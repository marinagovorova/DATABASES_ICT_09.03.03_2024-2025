--
-- PostgreSQL database dump
--

-- Dumped from database version 15.12
-- Dumped by pg_dump version 15.12

-- Started on 2025-06-15 16:20:15

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

--
-- TOC entry 3431 (class 1262 OID 24590)
-- Name: refill; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE refill WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'ru-RU';


ALTER DATABASE refill OWNER TO postgres;

\connect refill

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

--
-- TOC entry 3432 (class 0 OID 0)
-- Dependencies: 5
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: pg_database_owner
--

COMMENT ON SCHEMA public IS '';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 221 (class 1259 OID 24676)
-- Name: client_cards; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_cards (
    id_card integer NOT NULL,
    id_company integer NOT NULL,
    id_client integer NOT NULL,
    start_date date NOT NULL,
    end_date date,
    balance integer NOT NULL,
    discount_percent integer DEFAULT 0 NOT NULL,
    discount_rub integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.client_cards OWNER TO postgres;

--
-- TOC entry 3433 (class 0 OID 0)
-- Dependencies: 221
-- Name: COLUMN client_cards.end_date; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.client_cards.end_date IS 'несли NULL то неограниченно';


--
-- TOC entry 223 (class 1259 OID 24713)
-- Name: client_cards_id_card_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.client_cards ALTER COLUMN id_card ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.client_cards_id_card_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 214 (class 1259 OID 24592)
-- Name: clients; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.clients (
    id_client integer NOT NULL,
    surname character varying(40),
    name character varying(40),
    patronymic character varying(40),
    phone_number bigint NOT NULL,
    address character varying(100) NOT NULL
);


ALTER TABLE public.clients OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 24735)
-- Name: clients_id_client_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.clients ALTER COLUMN id_client ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.clients_id_client_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 216 (class 1259 OID 24602)
-- Name: companies; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.companies (
    id_company integer NOT NULL,
    type_company integer NOT NULL,
    legal_address character varying(100) NOT NULL,
    company_title character varying(100) NOT NULL
);


ALTER TABLE public.companies OWNER TO postgres;

--
-- TOC entry 3434 (class 0 OID 0)
-- Dependencies: 216
-- Name: COLUMN companies.type_company; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.companies.type_company IS '0 - фирма-владелец автозаправки
1 - фирма-производитель топлива';


--
-- TOC entry 228 (class 1259 OID 24726)
-- Name: companies_id_company_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.companies ALTER COLUMN id_company ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.companies_id_company_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 220 (class 1259 OID 24666)
-- Name: fuel_prices; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fuel_prices (
    id_fuel_price integer NOT NULL,
    id_sold_fuel integer NOT NULL,
    start_time timestamp without time zone NOT NULL,
    end_time timestamp without time zone,
    per_liter integer NOT NULL
);


ALTER TABLE public.fuel_prices OWNER TO postgres;

--
-- TOC entry 3435 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN fuel_prices.end_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.fuel_prices.end_time IS 'Если не зада то считаем период неограниченным';


--
-- TOC entry 226 (class 1259 OID 24722)
-- Name: fuel_prices_id_fuel_price_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.fuel_prices ALTER COLUMN id_fuel_price ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.fuel_prices_id_fuel_price_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 215 (class 1259 OID 24597)
-- Name: fuel_reference; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fuel_reference (
    id_kind_fuel integer NOT NULL,
    title character varying(40) NOT NULL,
    burning_temp integer,
    brand character varying(40),
    density integer,
    season integer,
    percent_sulfur integer,
    min_usage_temp integer,
    CONSTRAINT fuel_reference_burning_temp_check CHECK ((burning_temp >= 100)),
    CONSTRAINT fuel_reference_density_check CHECK ((density > 0)),
    CONSTRAINT fuel_reference_percent_sulfur_check CHECK (((percent_sulfur >= 0) AND (percent_sulfur <= 100))),
    CONSTRAINT fuel_reference_season_check CHECK (((season >= 0) AND (season <= 3)))
);


ALTER TABLE public.fuel_reference OWNER TO postgres;

--
-- TOC entry 3436 (class 0 OID 0)
-- Dependencies: 215
-- Name: COLUMN fuel_reference.density; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.fuel_reference.density IS 'кг/м³';


--
-- TOC entry 3437 (class 0 OID 0)
-- Dependencies: 215
-- Name: COLUMN fuel_reference.season; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.fuel_reference.season IS '0 - летние
1 - межсезонное
2 - зимнее
3 - арктическое';


--
-- TOC entry 224 (class 1259 OID 24714)
-- Name: fuel_reference_id_kind_fuel_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.fuel_reference ALTER COLUMN id_kind_fuel ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.fuel_reference_id_kind_fuel_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 218 (class 1259 OID 24629)
-- Name: gas_station; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.gas_station (
    id_station integer NOT NULL,
    id_company integer NOT NULL,
    station_address character varying(100)
);


ALTER TABLE public.gas_station OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 24728)
-- Name: gas_station_id_station_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.gas_station ALTER COLUMN id_station ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.gas_station_id_station_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 217 (class 1259 OID 24607)
-- Name: produced_fuel; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.produced_fuel (
    id_produced_fuel integer NOT NULL,
    id_kind_fuel integer NOT NULL,
    id_company integer NOT NULL
);


ALTER TABLE public.produced_fuel OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 24721)
-- Name: produced_fuel_id_produced_fuel_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.produced_fuel ALTER COLUMN id_produced_fuel ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.produced_fuel_id_produced_fuel_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 222 (class 1259 OID 24691)
-- Name: sales; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sales (
    id_fuel_price integer NOT NULL,
    id_card integer NOT NULL,
    sale_date timestamp without time zone NOT NULL,
    sold_liters_volume integer NOT NULL,
    id_sale bigint NOT NULL
);


ALTER TABLE public.sales OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 24750)
-- Name: sales_id_sale_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.sales ALTER COLUMN id_sale ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.sales_id_sale_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 219 (class 1259 OID 24651)
-- Name: sold_fuel; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sold_fuel (
    id_sold_fuel integer NOT NULL,
    id_produced_fuel integer NOT NULL,
    id_station integer NOT NULL
);


ALTER TABLE public.sold_fuel OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 24723)
-- Name: sold_fuel_id_sold_fuel_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.sold_fuel ALTER COLUMN id_sold_fuel ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.sold_fuel_id_sold_fuel_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 3415 (class 0 OID 24676)
-- Dependencies: 221
-- Data for Name: client_cards; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.client_cards OVERRIDING SYSTEM VALUE VALUES (1, 8, 1, '2023-01-01', '2024-01-01', 1000, 5, 50);
INSERT INTO public.client_cards OVERRIDING SYSTEM VALUE VALUES (2, 9, 2, '2023-02-01', '2024-02-01', 2000, 10, 100);
INSERT INTO public.client_cards OVERRIDING SYSTEM VALUE VALUES (3, 10, 3, '2023-03-01', NULL, -5000, 15, 150);
INSERT INTO public.client_cards OVERRIDING SYSTEM VALUE VALUES (4, 8, 1, '2023-01-01', '2024-01-01', 0, 0, 0);


--
-- TOC entry 3408 (class 0 OID 24592)
-- Dependencies: 214
-- Data for Name: clients; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.clients OVERRIDING SYSTEM VALUE VALUES (1, 'Иванов', 'Иван', 'Иванович', 89001234567, 'Москва');
INSERT INTO public.clients OVERRIDING SYSTEM VALUE VALUES (2, 'Петров', 'Петр', 'Петрович', 89007654321, 'Санкт-Петербург');
INSERT INTO public.clients OVERRIDING SYSTEM VALUE VALUES (3, 'Сидоров', 'Сидор', 'Сидорович', 89009876543, 'Екатеринбург');


--
-- TOC entry 3410 (class 0 OID 24602)
-- Dependencies: 216
-- Data for Name: companies; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.companies OVERRIDING SYSTEM VALUE VALUES (8, 0, 'Москва, ул. Ленина, д. 1', 'x213');
INSERT INTO public.companies OVERRIDING SYSTEM VALUE VALUES (9, 1, 'Санкт-Петербург, пр. Невский, д. 15', 'Х*й 5G');
INSERT INTO public.companies OVERRIDING SYSTEM VALUE VALUES (10, 0, 'Екатеринбург, ул. Мира, д. 25', 'LOL');


--
-- TOC entry 3414 (class 0 OID 24666)
-- Dependencies: 220
-- Data for Name: fuel_prices; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.fuel_prices OVERRIDING SYSTEM VALUE VALUES (1, 5, '2023-01-01 00:00:00', '2023-01-31 23:59:59', 50);
INSERT INTO public.fuel_prices OVERRIDING SYSTEM VALUE VALUES (2, 6, '2023-02-01 00:00:00', '2023-02-28 23:59:59', 55);
INSERT INTO public.fuel_prices OVERRIDING SYSTEM VALUE VALUES (3, 7, '2023-03-01 00:00:00', '2023-03-31 23:59:59', 60);
INSERT INTO public.fuel_prices OVERRIDING SYSTEM VALUE VALUES (4, 8, '2023-04-01 00:00:00', '2023-04-30 23:59:59', 65);
INSERT INTO public.fuel_prices OVERRIDING SYSTEM VALUE VALUES (5, 7, '2023-04-01 00:00:00', NULL, 1000);


--
-- TOC entry 3409 (class 0 OID 24597)
-- Dependencies: 215
-- Data for Name: fuel_reference; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.fuel_reference OVERRIDING SYSTEM VALUE VALUES (16, 'АИ-92', 400, 'Газпром', 720, 0, 0, -40);
INSERT INTO public.fuel_reference OVERRIDING SYSTEM VALUE VALUES (17, 'АИ-95', 450, 'Лукойл', 740, 1, 0, -30);
INSERT INTO public.fuel_reference OVERRIDING SYSTEM VALUE VALUES (18, 'Дизель', 500, 'Роснефть', 850, 2, 0, -50);
INSERT INTO public.fuel_reference OVERRIDING SYSTEM VALUE VALUES (19, 'Керосин', 300, 'Татнефть', 780, 3, 5, -60);


--
-- TOC entry 3412 (class 0 OID 24629)
-- Dependencies: 218
-- Data for Name: gas_station; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.gas_station OVERRIDING SYSTEM VALUE VALUES (7, 8, 'Москва, ул. Тверская');
INSERT INTO public.gas_station OVERRIDING SYSTEM VALUE VALUES (8, 9, 'Санкт-Петербург, ул. Восстания');
INSERT INTO public.gas_station OVERRIDING SYSTEM VALUE VALUES (9, 10, 'Екатеринбург, ул. Свердлова');


--
-- TOC entry 3411 (class 0 OID 24607)
-- Dependencies: 217
-- Data for Name: produced_fuel; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.produced_fuel OVERRIDING SYSTEM VALUE VALUES (13, 16, 8);
INSERT INTO public.produced_fuel OVERRIDING SYSTEM VALUE VALUES (14, 17, 9);
INSERT INTO public.produced_fuel OVERRIDING SYSTEM VALUE VALUES (15, 18, 10);
INSERT INTO public.produced_fuel OVERRIDING SYSTEM VALUE VALUES (16, 19, 8);


--
-- TOC entry 3416 (class 0 OID 24691)
-- Dependencies: 222
-- Data for Name: sales; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.sales OVERRIDING SYSTEM VALUE VALUES (1, 1, '2023-01-10 12:00:00', 10, 4);
INSERT INTO public.sales OVERRIDING SYSTEM VALUE VALUES (2, 2, '2023-02-15 14:30:00', 20, 5);
INSERT INTO public.sales OVERRIDING SYSTEM VALUE VALUES (5, 3, '2023-04-20 16:45:00', 1, 6);


--
-- TOC entry 3413 (class 0 OID 24651)
-- Dependencies: 219
-- Data for Name: sold_fuel; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.sold_fuel OVERRIDING SYSTEM VALUE VALUES (5, 13, 7);
INSERT INTO public.sold_fuel OVERRIDING SYSTEM VALUE VALUES (6, 14, 8);
INSERT INTO public.sold_fuel OVERRIDING SYSTEM VALUE VALUES (7, 15, 9);
INSERT INTO public.sold_fuel OVERRIDING SYSTEM VALUE VALUES (8, 16, 7);


--
-- TOC entry 3438 (class 0 OID 0)
-- Dependencies: 223
-- Name: client_cards_id_card_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.client_cards_id_card_seq', 4, true);


--
-- TOC entry 3439 (class 0 OID 0)
-- Dependencies: 230
-- Name: clients_id_client_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.clients_id_client_seq', 9, true);


--
-- TOC entry 3440 (class 0 OID 0)
-- Dependencies: 228
-- Name: companies_id_company_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.companies_id_company_seq', 10, true);


--
-- TOC entry 3441 (class 0 OID 0)
-- Dependencies: 226
-- Name: fuel_prices_id_fuel_price_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.fuel_prices_id_fuel_price_seq', 6, true);


--
-- TOC entry 3442 (class 0 OID 0)
-- Dependencies: 224
-- Name: fuel_reference_id_kind_fuel_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.fuel_reference_id_kind_fuel_seq', 19, true);


--
-- TOC entry 3443 (class 0 OID 0)
-- Dependencies: 229
-- Name: gas_station_id_station_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.gas_station_id_station_seq', 9, true);


--
-- TOC entry 3444 (class 0 OID 0)
-- Dependencies: 225
-- Name: produced_fuel_id_produced_fuel_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.produced_fuel_id_produced_fuel_seq', 16, true);


--
-- TOC entry 3445 (class 0 OID 0)
-- Dependencies: 231
-- Name: sales_id_sale_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sales_id_sale_seq', 6, true);


--
-- TOC entry 3446 (class 0 OID 0)
-- Dependencies: 227
-- Name: sold_fuel_id_sold_fuel_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sold_fuel_id_sold_fuel_seq', 8, true);


--
-- TOC entry 3228 (class 2606 OID 24732)
-- Name: client_cards client_cards_check; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.client_cards
    ADD CONSTRAINT client_cards_check CHECK (((end_date IS NULL) OR (end_date > start_date))) NOT VALID;


--
-- TOC entry 3229 (class 2606 OID 24733)
-- Name: client_cards client_cards_discount_percent_check; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.client_cards
    ADD CONSTRAINT client_cards_discount_percent_check CHECK (((discount_percent >= 0) AND (discount_percent <= 100))) NOT VALID;


--
-- TOC entry 3230 (class 2606 OID 24734)
-- Name: client_cards client_cards_discount_rub_check; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.client_cards
    ADD CONSTRAINT client_cards_discount_rub_check CHECK ((discount_rub >= 0)) NOT VALID;


--
-- TOC entry 3253 (class 2606 OID 24680)
-- Name: client_cards client_cards_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_cards
    ADD CONSTRAINT client_cards_pkey PRIMARY KEY (id_card);


--
-- TOC entry 3215 (class 2606 OID 24741)
-- Name: clients clients_name_check; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.clients
    ADD CONSTRAINT clients_name_check CHECK (((name)::text !~~ '%[^A-ZА-Я]%'::text)) NOT VALID;


--
-- TOC entry 3216 (class 2606 OID 24743)
-- Name: clients clients_patronymic_check; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.clients
    ADD CONSTRAINT clients_patronymic_check CHECK (((patronymic)::text !~~ '%[^A-ZА-Я]%'::text)) NOT VALID;


--
-- TOC entry 3217 (class 2606 OID 24745)
-- Name: clients clients_phone_number_check; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.clients
    ADD CONSTRAINT clients_phone_number_check CHECK ((phone_number > 0)) NOT VALID;


--
-- TOC entry 3233 (class 2606 OID 24757)
-- Name: clients clients_phone_number_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clients
    ADD CONSTRAINT clients_phone_number_key UNIQUE (phone_number);


--
-- TOC entry 3235 (class 2606 OID 24596)
-- Name: clients clients_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clients
    ADD CONSTRAINT clients_pkey PRIMARY KEY (id_client);


--
-- TOC entry 3218 (class 2606 OID 24742)
-- Name: clients clients_surname_check; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.clients
    ADD CONSTRAINT clients_surname_check CHECK (((surname)::text !~~ '%[^A-ZА-Я]%'::text)) NOT VALID;


--
-- TOC entry 3239 (class 2606 OID 24606)
-- Name: companies companies_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.companies
    ADD CONSTRAINT companies_pkey PRIMARY KEY (id_company);


--
-- TOC entry 3225 (class 2606 OID 24727)
-- Name: companies companies_type_company_check; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.companies
    ADD CONSTRAINT companies_type_company_check CHECK (((type_company >= 0) AND (type_company <= 1))) NOT VALID;


--
-- TOC entry 3226 (class 2606 OID 24724)
-- Name: fuel_prices fuel_prices_check; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.fuel_prices
    ADD CONSTRAINT fuel_prices_check CHECK (((end_time IS NULL) OR (end_time > start_time))) NOT VALID;


--
-- TOC entry 3227 (class 2606 OID 24725)
-- Name: fuel_prices fuel_prices_per_liter_check; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.fuel_prices
    ADD CONSTRAINT fuel_prices_per_liter_check CHECK ((per_liter > 0)) NOT VALID;


--
-- TOC entry 3251 (class 2606 OID 24670)
-- Name: fuel_prices fuel_prices_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fuel_prices
    ADD CONSTRAINT fuel_prices_pkey PRIMARY KEY (id_fuel_price);


--
-- TOC entry 3221 (class 2606 OID 24740)
-- Name: fuel_reference fuel_reference_grade_check; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.fuel_reference
    ADD CONSTRAINT fuel_reference_grade_check CHECK (((brand)::text !~~ '%[^A-ZА-Я-]%'::text)) NOT VALID;


--
-- TOC entry 3222 (class 2606 OID 24744)
-- Name: fuel_reference fuel_reference_min_usage_temp_check; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.fuel_reference
    ADD CONSTRAINT fuel_reference_min_usage_temp_check CHECK (((min_usage_temp >= '-255'::integer) AND (min_usage_temp < 100))) NOT VALID;


--
-- TOC entry 3237 (class 2606 OID 24601)
-- Name: fuel_reference fuel_reference_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fuel_reference
    ADD CONSTRAINT fuel_reference_pkey PRIMARY KEY (id_kind_fuel);


--
-- TOC entry 3247 (class 2606 OID 24633)
-- Name: gas_station gas_station_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gas_station
    ADD CONSTRAINT gas_station_pkey PRIMARY KEY (id_station);


--
-- TOC entry 3245 (class 2606 OID 24611)
-- Name: produced_fuel produced_fuel_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produced_fuel
    ADD CONSTRAINT produced_fuel_pkey PRIMARY KEY (id_produced_fuel);


--
-- TOC entry 3255 (class 2606 OID 24755)
-- Name: sales sales_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sales
    ADD CONSTRAINT sales_pkey PRIMARY KEY (id_sale);


--
-- TOC entry 3231 (class 2606 OID 24729)
-- Name: sales sales_sold_liters_volume_check; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.sales
    ADD CONSTRAINT sales_sold_liters_volume_check CHECK ((sold_liters_volume > 0)) NOT VALID;


--
-- TOC entry 3249 (class 2606 OID 24655)
-- Name: sold_fuel sold_fuel_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sold_fuel
    ADD CONSTRAINT sold_fuel_pkey PRIMARY KEY (id_sold_fuel);


--
-- TOC entry 3240 (class 1259 OID 24617)
-- Name: fki_i; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_i ON public.produced_fuel USING btree (id_company);


--
-- TOC entry 3241 (class 1259 OID 24644)
-- Name: fki_id_company_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_id_company_fkey ON public.produced_fuel USING btree (id_company);


--
-- TOC entry 3242 (class 1259 OID 24623)
-- Name: fki_id_kind_fuel; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_id_kind_fuel ON public.produced_fuel USING btree (id_kind_fuel);


--
-- TOC entry 3243 (class 1259 OID 24650)
-- Name: fki_id_kind_fuel_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_id_kind_fuel_fkey ON public.produced_fuel USING btree (id_kind_fuel);


--
-- TOC entry 3262 (class 2606 OID 24686)
-- Name: client_cards client_cards_id_client_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_cards
    ADD CONSTRAINT client_cards_id_client_fkey FOREIGN KEY (id_client) REFERENCES public.clients(id_client);


--
-- TOC entry 3263 (class 2606 OID 24681)
-- Name: client_cards client_cards_id_company_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_cards
    ADD CONSTRAINT client_cards_id_company_fkey FOREIGN KEY (id_company) REFERENCES public.companies(id_company);


--
-- TOC entry 3261 (class 2606 OID 24671)
-- Name: fuel_prices fuel_prices_id_sold_fuel_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fuel_prices
    ADD CONSTRAINT fuel_prices_id_sold_fuel_fkey FOREIGN KEY (id_sold_fuel) REFERENCES public.sold_fuel(id_sold_fuel);


--
-- TOC entry 3258 (class 2606 OID 24634)
-- Name: gas_station gas_station_id_company_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gas_station
    ADD CONSTRAINT gas_station_id_company_fkey FOREIGN KEY (id_company) REFERENCES public.companies(id_company);


--
-- TOC entry 3256 (class 2606 OID 24639)
-- Name: produced_fuel id_company_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produced_fuel
    ADD CONSTRAINT id_company_fkey FOREIGN KEY (id_company) REFERENCES public.companies(id_company) ON DELETE CASCADE;


--
-- TOC entry 3257 (class 2606 OID 24645)
-- Name: produced_fuel id_kind_fuel_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produced_fuel
    ADD CONSTRAINT id_kind_fuel_fkey FOREIGN KEY (id_kind_fuel) REFERENCES public.fuel_reference(id_kind_fuel);


--
-- TOC entry 3264 (class 2606 OID 24701)
-- Name: sales sales_id_card_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sales
    ADD CONSTRAINT sales_id_card_fkey FOREIGN KEY (id_card) REFERENCES public.client_cards(id_card);


--
-- TOC entry 3265 (class 2606 OID 24696)
-- Name: sales sales_id_fuel_price_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sales
    ADD CONSTRAINT sales_id_fuel_price_fkey FOREIGN KEY (id_fuel_price) REFERENCES public.fuel_prices(id_fuel_price);


--
-- TOC entry 3259 (class 2606 OID 24656)
-- Name: sold_fuel sold_fuel_id_produced_fuel_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sold_fuel
    ADD CONSTRAINT sold_fuel_id_produced_fuel_fkey FOREIGN KEY (id_produced_fuel) REFERENCES public.produced_fuel(id_produced_fuel);


--
-- TOC entry 3260 (class 2606 OID 24661)
-- Name: sold_fuel sold_fuel_id_station_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sold_fuel
    ADD CONSTRAINT sold_fuel_id_station_fkey FOREIGN KEY (id_station) REFERENCES public.gas_station(id_station);


-- Completed on 2025-06-15 16:20:15

--
-- PostgreSQL database dump complete
--

