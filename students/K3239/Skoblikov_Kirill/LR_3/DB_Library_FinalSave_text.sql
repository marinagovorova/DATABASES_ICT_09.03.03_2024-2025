--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4
-- Dumped by pg_dump version 17.4

-- Started on 2025-04-27 18:26:58

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
-- TOC entry 6 (class 2615 OID 24576)
-- Name: Library; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA "Library"; -- Создается схема


ALTER SCHEMA "Library" OWNER TO postgres; -- Устанавливается владелец схемы

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 230 (class 1259 OID 24676)
-- Name: Acceptance_certificate; Type: TABLE; Schema: Library; Owner: postgres
--

CREATE TABLE "Library"."Acceptance_certificate" ( -- Создание таблицы Acceptance_certificate и установление параметров полей
    acceptance_certificate_id integer NOT NULL,
    admission_date date NOT NULL,
    copy_id integer NOT NULL
);


ALTER TABLE "Library"."Acceptance_certificate" OWNER TO postgres; -- Устанавливается владелец таблицы

--
-- TOC entry 235 (class 1259 OID 24703)
-- Name: Acceptance_certificate_acceptance_certificate_id_seq; Type: SEQUENCE; Schema: Library; Owner: postgres
--

ALTER TABLE "Library"."Acceptance_certificate" ALTER COLUMN acceptance_certificate_id ADD GENERATED ALWAYS AS IDENTITY ( -- Поле acceptance_certificate_id делается автогенерируемым
    SEQUENCE NAME "Library"."Acceptance_certificate_acceptance_certificate_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

-- Дальше будут создаваться другие таблицы по той же схеме(Создание, назначение параметров полей, назначение владельца и т.д.)
--
-- TOC entry 229 (class 1259 OID 24671)
-- Name: Act_of_acceptance_in_place_of_lost; Type: TABLE; Schema: Library; Owner: postgres
--

CREATE TABLE "Library"."Act_of_acceptance_in_place_of_lost" (
    act_acceptance_in_place_lost_id integer NOT NULL,
    admission_date date NOT NULL,
    lost_copy_id integer NOT NULL,
    new_copy_id integer NOT NULL
);


ALTER TABLE "Library"."Act_of_acceptance_in_place_of_lost" OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 24704)
-- Name: Act_of_acceptance_in_place_of_act_acceptance_in_place_lost__seq; Type: SEQUENCE; Schema: Library; Owner: postgres
--

ALTER TABLE "Library"."Act_of_acceptance_in_place_of_lost" ALTER COLUMN act_acceptance_in_place_lost_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "Library"."Act_of_acceptance_in_place_of_act_acceptance_in_place_lost__seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 232 (class 1259 OID 24686)
-- Name: Appendix_to_writeoff_act; Type: TABLE; Schema: Library; Owner: postgres
--

CREATE TABLE "Library"."Appendix_to_writeoff_act" (
    appendix_to_writeoff_act_id integer NOT NULL,
    registration_number integer NOT NULL,
    storage_cipher character varying(50) NOT NULL,
    short_description character varying(1000),
    revaluation_coefficient numeric NOT NULL,
    total_cost integer NOT NULL,
    writeoff_act_id integer NOT NULL
);


ALTER TABLE "Library"."Appendix_to_writeoff_act" OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 24705)
-- Name: Appendix_to_writeoff_act_appendix_to_writeoff_act_id_seq; Type: SEQUENCE; Schema: Library; Owner: postgres
--

ALTER TABLE "Library"."Appendix_to_writeoff_act" ALTER COLUMN appendix_to_writeoff_act_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "Library"."Appendix_to_writeoff_act_appendix_to_writeoff_act_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 218 (class 1259 OID 24577)
-- Name: Book; Type: TABLE; Schema: Library; Owner: postgres
--

CREATE TABLE "Library"."Book" (
    book_id integer NOT NULL,
    author character varying(150) NOT NULL,
    name character varying(150) NOT NULL,
    volume_number integer DEFAULT 1,
    compiled_by character varying(200) NOT NULL,
    original_language character varying(50) NOT NULL,
    translator character varying(200),
    year_of_issue date NOT NULL
);


ALTER TABLE "Library"."Book" OWNER TO postgres;

--
-- TOC entry 238 (class 1259 OID 24706)
-- Name: Book_book_id_seq; Type: SEQUENCE; Schema: Library; Owner: postgres
--

ALTER TABLE "Library"."Book" ALTER COLUMN book_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "Library"."Book_book_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 219 (class 1259 OID 24621)
-- Name: Copy_book; Type: TABLE; Schema: Library; Owner: postgres
--

CREATE TABLE "Library"."Copy_book" (
    copy_id integer NOT NULL,
    library_cipher character varying(100) NOT NULL,
    type_publication character varying(150) NOT NULL,
    price integer NOT NULL,
    publishing_house character varying(150) NOT NULL,
    inventory_number integer NOT NULL,
    book_id integer NOT NULL,
    rack_id integer,
    year_publication integer NOT NULL
);


ALTER TABLE "Library"."Copy_book" OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 24707)
-- Name: Copy_book_copy_id_seq; Type: SEQUENCE; Schema: Library; Owner: postgres
--

ALTER TABLE "Library"."Copy_book" ALTER COLUMN copy_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "Library"."Copy_book_copy_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 233 (class 1259 OID 24693)
-- Name: Document; Type: TABLE; Schema: Library; Owner: postgres
--

CREATE TABLE "Library"."Document" (
    document_id integer NOT NULL,
    packing_list_id integer,
    writeoff_act_id integer,
    acceptance_certificate_id integer,
    act_acceptance_in_place_lost_id integer,
    document_type character varying(150) NOT NULL,
    date_added date NOT NULL
);


ALTER TABLE "Library"."Document" OWNER TO postgres;

--
-- TOC entry 240 (class 1259 OID 24708)
-- Name: Document_document_id_seq; Type: SEQUENCE; Schema: Library; Owner: postgres
--

ALTER TABLE "Library"."Document" ALTER COLUMN document_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "Library"."Document_document_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 225 (class 1259 OID 24651)
-- Name: Employee; Type: TABLE; Schema: Library; Owner: postgres
--

CREATE TABLE "Library"."Employee" (
    employee_id integer NOT NULL,
    people_id integer NOT NULL
);


ALTER TABLE "Library"."Employee" OWNER TO postgres;

--
-- TOC entry 241 (class 1259 OID 24709)
-- Name: Employee_employee_id_seq; Type: SEQUENCE; Schema: Library; Owner: postgres
--

ALTER TABLE "Library"."Employee" ALTER COLUMN employee_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "Library"."Employee_employee_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 222 (class 1259 OID 24636)
-- Name: People; Type: TABLE; Schema: Library; Owner: postgres
--

CREATE TABLE "Library"."People" (
    people_id integer NOT NULL,
    name character varying(50) NOT NULL,
    surname character varying(50) NOT NULL,
    lastname character varying(50) NOT NULL,
    address character varying(50) NOT NULL,
    phone_number character varying(50) NOT NULL,
    role character varying(50) NOT NULL,
    education character varying(75) NOT NULL
);


ALTER TABLE "Library"."People" OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 24646)
-- Name: Reader; Type: TABLE; Schema: Library; Owner: postgres
--

CREATE TABLE "Library"."Reader" (
    library_card_number integer NOT NULL,
    people_id integer NOT NULL
);


ALTER TABLE "Library"."Reader" OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 24631)
-- Name: Reading; Type: TABLE; Schema: Library; Owner: postgres
--

CREATE TABLE "Library"."Reading" (
    reading_id integer NOT NULL,
    receipt_date date NOT NULL,
    copy_id integer NOT NULL,
    library_card_number integer NOT NULL,
    returned boolean DEFAULT false NOT NULL,
    returned_on_time boolean DEFAULT false NOT NULL
);


ALTER TABLE "Library"."Reading" OWNER TO postgres;

--
-- TOC entry 252 (class 1259 OID 49183)
-- Name: Information about debtors; Type: VIEW; Schema: Library; Owner: postgres
--

CREATE VIEW "Library"."Information about debtors" AS -- Создание представления
 SELECT DISTINCT p.name,
    p.surname,
    p.lastname,
    p.address,
    p.phone_number,
    p.education
   FROM (("Library"."Reading" r
     LEFT JOIN "Library"."Reader" rr ON ((r.library_card_number = rr.library_card_number)))
     LEFT JOIN "Library"."People" p ON ((rr.people_id = p.people_id)))
  WHERE (r.returned = false);


ALTER VIEW "Library"."Information about debtors" OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 24659)
-- Name: Job_history; Type: TABLE; Schema: Library; Owner: postgres
--

CREATE TABLE "Library"."Job_history" (
    id integer NOT NULL,
    date_leaving_office date,
    date_taking_office date NOT NULL,
    number_rates integer NOT NULL,
    job_title_id integer NOT NULL,
    employee_id integer NOT NULL
);


ALTER TABLE "Library"."Job_history" OWNER TO postgres;

--
-- TOC entry 242 (class 1259 OID 24710)
-- Name: Job_history_id_seq; Type: SEQUENCE; Schema: Library; Owner: postgres
--

ALTER TABLE "Library"."Job_history" ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "Library"."Job_history_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 226 (class 1259 OID 24656)
-- Name: Job_title; Type: TABLE; Schema: Library; Owner: postgres
--

CREATE TABLE "Library"."Job_title" (
    job_title_id integer NOT NULL,
    name character varying(150) NOT NULL,
    rate_value integer NOT NULL
);


ALTER TABLE "Library"."Job_title" OWNER TO postgres;

--
-- TOC entry 243 (class 1259 OID 24711)
-- Name: Job_title_job_title_id_seq; Type: SEQUENCE; Schema: Library; Owner: postgres
--

ALTER TABLE "Library"."Job_title" ALTER COLUMN job_title_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "Library"."Job_title_job_title_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 251 (class 1259 OID 49178)
-- Name: Most popular books; Type: VIEW; Schema: Library; Owner: postgres
--

CREATE VIEW "Library"."Most popular books" AS
 WITH book_count AS (
         SELECT "Copy_book".book_id,
            count(*) AS count_on_library
           FROM "Library"."Copy_book"
          WHERE ("Copy_book".rack_id IS NOT NULL)
          GROUP BY "Copy_book".book_id
        ), on_hands_book AS (
         SELECT b_1.book_id,
            count(*) AS count_on_hands
           FROM (("Library"."Book" b_1
             LEFT JOIN "Library"."Copy_book" cb_1 ON ((b_1.book_id = cb_1.book_id)))
             LEFT JOIN "Library"."Reading" r_1 ON ((cb_1.copy_id = r_1.copy_id)))
          WHERE (r_1.receipt_date >= (CURRENT_DATE - '21 days'::interval))
          GROUP BY b_1.book_id
        )
 SELECT b.book_id,
    b.author,
    b.name,
    b.volume_number,
    b.compiled_by,
    b.original_language,
    b.translator,
    b.year_of_issue
   FROM (("Library"."Book" b
     LEFT JOIN "Library"."Copy_book" cb ON ((b.book_id = cb.book_id)))
     LEFT JOIN "Library"."Reading" r ON ((cb.copy_id = r.copy_id)))
  WHERE ((r.receipt_date >= (CURRENT_DATE - '21 days'::interval)) AND (b.book_id IN ( SELECT ohb.book_id
           FROM (on_hands_book ohb
             JOIN book_count bc ON (((ohb.book_id = bc.book_id) AND (bc.count_on_library = ohb.count_on_hands)))))));


ALTER VIEW "Library"."Most popular books" OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 24664)
-- Name: Packing_list; Type: TABLE; Schema: Library; Owner: postgres
--

CREATE TABLE "Library"."Packing_list" (
    packing_list_id integer NOT NULL,
    name character varying(150) NOT NULL,
    serial_number integer NOT NULL,
    compilation_date date NOT NULL,
    product_name character varying(250) NOT NULL,
    quantity_goods integer NOT NULL,
    product_weight numeric NOT NULL,
    price integer NOT NULL
);


ALTER TABLE "Library"."Packing_list" OWNER TO postgres;

--
-- TOC entry 244 (class 1259 OID 24712)
-- Name: Packing_list_packing_list_id_seq; Type: SEQUENCE; Schema: Library; Owner: postgres
--

ALTER TABLE "Library"."Packing_list" ALTER COLUMN packing_list_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "Library"."Packing_list_packing_list_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 223 (class 1259 OID 24641)
-- Name: Passport; Type: TABLE; Schema: Library; Owner: postgres
--

CREATE TABLE "Library"."Passport" (
    people_id integer NOT NULL,
    series character varying(4) NOT NULL,
    number character varying(6) NOT NULL,
    date_to date NOT NULL,
    date_from date NOT NULL,
    id integer NOT NULL
);


ALTER TABLE "Library"."Passport" OWNER TO postgres;

--
-- TOC entry 250 (class 1259 OID 49154)
-- Name: Passport_id_seq; Type: SEQUENCE; Schema: Library; Owner: postgres
--

ALTER TABLE "Library"."Passport" ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "Library"."Passport_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 245 (class 1259 OID 24714)
-- Name: People_people_id_seq; Type: SEQUENCE; Schema: Library; Owner: postgres
--

ALTER TABLE "Library"."People" ALTER COLUMN people_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "Library"."People_people_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 220 (class 1259 OID 24626)
-- Name: Rack; Type: TABLE; Schema: Library; Owner: postgres
--

CREATE TABLE "Library"."Rack" (
    rack_id integer NOT NULL,
    shelf_number integer NOT NULL,
    copy_id integer NOT NULL
);


ALTER TABLE "Library"."Rack" OWNER TO postgres;

--
-- TOC entry 246 (class 1259 OID 24715)
-- Name: Rack_rack_id_seq; Type: SEQUENCE; Schema: Library; Owner: postgres
--

ALTER TABLE "Library"."Rack" ALTER COLUMN rack_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "Library"."Rack_rack_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 247 (class 1259 OID 24717)
-- Name: Reading_reading_id_seq; Type: SEQUENCE; Schema: Library; Owner: postgres
--

ALTER TABLE "Library"."Reading" ALTER COLUMN reading_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "Library"."Reading_reading_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 234 (class 1259 OID 24698)
-- Name: Working_with_documents; Type: TABLE; Schema: Library; Owner: postgres
--

CREATE TABLE "Library"."Working_with_documents" (
    working_id integer NOT NULL,
    employee_id integer NOT NULL,
    document_id integer NOT NULL,
    work_date date NOT NULL
);


ALTER TABLE "Library"."Working_with_documents" OWNER TO postgres;

--
-- TOC entry 248 (class 1259 OID 24719)
-- Name: Working_with_documents_working_id_seq; Type: SEQUENCE; Schema: Library; Owner: postgres
--

ALTER TABLE "Library"."Working_with_documents" ALTER COLUMN working_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "Library"."Working_with_documents_working_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 231 (class 1259 OID 24681)
-- Name: Writeoff_act; Type: TABLE; Schema: Library; Owner: postgres
--

CREATE TABLE "Library"."Writeoff_act" (
    writeoff_act_id integer NOT NULL,
    writeoff_date date NOT NULL,
    copy_id integer NOT NULL
);


ALTER TABLE "Library"."Writeoff_act" OWNER TO postgres;

--
-- TOC entry 249 (class 1259 OID 24720)
-- Name: Writeoff_act_writeoff_act_id_seq; Type: SEQUENCE; Schema: Library; Owner: postgres
--

ALTER TABLE "Library"."Writeoff_act" ALTER COLUMN writeoff_act_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "Library"."Writeoff_act_writeoff_act_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 5075 (class 0 OID 24676)
-- Dependencies: 230
-- Data for Name: Acceptance_certificate; Type: TABLE DATA; Schema: Library; Owner: postgres
--

COPY "Library"."Acceptance_certificate" (acceptance_certificate_id, admission_date, copy_id) FROM stdin; -- Тут начинается заполнение таблиц данными
1	2021-03-16	17
2	2021-03-16	18
3	2021-03-16	19
4	2021-03-16	20
5	2021-03-16	21
6	2021-03-16	57
7	2021-03-16	58
8	2021-03-16	59
9	2021-03-16	60
10	2021-03-16	61
\.


--
-- TOC entry 5074 (class 0 OID 24671)
-- Dependencies: 229
-- Data for Name: Act_of_acceptance_in_place_of_lost; Type: TABLE DATA; Schema: Library; Owner: postgres
--

COPY "Library"."Act_of_acceptance_in_place_of_lost" (act_acceptance_in_place_lost_id, admission_date, lost_copy_id, new_copy_id) FROM stdin;
11	2021-07-30	47	16
12	2021-07-30	48	12
13	2021-07-30	49	13
14	2021-07-30	50	14
15	2021-07-30	51	15
16	2021-07-30	52	21
17	2021-07-30	53	22
18	2021-07-30	54	23
19	2021-07-30	55	24
20	2021-07-30	56	20
\.


--
-- TOC entry 5077 (class 0 OID 24686)
-- Dependencies: 232
-- Data for Name: Appendix_to_writeoff_act; Type: TABLE DATA; Schema: Library; Owner: postgres
--

COPY "Library"."Appendix_to_writeoff_act" (appendix_to_writeoff_act_id, registration_number, storage_cipher, short_description, revaluation_coefficient, total_cost, writeoff_act_id) FROM stdin;
1	1	Cesar	Утерян читателем	0	509	1
2	2	Cesar	Утерян читателем	0	509	2
3	3	Cesar	Утерян читателем	0	609	3
4	4	Cesar	Утерян читателем	0	609	4
5	5	Cesar	Утерян читателем	0	425	5
6	6	Cesar	Утерян читателем	0	459	6
7	7	Cesar	Утерян читателем	0	459	7
8	8	Cesar	Утерян читателем	0	439	8
9	9	Cesar	Утерян читателем	0	439	9
10	10	Cesar	Утерян читателем	0	499	10
\.


--
-- TOC entry 5063 (class 0 OID 24577)
-- Dependencies: 218
-- Data for Name: Book; Type: TABLE DATA; Schema: Library; Owner: postgres
--

COPY "Library"."Book" (book_id, author, name, volume_number, compiled_by, original_language, translator, year_of_issue) FROM stdin;
11	Viktor Dashkevich	Graf Averin	1	Viktor Dashkevich	Russian	Nothing	2022-10-24
12	Viktor Dashkevich	Imperatorskiy div	1	Viktor Dashkevich	Russian	Nothing	2022-12-28
13	Lev Tolstoy	Voyna and Mir	1	Lev Tolstoy	Russian	Nothing	1865-01-01
14	Lev Tolstoy	Voyna and Mir	2	Lev Tolstoy	Russian	Nothing	1865-06-01
15	Aleksandr Pushkin	Evgeniy Onegin	1	Aleksandr Pushkin	Russian	Nothing	1831-10-05
20	Arthur Heiley	Airport	1	Arthur Heiley	English	Т. Кудрявцева	1968-03-02
21	Arthur Heiley	Hotel	1	Arthur Heiley	English	Т. Кудрявцева	1965-02-03
22	Arthur Heiley	Runway Zero-Eight	1	Arthur Heiley	English	Т. Кудрявцева	1958-01-01
23	Arthur Heiley	Strong Medicine	1	Arthur Heiley	English	Т. Кудрявцева	1984-10-21
24	Arthur Heiley	Detective	1	Arthur Heiley	English	Т. Кудрявцева	1997-12-31
40	Slava Marlow	C# для чайников	1	Slava Marlow	Russian	Nothing	2018-01-01
41	Slava Marlow	C# для продвинутых	1	Slava Marlow	Russian	Nothing	2019-07-01
42	Slava Marlow	C# для профессионалов	1	Slava Marlow	Russian	Nothing	2021-01-01
43	Slava Marlow	Фишки C#	1	Slava Marlow	Russian	Nothing	2022-09-01
44	Aleg Camry	Сборник лучших анекдотов 2002	1	Oleg Kizaru	Russian	Nothing	2003-01-01
45	Aleg Camry	152 подката	1	Oleg Kizaru	Russian	Nothing	2002-04-25
46	Nikolay Sobolev	Мой путь к успеху	1	Slava Marlow	Russian	Nothing	2016-03-05
47	Guseyn Gasanov	Гусейн Гасанов	1	Guseyn Gasanov	Russian	Nothing	2019-10-01
\.


--
-- TOC entry 5064 (class 0 OID 24621)
-- Dependencies: 219
-- Data for Name: Copy_book; Type: TABLE DATA; Schema: Library; Owner: postgres
--

COPY "Library"."Copy_book" (copy_id, library_cipher, type_publication, price, publishing_house, inventory_number, book_id, rack_id, year_publication) FROM stdin;
70	R710MC	Paperback	429	АСТ	70	11	29	2023
71	R710MC	Paperback	419	АСТ	71	21	30	2003
19	R710LC	Paperback	409	АСТ	48	13	7	2017
20	R710LC	Paperback	409	АСТ	49	14	8	2023
21	R710LC	Paperback	369	АСТ	50	15	10	2023
57	R710LC	Paperback	329	АСТ	20	20	16	2007
58	R710LC	Paperback	329	АСТ	21	21	17	2005
16	R710MC	Hardcover	625	АСТ	45	15	9	2019
51	R710MC	Hardcover	425	АСТ	5	15	\N	2019
14	R710MC	Hardcover	809	Манн, Иванов и Фербер	43	13	5	2019
59	R710LC	Paperback	309	АСТ	22	22	18	2005
15	R710MC	Hardcover	809	Манн, Иванов и Фербер	44	14	6	2019
60	R710LC	Paperback	309	АСТ	23	23	19	2024
49	R710MC	Hardcover	609	Манн, Иванов и Фербер	3	13	\N	2020
61	R710LC	Paperback	369	АСТ	24	24	20	2024
12	R710MC	Hardcover	709	ЭКСМО	42	11	1	2023
17	R710LC	Paperback	459	ЭКСМО	46	11	3	2023
50	R710MC	Hardcover	609	Манн, Иванов и Фербер	4	14	\N	2020
13	R710MC	Hardcover	709	ЭКСМО	52	12	2	2021
18	R710LC	Paperback	459	ЭКСМО	47	12	4	2021
48	R710MC	Hardcover	509	ЭКСМО	2	12	\N	2021
22	L710MC	Hardcover	779	АСТ	51	20	11	2021
23	L710MC	Hardcover	779	АСТ	53	21	12	2021
47	R710MC	Hardcover	509	ЭКСМО	1	11	\N	2019
52	R710MC	Hardcover	459	ЭКСМО	6	21	\N	2000
53	R710MC	Hardcover	459	ЭКСМО	7	22	\N	2000
54	R710MC	Hardcover	439	АСТ	8	23	\N	1999
55	R710MC	Hardcover	439	АСТ	9	24	\N	1999
56	R710MC	Hardcover	499	АСТ	10	20	\N	1998
24	L710MC	Hardcover	779	АСТ	54	22	13	2021
25	L710MC	Hardcover	779	АСТ	55	23	14	2021
26	L710MC	Hardcover	779	АСТ	56	24	15	2001
62	R710LC	Paperback	199	ЭКСМО	999	40	21	2018
63	R710LC	Paperback	189	ЭКСМО	998	41	22	2019
64	R710LC	Paperback	259	ЭКСМО	997	42	23	2021
65	R710LC	Paperback	249	ЭКСМО	996	43	24	2022
66	R710LC	Paperback	159	ЭКСМО	995	44	25	2003
67	R710LC	Paperback	199	ЭКСМО	994	45	26	2002
68	R710LC	Paperback	199	ЭКСМО	993	46	27	2016
69	R710LC	Paperback	999	ЭКСМО	992	47	28	2019
\.


--
-- TOC entry 5078 (class 0 OID 24693)
-- Dependencies: 233
-- Data for Name: Document; Type: TABLE DATA; Schema: Library; Owner: postgres
--

COPY "Library"."Document" (document_id, packing_list_id, writeoff_act_id, acceptance_certificate_id, act_acceptance_in_place_lost_id, document_type, date_added) FROM stdin;
2	2	\N	\N	\N	Накладная	2019-12-30
3	3	\N	\N	\N	Накладная	2019-12-23
4	4	\N	\N	\N	Накладная	2020-01-28
5	5	\N	\N	\N	Накладная	2020-05-13
6	6	\N	\N	\N	Накладная	2021-03-15
7	7	\N	\N	\N	Накладная	2019-11-29
8	8	\N	\N	\N	Накладная	2022-07-25
9	9	\N	\N	\N	Накладная	2023-09-01
10	10	\N	\N	\N	Накладная	2024-11-17
11	11	\N	\N	\N	Накладная	2023-10-22
12	\N	1	\N	\N	Акт о списании	2022-08-01
13	\N	2	\N	\N	Акт о списании	2022-08-01
14	\N	3	\N	\N	Акт о списании	2022-08-01
15	\N	4	\N	\N	Акт о списании	2022-08-01
16	\N	5	\N	\N	Акт о списании	2022-08-01
17	\N	6	\N	\N	Акт о списании	2022-08-01
18	\N	7	\N	\N	Акт о списании	2022-08-01
19	\N	8	\N	\N	Акт о списании	2022-08-01
20	\N	9	\N	\N	Акт о списании	2022-08-01
21	\N	10	\N	\N	Акт о списании	2022-08-01
22	\N	\N	1	\N	Акт о приеме	2021-03-16
23	\N	\N	2	\N	Акт о приеме	2021-03-16
24	\N	\N	3	\N	Акт о приеме	2021-03-16
25	\N	\N	4	\N	Акт о приеме	2021-03-16
26	\N	\N	5	\N	Акт о приеме	2021-03-16
27	\N	\N	6	\N	Акт о приеме	2021-03-16
28	\N	\N	7	\N	Акт о приеме	2021-03-16
29	\N	\N	8	\N	Акт о приеме	2021-03-16
30	\N	\N	9	\N	Акт о приеме	2021-03-16
31	\N	\N	10	\N	Акт о приеме	2021-03-16
32	\N	\N	\N	11	Акт о приеме взамен утерянного	2021-07-30
33	\N	\N	\N	12	Акт о приеме взамен утерянного	2021-07-30
34	\N	\N	\N	13	Акт о приеме взамен утерянного	2021-07-30
35	\N	\N	\N	14	Акт о приеме взамен утерянного	2021-07-30
36	\N	\N	\N	15	Акт о приеме взамен утерянного	2021-07-30
37	\N	\N	\N	16	Акт о приеме взамен утерянного	2021-07-30
38	\N	\N	\N	17	Акт о приеме взамен утерянного	2021-07-30
39	\N	\N	\N	18	Акт о приеме взамен утерянного	2021-07-30
40	\N	\N	\N	19	Акт о приеме взамен утерянного	2021-07-30
41	\N	\N	\N	20	Акт о приеме взамен утерянного	2021-07-30
\.


--
-- TOC entry 5070 (class 0 OID 24651)
-- Dependencies: 225
-- Data for Name: Employee; Type: TABLE DATA; Schema: Library; Owner: postgres
--

COPY "Library"."Employee" (employee_id, people_id) FROM stdin;
1	6
2	8
3	9
4	10
5	11
6	12
7	13
8	14
9	15
10	16
\.


--
-- TOC entry 5072 (class 0 OID 24659)
-- Dependencies: 227
-- Data for Name: Job_history; Type: TABLE DATA; Schema: Library; Owner: postgres
--

COPY "Library"."Job_history" (id, date_leaving_office, date_taking_office, number_rates, job_title_id, employee_id) FROM stdin;
4	\N	2025-03-31	1	3	1
5	\N	2025-03-31	1	5	1
6	\N	2025-03-31	2	4	2
7	2025-03-30	2020-01-11	1	3	8
8	2025-03-30	2020-01-11	1	4	9
9	2025-03-30	2020-01-11	1	5	10
10	\N	2020-01-11	1	6	6
11	\N	2020-01-11	1	9	7
12	\N	2022-09-15	1	8	5
13	\N	2023-05-21	1	11	4
\.


--
-- TOC entry 5071 (class 0 OID 24656)
-- Dependencies: 226
-- Data for Name: Job_title; Type: TABLE DATA; Schema: Library; Owner: postgres
--

COPY "Library"."Job_title" (job_title_id, name, rate_value) FROM stdin;
3	Управляющий	120000
4	Библиотекарь	45000
5	Директор	150000
6	Заместитель директора	110000
7	Помощник управляющего	70000
8	Уборщик	40000
9	Охранник	50000
10	Системный администратор	40000
11	Заместитель заместителя директора	70000
12	Главный библиотекарь	90000
\.


--
-- TOC entry 5073 (class 0 OID 24664)
-- Dependencies: 228
-- Data for Name: Packing_list; Type: TABLE DATA; Schema: Library; Owner: postgres
--

COPY "Library"."Packing_list" (packing_list_id, name, serial_number, compilation_date, product_name, quantity_goods, product_weight, price) FROM stdin;
2	Приходная накладная	1	2019-12-30	Стеллажи	10	100	150000
3	Приходная накладная	2	2019-12-23	Столы	4	12.8	60000
4	Приходная накладная	3	2020-01-28	Компьютеры	5	8	200000
5	Приходная накладная	4	2020-05-13	Книги	30	15	10000
6	Приходная накладная	5	2021-03-15	Книги	30	15	10000
7	Приходная накладная	6	2019-11-29	Кресла	20	22.29	90000
8	Приходная накладная	7	2022-07-25	Стулья	15	7.65	65000
9	Приходная накладная	8	2023-09-01	Книги	30	14.95	10000
10	Приходная накладная	9	2024-11-17	Книги	30	15	10000
11	Приходная накладная	10	2023-10-22	Столы	2	7	35000
\.


--
-- TOC entry 5068 (class 0 OID 24641)
-- Dependencies: 223
-- Data for Name: Passport; Type: TABLE DATA; Schema: Library; Owner: postgres
--

COPY "Library"."Passport" (people_id, series, number, date_to, date_from, id) FROM stdin;
4	3514	489523	2045-01-01	2020-01-01	1
5	2002	326598	2026-09-25	2001-09-25	2
6	4319	595489	2026-06-06	2020-06-06	3
7	3648	789566	2034-10-12	2009-10-12	4
8	2112	432684	2022-04-29	2016-04-29	5
8	4489	621847	2047-04-30	2022-04-30	6
9	2232	100500	2050-01-01	2025-01-01	7
10	2232	100258	2049-12-15	2024-12-15	8
11	2215	984235	2046-06-24	2021-06-24	9
12	2214	695326	2044-01-29	2019-01-29	10
13	2215	110598	2045-07-17	2020-07-17	11
14	1195	485246	2028-11-26	2003-11-26	12
15	1194	687452	2028-11-26	2003-11-26	13
16	4765	234967	2041-03-15	2016-03-15	14
17	3684	354555	2026-10-25	2020-10-25	15
18	4252	525252	2029-05-14	2023-05-14	16
19	4252	365478	2029-06-21	2023-06-21	17
20	4314	942687	2034-09-21	2009-09-21	18
21	3891	125379	2037-12-20	2012-12-20	19
22	4875	692524	2025-12-12	2000-12-12	20
23	1846	354782	2027-01-29	2021-01-29	21
\.


--
-- TOC entry 5067 (class 0 OID 24636)
-- Dependencies: 222
-- Data for Name: People; Type: TABLE DATA; Schema: Library; Owner: postgres
--

COPY "Library"."People" (people_id, name, surname, lastname, address, phone_number, role, education) FROM stdin;
6	Karl	Gandalf	Slizerin	Stone Street 22	+79999930001	employee	higher education
8	Jeff	Mark	Bezos	Train Street 24	+79875553535	employee	higher education
9	Ben	Donald	Salazar	Road map 15	+79230003403	employee	higher education
10	Lionel	Andres	Messi	Snickers avenu 11	+79435647980	employee	higher education
11	Cristianu	Roberto	Ronaldo	Mars street 7	+79110072935	employee	higher education
12	Lamine	Lionel	Yamal	Twix road 2	+79525252552	employee	higher education
13	Serhio	Gonsalo	Ramos	Twix road 3	+79823456574	employee	higher education
14	Oleg	Mongol	Aleksandrovich	Berezka street 62	+79236590345	employee	higher education
15	Optimus	Megatron	Prime	Cybertron avenu 116	+79812654785	employee	higher education
16	Mark	Kir	Whynot	Road map 14	+79428652367	employee	higher education
4	John	Deivy	Harris	Food Cort 14	+79529935242	reader	higher education
20	Casper	Nikolay	Muller	Hogvarts street 4	+79345971263	reader	higher education
21	Tomas	Cristian	Parovozik	Hogvarts street 5	+79456734867	reader	higher education
5	Bob	Bill	Potter	Food Cort 15	+79529935007	reader	higher education
17	Ronald	Harry	Worldweb	Hogvarts street 1	+79999999999	reader	schoolboy
18	Harry	James	Potter	Hogvarts street 2	+79999999998	reader	schoolboy
19	Albus	Severus	Duwwdor	Hogvarts street 3	+79567845682	reader	schoolboy
23	Olaf	Laf	Tuhel	Hogvarts street 52	+79345679234	reader	schoolboy
7	Aurora	Ann	Howl	Brown Street 1	+79159936485	reader	incomplete higher education
22	Karina	Christmas	Dior	Tyazhelbiy lux 99	+79123456789	reader	incomplete higher education
\.


--
-- TOC entry 5065 (class 0 OID 24626)
-- Dependencies: 220
-- Data for Name: Rack; Type: TABLE DATA; Schema: Library; Owner: postgres
--

COPY "Library"."Rack" (rack_id, shelf_number, copy_id) FROM stdin;
1	21	12
2	21	13
3	21	17
4	21	18
5	39	14
6	39	15
7	39	19
8	39	20
9	40	16
10	40	21
11	40	22
12	40	23
13	39	24
14	39	25
15	39	26
16	39	57
17	39	58
18	39	59
19	39	60
20	39	61
21	41	62
22	41	63
23	41	64
24	41	65
25	42	66
26	42	67
27	43	68
28	43	69
29	42	70
30	42	71
\.


--
-- TOC entry 5069 (class 0 OID 24646)
-- Dependencies: 224
-- Data for Name: Reader; Type: TABLE DATA; Schema: Library; Owner: postgres
--

COPY "Library"."Reader" (library_card_number, people_id) FROM stdin;
356	4
2345	5
674	7
192	17
189	18
152	19
174	20
82	21
35	22
89	23
\.


--
-- TOC entry 5066 (class 0 OID 24631)
-- Dependencies: 221
-- Data for Name: Reading; Type: TABLE DATA; Schema: Library; Owner: postgres
--

COPY "Library"."Reading" (reading_id, receipt_date, copy_id, library_card_number, returned, returned_on_time) FROM stdin;
37	2025-04-04	63	356	f	f
38	2025-04-04	64	356	f	f
34	2024-09-25	13	674	t	t
35	2024-08-14	13	35	t	t
36	2024-09-25	57	674	t	t
10	2023-11-14	25	89	f	f
1	2025-04-10	12	356	t	t
2	2024-11-30	17	2345	t	t
3	2023-01-15	12	674	t	t
4	2024-11-30	13	2345	t	t
5	2022-03-02	21	356	t	t
6	2021-10-25	22	35	t	t
7	2021-10-25	23	35	t	t
8	2021-10-25	24	35	t	t
9	2022-02-15	15	82	t	t
11	2023-12-05	26	89	t	t
22	2025-04-20	57	674	t	t
23	2025-04-20	58	674	t	t
24	2025-04-21	60	35	t	t
25	2025-04-19	61	89	t	t
27	2023-12-05	63	89	t	t
28	2023-12-05	64	89	t	t
29	2023-12-05	65	89	t	t
30	2023-12-05	66	89	t	t
31	2023-12-05	67	89	t	t
32	2023-12-05	68	89	t	t
33	2023-12-05	69	89	t	t
26	2023-12-05	62	89	t	t
\.


--
-- TOC entry 5079 (class 0 OID 24698)
-- Dependencies: 234
-- Data for Name: Working_with_documents; Type: TABLE DATA; Schema: Library; Owner: postgres
--

COPY "Library"."Working_with_documents" (working_id, employee_id, document_id, work_date) FROM stdin;
11	2	22	2021-03-20
12	2	23	2021-03-22
13	2	24	2021-03-22
14	2	25	2021-03-29
15	6	6	2021-09-20
16	6	7	2020-02-17
17	6	8	2022-07-30
18	4	2	2020-02-01
19	4	4	2020-06-09
20	4	5	2020-06-09
\.


--
-- TOC entry 5076 (class 0 OID 24681)
-- Dependencies: 231
-- Data for Name: Writeoff_act; Type: TABLE DATA; Schema: Library; Owner: postgres
--

COPY "Library"."Writeoff_act" (writeoff_act_id, writeoff_date, copy_id) FROM stdin;
1	2021-08-01	47
2	2021-08-01	48
3	2021-08-01	49
4	2021-08-01	50
5	2021-08-01	51
6	2021-08-01	52
7	2021-08-01	53
8	2021-08-01	54
9	2021-08-01	55
10	2021-08-01	56
\.


--
-- TOC entry 5101 (class 0 OID 0)
-- Dependencies: 235
-- Name: Acceptance_certificate_acceptance_certificate_id_seq; Type: SEQUENCE SET; Schema: Library; Owner: postgres
--

SELECT pg_catalog.setval('"Library"."Acceptance_certificate_acceptance_certificate_id_seq"', 10, true);


--
-- TOC entry 5102 (class 0 OID 0)
-- Dependencies: 236
-- Name: Act_of_acceptance_in_place_of_act_acceptance_in_place_lost__seq; Type: SEQUENCE SET; Schema: Library; Owner: postgres
--

SELECT pg_catalog.setval('"Library"."Act_of_acceptance_in_place_of_act_acceptance_in_place_lost__seq"', 20, true);


--
-- TOC entry 5103 (class 0 OID 0)
-- Dependencies: 237
-- Name: Appendix_to_writeoff_act_appendix_to_writeoff_act_id_seq; Type: SEQUENCE SET; Schema: Library; Owner: postgres
--

SELECT pg_catalog.setval('"Library"."Appendix_to_writeoff_act_appendix_to_writeoff_act_id_seq"', 10, true);


--
-- TOC entry 5104 (class 0 OID 0)
-- Dependencies: 238
-- Name: Book_book_id_seq; Type: SEQUENCE SET; Schema: Library; Owner: postgres
--

SELECT pg_catalog.setval('"Library"."Book_book_id_seq"', 47, true);


--
-- TOC entry 5105 (class 0 OID 0)
-- Dependencies: 239
-- Name: Copy_book_copy_id_seq; Type: SEQUENCE SET; Schema: Library; Owner: postgres
--

SELECT pg_catalog.setval('"Library"."Copy_book_copy_id_seq"', 71, true);


--
-- TOC entry 5106 (class 0 OID 0)
-- Dependencies: 240
-- Name: Document_document_id_seq; Type: SEQUENCE SET; Schema: Library; Owner: postgres
--

SELECT pg_catalog.setval('"Library"."Document_document_id_seq"', 41, true);


--
-- TOC entry 5107 (class 0 OID 0)
-- Dependencies: 241
-- Name: Employee_employee_id_seq; Type: SEQUENCE SET; Schema: Library; Owner: postgres
--

SELECT pg_catalog.setval('"Library"."Employee_employee_id_seq"', 10, true);


--
-- TOC entry 5108 (class 0 OID 0)
-- Dependencies: 242
-- Name: Job_history_id_seq; Type: SEQUENCE SET; Schema: Library; Owner: postgres
--

SELECT pg_catalog.setval('"Library"."Job_history_id_seq"', 13, true);


--
-- TOC entry 5109 (class 0 OID 0)
-- Dependencies: 243
-- Name: Job_title_job_title_id_seq; Type: SEQUENCE SET; Schema: Library; Owner: postgres
--

SELECT pg_catalog.setval('"Library"."Job_title_job_title_id_seq"', 12, true);


--
-- TOC entry 5110 (class 0 OID 0)
-- Dependencies: 244
-- Name: Packing_list_packing_list_id_seq; Type: SEQUENCE SET; Schema: Library; Owner: postgres
--

SELECT pg_catalog.setval('"Library"."Packing_list_packing_list_id_seq"', 11, true);


--
-- TOC entry 5111 (class 0 OID 0)
-- Dependencies: 250
-- Name: Passport_id_seq; Type: SEQUENCE SET; Schema: Library; Owner: postgres
--

SELECT pg_catalog.setval('"Library"."Passport_id_seq"', 21, true);


--
-- TOC entry 5112 (class 0 OID 0)
-- Dependencies: 245
-- Name: People_people_id_seq; Type: SEQUENCE SET; Schema: Library; Owner: postgres
--

SELECT pg_catalog.setval('"Library"."People_people_id_seq"', 23, true);


--
-- TOC entry 5113 (class 0 OID 0)
-- Dependencies: 246
-- Name: Rack_rack_id_seq; Type: SEQUENCE SET; Schema: Library; Owner: postgres
--

SELECT pg_catalog.setval('"Library"."Rack_rack_id_seq"', 30, true);


--
-- TOC entry 5114 (class 0 OID 0)
-- Dependencies: 247
-- Name: Reading_reading_id_seq; Type: SEQUENCE SET; Schema: Library; Owner: postgres
--

SELECT pg_catalog.setval('"Library"."Reading_reading_id_seq"', 38, true);


--
-- TOC entry 5115 (class 0 OID 0)
-- Dependencies: 248
-- Name: Working_with_documents_working_id_seq; Type: SEQUENCE SET; Schema: Library; Owner: postgres
--

SELECT pg_catalog.setval('"Library"."Working_with_documents_working_id_seq"', 20, true);


--
-- TOC entry 5116 (class 0 OID 0)
-- Dependencies: 249
-- Name: Writeoff_act_writeoff_act_id_seq; Type: SEQUENCE SET; Schema: Library; Owner: postgres
--

SELECT pg_catalog.setval('"Library"."Writeoff_act_writeoff_act_id_seq"', 10, true);

-- Ниже пойдет установка ограничений, назначение первичных и внешних ключей
--
-- TOC entry 4876 (class 2606 OID 24680)
-- Name: Acceptance_certificate Acceptance_certificate_pkey; Type: CONSTRAINT; Schema: Library; Owner: postgres
--

ALTER TABLE ONLY "Library"."Acceptance_certificate"
    ADD CONSTRAINT "Acceptance_certificate_pkey" PRIMARY KEY (acceptance_certificate_id);


--
-- TOC entry 4870 (class 2606 OID 24675)
-- Name: Act_of_acceptance_in_place_of_lost Act_of_acceptance_in_place_of_lost_pkey; Type: CONSTRAINT; Schema: Library; Owner: postgres
--

ALTER TABLE ONLY "Library"."Act_of_acceptance_in_place_of_lost"
    ADD CONSTRAINT "Act_of_acceptance_in_place_of_lost_pkey" PRIMARY KEY (act_acceptance_in_place_lost_id);


--
-- TOC entry 4884 (class 2606 OID 24692)
-- Name: Appendix_to_writeoff_act Appendix_to_writeoff_act_pkey; Type: CONSTRAINT; Schema: Library; Owner: postgres
--

ALTER TABLE ONLY "Library"."Appendix_to_writeoff_act"
    ADD CONSTRAINT "Appendix_to_writeoff_act_pkey" PRIMARY KEY (appendix_to_writeoff_act_id);


--
-- TOC entry 4821 (class 2606 OID 32796)
-- Name: Appendix_to_writeoff_act Appendix_to_writeoff_act_registration_number_check; Type: CHECK CONSTRAINT; Schema: Library; Owner: postgres
--

ALTER TABLE "Library"."Appendix_to_writeoff_act"
    ADD CONSTRAINT "Appendix_to_writeoff_act_registration_number_check" CHECK ((registration_number > 0)) NOT VALID;


--
-- TOC entry 4822 (class 2606 OID 40981)
-- Name: Appendix_to_writeoff_act Appendix_to_writeoff_act_short_description_check; Type: CHECK CONSTRAINT; Schema: Library; Owner: postgres
--

ALTER TABLE "Library"."Appendix_to_writeoff_act"
    ADD CONSTRAINT "Appendix_to_writeoff_act_short_description_check" CHECK (((short_description)::text ~ '^[А-Яа-яA-Za-z,.!? ]+$'::text)) NOT VALID;


--
-- TOC entry 4823 (class 2606 OID 32798)
-- Name: Appendix_to_writeoff_act Appendix_to_writeoff_act_total_cost_check; Type: CHECK CONSTRAINT; Schema: Library; Owner: postgres
--

ALTER TABLE "Library"."Appendix_to_writeoff_act"
    ADD CONSTRAINT "Appendix_to_writeoff_act_total_cost_check" CHECK ((total_cost > 0)) NOT VALID;


--
-- TOC entry 4786 (class 2606 OID 40960)
-- Name: Book Book_author_check; Type: CHECK CONSTRAINT; Schema: Library; Owner: postgres
--

ALTER TABLE "Library"."Book"
    ADD CONSTRAINT "Book_author_check" CHECK (((author)::text ~ '^[A-Za-z. ]+$'::text)) NOT VALID;


--
-- TOC entry 4787 (class 2606 OID 40962)
-- Name: Book Book_compiled_by_check; Type: CHECK CONSTRAINT; Schema: Library; Owner: postgres
--

ALTER TABLE "Library"."Book"
    ADD CONSTRAINT "Book_compiled_by_check" CHECK (((compiled_by)::text ~ '^[A-Za-z. ]+$'::text)) NOT VALID;


--
-- TOC entry 4788 (class 2606 OID 49166)
-- Name: Book Book_name_check; Type: CHECK CONSTRAINT; Schema: Library; Owner: postgres
--

ALTER TABLE "Library"."Book"
    ADD CONSTRAINT "Book_name_check" CHECK (((name)::text ~ '^[А-Яа-яA-Za-z0-9\-\# ]+$'::text)) NOT VALID;


--
-- TOC entry 4789 (class 2606 OID 24619)
-- Name: Book Book_original_language_check; Type: CHECK CONSTRAINT; Schema: Library; Owner: postgres
--

ALTER TABLE "Library"."Book"
    ADD CONSTRAINT "Book_original_language_check" CHECK (((original_language)::text ~ '^[A-Za-z]+$'::text)) NOT VALID;


--
-- TOC entry 4826 (class 2606 OID 24611)
-- Name: Book Book_pkey; Type: CONSTRAINT; Schema: Library; Owner: postgres
--

ALTER TABLE ONLY "Library"."Book"
    ADD CONSTRAINT "Book_pkey" PRIMARY KEY (book_id);


--
-- TOC entry 4790 (class 2606 OID 40977)
-- Name: Book Book_translator_check; Type: CHECK CONSTRAINT; Schema: Library; Owner: postgres
--

ALTER TABLE "Library"."Book"
    ADD CONSTRAINT "Book_translator_check" CHECK (((translator)::text ~ '^[А-Яа-яA-Za-z. ]+$'::text)) NOT VALID;


--
-- TOC entry 4791 (class 2606 OID 24615)
-- Name: Book Book_volume_number_check; Type: CHECK CONSTRAINT; Schema: Library; Owner: postgres
--

ALTER TABLE "Library"."Book"
    ADD CONSTRAINT "Book_volume_number_check" CHECK ((volume_number > 0)) NOT VALID;


--
-- TOC entry 4792 (class 2606 OID 32772)
-- Name: Copy_book Copy_book_inventory_number_check; Type: CHECK CONSTRAINT; Schema: Library; Owner: postgres
--

ALTER TABLE "Library"."Copy_book"
    ADD CONSTRAINT "Copy_book_inventory_number_check" CHECK ((inventory_number > 0)) NOT VALID;


--
-- TOC entry 4793 (class 2606 OID 32768)
-- Name: Copy_book Copy_book_library_cipher_check; Type: CHECK CONSTRAINT; Schema: Library; Owner: postgres
--

ALTER TABLE "Library"."Copy_book"
    ADD CONSTRAINT "Copy_book_library_cipher_check" CHECK (((library_cipher)::text ~ '^[A-Za-z0-9]+$'::text)) NOT VALID;


--
-- TOC entry 4830 (class 2606 OID 24625)
-- Name: Copy_book Copy_book_pkey; Type: CONSTRAINT; Schema: Library; Owner: postgres
--

ALTER TABLE ONLY "Library"."Copy_book"
    ADD CONSTRAINT "Copy_book_pkey" PRIMARY KEY (copy_id);


--
-- TOC entry 4794 (class 2606 OID 32770)
-- Name: Copy_book Copy_book_price_check; Type: CHECK CONSTRAINT; Schema: Library; Owner: postgres
--

ALTER TABLE "Library"."Copy_book"
    ADD CONSTRAINT "Copy_book_price_check" CHECK ((price > 0)) NOT VALID;


--
-- TOC entry 4795 (class 2606 OID 40969)
-- Name: Copy_book Copy_book_publishing_house_check; Type: CHECK CONSTRAINT; Schema: Library; Owner: postgres
--

ALTER TABLE "Library"."Copy_book"
    ADD CONSTRAINT "Copy_book_publishing_house_check" CHECK (((publishing_house)::text ~ '^[А-Яа-яA-Za-z,  ]+$'::text)) NOT VALID;


--
-- TOC entry 4796 (class 2606 OID 32769)
-- Name: Copy_book Copy_book_type_publication_check; Type: CHECK CONSTRAINT; Schema: Library; Owner: postgres
--

ALTER TABLE "Library"."Copy_book"
    ADD CONSTRAINT "Copy_book_type_publication_check" CHECK (((type_publication)::text ~ '^[A-Za-z]+$'::text)) NOT VALID;


--
-- TOC entry 4797 (class 2606 OID 49162)
-- Name: Copy_book Copy_book_year_publication_check; Type: CHECK CONSTRAINT; Schema: Library; Owner: postgres
--

ALTER TABLE "Library"."Copy_book"
    ADD CONSTRAINT "Copy_book_year_publication_check" CHECK ((year_publication > 1500)) NOT VALID;


--
-- TOC entry 4798 (class 2606 OID 49163)
-- Name: Copy_book Copy_book_year_publication_check1; Type: CHECK CONSTRAINT; Schema: Library; Owner: postgres
--

ALTER TABLE "Library"."Copy_book"
    ADD CONSTRAINT "Copy_book_year_publication_check1" CHECK ((year_publication <= 2025)) NOT VALID;


--
-- TOC entry 4824 (class 2606 OID 40982)
-- Name: Document Document_document_type_check; Type: CHECK CONSTRAINT; Schema: Library; Owner: postgres
--

ALTER TABLE "Library"."Document"
    ADD CONSTRAINT "Document_document_type_check" CHECK (((document_type)::text ~ '^[А-Яа-яA-Za-z ]+$'::text)) NOT VALID;


--
-- TOC entry 4888 (class 2606 OID 24697)
-- Name: Document Document_pkey; Type: CONSTRAINT; Schema: Library; Owner: postgres
--

ALTER TABLE ONLY "Library"."Document"
    ADD CONSTRAINT "Document_pkey" PRIMARY KEY (document_id);


--
-- TOC entry 4854 (class 2606 OID 24655)
-- Name: Employee Employee_pkey; Type: CONSTRAINT; Schema: Library; Owner: postgres
--

ALTER TABLE ONLY "Library"."Employee"
    ADD CONSTRAINT "Employee_pkey" PRIMARY KEY (employee_id);


--
-- TOC entry 4812 (class 2606 OID 32787)
-- Name: Job_history Job_history_check; Type: CHECK CONSTRAINT; Schema: Library; Owner: postgres
--

ALTER TABLE "Library"."Job_history"
    ADD CONSTRAINT "Job_history_check" CHECK ((date_taking_office < date_leaving_office)) NOT VALID;


--
-- TOC entry 4813 (class 2606 OID 32788)
-- Name: Job_history Job_history_number_rates_check; Type: CHECK CONSTRAINT; Schema: Library; Owner: postgres
--

ALTER TABLE "Library"."Job_history"
    ADD CONSTRAINT "Job_history_number_rates_check" CHECK ((number_rates <= 2)) NOT VALID;


--
-- TOC entry 4814 (class 2606 OID 32789)
-- Name: Job_history Job_history_number_rates_check1; Type: CHECK CONSTRAINT; Schema: Library; Owner: postgres
--

ALTER TABLE "Library"."Job_history"
    ADD CONSTRAINT "Job_history_number_rates_check1" CHECK ((number_rates > 0)) NOT VALID;


--
-- TOC entry 4862 (class 2606 OID 24663)
-- Name: Job_history Job_history_pkey; Type: CONSTRAINT; Schema: Library; Owner: postgres
--

ALTER TABLE ONLY "Library"."Job_history"
    ADD CONSTRAINT "Job_history_pkey" PRIMARY KEY (id);


--
-- TOC entry 4810 (class 2606 OID 40975)
-- Name: Job_title Job_title_name_check; Type: CHECK CONSTRAINT; Schema: Library; Owner: postgres
--

ALTER TABLE "Library"."Job_title"
    ADD CONSTRAINT "Job_title_name_check" CHECK (((name)::text ~ '^[А-Яа-яA-Za-z -]+$'::text)) NOT VALID;


--
-- TOC entry 4858 (class 2606 OID 24762)
-- Name: Job_title Job_title_pkey; Type: CONSTRAINT; Schema: Library; Owner: postgres
--

ALTER TABLE ONLY "Library"."Job_title"
    ADD CONSTRAINT "Job_title_pkey" PRIMARY KEY (job_title_id);


--
-- TOC entry 4811 (class 2606 OID 32786)
-- Name: Job_title Job_title_rate_value_check; Type: CHECK CONSTRAINT; Schema: Library; Owner: postgres
--

ALTER TABLE "Library"."Job_title"
    ADD CONSTRAINT "Job_title_rate_value_check" CHECK ((rate_value > 0)) NOT VALID;


--
-- TOC entry 4815 (class 2606 OID 40976)
-- Name: Packing_list Packing_list_name_check; Type: CHECK CONSTRAINT; Schema: Library; Owner: postgres
--

ALTER TABLE "Library"."Packing_list"
    ADD CONSTRAINT "Packing_list_name_check" CHECK (((name)::text ~ '^[А-Яа-яA-Za-z., ]+$'::text)) NOT VALID;


--
-- TOC entry 4866 (class 2606 OID 24670)
-- Name: Packing_list Packing_list_pkey; Type: CONSTRAINT; Schema: Library; Owner: postgres
--

ALTER TABLE ONLY "Library"."Packing_list"
    ADD CONSTRAINT "Packing_list_pkey" PRIMARY KEY (packing_list_id);


--
-- TOC entry 4816 (class 2606 OID 32795)
-- Name: Packing_list Packing_list_price_check; Type: CHECK CONSTRAINT; Schema: Library; Owner: postgres
--

ALTER TABLE "Library"."Packing_list"
    ADD CONSTRAINT "Packing_list_price_check" CHECK ((price > 0)) NOT VALID;


--
-- TOC entry 4817 (class 2606 OID 40980)
-- Name: Packing_list Packing_list_product_name_check; Type: CHECK CONSTRAINT; Schema: Library; Owner: postgres
--

ALTER TABLE "Library"."Packing_list"
    ADD CONSTRAINT "Packing_list_product_name_check" CHECK (((product_name)::text ~ '^[А-Яа-яA-Za-z ]+$'::text)) NOT VALID;


--
-- TOC entry 4818 (class 2606 OID 32794)
-- Name: Packing_list Packing_list_product_weight_check; Type: CHECK CONSTRAINT; Schema: Library; Owner: postgres
--

ALTER TABLE "Library"."Packing_list"
    ADD CONSTRAINT "Packing_list_product_weight_check" CHECK ((product_weight > (0)::numeric)) NOT VALID;


--
-- TOC entry 4819 (class 2606 OID 32793)
-- Name: Packing_list Packing_list_quantity_goods_check; Type: CHECK CONSTRAINT; Schema: Library; Owner: postgres
--

ALTER TABLE "Library"."Packing_list"
    ADD CONSTRAINT "Packing_list_quantity_goods_check" CHECK ((quantity_goods > 0)) NOT VALID;


--
-- TOC entry 4820 (class 2606 OID 32791)
-- Name: Packing_list Packing_list_serial_number_check; Type: CHECK CONSTRAINT; Schema: Library; Owner: postgres
--

ALTER TABLE "Library"."Packing_list"
    ADD CONSTRAINT "Packing_list_serial_number_check" CHECK ((serial_number > 0)) NOT VALID;


--
-- TOC entry 4807 (class 2606 OID 32782)
-- Name: Passport Passport_check; Type: CHECK CONSTRAINT; Schema: Library; Owner: postgres
--

ALTER TABLE "Library"."Passport"
    ADD CONSTRAINT "Passport_check" CHECK ((date_from < date_to)) NOT VALID;


--
-- TOC entry 4808 (class 2606 OID 32784)
-- Name: Passport Passport_number_check; Type: CHECK CONSTRAINT; Schema: Library; Owner: postgres
--

ALTER TABLE "Library"."Passport"
    ADD CONSTRAINT "Passport_number_check" CHECK (((number)::text ~ '^[0-9]+$'::text)) NOT VALID;


--
-- TOC entry 4846 (class 2606 OID 49161)
-- Name: Passport Passport_pkey; Type: CONSTRAINT; Schema: Library; Owner: postgres
--

ALTER TABLE ONLY "Library"."Passport"
    ADD CONSTRAINT "Passport_pkey" PRIMARY KEY (id);


--
-- TOC entry 4809 (class 2606 OID 32783)
-- Name: Passport Passport_series_check; Type: CHECK CONSTRAINT; Schema: Library; Owner: postgres
--

ALTER TABLE "Library"."Passport"
    ADD CONSTRAINT "Passport_series_check" CHECK (((series)::text ~ '^[0-9]+$'::text)) NOT VALID;


--
-- TOC entry 4800 (class 2606 OID 40970)
-- Name: People People_address_check; Type: CHECK CONSTRAINT; Schema: Library; Owner: postgres
--

ALTER TABLE "Library"."People"
    ADD CONSTRAINT "People_address_check" CHECK (((address)::text ~ '^[A-Za-z.,0-9 ]+$'::text)) NOT VALID;


--
-- TOC entry 4801 (class 2606 OID 49169)
-- Name: People People_education_check; Type: CHECK CONSTRAINT; Schema: Library; Owner: postgres
--

ALTER TABLE "Library"."People"
    ADD CONSTRAINT "People_education_check" CHECK (((education)::text ~ '^[А-Яа-яA-Za-z.,0-9 ]+$'::text)) NOT VALID;


--
-- TOC entry 4802 (class 2606 OID 32776)
-- Name: People People_lastname_check; Type: CHECK CONSTRAINT; Schema: Library; Owner: postgres
--

ALTER TABLE "Library"."People"
    ADD CONSTRAINT "People_lastname_check" CHECK (((lastname)::text ~ '^[A-Za-z]+$'::text)) NOT VALID;


--
-- TOC entry 4803 (class 2606 OID 32774)
-- Name: People People_name_check; Type: CHECK CONSTRAINT; Schema: Library; Owner: postgres
--

ALTER TABLE "Library"."People"
    ADD CONSTRAINT "People_name_check" CHECK (((name)::text ~ '^[A-Za-z]+$'::text)) NOT VALID;


--
-- TOC entry 4804 (class 2606 OID 40971)
-- Name: People People_phone_number_check; Type: CHECK CONSTRAINT; Schema: Library; Owner: postgres
--

ALTER TABLE "Library"."People"
    ADD CONSTRAINT "People_phone_number_check" CHECK (((phone_number)::text ~ '^\+[0-9]+$'::text)) NOT VALID;


--
-- TOC entry 4842 (class 2606 OID 24640)
-- Name: People People_pkey; Type: CONSTRAINT; Schema: Library; Owner: postgres
--

ALTER TABLE ONLY "Library"."People"
    ADD CONSTRAINT "People_pkey" PRIMARY KEY (people_id);


--
-- TOC entry 4805 (class 2606 OID 32779)
-- Name: People People_role_check; Type: CHECK CONSTRAINT; Schema: Library; Owner: postgres
--

ALTER TABLE "Library"."People"
    ADD CONSTRAINT "People_role_check" CHECK (((role)::text ~ '^[A-Za-z]+$'::text)) NOT VALID;


--
-- TOC entry 4806 (class 2606 OID 32775)
-- Name: People People_surname_check; Type: CHECK CONSTRAINT; Schema: Library; Owner: postgres
--

ALTER TABLE "Library"."People"
    ADD CONSTRAINT "People_surname_check" CHECK (((surname)::text ~ '^[A-Za-z]+$'::text)) NOT VALID;


--
-- TOC entry 4834 (class 2606 OID 24630)
-- Name: Rack Rack_pkey; Type: CONSTRAINT; Schema: Library; Owner: postgres
--

ALTER TABLE ONLY "Library"."Rack"
    ADD CONSTRAINT "Rack_pkey" PRIMARY KEY (rack_id);


--
-- TOC entry 4799 (class 2606 OID 32773)
-- Name: Rack Rack_shelf_number_check; Type: CHECK CONSTRAINT; Schema: Library; Owner: postgres
--

ALTER TABLE "Library"."Rack"
    ADD CONSTRAINT "Rack_shelf_number_check" CHECK ((shelf_number > 0)) NOT VALID;


--
-- TOC entry 4850 (class 2606 OID 24650)
-- Name: Reader Reader_pkey; Type: CONSTRAINT; Schema: Library; Owner: postgres
--

ALTER TABLE ONLY "Library"."Reader"
    ADD CONSTRAINT "Reader_pkey" PRIMARY KEY (library_card_number);


--
-- TOC entry 4838 (class 2606 OID 24635)
-- Name: Reading Reading_pkey; Type: CONSTRAINT; Schema: Library; Owner: postgres
--

ALTER TABLE ONLY "Library"."Reading"
    ADD CONSTRAINT "Reading_pkey" PRIMARY KEY (reading_id);


--
-- TOC entry 4892 (class 2606 OID 24702)
-- Name: Working_with_documents Working_with_documents_pkey; Type: CONSTRAINT; Schema: Library; Owner: postgres
--

ALTER TABLE ONLY "Library"."Working_with_documents"
    ADD CONSTRAINT "Working_with_documents_pkey" PRIMARY KEY (working_id);


--
-- TOC entry 4880 (class 2606 OID 24685)
-- Name: Writeoff_act Writeoff_act_pkey; Type: CONSTRAINT; Schema: Library; Owner: postgres
--

ALTER TABLE ONLY "Library"."Writeoff_act"
    ADD CONSTRAINT "Writeoff_act_pkey" PRIMARY KEY (writeoff_act_id);


--
-- TOC entry 4878 (class 2606 OID 24853)
-- Name: Acceptance_certificate acceptance_unique; Type: CONSTRAINT; Schema: Library; Owner: postgres
--

ALTER TABLE ONLY "Library"."Acceptance_certificate"
    ADD CONSTRAINT acceptance_unique UNIQUE (acceptance_certificate_id);


--
-- TOC entry 4886 (class 2606 OID 24859)
-- Name: Appendix_to_writeoff_act appendix_writeoff_unique; Type: CONSTRAINT; Schema: Library; Owner: postgres
--

ALTER TABLE ONLY "Library"."Appendix_to_writeoff_act"
    ADD CONSTRAINT appendix_writeoff_unique UNIQUE (appendix_to_writeoff_act_id);


--
-- TOC entry 4828 (class 2606 OID 24829)
-- Name: Book book_unique; Type: CONSTRAINT; Schema: Library; Owner: postgres
--

ALTER TABLE ONLY "Library"."Book"
    ADD CONSTRAINT book_unique UNIQUE (book_id);


--
-- TOC entry 4832 (class 2606 OID 24831)
-- Name: Copy_book copy_unique; Type: CONSTRAINT; Schema: Library; Owner: postgres
--

ALTER TABLE ONLY "Library"."Copy_book"
    ADD CONSTRAINT copy_unique UNIQUE (copy_id);


--
-- TOC entry 4890 (class 2606 OID 24861)
-- Name: Document document_unique; Type: CONSTRAINT; Schema: Library; Owner: postgres
--

ALTER TABLE ONLY "Library"."Document"
    ADD CONSTRAINT document_unique UNIQUE (document_id);


--
-- TOC entry 4856 (class 2606 OID 24843)
-- Name: Employee employee_unique; Type: CONSTRAINT; Schema: Library; Owner: postgres
--

ALTER TABLE ONLY "Library"."Employee"
    ADD CONSTRAINT employee_unique UNIQUE (employee_id, people_id);


--
-- TOC entry 4864 (class 2606 OID 24847)
-- Name: Job_history job_history_unique; Type: CONSTRAINT; Schema: Library; Owner: postgres
--

ALTER TABLE ONLY "Library"."Job_history"
    ADD CONSTRAINT job_history_unique UNIQUE (id);


--
-- TOC entry 4860 (class 2606 OID 24845)
-- Name: Job_title job_unique; Type: CONSTRAINT; Schema: Library; Owner: postgres
--

ALTER TABLE ONLY "Library"."Job_title"
    ADD CONSTRAINT job_unique UNIQUE (job_title_id);


--
-- TOC entry 4872 (class 2606 OID 24857)
-- Name: Act_of_acceptance_in_place_of_lost laAct_unique; Type: CONSTRAINT; Schema: Library; Owner: postgres
--

ALTER TABLE ONLY "Library"."Act_of_acceptance_in_place_of_lost"
    ADD CONSTRAINT "laAct_unique" UNIQUE (lost_copy_id, new_copy_id);


--
-- TOC entry 4874 (class 2606 OID 24851)
-- Name: Act_of_acceptance_in_place_of_lost lost_act_unique; Type: CONSTRAINT; Schema: Library; Owner: postgres
--

ALTER TABLE ONLY "Library"."Act_of_acceptance_in_place_of_lost"
    ADD CONSTRAINT lost_act_unique UNIQUE (act_acceptance_in_place_lost_id);


--
-- TOC entry 4868 (class 2606 OID 24849)
-- Name: Packing_list packing_list_unique; Type: CONSTRAINT; Schema: Library; Owner: postgres
--

ALTER TABLE ONLY "Library"."Packing_list"
    ADD CONSTRAINT packing_list_unique UNIQUE (packing_list_id);


--
-- TOC entry 4844 (class 2606 OID 24837)
-- Name: People people_unique; Type: CONSTRAINT; Schema: Library; Owner: postgres
--

ALTER TABLE ONLY "Library"."People"
    ADD CONSTRAINT people_unique UNIQUE (people_id, phone_number);


--
-- TOC entry 4848 (class 2606 OID 40973)
-- Name: Passport pkey_unique; Type: CONSTRAINT; Schema: Library; Owner: postgres
--

ALTER TABLE ONLY "Library"."Passport"
    ADD CONSTRAINT pkey_unique UNIQUE (people_id, date_from);


--
-- TOC entry 4836 (class 2606 OID 24833)
-- Name: Rack rack_unique; Type: CONSTRAINT; Schema: Library; Owner: postgres
--

ALTER TABLE ONLY "Library"."Rack"
    ADD CONSTRAINT rack_unique UNIQUE (rack_id, copy_id);


--
-- TOC entry 4852 (class 2606 OID 24841)
-- Name: Reader reader_unique; Type: CONSTRAINT; Schema: Library; Owner: postgres
--

ALTER TABLE ONLY "Library"."Reader"
    ADD CONSTRAINT reader_unique UNIQUE (library_card_number, people_id);


--
-- TOC entry 4840 (class 2606 OID 24835)
-- Name: Reading reading_unique; Type: CONSTRAINT; Schema: Library; Owner: postgres
--

ALTER TABLE ONLY "Library"."Reading"
    ADD CONSTRAINT reading_unique UNIQUE (reading_id);


--
-- TOC entry 4894 (class 2606 OID 24863)
-- Name: Working_with_documents working_documents_unique; Type: CONSTRAINT; Schema: Library; Owner: postgres
--

ALTER TABLE ONLY "Library"."Working_with_documents"
    ADD CONSTRAINT working_documents_unique UNIQUE (working_id);


--
-- TOC entry 4882 (class 2606 OID 24855)
-- Name: Writeoff_act writeoff_unique; Type: CONSTRAINT; Schema: Library; Owner: postgres
--

ALTER TABLE ONLY "Library"."Writeoff_act"
    ADD CONSTRAINT writeoff_unique UNIQUE (writeoff_act_id, copy_id);


--
-- TOC entry 4910 (class 2606 OID 24808)
-- Name: Document fk_acceptance_certificate; Type: FK CONSTRAINT; Schema: Library; Owner: postgres
--

ALTER TABLE ONLY "Library"."Document"
    ADD CONSTRAINT fk_acceptance_certificate FOREIGN KEY (acceptance_certificate_id) REFERENCES "Library"."Acceptance_certificate"(acceptance_certificate_id) NOT VALID;


--
-- TOC entry 4911 (class 2606 OID 24813)
-- Name: Document fk_act_of_acceptance_in_place_of_lost; Type: FK CONSTRAINT; Schema: Library; Owner: postgres
--

ALTER TABLE ONLY "Library"."Document"
    ADD CONSTRAINT fk_act_of_acceptance_in_place_of_lost FOREIGN KEY (act_acceptance_in_place_lost_id) REFERENCES "Library"."Act_of_acceptance_in_place_of_lost"(act_acceptance_in_place_lost_id) NOT VALID;


--
-- TOC entry 4895 (class 2606 OID 24721)
-- Name: Copy_book fk_book; Type: FK CONSTRAINT; Schema: Library; Owner: postgres
--

ALTER TABLE ONLY "Library"."Copy_book"
    ADD CONSTRAINT fk_book FOREIGN KEY (book_id) REFERENCES "Library"."Book"(book_id) NOT VALID;


--
-- TOC entry 4897 (class 2606 OID 24731)
-- Name: Rack fk_copy; Type: FK CONSTRAINT; Schema: Library; Owner: postgres
--

ALTER TABLE ONLY "Library"."Rack"
    ADD CONSTRAINT fk_copy FOREIGN KEY (copy_id) REFERENCES "Library"."Copy_book"(copy_id) NOT VALID;


--
-- TOC entry 4898 (class 2606 OID 24741)
-- Name: Reading fk_copy; Type: FK CONSTRAINT; Schema: Library; Owner: postgres
--

ALTER TABLE ONLY "Library"."Reading"
    ADD CONSTRAINT fk_copy FOREIGN KEY (copy_id) REFERENCES "Library"."Copy_book"(copy_id) NOT VALID;


--
-- TOC entry 4907 (class 2606 OID 24783)
-- Name: Acceptance_certificate fk_copy; Type: FK CONSTRAINT; Schema: Library; Owner: postgres
--

ALTER TABLE ONLY "Library"."Acceptance_certificate"
    ADD CONSTRAINT fk_copy FOREIGN KEY (copy_id) REFERENCES "Library"."Copy_book"(copy_id) NOT VALID;


--
-- TOC entry 4908 (class 2606 OID 24788)
-- Name: Writeoff_act fk_copy; Type: FK CONSTRAINT; Schema: Library; Owner: postgres
--

ALTER TABLE ONLY "Library"."Writeoff_act"
    ADD CONSTRAINT fk_copy FOREIGN KEY (copy_id) REFERENCES "Library"."Copy_book"(copy_id) NOT VALID;


--
-- TOC entry 4905 (class 2606 OID 24773)
-- Name: Act_of_acceptance_in_place_of_lost fk_copy_lost; Type: FK CONSTRAINT; Schema: Library; Owner: postgres
--

ALTER TABLE ONLY "Library"."Act_of_acceptance_in_place_of_lost"
    ADD CONSTRAINT fk_copy_lost FOREIGN KEY (lost_copy_id) REFERENCES "Library"."Copy_book"(copy_id) NOT VALID;


--
-- TOC entry 4906 (class 2606 OID 24778)
-- Name: Act_of_acceptance_in_place_of_lost fk_copy_new; Type: FK CONSTRAINT; Schema: Library; Owner: postgres
--

ALTER TABLE ONLY "Library"."Act_of_acceptance_in_place_of_lost"
    ADD CONSTRAINT fk_copy_new FOREIGN KEY (new_copy_id) REFERENCES "Library"."Copy_book"(copy_id) NOT VALID;


--
-- TOC entry 4914 (class 2606 OID 24823)
-- Name: Working_with_documents fk_document; Type: FK CONSTRAINT; Schema: Library; Owner: postgres
--

ALTER TABLE ONLY "Library"."Working_with_documents"
    ADD CONSTRAINT fk_document FOREIGN KEY (document_id) REFERENCES "Library"."Document"(document_id) NOT VALID;


--
-- TOC entry 4903 (class 2606 OID 24768)
-- Name: Job_history fk_employee; Type: FK CONSTRAINT; Schema: Library; Owner: postgres
--

ALTER TABLE ONLY "Library"."Job_history"
    ADD CONSTRAINT fk_employee FOREIGN KEY (employee_id) REFERENCES "Library"."Employee"(employee_id) NOT VALID;


--
-- TOC entry 4915 (class 2606 OID 24818)
-- Name: Working_with_documents fk_employee; Type: FK CONSTRAINT; Schema: Library; Owner: postgres
--

ALTER TABLE ONLY "Library"."Working_with_documents"
    ADD CONSTRAINT fk_employee FOREIGN KEY (employee_id) REFERENCES "Library"."Employee"(employee_id) NOT VALID;


--
-- TOC entry 4904 (class 2606 OID 24763)
-- Name: Job_history fk_job_title; Type: FK CONSTRAINT; Schema: Library; Owner: postgres
--

ALTER TABLE ONLY "Library"."Job_history"
    ADD CONSTRAINT fk_job_title FOREIGN KEY (job_title_id) REFERENCES "Library"."Job_title"(job_title_id) NOT VALID;


--
-- TOC entry 4912 (class 2606 OID 24798)
-- Name: Document fk_packing_list; Type: FK CONSTRAINT; Schema: Library; Owner: postgres
--

ALTER TABLE ONLY "Library"."Document"
    ADD CONSTRAINT fk_packing_list FOREIGN KEY (packing_list_id) REFERENCES "Library"."Packing_list"(packing_list_id) NOT VALID;


--
-- TOC entry 4900 (class 2606 OID 24746)
-- Name: Passport fk_people; Type: FK CONSTRAINT; Schema: Library; Owner: postgres
--

ALTER TABLE ONLY "Library"."Passport"
    ADD CONSTRAINT fk_people FOREIGN KEY (people_id) REFERENCES "Library"."People"(people_id) NOT VALID;


--
-- TOC entry 4901 (class 2606 OID 24751)
-- Name: Reader fk_people; Type: FK CONSTRAINT; Schema: Library; Owner: postgres
--

ALTER TABLE ONLY "Library"."Reader"
    ADD CONSTRAINT fk_people FOREIGN KEY (people_id) REFERENCES "Library"."People"(people_id) NOT VALID;


--
-- TOC entry 4902 (class 2606 OID 24756)
-- Name: Employee fk_people; Type: FK CONSTRAINT; Schema: Library; Owner: postgres
--

ALTER TABLE ONLY "Library"."Employee"
    ADD CONSTRAINT fk_people FOREIGN KEY (people_id) REFERENCES "Library"."People"(people_id) NOT VALID;


--
-- TOC entry 4896 (class 2606 OID 24726)
-- Name: Copy_book fk_rack; Type: FK CONSTRAINT; Schema: Library; Owner: postgres
--

ALTER TABLE ONLY "Library"."Copy_book"
    ADD CONSTRAINT fk_rack FOREIGN KEY (rack_id) REFERENCES "Library"."Rack"(rack_id) NOT VALID;


--
-- TOC entry 4899 (class 2606 OID 24736)
-- Name: Reading fk_reader; Type: FK CONSTRAINT; Schema: Library; Owner: postgres
--

ALTER TABLE ONLY "Library"."Reading"
    ADD CONSTRAINT fk_reader FOREIGN KEY (library_card_number) REFERENCES "Library"."Reader"(library_card_number) NOT VALID;


--
-- TOC entry 4909 (class 2606 OID 24793)
-- Name: Appendix_to_writeoff_act fk_writeoff_act; Type: FK CONSTRAINT; Schema: Library; Owner: postgres
--

ALTER TABLE ONLY "Library"."Appendix_to_writeoff_act"
    ADD CONSTRAINT fk_writeoff_act FOREIGN KEY (writeoff_act_id) REFERENCES "Library"."Writeoff_act"(writeoff_act_id) NOT VALID;


--
-- TOC entry 4913 (class 2606 OID 24803)
-- Name: Document fk_writeoff_act; Type: FK CONSTRAINT; Schema: Library; Owner: postgres
--

ALTER TABLE ONLY "Library"."Document"
    ADD CONSTRAINT fk_writeoff_act FOREIGN KEY (writeoff_act_id) REFERENCES "Library"."Writeoff_act"(writeoff_act_id) NOT VALID;


-- Completed on 2025-04-27 18:26:58

--
-- PostgreSQL database dump complete
--
