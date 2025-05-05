--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4
-- Dumped by pg_dump version 17.0

-- Started on 2025-05-05 01:00:28 MSK

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
-- TOC entry 6 (class 2615 OID 16552)
-- Name: airport_scheme; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA airport_scheme;


ALTER SCHEMA airport_scheme OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 218 (class 1259 OID 16553)
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
-- TOC entry 3727 (class 0 OID 0)
-- Dependencies: 218
-- Name: TABLE aircraft; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON TABLE airport_scheme.aircraft IS 'Содержит технические характеристики воздушных судов.';


--
-- TOC entry 3728 (class 0 OID 0)
-- Dependencies: 218
-- Name: COLUMN aircraft.board_number; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON COLUMN airport_scheme.aircraft.board_number IS 'Бортовой номер воздушного судна.';


--
-- TOC entry 3729 (class 0 OID 0)
-- Dependencies: 218
-- Name: COLUMN aircraft.manufacturer; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON COLUMN airport_scheme.aircraft.manufacturer IS 'производитель';


--
-- TOC entry 3730 (class 0 OID 0)
-- Dependencies: 218
-- Name: COLUMN aircraft.model; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON COLUMN airport_scheme.aircraft.model IS 'модель';


--
-- TOC entry 3731 (class 0 OID 0)
-- Dependencies: 218
-- Name: COLUMN aircraft.production_year; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON COLUMN airport_scheme.aircraft.production_year IS 'год производства ';


--
-- TOC entry 3732 (class 0 OID 0)
-- Dependencies: 218
-- Name: COLUMN aircraft.last_maintenance_date; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON COLUMN airport_scheme.aircraft.last_maintenance_date IS 'дата последнего тех. осмотра';


--
-- TOC entry 3733 (class 0 OID 0)
-- Dependencies: 218
-- Name: COLUMN aircraft.speed; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON COLUMN airport_scheme.aircraft.speed IS 'полетная скорость км/ч';


--
-- TOC entry 3734 (class 0 OID 0)
-- Dependencies: 218
-- Name: COLUMN aircraft.fuel_consumption; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON COLUMN airport_scheme.aircraft.fuel_consumption IS 'расход топлива в литрах на км';


--
-- TOC entry 3735 (class 0 OID 0)
-- Dependencies: 218
-- Name: COLUMN aircraft.seat_capacity; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON COLUMN airport_scheme.aircraft.seat_capacity IS 'вместимость, шт';


--
-- TOC entry 3736 (class 0 OID 0)
-- Dependencies: 218
-- Name: COLUMN aircraft.flight_hours; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON COLUMN airport_scheme.aircraft.flight_hours IS 'налет в часах';


--
-- TOC entry 3737 (class 0 OID 0)
-- Dependencies: 218
-- Name: COLUMN aircraft.payload; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON COLUMN airport_scheme.aircraft.payload IS 'грузоподъемность, кг';


--
-- TOC entry 219 (class 1259 OID 16556)
-- Name: airline; Type: TABLE; Schema: airport_scheme; Owner: postgres
--

CREATE TABLE airport_scheme.airline (
    airline_id integer NOT NULL,
    airline_name character varying(20) NOT NULL
);


ALTER TABLE airport_scheme.airline OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16559)
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
-- TOC entry 3738 (class 0 OID 0)
-- Dependencies: 220
-- Name: TABLE airport; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON TABLE airport_scheme.airport IS 'Список аэропортов с их локациями и кодами ICAO.';


--
-- TOC entry 3739 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN airport.city; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON COLUMN airport_scheme.airport.city IS 'Город аэропорта';


--
-- TOC entry 3740 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN airport.code_isao; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON COLUMN airport_scheme.airport.code_isao IS 'Код аэропорта по стандарту ICAO (4 символа)';


--
-- TOC entry 3741 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN airport.country; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON COLUMN airport_scheme.airport.country IS 'страна аэропорта';


--
-- TOC entry 221 (class 1259 OID 16562)
-- Name: cash_desk; Type: TABLE; Schema: airport_scheme; Owner: postgres
--

CREATE TABLE airport_scheme.cash_desk (
    cashdesk_id integer NOT NULL,
    cashdesk_number integer NOT NULL,
    is_online boolean NOT NULL
);


ALTER TABLE airport_scheme.cash_desk OWNER TO postgres;

--
-- TOC entry 3742 (class 0 OID 0)
-- Dependencies: 221
-- Name: TABLE cash_desk; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON TABLE airport_scheme.cash_desk IS 'Информация о кассах продажи билетов (онлайн/оффлайн).';


--
-- TOC entry 3743 (class 0 OID 0)
-- Dependencies: 221
-- Name: COLUMN cash_desk.cashdesk_number; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON COLUMN airport_scheme.cash_desk.cashdesk_number IS 'номер кассы';


--
-- TOC entry 3744 (class 0 OID 0)
-- Dependencies: 221
-- Name: COLUMN cash_desk.is_online; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON COLUMN airport_scheme.cash_desk.is_online IS 'онлайн или офлайн касса';


--
-- TOC entry 222 (class 1259 OID 16565)
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
-- TOC entry 3745 (class 0 OID 0)
-- Dependencies: 222
-- Name: TABLE crew; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON TABLE airport_scheme.crew IS 'Связывает сотрудников с рейсами и указывает их роль в экипаже.';


--
-- TOC entry 3746 (class 0 OID 0)
-- Dependencies: 222
-- Name: COLUMN crew.role; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON COLUMN airport_scheme.crew.role IS 'роль сотрудника на рейсе';


--
-- TOC entry 223 (class 1259 OID 16569)
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
-- TOC entry 3747 (class 0 OID 0)
-- Dependencies: 223
-- Name: TABLE employee; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON TABLE airport_scheme.employee IS 'Данные о сотрудниках компании (ФИО, должность, медосмотры).';


--
-- TOC entry 3748 (class 0 OID 0)
-- Dependencies: 223
-- Name: COLUMN employee.medical_exam_date; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON COLUMN airport_scheme.employee.medical_exam_date IS 'Дата последнего медицинского осмотра сотрудника.';


--
-- TOC entry 3749 (class 0 OID 0)
-- Dependencies: 223
-- Name: COLUMN employee."position"; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON COLUMN airport_scheme.employee."position" IS 'должность сотрудника';


--
-- TOC entry 224 (class 1259 OID 16572)
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
-- TOC entry 3750 (class 0 OID 0)
-- Dependencies: 224
-- Name: TABLE flight; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON TABLE airport_scheme.flight IS 'Расписание и параметры рейсов (дата, время, тип, воздушное судно).';


--
-- TOC entry 3751 (class 0 OID 0)
-- Dependencies: 224
-- Name: COLUMN flight.flight_number; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON COLUMN airport_scheme.flight.flight_number IS 'Бизнес-номер рейса, присвоенный авиакомпанией (например, 100, 200). Используется в расписаниях и билетах. Может повторяться для разных дат вылета';


--
-- TOC entry 3752 (class 0 OID 0)
-- Dependencies: 224
-- Name: COLUMN flight.flight_type; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON COLUMN airport_scheme.flight.flight_type IS 'Тип рейса: международный, внутренний, чартерный.';


--
-- TOC entry 225 (class 1259 OID 16575)
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
-- TOC entry 3753 (class 0 OID 0)
-- Dependencies: 225
-- Name: TABLE medical_exam; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON TABLE airport_scheme.medical_exam IS 'Результаты медицинских осмотров сотрудников.';


--
-- TOC entry 3754 (class 0 OID 0)
-- Dependencies: 225
-- Name: COLUMN medical_exam.status; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON COLUMN airport_scheme.medical_exam.status IS 'Статус прохождения медосмотра: пройден, не пройден, в ожидании';


--
-- TOC entry 226 (class 1259 OID 16578)
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
-- TOC entry 3755 (class 0 OID 0)
-- Dependencies: 226
-- Name: TABLE passenger; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON TABLE airport_scheme.passenger IS 'Информация о пассажирах (ФИО, статус регистрации).';


--
-- TOC entry 227 (class 1259 OID 16581)
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
-- TOC entry 3756 (class 0 OID 0)
-- Dependencies: 227
-- Name: TABLE passport_data; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON TABLE airport_scheme.passport_data IS 'Паспортные данные пассажиров.';


--
-- TOC entry 228 (class 1259 OID 16584)
-- Name: route; Type: TABLE; Schema: airport_scheme; Owner: postgres
--

CREATE TABLE airport_scheme.route (
    route_id integer NOT NULL,
    departure_airport_id integer NOT NULL,
    arrival_airport_id integer NOT NULL
);


ALTER TABLE airport_scheme.route OWNER TO postgres;

--
-- TOC entry 3757 (class 0 OID 0)
-- Dependencies: 228
-- Name: TABLE route; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON TABLE airport_scheme.route IS 'Маршруты рейсов (аэропорты отправления и прибытия).';


--
-- TOC entry 229 (class 1259 OID 16587)
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
-- TOC entry 3758 (class 0 OID 0)
-- Dependencies: 229
-- Name: TABLE ticket; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON TABLE airport_scheme.ticket IS 'Данные о билетах (статус, класс, цена, место).';


--
-- TOC entry 3759 (class 0 OID 0)
-- Dependencies: 229
-- Name: COLUMN ticket.ticket_status; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON COLUMN airport_scheme.ticket.ticket_status IS 'Статус билета: активен, использован, отменен, просрочен';


--
-- TOC entry 3760 (class 0 OID 0)
-- Dependencies: 229
-- Name: COLUMN ticket.purchase_date; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON COLUMN airport_scheme.ticket.purchase_date IS 'дата покупки билета';


--
-- TOC entry 3761 (class 0 OID 0)
-- Dependencies: 229
-- Name: COLUMN ticket.class_of_service; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON COLUMN airport_scheme.ticket.class_of_service IS 'Класс обслуживания: эконом, бизнес, первый';


--
-- TOC entry 3762 (class 0 OID 0)
-- Dependencies: 229
-- Name: COLUMN ticket.baggage_insurance; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON COLUMN airport_scheme.ticket.baggage_insurance IS 'наличие багажа';


--
-- TOC entry 3763 (class 0 OID 0)
-- Dependencies: 229
-- Name: CONSTRAINT right_price ON ticket; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON CONSTRAINT right_price ON airport_scheme.ticket IS 'Цена билета должна быть больше 0.';


--
-- TOC entry 230 (class 1259 OID 16593)
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
-- TOC entry 3764 (class 0 OID 0)
-- Dependencies: 230
-- Name: TABLE transit_stop; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON TABLE airport_scheme.transit_stop IS 'Промежуточные остановки рейсов (транзит, дозаправка, аварийные).';


--
-- TOC entry 3765 (class 0 OID 0)
-- Dependencies: 230
-- Name: COLUMN transit_stop.stop_type; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON COLUMN airport_scheme.transit_stop.stop_type IS 'Тип остановки: транзит, дозаправка, аварийная.';


--
-- TOC entry 3709 (class 0 OID 16553)
-- Dependencies: 218
-- Data for Name: aircraft; Type: TABLE DATA; Schema: airport_scheme; Owner: postgres
--

COPY airport_scheme.aircraft (aircraft_id, board_number, manufacturer, model, production_year, last_maintenance_date, speed, fuel_consumption, seat_capacity, flight_hours, payload, airline_id) FROM stdin;
1	A123	Airbus	A320	2015	2024-12-01	800	5.000	180	5000	20000	1
2	B456	Boeing	737	2018	2025-03-15	850	4.800	150	6000	21000	1
3	C789	Airbus	A330	2020	2025-01-10	900	6.000	200	4000	22000	1
4	D012	Boeing	747	2012	2024-11-20	950	7.000	300	8000	25000	1
5	E345	Lockheed	L-1011	2005	2025-02-05	750	4.500	180	12000	22000	1
6	F678	Cessna	Citation X	2017	2025-01-15	850	4.200	80	4500	15000	1
7	G901	Airbus	A320	2013	2024-10-10	820	5.300	150	5500	20000	1
8	H234	Boeing	737	2019	2025-02-25	870	4.700	180	6000	21000	1
9	I567	Lockheed	L-1011	2016	2025-03-01	800	5.000	160	5500	21000	1
10	J890	Cessna	Citation X	2014	2025-01-01	830	4.600	100	4700	16000	1
11	K123	Airbus	A330	2021	2025-03-10	950	6.500	220	4000	24000	1
12	L456	Boeing	747	2018	2025-02-28	980	7.100	350	7500	27000	1
13	M789	Lockheed	L-1011	2015	2025-03-12	780	4.900	190	5400	23000	1
14	N012	Cessna	Citation X	2020	2025-02-20	840	4.800	120	4600	17000	1
15	O345	Airbus	A320	2012	2024-11-01	810	5.100	160	5000	21000	1
16	P678	Boeing	737	2020	2025-03-05	860	4.900	170	5800	21500	1
17	Q901	Lockheed	L-1011	2017	2025-01-08	800	5.200	180	5200	22000	1
18	R234	Cessna	Citation X	2016	2025-02-22	830	4.400	90	4800	16000	1
19	S567	Airbus	A330	2022	2025-03-08	950	6.600	210	4200	23000	1
20	T890	Boeing	747	2019	2025-01-25	970	7.200	320	8000	25000	1
21	U123	Lockheed	L-1011	2014	2025-02-15	770	5.100	200	5100	21000	1
22	V456	Cessna	Citation X	2018	2025-01-30	860	4.500	110	4600	15000	1
23	W789	Airbus	A320	2015	2025-03-03	800	5.200	150	5200	20000	1
24	X012	Boeing	737	2017	2025-02-18	850	4.600	160	5700	21000	1
25	Y345	Lockheed	L-1011	2016	2025-03-04	790	5.000	190	5300	22000	1
26	Z678	Cessna	Citation X	2019	2025-01-18	830	4.700	120	4900	16000	1
27	A901	Airbus	A330	2021	2025-03-07	940	6.300	230	4300	24000	1
28	B234	Boeing	747	2020	2025-02-27	960	7.000	330	7800	26000	1
29	C567	Lockheed	L-1011	2017	2025-01-20	790	5.300	170	5400	23000	1
30	D890	Cessna	Citation X	2015	2025-02-05	840	4.900	130	4700	17000	1
31	E123	Airbus	A320	2018	2025-01-13	810	5.400	160	5300	21000	1
32	F456	Boeing	737	2016	2025-02-12	860	5.100	150	5500	21500	1
33	G789	Lockheed	L-1011	2021	2025-03-11	770	5.200	190	5200	22000	1
34	H012	Cessna	Citation X	2020	2025-01-22	830	4.600	140	4800	16000	1
35	I345	Airbus	A320	2020	2025-02-28	800	5.000	150	5600	21000	1
36	J678	Boeing	737	2015	2025-03-06	850	4.800	170	6000	22000	1
37	K901	Lockheed	L-1011	2014	2025-03-02	800	5.100	160	5100	21000	1
38	L234	Cessna	Citation X	2018	2025-02-10	830	4.400	110	4900	15000	1
39	M567	Airbus	A330	2022	2025-03-09	960	6.800	240	4400	25000	1
40	N890	Boeing	747	2019	2025-01-29	970	7.300	330	7900	27000	1
\.


--
-- TOC entry 3710 (class 0 OID 16556)
-- Dependencies: 219
-- Data for Name: airline; Type: TABLE DATA; Schema: airport_scheme; Owner: postgres
--

COPY airport_scheme.airline (airline_id, airline_name) FROM stdin;
1	Aeroflt
2	SYBYR
\.


--
-- TOC entry 3711 (class 0 OID 16559)
-- Dependencies: 220
-- Data for Name: airport; Type: TABLE DATA; Schema: airport_scheme; Owner: postgres
--

COPY airport_scheme.airport (airport_id, city, code_isao, country) FROM stdin;
1	Москва	UUEE	Россия
2	Санкт-Петербург	ULLI	Россия
3	Нью-Йорк	KJFK	США
4	Лондон	EGLL	Великобритания
5	Берлин	EDDB	Германия
6	Токио	RJTT	Япония
7	Сидней	YSSY	Австралия
8	Париж	LFPG	Франция
9	Рим	LIRF	Италия
10	Барселона	LEBL	Испания
11	Амстердам	EHAM	Нидерланды
12	Киев	UKBB	Украина
13	Дубай	OMDB	ОАЭ
14	Лос-Анджелес	KLAX	США
15	Мельбурн	YMML	Австралия
16	Гонконг	VHHH	Китай
17	Сингапур	WSSS	Сингапур
18	Мумбаи	VABB	Индия
19	Шанхай	ZSPD	Китай
20	Сеул	RKSI	Южная Корея
21	Сингапур	WSSS	Сингапур
22	Мумбаи	VABB	Индия
23	Пекин	ZBAA	Китай
24	Дели	VIDP	Индия
25	Москва	UUEE	Россия
26	Лондон	EGLL	Великобритания
27	Пекин	ZBAA	Китай
28	Торонто	YYZ	Канада
29	Калифорния	KSFO	США
30	Чикаго	KORD	США
31	Даллас	KDFW	США
32	Атланта	KATL	США
33	Сан-Франциско	KSFO	США
34	Нью-Йорк	KJFK	США
35	Филадельфия	KPHL	США
36	Мадрид	LEMD	Испания
37	Шанхай	ZSPD	Китай
38	Москва	UUDD	Россия
39	Токио	RJAA	Япония
40	Киев	UKKK	Украина
\.


--
-- TOC entry 3712 (class 0 OID 16562)
-- Dependencies: 221
-- Data for Name: cash_desk; Type: TABLE DATA; Schema: airport_scheme; Owner: postgres
--

COPY airport_scheme.cash_desk (cashdesk_id, cashdesk_number, is_online) FROM stdin;
1	101	t
2	102	f
3	103	t
4	104	f
5	105	t
6	106	f
7	107	t
8	108	f
9	109	t
10	110	f
11	111	t
12	112	f
13	113	t
14	114	f
15	115	t
16	116	f
17	117	t
18	118	f
19	119	t
20	120	f
21	121	t
22	122	f
23	123	t
24	124	f
25	125	t
26	126	f
27	127	t
28	128	f
29	129	t
30	130	f
31	131	t
32	132	f
33	133	t
34	134	f
35	135	t
36	136	f
37	137	t
38	138	f
39	139	t
40	140	f
\.


--
-- TOC entry 3713 (class 0 OID 16565)
-- Dependencies: 222
-- Data for Name: crew; Type: TABLE DATA; Schema: airport_scheme; Owner: postgres
--

COPY airport_scheme.crew (crew_id, employee_id, flight_id, role, medical_status, reason_falling_medical) FROM stdin;
1	1	1	Пилот	прошел	\N
2	2	2	Стюардесса	прошел	\N
3	3	3	Механик	прошел	\N
4	4	4	Пилот	прошел	\N
5	5	5	Стюардесса	прошел	\N
6	6	6	Пилот	прошел	\N
7	7	7	Механик	прошел	\N
8	8	8	Стюардесса	прошел	\N
9	9	9	Пилот	прошел	\N
10	10	10	Стюардесса	прошел	\N
11	11	11	Механик	прошел	\N
12	12	12	Пилот	прошел	\N
13	13	13	Стюардесса	прошел	\N
14	14	14	Механик	прошел	\N
15	15	15	Пилот	прошел	\N
16	16	16	Стюардесса	прошел	\N
17	17	17	Механик	прошел	\N
18	18	18	Пилот	прошел	\N
19	19	19	Стюардесса	прошел	\N
20	20	20	Механик	прошел	\N
21	21	21	Пилот	прошел	\N
22	22	22	Стюардесса	прошел	\N
23	23	23	Механик	прошел	\N
24	24	24	Пилот	прошел	\N
25	25	25	Стюардесса	прошел	\N
26	26	26	Механик	прошел	\N
27	27	27	Пилот	прошел	\N
28	28	28	Стюардесса	прошел	\N
29	29	29	Механик	прошел	\N
30	30	30	Пилот	прошел	\N
31	31	31	Стюардесса	прошел	\N
32	32	32	Механик	прошел	\N
33	33	33	Пилот	прошел	\N
34	34	34	Стюардесса	прошел	\N
35	35	35	Механик	прошел	\N
36	36	36	Пилот	прошел	\N
37	37	37	Стюардесса	прошел	\N
38	38	38	Механик	прошел	\N
39	39	39	Пилот	прошел	\N
40	40	40	Стюардесса	прошел	\N
\.


--
-- TOC entry 3714 (class 0 OID 16569)
-- Dependencies: 223
-- Data for Name: employee; Type: TABLE DATA; Schema: airport_scheme; Owner: postgres
--

COPY airport_scheme.employee (employee_id, first_name, last_name, middle_name, birth_date, medical_exam_date, "position") FROM stdin;
1	Иван	Иванов	Иванович	1985-06-15	2025-04-01	Пилот
2	Мария	Петрова	Петровна	1990-08-25	2025-04-05	Стюардесса
3	Алексей	Сидоров	Алексеевич	1987-11-30	2025-03-25	Механик
4	Ольга	Васильева	Владимировна	1983-04-10	2025-04-02	Пилот
5	Дмитрий	Кузнецов	Сергеевич	1992-02-15	2025-03-30	Стюардесса
6	Татьяна	Федорова	Александровна	1995-01-05	2025-02-15	Пилот
7	Никита	Беляев	Михайлович	1989-07-23	2025-04-03	Механик
8	Екатерина	Петрова	Ивановна	1991-09-20	2025-03-28	Стюардесса
9	Роман	Григорьев	Игоревич	1988-03-12	2025-04-01	Пилот
10	Виктория	Смирнова	Владимировна	1986-05-25	2025-02-28	Стюардесса
11	Максим	Левченко	Олегович	1990-10-10	2025-03-15	Механик
12	Юлия	Калинина	Дмитриевна	1985-12-08	2025-03-20	Пилот
13	Анастасия	Воронова	Геннадиевна	1993-04-03	2025-02-17	Стюардесса
14	Игорь	Щербаков	Романович	1990-11-18	2025-03-22	Механик
15	Кирилл	Пономарев	Андреевич	1989-05-19	2025-03-25	Пилот
16	Валерия	Богданова	Сергеевна	1994-07-13	2025-02-19	Стюардесса
17	Сергей	Морозов	Петрович	1988-08-29	2025-03-12	Механик
18	Маргарита	Гусева	Викторовна	1992-10-05	2025-04-01	Пилот
19	Егор	Мельников	Дмитриевич	1987-02-16	2025-03-28	Стюардесса
20	Светлана	Козлова	Михайловна	1990-11-15	2025-02-25	Механик
21	Ярослав	Дмитриев	Николаевич	1991-03-04	2025-03-10	Пилот
22	Ольга	Захарова	Викторовна	1988-09-12	2025-04-03	Стюардесса
23	Артем	Филатов	Евгеньевич	1993-06-20	2025-03-19	Механик
24	Александр	Кириллов	Николаевич	1989-01-22	2025-04-05	Пилот
25	Тимофей	Федоров	Павлович	1987-12-17	2025-03-21	Стюардесса
26	Анатолий	Солдатов	Игоревич	1994-05-30	2025-02-22	Механик
27	Дарина	Чистякова	Александровна	1990-09-08	2025-03-10	Пилот
28	Алексей	Громов	Сергеевич	1991-04-18	2025-03-13	Стюардесса
29	Никита	Лазарев	Владимирович	1986-06-28	2025-04-02	Механик
30	Полина	Тимофеева	Романовна	1987-09-25	2025-02-18	Пилот
31	Ирина	Смирнова	Геннадиевна	1994-10-30	2025-02-12	Стюардесса
32	Дмитрий	Шмидт	Евгеньевич	1989-04-04	2025-03-22	Механик
33	Евгений	Фролов	Иванович	1990-07-03	2025-03-16	Пилот
34	Марина	Богданова	Юрьевна	1994-08-17	2025-02-07	Стюардесса
35	Владимир	Николаев	Михайлович	1987-11-14	2025-03-01	Механик
36	Ксения	Морозова	Петровна	1993-01-11	2025-03-18	Пилот
37	Григорий	Ефимов	Сергеевич	1989-12-08	2025-02-20	Стюардесса
38	Елена	Панова	Александровна	1990-05-24	2025-02-27	Механик
39	Петр	Лавров	Сергеевич	1991-08-13	2025-03-09	Пилот
40	Тимур	Мельников	Иванович	1987-01-29	2025-02-26	Стюардесса
\.


--
-- TOC entry 3715 (class 0 OID 16572)
-- Dependencies: 224
-- Data for Name: flight; Type: TABLE DATA; Schema: airport_scheme; Owner: postgres
--

COPY airport_scheme.flight (flight_id, flight_number, departure_date, departure_time, flight_type, aircraft_id, route_id) FROM stdin;
1	100	2025-04-20	10:30:00+03	Международный	1	1
2	200	2025-04-21	14:00:00+03	Внутренний	2	2
3	300	2025-04-22	16:00:00+03	Чартерный	3	3
4	400	2025-04-23	18:30:00+03	Международный	4	4
5	500	2025-04-24	08:00:00+03	Внутренний	5	5
6	600	2025-04-25	09:30:00+03	Чартерный	6	6
7	700	2025-04-26	12:00:00+03	Международный	7	7
8	800	2025-04-27	15:00:00+03	Внутренний	8	8
9	900	2025-04-28	17:30:00+03	Чартерный	9	9
10	1000	2025-04-29	19:00:00+03	Международный	10	10
11	1100	2025-04-30	07:30:00+03	Внутренний	11	11
12	1200	2025-05-01	09:00:00+03	Чартерный	12	12
13	1300	2025-05-02	11:30:00+03	Международный	13	13
14	1400	2025-05-03	13:00:00+03	Внутренний	14	14
15	1500	2025-05-04	14:30:00+03	Чартерный	15	15
16	1600	2025-05-05	16:00:00+03	Международный	16	16
17	1700	2025-05-06	17:30:00+03	Внутренний	17	17
18	1800	2025-05-07	19:00:00+03	Чартерный	18	18
19	1900	2025-05-08	20:30:00+03	Международный	19	19
20	2000	2025-05-09	21:00:00+03	Внутренний	20	20
21	2100	2025-05-10	07:00:00+03	Чартерный	21	21
22	2200	2025-05-11	08:30:00+03	Международный	22	22
23	2300	2025-05-12	10:00:00+03	Внутренний	23	23
24	2400	2025-05-13	11:30:00+03	Чартерный	24	24
25	2500	2025-05-14	13:00:00+03	Международный	25	25
26	2600	2025-05-15	14:30:00+03	Внутренний	26	26
27	2700	2025-05-16	16:00:00+03	Чартерный	27	27
28	2800	2025-05-17	17:30:00+03	Международный	28	28
29	2900	2025-05-18	19:00:00+03	Внутренний	29	29
30	3000	2025-05-19	20:30:00+03	Чартерный	30	30
31	3100	2025-05-20	21:00:00+03	Международный	31	31
32	3200	2025-05-21	07:00:00+03	Внутренний	32	32
33	3300	2025-05-22	08:30:00+03	Чартерный	33	33
34	3400	2025-05-23	10:00:00+03	Международный	34	34
35	3500	2025-05-24	11:30:00+03	Внутренний	35	35
36	3600	2025-05-25	13:00:00+03	Чартерный	36	36
37	3700	2025-05-26	14:30:00+03	Международный	37	37
38	3800	2025-05-27	16:00:00+03	Внутренний	38	38
39	3900	2025-05-28	17:30:00+03	Чартерный	39	39
40	4000	2025-05-29	19:00:00+03	Международный	40	40
\.


--
-- TOC entry 3716 (class 0 OID 16575)
-- Dependencies: 225
-- Data for Name: medical_exam; Type: TABLE DATA; Schema: airport_scheme; Owner: postgres
--

COPY airport_scheme.medical_exam (medical_exam_id, employee_id, status, exam_date) FROM stdin;
1	1	пройден	2025-04-01
2	2	в ожидании	2025-04-05
3	3	не пройден	2025-03-15
4	4	пройден	2025-04-02
5	5	в ожидании	2025-03-30
6	6	пройден	2025-02-15
7	7	не пройден	2025-04-03
8	8	в ожидании	2025-03-28
9	9	пройден	2025-04-01
10	10	не пройден	2025-02-28
11	11	в ожидании	2025-03-15
12	12	пройден	2025-03-20
13	13	не пройден	2025-02-17
14	14	в ожидании	2025-03-22
15	15	пройден	2025-03-25
16	16	в ожидании	2025-02-19
17	17	не пройден	2025-03-12
18	18	в ожидании	2025-04-01
19	19	пройден	2025-03-28
20	20	не пройден	2025-02-25
21	21	в ожидании	2025-03-10
22	22	пройден	2025-03-13
23	23	не пройден	2025-02-07
24	24	в ожидании	2025-03-19
25	25	пройден	2025-03-22
26	26	в ожидании	2025-02-12
27	27	не пройден	2025-03-25
28	28	в ожидании	2025-02-18
29	29	пройден	2025-03-09
30	30	не пройден	2025-02-26
31	31	в ожидании	2025-03-20
32	32	пройден	2025-02-15
33	33	в ожидании	2025-03-18
34	34	не пройден	2025-03-05
35	35	в ожидании	2025-02-22
36	36	пройден	2025-03-01
37	37	в ожидании	2025-02-28
38	38	не пройден	2025-03-07
39	39	в ожидании	2025-03-30
40	40	пройден	2025-04-02
\.


--
-- TOC entry 3717 (class 0 OID 16578)
-- Dependencies: 226
-- Data for Name: passenger; Type: TABLE DATA; Schema: airport_scheme; Owner: postgres
--

COPY airport_scheme.passenger (passenger_id, first_name, last_name, middle_name, registration_status) FROM stdin;
1	Олег	Смирнов	Алексеевич	t
2	Анна	Кузнецова	Сергеевна	t
3	Дмитрий	Михайлов	Юрьевич	f
4	Елена	Федорова	Александровна	t
5	Игорь	Солдатов	Павлович	t
6	Тимофей	Рогов	Максимович	t
7	Мария	Боброва	Викторовна	f
8	Алексей	Тимофеев	Александрович	t
9	Светлана	Козлова	Михайловна	t
10	Юлия	Савельева	Геннадиевна	f
11	Ирина	Мельникова	Алексеевна	t
12	Александр	Куликов	Владимирович	t
13	Наталья	Богданова	Сергеевна	t
14	Григорий	Морозов	Дмитриевич	t
15	Маргарита	Левина	Вячеславовна	f
16	Сергей	Николаев	Иванович	t
17	Дарина	Филиппова	Михайловна	t
18	Глеб	Волков	Николаевич	f
19	Анатолий	Зайцев	Викторович	t
20	Роман	Щербаков	Петрович	f
21	Марина	Тимофеева	Александровна	t
22	Денис	Шмидт	Игоревич	t
23	Людмила	Тимошенко	Федоровна	f
24	Петр	Горячев	Сергейевич	t
25	Юлия	Рыкова	Анатольевна	t
26	София	Громова	Геннадиевна	f
27	Егор	Филиппов	Михайлович	t
28	Анатолий	Климов	Игоревич	t
29	Никита	Макаров	Павлович	t
30	Алёна	Смирнова	Геннадиевна	t
31	Игорь	Костин	Петрович	f
32	Ирина	Жукова	Олеговна	t
33	Константин	Руденко	Юрьевич	t
34	Екатерина	Митрофанова	Владимировна	t
35	Максим	Никитин	Геннадиевич	f
36	Галина	Рогова	Ивановна	t
37	Татьяна	Соловьева	Анатольевна	f
38	Денис	Петров	Викторович	t
39	Елизавета	Шмидт	Геннадиевна	t
40	Николай	Голубев	Александрович	t
\.


--
-- TOC entry 3718 (class 0 OID 16581)
-- Dependencies: 227
-- Data for Name: passport_data; Type: TABLE DATA; Schema: airport_scheme; Owner: postgres
--

COPY airport_scheme.passport_data (passport_data_id, issue_date, passenger_id, series, number) FROM stdin;
1	2025-01-01	1	AA1234	123456789
2	2025-02-01	2	BB5678	987654321
3	2025-03-01	3	CC9012	112233445
4	2025-04-01	4	DD3456	556677889
5	2025-01-15	5	EE7890	998877665
6	2025-02-15	6	FF2345	123987654
7	2025-03-15	7	GG6789	432109876
8	2025-04-15	8	HH1234	908172634
9	2025-01-10	9	II5678	345678987
10	2025-02-10	10	JJ9012	879456123
11	2025-03-10	11	KK3456	654123789
12	2025-04-10	12	LL7890	345987654
13	2025-01-20	13	MM2345	234567891
14	2025-02-20	14	NN6789	672301589
15	2025-03-20	15	OO1234	453298764
16	2025-04-20	16	PP5678	124578963
17	2025-01-25	17	QQ9012	564781239
18	2025-02-25	18	RR3456	987612304
19	2025-03-25	19	SS7890	472381654
20	2025-04-25	20	TT2345	873654123
21	2025-01-30	21	UU6789	654987321
22	2025-02-28	22	VV1234	319876543
23	2025-03-30	23	WW5678	928746531
24	2025-04-30	24	XX9012	387564921
25	2025-01-05	25	YY3456	245781936
26	2025-02-05	26	ZZ7890	918276543
27	2025-03-05	27	AAA234	543678921
28	2025-04-05	28	BBB567	876521439
29	2025-01-12	29	CCC901	654239875
30	2025-02-12	30	DDD345	231867495
31	2025-03-12	31	EEE789	126534987
32	2025-04-12	32	FFF123	987654321
33	2025-01-18	33	GGG567	125678943
34	2025-02-18	34	HHH901	327594861
35	2025-03-18	35	III234	126548379
36	2025-04-18	36	JJJ567	987645231
37	2025-01-22	37	KKK901	234598763
38	2025-02-22	38	LLL345	978346251
39	2025-03-22	39	MMM789	145978632
40	2025-04-22	40	NNN123	654123789
\.


--
-- TOC entry 3719 (class 0 OID 16584)
-- Dependencies: 228
-- Data for Name: route; Type: TABLE DATA; Schema: airport_scheme; Owner: postgres
--

COPY airport_scheme.route (route_id, departure_airport_id, arrival_airport_id) FROM stdin;
1	1	2
2	2	3
3	3	4
4	4	5
5	5	6
6	6	7
7	7	8
8	8	9
9	9	10
10	10	11
11	11	12
12	12	13
13	13	14
14	14	15
15	15	16
16	16	17
17	17	18
18	18	19
19	19	20
20	20	21
21	21	22
22	22	23
23	23	24
24	24	25
25	25	26
26	26	27
27	27	28
28	28	29
29	29	30
30	30	31
31	31	32
32	32	33
33	33	34
34	34	35
35	35	36
36	36	37
37	37	38
38	38	39
39	39	40
40	40	1
\.


--
-- TOC entry 3720 (class 0 OID 16587)
-- Dependencies: 229
-- Data for Name: ticket; Type: TABLE DATA; Schema: airport_scheme; Owner: postgres
--

COPY airport_scheme.ticket (ticket_id, ticket_number, ticket_status, purchase_date, seat_number, class_of_service, baggage_insurance, price, passenger_id, flight_id, cashdesk_id, passport_data_id) FROM stdin;
35	T12379	активен	2025-04-16	43	эконом	t	14500	35	35	35	35
36	T12380	отменен	2025-04-14	44	первый	f	33000	36	36	36	36
37	T12381	активен	2025-04-15	45	эконом	t	16000	37	37	37	37
38	T12382	использован	2025-04-13	46	бизнес	t	29000	38	38	38	38
39	T12383	активен	2025-04-16	47	эконом	f	15000	39	39	39	39
40	T12384	отменен	2025-04-14	48	первый	t	34000	40	40	40	40
1	T12345	активен	2025-04-15	12	эконом	t	15000	1	1	1	1
7	T12351	активен	2025-04-17	10	бизнес	f	25000	7	7	7	7
8	T12352	использован	2025-04-13	6	эконом	t	13000	8	8	8	8
9	T12353	активен	2025-04-15	15	первый	f	32000	9	9	9	9
10	T12354	отменен	2025-04-14	11	бизнес	t	27000	10	10	10	10
11	T12355	активен	2025-04-16	18	эконом	f	16000	11	11	11	11
12	T12356	активен	2025-04-17	20	первый	t	35000	12	12	12	12
13	T12357	использован	2025-04-14	21	эконом	f	14000	13	13	13	13
14	T12358	активен	2025-04-15	22	бизнес	t	29000	14	14	14	14
15	T12359	отменен	2025-04-16	23	эконом	t	14500	15	15	15	15
16	T12360	активен	2025-04-17	24	первый	f	34000	16	16	16	16
17	T12361	активен	2025-04-15	25	эконом	t	15500	17	17	17	17
18	T12362	использован	2025-04-13	26	бизнес	f	26000	18	18	18	18
19	T12363	активен	2025-04-16	27	эконом	t	16000	19	19	19	19
20	T12364	отменен	2025-04-14	28	первый	f	33000	20	20	20	20
21	T12365	активен	2025-04-17	29	эконом	t	15000	21	21	21	21
22	T12366	использован	2025-04-15	30	бизнес	t	28000	22	22	22	22
23	T12367	активен	2025-04-17	31	эконом	f	14000	23	23	23	23
24	T12368	отменен	2025-04-14	32	первый	t	34000	24	24	24	24
25	T12369	активен	2025-04-15	33	эконом	t	15000	25	25	25	25
26	T12370	использован	2025-04-13	34	бизнес	f	29000	26	26	26	26
27	T12371	активен	2025-04-16	35	эконом	t	16000	27	27	27	27
28	T12372	отменен	2025-04-14	36	первый	f	35000	28	28	28	28
29	T12373	активен	2025-04-17	37	эконом	t	15000	29	29	29	29
30	T12374	использован	2025-04-15	38	бизнес	t	28000	30	30	30	30
31	T12375	активен	2025-04-16	39	эконом	f	15000	31	31	31	31
32	T12376	отменен	2025-04-14	40	первый	t	36000	32	32	32	32
33	T12377	активен	2025-04-17	41	эконом	t	15500	33	33	33	33
34	T12378	использован	2025-04-15	42	бизнес	f	27000	34	34	34	34
2	T12346	активен	2025-04-15	14	бизнес	f	30000	2	2	2	2
3	T12347	активен	2025-04-15	5	эконом	t	14000	3	3	3	3
4	T12348	использован	2025-04-14	8	первый	t	40000	4	4	4	4
5	T12349	активен	2025-04-16	3	эконом	f	12000	5	5	5	5
6	T12350	отменен	2025-04-15	7	эконом	t	13500	6	6	6	6
\.


--
-- TOC entry 3721 (class 0 OID 16593)
-- Dependencies: 230
-- Data for Name: transit_stop; Type: TABLE DATA; Schema: airport_scheme; Owner: postgres
--

COPY airport_scheme.transit_stop (transit_stop_id, flight_id, airport_id, stop_type) FROM stdin;
1	1	1	транзит
2	2	2	дозаправка
3	3	3	аварийная
4	4	4	транзит
5	5	5	дозаправка
6	6	6	аварийная
7	7	7	транзит
8	8	8	дозаправка
9	9	9	аварийная
10	10	10	транзит
11	11	11	дозаправка
12	12	12	аварийная
13	13	13	транзит
14	14	14	дозаправка
15	15	15	аварийная
16	16	16	транзит
17	17	17	дозаправка
18	18	18	аварийная
19	19	19	транзит
20	20	20	дозаправка
21	21	21	аварийная
22	22	22	транзит
23	23	23	дозаправка
24	24	24	аварийная
25	25	25	транзит
26	26	26	дозаправка
27	27	27	аварийная
28	28	28	транзит
29	29	29	дозаправка
30	30	30	аварийная
31	31	31	транзит
32	32	32	дозаправка
33	33	33	аварийная
34	34	34	транзит
35	35	35	дозаправка
36	36	36	аварийная
37	37	37	транзит
38	38	38	дозаправка
39	39	39	аварийная
40	40	40	транзит
\.


--
-- TOC entry 3507 (class 2606 OID 16596)
-- Name: route CHECK(depature_arrival); Type: CHECK CONSTRAINT; Schema: airport_scheme; Owner: postgres
--

ALTER TABLE airport_scheme.route
    ADD CONSTRAINT "CHECK(depature_arrival)" CHECK ((departure_airport_id <> arrival_airport_id)) NOT VALID;


--
-- TOC entry 3766 (class 0 OID 0)
-- Dependencies: 3507
-- Name: CONSTRAINT "CHECK(depature_arrival)" ON route; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON CONSTRAINT "CHECK(depature_arrival)" ON airport_scheme.route IS 'Аэропорты отправления и прибытия не совпадают';


--
-- TOC entry 3513 (class 2606 OID 16598)
-- Name: aircraft aircraft_pkey; Type: CONSTRAINT; Schema: airport_scheme; Owner: postgres
--

ALTER TABLE ONLY airport_scheme.aircraft
    ADD CONSTRAINT aircraft_pkey PRIMARY KEY (aircraft_id);


--
-- TOC entry 3517 (class 2606 OID 16600)
-- Name: airline airline_pkey; Type: CONSTRAINT; Schema: airport_scheme; Owner: postgres
--

ALTER TABLE ONLY airport_scheme.airline
    ADD CONSTRAINT airline_pkey PRIMARY KEY (airline_id);


--
-- TOC entry 3519 (class 2606 OID 16602)
-- Name: airport airport_pkey; Type: CONSTRAINT; Schema: airport_scheme; Owner: postgres
--

ALTER TABLE ONLY airport_scheme.airport
    ADD CONSTRAINT airport_pkey PRIMARY KEY (airport_id);


--
-- TOC entry 3515 (class 2606 OID 16604)
-- Name: aircraft board_numder_unique; Type: CONSTRAINT; Schema: airport_scheme; Owner: postgres
--

ALTER TABLE ONLY airport_scheme.aircraft
    ADD CONSTRAINT board_numder_unique UNIQUE (board_number);


--
-- TOC entry 3521 (class 2606 OID 16606)
-- Name: cash_desk cash_desk_pkey; Type: CONSTRAINT; Schema: airport_scheme; Owner: postgres
--

ALTER TABLE ONLY airport_scheme.cash_desk
    ADD CONSTRAINT cash_desk_pkey PRIMARY KEY (cashdesk_id);


--
-- TOC entry 3504 (class 2606 OID 16607)
-- Name: flight correct_type_flight; Type: CHECK CONSTRAINT; Schema: airport_scheme; Owner: postgres
--

ALTER TABLE airport_scheme.flight
    ADD CONSTRAINT correct_type_flight CHECK (((flight_type)::text = ANY (ARRAY[('Международный'::character varying)::text, ('Внутренний'::character varying)::text, ('Чартерный'::character varying)::text]))) NOT VALID;


--
-- TOC entry 3767 (class 0 OID 0)
-- Dependencies: 3504
-- Name: CONSTRAINT correct_type_flight ON flight; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON CONSTRAINT correct_type_flight ON airport_scheme.flight IS 'Проверяет корректность типа рейса (международный, внутренний, чартерный).';


--
-- TOC entry 3525 (class 2606 OID 16609)
-- Name: crew crew_pkey; Type: CONSTRAINT; Schema: airport_scheme; Owner: postgres
--

ALTER TABLE ONLY airport_scheme.crew
    ADD CONSTRAINT crew_pkey PRIMARY KEY (crew_id);


--
-- TOC entry 3529 (class 2606 OID 16611)
-- Name: employee employee_pkey; Type: CONSTRAINT; Schema: airport_scheme; Owner: postgres
--

ALTER TABLE ONLY airport_scheme.employee
    ADD CONSTRAINT employee_pkey PRIMARY KEY (employee_id);


--
-- TOC entry 3531 (class 2606 OID 16613)
-- Name: flight flight_pkey; Type: CONSTRAINT; Schema: airport_scheme; Owner: postgres
--

ALTER TABLE ONLY airport_scheme.flight
    ADD CONSTRAINT flight_pkey PRIMARY KEY (flight_id);


--
-- TOC entry 3535 (class 2606 OID 16615)
-- Name: medical_exam medical_exam_pkey; Type: CONSTRAINT; Schema: airport_scheme; Owner: postgres
--

ALTER TABLE ONLY airport_scheme.medical_exam
    ADD CONSTRAINT medical_exam_pkey PRIMARY KEY (medical_exam_id);


--
-- TOC entry 3527 (class 2606 OID 16617)
-- Name: crew not_double_employee_on_flight; Type: CONSTRAINT; Schema: airport_scheme; Owner: postgres
--

ALTER TABLE ONLY airport_scheme.crew
    ADD CONSTRAINT not_double_employee_on_flight UNIQUE (employee_id, flight_id);


--
-- TOC entry 3768 (class 0 OID 0)
-- Dependencies: 3527
-- Name: CONSTRAINT not_double_employee_on_flight ON crew; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON CONSTRAINT not_double_employee_on_flight ON airport_scheme.crew IS 'Запрещает назначать сотрудника на один рейс несколько раз';


--
-- TOC entry 3523 (class 2606 OID 16619)
-- Name: cash_desk number_cash_desk; Type: CONSTRAINT; Schema: airport_scheme; Owner: postgres
--

ALTER TABLE ONLY airport_scheme.cash_desk
    ADD CONSTRAINT number_cash_desk UNIQUE (cashdesk_number);


--
-- TOC entry 3537 (class 2606 OID 16621)
-- Name: passenger passenger_pkey; Type: CONSTRAINT; Schema: airport_scheme; Owner: postgres
--

ALTER TABLE ONLY airport_scheme.passenger
    ADD CONSTRAINT passenger_pkey PRIMARY KEY (passenger_id);


--
-- TOC entry 3539 (class 2606 OID 16623)
-- Name: passport_data passport_data_pkey; Type: CONSTRAINT; Schema: airport_scheme; Owner: postgres
--

ALTER TABLE ONLY airport_scheme.passport_data
    ADD CONSTRAINT passport_data_pkey PRIMARY KEY (passport_data_id);


--
-- TOC entry 3541 (class 2606 OID 16625)
-- Name: route route_pkey; Type: CONSTRAINT; Schema: airport_scheme; Owner: postgres
--

ALTER TABLE ONLY airport_scheme.route
    ADD CONSTRAINT route_pkey PRIMARY KEY (route_id);


--
-- TOC entry 3505 (class 2606 OID 16626)
-- Name: medical_exam status_check; Type: CHECK CONSTRAINT; Schema: airport_scheme; Owner: postgres
--

ALTER TABLE airport_scheme.medical_exam
    ADD CONSTRAINT status_check CHECK (((status)::text = ANY (ARRAY[('пройден'::character varying)::text, ('не пройден'::character varying)::text, ('в ожидании'::character varying)::text]))) NOT VALID;


--
-- TOC entry 3511 (class 2606 OID 16627)
-- Name: transit_stop stop_type_check; Type: CHECK CONSTRAINT; Schema: airport_scheme; Owner: postgres
--

ALTER TABLE airport_scheme.transit_stop
    ADD CONSTRAINT stop_type_check CHECK (((stop_type)::text = ANY (ARRAY[('транзит'::character varying)::text, ('дозаправка'::character varying)::text, ('аварийная'::character varying)::text]))) NOT VALID;


--
-- TOC entry 3769 (class 0 OID 0)
-- Dependencies: 3511
-- Name: CONSTRAINT stop_type_check ON transit_stop; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON CONSTRAINT stop_type_check ON airport_scheme.transit_stop IS 'правильность заполнения поля';


--
-- TOC entry 3545 (class 2606 OID 16629)
-- Name: ticket ticket_number_unique; Type: CONSTRAINT; Schema: airport_scheme; Owner: postgres
--

ALTER TABLE ONLY airport_scheme.ticket
    ADD CONSTRAINT ticket_number_unique UNIQUE (ticket_number);


--
-- TOC entry 3547 (class 2606 OID 16631)
-- Name: ticket ticket_pkey; Type: CONSTRAINT; Schema: airport_scheme; Owner: postgres
--

ALTER TABLE ONLY airport_scheme.ticket
    ADD CONSTRAINT ticket_pkey PRIMARY KEY (ticket_id);


--
-- TOC entry 3549 (class 2606 OID 16633)
-- Name: transit_stop transit_stop_pkey; Type: CONSTRAINT; Schema: airport_scheme; Owner: postgres
--

ALTER TABLE ONLY airport_scheme.transit_stop
    ADD CONSTRAINT transit_stop_pkey PRIMARY KEY (transit_stop_id);


--
-- TOC entry 3533 (class 2606 OID 16635)
-- Name: flight unique_flight; Type: CONSTRAINT; Schema: airport_scheme; Owner: postgres
--

ALTER TABLE ONLY airport_scheme.flight
    ADD CONSTRAINT unique_flight UNIQUE (flight_number, departure_date);


--
-- TOC entry 3543 (class 2606 OID 16637)
-- Name: route unique_ways; Type: CONSTRAINT; Schema: airport_scheme; Owner: postgres
--

ALTER TABLE ONLY airport_scheme.route
    ADD CONSTRAINT unique_ways UNIQUE (departure_airport_id, arrival_airport_id);


--
-- TOC entry 3770 (class 0 OID 0)
-- Dependencies: 3543
-- Name: CONSTRAINT unique_ways ON route; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON CONSTRAINT unique_ways ON airport_scheme.route IS 'Уникальность комбинации аэропортов отправления и прибытия';


--
-- TOC entry 3509 (class 2606 OID 16638)
-- Name: ticket valid_class; Type: CHECK CONSTRAINT; Schema: airport_scheme; Owner: postgres
--

ALTER TABLE airport_scheme.ticket
    ADD CONSTRAINT valid_class CHECK (((class_of_service)::text = ANY (ARRAY[('эконом'::character varying)::text, ('бизнес'::character varying)::text, ('первый'::character varying)::text]))) NOT VALID;


--
-- TOC entry 3771 (class 0 OID 0)
-- Dependencies: 3509
-- Name: CONSTRAINT valid_class ON ticket; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON CONSTRAINT valid_class ON airport_scheme.ticket IS 'Допустимые классы обслуживания: эконом, бизнес, первый';


--
-- TOC entry 3501 (class 2606 OID 16639)
-- Name: aircraft valid_fuel; Type: CHECK CONSTRAINT; Schema: airport_scheme; Owner: postgres
--

ALTER TABLE airport_scheme.aircraft
    ADD CONSTRAINT valid_fuel CHECK ((fuel_consumption > (0)::numeric)) NOT VALID;


--
-- TOC entry 3506 (class 2606 OID 16640)
-- Name: medical_exam valid_medical_date; Type: CHECK CONSTRAINT; Schema: airport_scheme; Owner: postgres
--

ALTER TABLE airport_scheme.medical_exam
    ADD CONSTRAINT valid_medical_date CHECK ((exam_date <= CURRENT_DATE)) NOT VALID;


--
-- TOC entry 3502 (class 2606 OID 16641)
-- Name: aircraft valid_seats; Type: CHECK CONSTRAINT; Schema: airport_scheme; Owner: postgres
--

ALTER TABLE airport_scheme.aircraft
    ADD CONSTRAINT valid_seats CHECK ((seat_capacity > 0)) NOT VALID;


--
-- TOC entry 3503 (class 2606 OID 16642)
-- Name: aircraft valid_speed; Type: CHECK CONSTRAINT; Schema: airport_scheme; Owner: postgres
--

ALTER TABLE airport_scheme.aircraft
    ADD CONSTRAINT valid_speed CHECK ((speed > 0)) NOT VALID;


--
-- TOC entry 3510 (class 2606 OID 16643)
-- Name: ticket valid_status; Type: CHECK CONSTRAINT; Schema: airport_scheme; Owner: postgres
--

ALTER TABLE airport_scheme.ticket
    ADD CONSTRAINT valid_status CHECK (((ticket_status)::text = ANY (ARRAY[('активен'::character varying)::text, ('использован'::character varying)::text, ('отменен'::character varying)::text, ('просрочен'::character varying)::text]))) NOT VALID;


--
-- TOC entry 3772 (class 0 OID 0)
-- Dependencies: 3510
-- Name: CONSTRAINT valid_status ON ticket; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON CONSTRAINT valid_status ON airport_scheme.ticket IS 'Допустимые статусы билетов: активен, использован, отменен, просрочен.';


--
-- TOC entry 3553 (class 2606 OID 16644)
-- Name: flight aircraft_id_fk; Type: FK CONSTRAINT; Schema: airport_scheme; Owner: postgres
--

ALTER TABLE ONLY airport_scheme.flight
    ADD CONSTRAINT aircraft_id_fk FOREIGN KEY (aircraft_id) REFERENCES airport_scheme.aircraft(aircraft_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3773 (class 0 OID 0)
-- Dependencies: 3553
-- Name: CONSTRAINT aircraft_id_fk ON flight; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON CONSTRAINT aircraft_id_fk ON airport_scheme.flight IS 'Связь с воздушным судном из таблицы aircraft.';


--
-- TOC entry 3550 (class 2606 OID 16649)
-- Name: aircraft airline_id_fk; Type: FK CONSTRAINT; Schema: airport_scheme; Owner: postgres
--

ALTER TABLE ONLY airport_scheme.aircraft
    ADD CONSTRAINT airline_id_fk FOREIGN KEY (airline_id) REFERENCES airport_scheme.airline(airline_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3562 (class 2606 OID 16654)
-- Name: transit_stop airport_id_fk; Type: FK CONSTRAINT; Schema: airport_scheme; Owner: postgres
--

ALTER TABLE ONLY airport_scheme.transit_stop
    ADD CONSTRAINT airport_id_fk FOREIGN KEY (airport_id) REFERENCES airport_scheme.airport(airport_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3774 (class 0 OID 0)
-- Dependencies: 3562
-- Name: CONSTRAINT airport_id_fk ON transit_stop; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON CONSTRAINT airport_id_fk ON airport_scheme.transit_stop IS 'Связывает транзитную остановку с аэропортом из таблицы airport';


--
-- TOC entry 3557 (class 2606 OID 16659)
-- Name: route arrival_airport_fk; Type: FK CONSTRAINT; Schema: airport_scheme; Owner: postgres
--

ALTER TABLE ONLY airport_scheme.route
    ADD CONSTRAINT arrival_airport_fk FOREIGN KEY (arrival_airport_id) REFERENCES airport_scheme.airport(airport_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3775 (class 0 OID 0)
-- Dependencies: 3557
-- Name: CONSTRAINT arrival_airport_fk ON route; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON CONSTRAINT arrival_airport_fk ON airport_scheme.route IS 'Указывает аэропорт прибытия из таблицы airport';


--
-- TOC entry 3559 (class 2606 OID 16664)
-- Name: ticket cashdesk_id_fk; Type: FK CONSTRAINT; Schema: airport_scheme; Owner: postgres
--

ALTER TABLE ONLY airport_scheme.ticket
    ADD CONSTRAINT cashdesk_id_fk FOREIGN KEY (cashdesk_id) REFERENCES airport_scheme.cash_desk(cashdesk_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3558 (class 2606 OID 16669)
-- Name: route departure_airport_fk; Type: FK CONSTRAINT; Schema: airport_scheme; Owner: postgres
--

ALTER TABLE ONLY airport_scheme.route
    ADD CONSTRAINT departure_airport_fk FOREIGN KEY (departure_airport_id) REFERENCES airport_scheme.airport(airport_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3776 (class 0 OID 0)
-- Dependencies: 3558
-- Name: CONSTRAINT departure_airport_fk ON route; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON CONSTRAINT departure_airport_fk ON airport_scheme.route IS 'Указывает аэропорт отправления из таблицы airport';


--
-- TOC entry 3555 (class 2606 OID 16674)
-- Name: medical_exam employee_id_fk; Type: FK CONSTRAINT; Schema: airport_scheme; Owner: postgres
--

ALTER TABLE ONLY airport_scheme.medical_exam
    ADD CONSTRAINT employee_id_fk FOREIGN KEY (employee_id) REFERENCES airport_scheme.employee(employee_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3777 (class 0 OID 0)
-- Dependencies: 3555
-- Name: CONSTRAINT employee_id_fk ON medical_exam; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON CONSTRAINT employee_id_fk ON airport_scheme.medical_exam IS 'Связывает медосмотр с сотрудником из таблицы employee';


--
-- TOC entry 3551 (class 2606 OID 16679)
-- Name: crew employee_id_fk; Type: FK CONSTRAINT; Schema: airport_scheme; Owner: postgres
--

ALTER TABLE ONLY airport_scheme.crew
    ADD CONSTRAINT employee_id_fk FOREIGN KEY (employee_id) REFERENCES airport_scheme.employee(employee_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3778 (class 0 OID 0)
-- Dependencies: 3551
-- Name: CONSTRAINT employee_id_fk ON crew; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON CONSTRAINT employee_id_fk ON airport_scheme.crew IS 'Связь с сотрудником из таблицы employee.';


--
-- TOC entry 3563 (class 2606 OID 16684)
-- Name: transit_stop flight_id_fk; Type: FK CONSTRAINT; Schema: airport_scheme; Owner: postgres
--

ALTER TABLE ONLY airport_scheme.transit_stop
    ADD CONSTRAINT flight_id_fk FOREIGN KEY (flight_id) REFERENCES airport_scheme.flight(flight_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3779 (class 0 OID 0)
-- Dependencies: 3563
-- Name: CONSTRAINT flight_id_fk ON transit_stop; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON CONSTRAINT flight_id_fk ON airport_scheme.transit_stop IS 'Связывает транзитную остановку с рейсом из таблицы flight';


--
-- TOC entry 3560 (class 2606 OID 16689)
-- Name: ticket flight_id_fk; Type: FK CONSTRAINT; Schema: airport_scheme; Owner: postgres
--

ALTER TABLE ONLY airport_scheme.ticket
    ADD CONSTRAINT flight_id_fk FOREIGN KEY (flight_id) REFERENCES airport_scheme.flight(flight_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3780 (class 0 OID 0)
-- Dependencies: 3560
-- Name: CONSTRAINT flight_id_fk ON ticket; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON CONSTRAINT flight_id_fk ON airport_scheme.ticket IS 'Связывает билет с рейсом из таблицы flight';


--
-- TOC entry 3552 (class 2606 OID 16694)
-- Name: crew flight_id_fk; Type: FK CONSTRAINT; Schema: airport_scheme; Owner: postgres
--

ALTER TABLE ONLY airport_scheme.crew
    ADD CONSTRAINT flight_id_fk FOREIGN KEY (flight_id) REFERENCES airport_scheme.flight(flight_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3781 (class 0 OID 0)
-- Dependencies: 3552
-- Name: CONSTRAINT flight_id_fk ON crew; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON CONSTRAINT flight_id_fk ON airport_scheme.crew IS 'Связывает экипаж с рейсом из таблицы flight';


--
-- TOC entry 3556 (class 2606 OID 16699)
-- Name: passport_data passenger_id_fk; Type: FK CONSTRAINT; Schema: airport_scheme; Owner: postgres
--

ALTER TABLE ONLY airport_scheme.passport_data
    ADD CONSTRAINT passenger_id_fk FOREIGN KEY (passenger_id) REFERENCES airport_scheme.passenger(passenger_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3782 (class 0 OID 0)
-- Dependencies: 3556
-- Name: CONSTRAINT passenger_id_fk ON passport_data; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON CONSTRAINT passenger_id_fk ON airport_scheme.passport_data IS 'Связывает паспортные данные с пассажиром из таблицы passenger';


--
-- TOC entry 3561 (class 2606 OID 16704)
-- Name: ticket passport_data_id_fk; Type: FK CONSTRAINT; Schema: airport_scheme; Owner: postgres
--

ALTER TABLE ONLY airport_scheme.ticket
    ADD CONSTRAINT passport_data_id_fk FOREIGN KEY (passport_data_id) REFERENCES airport_scheme.passport_data(passport_data_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3554 (class 2606 OID 16709)
-- Name: flight route_id_fk; Type: FK CONSTRAINT; Schema: airport_scheme; Owner: postgres
--

ALTER TABLE ONLY airport_scheme.flight
    ADD CONSTRAINT route_id_fk FOREIGN KEY (route_id) REFERENCES airport_scheme.route(route_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3783 (class 0 OID 0)
-- Dependencies: 3554
-- Name: CONSTRAINT route_id_fk ON flight; Type: COMMENT; Schema: airport_scheme; Owner: postgres
--

COMMENT ON CONSTRAINT route_id_fk ON airport_scheme.flight IS 'Связь с маршрутом из таблицы route.';


-- Completed on 2025-05-05 01:00:28 MSK

--
-- PostgreSQL database dump complete
--

