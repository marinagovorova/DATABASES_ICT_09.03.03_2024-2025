--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4 (Debian 17.4-1.pgdg120+2)
-- Dumped by pg_dump version 17.4 (Debian 17.4-1.pgdg120+2)

-- Started on 2025-04-03 11:26:55 UTC

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
-- TOC entry 6 (class 2615 OID 16390)
-- Name: lab3; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA lab3;


ALTER SCHEMA lab3 OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 224 (class 1259 OID 16439)
-- Name: accidents; Type: TABLE; Schema: lab3; Owner: postgres
--

CREATE TABLE lab3.accidents (
    violation_id integer NOT NULL,
    officer_personal_number integer NOT NULL,
    accident_address character varying(100) NOT NULL,
    accident_date_time timestamp without time zone NOT NULL,
    accident_description character varying(500) NOT NULL,
    accident_code integer NOT NULL
);


ALTER TABLE lab3.accidents OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 16558)
-- Name: accidents_accident_code_seq; Type: SEQUENCE; Schema: lab3; Owner: postgres
--

CREATE SEQUENCE lab3.accidents_accident_code_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE lab3.accidents_accident_code_seq OWNER TO postgres;

--
-- TOC entry 3509 (class 0 OID 0)
-- Dependencies: 229
-- Name: accidents_accident_code_seq; Type: SEQUENCE OWNED BY; Schema: lab3; Owner: postgres
--

ALTER SEQUENCE lab3.accidents_accident_code_seq OWNED BY lab3.accidents.accident_code;


--
-- TOC entry 227 (class 1259 OID 16481)
-- Name: car_owner; Type: TABLE; Schema: lab3; Owner: postgres
--

CREATE TABLE lab3.car_owner (
    car_id integer NOT NULL,
    driver_id integer NOT NULL,
    owned_from date NOT NULL,
    owned_until date,
    car_owner_id integer NOT NULL
);


ALTER TABLE lab3.car_owner OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 16567)
-- Name: car_owner_car_owner_id_seq; Type: SEQUENCE; Schema: lab3; Owner: postgres
--

CREATE SEQUENCE lab3.car_owner_car_owner_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE lab3.car_owner_car_owner_id_seq OWNER TO postgres;

--
-- TOC entry 3510 (class 0 OID 0)
-- Dependencies: 230
-- Name: car_owner_car_owner_id_seq; Type: SEQUENCE OWNED BY; Schema: lab3; Owner: postgres
--

ALTER SEQUENCE lab3.car_owner_car_owner_id_seq OWNED BY lab3.car_owner.car_owner_id;


--
-- TOC entry 221 (class 1259 OID 16412)
-- Name: cars; Type: TABLE; Schema: lab3; Owner: postgres
--

CREATE TABLE lab3.cars (
    registration_date date NOT NULL,
    year_of_manufacture date NOT NULL,
    car_number character varying(10) NOT NULL,
    brand character varying(50) NOT NULL,
    car_id integer NOT NULL
);


ALTER TABLE lab3.cars OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 16574)
-- Name: cars_car_id_seq; Type: SEQUENCE; Schema: lab3; Owner: postgres
--

CREATE SEQUENCE lab3.cars_car_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE lab3.cars_car_id_seq OWNER TO postgres;

--
-- TOC entry 3511 (class 0 OID 0)
-- Dependencies: 231
-- Name: cars_car_id_seq; Type: SEQUENCE OWNED BY; Schema: lab3; Owner: postgres
--

ALTER SEQUENCE lab3.cars_car_id_seq OWNED BY lab3.cars.car_id;


--
-- TOC entry 226 (class 1259 OID 16461)
-- Name: driver; Type: TABLE; Schema: lab3; Owner: postgres
--

CREATE TABLE lab3.driver (
    driver_lisence_number integer,
    insurance_number integer NOT NULL,
    full_name character varying(50) NOT NULL,
    address character varying(100) NOT NULL,
    telephone_number character varying(11) NOT NULL,
    driver_id integer NOT NULL
);


ALTER TABLE lab3.driver OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 16581)
-- Name: driver_driver_id_seq; Type: SEQUENCE; Schema: lab3; Owner: postgres
--

CREATE SEQUENCE lab3.driver_driver_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE lab3.driver_driver_id_seq OWNER TO postgres;

--
-- TOC entry 3512 (class 0 OID 0)
-- Dependencies: 232
-- Name: driver_driver_id_seq; Type: SEQUENCE OWNED BY; Schema: lab3; Owner: postgres
--

ALTER SEQUENCE lab3.driver_driver_id_seq OWNED BY lab3.driver.driver_id;


--
-- TOC entry 225 (class 1259 OID 16456)
-- Name: driver_license; Type: TABLE; Schema: lab3; Owner: postgres
--

CREATE TABLE lab3.driver_license (
    driver_id integer NOT NULL,
    license_issue_date date NOT NULL,
    document_expiry_date date NOT NULL,
    issuing_organization character varying(50) NOT NULL,
    birth_date date NOT NULL,
    license_categories text[] NOT NULL,
    driver_license_number integer NOT NULL
);


ALTER TABLE lab3.driver_license OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 16589)
-- Name: driver_license_driver_license_number_seq; Type: SEQUENCE; Schema: lab3; Owner: postgres
--

CREATE SEQUENCE lab3.driver_license_driver_license_number_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE lab3.driver_license_driver_license_number_seq OWNER TO postgres;

--
-- TOC entry 3513 (class 0 OID 0)
-- Dependencies: 233
-- Name: driver_license_driver_license_number_seq; Type: SEQUENCE OWNED BY; Schema: lab3; Owner: postgres
--

ALTER SEQUENCE lab3.driver_license_driver_license_number_seq OWNED BY lab3.driver_license.driver_license_number;


--
-- TOC entry 222 (class 1259 OID 16422)
-- Name: insurances; Type: TABLE; Schema: lab3; Owner: postgres
--

CREATE TABLE lab3.insurances (
    start_date date NOT NULL,
    end_date date NOT NULL,
    coverage_amount integer NOT NULL,
    insurance_type character varying(20) NOT NULL,
    insurance_company character varying(50) NOT NULL,
    insurance_status character varying(10) NOT NULL,
    insurance_number integer NOT NULL
);


ALTER TABLE lab3.insurances OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 16598)
-- Name: insurances_insurance_number_seq; Type: SEQUENCE; Schema: lab3; Owner: postgres
--

CREATE SEQUENCE lab3.insurances_insurance_number_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE lab3.insurances_insurance_number_seq OWNER TO postgres;

--
-- TOC entry 3514 (class 0 OID 0)
-- Dependencies: 234
-- Name: insurances_insurance_number_seq; Type: SEQUENCE OWNED BY; Schema: lab3; Owner: postgres
--

ALTER SEQUENCE lab3.insurances_insurance_number_seq OWNED BY lab3.insurances.insurance_number;


--
-- TOC entry 220 (class 1259 OID 16405)
-- Name: officers; Type: TABLE; Schema: lab3; Owner: postgres
--

CREATE TABLE lab3.officers (
    full_name character varying(20) NOT NULL,
    officer_personal_number integer NOT NULL
);


ALTER TABLE lab3.officers OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 16605)
-- Name: officers_officer_personal_number_seq; Type: SEQUENCE; Schema: lab3; Owner: postgres
--

CREATE SEQUENCE lab3.officers_officer_personal_number_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE lab3.officers_officer_personal_number_seq OWNER TO postgres;

--
-- TOC entry 3515 (class 0 OID 0)
-- Dependencies: 235
-- Name: officers_officer_personal_number_seq; Type: SEQUENCE OWNED BY; Schema: lab3; Owner: postgres
--

ALTER SEQUENCE lab3.officers_officer_personal_number_seq OWNED BY lab3.officers.officer_personal_number;


--
-- TOC entry 228 (class 1259 OID 16496)
-- Name: participant; Type: TABLE; Schema: lab3; Owner: postgres
--

CREATE TABLE lab3.participant (
    role_id integer NOT NULL,
    driver_id integer NOT NULL,
    accident_code integer NOT NULL,
    fault character varying(20),
    participant_id integer NOT NULL
);


ALTER TABLE lab3.participant OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 16612)
-- Name: participant_participant_id_seq; Type: SEQUENCE; Schema: lab3; Owner: postgres
--

CREATE SEQUENCE lab3.participant_participant_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE lab3.participant_participant_id_seq OWNER TO postgres;

--
-- TOC entry 3516 (class 0 OID 0)
-- Dependencies: 236
-- Name: participant_participant_id_seq; Type: SEQUENCE OWNED BY; Schema: lab3; Owner: postgres
--

ALTER SEQUENCE lab3.participant_participant_id_seq OWNED BY lab3.participant.participant_id;


--
-- TOC entry 218 (class 1259 OID 16391)
-- Name: role; Type: TABLE; Schema: lab3; Owner: postgres
--

CREATE TABLE lab3.role (
    role_id integer NOT NULL,
    role_name character varying(50) NOT NULL
);


ALTER TABLE lab3.role OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 16619)
-- Name: role_role_id_seq; Type: SEQUENCE; Schema: lab3; Owner: postgres
--

CREATE SEQUENCE lab3.role_role_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE lab3.role_role_id_seq OWNER TO postgres;

--
-- TOC entry 3517 (class 0 OID 0)
-- Dependencies: 237
-- Name: role_role_id_seq; Type: SEQUENCE OWNED BY; Schema: lab3; Owner: postgres
--

ALTER SEQUENCE lab3.role_role_id_seq OWNED BY lab3.role.role_id;


--
-- TOC entry 219 (class 1259 OID 16398)
-- Name: traffic_code; Type: TABLE; Schema: lab3; Owner: postgres
--

CREATE TABLE lab3.traffic_code (
    traffic_rule_name character varying(20) NOT NULL,
    traffic_code_id integer NOT NULL
);


ALTER TABLE lab3.traffic_code OWNER TO postgres;

--
-- TOC entry 238 (class 1259 OID 16626)
-- Name: traffic_code_traffic_code_id_seq; Type: SEQUENCE; Schema: lab3; Owner: postgres
--

CREATE SEQUENCE lab3.traffic_code_traffic_code_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE lab3.traffic_code_traffic_code_id_seq OWNER TO postgres;

--
-- TOC entry 3518 (class 0 OID 0)
-- Dependencies: 238
-- Name: traffic_code_traffic_code_id_seq; Type: SEQUENCE OWNED BY; Schema: lab3; Owner: postgres
--

ALTER SEQUENCE lab3.traffic_code_traffic_code_id_seq OWNED BY lab3.traffic_code.traffic_code_id;


--
-- TOC entry 223 (class 1259 OID 16429)
-- Name: violations; Type: TABLE; Schema: lab3; Owner: postgres
--

CREATE TABLE lab3.violations (
    traffic_code_id integer NOT NULL,
    fine_amount integer NOT NULL,
    payment_amount integer NOT NULL,
    payment_date date,
    violation_status character varying(15) NOT NULL,
    violation_date_time timestamp without time zone NOT NULL,
    violation_address character varying(100) NOT NULL,
    disqualification_start_date date,
    disqualification_end_date date,
    payment_percentage double precision NOT NULL,
    violation_id integer NOT NULL
);


ALTER TABLE lab3.violations OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 16633)
-- Name: violations_violation_id_seq; Type: SEQUENCE; Schema: lab3; Owner: postgres
--

CREATE SEQUENCE lab3.violations_violation_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE lab3.violations_violation_id_seq OWNER TO postgres;

--
-- TOC entry 3519 (class 0 OID 0)
-- Dependencies: 239
-- Name: violations_violation_id_seq; Type: SEQUENCE OWNED BY; Schema: lab3; Owner: postgres
--

ALTER SEQUENCE lab3.violations_violation_id_seq OWNED BY lab3.violations.violation_id;


--
-- TOC entry 3267 (class 2604 OID 16559)
-- Name: accidents accident_code; Type: DEFAULT; Schema: lab3; Owner: postgres
--

ALTER TABLE ONLY lab3.accidents ALTER COLUMN accident_code SET DEFAULT nextval('lab3.accidents_accident_code_seq'::regclass);


--
-- TOC entry 3270 (class 2604 OID 16568)
-- Name: car_owner car_owner_id; Type: DEFAULT; Schema: lab3; Owner: postgres
--

ALTER TABLE ONLY lab3.car_owner ALTER COLUMN car_owner_id SET DEFAULT nextval('lab3.car_owner_car_owner_id_seq'::regclass);


--
-- TOC entry 3264 (class 2604 OID 16575)
-- Name: cars car_id; Type: DEFAULT; Schema: lab3; Owner: postgres
--

ALTER TABLE ONLY lab3.cars ALTER COLUMN car_id SET DEFAULT nextval('lab3.cars_car_id_seq'::regclass);


--
-- TOC entry 3269 (class 2604 OID 16582)
-- Name: driver driver_id; Type: DEFAULT; Schema: lab3; Owner: postgres
--

ALTER TABLE ONLY lab3.driver ALTER COLUMN driver_id SET DEFAULT nextval('lab3.driver_driver_id_seq'::regclass);


--
-- TOC entry 3268 (class 2604 OID 16590)
-- Name: driver_license driver_license_number; Type: DEFAULT; Schema: lab3; Owner: postgres
--

ALTER TABLE ONLY lab3.driver_license ALTER COLUMN driver_license_number SET DEFAULT nextval('lab3.driver_license_driver_license_number_seq'::regclass);


--
-- TOC entry 3265 (class 2604 OID 16599)
-- Name: insurances insurance_number; Type: DEFAULT; Schema: lab3; Owner: postgres
--

ALTER TABLE ONLY lab3.insurances ALTER COLUMN insurance_number SET DEFAULT nextval('lab3.insurances_insurance_number_seq'::regclass);


--
-- TOC entry 3263 (class 2604 OID 16606)
-- Name: officers officer_personal_number; Type: DEFAULT; Schema: lab3; Owner: postgres
--

ALTER TABLE ONLY lab3.officers ALTER COLUMN officer_personal_number SET DEFAULT nextval('lab3.officers_officer_personal_number_seq'::regclass);


--
-- TOC entry 3271 (class 2604 OID 16613)
-- Name: participant participant_id; Type: DEFAULT; Schema: lab3; Owner: postgres
--

ALTER TABLE ONLY lab3.participant ALTER COLUMN participant_id SET DEFAULT nextval('lab3.participant_participant_id_seq'::regclass);


--
-- TOC entry 3261 (class 2604 OID 16620)
-- Name: role role_id; Type: DEFAULT; Schema: lab3; Owner: postgres
--

ALTER TABLE ONLY lab3.role ALTER COLUMN role_id SET DEFAULT nextval('lab3.role_role_id_seq'::regclass);


--
-- TOC entry 3262 (class 2604 OID 16627)
-- Name: traffic_code traffic_code_id; Type: DEFAULT; Schema: lab3; Owner: postgres
--

ALTER TABLE ONLY lab3.traffic_code ALTER COLUMN traffic_code_id SET DEFAULT nextval('lab3.traffic_code_traffic_code_id_seq'::regclass);


--
-- TOC entry 3266 (class 2604 OID 16634)
-- Name: violations violation_id; Type: DEFAULT; Schema: lab3; Owner: postgres
--

ALTER TABLE ONLY lab3.violations ALTER COLUMN violation_id SET DEFAULT nextval('lab3.violations_violation_id_seq'::regclass);


--
-- TOC entry 3488 (class 0 OID 16439)
-- Dependencies: 224
-- Data for Name: accidents; Type: TABLE DATA; Schema: lab3; Owner: postgres
--

COPY lab3.accidents (violation_id, officer_personal_number, accident_address, accident_date_time, accident_description, accident_code) FROM stdin;
1	3	ул. Ленина, 10, Москва	2023-05-10 14:25:00	Столкновение двух автомобилей на регулируемом перекрестке при проезде на красный сигнал светофора	1
5	7	пр. Победы, 25, Санкт-Петербург	2023-05-12 09:15:00	Наезд на пешехода на нерегулируемом пешеходном переходе в условиях ограниченной видимости	2
2	1	ул. Гагарина, 5, Казань	2023-05-15 18:30:00	Опрокидывание грузового автомобиля с превышением скорости на крутом повороте	3
7	4	ул. Кирова, 20, Екатеринбург	2023-05-18 12:45:00	Столкновение с дорожным ограждением в результате заноса на мокрой дороге	4
3	9	ул. Советская, 8, Новосибирск	2023-05-20 16:20:00	Лобовое столкновение вне населенного пункта с выездом на полосу встречного движения	5
8	2	ул. Мира, 12, Нижний Новгород	2023-05-22 21:10:00	Наезд на дорожное препятствие (осветительный столб) в темное время суток	6
4	6	ул. Пушкина, 3, Самара	2023-05-25 11:30:00	Занос автомобиля с выездом на тротуар и наездом на дорожные ограждения	7
6	8	ул. Садовая, 7, Омск	2023-05-28 08:40:00	Столкновение при перестроении между двумя легковыми автомобилями	8
9	5	ул. Центральная, 25, Ростов-на-Дону	2023-05-30 19:15:00	Наезд на велосипедиста, двигавшегося по обочине в попутном направлении	9
10	10	ул. Лесная, 18, Уфа	2023-06-01 22:50:00	ДТП с участием 3-х транспортных средств при несоблюдении безопасной дистанции	10
\.


--
-- TOC entry 3491 (class 0 OID 16481)
-- Dependencies: 227
-- Data for Name: car_owner; Type: TABLE DATA; Schema: lab3; Owner: postgres
--

COPY lab3.car_owner (car_id, driver_id, owned_from, owned_until, car_owner_id) FROM stdin;
1	1	2020-01-15	2022-03-10	1
2	3	2019-05-20	\N	2
3	5	2021-02-28	2023-07-15	3
4	2	2018-11-10	\N	4
5	7	2020-06-05	2021-12-31	5
6	4	2022-01-01	\N	6
7	9	2019-08-15	2022-09-30	7
8	6	2021-03-22	\N	8
9	8	2020-04-10	2023-01-15	9
10	10	2022-02-18	\N	10
2	12	2022-03-11	\N	11
5	14	2022-01-01	\N	12
7	11	2022-10-01	\N	13
3	13	2023-07-16	\N	14
9	15	2023-01-16	\N	15
\.


--
-- TOC entry 3485 (class 0 OID 16412)
-- Dependencies: 221
-- Data for Name: cars; Type: TABLE DATA; Schema: lab3; Owner: postgres
--

COPY lab3.cars (registration_date, year_of_manufacture, car_number, brand, car_id) FROM stdin;
2020-05-15	2019-01-01	А123БВ777	Toyota Camry	1
2021-03-22	2020-01-01	Х456УК123	Honda CR-V	2
2019-11-10	2018-01-01	О789ТР45	Volkswagen Tiguan	3
2022-01-30	2021-01-01	Е321КХ98	Skoda Octavia	4
2018-07-05	2017-01-01	Р159АС66	Kia Sportage	5
2023-02-18	2022-01-01	Т753ВО11	Hyundai Solaris	6
2020-09-14	2019-01-01	У951НК22	Renault Duster	7
2021-12-25	2020-01-01	М357ЕЕ33	Lada Vesta	8
2019-04-07	2018-01-01	С642ЛО44	Ford Focus	9
2022-08-11	2021-01-01	К864РМ55	BMW X5	10
\.


--
-- TOC entry 3490 (class 0 OID 16461)
-- Dependencies: 226
-- Data for Name: driver; Type: TABLE DATA; Schema: lab3; Owner: postgres
--

COPY lab3.driver (driver_lisence_number, insurance_number, full_name, address, telephone_number, driver_id) FROM stdin;
1	5	Иванов Иван Иванович	г. Москва, ул. Ленина, д. 10, кв. 25	89161234567	1
2	3	Петров Петр Петрович	г. Санкт-Петербург, Невский пр-т, д. 15	89219876543	2
3	8	Сидорова Анна Михайловна	г. Казань, ул. Баумана, д. 5	89376543210	3
4	12	Кузнецов Алексей Владимирович	г. Екатеринбург, ул. Малышева, д. 33	89091234567	4
5	1	Смирнова Ольга Дмитриевна	г. Новосибирск, Красный пр-т, д. 28	89518765432	5
6	7	Федоров Дмитрий Сергеевич	г. Нижний Новгород, ул. Рождественская, д. 12	89107654321	6
7	10	Николаева Екатерина Андреевна	г. Самара, ул. Куйбышева, д. 45	89261234567	7
8	4	Орлов Михаил Викторович	г. Омск, ул. Ленина, д. 1	89876543210	8
9	15	Морозов Артем Игоревич	г. Ростов-на-Дону, ул. Большая Садовая, д. 10	89011234567	9
10	6	Волкова Татьяна Николаевна	г. Уфа, ул. Ленина, д. 42	89198765432	10
11	2	Лебедев Сергей Александрович	г. Краснодар, ул. Красная, д. 100	89261234567	11
12	9	Соколова Марина Викторовна	г. Челябинск, пр-т Ленина, д. 50	89876543210	12
13	11	Павлов Игорь Олегович	г. Воронеж, ул. Плехановская, д. 5	89031234567	13
14	14	Козлов Андрей Петрович	г. Пермь, ул. Ленина, д. 60	89128765432	14
15	13	Новикова Елена Владимировна	г. Волгоград, пр-т Ленина, д. 25	89211234567	15
\.


--
-- TOC entry 3489 (class 0 OID 16456)
-- Dependencies: 225
-- Data for Name: driver_license; Type: TABLE DATA; Schema: lab3; Owner: postgres
--

COPY lab3.driver_license (driver_id, license_issue_date, document_expiry_date, issuing_organization, birth_date, license_categories, driver_license_number) FROM stdin;
1	2018-05-15	2028-05-14	ГИБДД Москвы	1990-03-10	{B}	1
2	2019-03-22	2029-03-21	ГИБДД Санкт-Петербурга	1985-07-15	{B,C}	2
3	2020-11-10	2030-11-09	ГИБДД Казани	1992-11-20	{B,BE}	3
4	2021-01-30	2031-01-29	ГИБДД Екатеринбурга	1988-04-05	{B,D}	4
5	2017-07-05	2027-07-04	ГИБДД Новосибирска	1979-09-12	{B,C,CE}	5
6	2022-02-18	2032-02-17	ГИБДД Нижнего Новгорода	1995-02-28	{A,B}	6
7	2020-09-14	2030-09-13	ГИБДД Самары	1991-06-25	{B,C1,D1}	7
8	2021-12-25	2031-12-24	ГИБДД Омска	1983-12-30	{B,BE,C}	8
9	2019-04-07	2029-04-06	ГИБДД Ростова-на-Дону	1987-08-17	{A,B,C,D}	9
10	2022-08-11	2032-08-10	ГИБДД Уфы	1994-05-22	{B,C,CE}	10
11	2018-06-01	2028-05-31	ГИБДД Краснодара	1980-10-08	{B,D,DE}	11
12	2021-09-10	2031-09-09	ГИБДД Челябинска	1993-01-15	{A1,B1}	12
13	2020-03-15	2030-03-14	ГИБДД Воронежа	1986-07-20	{B,C1}	13
14	2019-12-01	2029-11-30	ГИБДД Перми	1990-11-05	{B,BE,C}	14
15	2023-01-05	2033-01-04	ГИБДД Волгограда	1996-04-18	{A,B,C}	15
\.


--
-- TOC entry 3486 (class 0 OID 16422)
-- Dependencies: 222
-- Data for Name: insurances; Type: TABLE DATA; Schema: lab3; Owner: postgres
--

COPY lab3.insurances (start_date, end_date, coverage_amount, insurance_type, insurance_company, insurance_status, insurance_number) FROM stdin;
2023-01-15	2024-01-14	500000	ОСАГО	Росгосстрах	активна	1
2022-11-20	2023-11-19	500000	ОСАГО	Ингосстрах	неактивна	2
2023-03-10	2024-03-09	500000	ОСАГО	СОГАЗ	активна	3
2021-05-05	2022-05-04	400000	ОСАГО	РЕСО-Гарантия	неактивна	4
2023-02-28	2024-02-27	500000	ОСАГО	АльфаСтрахование	активна	5
2023-01-01	2024-01-01	1500000	КАСКО	ВТБ Страхование	активна	6
2022-07-15	2023-07-14	2000000	КАСКО	СберСтрахование	неактивна	7
2023-04-20	2024-04-19	1800000	КАСКО	Ренессанс Страхование	активна	8
2022-12-10	2023-12-09	1200000	КАСКО	Тинькофф Страхование	неактивна	9
2023-05-15	2024-05-14	1700000	КАСКО	Зетта Страхование	активна	10
2023-06-01	2024-05-31	500000	ОСАГО	Росгосстрах	активна	11
2022-09-10	2023-09-09	2000000	КАСКО	АльфаСтрахование	неактивна	12
2023-03-15	2024-03-14	500000	ОСАГО	СОГАЗ	активна	13
2022-12-01	2023-11-30	1600000	КАСКО	ВТБ Страхование	неактивна	14
2023-07-01	2024-06-30	500000	ОСАГО	РЕСО-Гарантия	активна	15
\.


--
-- TOC entry 3484 (class 0 OID 16405)
-- Dependencies: 220
-- Data for Name: officers; Type: TABLE DATA; Schema: lab3; Owner: postgres
--

COPY lab3.officers (full_name, officer_personal_number) FROM stdin;
Иванов А.А.	1
Петров Б.В.	2
Сидоров Г.Д.	3
Кузнецова Е.Ж.	4
Смирнов В.Г.	5
Ковалёва М.Н.	6
Николаев Р.С.	7
Орлова Т.П.	8
Фёдоров Д.Л.	9
Морозова А.К.	10
\.


--
-- TOC entry 3492 (class 0 OID 16496)
-- Dependencies: 228
-- Data for Name: participant; Type: TABLE DATA; Schema: lab3; Owner: postgres
--

COPY lab3.participant (role_id, driver_id, accident_code, fault, participant_id) FROM stdin;
1	3	5	виновен	1
2	7	2	виновен	2
3	1	8	виновен	3
4	9	3	виновен	4
5	2	7	виновен	5
1	4	1	невиновен	6
2	6	4	невиновен	7
3	8	6	невиновен	8
4	5	9	невиновен	9
5	10	10	невиновен	10
1	2	3	\N	11
2	3	5	\N	12
3	5	7	\N	13
4	7	2	\N	14
5	1	4	\N	15
\.


--
-- TOC entry 3482 (class 0 OID 16391)
-- Dependencies: 218
-- Data for Name: role; Type: TABLE DATA; Schema: lab3; Owner: postgres
--

COPY lab3.role (role_id, role_name) FROM stdin;
1	водитель транспортного средства
2	виновник дтп
3	пострадавший
4	свидетель
5	понятый
\.


--
-- TOC entry 3483 (class 0 OID 16398)
-- Dependencies: 219
-- Data for Name: traffic_code; Type: TABLE DATA; Schema: lab3; Owner: postgres
--

COPY lab3.traffic_code (traffic_rule_name, traffic_code_id) FROM stdin;
1.1	1
1.2	2
1.3	3
1.4	4
1.5	5
2.1	6
2.1.1	7
2.1.2	8
2.2	9
2.3	10
2.3.1	11
3.1	12
3.2	13
3.3	14
3.4	15
3.5	16
4.1	17
4.2	18
4.3	19
4.4	20
4.5	21
5.1	22
5.2	23
5.3	24
5.4	25
5.5	26
6.1	27
6.2	28
6.3	29
6.4	30
6.5	31
7.1	32
7.2	33
7.3	34
7.4	35
7.5	36
\.


--
-- TOC entry 3487 (class 0 OID 16429)
-- Dependencies: 223
-- Data for Name: violations; Type: TABLE DATA; Schema: lab3; Owner: postgres
--

COPY lab3.violations (traffic_code_id, fine_amount, payment_amount, payment_date, violation_status, violation_date_time, violation_address, disqualification_start_date, disqualification_end_date, payment_percentage, violation_id) FROM stdin;
7	5000	5000	2023-05-10	оплачено	2023-05-01 14:25:00	ул. Ленина, 10	\N	\N	1	1
3	3000	3000	2023-05-12	оплачено	2023-05-05 09:15:00	пр. Победы, 15	\N	\N	1	2
15	2000	2000	2023-05-15	оплачено	2023-05-10 18:30:00	ул. Гагарина, 5	\N	\N	1	3
12	4000	1000	2023-05-18	не оплачено	2023-05-12 12:45:00	ул. Кирова, 20	2023-05-18	2023-06-18	0.25	4
5	5000	2500	2023-05-20	не оплачено	2023-05-15 16:20:00	ул. Советская, 8	2023-05-20	2023-07-20	0.5	5
18	6000	4500	2023-05-22	не оплачено	2023-05-18 21:10:00	ул. Мира, 12	2023-05-22	2023-08-22	0.75	6
9	3500	0	\N	не оплачено	2023-05-25 11:30:00	ул. Пушкина, 3	2023-05-25	2023-08-25	0	7
2	2500	0	\N	не оплачено	2023-05-28 08:40:00	ул. Садовая, 7	2023-05-28	2023-07-28	0	8
14	4500	0	\N	не оплачено	2023-05-30 19:15:00	ул. Центральная, 25	2023-05-30	2023-11-30	0	9
8	5500	0	\N	не оплачено	2023-06-01 22:50:00	ул. Лесная, 18	2023-06-01	2024-06-01	0	10
\.


--
-- TOC entry 3520 (class 0 OID 0)
-- Dependencies: 229
-- Name: accidents_accident_code_seq; Type: SEQUENCE SET; Schema: lab3; Owner: postgres
--

SELECT pg_catalog.setval('lab3.accidents_accident_code_seq', 30, true);


--
-- TOC entry 3521 (class 0 OID 0)
-- Dependencies: 230
-- Name: car_owner_car_owner_id_seq; Type: SEQUENCE SET; Schema: lab3; Owner: postgres
--

SELECT pg_catalog.setval('lab3.car_owner_car_owner_id_seq', 15, true);


--
-- TOC entry 3522 (class 0 OID 0)
-- Dependencies: 231
-- Name: cars_car_id_seq; Type: SEQUENCE SET; Schema: lab3; Owner: postgres
--

SELECT pg_catalog.setval('lab3.cars_car_id_seq', 11, true);


--
-- TOC entry 3523 (class 0 OID 0)
-- Dependencies: 232
-- Name: driver_driver_id_seq; Type: SEQUENCE SET; Schema: lab3; Owner: postgres
--

SELECT pg_catalog.setval('lab3.driver_driver_id_seq', 15, true);


--
-- TOC entry 3524 (class 0 OID 0)
-- Dependencies: 233
-- Name: driver_license_driver_license_number_seq; Type: SEQUENCE SET; Schema: lab3; Owner: postgres
--

SELECT pg_catalog.setval('lab3.driver_license_driver_license_number_seq', 15, true);


--
-- TOC entry 3525 (class 0 OID 0)
-- Dependencies: 234
-- Name: insurances_insurance_number_seq; Type: SEQUENCE SET; Schema: lab3; Owner: postgres
--

SELECT pg_catalog.setval('lab3.insurances_insurance_number_seq', 15, true);


--
-- TOC entry 3526 (class 0 OID 0)
-- Dependencies: 235
-- Name: officers_officer_personal_number_seq; Type: SEQUENCE SET; Schema: lab3; Owner: postgres
--

SELECT pg_catalog.setval('lab3.officers_officer_personal_number_seq', 10, true);


--
-- TOC entry 3527 (class 0 OID 0)
-- Dependencies: 236
-- Name: participant_participant_id_seq; Type: SEQUENCE SET; Schema: lab3; Owner: postgres
--

SELECT pg_catalog.setval('lab3.participant_participant_id_seq', 30, true);


--
-- TOC entry 3528 (class 0 OID 0)
-- Dependencies: 237
-- Name: role_role_id_seq; Type: SEQUENCE SET; Schema: lab3; Owner: postgres
--

SELECT pg_catalog.setval('lab3.role_role_id_seq', 5, true);


--
-- TOC entry 3529 (class 0 OID 0)
-- Dependencies: 238
-- Name: traffic_code_traffic_code_id_seq; Type: SEQUENCE SET; Schema: lab3; Owner: postgres
--

SELECT pg_catalog.setval('lab3.traffic_code_traffic_code_id_seq', 36, true);


--
-- TOC entry 3530 (class 0 OID 0)
-- Dependencies: 239
-- Name: violations_violation_id_seq; Type: SEQUENCE SET; Schema: lab3; Owner: postgres
--

SELECT pg_catalog.setval('lab3.violations_violation_id_seq', 19, true);


--
-- TOC entry 3317 (class 2606 OID 16566)
-- Name: accidents accidents_pkey; Type: CONSTRAINT; Schema: lab3; Owner: postgres
--

ALTER TABLE ONLY lab3.accidents
    ADD CONSTRAINT accidents_pkey PRIMARY KEY (accident_code);


--
-- TOC entry 3298 (class 2606 OID 16550)
-- Name: driver address_check; Type: CHECK CONSTRAINT; Schema: lab3; Owner: postgres
--

ALTER TABLE lab3.driver
    ADD CONSTRAINT address_check CHECK (((address)::text <> ''::text)) NOT VALID;


--
-- TOC entry 3294 (class 2606 OID 16543)
-- Name: driver_license birth_date_check; Type: CHECK CONSTRAINT; Schema: lab3; Owner: postgres
--

ALTER TABLE lab3.driver_license
    ADD CONSTRAINT birth_date_check CHECK ((EXTRACT(year FROM birth_date) > (1900)::numeric)) NOT VALID;


--
-- TOC entry 3274 (class 2606 OID 16528)
-- Name: cars brand_check; Type: CHECK CONSTRAINT; Schema: lab3; Owner: postgres
--

ALTER TABLE lab3.cars
    ADD CONSTRAINT brand_check CHECK (((brand)::text <> ''::text)) NOT VALID;


--
-- TOC entry 3323 (class 2606 OID 16573)
-- Name: car_owner car_owner_pkey; Type: CONSTRAINT; Schema: lab3; Owner: postgres
--

ALTER TABLE ONLY lab3.car_owner
    ADD CONSTRAINT car_owner_pkey PRIMARY KEY (car_owner_id);


--
-- TOC entry 3311 (class 2606 OID 16580)
-- Name: cars cars_pkey; Type: CONSTRAINT; Schema: lab3; Owner: postgres
--

ALTER TABLE ONLY lab3.cars
    ADD CONSTRAINT cars_pkey PRIMARY KEY (car_id);


--
-- TOC entry 3291 (class 2606 OID 16518)
-- Name: accidents check_accident_date_time; Type: CHECK CONSTRAINT; Schema: lab3; Owner: postgres
--

ALTER TABLE lab3.accidents
    ADD CONSTRAINT check_accident_date_time CHECK ((accident_date_time < CURRENT_TIMESTAMP)) NOT VALID;


--
-- TOC entry 3292 (class 2606 OID 16516)
-- Name: accidents check_address; Type: CHECK CONSTRAINT; Schema: lab3; Owner: postgres
--

ALTER TABLE lab3.accidents
    ADD CONSTRAINT check_address CHECK (((accident_address)::text <> ''::text)) NOT VALID;


--
-- TOC entry 3293 (class 2606 OID 16517)
-- Name: accidents check_description; Type: CHECK CONSTRAINT; Schema: lab3; Owner: postgres
--

ALTER TABLE lab3.accidents
    ADD CONSTRAINT check_description CHECK (((accident_description)::text <> ''::text)) NOT VALID;


--
-- TOC entry 3301 (class 2606 OID 16520)
-- Name: car_owner check_owned_from; Type: CHECK CONSTRAINT; Schema: lab3; Owner: postgres
--

ALTER TABLE lab3.car_owner
    ADD CONSTRAINT check_owned_from CHECK ((EXTRACT(year FROM owned_from) > (1900)::numeric)) NOT VALID;


--
-- TOC entry 3302 (class 2606 OID 16522)
-- Name: car_owner check_owned_until; Type: CHECK CONSTRAINT; Schema: lab3; Owner: postgres
--

ALTER TABLE lab3.car_owner
    ADD CONSTRAINT check_owned_until CHECK (((owned_from < owned_until) OR (owned_until IS NULL))) NOT VALID;


--
-- TOC entry 3277 (class 2606 OID 16556)
-- Name: insurances coverage_amount_check; Type: CHECK CONSTRAINT; Schema: lab3; Owner: postgres
--

ALTER TABLE lab3.insurances
    ADD CONSTRAINT coverage_amount_check CHECK ((coverage_amount >= 0)) NOT VALID;


--
-- TOC entry 3283 (class 2606 OID 16541)
-- Name: violations disaualification_dates_check; Type: CHECK CONSTRAINT; Schema: lab3; Owner: postgres
--

ALTER TABLE lab3.violations
    ADD CONSTRAINT disaualification_dates_check CHECK (((disqualification_start_date < disqualification_end_date) OR ((disqualification_end_date IS NULL) AND (disqualification_start_date IS NULL)))) NOT VALID;


--
-- TOC entry 3295 (class 2606 OID 16545)
-- Name: driver_license document_expiry_date_ckeck; Type: CHECK CONSTRAINT; Schema: lab3; Owner: postgres
--

ALTER TABLE lab3.driver_license
    ADD CONSTRAINT document_expiry_date_ckeck CHECK (((document_expiry_date > license_issue_date) AND (document_expiry_date < (license_issue_date + '20 years'::interval)))) NOT VALID;


--
-- TOC entry 3319 (class 2606 OID 16597)
-- Name: driver_license driver_license_pkey; Type: CONSTRAINT; Schema: lab3; Owner: postgres
--

ALTER TABLE ONLY lab3.driver_license
    ADD CONSTRAINT driver_license_pkey PRIMARY KEY (driver_license_number);


--
-- TOC entry 3321 (class 2606 OID 16587)
-- Name: driver driver_pkey; Type: CONSTRAINT; Schema: lab3; Owner: postgres
--

ALTER TABLE ONLY lab3.driver
    ADD CONSTRAINT driver_pkey PRIMARY KEY (driver_id);


--
-- TOC entry 3278 (class 2606 OID 16555)
-- Name: insurances end_date_check; Type: CHECK CONSTRAINT; Schema: lab3; Owner: postgres
--

ALTER TABLE lab3.insurances
    ADD CONSTRAINT end_date_check CHECK (((end_date > start_date) AND (end_date < (start_date + '5 years'::interval)))) NOT VALID;


--
-- TOC entry 3303 (class 2606 OID 16533)
-- Name: participant fault_check; Type: CHECK CONSTRAINT; Schema: lab3; Owner: postgres
--

ALTER TABLE lab3.participant
    ADD CONSTRAINT fault_check CHECK ((((fault)::text = ANY ((ARRAY['виновен'::character varying, 'невиновен'::character varying])::text[])) OR (fault IS NULL))) NOT VALID;


--
-- TOC entry 3284 (class 2606 OID 16534)
-- Name: violations fine_amount_ckeck; Type: CHECK CONSTRAINT; Schema: lab3; Owner: postgres
--

ALTER TABLE lab3.violations
    ADD CONSTRAINT fine_amount_ckeck CHECK ((fine_amount > 0)) NOT VALID;


--
-- TOC entry 3273 (class 2606 OID 16531)
-- Name: officers full_name_check; Type: CHECK CONSTRAINT; Schema: lab3; Owner: postgres
--

ALTER TABLE lab3.officers
    ADD CONSTRAINT full_name_check CHECK (((full_name)::text <> ''::text)) NOT VALID;


--
-- TOC entry 3299 (class 2606 OID 16549)
-- Name: driver full_name_check; Type: CHECK CONSTRAINT; Schema: lab3; Owner: postgres
--

ALTER TABLE lab3.driver
    ADD CONSTRAINT full_name_check CHECK (((full_name)::text <> ''::text)) NOT VALID;


--
-- TOC entry 3279 (class 2606 OID 16553)
-- Name: insurances insurance_company_check; Type: CHECK CONSTRAINT; Schema: lab3; Owner: postgres
--

ALTER TABLE lab3.insurances
    ADD CONSTRAINT insurance_company_check CHECK (((insurance_company)::text <> ''::text)) NOT VALID;


--
-- TOC entry 3280 (class 2606 OID 16557)
-- Name: insurances insurance_status_check; Type: CHECK CONSTRAINT; Schema: lab3; Owner: postgres
--

ALTER TABLE lab3.insurances
    ADD CONSTRAINT insurance_status_check CHECK (((insurance_status)::text = ANY ((ARRAY['активна'::character varying, 'неактивна'::character varying])::text[]))) NOT VALID;


--
-- TOC entry 3281 (class 2606 OID 16552)
-- Name: insurances insurance_type_check; Type: CHECK CONSTRAINT; Schema: lab3; Owner: postgres
--

ALTER TABLE lab3.insurances
    ADD CONSTRAINT insurance_type_check CHECK (((insurance_type)::text = ANY ((ARRAY['ОСАГО'::character varying, 'КАСКО'::character varying])::text[]))) NOT VALID;


--
-- TOC entry 3313 (class 2606 OID 16604)
-- Name: insurances insurances_pkey; Type: CONSTRAINT; Schema: lab3; Owner: postgres
--

ALTER TABLE ONLY lab3.insurances
    ADD CONSTRAINT insurances_pkey PRIMARY KEY (insurance_number);


--
-- TOC entry 3296 (class 2606 OID 16548)
-- Name: driver_license license_categories_ckeck; Type: CHECK CONSTRAINT; Schema: lab3; Owner: postgres
--

ALTER TABLE lab3.driver_license
    ADD CONSTRAINT license_categories_ckeck CHECK (((license_categories <@ ARRAY['A'::text, 'B'::text, 'C'::text, 'D'::text, 'E'::text, 'A1'::text, 'B1'::text, 'C1'::text, 'D1'::text, 'BE'::text, 'CE'::text, 'DE'::text]) AND (array_length(license_categories, 1) > 0))) NOT VALID;


--
-- TOC entry 3297 (class 2606 OID 16544)
-- Name: driver_license license_issue_date_check; Type: CHECK CONSTRAINT; Schema: lab3; Owner: postgres
--

ALTER TABLE lab3.driver_license
    ADD CONSTRAINT license_issue_date_check CHECK ((license_issue_date >= (birth_date + '14 years'::interval))) NOT VALID;


--
-- TOC entry 3309 (class 2606 OID 16611)
-- Name: officers officers_pkey; Type: CONSTRAINT; Schema: lab3; Owner: postgres
--

ALTER TABLE ONLY lab3.officers
    ADD CONSTRAINT officers_pkey PRIMARY KEY (officer_personal_number);


--
-- TOC entry 3325 (class 2606 OID 16618)
-- Name: participant participant_pkey; Type: CONSTRAINT; Schema: lab3; Owner: postgres
--

ALTER TABLE ONLY lab3.participant
    ADD CONSTRAINT participant_pkey PRIMARY KEY (participant_id);


--
-- TOC entry 3285 (class 2606 OID 16535)
-- Name: violations payment_amount_check; Type: CHECK CONSTRAINT; Schema: lab3; Owner: postgres
--

ALTER TABLE lab3.violations
    ADD CONSTRAINT payment_amount_check CHECK ((payment_amount <= fine_amount)) NOT VALID;


--
-- TOC entry 3286 (class 2606 OID 16697)
-- Name: violations payment_date_check; Type: CHECK CONSTRAINT; Schema: lab3; Owner: postgres
--

ALTER TABLE lab3.violations
    ADD CONSTRAINT payment_date_check CHECK ((payment_date > (violation_date_time)::date)) NOT VALID;


--
-- TOC entry 3287 (class 2606 OID 16698)
-- Name: violations payment_percentage_check; Type: CHECK CONSTRAINT; Schema: lab3; Owner: postgres
--

ALTER TABLE lab3.violations
    ADD CONSTRAINT payment_percentage_check CHECK (((payment_percentage >= (0.0)::double precision) AND (payment_percentage <= (1.0)::double precision))) NOT VALID;


--
-- TOC entry 3275 (class 2606 OID 16696)
-- Name: cars rigistration_date_check; Type: CHECK CONSTRAINT; Schema: lab3; Owner: postgres
--

ALTER TABLE lab3.cars
    ADD CONSTRAINT rigistration_date_check CHECK ((registration_date >= year_of_manufacture)) NOT VALID;


--
-- TOC entry 3305 (class 2606 OID 16625)
-- Name: role role_pkey; Type: CONSTRAINT; Schema: lab3; Owner: postgres
--

ALTER TABLE ONLY lab3.role
    ADD CONSTRAINT role_pkey PRIMARY KEY (role_id);


--
-- TOC entry 3282 (class 2606 OID 16554)
-- Name: insurances start_date_check; Type: CHECK CONSTRAINT; Schema: lab3; Owner: postgres
--

ALTER TABLE lab3.insurances
    ADD CONSTRAINT start_date_check CHECK ((EXTRACT(year FROM start_date) > (1991)::numeric)) NOT VALID;


--
-- TOC entry 3300 (class 2606 OID 16551)
-- Name: driver telephone_number_check; Type: CHECK CONSTRAINT; Schema: lab3; Owner: postgres
--

ALTER TABLE lab3.driver
    ADD CONSTRAINT telephone_number_check CHECK ((((telephone_number)::text <> ''::text) AND ((telephone_number)::text ~~ '89_________'::text))) NOT VALID;


--
-- TOC entry 3307 (class 2606 OID 16632)
-- Name: traffic_code traffic_code_pkey; Type: CONSTRAINT; Schema: lab3; Owner: postgres
--

ALTER TABLE ONLY lab3.traffic_code
    ADD CONSTRAINT traffic_code_pkey PRIMARY KEY (traffic_code_id);


--
-- TOC entry 3272 (class 2606 OID 16542)
-- Name: traffic_code traffic_rule_name_ckeck; Type: CHECK CONSTRAINT; Schema: lab3; Owner: postgres
--

ALTER TABLE lab3.traffic_code
    ADD CONSTRAINT traffic_rule_name_ckeck CHECK (((traffic_rule_name)::text <> ''::text)) NOT VALID;


--
-- TOC entry 3288 (class 2606 OID 16540)
-- Name: violations violation_address_check; Type: CHECK CONSTRAINT; Schema: lab3; Owner: postgres
--

ALTER TABLE lab3.violations
    ADD CONSTRAINT violation_address_check CHECK (((violation_address)::text <> ''::text)) NOT VALID;


--
-- TOC entry 3289 (class 2606 OID 16539)
-- Name: violations violation_date_time_check; Type: CHECK CONSTRAINT; Schema: lab3; Owner: postgres
--

ALTER TABLE lab3.violations
    ADD CONSTRAINT violation_date_time_check CHECK ((violation_date_time < now())) NOT VALID;


--
-- TOC entry 3290 (class 2606 OID 16538)
-- Name: violations violation_status_check; Type: CHECK CONSTRAINT; Schema: lab3; Owner: postgres
--

ALTER TABLE lab3.violations
    ADD CONSTRAINT violation_status_check CHECK (((violation_status)::text = ANY ((ARRAY['оплачено'::character varying, 'не оплачено'::character varying])::text[]))) NOT VALID;


--
-- TOC entry 3315 (class 2606 OID 16639)
-- Name: violations violations_pkey; Type: CONSTRAINT; Schema: lab3; Owner: postgres
--

ALTER TABLE ONLY lab3.violations
    ADD CONSTRAINT violations_pkey PRIMARY KEY (violation_id);


--
-- TOC entry 3276 (class 2606 OID 16530)
-- Name: cars year_of_manufacture_check; Type: CHECK CONSTRAINT; Schema: lab3; Owner: postgres
--

ALTER TABLE lab3.cars
    ADD CONSTRAINT year_of_manufacture_check CHECK (((EXTRACT(year FROM year_of_manufacture) >= (1886)::numeric) AND (EXTRACT(year FROM year_of_manufacture) <= EXTRACT(year FROM CURRENT_DATE)))) NOT VALID;


--
-- TOC entry 3334 (class 2606 OID 16676)
-- Name: participant accident_code_fkey; Type: FK CONSTRAINT; Schema: lab3; Owner: postgres
--

ALTER TABLE ONLY lab3.participant
    ADD CONSTRAINT accident_code_fkey FOREIGN KEY (accident_code) REFERENCES lab3.accidents(accident_code) NOT VALID;


--
-- TOC entry 3332 (class 2606 OID 16651)
-- Name: car_owner car_id_fkey; Type: FK CONSTRAINT; Schema: lab3; Owner: postgres
--

ALTER TABLE ONLY lab3.car_owner
    ADD CONSTRAINT car_id_fkey FOREIGN KEY (car_id) REFERENCES lab3.cars(car_id) NOT VALID;


--
-- TOC entry 3333 (class 2606 OID 16656)
-- Name: car_owner driver_id_fkey; Type: FK CONSTRAINT; Schema: lab3; Owner: postgres
--

ALTER TABLE ONLY lab3.car_owner
    ADD CONSTRAINT driver_id_fkey FOREIGN KEY (driver_id) REFERENCES lab3.driver(driver_id) NOT VALID;


--
-- TOC entry 3329 (class 2606 OID 16671)
-- Name: driver_license driver_id_fkey; Type: FK CONSTRAINT; Schema: lab3; Owner: postgres
--

ALTER TABLE ONLY lab3.driver_license
    ADD CONSTRAINT driver_id_fkey FOREIGN KEY (driver_id) REFERENCES lab3.driver(driver_id) NOT VALID;


--
-- TOC entry 3335 (class 2606 OID 16681)
-- Name: participant driver_id_fkey; Type: FK CONSTRAINT; Schema: lab3; Owner: postgres
--

ALTER TABLE ONLY lab3.participant
    ADD CONSTRAINT driver_id_fkey FOREIGN KEY (driver_id) REFERENCES lab3.driver(driver_id) NOT VALID;


--
-- TOC entry 3330 (class 2606 OID 16661)
-- Name: driver driver_license_number_fkey; Type: FK CONSTRAINT; Schema: lab3; Owner: postgres
--

ALTER TABLE ONLY lab3.driver
    ADD CONSTRAINT driver_license_number_fkey FOREIGN KEY (driver_lisence_number) REFERENCES lab3.driver_license(driver_license_number) NOT VALID;


--
-- TOC entry 3331 (class 2606 OID 16666)
-- Name: driver insurance_number_fkey; Type: FK CONSTRAINT; Schema: lab3; Owner: postgres
--

ALTER TABLE ONLY lab3.driver
    ADD CONSTRAINT insurance_number_fkey FOREIGN KEY (insurance_number) REFERENCES lab3.insurances(insurance_number) NOT VALID;


--
-- TOC entry 3327 (class 2606 OID 16641)
-- Name: accidents officer_personal_number_fkey; Type: FK CONSTRAINT; Schema: lab3; Owner: postgres
--

ALTER TABLE ONLY lab3.accidents
    ADD CONSTRAINT officer_personal_number_fkey FOREIGN KEY (officer_personal_number) REFERENCES lab3.officers(officer_personal_number) NOT VALID;


--
-- TOC entry 3336 (class 2606 OID 16686)
-- Name: participant role_id_fkey; Type: FK CONSTRAINT; Schema: lab3; Owner: postgres
--

ALTER TABLE ONLY lab3.participant
    ADD CONSTRAINT role_id_fkey FOREIGN KEY (role_id) REFERENCES lab3.role(role_id) NOT VALID;


--
-- TOC entry 3326 (class 2606 OID 16691)
-- Name: violations traffic_code_fkey; Type: FK CONSTRAINT; Schema: lab3; Owner: postgres
--

ALTER TABLE ONLY lab3.violations
    ADD CONSTRAINT traffic_code_fkey FOREIGN KEY (traffic_code_id) REFERENCES lab3.traffic_code(traffic_code_id) NOT VALID;


--
-- TOC entry 3328 (class 2606 OID 16646)
-- Name: accidents violation_id_fkey; Type: FK CONSTRAINT; Schema: lab3; Owner: postgres
--

ALTER TABLE ONLY lab3.accidents
    ADD CONSTRAINT violation_id_fkey FOREIGN KEY (violation_id) REFERENCES lab3.violations(violation_id) NOT VALID;


-- Completed on 2025-04-03 11:26:55 UTC

--
-- PostgreSQL database dump complete
--

