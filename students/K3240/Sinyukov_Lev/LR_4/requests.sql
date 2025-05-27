
-- ЗАПРОСЫ

-- Вывести фамилии водителей и номера автобусов, отправившиеся в рейсы до 12 часов текущего дня
SELECT driver.full_name, bus.registration_number FROM trip
JOIN crew ON crew.trip_id = trip.trip_id
JOIN passport_driver ON crew.passport_driver_id = passport_driver.passport_id
JOIN driver ON driver.driver_id = passport_driver.driver_id
JOIN bus ON bus.bus_id = trip.bus_id
JOIN route ON route.route_id = trip.route_id
WHERE trip.departure_date = CURRENT_DATE AND route.departure_time < '12:00';

-- Рассчитать выручку от продажи билетов за прошедший день
SELECT SUM(trip.price) AS total_revenue FROM trip
JOIN ticket ON ticket.trip_id = trip.trip_id
WHERE trip.departure_date = CURRENT_DATE - 1 AND ticket.status = 'Purchased';

-- Вывести список водителей, которые не выполнили ни одного рейса за прошедшую неделю
SELECT driver.full_name FROM driver
LEFT JOIN passport_driver ON passport_driver.driver_id = driver.driver_id
LEFT JOIN crew ON crew.passport_driver_id = passport_driver.passport_id
LEFT JOIN trip ON trip.trip_id = crew.trip_id AND trip.departure_date >= CURRENT_DATE - 7
WHERE crew.trip_id IS NULL OR trip.trip_id IS NULL;

-- Вывести сумму убытков из-за непроданных мест в автобусе за прошедшую неделю
SELECT SUM((bus_model.seats_number - COALESCE(sold_tickets.count, 0)) * trip.price) AS lost_revenue FROM trip
JOIN bus ON bus.bus_id = trip.bus_id
JOIN bus_model ON bus_model.bus_model_id = bus.bus_model_id
LEFT JOIN (
    SELECT ticket.trip_id, COUNT(*) AS count
    FROM ticket
    WHERE ticket.status = 'Purchased'
    GROUP BY ticket.trip_id
) sold_tickets ON sold_tickets.trip_id = trip.trip_id
WHERE trip.departure_date BETWEEN CURRENT_DATE - 7 AND CURRENT_DATE;

-- Найти самый популярный маршрут за прошедший месяц
SELECT route.name, COUNT(trip.trip_id) AS trip_count FROM route
JOIN trip ON trip.route_id = route.route_id
WHERE trip.departure_date BETWEEN CURRENT_DATE - INTERVAL '1 month' AND CURRENT_DATE
GROUP BY route.route_id, route.name
HAVING COUNT(trip.trip_id) = (
        SELECT MAX(trip_count)
        FROM (
            SELECT COUNT(trip.trip_id) AS trip_count FROM route
            JOIN trip ON trip.route_id = route.route_id
            WHERE trip.departure_date BETWEEN CURRENT_DATE - INTERVAL '1 month' AND CURRENT_DATE
            GROUP BY route.route_id
        ) AS counts
    );


-- Вывести тип автобуса, который используется на всех рейсах 
SELECT bus_model.manufacturer, bus_model.model_name FROM bus_model
JOIN bus ON bus.bus_model_id = bus_model.bus_model_id
JOIN trip ON trip.bus_id = bus.bus_id
GROUP BY bus_model.bus_model_id
HAVING COUNT(DISTINCT trip.route_id) = (SELECT COUNT(DISTINCT route_id) FROM trip);

-- Вывести данные водителя, который провел максимальное время в пути за прошедшую неделю
SELECT driver.full_name, SUM(route.travel_time) AS total_travel_time
FROM crew
JOIN passport_driver ON crew.passport_driver_id = passport_driver.passport_id
JOIN driver ON driver.driver_id = passport_driver.driver_id
JOIN trip ON trip.trip_id = crew.trip_id
JOIN route ON route.route_id = trip.route_id
WHERE trip.departure_date BETWEEN CURRENT_DATE - INTERVAL '7 days' AND CURRENT_DATE
GROUP BY driver.driver_id, driver.full_name
HAVING SUM(route.travel_time) = (
    SELECT MAX(total_travel_time)
    FROM (
        SELECT SUM(route.travel_time) AS total_travel_time
        FROM crew
        JOIN passport_driver ON crew.passport_driver_id = passport_driver.passport_id
        JOIN driver ON driver.driver_id = passport_driver.driver_id
        JOIN trip ON trip.trip_id = crew.trip_id
        JOIN route ON route.route_id = trip.route_id
        WHERE trip.departure_date BETWEEN CURRENT_DATE - INTERVAL '7 days' AND CURRENT_DATE
        GROUP BY driver.driver_id
    ) AS max_times
);

-- ПРЕДСТАВЛЕНИЯ 

-- Количество свободных мест на все рейсы на завтра
CREATE VIEW view_free_seats_tomorrow AS
SELECT 
    trip.trip_id,
    route.name AS route_name,
    trip.departure_date,
    bus.registration_number,
    bus_model.seats_number,
    COALESCE(sold_tickets.sold_count, 0) AS sold_seats,
    (bus_model.seats_number - COALESCE(sold_tickets.sold_count, 0)) AS free_seats
FROM trip
JOIN route ON route.route_id = trip.route_id
JOIN bus ON bus.bus_id = trip.bus_id
JOIN bus_model ON bus_model.bus_model_id = bus.bus_model_id
LEFT JOIN (
    SELECT ticket.trip_id, COUNT(*) AS sold_count FROM ticket
    WHERE ticket.status = 'Purchased'
    GROUP BY ticket.trip_id
) sold_tickets ON sold_tickets.trip_id = trip.trip_id
WHERE trip.departure_date = CURRENT_DATE + 1;

-- Самый популярный маршрут этой зимой
CREATE VIEW view_popular_route_winter AS
SELECT route.name, COUNT(trip.trip_id) AS trip_count FROM route
JOIN trip ON trip.route_id = route.route_id
WHERE trip.departure_date BETWEEN '2025-12-01' AND '2026-02-28'
GROUP BY route.route_id
ORDER BY trip_count DESC
LIMIT 1;
