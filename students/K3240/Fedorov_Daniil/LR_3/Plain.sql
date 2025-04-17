--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4
-- Dumped by pg_dump version 17.4

-- Started on 2025-04-17 15:25:38 MSK

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 3727 (class 1262 OID 16388)
-- Name: airport_db; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE airport_db WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'C';


ALTER DATABASE airport_db OWNER TO postgres;

\connect airport_db

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 6 (class 2615 OID 16389)
-- Name: airport_scheme; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA airport_scheme;


ALTER SCHEMA airport_scheme OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 223 (class 1259 OID 16446)
-- Name: aircraft; Type: TABLE; Schema: airport_scheme; Owner: postgres
--

CREATE TABLE airport_scheme.aircraft (
    aircraft_id integer NOT NULL,
    board_number character varying(15) NOT NULL,
    manufacturer character varying(50) NOT NULL,
    model character varying(50) NOT NULL,
    production_year integer NOT NULL,
    last_maintenance_date date NOT NULL,
    speed integer NOT NULL,
    fuel_consumption numeric(10,3) NOT NULL,
    seat_capacity integer NOT NULL,
    flight_hours integer NOT NULL,
    payload integer NOT NULL,
    airline_id integer NOT NULL
);


ALTER TABLE airport_scheme.aircraft OWNER TO postgres;

--
-- TOC entry 3728 (class 0 OID 0)
-- Dependencies: 223
-- Name: TABLE aircraft; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON TABLE airport_scheme.aircraft IS 'Содержит технические характеристики воздушных судов.';


--
-- TOC entry 3729 (class 0 OID 0)
-- Dependencies: 223
-- Name: COLUMN aircraft.board_number; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON COLUMN airport_scheme.aircraft.board_number IS 'Бортовой номер воздушного судна.';


--
-- TOC entry 3730 (class 0 OID 0)
-- Dependencies: 223
-- Name: COLUMN aircraft.manufacturer; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON COLUMN airport_scheme.aircraft.manufacturer IS 'производитель';


--
-- TOC entry 3731 (class 0 OID 0)
-- Dependencies: 223
-- Name: COLUMN aircraft.model; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON COLUMN airport_scheme.aircraft.model IS 'модель';


--
-- TOC entry 3732 (class 0 OID 0)
-- Dependencies: 223
-- Name: COLUMN aircraft.production_year; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON COLUMN airport_scheme.aircraft.production_year IS 'год производства ';


--
-- TOC entry 3733 (class 0 OID 0)
-- Dependencies: 223
-- Name: COLUMN aircraft.last_maintenance_date; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON COLUMN airport_scheme.aircraft.last_maintenance_date IS 'дата последнего тех. осмотра';


--
-- TOC entry 3734 (class 0 OID 0)
-- Dependencies: 223
-- Name: COLUMN aircraft.speed; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON COLUMN airport_scheme.aircraft.speed IS 'полетная скорость км/ч';


--
-- TOC entry 3735 (class 0 OID 0)
-- Dependencies: 223
-- Name: COLUMN aircraft.fuel_consumption; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON COLUMN airport_scheme.aircraft.fuel_consumption IS 'расход топлива в литрах на км';


--
-- TOC entry 3736 (class 0 OID 0)
-- Dependencies: 223
-- Name: COLUMN aircraft.seat_capacity; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON COLUMN airport_scheme.aircraft.seat_capacity IS 'вместимость, шт';


--
-- TOC entry 3737 (class 0 OID 0)
-- Dependencies: 223
-- Name: COLUMN aircraft.flight_hours; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON COLUMN airport_scheme.aircraft.flight_hours IS 'налет в часах';


--
-- TOC entry 3738 (class 0 OID 0)
-- Dependencies: 223
-- Name: COLUMN aircraft.payload; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON COLUMN airport_scheme.aircraft.payload IS 'грузоподъемность, кг';


--
-- TOC entry 230 (class 1259 OID 16737)
-- Name: airline; Type: TABLE; Schema: airport_scheme; Owner: postgres
--

CREATE TABLE airport_scheme.airline (
    airline_id integer NOT NULL,
    airline_name character varying(20) NOT NULL
);


ALTER TABLE airport_scheme.airline OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16416)
-- Name: airport; Type: TABLE; Schema: airport_scheme; Owner: postgres
--

CREATE TABLE airport_scheme.airport (
    airport_id integer NOT NULL,
    city character varying(50) NOT NULL,
    code_isao character varying(4) NOT NULL,
    country character varying(50) NOT NULL
);


ALTER TABLE airport_scheme.airport OWNER TO postgres;

--
-- TOC entry 3739 (class 0 OID 0)
-- Dependencies: 221
-- Name: TABLE airport; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON TABLE airport_scheme.airport IS 'Список аэропортов с их локациями и кодами ICAO.';


--
-- TOC entry 3740 (class 0 OID 0)
-- Dependencies: 221
-- Name: COLUMN airport.city; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON COLUMN airport_scheme.airport.city IS 'Город аэропорта';


--
-- TOC entry 3741 (class 0 OID 0)
-- Dependencies: 221
-- Name: COLUMN airport.code_isao; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON COLUMN airport_scheme.airport.code_isao IS 'Код аэропорта по стандарту ICAO (4 символа)';


--
-- TOC entry 3742 (class 0 OID 0)
-- Dependencies: 221
-- Name: COLUMN airport.country; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON COLUMN airport_scheme.airport.country IS 'страна аэропорта';


--
-- TOC entry 227 (class 1259 OID 16490)
-- Name: cash_desk; Type: TABLE; Schema: airport_scheme; Owner: postgres
--

CREATE TABLE airport_scheme.cash_desk (
    cashdesk_id integer NOT NULL,
    cashdesk_number integer NOT NULL,
    is_online boolean NOT NULL
);


ALTER TABLE airport_scheme.cash_desk OWNER TO postgres;

--
-- TOC entry 3743 (class 0 OID 0)
-- Dependencies: 227
-- Name: TABLE cash_desk; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON TABLE airport_scheme.cash_desk IS 'Информация о кассах продажи билетов (онлайн/оффлайн).';


--
-- TOC entry 3744 (class 0 OID 0)
-- Dependencies: 227
-- Name: COLUMN cash_desk.cashdesk_number; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON COLUMN airport_scheme.cash_desk.cashdesk_number IS 'номер кассы';


--
-- TOC entry 3745 (class 0 OID 0)
-- Dependencies: 227
-- Name: COLUMN cash_desk.is_online; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON COLUMN airport_scheme.cash_desk.is_online IS 'онлайн или офлайн касса';


--
-- TOC entry 220 (class 1259 OID 16406)
-- Name: crew; Type: TABLE; Schema: airport_scheme; Owner: postgres
--

CREATE TABLE airport_scheme.crew (
    crew_id integer NOT NULL,
    employee_id integer NOT NULL,
    flight_id integer NOT NULL,
    role character varying(50) NOT NULL,
    medical_status character varying(10) DEFAULT 'прошел'::character varying NOT NULL,
    reason_falling_medical character varying(50)
);


ALTER TABLE airport_scheme.crew OWNER TO postgres;

--
-- TOC entry 3746 (class 0 OID 0)
-- Dependencies: 220
-- Name: TABLE crew; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON TABLE airport_scheme.crew IS 'Связывает сотрудников с рейсами и указывает их роль в экипаже.';


--
-- TOC entry 3747 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN crew.role; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON COLUMN airport_scheme.crew.role IS 'роль сотрудника на рейсе';


--
-- TOC entry 218 (class 1259 OID 16390)
-- Name: employee; Type: TABLE; Schema: airport_scheme; Owner: postgres
--

CREATE TABLE airport_scheme.employee (
    employee_id integer NOT NULL,
    first_name character varying(50) NOT NULL,
    last_name character varying(50) NOT NULL,
    middle_name character varying(50),
    birth_date date NOT NULL,
    medical_exam_date date NOT NULL,
    "position" character varying(50) NOT NULL
);


ALTER TABLE airport_scheme.employee OWNER TO postgres;

--
-- TOC entry 3748 (class 0 OID 0)
-- Dependencies: 218
-- Name: TABLE employee; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON TABLE airport_scheme.employee IS 'Данные о сотрудниках компании (ФИО, должность, медосмотры).';


--
-- TOC entry 3749 (class 0 OID 0)
-- Dependencies: 218
-- Name: COLUMN employee.medical_exam_date; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON COLUMN airport_scheme.employee.medical_exam_date IS 'Дата последнего медицинского осмотра сотрудника.';


--
-- TOC entry 3750 (class 0 OID 0)
-- Dependencies: 218
-- Name: COLUMN employee."position"; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON COLUMN airport_scheme.employee."position" IS 'должность сотрудника';


--
-- TOC entry 222 (class 1259 OID 16431)
-- Name: flight; Type: TABLE; Schema: airport_scheme; Owner: postgres
--

CREATE TABLE airport_scheme.flight (
    flight_id integer NOT NULL,
    flight_number integer NOT NULL,
    departure_date date NOT NULL,
    departure_time time with time zone NOT NULL,
    flight_type character varying(15) NOT NULL,
    aircraft_id integer NOT NULL,
    route_id integer NOT NULL
);


ALTER TABLE airport_scheme.flight OWNER TO postgres;

--
-- TOC entry 3751 (class 0 OID 0)
-- Dependencies: 222
-- Name: TABLE flight; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON TABLE airport_scheme.flight IS 'Расписание и параметры рейсов (дата, время, тип, воздушное судно).';


--
-- TOC entry 3752 (class 0 OID 0)
-- Dependencies: 222
-- Name: COLUMN flight.flight_number; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON COLUMN airport_scheme.flight.flight_number IS 'Бизнес-номер рейса, присвоенный авиакомпанией (например, 100, 200). Используется в расписаниях и билетах. Может повторяться для разных дат вылета';


--
-- TOC entry 3753 (class 0 OID 0)
-- Dependencies: 222
-- Name: COLUMN flight.flight_type; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON COLUMN airport_scheme.flight.flight_type IS 'Тип рейса: международный, внутренний, чартерный.';


--
-- TOC entry 219 (class 1259 OID 16395)
-- Name: medical_exam; Type: TABLE; Schema: airport_scheme; Owner: postgres
--

CREATE TABLE airport_scheme.medical_exam (
    medical_exam_id integer NOT NULL,
    employee_id integer NOT NULL,
    status character varying(20) NOT NULL,
    exam_date date NOT NULL
);


ALTER TABLE airport_scheme.medical_exam OWNER TO postgres;

--
-- TOC entry 3754 (class 0 OID 0)
-- Dependencies: 219
-- Name: TABLE medical_exam; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON TABLE airport_scheme.medical_exam IS 'Результаты медицинских осмотров сотрудников.';


--
-- TOC entry 3755 (class 0 OID 0)
-- Dependencies: 219
-- Name: COLUMN medical_exam.status; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON COLUMN airport_scheme.medical_exam.status IS 'Статус прохождения медосмотра: пройден, не пройден, в ожидании';


--
-- TOC entry 225 (class 1259 OID 16473)
-- Name: passenger; Type: TABLE; Schema: airport_scheme; Owner: postgres
--

CREATE TABLE airport_scheme.passenger (
    passenger_id integer NOT NULL,
    first_name character varying(50) NOT NULL,
    last_name character varying(50) NOT NULL,
    middle_name character varying(50),
    registration_status boolean NOT NULL
);


ALTER TABLE airport_scheme.passenger OWNER TO postgres;

--
-- TOC entry 3756 (class 0 OID 0)
-- Dependencies: 225
-- Name: TABLE passenger; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON TABLE airport_scheme.passenger IS 'Информация о пассажирах (ФИО, статус регистрации).';


--
-- TOC entry 226 (class 1259 OID 16478)
-- Name: passport_data; Type: TABLE; Schema: airport_scheme; Owner: postgres
--

CREATE TABLE airport_scheme.passport_data (
    passport_data_id integer NOT NULL,
    issue_date date NOT NULL,
    passenger_id integer NOT NULL,
    series character varying(10) NOT NULL,
    number character varying(15) NOT NULL
);


ALTER TABLE airport_scheme.passport_data OWNER TO postgres;

--
-- TOC entry 3757 (class 0 OID 0)
-- Dependencies: 226
-- Name: TABLE passport_data; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON TABLE airport_scheme.passport_data IS 'Паспортные данные пассажиров.';


--
-- TOC entry 229 (class 1259 OID 16525)
-- Name: route; Type: TABLE; Schema: airport_scheme; Owner: postgres
--

CREATE TABLE airport_scheme.route (
    route_id integer NOT NULL,
    departure_airport_id integer NOT NULL,
    arrival_airport_id integer NOT NULL
);


ALTER TABLE airport_scheme.route OWNER TO postgres;

--
-- TOC entry 3758 (class 0 OID 0)
-- Dependencies: 229
-- Name: TABLE route; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON TABLE airport_scheme.route IS 'Маршруты рейсов (аэропорты отправления и прибытия).';


--
-- TOC entry 228 (class 1259 OID 16497)
-- Name: ticket; Type: TABLE; Schema: airport_scheme; Owner: postgres
--

CREATE TABLE airport_scheme.ticket (
    ticket_id integer NOT NULL,
    ticket_number character varying(15) NOT NULL,
    ticket_status character varying(15) NOT NULL,
    purchase_date date NOT NULL,
    seat_number integer NOT NULL,
    class_of_service character varying(20) NOT NULL,
    baggage_insurance boolean NOT NULL,
    price integer NOT NULL,
    passenger_id integer NOT NULL,
    flight_id integer NOT NULL,
    cashdesk_id integer DEFAULT 1 NOT NULL,
    passport_data_id integer DEFAULT 1 NOT NULL,
    CONSTRAINT right_price CHECK ((price > 0))
);


ALTER TABLE airport_scheme.ticket OWNER TO postgres;

--
-- TOC entry 3759 (class 0 OID 0)
-- Dependencies: 228
-- Name: TABLE ticket; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON TABLE airport_scheme.ticket IS 'Данные о билетах (статус, класс, цена, место).';


--
-- TOC entry 3760 (class 0 OID 0)
-- Dependencies: 228
-- Name: COLUMN ticket.ticket_status; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON COLUMN airport_scheme.ticket.ticket_status IS 'Статус билета: активен, использован, отменен, просрочен';


--
-- TOC entry 3761 (class 0 OID 0)
-- Dependencies: 228
-- Name: COLUMN ticket.purchase_date; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON COLUMN airport_scheme.ticket.purchase_date IS 'дата покупки билета';


--
-- TOC entry 3762 (class 0 OID 0)
-- Dependencies: 228
-- Name: COLUMN ticket.class_of_service; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON COLUMN airport_scheme.ticket.class_of_service IS 'Класс обслуживания: эконом, бизнес, первый';


--
-- TOC entry 3763 (class 0 OID 0)
-- Dependencies: 228
-- Name: COLUMN ticket.baggage_insurance; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON COLUMN airport_scheme.ticket.baggage_insurance IS 'наличие багажа';


--
-- TOC entry 3764 (class 0 OID 0)
-- Dependencies: 228
-- Name: CONSTRAINT right_price ON ticket; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON CONSTRAINT right_price ON airport_scheme.ticket IS 'Цена билета должна быть больше 0.';


--
-- TOC entry 224 (class 1259 OID 16458)
-- Name: transit_stop; Type: TABLE; Schema: airport_scheme; Owner: postgres
--

CREATE TABLE airport_scheme.transit_stop (
    transit_stop_id integer NOT NULL,
    flight_id integer NOT NULL,
    airport_id integer NOT NULL,
    stop_type character varying(20) NOT NULL
);


ALTER TABLE airport_scheme.transit_stop OWNER TO postgres;

--
-- TOC entry 3765 (class 0 OID 0)
-- Dependencies: 224
-- Name: TABLE transit_stop; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON TABLE airport_scheme.transit_stop IS 'Промежуточные остановки рейсов (транзит, дозаправка, аварийные).';


--
-- TOC entry 3766 (class 0 OID 0)
-- Dependencies: 224
-- Name: COLUMN transit_stop.stop_type; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON COLUMN airport_scheme.transit_stop.stop_type IS 'Тип остановки: транзит, дозаправка, аварийная.';


--
-- TOC entry 3714 (class 0 OID 16446)
-- Dependencies: 223
-- Data for Name: aircraft; Type: TABLE DATA; Schema: airport_scheme; Owner: postgres
--

INSERT INTO airport_scheme.aircraft VALUES (1, 'A123', 'Airbus', 'A320', 2015, '2024-12-01', 800, 5.000, 180, 5000, 20000, 1);
INSERT INTO airport_scheme.aircraft VALUES (2, 'B456', 'Boeing', '737', 2018, '2025-03-15', 850, 4.800, 150, 6000, 21000, 1);
INSERT INTO airport_scheme.aircraft VALUES (3, 'C789', 'Airbus', 'A330', 2020, '2025-01-10', 900, 6.000, 200, 4000, 22000, 1);
INSERT INTO airport_scheme.aircraft VALUES (4, 'D012', 'Boeing', '747', 2012, '2024-11-20', 950, 7.000, 300, 8000, 25000, 1);
INSERT INTO airport_scheme.aircraft VALUES (5, 'E345', 'Lockheed', 'L-1011', 2005, '2025-02-05', 750, 4.500, 180, 12000, 22000, 1);
INSERT INTO airport_scheme.aircraft VALUES (6, 'F678', 'Cessna', 'Citation X', 2017, '2025-01-15', 850, 4.200, 80, 4500, 15000, 1);
INSERT INTO airport_scheme.aircraft VALUES (7, 'G901', 'Airbus', 'A320', 2013, '2024-10-10', 820, 5.300, 150, 5500, 20000, 1);
INSERT INTO airport_scheme.aircraft VALUES (8, 'H234', 'Boeing', '737', 2019, '2025-02-25', 870, 4.700, 180, 6000, 21000, 1);
INSERT INTO airport_scheme.aircraft VALUES (9, 'I567', 'Lockheed', 'L-1011', 2016, '2025-03-01', 800, 5.000, 160, 5500, 21000, 1);
INSERT INTO airport_scheme.aircraft VALUES (10, 'J890', 'Cessna', 'Citation X', 2014, '2025-01-01', 830, 4.600, 100, 4700, 16000, 1);
INSERT INTO airport_scheme.aircraft VALUES (11, 'K123', 'Airbus', 'A330', 2021, '2025-03-10', 950, 6.500, 220, 4000, 24000, 1);
INSERT INTO airport_scheme.aircraft VALUES (12, 'L456', 'Boeing', '747', 2018, '2025-02-28', 980, 7.100, 350, 7500, 27000, 1);
INSERT INTO airport_scheme.aircraft VALUES (13, 'M789', 'Lockheed', 'L-1011', 2015, '2025-03-12', 780, 4.900, 190, 5400, 23000, 1);
INSERT INTO airport_scheme.aircraft VALUES (14, 'N012', 'Cessna', 'Citation X', 2020, '2025-02-20', 840, 4.800, 120, 4600, 17000, 1);
INSERT INTO airport_scheme.aircraft VALUES (15, 'O345', 'Airbus', 'A320', 2012, '2024-11-01', 810, 5.100, 160, 5000, 21000, 1);
INSERT INTO airport_scheme.aircraft VALUES (16, 'P678', 'Boeing', '737', 2020, '2025-03-05', 860, 4.900, 170, 5800, 21500, 1);
INSERT INTO airport_scheme.aircraft VALUES (17, 'Q901', 'Lockheed', 'L-1011', 2017, '2025-01-08', 800, 5.200, 180, 5200, 22000, 1);
INSERT INTO airport_scheme.aircraft VALUES (18, 'R234', 'Cessna', 'Citation X', 2016, '2025-02-22', 830, 4.400, 90, 4800, 16000, 1);
INSERT INTO airport_scheme.aircraft VALUES (19, 'S567', 'Airbus', 'A330', 2022, '2025-03-08', 950, 6.600, 210, 4200, 23000, 1);
INSERT INTO airport_scheme.aircraft VALUES (20, 'T890', 'Boeing', '747', 2019, '2025-01-25', 970, 7.200, 320, 8000, 25000, 1);
INSERT INTO airport_scheme.aircraft VALUES (21, 'U123', 'Lockheed', 'L-1011', 2014, '2025-02-15', 770, 5.100, 200, 5100, 21000, 1);
INSERT INTO airport_scheme.aircraft VALUES (22, 'V456', 'Cessna', 'Citation X', 2018, '2025-01-30', 860, 4.500, 110, 4600, 15000, 1);
INSERT INTO airport_scheme.aircraft VALUES (23, 'W789', 'Airbus', 'A320', 2015, '2025-03-03', 800, 5.200, 150, 5200, 20000, 1);
INSERT INTO airport_scheme.aircraft VALUES (24, 'X012', 'Boeing', '737', 2017, '2025-02-18', 850, 4.600, 160, 5700, 21000, 1);
INSERT INTO airport_scheme.aircraft VALUES (25, 'Y345', 'Lockheed', 'L-1011', 2016, '2025-03-04', 790, 5.000, 190, 5300, 22000, 1);
INSERT INTO airport_scheme.aircraft VALUES (26, 'Z678', 'Cessna', 'Citation X', 2019, '2025-01-18', 830, 4.700, 120, 4900, 16000, 1);
INSERT INTO airport_scheme.aircraft VALUES (27, 'A901', 'Airbus', 'A330', 2021, '2025-03-07', 940, 6.300, 230, 4300, 24000, 1);
INSERT INTO airport_scheme.aircraft VALUES (28, 'B234', 'Boeing', '747', 2020, '2025-02-27', 960, 7.000, 330, 7800, 26000, 1);
INSERT INTO airport_scheme.aircraft VALUES (29, 'C567', 'Lockheed', 'L-1011', 2017, '2025-01-20', 790, 5.300, 170, 5400, 23000, 1);
INSERT INTO airport_scheme.aircraft VALUES (30, 'D890', 'Cessna', 'Citation X', 2015, '2025-02-05', 840, 4.900, 130, 4700, 17000, 1);
INSERT INTO airport_scheme.aircraft VALUES (31, 'E123', 'Airbus', 'A320', 2018, '2025-01-13', 810, 5.400, 160, 5300, 21000, 1);
INSERT INTO airport_scheme.aircraft VALUES (32, 'F456', 'Boeing', '737', 2016, '2025-02-12', 860, 5.100, 150, 5500, 21500, 1);
INSERT INTO airport_scheme.aircraft VALUES (33, 'G789', 'Lockheed', 'L-1011', 2021, '2025-03-11', 770, 5.200, 190, 5200, 22000, 1);
INSERT INTO airport_scheme.aircraft VALUES (34, 'H012', 'Cessna', 'Citation X', 2020, '2025-01-22', 830, 4.600, 140, 4800, 16000, 1);
INSERT INTO airport_scheme.aircraft VALUES (35, 'I345', 'Airbus', 'A320', 2020, '2025-02-28', 800, 5.000, 150, 5600, 21000, 1);
INSERT INTO airport_scheme.aircraft VALUES (36, 'J678', 'Boeing', '737', 2015, '2025-03-06', 850, 4.800, 170, 6000, 22000, 1);
INSERT INTO airport_scheme.aircraft VALUES (37, 'K901', 'Lockheed', 'L-1011', 2014, '2025-03-02', 800, 5.100, 160, 5100, 21000, 1);
INSERT INTO airport_scheme.aircraft VALUES (38, 'L234', 'Cessna', 'Citation X', 2018, '2025-02-10', 830, 4.400, 110, 4900, 15000, 1);
INSERT INTO airport_scheme.aircraft VALUES (39, 'M567', 'Airbus', 'A330', 2022, '2025-03-09', 960, 6.800, 240, 4400, 25000, 1);
INSERT INTO airport_scheme.aircraft VALUES (40, 'N890', 'Boeing', '747', 2019, '2025-01-29', 970, 7.300, 330, 7900, 27000, 1);


--
-- TOC entry 3721 (class 0 OID 16737)
-- Dependencies: 230
-- Data for Name: airline; Type: TABLE DATA; Schema: airport_scheme; Owner: postgres
--

INSERT INTO airport_scheme.airline VALUES (1, 'Aeroflt');
INSERT INTO airport_scheme.airline VALUES (2, 'SYBYR');


--
-- TOC entry 3712 (class 0 OID 16416)
-- Dependencies: 221
-- Data for Name: airport; Type: TABLE DATA; Schema: airport_scheme; Owner: postgres
--

INSERT INTO airport_scheme.airport VALUES (1, 'Москва', 'UUEE', 'Россия');
INSERT INTO airport_scheme.airport VALUES (2, 'Санкт-Петербург', 'ULLI', 'Россия');
INSERT INTO airport_scheme.airport VALUES (3, 'Нью-Йорк', 'KJFK', 'США');
INSERT INTO airport_scheme.airport VALUES (4, 'Лондон', 'EGLL', 'Великобритания');
INSERT INTO airport_scheme.airport VALUES (5, 'Берлин', 'EDDB', 'Германия');
INSERT INTO airport_scheme.airport VALUES (6, 'Токио', 'RJTT', 'Япония');
INSERT INTO airport_scheme.airport VALUES (7, 'Сидней', 'YSSY', 'Австралия');
INSERT INTO airport_scheme.airport VALUES (8, 'Париж', 'LFPG', 'Франция');
INSERT INTO airport_scheme.airport VALUES (9, 'Рим', 'LIRF', 'Италия');
INSERT INTO airport_scheme.airport VALUES (10, 'Барселона', 'LEBL', 'Испания');
INSERT INTO airport_scheme.airport VALUES (11, 'Амстердам', 'EHAM', 'Нидерланды');
INSERT INTO airport_scheme.airport VALUES (12, 'Киев', 'UKBB', 'Украина');
INSERT INTO airport_scheme.airport VALUES (13, 'Дубай', 'OMDB', 'ОАЭ');
INSERT INTO airport_scheme.airport VALUES (14, 'Лос-Анджелес', 'KLAX', 'США');
INSERT INTO airport_scheme.airport VALUES (15, 'Мельбурн', 'YMML', 'Австралия');
INSERT INTO airport_scheme.airport VALUES (16, 'Гонконг', 'VHHH', 'Китай');
INSERT INTO airport_scheme.airport VALUES (17, 'Сингапур', 'WSSS', 'Сингапур');
INSERT INTO airport_scheme.airport VALUES (18, 'Мумбаи', 'VABB', 'Индия');
INSERT INTO airport_scheme.airport VALUES (19, 'Шанхай', 'ZSPD', 'Китай');
INSERT INTO airport_scheme.airport VALUES (20, 'Сеул', 'RKSI', 'Южная Корея');
INSERT INTO airport_scheme.airport VALUES (21, 'Сингапур', 'WSSS', 'Сингапур');
INSERT INTO airport_scheme.airport VALUES (22, 'Мумбаи', 'VABB', 'Индия');
INSERT INTO airport_scheme.airport VALUES (23, 'Пекин', 'ZBAA', 'Китай');
INSERT INTO airport_scheme.airport VALUES (24, 'Дели', 'VIDP', 'Индия');
INSERT INTO airport_scheme.airport VALUES (25, 'Москва', 'UUEE', 'Россия');
INSERT INTO airport_scheme.airport VALUES (26, 'Лондон', 'EGLL', 'Великобритания');
INSERT INTO airport_scheme.airport VALUES (27, 'Пекин', 'ZBAA', 'Китай');
INSERT INTO airport_scheme.airport VALUES (28, 'Торонто', 'YYZ', 'Канада');
INSERT INTO airport_scheme.airport VALUES (29, 'Калифорния', 'KSFO', 'США');
INSERT INTO airport_scheme.airport VALUES (30, 'Чикаго', 'KORD', 'США');
INSERT INTO airport_scheme.airport VALUES (31, 'Даллас', 'KDFW', 'США');
INSERT INTO airport_scheme.airport VALUES (32, 'Атланта', 'KATL', 'США');
INSERT INTO airport_scheme.airport VALUES (33, 'Сан-Франциско', 'KSFO', 'США');
INSERT INTO airport_scheme.airport VALUES (34, 'Нью-Йорк', 'KJFK', 'США');
INSERT INTO airport_scheme.airport VALUES (35, 'Филадельфия', 'KPHL', 'США');
INSERT INTO airport_scheme.airport VALUES (36, 'Мадрид', 'LEMD', 'Испания');
INSERT INTO airport_scheme.airport VALUES (37, 'Шанхай', 'ZSPD', 'Китай');
INSERT INTO airport_scheme.airport VALUES (38, 'Москва', 'UUDD', 'Россия');
INSERT INTO airport_scheme.airport VALUES (39, 'Токио', 'RJAA', 'Япония');
INSERT INTO airport_scheme.airport VALUES (40, 'Киев', 'UKKK', 'Украина');


--
-- TOC entry 3718 (class 0 OID 16490)
-- Dependencies: 227
-- Data for Name: cash_desk; Type: TABLE DATA; Schema: airport_scheme; Owner: postgres
--

INSERT INTO airport_scheme.cash_desk VALUES (1, 101, true);
INSERT INTO airport_scheme.cash_desk VALUES (2, 102, false);
INSERT INTO airport_scheme.cash_desk VALUES (3, 103, true);
INSERT INTO airport_scheme.cash_desk VALUES (4, 104, false);
INSERT INTO airport_scheme.cash_desk VALUES (5, 105, true);
INSERT INTO airport_scheme.cash_desk VALUES (6, 106, false);
INSERT INTO airport_scheme.cash_desk VALUES (7, 107, true);
INSERT INTO airport_scheme.cash_desk VALUES (8, 108, false);
INSERT INTO airport_scheme.cash_desk VALUES (9, 109, true);
INSERT INTO airport_scheme.cash_desk VALUES (10, 110, false);
INSERT INTO airport_scheme.cash_desk VALUES (11, 111, true);
INSERT INTO airport_scheme.cash_desk VALUES (12, 112, false);
INSERT INTO airport_scheme.cash_desk VALUES (13, 113, true);
INSERT INTO airport_scheme.cash_desk VALUES (14, 114, false);
INSERT INTO airport_scheme.cash_desk VALUES (15, 115, true);
INSERT INTO airport_scheme.cash_desk VALUES (16, 116, false);
INSERT INTO airport_scheme.cash_desk VALUES (17, 117, true);
INSERT INTO airport_scheme.cash_desk VALUES (18, 118, false);
INSERT INTO airport_scheme.cash_desk VALUES (19, 119, true);
INSERT INTO airport_scheme.cash_desk VALUES (20, 120, false);
INSERT INTO airport_scheme.cash_desk VALUES (21, 121, true);
INSERT INTO airport_scheme.cash_desk VALUES (22, 122, false);
INSERT INTO airport_scheme.cash_desk VALUES (23, 123, true);
INSERT INTO airport_scheme.cash_desk VALUES (24, 124, false);
INSERT INTO airport_scheme.cash_desk VALUES (25, 125, true);
INSERT INTO airport_scheme.cash_desk VALUES (26, 126, false);
INSERT INTO airport_scheme.cash_desk VALUES (27, 127, true);
INSERT INTO airport_scheme.cash_desk VALUES (28, 128, false);
INSERT INTO airport_scheme.cash_desk VALUES (29, 129, true);
INSERT INTO airport_scheme.cash_desk VALUES (30, 130, false);
INSERT INTO airport_scheme.cash_desk VALUES (31, 131, true);
INSERT INTO airport_scheme.cash_desk VALUES (32, 132, false);
INSERT INTO airport_scheme.cash_desk VALUES (33, 133, true);
INSERT INTO airport_scheme.cash_desk VALUES (34, 134, false);
INSERT INTO airport_scheme.cash_desk VALUES (35, 135, true);
INSERT INTO airport_scheme.cash_desk VALUES (36, 136, false);
INSERT INTO airport_scheme.cash_desk VALUES (37, 137, true);
INSERT INTO airport_scheme.cash_desk VALUES (38, 138, false);
INSERT INTO airport_scheme.cash_desk VALUES (39, 139, true);
INSERT INTO airport_scheme.cash_desk VALUES (40, 140, false);


--
-- TOC entry 3711 (class 0 OID 16406)
-- Dependencies: 220
-- Data for Name: crew; Type: TABLE DATA; Schema: airport_scheme; Owner: postgres
--

INSERT INTO airport_scheme.crew VALUES (1, 1, 1, 'Пилот', 'прошел', NULL);
INSERT INTO airport_scheme.crew VALUES (2, 2, 2, 'Стюардесса', 'прошел', NULL);
INSERT INTO airport_scheme.crew VALUES (3, 3, 3, 'Механик', 'прошел', NULL);
INSERT INTO airport_scheme.crew VALUES (4, 4, 4, 'Пилот', 'прошел', NULL);
INSERT INTO airport_scheme.crew VALUES (5, 5, 5, 'Стюардесса', 'прошел', NULL);
INSERT INTO airport_scheme.crew VALUES (6, 6, 6, 'Пилот', 'прошел', NULL);
INSERT INTO airport_scheme.crew VALUES (7, 7, 7, 'Механик', 'прошел', NULL);
INSERT INTO airport_scheme.crew VALUES (8, 8, 8, 'Стюардесса', 'прошел', NULL);
INSERT INTO airport_scheme.crew VALUES (9, 9, 9, 'Пилот', 'прошел', NULL);
INSERT INTO airport_scheme.crew VALUES (10, 10, 10, 'Стюардесса', 'прошел', NULL);
INSERT INTO airport_scheme.crew VALUES (11, 11, 11, 'Механик', 'прошел', NULL);
INSERT INTO airport_scheme.crew VALUES (12, 12, 12, 'Пилот', 'прошел', NULL);
INSERT INTO airport_scheme.crew VALUES (13, 13, 13, 'Стюардесса', 'прошел', NULL);
INSERT INTO airport_scheme.crew VALUES (14, 14, 14, 'Механик', 'прошел', NULL);
INSERT INTO airport_scheme.crew VALUES (15, 15, 15, 'Пилот', 'прошел', NULL);
INSERT INTO airport_scheme.crew VALUES (16, 16, 16, 'Стюардесса', 'прошел', NULL);
INSERT INTO airport_scheme.crew VALUES (17, 17, 17, 'Механик', 'прошел', NULL);
INSERT INTO airport_scheme.crew VALUES (18, 18, 18, 'Пилот', 'прошел', NULL);
INSERT INTO airport_scheme.crew VALUES (19, 19, 19, 'Стюардесса', 'прошел', NULL);
INSERT INTO airport_scheme.crew VALUES (20, 20, 20, 'Механик', 'прошел', NULL);
INSERT INTO airport_scheme.crew VALUES (21, 21, 21, 'Пилот', 'прошел', NULL);
INSERT INTO airport_scheme.crew VALUES (22, 22, 22, 'Стюардесса', 'прошел', NULL);
INSERT INTO airport_scheme.crew VALUES (23, 23, 23, 'Механик', 'прошел', NULL);
INSERT INTO airport_scheme.crew VALUES (24, 24, 24, 'Пилот', 'прошел', NULL);
INSERT INTO airport_scheme.crew VALUES (25, 25, 25, 'Стюардесса', 'прошел', NULL);
INSERT INTO airport_scheme.crew VALUES (26, 26, 26, 'Механик', 'прошел', NULL);
INSERT INTO airport_scheme.crew VALUES (27, 27, 27, 'Пилот', 'прошел', NULL);
INSERT INTO airport_scheme.crew VALUES (28, 28, 28, 'Стюардесса', 'прошел', NULL);
INSERT INTO airport_scheme.crew VALUES (29, 29, 29, 'Механик', 'прошел', NULL);
INSERT INTO airport_scheme.crew VALUES (30, 30, 30, 'Пилот', 'прошел', NULL);
INSERT INTO airport_scheme.crew VALUES (31, 31, 31, 'Стюардесса', 'прошел', NULL);
INSERT INTO airport_scheme.crew VALUES (32, 32, 32, 'Механик', 'прошел', NULL);
INSERT INTO airport_scheme.crew VALUES (33, 33, 33, 'Пилот', 'прошел', NULL);
INSERT INTO airport_scheme.crew VALUES (34, 34, 34, 'Стюардесса', 'прошел', NULL);
INSERT INTO airport_scheme.crew VALUES (35, 35, 35, 'Механик', 'прошел', NULL);
INSERT INTO airport_scheme.crew VALUES (36, 36, 36, 'Пилот', 'прошел', NULL);
INSERT INTO airport_scheme.crew VALUES (37, 37, 37, 'Стюардесса', 'прошел', NULL);
INSERT INTO airport_scheme.crew VALUES (38, 38, 38, 'Механик', 'прошел', NULL);
INSERT INTO airport_scheme.crew VALUES (39, 39, 39, 'Пилот', 'прошел', NULL);
INSERT INTO airport_scheme.crew VALUES (40, 40, 40, 'Стюардесса', 'прошел', NULL);


--
-- TOC entry 3709 (class 0 OID 16390)
-- Dependencies: 218
-- Data for Name: employee; Type: TABLE DATA; Schema: airport_scheme; Owner: postgres
--

INSERT INTO airport_scheme.employee VALUES (1, 'Иван', 'Иванов', 'Иванович', '1985-06-15', '2025-04-01', 'Пилот');
INSERT INTO airport_scheme.employee VALUES (2, 'Мария', 'Петрова', 'Петровна', '1990-08-25', '2025-04-05', 'Стюардесса');
INSERT INTO airport_scheme.employee VALUES (3, 'Алексей', 'Сидоров', 'Алексеевич', '1987-11-30', '2025-03-25', 'Механик');
INSERT INTO airport_scheme.employee VALUES (4, 'Ольга', 'Васильева', 'Владимировна', '1983-04-10', '2025-04-02', 'Пилот');
INSERT INTO airport_scheme.employee VALUES (5, 'Дмитрий', 'Кузнецов', 'Сергеевич', '1992-02-15', '2025-03-30', 'Стюардесса');
INSERT INTO airport_scheme.employee VALUES (6, 'Татьяна', 'Федорова', 'Александровна', '1995-01-05', '2025-02-15', 'Пилот');
INSERT INTO airport_scheme.employee VALUES (7, 'Никита', 'Беляев', 'Михайлович', '1989-07-23', '2025-04-03', 'Механик');
INSERT INTO airport_scheme.employee VALUES (8, 'Екатерина', 'Петрова', 'Ивановна', '1991-09-20', '2025-03-28', 'Стюардесса');
INSERT INTO airport_scheme.employee VALUES (9, 'Роман', 'Григорьев', 'Игоревич', '1988-03-12', '2025-04-01', 'Пилот');
INSERT INTO airport_scheme.employee VALUES (10, 'Виктория', 'Смирнова', 'Владимировна', '1986-05-25', '2025-02-28', 'Стюардесса');
INSERT INTO airport_scheme.employee VALUES (11, 'Максим', 'Левченко', 'Олегович', '1990-10-10', '2025-03-15', 'Механик');
INSERT INTO airport_scheme.employee VALUES (12, 'Юлия', 'Калинина', 'Дмитриевна', '1985-12-08', '2025-03-20', 'Пилот');
INSERT INTO airport_scheme.employee VALUES (13, 'Анастасия', 'Воронова', 'Геннадиевна', '1993-04-03', '2025-02-17', 'Стюардесса');
INSERT INTO airport_scheme.employee VALUES (14, 'Игорь', 'Щербаков', 'Романович', '1990-11-18', '2025-03-22', 'Механик');
INSERT INTO airport_scheme.employee VALUES (15, 'Кирилл', 'Пономарев', 'Андреевич', '1989-05-19', '2025-03-25', 'Пилот');
INSERT INTO airport_scheme.employee VALUES (16, 'Валерия', 'Богданова', 'Сергеевна', '1994-07-13', '2025-02-19', 'Стюардесса');
INSERT INTO airport_scheme.employee VALUES (17, 'Сергей', 'Морозов', 'Петрович', '1988-08-29', '2025-03-12', 'Механик');
INSERT INTO airport_scheme.employee VALUES (18, 'Маргарита', 'Гусева', 'Викторовна', '1992-10-05', '2025-04-01', 'Пилот');
INSERT INTO airport_scheme.employee VALUES (19, 'Егор', 'Мельников', 'Дмитриевич', '1987-02-16', '2025-03-28', 'Стюардесса');
INSERT INTO airport_scheme.employee VALUES (20, 'Светлана', 'Козлова', 'Михайловна', '1990-11-15', '2025-02-25', 'Механик');
INSERT INTO airport_scheme.employee VALUES (21, 'Ярослав', 'Дмитриев', 'Николаевич', '1991-03-04', '2025-03-10', 'Пилот');
INSERT INTO airport_scheme.employee VALUES (22, 'Ольга', 'Захарова', 'Викторовна', '1988-09-12', '2025-04-03', 'Стюардесса');
INSERT INTO airport_scheme.employee VALUES (23, 'Артем', 'Филатов', 'Евгеньевич', '1993-06-20', '2025-03-19', 'Механик');
INSERT INTO airport_scheme.employee VALUES (24, 'Александр', 'Кириллов', 'Николаевич', '1989-01-22', '2025-04-05', 'Пилот');
INSERT INTO airport_scheme.employee VALUES (25, 'Тимофей', 'Федоров', 'Павлович', '1987-12-17', '2025-03-21', 'Стюардесса');
INSERT INTO airport_scheme.employee VALUES (26, 'Анатолий', 'Солдатов', 'Игоревич', '1994-05-30', '2025-02-22', 'Механик');
INSERT INTO airport_scheme.employee VALUES (27, 'Дарина', 'Чистякова', 'Александровна', '1990-09-08', '2025-03-10', 'Пилот');
INSERT INTO airport_scheme.employee VALUES (28, 'Алексей', 'Громов', 'Сергеевич', '1991-04-18', '2025-03-13', 'Стюардесса');
INSERT INTO airport_scheme.employee VALUES (29, 'Никита', 'Лазарев', 'Владимирович', '1986-06-28', '2025-04-02', 'Механик');
INSERT INTO airport_scheme.employee VALUES (30, 'Полина', 'Тимофеева', 'Романовна', '1987-09-25', '2025-02-18', 'Пилот');
INSERT INTO airport_scheme.employee VALUES (31, 'Ирина', 'Смирнова', 'Геннадиевна', '1994-10-30', '2025-02-12', 'Стюардесса');
INSERT INTO airport_scheme.employee VALUES (32, 'Дмитрий', 'Шмидт', 'Евгеньевич', '1989-04-04', '2025-03-22', 'Механик');
INSERT INTO airport_scheme.employee VALUES (33, 'Евгений', 'Фролов', 'Иванович', '1990-07-03', '2025-03-16', 'Пилот');
INSERT INTO airport_scheme.employee VALUES (34, 'Марина', 'Богданова', 'Юрьевна', '1994-08-17', '2025-02-07', 'Стюардесса');
INSERT INTO airport_scheme.employee VALUES (35, 'Владимир', 'Николаев', 'Михайлович', '1987-11-14', '2025-03-01', 'Механик');
INSERT INTO airport_scheme.employee VALUES (36, 'Ксения', 'Морозова', 'Петровна', '1993-01-11', '2025-03-18', 'Пилот');
INSERT INTO airport_scheme.employee VALUES (37, 'Григорий', 'Ефимов', 'Сергеевич', '1989-12-08', '2025-02-20', 'Стюардесса');
INSERT INTO airport_scheme.employee VALUES (38, 'Елена', 'Панова', 'Александровна', '1990-05-24', '2025-02-27', 'Механик');
INSERT INTO airport_scheme.employee VALUES (39, 'Петр', 'Лавров', 'Сергеевич', '1991-08-13', '2025-03-09', 'Пилот');
INSERT INTO airport_scheme.employee VALUES (40, 'Тимур', 'Мельников', 'Иванович', '1987-01-29', '2025-02-26', 'Стюардесса');


--
-- TOC entry 3713 (class 0 OID 16431)
-- Dependencies: 222
-- Data for Name: flight; Type: TABLE DATA; Schema: airport_scheme; Owner: postgres
--

INSERT INTO airport_scheme.flight VALUES (1, 100, '2025-04-20', '10:30:00+03', 'Международный', 1, 1);
INSERT INTO airport_scheme.flight VALUES (2, 200, '2025-04-21', '14:00:00+03', 'Внутренний', 2, 2);
INSERT INTO airport_scheme.flight VALUES (3, 300, '2025-04-22', '16:00:00+03', 'Чартерный', 3, 3);
INSERT INTO airport_scheme.flight VALUES (4, 400, '2025-04-23', '18:30:00+03', 'Международный', 4, 4);
INSERT INTO airport_scheme.flight VALUES (5, 500, '2025-04-24', '08:00:00+03', 'Внутренний', 5, 5);
INSERT INTO airport_scheme.flight VALUES (6, 600, '2025-04-25', '09:30:00+03', 'Чартерный', 6, 6);
INSERT INTO airport_scheme.flight VALUES (7, 700, '2025-04-26', '12:00:00+03', 'Международный', 7, 7);
INSERT INTO airport_scheme.flight VALUES (8, 800, '2025-04-27', '15:00:00+03', 'Внутренний', 8, 8);
INSERT INTO airport_scheme.flight VALUES (9, 900, '2025-04-28', '17:30:00+03', 'Чартерный', 9, 9);
INSERT INTO airport_scheme.flight VALUES (10, 1000, '2025-04-29', '19:00:00+03', 'Международный', 10, 10);
INSERT INTO airport_scheme.flight VALUES (11, 1100, '2025-04-30', '07:30:00+03', 'Внутренний', 11, 11);
INSERT INTO airport_scheme.flight VALUES (12, 1200, '2025-05-01', '09:00:00+03', 'Чартерный', 12, 12);
INSERT INTO airport_scheme.flight VALUES (13, 1300, '2025-05-02', '11:30:00+03', 'Международный', 13, 13);
INSERT INTO airport_scheme.flight VALUES (14, 1400, '2025-05-03', '13:00:00+03', 'Внутренний', 14, 14);
INSERT INTO airport_scheme.flight VALUES (15, 1500, '2025-05-04', '14:30:00+03', 'Чартерный', 15, 15);
INSERT INTO airport_scheme.flight VALUES (16, 1600, '2025-05-05', '16:00:00+03', 'Международный', 16, 16);
INSERT INTO airport_scheme.flight VALUES (17, 1700, '2025-05-06', '17:30:00+03', 'Внутренний', 17, 17);
INSERT INTO airport_scheme.flight VALUES (18, 1800, '2025-05-07', '19:00:00+03', 'Чартерный', 18, 18);
INSERT INTO airport_scheme.flight VALUES (19, 1900, '2025-05-08', '20:30:00+03', 'Международный', 19, 19);
INSERT INTO airport_scheme.flight VALUES (20, 2000, '2025-05-09', '21:00:00+03', 'Внутренний', 20, 20);
INSERT INTO airport_scheme.flight VALUES (21, 2100, '2025-05-10', '07:00:00+03', 'Чартерный', 21, 21);
INSERT INTO airport_scheme.flight VALUES (22, 2200, '2025-05-11', '08:30:00+03', 'Международный', 22, 22);
INSERT INTO airport_scheme.flight VALUES (23, 2300, '2025-05-12', '10:00:00+03', 'Внутренний', 23, 23);
INSERT INTO airport_scheme.flight VALUES (24, 2400, '2025-05-13', '11:30:00+03', 'Чартерный', 24, 24);
INSERT INTO airport_scheme.flight VALUES (25, 2500, '2025-05-14', '13:00:00+03', 'Международный', 25, 25);
INSERT INTO airport_scheme.flight VALUES (26, 2600, '2025-05-15', '14:30:00+03', 'Внутренний', 26, 26);
INSERT INTO airport_scheme.flight VALUES (27, 2700, '2025-05-16', '16:00:00+03', 'Чартерный', 27, 27);
INSERT INTO airport_scheme.flight VALUES (28, 2800, '2025-05-17', '17:30:00+03', 'Международный', 28, 28);
INSERT INTO airport_scheme.flight VALUES (29, 2900, '2025-05-18', '19:00:00+03', 'Внутренний', 29, 29);
INSERT INTO airport_scheme.flight VALUES (30, 3000, '2025-05-19', '20:30:00+03', 'Чартерный', 30, 30);
INSERT INTO airport_scheme.flight VALUES (31, 3100, '2025-05-20', '21:00:00+03', 'Международный', 31, 31);
INSERT INTO airport_scheme.flight VALUES (32, 3200, '2025-05-21', '07:00:00+03', 'Внутренний', 32, 32);
INSERT INTO airport_scheme.flight VALUES (33, 3300, '2025-05-22', '08:30:00+03', 'Чартерный', 33, 33);
INSERT INTO airport_scheme.flight VALUES (34, 3400, '2025-05-23', '10:00:00+03', 'Международный', 34, 34);
INSERT INTO airport_scheme.flight VALUES (35, 3500, '2025-05-24', '11:30:00+03', 'Внутренний', 35, 35);
INSERT INTO airport_scheme.flight VALUES (36, 3600, '2025-05-25', '13:00:00+03', 'Чартерный', 36, 36);
INSERT INTO airport_scheme.flight VALUES (37, 3700, '2025-05-26', '14:30:00+03', 'Международный', 37, 37);
INSERT INTO airport_scheme.flight VALUES (38, 3800, '2025-05-27', '16:00:00+03', 'Внутренний', 38, 38);
INSERT INTO airport_scheme.flight VALUES (39, 3900, '2025-05-28', '17:30:00+03', 'Чартерный', 39, 39);
INSERT INTO airport_scheme.flight VALUES (40, 4000, '2025-05-29', '19:00:00+03', 'Международный', 40, 40);


--
-- TOC entry 3710 (class 0 OID 16395)
-- Dependencies: 219
-- Data for Name: medical_exam; Type: TABLE DATA; Schema: airport_scheme; Owner: postgres
--

INSERT INTO airport_scheme.medical_exam VALUES (1, 1, 'пройден', '2025-04-01');
INSERT INTO airport_scheme.medical_exam VALUES (2, 2, 'в ожидании', '2025-04-05');
INSERT INTO airport_scheme.medical_exam VALUES (3, 3, 'не пройден', '2025-03-15');
INSERT INTO airport_scheme.medical_exam VALUES (4, 4, 'пройден', '2025-04-02');
INSERT INTO airport_scheme.medical_exam VALUES (5, 5, 'в ожидании', '2025-03-30');
INSERT INTO airport_scheme.medical_exam VALUES (6, 6, 'пройден', '2025-02-15');
INSERT INTO airport_scheme.medical_exam VALUES (7, 7, 'не пройден', '2025-04-03');
INSERT INTO airport_scheme.medical_exam VALUES (8, 8, 'в ожидании', '2025-03-28');
INSERT INTO airport_scheme.medical_exam VALUES (9, 9, 'пройден', '2025-04-01');
INSERT INTO airport_scheme.medical_exam VALUES (10, 10, 'не пройден', '2025-02-28');
INSERT INTO airport_scheme.medical_exam VALUES (11, 11, 'в ожидании', '2025-03-15');
INSERT INTO airport_scheme.medical_exam VALUES (12, 12, 'пройден', '2025-03-20');
INSERT INTO airport_scheme.medical_exam VALUES (13, 13, 'не пройден', '2025-02-17');
INSERT INTO airport_scheme.medical_exam VALUES (14, 14, 'в ожидании', '2025-03-22');
INSERT INTO airport_scheme.medical_exam VALUES (15, 15, 'пройден', '2025-03-25');
INSERT INTO airport_scheme.medical_exam VALUES (16, 16, 'в ожидании', '2025-02-19');
INSERT INTO airport_scheme.medical_exam VALUES (17, 17, 'не пройден', '2025-03-12');
INSERT INTO airport_scheme.medical_exam VALUES (18, 18, 'в ожидании', '2025-04-01');
INSERT INTO airport_scheme.medical_exam VALUES (19, 19, 'пройден', '2025-03-28');
INSERT INTO airport_scheme.medical_exam VALUES (20, 20, 'не пройден', '2025-02-25');
INSERT INTO airport_scheme.medical_exam VALUES (21, 21, 'в ожидании', '2025-03-10');
INSERT INTO airport_scheme.medical_exam VALUES (22, 22, 'пройден', '2025-03-13');
INSERT INTO airport_scheme.medical_exam VALUES (23, 23, 'не пройден', '2025-02-07');
INSERT INTO airport_scheme.medical_exam VALUES (24, 24, 'в ожидании', '2025-03-19');
INSERT INTO airport_scheme.medical_exam VALUES (25, 25, 'пройден', '2025-03-22');
INSERT INTO airport_scheme.medical_exam VALUES (26, 26, 'в ожидании', '2025-02-12');
INSERT INTO airport_scheme.medical_exam VALUES (27, 27, 'не пройден', '2025-03-25');
INSERT INTO airport_scheme.medical_exam VALUES (28, 28, 'в ожидании', '2025-02-18');
INSERT INTO airport_scheme.medical_exam VALUES (29, 29, 'пройден', '2025-03-09');
INSERT INTO airport_scheme.medical_exam VALUES (30, 30, 'не пройден', '2025-02-26');
INSERT INTO airport_scheme.medical_exam VALUES (31, 31, 'в ожидании', '2025-03-20');
INSERT INTO airport_scheme.medical_exam VALUES (32, 32, 'пройден', '2025-02-15');
INSERT INTO airport_scheme.medical_exam VALUES (33, 33, 'в ожидании', '2025-03-18');
INSERT INTO airport_scheme.medical_exam VALUES (34, 34, 'не пройден', '2025-03-05');
INSERT INTO airport_scheme.medical_exam VALUES (35, 35, 'в ожидании', '2025-02-22');
INSERT INTO airport_scheme.medical_exam VALUES (36, 36, 'пройден', '2025-03-01');
INSERT INTO airport_scheme.medical_exam VALUES (37, 37, 'в ожидании', '2025-02-28');
INSERT INTO airport_scheme.medical_exam VALUES (38, 38, 'не пройден', '2025-03-07');
INSERT INTO airport_scheme.medical_exam VALUES (39, 39, 'в ожидании', '2025-03-30');
INSERT INTO airport_scheme.medical_exam VALUES (40, 40, 'пройден', '2025-04-02');


--
-- TOC entry 3716 (class 0 OID 16473)
-- Dependencies: 225
-- Data for Name: passenger; Type: TABLE DATA; Schema: airport_scheme; Owner: postgres
--

INSERT INTO airport_scheme.passenger VALUES (1, 'Олег', 'Смирнов', 'Алексеевич', true);
INSERT INTO airport_scheme.passenger VALUES (2, 'Анна', 'Кузнецова', 'Сергеевна', true);
INSERT INTO airport_scheme.passenger VALUES (3, 'Дмитрий', 'Михайлов', 'Юрьевич', false);
INSERT INTO airport_scheme.passenger VALUES (4, 'Елена', 'Федорова', 'Александровна', true);
INSERT INTO airport_scheme.passenger VALUES (5, 'Игорь', 'Солдатов', 'Павлович', true);
INSERT INTO airport_scheme.passenger VALUES (6, 'Тимофей', 'Рогов', 'Максимович', true);
INSERT INTO airport_scheme.passenger VALUES (7, 'Мария', 'Боброва', 'Викторовна', false);
INSERT INTO airport_scheme.passenger VALUES (8, 'Алексей', 'Тимофеев', 'Александрович', true);
INSERT INTO airport_scheme.passenger VALUES (9, 'Светлана', 'Козлова', 'Михайловна', true);
INSERT INTO airport_scheme.passenger VALUES (10, 'Юлия', 'Савельева', 'Геннадиевна', false);
INSERT INTO airport_scheme.passenger VALUES (11, 'Ирина', 'Мельникова', 'Алексеевна', true);
INSERT INTO airport_scheme.passenger VALUES (12, 'Александр', 'Куликов', 'Владимирович', true);
INSERT INTO airport_scheme.passenger VALUES (13, 'Наталья', 'Богданова', 'Сергеевна', true);
INSERT INTO airport_scheme.passenger VALUES (14, 'Григорий', 'Морозов', 'Дмитриевич', true);
INSERT INTO airport_scheme.passenger VALUES (15, 'Маргарита', 'Левина', 'Вячеславовна', false);
INSERT INTO airport_scheme.passenger VALUES (16, 'Сергей', 'Николаев', 'Иванович', true);
INSERT INTO airport_scheme.passenger VALUES (17, 'Дарина', 'Филиппова', 'Михайловна', true);
INSERT INTO airport_scheme.passenger VALUES (18, 'Глеб', 'Волков', 'Николаевич', false);
INSERT INTO airport_scheme.passenger VALUES (19, 'Анатолий', 'Зайцев', 'Викторович', true);
INSERT INTO airport_scheme.passenger VALUES (20, 'Роман', 'Щербаков', 'Петрович', false);
INSERT INTO airport_scheme.passenger VALUES (21, 'Марина', 'Тимофеева', 'Александровна', true);
INSERT INTO airport_scheme.passenger VALUES (22, 'Денис', 'Шмидт', 'Игоревич', true);
INSERT INTO airport_scheme.passenger VALUES (23, 'Людмила', 'Тимошенко', 'Федоровна', false);
INSERT INTO airport_scheme.passenger VALUES (24, 'Петр', 'Горячев', 'Сергейевич', true);
INSERT INTO airport_scheme.passenger VALUES (25, 'Юлия', 'Рыкова', 'Анатольевна', true);
INSERT INTO airport_scheme.passenger VALUES (26, 'София', 'Громова', 'Геннадиевна', false);
INSERT INTO airport_scheme.passenger VALUES (27, 'Егор', 'Филиппов', 'Михайлович', true);
INSERT INTO airport_scheme.passenger VALUES (28, 'Анатолий', 'Климов', 'Игоревич', true);
INSERT INTO airport_scheme.passenger VALUES (29, 'Никита', 'Макаров', 'Павлович', true);
INSERT INTO airport_scheme.passenger VALUES (30, 'Алёна', 'Смирнова', 'Геннадиевна', true);
INSERT INTO airport_scheme.passenger VALUES (31, 'Игорь', 'Костин', 'Петрович', false);
INSERT INTO airport_scheme.passenger VALUES (32, 'Ирина', 'Жукова', 'Олеговна', true);
INSERT INTO airport_scheme.passenger VALUES (33, 'Константин', 'Руденко', 'Юрьевич', true);
INSERT INTO airport_scheme.passenger VALUES (34, 'Екатерина', 'Митрофанова', 'Владимировна', true);
INSERT INTO airport_scheme.passenger VALUES (35, 'Максим', 'Никитин', 'Геннадиевич', false);
INSERT INTO airport_scheme.passenger VALUES (36, 'Галина', 'Рогова', 'Ивановна', true);
INSERT INTO airport_scheme.passenger VALUES (37, 'Татьяна', 'Соловьева', 'Анатольевна', false);
INSERT INTO airport_scheme.passenger VALUES (38, 'Денис', 'Петров', 'Викторович', true);
INSERT INTO airport_scheme.passenger VALUES (39, 'Елизавета', 'Шмидт', 'Геннадиевна', true);
INSERT INTO airport_scheme.passenger VALUES (40, 'Николай', 'Голубев', 'Александрович', true);


--
-- TOC entry 3717 (class 0 OID 16478)
-- Dependencies: 226
-- Data for Name: passport_data; Type: TABLE DATA; Schema: airport_scheme; Owner: postgres
--

INSERT INTO airport_scheme.passport_data VALUES (1, '2025-01-01', 1, 'AA1234', '123456789');
INSERT INTO airport_scheme.passport_data VALUES (2, '2025-02-01', 2, 'BB5678', '987654321');
INSERT INTO airport_scheme.passport_data VALUES (3, '2025-03-01', 3, 'CC9012', '112233445');
INSERT INTO airport_scheme.passport_data VALUES (4, '2025-04-01', 4, 'DD3456', '556677889');
INSERT INTO airport_scheme.passport_data VALUES (5, '2025-01-15', 5, 'EE7890', '998877665');
INSERT INTO airport_scheme.passport_data VALUES (6, '2025-02-15', 6, 'FF2345', '123987654');
INSERT INTO airport_scheme.passport_data VALUES (7, '2025-03-15', 7, 'GG6789', '432109876');
INSERT INTO airport_scheme.passport_data VALUES (8, '2025-04-15', 8, 'HH1234', '908172634');
INSERT INTO airport_scheme.passport_data VALUES (9, '2025-01-10', 9, 'II5678', '345678987');
INSERT INTO airport_scheme.passport_data VALUES (10, '2025-02-10', 10, 'JJ9012', '879456123');
INSERT INTO airport_scheme.passport_data VALUES (11, '2025-03-10', 11, 'KK3456', '654123789');
INSERT INTO airport_scheme.passport_data VALUES (12, '2025-04-10', 12, 'LL7890', '345987654');
INSERT INTO airport_scheme.passport_data VALUES (13, '2025-01-20', 13, 'MM2345', '234567891');
INSERT INTO airport_scheme.passport_data VALUES (14, '2025-02-20', 14, 'NN6789', '672301589');
INSERT INTO airport_scheme.passport_data VALUES (15, '2025-03-20', 15, 'OO1234', '453298764');
INSERT INTO airport_scheme.passport_data VALUES (16, '2025-04-20', 16, 'PP5678', '124578963');
INSERT INTO airport_scheme.passport_data VALUES (17, '2025-01-25', 17, 'QQ9012', '564781239');
INSERT INTO airport_scheme.passport_data VALUES (18, '2025-02-25', 18, 'RR3456', '987612304');
INSERT INTO airport_scheme.passport_data VALUES (19, '2025-03-25', 19, 'SS7890', '472381654');
INSERT INTO airport_scheme.passport_data VALUES (20, '2025-04-25', 20, 'TT2345', '873654123');
INSERT INTO airport_scheme.passport_data VALUES (21, '2025-01-30', 21, 'UU6789', '654987321');
INSERT INTO airport_scheme.passport_data VALUES (22, '2025-02-28', 22, 'VV1234', '319876543');
INSERT INTO airport_scheme.passport_data VALUES (23, '2025-03-30', 23, 'WW5678', '928746531');
INSERT INTO airport_scheme.passport_data VALUES (24, '2025-04-30', 24, 'XX9012', '387564921');
INSERT INTO airport_scheme.passport_data VALUES (25, '2025-01-05', 25, 'YY3456', '245781936');
INSERT INTO airport_scheme.passport_data VALUES (26, '2025-02-05', 26, 'ZZ7890', '918276543');
INSERT INTO airport_scheme.passport_data VALUES (27, '2025-03-05', 27, 'AAA234', '543678921');
INSERT INTO airport_scheme.passport_data VALUES (28, '2025-04-05', 28, 'BBB567', '876521439');
INSERT INTO airport_scheme.passport_data VALUES (29, '2025-01-12', 29, 'CCC901', '654239875');
INSERT INTO airport_scheme.passport_data VALUES (30, '2025-02-12', 30, 'DDD345', '231867495');
INSERT INTO airport_scheme.passport_data VALUES (31, '2025-03-12', 31, 'EEE789', '126534987');
INSERT INTO airport_scheme.passport_data VALUES (32, '2025-04-12', 32, 'FFF123', '987654321');
INSERT INTO airport_scheme.passport_data VALUES (33, '2025-01-18', 33, 'GGG567', '125678943');
INSERT INTO airport_scheme.passport_data VALUES (34, '2025-02-18', 34, 'HHH901', '327594861');
INSERT INTO airport_scheme.passport_data VALUES (35, '2025-03-18', 35, 'III234', '126548379');
INSERT INTO airport_scheme.passport_data VALUES (36, '2025-04-18', 36, 'JJJ567', '987645231');
INSERT INTO airport_scheme.passport_data VALUES (37, '2025-01-22', 37, 'KKK901', '234598763');
INSERT INTO airport_scheme.passport_data VALUES (38, '2025-02-22', 38, 'LLL345', '978346251');
INSERT INTO airport_scheme.passport_data VALUES (39, '2025-03-22', 39, 'MMM789', '145978632');
INSERT INTO airport_scheme.passport_data VALUES (40, '2025-04-22', 40, 'NNN123', '654123789');


--
-- TOC entry 3720 (class 0 OID 16525)
-- Dependencies: 229
-- Data for Name: route; Type: TABLE DATA; Schema: airport_scheme; Owner: postgres
--

INSERT INTO airport_scheme.route VALUES (1, 1, 2);
INSERT INTO airport_scheme.route VALUES (2, 2, 3);
INSERT INTO airport_scheme.route VALUES (3, 3, 4);
INSERT INTO airport_scheme.route VALUES (4, 4, 5);
INSERT INTO airport_scheme.route VALUES (5, 5, 6);
INSERT INTO airport_scheme.route VALUES (6, 6, 7);
INSERT INTO airport_scheme.route VALUES (7, 7, 8);
INSERT INTO airport_scheme.route VALUES (8, 8, 9);
INSERT INTO airport_scheme.route VALUES (9, 9, 10);
INSERT INTO airport_scheme.route VALUES (10, 10, 11);
INSERT INTO airport_scheme.route VALUES (11, 11, 12);
INSERT INTO airport_scheme.route VALUES (12, 12, 13);
INSERT INTO airport_scheme.route VALUES (13, 13, 14);
INSERT INTO airport_scheme.route VALUES (14, 14, 15);
INSERT INTO airport_scheme.route VALUES (15, 15, 16);
INSERT INTO airport_scheme.route VALUES (16, 16, 17);
INSERT INTO airport_scheme.route VALUES (17, 17, 18);
INSERT INTO airport_scheme.route VALUES (18, 18, 19);
INSERT INTO airport_scheme.route VALUES (19, 19, 20);
INSERT INTO airport_scheme.route VALUES (20, 20, 21);
INSERT INTO airport_scheme.route VALUES (21, 21, 22);
INSERT INTO airport_scheme.route VALUES (22, 22, 23);
INSERT INTO airport_scheme.route VALUES (23, 23, 24);
INSERT INTO airport_scheme.route VALUES (24, 24, 25);
INSERT INTO airport_scheme.route VALUES (25, 25, 26);
INSERT INTO airport_scheme.route VALUES (26, 26, 27);
INSERT INTO airport_scheme.route VALUES (27, 27, 28);
INSERT INTO airport_scheme.route VALUES (28, 28, 29);
INSERT INTO airport_scheme.route VALUES (29, 29, 30);
INSERT INTO airport_scheme.route VALUES (30, 30, 31);
INSERT INTO airport_scheme.route VALUES (31, 31, 32);
INSERT INTO airport_scheme.route VALUES (32, 32, 33);
INSERT INTO airport_scheme.route VALUES (33, 33, 34);
INSERT INTO airport_scheme.route VALUES (34, 34, 35);
INSERT INTO airport_scheme.route VALUES (35, 35, 36);
INSERT INTO airport_scheme.route VALUES (36, 36, 37);
INSERT INTO airport_scheme.route VALUES (37, 37, 38);
INSERT INTO airport_scheme.route VALUES (38, 38, 39);
INSERT INTO airport_scheme.route VALUES (39, 39, 40);
INSERT INTO airport_scheme.route VALUES (40, 40, 1);


--
-- TOC entry 3719 (class 0 OID 16497)
-- Dependencies: 228
-- Data for Name: ticket; Type: TABLE DATA; Schema: airport_scheme; Owner: postgres
--

INSERT INTO airport_scheme.ticket VALUES (35, 'T12379', 'активен', '2025-04-16', 43, 'эконом', true, 14500, 35, 35, 35, 35);
INSERT INTO airport_scheme.ticket VALUES (36, 'T12380', 'отменен', '2025-04-14', 44, 'первый', false, 33000, 36, 36, 36, 36);
INSERT INTO airport_scheme.ticket VALUES (37, 'T12381', 'активен', '2025-04-15', 45, 'эконом', true, 16000, 37, 37, 37, 37);
INSERT INTO airport_scheme.ticket VALUES (38, 'T12382', 'использован', '2025-04-13', 46, 'бизнес', true, 29000, 38, 38, 38, 38);
INSERT INTO airport_scheme.ticket VALUES (39, 'T12383', 'активен', '2025-04-16', 47, 'эконом', false, 15000, 39, 39, 39, 39);
INSERT INTO airport_scheme.ticket VALUES (40, 'T12384', 'отменен', '2025-04-14', 48, 'первый', true, 34000, 40, 40, 40, 40);
INSERT INTO airport_scheme.ticket VALUES (1, 'T12345', 'активен', '2025-04-15', 12, 'эконом', true, 15000, 1, 1, 1, 1);
INSERT INTO airport_scheme.ticket VALUES (7, 'T12351', 'активен', '2025-04-17', 10, 'бизнес', false, 25000, 7, 7, 7, 7);
INSERT INTO airport_scheme.ticket VALUES (8, 'T12352', 'использован', '2025-04-13', 6, 'эконом', true, 13000, 8, 8, 8, 8);
INSERT INTO airport_scheme.ticket VALUES (9, 'T12353', 'активен', '2025-04-15', 15, 'первый', false, 32000, 9, 9, 9, 9);
INSERT INTO airport_scheme.ticket VALUES (10, 'T12354', 'отменен', '2025-04-14', 11, 'бизнес', true, 27000, 10, 10, 10, 10);
INSERT INTO airport_scheme.ticket VALUES (11, 'T12355', 'активен', '2025-04-16', 18, 'эконом', false, 16000, 11, 11, 11, 11);
INSERT INTO airport_scheme.ticket VALUES (12, 'T12356', 'активен', '2025-04-17', 20, 'первый', true, 35000, 12, 12, 12, 12);
INSERT INTO airport_scheme.ticket VALUES (13, 'T12357', 'использован', '2025-04-14', 21, 'эконом', false, 14000, 13, 13, 13, 13);
INSERT INTO airport_scheme.ticket VALUES (14, 'T12358', 'активен', '2025-04-15', 22, 'бизнес', true, 29000, 14, 14, 14, 14);
INSERT INTO airport_scheme.ticket VALUES (15, 'T12359', 'отменен', '2025-04-16', 23, 'эконом', true, 14500, 15, 15, 15, 15);
INSERT INTO airport_scheme.ticket VALUES (16, 'T12360', 'активен', '2025-04-17', 24, 'первый', false, 34000, 16, 16, 16, 16);
INSERT INTO airport_scheme.ticket VALUES (17, 'T12361', 'активен', '2025-04-15', 25, 'эконом', true, 15500, 17, 17, 17, 17);
INSERT INTO airport_scheme.ticket VALUES (18, 'T12362', 'использован', '2025-04-13', 26, 'бизнес', false, 26000, 18, 18, 18, 18);
INSERT INTO airport_scheme.ticket VALUES (19, 'T12363', 'активен', '2025-04-16', 27, 'эконом', true, 16000, 19, 19, 19, 19);
INSERT INTO airport_scheme.ticket VALUES (20, 'T12364', 'отменен', '2025-04-14', 28, 'первый', false, 33000, 20, 20, 20, 20);
INSERT INTO airport_scheme.ticket VALUES (21, 'T12365', 'активен', '2025-04-17', 29, 'эконом', true, 15000, 21, 21, 21, 21);
INSERT INTO airport_scheme.ticket VALUES (22, 'T12366', 'использован', '2025-04-15', 30, 'бизнес', true, 28000, 22, 22, 22, 22);
INSERT INTO airport_scheme.ticket VALUES (23, 'T12367', 'активен', '2025-04-17', 31, 'эконом', false, 14000, 23, 23, 23, 23);
INSERT INTO airport_scheme.ticket VALUES (24, 'T12368', 'отменен', '2025-04-14', 32, 'первый', true, 34000, 24, 24, 24, 24);
INSERT INTO airport_scheme.ticket VALUES (25, 'T12369', 'активен', '2025-04-15', 33, 'эконом', true, 15000, 25, 25, 25, 25);
INSERT INTO airport_scheme.ticket VALUES (26, 'T12370', 'использован', '2025-04-13', 34, 'бизнес', false, 29000, 26, 26, 26, 26);
INSERT INTO airport_scheme.ticket VALUES (27, 'T12371', 'активен', '2025-04-16', 35, 'эконом', true, 16000, 27, 27, 27, 27);
INSERT INTO airport_scheme.ticket VALUES (28, 'T12372', 'отменен', '2025-04-14', 36, 'первый', false, 35000, 28, 28, 28, 28);
INSERT INTO airport_scheme.ticket VALUES (29, 'T12373', 'активен', '2025-04-17', 37, 'эконом', true, 15000, 29, 29, 29, 29);
INSERT INTO airport_scheme.ticket VALUES (30, 'T12374', 'использован', '2025-04-15', 38, 'бизнес', true, 28000, 30, 30, 30, 30);
INSERT INTO airport_scheme.ticket VALUES (31, 'T12375', 'активен', '2025-04-16', 39, 'эконом', false, 15000, 31, 31, 31, 31);
INSERT INTO airport_scheme.ticket VALUES (32, 'T12376', 'отменен', '2025-04-14', 40, 'первый', true, 36000, 32, 32, 32, 32);
INSERT INTO airport_scheme.ticket VALUES (33, 'T12377', 'активен', '2025-04-17', 41, 'эконом', true, 15500, 33, 33, 33, 33);
INSERT INTO airport_scheme.ticket VALUES (34, 'T12378', 'использован', '2025-04-15', 42, 'бизнес', false, 27000, 34, 34, 34, 34);
INSERT INTO airport_scheme.ticket VALUES (2, 'T12346', 'активен', '2025-04-15', 14, 'бизнес', false, 30000, 2, 2, 2, 2);
INSERT INTO airport_scheme.ticket VALUES (3, 'T12347', 'активен', '2025-04-15', 5, 'эконом', true, 14000, 3, 3, 3, 3);
INSERT INTO airport_scheme.ticket VALUES (4, 'T12348', 'использован', '2025-04-14', 8, 'первый', true, 40000, 4, 4, 4, 4);
INSERT INTO airport_scheme.ticket VALUES (5, 'T12349', 'активен', '2025-04-16', 3, 'эконом', false, 12000, 5, 5, 5, 5);
INSERT INTO airport_scheme.ticket VALUES (6, 'T12350', 'отменен', '2025-04-15', 7, 'эконом', true, 13500, 6, 6, 6, 6);


--
-- TOC entry 3715 (class 0 OID 16458)
-- Dependencies: 224
-- Data for Name: transit_stop; Type: TABLE DATA; Schema: airport_scheme; Owner: postgres
--

INSERT INTO airport_scheme.transit_stop VALUES (1, 1, 1, 'транзит');
INSERT INTO airport_scheme.transit_stop VALUES (2, 2, 2, 'дозаправка');
INSERT INTO airport_scheme.transit_stop VALUES (3, 3, 3, 'аварийная');
INSERT INTO airport_scheme.transit_stop VALUES (4, 4, 4, 'транзит');
INSERT INTO airport_scheme.transit_stop VALUES (5, 5, 5, 'дозаправка');
INSERT INTO airport_scheme.transit_stop VALUES (6, 6, 6, 'аварийная');
INSERT INTO airport_scheme.transit_stop VALUES (7, 7, 7, 'транзит');
INSERT INTO airport_scheme.transit_stop VALUES (8, 8, 8, 'дозаправка');
INSERT INTO airport_scheme.transit_stop VALUES (9, 9, 9, 'аварийная');
INSERT INTO airport_scheme.transit_stop VALUES (10, 10, 10, 'транзит');
INSERT INTO airport_scheme.transit_stop VALUES (11, 11, 11, 'дозаправка');
INSERT INTO airport_scheme.transit_stop VALUES (12, 12, 12, 'аварийная');
INSERT INTO airport_scheme.transit_stop VALUES (13, 13, 13, 'транзит');
INSERT INTO airport_scheme.transit_stop VALUES (14, 14, 14, 'дозаправка');
INSERT INTO airport_scheme.transit_stop VALUES (15, 15, 15, 'аварийная');
INSERT INTO airport_scheme.transit_stop VALUES (16, 16, 16, 'транзит');
INSERT INTO airport_scheme.transit_stop VALUES (17, 17, 17, 'дозаправка');
INSERT INTO airport_scheme.transit_stop VALUES (18, 18, 18, 'аварийная');
INSERT INTO airport_scheme.transit_stop VALUES (19, 19, 19, 'транзит');
INSERT INTO airport_scheme.transit_stop VALUES (20, 20, 20, 'дозаправка');
INSERT INTO airport_scheme.transit_stop VALUES (21, 21, 21, 'аварийная');
INSERT INTO airport_scheme.transit_stop VALUES (22, 22, 22, 'транзит');
INSERT INTO airport_scheme.transit_stop VALUES (23, 23, 23, 'дозаправка');
INSERT INTO airport_scheme.transit_stop VALUES (24, 24, 24, 'аварийная');
INSERT INTO airport_scheme.transit_stop VALUES (25, 25, 25, 'транзит');
INSERT INTO airport_scheme.transit_stop VALUES (26, 26, 26, 'дозаправка');
INSERT INTO airport_scheme.transit_stop VALUES (27, 27, 27, 'аварийная');
INSERT INTO airport_scheme.transit_stop VALUES (28, 28, 28, 'транзит');
INSERT INTO airport_scheme.transit_stop VALUES (29, 29, 29, 'дозаправка');
INSERT INTO airport_scheme.transit_stop VALUES (30, 30, 30, 'аварийная');
INSERT INTO airport_scheme.transit_stop VALUES (31, 31, 31, 'транзит');
INSERT INTO airport_scheme.transit_stop VALUES (32, 32, 32, 'дозаправка');
INSERT INTO airport_scheme.transit_stop VALUES (33, 33, 33, 'аварийная');
INSERT INTO airport_scheme.transit_stop VALUES (34, 34, 34, 'транзит');
INSERT INTO airport_scheme.transit_stop VALUES (35, 35, 35, 'дозаправка');
INSERT INTO airport_scheme.transit_stop VALUES (36, 36, 36, 'аварийная');
INSERT INTO airport_scheme.transit_stop VALUES (37, 37, 37, 'транзит');
INSERT INTO airport_scheme.transit_stop VALUES (38, 38, 38, 'дозаправка');
INSERT INTO airport_scheme.transit_stop VALUES (39, 39, 39, 'аварийная');
INSERT INTO airport_scheme.transit_stop VALUES (40, 40, 40, 'транзит');


--
-- TOC entry 3511 (class 2606 OID 16562)
-- Name: route CHECK(depature_arrival); Type: CHECK CONSTRAINT; Schema: airport_scheme; Owner: postgres
--

ALTER TABLE airport_scheme.route
    ADD CONSTRAINT "CHECK(depature_arrival)" CHECK ((departure_airport_id <> arrival_airport_id)) NOT VALID;


--
-- TOC entry 3767 (class 0 OID 0)
-- Dependencies: 3511
-- Name: CONSTRAINT "CHECK(depature_arrival)" ON route; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON CONSTRAINT "CHECK(depature_arrival)" ON airport_scheme.route IS 'Аэропорты отправления и прибытия не совпадают';


--
-- TOC entry 3527 (class 2606 OID 16450)
-- Name: aircraft aircraft_pkey; Type: CONSTRAINT; Schema: airport_scheme; Owner: postgres
--

ALTER TABLE ONLY airport_scheme.aircraft
    ADD CONSTRAINT aircraft_pkey PRIMARY KEY (aircraft_id);


--
-- TOC entry 3549 (class 2606 OID 16741)
-- Name: airline airline_pkey; Type: CONSTRAINT; Schema: airport_scheme; Owner: postgres
--

ALTER TABLE ONLY airport_scheme.airline
    ADD CONSTRAINT airline_pkey PRIMARY KEY (airline_id);


--
-- TOC entry 3521 (class 2606 OID 16420)
-- Name: airport airport_pkey; Type: CONSTRAINT; Schema: airport_scheme; Owner: postgres
--

ALTER TABLE ONLY airport_scheme.airport
    ADD CONSTRAINT airport_pkey PRIMARY KEY (airport_id);


--
-- TOC entry 3529 (class 2606 OID 16452)
-- Name: aircraft board_numder_unique; Type: CONSTRAINT; Schema: airport_scheme; Owner: postgres
--

ALTER TABLE ONLY airport_scheme.aircraft
    ADD CONSTRAINT board_numder_unique UNIQUE (board_number);


--
-- TOC entry 3537 (class 2606 OID 16494)
-- Name: cash_desk cash_desk_pkey; Type: CONSTRAINT; Schema: airport_scheme; Owner: postgres
--

ALTER TABLE ONLY airport_scheme.cash_desk
    ADD CONSTRAINT cash_desk_pkey PRIMARY KEY (cashdesk_id);


--
-- TOC entry 3503 (class 2606 OID 16566)
-- Name: flight correct_type_flight; Type: CHECK CONSTRAINT; Schema: airport_scheme; Owner: postgres
--

ALTER TABLE airport_scheme.flight
    ADD CONSTRAINT correct_type_flight CHECK (((flight_type)::text = ANY ((ARRAY['Международный'::character varying, 'Внутренний'::character varying, 'Чартерный'::character varying])::text[]))) NOT VALID;


--
-- TOC entry 3768 (class 0 OID 0)
-- Dependencies: 3503
-- Name: CONSTRAINT correct_type_flight ON flight; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON CONSTRAINT correct_type_flight ON airport_scheme.flight IS 'Проверяет корректность типа рейса (международный, внутренний, чартерный).';


--
-- TOC entry 3517 (class 2606 OID 16410)
-- Name: crew crew_pkey; Type: CONSTRAINT; Schema: airport_scheme; Owner: postgres
--

ALTER TABLE ONLY airport_scheme.crew
    ADD CONSTRAINT crew_pkey PRIMARY KEY (crew_id);


--
-- TOC entry 3513 (class 2606 OID 16394)
-- Name: employee employee_pkey; Type: CONSTRAINT; Schema: airport_scheme; Owner: postgres
--

ALTER TABLE ONLY airport_scheme.employee
    ADD CONSTRAINT employee_pkey PRIMARY KEY (employee_id);


--
-- TOC entry 3523 (class 2606 OID 16435)
-- Name: flight flight_pkey; Type: CONSTRAINT; Schema: airport_scheme; Owner: postgres
--

ALTER TABLE ONLY airport_scheme.flight
    ADD CONSTRAINT flight_pkey PRIMARY KEY (flight_id);


--
-- TOC entry 3515 (class 2606 OID 16399)
-- Name: medical_exam medical_exam_pkey; Type: CONSTRAINT; Schema: airport_scheme; Owner: postgres
--

ALTER TABLE ONLY airport_scheme.medical_exam
    ADD CONSTRAINT medical_exam_pkey PRIMARY KEY (medical_exam_id);


--
-- TOC entry 3519 (class 2606 OID 16561)
-- Name: crew not_double_employee_on_flight; Type: CONSTRAINT; Schema: airport_scheme; Owner: postgres
--

ALTER TABLE ONLY airport_scheme.crew
    ADD CONSTRAINT not_double_employee_on_flight UNIQUE (employee_id, flight_id);


--
-- TOC entry 3769 (class 0 OID 0)
-- Dependencies: 3519
-- Name: CONSTRAINT not_double_employee_on_flight ON crew; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON CONSTRAINT not_double_employee_on_flight ON airport_scheme.crew IS 'Запрещает назначать сотрудника на один рейс несколько раз';


--
-- TOC entry 3539 (class 2606 OID 16496)
-- Name: cash_desk number_cash_desk; Type: CONSTRAINT; Schema: airport_scheme; Owner: postgres
--

ALTER TABLE ONLY airport_scheme.cash_desk
    ADD CONSTRAINT number_cash_desk UNIQUE (cashdesk_number);


--
-- TOC entry 3533 (class 2606 OID 16477)
-- Name: passenger passenger_pkey; Type: CONSTRAINT; Schema: airport_scheme; Owner: postgres
--

ALTER TABLE ONLY airport_scheme.passenger
    ADD CONSTRAINT passenger_pkey PRIMARY KEY (passenger_id);


--
-- TOC entry 3535 (class 2606 OID 16482)
-- Name: passport_data passport_data_pkey; Type: CONSTRAINT; Schema: airport_scheme; Owner: postgres
--

ALTER TABLE ONLY airport_scheme.passport_data
    ADD CONSTRAINT passport_data_pkey PRIMARY KEY (passport_data_id);


--
-- TOC entry 3545 (class 2606 OID 16529)
-- Name: route route_pkey; Type: CONSTRAINT; Schema: airport_scheme; Owner: postgres
--

ALTER TABLE ONLY airport_scheme.route
    ADD CONSTRAINT route_pkey PRIMARY KEY (route_id);


--
-- TOC entry 3501 (class 2606 OID 16569)
-- Name: medical_exam status_check; Type: CHECK CONSTRAINT; Schema: airport_scheme; Owner: postgres
--

ALTER TABLE airport_scheme.medical_exam
    ADD CONSTRAINT status_check CHECK (((status)::text = ANY ((ARRAY['пройден'::character varying, 'не пройден'::character varying, 'в ожидании'::character varying])::text[]))) NOT VALID;


--
-- TOC entry 3507 (class 2606 OID 16570)
-- Name: transit_stop stop_type_check; Type: CHECK CONSTRAINT; Schema: airport_scheme; Owner: postgres
--

ALTER TABLE airport_scheme.transit_stop
    ADD CONSTRAINT stop_type_check CHECK (((stop_type)::text = ANY ((ARRAY['транзит'::character varying, 'дозаправка'::character varying, 'аварийная'::character varying])::text[]))) NOT VALID;


--
-- TOC entry 3770 (class 0 OID 0)
-- Dependencies: 3507
-- Name: CONSTRAINT stop_type_check ON transit_stop; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON CONSTRAINT stop_type_check ON airport_scheme.transit_stop IS 'правильность заполнения поля';


--
-- TOC entry 3541 (class 2606 OID 16504)
-- Name: ticket ticket_number_unique; Type: CONSTRAINT; Schema: airport_scheme; Owner: postgres
--

ALTER TABLE ONLY airport_scheme.ticket
    ADD CONSTRAINT ticket_number_unique UNIQUE (ticket_number);


--
-- TOC entry 3543 (class 2606 OID 16502)
-- Name: ticket ticket_pkey; Type: CONSTRAINT; Schema: airport_scheme; Owner: postgres
--

ALTER TABLE ONLY airport_scheme.ticket
    ADD CONSTRAINT ticket_pkey PRIMARY KEY (ticket_id);


--
-- TOC entry 3531 (class 2606 OID 16462)
-- Name: transit_stop transit_stop_pkey; Type: CONSTRAINT; Schema: airport_scheme; Owner: postgres
--

ALTER TABLE ONLY airport_scheme.transit_stop
    ADD CONSTRAINT transit_stop_pkey PRIMARY KEY (transit_stop_id);


--
-- TOC entry 3525 (class 2606 OID 16576)
-- Name: flight unique_flight; Type: CONSTRAINT; Schema: airport_scheme; Owner: postgres
--

ALTER TABLE ONLY airport_scheme.flight
    ADD CONSTRAINT unique_flight UNIQUE (flight_number, departure_date);


--
-- TOC entry 3547 (class 2606 OID 16565)
-- Name: route unique_ways; Type: CONSTRAINT; Schema: airport_scheme; Owner: postgres
--

ALTER TABLE ONLY airport_scheme.route
    ADD CONSTRAINT unique_ways UNIQUE (departure_airport_id, arrival_airport_id);


--
-- TOC entry 3771 (class 0 OID 0)
-- Dependencies: 3547
-- Name: CONSTRAINT unique_ways ON route; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON CONSTRAINT unique_ways ON airport_scheme.route IS 'Уникальность комбинации аэропортов отправления и прибытия';


--
-- TOC entry 3509 (class 2606 OID 16567)
-- Name: ticket valid_class; Type: CHECK CONSTRAINT; Schema: airport_scheme; Owner: postgres
--

ALTER TABLE airport_scheme.ticket
    ADD CONSTRAINT valid_class CHECK (((class_of_service)::text = ANY ((ARRAY['эконом'::character varying, 'бизнес'::character varying, 'первый'::character varying])::text[]))) NOT VALID;


--
-- TOC entry 3772 (class 0 OID 0)
-- Dependencies: 3509
-- Name: CONSTRAINT valid_class ON ticket; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON CONSTRAINT valid_class ON airport_scheme.ticket IS 'Допустимые классы обслуживания: эконом, бизнес, первый';


--
-- TOC entry 3504 (class 2606 OID 16573)
-- Name: aircraft valid_fuel; Type: CHECK CONSTRAINT; Schema: airport_scheme; Owner: postgres
--

ALTER TABLE airport_scheme.aircraft
    ADD CONSTRAINT valid_fuel CHECK ((fuel_consumption > (0)::numeric)) NOT VALID;


--
-- TOC entry 3502 (class 2606 OID 16571)
-- Name: medical_exam valid_medical_date; Type: CHECK CONSTRAINT; Schema: airport_scheme; Owner: postgres
--

ALTER TABLE airport_scheme.medical_exam
    ADD CONSTRAINT valid_medical_date CHECK ((exam_date <= CURRENT_DATE)) NOT VALID;


--
-- TOC entry 3505 (class 2606 OID 16574)
-- Name: aircraft valid_seats; Type: CHECK CONSTRAINT; Schema: airport_scheme; Owner: postgres
--

ALTER TABLE airport_scheme.aircraft
    ADD CONSTRAINT valid_seats CHECK ((seat_capacity > 0)) NOT VALID;


--
-- TOC entry 3506 (class 2606 OID 16572)
-- Name: aircraft valid_speed; Type: CHECK CONSTRAINT; Schema: airport_scheme; Owner: postgres
--

ALTER TABLE airport_scheme.aircraft
    ADD CONSTRAINT valid_speed CHECK ((speed > 0)) NOT VALID;


--
-- TOC entry 3510 (class 2606 OID 16568)
-- Name: ticket valid_status; Type: CHECK CONSTRAINT; Schema: airport_scheme; Owner: postgres
--

ALTER TABLE airport_scheme.ticket
    ADD CONSTRAINT valid_status CHECK (((ticket_status)::text = ANY ((ARRAY['активен'::character varying, 'использован'::character varying, 'отменен'::character varying, 'просрочен'::character varying])::text[]))) NOT VALID;


--
-- TOC entry 3773 (class 0 OID 0)
-- Dependencies: 3510
-- Name: CONSTRAINT valid_status ON ticket; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON CONSTRAINT valid_status ON airport_scheme.ticket IS 'Допустимые статусы билетов: активен, использован, отменен, просрочен.';


--
-- TOC entry 3553 (class 2606 OID 16453)
-- Name: flight aircraft_id_fk; Type: FK CONSTRAINT; Schema: airport_scheme; Owner: postgres
--

ALTER TABLE ONLY airport_scheme.flight
    ADD CONSTRAINT aircraft_id_fk FOREIGN KEY (aircraft_id) REFERENCES airport_scheme.aircraft(aircraft_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3774 (class 0 OID 0)
-- Dependencies: 3553
-- Name: CONSTRAINT aircraft_id_fk ON flight; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON CONSTRAINT aircraft_id_fk ON airport_scheme.flight IS 'Связь с воздушным судном из таблицы aircraft.';


--
-- TOC entry 3555 (class 2606 OID 16743)
-- Name: aircraft airline_id_fk; Type: FK CONSTRAINT; Schema: airport_scheme; Owner: postgres
--

ALTER TABLE ONLY airport_scheme.aircraft
    ADD CONSTRAINT airline_id_fk FOREIGN KEY (airline_id) REFERENCES airport_scheme.airline(airline_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3556 (class 2606 OID 16468)
-- Name: transit_stop airport_id_fk; Type: FK CONSTRAINT; Schema: airport_scheme; Owner: postgres
--

ALTER TABLE ONLY airport_scheme.transit_stop
    ADD CONSTRAINT airport_id_fk FOREIGN KEY (airport_id) REFERENCES airport_scheme.airport(airport_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3775 (class 0 OID 0)
-- Dependencies: 3556
-- Name: CONSTRAINT airport_id_fk ON transit_stop; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON CONSTRAINT airport_id_fk ON airport_scheme.transit_stop IS 'Связывает транзитную остановку с аэропортом из таблицы airport';


--
-- TOC entry 3562 (class 2606 OID 16535)
-- Name: route arrival_airport_fk; Type: FK CONSTRAINT; Schema: airport_scheme; Owner: postgres
--

ALTER TABLE ONLY airport_scheme.route
    ADD CONSTRAINT arrival_airport_fk FOREIGN KEY (arrival_airport_id) REFERENCES airport_scheme.airport(airport_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3776 (class 0 OID 0)
-- Dependencies: 3562
-- Name: CONSTRAINT arrival_airport_fk ON route; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON CONSTRAINT arrival_airport_fk ON airport_scheme.route IS 'Указывает аэропорт прибытия из таблицы airport';


--
-- TOC entry 3559 (class 2606 OID 16751)
-- Name: ticket cashdesk_id_fk; Type: FK CONSTRAINT; Schema: airport_scheme; Owner: postgres
--

ALTER TABLE ONLY airport_scheme.ticket
    ADD CONSTRAINT cashdesk_id_fk FOREIGN KEY (cashdesk_id) REFERENCES airport_scheme.cash_desk(cashdesk_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3563 (class 2606 OID 16530)
-- Name: route departure_airport_fk; Type: FK CONSTRAINT; Schema: airport_scheme; Owner: postgres
--

ALTER TABLE ONLY airport_scheme.route
    ADD CONSTRAINT departure_airport_fk FOREIGN KEY (departure_airport_id) REFERENCES airport_scheme.airport(airport_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3777 (class 0 OID 0)
-- Dependencies: 3563
-- Name: CONSTRAINT departure_airport_fk ON route; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON CONSTRAINT departure_airport_fk ON airport_scheme.route IS 'Указывает аэропорт отправления из таблицы airport';


--
-- TOC entry 3550 (class 2606 OID 16400)
-- Name: medical_exam employee_id_fk; Type: FK CONSTRAINT; Schema: airport_scheme; Owner: postgres
--

ALTER TABLE ONLY airport_scheme.medical_exam
    ADD CONSTRAINT employee_id_fk FOREIGN KEY (employee_id) REFERENCES airport_scheme.employee(employee_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3778 (class 0 OID 0)
-- Dependencies: 3550
-- Name: CONSTRAINT employee_id_fk ON medical_exam; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON CONSTRAINT employee_id_fk ON airport_scheme.medical_exam IS 'Связывает медосмотр с сотрудником из таблицы employee';


--
-- TOC entry 3551 (class 2606 OID 16411)
-- Name: crew employee_id_fk; Type: FK CONSTRAINT; Schema: airport_scheme; Owner: postgres
--

ALTER TABLE ONLY airport_scheme.crew
    ADD CONSTRAINT employee_id_fk FOREIGN KEY (employee_id) REFERENCES airport_scheme.employee(employee_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3779 (class 0 OID 0)
-- Dependencies: 3551
-- Name: CONSTRAINT employee_id_fk ON crew; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON CONSTRAINT employee_id_fk ON airport_scheme.crew IS 'Связь с сотрудником из таблицы employee.';


--
-- TOC entry 3557 (class 2606 OID 16463)
-- Name: transit_stop flight_id_fk; Type: FK CONSTRAINT; Schema: airport_scheme; Owner: postgres
--

ALTER TABLE ONLY airport_scheme.transit_stop
    ADD CONSTRAINT flight_id_fk FOREIGN KEY (flight_id) REFERENCES airport_scheme.flight(flight_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3780 (class 0 OID 0)
-- Dependencies: 3557
-- Name: CONSTRAINT flight_id_fk ON transit_stop; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON CONSTRAINT flight_id_fk ON airport_scheme.transit_stop IS 'Связывает транзитную остановку с рейсом из таблицы flight';


--
-- TOC entry 3560 (class 2606 OID 16510)
-- Name: ticket flight_id_fk; Type: FK CONSTRAINT; Schema: airport_scheme; Owner: postgres
--

ALTER TABLE ONLY airport_scheme.ticket
    ADD CONSTRAINT flight_id_fk FOREIGN KEY (flight_id) REFERENCES airport_scheme.flight(flight_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3781 (class 0 OID 0)
-- Dependencies: 3560
-- Name: CONSTRAINT flight_id_fk ON ticket; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON CONSTRAINT flight_id_fk ON airport_scheme.ticket IS 'Связывает билет с рейсом из таблицы flight';


--
-- TOC entry 3552 (class 2606 OID 16520)
-- Name: crew flight_id_fk; Type: FK CONSTRAINT; Schema: airport_scheme; Owner: postgres
--

ALTER TABLE ONLY airport_scheme.crew
    ADD CONSTRAINT flight_id_fk FOREIGN KEY (flight_id) REFERENCES airport_scheme.flight(flight_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3782 (class 0 OID 0)
-- Dependencies: 3552
-- Name: CONSTRAINT flight_id_fk ON crew; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON CONSTRAINT flight_id_fk ON airport_scheme.crew IS 'Связывает экипаж с рейсом из таблицы flight';


--
-- TOC entry 3558 (class 2606 OID 16485)
-- Name: passport_data passenger_id_fk; Type: FK CONSTRAINT; Schema: airport_scheme; Owner: postgres
--

ALTER TABLE ONLY airport_scheme.passport_data
    ADD CONSTRAINT passenger_id_fk FOREIGN KEY (passenger_id) REFERENCES airport_scheme.passenger(passenger_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3783 (class 0 OID 0)
-- Dependencies: 3558
-- Name: CONSTRAINT passenger_id_fk ON passport_data; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON CONSTRAINT passenger_id_fk ON airport_scheme.passport_data IS 'Связывает паспортные данные с пассажиром из таблицы passenger';


--
-- TOC entry 3561 (class 2606 OID 16757)
-- Name: ticket passport_data_id_fk; Type: FK CONSTRAINT; Schema: airport_scheme; Owner: postgres
--

ALTER TABLE ONLY airport_scheme.ticket
    ADD CONSTRAINT passport_data_id_fk FOREIGN KEY (passport_data_id) REFERENCES airport_scheme.passport_data(passport_data_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3554 (class 2606 OID 16540)
-- Name: flight route_id_fk; Type: FK CONSTRAINT; Schema: airport_scheme; Owner: postgres
--

ALTER TABLE ONLY airport_scheme.flight
    ADD CONSTRAINT route_id_fk FOREIGN KEY (route_id) REFERENCES airport_scheme.route(route_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3784 (class 0 OID 0)
-- Dependencies: 3554
-- Name: CONSTRAINT route_id_fk ON flight; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON CONSTRAINT route_id_fk ON airport_scheme.flight IS 'Связь с маршрутом из таблицы route.';


-- Completed on 2025-04-17 15:25:38 MSK

--
-- PostgreSQL database dump complete
--

