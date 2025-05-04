-- Создание базы данных
CREATE DATABASE bus_system;
\c bus_system;

-- Населенные пункты
CREATE TABLE settlement (
    settlement_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

-- Маршрут
CREATE TABLE route (
    route_id SERIAL PRIMARY KEY,
    name VARCHAR(45) NOT NULL
);

-- Автобус
CREATE TABLE bus (
    bus_id SERIAL PRIMARY KEY,
    manufacturer VARCHAR(255),
    model_type VARCHAR(255),
    production_year INT,
    registration_number VARCHAR(255),
    seats_number INT NOT NULL
);

-- Данные пассажира
CREATE TABLE passenger (
    passenger_id SERIAL PRIMARY KEY,
    full_name VARCHAR(255) NOT NULL
);

-- Данные паспорта пассажира
CREATE TABLE passport_passenger (
    passport_id SERIAL PRIMARY KEY,
    series INT,
    number INT,
    issue_date DATE,
    issue_place VARCHAR(255),
    registration_address VARCHAR(255),
    passenger_id INT UNIQUE REFERENCES passenger(passenger_id)
);

-- Билет
CREATE TABLE ticket (
    ticket_id SERIAL PRIMARY KEY,
    ticket_number INT,
    seat_number INT,
    price NUMERIC(10, 2),
    passenger_id INT REFERENCES passenger(passenger_id),
    trip_id INT
);

-- Рейс (данные рейса)
CREATE TABLE trip (
    trip_id SERIAL PRIMARY KEY,
    departure_date DATE,
    departure_time TIMESTAMP,
    travel_time INTERVAL,
    bus_id INT REFERENCES bus(bus_id),
    route_id INT REFERENCES route(route_id),
    start_stop_id INT,
    final_stop_id INT
);

-- Промежуточные остановки
CREATE TABLE intermediate_stop (
    stop_id SERIAL PRIMARY KEY,
    stop_number INT,
    settlement_id INT REFERENCES settlement(settlement_id)
);

-- Состав маршрута
CREATE TABLE route_composition (
    route_composition_id SERIAL PRIMARY KEY,
    route_id INT REFERENCES route(route_id),
    stop_id INT REFERENCES intermediate_stop(stop_id)
);

-- Данные водителя
CREATE TABLE driver (
    driver_id SERIAL PRIMARY KEY,
    full_name VARCHAR(255),
    phone_number VARCHAR(20)
);

-- Данные паспорта водителя
CREATE TABLE passport_driver (
    passport_id SERIAL PRIMARY KEY,
    series INT,
    number INT,
    issue_date DATE,
    issue_place VARCHAR(255),
    registration_address VARCHAR(255),
    driver_id INT UNIQUE REFERENCES driver(driver_id)
);

-- Экипаж
CREATE TABLE crew (
    crew_id SERIAL PRIMARY KEY,
    driver_id INT REFERENCES driver(driver_id),
    trip_id INT REFERENCES trip(trip_id)
);

-- Причины недопуска по медосмотру
CREATE TABLE reason_for_disqualification (
    reason_id SERIAL PRIMARY KEY,
    disease VARCHAR(255)
);

-- Медицинский осмотр
CREATE TABLE medical_checkup (
    checkup_id SERIAL PRIMARY KEY,
    checkup_date TIMESTAMP,
    status VARCHAR(45),
    driver_id INT REFERENCES driver(driver_id),
    reason_id INT REFERENCES reason_for_disqualification(reason_id)
);


INSERT INTO settlement (name) VALUES ('Moscow'), ('St. Petersburg'), ('Pskov');

INSERT INTO route (name) VALUES ('Moscow - St. Petersburg'), ('Pskov - Moscow');

INSERT INTO bus (manufacturer, model_type, production_year, registration_number, seats_number)
VALUES ('GAZ', 'Gazelle', 2020, 'A777AA77', 12);

INSERT INTO passenger (full_name) VALUES ('Andrey Sahur');

INSERT INTO passport_passenger (series, number, issue_date, issue_place, registration_address, passenger_id)
VALUES (1111, 777111, '2002-02-01', 'Moscow', 'Moscow, Lesnaya st. 13', 1);

INSERT INTO ticket (ticket_number, seat_number, price, passenger_id)
VALUES (1001, 5, 1500.00, 1);

INSERT INTO trip (departure_date, departure_time, travel_time, bus_id, route_id)
VALUES ('2025-05-06', '2025-05-06 08:00:00', '07:00', 1, 1);

INSERT INTO intermediate_stop (stop_number, settlement_id)
VALUES (1, 1), (2, 2);

INSERT INTO route_composition (route_id, stop_id)
VALUES (1, 1), (1, 2);

INSERT INTO driver (full_name, phone_number)
VALUES ('Ivan Ivanich', '79992220222');

INSERT INTO passport_driver (series, number, issue_date, issue_place, registration_address, driver_id)
VALUES (1234, 123456, '1999-05-01', 'Pskov', 'Pskov, Krasniy ave. 1', 1);

INSERT INTO crew (driver_id, trip_id)
VALUES (1, 1);

INSERT INTO reason_for_disqualification (disease)
VALUES ('Heart');

INSERT INTO medical_checkup (checkup_date, status, driver_id, reason_id)
VALUES ('2025-04-01 09:00:00', 'Passed', 1, NULL);
