--
-- PostgreSQL database dump
--

-- Dumped from database version 15.12 (Debian 15.12-1.pgdg120+1)
-- Dumped by pg_dump version 15.12

-- Started on 2025-04-03 11:24:46 UTC

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
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
-- TOC entry 230 (class 1259 OID 16528)
-- Name: additional_service_connection; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.additional_service_connection (
    id_contract_on_tariff integer NOT NULL,
    id_service integer NOT NULL,
    connection_date date NOT NULL,
    disconnection_date date,
    payment_day date NOT NULL,
    id integer NOT NULL,
    CONSTRAINT additional_service_connection_check CHECK (((disconnection_date IS NULL) OR (disconnection_date >= connection_date))),
    CONSTRAINT additional_service_connection_check1 CHECK ((payment_day >= connection_date)),
    CONSTRAINT additional_service_connection_connection_date_check CHECK ((connection_date >= CURRENT_DATE))
);


ALTER TABLE public.additional_service_connection OWNER TO admin;

--
-- TOC entry 238 (class 1259 OID 16692)
-- Name: additional_service_connection_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

ALTER TABLE public.additional_service_connection ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.additional_service_connection_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 225 (class 1259 OID 16474)
-- Name: balance; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.balance (
    id_balance integer NOT NULL,
    id_contract_on_tariff integer NOT NULL,
    remaining_sms integer NOT NULL,
    remaining_minutes integer NOT NULL,
    remaining_mb integer NOT NULL,
    CONSTRAINT balance_remaining_mb_check CHECK ((remaining_mb >= 0)),
    CONSTRAINT balance_remaining_minutes_check CHECK ((remaining_minutes >= 0)),
    CONSTRAINT balance_remaining_sms_check CHECK ((remaining_sms >= 0))
);


ALTER TABLE public.balance OWNER TO admin;

--
-- TOC entry 224 (class 1259 OID 16473)
-- Name: balance_id_balance_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

ALTER TABLE public.balance ALTER COLUMN id_balance ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.balance_id_balance_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 231 (class 1259 OID 16546)
-- Name: basic_service_connection; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.basic_service_connection (
    id_tariff integer NOT NULL,
    id_service integer NOT NULL,
    connection_date date NOT NULL,
    disconnection_date date,
    payment_day date NOT NULL,
    id integer NOT NULL,
    CONSTRAINT basic_service_connection_check CHECK (((disconnection_date IS NULL) OR (disconnection_date >= connection_date))),
    CONSTRAINT basic_service_connection_check1 CHECK ((payment_day >= connection_date)),
    CONSTRAINT basic_service_connection_connection_date_check CHECK ((connection_date >= CURRENT_DATE))
);


ALTER TABLE public.basic_service_connection OWNER TO admin;

--
-- TOC entry 237 (class 1259 OID 16685)
-- Name: basic_service_connection_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

ALTER TABLE public.basic_service_connection ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.basic_service_connection_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 240 (class 1259 OID 16701)
-- Name: call; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.call (
    id_call integer NOT NULL,
    receiver_zone_id integer NOT NULL,
    subscriber_zone_id integer NOT NULL,
    receiver_phone character varying(15) NOT NULL,
    cost integer NOT NULL,
    payment_status character varying(20) NOT NULL,
    payment_date date,
    payment_method character varying(20) NOT NULL,
    call_start_time timestamp without time zone NOT NULL,
    call_end_time timestamp without time zone NOT NULL,
    id_contract_on_tariff integer NOT NULL,
    CONSTRAINT call_check CHECK (((payment_date IS NULL) OR (payment_date >= call_end_time))),
    CONSTRAINT call_check1 CHECK ((call_end_time >= call_start_time)),
    CONSTRAINT call_cost_check CHECK ((cost >= 0)),
    CONSTRAINT call_payment_method_check CHECK (((payment_method)::text = ANY ((ARRAY['Пакет'::character varying, 'Рубли'::character varying])::text[]))),
    CONSTRAINT call_payment_status_check CHECK (((payment_status)::text = ANY ((ARRAY['оплачено'::character varying, 'не оплачено'::character varying])::text[]))),
    CONSTRAINT call_receiver_phone_check CHECK (((receiver_phone)::text ~ '^\+7\d{10}$'::text))
);


ALTER TABLE public.call OWNER TO admin;

--
-- TOC entry 239 (class 1259 OID 16700)
-- Name: call_id_call_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

ALTER TABLE public.call ALTER COLUMN id_call ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.call_id_call_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 221 (class 1259 OID 16439)
-- Name: contract_on_number; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.contract_on_number (
    id_contract integer NOT NULL,
    id_subscriber integer NOT NULL,
    termination_date date,
    signing_date date NOT NULL,
    phone_number character varying(15) NOT NULL,
    CONSTRAINT contract_on_number_check CHECK (((termination_date IS NULL) OR (termination_date >= signing_date))),
    CONSTRAINT contract_on_number_phone_number_check CHECK (((phone_number)::text ~ '^\+7\d{10}$'::text)),
    CONSTRAINT contract_on_number_signing_date_check CHECK ((signing_date >= CURRENT_DATE))
);


ALTER TABLE public.contract_on_number OWNER TO admin;

--
-- TOC entry 220 (class 1259 OID 16438)
-- Name: contract_on_number_id_contract_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

ALTER TABLE public.contract_on_number ALTER COLUMN id_contract ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.contract_on_number_id_contract_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 223 (class 1259 OID 16455)
-- Name: contract_on_tariff; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.contract_on_tariff (
    id_contract_on_tariff integer NOT NULL,
    id_tariff integer NOT NULL,
    id_contract integer NOT NULL,
    balance integer NOT NULL,
    connection_date date NOT NULL,
    disconnection_date date,
    payment_day date NOT NULL,
    CONSTRAINT contract_on_tariff_balance_check CHECK ((balance >= 0)),
    CONSTRAINT contract_on_tariff_check CHECK (((disconnection_date IS NULL) OR (disconnection_date >= connection_date))),
    CONSTRAINT contract_on_tariff_connection_date_check CHECK ((connection_date >= CURRENT_DATE))
);


ALTER TABLE public.contract_on_tariff OWNER TO admin;

--
-- TOC entry 222 (class 1259 OID 16454)
-- Name: contract_on_tariff_id_contract_on_tariff_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

ALTER TABLE public.contract_on_tariff ALTER COLUMN id_contract_on_tariff ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.contract_on_tariff_id_contract_on_tariff_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 233 (class 1259 OID 16565)
-- Name: external_resource; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.external_resource (
    id_resource integer NOT NULL,
    price integer NOT NULL,
    name character varying(100) NOT NULL,
    description character varying(255),
    payment_period character varying(30) NOT NULL,
    CONSTRAINT external_resource_payment_period_check CHECK (((payment_period)::text = ANY ((ARRAY['ежедневно'::character varying, 'ежемесячно'::character varying])::text[]))),
    CONSTRAINT external_resource_price_check CHECK ((price >= 0))
);


ALTER TABLE public.external_resource OWNER TO admin;

--
-- TOC entry 234 (class 1259 OID 16572)
-- Name: external_resource_connection; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.external_resource_connection (
    id_contract integer NOT NULL,
    id_resource integer NOT NULL,
    connection_date date NOT NULL,
    disconnection_date date,
    payment_day date NOT NULL,
    id integer NOT NULL,
    CONSTRAINT external_resource_connection_check CHECK (((disconnection_date IS NULL) OR (disconnection_date >= connection_date))),
    CONSTRAINT external_resource_connection_check1 CHECK ((payment_day >= connection_date))
);


ALTER TABLE public.external_resource_connection OWNER TO admin;

--
-- TOC entry 235 (class 1259 OID 16673)
-- Name: external_resource_connection_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.external_resource_connection_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.external_resource_connection_id_seq OWNER TO admin;

--
-- TOC entry 3525 (class 0 OID 0)
-- Dependencies: 235
-- Name: external_resource_connection_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.external_resource_connection_id_seq OWNED BY public.external_resource_connection.id;


--
-- TOC entry 236 (class 1259 OID 16684)
-- Name: external_resource_connection_id_seq1; Type: SEQUENCE; Schema: public; Owner: admin
--

ALTER TABLE public.external_resource_connection ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.external_resource_connection_id_seq1
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 232 (class 1259 OID 16564)
-- Name: external_resource_id_resource_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

ALTER TABLE public.external_resource ALTER COLUMN id_resource ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.external_resource_id_resource_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 227 (class 1259 OID 16490)
-- Name: interzone_tariff; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.interzone_tariff (
    id_interzone_tariff integer NOT NULL,
    sms_price integer NOT NULL,
    minute_price integer NOT NULL,
    sender_zone_id integer NOT NULL,
    receiver_zone_id integer NOT NULL,
    CONSTRAINT interzone_tariff_check CHECK ((sender_zone_id <> receiver_zone_id)),
    CONSTRAINT interzone_tariff_minute_price_check CHECK ((minute_price >= 0)),
    CONSTRAINT interzone_tariff_sms_price_check CHECK ((sms_price >= 0))
);


ALTER TABLE public.interzone_tariff OWNER TO admin;

--
-- TOC entry 226 (class 1259 OID 16489)
-- Name: interzone_tariff_id_interzone_tariff_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

ALTER TABLE public.interzone_tariff ALTER COLUMN id_interzone_tariff ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.interzone_tariff_id_interzone_tariff_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 229 (class 1259 OID 16521)
-- Name: service; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.service (
    id_service integer NOT NULL,
    price integer NOT NULL,
    name character varying(100) NOT NULL,
    description character varying(255),
    payment_period character varying(30) NOT NULL,
    CONSTRAINT service_payment_period_check CHECK (((payment_period)::text = ANY ((ARRAY['ежедневно'::character varying, 'ежемесячно'::character varying])::text[]))),
    CONSTRAINT service_price_check CHECK ((price >= 0))
);


ALTER TABLE public.service OWNER TO admin;

--
-- TOC entry 228 (class 1259 OID 16520)
-- Name: service_id_service_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

ALTER TABLE public.service ALTER COLUMN id_service ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.service_id_service_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 215 (class 1259 OID 16403)
-- Name: subscriber; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.subscriber (
    id_subscriber integer NOT NULL,
    full_name character varying(80) NOT NULL,
    passport_data character varying(30) NOT NULL,
    current_address character varying(150) NOT NULL,
    CONSTRAINT subscriber_full_name_check CHECK (((full_name)::text ~ '^[А-Яа-яЁё\s-]+$'::text)),
    CONSTRAINT subscriber_passport_data_check CHECK (((passport_data)::text ~ '^\d{4}-\d{6}$'::text))
);


ALTER TABLE public.subscriber OWNER TO admin;

--
-- TOC entry 214 (class 1259 OID 16402)
-- Name: subscriber_id_subscriber_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

ALTER TABLE public.subscriber ALTER COLUMN id_subscriber ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.subscriber_id_subscriber_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 219 (class 1259 OID 16422)
-- Name: tariff; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.tariff (
    id_tariff integer NOT NULL,
    cost integer NOT NULL,
    connection_conditions character varying(255),
    appearance_date date NOT NULL,
    archivation_date date,
    mb_package integer NOT NULL,
    minutes_package integer NOT NULL,
    sms_package integer NOT NULL,
    id_zone integer NOT NULL,
    CONSTRAINT tariff_appearance_date_check CHECK ((appearance_date <= CURRENT_DATE)),
    CONSTRAINT tariff_check CHECK (((archivation_date IS NULL) OR (archivation_date >= appearance_date))),
    CONSTRAINT tariff_cost_check CHECK ((cost >= 0)),
    CONSTRAINT tariff_mb_package_check CHECK ((mb_package >= 0)),
    CONSTRAINT tariff_minutes_package_check CHECK ((minutes_package >= 0)),
    CONSTRAINT tariff_sms_package_check CHECK ((sms_package >= 0))
);


ALTER TABLE public.tariff OWNER TO admin;

--
-- TOC entry 218 (class 1259 OID 16421)
-- Name: tariff_id_tariff_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

ALTER TABLE public.tariff ALTER COLUMN id_tariff ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.tariff_id_tariff_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 217 (class 1259 OID 16413)
-- Name: zone; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.zone (
    id_zone integer NOT NULL,
    zone_code character varying(10) NOT NULL,
    city character varying(50) NOT NULL,
    country character varying(40) NOT NULL,
    zone_type character varying(20) NOT NULL,
    price_per_mb integer NOT NULL,
    CONSTRAINT zone_price_per_mb_check CHECK ((price_per_mb >= 0))
);


ALTER TABLE public.zone OWNER TO admin;

--
-- TOC entry 216 (class 1259 OID 16412)
-- Name: zone_id_zone_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

ALTER TABLE public.zone ALTER COLUMN id_zone ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.zone_id_zone_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 3509 (class 0 OID 16528)
-- Dependencies: 230
-- Data for Name: additional_service_connection; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.additional_service_connection (id_contract_on_tariff, id_service, connection_date, disconnection_date, payment_day, id) FROM stdin;
2	4	2026-02-01	\N	2026-03-01	1
3	5	2027-07-01	\N	2027-08-01	2
4	6	2028-04-01	\N	2028-05-01	3
\.


--
-- TOC entry 3504 (class 0 OID 16474)
-- Dependencies: 225
-- Data for Name: balance; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.balance (id_balance, id_contract_on_tariff, remaining_sms, remaining_minutes, remaining_mb) FROM stdin;
1	2	100	300	1024
2	3	200	500	2048
3	4	50	150	512
\.


--
-- TOC entry 3510 (class 0 OID 16546)
-- Dependencies: 231
-- Data for Name: basic_service_connection; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.basic_service_connection (id_tariff, id_service, connection_date, disconnection_date, payment_day, id) FROM stdin;
13	4	2026-01-16	2026-04-16	2026-02-01	1
14	5	2027-06-02	2027-07-02	2027-07-01	2
15	6	2028-03-11	2028-09-11	2028-04-01	3
\.


--
-- TOC entry 3519 (class 0 OID 16701)
-- Dependencies: 240
-- Data for Name: call; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.call (id_call, receiver_zone_id, subscriber_zone_id, receiver_phone, cost, payment_status, payment_date, payment_method, call_start_time, call_end_time, id_contract_on_tariff) FROM stdin;
4	14	13	+79165554433	50	оплачено	\N	Пакет	2023-10-05 14:00:00	2023-10-05 14:05:00	2
5	15	14	+79167778899	70	не оплачено	\N	Рубли	2023-10-06 15:30:00	2023-10-06 15:35:00	3
6	13	14	+79161234567	35	оплачено	\N	Пакет	2023-10-07 10:15:00	2023-10-07 10:20:00	3
\.


--
-- TOC entry 3500 (class 0 OID 16439)
-- Dependencies: 221
-- Data for Name: contract_on_number; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.contract_on_number (id_contract, id_subscriber, termination_date, signing_date, phone_number) FROM stdin;
9	4	\N	2025-04-16	+74951234567
10	5	\N	2026-06-02	+78127654321
11	6	\N	2027-03-11	+73831122334
\.


--
-- TOC entry 3502 (class 0 OID 16455)
-- Dependencies: 223
-- Data for Name: contract_on_tariff; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.contract_on_tariff (id_contract_on_tariff, id_tariff, id_contract, balance, connection_date, disconnection_date, payment_day) FROM stdin;
2	13	9	0	2026-01-16	\N	2026-02-01
3	14	10	50	2027-06-02	\N	2027-07-01
4	15	11	10	2028-03-11	\N	2028-04-01
\.


--
-- TOC entry 3512 (class 0 OID 16565)
-- Dependencies: 233
-- Data for Name: external_resource; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.external_resource (id_resource, price, name, description, payment_period) FROM stdin;
1	150	Внешний интернет	Подключение к внешнему интернету	ежемесячно
2	200	Облачное хранилище	Подключение к облачному сервису хранения данных	ежемесячно
3	100	VPN сервис	Подключение к VPN сервису	ежемесячно
\.


--
-- TOC entry 3513 (class 0 OID 16572)
-- Dependencies: 234
-- Data for Name: external_resource_connection; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.external_resource_connection (id_contract, id_resource, connection_date, disconnection_date, payment_day, id) FROM stdin;
9	1	2026-01-16	\N	2026-02-01	1
10	2	2027-06-02	\N	2027-07-01	2
11	3	2028-03-11	\N	2028-04-01	3
\.


--
-- TOC entry 3506 (class 0 OID 16490)
-- Dependencies: 227
-- Data for Name: interzone_tariff; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.interzone_tariff (id_interzone_tariff, sms_price, minute_price, sender_zone_id, receiver_zone_id) FROM stdin;
1	5	10	13	14
2	7	15	14	15
3	6	12	15	13
\.


--
-- TOC entry 3508 (class 0 OID 16521)
-- Dependencies: 229
-- Data for Name: service; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.service (id_service, price, name, description, payment_period) FROM stdin;
4	100	Интернет-дополнительный	Дополнительный интернет пакет	ежемесячно
5	50	Антивирус	Защита устройства	ежемесячно
6	20	Мобильное ТВ	Подключение к ТВ-сервису	ежемесячно
\.


--
-- TOC entry 3494 (class 0 OID 16403)
-- Dependencies: 215
-- Data for Name: subscriber; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.subscriber (id_subscriber, full_name, passport_data, current_address) FROM stdin;
4	Иванов Иван Иванович	1234-567890	г. Москва, ул. Ленина, д. 1
5	Петров Петр Петрович	2345-678901	г. Санкт-Петербург, пр. Мира, д. 1
6	Сидорова Мария Ивановна	3456-789012	г. Новосибирск, ул. Советская, д. 1
\.


--
-- TOC entry 3498 (class 0 OID 16422)
-- Dependencies: 219
-- Data for Name: tariff; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.tariff (id_tariff, cost, connection_conditions, appearance_date, archivation_date, mb_package, minutes_package, sms_package, id_zone) FROM stdin;
13	500	Подключение без предоплаты	2020-01-15	\N	1024	300	100	13
14	750	Подключение с минимальной абонентской платой	2021-06-01	\N	2048	500	200	14
15	300	Акционный тариф	2022-03-10	\N	512	150	50	15
\.


--
-- TOC entry 3496 (class 0 OID 16413)
-- Dependencies: 217
-- Data for Name: zone; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.zone (id_zone, zone_code, city, country, zone_type, price_per_mb) FROM stdin;
13	MSK	Москва	Россия	городская	10
14	SPB	Санкт-Петербург	Россия	городская	12
15	NVR	Новороссийск	Россия	сельская	8
\.


--
-- TOC entry 3526 (class 0 OID 0)
-- Dependencies: 238
-- Name: additional_service_connection_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.additional_service_connection_id_seq', 3, true);


--
-- TOC entry 3527 (class 0 OID 0)
-- Dependencies: 224
-- Name: balance_id_balance_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.balance_id_balance_seq', 3, true);


--
-- TOC entry 3528 (class 0 OID 0)
-- Dependencies: 237
-- Name: basic_service_connection_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.basic_service_connection_id_seq', 3, true);


--
-- TOC entry 3529 (class 0 OID 0)
-- Dependencies: 239
-- Name: call_id_call_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.call_id_call_seq', 6, true);


--
-- TOC entry 3530 (class 0 OID 0)
-- Dependencies: 220
-- Name: contract_on_number_id_contract_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.contract_on_number_id_contract_seq', 11, true);


--
-- TOC entry 3531 (class 0 OID 0)
-- Dependencies: 222
-- Name: contract_on_tariff_id_contract_on_tariff_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.contract_on_tariff_id_contract_on_tariff_seq', 4, true);


--
-- TOC entry 3532 (class 0 OID 0)
-- Dependencies: 235
-- Name: external_resource_connection_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.external_resource_connection_id_seq', 3, true);


--
-- TOC entry 3533 (class 0 OID 0)
-- Dependencies: 236
-- Name: external_resource_connection_id_seq1; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.external_resource_connection_id_seq1', 1, false);


--
-- TOC entry 3534 (class 0 OID 0)
-- Dependencies: 232
-- Name: external_resource_id_resource_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.external_resource_id_resource_seq', 3, true);


--
-- TOC entry 3535 (class 0 OID 0)
-- Dependencies: 226
-- Name: interzone_tariff_id_interzone_tariff_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.interzone_tariff_id_interzone_tariff_seq', 3, true);


--
-- TOC entry 3536 (class 0 OID 0)
-- Dependencies: 228
-- Name: service_id_service_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.service_id_service_seq', 6, true);


--
-- TOC entry 3537 (class 0 OID 0)
-- Dependencies: 214
-- Name: subscriber_id_subscriber_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.subscriber_id_subscriber_seq', 6, true);


--
-- TOC entry 3538 (class 0 OID 0)
-- Dependencies: 218
-- Name: tariff_id_tariff_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.tariff_id_tariff_seq', 15, true);


--
-- TOC entry 3539 (class 0 OID 0)
-- Dependencies: 216
-- Name: zone_id_zone_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.zone_id_zone_seq', 15, true);


--
-- TOC entry 3324 (class 2606 OID 16698)
-- Name: additional_service_connection additional_service_connection_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.additional_service_connection
    ADD CONSTRAINT additional_service_connection_pkey PRIMARY KEY (id);


--
-- TOC entry 3316 (class 2606 OID 16483)
-- Name: balance balance_id_contract_on_tariff_key; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.balance
    ADD CONSTRAINT balance_id_contract_on_tariff_key UNIQUE (id_contract_on_tariff);


--
-- TOC entry 3318 (class 2606 OID 16481)
-- Name: balance balance_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.balance
    ADD CONSTRAINT balance_pkey PRIMARY KEY (id_balance);


--
-- TOC entry 3326 (class 2606 OID 16691)
-- Name: basic_service_connection basic_service_connection_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.basic_service_connection
    ADD CONSTRAINT basic_service_connection_pkey PRIMARY KEY (id);


--
-- TOC entry 3334 (class 2606 OID 16711)
-- Name: call call_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.call
    ADD CONSTRAINT call_pkey PRIMARY KEY (id_call);


--
-- TOC entry 3310 (class 2606 OID 16448)
-- Name: contract_on_number contract_on_number_phone_number_key; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.contract_on_number
    ADD CONSTRAINT contract_on_number_phone_number_key UNIQUE (phone_number);


--
-- TOC entry 3312 (class 2606 OID 16446)
-- Name: contract_on_number contract_on_number_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.contract_on_number
    ADD CONSTRAINT contract_on_number_pkey PRIMARY KEY (id_contract);


--
-- TOC entry 3314 (class 2606 OID 16462)
-- Name: contract_on_tariff contract_on_tariff_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.contract_on_tariff
    ADD CONSTRAINT contract_on_tariff_pkey PRIMARY KEY (id_contract_on_tariff);


--
-- TOC entry 3330 (class 2606 OID 16676)
-- Name: external_resource_connection external_resource_connection_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.external_resource_connection
    ADD CONSTRAINT external_resource_connection_pkey PRIMARY KEY (id);


--
-- TOC entry 3328 (class 2606 OID 16571)
-- Name: external_resource external_resource_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.external_resource
    ADD CONSTRAINT external_resource_pkey PRIMARY KEY (id_resource);


--
-- TOC entry 3320 (class 2606 OID 16497)
-- Name: interzone_tariff interzone_tariff_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.interzone_tariff
    ADD CONSTRAINT interzone_tariff_pkey PRIMARY KEY (id_interzone_tariff);


--
-- TOC entry 3322 (class 2606 OID 16527)
-- Name: service service_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.service
    ADD CONSTRAINT service_pkey PRIMARY KEY (id_service);


--
-- TOC entry 3300 (class 2606 OID 16411)
-- Name: subscriber subscriber_passport_data_key; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.subscriber
    ADD CONSTRAINT subscriber_passport_data_key UNIQUE (passport_data);


--
-- TOC entry 3302 (class 2606 OID 16409)
-- Name: subscriber subscriber_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.subscriber
    ADD CONSTRAINT subscriber_pkey PRIMARY KEY (id_subscriber);


--
-- TOC entry 3308 (class 2606 OID 16432)
-- Name: tariff tariff_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.tariff
    ADD CONSTRAINT tariff_pkey PRIMARY KEY (id_tariff);


--
-- TOC entry 3332 (class 2606 OID 16682)
-- Name: external_resource_connection uq_contract_resource; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.external_resource_connection
    ADD CONSTRAINT uq_contract_resource UNIQUE (id_contract, id_resource);


--
-- TOC entry 3304 (class 2606 OID 16418)
-- Name: zone zone_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.zone
    ADD CONSTRAINT zone_pkey PRIMARY KEY (id_zone);


--
-- TOC entry 3306 (class 2606 OID 16420)
-- Name: zone zone_zone_code_key; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.zone
    ADD CONSTRAINT zone_zone_code_key UNIQUE (zone_code);


--
-- TOC entry 3342 (class 2606 OID 16536)
-- Name: additional_service_connection additional_service_connection_id_contract_on_tariff_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.additional_service_connection
    ADD CONSTRAINT additional_service_connection_id_contract_on_tariff_fkey FOREIGN KEY (id_contract_on_tariff) REFERENCES public.contract_on_tariff(id_contract_on_tariff);


--
-- TOC entry 3343 (class 2606 OID 16541)
-- Name: additional_service_connection additional_service_connection_id_service_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.additional_service_connection
    ADD CONSTRAINT additional_service_connection_id_service_fkey FOREIGN KEY (id_service) REFERENCES public.service(id_service);


--
-- TOC entry 3339 (class 2606 OID 16484)
-- Name: balance balance_id_contract_on_tariff_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.balance
    ADD CONSTRAINT balance_id_contract_on_tariff_fkey FOREIGN KEY (id_contract_on_tariff) REFERENCES public.contract_on_tariff(id_contract_on_tariff);


--
-- TOC entry 3344 (class 2606 OID 16559)
-- Name: basic_service_connection basic_service_connection_id_service_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.basic_service_connection
    ADD CONSTRAINT basic_service_connection_id_service_fkey FOREIGN KEY (id_service) REFERENCES public.service(id_service);


--
-- TOC entry 3345 (class 2606 OID 16554)
-- Name: basic_service_connection basic_service_connection_id_tariff_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.basic_service_connection
    ADD CONSTRAINT basic_service_connection_id_tariff_fkey FOREIGN KEY (id_tariff) REFERENCES public.tariff(id_tariff);


--
-- TOC entry 3348 (class 2606 OID 16722)
-- Name: call call_id_contract_on_tariff_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.call
    ADD CONSTRAINT call_id_contract_on_tariff_fkey FOREIGN KEY (id_contract_on_tariff) REFERENCES public.contract_on_tariff(id_contract_on_tariff);


--
-- TOC entry 3349 (class 2606 OID 16712)
-- Name: call call_receiver_zone_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.call
    ADD CONSTRAINT call_receiver_zone_id_fkey FOREIGN KEY (receiver_zone_id) REFERENCES public.zone(id_zone);


--
-- TOC entry 3350 (class 2606 OID 16717)
-- Name: call call_subscriber_zone_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.call
    ADD CONSTRAINT call_subscriber_zone_id_fkey FOREIGN KEY (subscriber_zone_id) REFERENCES public.zone(id_zone);


--
-- TOC entry 3336 (class 2606 OID 16449)
-- Name: contract_on_number contract_on_number_id_subscriber_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.contract_on_number
    ADD CONSTRAINT contract_on_number_id_subscriber_fkey FOREIGN KEY (id_subscriber) REFERENCES public.subscriber(id_subscriber);


--
-- TOC entry 3337 (class 2606 OID 16468)
-- Name: contract_on_tariff contract_on_tariff_id_contract_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.contract_on_tariff
    ADD CONSTRAINT contract_on_tariff_id_contract_fkey FOREIGN KEY (id_contract) REFERENCES public.contract_on_number(id_contract);


--
-- TOC entry 3338 (class 2606 OID 16463)
-- Name: contract_on_tariff contract_on_tariff_id_tariff_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.contract_on_tariff
    ADD CONSTRAINT contract_on_tariff_id_tariff_fkey FOREIGN KEY (id_tariff) REFERENCES public.tariff(id_tariff);


--
-- TOC entry 3346 (class 2606 OID 16579)
-- Name: external_resource_connection external_resource_connection_id_contract_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.external_resource_connection
    ADD CONSTRAINT external_resource_connection_id_contract_fkey FOREIGN KEY (id_contract) REFERENCES public.contract_on_number(id_contract);


--
-- TOC entry 3347 (class 2606 OID 16584)
-- Name: external_resource_connection external_resource_connection_id_resource_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.external_resource_connection
    ADD CONSTRAINT external_resource_connection_id_resource_fkey FOREIGN KEY (id_resource) REFERENCES public.external_resource(id_resource);


--
-- TOC entry 3340 (class 2606 OID 16503)
-- Name: interzone_tariff interzone_tariff_receiver_zone_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.interzone_tariff
    ADD CONSTRAINT interzone_tariff_receiver_zone_id_fkey FOREIGN KEY (receiver_zone_id) REFERENCES public.zone(id_zone);


--
-- TOC entry 3341 (class 2606 OID 16498)
-- Name: interzone_tariff interzone_tariff_sender_zone_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.interzone_tariff
    ADD CONSTRAINT interzone_tariff_sender_zone_id_fkey FOREIGN KEY (sender_zone_id) REFERENCES public.zone(id_zone);


--
-- TOC entry 3335 (class 2606 OID 16433)
-- Name: tariff tariff_id_zone_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.tariff
    ADD CONSTRAINT tariff_id_zone_fkey FOREIGN KEY (id_zone) REFERENCES public.zone(id_zone);


-- Completed on 2025-04-03 11:24:46 UTC

--
-- PostgreSQL database dump complete
--

