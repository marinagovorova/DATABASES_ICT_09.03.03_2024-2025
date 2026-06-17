CREATE SCHEMA IF NOT EXISTS taxi_service;
SET search_path TO taxi_service;

-- Расширение для GiST-исключений
CREATE EXTENSION IF NOT EXISTS btree_gist;

-- 1. Домены
CREATE DOMAIN phone_number AS TEXT
  CONSTRAINT chk_phone_number__format CHECK (VALUE ~ '^\+?7\d{10}$');

CREATE DOMAIN positive_num AS NUMERIC(10,2)
  CONSTRAINT chk_positive_num__nonneg CHECK (VALUE >= 0);

-- 2. Перечисления
CREATE TYPE ride_status    AS ENUM ('pending','in_progress','completed','cancelled');
CREATE TYPE payment_method AS ENUM ('cash','card','online');

-- 4. Справочные таблицы
CREATE TABLE position (
  id                 SERIAL       CONSTRAINT pk_position PRIMARY KEY,
  name               TEXT         CONSTRAINT uq_position__name UNIQUE,
  working_conditions TEXT,
  min_payment        positive_num NOT NULL
    CONSTRAINT chk_position__min_payment CHECK (min_payment >= 0)
);

CREATE TABLE taxi_park (
  id      SERIAL CONSTRAINT pk_taxi_park PRIMARY KEY,
  name    TEXT   NOT NULL CONSTRAINT uq_taxi_park__name UNIQUE,
  address TEXT   NOT NULL
);

CREATE TABLE fare (
  id          SERIAL CONSTRAINT pk_fare PRIMARY KEY,
  name        TEXT   NOT NULL CONSTRAINT uq_fare__name UNIQUE,
  description TEXT
);

CREATE TABLE fine_type (
  id          SERIAL CONSTRAINT pk_fine_type PRIMARY KEY,
  name        TEXT   NOT NULL CONSTRAINT uq_fine_type__name UNIQUE,
  description TEXT
);

-- 5. Основные сущности

CREATE TABLE employee (
  id             SERIAL       CONSTRAINT pk_employee PRIMARY KEY,
  position_id    INT          NOT NULL
    CONSTRAINT fk_employee_position
    REFERENCES position(id)
      ON UPDATE CASCADE
      ON DELETE RESTRICT
      DEFERRABLE INITIALLY DEFERRED,
  full_name      TEXT         NOT NULL,
  phone          phone_number NOT NULL
    CONSTRAINT uq_employee__phone UNIQUE,
  address        TEXT,
  passport_data  TEXT         NOT NULL
    CONSTRAINT uq_employee__passport UNIQUE
);

CREATE TABLE passenger (
  id                SERIAL       CONSTRAINT pk_passenger PRIMARY KEY,
  full_name         TEXT         NOT NULL,
  phone             phone_number NOT NULL
    CONSTRAINT uq_passenger__phone UNIQUE,
  registration_time TIMESTAMPTZ  NOT NULL DEFAULT now()
);

CREATE TABLE car (
  id                SERIAL       CONSTRAINT pk_car PRIMARY KEY,
  brand             TEXT         NOT NULL,
  model             TEXT         NOT NULL,
  country_of_origin TEXT,
  production_year   INT          NOT NULL
    CONSTRAINT chk_car__prod_year CHECK (
      production_year BETWEEN 1900 AND EXTRACT(YEAR FROM now())::INT
    ),
  plate_number      TEXT         NOT NULL
    CONSTRAINT uq_car__plate UNIQUE
    CONSTRAINT chk_car__plate_format CHECK (
      plate_number ~ '^[АВЕКМНОРСТУХ]{1}\d{3}[АВЕКМНОРСТУХ]{2}\d{2,3}$'
    ),
  price             positive_num NOT NULL,
  employee_owner_id INT
    CONSTRAINT fk_car__employee__owner
    REFERENCES employee(id)
      ON UPDATE CASCADE
      ON DELETE SET NULL
      DEFERRABLE INITIALLY DEFERRED,
  park_owner_id     INT
    CONSTRAINT fk_car__park_owner
    REFERENCES taxi_park(id)
      ON UPDATE CASCADE
      ON DELETE SET NULL
      DEFERRABLE INITIALLY DEFERRED,
  CONSTRAINT chk_car__owner_xor CHECK (
    (employee_owner_id IS NOT NULL AND park_owner_id IS NULL)
    OR
    (employee_owner_id IS NULL AND park_owner_id IS NOT NULL)
  )
);

-- 6. Ставки оплаты труда
CREATE TABLE salary_rate (
  id         SERIAL       CONSTRAINT pk_salary_rate PRIMARY KEY,
  driver_id  INT          NOT NULL
    CONSTRAINT fk_salary_rate__driver
    REFERENCES employee(id)
      ON UPDATE CASCADE
      ON DELETE CASCADE
      DEFERRABLE INITIALLY DEFERRED,
  rate_type  TEXT         NOT NULL,
  value      positive_num NOT NULL,
  start_date DATE         NOT NULL,
  end_date   DATE         NOT NULL
    CONSTRAINT chk_salary_rate__dates CHECK (end_date > start_date)
);

ALTER TABLE salary_rate
  ADD CONSTRAINT chk_salary_rate__no_overlap
    EXCLUDE USING GIST (
      driver_id   WITH =,
      rate_type   WITH =,
      daterange(start_date, end_date, '[]') WITH &&
    );

-- 7. График работы

CREATE TABLE schedule (
  id           SERIAL    CONSTRAINT pk_schedule PRIMARY KEY,
  driver_id    INT       NOT NULL
    CONSTRAINT fk_schedule_driver
    REFERENCES employee(id)
      ON UPDATE CASCADE
      ON DELETE CASCADE
      DEFERRABLE INITIALLY DEFERRED,
  day_of_week  INT       NOT NULL
    CONSTRAINT chk_schedule__dow CHECK (day_of_week BETWEEN 1 AND 7),
  shift_start  TIME      NOT NULL,
  shift_end    TIME      NOT NULL
    CONSTRAINT chk_schedule__shift CHECK (shift_end > shift_start)
);

-- 8. Водительские права

CREATE TABLE driving_license (
  id             SERIAL       CONSTRAINT pk_driving_license PRIMARY KEY,
  driver_id      INT          NOT NULL
    CONSTRAINT fk_driving_license__driver
    REFERENCES employee(id)
      ON UPDATE CASCADE
      ON DELETE CASCADE
      DEFERRABLE INITIALLY DEFERRED,
  categories     TEXT[]       NOT NULL,
  license_number TEXT         NOT NULL
    CONSTRAINT uq_driving_license__number UNIQUE,
  start_date     DATE         NOT NULL,
  end_date       DATE         NOT NULL
    CONSTRAINT chk_driving_license__dates CHECK (end_date > start_date)
);

ALTER TABLE driving_license
  ADD CONSTRAINT chk_driving_license__no_overlap
    EXCLUDE USING GIST (
      driver_id    WITH =,
      daterange(start_date, end_date, '[]') WITH &&
    );

-- 9. Назначения автомобилей

CREATE TABLE car_assignment (
  id           SERIAL       CONSTRAINT pk_car_assignment PRIMARY KEY,
  car_id       INT          NOT NULL
    CONSTRAINT fk_car_assignment__car
    REFERENCES car(id)
      ON UPDATE CASCADE
      ON DELETE RESTRICT
      DEFERRABLE INITIALLY DEFERRED,
  driver_id    INT          NOT NULL
    CONSTRAINT fk_car_assignment__driver
    REFERENCES employee(id)
      ON UPDATE CASCADE
      ON DELETE RESTRICT
      DEFERRABLE INITIALLY DEFERRED,
  taxi_park_id INT          NOT NULL
    CONSTRAINT fk_car_assignment__park
    REFERENCES taxi_park(id)
      ON UPDATE CASCADE
      ON DELETE RESTRICT
      DEFERRABLE INITIALLY DEFERRED,
  start_date   DATE         NOT NULL,
  end_date     DATE         NOT NULL
    CONSTRAINT chk_car_assignment__dates CHECK (end_date > start_date)
);

ALTER TABLE car_assignment
  ADD CONSTRAINT chk_car_assignment__no_overlap_car
    EXCLUDE USING GIST (
      car_id WITH =,
      daterange(start_date, end_date, '[]') WITH &&
    ),
  ADD CONSTRAINT chk_car_assignment__no_overlap_driver
    EXCLUDE USING GIST (
      driver_id WITH =,
      daterange(start_date, end_date, '[]') WITH &&
    );

-- 10. Поездки

CREATE TABLE ride (
  id                   SERIAL        CONSTRAINT pk_ride PRIMARY KEY,
  passenger_id         INT           NOT NULL
    CONSTRAINT fk_ride__passenger
    REFERENCES passenger(id)
      ON UPDATE CASCADE
      ON DELETE RESTRICT
      DEFERRABLE INITIALLY DEFERRED,
  driver_id            INT           NOT NULL
    CONSTRAINT fk_ride__driver
    REFERENCES employee(id)
      ON UPDATE CASCADE
      ON DELETE RESTRICT
      DEFERRABLE INITIALLY DEFERRED,
  car_id               INT           NOT NULL
    CONSTRAINT fk_ride__car
    REFERENCES car(id)
      ON UPDATE CASCADE
      ON DELETE RESTRICT
      DEFERRABLE INITIALLY DEFERRED,
  created_at           TIMESTAMPTZ   NOT NULL DEFAULT now(),
  start_time           TIMESTAMPTZ   NOT NULL
    CONSTRAINT chk_ride__start_after_create CHECK (start_time >= created_at),
  boarding_time        TIMESTAMPTZ   NOT NULL
    CONSTRAINT chk_ride__boarding_after_start CHECK (boarding_time >= start_time),
  end_time             TIMESTAMPTZ   NOT NULL
    CONSTRAINT chk_ride__end_after_boarding CHECK (end_time >= boarding_time),
  distance             positive_num  NOT NULL,
  total_cost           positive_num  NOT NULL,
  fare_id              INT           NOT NULL
    CONSTRAINT fk_ride__fare
    REFERENCES fare(id)
      ON UPDATE CASCADE
      ON DELETE RESTRICT
      DEFERRABLE INITIALLY DEFERRED,
  arrival_address      TEXT          NOT NULL,
  destination_address  TEXT          NOT NULL,
  status               ride_status   NOT NULL
);

ALTER TABLE ride
  ADD CONSTRAINT uq_ride__passenger UNIQUE (id, passenger_id),
  ADD CONSTRAINT uq_ride__driver    UNIQUE (id, driver_id);

-- 11. Отзывы

CREATE TABLE review (
  id           SERIAL PRIMARY KEY,
  ride_id      INT    NOT NULL,
  rating       INT    NOT NULL
    CONSTRAINT chk_review__rating CHECK (rating BETWEEN 1 AND 5),
  passenger_id INT    NOT NULL,
  driver_id    INT    NOT NULL,
  comment      TEXT,
  review_date  DATE   NOT NULL DEFAULT CURRENT_DATE,
  CONSTRAINT fk_review__ride FOREIGN KEY (ride_id)
    REFERENCES ride(id)
      ON UPDATE CASCADE
      ON DELETE CASCADE
      DEFERRABLE INITIALLY DEFERRED,
  CONSTRAINT fk_review__passenger FOREIGN KEY (ride_id, passenger_id)
    REFERENCES ride(id, passenger_id)
      ON UPDATE CASCADE
      ON DELETE RESTRICT
      DEFERRABLE INITIALLY DEFERRED,
  CONSTRAINT fk_review__driver FOREIGN KEY (ride_id, driver_id)
    REFERENCES ride(id, driver_id)
      ON UPDATE CASCADE
      ON DELETE RESTRICT
      DEFERRABLE INITIALLY DEFERRED
);

-- 12. Платежи

CREATE TABLE payment (
  id             SERIAL        CONSTRAINT payment_pkey PRIMARY KEY,
  ride_id        INT           NOT NULL
    CONSTRAINT fk_payment__ride
    REFERENCES ride(id)
      ON UPDATE CASCADE
      ON DELETE CASCADE
      DEFERRABLE INITIALLY DEFERRED,
  amount         positive_num  NOT NULL,
  payment_method payment_method NOT NULL,
  payment_date   DATE           NOT NULL DEFAULT CURRENT_DATE
);

-- 13. История тарифов

CREATE TABLE fare_history (
  id           SERIAL CONSTRAINT pk_fare_history PRIMARY KEY,
  fare_id      INT    NOT NULL
    CONSTRAINT fk_fare_history__fare
    REFERENCES fare(id)
      ON UPDATE CASCADE
      ON DELETE CASCADE
      DEFERRABLE INITIALLY DEFERRED,
  price_per_km positive_num NOT NULL,
  start_date   DATE         NOT NULL,
  end_date     DATE         NOT NULL
    CONSTRAINT chk_fare_history__dates CHECK (end_date > start_date)
);

ALTER TABLE fare_history
  ADD CONSTRAINT chk_fare_history__no_overlap
    EXCLUDE USING GIST (
      fare_id WITH =,
      daterange(start_date, end_date, '[]') WITH &&
    );

-- 14. Штрафы

CREATE TABLE fine (
  id            SERIAL CONSTRAINT pk_fine PRIMARY KEY,
  ride_id       INT    NOT NULL CONSTRAINT fk_fine__ride
    REFERENCES ride(id)
      ON UPDATE CASCADE
      ON DELETE CASCADE
      DEFERRABLE INITIALLY DEFERRED,
  fine_type_id  INT    NOT NULL CONSTRAINT fk_fine__fine_type
    REFERENCES fine_type(id)
      ON UPDATE CASCADE
      ON DELETE RESTRICT
      DEFERRABLE INITIALLY DEFERRED,
  amount        positive_num NOT NULL,
  fine_date     DATE         NOT NULL
);

-- Вставка данных

BEGIN;

-- 1. Позиции
INSERT INTO position (name, working_conditions, min_payment) VALUES
  ('Водитель',      'График 2/2, аренда машины', 50000.00),
  ('Администратор', 'Офис, сменный график',      40000.00);

-- 2. Сотрудники
INSERT INTO employee (position_id, full_name, phone, address, passport_data) VALUES
  (1, 'Иванов Иван Иванович',      '+79001234567', 'ул. Пушкина, д. 1',   '1234 567890'),
  (1, 'Петрова Мария Сергеевна',   '+79007654321', 'пр. Мира, д. 15',     '2345 678901'),
  (1, 'Сидоров Алексей Олегович',  '+79005556677', 'ул. Чехова, д. 7',    '3456 789012');

-- 3. Парки
INSERT INTO taxi_park (name, address) VALUES
  ('Такси Север', 'г. Москва, ул. Ленина, 10'),
  ('Такси Юг',    'г. Нижний Новгород, ул. Минина, 12');

-- 4. Автомобили
INSERT INTO car (brand, model, country_of_origin, production_year, plate_number, price, park_owner_id) VALUES
  ('Hyundai',    'Solaris',   'Корея', 2020, 'А123ВС77', 850000.00, 1),
  ('Toyota',     'Camry',     'Япония',2021, 'В456ЕК77',1200000.00, 2),
  ('Kia',        'Rio',       'Корея', 2019, 'С789УР78', 650000.00, 1);

-- 5. Тарифы
INSERT INTO fare (name, description) VALUES
  ('Эконом',  'Самый бюджетный тариф'),
  ('Стандарт','Обычный тариф без доплат'),
  ('Премиум', 'Повышенный комфорт и безопасность');

-- 6. История тарифов
INSERT INTO fare_history (fare_id, price_per_km, start_date, end_date) VALUES
  (1,  8.00, '2025-01-01', '2025-12-31'),
  (2, 20.00, '2024-01-01', '2024-12-31'),
  (2, 22.00, '2025-01-01', '2025-12-31'),
  (3, 35.00, '2025-01-01', '2025-12-31');

-- 7. Пассажиры
INSERT INTO passenger (full_name, phone) VALUES
  ('Петров Петр Петрович',         '+79001112233'),
  ('Кузнецова Ольга Николаевна',   '+79002223344'),
  ('Морозов Дмитрий Сергеевич',    '+79003334455'),
  ('Смирнова Анна Владимировна',   '+79004445566'),
  ('Новиков Алексей Николаевич',   '+79005556677');

-- 8. Назначения машин водителям
INSERT INTO car_assignment (car_id, driver_id, taxi_park_id, start_date, end_date) VALUES
  (1, 1, 1, '2025-01-01', '2025-06-30'),
  (2, 2, 2, '2025-01-15', '2025-12-31'),
  (3, 3, 1, '2025-02-01', '2025-12-31');

-- 9. Водительские права
INSERT INTO driving_license (driver_id, categories, license_number, start_date, end_date) VALUES
  (1, ARRAY['B'],    'AB1234567', '2023-01-01', '2033-01-01'),
  (2, ARRAY['B','C'],'BC7654321', '2024-05-01', '2034-05-01'),
  (3, ARRAY['B'],    'BZ1122334', '2022-07-01', '2032-07-01');

-- 10. Ставки оплаты труда
INSERT INTO salary_rate (driver_id, rate_type, value, start_date, end_date) VALUES
  (1, 'Фиксированная', 60000.00, '2025-01-01', '2025-12-31'),
  (2, 'Почасовая',      800.00, '2025-01-01', '2025-12-31'),
  (3, 'По км',          15.00, '2025-01-01', '2025-12-31');

-- 11. График работы
INSERT INTO schedule (driver_id, day_of_week, shift_start, shift_end) VALUES
  (1, 1, '08:00', '20:00'),
  (1, 5, '12:00', '23:59:59'),
  (2, 2, '09:00', '21:00'),
  (3, 3, '10:00', '22:00');

-- 12. Типы штрафов
INSERT INTO fine_type (name, description) VALUES
  ('Превышение скорости', 'Штраф за превышение установленной скорости'),
  ('Нарушение парковки',  'Штраф за остановку в неположенном месте');

-- 13. Поездки (5 разных сценариев)
INSERT INTO ride (
  passenger_id, driver_id, car_id,
  created_at, start_time, boarding_time, end_time,
  distance, total_cost, fare_id,
  arrival_address, destination_address, status
) VALUES
  -- 1) Завершённая поездка, оплата картой, есть отзыв
  (1, 1, 1,
   now() - interval '2 hours', now() - interval '2 hours', now() - interval '1 hour 55 minutes', now() - interval '1 hour 30 minutes',
   10.0, 200.00, 2,
   'ул. Ленина, 10', 'ул. Гагарина, 5', 'completed'
  ),
  -- 2) Завершённая поездка, оплата наличными, есть отзыв и штраф
  (2, 2, 2,
   now() - interval '5 hours', now() - interval '5 hours', now() - interval '4 hours 55 minutes', now() - interval '4 hours 40 minutes',
   3.5, 35.00, 1,
   'пр. Мира, 12', 'ул. Советская, 8', 'completed'
  ),
  -- 3) В процессе (in_progress), без оплаты
  (3, 1, 3,
   now() - interval '30 minutes', now() - interval '30 minutes', now() - interval '28 minutes', now() + interval '15 minutes',
   7.2, 144.00, 3,
   'ул. Чехова, 7', 'ул. Пушкина, 1', 'in_progress'
  ),
  -- 4) Запланирована (pending), без оплаты
  (4, 2, 1,
   now(), now() + interval '1 hour', now() + interval '1 hour 5 minutes', now() + interval '1 hour 30 minutes',
   2.0, 22.00, 2,
   'ул. Крылова, 6', 'ул. Лермонтова, 3', 'pending'
  ),
  -- 5) Отменена (cancelled), без оплаты
  (5, 3, 2,
   now() - interval '3 hours', now() - interval '3 hours', now() - interval '2 hours 55 minutes', now() - interval '2 hours 50 minutes',
   1.2, 12.00, 1,
   'ул. Революции, 10', 'ул. Энгельса, 2', 'cancelled'
  );

-- 14. Платежи (только для завершённых)
INSERT INTO payment (ride_id, amount, payment_method) VALUES
  (1, 200.00, 'card'),
  (2,  35.00, 'cash');

-- 15. Отзывы (для завершённых)
INSERT INTO review (ride_id, rating, passenger_id, driver_id, comment) VALUES
  (1, 5, 1, 1, 'Отличный сервис, рекомендую!'),
  (2, 4, 2, 2, 'Хорошая поездка, но водитель немного опоздал.');

-- 16. Штрафы (для одной завершённой поездки)
INSERT INTO fine (ride_id, fine_type_id, amount, fine_date) VALUES
  (2, 1, 500.00, current_date);

COMMIT;
