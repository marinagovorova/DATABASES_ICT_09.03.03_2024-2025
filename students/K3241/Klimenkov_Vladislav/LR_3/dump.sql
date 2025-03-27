--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4
-- Dumped by pg_dump version 17.4

-- Started on 2025-03-27 16:22:26

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 228 (class 1259 OID 16484)
-- Name: administrator; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.administrator (
    employee_id integer NOT NULL,
    call_center_number integer NOT NULL,
    CONSTRAINT check_call_center_number CHECK ((call_center_number >= 1))
);


ALTER TABLE public.administrator OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 16548)
-- Name: bank_card; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bank_card (
    id integer NOT NULL,
    number character varying(16) NOT NULL,
    passenger_id integer NOT NULL,
    CONSTRAINT check_number CHECK (((number)::text ~ '^[0-9]+$'::text))
);


ALTER TABLE public.bank_card OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 16547)
-- Name: bank_card_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.bank_card_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.bank_card_id_seq OWNER TO postgres;

--
-- TOC entry 5025 (class 0 OID 0)
-- Dependencies: 234
-- Name: bank_card_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.bank_card_id_seq OWNED BY public.bank_card.id;


--
-- TOC entry 239 (class 1259 OID 16577)
-- Name: car; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.car (
    id integer NOT NULL,
    model_id integer NOT NULL,
    owner character varying(20) NOT NULL,
    cost integer NOT NULL,
    license_plate character varying(10) NOT NULL,
    year_manufacture smallint NOT NULL,
    car_mileage integer NOT NULL,
    last_maintenance_date date NOT NULL,
    CONSTRAINT check_car_mileage CHECK ((car_mileage >= 0)),
    CONSTRAINT check_cost CHECK ((cost >= 0)),
    CONSTRAINT check_license_plate CHECK (((license_plate)::text ~ '^[АВЕКМНОРСТУХABEKMHOPCTYX]\d{3}[АВЕКМНОРСТУХABEKMHOPCTYX]{2}\d{2,3}$'::text)),
    CONSTRAINT check_owner CHECK (((owner)::text = ANY ((ARRAY['компания'::character varying, 'водитель'::character varying])::text[]))),
    CONSTRAINT check_year_manufacture CHECK (((year_manufacture >= 2000) AND ((year_manufacture)::numeric <= EXTRACT(year FROM CURRENT_DATE))))
);


ALTER TABLE public.car OWNER TO postgres;

--
-- TOC entry 238 (class 1259 OID 16576)
-- Name: car_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.car_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.car_id_seq OWNER TO postgres;

--
-- TOC entry 5026 (class 0 OID 0)
-- Dependencies: 238
-- Name: car_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.car_id_seq OWNED BY public.car.id;


--
-- TOC entry 237 (class 1259 OID 16561)
-- Name: car_model; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.car_model (
    id integer NOT NULL,
    make_and_model character varying(50) NOT NULL,
    country character varying(30) NOT NULL,
    characteristics character varying(255) NOT NULL
);


ALTER TABLE public.car_model OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 16560)
-- Name: car_model_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.car_model_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.car_model_id_seq OWNER TO postgres;

--
-- TOC entry 5027 (class 0 OID 0)
-- Dependencies: 236
-- Name: car_model_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.car_model_id_seq OWNED BY public.car_model.id;


--
-- TOC entry 241 (class 1259 OID 16592)
-- Name: car_usage; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.car_usage (
    id integer NOT NULL,
    driver_id integer NOT NULL,
    car_id integer NOT NULL,
    start_date date NOT NULL,
    end_date date,
    CONSTRAINT check_date CHECK ((end_date > start_date))
);


ALTER TABLE public.car_usage OWNER TO postgres;

--
-- TOC entry 240 (class 1259 OID 16591)
-- Name: car_usage_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.car_usage_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.car_usage_id_seq OWNER TO postgres;

--
-- TOC entry 5028 (class 0 OID 0)
-- Dependencies: 240
-- Name: car_usage_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.car_usage_id_seq OWNED BY public.car_usage.id;


--
-- TOC entry 247 (class 1259 OID 16639)
-- Name: cost_adjustment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cost_adjustment (
    id integer NOT NULL,
    time_of_day character varying(20) NOT NULL,
    traffic_level integer NOT NULL,
    ratio real NOT NULL,
    start_date timestamp without time zone NOT NULL,
    end_date timestamp without time zone,
    CONSTRAINT check_date CHECK ((end_date > start_date)),
    CONSTRAINT check_ratio CHECK (((ratio > (0)::double precision) AND (ratio <= (5)::double precision))),
    CONSTRAINT check_time_of_day CHECK (((time_of_day)::text = ANY ((ARRAY['день'::character varying, 'вечер'::character varying, 'ночь'::character varying, 'утро'::character varying])::text[]))),
    CONSTRAINT check_traffic_level CHECK (((traffic_level >= 0) AND (traffic_level <= 10)))
);


ALTER TABLE public.cost_adjustment OWNER TO postgres;

--
-- TOC entry 246 (class 1259 OID 16638)
-- Name: cost_adjustment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cost_adjustment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cost_adjustment_id_seq OWNER TO postgres;

--
-- TOC entry 5029 (class 0 OID 0)
-- Dependencies: 246
-- Name: cost_adjustment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cost_adjustment_id_seq OWNED BY public.cost_adjustment.id;


--
-- TOC entry 230 (class 1259 OID 16497)
-- Name: driver; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.driver (
    employee_id integer NOT NULL,
    license_number character(11) NOT NULL,
    geolocation character(15),
    CONSTRAINT check_geolocation CHECK ((geolocation ~ '^[0-9.,]+$'::text)),
    CONSTRAINT check_license_number CHECK ((license_number ~ '^[0-9 ]+$'::text))
);


ALTER TABLE public.driver OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 16496)
-- Name: driver_employee_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.driver_employee_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.driver_employee_id_seq OWNER TO postgres;

--
-- TOC entry 5030 (class 0 OID 0)
-- Dependencies: 229
-- Name: driver_employee_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.driver_employee_id_seq OWNED BY public.driver.employee_id;


--
-- TOC entry 219 (class 1259 OID 16415)
-- Name: employee; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.employee (
    person_id integer NOT NULL,
    status character varying(20) NOT NULL
);


ALTER TABLE public.employee OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16443)
-- Name: employee_with_position; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.employee_with_position (
    id integer NOT NULL,
    employee_id integer NOT NULL,
    position_id integer NOT NULL,
    start_date date NOT NULL,
    end_date date
);


ALTER TABLE public.employee_with_position OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16442)
-- Name: employee_with_position_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.employee_with_position_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.employee_with_position_id_seq OWNER TO postgres;

--
-- TOC entry 5031 (class 0 OID 0)
-- Dependencies: 222
-- Name: employee_with_position_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.employee_with_position_id_seq OWNED BY public.employee_with_position.id;


--
-- TOC entry 233 (class 1259 OID 16527)
-- Name: passenger; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.passenger (
    person_id integer NOT NULL,
    discount real,
    CONSTRAINT check_discount CHECK (((discount >= (0)::double precision) AND (discount <= (1)::double precision)))
);


ALTER TABLE public.passenger OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 16468)
-- Name: payment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payment (
    id integer NOT NULL,
    payment_type_id integer NOT NULL,
    employee_id integer NOT NULL,
    amount integer NOT NULL,
    date date NOT NULL,
    CONSTRAINT check_amount CHECK ((amount > 0))
);


ALTER TABLE public.payment OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 16467)
-- Name: payment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.payment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.payment_id_seq OWNER TO postgres;

--
-- TOC entry 5032 (class 0 OID 0)
-- Dependencies: 226
-- Name: payment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.payment_id_seq OWNED BY public.payment.id;


--
-- TOC entry 225 (class 1259 OID 16461)
-- Name: payment_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payment_type (
    id integer NOT NULL,
    name character varying(30) NOT NULL
);


ALTER TABLE public.payment_type OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 16460)
-- Name: payment_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.payment_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.payment_type_id_seq OWNER TO postgres;

--
-- TOC entry 5033 (class 0 OID 0)
-- Dependencies: 224
-- Name: payment_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.payment_type_id_seq OWNED BY public.payment_type.id;


--
-- TOC entry 217 (class 1259 OID 16402)
-- Name: person; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.person (
    id integer NOT NULL,
    full_name character varying(100) NOT NULL,
    address character varying(255) NOT NULL,
    phone character(12) NOT NULL,
    passport character varying(20) NOT NULL,
    CONSTRAINT check_full_name CHECK (((full_name)::text ~ '^[А-Яа-яЁё -]+$'::text)),
    CONSTRAINT check_passport CHECK (((passport)::text ~ '^[A-Za-zА-Яа-яЁё0-9 ]+$'::text)),
    CONSTRAINT check_phone CHECK ((phone ~ '^[0-9+]+$'::text))
);


ALTER TABLE public.person OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16405)
-- Name: person_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.person_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.person_id_seq OWNER TO postgres;

--
-- TOC entry 5034 (class 0 OID 0)
-- Dependencies: 218
-- Name: person_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.person_id_seq OWNED BY public.person.id;


--
-- TOC entry 220 (class 1259 OID 16432)
-- Name: position; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."position" (
    id integer NOT NULL,
    title character varying(50) NOT NULL,
    basic_salary integer NOT NULL,
    CONSTRAINT check_basic_salary CHECK ((basic_salary >= 0))
);


ALTER TABLE public."position" OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16435)
-- Name: position_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.position_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.position_id_seq OWNER TO postgres;

--
-- TOC entry 5035 (class 0 OID 0)
-- Dependencies: 221
-- Name: position_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.position_id_seq OWNED BY public."position".id;


--
-- TOC entry 243 (class 1259 OID 16617)
-- Name: tariff; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tariff (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    car_type character varying(30) NOT NULL,
    CONSTRAINT check_car_type CHECK (((car_type)::text = ANY ((ARRAY['эконом'::character varying, 'комфорт'::character varying, 'бизнес'::character varying, 'премиум'::character varying])::text[])))
);


ALTER TABLE public.tariff OWNER TO postgres;

--
-- TOC entry 242 (class 1259 OID 16616)
-- Name: tariff_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tariff_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tariff_id_seq OWNER TO postgres;

--
-- TOC entry 5036 (class 0 OID 0)
-- Dependencies: 242
-- Name: tariff_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tariff_id_seq OWNED BY public.tariff.id;


--
-- TOC entry 245 (class 1259 OID 16627)
-- Name: tariff_price; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tariff_price (
    id integer NOT NULL,
    tariff_id integer NOT NULL,
    price_per_km integer NOT NULL,
    start_date timestamp without time zone NOT NULL,
    end_date timestamp without time zone,
    CONSTRAINT check_date CHECK ((end_date > start_date)),
    CONSTRAINT check_price_per_km CHECK ((price_per_km >= 0))
);


ALTER TABLE public.tariff_price OWNER TO postgres;

--
-- TOC entry 244 (class 1259 OID 16626)
-- Name: tariff_price_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tariff_price_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tariff_price_id_seq OWNER TO postgres;

--
-- TOC entry 5037 (class 0 OID 0)
-- Dependencies: 244
-- Name: tariff_price_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tariff_price_id_seq OWNED BY public.tariff_price.id;


--
-- TOC entry 249 (class 1259 OID 16647)
-- Name: taxi_call; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.taxi_call (
    id integer NOT NULL,
    driver_id integer NOT NULL,
    tariff_price_id integer NOT NULL,
    cost_adjustment_id integer NOT NULL,
    passenger_id integer NOT NULL,
    administrator_id integer NOT NULL,
    payment_amount integer NOT NULL,
    start_time timestamp without time zone NOT NULL,
    end_time timestamp without time zone NOT NULL,
    start_place character varying(200) NOT NULL,
    end_place character varying(200) NOT NULL,
    distance integer NOT NULL,
    payment_method character varying(20) NOT NULL,
    trip_rating integer,
    trip_review text,
    call_time timestamp without time zone NOT NULL,
    CONSTRAINT check_distance CHECK ((distance >= 0)),
    CONSTRAINT check_payment_amount CHECK ((payment_amount >= 0)),
    CONSTRAINT check_payment_method CHECK (((payment_method)::text = ANY ((ARRAY['наличные'::character varying, 'онлайн'::character varying, 'карта'::character varying])::text[]))),
    CONSTRAINT check_time CHECK (((end_time > start_time) AND (start_time > call_time))),
    CONSTRAINT check_trip_rating CHECK (((trip_rating >= 1) AND (trip_rating <= 5)))
);


ALTER TABLE public.taxi_call OWNER TO postgres;

--
-- TOC entry 248 (class 1259 OID 16646)
-- Name: taxi_call_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.taxi_call_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.taxi_call_id_seq OWNER TO postgres;

--
-- TOC entry 5038 (class 0 OID 0)
-- Dependencies: 248
-- Name: taxi_call_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.taxi_call_id_seq OWNED BY public.taxi_call.id;


--
-- TOC entry 232 (class 1259 OID 16513)
-- Name: work_schedule; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.work_schedule (
    id integer NOT NULL,
    driver_id integer NOT NULL,
    start_time timestamp without time zone NOT NULL,
    end_time timestamp without time zone NOT NULL,
    status character varying(20),
    CONSTRAINT check_time CHECK ((end_time > start_time))
);


ALTER TABLE public.work_schedule OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 16512)
-- Name: work_schedule_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.work_schedule_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.work_schedule_id_seq OWNER TO postgres;

--
-- TOC entry 5039 (class 0 OID 0)
-- Dependencies: 231
-- Name: work_schedule_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.work_schedule_id_seq OWNED BY public.work_schedule.id;


--
-- TOC entry 4730 (class 2604 OID 16551)
-- Name: bank_card id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bank_card ALTER COLUMN id SET DEFAULT nextval('public.bank_card_id_seq'::regclass);


--
-- TOC entry 4732 (class 2604 OID 16580)
-- Name: car id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.car ALTER COLUMN id SET DEFAULT nextval('public.car_id_seq'::regclass);


--
-- TOC entry 4731 (class 2604 OID 16564)
-- Name: car_model id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.car_model ALTER COLUMN id SET DEFAULT nextval('public.car_model_id_seq'::regclass);


--
-- TOC entry 4733 (class 2604 OID 16595)
-- Name: car_usage id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.car_usage ALTER COLUMN id SET DEFAULT nextval('public.car_usage_id_seq'::regclass);


--
-- TOC entry 4736 (class 2604 OID 16642)
-- Name: cost_adjustment id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cost_adjustment ALTER COLUMN id SET DEFAULT nextval('public.cost_adjustment_id_seq'::regclass);


--
-- TOC entry 4728 (class 2604 OID 16500)
-- Name: driver employee_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.driver ALTER COLUMN employee_id SET DEFAULT nextval('public.driver_employee_id_seq'::regclass);


--
-- TOC entry 4725 (class 2604 OID 16446)
-- Name: employee_with_position id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee_with_position ALTER COLUMN id SET DEFAULT nextval('public.employee_with_position_id_seq'::regclass);


--
-- TOC entry 4727 (class 2604 OID 16471)
-- Name: payment id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment ALTER COLUMN id SET DEFAULT nextval('public.payment_id_seq'::regclass);


--
-- TOC entry 4726 (class 2604 OID 16464)
-- Name: payment_type id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment_type ALTER COLUMN id SET DEFAULT nextval('public.payment_type_id_seq'::regclass);


--
-- TOC entry 4723 (class 2604 OID 16406)
-- Name: person id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.person ALTER COLUMN id SET DEFAULT nextval('public.person_id_seq'::regclass);


--
-- TOC entry 4724 (class 2604 OID 16436)
-- Name: position id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."position" ALTER COLUMN id SET DEFAULT nextval('public.position_id_seq'::regclass);


--
-- TOC entry 4734 (class 2604 OID 16620)
-- Name: tariff id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tariff ALTER COLUMN id SET DEFAULT nextval('public.tariff_id_seq'::regclass);


--
-- TOC entry 4735 (class 2604 OID 16630)
-- Name: tariff_price id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tariff_price ALTER COLUMN id SET DEFAULT nextval('public.tariff_price_id_seq'::regclass);


--
-- TOC entry 4737 (class 2604 OID 16650)
-- Name: taxi_call id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.taxi_call ALTER COLUMN id SET DEFAULT nextval('public.taxi_call_id_seq'::regclass);


--
-- TOC entry 4729 (class 2604 OID 16516)
-- Name: work_schedule id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.work_schedule ALTER COLUMN id SET DEFAULT nextval('public.work_schedule_id_seq'::regclass);


--
-- TOC entry 4998 (class 0 OID 16484)
-- Dependencies: 228
-- Data for Name: administrator; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.administrator (employee_id, call_center_number) FROM stdin;
1	1
2	5
3	10
4	3
5	3
6	7
7	5
8	7
9	3
10	9
11	1
12	10
13	4
14	9
15	1
16	2
17	8
18	4
19	10
20	8
21	10
22	6
23	2
24	7
25	8
26	4
27	8
28	4
29	10
30	7
31	8
32	1
33	1
34	7
35	9
36	10
37	1
38	10
39	8
40	1
41	7
42	2
43	6
44	3
45	6
46	2
47	1
48	7
49	6
50	8
51	9
52	7
53	9
54	1
55	4
56	10
57	4
58	1
59	9
60	9
61	7
62	3
63	5
64	6
65	10
66	4
67	5
68	9
69	3
70	1
71	5
72	6
73	4
74	9
75	3
76	5
77	10
78	2
79	1
80	5
81	8
82	7
83	9
84	6
85	8
86	9
87	3
88	6
89	4
90	9
91	10
92	4
93	9
94	4
95	8
96	8
97	3
98	5
99	10
100	10
\.


--
-- TOC entry 5005 (class 0 OID 16548)
-- Dependencies: 235
-- Data for Name: bank_card; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.bank_card (id, number, passenger_id) FROM stdin;
1	5995835781665312	201
2	5459892261218636	202
3	3723491532471873	203
4	3193149542977746	204
5	1128269215497634	205
6	8232831535359286	206
7	4526251489868274	207
8	1194757246113437	208
9	9394427491559146	209
10	8561934538635684	210
11	8318264747389994	211
12	2867896635177977	212
13	3838389972782244	213
14	7518892221889319	214
15	4231231755495397	215
16	4936438955378113	216
17	3794745735738966	217
18	9433717151587536	218
19	1287646812218158	219
20	9217558616851846	220
21	5862655586976885	221
22	3479956386936763	222
23	4983288633761731	223
24	5919197831857666	224
25	8364852825842681	225
26	5539865757819575	226
27	3634663365913653	227
28	1427564349359541	228
29	6589165387925514	229
30	4476247433152487	230
31	9131828661572189	231
32	3138641688167728	232
33	7914922528739327	233
34	4356928694799445	234
35	4482561577181574	235
36	1757788858322629	236
37	3224339916256637	237
38	3777324425585458	238
39	3612633785227326	239
40	4513999429238691	240
41	7228798341554592	241
42	5476926463314162	242
43	7776635669939277	243
44	6556422468139862	244
45	1957889999827993	245
46	5115974114277758	246
47	9278995479162774	247
48	4399196317352176	248
49	2575486138448924	249
50	2698393264177825	250
51	9198924888538462	251
52	2596268179984323	252
53	8916788387334217	253
54	5496339397711695	254
55	2128578628254291	255
56	8146439995117297	256
57	3731328119838179	257
58	5252437148875445	258
59	3624424599662993	259
60	5618917747458669	260
61	9432279815154546	261
62	9572174524283666	262
63	2291399331492274	263
64	3817219329616771	264
65	5361219252728115	265
66	1477438576224259	266
67	9324824553234618	267
68	3556369161543863	268
69	7712916525211673	269
70	7624249166699288	270
71	8433945356831472	271
72	9256939873643267	272
73	6453242977499179	273
74	5865576216197562	274
75	9622575196749387	275
76	5969993948879722	276
77	3754479732498591	277
78	9791594385497975	278
79	3291765392694641	279
80	1565972926728497	280
81	8794129537172261	281
82	6981345597818931	282
83	3385843343842138	283
84	6377965968588391	284
85	7781736446865639	285
86	2967194344714446	286
87	8134936366817546	287
88	3772712512326774	288
89	1251212736119558	289
90	7168688167112788	290
91	2472774851825888	291
92	2675562343164666	292
93	8539512628266819	293
94	2412963269591931	294
95	2899198271598652	295
96	9394193945599256	296
97	9447745559634216	297
98	2441816872627218	298
99	1834212455633617	299
100	7845569149126714	300
\.


--
-- TOC entry 5009 (class 0 OID 16577)
-- Dependencies: 239
-- Data for Name: car; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.car (id, model_id, owner, cost, license_plate, year_manufacture, car_mileage, last_maintenance_date) FROM stdin;
1	4	водитель	1642843	Е828ЕВ00	2015	61408	2016-08-08
2	2	компания	5978829	А611УТ96	2016	38122	2024-01-26
3	5	водитель	7639946	С529ОН04	2024	99484	2025-01-02
4	2	водитель	3027332	В357ХР49	2012	41227	2016-03-18
5	9	водитель	5381433	С394ОК90	2024	76057	2025-03-13
6	9	водитель	6871350	Е166ЕК58	2010	58597	2010-07-24
7	7	водитель	1382909	В658ХУ52	2013	83137	2022-09-26
8	9	компания	4806267	Р049КА15	2014	75380	2023-01-10
9	4	компания	9946778	Е166ТВ12	2011	14731	2022-12-17
10	4	водитель	8435747	У411СХ80	2008	3589	2024-11-09
11	8	компания	4586316	А951АО64	2023	86574	2023-12-19
12	2	компания	3704702	Х214ВК17	2006	11460	2015-04-16
13	7	водитель	8482805	У630ЕС44	2021	10974	2024-09-27
14	3	компания	5192690	Н214АН05	2012	84472	2016-08-13
15	2	водитель	2407694	Е667НК40	2022	86979	2024-02-22
16	10	водитель	7320554	Х223АО87	2010	842	2015-07-28
17	1	компания	9211395	С233ОА13	2022	93234	2023-10-19
18	7	водитель	7204387	А500НС86	2005	51897	2013-06-02
19	9	компания	3845181	У726ВА12	2020	96472	2021-10-06
20	10	водитель	4415882	В403МО73	2015	11995	2017-09-06
21	3	компания	8860687	Р924ТК56	2017	41468	2024-05-04
22	4	водитель	5160954	Е497ТН49	2024	16747	2024-12-22
23	3	компания	2176125	Р852АМ74	2016	95298	2016-07-14
24	7	водитель	5167989	Т813ЕУ99	2021	26674	2024-02-15
25	8	водитель	5420735	У066АТ01	2016	38069	2018-08-13
26	6	компания	6992021	С861УТ33	2021	61486	2023-06-05
27	10	водитель	6083512	В413ЕХ32	2005	58337	2009-06-14
28	1	водитель	6260316	М948НЕ80	2017	34197	2017-07-12
29	6	водитель	5219850	М494ВО91	2015	8108	2017-10-29
30	2	компания	9180370	Н440МС89	2008	96788	2008-08-16
31	3	водитель	2543876	Е558РУ90	2017	80258	2018-04-13
32	4	водитель	8995871	Т141КМ32	2016	72164	2020-06-22
33	4	компания	6616432	С554АМ45	2008	13176	2018-08-23
34	10	водитель	7698288	М051НХ29	2021	78063	2025-01-12
35	4	компания	6956567	С332ЕО77	2014	38532	2025-03-22
36	6	компания	6507770	М582МХ64	2014	66398	2021-03-31
37	2	водитель	2351451	Н993РЕ63	2016	21294	2024-05-11
38	7	компания	1410328	Х024ТР12	2022	82551	2022-07-07
39	5	водитель	3799925	Н994РС50	2007	6100	2013-07-05
40	4	компания	9509437	В251ТН67	2018	97972	2019-02-20
41	8	компания	6689521	Х268ЕР78	2016	54566	2020-03-10
42	8	водитель	9708066	Х255НС62	2007	47846	2008-04-27
43	9	компания	3750401	О646АР01	2018	19855	2018-09-29
44	8	компания	8422530	У657АР20	2018	7584	2021-06-08
45	6	водитель	2189167	А929УН32	2022	26525	2024-09-08
46	8	водитель	3500906	У850ЕН79	2016	18105	2020-12-26
47	8	водитель	5708957	А705ЕН65	2015	81362	2021-07-10
48	10	компания	1777291	Р149МК47	2008	27500	2009-09-20
49	8	компания	7686656	С983ТТ24	2018	69174	2023-03-14
50	8	водитель	1393915	О977ОЕ66	2016	39994	2019-10-01
51	5	компания	4481860	Р229СО32	2021	80796	2024-03-11
52	6	компания	5663179	С102ВУ98	2009	61960	2024-07-07
53	5	водитель	3311846	С491РУ32	2018	36124	2021-07-01
54	9	водитель	3126850	С836РР80	2023	15470	2024-08-16
55	6	водитель	1544093	Т679ВМ08	2017	11820	2018-11-23
56	3	водитель	2947205	У187ОР96	2007	97197	2013-10-27
57	10	компания	7294203	Р295РА03	2021	38096	2022-11-08
58	7	компания	8410545	М469РМ94	2017	16724	2021-11-20
59	3	водитель	3550666	С730ТН24	2008	79441	2025-02-13
60	6	компания	3927951	У117СР04	2017	18813	2017-06-29
61	7	водитель	6701252	Р332ОР71	2007	83958	2023-08-12
62	3	компания	4307828	М590ЕК39	2012	56956	2021-08-28
63	9	компания	8953827	Е867АВ00	2021	12957	2021-02-20
64	6	компания	8166063	У433ТР29	2005	64973	2019-08-08
65	4	водитель	3731713	С454НТ73	2005	63210	2019-09-21
66	4	водитель	4588884	Х229НЕ95	2023	26246	2024-08-22
67	8	водитель	3957701	Н552УЕ10	2017	64013	2022-05-10
68	2	компания	2293618	Х897ОУ42	2017	96320	2020-07-14
69	8	компания	9740281	О489ЕХ61	2011	96771	2019-03-29
70	10	водитель	1156859	Е093ТН32	2024	38792	2024-10-22
71	6	водитель	8219588	С130НК50	2015	32472	2019-05-04
72	5	компания	9603944	Н740ТН02	2021	74045	2024-05-27
73	3	компания	2641025	Н470ХС84	2017	75490	2019-12-02
74	1	компания	8013813	Р053СВ85	2014	59168	2015-06-20
75	2	водитель	7746158	О059ВМ75	2020	64118	2021-10-17
76	3	водитель	3319765	Е674РО09	2017	39898	2021-03-03
77	3	водитель	2314404	У223АК82	2017	49882	2022-05-20
78	9	компания	4576045	Т920КУ07	2024	92466	2025-02-07
79	6	водитель	4477076	С534ХР24	2016	81903	2023-01-01
80	9	водитель	6635307	Н409МУ03	2017	87551	2024-06-22
81	4	компания	5051693	Р886УК70	2010	72574	2021-09-13
82	7	компания	1548609	С639РВ11	2021	8776	2022-07-27
83	7	компания	7981300	Е979СТ08	2012	83330	2021-09-11
84	9	компания	7764081	К836ХК63	2008	81445	2011-08-07
85	2	компания	3929318	В272УС22	2021	48192	2022-10-15
86	9	водитель	6832870	В632КС02	2019	34607	2022-08-28
87	8	компания	9717353	К265ТР16	2009	85312	2021-11-07
88	3	водитель	1913415	С322ЕМ27	2023	14185	2024-02-15
89	9	компания	6847680	Х829СМ17	2007	21572	2022-09-02
90	1	водитель	6741292	Т677ВН80	2011	37210	2022-12-05
91	6	водитель	6306867	М412ХТ48	2015	77877	2017-04-30
92	2	компания	9897920	С340КР78	2023	25511	2024-07-13
93	2	компания	8822567	А595АН19	2018	69663	2024-07-30
94	7	водитель	9248176	Х110СО33	2020	17875	2021-06-27
95	2	водитель	3188776	К535ЕМ33	2009	54183	2018-04-07
96	3	компания	4930250	В079ОР41	2011	10431	2017-10-30
97	10	водитель	3317616	Е620РР23	2015	65350	2015-11-26
98	6	компания	5439796	У818АО40	2014	53738	2016-01-03
99	3	компания	8121950	О193РВ53	2024	58125	2024-04-09
100	3	водитель	1538729	Е906ОТ17	2010	78154	2024-05-21
\.


--
-- TOC entry 5007 (class 0 OID 16561)
-- Dependencies: 237
-- Data for Name: car_model; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.car_model (id, make_and_model, country, characteristics) FROM stdin;
1	Toyota Camry	Japan	Sedan, 4-door, Hybrid
2	Ford Mustang	USA	Coupe, 2-door, V8 engine
3	Volkswagen Golf	Germany	Hatchback, 5-door, Turbocharged
4	Hyundai Elantra	South Korea	Sedan, 4-door, Fuel-efficient
5	Chevrolet Silverado	USA	Pickup, 4-door, Heavy-duty
6	BMW 3 Series	Germany	Sedan, 4-door, Luxury
7	Kia Sportage	South Korea	SUV, 5-door, All-wheel drive
8	Nissan Altima	Japan	Sedan, 4-door, Sporty design
9	Subaru Outback	Japan	Wagon, 5-door, Off-road capability
10	Tesla Model 3	USA	Sedan, 4-door, Electric
\.


--
-- TOC entry 5011 (class 0 OID 16592)
-- Dependencies: 241
-- Data for Name: car_usage; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.car_usage (id, driver_id, car_id, start_date, end_date) FROM stdin;
1	177	69	2021-07-02	2024-03-08
2	176	43	2018-07-19	2022-07-05
3	141	92	2021-06-23	2021-11-09
4	194	93	2017-08-07	2024-05-10
5	173	100	2017-04-18	2025-01-04
6	170	14	2019-01-16	2021-02-28
7	141	29	2016-11-26	2024-08-31
8	179	58	2017-05-13	2020-07-10
9	183	100	2015-05-15	2025-01-05
10	108	40	2023-08-06	2024-06-12
11	150	44	2022-07-27	2024-01-10
12	166	64	2018-10-22	2025-03-24
13	149	49	2023-09-15	2024-04-21
14	169	34	2025-02-24	2025-03-23
15	128	70	2005-06-26	2016-10-24
16	169	2	2017-01-08	2022-07-21
17	125	57	2006-04-12	2007-02-24
18	199	54	2006-06-12	2014-12-23
19	177	54	2013-03-07	2021-07-04
20	107	34	2017-11-24	2024-12-14
21	109	15	2016-07-06	2018-02-02
22	140	94	2012-06-04	2020-07-04
23	121	9	2013-01-17	2013-12-26
24	193	66	2008-04-13	2019-01-20
25	115	7	2008-01-18	2013-07-06
26	194	93	2007-07-06	2022-10-17
27	133	63	2009-02-08	2012-05-19
28	137	74	2019-06-02	2021-10-10
29	178	60	2015-01-03	2020-03-07
30	104	46	2022-09-29	2023-12-04
31	136	91	2023-07-13	2024-07-13
32	192	60	2007-09-22	2015-07-04
33	148	34	2006-10-07	2023-11-22
34	186	63	2025-03-19	2025-03-22
35	141	62	2016-01-14	2017-03-14
36	122	12	2010-05-13	2017-12-16
37	101	52	2007-02-13	2007-07-11
38	195	80	2019-04-10	2022-10-01
39	113	71	2022-11-16	2023-10-10
40	131	87	2022-06-06	2024-03-11
41	119	35	2009-12-01	2019-04-13
42	155	19	2022-07-06	2024-11-16
43	137	52	2015-07-23	2023-10-21
44	130	45	2005-05-28	2021-11-26
45	118	31	2020-04-04	2023-04-17
46	110	66	2008-02-01	2021-03-02
47	130	21	2022-06-14	2023-03-19
48	133	91	2011-06-28	2017-05-29
49	198	93	2019-07-26	2020-10-14
50	192	32	2011-03-14	2011-11-02
51	177	78	2012-07-15	2015-10-19
52	124	4	2017-04-18	2022-02-05
53	176	46	2008-08-07	2022-02-12
54	198	44	2019-06-23	2023-09-09
55	106	73	2023-02-12	2024-10-31
56	165	26	2011-04-22	2012-02-10
57	111	31	2017-03-29	2017-04-28
58	164	61	2007-05-13	2008-03-29
59	198	20	2018-08-06	2019-12-13
60	175	33	2005-07-28	2010-11-07
61	184	48	2022-06-23	2024-05-17
62	168	87	2010-01-10	2020-01-30
63	199	19	2022-04-14	2022-09-11
64	152	38	2005-05-04	2024-11-27
65	199	40	2024-11-05	2024-11-23
66	179	85	2019-04-26	2023-04-15
67	130	46	2009-04-04	2022-01-06
68	111	67	2018-03-20	2019-07-08
69	191	79	2019-07-07	2022-01-03
70	165	26	2024-01-19	2024-01-29
71	173	5	2005-04-22	2014-06-29
72	163	20	2020-03-23	2020-10-20
73	188	92	2005-12-30	2019-11-08
74	124	23	2013-04-26	2020-04-21
75	125	30	2010-08-16	2017-05-10
76	168	14	2024-06-18	2024-08-24
77	129	88	2024-12-26	2025-01-16
78	177	91	2014-11-29	2021-04-02
79	117	50	2017-04-23	2019-12-24
80	169	52	2025-01-19	2025-03-03
81	124	99	2019-08-23	2023-07-17
82	120	74	2019-09-06	2021-02-05
83	184	29	2020-02-07	2025-01-28
84	129	21	2012-08-07	2014-06-15
85	141	18	2022-08-22	2023-06-08
86	191	10	2019-10-29	2020-09-10
87	128	54	2013-05-29	2016-11-11
88	170	83	2017-01-17	2018-11-14
89	127	72	2015-02-25	2017-04-15
90	195	53	2010-08-15	2023-04-10
91	177	3	2016-05-17	2024-10-25
92	165	100	2006-08-26	2015-10-29
93	136	3	2006-04-29	2016-04-14
94	140	70	2018-11-12	2020-12-28
95	176	37	2009-06-14	2012-04-03
96	155	80	2009-11-24	2019-11-02
97	185	42	2011-04-13	2017-05-08
98	104	3	2023-09-28	2024-05-10
99	198	29	2013-04-25	2017-12-23
100	138	84	2012-01-30	2024-09-24
\.


--
-- TOC entry 5017 (class 0 OID 16639)
-- Dependencies: 247
-- Data for Name: cost_adjustment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cost_adjustment (id, time_of_day, traffic_level, ratio, start_date, end_date) FROM stdin;
1	ночь	5	1.4	2006-12-29 01:08:51	2017-01-26 00:37:13
2	ночь	2	1.2	2023-06-06 17:44:39	2025-01-30 03:10:21
3	ночь	8	1.3	2016-07-05 09:30:51	2016-10-16 13:46:45
4	день	8	1.1	2014-02-01 16:08:39	2015-10-17 03:50:03
5	ночь	4	2	2009-07-03 14:19:23	2019-11-16 05:36:15
6	утро	10	1.2	2018-05-26 09:15:26	2020-11-13 16:08:52
7	вечер	7	1.2	2016-08-02 07:44:30	2021-06-09 19:45:45
8	утро	10	1.6	2009-06-11 02:32:55	2023-08-15 12:19:17
9	утро	4	1.4	2011-09-15 23:00:20	2015-12-09 23:35:40
10	день	1	1.8	2020-06-14 03:18:41	2021-08-24 17:17:55
11	ночь	9	1.4	2012-11-17 02:38:58	2013-08-03 14:24:24
12	вечер	4	1.2	2024-04-03 03:22:24	2024-06-03 00:29:23
13	ночь	4	1.8	2011-05-01 16:55:13	2014-07-26 19:57:02
14	день	5	1.8	2007-09-15 16:17:21	2020-08-23 13:07:58
15	ночь	7	1.3	2006-05-31 10:02:29	2020-01-18 00:05:35
16	утро	3	1.7	2020-11-24 06:45:48	2021-07-05 07:28:06
17	утро	7	1.4	2011-03-20 17:00:15	2018-01-14 22:27:48
18	ночь	3	1.5	2018-11-27 00:31:19	2023-06-27 15:53:18
19	утро	10	1.5	2012-07-13 03:09:44	2022-03-10 22:56:47
20	вечер	1	1.2	2008-10-31 18:24:37	2011-06-11 08:27:45
21	вечер	4	1.1	2010-10-09 14:19:04	2010-12-03 04:33:24
22	утро	8	1.9	2017-01-09 17:08:49	2021-03-02 11:41:55
23	вечер	7	1.1	2013-02-28 14:30:10	2015-01-14 22:31:23
24	ночь	4	1.9	2020-06-13 02:06:18	2023-08-21 09:50:45
25	ночь	2	1.9	2022-05-03 01:26:17	2024-11-17 08:06:05
26	утро	7	1.2	2006-11-21 21:54:58	2023-03-12 11:33:39
27	вечер	8	1.6	2006-09-02 21:17:06	2021-05-05 13:23:01
28	утро	10	1.1	2011-02-22 12:12:12	2019-09-05 21:10:45
29	ночь	7	1.3	2023-05-07 14:51:12	2023-09-02 14:30:58
30	ночь	10	1.2	2020-11-23 08:11:31	2024-07-23 00:26:17
31	утро	1	1.3	2016-08-28 19:51:00	2022-01-19 07:03:21
32	утро	9	1.2	2005-07-29 14:52:23	2006-03-09 19:15:31
33	вечер	3	1.4	2009-02-07 09:09:50	2018-09-21 23:54:26
34	день	4	1.6	2007-11-06 04:08:44	2021-06-11 15:29:59
35	утро	6	2	2021-12-13 00:24:56	2022-07-16 22:27:16
36	день	10	1.9	2009-08-17 22:08:27	2019-08-28 06:26:33
37	вечер	8	1.2	2009-04-02 20:29:14	2021-10-08 07:39:41
38	утро	5	1.9	2010-10-25 15:31:18	2020-02-15 20:15:55
39	ночь	9	1.6	2023-08-23 09:29:37	2023-11-04 13:31:46
40	день	2	1.2	2013-09-26 08:57:14	2016-01-24 06:30:02
41	ночь	4	2	2013-03-30 15:21:05	2020-03-08 10:28:56
42	вечер	2	1.8	2022-05-12 08:30:51	2024-02-10 11:12:33
43	утро	8	1.5	2017-08-31 06:00:38	2020-09-26 08:14:51
44	утро	10	1.1	2008-08-23 21:29:20	2019-01-21 07:08:09
45	вечер	8	1.8	2007-04-09 22:34:59	2022-05-23 14:35:39
46	утро	4	1.5	2020-04-25 20:27:07	2025-03-05 17:19:22
47	вечер	1	1.2	2010-07-30 17:49:20	2024-07-23 04:28:28
48	утро	8	1.4	2009-01-11 15:02:30	2017-09-07 14:31:15
49	вечер	5	1.7	2012-06-04 23:00:06	2014-03-26 05:50:16
50	день	2	1.2	2023-06-11 11:39:14	2025-02-19 08:59:02
51	утро	6	2	2016-11-08 12:11:56	2020-09-06 00:23:24
52	вечер	1	1.5	2016-02-08 17:33:40	2017-10-02 09:38:46
53	ночь	6	1.7	2018-02-01 06:33:19	2020-10-24 05:02:33
54	ночь	3	1.5	2013-12-24 09:05:08	2014-05-12 04:55:54
55	вечер	4	1.9	2014-04-25 03:04:49	2018-10-26 14:06:07
56	день	3	1.9	2023-05-30 22:57:49	2023-07-03 22:32:09
57	утро	7	1.3	2011-03-26 14:49:54	2015-10-30 06:21:38
58	ночь	6	1.7	2023-11-01 23:20:37	2025-02-03 20:11:11
59	вечер	4	2	2014-08-13 01:32:59	2016-05-28 14:39:36
60	утро	1	2	2023-12-06 08:55:31	2025-02-25 03:45:17
61	вечер	3	1.9	2016-08-14 15:51:46	2016-10-11 13:14:30
62	утро	10	1.9	2008-11-25 18:39:08	2023-10-29 14:05:56
63	день	7	1.7	2018-09-04 09:51:38	2024-03-04 00:48:09
64	день	1	1.5	2018-04-05 20:09:16	2023-03-06 19:57:14
65	ночь	4	2	2007-06-18 21:22:25	2011-04-29 07:49:13
66	ночь	1	1.1	2008-12-06 21:04:46	2018-07-27 16:26:48
67	вечер	3	2	2016-05-30 21:33:26	2019-08-16 11:32:10
68	день	9	1.9	2019-09-26 17:55:29	2023-08-24 13:45:48
69	ночь	3	1.7	2006-05-06 17:01:08	2007-07-30 17:51:21
70	вечер	4	1.6	2011-04-23 09:47:29	2018-07-07 09:06:23
71	ночь	5	1.7	2023-07-03 13:44:30	2024-08-19 00:16:10
72	утро	4	1.9	2023-01-22 17:06:13	2024-06-02 13:59:24
73	ночь	6	1.9	2015-04-13 09:30:14	2020-12-04 07:45:37
74	утро	10	1.4	2018-02-17 04:22:25	2021-05-31 12:58:36
75	день	4	1.8	2012-09-08 19:54:20	2023-10-16 02:34:12
76	день	2	1.5	2013-02-12 20:37:24	2023-02-21 12:37:45
77	утро	9	1.8	2010-10-15 15:16:04	2014-05-19 19:18:54
78	вечер	9	1.5	2006-04-30 18:38:15	2017-10-14 23:18:23
79	вечер	6	1.6	2010-03-23 19:16:16	2013-08-31 03:30:23
80	день	1	1.9	2012-10-05 21:19:55	2021-08-09 07:15:38
81	ночь	10	1.8	2020-02-04 10:21:11	2022-12-29 02:55:06
82	ночь	4	1.9	2024-03-17 18:35:23	2025-03-20 13:16:14
83	ночь	10	1.1	2017-10-04 11:13:18	2020-12-08 22:24:56
84	вечер	7	1.2	2024-07-26 07:09:30	2024-08-14 18:16:49
85	утро	4	1.4	2023-10-25 17:25:26	2024-08-15 18:36:46
86	ночь	7	1.8	2018-08-05 06:52:53	2023-10-22 06:48:52
87	утро	8	1.2	2005-04-01 01:49:45	2018-05-14 04:07:29
88	вечер	7	1.9	2009-11-06 04:43:34	2016-06-30 01:09:36
89	утро	7	2	2013-05-30 13:14:27	2021-02-09 00:22:37
90	ночь	3	1.8	2021-11-19 23:20:06	2022-07-16 21:53:16
91	ночь	9	1.8	2005-04-23 23:55:07	2025-01-09 23:47:20
92	ночь	6	1.1	2016-08-20 02:41:30	2020-09-10 21:46:52
93	ночь	10	1.2	2008-02-23 14:53:32	2010-04-29 00:37:10
94	утро	6	1.9	2015-04-18 23:18:59	2022-05-24 21:30:55
95	день	8	2	2014-02-13 14:06:23	2014-12-24 06:03:46
96	день	9	1.5	2005-08-11 07:52:59	2012-06-12 23:10:14
97	ночь	3	1.1	2020-02-05 07:35:29	2023-03-03 21:51:30
98	день	8	1.1	2022-01-14 19:27:37	2024-10-31 17:29:12
99	день	1	1.5	2008-02-07 18:01:18	2018-08-04 20:44:53
100	день	6	1.2	2015-10-31 15:35:22	2020-01-08 23:15:13
\.


--
-- TOC entry 5000 (class 0 OID 16497)
-- Dependencies: 230
-- Data for Name: driver; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.driver (employee_id, license_number, geolocation) FROM stdin;
101	7144 987042	11.8404,94.4915
102	9182 722022	27.2423,14.2776
103	7642 188369	30.9725,18.4467
104	0334 219427	74.7944,63.3292
105	7828 511187	96.4528,29.3517
106	1103 785904	49.2848,49.5504
107	1012 470819	96.7536,48.5171
108	9476 532802	37.4042,81.2692
109	1384 350096	84.0927,97.9830
110	2949 250736	64.9470,49.8985
111	9346 901074	75.5647,50.9797
112	5269 816083	49.7754,44.1941
113	3828 916467	43.4464,73.8530
114	9065 030760	73.5794,41.4415
115	5264 546476	77.8979,01.3331
116	2206 067827	27.7447,38.5746
117	0124 619221	83.2661,48.6619
118	7099 763013	81.8480,96.3325
119	0900 172304	68.4589,78.0523
120	6042 688513	02.3747,04.9305
121	0436 016728	42.2553,81.4908
122	1968 256088	96.2399,84.2179
123	5884 452088	42.3424,13.0000
124	8253 656400	31.4050,27.6082
125	8788 171598	13.0416,72.7661
126	3057 297279	02.0114,51.3985
127	6501 749713	49.3881,06.3573
128	0166 037612	93.7849,86.9357
129	9969 410241	61.1337,95.1622
130	7688 278880	81.3185,75.0207
131	8036 894299	89.5869,04.4280
132	5960 954981	33.0952,36.4645
133	3250 632864	31.9270,78.1706
134	8950 773683	75.6303,18.8590
135	5942 476663	90.6258,37.1800
136	7132 059293	74.8089,65.9037
137	1311 219372	36.5449,55.1794
138	0045 964105	00.0184,83.0536
139	3034 622228	92.8452,60.8812
140	5162 491248	03.2537,04.5301
141	5471 017614	98.4754,24.7439
142	5378 225025	27.2531,73.2672
143	6587 420982	41.7301,87.8120
144	0870 705402	36.9174,56.0809
145	4566 779717	29.1039,91.1959
146	9891 045959	82.0433,95.9716
147	4246 556280	68.5661,98.1207
148	2614 705570	79.6708,71.4313
149	9398 269023	31.8166,51.9309
150	3813 166674	71.5802,58.8639
151	8645 768866	44.0867,64.1007
152	8834 563806	23.6104,12.3194
153	1669 919759	52.1207,87.5684
154	3163 011061	72.4540,08.3230
155	4039 233037	66.9966,21.5051
156	2720 056398	96.9504,28.2464
157	0979 847173	73.7335,77.2954
158	5773 033277	94.9355,14.5528
159	0798 863788	57.3817,40.7749
160	4550 771037	39.1946,85.6199
161	3141 125989	53.6197,61.3231
162	4672 130952	15.8921,67.6885
163	9491 727963	05.5219,80.2966
164	4354 650022	35.7819,38.3877
165	4450 867427	37.9780,78.1281
166	4150 232991	98.9995,43.4220
167	5129 511432	60.5743,06.9162
168	1719 281233	05.1830,72.3689
169	2407 569848	83.5131,45.2303
170	3722 660713	93.4820,03.9955
171	8608 182861	57.4335,67.5191
172	2461 643662	00.9606,57.9616
173	0888 899245	26.2692,32.2385
174	5627 128792	60.7190,67.6554
175	9162 950560	30.7713,80.0324
176	0723 839266	26.6572,29.6879
177	7355 970321	17.1571,31.1920
178	3287 277261	99.4928,79.4141
179	0124 658369	95.3444,38.3524
180	4256 942581	60.8383,81.6051
181	5236 644156	22.9417,55.5240
182	6561 597046	77.3679,79.4909
183	1958 268115	97.6377,42.5429
184	7041 760555	84.9245,65.2985
185	9324 472411	37.5980,53.8380
186	7155 102537	29.5655,00.7587
187	5909 979894	94.5213,14.5675
188	0981 034089	97.5295,89.7448
189	3872 931599	40.4229,67.6716
190	0289 626704	61.5384,01.0054
191	0532 639110	12.4017,40.1420
192	2496 100882	71.1209,07.8681
193	5101 155024	43.0689,57.8296
194	8032 870303	79.9522,85.1082
195	4410 233390	44.9958,60.5554
196	8908 778910	35.8664,19.8031
197	8466 046850	24.7820,96.4315
198	5999 023436	01.5890,28.0122
199	8122 309843	44.2714,06.2185
200	3527 789215	89.0461,85.9827
\.


--
-- TOC entry 4989 (class 0 OID 16415)
-- Dependencies: 219
-- Data for Name: employee; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.employee (person_id, status) FROM stdin;
1	работает
2	работает
3	работает
4	работает
5	работает
6	работает
7	работает
8	работает
9	работает
10	работает
11	работает
12	работает
13	работает
14	работает
15	работает
16	работает
17	работает
18	работает
19	работает
20	работает
21	работает
22	работает
23	работает
24	работает
25	работает
26	работает
27	работает
28	работает
29	работает
30	работает
31	работает
32	работает
33	работает
34	работает
35	работает
36	работает
37	работает
38	работает
39	работает
40	работает
41	работает
42	работает
43	работает
44	работает
45	работает
46	работает
47	работает
48	работает
49	работает
50	работает
51	работает
52	работает
53	работает
54	работает
55	работает
56	работает
57	работает
58	работает
59	работает
60	работает
61	работает
62	работает
63	работает
64	работает
65	работает
66	работает
67	работает
68	работает
69	работает
70	работает
71	работает
72	работает
73	работает
74	работает
75	работает
76	работает
77	работает
78	работает
79	работает
80	работает
81	работает
82	работает
83	работает
84	работает
85	работает
86	работает
87	работает
88	работает
89	работает
90	работает
91	работает
92	работает
93	работает
94	работает
95	работает
96	работает
97	работает
98	работает
99	работает
100	работает
101	работает
102	работает
103	работает
104	работает
105	работает
106	работает
107	работает
108	работает
109	работает
110	работает
111	работает
112	работает
113	работает
114	работает
115	работает
116	работает
117	работает
118	работает
119	работает
120	работает
121	работает
122	работает
123	работает
124	работает
125	работает
126	работает
127	работает
128	работает
129	работает
130	работает
131	работает
132	работает
133	работает
134	работает
135	работает
136	работает
137	работает
138	работает
139	работает
140	работает
141	работает
142	работает
143	работает
144	работает
145	работает
146	работает
147	работает
148	работает
149	работает
150	работает
151	работает
152	работает
153	работает
154	работает
155	работает
156	работает
157	работает
158	работает
159	работает
160	работает
161	работает
162	работает
163	работает
164	работает
165	работает
166	работает
167	работает
168	работает
169	работает
170	работает
171	работает
172	работает
173	работает
174	работает
175	работает
176	работает
177	работает
178	работает
179	работает
180	работает
181	работает
182	работает
183	работает
184	работает
185	работает
186	работает
187	работает
188	работает
189	работает
190	работает
191	работает
192	работает
193	работает
194	работает
195	работает
196	работает
197	работает
198	работает
199	работает
200	работает
301	не работает
302	не работает
303	не работает
304	не работает
305	не работает
306	не работает
307	не работает
308	не работает
309	не работает
310	не работает
311	не работает
312	не работает
313	не работает
314	не работает
315	не работает
316	не работает
317	не работает
318	не работает
319	не работает
320	не работает
321	не работает
322	не работает
323	не работает
324	не работает
325	не работает
326	не работает
327	не работает
328	не работает
329	не работает
330	не работает
331	не работает
332	не работает
333	не работает
334	не работает
335	не работает
336	не работает
337	не работает
338	не работает
339	не работает
340	не работает
341	не работает
342	не работает
343	не работает
344	не работает
345	не работает
346	не работает
347	не работает
348	не работает
349	не работает
350	не работает
351	не работает
352	не работает
353	не работает
354	не работает
355	не работает
356	не работает
357	не работает
358	не работает
359	не работает
360	не работает
361	не работает
362	не работает
363	не работает
364	не работает
365	не работает
366	не работает
367	не работает
368	не работает
369	не работает
370	не работает
371	не работает
372	не работает
373	не работает
374	не работает
375	не работает
376	не работает
377	не работает
378	не работает
379	не работает
380	не работает
381	не работает
382	не работает
383	не работает
384	не работает
385	не работает
386	не работает
387	не работает
388	не работает
389	не работает
390	не работает
391	не работает
392	не работает
393	не работает
394	не работает
395	не работает
396	не работает
397	не работает
398	не работает
399	не работает
400	не работает
\.


--
-- TOC entry 4993 (class 0 OID 16443)
-- Dependencies: 223
-- Data for Name: employee_with_position; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.employee_with_position (id, employee_id, position_id, start_date, end_date) FROM stdin;
101	101	2	2002-08-07	2014-05-05
102	102	2	2015-01-26	2020-10-02
103	103	2	2010-09-21	2023-07-28
104	104	2	1982-04-19	2006-05-26
105	105	2	1982-09-26	1984-07-13
106	106	2	1975-09-13	2007-03-31
107	107	2	1992-04-14	2008-12-03
108	108	2	1975-12-10	1981-11-17
109	109	2	2005-04-27	2006-04-02
110	110	2	1970-04-15	1992-02-17
111	111	2	2008-12-12	2019-01-10
112	112	2	2022-04-24	2023-08-09
113	113	2	2011-06-07	2011-09-19
114	114	2	1987-09-08	2006-01-03
115	115	2	1974-08-20	1987-03-04
116	116	2	1976-07-23	1977-05-07
117	117	2	2008-12-26	2017-11-28
118	118	2	2009-08-25	2012-10-15
119	119	2	1974-07-14	1992-01-11
120	120	2	2023-11-17	2024-07-18
121	121	2	2004-09-08	2020-07-11
122	122	2	1998-05-21	2022-12-30
123	123	2	2020-04-16	2023-07-08
124	124	2	2015-03-16	2022-11-08
125	125	2	2022-11-22	2024-06-12
126	126	2	1975-02-04	2018-12-30
127	127	2	2018-10-17	2019-03-05
128	128	2	2022-04-15	2023-08-29
129	129	2	1979-07-25	1995-12-30
130	130	2	2008-02-19	2013-04-08
131	131	2	2009-05-13	2025-02-21
132	132	2	1988-10-25	1990-12-11
133	133	2	2001-11-06	2010-09-03
134	134	2	1982-06-16	2013-06-10
135	135	2	1976-06-21	1984-11-29
136	136	2	2007-09-16	2010-12-03
137	137	2	1998-11-12	2006-12-21
138	138	2	1984-04-08	2000-05-28
139	139	2	2021-01-28	2022-09-21
140	140	2	1978-06-05	1978-09-14
141	141	2	1978-11-27	1992-09-23
142	142	2	1999-08-21	2002-01-30
143	143	2	1991-04-13	1993-12-04
144	144	2	1972-08-26	1975-10-01
145	145	2	2017-04-14	2022-04-07
146	146	2	2012-10-16	2018-07-29
147	147	2	1980-10-29	2017-01-02
148	148	2	1998-06-02	2007-09-01
149	149	2	1987-10-09	2001-10-13
150	150	2	1985-10-11	1996-02-14
151	151	2	1990-07-06	2004-05-10
152	152	2	1997-01-25	2005-06-01
153	153	2	2016-01-29	2025-03-08
154	154	2	2008-02-23	2020-07-28
155	155	2	2009-12-05	2017-05-06
156	156	2	2011-12-30	2017-07-05
157	157	2	1991-08-02	1997-12-17
158	158	2	2006-01-11	2008-07-17
159	159	2	2002-02-24	2012-08-19
160	160	2	2001-04-29	2013-03-26
161	161	2	1970-10-05	2007-06-04
162	162	2	2022-08-01	2024-07-10
163	163	2	1977-08-05	1982-10-18
164	164	2	1990-02-02	1992-05-04
165	165	2	1994-04-01	2002-05-08
166	166	2	1974-05-09	2002-03-10
167	167	2	1994-10-09	1999-11-11
168	168	2	2006-12-15	2015-07-12
169	169	2	2014-08-25	2017-11-08
170	170	2	2007-03-23	2015-04-18
171	171	2	1973-05-31	1996-10-19
172	172	2	2008-10-05	2018-03-07
173	173	2	2022-03-11	2024-08-24
174	174	2	2002-01-08	2013-08-10
175	175	2	1971-10-12	1982-07-09
176	176	2	1988-07-23	2022-09-28
177	177	2	1983-04-21	2010-11-11
178	178	2	1998-05-09	2008-07-08
179	179	2	1979-07-31	2024-11-03
180	180	2	2009-05-26	2013-01-08
181	181	2	1999-09-05	2006-02-12
182	182	2	2001-08-01	2014-09-03
183	183	2	2011-10-06	2018-07-30
184	184	2	2023-04-04	2024-01-03
185	185	2	2008-05-05	2020-08-03
186	186	2	2024-05-20	2024-12-31
187	187	2	1971-10-28	2022-10-21
188	188	2	1970-05-04	2000-12-22
189	189	2	2015-10-25	2019-04-19
190	190	2	2001-07-23	2002-06-29
191	191	2	2003-02-03	2015-10-13
192	192	2	1983-11-20	1997-05-14
193	193	2	1973-12-03	2004-09-20
194	194	2	2019-03-25	2019-10-30
195	195	2	2020-11-25	2022-02-21
196	196	2	2013-10-12	2023-11-10
197	197	2	1980-05-24	2016-02-28
198	198	2	1971-07-09	2010-09-21
199	199	2	1985-02-17	2023-12-08
200	200	2	1983-12-26	2016-01-30
1	1	1	2013-10-29	2021-05-12
2	2	1	1972-04-28	1988-01-22
3	3	1	1981-10-10	2023-03-08
4	4	1	1975-12-16	2007-03-03
5	5	1	2001-05-18	2019-05-27
6	6	1	2016-09-25	2023-07-16
7	7	1	2001-02-09	2013-05-19
8	8	1	1979-02-09	1987-09-26
9	9	1	1988-02-05	2020-12-03
10	10	1	2007-04-09	2013-07-16
11	11	1	2016-02-26	2017-10-10
12	12	1	1977-08-14	2025-01-28
13	13	1	2005-12-17	2014-02-21
14	14	1	2009-03-18	2022-10-25
15	15	1	2013-10-10	2023-05-14
16	16	1	1976-06-22	1980-12-26
17	17	1	2005-11-02	2014-04-08
18	18	1	1995-02-09	2008-09-16
19	19	1	2018-02-10	2024-04-02
20	20	1	2000-03-05	2000-09-15
21	21	1	1984-07-12	1998-11-28
22	22	1	2009-01-11	2023-05-14
23	23	1	2009-11-15	2018-12-28
24	24	1	2008-03-26	2009-08-09
25	25	1	2005-09-21	2019-08-23
26	26	1	1978-04-22	2003-05-22
27	27	1	2012-09-20	2016-03-28
28	28	1	1988-01-06	2016-06-15
29	29	1	1999-04-16	2006-08-08
30	30	1	2017-06-07	2020-04-10
31	31	1	1998-01-06	2001-05-31
32	32	1	1982-03-13	1989-07-04
33	33	1	1996-04-17	2011-07-30
34	34	1	1987-03-28	2023-04-16
35	35	1	1996-03-16	1999-06-04
36	36	1	2018-06-25	2020-02-12
37	37	1	2016-08-10	2022-12-01
38	38	1	1995-03-22	2002-08-09
39	39	1	1974-10-03	1979-01-04
40	40	1	2011-07-07	2014-11-09
41	41	1	2005-06-03	2023-12-25
42	42	1	2023-03-09	2023-05-24
43	43	1	2020-06-05	2023-08-20
44	44	1	1983-11-22	2005-09-09
45	45	1	1993-12-15	1993-12-26
46	46	1	1998-02-17	2021-02-24
47	47	1	1976-09-07	2017-04-25
48	48	1	1998-12-10	2005-07-16
49	49	1	1990-04-10	1997-08-17
50	50	1	2022-02-01	2024-07-03
51	51	1	2005-04-17	2006-01-21
52	52	1	1977-12-31	2018-08-16
53	53	1	1985-06-11	1985-07-06
54	54	1	1978-07-17	2022-10-10
55	55	1	1976-02-01	1992-12-17
56	56	1	1997-01-31	2013-09-01
57	57	1	2022-07-30	2024-01-14
58	58	1	1999-01-12	2011-08-09
59	59	1	1980-09-02	2021-06-14
60	60	1	2007-10-09	2014-10-13
61	61	1	1981-08-03	2014-06-28
62	62	1	1994-07-03	2024-09-19
63	63	1	1996-12-31	2007-03-12
64	64	1	1992-07-11	1992-09-10
65	65	1	2003-12-29	2023-05-29
66	66	1	1978-04-02	1985-03-12
67	67	1	1999-03-14	2012-12-28
68	68	1	1982-03-06	2024-01-29
69	69	1	1995-05-03	2005-03-30
70	70	1	2015-03-17	2021-03-10
71	71	1	2002-03-02	2014-01-31
72	72	1	2002-03-23	2022-06-23
73	73	1	1995-05-17	2010-04-09
74	74	1	1984-01-26	2018-06-06
75	75	1	1994-02-28	1997-11-13
76	76	1	2019-06-13	2024-06-04
77	77	1	2007-02-02	2015-09-16
78	78	1	1996-03-16	2021-09-16
79	79	1	2002-01-05	2018-11-21
80	80	1	1973-12-18	1998-01-22
81	81	1	1990-12-08	2002-09-18
82	82	1	1972-07-06	1978-10-07
83	83	1	1972-12-09	1995-07-04
84	84	1	2022-01-25	2025-02-24
85	85	1	2016-05-31	2020-06-28
86	86	1	1979-01-24	1985-04-02
87	87	1	2018-06-12	2020-06-23
88	88	1	1980-11-20	1987-01-19
89	89	1	1977-09-21	2012-09-19
90	90	1	2004-10-20	2019-02-16
91	91	1	1974-09-18	2024-04-11
92	92	1	2018-10-14	2021-12-14
93	93	1	1979-04-10	2007-09-18
94	94	1	1993-05-08	2022-02-12
95	95	1	2004-09-02	2022-04-29
96	96	1	1974-05-01	2011-09-14
97	97	1	2023-08-08	2025-02-03
98	98	1	1990-06-03	1997-05-03
99	99	1	2023-01-17	2023-03-19
100	100	1	2018-03-29	2018-11-14
\.


--
-- TOC entry 5003 (class 0 OID 16527)
-- Dependencies: 233
-- Data for Name: passenger; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.passenger (person_id, discount) FROM stdin;
201	0.3
202	0.2
203	0.3
204	0.5
205	0.4
206	0.3
207	0.4
208	0.2
209	0.5
210	0.5
211	0.1
212	0.5
213	0.5
214	0.5
215	0.3
216	0.5
217	0.1
218	0.1
219	0.4
220	0.3
221	0.3
222	0.5
223	0.2
224	0.2
225	0.1
226	0.5
227	0.1
228	0.4
229	0.3
230	0.3
231	0.2
232	0.3
233	0.3
234	0.4
235	0.3
236	0.5
237	0.2
238	0.1
239	0.1
240	0.3
241	0.1
242	0.1
243	0.1
244	0.1
245	0.4
246	0.2
247	0.1
248	0.2
249	0.3
250	0.5
251	0.3
252	0.2
253	0.2
254	0.4
255	0.1
256	0.1
257	0.5
258	0.4
259	0.3
260	0.1
261	0.1
262	0.3
263	0.5
264	0.5
265	0.1
266	0.3
267	0.2
268	0.3
269	0.3
270	0.3
271	0.2
272	0.2
273	0.2
274	0.5
275	0.4
276	0.5
277	0.4
278	0.4
279	0.4
280	0.1
281	0.1
282	0.1
283	0.5
284	0.5
285	0.3
286	0.1
287	0.3
288	0.1
289	0.1
290	0.5
291	0.4
292	0.5
293	0.2
294	0.5
295	0.3
296	0.1
297	0.4
298	0.3
299	0.5
300	0.4
\.


--
-- TOC entry 4997 (class 0 OID 16468)
-- Dependencies: 227
-- Data for Name: payment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.payment (id, payment_type_id, employee_id, amount, date) FROM stdin;
1	1	1	79179	2016-06-11
2	1	2	64878	1981-03-18
3	1	3	69950	1977-03-28
4	1	4	68930	2011-02-01
5	1	5	61659	2007-02-28
6	1	6	79498	1990-07-21
7	1	7	60464	1991-11-25
8	1	8	66341	2005-06-08
9	1	9	72678	2007-01-09
10	1	10	74395	1978-05-07
11	1	11	62205	2012-01-12
12	1	12	63518	1980-05-22
13	1	13	79873	1972-02-28
14	1	14	61541	1994-09-26
15	1	15	62960	2007-12-08
16	1	16	75018	2003-05-23
17	1	17	74756	2014-05-13
18	1	18	75117	1972-02-14
19	1	19	63450	1978-08-15
20	1	20	71516	2017-04-18
21	1	21	60165	1984-09-30
22	1	22	64470	1976-07-11
23	1	23	66612	1996-12-02
24	1	24	69647	2006-04-19
25	1	25	71666	1986-06-23
26	1	26	60437	1998-01-06
27	1	27	60712	2000-03-27
28	1	28	71023	1982-03-16
29	1	29	77961	2003-02-09
30	1	30	63032	2021-12-13
31	1	31	64833	2008-07-27
32	1	32	67553	2006-06-08
33	1	33	73425	2020-06-12
34	1	34	77722	1979-03-13
35	1	35	73109	2008-11-21
36	1	36	77630	1996-07-12
37	1	37	65241	1970-06-02
38	1	38	68712	1994-05-17
39	1	39	77764	1998-06-08
40	1	40	68158	2019-06-09
41	1	41	65448	2016-04-03
42	1	42	77424	2016-01-21
43	1	43	72761	1999-09-12
44	1	44	65273	2006-04-20
45	1	45	61537	1981-11-27
46	1	46	61719	2002-01-19
47	1	47	72880	2000-08-03
48	1	48	65144	2016-08-09
49	1	49	66782	2005-01-02
50	1	50	67222	1999-01-09
51	1	51	70536	1994-03-02
52	1	52	70853	2014-04-06
53	1	53	65037	2019-11-19
54	1	54	76390	1983-11-23
55	1	55	73928	2022-02-15
56	1	56	65847	2016-08-11
57	1	57	72843	2000-06-18
58	1	58	61713	2024-03-22
59	1	59	64868	1998-11-06
60	1	60	78826	1974-07-08
61	1	61	67706	1975-09-13
62	1	62	69340	2018-06-22
63	1	63	66961	1996-08-16
64	1	64	66619	2009-12-17
65	1	65	73828	1993-09-27
66	1	66	66292	1970-04-18
67	1	67	69178	2015-02-25
68	1	68	78739	1984-01-25
69	1	69	62169	1991-04-03
70	1	70	64628	1975-05-31
71	1	71	68197	2008-11-23
72	1	72	75726	1973-02-12
73	1	73	77935	2024-09-12
74	1	74	70593	2020-06-20
75	1	75	61189	1976-01-30
76	1	76	60445	2006-09-12
77	1	77	74028	2000-10-10
78	1	78	72149	2010-12-22
79	1	79	72911	1999-10-29
80	1	80	62103	1997-10-02
81	1	81	76378	2017-03-18
82	1	82	79159	2021-11-04
83	1	83	67984	1986-03-06
84	1	84	64699	1979-12-05
85	1	85	60617	1992-01-06
86	1	86	77466	1980-02-14
87	1	87	73711	1994-07-21
88	1	88	61301	1982-09-02
89	1	89	66675	1974-03-01
90	1	90	61909	1993-05-03
91	1	91	78592	1974-03-14
92	1	92	72751	1980-09-24
93	1	93	61103	1988-06-03
94	1	94	75290	2019-04-20
95	1	95	65073	1973-12-03
96	1	96	70347	1993-07-07
97	1	97	67316	1990-12-10
98	1	98	62939	1988-02-09
99	1	99	75128	1981-05-31
100	1	100	74939	1985-04-06
101	2	1	18848	1986-05-28
102	2	2	17085	1972-05-27
103	2	3	16297	1974-06-23
104	2	4	18412	1993-09-20
105	2	5	15872	1986-08-25
106	2	6	13164	1981-05-10
107	2	7	17413	2008-02-15
108	2	8	16283	2000-01-13
109	2	9	18740	1989-04-26
110	2	10	13174	1972-11-24
111	2	11	13164	1994-03-20
112	2	12	13760	2015-07-05
113	2	13	13068	1971-12-08
114	2	14	15072	1975-09-28
115	2	15	10746	2015-01-18
116	2	16	12577	2006-12-16
117	2	17	18818	2004-08-31
118	2	18	18379	1986-05-26
119	2	19	19027	1988-10-07
120	2	20	14922	1995-08-09
121	2	21	18650	2009-07-07
122	2	22	12936	2011-01-02
123	2	23	19510	1984-12-22
124	2	24	15300	2012-10-18
125	2	25	13040	1984-03-14
126	2	26	12719	1972-09-17
127	2	27	16553	1996-10-06
128	2	28	19729	1999-05-01
129	2	29	13494	2001-02-28
130	2	30	19240	1997-02-09
131	2	31	14308	1973-05-23
132	2	32	17425	2001-08-15
133	2	33	19352	2005-07-02
134	2	34	19662	2013-08-25
135	2	35	18663	1996-09-12
136	2	36	15939	1972-02-25
137	2	37	14157	1971-06-18
138	2	38	17730	1992-12-30
139	2	39	19393	2001-03-29
140	2	40	17383	2024-10-27
141	2	41	17901	2014-03-06
142	2	42	12090	1973-02-05
143	2	43	14570	1996-11-23
144	2	44	13089	1998-10-06
145	2	45	13428	1991-04-04
146	2	46	17216	1980-05-28
147	2	47	16689	2007-03-31
148	2	48	11281	1991-11-29
149	2	49	10118	1982-03-07
150	2	50	12449	1970-06-17
151	2	51	14147	1984-11-19
152	2	52	13404	2017-08-08
153	2	53	16515	2024-07-26
154	2	54	12129	2016-10-04
155	2	55	10381	2024-01-14
156	2	56	19901	1993-07-13
157	2	57	15487	2015-12-16
158	2	58	10711	2012-05-16
159	2	59	14560	2021-03-22
160	2	60	18177	2007-04-16
161	2	61	18713	2024-02-19
162	2	62	12266	1984-11-20
163	2	63	19571	1972-02-18
164	2	64	15067	1998-01-16
165	2	65	18587	2000-05-12
166	2	66	13137	1984-08-24
167	2	67	17724	1978-11-21
168	2	68	19964	2019-10-31
169	2	69	13230	1987-05-14
170	2	70	12908	2007-04-15
171	2	71	17763	2023-11-26
172	2	72	15720	2017-01-10
173	2	73	17797	1999-12-03
174	2	74	14669	2016-08-30
175	2	75	16752	1993-09-07
176	2	76	13837	1998-12-29
177	2	77	11965	2021-11-08
178	2	78	15813	1989-09-28
179	2	79	10250	2024-04-12
180	2	80	10704	1996-04-03
181	2	81	13513	2007-05-18
182	2	82	16141	2000-12-17
183	2	83	13119	2003-02-20
184	2	84	12178	2024-02-15
185	2	85	16707	2015-12-03
186	2	86	15466	2000-06-11
187	2	87	10014	2020-12-15
188	2	88	16212	1975-12-28
189	2	89	11385	1984-05-09
190	2	90	18595	2011-05-03
191	2	91	10850	1973-07-30
192	2	92	16554	2015-12-16
193	2	93	10725	2014-08-03
194	2	94	12371	2003-08-01
195	2	95	12501	1998-09-10
196	2	96	12970	1980-08-08
197	2	97	12636	1991-03-01
198	2	98	16004	2013-08-02
199	2	99	10989	1996-05-13
200	2	100	10519	2002-07-09
\.


--
-- TOC entry 4995 (class 0 OID 16461)
-- Dependencies: 225
-- Data for Name: payment_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.payment_type (id, name) FROM stdin;
1	Зарплата
2	Премия
3	Компенсация
4	Социальная выплата
5	Возмещение расходов
\.


--
-- TOC entry 4987 (class 0 OID 16402)
-- Dependencies: 217
-- Data for Name: person; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.person (id, full_name, address, phone, passport) FROM stdin;
1	Петров Поликарп Архипович	г. Архыз, наб. Просвещения, д. 647 стр. 1, 306819	+72428659564	3931 794207
2	Эдуард Венедиктович Сорокин	к. Нижнеудинск, наб. Светлая, д. 4, 063773	+70815819529	0835 387681
3	Спиридон Валентинович Степанов	п. Санкт-Петербург, ул. Угловая, д. 28 стр. 612, 731768	+79531423711	6348 271181
4	Леонид Тимурович Никонов	ст. Тихвин, ул. 50 лет Октября, д. 613 стр. 5, 976181	+72051414267	1349 149654
5	Филиппова Иванна Даниловна	п. Красноселькуп, алл. Рыбацкая, д. 1 к. 98, 276062	+72616364714	4055 215868
6	Агафонов Герасим Богданович	д. Усть-Камчатск, бул. Кедровый, д. 88, 709413	+79806523542	3277 706504
7	Мартынова Вера Филипповна	клх Яр-Сале, алл. Серафимовича, д. 9 стр. 77, 339820	+72572750143	2144 109412
8	Тимур Трофимович Елисеев	д. Горячий Ключ, ш. Механическое, д. 210, 015012	+75792501393	9733 626034
9	Красильников Ефим Абрамович	с. Чайковский, пр. Пограничный, д. 9, 119839	+73011639251	7833 919039
10	Харитонов Модест Гертрудович	к. Пушкинские Горы, бул. Енисейский, д. 6 к. 8/8, 559299	+79664772249	8926 061451
11	Громов Чеслав Бориславович	г. Забайкальск, ш. Станиславского, д. 9/4, 640573	+76634400389	0183 300990
12	Лебедева Кира Артемовна	г. Двинской, пер. Ленский, д. 1/5 к. 546, 879675	+74906893654	4814 789390
13	Феоктист Иосипович Русаков	с. Кедровый, бул. Короткий, д. 47 к. 478, 934661	+79214716969	7162 210358
14	Беляева Анжелика Робертовна	д. Королев, ул. Энтузиастов, д. 822 к. 484, 838223	+70646421033	8793 556703
15	Крылова Эмилия Робертовна	клх Тикси, пер. Спортивный, д. 5 к. 1, 504259	+78162925263	2768 397467
16	Лукина Маргарита Борисовна	к. Дмитров, пр. Вахитова, д. 2/2 стр. 5, 179125	+72941133253	1874 047820
17	Королева Лидия Эдуардовна	г. Североуральск, ул. Воронежская, д. 2 к. 5/2, 093403	+79468865631	1476 407803
18	Данилова Раиса Вячеславовна	п. Тамбов, бул. Черемуховый, д. 9 к. 1, 120709	+76756648241	8631 336495
19	Жуков Онуфрий Брониславович	г. Кущевская, алл. Учительская, д. 6/1 стр. 32, 738635	+76292899001	3853 854175
20	Дорофеева Полина Максимовна	д. Октябрьский (Башк.), пер. Хвойный, д. 6/9 к. 245, 130518	+78881208463	9070 186417
21	Элеонора Анатольевна Дорофеева	с. Тотьма, бул. Литейный, д. 6, 506582	+74658733790	4559 150819
22	Субботина Евгения Афанасьевна	д. Челябинск, бул. Тюленина, д. 183 стр. 3/8, 725164	+71613835641	4031 423039
23	Алексей Давидович Голубев	к. Цимлянск, ул. Курганная, д. 167 стр. 5/2, 110704	+70645811937	2804 584466
24	Мамонтов Трофим Виленович	п. Холмогоры, ш. Запрудное, д. 396 стр. 47, 461071	+71987093295	4036 925441
25	Эммануил Феоктистович Буров	п. Абакан, ш. Мирное, д. 8/9, 659151	+77958624540	0984 188580
26	Князева Алина Артемовна	г. Новомосковск, пр. Народный, д. 66 к. 8/6, 646723	+76504341076	8077 622207
27	Семенова Прасковья Вадимовна	д. Ноябрьск, ул. Брянская, д. 36 стр. 690, 703716	+70647159542	3722 252514
28	Голубева Марина Геннадьевна	клх Кандалакша, наб. Водников, д. 100 к. 1, 800843	+78292985111	2304 596069
29	Ираида Феликсовна Воронцова	к. Абакан, ш. Дорожное, д. 41 стр. 650, 119884	+73682860874	8035 074804
30	Потапова Зоя Петровна	д. Нязепетровск, наб. Строительная, д. 300 к. 5, 674761	+79874497589	6583 370197
31	Нинель Владимировна Рыбакова	д. Костомукша, бул. Короткий, д. 8/2 стр. 130, 683399	+71946823273	2768 581355
32	Козлова Жанна Валентиновна	с. Урай, ш. Севастопольское, д. 54 стр. 282, 123876	+73111129249	5647 233861
33	Сысоев Амвросий Фомич	д. Абинск, ул. Димитрова, д. 55 стр. 52, 975555	+73028977083	3981 270671
34	Лыткин Карп Иосифович	п. Краснодар, ул. Космонавтов, д. 39 стр. 9/9, 570355	+73113411416	4699 274414
35	Татьяна Яковлевна Гусева	ст. Пушкинские Горы, бул. Пионерский, д. 7, 173857	+77532115909	3611 659796
36	Наина Наумовна Князева	клх Городовиковск, ш. Некрасова, д. 5 к. 1, 127082	+78907403801	5438 140445
37	Милий Брониславович Гурьев	д. Пермь, наб. Тукая, д. 4/3, 430123	+73774177400	2238 582631
38	Селезнева Дарья Леонидовна	к. Петропавловск-Камчатский, ш. Приозерное, д. 99 к. 57, 306219	+75002513094	4330 680781
39	Семенова Елена Рубеновна	г. Арзамас, бул. Хуторской, д. 5/8 к. 7/5, 007004	+74786152358	0411 994922
40	Ермакова Евпраксия Архиповна	п. Алдан, алл. Гражданская, д. 1 к. 19, 348996	+77421798159	9705 992194
41	Рябов Мартын Дмитриевич	клх Амдерма, ш. Совхозное, д. 7/1 к. 598, 097775	+72632902523	1228 607297
42	Маслова Фаина Сергеевна	д. Ясный (Оренб.), ул. Запорожская, д. 203 стр. 6/9, 270842	+78280474693	8021 780547
43	Михаил Марсович Колобов	г. Выборг, алл. Юбилейная, д. 7, 376992	+77183360576	8033 429713
44	Логинов Митофан Тихонович	п. Пятигорск, наб. Кочубея, д. 481 к. 2, 021209	+79911764366	6704 753742
45	Ульяна Руслановна Артемьева	д. Тулун, наб. Баумана, д. 6, 043984	+71594900320	4089 671262
46	Исакова Евгения Борисовна	ст. Октябрьский (Башк.), наб. Привольная, д. 448 стр. 7/6, 479097	+70387332452	3259 455804
47	Петухова Элеонора Захаровна	г. Яхрома, пер. Детский, д. 3 к. 89, 063905	+70695497804	9716 971580
48	Соловьева Таисия Николаевна	клх Городовиковск, ул. Виноградная, д. 66, 705777	+73737323204	5206 118132
49	Лазарева Екатерина Харитоновна	клх Крымск, бул. Медицинский, д. 6/9, 905284	+76439519955	5766 070892
50	Олег Виленович Белоусов	к. Челябинск, ул. Чкалова, д. 8, 016316	+77622317847	7779 315714
51	Нонна Николаевна Лебедева	г. Орехово-Зуево, пер. Макаренко, д. 7 стр. 8, 578085	+78553962165	0743 078241
52	Кириллов Селиван Анисимович	к. Руза, пер. Культуры, д. 17 стр. 6, 668618	+70265523375	1102 793019
53	Анастасия Станиславовна Лихачева	с. Нязепетровск, алл. Горняцкая, д. 373, 945054	+71853972736	0773 992366
54	Константин Виленович Симонов	клх Новокузнецк, пр. Сосновый, д. 5 стр. 5/5, 438246	+75672857129	1152 362293
55	Устинов Филарет Юльевич	с. Троицко-Печорск, ул. Мельничная, д. 7, 006922	+73870063497	1259 004146
56	Абрамов Мартьян Всеволодович	с. Шуя, пр. Уральский, д. 2/5 стр. 6/9, 984320	+79091006305	9182 649599
57	Елена Юрьевна Моисеева	клх Мыс Шмидта, бул. О.Кошевого, д. 224 к. 79, 836026	+76443282307	9868 329555
58	г-жа Медведева Оксана Мироновна	д. Мичуринск, пер. Кузнечный, д. 280, 967591	+71015764661	8556 020921
59	Артемий Евстигнеевич Дьячков	с. Якша, пр. Коллективный, д. 2 к. 2, 330345	+70550855454	1305 659867
60	Беляев Всемил Арсеньевич	к. Луховицы, наб. Степана Разина, д. 622 стр. 4/8, 740462	+79829570828	9295 688989
61	Майя Робертовна Михайлова	с. Сибай, бул. Ангарский, д. 2 к. 84, 373479	+71983123606	7090 295506
62	Ольга Филипповна Прохорова	г. Кировск (Мурм.), пр. Строителей, д. 3, 450972	+70205980444	2614 517345
63	Горбунов Кирилл Вилорович	п. Амдерма, ул. Прибрежная, д. 19, 474766	+72297091446	5744 795692
64	Дорофей Фокич Мельников	ст. Пятигорск, алл. Придорожная, д. 8/9 стр. 4, 978167	+70643662603	3734 820248
65	Кудряшов Аскольд Дорофеевич	п. Воткинск, пр. Пролетарский, д. 31, 187800	+72483590023	8603 807637
66	Анисим Филимонович Попов	д. Холмогоры, алл. Жукова, д. 7/3 к. 117, 488070	+75416977994	1302 028342
67	Павлова Зоя Тимофеевна	ст. Любань, наб. Ушакова, д. 87 стр. 6, 333396	+76840648362	7102 053075
68	Петр Фролович Павлов	п. Жигулевск, бул. Локомотивный, д. 6/8, 443807	+73687545632	8942 863954
69	Дарья Филипповна Давыдова	п. Крымск, алл. Мусы Джалиля, д. 75 стр. 5/6, 011965	+78125386744	8157 489078
70	Максимильян Ильясович Медведев	г. Уфа, алл. Бажова, д. 4/4 стр. 7/5, 072656	+76705455281	8633 946617
71	Галина Степановна Кабанова	клх Ирбит, бул. 9 мая, д. 948 стр. 6, 093572	+70291750518	2426 262764
72	Волков Борис Захарьевич	клх Амдерма, ул. Щорса, д. 7/2 к. 4, 805465	+73951754546	7856 314841
74	Степанова Нонна Богдановна	к. Усть-Илимск, пр. Серафимовича, д. 344, 595627	+78688219902	0130 426782
75	Никандр Ефремович Комаров	п. Новокузнецк, наб. Макаренко, д. 276 стр. 57, 164946	+79687230308	8906 148194
76	Шаров Яков Ермолаевич	ст. Наро-Фоминск, бул. Тепличный, д. 4, 467645	+76724888454	7671 826807
77	Панфил Богданович Зыков	клх Урай, алл. Жданова, д. 3 к. 609, 600151	+77131825219	1471 240227
78	Овчинникова Нонна Никифоровна	г. Луга, наб. Подстанция, д. 8 стр. 1/9, 409297	+74657502249	6282 599646
79	Дарья Даниловна Крылова	ст. Тобольск, алл. Большая, д. 5, 061164	+73499159241	6379 654675
80	Лаврентьева Вера Афанасьевна	к. Москва, МГУ, бул. Автомобилистов, д. 67 стр. 3, 526000	+79352338018	8248 557370
81	Раиса Игоревна Чернова	г. Нягань, алл. Ярославская, д. 36 к. 404, 598261	+79522525772	2590 353024
82	Феликс Григорьевич Меркушев	д. Зарайск, бул. Загородный, д. 9 стр. 7, 970280	+71056513759	3448 407345
83	Морозова Анна Анатольевна	г. Орск, бул. Чапаева, д. 323 стр. 698, 841567	+77318772380	5285 961571
84	Иванова Галина Наумовна	с. Тамбей, пр. Февральский, д. 7/8 стр. 7, 197973	+74409176369	4463 614932
85	Коновалова Феврония Оскаровна	г. Каневская, пер. Заливный, д. 108 к. 3, 368502	+73001526172	7765 782530
86	Гордей Германович Кулаков	к. Тамбов, наб. Малая, д. 485, 456113	+71132558772	8923 136422
87	Копылова Александра Филипповна	к. Шадринск, ул. Кузнечная, д. 87, 081376	+79542092959	9109 949772
88	Парамон Ерофеевич Ковалев	г. Кондопога, наб. Красина, д. 9, 007739	+75288023351	1357 281720
89	Лариса Макаровна Федотова	г. Кунгур, ул. 40 лет Победы, д. 3/1 к. 45, 398369	+75306553576	8253 995800
90	Елена Яковлевна Кузнецова	ст. Кондопога, алл. Щетинкина, д. 3/8 к. 86, 034226	+74912207458	1890 780553
91	Блохин Ираклий Арсенович	д. Североуральск, алл. Радужная, д. 2/8, 179208	+79312550032	3398 045865
92	Потапова Зинаида Сергеевна	д. Серов, ш. Выгонное, д. 6 стр. 9, 482836	+70342339857	1382 737267
93	Шилова Алла Захаровна	г. Ржев, наб. Ангарская, д. 9/8, 173691	+77761105372	8168 626754
94	Агафонова Алина Егоровна	с. Артем, наб. Садовая, д. 4/7 стр. 392, 262448	+73743260425	8335 801351
95	Тихонов Ким Ярославович	к. Псебай, наб. Саратовская, д. 5/5, 192151	+79568917922	0620 178378
96	Феврония Аркадьевна Котова	п. Туапсе, пер. 8 Марта, д. 148 к. 34, 417890	+70667707938	3574 367845
97	Мирон Адрианович Некрасов	д. Кедровый, пер. Мельничный, д. 2 к. 64, 889998	+79029816886	0916 004036
98	Зиновьева Алла Ивановна	с. Тикси, пер. Механический, д. 56 стр. 9, 399919	+75297258137	3824 500520
99	Лидия Викторовна Гусева	с. Глазов, алл. Ермака, д. 7/7, 341899	+79807227568	1633 066355
100	Егор Ефремович Капустин	п. Рязань, пр. Матросова, д. 44 к. 5/9, 014643	+79784552173	8951 338566
101	Дмитрий Федосеевич Фадеев	г. Поронайск, пер. Вокзальный, д. 62 к. 714, 509060	+76409556297	8491 847064
102	Прохор Федосеевич Корнилов	к. Охотск, алл. О.Кошевого, д. 6/5, 208145	+79080154089	5826 503594
103	Глафира Аскольдовна Ситникова	ст. Александровск-Сахалинский, ул. Октябрьская, д. 68 к. 1, \n002454	+75660508807	3597 106765
104	Панкрат Ааронович Колобов	г. Жуковский, пер. Лунный, д. 849, 646735	+71370227126	8527 552991
105	Устинов Тит Арсеньевич	д. Самара, бул. Карбышева, д. 5/9 стр. 7, 935193	+70148027691	4021 392742
106	Никодим Харлампьевич Гаврилов	к. Красновишерск, ул. Кутузова, д. 6 стр. 325, 428696	+76081093874	7633 048360
108	Журавлева Нинель Егоровна	клх Сочи, бул. Алтайский, д. 2/1 стр. 7/3, 855570	+74922711639	3219 376736
109	Котова Василиса Львовна	д. Калач, ул. Ленская, д. 7/7 к. 523, 869062	+73566175961	0771 618026
110	Субботин Пантелеймон Измаилович	к. Лабытнанги, бул. Кирова, д. 9/7 к. 79, 844381	+77723286080	1799 345135
111	Ольга Владимировна Русакова	г. Железногорск(Курск.), алл. Западная, д. 7/8, 421319	+76826864056	7400 908950
112	Евлампий Антипович Гусев	к. Новороссийск, наб. Суворова, д. 6/6 стр. 72, 140393	+72069085068	6423 590457
113	Степанов Варлаам Устинович	ст. Жигулевск, алл. Троицкая, д. 5 стр. 7/1, 375082	+74471843154	6026 001281
114	Кира Валериевна Дьячкова	п. Печенга, пер. Горького, д. 5 стр. 3/2, 143347	+70718360491	6653 805865
115	Иванова Марфа Ефимовна	д. Яшалта, наб. Авиационная, д. 640 к. 131, 868328	+74548651539	6104 968607
116	Александра Викторовна Комиссарова	г. Бодайбо, пер. Морской, д. 6, 752100	+75801363311	6345 163272
117	Панфилов Эраст Дорофеевич	г. Нефтеюганск, пер. Приозерный, д. 89, 468917	+73275330253	8482 660285
118	Гордеев Федор Яковлевич	клх Плесецк, бул. Новосельский, д. 897 к. 5/3, 952304	+72717609466	9240 682736
119	Алевтина Юрьевна Авдеева	г. Липецк, ул. Раздольная, д. 4/8 к. 70, 864761	+77146019849	2907 560585
120	Ия Ефимовна Ефимова	ст. Бологое, ш. Металлургов, д. 861 стр. 610, 477515	+75916714450	7447 443953
121	Самойлова Майя Андреевна	п. Сарапул, ш. Светлое, д. 5 к. 7, 971004	+79400780727	2200 799342
123	Лариса Юрьевна Михеева	г. Нерчинск, наб. Прудная, д. 7, 918847	+71813196377	6522 437976
124	Николаева София Юльевна	п. Апшеронск, пер. Лесозаводский, д. 41, 479321	+78937659746	7769 825855
125	Гедеон Феликсович Никонов	клх Куртамыш, ул. Новостройка, д. 57 стр. 268, 217934	+70796866762	8867 230967
126	Владимирова Нонна Геннадьевна	ст. Ахтубинск, бул. Севастопольский, д. 4, 527732	+78909306505	3590 035969
127	Кузнецова Тамара Евгеньевна	п. Томск, пр. Детский, д. 16, 934681	+74490708392	7413 010404
128	Никонова Зинаида Леоновна	г. Казань, алл. Геологическая, д. 206 к. 475, 568255	+70070575575	1409 884283
129	Костин Владимир Евсеевич	ст. Серебряные Пруды, пр. Таманский, д. 740 к. 4, 755611	+74402828416	5931 624688
130	Орехов Фадей Давыдович	д. Тарко-Сале, бул. Геологический, д. 1/3 стр. 6, 189407	+78275840781	4426 839568
131	Исаев Остап Юльевич	к. Мыс Шмидта, алл. З.Космодемьянской, д. 74, 398776	+70153341402	9857 092134
132	Регина Дмитриевна Орлова	клх Азов (Рост.), ул. Ушакова, д. 3/3 к. 951, 584970	+79282057485	6275 648010
133	Лидия Егоровна Блохина	с. Самара, наб. Кирова, д. 87 стр. 30, 375186	+70306752142	5021 957777
134	Шашкова Вероника Захаровна	клх Элиста, бул. Главный, д. 9 стр. 459, 266694	+71904591790	2103 434774
135	Константинов Савва Исидорович	п. Кропоткин (Краснод.), пер. Короленко, д. 4/9 к. 354, 837371	+78375595254	7307 597288
136	Филарет Филимонович Лобанов	к. Анива, ш. Гражданское, д. 82, 419429	+78821853837	9021 116650
137	Спиридон Елисеевич Орехов	п. Ишим, алл. Иванова, д. 260, 366614	+76597453185	3763 666282
138	Богданов Бажен Ярославович	клх Крымск, бул. Приморский, д. 78 к. 555, 909499	+77947901724	4938 481676
139	Алевтина Феликсовна Аксенова	клх Астрахань, бул. Пролетарский, д. 4/4, 705858	+79449895135	0006 637982
140	Щербаков Максимильян Аксёнович	д. Мценск, ш. Карбышева, д. 62, 223147	+73550027838	2197 350441
141	Евфросиния Оскаровна Бобылева	с. Прохладный, ш. Энергетиков, д. 407 к. 213, 489242	+79391746800	6827 529121
142	Харитонов Сила Иларионович	д. Асбест, бул. Васильковый, д. 6, 150978	+76527809266	9623 986992
143	Новикова Алина Львовна	клх Елец, бул. Челюскинцев, д. 7 к. 6, 956320	+70034802409	3873 810207
144	Русаков Лучезар Федотович	д. Владимир, алл. Большевистская, д. 224 к. 7/1, 868416	+75472768416	4015 418467
145	Якушев Аполлон Викентьевич	д. Снежногорск (Мурм.), наб. Громова, д. 8/5, 426567	+75731070670	4126 781816
146	Филиппов Максимильян Арсеньевич	д. Яшкуль, наб. Мелиоративная, д. 1/3 к. 9/9, 306885	+73603033036	4204 699101
147	Евдокия Павловна Фокина	г. Адлер, бул. Фадеева, д. 6 стр. 32, 962521	+70923228879	6937 038096
148	Леонтий Викторович Лобанов	клх Сухиничи, ш. Путейское, д. 1/2, 558921	+71442781335	8699 660906
149	Афанасьев Ким Архипович	клх Игнашино, ш. Ольховое, д. 85 к. 8/9, 394216	+74179768527	9227 823139
150	Капитон Валентинович Буров	клх Усть-Катав, бул. Брянский, д. 85 к. 3, 872177	+72091731275	7452 984252
151	Комаров Анатолий Измаилович	с. Томпа, пр. Шаумяна, д. 63, 505322	+78673268034	0893 389376
152	Константинова Лидия Ивановна	г. Камышлов, наб. Краснофлотская, д. 6/8 стр. 837, 353219	+74603109554	1560 356341
153	Людмила Тимофеевна Давыдова	д. Амурск, пр. Озерный, д. 6 к. 3, 211492	+74122865351	1811 424572
154	Октябрина Антоновна Власова	п. Тура, ул. Целинная, д. 2/9 к. 8, 030066	+75727886752	8499 872667
155	Фомичева Прасковья Антоновна	клх Обнинск, пр. Павлова, д. 50 к. 1/3, 412029	+70038830792	8677 070087
156	Всеслав Филатович Ситников	к. Кежма, пр. Л.Толстого, д. 3/6 к. 162, 064638	+70978460860	7564 190334
157	Мельникова Зинаида Валентиновна	г. Вуктыл, пр. Интернациональный, д. 6, 604033	+74629541185	9444 846790
158	Панфилов Поликарп Бориславович	п. Кингисепп, ш. Курчатова, д. 41 к. 614, 516955	+72932349284	4276 059844
159	Зайцева Варвара Афанасьевна	к. Нефтекамск, ул. Магистральная, д. 55 к. 67, 222142	+76018664392	4595 792970
160	Егор Изотович Романов	п. Камень-на-Оби, пер. Матросова, д. 44 стр. 3, 007942	+75048618956	3399 832708
161	Епифан Ефимьевич Якушев	п. Октябрьское (Хант.), пер. Горького, д. 403, 220333	+70229425860	5822 095630
162	Октябрина Леонидовна Денисова	ст. Кырен, наб. Малая, д. 6/9 стр. 3, 885738	+70059815257	5420 884599
163	Селиверст Демьянович Мамонтов	г. Киренск, пер. Кавказский, д. 91 стр. 318, 642571	+76906811848	3263 076453
164	Александра Тарасовна Николаева	ст. Урус-Мартан, ш. Лермонтова, д. 964, 221081	+70148307649	8272 152504
165	Ярополк Адамович Ларионов	п. Богучар, ш. Иркутское, д. 3/3 стр. 6, 709856	+78265853621	9009 943851
166	Родионова Екатерина Федоровна	г. Бодайбо, ул. 30 лет Победы, д. 5 к. 15, 107845	+76387107476	0280 245085
167	Лукина Екатерина Никифоровна	к. Солнечногорск, бул. Культуры, д. 6/5 стр. 86, 658324	+77561157896	9354 604603
168	Порфирий Ааронович Гордеев	к. Карталы, алл. Спартака, д. 2/4 к. 288, 798363	+79828798002	8832 929241
169	Андрей Харлампович Гаврилов	г. Благовещенск (Амур.), ул. Монтажников, д. 6/9 стр. 1, 296973	+77339860657	7828 527179
170	Карпова Елена Аркадьевна	п. Курильск, бул. Куйбышева, д. 926 к. 25, 597054	+76715572706	5355 504415
171	Логинова Оксана Егоровна	ст. Енисейск, алл. Лесхозная, д. 1 стр. 966, 096210	+75874181406	4200 407590
172	Дмитриев Геннадий Яковлевич	с. Касимов, бул. Болотный, д. 9/4 стр. 97, 203439	+77787760314	9704 815857
173	Воробьев Аникей Богданович	г. Сузун, ул. Гвардейская, д. 52 к. 588, 585737	+70679143952	8368 975803
174	Мина Елизарович Беляков	клх Челюскин, наб. Мичурина, д. 44 стр. 7/7, 208182	+72444491594	7007 054039
175	Фирс Денисович Горбачев	с. Калуга, алл. Московская, д. 5 стр. 1, 619205	+70804493393	5396 088724
176	Олимпиада Степановна Белозерова	п. Серафимович, алл. Тихая, д. 20, 787150	+76075344132	6510 939127
177	Ефимов Добромысл Дорофеевич	клх Данков, ш. Мира, д. 5/8 стр. 8, 000708	+75360116105	0014 583464
178	Нинель Руслановна Беляева	клх Североуральск, пр. Элеваторный, д. 6 к. 6/6, 338961	+73773622460	1243 128302
179	Никонов Эмиль Филиппович	ст. Миллерово, наб. 60 лет Октября, д. 9 стр. 179, 540363	+78231347894	5744 809044
180	г-жа Колесникова Глафира Вадимовна	п. Красная Поляна, ул. Энергетическая, д. 3/3 стр. 9/6, 029128	+74716470937	5257 281663
181	Горшкова Евпраксия Натановна	п. Верхоянск, ул. Ульянова, д. 6/3, 784799	+78031718148	0044 023289
182	Светлана Григорьевна Тарасова	п. Петрозаводск, наб. Металлургов, д. 26, 233646	+76064943137	3060 229242
184	Тамара Игоревна Кондратьева	с. Северобайкальск, бул. Гайдара, д. 7 к. 141, 221057	+71908965208	9832 516176
186	Людмила Ниловна Карпова	ст. Гатчина, пер. Механизаторов, д. 68 стр. 6/4, 072071	+76502844815	9287 957629
187	Богдан Ааронович Нестеров	ст. Карачаевск, пер. Беляева, д. 8 к. 55, 637223	+76906334496	8183 900749
188	Михаил Игнатьевич Журавлев	д. Ишим, ш. Стадионное, д. 7, 112073	+74928708001	7656 552649
189	Адриан Богданович Данилов	п. Бронницы, наб. Болотная, д. 8 стр. 61, 794657	+72876826927	5643 609777
190	Афанасьева Галина Кузьминична	г. Забайкальск, пр. Средний, д. 95, 320436	+78370751720	2990 277278
191	Модест Дорофеевич Селезнев	к. Нефтегорск (Самар.), бул. Виноградный, д. 6/7 стр. 7/6, 133511	+75601992033	3079 939510
192	Евфросиния Владиславовна Константинова	п. Волгоград, пр. Луговой, д. 9 к. 80, 772524	+75228575666	2559 974017
193	Марина Робертовна Борисова	клх Кущевская, алл. Шолохова, д. 1/6 стр. 831, 414556	+72594524424	5062 651937
194	Комарова Алла Леонидовна	клх Кинешма, ш. Набережное, д. 654 к. 4/1, 203018	+77321265804	7157 977876
195	Терентьев Артемий Марсович	с. Домбай, ш. Павлика Морозова, д. 4/8 к. 4/4, 266916	+74373597488	4355 441158
196	Евгения Тимуровна Чернова	ст. Медногорск, ул. Волочаевская, д. 876, 488968	+76108206183	4773 719268
197	Иванна Кузьминична Николаева	д. Поярково, наб. Полярная, д. 2, 822438	+75490032462	8313 829855
198	Воронцов Кирилл Эдгарович	г. Новгород Великий, наб. Хвойная, д. 6 стр. 2, 676907	+78792609670	0412 220412
199	Ульяна Викторовна Дроздова	п. Анапа, пер. Промышленный, д. 713, 597722	+70931012697	7929 718227
200	Щукина Ольга Геннадьевна	ст. Пышма, ул. Камская, д. 83, 067359	+76935844960	1141 942457
201	Андрон Изотович Михеев	с. Москва, наб. Ватутина, д. 7/7 к. 2/2, 582850	+74554436816	5567 218731
202	Евфросиния Максимовна Калинина	к. Шенкурск, пр. Демьяна Бедного, д. 480, 248432	+78861949253	1846 652719
203	Тимур Владиславович Хохлов	г. Партизанск, ул. Минская, д. 5 стр. 3, 128669	+75968290945	1060 339677
204	Галкина Анжелика Кузьминична	г. Листвянка (Иркут.), пр. Орловский, д. 764, 335658	+75206349350	5711 723159
205	Таисия Евгеньевна Фролова	п. Смирных, ул. Украинская, д. 2/5, 150040	+79999162343	1493 291702
206	Виктория Аркадьевна Шарапова	клх Малоярославец, бул. Фабричный, д. 526 стр. 1/9, 510998	+79435402971	2242 284961
207	Татьяна Макаровна Ларионова	п. Уфа, наб. Восточная, д. 3/2 стр. 5, 674929	+73803331133	8830 112973
208	Изот Григорьевич Яковлев	к. Углегорск, ш. О.Кошевого, д. 4/1 к. 56, 449361	+77899057578	3276 546644
209	Одинцов Дорофей Герасимович	п. Кашира, пер. Высоцкого, д. 2/5 стр. 26, 056539	+79515892932	2505 457575
210	Сергеев Вадим Георгиевич	г. Киржач, ул. Буденного, д. 32, 191642	+75388177219	2163 163881
211	Молчанов Бажен Ермолаевич	г. Канск, наб. Ручейная, д. 5/6 стр. 6/6, 519839	+74334591316	5928 291703
212	Богданова Александра Аскольдовна	п. Усть-Джегута, ш. Базарное, д. 5 стр. 5, 667873	+78552896773	6538 263913
213	Эрнест Ерофеевич Семенов	к. Нижний Тагил, наб. Чехова, д. 6 стр. 8/1, 067247	+70005310264	2805 626496
214	Воробьев Ананий Абрамович	п. Александров, алл. Крупской, д. 25 к. 7, 820311	+75409178240	3174 238267
215	Соболева Александра Петровна	с. Баксан, алл. Журавлева, д. 5/3 к. 782, 812727	+74522650493	9059 100498
216	Алла Эдуардовна Ширяева	клх Новороссийск, ш. Тупиковое, д. 1 стр. 5, 723948	+79156572424	1559 517067
217	Мартьян Архипович Красильников	п. Цимлянск, наб. Мусы Джалиля, д. 4 к. 621, 887705	+78683885143	1684 081588
218	Шубин Милен Феоктистович	г. Шенкурск, ул. Короленко, д. 688 стр. 7/4, 443698	+71634954206	6920 963526
219	Олимпиада Тарасовна Попова	г. Ялуторовск, наб. Учительская, д. 9/1, 746370	+72862535132	2648 697280
220	Фадей Артёмович Виноградов	к. Краснодар, пер. Трудовой, д. 8/3 к. 31, 209083	+73029224176	9978 149670
185	Ираклий Иосипович Селезнев	г. Якша, пер. Пирогова, д. 565, 916325	+75598350548	4796 708598
221	Ирина Харитоновна Анисимова	г. Переславль-Залесский, бул. Тупиковый, д. 9, 541122	+73266855540	2553 434750
222	Белозерова Виктория Юрьевна	г. Мелеуз, алл. Балтийская, д. 6 стр. 1/2, 309440	+79985262930	5372 425290
223	Татьяна Владиславовна Бирюкова	п. Чусовой, ул. 40 лет Победы, д. 646 к. 19, 307553	+73897415864	8030 843131
224	Ким Владиславович Гущин	г. Усть-Джегута, ш. Олега Кошевого, д. 7/9 стр. 99, 596614	+77878990176	8027 620755
225	Доронина Жанна Станиславовна	д. Салават, алл. Тимирязева, д. 9/7 к. 80, 619086	+77078571791	2566 467874
226	Лучезар Измаилович Васильев	с. Печора, наб. Прудная, д. 7 стр. 4/5, 298098	+73924617779	1396 259383
227	Эмилия Степановна Пономарева	с. Темрюк, наб. Тельмана, д. 4/1 к. 3/9, 281666	+79678653717	0780 586476
228	Кузьмин Елисей Игоревич	клх Кажим, алл. Стахановская, д. 355, 759904	+76241049162	2084 711361
230	Артем Трифонович Уваров	п. Баргузин, алл. 8 Марта, д. 6 стр. 5, 260246	+74017403462	8957 190536
231	Сидоров Марк Иларионович	клх Наро-Фоминск, пр. Куйбышева, д. 5/7 к. 85, 244904	+74688210900	4863 712808
232	Мария Феликсовна Агафонова	п. Пермь, пер. Машиностроителей, д. 641, 383002	+72912369113	4379 184279
233	Клавдий Феодосьевич Пономарев	клх Тулпан, ш. Веселое, д. 18 стр. 848, 029550	+77257665238	6590 409639
234	Евфросиния Валериевна Савина	с. Черский, пер. Химиков, д. 9/6, 341090	+73915163705	1454 638091
235	Анна Эльдаровна Горбачева	д. Оймякон, бул. Курчатова, д. 86 стр. 2/6, 405140	+76757946457	0851 367426
236	Лука Ефимьевич Хохлов	клх Вендинга, пр. Флотский, д. 11 к. 7/8, 811000	+75026735719	2915 575789
237	Ираида Васильевна Тимофеева	п. Новый Уренгой, ул. Нахимова, д. 8 стр. 14, 717362	+73210296536	9416 500671
238	Анастасия Наумовна Суханова	п. Палана, ул. Горная, д. 94 стр. 832, 445206	+74513187073	1385 970663
239	Вера Максимовна Кононова	клх Чермоз, бул. Ушакова, д. 3/1 к. 4, 922005	+70712108307	1715 015935
240	Юдина Зинаида Наумовна	п. Владикавказ, наб. Калинина, д. 534 стр. 264, 216369	+71622160114	6127 681216
241	Агата Львовна Гущина	ст. Петропавловск-Камчатский, ул. Пушкина, д. 2/1, 200087	+74768711861	0566 919452
242	Милан Марсович Горшков	п. Солнечногорск, алл. Азовская, д. 18, 768431	+79792460214	8271 773495
243	Лидия Тимофеевна Горшкова	с. Набережные Челны, наб. Флотская, д. 164, 900276	+79651320196	1071 047299
244	Евсеев Мирослав Денисович	к. Киржач, пер. Льва Толстого, д. 473 к. 59, 404968	+70169208105	0371 297293
245	Белозерова Таисия Архиповна	г. Магадан, ш. Победы, д. 305 к. 9, 500157	+77961282720	0419 530312
246	Фёкла Евгеньевна Русакова	клх Шахты, пр. Пирогова, д. 9 стр. 97, 455130	+79964572971	6322 413347
247	Богданов Ростислав Герасимович	к. Сосногорск, ул. Юбилейная, д. 6/6 к. 2/2, 873903	+78651434748	4960 174130
248	г-н Воронов Владлен Чеславович	д. Лагань, ул. Володарского, д. 425, 733877	+79532133088	3212 167111
249	Борисов Семен Трифонович	ст. Кострома, пр. О.Кошевого, д. 4/6 стр. 72, 524253	+71370448368	6202 923377
250	Гришин Лукьян Ануфриевич	к. Валаам, ул. Куйбышева, д. 3, 074851	+74815203747	5960 827695
251	Ефремов Самуил Адамович	к. Выборг, ш. Высотное, д. 4/8 к. 811, 747787	+77976336723	3080 095982
252	Осипов Григорий Евсеевич	ст. Александровск-Сахалинский, алл. Волкова, д. 98 стр. 2/6, 103078	+72084641164	7933 433597
253	Авксентий Ефимович Николаев	д. Северо-Курильск, пр. Космический, д. 712 стр. 839, 448002	+74486880849	2324 404517
254	Фомин Леон Ермилович	к. Ивдель, наб. Пограничная, д. 96 к. 5, 966526	+75106564154	3898 289400
255	Лариса Семеновна Калашникова	д. Морозовск, бул. Краснопартизанский, д. 4/6 к. 39, 182475	+73081910239	9647 422765
256	Сергеева Нинель Ивановна	с. Витим, бул. Толбухина, д. 1/1 стр. 3/7, 841185	+72211820022	0125 633529
257	Любосмысл Аксёнович Афанасьев	к. Владивосток, алл. Семашко, д. 1 к. 44, 595574	+77075258448	2512 546527
258	Михаил Елизарович Чернов	к. Люберцы, ш. Блюхера, д. 9/3 к. 7, 221395	+76212266405	2929 433387
259	Елизар Тарасович Беляков	г. Можайск, бул. Ленинский, д. 4 стр. 4/1, 460087	+74737073896	8004 022699
260	Шубин Гремислав Венедиктович	с. Тамбов, ш. Бригадное, д. 76 к. 935, 093897	+78090222805	6951 146088
261	Нина Ниловна Ситникова	клх Волгодонск, пр. Революционный, д. 921, 791837	+79639978766	9971 323232
262	Наина Архиповна Егорова	к. Адлер, ул. Крымская, д. 8 стр. 3, 576202	+76863855646	1768 468515
263	Агафья Владиславовна Муравьева	г. Усолье Сибирское, наб. Киевская, д. 59 стр. 869, 826821	+74408480348	7069 075209
264	Маргарита Кирилловна Архипова	к. Нижневартовск, ш. Омское, д. 4, 275058	+78559506865	8162 167709
265	г-н Ефимов Модест Викентьевич	с. Медногорск, пер. Прудный, д. 7/6, 741671	+76854971816	3137 081881
266	Трофимова Ангелина Максимовна	п. Печора, наб. Металлистов, д. 5, 135097	+76918144363	6253 156885
267	Ксения Феликсовна Герасимова	п. Белореченск, пер. Семашко, д. 5 к. 6/6, 453475	+70235770455	1892 358998
268	Никитина Ульяна Алексеевна	к. Туруханск, ул. Ермака, д. 8/8, 836895	+72490168542	2136 484340
269	Раиса Феликсовна Кулакова	д. Мценск, алл. Краснофлотская, д. 3, 575951	+73472956016	1258 201177
270	Полина Харитоновна Ильина	п. Серов, пр. Каштановый, д. 68 стр. 89, 208234	+74895539693	6914 742161
271	Рубен Еремеевич Щукин	клх Шелехов, пр. Литейный, д. 30 к. 571, 350131	+70658533016	6119 722010
272	Носкова Валерия Васильевна	д. Малгобек, бул. Баумана, д. 7, 945378	+72881716248	2620 412314
273	Алина Вячеславовна Капустина	клх Владивосток, пер. Флотский, д. 7 к. 5/1, 015603	+75804345699	7036 872951
275	Василиса Альбертовна Дорофеева	ст. Хасан, наб. Элеваторная, д. 935 к. 435, 963076	+76549397136	0480 158168
276	Борисов Любомир Ефстафьевич	г. Новая Игирма, бул. Центральный, д. 4 к. 9, 113496	+74850072072	3042 482021
277	Мстислав Федотович Калинин	д. Югорск, пр. Украинский, д. 30 к. 399, 933465	+77299481633	6185 859507
278	Валерий Фомич Евсеев	клх Екатеринбург, бул. Первомайский, д. 227, 531845	+74690428492	0507 128507
279	Артемьева Элеонора Леоновна	г. Камышин, ш. Кочубея, д. 350 к. 1/4, 935678	+73970565096	5426 320514
280	Анатолий Иларионович Назаров	д. Красноселькуп, ш. Пирогова, д. 550 к. 627, 849280	+76644308058	5368 102572
281	Абрамова Ираида Николаевна	клх Сосьва (Хант.), ул. Верхняя, д. 80 стр. 15, 594357	+75742355227	2918 770979
282	Ольга Аскольдовна Виноградова	к. Радужный, наб. Демьяна Бедного, д. 4/6, 255126	+76331325130	4998 978299
283	Прасковья Леонидовна Стрелкова	п. Можайск, бул. Высокий, д. 1 к. 5/3, 362428	+78634561176	5272 925707
284	Марина Дмитриевна Петрова	д. Сасово, алл. Шмидта, д. 5 к. 2/6, 816013	+75929531947	7688 342507
285	Эммануил Денисович Капустин	клх Томпа, наб. Высокая, д. 375 к. 9, 869384	+71954872058	7165 430062
286	Пелагея Оскаровна Орлова	г. Дагомыс, бул. Новгородский, д. 2/1, 397932	+72863541819	3672 576961
287	Викентий Феофанович Агафонов	ст. Кашхатау, пр. Заовражный, д. 652 стр. 1/9, 632503	+73608718260	8288 729674
289	Силин Денис Филимонович	к. Сусуман, наб. Кооперативная, д. 377 стр. 51, 675838	+78012361621	0628 115273
290	Ковалев Пров Ильич	клх Кингисепп, ул. Космодемьянской, д. 6/7, 729274	+73446822931	4712 416929
291	Чернова Оксана Кузьминична	с. Хоста, ш. Станционное, д. 37 стр. 5, 162660	+73265965126	7999 915002
292	Кузнецов Лазарь Бенедиктович	г. Байкальск, пер. Макаренко, д. 3/7 к. 3/8, 726428	+75342106948	8970 206952
294	Леон Бориславович Рыбаков	п. Ханты-Мансийск, пр. Фрунзе, д. 805 стр. 3/3, 179040	+76092685275	7666 989205
295	Евпраксия Игоревна Семенова	д. Череповец, ш. Энтузиастов, д. 1/7 стр. 93, 029439	+77472815639	8615 401193
296	Конон Игнатьевич Колесников	клх Калининград, бул. Придорожный, д. 3 к. 557, 688306	+70625412581	6508 415919
297	Варвара Кузьминична Носкова	клх Железногорск(Курск.), наб. Сиреневая, д. 739 к. 140, 918260	+71870522196	5034 228711
298	Харитонов Лаврентий Иосифович	ст. Верхний Тагил, ш. Коммунистическое, д. 266 стр. 847, 778658	+76997310160	6277 852864
299	Анна Олеговна Кузьмина	к. Тайшет, ш. Стадионное, д. 7/7 стр. 767, 464096	+71065992118	4606 543404
300	Никанор Изотович Пестов	с. Гудермес, ул. Березовая, д. 37 к. 9, 804020	+71877448094	7270 111541
73	Гришина Надежда Ждановна	к. Магас, наб. Транспортная, д. 796 стр. 79, 642264	+70992659203	9175 655950
183	Соловьев Всеволод Богданович	ст. Курчатов, наб. Вольная, д. 20, 815641	+78915402138	2870 404091
288	Горбунов Виссарион Викторович	с. Ковров, ш. Амурское, д. 45 стр. 2, 995766	+72844921208	3426 751173
293	Власов Автоном Жанович	п. Токсово, пр. Мусы Джалиля, д. 57 стр. 6/3, 326862	+76204027946	1047 769995
107	Антонов Юрий Адамович	г. Лысьва, наб. Монтажников, д. 2/3, 604263	+74976386964	4930 830698
122	Чеслав Власович Титов	с. Подольск, ш. Монтажников, д. 418, 463789	+74659646079	5094 650327
229	Максим Ефимович Сорокин	ст. Тобольск, алл. Красная, д. 30, 860344	+79807545125	1330 970295
274	Евсеев Гостомысл Виленович	к. Тула, бул. Культуры, д. 6/8, 746497	+72561229895	6715 081187
301	София Григорьевна Ситникова	г. Сладково, ш. Никитина, д. 48 стр. 8, 742686	+71651104141	6666 309549
302	Гуляев Ким Жоресович	г. Черкесск, алл. Амурская, д. 3 к. 5/5, 869119	+73193462785	0555 823621
303	Анастасия Ильинична Устинова	с. Невьянск, ул. Лесозаводская, д. 4 стр. 9, 525126	+79262201027	9829 462373
304	Родионов Виктор Юльевич	ст. Новомичуринск, бул. Панфилова, д. 291 к. 3, 581292	+71325484056	4868 570895
305	Абрамов Аникей Афанасьевич	к. Яхрома, бул. Спортивный, д. 9 стр. 9, 649727	+74255318873	3375 689319
306	Гаврилов Пимен Валентинович	к. Соликамск, алл. Льва Толстого, д. 242 стр. 4/7, 027765	+78731270149	0599 451802
307	Гаврилов Иосиф Иосипович	с. Переславль-Залесский, бул. Томский, д. 517 к. 9, 584019	+71983007567	4061 320059
308	Флорентин Исидорович Ковалев	ст. Истра, бул. Кутузова, д. 261 стр. 19, 020734	+73080887842	0897 535358
309	Фаина Геннадьевна Зуева	с. Усмань, ш. Локомотивное, д. 179 стр. 9, 702567	+79374424552	6158 033620
310	Потапов Игорь Федосьевич	с. Добрянка, пр. Локомотивный, д. 813 стр. 6/7, 878797	+78243222459	5920 960888
311	Никандр Бориславович Капустин	г. Котлас, наб. Хвойная, д. 43, 687776	+71682763930	5502 035639
312	Крюков Трофим Марсович	д. Кириши, наб. Ударная, д. 542 стр. 3, 618676	+75414895883	5354 984030
313	Надежда Макаровна Блохина	г. Томари, ш. Суворова, д. 78, 300500	+75160730079	3453 433438
314	Ермаков Платон Федотович	с. Белореченск, пер. Минский, д. 8/1 стр. 584, 298686	+72561164969	4520 285617
315	Елисеев Артем Ефимович	п. Токма, алл. Калинина, д. 3/7 к. 7/1, 417341	+76299451762	1445 789066
316	Валерий Федосьевич Гущин	г. Пинега, пер. Журавлева, д. 28 к. 666, 836798	+77562601323	8135 793144
317	Силин Ким Денисович	г. Нижневартовск, наб. Юбилейная, д. 31 стр. 7/4, 117659	+77032006983	8787 522916
318	Вера Вячеславовна Архипова	д. Сибай, наб. Плеханова, д. 323 стр. 747, 056670	+74672643661	5404 109527
319	Силин Ермолай Брониславович	г. Магадан, алл. Культуры, д. 6 к. 3, 763429	+76635325117	1472 456406
320	Тетерина Ия Сергеевна	клх Алдан, пр. Гончарова, д. 842 к. 628, 765936	+77881316152	3889 341882
321	Регина Матвеевна Дементьева	с. Партизанск, бул. Деповский, д. 28, 135961	+79726107504	9016 903363
322	Александра Феликсовна Виноградова	д. Одинцово, ул. Владимирская, д. 40, 621042	+71345081581	4623 117477
323	Флорентин Антонович Новиков	ст. Норильск, наб. Павлова, д. 1 стр. 5, 187069	+78092036970	3417 556342
324	Фомин Севастьян Васильевич	к. Лагань, пр. Нефтяников, д. 9/2 стр. 975, 539100	+73732682677	6238 496790
325	Мартын Фадеевич Некрасов	ст. Нязепетровск, ул. Луговая, д. 2/9, 555576	+79139946432	5263 704739
326	Екатерина Руслановна Воробьева	с. Дивногорск, пр. 1 Мая, д. 4 к. 344, 991560	+76777876199	1835 678913
327	Регина Васильевна Некрасова	д. Оха, алл. Автомобилистов, д. 9/5 стр. 128, 509948	+72115926931	8644 894533
328	Дорофей Игнатович Исаков	с. Дивногорск, алл. Маяковского, д. 557 к. 3, 395724	+72860657313	0103 229521
329	Емельянов Сигизмунд Герасимович	клх Ачинск, ул. Заводская, д. 6 к. 523, 151977	+79940438191	3176 719843
330	Комиссаров Мариан Адамович	клх Воронеж, ул. Пионерская, д. 6/5 к. 188, 285648	+74546418090	3100 330913
331	Артемий Бориславович Орлов	г. Инта, бул. Мостовой, д. 893 стр. 649, 121290	+79845909385	2181 848216
332	Мартьян Артурович Зыков	г. Камышлов, ш. Фадеева, д. 737 к. 3/7, 142073	+77812207400	4744 117154
333	Казаков Кирилл Бенедиктович	д. Владикавказ, алл. Азовская, д. 7/3, 739755	+75578260822	2219 796251
334	Агафон Германович Петухов	ст. Мценск, ул. Труда, д. 24 стр. 1, 815262	+77974270148	8326 439729
335	Фаина Альбертовна Мамонтова	к. Онега, ш. Республиканское, д. 7 к. 3/1, 591293	+79283163241	7717 632532
336	Ратибор Захарьевич Воробьев	п. Кизилюрт, пр. Пограничный, д. 17 к. 1/5, 901986	+78153966149	4715 726172
337	Максимов Валерьян Ильясович	к. Тимашевск, бул. Панфилова, д. 49 стр. 2/5, 028571	+79799782175	3430 588495
338	Леонид Ермолаевич Суворов	с. Белорецк, наб. Кольцевая, д. 8 стр. 9, 667859	+72113848993	6077 582321
339	Евфросиния Евгеньевна Аксенова	п. Мураши, алл. Октября, д. 21 стр. 84, 378941	+71139771849	9269 972222
340	Зоя Борисовна Гордеева	к. Шаховская, ш. Красногвардейское, д. 2/9 стр. 724, 349556	+73258910429	1441 416271
341	Сила Владленович Архипов	к. Валаам, наб. Союзная, д. 892 стр. 14, 056880	+78605863651	6244 611368
342	Галина Вячеславовна Авдеева	г. Лазаревское, наб. Выгонная, д. 6/5, 829522	+77924714481	6769 459232
343	Поляков Никифор Эдуардович	с. Выборг, ш. Химиков, д. 8 стр. 4/2, 430033	+77735636074	4861 697919
344	Надежда Рубеновна Смирнова	с. Калач, алл. 40 лет Победы, д. 5/1 к. 5, 839334	+73213109484	8743 157037
345	Веселова Марина Сергеевна	п. Нязепетровск, наб. Колхозная, д. 1 к. 12, 159184	+76751485020	4113 133734
346	Субботин Мина Афанасьевич	ст. Кош-Агач, ш. Ворошилова, д. 614 стр. 2/2, 256379	+73925342364	1040 291867
347	Ангелина Артемовна Назарова	с. Избербаш, ул. Дачная, д. 51, 288156	+73294996320	8607 815540
348	Гуляева Милица Николаевна	к. Нальчик, ул. 40 лет Октября, д. 932, 271054	+77615848533	7677 578381
349	Горбунов Гурий Ефимьевич	д. Игарка, наб. Крайняя, д. 9/9, 951199	+78899882958	7360 741322
350	Пров Давидович Терентьев	п. Астрахань, наб. Абрикосовая, д. 5, 486733	+79814294718	8280 355148
351	Фомичева Ираида Архиповна	клх Беломорск, алл. З.Космодемьянской, д. 35 стр. 87, 899925	+75616104017	4216 276566
352	Самсонов Максимильян Бенедиктович	к. Тамбей, пер. Просвещения, д. 9, 783027	+70878655148	4225 708485
353	Анисимова Ольга Максимовна	п. Суздаль, пер. Революции, д. 3, 989248	+74092816185	2652 934611
354	Кондратий Адамович Овчинников	г. Сосновый Бор, ш. Тульское, д. 713 к. 76, 612259	+72937556472	4707 530434
355	Соловьева Иванна Альбертовна	п. Самара, наб. Казанская, д. 97 стр. 599, 014607	+72746743070	2378 740962
356	Поляков Евгений Иосифович	с. Кириши, пер. Просвещения, д. 6 стр. 2, 507072	+73463265869	2475 523581
357	Виктория Максимовна Куликова	д. Усть-Ишим, пр. Прудный, д. 2/7 стр. 5/3, 123598	+76972141235	9205 550612
358	Соболева Акулина Максимовна	д. Костомукша, ш. Подгорное, д. 432 к. 3, 154228	+75193575929	0776 749211
359	Агата Михайловна Зуева	клх Мокшан, наб. 30 лет Победы, д. 7/8 стр. 9, 057386	+79970088502	8932 398225
360	Вячеслав Артемьевич Блинов	д. Адыгейск, ш. Саратовское, д. 484 к. 82, 415193	+72764149400	8453 398539
361	Силантий Жанович Михеев	к. Белоярский, ш. Торговое, д. 6, 743640	+77586085237	6972 686620
362	Прокофий Жанович Колесников	клх Шали, пр. Краснодарский, д. 4 к. 6/7, 854674	+72610472941	2932 366693
363	Агата Эдуардовна Лаврентьева	ст. Моршанск, наб. Снежная, д. 8, 504763	+72087022494	9323 536872
364	Синклитикия Харитоновна Давыдова	д. Старая Русса, ул. Санаторная, д. 4/3 к. 1, 952523	+74954759280	4399 434558
365	Антонина Оскаровна Богданова	д. Магас, пер. Светлый, д. 968, 573818	+71158928217	4876 537786
366	Лариса Тимуровна Мухина	п. Рыбинск, пр. Медицинский, д. 73, 892602	+72558993568	0510 882196
367	Владимиров Андрон Димитриевич	к. Грозный, пр. Кирпичный, д. 4/9 к. 174, 530285	+75620870651	6398 106703
368	Некрасова Дарья Семеновна	ст. Лабинск, наб. Сельская, д. 56, 533675	+70137811392	6792 243279
369	Клавдия Ниловна Одинцова	клх Сочи, ш. Дарвина, д. 613 к. 7/5, 354635	+71305757809	6060 450140
370	Кулагина Надежда Натановна	к. Качканар, пер. Энергетиков, д. 126 к. 8/8, 552688	+70116186493	9370 335031
371	Синклитикия Афанасьевна Смирнова	д. Краснокамск, бул. Профсоюзный, д. 23, 298764	+76606206197	8614 092219
372	Автоном Ярославович Тимофеев	к. Усть-Баргузин, пр. Пушкина, д. 9 стр. 7/9, 965302	+74610188176	6064 231506
373	Елизавета Леонидовна Ермакова	д. Калачинск, бул. Проточный, д. 9 к. 9/7, 331344	+70232233622	1556 988022
374	Мечислав Елизарович Степанов	п. Кировск (Ленин.), ул. Производственная, д. 5 стр. 3, 360568	+73578217871	9400 938829
375	Абрамов Эрнест Харлампьевич	п. Костомукша, ул. Высоцкого, д. 146, 008086	+74454472936	5622 368457
376	Горбунов Панкратий Васильевич	клх Соль-Илецк, бул. Набережный, д. 22 к. 659, 518219	+79997688373	7057 007343
377	Куликов Степан Анатольевич	п. Заводоуковск, пер. Камский, д. 29 к. 73, 762081	+77132369290	9338 096630
378	Чернов Эдуард Фокич	г. Апшеронск, наб. Менделеева, д. 2/5 к. 2/7, 282661	+75012388525	7480 407793
379	Роман Данилович Захаров	ст. Бреды, пр. Широкий, д. 8/6 к. 927, 508499	+70462166680	9299 335994
380	Анисим Давидович Кошелев	ст. Ангарск, ул. Дарвина, д. 96 к. 276, 550286	+75847708547	3028 548262
381	Бобылев Модест Филиппович	с. Улан-Удэ, наб. Мусы Джалиля, д. 84, 104760	+78443852594	0935 699968
382	Гусева Раиса Аркадьевна	г. Вязьма, пр. Труда, д. 353 стр. 2, 936409	+75622486218	0313 117343
383	Ульяна Геннадьевна Лебедева	г. Ишим, ш. Верхнее, д. 572 стр. 997, 861864	+76388769083	0716 964005
384	Кузьма Вилорович Блинов	ст. Курск, пер. Енисейский, д. 1 стр. 8/9, 471654	+74939387195	5702 770793
385	Михеев Викентий Давидович	г. Ялуторовск, алл. Шолохова, д. 7/1 к. 7, 059179	+73732667033	4524 843744
386	Гришин Любосмысл Ефремович	к. Ряжск, пер. Азина, д. 6, 966170	+77029759565	8873 396618
387	Мечислав Юльевич Журавлев	п. Инта, ул. 70 лет Октября, д. 3/1, 680717	+73924374622	0900 831542
388	Юлий Артемьевич Антонов	д. Череповец, ш. Васильковое, д. 3/4, 376138	+78291313935	0609 574284
389	Агата Ефимовна Лазарева	п. Карабудахкент, пер. Маркса Карла, д. 7 к. 34, 981263	+70516786710	8153 456906
390	Марк Марсович Титов	п. Улан-Удэ, пер. Севастопольский, д. 56 стр. 581, 087411	+79202549330	7552 552848
391	Суханов Бронислав Марсович	клх Кунгур, алл. Бабушкина, д. 2, 396412	+70523751679	0893 542399
392	Симонов Лавр Филатович	г. Солнечногорск, пр. Грибоедова, д. 9/9, 473696	+70294174848	1038 932005
393	Игнатов Мечислав Всеволодович	ст. Карабудахкент, наб. Гагарина, д. 50 стр. 6, 326952	+70257573532	5299 370720
394	Агата Анатольевна Громова	ст. Абинск, пр. Угловой, д. 77 стр. 3, 252104	+75990467324	8164 673151
395	Аристарх Артурович Власов	с. Кулунда, бул. Тельмана, д. 124 стр. 572, 348336	+73281008156	1642 784842
396	Щербакова Валерия Геннадиевна	к. Курган, наб. Станционная, д. 7/4 стр. 7/2, 216133	+73160778896	0265 050572
397	Велимир Владленович Рожков	п. Карабудахкент, ул. Л.Толстого, д. 7 к. 4/3, 449225	+73720986962	4250 669554
398	Алла Вячеславовна Беспалова	д. Краснотурьинск, пр. Проточный, д. 80 к. 8/2, 709246	+78916954103	8658 174037
399	Герман Иосипович Анисимов	клх Середниково, ул. Гоголя, д. 8/4 к. 15, 790250	+75649280792	0255 153715
400	Суворов Евдоким Бенедиктович	к. Киров (Вятка), алл. Заозерная, д. 747 к. 8/6, 126430	+73732899927	3601 431177
\.


--
-- TOC entry 4990 (class 0 OID 16432)
-- Dependencies: 220
-- Data for Name: position; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."position" (id, title, basic_salary) FROM stdin;
1	Администратор	60000
2	Водитель	80000
\.


--
-- TOC entry 5013 (class 0 OID 16617)
-- Dependencies: 243
-- Data for Name: tariff; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tariff (id, name, car_type) FROM stdin;
1	Эконом	эконом
2	Комфорт	комфорт
3	Бизнес	бизнес
4	Премиум	премиум
\.


--
-- TOC entry 5015 (class 0 OID 16627)
-- Dependencies: 245
-- Data for Name: tariff_price; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tariff_price (id, tariff_id, price_per_km, start_date, end_date) FROM stdin;
1	3	20	2005-12-01 21:38:10	2008-07-02 00:30:13
2	2	45	2009-11-11 20:26:36	2018-08-14 06:51:34
3	4	64	2012-09-03 22:27:15	2016-11-12 10:00:06
4	3	49	2008-11-20 03:24:43	2022-03-04 13:46:15
5	4	74	2006-08-23 21:17:35	2012-10-29 05:13:03
6	3	20	2011-02-02 17:11:32	2021-05-05 19:24:13
7	2	49	2007-09-19 02:03:14	2019-09-13 04:09:18
8	4	62	2010-03-10 13:14:34	2021-05-31 21:17:50
9	3	60	2013-04-05 08:24:00	2016-07-24 13:24:43
10	1	17	2024-04-22 21:39:47	2025-03-24 15:37:35
11	4	37	2021-08-25 10:23:11	2022-11-10 21:01:42
12	2	72	2023-07-29 02:57:28	2025-03-20 02:42:12
13	3	14	2012-07-04 17:29:22	2015-01-31 17:47:54
14	4	80	2007-12-02 06:49:46	2019-07-15 17:19:42
15	2	33	2006-04-23 02:36:14	2008-01-22 17:16:09
16	1	66	2011-01-17 09:53:36	2016-07-08 09:18:10
17	4	90	2005-12-24 12:45:56	2023-07-25 20:26:09
18	4	76	2019-11-29 17:49:56	2024-08-15 13:56:50
19	2	67	2010-01-07 09:51:30	2015-12-30 00:10:16
20	1	16	2021-09-05 08:09:43	2022-03-24 20:18:43
21	1	46	2007-04-10 14:36:19	2020-10-26 20:44:47
22	3	75	2010-04-17 20:51:08	2019-10-08 02:30:39
23	2	46	2017-04-26 01:22:49	2018-07-31 17:15:05
24	4	99	2017-11-12 04:45:49	2024-07-18 21:40:27
25	4	47	2017-06-18 12:29:05	2021-07-12 12:38:20
26	2	51	2018-10-27 11:05:32	2022-04-26 13:04:36
27	4	87	2024-02-13 07:59:16	2024-10-04 17:21:02
28	3	85	2019-12-22 19:42:43	2022-04-19 00:00:36
29	3	23	2022-02-01 03:43:26	2022-02-28 22:23:18
30	1	21	2019-07-10 05:13:55	2022-10-21 04:25:02
31	1	84	2021-03-10 02:00:44	2021-04-13 17:01:06
32	1	77	2007-08-22 00:10:14	2009-08-06 22:34:16
33	3	79	2025-01-19 01:59:19	2025-03-13 19:02:44
34	2	91	2012-03-09 21:53:06	2020-12-05 13:53:01
35	3	90	2009-06-22 19:13:36	2010-09-14 07:51:57
36	2	77	2014-01-08 06:59:30	2023-07-20 22:10:47
37	1	99	2007-04-15 19:34:30	2008-09-24 04:44:53
38	1	86	2018-09-08 10:38:24	2024-07-24 20:32:20
39	3	88	2012-01-17 08:09:39	2013-04-04 06:25:18
40	2	72	2006-07-31 03:35:59	2007-10-07 16:39:52
41	3	68	2013-07-30 01:06:27	2020-06-09 13:30:01
42	2	50	2009-10-05 00:44:19	2024-08-11 22:58:54
43	3	93	2005-09-07 07:55:38	2024-07-06 18:53:12
44	1	44	2017-03-26 20:33:58	2020-11-19 20:19:45
45	3	62	2020-04-06 15:01:17	2023-07-03 22:04:10
46	1	36	2012-12-26 04:48:36	2019-03-06 06:37:33
47	4	59	2011-02-12 03:15:16	2017-03-24 05:51:12
48	3	88	2018-11-25 03:45:09	2023-05-27 23:59:44
49	2	84	2011-02-07 07:14:11	2021-10-20 18:16:06
50	2	32	2025-03-11 04:25:39	2025-03-20 05:19:30
51	2	81	2008-08-21 11:26:55	2015-06-02 16:07:20
52	1	80	2020-06-20 01:21:53	2023-04-27 02:10:51
53	4	13	2019-06-07 23:55:25	2020-06-04 15:50:16
54	3	62	2011-09-08 05:50:48	2018-09-03 19:01:07
55	1	70	2013-05-25 05:26:58	2014-01-26 16:50:41
56	4	27	2022-01-30 05:11:46	2024-08-12 08:48:17
57	3	53	2014-01-28 08:57:07	2014-10-20 09:52:42
58	1	63	2023-05-17 20:20:32	2024-09-16 10:26:54
59	2	49	2007-08-27 10:20:14	2012-02-28 23:09:43
60	2	79	2013-05-25 01:35:08	2018-07-06 14:41:08
61	3	81	2011-02-01 01:40:28	2013-05-31 09:03:39
62	3	46	2009-07-03 11:59:08	2011-05-25 21:56:59
63	2	48	2014-06-23 07:12:37	2022-05-08 03:31:42
64	4	49	2011-08-24 17:44:40	2022-12-07 06:22:23
65	4	17	2007-03-24 01:42:40	2025-01-22 21:52:28
66	2	62	2017-05-10 05:39:44	2021-01-11 07:34:15
67	3	96	2010-05-13 17:07:44	2017-02-20 22:56:29
68	2	88	2017-09-08 02:07:48	2017-12-12 12:57:59
69	1	54	2006-07-01 06:24:39	2010-07-15 17:50:18
70	4	92	2022-01-26 10:46:17	2022-05-02 22:50:14
71	3	84	2010-10-10 04:41:30	2020-03-07 13:22:07
72	2	98	2017-04-20 20:33:01	2018-09-25 08:00:27
73	3	34	2006-10-20 07:42:18	2011-02-21 15:45:51
74	1	98	2015-01-12 14:57:00	2024-08-29 19:11:55
75	3	52	2017-05-08 11:09:18	2022-02-22 16:33:57
76	4	96	2012-11-25 18:27:32	2025-02-16 05:00:50
77	4	58	2013-06-04 17:19:02	2015-08-17 01:09:05
78	1	88	2019-03-24 21:46:07	2020-05-21 09:37:48
79	1	74	2015-02-21 09:05:07	2023-03-27 18:17:25
80	3	78	2009-09-21 04:34:01	2023-07-21 23:25:29
81	1	70	2015-04-10 12:35:26	2024-05-26 22:15:16
82	1	19	2009-07-27 01:50:07	2018-09-30 23:23:53
83	2	36	2016-01-08 10:06:59	2016-11-22 21:40:03
84	2	47	2011-03-06 14:48:51	2014-10-17 06:57:06
85	3	39	2009-07-08 12:51:31	2016-04-04 23:09:44
86	3	30	2005-10-04 11:09:58	2012-11-08 03:12:48
87	3	97	2014-12-08 17:27:16	2017-10-29 15:46:31
88	3	35	2015-03-06 01:37:22	2017-07-01 22:50:47
89	3	98	2017-06-26 10:38:43	2019-03-30 12:56:36
90	1	86	2022-10-06 13:08:22	2024-05-26 18:52:58
91	4	85	2013-03-13 22:14:29	2017-01-16 14:20:48
92	4	56	2014-05-11 01:57:54	2025-02-13 17:32:05
93	3	39	2007-08-03 16:42:47	2008-01-30 05:41:04
94	2	58	2012-11-01 06:51:26	2025-02-16 01:53:01
95	1	64	2006-06-25 10:58:31	2022-06-29 15:20:46
96	3	52	2023-08-17 12:57:24	2025-02-17 06:17:21
97	1	45	2008-08-12 15:32:14	2011-02-06 02:23:55
98	3	57	2007-08-19 16:27:49	2024-06-09 11:20:09
99	4	14	2016-03-31 08:25:48	2019-12-18 02:34:58
100	2	41	2022-12-22 18:49:12	2022-12-23 14:01:30
\.


--
-- TOC entry 5019 (class 0 OID 16647)
-- Dependencies: 249
-- Data for Name: taxi_call; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.taxi_call (id, driver_id, tariff_price_id, cost_adjustment_id, passenger_id, administrator_id, payment_amount, start_time, end_time, start_place, end_place, distance, payment_method, trip_rating, trip_review, call_time) FROM stdin;
2	105	39	99	284	58	2883	2022-04-14 21:47:49	2022-04-15 13:51:43	ст. Верхнее Пенжино, ул. Рабочая, д. 3 стр. 3, 322168	ст. Урай, бул. Строительный, д. 9, 892964	23	онлайн	3	CcaOxyS3QVvqav2MdUWBAFeFlsvaR6aIbpByH0yhdb6XeXmEkehRykeyCWWnNEP1BsC6p3oaLN6BS8KK14xThjY	2022-04-14 18:07:40
3	200	8	82	283	55	2351	2019-06-09 05:54:53	2019-06-09 09:14:43	ст. Шелехов, бул. Геологический, д. 3 стр. 953, 331122	ст. Южно-Сахалинск, пер. Совхозный, д. 7, 860050	91	карта	2	OwYxhJ1yptdmnl95y52KisnvR686bFIf2ePmedDUwBnGKEI7aFbkCrAEaYcKGfhYKgxcyBXH5j1	2019-06-08 23:45:40
4	171	90	8	255	34	2033	2010-12-13 14:47:53	2010-12-13 15:32:20	клх Лагань, алл. Ветеранов, д. 6/9 стр. 176, 060573	д. Череповец, ш. Школьное, д. 828 стр. 44, 010569	35	наличные	1	ti6pzVC1nvcwI4fLvFV6DxkrdBvpDyqjCc4MyZfzhWDGVpTTa7vH	2010-12-13 12:45:17
5	183	34	71	250	2	1601	2006-06-05 04:52:55	2006-06-05 14:40:35	клх Адыгейск, ш. Кавказское, д. 705 стр. 8, 837888	п. Охотск, алл. Крестьянская, д. 6/5 стр. 96, 556009	62	онлайн	3	HXhIqpkcs2zW	2006-06-04 13:56:35
6	151	93	78	280	53	371	2011-10-16 08:10:32	2011-10-16 15:49:55	п. Серафимович, ш. Коммунальное, д. 8/6 стр. 87, 904572	ст. Калевала, наб. Челюскинцев, д. 75 стр. 5/4, 056404	133	онлайн	5	TiNsSVfaTuN7CYfLAaL4a6KfXyb2LiyalUGpvh0NcDRs4rJEmpEKhCFABHDQwVnizLd2K4EjedZlw6CfEpRPvJOpJYTUD3CuvONgJulOU3UJxCGccuIzl0vsdtzGHqei	2011-10-16 01:36:37
7	140	70	56	210	50	699	2024-07-10 16:43:01	2024-07-11 01:08:14	ст. Тарко-Сале, ш. Ручейное, д. 5/7 к. 89, 769251	с. Серпухов, алл. Загородная, д. 3 стр. 27, 593667	80	онлайн	1	lkpB9JQdxU3B3RSD8GU4sLfIVkLdRqx6C3eLAijZp5VpLXjCM6BvQ5x3RmGrkD34M7S6rSHPLaBeshyMsK2qtLbLgciN3D7WmEco2ftC6PNzkBOpHGWwt	2024-07-10 00:47:09
8	183	73	67	246	96	2318	2010-04-17 13:11:30	2010-04-17 18:45:17	к. Пятигорск, алл. Березовая, д. 1/4 к. 179, 775599	д. Глазов, наб. Ударная, д. 96 к. 7/1, 869728	69	наличные	1	ARKyn9hDEAYksh9AY9Twtud4UL8nBWFfmmQWiQktlusIPkTwNtNdwk689R8QxZkrElePF1J3GXuxQIuV9AR566ZEUK7bjz2NvkufogdqbITmsMNDBCPoHxTHWBIyFXh3MDaWspeQBgdCJa2QB3tx6dTdTPgdddTRonNnWLQgFEhuRP12BL7yLkXVRd1Nn	2010-04-16 22:02:28
9	193	34	19	210	38	2160	2023-12-24 03:18:49	2023-12-24 22:11:43	клх Гремячинск (Бурят.), пер. Больничный, д. 7/9 к. 460, 668765	ст. Тосно, ул. 70 лет Октября, д. 53 стр. 8, 975400	60	онлайн	1	vHPxvJafrfcdLQd58Ln4xv8hTUboVFQA7O5nqpVsR6PWTf4pxxQH5duVqE5Txo48IAdBokrmtvh3z0iFUPCzDavvxw9m3HNI6DkqNajy7ibdUwejaTrfvvaAjmtT7PH3o43qx9F2IjhF3SwSlXpZ5LMx60H4ZnHP6MfnIl	2023-12-23 03:24:21
10	151	86	53	258	69	2752	2010-05-13 14:11:33	2010-05-13 15:50:46	к. Борзя, наб. Веселая, д. 844 стр. 24, 545237	с. Чулым, алл. Волочаевская, д. 4/5, 247157	24	карта	3	XUKgwaPWzzPtSle0yL1pxSUlyWuRm73mYKbKB5Cs6f59naYJ9OykfzPTyXltS4gRVj3vrLS6IbA968NePv4TfiwgtAxe1901	2010-05-12 15:26:13
11	108	31	23	226	6	2673	2006-10-22 05:30:55	2006-10-22 05:43:31	п. Курумкан, ш. Промышленное, д. 4/1, 391511	п. Верхотурье, наб. Родниковая, д. 39 к. 7/6, 723632	103	карта	4	3tazys1ZnTrraD4sYYrYUYBKJbDkLjVhA7UoTa7CGFJxzkdUjKBCufrPT0mBIXUzboT	2006-10-22 01:21:31
12	105	19	62	214	45	448	2025-03-06 15:56:39	2025-03-06 17:49:10	к. Лысьва, пер. Макаренко, д. 2/6 к. 2, 673237	ст. Оленегорск (Якут.), ш. Прохладное, д. 63 к. 80, 527575	19	наличные	5	jxtnKxEMURmwZgkkXIBpFEzYB3q	2025-03-05 23:57:44
13	187	37	55	265	60	1683	2018-08-03 17:05:40	2018-08-03 20:34:02	клх Устюжна, ш. Черемушки, д. 9 стр. 6, 993715	к. Терскол, бул. Одесский, д. 5/7 к. 3, 931250	93	карта	2	wh0k3iDKc6n9Y1vneEWUXqelWR2qZJgZ1xQEru1fcgHT6cRvxbyy2ec4vs2vpm4oFfNNEk1whghTM2W3uHY3BhcJ8uCiMmfn7zSjpzrTK7NrqudCYHhctgYPSG3Ck0YMVOOBj5lpMAwZSS	2018-08-03 05:30:22
14	187	56	2	227	98	529	2011-04-07 03:25:47	2011-04-07 20:32:43	ст. Апрелевка, алл. 60 лет Октября, д. 1, 612478	ст. \nБугуруслан, бул. Водников, д. 9 к. 387, 478548	102	наличные	5	a2lP4HN3awS8s8fppdhRBE3vhiStT1rkIrM1lndaFVJivhN0ol58knWvDn383FMKnnumlta9z02a14FTyWE6426Y9XXQQ6Sj1GiNQNMK70n7CgvsnWxm1X4Pl1cYIm8UnnrSI60hiAztnJ6LwRSivvn1wVjlaTShGgqPLAByq8yYMG3S6kkE8QfVsiFNEG2TaRgwxRmJ	2011-04-07 01:45:23
15	189	63	79	260	11	266	2014-09-01 02:20:15	2014-09-01 10:57:12	д. Каменномостский, ул. Некрасова, д. 8/8, 816008	с. Елец, алл. Депутатская, д. 1/8, 292114	52	онлайн	4	fD12RJfTY7dLRN7LHaecwMTRmSQI78hXhflqv7LpBtBPUoGwZqfPSFjN5gF	2014-08-31 21:55:05
16	103	68	33	206	39	2163	2005-09-13 02:03:43	2005-09-13 15:18:25	ст. Алдан, наб. Громова, д. 347 к. 827, 571172	п. Ясный (Оренб.), пр. Пограничный, д. 623 к. 901, 153850	61	онлайн	2	8e9F9FB4tveqVq8WpZfLkGL77GTuOVdwsGxzFCTsaA5Xu9x4MkbCD927Aenrm51iWcYGk2SWqb9wdFOFB93Xq177GeFdRBsglzDnHqdwM1zka8JiyWwUqv8yux6UU9cOPAJkra9BhN2WENSrWQniQpkfvy462Qnv5Bi5v2ExjCrhcQaDnF8DH1gmBpG1I32	2005-09-12 02:22:30
17	139	32	25	294	72	1872	2024-10-02 16:13:59	2024-10-02 20:32:58	п. Алдан, алл. Полтавская, д. 133 стр. 15, 437843	г. Мыс Шмидта, наб. Котовского, д. 4/5, 994659	97	наличные	5	Lb46xPpuYSI617UWqizutJodLDFZGhgp7NTLThpqnnsHJ40g2gYVDvi6D9EkZBrVgGGERMNRuWyQS	2024-10-01 22:52:36
18	137	72	16	221	34	217	2015-05-31 21:27:36	2015-06-01 12:12:26	ст. Тихвин, пер. Крестьянский, д. 98 стр. 4, 146557	с. Всеволожск, пр. Космонавтов, д. 95 стр. 5/2, 294353	142	наличные	4	VjCC5ixR4oPKaxVZUj2jbdZg8FE1fApQOdGdm7xMQoftiZKX1PdlohvLJN2TK2yfm3yEE5IsxlOkFEZUXBJh4EJBlN7DLg1hKOZPlsSQCv2UeElEyTzM0d78yl23ATdIIfz0m10MUyyCnE2IbiZJI4HZr	2015-05-31 07:12:53
19	166	90	92	241	82	228	2008-04-26 00:15:20	2008-04-26 00:42:46	к. Углич, ш. Марта 8, д. 4/5 к. 353, 099363	г. Асбест, пер. Машиностроителей, д. 53 к. 346, 647062	15	наличные	4	sqNi3rsUewtrDiCBcB3	2008-04-25 12:21:22
20	101	78	13	269	13	1944	2019-10-21 15:52:28	2019-10-21 21:48:48	п. Мураши, ш. Промышленное, д. 9/5 к. 49, 592148	г. Истра, алл. Весенняя, д. 858 стр. 36, 814160	104	онлайн	5	CgQ33s2QhGj0XfZ9430sOsqqIhhNZuYnSAedXLzaSX0bA3HGMdQpqtIK2JU6lj7sTaoJQVzsvGUfLSO3U7G0SmgBdbOCmNSkfAsi792VJxMjlBhq1OCiY1J1NWTaw7V6Z6	2019-10-21 10:08:47
21	117	76	19	299	36	440	2010-11-14 04:56:44	2010-11-15 01:24:33	г. Шамары, пер. Станиславского, д. 9 к. 6, 689138	ст. Буденновск, ул. О.Кошевого, д. 6/6 стр. 58, 615638	155	карта	4	ndxNghcyznRoarjnwt5VL8U3ARChockpwe7gCIPorD7uV82PvpgRDG8F5ZbA7Y6cq1KTqJV72m1Hg7M4XCZAXFhtbRcUDUJOHKU9JtlzmsiCMsAOkDPO	2010-11-13 14:20:41
22	175	48	12	300	24	542	2014-08-06 05:19:25	2014-08-06 14:15:43	клх Светлогорск (Калин.), бул. Циолковского, д. 2, 696392	д. Черусти, алл. Российская, д. 3/8 к. 1, 820512	2	онлайн	1	KI88NfQxxdt3FjH2UU6iBXLeOYycFHCkxgcEMxrE8QrODH4u3Dp6UQrJmtAqGHeZZBuj8eE8rbsqERgMLhJnIwQP	2014-08-05 12:23:05
23	159	79	27	201	43	1505	2011-07-07 08:22:26	2011-07-08 01:59:15	д. Торжок, ул. Республиканская, д. 14, 970441	клх Омск, ул. Осипенко, д. 848, 178294	167	онлайн	2	eWeNq9Y9stU78DKXLQ2LK6o8ys4QyEAMf9l0vODsoCEDa7DPWmIYTgUTE2nHh48Q5Mkr7SpNbXcPMsKrtKucEjAxWnRxFd0ZRWzCPjKu3OiNWpIliegjb3XVoJVFNwgsJ8ncqRy5btMrKRrzlABtVys5cyGPWBRT1huhnONfdTFM	2011-07-06 08:25:46
24	113	12	52	217	52	2059	2010-07-05 13:28:20	2010-07-06 12:25:34	г. Торжок, ш. Гвардейское, д. 38, 457789	клх Дубна, наб. Карла Маркса, д. 816 к. 560, 547839	147	карта	2	5KPlMDklKMyBUkw5cBsdst3bCSdCCEdVpli4NhtOby6y51kihUdV85DbeP9DnznbvDJld9J9HbvpigWwOZ94Mngv	2010-07-05 11:25:27
25	134	23	55	266	70	1923	2022-10-20 05:21:34	2022-10-20 22:15:09	клх Пушкин, ш. Комарова, д. 2, 001373	ст. Батайск, \nпер. Энтузиастов, д. 65 к. 1/6, 367365	198	карта	2	gxLe2ZulBssXRIieByf8OHHoGLecvMXuhYCz1nFcYY7ddlrkcuPsJGnNeqtek4ZxA8V0J9CDFlWOt3MWFy9OKpCJkHVfvka7jHE7XTdsMItzeb2Wm2uS4nimz7CEcWIRHHqxkegmI0pRVsFElv	2022-10-20 03:23:56
26	106	64	99	236	59	2581	2010-08-29 14:47:57	2010-08-30 01:47:38	клх Тосно, наб. Союзная, д. 6, 030019	клх Ростов, бул. Производственный, д. 8/3 к. 9, 074728	173	наличные	1	TThRUGLCViwLJgDQr9UQ0wc4CaGu6	2010-08-29 03:34:01
27	148	39	58	256	23	369	2008-10-22 07:31:12	2008-10-23 05:58:50	д. Благовещенск (Амур.), ул. Войкова, д. 54 стр. 777, 550633	с. Новочеркасск, бул. Геологов, д. 84, 661831	45	карта	1	Gcs7oHB9J6bfsEI02Txr09aLioYxG43VCyokzcXfphtvKsF8bVNe6J7J5cH8GLSZmD	2008-10-21 13:51:39
28	193	4	7	201	9	1366	2006-03-23 17:41:29	2006-03-24 09:30:13	ст. Меренга, ул. Студенческая, д. 8, 673906	с. Шуя, ул. Карла Маркса, д. 5/9 стр. 4/6, 201583	61	карта	1	BevLeG8K0X7ERqsjWAg2S5T0ApPzEMTd28daGSJPoM6Gf021auyCiwDiag0oULq0IGIcVdIJjwIDnw2HP6U	2006-03-23 03:46:27
29	130	13	67	299	69	174	2008-05-03 18:32:33	2008-05-04 10:17:51	п. Ангарск, наб. Бажова, д. 5 к. 5, 296436	д. Черусти, алл. Первомайская, д. 17, 944566	11	наличные	1	WPTYQcWZSe2oRrzzgO6viXOl72haTsivruwoFJdpgFiaUMPL81OSou3m	2008-05-03 09:13:32
30	142	50	10	220	57	1129	2013-04-30 20:28:29	2013-05-01 05:37:48	д. Сосновый Бор, пр. Лазо, д. 906 к. 696, 549102	п. Нурлат, бул. Бригадный, д. 45 к. 63, 185355	114	онлайн	1	raOIQFrAMrRXHmfU6pFmh9wVYqauETun9JbteEQrbsq7R	2013-04-30 13:44:57
31	199	66	6	271	38	2375	2012-04-16 08:39:19	2012-04-16 19:30:08	с. Игарка, алл. Черноморская, д. 41 к. 9, 740121	д. \nПушкин, бул. Дорожный, д. 4 стр. 610, 380378	34	наличные	2	g3e5ukzs0ggIJYrC8V2xn72u9cuw9oQcXNK9WjDlFH7WMiL9LldrvUM2q	2012-04-16 01:52:37
32	175	44	28	205	24	1964	2006-12-26 00:13:37	2006-12-26 16:48:01	г. Подольск, алл. Прудовая, д. 32, 420589	с. Теберда, пр. Ангарский, д. 7 стр. 21, 675210	153	онлайн	4	bxumkMyrZumJt18JDCXt3YyZEJIKYbM2JWunGEVnVkMne61Lguxfg18hM8JAHLTdBlDJcAfL3HJ6eixvSGRoXdCx4vZcMAEZQTiCmQQfFzYCZHvBCyWa6EnXYTPrQn2cWVC8uwdSHsodqXHY8h508eD17wBv7ln	2006-12-25 05:30:30
33	141	29	87	246	87	1702	2009-12-03 11:13:04	2009-12-03 23:54:11	с. Дубна, алл. Горная, д. 425 к. 3/6, 264075	клх Макаров, бул. Высоковольтный, д. 1, 592504	147	наличные	2	O7K6lEfIiPOYeV6adFaPtgKVQ0XIxFpDMPnEjfFaTiMV46YixzAZmC6NQIxG69dwRjldQ5W3FUJRfCYuqrdI3liClOSQ8EDeg2nZuMaG5Qf3Jy3RnA123dFJIK64PMjPVeQX8JTvP0K7wYgqpXla	2009-12-03 08:47:01
34	158	38	1	226	99	2765	2013-05-15 07:15:07	2013-05-15 22:12:47	д. Катав-Ивановск, пер. Морозова, д. 3/8, 362002	ст. Красноуфимск, бул. Ясный, д. 478 к. 340, 249987	105	карта	1	qSX7HOuTPSJAhZAOKVznTcHrdgLQI3zIGb56IUVphq9XuLUZY6WJz2usDUrQgIiNCCarVgtaH1AjjqVGlxuosB2YTKsIcOUVO3jJtrAEzqIGTH1e8lu39K9CjTVsvOFZ97Qu1yfBhI3AjwVo0Nx4bre6DIrVh29mLI0iLq7lhdLfRwxAYYXGHIcxxVst9	2013-05-15 04:06:07
35	180	77	22	291	88	2546	2013-10-23 05:27:57	2013-10-23 16:47:41	ст. Лагань, пер. Тамбовский, д. 3, 283018	клх Сосновый Бор, наб. Энергетическая, д. 111, 518018	109	карта	2	Cvo4wwRj12K0jn8NCb8vCIlbz	2013-10-23 00:10:08
36	101	99	14	237	60	2962	2022-06-24 15:55:01	2022-06-25 13:05:33	клх Джейрах, бул. Локомотивный, д. 3 стр. 80, 617596	д. Подольск, наб. Космодемьянской, д. 62 стр. 5, 692843	132	онлайн	4	wzecE4uXDHNDMo8QkbDBbjmXqDKxK2oP33eML49eq2LWmNFGvSrWhol6473jDyVD0ATpxUu4S8FAkpLxSRJJyFR5cRzPqfdr4aJfunhLe0lUQD5pMdTaD76oSUjRlQRUFpQYagMchMJokyRbomSZ28WT8pd1gXEVcSivPnGLHZalC2T2vI3rzpTmgsj5fVJWXFoz0Ku7	2022-06-23 18:57:01
37	173	62	11	233	40	1703	2016-06-08 11:28:25	2016-06-09 03:54:20	п. Гагарин, ул. Победы, д. 459 стр. 169, 551707	д. \nСеймчан, пр. Брянский, д. 172 стр. 6/4, 758685	70	онлайн	5	rysRcDjwG3J1NgUFrnujAyVg1dXDjVlNSP7204ouYEjgKLwRKRCsQYoiugDsqBd4cMvaFBn80sUcDvjMPfIKJOdYHoonAnzXnIN5hOrvQykZkWC9fQ8wvAO5JauIp1dEQXHq61pHUfTSLrKMgwqdwKdtx4n5ZxwlKbwamzffOrl	2016-06-07 12:25:10
38	127	84	31	259	85	2834	2023-01-30 19:30:24	2023-01-31 06:46:15	с. Лянтор, пер. Олимпийский, д. 577 стр. 2, 648750	с. Серафимович, ш. Пархоменко, д. 89 к. 1/9, 983076	146	карта	3	nkZuYzJiQyzP5Oynep5xMKvTta3iBDzeXjLNrdWFp0gVNZ	2023-01-30 15:47:07
39	157	79	36	244	48	1277	2010-05-08 12:19:23	2010-05-08 17:32:51	с. Котельнич, алл. Городская, д. 78, 190613	п. Кабанск, бул. Красноярский, д. 4/8, 618781	145	наличные	4	7IRCGVoqy1EUSWtUAhLtdeso0gcRM2dP0LeKPCl3La0evZCQsAMH1rjO7eTYD1CcO0dKFjbEP1NlqIZpaqPSoCP2NckNsj3HdgNnojCyxK8pwJ5cpcuGxZJlYuot28F78zbbv26Qbth0OBCwEoblVMdXwEnWV7yoGCtIGBwfyQI	2010-05-08 12:12:07
40	166	25	41	260	10	1971	2008-08-02 16:04:43	2008-08-03 00:11:25	с. Уссурийск, ш. Степное, д. 21 стр. 637, 714006	с. Ессентуки, пер. Шахтерский, д. 926 стр. 1, 777735	139	карта	1	7AUBnAHy65ry19dqCcEIxptnNKVohpFuZOxTsdwtdh7Bce6qK08pUGxtGkFovo2IftG6tcNYLtDB0KNUpcSVpLvMPq5OK4F3MnCc4WSbfWaQa3o12UMZ0KzpVthw7wVRNULNS4wQ8cX6v2UpfgKb	2008-08-02 08:54:49
41	131	65	63	277	46	2233	2010-10-19 09:56:03	2010-10-19 23:14:03	п. Каневская, ул. Родниковая, д. 642 стр. 9, 582443	с. Абакан, пер. Медицинский, д. 19 к. 6, 006995	127	онлайн	5	ZHONeIBCDMVTM0B9306IESXBglJax5UpxpJgnCbGdPR3KPvraOmLOu7A2jg6IopA5Nagrl9eb5NwQyUw2VefQkvZzfk81FiZLxvCsQISdqoUk4TH4j37QjhkXEBYfFMcSRhXKSoO1ymPYvUysSChQa0iyiV9nzLZWavlrA	2010-10-19 00:52:04
42	152	86	31	293	78	778	2010-07-23 13:22:04	2010-07-24 06:23:22	ст. Великие Луки, ш. Ключевое, д. 59 стр. 81, 523849	клх Тихвин, алл. Советской Армии, д. 3, 242566	191	онлайн	2	NRySTJnU8v6T60B5FgprJd3az3UbjhnO0NBonePujWf3wQyAN2IOvvog2OIL5Ur01lQWcisFdB8uT9jLmGQy1K3Ewr3MNKnqzfoklBtzR	2010-07-23 11:30:59
43	109	3	8	243	21	309	2006-04-17 03:11:25	2006-04-17 10:51:44	г. Ноябрьск, наб. Коммунаров, д. 513, 082803	г. Серпухов, пер. Циолковского, д. 2 стр. 9, 749364	92	онлайн	3	uxm8zTObGQLuW7mqMr7zuL933bvQ	2006-04-17 00:18:43
44	109	42	1	202	84	2299	2007-04-14 19:49:19	2007-04-15 02:55:33	п. Туруханск, ш. Мичурина, д. 2 к. 871, 375700	ст. Амурск, ш. Павлова, д. 7/5 к. 2/4, 986700	48	онлайн	1	LOFHudTmEAp1C4lkA7Ark4PuOdgEJOzIBMt6uPRTpX6wPOTR04W5Zub0YdHNohxHxSSeDcciGCDRctjhDqZgvCjnqTCLdx	2007-04-14 08:37:58
45	198	25	89	267	99	2754	2018-06-11 22:07:39	2018-06-12 22:02:35	с. Кизляр, наб. Курортная, д. 60, 108107	к. Бронницы, ул. Коммунальная, д. 80 стр. 357, 330823	77	наличные	2	q138BzB3JPrcqP1fKMMZgjhYXd7sgLDpHanDylFARg366GWn0eZhP3JosIAhk51rVbsDSj1Xum1FmgCrtiQBacQXvSlfySt	2018-06-10 23:21:34
46	167	57	58	256	19	950	2022-02-13 14:51:39	2022-02-14 11:20:36	клх Псебай, бул. Проезжий, д. 372 стр. 4/3, 319310	п. Ирбит, пер. Карла Маркса, д. 5, 402628	68	онлайн	1	QK4yGpZxZN74UrAdsk6SyUykXG9S8w16dizjxZnJFV2heN9U5JhYU4LdgQYvRoinKBlmak7H1J8jrQZ4uL8RNMA	2022-02-13 04:25:11
47	194	13	19	204	56	256	2015-11-18 16:37:19	2015-11-19 11:51:01	д. Мценск, ш. Ленинградское, д. 8/7, 231104	к. Обоянь, пер. Крымский, д. 8/1, 839521	155	карта	5	R40UuH5K6YxhIdqXM6Dfoly0VHDgeycpJBZDJhDTt8UU94RFBeijQJjPDWNWztHsRO3biFvhTcnOJb	2015-11-18 03:37:41
48	167	53	41	290	15	1670	2014-09-13 18:25:52	2014-09-14 08:05:58	д. Старый Оскол, алл. Цветочная, д. 73, 904045	п. Брянск, бул. Ореховый, д. 183 к. 8/1, 646510	127	наличные	1	MvreUTlLjcHdYp	2014-09-13 08:41:26
49	147	36	14	288	42	1118	2007-08-19 02:43:06	2007-08-19 16:47:02	п. Нягань, пр. Кутузова, д. 5 стр. 8, 072382	с. Бугульма, бул. Шевченко, д. 4 стр. 852, 815367	156	карта	2	qsMh8eYJDHySwS6wcok1eh	2007-08-18 11:49:27
50	131	98	63	282	14	1675	2014-12-09 01:47:58	2014-12-09 19:08:20	с. Томск, алл. Гончарова, д. 9 стр. 4/3, 687737	к. \nВилюйск, наб. Транспортная, д. 5 стр. 60, 286582	106	наличные	2	stYGXUK6xTPr4YrHHzTI2Kwk7lPyd8SBK6qVim2vXicmsLIb2NROZXfkPz7lJtBJv92x12LSqHZ8JbrA6dmRMTraf25S2C	2014-12-08 03:20:31
51	112	19	28	224	68	2693	2022-08-03 11:13:16	2022-08-03 11:39:36	г. Пинега, наб. Менделеева, д. 579, 893455	д. Можайск, ул. Октябрьская, д. 3, 928011	187	карта	3	evteVZUaKY2TDHP6wd8fWOrX	2022-08-02 12:56:16
52	191	94	66	217	6	890	2019-04-25 02:54:56	2019-04-25 20:00:38	с. Чебаркуль, ш. Коминтерна, д. 268 к. 1/8, 750483	клх Верхоянск, пр. Первомайский, д. 14 стр. 9, 066553	152	онлайн	2	Q9ib8ZPOmQVhMZbLAKgwtShD20H74clo1JtcNTYOc86STqlXbIF8JFs4mwS1TUC2PG2abFJhMvKkO3taRyrubC67YEzrtZMKvRZRngxiTRANNdQU8P6EtQAqTlcXHZ7XDO0HcYAMQAuNk6etf9e50j9kiodiC	2019-04-25 01:17:39
53	178	4	21	223	26	1351	2009-08-07 07:04:44	2009-08-07 10:23:48	с. Долинск, алл. Невского, д. 8/2, 005401	д. Москва, пер. Весенний, д. 245 к. 391, 650242	101	наличные	5	zxEvCMsk4M1O48SB	2009-08-07 01:55:57
54	142	98	52	239	26	2305	2016-11-09 10:49:37	2016-11-09 22:20:45	д. Тавда, пер. Лазурный, д. 5/3 стр. 97, 606177	к. \nКиржач, наб. Ореховая, д. 31 к. 8, 141348	192	онлайн	5	rEvXiPL6E6VyrGwTEwZIYVXOhltZXDLXSEJqMrwgdjYCJdyAaDGqM47MDNu22EcJg92tqeFvKYRtfeM9vqps3IpOmKQet0c6zbA4WxuUbBGzLdmpwTmQBpJsuXDGezzS6brWgr3pFwCesqiLOkHIZK0YRe	2016-11-09 04:27:02
55	177	23	95	201	76	1580	2019-03-20 01:39:05	2019-03-20 13:53:16	п. Тайшет, пер. Отрадный, д. 209, 731333	ст. Рязань, бул. Просвещения, д. 1/6, 488572	182	онлайн	3	dk2dY2OPcDZzysOH56urc6dfR9V18ecqYnfjeM3T1Yy1A6qdGFBXrINr8H3xStUakd5QdyyrYPfPPgEZ1yAfPEV6O7qRmmtsXDlhJz	2019-03-19 17:40:10
56	148	18	64	276	41	1591	2007-12-31 17:14:42	2008-01-01 17:03:36	с. Палана, пер. Мельничный, д. 48 стр. 5, 046696	д. Северобайкальск, пер. Металлистов, д. 9/6 к. 121, 055586	53	карта	5	yyRxB3huPdhDn5mrZ9dNRmKQd13Ci2stvmARdQkMk19	2007-12-31 12:05:13
57	125	50	57	219	55	2073	2007-06-21 17:56:23	2007-06-22 09:17:33	д. Егорьевск, ш. Речное, д. 2/5, 593740	клх Южно-Курильск, ш. Рабочее, д. 70 стр. 9/4, 780075	83	наличные	2	KjjsQjZODnbGUoYCy8A6PvoCCWHNUQMkfV9UXhFgxzUOI8944SUJFHvAcBk4rnRWT3lzZpJHQFNkIDzSmJsHwUHyv6hghxT2MO7v1EGrgHN8	2007-06-21 03:01:10
58	180	87	37	264	63	2821	2008-03-23 04:08:39	2008-03-24 00:20:34	клх Курильск, ш. Революционное, д. 3 стр. 6, 999291	клх Ессентуки, ул. Мелиораторов, д. 9, 296671	176	наличные	4	ZZhYTd1H5ZjNFHRsJER7ukOT3xdPBUa6qasc7SHkDqSI1pByEHHAcP4OrSLF1oYv8G	2008-03-22 15:07:19
59	120	90	95	237	49	1447	2009-05-03 00:01:18	2009-05-03 10:28:15	г. Калязин, пер. Строительный, д. 2/8 стр. 6/4, 911414	г. Юрюзань, бул. Тупиковый, д. 7/2 стр. 45, 830438	130	наличные	3	2j4HGDFjguRb4NJ2JTg0JcIVpgGySSgon90W5FiUNRkuZ7qFeaJsp93wABbZDjsv6R1tRGbEvNhcEUay2xXqyySWSxNPFgJb65hohDdpMfswnMW5dg5CeXRbVgTQC	2009-05-02 13:10:29
60	136	46	48	296	13	1180	2014-07-23 13:07:12	2014-07-24 02:47:08	с. Арсеньев, алл. Буденного, д. 52, 322419	ст. Аршан (Бурят.), алл. Северная, д. 16, 872880	116	онлайн	5	VyGfPEtjshjtMOyU6CLxFPDUnroovc1pU17k2V6BELIFSCtj52hLV9kFZYjq6GVrxCbi42GzNyhk3WWXz8ojaLzR4kewX3yADrOkD78fPkqv5PMcuUS3WVWoJKhnnWtDstdN2SJ92qi	2014-07-22 23:19:40
61	167	96	3	265	10	1824	2019-06-19 10:56:04	2019-06-20 04:28:44	г. Сарапул, бул. Ленина, д. 355 к. 9/3, 216909	д. Тулпан, бул. Полевой, д. 53 к. 41, 799222	104	карта	4	y1hBFqo50xtMcYpr9RXzrHuB02nAwvRFORKgjTeh13QmnB3rzwl12	2019-06-19 00:18:34
62	198	11	4	207	68	2359	2020-04-03 21:13:10	2020-04-04 20:07:32	д. Амдерма, наб. Победы, д. 2 стр. 57, 842837	ст. Юрьев-Польский, пр. Курортный, д. 4 к. 1/8, 522601	114	наличные	5	cgpbz9reL6f7EcOlptJORW9Z8HlYOWI2EjBl49OIgv2RjkFLmXfA2QRkaXSm3n2rlLBdIrhEbs401SBgZD9fj2buLlVDX7KdEGZi3zc	2020-04-03 12:10:13
63	200	46	64	288	90	1065	2014-09-21 00:39:52	2014-09-21 16:19:13	с. Малоярославец, пр. Войкова, д. 387, 236894	клх Ербогачен, алл. Промышленная, д. 431 стр. 1/8, 391322	184	онлайн	4	O4xzUG2FI3VfwsSjWsHJ4a0fxXCaLhDTywfiws7TRQs27oo0GitQD9EFIQgByf2ErHf8dZGPQfcfJi18FfFVsMm9vy8zKOtcorAm70NUsJVQGL9dTw8aDEXZ3RXe3bomb9r3kEEBZBw990gAf1LHYHuzqtPCwCbbEM8hFXoHAFZqtaH1adrW9HFxjWxeK	2014-09-20 15:06:17
64	197	29	38	271	23	2496	2010-03-01 00:18:33	2010-03-01 10:35:00	с. Валдай, пер. Геологов, д. 69 стр. 58, 404739	ст. Шумиха, наб. Коммунаров, д. 24 стр. 359, 154560	142	онлайн	2	PpweXqT0ZML6o1OXnK8DKXqWwv3uuqz1mt41auknltzQbBScMZSR303KwBMO6WiYnR0EV5zjqhuQg44JZH7k4fFcyKSwqZ3JaIDnwytdBv51SrfiXRU5u0HwTO3ixFXXYLW4qBZeP6k8DOtm5Rb6gJhFxVDmNORd9r7NnXIxf74YYucAHVwf	2010-02-28 19:02:24
65	199	36	21	271	100	1302	2023-11-28 04:59:53	2023-11-28 14:58:06	с. Гремячинск (Перм.), бул. Нефтяников, д. 648 стр. 6, 421970	д. Калининград, ул. Щербакова, д. 864 к. 4/8, 171678	55	наличные	5	KUo1qWku5F0Q5kdNLBQmsKL1g3WxTPqX0YALrPR22ZKsLklxE5eWyoHZF0NX5vgFb9PKrToCPVMkAAjVUXMNoMtSnDCyQBQyUNx0s36G04OkvPxRQ2xOxUX7bnNhqq2h	2023-11-27 17:21:01
66	130	16	78	286	38	1204	2023-11-01 16:29:33	2023-11-02 11:12:03	г. Зарайск, наб. Шоссейная, д. 9 к. 9, 859200	п. Токма, пр. Орджоникидзе, д. 1/2, 197065	105	онлайн	4	INgVeofo7sIbig4HwvAFf3	2023-10-31 16:35:20
67	194	36	17	249	87	1784	2012-12-15 18:03:30	2012-12-15 19:16:09	г. Шереметьево, пер. Луначарского, д. 33 к. 4/7, 763559	п. Вытегра, алл. Сиреневая, д. 469, 982687	5	карта	2	t8NXs1LcBuM2u4IE2I2AM8wvXaxP3fSaT16e6CilvMphLZ6Svxzy	2012-12-15 13:42:29
68	134	83	73	209	28	2467	2024-06-14 01:21:07	2024-06-14 14:57:24	д. Белоярский, ул. Парижской Коммуны, д. 3/9 стр. 7, 133477	п. Арсеньев, пер. Огородный, д. 1/7, 408209	42	онлайн	2	yeZ4LcUTMwtVsj4R10dkJk9AxfKq2xrdcW7yAJnFscteKHmzu1jlukJJnmiVx0tDbsKyA6MFZbiUQeZ74zdiBfvUUpAhLOb7dDmwPEsptso3r09gXTAGdWhWCJEUh6KOpyW3lbvdX4o3PymVNXyXqTI3lNbiuNG1m5nTuBWkiMAkcT0d	2024-06-13 08:27:01
69	192	27	53	295	29	1049	2017-12-31 03:39:13	2017-12-31 07:27:56	д. Сухиничи, ул. Гончарова, д. 653, 586995	г. Вендинга, ул. 50 лет Победы, д. 40, 687350	80	онлайн	3	l3bD05mSrx7PFA73mV0zKcGxD8rhgBjoOKWrVteLBZeluaDw9dIrooK6fcZ3ekC0	2017-12-30 12:14:10
70	197	48	70	243	58	1653	2015-08-20 02:31:18	2015-08-20 08:06:42	г. Челябинск, наб. Ставропольская, д. 5 стр. 41, 295003	клх Кинешма, пер. Черемушки, д. 41 стр. 13, 264127	87	онлайн	5	JrDSuSXPX0XKvUsGpyfFZOj2ct0Qz9hsZCJXMhBxWMg0BFXW4EsXGngW6Um6tII0umN8jrP5EpgsFTWSKdXhaRvRQt6qjnxIRF5dmVYIQJDFjbUjb6YaR5ikQoZPHLj5ilnetsVFLwNLMEYmLU7wlHP2B4	2015-08-19 15:55:52
71	124	77	44	273	95	251	2024-11-04 23:05:15	2024-11-05 08:01:48	к. Новомосковск, бул. Тепличный, д. 76, 417818	ст. Лабинск, ул. Тихая, д. 8 стр. 4, 069350	135	онлайн	3	Zsyz2MlgsYXSm1oPzbxZtWz6R9dpaUEN43PXYSO1rqKkQS8yj3jjC8rzXZwfnxAbtdiFeuXrPMjm8PWikefVbaZO6K9m7gKkGO2Neh7CVkEUrnn6N6mKkM5l0x1qjOVStXRBGwKRME4wIc8E8jGHLdA3FYf5ehGnILPa3WKQXKn1DHesRErUvAZotYY	2024-11-04 15:59:40
72	132	71	61	287	6	2119	2017-12-04 12:26:27	2017-12-04 21:15:23	к. Кропоткин (Краснод.), пр. Красногвардейский, д. 264, 574729	клх Норильск, алл. Водников, д. 10 к. 13, 388708	195	наличные	3	JTG5LPb16lmHoJVHzrEveylOSwLcVxGkKXdDwjJ7ONw1pFbpGG22DV3Z4cnHvtmGXAP60JySElCC6MkUxFNXk55XCSj6XLo97zv8QUiz91Za3q5K6m8CQ3u6N1slk56rEFqWWuYcyREDi4y7OmugBtMlGRN7KPekIuqKBGCuKVy4pkAcgFFG0EmbZZG2w8	2017-12-03 22:44:35
73	129	29	62	226	18	1135	2020-12-04 10:18:45	2020-12-04 19:25:04	г. Кострома, пр. Стахановский, д. 4/2 стр. 3/4, 025317	ст. Жигулевск, наб. 50 лет Победы, д. 9 стр. 9, 522793	106	карта	2	hOelSrSo91YM6Hte8uP2Ro02cxeVHvSCKYvfMoeIFLu3ohfCRfly2GY482TG9DmPT9pPmU96qcR	2020-12-04 09:36:31
74	102	1	70	248	100	1891	2016-09-21 22:50:23	2016-09-22 05:23:29	д. Усть-Ишим, пер. Хвойный, д. 2 стр. 81, 389341	к. Аршан (Бурят.), пр. Широкий, д. 5 к. 528, 657987	176	наличные	5	DNPkARA3IdKR61LRq25lqHaC12ir4Y1x9t2zVrMby9efAFVV9LoRS1DRpbPy5XwxzcFmFSLhGfSwLXLJvesHNHWf2RuRZDW3KnuG	2016-09-21 00:23:19
75	117	64	64	235	97	2107	2020-04-10 17:16:56	2020-04-11 03:49:24	д. Калевала, алл. Украинская, д. 638, 105729	г. Тымовское, наб. Тракторная, д. 19, 996668	1	онлайн	5	NZtQgOtzEx9fakXR1a6D2r4GJswOwnB9pdR8Pr4xoJtaREa3imIKymI5nzARadIMr7VxvOMcCYTA1TfuB1eYgMcwId2FlfE7k1nhtAIAP	2020-04-09 19:13:45
76	176	39	3	220	4	1576	2006-02-15 08:57:34	2006-02-16 05:37:45	г. Батайск, ш. Камское, д. 78 к. 377, 898510	ст. Биробиджан, ш. К.Маркса, д. 181 стр. 6/5, 788407	9	карта	2	3bvftpJinxlTufig8J0hD8tiYc0GJe8Ptfw3TqjdI75nggIsZuU1q24ldqzSY8EjlDRlJtlABktW81Uj0JuBtr36KZstXaBiFV9krAVapIwaWPStJR7GFcKsaWcoevSTAsFurcd8DPqPlrbWOwM9sZIbyqhe	2006-02-14 13:33:03
77	179	24	32	273	75	2047	2015-05-14 19:03:43	2015-05-15 12:04:38	к. Бугульма, алл. Победа, д. 784 к. 219, 816928	клх Златоуст, алл. Молодежная, д. 3/6 к. 31, 838424	172	онлайн	2	vcZfmLCnWoccgsXBxLc68Dfg8QCxQ1ZmMrZA4YOuQHw5M7CDX4HDoP0sWQB9oCBiFGqIjawaSAI33PKHj9JdIoZgdE8gbJMf3RaIlO69KppoQDPQjxSFfKR5pXmTIYzKubxVIOIt1ur6E0dBGNweuj	2015-05-14 16:08:29
78	142	10	88	289	51	2537	2005-10-10 18:23:02	2005-10-11 03:56:46	д. Арсеньев, ш. Шаумяна, д. 4 стр. 7, 611095	ст. Далматово, алл. Свободная, д. 86 к. 4/9, 703938	183	онлайн	1	dprgFPenwDeon1Iw37xc5PDqa2818oa6qkbu4eNmD52DGytlagamdxV9fVCuCnpID6Ol3moBUdI2ymPdjvK75RgcuaBqyuu1xPqYPkRwFOp6CCvzHMamZsnn9rnnMt2W2uqGjwDIXWn5VHIo6nvaNaTxOcqWGNvYgjqogs9TduOsrpOKkZDDh9PvbTeP	2005-10-10 00:22:09
79	112	4	98	209	71	2639	2006-08-30 23:14:12	2006-08-31 16:40:40	с. Джубга, бул. Песочный, д. 7/6, 853955	д. Тосно, пр. Ворошилова, д. 5/1 стр. 14, 280084	163	онлайн	1	R2bHY4Bz2nP3rnY5eIN8UTpOsfG30ZuqlULi77tBWQ8Ihk7nH7u2Hlir5CspCgBzN25GurEuPmY38X9JCqrytVWccmHSGkYwEN7tuluIbAxWgXhe2D2J8gcYC3Mf8zFfRoIHkoEc	2006-08-30 09:20:01
80	178	85	83	236	55	2358	2019-03-11 12:20:30	2019-03-11 13:24:36	п. Дно, ш. Покровское, д. 3 стр. 39, 982251	г. Зарайск, наб. Дорожников, д. 285 к. 2, 385988	1	карта	5	7GMb6OSVg3gWlbSUYDsYfJ4pPFldik689Nt3xeEZ1V7CCgZc2AjUZkOxUPm1DlvbXEVyTfNp0QxNGMN6JzhhUsBht1uFFv7OSQf2DGlhzHK6Mi3TvJJtANgbt	2019-03-11 10:23:24
81	179	29	52	232	44	1665	2006-08-12 18:42:52	2006-08-13 02:20:39	клх Верхний Баскунчак, ш. Азина, д. 7 к. 62, 798580	д. Валаам, наб. Троицкая, д. 89 стр. 397, 479566	102	онлайн	2	8eGheMK1eHITH	2006-08-12 03:12:06
82	152	41	55	203	44	2817	2022-04-07 17:20:13	2022-04-08 09:07:21	с. Петушки, алл. Чайкиной, д. 46 к. 7, 874830	д. Сузун, наб. Гончарова, д. 9/5 стр. 12, 943116	101	онлайн	4	6I3LeFHkEhtT6Z4t962WQrczxKmWCxnoLLccfP2	2022-04-07 16:57:39
83	114	14	68	295	69	2496	2022-03-07 15:03:01	2022-03-08 06:34:04	п. Моршанск, пр. Ушакова, д. 7 к. 27, 810376	с. Сальск, ул. Осипенко, д. 8/2 стр. 374, 169868	97	онлайн	3	UcT29JXQwo8xBL	2022-03-07 14:39:45
84	178	49	81	273	18	124	2011-03-01 02:20:09	2011-03-01 22:34:36	д. Черняховск, алл. Курчатова, д. 8 стр. 5, 705588	с. Саратов, пер. Речной, д. 73 к. 14, 980323	13	карта	5	H2fUWWN0wFP2VTji18IHbxPU1Q	2011-02-28 18:21:31
85	171	31	27	207	64	168	2024-05-25 00:00:15	2024-05-25 15:33:42	к. Саров (Морд.), бул. Привольный, д. 5/8, 680074	г. Нижний Новгород, пер. Мостовой, д. 48 к. 9, 969889	38	наличные	2	O8cmq8SW7QqH9sQZfsMxSFetV5sPcp64m5A0brtH4M3T79WSOF8nVN5rKGiQqQwHP6bsdcNTJ2GxTIQHr5RkZPKKfdRmF27lgzH6mjbtaezXQRNx	2024-05-24 09:10:43
86	158	36	1	218	68	415	2005-07-15 01:23:31	2005-07-15 11:19:40	г. Старый Оскол, бул. Харьковский, д. 1/6, 049131	ст. Тырныауз, пр. 8 Марта, д. 358 к. 714, 989421	7	наличные	1	FaxRGu8SOtimMA8el8hDcB3sP6Z0fl02r7OubIYd7pROghvkO0cPIuDVFM0bkP6OQXpdCR8BaRGl5ecRbfVbskGl22l5AFLTgCi4AynkYGPQoduNj31SSNpJIKMBN72qyjZqCjGgCFNZ0XS6m8tpppFWh3RGeSVQwe9GUTjqiGOWtdgC5GnoG	2005-07-14 15:05:15
87	178	69	75	296	8	1885	2017-06-12 11:30:50	2017-06-13 00:03:00	г. Верхотурье, наб. Заливная, д. 95 к. 33, 674149	с. Магадан, алл. Российская, д. 3 стр. 7/8, 341972	105	онлайн	1	IvPL0m8cGmJHLYponWMHJwM01mAaBFo0krcAlKy7PT1zzi1bkd1FJFEzgIAON9XXcBogVu	2017-06-12 07:27:15
88	143	19	76	207	49	2653	2020-11-27 15:18:17	2020-11-28 13:59:14	г. Обоянь, пр. Байкальский, д. 88 стр. 794, 169408	с. Ярославль, наб. Космодемьянской, д. 54 к. 2/5, 658523	138	карта	5	P4EwWdj6Ow7SpCfQHSJwannCvulyLeNZpkRQPxAYJxZ9sh3IRuQ19lGKS1aZuFmVJRsfbZMrAoWQbldRsbTEXtonszonlcTscTiGT64C8SpRYjI7hODcE33RsoIRSSFveZQ	2020-11-26 17:52:28
89	171	24	45	298	44	1978	2017-09-26 05:51:13	2017-09-26 06:05:15	клх Канск, ул. Нефтяников, д. 64, 418582	п. Верхний Баскунчак, пр. Фабричный, д. 684 стр. 689, 202131	78	карта	4	u5Hm06dBVUQJmgtOUGJ94segCdTdmcs9MmoRAt1yGKIrp38EQpbu7ey2TRp4tnFbOyMPAr5IWbDW83OFa42WNoOLiiIYExyJj7oGQDEtogk4TsTs0sm9NZtTDGxYGblg	2017-09-25 16:55:36
90	162	84	89	250	42	1546	2010-07-19 00:52:54	2010-07-19 13:14:33	ст. Ельня, ш. Поселковое, д. 8/2 к. 9, 003796	с. Абакан, ул. Титова, д. 4/4, 783174	30	онлайн	2	w19vShFcrUFQzmqefSmOcQoxLAX5oFHxmBCZuYW9hkrHUeKZ8X7Ci8FOFlCKN7AU9Ipp5qr5y9I7FNV9ymUvDeIG8OPIhnI5bD4q4r8zatjZcWScaqKP3mk5JeioEAws1VM	2010-07-18 11:06:52
91	108	3	17	234	39	2083	2009-08-05 03:20:08	2009-08-06 01:07:57	к. Приозерск, бул. Больничный, д. 3/1 стр. 95, 518438	п. Муром, ш. Бульварное, д. 82, 110001	98	карта	3	avSierAwJI1CCTcDK01leI7vCmLK84w0YXktDiOqrQz4ENjKgeYmGfkisFyWo9OKa0	2009-08-04 07:12:05
92	190	47	45	245	71	771	2007-12-24 04:44:48	2007-12-24 18:35:52	клх Карачаевск, наб. Техническая, д. 7/3 к. 142, 776216	с. Мокшан, ш. Крестьянское, д. 78 к. 6, 720512	7	наличные	3	7qcT5pjdAfacBVf7DfXplRdgCzrReC5NnzI8kPEwazBiN0B91pzHbdBbVQWAEC37CH9Gfa6BDQAIiEQW5N84mMBtn3GZnDH7q04wQnqOnetxZ49ZitE72gj8N3YXSxPlLJPx8t	2007-12-24 03:38:23
93	139	14	24	274	84	245	2015-01-26 12:39:00	2015-01-27 00:30:53	д. Куртамыш, бул. Тульский, д. 3/5, 063566	д. Оренбург, бул. Байкальский, д. 29, 225236	65	онлайн	1	jTlZgX7cvPhfJJkW5Zm1fnVYGG5sFkc8QfPvPL0t02oFpH6sfkXUYPByxwU2qgPQcgcg4p6vpJg4TDC0vRcLmXenmq8SSGcs7jyPbCdeN4Ku1ft9YQVMItdPE91jrI1VVdXOq6HpwrsRMudFYpT8ODaLE	2015-01-25 15:10:19
94	134	65	18	236	69	1632	2016-12-02 08:40:21	2016-12-03 00:50:25	с. Сосновый Бор, пр. Панфилова, д. 4/7 к. 4/5, 124088	к. Курчатов, наб. Брянская, д. 103, 148628	2	карта	2	9MPquGIHB7YUkq6QWw3bjIG2CzCDxHyKT75FOOONyqxGwvi0dXqic	2016-12-02 00:46:26
95	166	99	95	246	4	1775	2022-09-05 11:39:58	2022-09-06 08:07:49	клх Самара, ул. Коммунаров, д. 983 к. 946, 961266	клх Кунгур, наб. Мелиоративная, д. 4 стр. 202, 977266	182	онлайн	4	1U5Y94Uewu2MgBh2ozM1KCPMdBqYsqQfITz728qEt2K38skd3VDHaH8EclEfpFyuBM9u2Sb5dG8MQQ15xihMMucM	2022-09-04 20:33:21
96	112	3	45	229	72	169	2016-01-08 19:20:47	2016-01-09 18:54:31	п. Самара, пр. 60 лет Октября, д. 1/1 к. 353, 899797	д. Советский, алл. Пархоменко, д. 73 к. 48, 517476	151	карта	1	TQz3STFtdWo40kEqYCwudSepmMRyJFkdfIO6FBp3ySXZXcQMSiMvbxM7SUCI2Yhl3u8ShKgx5	2016-01-08 09:43:43
97	180	65	96	280	34	234	2013-01-06 21:00:18	2013-01-07 07:25:40	к. Калач, пр. Краснопартизанский, д. 3 стр. 6, 203946	п. Зеленогорск (Ленин.), ул. Заливная, д. 102, 715743	185	карта	2	VdvhxjUxJgiUhrUC5IW3RH3gS	2013-01-06 12:06:20
98	114	88	3	296	14	2012	2017-08-22 18:46:01	2017-08-22 22:08:37	д. Королев, пр. Зеленый, д. 8/2 стр. 8/1, 985677	к. \nСосногорск, алл. Гафури, д. 26 к. 639, 562321	172	онлайн	1	VIJbOoeE1QrLnVkZjaaVsESBbRJTOX5DwvpmsPj7kh0p7GvXmlFyNvTXVlCONgO5voRx1lKPwmZo4yNEeNKh9x5GHkDQKw1hXjh5TdrV2OVlVluLyevHh76HDKiM93zGD96PI5nhaaMi	2017-08-22 14:51:16
99	192	27	37	290	16	818	2008-08-04 05:02:38	2008-08-04 20:02:25	с. Вилюйск, ш. Чернышевского, д. 167 стр. 23, 693305	ст. Воткинск, пер. Вишневый, д. 39 к. 905, 305313	126	карта	1	9QXC53GU5QmgGt6OAjAmmiQc21FjQe6vNCE40Pb31sJVuBpYs4J60fOazVm	2008-08-03 06:21:11
100	110	36	88	218	95	1656	2019-04-26 01:11:08	2019-04-26 07:33:02	п. Владивосток, пр. Вавилова, д. 7 стр. 5/8, 357519	с. Оренбург, ш. 50 лет Победы, д. 4/9, 696949	93	онлайн	2	vpZF4YzKM5paiy2xeKzBiB83sQ1L9XD4O7iplln1Dqw1A9BXQvw5FUKyjOADfU9wUz4LlMKfQ7M8zAzlYlLS1Y	2019-04-25 07:30:03
101	182	51	80	246	38	1473	2022-11-02 04:28:05	2022-11-03 02:25:50	г. Серпухов, алл. Заречная, д. 434 стр. 208, 637076	с. Нерчинск, бул. Лермонтова, д. 1/4, 126772	96	карта	5	bjPIpHFKChg5i9R8rRVh01vnMrUSBVWBmuOFBuVdXxGX30nVsxHi4ZoNkx4Y5fRveReIU5CY9epdV4vbEls6nSf1go8gCubYbjIbWDdzmygRIOZr8rx	2022-11-01 17:01:35
\.


--
-- TOC entry 5002 (class 0 OID 16513)
-- Dependencies: 232
-- Data for Name: work_schedule; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.work_schedule (id, driver_id, start_time, end_time, status) FROM stdin;
1	101	2019-08-18 05:59:05	2021-08-22 15:23:02	вышел
2	102	2021-10-01 21:13:18	2024-02-04 03:48:07	вышел
3	103	2007-11-23 11:38:45	2019-03-12 06:53:01	вышел
4	104	2021-04-04 06:47:50	2022-11-11 23:35:47	вышел
5	105	2020-10-15 17:28:44	2021-06-08 15:18:29	вышел
6	106	2019-12-31 12:32:47	2021-05-02 05:06:33	вышел
7	107	2011-06-18 15:38:46	2019-04-29 04:23:18	вышел
8	108	2013-04-17 11:10:31	2014-12-27 05:17:45	вышел
9	109	2016-06-25 00:06:38	2020-07-13 02:33:57	вышел
10	110	2014-03-15 01:45:29	2014-09-20 20:21:14	вышел
11	111	2022-07-18 01:55:29	2024-09-07 03:47:26	вышел
12	112	2012-10-12 02:31:41	2018-10-17 20:05:54	вышел
13	113	2019-07-25 03:01:41	2020-02-01 07:58:10	вышел
14	114	2021-02-16 02:06:15	2023-03-20 23:21:44	вышел
15	115	2009-12-22 19:55:07	2015-08-18 11:27:10	вышел
16	116	2007-12-09 03:39:44	2021-06-22 08:30:50	вышел
17	117	2022-01-08 00:49:53	2022-08-24 23:11:31	вышел
18	118	2017-04-02 19:33:42	2020-05-26 06:32:56	вышел
19	119	2011-06-04 00:27:15	2022-08-02 10:56:58	вышел
20	120	2011-11-20 17:34:28	2015-02-24 23:52:38	вышел
21	121	2012-12-21 07:31:29	2013-03-21 04:18:58	вышел
22	122	2011-01-16 09:00:37	2016-11-26 02:02:24	вышел
23	123	2018-12-02 10:51:11	2020-04-20 22:04:05	вышел
24	124	2024-05-31 19:01:10	2024-12-14 03:51:26	вышел
25	125	2011-05-04 20:17:53	2015-03-26 19:16:50	вышел
26	126	2021-07-04 03:36:07	2021-07-27 22:03:44	вышел
27	127	2006-05-12 04:11:44	2023-06-21 13:31:34	вышел
28	128	2020-04-09 18:22:04	2025-03-18 00:21:57	вышел
29	129	2022-11-13 21:04:45	2024-01-03 10:21:57	вышел
30	130	2022-02-24 13:22:20	2023-08-19 10:24:38	вышел
31	131	2024-11-02 10:23:00	2025-03-21 10:29:18	вышел
32	132	2019-10-18 20:13:45	2023-09-03 01:58:36	вышел
33	133	2012-12-18 20:36:33	2016-06-29 06:01:25	вышел
34	134	2013-02-09 11:29:38	2016-06-08 06:44:24	вышел
35	135	2016-06-02 03:51:39	2016-07-09 07:38:57	вышел
36	136	2011-08-31 06:47:06	2023-10-17 10:49:16	вышел
37	137	2008-09-25 19:55:49	2020-12-24 07:05:16	вышел
38	138	2018-10-19 03:17:35	2021-02-23 07:23:39	вышел
39	139	2023-01-30 03:48:53	2024-12-17 00:17:05	вышел
40	140	2017-03-25 22:26:58	2018-04-23 12:06:33	вышел
41	141	2019-12-10 07:37:14	2024-02-25 03:19:31	вышел
42	142	2018-08-09 16:36:52	2023-05-26 04:30:50	вышел
43	143	2006-07-12 00:45:14	2015-02-11 00:15:31	вышел
44	144	2021-06-29 12:51:19	2023-01-10 21:44:16	вышел
45	145	2016-12-09 22:21:45	2022-01-20 14:55:14	вышел
46	146	2006-04-05 14:45:37	2018-03-10 17:04:37	вышел
47	147	2014-01-12 10:33:20	2023-12-02 04:55:32	вышел
48	148	2018-01-04 11:23:23	2023-08-20 05:56:26	вышел
49	149	2021-08-11 22:15:37	2022-04-30 18:30:33	вышел
50	150	2018-02-22 22:52:28	2021-05-02 00:11:24	вышел
51	151	2023-09-30 14:22:01	2024-09-29 04:33:59	вышел
52	152	2017-02-17 22:27:27	2020-04-01 04:56:19	вышел
53	153	2011-04-02 16:10:22	2011-10-22 16:35:07	вышел
54	154	2023-07-11 20:39:09	2023-09-13 11:56:01	вышел
55	155	2021-02-23 15:25:09	2021-04-05 03:57:42	вышел
56	156	2014-04-30 19:28:14	2017-03-07 02:55:29	вышел
57	157	2008-02-01 08:04:25	2015-10-19 17:27:32	вышел
58	158	2019-09-03 21:56:54	2020-01-04 04:31:22	вышел
59	159	2007-07-19 14:30:46	2014-04-27 01:12:00	вышел
60	160	2013-01-19 04:53:33	2023-10-12 09:33:00	вышел
61	161	2021-08-16 20:01:03	2021-12-01 22:22:28	вышел
62	162	2021-12-21 02:02:32	2022-03-14 16:06:07	вышел
63	163	2016-06-18 17:36:26	2023-01-24 13:59:03	вышел
64	164	2016-06-20 16:40:05	2023-02-22 10:34:08	вышел
65	165	2007-10-20 07:03:31	2009-05-08 22:56:29	вышел
66	166	2024-07-31 02:26:49	2024-09-15 04:36:27	вышел
67	167	2018-03-26 13:34:50	2022-05-20 13:38:27	вышел
68	168	2021-09-03 21:19:10	2023-09-19 01:53:41	вышел
69	169	2023-07-23 15:41:45	2023-10-17 02:13:06	вышел
70	170	2018-03-22 03:03:34	2024-10-17 12:47:32	вышел
71	171	2016-09-25 05:22:34	2022-10-01 08:14:55	вышел
72	172	2013-07-29 10:35:11	2020-11-10 04:02:42	вышел
73	173	2022-05-27 09:16:45	2023-09-20 19:23:59	вышел
74	174	2016-09-19 04:32:56	2016-12-08 12:39:01	вышел
75	175	2018-10-17 02:08:05	2025-03-10 06:56:22	вышел
76	176	2013-07-31 19:30:31	2019-02-22 02:25:20	вышел
77	177	2018-06-10 15:32:57	2020-04-22 20:44:03	вышел
78	178	2009-10-18 15:24:16	2013-07-25 21:58:32	вышел
79	179	2015-11-27 22:53:07	2016-09-12 02:06:49	вышел
80	180	2011-02-15 21:07:23	2020-12-20 04:33:07	вышел
81	181	2020-06-25 08:46:18	2024-01-21 06:19:40	вышел
82	182	2022-02-08 22:38:57	2024-01-16 02:16:27	вышел
83	183	2009-06-04 09:25:56	2014-05-28 12:41:01	вышел
84	184	2010-09-20 19:26:08	2022-08-14 03:40:58	вышел
85	185	2022-03-18 10:23:57	2022-05-11 00:04:13	вышел
86	186	2022-05-10 19:03:24	2023-11-13 14:14:32	вышел
87	187	2020-09-26 13:04:45	2024-09-26 13:12:15	вышел
88	188	2008-06-09 02:12:01	2010-07-09 11:29:24	вышел
89	189	2022-03-03 06:23:37	2024-07-13 05:21:24	вышел
90	190	2005-11-29 04:52:10	2025-01-12 22:48:44	вышел
91	191	2011-05-06 07:12:50	2017-05-22 16:36:37	вышел
92	192	2016-09-17 10:31:05	2023-06-09 23:36:47	вышел
93	193	2020-02-14 04:52:17	2023-08-12 17:47:18	вышел
94	194	2016-04-11 02:49:07	2017-10-13 20:17:34	вышел
95	195	2015-12-20 02:00:10	2021-01-24 05:42:13	вышел
96	196	2016-08-04 10:19:18	2022-01-13 13:33:05	вышел
97	197	2012-06-09 03:41:51	2019-03-04 21:04:03	вышел
98	198	2020-07-26 08:40:02	2020-10-11 10:08:05	вышел
99	199	2011-03-02 07:20:13	2019-03-19 21:32:56	вышел
100	200	2014-12-11 16:32:11	2016-01-16 00:46:52	вышел
\.


--
-- TOC entry 5040 (class 0 OID 0)
-- Dependencies: 234
-- Name: bank_card_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.bank_card_id_seq', 100, true);


--
-- TOC entry 5041 (class 0 OID 0)
-- Dependencies: 238
-- Name: car_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.car_id_seq', 100, true);


--
-- TOC entry 5042 (class 0 OID 0)
-- Dependencies: 236
-- Name: car_model_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.car_model_id_seq', 10, true);


--
-- TOC entry 5043 (class 0 OID 0)
-- Dependencies: 240
-- Name: car_usage_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.car_usage_id_seq', 100, true);


--
-- TOC entry 5044 (class 0 OID 0)
-- Dependencies: 246
-- Name: cost_adjustment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cost_adjustment_id_seq', 100, true);


--
-- TOC entry 5045 (class 0 OID 0)
-- Dependencies: 229
-- Name: driver_employee_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.driver_employee_id_seq', 1, false);


--
-- TOC entry 5046 (class 0 OID 0)
-- Dependencies: 222
-- Name: employee_with_position_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.employee_with_position_id_seq', 200, true);


--
-- TOC entry 5047 (class 0 OID 0)
-- Dependencies: 226
-- Name: payment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.payment_id_seq', 200, true);


--
-- TOC entry 5048 (class 0 OID 0)
-- Dependencies: 224
-- Name: payment_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.payment_type_id_seq', 5, true);


--
-- TOC entry 5049 (class 0 OID 0)
-- Dependencies: 218
-- Name: person_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.person_id_seq', 400, true);


--
-- TOC entry 5050 (class 0 OID 0)
-- Dependencies: 221
-- Name: position_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.position_id_seq', 1, true);


--
-- TOC entry 5051 (class 0 OID 0)
-- Dependencies: 242
-- Name: tariff_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tariff_id_seq', 4, true);


--
-- TOC entry 5052 (class 0 OID 0)
-- Dependencies: 244
-- Name: tariff_price_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tariff_price_id_seq', 100, true);


--
-- TOC entry 5053 (class 0 OID 0)
-- Dependencies: 248
-- Name: taxi_call_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.taxi_call_id_seq', 101, true);


--
-- TOC entry 5054 (class 0 OID 0)
-- Dependencies: 231
-- Name: work_schedule_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.work_schedule_id_seq', 100, true);


--
-- TOC entry 4791 (class 2606 OID 16488)
-- Name: administrator administrator_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.administrator
    ADD CONSTRAINT administrator_pkey PRIMARY KEY (employee_id);


--
-- TOC entry 4801 (class 2606 OID 16553)
-- Name: bank_card bank_card_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bank_card
    ADD CONSTRAINT bank_card_pkey PRIMARY KEY (id);


--
-- TOC entry 4805 (class 2606 OID 16568)
-- Name: car_model car_model_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.car_model
    ADD CONSTRAINT car_model_pkey PRIMARY KEY (id);


--
-- TOC entry 4809 (class 2606 OID 16583)
-- Name: car car_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.car
    ADD CONSTRAINT car_pkey PRIMARY KEY (id);


--
-- TOC entry 4813 (class 2606 OID 16597)
-- Name: car_usage car_usage_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.car_usage
    ADD CONSTRAINT car_usage_pkey PRIMARY KEY (id);


--
-- TOC entry 4743 (class 2606 OID 16700)
-- Name: employee_with_position check_date; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.employee_with_position
    ADD CONSTRAINT check_date CHECK ((end_date > start_date)) NOT VALID;


--
-- TOC entry 4748 (class 2606 OID 16524)
-- Name: work_schedule check_status; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.work_schedule
    ADD CONSTRAINT check_status CHECK (((status)::text = ANY ((ARRAY['вышел'::character varying, 'не вышел'::character varying, 'досрочно закончил'::character varying])::text[]))) NOT VALID;


--
-- TOC entry 4821 (class 2606 OID 16645)
-- Name: cost_adjustment cost_adjustment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cost_adjustment
    ADD CONSTRAINT cost_adjustment_pkey PRIMARY KEY (id);


--
-- TOC entry 4793 (class 2606 OID 16502)
-- Name: driver driver_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.driver
    ADD CONSTRAINT driver_pkey PRIMARY KEY (employee_id);


--
-- TOC entry 4777 (class 2606 OID 16419)
-- Name: employee employee_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee
    ADD CONSTRAINT employee_pkey PRIMARY KEY (person_id);


--
-- TOC entry 4783 (class 2606 OID 16448)
-- Name: employee_with_position employee_with_position_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee_with_position
    ADD CONSTRAINT employee_with_position_pkey PRIMARY KEY (id);


--
-- TOC entry 4799 (class 2606 OID 16531)
-- Name: passenger passenger_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.passenger
    ADD CONSTRAINT passenger_pkey PRIMARY KEY (person_id);


--
-- TOC entry 4789 (class 2606 OID 16473)
-- Name: payment payment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment
    ADD CONSTRAINT payment_pkey PRIMARY KEY (id);


--
-- TOC entry 4785 (class 2606 OID 16466)
-- Name: payment_type payment_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment_type
    ADD CONSTRAINT payment_type_pkey PRIMARY KEY (id);


--
-- TOC entry 4771 (class 2606 OID 16408)
-- Name: person person_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.person
    ADD CONSTRAINT person_pkey PRIMARY KEY (id);


--
-- TOC entry 4779 (class 2606 OID 16441)
-- Name: position position_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."position"
    ADD CONSTRAINT position_pkey PRIMARY KEY (id);


--
-- TOC entry 4741 (class 2606 OID 16431)
-- Name: employee status_check; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.employee
    ADD CONSTRAINT status_check CHECK (((status)::text = ANY ((ARRAY['работает'::character varying, 'не работает'::character varying, 'в отпуске'::character varying])::text[]))) NOT VALID;


--
-- TOC entry 4815 (class 2606 OID 16623)
-- Name: tariff tariff_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tariff
    ADD CONSTRAINT tariff_pkey PRIMARY KEY (id);


--
-- TOC entry 4819 (class 2606 OID 16632)
-- Name: tariff_price tariff_price_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tariff_price
    ADD CONSTRAINT tariff_price_pkey PRIMARY KEY (id);


--
-- TOC entry 4823 (class 2606 OID 16654)
-- Name: taxi_call taxi_call_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.taxi_call
    ADD CONSTRAINT taxi_call_pkey PRIMARY KEY (id);


--
-- TOC entry 4795 (class 2606 OID 16542)
-- Name: driver unique_license_number; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.driver
    ADD CONSTRAINT unique_license_number UNIQUE (license_number);


--
-- TOC entry 4811 (class 2606 OID 16590)
-- Name: car unique_license_plate; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.car
    ADD CONSTRAINT unique_license_plate UNIQUE (license_plate);


--
-- TOC entry 4807 (class 2606 OID 16575)
-- Name: car_model unique_make_and_model; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.car_model
    ADD CONSTRAINT unique_make_and_model UNIQUE (make_and_model);


--
-- TOC entry 4787 (class 2606 OID 16544)
-- Name: payment_type unique_name; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment_type
    ADD CONSTRAINT unique_name UNIQUE (name);


--
-- TOC entry 4803 (class 2606 OID 16686)
-- Name: bank_card unique_number; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bank_card
    ADD CONSTRAINT unique_number UNIQUE (number);


--
-- TOC entry 4773 (class 2606 OID 16410)
-- Name: person unique_passport_data; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.person
    ADD CONSTRAINT unique_passport_data UNIQUE (passport);


--
-- TOC entry 4775 (class 2606 OID 16412)
-- Name: person unique_phone; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.person
    ADD CONSTRAINT unique_phone UNIQUE (phone);


--
-- TOC entry 4817 (class 2606 OID 16625)
-- Name: tariff unique_tariff_name; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tariff
    ADD CONSTRAINT unique_tariff_name UNIQUE (name);


--
-- TOC entry 4781 (class 2606 OID 16546)
-- Name: position unique_title; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."position"
    ADD CONSTRAINT unique_title UNIQUE (title);


--
-- TOC entry 4797 (class 2606 OID 16518)
-- Name: work_schedule work_schedule_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.work_schedule
    ADD CONSTRAINT work_schedule_pkey PRIMARY KEY (id);


--
-- TOC entry 4837 (class 2606 OID 16670)
-- Name: taxi_call fk_administrator_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.taxi_call
    ADD CONSTRAINT fk_administrator_id FOREIGN KEY (administrator_id) REFERENCES public.administrator(employee_id);


--
-- TOC entry 4834 (class 2606 OID 16598)
-- Name: car_usage fk_car_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.car_usage
    ADD CONSTRAINT fk_car_id FOREIGN KEY (car_id) REFERENCES public.car(id);


--
-- TOC entry 4838 (class 2606 OID 16660)
-- Name: taxi_call fk_cost_adjustment_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.taxi_call
    ADD CONSTRAINT fk_cost_adjustment_id FOREIGN KEY (cost_adjustment_id) REFERENCES public.cost_adjustment(id);


--
-- TOC entry 4830 (class 2606 OID 16519)
-- Name: work_schedule fk_driver_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.work_schedule
    ADD CONSTRAINT fk_driver_id FOREIGN KEY (driver_id) REFERENCES public.driver(employee_id) NOT VALID;


--
-- TOC entry 4835 (class 2606 OID 16603)
-- Name: car_usage fk_driver_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.car_usage
    ADD CONSTRAINT fk_driver_id FOREIGN KEY (driver_id) REFERENCES public.driver(employee_id);


--
-- TOC entry 4839 (class 2606 OID 16655)
-- Name: taxi_call fk_driver_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.taxi_call
    ADD CONSTRAINT fk_driver_id FOREIGN KEY (driver_id) REFERENCES public.driver(employee_id);


--
-- TOC entry 4825 (class 2606 OID 16450)
-- Name: employee_with_position fk_employee_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee_with_position
    ADD CONSTRAINT fk_employee_id FOREIGN KEY (employee_id) REFERENCES public.employee(person_id) NOT VALID;


--
-- TOC entry 4827 (class 2606 OID 16479)
-- Name: payment fk_employee_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment
    ADD CONSTRAINT fk_employee_id FOREIGN KEY (employee_id) REFERENCES public.employee(person_id);


--
-- TOC entry 4829 (class 2606 OID 16489)
-- Name: administrator fk_employee_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.administrator
    ADD CONSTRAINT fk_employee_id FOREIGN KEY (employee_id) REFERENCES public.employee(person_id);


--
-- TOC entry 4833 (class 2606 OID 16584)
-- Name: car fk_model_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.car
    ADD CONSTRAINT fk_model_id FOREIGN KEY (model_id) REFERENCES public.car_model(id);


--
-- TOC entry 4840 (class 2606 OID 16665)
-- Name: taxi_call fk_passenger_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.taxi_call
    ADD CONSTRAINT fk_passenger_id FOREIGN KEY (passenger_id) REFERENCES public.passenger(person_id);


--
-- TOC entry 4828 (class 2606 OID 16474)
-- Name: payment fk_payment_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment
    ADD CONSTRAINT fk_payment_type_id FOREIGN KEY (payment_type_id) REFERENCES public.payment_type(id);


--
-- TOC entry 4824 (class 2606 OID 16420)
-- Name: employee fk_person_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee
    ADD CONSTRAINT fk_person_id FOREIGN KEY (person_id) REFERENCES public.person(id) NOT VALID;


--
-- TOC entry 4831 (class 2606 OID 16532)
-- Name: passenger fk_person_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.passenger
    ADD CONSTRAINT fk_person_id FOREIGN KEY (person_id) REFERENCES public.person(id);


--
-- TOC entry 4832 (class 2606 OID 16554)
-- Name: bank_card fk_pessenger_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bank_card
    ADD CONSTRAINT fk_pessenger_id FOREIGN KEY (passenger_id) REFERENCES public.passenger(person_id);


--
-- TOC entry 4826 (class 2606 OID 16455)
-- Name: employee_with_position fk_position_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee_with_position
    ADD CONSTRAINT fk_position_id FOREIGN KEY (position_id) REFERENCES public."position"(id) NOT VALID;


--
-- TOC entry 4836 (class 2606 OID 16633)
-- Name: tariff_price fk_tariff_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tariff_price
    ADD CONSTRAINT fk_tariff_id FOREIGN KEY (tariff_id) REFERENCES public.tariff(id);


--
-- TOC entry 4841 (class 2606 OID 16675)
-- Name: taxi_call fk_tariff_price_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.taxi_call
    ADD CONSTRAINT fk_tariff_price_id FOREIGN KEY (tariff_price_id) REFERENCES public.tariff_price(id);


-- Completed on 2025-03-27 16:22:27

--
-- PostgreSQL database dump complete
--

