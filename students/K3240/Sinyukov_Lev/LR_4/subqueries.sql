
-- 1. INSERT. Определим пассажира с наименьшим количеством билетов и выдадим ему билет на завтра 
INSERT INTO ticket (trip_id, passport_passenger_id, seat_number, status)
SELECT
    trip.trip_id,
    passport_passenger.passport_id,
    10,
    'Purchased'
FROM passport_passenger
JOIN passenger ON passenger.passenger_id = passport_passenger.passenger_id
JOIN trip ON trip.departure_date = CURRENT_DATE + 1
WHERE passport_passenger.passport_id = (
    SELECT passport_passenger_id
    FROM ticket
    GROUP BY passport_passenger_id
    ORDER BY COUNT(*) ASC
    LIMIT 1
);


-- 2. UPDATE. Найдем рейс с наибольшей ценой билета и обновим статус для каждого
UPDATE ticket
SET status = 'Cancelled'
WHERE trip_id = (
    SELECT trip_id
    FROM trip
    ORDER BY price DESC
    LIMIT 1
);

-- 3. DELETE. Определим самый непопулярный маршрут и удалим все билеты для этого маршрута
DELETE FROM ticket WHERE trip_id IN (
    SELECT trip_id FROM trip
    WHERE route_id IN (
        SELECT route_id FROM (
            SELECT trip.route_id, COUNT(ticket.ticket_id) AS ticket_count
            FROM trip
            JOIN ticket ON ticket.trip_id = trip.trip_id
            WHERE trip.departure_date > CURRENT_DATE - INTERVAL '1 month'
            GROUP BY trip.route_id
        ) AS route_ticket_counts
        WHERE ticket_count IN (
            SELECT MIN(ticket_count)
            FROM (
                SELECT trip.route_id, COUNT(ticket.ticket_id) AS ticket_count
                FROM trip
                JOIN ticket ON ticket.trip_id = trip.trip_id
                WHERE trip.departure_date > CURRENT_DATE - INTERVAL '1 month'
                GROUP BY trip.route_id
            ) AS counts
        )
    )
);
