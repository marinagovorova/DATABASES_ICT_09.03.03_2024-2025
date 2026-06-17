
-- Создание базы данных
CREATE DATABASE bus_system;
\c bus_system;

-- DROP TABLE IF EXISTS crew, reason_for_disqualification, passport_driver, driver,
-- ticket, passport_passenger, passenger, trip, route_composition, route,
-- bus, bus_model, settlement CASCADE;

-- Населенные пункты 
CREATE TABLE settlement (
    settlement_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

-- Модель автобуса, для ссылки в таблицу автобус
CREATE TABLE bus_model (
    bus_model_id SERIAL PRIMARY KEY,
    manufacturer VARCHAR(255),
    model_name VARCHAR(255),
    seats_number INT NOT NULL
);

-- Автобус, добавлена связь с моделью
CREATE TABLE bus (
    bus_id SERIAL PRIMARY KEY,
    bus_model_id INT REFERENCES bus_model(bus_model_id),
    production_year INT,
    registration_number VARCHAR(255)
);

-- Маршрут. Добавлены время отправления, прибытия, в пути
CREATE TABLE route (
    route_id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    start_settlement_id INT REFERENCES settlement(settlement_id),
    final_settlement_id INT REFERENCES settlement(settlement_id),
    departure_time TIME,
    arrival_time TIME,
    travel_time INTERVAL
);

-- Маршрут
CREATE TABLE route_composition (
    route_composition_id SERIAL PRIMARY KEY,
    route_id INT REFERENCES route(route_id),
    settlement_id INT REFERENCES settlement(settlement_id),
    stop_number INT,
    arrival_time TIME,
    stop_duration INTERVAL
);

-- Рейс. Добавлен статус, стоимость
CREATE TABLE trip (
    trip_id SERIAL PRIMARY KEY,
    route_id INT REFERENCES route(route_id),
    bus_id INT REFERENCES bus(bus_id),
    departure_date DATE,
    status VARCHAR(50),
    price NUMERIC(10, 2)
);

-- Пассажир
CREATE TABLE passenger (
    passenger_id SERIAL PRIMARY KEY,
    full_name VARCHAR(255) NOT NULL
);

-- Паспорт пассажира
CREATE TABLE passport_passenger (
    passport_id SERIAL PRIMARY KEY,
    series INT,
    number INT,
    issue_date DATE,
    issue_place VARCHAR(255),
    registration_address VARCHAR(255),
    passenger_id INT UNIQUE REFERENCES passenger(passenger_id)
);

-- Билет. Связь с паспортом пассажира
CREATE TABLE ticket (
    ticket_id SERIAL PRIMARY KEY,
    trip_id INT REFERENCES trip(trip_id),
    passport_passenger_id INT REFERENCES passport_passenger(passport_id),
    seat_number INT,
    status VARCHAR(50)
);

-- Водитель
CREATE TABLE driver (
    driver_id SERIAL PRIMARY KEY,
    full_name VARCHAR(255),
    phone_number VARCHAR(20)
);

-- Паспорт водителя
CREATE TABLE passport_driver (
    passport_id SERIAL PRIMARY KEY,
    series INT,
    number INT,
    issue_date DATE,
    issue_place VARCHAR(255),
    registration_address VARCHAR(255),
    driver_id INT UNIQUE REFERENCES driver(driver_id)
);

-- Причины недопуска по медосмотру
CREATE TABLE reason_for_disqualification (
    reason_id SERIAL PRIMARY KEY,
    disease VARCHAR(255)
);

-- Экипаж. Связь с паспортом водителя. Добавлен статус медосмотра, дата
CREATE TABLE crew (
    crew_id SERIAL PRIMARY KEY,
    trip_id INT REFERENCES trip(trip_id),
    passport_driver_id INT REFERENCES passport_driver(passport_id),
    medical_status VARCHAR(50),
    medical_checkup_date DATE,
    reason_id INT REFERENCES reason_for_disqualification(reason_id)
);


INSERT INTO settlement (name) VALUES ('Moscow'), ('St. Petersburg'), ('Pskov');

INSERT INTO bus_model (manufacturer, model_name, seats_number)
VALUES ('GAZ', 'Gazelle', 12);

INSERT INTO bus (bus_model_id, production_year, registration_number)
VALUES (1, 2020, 'A777AA77');

INSERT INTO route (name, start_settlement_id, final_settlement_id, departure_time, arrival_time, travel_time)
VALUES ('Moscow - St. Petersburg', 1, 2, '08:00', '15:00', '07:00'),
       ('Pskov - Moscow', 3, 1, '09:00', '17:00', '08:00');

INSERT INTO route_composition (route_id, settlement_id, stop_number, arrival_time, stop_duration)
VALUES (1, 1, 1, '08:00', '00:10'),
       (1, 2, 2, '15:00', '00:00');

INSERT INTO trip (route_id, bus_id, departure_date, status, price)
VALUES (1, 1, '2025-01-01', 'Boarding', 1500.00);

INSERT INTO passenger (full_name) VALUES ('Andrey Sahur');

INSERT INTO passport_passenger (series, number, issue_date, issue_place, registration_address, passenger_id)
VALUES (1111, 777111, '2002-02-01', 'Moscow', 'Moscow, Lesnaya st. 13', 1);

INSERT INTO ticket (trip_id, passport_passenger_id, seat_number, status)
VALUES (1, 1, 5, 'Booked');

INSERT INTO driver (full_name, phone_number)
VALUES ('Ivan Ivanich', '79992220222');

INSERT INTO passport_driver (series, number, issue_date, issue_place, registration_address, driver_id)
VALUES (1234, 123456, '1999-05-01', 'Pskov', 'Pskov, Krasniy ave. 1', 1);

INSERT INTO reason_for_disqualification (disease)
VALUES ('Heart disease');

INSERT INTO crew (trip_id, passport_driver_id, medical_status, medical_checkup_date, reason_id)
VALUES (1, 1, 'Passed', '2025-01-01', NULL);

-- NEW INSERTS
INSERT INTO driver (full_name, phone_number)
VALUES ('Petr Petrovich', '79999999999');

INSERT INTO passport_driver (series, number, issue_date, issue_place, registration_address, driver_id)
VALUES (5678, 567878, '1991-06-01', 'Moscow', 'Moscow, Red Square 1', 2);

INSERT INTO trip (route_id, bus_id, departure_date, status, price)
VALUES (1, 1, CURRENT_DATE, 'Boarding', 1500.00);

INSERT INTO crew (trip_id, passport_driver_id, medical_status, medical_checkup_date, reason_id)
VALUES ((SELECT trip_id FROM trip WHERE departure_date = CURRENT_DATE AND route_id = 1 LIMIT 1), 1, 'Passed', CURRENT_DATE, NULL);

INSERT INTO trip (route_id, bus_id, departure_date, status, price)
VALUES (2, 1, CURRENT_DATE - 1, 'Completed', 1800.00);

INSERT INTO crew (trip_id, passport_driver_id, medical_status, medical_checkup_date, reason_id)
VALUES ((SELECT trip_id FROM trip WHERE departure_date = CURRENT_DATE - 1 AND route_id = 2 LIMIT 1), 2, 'Passed', CURRENT_DATE - 1, NULL);

INSERT INTO ticket (trip_id, passport_passenger_id, seat_number, status)
VALUES ((SELECT trip_id FROM trip WHERE departure_date = CURRENT_DATE - 1 AND route_id = 2 LIMIT 1), 1, 3, 'Purchased');

INSERT INTO trip (route_id, bus_id, departure_date, status, price)
VALUES (2, 1, CURRENT_DATE - 5, 'Completed', 1800.00);

INSERT INTO crew (trip_id, passport_driver_id, medical_status, medical_checkup_date, reason_id)
VALUES ((SELECT trip_id FROM trip WHERE departure_date = CURRENT_DATE - 5 AND route_id = 2 LIMIT 1), 2, 'Passed', CURRENT_DATE - 5, NULL);

INSERT INTO bus (bus_model_id, production_year, registration_number)
VALUES (1, 2021, 'B888BB77');

INSERT INTO route (name, start_settlement_id, final_settlement_id, departure_time, arrival_time, travel_time)
VALUES ('St. Petersburg - Pskov', 2, 3, '14:00', '19:00', '05:00');

INSERT INTO trip (route_id, bus_id, departure_date, status, price)
VALUES (3, 2, CURRENT_DATE - 3, 'Completed', 1000.00);

INSERT INTO crew (trip_id, passport_driver_id, medical_status, medical_checkup_date, reason_id)
VALUES ((SELECT trip_id FROM trip WHERE route_id = 3 AND departure_date = CURRENT_DATE - 3 LIMIT 1), 1, 'Passed', CURRENT_DATE - 3, NULL);

INSERT INTO trip (route_id, bus_id, departure_date, status, price)
VALUES (1, 1, CURRENT_DATE + 1, 'Boarding', 1000.00);

INSERT INTO ticket (trip_id, passport_passenger_id, seat_number, status)
VALUES 
((SELECT trip_id FROM trip WHERE departure_date = CURRENT_DATE + 1 AND route_id = 1 LIMIT 1), 1, 1, 'Purchased'),
((SELECT trip_id FROM trip WHERE departure_date = CURRENT_DATE + 1 AND route_id = 1 LIMIT 1), 1, 2, 'Purchased'),
((SELECT trip_id FROM trip WHERE departure_date = CURRENT_DATE + 1 AND route_id = 1 LIMIT 1), 1, 3, 'Purchased');

INSERT INTO trip (route_id, bus_id, departure_date, status, price)
VALUES 
(1, 1, '2025-12-15', 'Completed', 1000.00),
(1, 1, '2026-01-10', 'Completed', 1000.00),
(1, 1, '2026-02-01', 'Completed', 1000.00);

INSERT INTO trip (route_id, bus_id, departure_date, status, price)
VALUES 
(2, 1, '2026-01-15', 'Completed', 2000.00),
(2, 1, '2026-02-10', 'Completed', 2000.00);
