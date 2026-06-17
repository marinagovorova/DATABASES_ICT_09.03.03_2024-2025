--
-- PostgreSQL database dump
--

-- Dumped from database version 17.5 (Homebrew)
-- Dumped by pg_dump version 17.0

-- Started on 2025-06-17 09:15:26 MSK

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
-- TOC entry 238 (class 1259 OID 16884)
-- Name: act; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.act (
    act_id integer NOT NULL
);


ALTER TABLE public.act OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 16883)
-- Name: act_act_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.act_act_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.act_act_id_seq OWNER TO postgres;

--
-- TOC entry 3999 (class 0 OID 0)
-- Dependencies: 237
-- Name: act_act_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.act_act_id_seq OWNED BY public.act.act_id;


--
-- TOC entry 218 (class 1259 OID 16769)
-- Name: author; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.author (
    author_id integer NOT NULL,
    last_name text NOT NULL,
    first_name text NOT NULL,
    middle_name text,
    email text,
    phone text
);


ALTER TABLE public.author OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16768)
-- Name: author_author_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.author_author_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.author_author_id_seq OWNER TO postgres;

--
-- TOC entry 4000 (class 0 OID 0)
-- Dependencies: 217
-- Name: author_author_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.author_author_id_seq OWNED BY public.author.author_id;


--
-- TOC entry 250 (class 1259 OID 16968)
-- Name: authorship; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authorship (
    authorship_id integer NOT NULL,
    author_id integer,
    book_id integer,
    author_order integer
);


ALTER TABLE public.authorship OWNER TO postgres;

--
-- TOC entry 249 (class 1259 OID 16967)
-- Name: authorship_authorship_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.authorship_authorship_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.authorship_authorship_id_seq OWNER TO postgres;

--
-- TOC entry 4001 (class 0 OID 0)
-- Dependencies: 249
-- Name: authorship_authorship_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.authorship_authorship_id_seq OWNED BY public.authorship.authorship_id;


--
-- TOC entry 224 (class 1259 OID 16794)
-- Name: book; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.book (
    book_id integer NOT NULL,
    isbn text NOT NULL,
    title text NOT NULL,
    publish_year integer,
    page_count integer,
    category_id integer,
    has_illustrations boolean,
    price numeric(10,2),
    print_run_id integer
);


ALTER TABLE public.book OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16793)
-- Name: book_book_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.book_book_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.book_book_id_seq OWNER TO postgres;

--
-- TOC entry 4002 (class 0 OID 0)
-- Dependencies: 223
-- Name: book_book_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.book_book_id_seq OWNED BY public.book.book_id;


--
-- TOC entry 220 (class 1259 OID 16778)
-- Name: category; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.category (
    category_id integer NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.category OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16777)
-- Name: category_category_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.category_category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.category_category_id_seq OWNER TO postgres;

--
-- TOC entry 4003 (class 0 OID 0)
-- Dependencies: 219
-- Name: category_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.category_category_id_seq OWNED BY public.category.category_id;


--
-- TOC entry 232 (class 1259 OID 16857)
-- Name: client; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client (
    client_id integer NOT NULL,
    last_name text NOT NULL,
    first_name text NOT NULL,
    middle_name text,
    phone text,
    address text
);


ALTER TABLE public.client OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 16856)
-- Name: client_client_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.client_client_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.client_client_id_seq OWNER TO postgres;

--
-- TOC entry 4004 (class 0 OID 0)
-- Dependencies: 231
-- Name: client_client_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.client_client_id_seq OWNED BY public.client.client_id;


--
-- TOC entry 230 (class 1259 OID 16838)
-- Name: edition; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.edition (
    edition_id integer NOT NULL,
    edition_type text,
    edition_number integer,
    book_id integer,
    tech_task_id integer
);


ALTER TABLE public.edition OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 16837)
-- Name: edition_edition_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.edition_edition_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.edition_edition_id_seq OWNER TO postgres;

--
-- TOC entry 4005 (class 0 OID 0)
-- Dependencies: 229
-- Name: edition_edition_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.edition_edition_id_seq OWNED BY public.edition.edition_id;


--
-- TOC entry 226 (class 1259 OID 16815)
-- Name: editor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.editor (
    editor_id integer NOT NULL,
    last_name text NOT NULL,
    first_name text NOT NULL,
    middle_name text,
    list_order integer
);


ALTER TABLE public.editor OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16814)
-- Name: editor_editor_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.editor_editor_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.editor_editor_id_seq OWNER TO postgres;

--
-- TOC entry 4006 (class 0 OID 0)
-- Dependencies: 225
-- Name: editor_editor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.editor_editor_id_seq OWNED BY public.editor.editor_id;


--
-- TOC entry 252 (class 1259 OID 16985)
-- Name: editor_participation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.editor_participation (
    participation_id integer NOT NULL,
    editor_id integer,
    tech_task_id integer,
    is_main boolean
);


ALTER TABLE public.editor_participation OWNER TO postgres;

--
-- TOC entry 251 (class 1259 OID 16984)
-- Name: editor_participation_participation_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.editor_participation_participation_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.editor_participation_participation_id_seq OWNER TO postgres;

--
-- TOC entry 4007 (class 0 OID 0)
-- Dependencies: 251
-- Name: editor_participation_participation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.editor_participation_participation_id_seq OWNED BY public.editor_participation.participation_id;


--
-- TOC entry 242 (class 1259 OID 16918)
-- Name: invoice; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.invoice (
    invoice_id integer NOT NULL,
    order_id integer,
    invoice_date date,
    prepayment numeric(10,2),
    balance numeric(10,2)
);


ALTER TABLE public.invoice OWNER TO postgres;

--
-- TOC entry 241 (class 1259 OID 16917)
-- Name: invoice_invoice_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.invoice_invoice_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.invoice_invoice_id_seq OWNER TO postgres;

--
-- TOC entry 4008 (class 0 OID 0)
-- Dependencies: 241
-- Name: invoice_invoice_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.invoice_invoice_id_seq OWNED BY public.invoice.invoice_id;


--
-- TOC entry 246 (class 1259 OID 16939)
-- Name: job_history; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.job_history (
    history_id integer NOT NULL,
    start_date date NOT NULL,
    end_date date,
    position_id integer,
    employee_id integer
);


ALTER TABLE public.job_history OWNER TO postgres;

--
-- TOC entry 245 (class 1259 OID 16938)
-- Name: job_history_history_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.job_history_history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.job_history_history_id_seq OWNER TO postgres;

--
-- TOC entry 4009 (class 0 OID 0)
-- Dependencies: 245
-- Name: job_history_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.job_history_history_id_seq OWNED BY public.job_history.history_id;


--
-- TOC entry 234 (class 1259 OID 16866)
-- Name: manager; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.manager (
    manager_id integer NOT NULL,
    last_name text NOT NULL,
    first_name text NOT NULL,
    middle_name text,
    phone text
);


ALTER TABLE public.manager OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 16865)
-- Name: manager_manager_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.manager_manager_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.manager_manager_id_seq OWNER TO postgres;

--
-- TOC entry 4010 (class 0 OID 0)
-- Dependencies: 233
-- Name: manager_manager_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.manager_manager_id_seq OWNED BY public.manager.manager_id;


--
-- TOC entry 236 (class 1259 OID 16875)
-- Name: order_status; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_status (
    status_id integer NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.order_status OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 16874)
-- Name: order_status_status_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.order_status_status_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.order_status_status_id_seq OWNER TO postgres;

--
-- TOC entry 4011 (class 0 OID 0)
-- Dependencies: 235
-- Name: order_status_status_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.order_status_status_id_seq OWNED BY public.order_status.status_id;


--
-- TOC entry 248 (class 1259 OID 16951)
-- Name: ordered_books; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ordered_books (
    ordered_book_id integer NOT NULL,
    print_run_id integer,
    order_id integer,
    quantity integer NOT NULL
);


ALTER TABLE public.ordered_books OWNER TO postgres;

--
-- TOC entry 247 (class 1259 OID 16950)
-- Name: ordered_books_ordered_book_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ordered_books_ordered_book_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.ordered_books_ordered_book_id_seq OWNER TO postgres;

--
-- TOC entry 4012 (class 0 OID 0)
-- Dependencies: 247
-- Name: ordered_books_ordered_book_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ordered_books_ordered_book_id_seq OWNED BY public.ordered_books.ordered_book_id;


--
-- TOC entry 240 (class 1259 OID 16891)
-- Name: orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orders (
    order_id integer NOT NULL,
    order_date date,
    deadline date,
    completion_date date,
    status_id integer,
    client_id integer,
    manager_id integer,
    act_id integer
);


ALTER TABLE public.orders OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 16890)
-- Name: orders_order_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.orders_order_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.orders_order_id_seq OWNER TO postgres;

--
-- TOC entry 4013 (class 0 OID 0)
-- Dependencies: 239
-- Name: orders_order_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.orders_order_id_seq OWNED BY public.orders.order_id;


--
-- TOC entry 244 (class 1259 OID 16930)
-- Name: position; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."position" (
    position_id integer NOT NULL,
    name text NOT NULL,
    salary numeric(10,2)
);


ALTER TABLE public."position" OWNER TO postgres;

--
-- TOC entry 243 (class 1259 OID 16929)
-- Name: position_position_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.position_position_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.position_position_id_seq OWNER TO postgres;

--
-- TOC entry 4014 (class 0 OID 0)
-- Dependencies: 243
-- Name: position_position_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.position_position_id_seq OWNED BY public."position".position_id;


--
-- TOC entry 222 (class 1259 OID 16787)
-- Name: print_run; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.print_run (
    print_run_id integer NOT NULL,
    quantity integer NOT NULL,
    remaining integer NOT NULL,
    date date NOT NULL
);


ALTER TABLE public.print_run OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16786)
-- Name: print_run_print_run_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.print_run_print_run_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.print_run_print_run_id_seq OWNER TO postgres;

--
-- TOC entry 4015 (class 0 OID 0)
-- Dependencies: 221
-- Name: print_run_print_run_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.print_run_print_run_id_seq OWNED BY public.print_run.print_run_id;


--
-- TOC entry 228 (class 1259 OID 16824)
-- Name: tech_task; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tech_task (
    tech_task_id integer NOT NULL,
    description text,
    cover_type text,
    has_illustrations boolean,
    editor_id integer,
    paper_type text
);


ALTER TABLE public.tech_task OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 16823)
-- Name: tech_task_tech_task_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tech_task_tech_task_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tech_task_tech_task_id_seq OWNER TO postgres;

--
-- TOC entry 4016 (class 0 OID 0)
-- Dependencies: 227
-- Name: tech_task_tech_task_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tech_task_tech_task_id_seq OWNED BY public.tech_task.tech_task_id;


--
-- TOC entry 3750 (class 2604 OID 16887)
-- Name: act act_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.act ALTER COLUMN act_id SET DEFAULT nextval('public.act_act_id_seq'::regclass);


--
-- TOC entry 3740 (class 2604 OID 16772)
-- Name: author author_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.author ALTER COLUMN author_id SET DEFAULT nextval('public.author_author_id_seq'::regclass);


--
-- TOC entry 3756 (class 2604 OID 16971)
-- Name: authorship authorship_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authorship ALTER COLUMN authorship_id SET DEFAULT nextval('public.authorship_authorship_id_seq'::regclass);


--
-- TOC entry 3743 (class 2604 OID 16797)
-- Name: book book_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book ALTER COLUMN book_id SET DEFAULT nextval('public.book_book_id_seq'::regclass);


--
-- TOC entry 3741 (class 2604 OID 16781)
-- Name: category category_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.category ALTER COLUMN category_id SET DEFAULT nextval('public.category_category_id_seq'::regclass);


--
-- TOC entry 3747 (class 2604 OID 16860)
-- Name: client client_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client ALTER COLUMN client_id SET DEFAULT nextval('public.client_client_id_seq'::regclass);


--
-- TOC entry 3746 (class 2604 OID 16841)
-- Name: edition edition_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.edition ALTER COLUMN edition_id SET DEFAULT nextval('public.edition_edition_id_seq'::regclass);


--
-- TOC entry 3744 (class 2604 OID 16818)
-- Name: editor editor_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.editor ALTER COLUMN editor_id SET DEFAULT nextval('public.editor_editor_id_seq'::regclass);


--
-- TOC entry 3757 (class 2604 OID 16988)
-- Name: editor_participation participation_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.editor_participation ALTER COLUMN participation_id SET DEFAULT nextval('public.editor_participation_participation_id_seq'::regclass);


--
-- TOC entry 3752 (class 2604 OID 16921)
-- Name: invoice invoice_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoice ALTER COLUMN invoice_id SET DEFAULT nextval('public.invoice_invoice_id_seq'::regclass);


--
-- TOC entry 3754 (class 2604 OID 16942)
-- Name: job_history history_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job_history ALTER COLUMN history_id SET DEFAULT nextval('public.job_history_history_id_seq'::regclass);


--
-- TOC entry 3748 (class 2604 OID 16869)
-- Name: manager manager_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.manager ALTER COLUMN manager_id SET DEFAULT nextval('public.manager_manager_id_seq'::regclass);


--
-- TOC entry 3749 (class 2604 OID 16878)
-- Name: order_status status_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_status ALTER COLUMN status_id SET DEFAULT nextval('public.order_status_status_id_seq'::regclass);


--
-- TOC entry 3755 (class 2604 OID 16954)
-- Name: ordered_books ordered_book_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ordered_books ALTER COLUMN ordered_book_id SET DEFAULT nextval('public.ordered_books_ordered_book_id_seq'::regclass);


--
-- TOC entry 3751 (class 2604 OID 16894)
-- Name: orders order_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders ALTER COLUMN order_id SET DEFAULT nextval('public.orders_order_id_seq'::regclass);


--
-- TOC entry 3753 (class 2604 OID 16933)
-- Name: position position_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."position" ALTER COLUMN position_id SET DEFAULT nextval('public.position_position_id_seq'::regclass);


--
-- TOC entry 3742 (class 2604 OID 16790)
-- Name: print_run print_run_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.print_run ALTER COLUMN print_run_id SET DEFAULT nextval('public.print_run_print_run_id_seq'::regclass);


--
-- TOC entry 3745 (class 2604 OID 16827)
-- Name: tech_task tech_task_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tech_task ALTER COLUMN tech_task_id SET DEFAULT nextval('public.tech_task_tech_task_id_seq'::regclass);


--
-- TOC entry 3979 (class 0 OID 16884)
-- Dependencies: 238
-- Data for Name: act; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.act (act_id) FROM stdin;
1
\.


--
-- TOC entry 3959 (class 0 OID 16769)
-- Dependencies: 218
-- Data for Name: author; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.author (author_id, last_name, first_name, middle_name, email, phone) FROM stdin;
1	Смирнов	Иван	Петрович	smirnov@example.com	9010000005
2	Козлова	Ольга	Игоревна	kozlova@example.com	9010000006
\.


--
-- TOC entry 3991 (class 0 OID 16968)
-- Dependencies: 250
-- Data for Name: authorship; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authorship (authorship_id, author_id, book_id, author_order) FROM stdin;
1	1	1	1
2	2	1	2
3	2	2	1
\.


--
-- TOC entry 3965 (class 0 OID 16794)
-- Dependencies: 224
-- Data for Name: book; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.book (book_id, isbn, title, publish_year, page_count, category_id, has_illustrations, price, print_run_id) FROM stdin;
1	978-5-4461-0923-0	Основы PostgreSQL	2024	320	1	t	950.00	1
2	978-5-4461-1024-3	Сетевое программирование	2023	280	3	f	850.00	2
\.


--
-- TOC entry 3961 (class 0 OID 16778)
-- Dependencies: 220
-- Data for Name: category; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.category (category_id, name) FROM stdin;
1	Базы данных
2	Языки программирования
3	Сетевые технологии
\.


--
-- TOC entry 3973 (class 0 OID 16857)
-- Dependencies: 232
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client (client_id, last_name, first_name, middle_name, phone, address) FROM stdin;
1	Петров	Андрей	Игоревич	9010000001	ул. Ленина, 12
2	Сидоров	Борис	Александрович	9010000002	ул. Мира, 45
\.


--
-- TOC entry 3971 (class 0 OID 16838)
-- Dependencies: 230
-- Data for Name: edition; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.edition (edition_id, edition_type, edition_number, book_id, tech_task_id) FROM stdin;
1	Учебник	1	1	1
2	Справочник	2	2	2
\.


--
-- TOC entry 3967 (class 0 OID 16815)
-- Dependencies: 226
-- Data for Name: editor; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.editor (editor_id, last_name, first_name, middle_name, list_order) FROM stdin;
1	Фёдоров	Антон	Леонидович	1
2	Мельник	Елена	Владимировна	2
\.


--
-- TOC entry 3993 (class 0 OID 16985)
-- Dependencies: 252
-- Data for Name: editor_participation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.editor_participation (participation_id, editor_id, tech_task_id, is_main) FROM stdin;
1	1	1	t
2	2	1	f
\.


--
-- TOC entry 3983 (class 0 OID 16918)
-- Dependencies: 242
-- Data for Name: invoice; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.invoice (invoice_id, order_id, invoice_date, prepayment, balance) FROM stdin;
1	1	2025-04-01	5000.00	2000.00
2	2	2025-04-05	3000.00	1500.00
\.


--
-- TOC entry 3987 (class 0 OID 16939)
-- Dependencies: 246
-- Data for Name: job_history; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.job_history (history_id, start_date, end_date, position_id, employee_id) FROM stdin;
1	2023-01-01	2024-01-01	1	1
\.


--
-- TOC entry 3975 (class 0 OID 16866)
-- Dependencies: 234
-- Data for Name: manager; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.manager (manager_id, last_name, first_name, middle_name, phone) FROM stdin;
1	Иванов	Дмитрий	Васильевич	9010000003
2	Кузнецова	Мария	Сергеевна	9010000004
\.


--
-- TOC entry 3977 (class 0 OID 16875)
-- Dependencies: 236
-- Data for Name: order_status; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.order_status (status_id, name) FROM stdin;
1	оплачен
2	ожидает оплаты
3	отменен
\.


--
-- TOC entry 3989 (class 0 OID 16951)
-- Dependencies: 248
-- Data for Name: ordered_books; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ordered_books (ordered_book_id, print_run_id, order_id, quantity) FROM stdin;
1	1	1	10
2	2	2	5
\.


--
-- TOC entry 3981 (class 0 OID 16891)
-- Dependencies: 240
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.orders (order_id, order_date, deadline, completion_date, status_id, client_id, manager_id, act_id) FROM stdin;
1	2025-04-01	2025-04-11	2025-04-10	1	1	1	1
2	2025-04-05	2025-04-12	2025-04-12	2	2	2	1
\.


--
-- TOC entry 3985 (class 0 OID 16930)
-- Dependencies: 244
-- Data for Name: position; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."position" (position_id, name, salary) FROM stdin;
1	Менеджер проектов	70000.00
2	Редактор	60000.00
3	Программист	80000.00
\.


--
-- TOC entry 3963 (class 0 OID 16787)
-- Dependencies: 222
-- Data for Name: print_run; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.print_run (print_run_id, quantity, remaining, date) FROM stdin;
1	1000	200	2024-02-10
2	500	0	2023-11-15
\.


--
-- TOC entry 3969 (class 0 OID 16824)
-- Dependencies: 228
-- Data for Name: tech_task; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tech_task (tech_task_id, description, cover_type, has_illustrations, editor_id, paper_type) FROM stdin;
1	Первое издание с иллюстрациями	Твердый переплет	t	1	Мелованная бумага
2	Переиздание без иллюстраций	Мягкий переплет	f	2	Офсетная бумага
\.


--
-- TOC entry 4017 (class 0 OID 0)
-- Dependencies: 237
-- Name: act_act_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.act_act_id_seq', 1, true);


--
-- TOC entry 4018 (class 0 OID 0)
-- Dependencies: 217
-- Name: author_author_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.author_author_id_seq', 6, true);


--
-- TOC entry 4019 (class 0 OID 0)
-- Dependencies: 249
-- Name: authorship_authorship_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.authorship_authorship_id_seq', 3, true);


--
-- TOC entry 4020 (class 0 OID 0)
-- Dependencies: 223
-- Name: book_book_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.book_book_id_seq', 2, true);


--
-- TOC entry 4021 (class 0 OID 0)
-- Dependencies: 219
-- Name: category_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.category_category_id_seq', 9, true);


--
-- TOC entry 4022 (class 0 OID 0)
-- Dependencies: 231
-- Name: client_client_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.client_client_id_seq', 6, true);


--
-- TOC entry 4023 (class 0 OID 0)
-- Dependencies: 229
-- Name: edition_edition_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.edition_edition_id_seq', 2, true);


--
-- TOC entry 4024 (class 0 OID 0)
-- Dependencies: 225
-- Name: editor_editor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.editor_editor_id_seq', 6, true);


--
-- TOC entry 4025 (class 0 OID 0)
-- Dependencies: 251
-- Name: editor_participation_participation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.editor_participation_participation_id_seq', 2, true);


--
-- TOC entry 4026 (class 0 OID 0)
-- Dependencies: 241
-- Name: invoice_invoice_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.invoice_invoice_id_seq', 1, false);


--
-- TOC entry 4027 (class 0 OID 0)
-- Dependencies: 245
-- Name: job_history_history_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.job_history_history_id_seq', 1, false);


--
-- TOC entry 4028 (class 0 OID 0)
-- Dependencies: 233
-- Name: manager_manager_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.manager_manager_id_seq', 6, true);


--
-- TOC entry 4029 (class 0 OID 0)
-- Dependencies: 235
-- Name: order_status_status_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.order_status_status_id_seq', 9, true);


--
-- TOC entry 4030 (class 0 OID 0)
-- Dependencies: 247
-- Name: ordered_books_ordered_book_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ordered_books_ordered_book_id_seq', 1, false);


--
-- TOC entry 4031 (class 0 OID 0)
-- Dependencies: 239
-- Name: orders_order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.orders_order_id_seq', 1, false);


--
-- TOC entry 4032 (class 0 OID 0)
-- Dependencies: 243
-- Name: position_position_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.position_position_id_seq', 9, true);


--
-- TOC entry 4033 (class 0 OID 0)
-- Dependencies: 221
-- Name: print_run_print_run_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.print_run_print_run_id_seq', 2, true);


--
-- TOC entry 4034 (class 0 OID 0)
-- Dependencies: 227
-- Name: tech_task_tech_task_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tech_task_tech_task_id_seq', 6, true);


--
-- TOC entry 3781 (class 2606 OID 16889)
-- Name: act act_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.act
    ADD CONSTRAINT act_pkey PRIMARY KEY (act_id);


--
-- TOC entry 3759 (class 2606 OID 16776)
-- Name: author author_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.author
    ADD CONSTRAINT author_pkey PRIMARY KEY (author_id);


--
-- TOC entry 3793 (class 2606 OID 16973)
-- Name: authorship authorship_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authorship
    ADD CONSTRAINT authorship_pkey PRIMARY KEY (authorship_id);


--
-- TOC entry 3765 (class 2606 OID 16803)
-- Name: book book_isbn_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book
    ADD CONSTRAINT book_isbn_key UNIQUE (isbn);


--
-- TOC entry 3767 (class 2606 OID 16801)
-- Name: book book_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book
    ADD CONSTRAINT book_pkey PRIMARY KEY (book_id);


--
-- TOC entry 3761 (class 2606 OID 16785)
-- Name: category category_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.category
    ADD CONSTRAINT category_pkey PRIMARY KEY (category_id);


--
-- TOC entry 3775 (class 2606 OID 16864)
-- Name: client client_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT client_pkey PRIMARY KEY (client_id);


--
-- TOC entry 3773 (class 2606 OID 16845)
-- Name: edition edition_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.edition
    ADD CONSTRAINT edition_pkey PRIMARY KEY (edition_id);


--
-- TOC entry 3795 (class 2606 OID 16990)
-- Name: editor_participation editor_participation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.editor_participation
    ADD CONSTRAINT editor_participation_pkey PRIMARY KEY (participation_id);


--
-- TOC entry 3769 (class 2606 OID 16822)
-- Name: editor editor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.editor
    ADD CONSTRAINT editor_pkey PRIMARY KEY (editor_id);


--
-- TOC entry 3785 (class 2606 OID 16923)
-- Name: invoice invoice_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoice
    ADD CONSTRAINT invoice_pkey PRIMARY KEY (invoice_id);


--
-- TOC entry 3789 (class 2606 OID 16944)
-- Name: job_history job_history_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job_history
    ADD CONSTRAINT job_history_pkey PRIMARY KEY (history_id);


--
-- TOC entry 3777 (class 2606 OID 16873)
-- Name: manager manager_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.manager
    ADD CONSTRAINT manager_pkey PRIMARY KEY (manager_id);


--
-- TOC entry 3779 (class 2606 OID 16882)
-- Name: order_status order_status_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_status
    ADD CONSTRAINT order_status_pkey PRIMARY KEY (status_id);


--
-- TOC entry 3791 (class 2606 OID 16956)
-- Name: ordered_books ordered_books_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ordered_books
    ADD CONSTRAINT ordered_books_pkey PRIMARY KEY (ordered_book_id);


--
-- TOC entry 3783 (class 2606 OID 16896)
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (order_id);


--
-- TOC entry 3787 (class 2606 OID 16937)
-- Name: position position_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."position"
    ADD CONSTRAINT position_pkey PRIMARY KEY (position_id);


--
-- TOC entry 3763 (class 2606 OID 16792)
-- Name: print_run print_run_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.print_run
    ADD CONSTRAINT print_run_pkey PRIMARY KEY (print_run_id);


--
-- TOC entry 3771 (class 2606 OID 16831)
-- Name: tech_task tech_task_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tech_task
    ADD CONSTRAINT tech_task_pkey PRIMARY KEY (tech_task_id);


--
-- TOC entry 3809 (class 2606 OID 16974)
-- Name: authorship authorship_author_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authorship
    ADD CONSTRAINT authorship_author_id_fkey FOREIGN KEY (author_id) REFERENCES public.author(author_id);


--
-- TOC entry 3810 (class 2606 OID 16979)
-- Name: authorship authorship_book_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authorship
    ADD CONSTRAINT authorship_book_id_fkey FOREIGN KEY (book_id) REFERENCES public.book(book_id);


--
-- TOC entry 3796 (class 2606 OID 16804)
-- Name: book book_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book
    ADD CONSTRAINT book_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.category(category_id);


--
-- TOC entry 3797 (class 2606 OID 16809)
-- Name: book book_print_run_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book
    ADD CONSTRAINT book_print_run_id_fkey FOREIGN KEY (print_run_id) REFERENCES public.print_run(print_run_id);


--
-- TOC entry 3799 (class 2606 OID 16846)
-- Name: edition edition_book_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.edition
    ADD CONSTRAINT edition_book_id_fkey FOREIGN KEY (book_id) REFERENCES public.book(book_id);


--
-- TOC entry 3800 (class 2606 OID 16851)
-- Name: edition edition_tech_task_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.edition
    ADD CONSTRAINT edition_tech_task_id_fkey FOREIGN KEY (tech_task_id) REFERENCES public.tech_task(tech_task_id);


--
-- TOC entry 3811 (class 2606 OID 16991)
-- Name: editor_participation editor_participation_editor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.editor_participation
    ADD CONSTRAINT editor_participation_editor_id_fkey FOREIGN KEY (editor_id) REFERENCES public.editor(editor_id);


--
-- TOC entry 3812 (class 2606 OID 16996)
-- Name: editor_participation editor_participation_tech_task_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.editor_participation
    ADD CONSTRAINT editor_participation_tech_task_id_fkey FOREIGN KEY (tech_task_id) REFERENCES public.tech_task(tech_task_id);


--
-- TOC entry 3805 (class 2606 OID 16924)
-- Name: invoice invoice_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoice
    ADD CONSTRAINT invoice_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(order_id);


--
-- TOC entry 3806 (class 2606 OID 16945)
-- Name: job_history job_history_position_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job_history
    ADD CONSTRAINT job_history_position_id_fkey FOREIGN KEY (position_id) REFERENCES public."position"(position_id);


--
-- TOC entry 3807 (class 2606 OID 16962)
-- Name: ordered_books ordered_books_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ordered_books
    ADD CONSTRAINT ordered_books_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(order_id);


--
-- TOC entry 3808 (class 2606 OID 16957)
-- Name: ordered_books ordered_books_print_run_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ordered_books
    ADD CONSTRAINT ordered_books_print_run_id_fkey FOREIGN KEY (print_run_id) REFERENCES public.print_run(print_run_id);


--
-- TOC entry 3801 (class 2606 OID 16912)
-- Name: orders orders_act_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_act_id_fkey FOREIGN KEY (act_id) REFERENCES public.act(act_id);


--
-- TOC entry 3802 (class 2606 OID 16902)
-- Name: orders orders_client_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_client_id_fkey FOREIGN KEY (client_id) REFERENCES public.client(client_id);


--
-- TOC entry 3803 (class 2606 OID 16907)
-- Name: orders orders_manager_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_manager_id_fkey FOREIGN KEY (manager_id) REFERENCES public.manager(manager_id);


--
-- TOC entry 3804 (class 2606 OID 16897)
-- Name: orders orders_status_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_status_id_fkey FOREIGN KEY (status_id) REFERENCES public.order_status(status_id);


--
-- TOC entry 3798 (class 2606 OID 16832)
-- Name: tech_task tech_task_editor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tech_task
    ADD CONSTRAINT tech_task_editor_id_fkey FOREIGN KEY (editor_id) REFERENCES public.editor(editor_id);


-- Completed on 2025-06-17 09:15:26 MSK

--
-- PostgreSQL database dump complete
--

