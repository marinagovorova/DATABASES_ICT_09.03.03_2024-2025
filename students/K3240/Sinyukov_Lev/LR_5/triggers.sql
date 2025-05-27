-- ТРИГГЕРЫ

-- 1. Автоматическая установка статуса Booked при выпуске билета

CREATE OR REPLACE FUNCTION set_ticket_status_booked()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.status IS NULL THEN
        NEW.status := 'Booked';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_ticket_default_status
BEFORE INSERT ON ticket
FOR EACH ROW
EXECUTE FUNCTION set_ticket_status_booked();

-- Проверка

INSERT INTO ticket (trip_id, passport_passenger_id, seat_number) VALUES (1, 1, 72);
SELECT ticket_id, status FROM ticket WHERE seat_number = 72;

-- 2. Запрет на продажу билетов после отправления автобуса

CREATE OR REPLACE FUNCTION prevent_late_ticket_sale()
RETURNS TRIGGER AS $$
DECLARE
    trip_date DATE;
BEGIN
    SELECT departure_date INTO trip_date FROM trip WHERE trip_id = NEW.trip_id;
    IF trip_date < CURRENT_DATE THEN
        RAISE EXCEPTION 'Автобус отправился в рейс, приобритение билетов невозможно';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_ticket_sale_check
BEFORE INSERT ON ticket
FOR EACH ROW
EXECUTE FUNCTION prevent_late_ticket_sale();

-- Проверка

INSERT INTO trip (route_id, bus_id, departure_date, status, price) VALUES (1, 1, CURRENT_DATE - 3, 'Completed', 1000.00);
INSERT INTO ticket (trip_id, passport_passenger_id, seat_number) VALUES (18, 1, 88);

-- 3. Автоматическая установка статуса Completed на рейс в прошлом

CREATE OR REPLACE FUNCTION auto_complete_trip()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.departure_date < CURRENT_DATE THEN
        NEW.status := 'Completed';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_trip_auto_status
BEFORE INSERT ON trip
FOR EACH ROW
EXECUTE FUNCTION auto_complete_trip();

-- Проверка

INSERT INTO trip (route_id, bus_id, departure_date, status, price) VALUES (17, 1, CURRENT_DATE - 2, NULL, 1000.00);
SELECT trip_id, status FROM trip ORDER BY trip_id DESC LIMIT 1;

-- 4. Логирование пассажиров

CREATE TABLE passenger_log (
    log_id SERIAL PRIMARY KEY,
    full_name TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE OR REPLACE FUNCTION log_new_passenger()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO passenger_log (full_name)
    VALUES (NEW.full_name);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_log_passenger
AFTER INSERT ON passenger
FOR EACH ROW
EXECUTE FUNCTION log_new_passenger();

-- Проверка

INSERT INTO passenger (full_name) VALUES ('passenger');
SELECT * FROM passenger_log ORDER BY log_id DESC LIMIT 1;

-- 5. Проверка пройден ли медосмотр водителем 

CREATE OR REPLACE FUNCTION validate_crew_medical()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.medical_checkup_date != CURRENT_DATE THEN
        RAISE EXCEPTION 'Медосмотр не был пройден';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_crew_medical_check
BEFORE INSERT ON crew
FOR EACH ROW
EXECUTE FUNCTION validate_crew_medical();

-- Проверка

INSERT INTO crew (trip_id, passport_driver_id, medical_status, medical_checkup_date, reason_id) VALUES (1, 1, 'Passed', CURRENT_DATE - 1, NULL);

-- 6. Автоудаление билета при возврате

CREATE OR REPLACE FUNCTION delete_cancelled_ticket()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.status = 'Cancelled' THEN
        DELETE FROM ticket WHERE ticket_id = NEW.ticket_id;
        RETURN NULL;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_delete_cancelled
AFTER UPDATE ON ticket
FOR EACH ROW
EXECUTE FUNCTION delete_cancelled_ticket();

-- Проверка

SELECT trip_id, departure_date FROM trip WHERE departure_date >= CURRENT_DATE;

INSERT INTO ticket (trip_id, passport_passenger_id, seat_number, status) VALUES (8, 1, 100, 'Purchased');

UPDATE ticket SET status = 'Cancelled' WHERE trip_id = 8 AND seat_number = 100;

SELECT * FROM ticket WHERE trip_id = 8 AND seat_number = 100;


-- 7. Проверка данных ФИО пассажира на дублирование в таблице 

CREATE OR REPLACE FUNCTION prevent_duplicate_passenger()
RETURNS TRIGGER AS $$
BEGIN
    IF EXISTS (
        SELECT 1 FROM passport_passenger WHERE series = NEW.series
    ) THEN
        RAISE EXCEPTION 'Пассажир с такими данными уже существует';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_unique_passenger_name
BEFORE INSERT ON passport_passenger
FOR EACH ROW
EXECUTE FUNCTION prevent_duplicate_passenger();

-- Проверка

INSERT INTO passenger (full_name) VALUES ('I?')

INSERT INTO passport_passenger (series, number, issue_date, issue_place, registration_address, passenger_id) VALUES (1234, 567890, '2001-01-01', 'Moscow', 'Moscow, AAA', 2);