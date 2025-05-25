-- ПРОЦЕДУРЫ

-- 1. Продажа билета

CREATE OR REPLACE PROCEDURE sell_ticket(
    IN in_trip_id INT,
    IN in_passport_passenger_id INT,
    IN in_seat_number INT,
    OUT out_ticket_id INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF EXISTS (
        SELECT 1
        FROM ticket
        WHERE trip_id = in_trip_id
          AND seat_number = in_seat_number
          AND status = 'Purchased'
    ) THEN
        RAISE EXCEPTION 'Место % занято для рейса %', in_seat_number, in_trip_id;
    END IF;

    INSERT INTO ticket (trip_id, passport_passenger_id, seat_number, status)
    VALUES (in_trip_id, in_passport_passenger_id, in_seat_number, 'Purchased')
    RETURNING ticket_id INTO out_ticket_id;
END;
$$;


-- Выполнение

DO $$
DECLARE t_id INT;
BEGIN
    CALL sell_ticket(8, 1, 7, t_id);
    RAISE NOTICE 'Новый билет ID = %', t_id;
END;
$$;

-- 2. Возврат билета

CREATE OR REPLACE PROCEDURE return_ticket(
    IN in_ticket_id INT,
    OUT is_success BOOLEAN
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE ticket
    SET status = 'Cancelled'
    WHERE ticket_id = in_ticket_id
      AND status != 'Cancelled'
    RETURNING ticket_id INTO in_ticket_id;
    is_success := FOUND;
END;
$$;

-- Выполение

DO $$
DECLARE
    result BOOLEAN;
BEGIN
    CALL return_ticket(26, result);
    RAISE NOTICE 'Возврат выполнен: %', result;
END;
$$;

-- 3. Добавление нового рейса

CREATE OR REPLACE PROCEDURE add_trip(
    IN in_route_id INT,
    IN in_bus_id INT,
    IN in_departure_date DATE,
    IN in_status VARCHAR,
    IN in_price NUMERIC,
    OUT out_trip_id INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO trip (route_id, bus_id, departure_date, status, price)
    VALUES (in_route_id, in_bus_id, in_departure_date, in_status, in_price)
    RETURNING trip_id INTO out_trip_id;
END;
$$;

-- Выполение

DO $$
DECLARE
    t_id INT;
BEGIN
    CALL add_trip(1, 1, CURRENT_DATE + 5, 'Boarding', 100.00, t_id);
    RAISE NOTICE 'Добавлен новый рейс с ID = %', t_id;
END;
$$;
