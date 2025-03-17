--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4 (Debian 17.4-1.pgdg120+2)
-- Dumped by pg_dump version 17.4

-- Started on 2025-03-17 10:25:53 UTC

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
-- TOC entry 5 (class 2615 OID 16836)
-- Name: public; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA public;


--
-- TOC entry 218 (class 1259 OID 16838)
-- Name: author; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.author (
    author_id integer NOT NULL,
    name character varying(100) NOT NULL,
    CONSTRAINT author_name_check CHECK (((name)::text ~ '^[A-Za-zА-Яа-яЁё\- ]+$'::text))
);


--
-- TOC entry 217 (class 1259 OID 16837)
-- Name: author_author_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.author_author_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3543 (class 0 OID 0)
-- Dependencies: 217
-- Name: author_author_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.author_author_id_seq OWNED BY public.author.author_id;


--
-- TOC entry 221 (class 1259 OID 16856)
-- Name: authorbook; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.authorbook (
    book_id integer NOT NULL,
    author_id integer NOT NULL,
    author_order integer
);


--
-- TOC entry 220 (class 1259 OID 16846)
-- Name: book; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.book (
    book_id integer NOT NULL,
    title character varying(255) NOT NULL,
    genre character varying(50),
    knowledge_area character varying(100),
    language character varying(50),
    library_code character varying(50) NOT NULL,
    publication_year integer
);


--
-- TOC entry 219 (class 1259 OID 16845)
-- Name: book_book_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.book_book_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3544 (class 0 OID 0)
-- Dependencies: 219
-- Name: book_book_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.book_book_id_seq OWNED BY public.book.book_id;


--
-- TOC entry 226 (class 1259 OID 16895)
-- Name: bookcopy; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.bookcopy (
    copy_id integer NOT NULL,
    book_id integer NOT NULL,
    inventory_number character varying(20) NOT NULL,
    price numeric,
    CONSTRAINT bookcopy_price_check CHECK ((price > (0)::numeric))
);


--
-- TOC entry 225 (class 1259 OID 16894)
-- Name: bookcopy_copy_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.bookcopy_copy_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3545 (class 0 OID 0)
-- Dependencies: 225
-- Name: bookcopy_copy_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.bookcopy_copy_id_seq OWNED BY public.bookcopy.copy_id;


--
-- TOC entry 245 (class 1259 OID 17028)
-- Name: bookloan; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.bookloan (
    loan_id integer NOT NULL,
    copy_id integer NOT NULL,
    reader_id integer NOT NULL,
    loan_date date NOT NULL,
    due_date date NOT NULL,
    return_date date,
    fine numeric(10,2),
    CONSTRAINT bookloan_check CHECK ((loan_date <= due_date)),
    CONSTRAINT bookloan_check1 CHECK ((return_date >= loan_date))
);


--
-- TOC entry 244 (class 1259 OID 17027)
-- Name: bookloan_loan_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.bookloan_loan_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3546 (class 0 OID 0)
-- Dependencies: 244
-- Name: bookloan_loan_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.bookloan_loan_id_seq OWNED BY public.bookloan.loan_id;


--
-- TOC entry 230 (class 1259 OID 16925)
-- Name: employee; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.employee (
    employee_id integer NOT NULL,
    name character varying(100) NOT NULL,
    CONSTRAINT employee_name_check CHECK (((name)::text ~ '^[A-Za-zА-Яа-яЁё\- ]+$'::text))
);


--
-- TOC entry 229 (class 1259 OID 16924)
-- Name: employee_employee_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.employee_employee_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3547 (class 0 OID 0)
-- Dependencies: 229
-- Name: employee_employee_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.employee_employee_id_seq OWNED BY public.employee.employee_id;


--
-- TOC entry 235 (class 1259 OID 16958)
-- Name: employeeposition; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.employeeposition (
    employee_id integer NOT NULL,
    position_id integer NOT NULL
);


--
-- TOC entry 239 (class 1259 OID 16991)
-- Name: excludeditems; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.excludeditems (
    excluded_item_id integer NOT NULL,
    copy_id integer,
    reason character varying(255),
    cost numeric(10,2),
    revaluation_coef numeric(5,2),
    date date NOT NULL,
    CONSTRAINT excludeditems_cost_check CHECK ((cost > (0)::numeric))
);


--
-- TOC entry 238 (class 1259 OID 16990)
-- Name: excludeditems_excluded_item_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.excludeditems_excluded_item_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3548 (class 0 OID 0)
-- Dependencies: 238
-- Name: excludeditems_excluded_item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.excludeditems_excluded_item_id_seq OWNED BY public.excludeditems.excluded_item_id;


--
-- TOC entry 237 (class 1259 OID 16974)
-- Name: inventoryrecord; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.inventoryrecord (
    record_id integer NOT NULL,
    copy_id integer,
    employee_id integer,
    record_type character varying(50) NOT NULL,
    doc_number character varying(20),
    date date NOT NULL
);


--
-- TOC entry 236 (class 1259 OID 16973)
-- Name: inventoryrecord_record_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.inventoryrecord_record_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3549 (class 0 OID 0)
-- Dependencies: 236
-- Name: inventoryrecord_record_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.inventoryrecord_record_id_seq OWNED BY public.inventoryrecord.record_id;


--
-- TOC entry 243 (class 1259 OID 17014)
-- Name: passport; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.passport (
    passport_id integer NOT NULL,
    reader_id integer NOT NULL,
    passport_number character varying(20) NOT NULL,
    start_date date NOT NULL,
    end_date date NOT NULL,
    CONSTRAINT passport_check CHECK ((start_date <= end_date)),
    CONSTRAINT passport_passport_number_check CHECK (((passport_number)::text ~ '^[0-9]+$'::text))
);


--
-- TOC entry 242 (class 1259 OID 17013)
-- Name: passport_passport_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.passport_passport_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3550 (class 0 OID 0)
-- Dependencies: 242
-- Name: passport_passport_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.passport_passport_id_seq OWNED BY public.passport.passport_id;


--
-- TOC entry 234 (class 1259 OID 16942)
-- Name: position; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."position" (
    position_id integer NOT NULL,
    position_catalog_id integer NOT NULL,
    rate integer,
    salary numeric,
    start_date date,
    end_date date,
    CONSTRAINT position_check CHECK ((start_date <= end_date)),
    CONSTRAINT position_rate_check CHECK ((rate > 0)),
    CONSTRAINT position_salary_check CHECK ((salary > (0)::numeric))
);


--
-- TOC entry 233 (class 1259 OID 16941)
-- Name: position_position_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.position_position_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3551 (class 0 OID 0)
-- Dependencies: 233
-- Name: position_position_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.position_position_id_seq OWNED BY public."position".position_id;


--
-- TOC entry 232 (class 1259 OID 16933)
-- Name: positioncatalog; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.positioncatalog (
    position_catalog_id integer NOT NULL,
    position_name character varying(50) NOT NULL
);


--
-- TOC entry 231 (class 1259 OID 16932)
-- Name: positioncatalog_position_catalog_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.positioncatalog_position_catalog_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3552 (class 0 OID 0)
-- Dependencies: 231
-- Name: positioncatalog_position_catalog_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.positioncatalog_position_catalog_id_seq OWNED BY public.positioncatalog.position_catalog_id;


--
-- TOC entry 241 (class 1259 OID 17004)
-- Name: reader; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.reader (
    reader_id integer NOT NULL,
    card_number character varying(20) NOT NULL,
    name character varying(100) NOT NULL,
    address character varying(255),
    phone character varying(20),
    email character varying(100),
    CONSTRAINT reader_email_check CHECK (((email)::text ~ '^[^@\s]+@[^@\s]+\.[^@\s]+$'::text)),
    CONSTRAINT reader_name_check CHECK (((name)::text ~ '^[A-Za-zА-Яа-яЁё\- ]+$'::text)),
    CONSTRAINT reader_phone_check CHECK (((phone)::text ~ '^\+7[0-9]{10}$'::text))
);


--
-- TOC entry 240 (class 1259 OID 17003)
-- Name: reader_reader_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.reader_reader_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3553 (class 0 OID 0)
-- Dependencies: 240
-- Name: reader_reader_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.reader_reader_id_seq OWNED BY public.reader.reader_id;


--
-- TOC entry 228 (class 1259 OID 16912)
-- Name: storage; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.storage (
    storage_id integer NOT NULL,
    copy_id integer NOT NULL,
    room integer,
    rack integer,
    shelf integer,
    start_date date,
    end_date date,
    CONSTRAINT storage_check CHECK ((start_date <= end_date))
);


--
-- TOC entry 227 (class 1259 OID 16911)
-- Name: storage_storage_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.storage_storage_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3554 (class 0 OID 0)
-- Dependencies: 227
-- Name: storage_storage_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.storage_storage_id_seq OWNED BY public.storage.storage_id;


--
-- TOC entry 223 (class 1259 OID 16872)
-- Name: translator; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.translator (
    translator_id integer NOT NULL,
    name character varying(100) NOT NULL,
    CONSTRAINT translator_name_check CHECK (((name)::text ~ '^[A-Za-zА-Яа-яЁё\- ]+$'::text))
);


--
-- TOC entry 222 (class 1259 OID 16871)
-- Name: translator_translator_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.translator_translator_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3555 (class 0 OID 0)
-- Dependencies: 222
-- Name: translator_translator_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.translator_translator_id_seq OWNED BY public.translator.translator_id;


--
-- TOC entry 224 (class 1259 OID 16879)
-- Name: translatorbook; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.translatorbook (
    book_id integer NOT NULL,
    translator_id integer NOT NULL
);


--
-- TOC entry 3282 (class 2604 OID 16841)
-- Name: author author_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.author ALTER COLUMN author_id SET DEFAULT nextval('public.author_author_id_seq'::regclass);


--
-- TOC entry 3283 (class 2604 OID 16849)
-- Name: book book_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.book ALTER COLUMN book_id SET DEFAULT nextval('public.book_book_id_seq'::regclass);


--
-- TOC entry 3285 (class 2604 OID 16898)
-- Name: bookcopy copy_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bookcopy ALTER COLUMN copy_id SET DEFAULT nextval('public.bookcopy_copy_id_seq'::regclass);


--
-- TOC entry 3294 (class 2604 OID 17031)
-- Name: bookloan loan_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bookloan ALTER COLUMN loan_id SET DEFAULT nextval('public.bookloan_loan_id_seq'::regclass);


--
-- TOC entry 3287 (class 2604 OID 16928)
-- Name: employee employee_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.employee ALTER COLUMN employee_id SET DEFAULT nextval('public.employee_employee_id_seq'::regclass);


--
-- TOC entry 3291 (class 2604 OID 16994)
-- Name: excludeditems excluded_item_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.excludeditems ALTER COLUMN excluded_item_id SET DEFAULT nextval('public.excludeditems_excluded_item_id_seq'::regclass);


--
-- TOC entry 3290 (class 2604 OID 16977)
-- Name: inventoryrecord record_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inventoryrecord ALTER COLUMN record_id SET DEFAULT nextval('public.inventoryrecord_record_id_seq'::regclass);


--
-- TOC entry 3293 (class 2604 OID 17017)
-- Name: passport passport_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.passport ALTER COLUMN passport_id SET DEFAULT nextval('public.passport_passport_id_seq'::regclass);


--
-- TOC entry 3289 (class 2604 OID 16945)
-- Name: position position_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."position" ALTER COLUMN position_id SET DEFAULT nextval('public.position_position_id_seq'::regclass);


--
-- TOC entry 3288 (class 2604 OID 16936)
-- Name: positioncatalog position_catalog_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.positioncatalog ALTER COLUMN position_catalog_id SET DEFAULT nextval('public.positioncatalog_position_catalog_id_seq'::regclass);


--
-- TOC entry 3292 (class 2604 OID 17007)
-- Name: reader reader_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reader ALTER COLUMN reader_id SET DEFAULT nextval('public.reader_reader_id_seq'::regclass);


--
-- TOC entry 3286 (class 2604 OID 16915)
-- Name: storage storage_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.storage ALTER COLUMN storage_id SET DEFAULT nextval('public.storage_storage_id_seq'::regclass);


--
-- TOC entry 3284 (class 2604 OID 16875)
-- Name: translator translator_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.translator ALTER COLUMN translator_id SET DEFAULT nextval('public.translator_translator_id_seq'::regclass);


--
-- TOC entry 3510 (class 0 OID 16838)
-- Dependencies: 218
-- Data for Name: author; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.author VALUES (1, 'Лев Толстой');
INSERT INTO public.author VALUES (2, 'Федор Достоевский');
INSERT INTO public.author VALUES (3, 'Антон Чехов');
INSERT INTO public.author VALUES (4, 'Александр Пушкин');
INSERT INTO public.author VALUES (5, 'Иван Тургенев');


--
-- TOC entry 3513 (class 0 OID 16856)
-- Dependencies: 221
-- Data for Name: authorbook; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 3512 (class 0 OID 16846)
-- Dependencies: 220
-- Data for Name: book; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.book VALUES (1, 'Война и мир', 'Роман', 'Литература', 'Русский', 'LC001', 1869);
INSERT INTO public.book VALUES (2, 'Преступление и наказание', 'Роман', 'Литература', 'Русский', 'LC002', 1866);


--
-- TOC entry 3518 (class 0 OID 16895)
-- Dependencies: 226
-- Data for Name: bookcopy; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.bookcopy VALUES (1, 1, 'INV001', 500.00);
INSERT INTO public.bookcopy VALUES (2, 2, 'INV002', 400.00);


--
-- TOC entry 3537 (class 0 OID 17028)
-- Dependencies: 245
-- Data for Name: bookloan; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.bookloan VALUES (1, 1, 1, '2024-03-01', '2024-03-31', NULL, NULL);


--
-- TOC entry 3522 (class 0 OID 16925)
-- Dependencies: 230
-- Data for Name: employee; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.employee VALUES (1, 'Алексей Смирнов');
INSERT INTO public.employee VALUES (2, 'Наталья Иванова');


--
-- TOC entry 3527 (class 0 OID 16958)
-- Dependencies: 235
-- Data for Name: employeeposition; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.employeeposition VALUES (1, 1);


--
-- TOC entry 3531 (class 0 OID 16991)
-- Dependencies: 239
-- Data for Name: excludeditems; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 3529 (class 0 OID 16974)
-- Dependencies: 237
-- Data for Name: inventoryrecord; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 3535 (class 0 OID 17014)
-- Dependencies: 243
-- Data for Name: passport; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.passport VALUES (1, 1, '1234567890', '2020-01-01', '2030-01-01');


--
-- TOC entry 3526 (class 0 OID 16942)
-- Dependencies: 234
-- Data for Name: position; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public."position" VALUES (1, 1, 1, 50000, '2024-01-01', '2025-01-01');


--
-- TOC entry 3524 (class 0 OID 16933)
-- Dependencies: 232
-- Data for Name: positioncatalog; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.positioncatalog VALUES (1, 'Библиотекарь');
INSERT INTO public.positioncatalog VALUES (2, 'Менеджер');


--
-- TOC entry 3533 (class 0 OID 17004)
-- Dependencies: 241
-- Data for Name: reader; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.reader VALUES (1, 'R001', 'Иван Иванов', 'Москва, ул. Ленина, д.1', '+79991112233', 'ivan@example.com');


--
-- TOC entry 3520 (class 0 OID 16912)
-- Dependencies: 228
-- Data for Name: storage; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 3515 (class 0 OID 16872)
-- Dependencies: 223
-- Data for Name: translator; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 3516 (class 0 OID 16879)
-- Dependencies: 224
-- Data for Name: translatorbook; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 3556 (class 0 OID 0)
-- Dependencies: 217
-- Name: author_author_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.author_author_id_seq', 5, true);


--
-- TOC entry 3557 (class 0 OID 0)
-- Dependencies: 219
-- Name: book_book_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.book_book_id_seq', 2, true);


--
-- TOC entry 3558 (class 0 OID 0)
-- Dependencies: 225
-- Name: bookcopy_copy_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.bookcopy_copy_id_seq', 2, true);


--
-- TOC entry 3559 (class 0 OID 0)
-- Dependencies: 244
-- Name: bookloan_loan_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.bookloan_loan_id_seq', 1, true);


--
-- TOC entry 3560 (class 0 OID 0)
-- Dependencies: 229
-- Name: employee_employee_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.employee_employee_id_seq', 2, true);


--
-- TOC entry 3561 (class 0 OID 0)
-- Dependencies: 238
-- Name: excludeditems_excluded_item_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.excludeditems_excluded_item_id_seq', 1, false);


--
-- TOC entry 3562 (class 0 OID 0)
-- Dependencies: 236
-- Name: inventoryrecord_record_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.inventoryrecord_record_id_seq', 1, false);


--
-- TOC entry 3563 (class 0 OID 0)
-- Dependencies: 242
-- Name: passport_passport_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.passport_passport_id_seq', 1, true);


--
-- TOC entry 3564 (class 0 OID 0)
-- Dependencies: 233
-- Name: position_position_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.position_position_id_seq', 1, true);


--
-- TOC entry 3565 (class 0 OID 0)
-- Dependencies: 231
-- Name: positioncatalog_position_catalog_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.positioncatalog_position_catalog_id_seq', 2, true);


--
-- TOC entry 3566 (class 0 OID 0)
-- Dependencies: 240
-- Name: reader_reader_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.reader_reader_id_seq', 1, true);


--
-- TOC entry 3567 (class 0 OID 0)
-- Dependencies: 227
-- Name: storage_storage_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.storage_storage_id_seq', 1, false);


--
-- TOC entry 3568 (class 0 OID 0)
-- Dependencies: 222
-- Name: translator_translator_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.translator_translator_id_seq', 1, false);


--
-- TOC entry 3312 (class 2606 OID 16844)
-- Name: author author_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.author
    ADD CONSTRAINT author_pkey PRIMARY KEY (author_id);


--
-- TOC entry 3318 (class 2606 OID 16860)
-- Name: authorbook authorbook_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.authorbook
    ADD CONSTRAINT authorbook_pkey PRIMARY KEY (book_id, author_id);


--
-- TOC entry 3314 (class 2606 OID 16855)
-- Name: book book_library_code_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.book
    ADD CONSTRAINT book_library_code_key UNIQUE (library_code);


--
-- TOC entry 3316 (class 2606 OID 16853)
-- Name: book book_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.book
    ADD CONSTRAINT book_pkey PRIMARY KEY (book_id);


--
-- TOC entry 3324 (class 2606 OID 16905)
-- Name: bookcopy bookcopy_inventory_number_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bookcopy
    ADD CONSTRAINT bookcopy_inventory_number_key UNIQUE (inventory_number);


--
-- TOC entry 3326 (class 2606 OID 16903)
-- Name: bookcopy bookcopy_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bookcopy
    ADD CONSTRAINT bookcopy_pkey PRIMARY KEY (copy_id);


--
-- TOC entry 3348 (class 2606 OID 17035)
-- Name: bookloan bookloan_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bookloan
    ADD CONSTRAINT bookloan_pkey PRIMARY KEY (loan_id);


--
-- TOC entry 3330 (class 2606 OID 16931)
-- Name: employee employee_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.employee
    ADD CONSTRAINT employee_pkey PRIMARY KEY (employee_id);


--
-- TOC entry 3338 (class 2606 OID 16962)
-- Name: employeeposition employeeposition_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.employeeposition
    ADD CONSTRAINT employeeposition_pkey PRIMARY KEY (employee_id, position_id);


--
-- TOC entry 3342 (class 2606 OID 16997)
-- Name: excludeditems excludeditems_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.excludeditems
    ADD CONSTRAINT excludeditems_pkey PRIMARY KEY (excluded_item_id);


--
-- TOC entry 3340 (class 2606 OID 16979)
-- Name: inventoryrecord inventoryrecord_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inventoryrecord
    ADD CONSTRAINT inventoryrecord_pkey PRIMARY KEY (record_id);


--
-- TOC entry 3346 (class 2606 OID 17021)
-- Name: passport passport_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.passport
    ADD CONSTRAINT passport_pkey PRIMARY KEY (passport_id);


--
-- TOC entry 3336 (class 2606 OID 16952)
-- Name: position position_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."position"
    ADD CONSTRAINT position_pkey PRIMARY KEY (position_id);


--
-- TOC entry 3332 (class 2606 OID 16938)
-- Name: positioncatalog positioncatalog_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.positioncatalog
    ADD CONSTRAINT positioncatalog_pkey PRIMARY KEY (position_catalog_id);


--
-- TOC entry 3334 (class 2606 OID 16940)
-- Name: positioncatalog positioncatalog_position_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.positioncatalog
    ADD CONSTRAINT positioncatalog_position_name_key UNIQUE (position_name);


--
-- TOC entry 3344 (class 2606 OID 17012)
-- Name: reader reader_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reader
    ADD CONSTRAINT reader_pkey PRIMARY KEY (reader_id);


--
-- TOC entry 3328 (class 2606 OID 16918)
-- Name: storage storage_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.storage
    ADD CONSTRAINT storage_pkey PRIMARY KEY (storage_id);


--
-- TOC entry 3320 (class 2606 OID 16878)
-- Name: translator translator_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.translator
    ADD CONSTRAINT translator_pkey PRIMARY KEY (translator_id);


--
-- TOC entry 3322 (class 2606 OID 16883)
-- Name: translatorbook translatorbook_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.translatorbook
    ADD CONSTRAINT translatorbook_pkey PRIMARY KEY (book_id, translator_id);


--
-- TOC entry 3349 (class 2606 OID 16866)
-- Name: authorbook authorbook_author_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.authorbook
    ADD CONSTRAINT authorbook_author_id_fkey FOREIGN KEY (author_id) REFERENCES public.author(author_id);


--
-- TOC entry 3350 (class 2606 OID 16861)
-- Name: authorbook authorbook_book_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.authorbook
    ADD CONSTRAINT authorbook_book_id_fkey FOREIGN KEY (book_id) REFERENCES public.book(book_id);


--
-- TOC entry 3353 (class 2606 OID 16906)
-- Name: bookcopy bookcopy_book_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bookcopy
    ADD CONSTRAINT bookcopy_book_id_fkey FOREIGN KEY (book_id) REFERENCES public.book(book_id);


--
-- TOC entry 3362 (class 2606 OID 17036)
-- Name: bookloan bookloan_copy_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bookloan
    ADD CONSTRAINT bookloan_copy_id_fkey FOREIGN KEY (copy_id) REFERENCES public.bookcopy(copy_id);


--
-- TOC entry 3363 (class 2606 OID 17041)
-- Name: bookloan bookloan_reader_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bookloan
    ADD CONSTRAINT bookloan_reader_id_fkey FOREIGN KEY (reader_id) REFERENCES public.reader(reader_id);


--
-- TOC entry 3356 (class 2606 OID 16963)
-- Name: employeeposition employeeposition_employee_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.employeeposition
    ADD CONSTRAINT employeeposition_employee_id_fkey FOREIGN KEY (employee_id) REFERENCES public.employee(employee_id);


--
-- TOC entry 3357 (class 2606 OID 16968)
-- Name: employeeposition employeeposition_position_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.employeeposition
    ADD CONSTRAINT employeeposition_position_id_fkey FOREIGN KEY (position_id) REFERENCES public."position"(position_id);


--
-- TOC entry 3360 (class 2606 OID 16998)
-- Name: excludeditems excludeditems_copy_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.excludeditems
    ADD CONSTRAINT excludeditems_copy_id_fkey FOREIGN KEY (copy_id) REFERENCES public.bookcopy(copy_id);


--
-- TOC entry 3358 (class 2606 OID 16980)
-- Name: inventoryrecord inventoryrecord_copy_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inventoryrecord
    ADD CONSTRAINT inventoryrecord_copy_id_fkey FOREIGN KEY (copy_id) REFERENCES public.bookcopy(copy_id);


--
-- TOC entry 3359 (class 2606 OID 16985)
-- Name: inventoryrecord inventoryrecord_employee_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inventoryrecord
    ADD CONSTRAINT inventoryrecord_employee_id_fkey FOREIGN KEY (employee_id) REFERENCES public.employee(employee_id);


--
-- TOC entry 3361 (class 2606 OID 17022)
-- Name: passport passport_reader_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.passport
    ADD CONSTRAINT passport_reader_id_fkey FOREIGN KEY (reader_id) REFERENCES public.reader(reader_id);


--
-- TOC entry 3355 (class 2606 OID 16953)
-- Name: position position_position_catalog_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."position"
    ADD CONSTRAINT position_position_catalog_id_fkey FOREIGN KEY (position_catalog_id) REFERENCES public.positioncatalog(position_catalog_id);


--
-- TOC entry 3354 (class 2606 OID 16919)
-- Name: storage storage_copy_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.storage
    ADD CONSTRAINT storage_copy_id_fkey FOREIGN KEY (copy_id) REFERENCES public.bookcopy(copy_id);


--
-- TOC entry 3351 (class 2606 OID 16884)
-- Name: translatorbook translatorbook_book_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.translatorbook
    ADD CONSTRAINT translatorbook_book_id_fkey FOREIGN KEY (book_id) REFERENCES public.book(book_id);


--
-- TOC entry 3352 (class 2606 OID 16889)
-- Name: translatorbook translatorbook_translator_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.translatorbook
    ADD CONSTRAINT translatorbook_translator_id_fkey FOREIGN KEY (translator_id) REFERENCES public.translator(translator_id);


-- Completed on 2025-03-17 10:25:53 UTC

--
-- PostgreSQL database dump complete
--

