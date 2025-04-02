--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4
-- Dumped by pg_dump version 17.4

-- Started on 2025-04-02 15:59:40 MSK

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

DROP DATABASE IF EXISTS bank;
--
-- TOC entry 3723 (class 1262 OID 16388)
-- Name: bank; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE bank WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'C';


ALTER DATABASE bank OWNER TO postgres;

\connect bank

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
-- Name: bank_schema; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA bank_schema;


ALTER SCHEMA bank_schema OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 219 (class 1259 OID 16395)
-- Name: валюта; Type: TABLE; Schema: bank_schema; Owner: postgres
--

CREATE TABLE bank_schema."валюта" (
    "код_валюты" character(3) NOT NULL,
    "наименование" character(50) NOT NULL,
    "страна" character(50) NOT NULL
);


ALTER TABLE bank_schema."валюта" OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 16538)
-- Name: вид_вклада; Type: TABLE; Schema: bank_schema; Owner: postgres
--

CREATE TABLE bank_schema."вид_вклада" (
    "id_вида_вклада" integer NOT NULL,
    "наименование" character(50),
    "описание" text,
    "минимальная_сумма" numeric(10,2) NOT NULL,
    "максимальный_срок" integer NOT NULL,
    "процентная_ставка" numeric(5,2) NOT NULL
);


ALTER TABLE bank_schema."вид_вклада" OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16400)
-- Name: вид_кредита; Type: TABLE; Schema: bank_schema; Owner: postgres
--

CREATE TABLE bank_schema."вид_кредита" (
    "id_вида_кредита" integer NOT NULL,
    "наименование" character(50),
    "описание" text,
    "срок" integer NOT NULL,
    "процентная_ставка" numeric(5,2) NOT NULL
);


ALTER TABLE bank_schema."вид_кредита" OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 16454)
-- Name: график_выплат; Type: TABLE; Schema: bank_schema; Owner: postgres
--

CREATE TABLE bank_schema."график_выплат" (
    "id_платежа" integer NOT NULL,
    "id_договора" integer NOT NULL,
    "дата_назначенной_выплаты" date,
    "дата_фактической_выплаты" date NOT NULL,
    "сумма_процентов" numeric(10,2) NOT NULL,
    "сумма_основного_долга" numeric(10,2) NOT NULL,
    "статус_оплаты" boolean NOT NULL
);


ALTER TABLE bank_schema."график_выплат" OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16461)
-- Name: договор_вклада; Type: TABLE; Schema: bank_schema; Owner: postgres
--

CREATE TABLE bank_schema."договор_вклада" (
    "id_договора_вклада" integer NOT NULL,
    "id_вида_вклада" integer,
    "id_сотрудника" integer,
    "id_клиента" integer,
    "код_валюты" character(3),
    "дата_вклада" date,
    "дата_возврата" date,
    "сумма" numeric(10,2)
);


ALTER TABLE bank_schema."договор_вклада" OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16390)
-- Name: договор_кредита; Type: TABLE; Schema: bank_schema; Owner: postgres
--

CREATE TABLE bank_schema."договор_кредита" (
    "id_договора_кредита" integer NOT NULL,
    "id_сотрудника" integer NOT NULL,
    "id_клиента" integer NOT NULL,
    "код_валюты" character(3) NOT NULL,
    "дата_выдачи" date NOT NULL,
    "дата_погашения" date NOT NULL,
    "сумма" numeric(10,2) NOT NULL,
    "процентная_ставка" numeric(5,2) NOT NULL,
    "число_платежа" integer NOT NULL,
    "id_вида_кредита" integer NOT NULL
);


ALTER TABLE bank_schema."договор_кредита" OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16412)
-- Name: должность; Type: TABLE; Schema: bank_schema; Owner: postgres
--

CREATE TABLE bank_schema."должность" (
    "id_должности" integer NOT NULL,
    "наименование" character(50),
    "количество_ставок" integer NOT NULL,
    "оклад" numeric(10,2) NOT NULL
);


ALTER TABLE bank_schema."должность" OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16407)
-- Name: клиент; Type: TABLE; Schema: bank_schema; Owner: postgres
--

CREATE TABLE bank_schema."клиент" (
    "id_клиента" integer NOT NULL,
    "фио" character(50) NOT NULL,
    "адрес" character varying(200),
    "номер_телефона" character(12) NOT NULL,
    email character varying(100),
    "паспортные_данные" character(10) NOT NULL
);


ALTER TABLE bank_schema."клиент" OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 16585)
-- Name: начисления_по_вкладу; Type: TABLE; Schema: bank_schema; Owner: postgres
--

CREATE TABLE bank_schema."начисления_по_вкладу" (
    "id_начисления" integer NOT NULL,
    "id_договора_вклада" integer NOT NULL,
    "дата_начисления" date NOT NULL,
    "сумма_начисления" numeric(10,2) NOT NULL,
    "процентная_ставка" numeric(5,2) NOT NULL
);


ALTER TABLE bank_schema."начисления_по_вкладу" OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16439)
-- Name: сотрудник; Type: TABLE; Schema: bank_schema; Owner: postgres
--

CREATE TABLE bank_schema."сотрудник" (
    "id_сотрудника" integer NOT NULL,
    "id_должности" integer NOT NULL,
    "фио" character(50),
    "адрес" character varying(200),
    "номер_телефона" character(12),
    email character varying(100),
    "паспортные_данные" character(10) NOT NULL,
    "оклад" numeric(10,2) NOT NULL,
    "возраст" integer
);


ALTER TABLE bank_schema."сотрудник" OWNER TO postgres;

--
-- TOC entry 3709 (class 0 OID 16395)
-- Dependencies: 219
-- Data for Name: валюта; Type: TABLE DATA; Schema: bank_schema; Owner: postgres
--

COPY bank_schema."валюта" ("код_валюты", "наименование", "страна") FROM stdin;
RUB	Российский рубль                                  	Россия                                            
USD	Доллар США                                        	США                                               
EUR	Евро                                              	Европейский союз                                  
CNY	Китайский юань                                    	Китай                                             
GBP	Фунт стерлингов                                   	Великобритания                                    
\.


--
-- TOC entry 3716 (class 0 OID 16538)
-- Dependencies: 226
-- Data for Name: вид_вклада; Type: TABLE DATA; Schema: bank_schema; Owner: postgres
--

COPY bank_schema."вид_вклада" ("id_вида_вклада", "наименование", "описание", "минимальная_сумма", "максимальный_срок", "процентная_ставка") FROM stdin;
1	Накопительный                                     	Вклад с возможностью пополнения и снятия средств	10000.00	36	5.50
2	Срочный                                           	Вклад с фиксированным сроком и повышенной ставкой	50000.00	24	7.20
3	Пенсионный                                        	Специальный вклад для пенсионеров с льготными условиями	1000.00	60	6.80
4	Детский                                           	Долгосрочный вклад на имя ребенка с возможностью пополнения	5000.00	120	6.00
5	Металлический                                     	Вклад в драгоценных металлах с защитой от инфляции	30000.00	36	4.50
\.


--
-- TOC entry 3710 (class 0 OID 16400)
-- Dependencies: 220
-- Data for Name: вид_кредита; Type: TABLE DATA; Schema: bank_schema; Owner: postgres
--

COPY bank_schema."вид_кредита" ("id_вида_кредита", "наименование", "описание", "срок", "процентная_ставка") FROM stdin;
1	Потребительский кредит                            	Кредит на любые цели без обеспечения	36	12.50
2	Ипотечный кредит                                  	Долгосрочный кредит на покупку недвижимости	240	8.75
3	Автокредит                                        	Кредит на покупку автомобиля	60	9.25
4	Кредитная карта                                   	Возобновляемая кредитная линия с льготным периодом	12	23.90
5	Экспресс-кредит                                   	Быстрый кредит наличными с минимальным пакетом документов	12	15.00
\.


--
-- TOC entry 3714 (class 0 OID 16454)
-- Dependencies: 224
-- Data for Name: график_выплат; Type: TABLE DATA; Schema: bank_schema; Owner: postgres
--

COPY bank_schema."график_выплат" ("id_платежа", "id_договора", "дата_назначенной_выплаты", "дата_фактической_выплаты", "сумма_процентов", "сумма_основного_долга", "статус_оплаты") FROM stdin;
1	1	2025-02-15	2025-02-15	5208.33	13888.89	t
2	1	2025-03-15	2025-03-15	5069.44	13888.89	f
3	2	2024-07-01	2024-07-01	21875.00	12500.00	t
4	2	2024-08-01	2024-08-01	21831.60	12500.00	t
5	3	2025-04-10	2025-04-15	11562.50	25000.00	f
\.


--
-- TOC entry 3715 (class 0 OID 16461)
-- Dependencies: 225
-- Data for Name: договор_вклада; Type: TABLE DATA; Schema: bank_schema; Owner: postgres
--

COPY bank_schema."договор_вклада" ("id_договора_вклада", "id_вида_вклада", "id_сотрудника", "id_клиента", "код_валюты", "дата_вклада", "дата_возврата", "сумма") FROM stdin;
1	2	4	1	RUB	2025-01-10	2028-01-10	200000.00
2	2	4	2	RUB	2025-02-15	2026-02-15	500000.00
3	3	4	3	RUB	2025-03-01	\N	100000.00
4	5	4	4	USD	2025-01-20	2027-01-20	10000.00
5	1	4	5	RUB	2025-02-01	\N	50000.00
\.


--
-- TOC entry 3708 (class 0 OID 16390)
-- Dependencies: 218
-- Data for Name: договор_кредита; Type: TABLE DATA; Schema: bank_schema; Owner: postgres
--

COPY bank_schema."договор_кредита" ("id_договора_кредита", "id_сотрудника", "id_клиента", "код_валюты", "дата_выдачи", "дата_погашения", "сумма", "процентная_ставка", "число_платежа", "id_вида_кредита") FROM stdin;
1	2	1	RUB	2025-01-15	2027-01-15	500000.00	12.50	36	2
2	2	2	RUB	2024-06-01	2044-06-01	3000000.00	8.75	240	1
3	2	3	RUB	2025-03-10	2030-03-10	1500000.00	9.25	60	1
4	2	4	RUB	2025-02-20	2026-02-20	100000.00	23.90	12	4
5	2	5	RUB	2025-01-05	2026-01-05	200000.00	15.00	12	3
\.


--
-- TOC entry 3712 (class 0 OID 16412)
-- Dependencies: 222
-- Data for Name: должность; Type: TABLE DATA; Schema: bank_schema; Owner: postgres
--

COPY bank_schema."должность" ("id_должности", "наименование", "количество_ставок", "оклад") FROM stdin;
1	Директор филиала                                  	1	150000.00
2	Кредитный специалист                              	1	80000.00
3	Операционист                                      	1	60000.00
4	Менеджер по вкладам                               	1	70000.00
5	Главный бухгалтер                                 	1	120000.00
\.


--
-- TOC entry 3711 (class 0 OID 16407)
-- Dependencies: 221
-- Data for Name: клиент; Type: TABLE DATA; Schema: bank_schema; Owner: postgres
--

COPY bank_schema."клиент" ("id_клиента", "фио", "адрес", "номер_телефона", email, "паспортные_данные") FROM stdin;
1	Алексеев Михаил Юрьевич                           	г. Москва, ул. Тверская, д.25	+79031234567	alekseev@mail.ru	6789012345
2	Борисова Ольга Игоревна                           	г. Москва, ул. Арбат, д.30	+79041234567	borisova@mail.ru	7890123456
3	Васильев Андрей Николаевич                        	г. Москва, ул. Новый Арбат, д.12	+79051234567	vasiliev@mail.ru	8901234567
4	Григорьева Татьяна Викторовна                     	г. Москва, ул. Садовая, д.8	+79061234567	grigorieva@mail.ru	9012345678
5	Дмитриев Сергей Александрович                     	г. Москва, ул. Ленинградская, д.40	+79071234567	dmitriev@mail.ru	0123456789
\.


--
-- TOC entry 3717 (class 0 OID 16585)
-- Dependencies: 227
-- Data for Name: начисления_по_вкладу; Type: TABLE DATA; Schema: bank_schema; Owner: postgres
--

COPY bank_schema."начисления_по_вкладу" ("id_начисления", "id_договора_вклада", "дата_начисления", "сумма_начисления", "процентная_ставка") FROM stdin;
1	1	2023-01-31	1250.50	5.50
2	1	2023-02-28	1268.75	5.50
3	2	2023-01-31	3200.00	7.20
4	5	2023-01-31	850.25	6.80
5	3	2023-02-28	456.25	6.00
\.


--
-- TOC entry 3713 (class 0 OID 16439)
-- Dependencies: 223
-- Data for Name: сотрудник; Type: TABLE DATA; Schema: bank_schema; Owner: postgres
--

COPY bank_schema."сотрудник" ("id_сотрудника", "id_должности", "фио", "адрес", "номер_телефона", email, "паспортные_данные", "оклад", "возраст") FROM stdin;
1	1	Иванов Иван Иванович                              	г. Москва, ул. Ленина, д.1	+79101234567	ivanov@bank.ru	1234567890	500000.00	42
2	1	Петрова Анна Сергеевна                            	г. Москва, ул. Пушкина, д.10	+79111234567	petrova@bank.ru	2345678901	300000.00	35
3	2	Сидоров Алексей Петрович                          	г. Москва, пр. Мира, д.5	+79121234567	sidorov@bank.ru	3456789012	200000.00	28
4	5	Кузнецова Елена Владимировна                      	г. Москва, ул. Гагарина, д.15	+79131234567	kuznetsova@bank.ru	4567890123	250000.00	31
5	3	Смирнов Дмитрий Алексеевич                        	г. Москва, ул. Советская, д.20	+79141234567	smirnov@bank.ru	5678901234	400000.00	45
\.


--
-- TOC entry 3497 (class 2606 OID 16650)
-- Name: сотрудник chk_age; Type: CHECK CONSTRAINT; Schema: bank_schema; Owner: postgres
--

ALTER TABLE bank_schema."сотрудник"
    ADD CONSTRAINT chk_age CHECK ((("возраст" >= 18) AND ("возраст" <= 70))) NOT VALID;


--
-- TOC entry 3490 (class 2606 OID 16655)
-- Name: валюта chk_code; Type: CHECK CONSTRAINT; Schema: bank_schema; Owner: postgres
--

ALTER TABLE bank_schema."валюта"
    ADD CONSTRAINT chk_code CHECK (("код_валюты" ~ '^[A-Z]{3}$'::text)) NOT VALID;


--
-- TOC entry 3501 (class 2606 OID 16661)
-- Name: договор_вклада chk_code; Type: CHECK CONSTRAINT; Schema: bank_schema; Owner: postgres
--

ALTER TABLE bank_schema."договор_вклада"
    ADD CONSTRAINT chk_code CHECK (("код_валюты" ~ '^[A-Z]{3}$'::text)) NOT VALID;


--
-- TOC entry 3486 (class 2606 OID 16677)
-- Name: договор_кредита chk_code; Type: CHECK CONSTRAINT; Schema: bank_schema; Owner: postgres
--

ALTER TABLE bank_schema."договор_кредита"
    ADD CONSTRAINT chk_code CHECK (("код_валюты" ~ '^[A-Z]{3}$'::text)) NOT VALID;


--
-- TOC entry 3487 (class 2606 OID 16606)
-- Name: договор_кредита chk_date; Type: CHECK CONSTRAINT; Schema: bank_schema; Owner: postgres
--

ALTER TABLE bank_schema."договор_кредита"
    ADD CONSTRAINT chk_date CHECK (("дата_погашения" > "дата_выдачи")) NOT VALID;


--
-- TOC entry 3500 (class 2606 OID 16642)
-- Name: график_выплат chk_date; Type: CHECK CONSTRAINT; Schema: bank_schema; Owner: postgres
--

ALTER TABLE bank_schema."график_выплат"
    ADD CONSTRAINT chk_date CHECK (("дата_фактической_выплаты" >= "дата_назначенной_выплаты")) NOT VALID;


--
-- TOC entry 3502 (class 2606 OID 16626)
-- Name: договор_вклада chk_dates; Type: CHECK CONSTRAINT; Schema: bank_schema; Owner: postgres
--

ALTER TABLE bank_schema."договор_вклада"
    ADD CONSTRAINT chk_dates CHECK (("дата_возврата" > "дата_вклада")) NOT VALID;


--
-- TOC entry 3493 (class 2606 OID 16610)
-- Name: клиент chk_email; Type: CHECK CONSTRAINT; Schema: bank_schema; Owner: postgres
--

ALTER TABLE bank_schema."клиент"
    ADD CONSTRAINT chk_email CHECK (((email)::text ~* '^[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+[.][A-Za-z]+$'::text)) NOT VALID;


--
-- TOC entry 3498 (class 2606 OID 16651)
-- Name: сотрудник chk_email; Type: CHECK CONSTRAINT; Schema: bank_schema; Owner: postgres
--

ALTER TABLE bank_schema."сотрудник"
    ADD CONSTRAINT chk_email CHECK (((email)::text ~* '^[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+[.][A-Za-z]+$'::text)) NOT VALID;


--
-- TOC entry 3488 (class 2606 OID 16608)
-- Name: договор_кредита chk_payment_day; Type: CHECK CONSTRAINT; Schema: bank_schema; Owner: postgres
--

ALTER TABLE bank_schema."договор_кредита"
    ADD CONSTRAINT chk_payment_day CHECK (("число_платежа" > 0)) NOT VALID;


--
-- TOC entry 3504 (class 2606 OID 16636)
-- Name: вид_вклада chk_percentage; Type: CHECK CONSTRAINT; Schema: bank_schema; Owner: postgres
--

ALTER TABLE bank_schema."вид_вклада"
    ADD CONSTRAINT chk_percentage CHECK ((("процентная_ставка" >= (0)::numeric) AND ("процентная_ставка" <= (100)::numeric))) NOT VALID;


--
-- TOC entry 3491 (class 2606 OID 16643)
-- Name: вид_кредита chk_percentage; Type: CHECK CONSTRAINT; Schema: bank_schema; Owner: postgres
--

ALTER TABLE bank_schema."вид_кредита"
    ADD CONSTRAINT chk_percentage CHECK ((("процентная_ставка" >= (0)::numeric) AND ("процентная_ставка" <= (100)::numeric))) NOT VALID;


--
-- TOC entry 3499 (class 2606 OID 16678)
-- Name: сотрудник chk_ph_number; Type: CHECK CONSTRAINT; Schema: bank_schema; Owner: postgres
--

ALTER TABLE bank_schema."сотрудник"
    ADD CONSTRAINT chk_ph_number CHECK (("номер_телефона" ~ '^\+?\d{11}$'::text)) NOT VALID;


--
-- TOC entry 3494 (class 2606 OID 16679)
-- Name: клиент chk_ph_number; Type: CHECK CONSTRAINT; Schema: bank_schema; Owner: postgres
--

ALTER TABLE bank_schema."клиент"
    ADD CONSTRAINT chk_ph_number CHECK (("номер_телефона" ~ '^\+?\d{11}$'::text)) NOT VALID;


--
-- TOC entry 3495 (class 2606 OID 16653)
-- Name: должность chk_shifts; Type: CHECK CONSTRAINT; Schema: bank_schema; Owner: postgres
--

ALTER TABLE bank_schema."должность"
    ADD CONSTRAINT chk_shifts CHECK (("количество_ставок" > 0)) NOT VALID;


--
-- TOC entry 3505 (class 2606 OID 16635)
-- Name: вид_вклада chk_srok; Type: CHECK CONSTRAINT; Schema: bank_schema; Owner: postgres
--

ALTER TABLE bank_schema."вид_вклада"
    ADD CONSTRAINT chk_srok CHECK (("максимальный_срок" > 0)) NOT VALID;


--
-- TOC entry 3492 (class 2606 OID 16644)
-- Name: вид_кредита chk_srok; Type: CHECK CONSTRAINT; Schema: bank_schema; Owner: postgres
--

ALTER TABLE bank_schema."вид_кредита"
    ADD CONSTRAINT chk_srok CHECK (("срок" > 0)) NOT VALID;


--
-- TOC entry 3489 (class 2606 OID 16607)
-- Name: договор_кредита chk_sum; Type: CHECK CONSTRAINT; Schema: bank_schema; Owner: postgres
--

ALTER TABLE bank_schema."договор_кредита"
    ADD CONSTRAINT chk_sum CHECK (("сумма" > (0)::numeric)) NOT VALID;


--
-- TOC entry 3503 (class 2606 OID 16627)
-- Name: договор_вклада chk_sum; Type: CHECK CONSTRAINT; Schema: bank_schema; Owner: postgres
--

ALTER TABLE bank_schema."договор_вклада"
    ADD CONSTRAINT chk_sum CHECK (("сумма" > (0)::numeric)) NOT VALID;


--
-- TOC entry 3507 (class 2606 OID 16633)
-- Name: начисления_по_вкладу chk_sum; Type: CHECK CONSTRAINT; Schema: bank_schema; Owner: postgres
--

ALTER TABLE bank_schema."начисления_по_вкладу"
    ADD CONSTRAINT chk_sum CHECK (("сумма_начисления" > (0)::numeric)) NOT VALID;


--
-- TOC entry 3506 (class 2606 OID 16634)
-- Name: вид_вклада chk_sum; Type: CHECK CONSTRAINT; Schema: bank_schema; Owner: postgres
--

ALTER TABLE bank_schema."вид_вклада"
    ADD CONSTRAINT chk_sum CHECK (("минимальная_сумма" > (0)::numeric)) NOT VALID;


--
-- TOC entry 3521 (class 2606 OID 16411)
-- Name: клиент client_pkey; Type: CONSTRAINT; Schema: bank_schema; Owner: postgres
--

ALTER TABLE ONLY bank_schema."клиент"
    ADD CONSTRAINT client_pkey PRIMARY KEY ("id_клиента");


--
-- TOC entry 3541 (class 2606 OID 16467)
-- Name: договор_вклада contribution_agreement_pkey; Type: CONSTRAINT; Schema: bank_schema; Owner: postgres
--

ALTER TABLE ONLY bank_schema."договор_вклада"
    ADD CONSTRAINT contribution_agreement_pkey PRIMARY KEY ("id_договора_вклада");


--
-- TOC entry 3549 (class 2606 OID 16589)
-- Name: начисления_по_вкладу contribution_charges_pkey; Type: CONSTRAINT; Schema: bank_schema; Owner: postgres
--

ALTER TABLE ONLY bank_schema."начисления_по_вкладу"
    ADD CONSTRAINT contribution_charges_pkey PRIMARY KEY ("id_начисления");


--
-- TOC entry 3545 (class 2606 OID 16544)
-- Name: вид_вклада contribution_type_pkey; Type: CONSTRAINT; Schema: bank_schema; Owner: postgres
--

ALTER TABLE ONLY bank_schema."вид_вклада"
    ADD CONSTRAINT contribution_type_pkey PRIMARY KEY ("id_вида_вклада");


--
-- TOC entry 3509 (class 2606 OID 16394)
-- Name: договор_кредита credit_agreement_pkey; Type: CONSTRAINT; Schema: bank_schema; Owner: postgres
--

ALTER TABLE ONLY bank_schema."договор_кредита"
    ADD CONSTRAINT credit_agreement_pkey PRIMARY KEY ("id_договора_кредита");


--
-- TOC entry 3537 (class 2606 OID 16460)
-- Name: график_выплат credit_payment_schedule_pkey; Type: CONSTRAINT; Schema: bank_schema; Owner: postgres
--

ALTER TABLE ONLY bank_schema."график_выплат"
    ADD CONSTRAINT credit_payment_schedule_pkey PRIMARY KEY ("id_платежа");


--
-- TOC entry 3517 (class 2606 OID 16406)
-- Name: вид_кредита credit_type_pkey; Type: CONSTRAINT; Schema: bank_schema; Owner: postgres
--

ALTER TABLE ONLY bank_schema."вид_кредита"
    ADD CONSTRAINT credit_type_pkey PRIMARY KEY ("id_вида_кредита");


--
-- TOC entry 3513 (class 2606 OID 16500)
-- Name: валюта currency_pkey; Type: CONSTRAINT; Schema: bank_schema; Owner: postgres
--

ALTER TABLE ONLY bank_schema."валюта"
    ADD CONSTRAINT currency_pkey PRIMARY KEY ("код_валюты");


--
-- TOC entry 3531 (class 2606 OID 16445)
-- Name: сотрудник employee_pkey; Type: CONSTRAINT; Schema: bank_schema; Owner: postgres
--

ALTER TABLE ONLY bank_schema."сотрудник"
    ADD CONSTRAINT employee_pkey PRIMARY KEY ("id_сотрудника");


--
-- TOC entry 3533 (class 2606 OID 16681)
-- Name: сотрудник passport_unique; Type: CONSTRAINT; Schema: bank_schema; Owner: postgres
--

ALTER TABLE ONLY bank_schema."сотрудник"
    ADD CONSTRAINT passport_unique UNIQUE ("паспортные_данные") INCLUDE ("паспортные_данные");


--
-- TOC entry 3523 (class 2606 OID 16683)
-- Name: клиент passport_unique2; Type: CONSTRAINT; Schema: bank_schema; Owner: postgres
--

ALTER TABLE ONLY bank_schema."клиент"
    ADD CONSTRAINT passport_unique2 UNIQUE ("паспортные_данные") INCLUDE ("паспортные_данные");


--
-- TOC entry 3527 (class 2606 OID 16418)
-- Name: должность position_pkey; Type: CONSTRAINT; Schema: bank_schema; Owner: postgres
--

ALTER TABLE ONLY bank_schema."должность"
    ADD CONSTRAINT position_pkey PRIMARY KEY ("id_должности");


--
-- TOC entry 3496 (class 2606 OID 16654)
-- Name: должность salary; Type: CHECK CONSTRAINT; Schema: bank_schema; Owner: postgres
--

ALTER TABLE bank_schema."должность"
    ADD CONSTRAINT salary CHECK (("оклад" >= (0)::numeric)) NOT VALID;


--
-- TOC entry 3511 (class 2606 OID 16685)
-- Name: договор_кредита un1; Type: CONSTRAINT; Schema: bank_schema; Owner: postgres
--

ALTER TABLE ONLY bank_schema."договор_кредита"
    ADD CONSTRAINT un1 UNIQUE ("id_договора_кредита") INCLUDE ("id_договора_кредита");


--
-- TOC entry 3529 (class 2606 OID 16703)
-- Name: должность un10; Type: CONSTRAINT; Schema: bank_schema; Owner: postgres
--

ALTER TABLE ONLY bank_schema."должность"
    ADD CONSTRAINT un10 UNIQUE ("id_должности") INCLUDE ("id_должности");


--
-- TOC entry 3525 (class 2606 OID 16687)
-- Name: клиент un2; Type: CONSTRAINT; Schema: bank_schema; Owner: postgres
--

ALTER TABLE ONLY bank_schema."клиент"
    ADD CONSTRAINT un2 UNIQUE ("id_клиента") INCLUDE ("id_клиента");


--
-- TOC entry 3543 (class 2606 OID 16689)
-- Name: договор_вклада un3; Type: CONSTRAINT; Schema: bank_schema; Owner: postgres
--

ALTER TABLE ONLY bank_schema."договор_вклада"
    ADD CONSTRAINT un3 UNIQUE ("id_договора_вклада") INCLUDE ("id_договора_вклада");


--
-- TOC entry 3551 (class 2606 OID 16691)
-- Name: начисления_по_вкладу un4; Type: CONSTRAINT; Schema: bank_schema; Owner: postgres
--

ALTER TABLE ONLY bank_schema."начисления_по_вкладу"
    ADD CONSTRAINT un4 UNIQUE ("id_начисления") INCLUDE ("id_начисления");


--
-- TOC entry 3547 (class 2606 OID 16693)
-- Name: вид_вклада un5; Type: CONSTRAINT; Schema: bank_schema; Owner: postgres
--

ALTER TABLE ONLY bank_schema."вид_вклада"
    ADD CONSTRAINT un5 UNIQUE ("id_вида_вклада") INCLUDE ("id_вида_вклада");


--
-- TOC entry 3539 (class 2606 OID 16695)
-- Name: график_выплат un6; Type: CONSTRAINT; Schema: bank_schema; Owner: postgres
--

ALTER TABLE ONLY bank_schema."график_выплат"
    ADD CONSTRAINT un6 UNIQUE ("id_платежа") INCLUDE ("id_платежа");


--
-- TOC entry 3519 (class 2606 OID 16697)
-- Name: вид_кредита un7; Type: CONSTRAINT; Schema: bank_schema; Owner: postgres
--

ALTER TABLE ONLY bank_schema."вид_кредита"
    ADD CONSTRAINT un7 UNIQUE ("id_вида_кредита") INCLUDE ("id_вида_кредита");


--
-- TOC entry 3515 (class 2606 OID 16699)
-- Name: валюта un8; Type: CONSTRAINT; Schema: bank_schema; Owner: postgres
--

ALTER TABLE ONLY bank_schema."валюта"
    ADD CONSTRAINT un8 UNIQUE ("код_валюты") INCLUDE ("код_валюты");


--
-- TOC entry 3535 (class 2606 OID 16701)
-- Name: сотрудник un9; Type: CONSTRAINT; Schema: bank_schema; Owner: postgres
--

ALTER TABLE ONLY bank_schema."сотрудник"
    ADD CONSTRAINT un9 UNIQUE ("id_сотрудника") INCLUDE ("id_сотрудника");


--
-- TOC entry 3558 (class 2606 OID 16611)
-- Name: договор_вклада FK_id_вид_вклада; Type: FK CONSTRAINT; Schema: bank_schema; Owner: postgres
--

ALTER TABLE ONLY bank_schema."договор_вклада"
    ADD CONSTRAINT "FK_id_вид_вклада" FOREIGN KEY ("id_вида_вклада") REFERENCES bank_schema."вид_вклада"("id_вида_вклада") DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3552 (class 2606 OID 16601)
-- Name: договор_кредита FK_id_вид_кредита; Type: FK CONSTRAINT; Schema: bank_schema; Owner: postgres
--

ALTER TABLE ONLY bank_schema."договор_кредита"
    ADD CONSTRAINT "FK_id_вид_кредита" FOREIGN KEY ("id_вида_кредита") REFERENCES bank_schema."вид_кредита"("id_вида_кредита") DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3562 (class 2606 OID 16628)
-- Name: начисления_по_вкладу FK_id_договора; Type: FK CONSTRAINT; Schema: bank_schema; Owner: postgres
--

ALTER TABLE ONLY bank_schema."начисления_по_вкладу"
    ADD CONSTRAINT "FK_id_договора" FOREIGN KEY ("id_договора_вклада") REFERENCES bank_schema."договор_вклада"("id_договора_вклада") DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3557 (class 2606 OID 16637)
-- Name: график_выплат FK_id_договора; Type: FK CONSTRAINT; Schema: bank_schema; Owner: postgres
--

ALTER TABLE ONLY bank_schema."график_выплат"
    ADD CONSTRAINT "FK_id_договора" FOREIGN KEY ("id_договора") REFERENCES bank_schema."договор_кредита"("id_договора_кредита") DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3556 (class 2606 OID 16645)
-- Name: сотрудник FK_id_должности; Type: FK CONSTRAINT; Schema: bank_schema; Owner: postgres
--

ALTER TABLE ONLY bank_schema."сотрудник"
    ADD CONSTRAINT "FK_id_должности" FOREIGN KEY ("id_должности") REFERENCES bank_schema."должность"("id_должности") DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3559 (class 2606 OID 16621)
-- Name: договор_вклада FK_id_клиента; Type: FK CONSTRAINT; Schema: bank_schema; Owner: postgres
--

ALTER TABLE ONLY bank_schema."договор_вклада"
    ADD CONSTRAINT "FK_id_клиента" FOREIGN KEY ("id_клиента") REFERENCES bank_schema."клиент"("id_клиента") DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3553 (class 2606 OID 16667)
-- Name: договор_кредита FK_id_клиента; Type: FK CONSTRAINT; Schema: bank_schema; Owner: postgres
--

ALTER TABLE ONLY bank_schema."договор_кредита"
    ADD CONSTRAINT "FK_id_клиента" FOREIGN KEY ("id_клиента") REFERENCES bank_schema."клиент"("id_клиента") DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3560 (class 2606 OID 16616)
-- Name: договор_вклада FK_id_сотрудника; Type: FK CONSTRAINT; Schema: bank_schema; Owner: postgres
--

ALTER TABLE ONLY bank_schema."договор_вклада"
    ADD CONSTRAINT "FK_id_сотрудника" FOREIGN KEY ("id_сотрудника") REFERENCES bank_schema."сотрудник"("id_сотрудника") DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3554 (class 2606 OID 16662)
-- Name: договор_кредита FK_id_сотрудника; Type: FK CONSTRAINT; Schema: bank_schema; Owner: postgres
--

ALTER TABLE ONLY bank_schema."договор_кредита"
    ADD CONSTRAINT "FK_id_сотрудника" FOREIGN KEY ("id_сотрудника") REFERENCES bank_schema."сотрудник"("id_сотрудника") DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3561 (class 2606 OID 16656)
-- Name: договор_вклада FK_код_валюты; Type: FK CONSTRAINT; Schema: bank_schema; Owner: postgres
--

ALTER TABLE ONLY bank_schema."договор_вклада"
    ADD CONSTRAINT "FK_код_валюты" FOREIGN KEY ("код_валюты") REFERENCES bank_schema."валюта"("код_валюты") DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3555 (class 2606 OID 16672)
-- Name: договор_кредита FK_код_валюты; Type: FK CONSTRAINT; Schema: bank_schema; Owner: postgres
--

ALTER TABLE ONLY bank_schema."договор_кредита"
    ADD CONSTRAINT "FK_код_валюты" FOREIGN KEY ("код_валюты") REFERENCES bank_schema."валюта"("код_валюты") DEFERRABLE INITIALLY DEFERRED;


-- Completed on 2025-04-02 15:59:40 MSK

--
-- PostgreSQL database dump complete
--

