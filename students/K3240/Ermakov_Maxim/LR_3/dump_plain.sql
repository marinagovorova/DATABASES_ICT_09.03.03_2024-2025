--
-- PostgreSQL database dump
--

-- Dumped from database version 15.12
-- Dumped by pg_dump version 15.12

-- Started on 2025-04-03 15:22:44 MSK

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

DROP DATABASE company;
--
-- TOC entry 3740 (class 1262 OID 16670)
-- Name: company; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE company WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'C';


ALTER DATABASE company OWNER TO postgres;

\connect company

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
-- TOC entry 223 (class 1259 OID 16718)
-- Name: branch; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.branch (
    branch_id integer NOT NULL,
    address text NOT NULL,
    branch_name character varying(100) NOT NULL
);


ALTER TABLE public.branch OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16717)
-- Name: branch_branch_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.branch_branch_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.branch_branch_id_seq OWNER TO postgres;

--
-- TOC entry 3741 (class 0 OID 0)
-- Dependencies: 222
-- Name: branch_branch_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.branch_branch_id_seq OWNED BY public.branch.branch_id;


--
-- TOC entry 225 (class 1259 OID 16727)
-- Name: customer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customer (
    customer_id integer NOT NULL,
    company_name character varying(100) NOT NULL,
    city character varying(100),
    country character varying(50),
    phone character varying(20)
);


ALTER TABLE public.customer OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 16726)
-- Name: customer_customer_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.customer_customer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.customer_customer_id_seq OWNER TO postgres;

--
-- TOC entry 3742 (class 0 OID 0)
-- Dependencies: 224
-- Name: customer_customer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.customer_customer_id_seq OWNED BY public.customer.customer_id;


--
-- TOC entry 237 (class 1259 OID 16855)
-- Name: invoice; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.invoice (
    invoice_id integer NOT NULL,
    order_id integer NOT NULL,
    amount integer NOT NULL,
    issue_date date NOT NULL,
    payment_date date,
    payment_status character varying(20) NOT NULL,
    CONSTRAINT invoice_amount_check CHECK ((amount >= 0)),
    CONSTRAINT invoice_payment_status_check CHECK (((payment_status)::text = ANY ((ARRAY['ожидание'::character varying, 'оплачен'::character varying, 'отменён'::character varying])::text[])))
);


ALTER TABLE public.invoice OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 16854)
-- Name: invoice_invoice_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.invoice_invoice_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.invoice_invoice_id_seq OWNER TO postgres;

--
-- TOC entry 3743 (class 0 OID 0)
-- Dependencies: 236
-- Name: invoice_invoice_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.invoice_invoice_id_seq OWNED BY public.invoice.invoice_id;


--
-- TOC entry 221 (class 1259 OID 16702)
-- Name: manager; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.manager (
    manager_id integer NOT NULL,
    position_id integer NOT NULL,
    employee_code integer NOT NULL,
    full_name character varying(100) NOT NULL,
    phone_number character varying(20) NOT NULL
);


ALTER TABLE public.manager OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16701)
-- Name: manager_manager_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.manager_manager_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.manager_manager_id_seq OWNER TO postgres;

--
-- TOC entry 3744 (class 0 OID 0)
-- Dependencies: 220
-- Name: manager_manager_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.manager_manager_id_seq OWNED BY public.manager.manager_id;


--
-- TOC entry 219 (class 1259 OID 16695)
-- Name: manager_position; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.manager_position (
    position_id integer NOT NULL,
    position_name character varying(50) NOT NULL,
    salary_rate integer
);


ALTER TABLE public.manager_position OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16694)
-- Name: manager_position_position_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.manager_position_position_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.manager_position_position_id_seq OWNER TO postgres;

--
-- TOC entry 3745 (class 0 OID 0)
-- Dependencies: 218
-- Name: manager_position_position_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.manager_position_position_id_seq OWNED BY public.manager_position.position_id;


--
-- TOC entry 215 (class 1259 OID 16672)
-- Name: manufacturer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.manufacturer (
    manufacturer_id integer NOT NULL,
    company_name character varying(50) NOT NULL,
    city character varying(50) NOT NULL,
    country character varying(50) NOT NULL,
    tax_id bigint NOT NULL
);


ALTER TABLE public.manufacturer OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 16671)
-- Name: manufacturer_manufacturer_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.manufacturer_manufacturer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.manufacturer_manufacturer_id_seq OWNER TO postgres;

--
-- TOC entry 3746 (class 0 OID 0)
-- Dependencies: 214
-- Name: manufacturer_manufacturer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.manufacturer_manufacturer_id_seq OWNED BY public.manufacturer.manufacturer_id;


--
-- TOC entry 235 (class 1259 OID 16831)
-- Name: order_details; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_details (
    order_details_id integer NOT NULL,
    supply_details_id integer,
    order_id integer,
    total_price integer,
    quantity integer,
    unit_price integer,
    unit_measure character varying(20)
);


ALTER TABLE public.order_details OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 16830)
-- Name: order_details_order_details_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.order_details_order_details_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.order_details_order_details_id_seq OWNER TO postgres;

--
-- TOC entry 3747 (class 0 OID 0)
-- Dependencies: 234
-- Name: order_details_order_details_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.order_details_order_details_id_seq OWNED BY public.order_details.order_details_id;


--
-- TOC entry 227 (class 1259 OID 16734)
-- Name: orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orders (
    order_id integer NOT NULL,
    customer_id integer,
    order_date date NOT NULL,
    delivery_date date,
    payment_status character varying(20),
    processing_status character varying(20),
    manager_id integer,
    branch_id integer,
    delivery_address text DEFAULT 'Не указан'::text NOT NULL,
    CONSTRAINT orders_payment_status_check CHECK (((payment_status)::text = ANY ((ARRAY['ожидание'::character varying, 'оплачен'::character varying, 'отменён'::character varying])::text[]))),
    CONSTRAINT orders_processing_status_check CHECK (((processing_status)::text = ANY ((ARRAY['новый'::character varying, 'в обработке'::character varying, 'завершён'::character varying, 'отменён'::character varying])::text[])))
);


ALTER TABLE public.orders OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 16733)
-- Name: orders_order_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.orders_order_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.orders_order_id_seq OWNER TO postgres;

--
-- TOC entry 3748 (class 0 OID 0)
-- Dependencies: 226
-- Name: orders_order_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.orders_order_id_seq OWNED BY public.orders.order_id;


--
-- TOC entry 217 (class 1259 OID 16681)
-- Name: product; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product (
    product_id integer NOT NULL,
    manufacturer_id integer NOT NULL,
    product_name character varying(100) NOT NULL,
    stock_quantity integer NOT NULL,
    description text
);


ALTER TABLE public.product OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 16680)
-- Name: product_product_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.product_product_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.product_product_id_seq OWNER TO postgres;

--
-- TOC entry 3749 (class 0 OID 0)
-- Dependencies: 216
-- Name: product_product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.product_product_id_seq OWNED BY public.product.product_id;


--
-- TOC entry 229 (class 1259 OID 16770)
-- Name: supplier; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.supplier (
    supplier_id integer NOT NULL,
    company_name character varying(100) NOT NULL,
    address text,
    city character varying(100),
    country character varying(50),
    tax_id bigint NOT NULL
);


ALTER TABLE public.supplier OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 16769)
-- Name: supplier_supplier_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.supplier_supplier_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.supplier_supplier_id_seq OWNER TO postgres;

--
-- TOC entry 3750 (class 0 OID 0)
-- Dependencies: 228
-- Name: supplier_supplier_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.supplier_supplier_id_seq OWNED BY public.supplier.supplier_id;


--
-- TOC entry 231 (class 1259 OID 16781)
-- Name: supply; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.supply (
    supply_id integer NOT NULL,
    batch_number integer NOT NULL,
    processing_status character varying(20),
    supply_date date,
    branch_id integer,
    supplier_id integer,
    CONSTRAINT supply_processing_status_check CHECK (((processing_status)::text = ANY ((ARRAY['в обработке'::character varying, 'завершена'::character varying, 'отменена'::character varying])::text[])))
);


ALTER TABLE public.supply OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 16812)
-- Name: supply_details; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.supply_details (
    supply_details_id integer NOT NULL,
    product_id integer,
    supply_id integer,
    delivery_price integer,
    quantity integer,
    remaining_quantity integer,
    unit_measure character varying(20),
    weight_per_unit integer,
    expiration_date date,
    unit_price integer,
    comments text
);


ALTER TABLE public.supply_details OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 16811)
-- Name: supply_details_supply_details_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.supply_details_supply_details_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.supply_details_supply_details_id_seq OWNER TO postgres;

--
-- TOC entry 3751 (class 0 OID 0)
-- Dependencies: 232
-- Name: supply_details_supply_details_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.supply_details_supply_details_id_seq OWNED BY public.supply_details.supply_details_id;


--
-- TOC entry 239 (class 1259 OID 16870)
-- Name: supply_invoice; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.supply_invoice (
    supply_invoice_id integer NOT NULL,
    supply_id integer NOT NULL,
    amount integer NOT NULL,
    issue_date date NOT NULL,
    payment_date date,
    payment_status character varying(20) NOT NULL,
    CONSTRAINT supply_invoice_amount_check CHECK ((amount >= 0)),
    CONSTRAINT supply_invoice_payment_status_check CHECK (((payment_status)::text = ANY ((ARRAY['ожидание'::character varying, 'оплачен'::character varying, 'отменён'::character varying])::text[])))
);


ALTER TABLE public.supply_invoice OWNER TO postgres;

--
-- TOC entry 238 (class 1259 OID 16869)
-- Name: supply_invoice_supply_invoice_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.supply_invoice_supply_invoice_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.supply_invoice_supply_invoice_id_seq OWNER TO postgres;

--
-- TOC entry 3752 (class 0 OID 0)
-- Dependencies: 238
-- Name: supply_invoice_supply_invoice_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.supply_invoice_supply_invoice_id_seq OWNED BY public.supply_invoice.supply_invoice_id;


--
-- TOC entry 230 (class 1259 OID 16780)
-- Name: supply_supply_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.supply_supply_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.supply_supply_id_seq OWNER TO postgres;

--
-- TOC entry 3753 (class 0 OID 0)
-- Dependencies: 230
-- Name: supply_supply_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.supply_supply_id_seq OWNED BY public.supply.supply_id;


--
-- TOC entry 3503 (class 2604 OID 16721)
-- Name: branch branch_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.branch ALTER COLUMN branch_id SET DEFAULT nextval('public.branch_branch_id_seq'::regclass);


--
-- TOC entry 3504 (class 2604 OID 16730)
-- Name: customer customer_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer ALTER COLUMN customer_id SET DEFAULT nextval('public.customer_customer_id_seq'::regclass);


--
-- TOC entry 3511 (class 2604 OID 16858)
-- Name: invoice invoice_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoice ALTER COLUMN invoice_id SET DEFAULT nextval('public.invoice_invoice_id_seq'::regclass);


--
-- TOC entry 3502 (class 2604 OID 16705)
-- Name: manager manager_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.manager ALTER COLUMN manager_id SET DEFAULT nextval('public.manager_manager_id_seq'::regclass);


--
-- TOC entry 3501 (class 2604 OID 16698)
-- Name: manager_position position_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.manager_position ALTER COLUMN position_id SET DEFAULT nextval('public.manager_position_position_id_seq'::regclass);


--
-- TOC entry 3499 (class 2604 OID 16675)
-- Name: manufacturer manufacturer_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.manufacturer ALTER COLUMN manufacturer_id SET DEFAULT nextval('public.manufacturer_manufacturer_id_seq'::regclass);


--
-- TOC entry 3510 (class 2604 OID 16834)
-- Name: order_details order_details_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_details ALTER COLUMN order_details_id SET DEFAULT nextval('public.order_details_order_details_id_seq'::regclass);


--
-- TOC entry 3505 (class 2604 OID 16737)
-- Name: orders order_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders ALTER COLUMN order_id SET DEFAULT nextval('public.orders_order_id_seq'::regclass);


--
-- TOC entry 3500 (class 2604 OID 16684)
-- Name: product product_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product ALTER COLUMN product_id SET DEFAULT nextval('public.product_product_id_seq'::regclass);


--
-- TOC entry 3507 (class 2604 OID 16773)
-- Name: supplier supplier_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.supplier ALTER COLUMN supplier_id SET DEFAULT nextval('public.supplier_supplier_id_seq'::regclass);


--
-- TOC entry 3508 (class 2604 OID 16784)
-- Name: supply supply_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.supply ALTER COLUMN supply_id SET DEFAULT nextval('public.supply_supply_id_seq'::regclass);


--
-- TOC entry 3509 (class 2604 OID 16815)
-- Name: supply_details supply_details_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.supply_details ALTER COLUMN supply_details_id SET DEFAULT nextval('public.supply_details_supply_details_id_seq'::regclass);


--
-- TOC entry 3512 (class 2604 OID 16873)
-- Name: supply_invoice supply_invoice_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.supply_invoice ALTER COLUMN supply_invoice_id SET DEFAULT nextval('public.supply_invoice_supply_invoice_id_seq'::regclass);


--
-- TOC entry 3718 (class 0 OID 16718)
-- Dependencies: 223
-- Data for Name: branch; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.branch (branch_id, address, branch_name) FROM stdin;
1	г. Москва, ул. Логистическая, д. 10	Московский склад
2	г. Санкт-Петербург, ул. Промышленная, д. 22	Северо-Западный филиал
3	г. Новосибирск, ул. Склада №3	Сибирский логистический центр
4	г. Екатеринбург, ул. Производственная, д. 14	Уральский филиал
5	г. Казань, ул. Складская, д. 5	Волжский логистический узел
6	г. Краснодар, ул. Южная, д. 8	Южный филиал
7	г. Владивосток, ул. Морская, д. 12	Дальневосточный центр
8	г. Нижний Новгород, ул. Грузовая, д. 3	Центрально-Поволжский склад
9	г. Самара, ул. Оптовая, д. 17	Поволжский логистический центр
10	г. Ростов-на-Дону, ул. Транспортная, д. 6	Донской распределительный узел
\.


--
-- TOC entry 3720 (class 0 OID 16727)
-- Dependencies: 225
-- Data for Name: customer; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.customer (customer_id, company_name, city, country, phone) FROM stdin;
1	ЗАО "Торговля-246"	Самара	Россия	8-905-982-63-40
2	АО "Ритейл-553"	Саратов	Россия	8-913-849-89-88
3	ООО "Поставка-640"	Пермь	Россия	8-920-126-27-98
4	ПАО "Продукты-508"	Москва	Россия	8-905-907-75-76
5	АО "ОптМаркет-618"	Санкт-Петербург	Россия	8-970-571-49-93
6	ИП "Торговля-448"	Краснодар	Россия	8-911-722-30-90
7	ПАО "Поставка-175"	Екатеринбург	Россия	8-984-112-95-19
8	ООО "Торговля-239"	Самара	Россия	8-934-174-54-70
9	ООО "Торговля-811"	Саратов	Россия	8-913-321-57-39
10	ИП "Снабжение-751"	Омск	Россия	8-908-107-23-81
11	ПАО "Снабжение-848"	Саратов	Россия	8-968-628-39-70
12	ЗАО "Ритейл-832"	Саратов	Россия	8-926-823-84-10
13	ПАО "ОптМаркет-266"	Челябинск	Россия	8-974-325-94-47
14	ЗАО "Ритейл-788"	Самара	Россия	8-924-521-95-68
15	ПАО "Снабжение-316"	Саратов	Россия	8-905-408-78-39
16	ИП "Торговля-526"	Красноярск	Россия	8-940-152-62-39
17	ПАО "ОптМаркет-807"	Новосибирск	Россия	8-936-298-58-90
18	ПАО "ОптМаркет-751"	Красноярск	Россия	8-940-232-45-52
19	ИП "ОптМаркет-547"	Тюмень	Россия	8-990-149-42-23
20	ПАО "Снабжение-306"	Екатеринбург	Россия	8-927-409-83-21
21	ПАО "Поставка-543"	Барнаул	Россия	8-967-157-42-79
22	ООО "Снабжение-156"	Волгоград	Россия	8-943-300-46-29
23	ПАО "Снабжение-200"	Барнаул	Россия	8-905-283-25-94
24	ИП "Ритейл-645"	Уфа	Россия	8-938-335-40-50
25	АО "Ритейл-118"	Тюмень	Россия	8-902-686-31-23
26	АО "ОптМаркет-803"	Уфа	Россия	8-930-701-92-77
27	ЗАО "Торговля-361"	Саратов	Россия	8-988-760-55-55
28	ИП "Ритейл-188"	Санкт-Петербург	Россия	8-900-667-38-62
29	ПАО "ОптМаркет-395"	Казань	Россия	8-969-585-43-42
30	ПАО "Продукты-228"	Москва	Россия	8-917-555-88-98
31	АО "Продукты-701"	Тюмень	Россия	8-965-534-39-95
32	ООО "ОптМаркет-364"	Нижний Новгород	Россия	8-922-824-21-57
33	ООО "Торговля-102"	Казань	Россия	8-944-583-73-90
34	ИП "Торговля-638"	Казань	Россия	8-968-753-74-57
35	ЗАО "Торговля-553"	Краснодар	Россия	8-924-422-62-56
36	ПАО "Продукты-337"	Ростов-на-Дону	Россия	8-933-988-44-18
37	ПАО "Торговля-220"	Воронеж	Россия	8-942-133-74-93
38	ПАО "Снабжение-438"	Новосибирск	Россия	8-948-838-55-78
39	ЗАО "Торговля-222"	Иркутск	Россия	8-995-140-98-40
40	АО "Ритейл-895"	Санкт-Петербург	Россия	8-994-639-45-84
41	ООО "ОптМаркет-507"	Нижний Новгород	Россия	8-971-121-30-11
42	ООО "Ритейл-232"	Москва	Россия	8-927-887-72-43
43	АО "Продукты-255"	Волгоград	Россия	8-951-354-68-58
44	АО "Снабжение-826"	Воронеж	Россия	8-945-110-17-71
45	ООО "Продукты-701"	Новосибирск	Россия	8-959-881-16-98
46	ЗАО "ОптМаркет-187"	Барнаул	Россия	8-998-221-33-56
47	ПАО "Продукты-881"	Новосибирск	Россия	8-912-236-39-19
48	ООО "Торговля-820"	Красноярск	Россия	8-951-212-24-64
49	ЗАО "Поставка-416"	Москва	Россия	8-917-880-19-18
50	ИП "Ритейл-254"	Красноярск	Россия	8-985-802-50-78
51	ЗАО "Торговля-246"	Самара	Россия	8-905-982-63-40
52	АО "Ритейл-553"	Саратов	Россия	8-913-849-89-88
53	ООО "Поставка-640"	Пермь	Россия	8-920-126-27-98
54	ПАО "Продукты-508"	Москва	Россия	8-905-907-75-76
55	АО "ОптМаркет-618"	Санкт-Петербург	Россия	8-970-571-49-93
56	ИП "Торговля-448"	Краснодар	Россия	8-911-722-30-90
57	ПАО "Поставка-175"	Екатеринбург	Россия	8-984-112-95-19
58	ООО "Торговля-239"	Самара	Россия	8-934-174-54-70
59	ООО "Торговля-811"	Саратов	Россия	8-913-321-57-39
60	ИП "Снабжение-751"	Омск	Россия	8-908-107-23-81
61	ПАО "Снабжение-848"	Саратов	Россия	8-968-628-39-70
62	ЗАО "Ритейл-832"	Саратов	Россия	8-926-823-84-10
63	ПАО "ОптМаркет-266"	Челябинск	Россия	8-974-325-94-47
64	ЗАО "Ритейл-788"	Самара	Россия	8-924-521-95-68
65	ПАО "Снабжение-316"	Саратов	Россия	8-905-408-78-39
66	ИП "Торговля-526"	Красноярск	Россия	8-940-152-62-39
67	ПАО "ОптМаркет-807"	Новосибирск	Россия	8-936-298-58-90
68	ПАО "ОптМаркет-751"	Красноярск	Россия	8-940-232-45-52
69	ИП "ОптМаркет-547"	Тюмень	Россия	8-990-149-42-23
70	ПАО "Снабжение-306"	Екатеринбург	Россия	8-927-409-83-21
71	ПАО "Поставка-543"	Барнаул	Россия	8-967-157-42-79
72	ООО "Снабжение-156"	Волгоград	Россия	8-943-300-46-29
73	ПАО "Снабжение-200"	Барнаул	Россия	8-905-283-25-94
74	ИП "Ритейл-645"	Уфа	Россия	8-938-335-40-50
75	АО "Ритейл-118"	Тюмень	Россия	8-902-686-31-23
76	АО "ОптМаркет-803"	Уфа	Россия	8-930-701-92-77
77	ЗАО "Торговля-361"	Саратов	Россия	8-988-760-55-55
78	ИП "Ритейл-188"	Санкт-Петербург	Россия	8-900-667-38-62
79	ПАО "ОптМаркет-395"	Казань	Россия	8-969-585-43-42
80	ПАО "Продукты-228"	Москва	Россия	8-917-555-88-98
81	АО "Продукты-701"	Тюмень	Россия	8-965-534-39-95
82	ООО "ОптМаркет-364"	Нижний Новгород	Россия	8-922-824-21-57
83	ООО "Торговля-102"	Казань	Россия	8-944-583-73-90
84	ИП "Торговля-638"	Казань	Россия	8-968-753-74-57
85	ЗАО "Торговля-553"	Краснодар	Россия	8-924-422-62-56
86	ПАО "Продукты-337"	Ростов-на-Дону	Россия	8-933-988-44-18
87	ПАО "Торговля-220"	Воронеж	Россия	8-942-133-74-93
88	ПАО "Снабжение-438"	Новосибирск	Россия	8-948-838-55-78
89	ЗАО "Торговля-222"	Иркутск	Россия	8-995-140-98-40
90	АО "Ритейл-895"	Санкт-Петербург	Россия	8-994-639-45-84
91	ООО "ОптМаркет-507"	Нижний Новгород	Россия	8-971-121-30-11
92	ООО "Ритейл-232"	Москва	Россия	8-927-887-72-43
93	АО "Продукты-255"	Волгоград	Россия	8-951-354-68-58
94	АО "Снабжение-826"	Воронеж	Россия	8-945-110-17-71
95	ООО "Продукты-701"	Новосибирск	Россия	8-959-881-16-98
96	ЗАО "ОптМаркет-187"	Барнаул	Россия	8-998-221-33-56
97	ПАО "Продукты-881"	Новосибирск	Россия	8-912-236-39-19
98	ООО "Торговля-820"	Красноярск	Россия	8-951-212-24-64
99	ЗАО "Поставка-416"	Москва	Россия	8-917-880-19-18
100	ИП "Ритейл-254"	Красноярск	Россия	8-985-802-50-78
101	АО "Поставка-652"	Екатеринбург	Россия	8-998-874-29-77
102	ООО "Ритейл-766"	Нижний Новгород	Россия	8-952-198-18-89
103	АО "Поставка-344"	Пермь	Россия	8-920-599-21-41
104	ЗАО "Снабжение-658"	Самара	Россия	8-919-977-31-52
105	ООО "Снабжение-928"	Иркутск	Россия	8-954-771-88-30
106	АО "Снабжение-595"	Пермь	Россия	8-975-943-50-87
107	ЗАО "Снабжение-579"	Барнаул	Россия	8-978-308-12-84
108	ООО "Ритейл-774"	Самара	Россия	8-953-383-62-33
109	ЗАО "Продукты-710"	Волгоград	Россия	8-985-362-71-52
110	АО "Поставка-950"	Омск	Россия	8-917-849-97-43
111	ПАО "Снабжение-550"	Санкт-Петербург	Россия	8-948-758-48-95
112	ПАО "Ритейл-253"	Ростов-на-Дону	Россия	8-994-149-14-31
113	ООО "Продукты-594"	Ростов-на-Дону	Россия	8-984-836-24-33
114	АО "Снабжение-866"	Нижний Новгород	Россия	8-931-404-73-53
115	ЗАО "ОптМаркет-551"	Москва	Россия	8-933-781-36-67
116	ЗАО "Торговля-193"	Иркутск	Россия	8-905-806-99-53
117	АО "Продукты-204"	Краснодар	Россия	8-986-787-60-98
118	ПАО "Торговля-115"	Омск	Россия	8-951-457-47-25
119	ПАО "Поставка-906"	Казань	Россия	8-926-279-34-99
120	ПАО "Продукты-938"	Нижний Новгород	Россия	8-981-423-72-55
121	АО "ОптМаркет-429"	Самара	Россия	8-911-288-19-89
122	ИП "Поставка-630"	Воронеж	Россия	8-956-530-36-75
123	ПАО "Продукты-480"	Санкт-Петербург	Россия	8-917-243-49-23
124	ИП "Поставка-276"	Пермь	Россия	8-972-226-55-96
125	ЗАО "ОптМаркет-986"	Ростов-на-Дону	Россия	8-904-383-17-55
126	АО "Поставка-962"	Волгоград	Россия	8-905-800-52-21
127	ПАО "Снабжение-947"	Казань	Россия	8-980-431-67-14
128	ИП "Торговля-133"	Тюмень	Россия	8-942-332-56-21
129	АО "Продукты-678"	Волгоград	Россия	8-978-326-24-55
130	АО "Торговля-117"	Барнаул	Россия	8-926-809-23-82
131	АО "Продукты-965"	Тюмень	Россия	8-945-202-74-19
132	ООО "Продукты-972"	Нижний Новгород	Россия	8-901-577-71-35
133	ЗАО "Снабжение-851"	Барнаул	Россия	8-963-823-51-33
134	ООО "Продукты-723"	Воронеж	Россия	8-903-740-75-61
135	ЗАО "Ритейл-851"	Воронеж	Россия	8-907-944-81-23
136	ЗАО "Торговля-167"	Барнаул	Россия	8-952-789-88-72
137	ИП "Продукты-758"	Санкт-Петербург	Россия	8-930-461-77-36
138	АО "Торговля-359"	Омск	Россия	8-904-781-37-69
139	ООО "Снабжение-552"	Санкт-Петербург	Россия	8-900-322-68-58
140	ООО "Ритейл-210"	Уфа	Россия	8-918-321-52-28
141	АО "Поставка-739"	Красноярск	Россия	8-929-116-92-18
142	ИП "Снабжение-884"	Нижний Новгород	Россия	8-975-891-23-91
143	ЗАО "Продукты-720"	Волгоград	Россия	8-942-122-94-71
144	ООО "Продукты-623"	Пермь	Россия	8-923-802-89-75
145	ПАО "Торговля-816"	Челябинск	Россия	8-954-803-16-73
146	ИП "ОптМаркет-227"	Волгоград	Россия	8-916-304-10-40
147	ЗАО "Поставка-225"	Тюмень	Россия	8-953-833-69-94
148	ПАО "Снабжение-940"	Барнаул	Россия	8-935-624-74-64
149	ПАО "Продукты-658"	Челябинск	Россия	8-953-203-90-39
150	ПАО "Снабжение-794"	Воронеж	Россия	8-913-898-19-69
151	ЗАО "Продукты-297"	Красноярск	Россия	8-922-401-66-38
152	ИП "Ритейл-621"	Новосибирск	Россия	8-915-278-45-12
153	ИП "Продукты-603"	Казань	Россия	8-964-686-19-99
154	ООО "Поставка-847"	Екатеринбург	Россия	8-967-245-31-34
155	АО "Снабжение-907"	Санкт-Петербург	Россия	8-968-615-67-66
156	ООО "Ритейл-113"	Омск	Россия	8-959-339-64-50
157	ИП "ОптМаркет-473"	Барнаул	Россия	8-942-680-95-36
158	АО "Снабжение-177"	Барнаул	Россия	8-970-528-63-19
159	ЗАО "Ритейл-662"	Саратов	Россия	8-974-884-87-90
160	ИП "Поставка-967"	Омск	Россия	8-960-387-72-86
161	ПАО "Снабжение-150"	Новосибирск	Россия	8-963-649-33-73
162	АО "Поставка-586"	Челябинск	Россия	8-928-239-78-32
163	ООО "ОптМаркет-451"	Красноярск	Россия	8-964-903-59-88
164	ИП "Ритейл-415"	Омск	Россия	8-979-248-67-99
165	ЗАО "Торговля-669"	Иркутск	Россия	8-965-820-16-89
166	ООО "Ритейл-913"	Саратов	Россия	8-947-954-84-77
167	ИП "Поставка-852"	Барнаул	Россия	8-994-234-25-49
168	ПАО "Ритейл-102"	Новосибирск	Россия	8-979-285-55-29
169	АО "Поставка-270"	Екатеринбург	Россия	8-983-255-35-45
170	ПАО "Снабжение-438"	Саратов	Россия	8-920-251-23-83
171	ИП "ОптМаркет-105"	Краснодар	Россия	8-995-843-42-13
172	ООО "Поставка-732"	Ростов-на-Дону	Россия	8-996-708-13-67
173	ООО "Снабжение-923"	Красноярск	Россия	8-962-670-23-45
174	АО "ОптМаркет-934"	Челябинск	Россия	8-942-638-85-64
175	ООО "ОптМаркет-957"	Иркутск	Россия	8-947-658-16-50
176	ООО "Продукты-419"	Челябинск	Россия	8-954-424-51-94
177	АО "Торговля-774"	Новосибирск	Россия	8-904-514-89-89
178	АО "Ритейл-394"	Барнаул	Россия	8-959-879-74-26
179	АО "Снабжение-636"	Новосибирск	Россия	8-995-642-17-46
180	ЗАО "Ритейл-202"	Екатеринбург	Россия	8-927-640-39-85
181	ООО "Поставка-895"	Омск	Россия	8-946-395-23-66
182	ИП "Поставка-292"	Воронеж	Россия	8-972-667-78-37
183	ЗАО "Снабжение-714"	Екатеринбург	Россия	8-950-382-73-91
184	ПАО "Торговля-101"	Краснодар	Россия	8-979-889-90-10
185	АО "ОптМаркет-941"	Новосибирск	Россия	8-973-654-54-55
186	ИП "Торговля-894"	Санкт-Петербург	Россия	8-976-458-27-97
187	ПАО "Торговля-527"	Красноярск	Россия	8-991-736-91-37
188	АО "Поставка-831"	Красноярск	Россия	8-969-905-85-86
189	ООО "ОптМаркет-274"	Санкт-Петербург	Россия	8-925-964-14-31
190	АО "Ритейл-290"	Тюмень	Россия	8-967-354-94-67
191	ООО "Продукты-389"	Москва	Россия	8-950-626-60-46
192	ИП "Ритейл-168"	Санкт-Петербург	Россия	8-966-477-47-66
193	ИП "Снабжение-445"	Краснодар	Россия	8-974-558-15-45
194	ООО "Продукты-523"	Саратов	Россия	8-964-796-50-97
195	АО "ОптМаркет-567"	Тюмень	Россия	8-944-941-41-47
196	ЗАО "Поставка-492"	Екатеринбург	Россия	8-950-904-20-54
197	АО "Поставка-391"	Тюмень	Россия	8-985-792-13-38
198	ЗАО "Снабжение-568"	Тюмень	Россия	8-981-705-70-51
199	ПАО "Поставка-938"	Челябинск	Россия	8-977-659-88-29
200	ПАО "Снабжение-953"	Ростов-на-Дону	Россия	8-903-291-34-62
201	ПАО "Торговля-436"	Иркутск	Россия	8-930-130-18-12
202	ООО "ОптМаркет-256"	Иркутск	Россия	8-920-866-70-19
203	ИП "Продукты-760"	Челябинск	Россия	8-963-907-53-16
204	ИП "Снабжение-206"	Тюмень	Россия	8-996-777-95-22
205	ООО "ОптМаркет-108"	Санкт-Петербург	Россия	8-989-449-81-13
206	ПАО "Снабжение-398"	Санкт-Петербург	Россия	8-952-364-34-81
207	АО "Поставка-843"	Пермь	Россия	8-949-995-19-53
208	ООО "Ритейл-414"	Иркутск	Россия	8-946-648-70-30
209	ООО "Продукты-310"	Нижний Новгород	Россия	8-939-722-65-21
210	ИП "Поставка-841"	Казань	Россия	8-906-627-26-54
211	ИП "Снабжение-196"	Краснодар	Россия	8-934-851-97-34
212	ПАО "Продукты-201"	Самара	Россия	8-909-817-14-86
213	ИП "Снабжение-501"	Тюмень	Россия	8-987-950-33-40
214	ИП "Снабжение-937"	Екатеринбург	Россия	8-922-298-48-66
215	ООО "Снабжение-442"	Краснодар	Россия	8-941-995-43-88
216	ООО "Продукты-609"	Нижний Новгород	Россия	8-916-506-57-39
217	АО "Торговля-346"	Тюмень	Россия	8-997-484-65-86
218	ПАО "Снабжение-946"	Краснодар	Россия	8-969-277-65-73
219	ООО "Торговля-894"	Краснодар	Россия	8-961-239-34-50
220	АО "Снабжение-630"	Воронеж	Россия	8-943-610-54-11
221	ПАО "Продукты-886"	Челябинск	Россия	8-903-923-90-86
222	ИП "Снабжение-742"	Тюмень	Россия	8-923-612-48-78
223	ИП "Ритейл-900"	Самара	Россия	8-948-589-71-23
224	ИП "ОптМаркет-137"	Тюмень	Россия	8-946-671-53-82
225	ПАО "Снабжение-207"	Казань	Россия	8-962-517-70-90
226	АО "Продукты-919"	Барнаул	Россия	8-998-827-28-75
227	ООО "Поставка-768"	Санкт-Петербург	Россия	8-947-736-57-12
228	АО "Снабжение-299"	Иркутск	Россия	8-924-653-23-56
229	ООО "Торговля-281"	Санкт-Петербург	Россия	8-941-260-18-35
230	ЗАО "Продукты-186"	Москва	Россия	8-921-694-13-92
231	АО "Поставка-464"	Екатеринбург	Россия	8-995-629-68-34
232	АО "Снабжение-108"	Екатеринбург	Россия	8-926-254-35-70
233	ООО "ОптМаркет-786"	Тюмень	Россия	8-954-749-60-14
234	ООО "Продукты-170"	Уфа	Россия	8-903-895-72-71
235	ПАО "Продукты-300"	Санкт-Петербург	Россия	8-992-154-98-36
236	ПАО "Поставка-691"	Волгоград	Россия	8-971-387-72-14
237	ИП "Снабжение-790"	Красноярск	Россия	8-966-942-13-48
238	АО "Ритейл-695"	Казань	Россия	8-978-563-93-77
239	ПАО "Продукты-299"	Омск	Россия	8-949-304-53-68
240	ИП "Торговля-403"	Омск	Россия	8-972-597-28-50
241	ЗАО "Продукты-531"	Санкт-Петербург	Россия	8-973-696-68-20
242	ЗАО "Торговля-143"	Иркутск	Россия	8-917-159-69-27
243	ЗАО "ОптМаркет-864"	Санкт-Петербург	Россия	8-983-106-88-41
244	ООО "Ритейл-874"	Самара	Россия	8-990-219-22-26
245	ИП "Ритейл-458"	Уфа	Россия	8-962-996-16-53
246	ИП "Поставка-979"	Волгоград	Россия	8-927-649-31-80
247	ИП "Продукты-962"	Воронеж	Россия	8-908-353-54-62
248	ЗАО "Поставка-944"	Нижний Новгород	Россия	8-949-580-17-35
249	ПАО "Снабжение-385"	Пермь	Россия	8-930-860-76-86
250	ООО "Продукты-657"	Красноярск	Россия	8-901-590-17-19
251	ИП "ОптМаркет-983"	Новосибирск	Россия	8-916-667-13-88
252	ПАО "Ритейл-425"	Волгоград	Россия	8-980-878-22-60
253	АО "Ритейл-456"	Москва	Россия	8-932-186-57-32
254	ИП "Ритейл-522"	Тюмень	Россия	8-950-173-64-31
255	ООО "ОптМаркет-779"	Краснодар	Россия	8-940-635-23-61
256	ЗАО "Ритейл-652"	Тюмень	Россия	8-961-903-96-82
257	АО "Торговля-529"	Тюмень	Россия	8-997-140-74-98
258	ЗАО "ОптМаркет-680"	Волгоград	Россия	8-956-687-74-57
259	АО "Поставка-332"	Новосибирск	Россия	8-944-214-55-13
260	АО "ОптМаркет-987"	Уфа	Россия	8-996-450-11-18
261	ПАО "Снабжение-470"	Иркутск	Россия	8-924-660-71-26
262	ИП "Торговля-994"	Нижний Новгород	Россия	8-975-122-89-65
263	ПАО "Торговля-950"	Волгоград	Россия	8-933-158-63-50
264	ПАО "Снабжение-823"	Санкт-Петербург	Россия	8-988-324-15-97
265	ООО "Поставка-544"	Санкт-Петербург	Россия	8-996-571-26-64
266	ИП "ОптМаркет-435"	Москва	Россия	8-904-770-48-72
267	АО "ОптМаркет-148"	Красноярск	Россия	8-922-488-99-22
268	ИП "Поставка-249"	Челябинск	Россия	8-907-143-33-45
269	ООО "Снабжение-621"	Саратов	Россия	8-983-308-24-39
270	ПАО "ОптМаркет-714"	Нижний Новгород	Россия	8-910-162-61-68
271	ООО "Поставка-430"	Красноярск	Россия	8-983-637-80-17
272	ПАО "ОптМаркет-736"	Москва	Россия	8-941-135-89-95
273	ПАО "Снабжение-359"	Тюмень	Россия	8-916-351-39-37
274	ИП "Ритейл-500"	Самара	Россия	8-976-487-63-18
275	ООО "Снабжение-645"	Ростов-на-Дону	Россия	8-995-137-64-41
276	ЗАО "Продукты-564"	Саратов	Россия	8-954-196-20-63
277	ЗАО "Продукты-529"	Санкт-Петербург	Россия	8-943-153-46-45
278	ПАО "ОптМаркет-754"	Челябинск	Россия	8-957-942-14-60
279	ООО "ОптМаркет-383"	Екатеринбург	Россия	8-987-325-21-20
280	ООО "ОптМаркет-158"	Омск	Россия	8-964-721-97-99
281	АО "Поставка-571"	Тюмень	Россия	8-997-660-52-16
282	ПАО "Ритейл-204"	Красноярск	Россия	8-937-832-91-55
283	АО "Торговля-472"	Санкт-Петербург	Россия	8-902-103-63-24
284	ЗАО "ОптМаркет-484"	Иркутск	Россия	8-919-665-83-32
285	ИП "Ритейл-538"	Красноярск	Россия	8-909-471-74-20
286	ПАО "ОптМаркет-577"	Самара	Россия	8-994-789-28-91
287	АО "ОптМаркет-874"	Уфа	Россия	8-904-952-31-44
288	ПАО "Продукты-875"	Нижний Новгород	Россия	8-948-815-97-20
289	ООО "Снабжение-801"	Нижний Новгород	Россия	8-980-605-37-92
290	АО "ОптМаркет-891"	Волгоград	Россия	8-911-131-64-16
291	ИП "Продукты-705"	Челябинск	Россия	8-925-207-51-92
292	ПАО "Снабжение-993"	Самара	Россия	8-955-199-42-66
293	ПАО "ОптМаркет-495"	Екатеринбург	Россия	8-919-862-67-59
294	АО "Продукты-551"	Нижний Новгород	Россия	8-966-528-81-10
295	ПАО "Ритейл-264"	Тюмень	Россия	8-984-417-93-14
296	ООО "Продукты-263"	Челябинск	Россия	8-953-490-71-42
297	ПАО "Ритейл-184"	Воронеж	Россия	8-903-425-16-58
298	ЗАО "ОптМаркет-416"	Саратов	Россия	8-942-554-99-93
299	ЗАО "Поставка-799"	Новосибирск	Россия	8-945-953-39-94
300	ЗАО "ОптМаркет-742"	Нижний Новгород	Россия	8-929-894-43-25
301	АО "Снабжение-628"	Саратов	Россия	8-973-550-52-88
302	ИП "Поставка-532"	Новосибирск	Россия	8-912-556-77-71
303	ООО "Снабжение-127"	Санкт-Петербург	Россия	8-983-706-46-31
304	ООО "Торговля-485"	Екатеринбург	Россия	8-995-874-14-25
305	ООО "Ритейл-135"	Казань	Россия	8-967-195-58-76
306	ПАО "Торговля-979"	Санкт-Петербург	Россия	8-943-948-80-91
307	ЗАО "Продукты-492"	Барнаул	Россия	8-963-687-33-55
308	ЗАО "Торговля-867"	Барнаул	Россия	8-905-780-26-34
309	ИП "ОптМаркет-582"	Казань	Россия	8-918-258-30-84
310	ПАО "Продукты-289"	Краснодар	Россия	8-965-962-58-90
311	АО "Продукты-255"	Москва	Россия	8-920-803-49-24
312	АО "Поставка-108"	Краснодар	Россия	8-935-127-38-73
313	АО "Поставка-746"	Саратов	Россия	8-992-486-92-79
314	ЗАО "ОптМаркет-333"	Нижний Новгород	Россия	8-907-347-66-42
315	ИП "Продукты-990"	Новосибирск	Россия	8-941-951-52-56
316	ПАО "Ритейл-217"	Красноярск	Россия	8-990-830-70-82
317	ПАО "Снабжение-278"	Нижний Новгород	Россия	8-974-488-37-79
318	ИП "Снабжение-282"	Воронеж	Россия	8-910-973-49-93
319	ИП "ОптМаркет-445"	Новосибирск	Россия	8-958-755-57-94
320	ООО "Поставка-879"	Иркутск	Россия	8-991-118-87-27
321	ПАО "Торговля-472"	Уфа	Россия	8-926-292-33-17
322	ПАО "Снабжение-143"	Уфа	Россия	8-913-139-34-74
323	ЗАО "ОптМаркет-365"	Краснодар	Россия	8-914-544-16-68
324	ООО "Поставка-357"	Пермь	Россия	8-981-489-68-63
325	ЗАО "Продукты-240"	Воронеж	Россия	8-975-239-65-61
326	ПАО "Снабжение-282"	Саратов	Россия	8-972-735-91-17
327	ЗАО "Поставка-480"	Воронеж	Россия	8-921-223-59-67
328	ПАО "Ритейл-518"	Екатеринбург	Россия	8-926-306-64-34
329	ИП "Ритейл-633"	Воронеж	Россия	8-922-931-45-81
330	АО "Продукты-302"	Москва	Россия	8-928-101-53-77
331	ЗАО "Поставка-516"	Ростов-на-Дону	Россия	8-924-501-88-64
332	ЗАО "Торговля-951"	Уфа	Россия	8-906-113-74-26
333	ЗАО "Продукты-920"	Екатеринбург	Россия	8-972-434-93-89
334	ООО "Продукты-880"	Иркутск	Россия	8-927-673-23-26
335	АО "Поставка-555"	Омск	Россия	8-994-916-78-71
336	АО "ОптМаркет-527"	Омск	Россия	8-971-696-97-37
337	АО "Продукты-115"	Волгоград	Россия	8-918-325-30-76
338	ПАО "Поставка-849"	Барнаул	Россия	8-902-285-73-15
339	ИП "Ритейл-504"	Иркутск	Россия	8-960-853-44-26
340	АО "ОптМаркет-951"	Уфа	Россия	8-955-627-33-52
341	ПАО "ОптМаркет-250"	Краснодар	Россия	8-912-453-63-89
342	АО "ОптМаркет-211"	Москва	Россия	8-987-299-73-73
343	ПАО "Снабжение-401"	Нижний Новгород	Россия	8-954-606-21-62
344	ИП "Торговля-252"	Барнаул	Россия	8-997-510-15-46
345	ЗАО "Ритейл-560"	Казань	Россия	8-921-451-33-50
346	ПАО "Продукты-316"	Самара	Россия	8-975-536-45-41
347	ЗАО "Торговля-253"	Иркутск	Россия	8-988-534-14-58
348	АО "Торговля-917"	Омск	Россия	8-988-439-54-67
349	АО "Снабжение-585"	Воронеж	Россия	8-933-502-12-64
350	АО "Снабжение-221"	Новосибирск	Россия	8-921-858-48-90
351	АО "ОптМаркет-242"	Воронеж	Россия	8-932-234-62-33
352	АО "Снабжение-666"	Челябинск	Россия	8-980-171-20-55
353	АО "Снабжение-155"	Иркутск	Россия	8-974-977-58-86
354	ПАО "Ритейл-401"	Краснодар	Россия	8-921-281-31-16
355	АО "Поставка-857"	Нижний Новгород	Россия	8-922-502-87-75
356	ЗАО "Торговля-115"	Москва	Россия	8-951-521-38-54
357	ЗАО "Снабжение-454"	Омск	Россия	8-926-751-65-24
358	АО "Ритейл-611"	Казань	Россия	8-910-149-12-33
359	ООО "Поставка-621"	Краснодар	Россия	8-929-171-87-87
360	ПАО "Поставка-870"	Краснодар	Россия	8-962-787-66-44
361	АО "Торговля-384"	Краснодар	Россия	8-960-382-12-13
362	ПАО "Снабжение-292"	Казань	Россия	8-930-927-97-75
363	ПАО "Снабжение-487"	Иркутск	Россия	8-905-577-14-54
364	ИП "Снабжение-221"	Краснодар	Россия	8-923-985-50-33
365	ЗАО "Снабжение-252"	Барнаул	Россия	8-909-784-71-67
366	ПАО "Ритейл-350"	Тюмень	Россия	8-946-326-98-10
367	ИП "Торговля-331"	Москва	Россия	8-999-177-77-26
368	ООО "Продукты-168"	Екатеринбург	Россия	8-968-292-66-20
369	ЗАО "Поставка-644"	Краснодар	Россия	8-995-586-76-18
370	ЗАО "Ритейл-975"	Краснодар	Россия	8-911-753-63-58
371	ПАО "Снабжение-335"	Красноярск	Россия	8-991-495-33-10
372	ПАО "Торговля-969"	Казань	Россия	8-980-198-51-12
373	ИП "Торговля-808"	Иркутск	Россия	8-975-567-22-42
374	ЗАО "Ритейл-475"	Иркутск	Россия	8-900-742-17-44
375	ПАО "Ритейл-509"	Санкт-Петербург	Россия	8-903-255-37-46
376	ИП "Продукты-412"	Москва	Россия	8-957-432-95-81
377	ИП "Ритейл-499"	Пермь	Россия	8-951-948-21-75
378	АО "Поставка-893"	Пермь	Россия	8-973-750-21-95
379	ИП "Ритейл-608"	Екатеринбург	Россия	8-952-893-80-17
380	ИП "Продукты-965"	Нижний Новгород	Россия	8-990-853-39-67
381	ИП "ОптМаркет-227"	Новосибирск	Россия	8-964-178-95-67
382	ПАО "ОптМаркет-710"	Омск	Россия	8-954-145-72-37
383	ИП "Снабжение-345"	Воронеж	Россия	8-974-844-18-90
384	ПАО "ОптМаркет-704"	Нижний Новгород	Россия	8-984-229-52-92
385	ЗАО "Ритейл-635"	Волгоград	Россия	8-933-179-39-62
386	ПАО "Торговля-925"	Казань	Россия	8-916-516-46-19
387	ПАО "Поставка-214"	Москва	Россия	8-964-336-98-80
388	ООО "Торговля-406"	Саратов	Россия	8-905-544-87-54
389	ООО "Поставка-234"	Саратов	Россия	8-998-853-96-95
390	ИП "Снабжение-212"	Пермь	Россия	8-904-422-45-82
391	ООО "ОптМаркет-330"	Челябинск	Россия	8-924-839-40-21
392	ИП "Поставка-642"	Санкт-Петербург	Россия	8-941-127-77-47
393	ЗАО "Снабжение-797"	Самара	Россия	8-912-362-48-94
394	ИП "ОптМаркет-494"	Казань	Россия	8-952-634-71-27
395	ООО "ОптМаркет-137"	Ростов-на-Дону	Россия	8-977-445-72-40
396	ЗАО "Ритейл-796"	Челябинск	Россия	8-935-655-75-62
397	ООО "Торговля-378"	Барнаул	Россия	8-987-410-44-76
398	ПАО "Продукты-181"	Воронеж	Россия	8-974-693-60-63
399	ПАО "Продукты-101"	Екатеринбург	Россия	8-951-806-36-86
400	ПАО "Торговля-730"	Ростов-на-Дону	Россия	8-984-948-10-57
401	ИП "Торговля-722"	Барнаул	Россия	8-955-276-37-78
402	АО "Торговля-172"	Екатеринбург	Россия	8-914-637-35-60
403	ООО "Торговля-137"	Саратов	Россия	8-922-943-66-95
404	ИП "Снабжение-688"	Саратов	Россия	8-965-834-64-35
405	ИП "Ритейл-159"	Нижний Новгород	Россия	8-906-828-53-90
406	ПАО "ОптМаркет-857"	Новосибирск	Россия	8-916-569-14-89
407	ООО "Поставка-445"	Тюмень	Россия	8-970-784-68-20
408	ПАО "Поставка-150"	Ростов-на-Дону	Россия	8-905-484-76-75
409	ЗАО "Снабжение-939"	Челябинск	Россия	8-970-523-28-91
410	АО "Торговля-400"	Екатеринбург	Россия	8-965-432-53-34
411	ИП "ОптМаркет-539"	Барнаул	Россия	8-928-852-45-16
412	ИП "ОптМаркет-835"	Самара	Россия	8-935-771-35-19
413	ЗАО "Торговля-927"	Омск	Россия	8-960-113-68-91
414	ПАО "Поставка-184"	Тюмень	Россия	8-979-312-71-67
415	ПАО "Снабжение-860"	Екатеринбург	Россия	8-900-668-17-82
416	ПАО "Снабжение-876"	Санкт-Петербург	Россия	8-900-104-32-25
417	ООО "Снабжение-940"	Челябинск	Россия	8-982-324-99-42
418	ЗАО "Снабжение-438"	Тюмень	Россия	8-957-935-33-14
419	ИП "Продукты-917"	Краснодар	Россия	8-979-625-44-15
420	ИП "ОптМаркет-199"	Тюмень	Россия	8-975-701-69-25
421	ЗАО "Торговля-810"	Краснодар	Россия	8-920-728-65-56
422	ООО "Снабжение-452"	Красноярск	Россия	8-944-561-60-67
423	АО "ОптМаркет-772"	Красноярск	Россия	8-996-868-99-66
424	ПАО "Продукты-779"	Краснодар	Россия	8-991-316-57-90
425	ООО "ОптМаркет-273"	Красноярск	Россия	8-989-204-46-26
426	ЗАО "Торговля-210"	Красноярск	Россия	8-912-692-34-90
427	ЗАО "Торговля-393"	Иркутск	Россия	8-942-999-12-83
428	ООО "Торговля-549"	Санкт-Петербург	Россия	8-975-230-31-91
429	ООО "Продукты-713"	Москва	Россия	8-930-879-50-41
430	АО "Торговля-765"	Челябинск	Россия	8-999-929-99-43
431	ИП "Поставка-123"	Ростов-на-Дону	Россия	8-908-240-78-51
432	ПАО "Снабжение-827"	Нижний Новгород	Россия	8-951-443-71-94
433	ООО "Поставка-414"	Воронеж	Россия	8-990-115-77-22
434	ПАО "Продукты-285"	Санкт-Петербург	Россия	8-953-423-66-40
435	ООО "Снабжение-471"	Челябинск	Россия	8-900-100-26-62
436	ООО "Ритейл-584"	Новосибирск	Россия	8-995-427-78-84
437	ПАО "ОптМаркет-990"	Воронеж	Россия	8-957-887-84-86
438	ПАО "Поставка-473"	Воронеж	Россия	8-980-283-87-26
439	ПАО "Ритейл-651"	Волгоград	Россия	8-971-946-82-97
440	ИП "ОптМаркет-428"	Пермь	Россия	8-922-983-40-84
441	ИП "Торговля-322"	Екатеринбург	Россия	8-916-887-18-34
442	ПАО "Ритейл-876"	Барнаул	Россия	8-929-533-68-35
443	ПАО "ОптМаркет-255"	Красноярск	Россия	8-945-475-99-97
444	ООО "Продукты-715"	Самара	Россия	8-988-714-36-18
445	ООО "Продукты-175"	Волгоград	Россия	8-966-127-98-99
446	ИП "Торговля-264"	Волгоград	Россия	8-936-656-79-19
447	ЗАО "Снабжение-803"	Нижний Новгород	Россия	8-922-906-56-70
448	ИП "Торговля-602"	Нижний Новгород	Россия	8-935-981-69-74
449	ПАО "Торговля-857"	Казань	Россия	8-968-314-33-97
450	АО "Поставка-875"	Новосибирск	Россия	8-980-389-12-95
451	ЗАО "Поставка-743"	Краснодар	Россия	8-952-324-28-67
452	ПАО "Поставка-714"	Краснодар	Россия	8-912-719-33-30
453	АО "ОптМаркет-789"	Барнаул	Россия	8-987-143-34-35
454	ООО "ОптМаркет-642"	Пермь	Россия	8-936-460-22-80
455	АО "Торговля-435"	Саратов	Россия	8-969-451-81-91
456	ООО "Поставка-251"	Санкт-Петербург	Россия	8-996-649-57-52
457	ПАО "Ритейл-711"	Новосибирск	Россия	8-934-756-90-97
458	АО "Торговля-138"	Челябинск	Россия	8-997-980-52-41
459	ИП "Поставка-656"	Самара	Россия	8-937-672-79-74
460	ООО "Поставка-223"	Нижний Новгород	Россия	8-985-576-74-95
461	ЗАО "Продукты-638"	Тюмень	Россия	8-917-277-51-20
462	ООО "Ритейл-231"	Краснодар	Россия	8-980-327-77-57
463	ЗАО "Ритейл-819"	Екатеринбург	Россия	8-930-570-11-25
464	ИП "Снабжение-676"	Барнаул	Россия	8-909-165-25-58
465	ИП "Ритейл-340"	Нижний Новгород	Россия	8-906-689-65-18
466	ПАО "Торговля-687"	Краснодар	Россия	8-919-795-63-73
467	ИП "Ритейл-106"	Новосибирск	Россия	8-931-222-96-42
468	ИП "Торговля-636"	Нижний Новгород	Россия	8-978-977-37-36
469	ПАО "Поставка-775"	Казань	Россия	8-990-502-44-60
470	АО "Поставка-505"	Красноярск	Россия	8-933-465-78-84
471	АО "Ритейл-188"	Тюмень	Россия	8-950-610-94-15
472	ООО "ОптМаркет-587"	Санкт-Петербург	Россия	8-946-169-76-57
473	ЗАО "ОптМаркет-242"	Москва	Россия	8-917-864-69-88
474	АО "Снабжение-627"	Москва	Россия	8-982-216-40-40
475	ЗАО "Торговля-655"	Воронеж	Россия	8-971-624-84-51
476	ИП "Снабжение-857"	Барнаул	Россия	8-913-581-15-82
477	ИП "ОптМаркет-519"	Самара	Россия	8-968-220-26-16
478	ЗАО "Снабжение-119"	Волгоград	Россия	8-911-752-27-19
479	ООО "Ритейл-960"	Краснодар	Россия	8-942-940-28-66
480	АО "Ритейл-269"	Барнаул	Россия	8-902-109-92-84
481	ЗАО "Снабжение-187"	Красноярск	Россия	8-972-842-60-89
482	АО "Поставка-771"	Воронеж	Россия	8-980-897-57-35
483	ПАО "Продукты-761"	Екатеринбург	Россия	8-993-193-32-27
484	ЗАО "Снабжение-926"	Саратов	Россия	8-931-539-12-42
485	ЗАО "Поставка-669"	Саратов	Россия	8-901-796-33-46
486	ПАО "Снабжение-744"	Казань	Россия	8-973-416-12-57
487	АО "Снабжение-274"	Саратов	Россия	8-911-152-16-30
488	ИП "Ритейл-861"	Нижний Новгород	Россия	8-980-731-15-38
489	ЗАО "Ритейл-730"	Тюмень	Россия	8-918-684-78-62
490	АО "ОптМаркет-521"	Волгоград	Россия	8-993-731-92-85
491	ПАО "Снабжение-579"	Нижний Новгород	Россия	8-991-534-62-40
492	ИП "Поставка-272"	Омск	Россия	8-986-995-59-67
493	ИП "Поставка-253"	Челябинск	Россия	8-908-960-12-79
494	ЗАО "Ритейл-836"	Волгоград	Россия	8-949-683-44-95
495	ПАО "ОптМаркет-668"	Казань	Россия	8-920-389-16-20
496	ИП "ОптМаркет-537"	Казань	Россия	8-968-882-91-33
497	АО "Продукты-498"	Омск	Россия	8-994-135-14-95
498	ИП "Торговля-406"	Воронеж	Россия	8-950-549-46-43
499	ЗАО "Снабжение-915"	Саратов	Россия	8-974-618-11-24
500	ПАО "Торговля-964"	Иркутск	Россия	8-906-574-16-85
501	ЗАО "Ритейл-916"	Челябинск	Россия	8-913-219-44-32
502	ЗАО "Торговля-417"	Уфа	Россия	8-960-161-32-41
503	ПАО "Ритейл-283"	Казань	Россия	8-913-846-13-61
504	ПАО "ОптМаркет-243"	Нижний Новгород	Россия	8-966-472-47-70
505	АО "Продукты-181"	Самара	Россия	8-969-358-93-20
506	ООО "Снабжение-206"	Красноярск	Россия	8-928-644-90-82
507	ИП "Торговля-839"	Москва	Россия	8-934-615-13-65
508	ЗАО "Продукты-643"	Ростов-на-Дону	Россия	8-915-452-99-45
509	ООО "Продукты-993"	Пермь	Россия	8-952-542-87-21
510	ИП "Поставка-669"	Москва	Россия	8-978-389-48-37
511	ЗАО "Снабжение-295"	Краснодар	Россия	8-978-750-12-47
512	ЗАО "Ритейл-164"	Самара	Россия	8-950-664-18-50
513	АО "Продукты-579"	Тюмень	Россия	8-986-146-88-28
514	ПАО "Ритейл-392"	Иркутск	Россия	8-919-129-65-65
515	ИП "Торговля-411"	Новосибирск	Россия	8-949-266-72-78
516	ООО "Торговля-886"	Челябинск	Россия	8-938-685-29-30
517	ПАО "Поставка-351"	Краснодар	Россия	8-911-297-37-24
518	АО "Поставка-640"	Москва	Россия	8-934-557-68-60
519	АО "Торговля-331"	Новосибирск	Россия	8-986-718-52-55
520	ЗАО "Торговля-368"	Екатеринбург	Россия	8-963-817-62-57
521	ЗАО "Продукты-515"	Краснодар	Россия	8-925-701-10-68
522	ИП "Торговля-832"	Казань	Россия	8-935-752-98-27
523	АО "Снабжение-802"	Казань	Россия	8-988-774-74-10
524	АО "Торговля-764"	Тюмень	Россия	8-972-433-73-64
525	ООО "Продукты-774"	Омск	Россия	8-944-941-98-73
526	ЗАО "Продукты-127"	Тюмень	Россия	8-975-866-23-60
527	ИП "Снабжение-356"	Екатеринбург	Россия	8-948-700-12-97
528	АО "Поставка-992"	Ростов-на-Дону	Россия	8-982-435-85-16
529	ПАО "Торговля-745"	Ростов-на-Дону	Россия	8-991-699-16-62
530	АО "ОптМаркет-737"	Новосибирск	Россия	8-905-892-42-47
531	ООО "Поставка-487"	Волгоград	Россия	8-987-972-83-52
532	ООО "Ритейл-659"	Екатеринбург	Россия	8-953-250-56-95
533	ООО "Продукты-404"	Ростов-на-Дону	Россия	8-959-575-64-59
534	ЗАО "ОптМаркет-526"	Иркутск	Россия	8-971-400-43-28
535	ИП "Ритейл-595"	Нижний Новгород	Россия	8-980-730-99-62
536	ООО "Торговля-653"	Тюмень	Россия	8-930-606-42-15
537	ЗАО "Торговля-198"	Казань	Россия	8-903-840-79-41
538	ЗАО "Торговля-373"	Новосибирск	Россия	8-961-871-83-89
539	ИП "Поставка-779"	Казань	Россия	8-918-905-77-75
540	ИП "Ритейл-402"	Челябинск	Россия	8-948-996-43-68
541	ЗАО "Продукты-738"	Воронеж	Россия	8-907-713-60-33
542	АО "Продукты-199"	Санкт-Петербург	Россия	8-941-878-91-59
543	ПАО "Торговля-260"	Омск	Россия	8-986-513-78-74
544	ЗАО "Поставка-541"	Москва	Россия	8-945-239-50-77
545	ПАО "Ритейл-287"	Санкт-Петербург	Россия	8-904-475-60-49
546	АО "Поставка-805"	Ростов-на-Дону	Россия	8-920-380-89-55
547	АО "Ритейл-205"	Краснодар	Россия	8-978-565-68-75
548	ООО "Торговля-252"	Ростов-на-Дону	Россия	8-950-658-52-55
549	ЗАО "Поставка-534"	Самара	Россия	8-985-489-44-50
550	ООО "Поставка-587"	Екатеринбург	Россия	8-943-493-40-54
551	ООО "ОптМаркет-105"	Волгоград	Россия	8-954-365-30-96
552	ПАО "Торговля-126"	Омск	Россия	8-915-289-37-25
553	ООО "Продукты-885"	Екатеринбург	Россия	8-923-376-73-20
554	ООО "ОптМаркет-296"	Новосибирск	Россия	8-975-636-95-41
555	АО "Снабжение-724"	Пермь	Россия	8-908-125-45-52
556	ЗАО "ОптМаркет-844"	Красноярск	Россия	8-913-687-13-19
557	ООО "ОптМаркет-305"	Омск	Россия	8-948-471-88-62
558	ООО "Снабжение-559"	Пермь	Россия	8-987-101-80-54
559	АО "Продукты-397"	Уфа	Россия	8-901-533-91-86
560	АО "Снабжение-715"	Саратов	Россия	8-963-672-75-52
561	ЗАО "Ритейл-108"	Воронеж	Россия	8-908-527-34-96
562	ИП "Продукты-340"	Екатеринбург	Россия	8-961-580-58-76
563	ЗАО "Поставка-752"	Тюмень	Россия	8-922-935-10-93
564	ООО "Торговля-877"	Тюмень	Россия	8-916-816-69-35
565	ИП "Продукты-599"	Санкт-Петербург	Россия	8-973-451-74-31
566	ИП "Снабжение-562"	Иркутск	Россия	8-949-869-76-84
567	ЗАО "Снабжение-934"	Нижний Новгород	Россия	8-988-793-94-21
568	АО "Снабжение-395"	Москва	Россия	8-913-141-55-44
569	АО "Ритейл-176"	Волгоград	Россия	8-959-499-71-34
570	ООО "Поставка-771"	Омск	Россия	8-927-645-74-32
571	ЗАО "Поставка-496"	Саратов	Россия	8-950-651-80-74
572	АО "Снабжение-292"	Самара	Россия	8-940-942-50-15
573	ООО "Торговля-343"	Екатеринбург	Россия	8-918-510-42-62
574	АО "Ритейл-814"	Челябинск	Россия	8-924-431-85-65
575	ИП "Продукты-564"	Уфа	Россия	8-990-373-80-16
576	АО "Торговля-137"	Нижний Новгород	Россия	8-933-546-76-96
577	ПАО "Ритейл-195"	Волгоград	Россия	8-996-958-26-31
578	ИП "Ритейл-808"	Ростов-на-Дону	Россия	8-950-102-44-35
579	ПАО "Торговля-629"	Пермь	Россия	8-934-131-60-15
580	АО "Ритейл-538"	Самара	Россия	8-976-100-60-51
581	ИП "ОптМаркет-222"	Саратов	Россия	8-973-220-95-27
582	ПАО "ОптМаркет-505"	Волгоград	Россия	8-926-854-79-91
583	ЗАО "Снабжение-794"	Воронеж	Россия	8-975-375-55-12
584	ООО "Торговля-559"	Нижний Новгород	Россия	8-981-745-92-93
585	ИП "Ритейл-317"	Омск	Россия	8-942-942-81-34
586	ИП "Ритейл-600"	Тюмень	Россия	8-902-799-94-85
587	ИП "Поставка-951"	Краснодар	Россия	8-924-341-92-33
588	АО "Ритейл-519"	Воронеж	Россия	8-927-139-86-41
589	ЗАО "Торговля-654"	Краснодар	Россия	8-981-980-42-13
590	ИП "Торговля-903"	Воронеж	Россия	8-987-570-65-42
591	ЗАО "Поставка-515"	Самара	Россия	8-922-389-63-25
592	ПАО "Снабжение-631"	Ростов-на-Дону	Россия	8-914-795-77-45
593	ЗАО "Торговля-118"	Саратов	Россия	8-964-726-59-87
594	ПАО "Снабжение-308"	Саратов	Россия	8-957-401-20-41
595	ЗАО "Торговля-524"	Челябинск	Россия	8-990-816-19-51
596	ООО "Снабжение-589"	Иркутск	Россия	8-916-967-49-80
597	ИП "Ритейл-406"	Челябинск	Россия	8-912-213-41-32
598	ЗАО "Ритейл-236"	Москва	Россия	8-952-647-58-71
599	ООО "Снабжение-556"	Екатеринбург	Россия	8-907-846-60-66
600	ИП "Снабжение-291"	Санкт-Петербург	Россия	8-939-352-63-43
601	ЗАО "Торговля-592"	Челябинск	Россия	8-972-293-63-71
602	ООО "Поставка-157"	Санкт-Петербург	Россия	8-953-955-85-85
603	ПАО "Ритейл-323"	Екатеринбург	Россия	8-928-629-68-88
604	АО "Снабжение-934"	Москва	Россия	8-947-482-35-88
605	ПАО "Торговля-802"	Санкт-Петербург	Россия	8-991-821-54-52
606	ООО "Ритейл-903"	Волгоград	Россия	8-976-711-69-14
607	ПАО "Поставка-669"	Пермь	Россия	8-923-472-66-81
608	АО "Торговля-724"	Санкт-Петербург	Россия	8-952-936-61-22
609	ПАО "Снабжение-327"	Омск	Россия	8-999-712-33-61
610	АО "Снабжение-803"	Уфа	Россия	8-968-594-29-92
611	ПАО "Ритейл-445"	Саратов	Россия	8-990-376-56-95
612	ПАО "Поставка-707"	Нижний Новгород	Россия	8-966-606-81-62
613	ПАО "Продукты-213"	Санкт-Петербург	Россия	8-935-296-16-99
614	ООО "Ритейл-295"	Барнаул	Россия	8-927-523-70-90
615	ПАО "ОптМаркет-289"	Краснодар	Россия	8-996-368-61-87
616	АО "Поставка-388"	Уфа	Россия	8-928-116-95-92
617	ИП "Поставка-956"	Саратов	Россия	8-939-844-47-62
618	ООО "Снабжение-222"	Волгоград	Россия	8-978-797-27-21
619	АО "ОптМаркет-626"	Самара	Россия	8-933-197-75-19
620	ИП "Снабжение-300"	Москва	Россия	8-983-693-91-97
621	ИП "Продукты-953"	Санкт-Петербург	Россия	8-905-761-80-33
622	ПАО "Поставка-504"	Барнаул	Россия	8-963-614-81-14
623	АО "Продукты-713"	Краснодар	Россия	8-986-183-77-63
624	ИП "Поставка-769"	Пермь	Россия	8-952-608-96-32
625	ПАО "Поставка-323"	Челябинск	Россия	8-940-612-20-21
626	АО "ОптМаркет-793"	Пермь	Россия	8-992-504-26-56
627	ООО "Торговля-198"	Санкт-Петербург	Россия	8-976-535-47-51
628	ЗАО "ОптМаркет-952"	Новосибирск	Россия	8-962-676-20-56
629	АО "Ритейл-615"	Воронеж	Россия	8-960-107-43-29
630	АО "Продукты-436"	Красноярск	Россия	8-929-303-16-72
631	ООО "Продукты-280"	Казань	Россия	8-915-342-46-86
632	ООО "Продукты-734"	Москва	Россия	8-975-866-28-61
633	ООО "Торговля-573"	Воронеж	Россия	8-904-380-79-10
634	ЗАО "Торговля-264"	Воронеж	Россия	8-961-730-82-92
635	ООО "Ритейл-590"	Казань	Россия	8-976-179-57-95
636	ООО "ОптМаркет-246"	Уфа	Россия	8-939-318-91-82
637	ПАО "Поставка-843"	Казань	Россия	8-931-668-79-17
638	ПАО "Торговля-585"	Санкт-Петербург	Россия	8-936-850-99-71
639	ООО "Торговля-883"	Челябинск	Россия	8-915-143-78-92
640	ИП "Торговля-646"	Тюмень	Россия	8-972-107-36-74
641	ООО "Поставка-338"	Уфа	Россия	8-912-438-80-17
642	ООО "Ритейл-760"	Ростов-на-Дону	Россия	8-900-473-16-83
643	ЗАО "Ритейл-714"	Нижний Новгород	Россия	8-979-349-77-48
644	АО "Ритейл-618"	Челябинск	Россия	8-966-219-52-52
645	ИП "Поставка-894"	Воронеж	Россия	8-926-631-41-89
646	ЗАО "Торговля-326"	Краснодар	Россия	8-979-743-20-45
647	АО "Поставка-878"	Тюмень	Россия	8-948-388-16-54
648	ООО "ОптМаркет-173"	Саратов	Россия	8-924-615-86-19
649	ИП "Продукты-225"	Красноярск	Россия	8-918-968-66-35
650	ООО "Ритейл-546"	Краснодар	Россия	8-984-671-21-24
651	ИП "ОптМаркет-166"	Омск	Россия	8-966-454-40-45
652	АО "ОптМаркет-931"	Омск	Россия	8-984-549-30-30
653	АО "Продукты-489"	Краснодар	Россия	8-968-505-20-60
654	АО "Торговля-603"	Екатеринбург	Россия	8-954-216-94-19
655	ИП "Продукты-392"	Саратов	Россия	8-970-290-59-55
656	ООО "Снабжение-360"	Пермь	Россия	8-908-396-16-94
657	ИП "ОптМаркет-164"	Краснодар	Россия	8-910-222-33-77
658	ЗАО "Снабжение-618"	Иркутск	Россия	8-901-796-68-43
659	ПАО "Снабжение-269"	Уфа	Россия	8-958-941-26-81
660	АО "Торговля-886"	Воронеж	Россия	8-957-205-53-78
661	ИП "Снабжение-258"	Самара	Россия	8-975-276-61-11
662	ИП "Ритейл-830"	Новосибирск	Россия	8-909-401-24-42
663	ООО "Снабжение-339"	Челябинск	Россия	8-992-863-19-57
664	ООО "Ритейл-220"	Ростов-на-Дону	Россия	8-953-151-10-72
665	ИП "Продукты-702"	Волгоград	Россия	8-970-442-80-43
666	ЗАО "Ритейл-774"	Барнаул	Россия	8-985-953-15-64
667	ИП "Ритейл-237"	Самара	Россия	8-958-842-65-37
668	АО "Поставка-418"	Ростов-на-Дону	Россия	8-907-254-49-21
669	ИП "Ритейл-488"	Самара	Россия	8-904-878-70-32
670	ЗАО "ОптМаркет-949"	Пермь	Россия	8-956-615-97-68
671	АО "Продукты-993"	Москва	Россия	8-959-611-96-53
672	ЗАО "Ритейл-496"	Тюмень	Россия	8-948-931-22-74
673	ООО "Снабжение-137"	Ростов-на-Дону	Россия	8-974-826-18-43
674	ПАО "Продукты-954"	Волгоград	Россия	8-902-618-66-74
675	ООО "Ритейл-745"	Новосибирск	Россия	8-987-944-13-20
676	АО "Поставка-127"	Пермь	Россия	8-998-753-83-89
677	АО "Снабжение-217"	Краснодар	Россия	8-919-512-53-72
678	ИП "Ритейл-752"	Саратов	Россия	8-977-281-19-45
679	ЗАО "ОптМаркет-376"	Барнаул	Россия	8-916-919-48-53
680	ЗАО "Снабжение-290"	Челябинск	Россия	8-978-449-40-98
681	АО "ОптМаркет-183"	Краснодар	Россия	8-919-139-84-48
682	ЗАО "Снабжение-536"	Омск	Россия	8-961-329-66-96
683	ООО "Снабжение-154"	Иркутск	Россия	8-946-470-69-26
684	АО "Поставка-496"	Краснодар	Россия	8-986-895-98-87
685	ООО "ОптМаркет-446"	Красноярск	Россия	8-993-948-72-25
686	ООО "Поставка-283"	Пермь	Россия	8-900-898-26-15
687	ИП "ОптМаркет-919"	Москва	Россия	8-919-734-42-17
688	ЗАО "Ритейл-239"	Самара	Россия	8-902-284-75-70
689	ООО "Торговля-208"	Барнаул	Россия	8-955-704-36-46
690	ПАО "Поставка-657"	Краснодар	Россия	8-940-620-36-50
691	ЗАО "Продукты-735"	Тюмень	Россия	8-919-137-42-51
692	ООО "ОптМаркет-813"	Самара	Россия	8-971-657-76-89
693	АО "Поставка-264"	Казань	Россия	8-969-721-91-16
694	ЗАО "Продукты-448"	Новосибирск	Россия	8-907-656-19-88
695	ЗАО "ОптМаркет-138"	Челябинск	Россия	8-920-596-13-73
696	ЗАО "Торговля-546"	Тюмень	Россия	8-967-220-94-43
697	ИП "Снабжение-381"	Пермь	Россия	8-932-809-35-58
698	АО "Торговля-692"	Новосибирск	Россия	8-997-683-77-77
699	ПАО "Торговля-123"	Волгоград	Россия	8-983-265-57-78
700	ЗАО "Поставка-925"	Казань	Россия	8-910-777-52-23
701	ИП "Ритейл-106"	Саратов	Россия	8-935-930-77-73
702	ООО "Торговля-622"	Челябинск	Россия	8-983-246-79-76
703	ИП "Продукты-990"	Новосибирск	Россия	8-936-639-63-65
704	ЗАО "ОптМаркет-245"	Ростов-на-Дону	Россия	8-963-504-83-71
705	ИП "Ритейл-397"	Барнаул	Россия	8-911-853-41-59
706	ПАО "ОптМаркет-994"	Тюмень	Россия	8-980-226-89-25
707	ИП "Продукты-354"	Иркутск	Россия	8-930-506-67-30
708	ЗАО "ОптМаркет-367"	Екатеринбург	Россия	8-951-796-64-34
709	ПАО "Торговля-239"	Краснодар	Россия	8-912-347-86-82
710	ЗАО "ОптМаркет-485"	Санкт-Петербург	Россия	8-932-340-21-45
711	АО "Торговля-335"	Санкт-Петербург	Россия	8-900-874-95-62
712	АО "Снабжение-457"	Санкт-Петербург	Россия	8-963-362-97-97
713	ООО "ОптМаркет-647"	Пермь	Россия	8-997-105-82-18
714	ЗАО "ОптМаркет-620"	Красноярск	Россия	8-967-659-53-73
715	АО "Ритейл-852"	Волгоград	Россия	8-988-535-26-89
716	АО "Поставка-892"	Казань	Россия	8-954-958-16-90
717	ПАО "Снабжение-881"	Санкт-Петербург	Россия	8-992-494-29-26
718	АО "ОптМаркет-703"	Москва	Россия	8-909-465-63-15
719	ЗАО "Поставка-154"	Саратов	Россия	8-918-191-45-73
720	АО "Продукты-368"	Екатеринбург	Россия	8-917-402-81-82
721	ПАО "Продукты-962"	Москва	Россия	8-927-369-48-71
722	ПАО "Ритейл-719"	Красноярск	Россия	8-960-412-69-37
723	ЗАО "Продукты-371"	Краснодар	Россия	8-919-688-42-48
724	АО "Ритейл-595"	Казань	Россия	8-986-101-36-20
725	АО "Ритейл-750"	Барнаул	Россия	8-949-988-39-67
726	ЗАО "Ритейл-915"	Уфа	Россия	8-964-178-74-34
727	АО "ОптМаркет-321"	Тюмень	Россия	8-901-975-47-19
728	АО "Снабжение-693"	Уфа	Россия	8-947-936-49-70
729	АО "Продукты-508"	Волгоград	Россия	8-980-984-22-24
730	ИП "ОптМаркет-139"	Пермь	Россия	8-997-402-56-89
731	ПАО "ОптМаркет-411"	Казань	Россия	8-943-885-53-77
732	АО "ОптМаркет-119"	Волгоград	Россия	8-921-913-88-17
733	ПАО "Снабжение-295"	Нижний Новгород	Россия	8-907-717-98-28
734	АО "Поставка-458"	Волгоград	Россия	8-912-824-57-78
735	ИП "Ритейл-282"	Волгоград	Россия	8-957-373-35-14
736	АО "Поставка-622"	Самара	Россия	8-988-547-99-87
737	ПАО "Поставка-108"	Пермь	Россия	8-951-282-72-54
738	ЗАО "Торговля-202"	Екатеринбург	Россия	8-981-816-59-41
739	ПАО "Торговля-267"	Самара	Россия	8-969-906-38-12
740	ООО "ОптМаркет-808"	Нижний Новгород	Россия	8-921-228-17-78
741	ИП "Продукты-528"	Красноярск	Россия	8-992-267-79-91
742	ПАО "Снабжение-910"	Новосибирск	Россия	8-993-339-17-83
743	АО "Поставка-831"	Барнаул	Россия	8-971-958-82-30
744	ПАО "Продукты-183"	Иркутск	Россия	8-988-504-74-83
745	АО "Снабжение-436"	Екатеринбург	Россия	8-931-645-34-34
746	ЗАО "Поставка-859"	Красноярск	Россия	8-919-619-86-60
747	ПАО "ОптМаркет-962"	Волгоград	Россия	8-950-286-13-84
748	АО "Снабжение-997"	Новосибирск	Россия	8-924-507-56-83
749	ООО "Торговля-821"	Краснодар	Россия	8-977-339-28-38
750	ПАО "ОптМаркет-630"	Казань	Россия	8-928-543-10-66
751	ООО "Торговля-484"	Нижний Новгород	Россия	8-944-383-50-60
752	ЗАО "Поставка-989"	Москва	Россия	8-904-462-56-85
753	ЗАО "Торговля-489"	Воронеж	Россия	8-931-319-96-52
754	ПАО "Поставка-461"	Челябинск	Россия	8-967-576-17-56
755	АО "Поставка-280"	Иркутск	Россия	8-910-578-37-23
756	ООО "Снабжение-801"	Пермь	Россия	8-958-710-79-31
757	АО "Ритейл-236"	Краснодар	Россия	8-983-398-91-58
758	ПАО "Снабжение-605"	Тюмень	Россия	8-954-674-49-79
759	ПАО "Снабжение-405"	Челябинск	Россия	8-982-303-39-20
760	ЗАО "Снабжение-735"	Омск	Россия	8-907-193-14-17
761	ИП "ОптМаркет-770"	Новосибирск	Россия	8-960-557-71-72
762	ЗАО "Снабжение-842"	Самара	Россия	8-945-130-95-16
763	ЗАО "Ритейл-883"	Санкт-Петербург	Россия	8-957-400-36-19
764	ЗАО "Ритейл-125"	Новосибирск	Россия	8-946-125-24-21
765	ЗАО "Торговля-187"	Омск	Россия	8-928-656-54-60
766	ПАО "Снабжение-384"	Омск	Россия	8-972-825-14-19
767	ЗАО "Продукты-869"	Москва	Россия	8-965-882-73-91
768	ПАО "ОптМаркет-571"	Иркутск	Россия	8-923-844-70-48
769	АО "Поставка-839"	Челябинск	Россия	8-929-490-64-85
770	АО "Снабжение-921"	Воронеж	Россия	8-979-916-93-99
771	ЗАО "Снабжение-746"	Уфа	Россия	8-980-645-69-97
772	ЗАО "ОптМаркет-318"	Новосибирск	Россия	8-987-136-55-71
773	ПАО "Поставка-719"	Екатеринбург	Россия	8-979-814-58-63
774	ООО "Снабжение-436"	Новосибирск	Россия	8-961-780-47-88
775	ПАО "Продукты-487"	Казань	Россия	8-982-189-41-66
776	ООО "Продукты-837"	Тюмень	Россия	8-934-817-62-90
777	ПАО "Ритейл-678"	Тюмень	Россия	8-982-340-86-67
778	ЗАО "Снабжение-607"	Нижний Новгород	Россия	8-932-644-51-30
779	АО "Продукты-186"	Уфа	Россия	8-915-861-72-53
780	ИП "Поставка-586"	Саратов	Россия	8-981-323-95-20
781	ООО "Снабжение-169"	Пермь	Россия	8-968-851-87-73
782	ИП "Ритейл-454"	Тюмень	Россия	8-992-556-98-80
783	АО "Снабжение-364"	Волгоград	Россия	8-998-771-49-38
784	ООО "Поставка-989"	Самара	Россия	8-998-596-62-58
785	ООО "Торговля-549"	Москва	Россия	8-916-604-70-39
786	ООО "ОптМаркет-527"	Нижний Новгород	Россия	8-920-710-71-86
787	ООО "Ритейл-203"	Воронеж	Россия	8-931-689-60-86
788	ПАО "Торговля-800"	Воронеж	Россия	8-994-385-18-83
789	АО "Снабжение-775"	Москва	Россия	8-938-308-78-90
790	ЗАО "Ритейл-200"	Ростов-на-Дону	Россия	8-964-510-77-89
791	АО "Снабжение-118"	Екатеринбург	Россия	8-953-217-61-57
792	АО "ОптМаркет-699"	Волгоград	Россия	8-969-577-33-21
793	ПАО "Поставка-432"	Иркутск	Россия	8-955-454-46-42
794	АО "Поставка-790"	Саратов	Россия	8-981-706-35-75
795	АО "Продукты-601"	Пермь	Россия	8-981-580-49-63
796	АО "ОптМаркет-503"	Саратов	Россия	8-947-219-32-85
797	ИП "Торговля-210"	Самара	Россия	8-938-204-37-60
798	ООО "ОптМаркет-910"	Красноярск	Россия	8-917-366-51-96
799	ИП "Ритейл-539"	Пермь	Россия	8-966-370-90-71
800	ООО "Поставка-144"	Челябинск	Россия	8-948-433-74-90
801	ЗАО "Ритейл-492"	Казань	Россия	8-977-369-18-73
802	ПАО "Торговля-431"	Барнаул	Россия	8-938-161-53-29
803	ПАО "Снабжение-552"	Самара	Россия	8-943-300-10-53
804	ИП "Поставка-429"	Омск	Россия	8-980-271-12-66
805	АО "Снабжение-416"	Тюмень	Россия	8-904-637-19-27
806	ЗАО "ОптМаркет-253"	Омск	Россия	8-954-891-20-43
807	ПАО "ОптМаркет-187"	Омск	Россия	8-905-271-32-33
808	ЗАО "Продукты-579"	Москва	Россия	8-978-660-64-90
809	ИП "Снабжение-594"	Санкт-Петербург	Россия	8-964-556-55-60
810	ИП "Торговля-644"	Нижний Новгород	Россия	8-959-943-87-95
811	ПАО "Продукты-243"	Екатеринбург	Россия	8-949-764-29-86
812	ООО "Ритейл-865"	Барнаул	Россия	8-917-786-66-96
813	АО "Ритейл-530"	Омск	Россия	8-936-571-15-79
814	ООО "Ритейл-508"	Нижний Новгород	Россия	8-962-163-79-84
815	ООО "ОптМаркет-141"	Челябинск	Россия	8-988-372-88-86
816	ИП "ОптМаркет-275"	Санкт-Петербург	Россия	8-933-623-32-77
817	ПАО "Торговля-756"	Уфа	Россия	8-903-270-67-61
818	ИП "Торговля-543"	Иркутск	Россия	8-907-644-26-82
819	ЗАО "Ритейл-361"	Уфа	Россия	8-910-600-15-97
820	ПАО "Ритейл-719"	Уфа	Россия	8-993-611-36-85
821	АО "Поставка-267"	Краснодар	Россия	8-910-937-93-19
822	АО "Ритейл-556"	Самара	Россия	8-990-433-64-69
823	ПАО "Поставка-759"	Иркутск	Россия	8-911-179-83-89
824	ПАО "Торговля-390"	Уфа	Россия	8-944-464-33-11
825	ПАО "Ритейл-514"	Санкт-Петербург	Россия	8-973-491-73-63
826	ООО "Торговля-103"	Красноярск	Россия	8-939-952-22-17
827	АО "Продукты-257"	Саратов	Россия	8-946-181-72-50
828	ООО "Продукты-309"	Екатеринбург	Россия	8-931-972-95-56
829	АО "Торговля-353"	Санкт-Петербург	Россия	8-949-835-30-39
830	ИП "ОптМаркет-600"	Ростов-на-Дону	Россия	8-921-708-64-24
831	ИП "Снабжение-199"	Нижний Новгород	Россия	8-963-609-28-58
832	ЗАО "Ритейл-441"	Нижний Новгород	Россия	8-912-764-81-15
833	ООО "Продукты-448"	Челябинск	Россия	8-940-961-36-41
834	ПАО "ОптМаркет-697"	Омск	Россия	8-974-601-22-51
835	ООО "Торговля-665"	Красноярск	Россия	8-996-444-24-96
836	ИП "Продукты-374"	Иркутск	Россия	8-979-893-36-36
837	ООО "Торговля-714"	Воронеж	Россия	8-956-263-96-55
838	ИП "Продукты-463"	Нижний Новгород	Россия	8-925-134-43-65
839	ООО "Ритейл-536"	Воронеж	Россия	8-931-801-89-51
840	ПАО "Продукты-476"	Краснодар	Россия	8-973-691-80-77
841	ИП "ОптМаркет-855"	Барнаул	Россия	8-995-524-22-38
842	ИП "Ритейл-816"	Краснодар	Россия	8-937-505-12-52
843	ЗАО "Поставка-922"	Омск	Россия	8-930-837-23-95
844	АО "ОптМаркет-450"	Барнаул	Россия	8-991-389-70-81
845	АО "Продукты-779"	Ростов-на-Дону	Россия	8-959-831-74-87
846	ЗАО "Поставка-645"	Краснодар	Россия	8-996-124-80-94
847	ЗАО "Снабжение-873"	Нижний Новгород	Россия	8-935-982-85-63
848	ООО "ОптМаркет-773"	Пермь	Россия	8-973-108-89-44
849	ООО "ОптМаркет-375"	Краснодар	Россия	8-997-611-77-24
850	ЗАО "Снабжение-919"	Нижний Новгород	Россия	8-920-483-59-69
851	ИП "Поставка-862"	Санкт-Петербург	Россия	8-976-620-99-88
852	ИП "Торговля-168"	Омск	Россия	8-950-579-65-94
853	ИП "Поставка-313"	Тюмень	Россия	8-934-751-40-30
854	ООО "Продукты-242"	Уфа	Россия	8-937-523-92-49
855	ООО "ОптМаркет-905"	Новосибирск	Россия	8-985-746-41-31
856	ООО "Снабжение-828"	Санкт-Петербург	Россия	8-911-679-35-78
857	ООО "Торговля-541"	Челябинск	Россия	8-939-431-32-19
858	АО "Торговля-244"	Санкт-Петербург	Россия	8-957-413-71-42
859	ЗАО "Ритейл-226"	Красноярск	Россия	8-999-454-54-91
860	ЗАО "Снабжение-382"	Пермь	Россия	8-916-408-32-86
861	ПАО "Продукты-822"	Москва	Россия	8-921-255-97-57
862	ПАО "Снабжение-983"	Новосибирск	Россия	8-932-845-69-44
863	ООО "Снабжение-120"	Челябинск	Россия	8-902-126-25-77
864	ИП "Ритейл-171"	Красноярск	Россия	8-921-347-35-80
865	ООО "Торговля-526"	Челябинск	Россия	8-938-142-17-16
866	ИП "Поставка-713"	Барнаул	Россия	8-948-692-63-61
867	ООО "Продукты-867"	Москва	Россия	8-952-874-86-95
868	ПАО "Торговля-617"	Краснодар	Россия	8-936-272-10-13
869	ООО "Торговля-407"	Екатеринбург	Россия	8-997-845-99-91
870	ЗАО "Продукты-846"	Уфа	Россия	8-974-737-77-47
871	ПАО "Продукты-628"	Уфа	Россия	8-951-344-73-33
872	ПАО "Ритейл-358"	Екатеринбург	Россия	8-956-477-34-15
873	ИП "ОптМаркет-815"	Красноярск	Россия	8-996-474-13-78
874	ПАО "Поставка-881"	Ростов-на-Дону	Россия	8-990-980-76-42
875	ООО "ОптМаркет-456"	Иркутск	Россия	8-918-961-62-32
876	ИП "Поставка-147"	Уфа	Россия	8-971-958-81-21
877	ИП "Продукты-857"	Воронеж	Россия	8-917-422-87-83
878	ООО "Поставка-914"	Барнаул	Россия	8-996-284-12-91
879	АО "Ритейл-561"	Волгоград	Россия	8-902-535-76-49
880	АО "Поставка-542"	Омск	Россия	8-926-728-50-98
881	ЗАО "Ритейл-391"	Барнаул	Россия	8-921-944-25-18
882	ЗАО "Торговля-471"	Самара	Россия	8-905-457-62-80
883	ЗАО "Поставка-977"	Тюмень	Россия	8-955-278-50-84
884	ИП "Поставка-818"	Омск	Россия	8-953-239-17-59
885	ПАО "Поставка-399"	Иркутск	Россия	8-952-759-73-33
886	ЗАО "Снабжение-646"	Екатеринбург	Россия	8-979-121-10-62
887	ЗАО "Снабжение-244"	Волгоград	Россия	8-989-446-53-81
888	ИП "Торговля-637"	Краснодар	Россия	8-969-128-60-46
889	ЗАО "Снабжение-953"	Челябинск	Россия	8-990-200-30-37
890	ЗАО "Снабжение-680"	Ростов-на-Дону	Россия	8-955-485-66-25
891	ПАО "Поставка-186"	Челябинск	Россия	8-966-111-91-26
892	ЗАО "ОптМаркет-656"	Новосибирск	Россия	8-950-946-87-18
893	ПАО "Торговля-832"	Воронеж	Россия	8-924-179-35-98
894	ПАО "ОптМаркет-902"	Саратов	Россия	8-950-912-42-40
895	ООО "Продукты-595"	Омск	Россия	8-942-792-20-51
896	ПАО "ОптМаркет-973"	Санкт-Петербург	Россия	8-966-198-62-14
897	ООО "Снабжение-816"	Краснодар	Россия	8-905-315-88-64
898	ПАО "Ритейл-835"	Ростов-на-Дону	Россия	8-978-863-48-87
899	ЗАО "Снабжение-265"	Самара	Россия	8-968-235-34-25
900	ООО "Торговля-571"	Ростов-на-Дону	Россия	8-974-484-72-34
901	ИП "Ритейл-679"	Уфа	Россия	8-929-298-22-48
902	ИП "Торговля-872"	Барнаул	Россия	8-980-539-54-36
903	ООО "ОптМаркет-906"	Санкт-Петербург	Россия	8-948-832-75-58
904	ИП "Поставка-569"	Казань	Россия	8-933-839-94-22
905	ИП "Продукты-810"	Тюмень	Россия	8-938-420-50-18
906	АО "ОптМаркет-881"	Уфа	Россия	8-902-750-82-59
907	ООО "Торговля-980"	Самара	Россия	8-958-534-80-46
908	ПАО "Продукты-105"	Нижний Новгород	Россия	8-993-411-72-37
909	ООО "Продукты-751"	Волгоград	Россия	8-963-684-50-67
910	ООО "Снабжение-195"	Ростов-на-Дону	Россия	8-973-812-70-96
911	ИП "ОптМаркет-346"	Пермь	Россия	8-907-970-31-39
912	АО "Ритейл-969"	Ростов-на-Дону	Россия	8-967-900-64-99
913	ПАО "Торговля-727"	Самара	Россия	8-965-798-69-60
914	ЗАО "Снабжение-377"	Казань	Россия	8-907-173-87-75
915	АО "Ритейл-422"	Екатеринбург	Россия	8-977-838-27-88
916	ООО "Продукты-266"	Тюмень	Россия	8-976-884-44-68
917	ЗАО "Продукты-376"	Красноярск	Россия	8-902-457-45-56
918	ИП "Снабжение-281"	Самара	Россия	8-917-697-54-86
919	ПАО "Ритейл-568"	Барнаул	Россия	8-908-611-10-52
920	ПАО "ОптМаркет-463"	Москва	Россия	8-924-422-62-96
921	ООО "Снабжение-866"	Уфа	Россия	8-976-401-31-17
922	ПАО "Поставка-207"	Пермь	Россия	8-907-570-73-29
923	ЗАО "ОптМаркет-841"	Нижний Новгород	Россия	8-901-375-48-31
924	ПАО "Продукты-804"	Иркутск	Россия	8-992-318-86-48
925	ИП "Продукты-517"	Краснодар	Россия	8-941-314-81-85
926	ООО "Продукты-408"	Новосибирск	Россия	8-900-146-33-46
927	ИП "Ритейл-682"	Самара	Россия	8-959-439-19-15
928	ПАО "Торговля-114"	Ростов-на-Дону	Россия	8-955-431-30-90
929	ПАО "Поставка-440"	Уфа	Россия	8-908-302-16-12
930	АО "Снабжение-999"	Иркутск	Россия	8-918-769-90-22
931	АО "ОптМаркет-895"	Барнаул	Россия	8-903-142-82-27
932	АО "Торговля-292"	Санкт-Петербург	Россия	8-964-655-76-63
933	ПАО "ОптМаркет-198"	Москва	Россия	8-940-347-62-48
934	ПАО "ОптМаркет-307"	Самара	Россия	8-946-842-39-44
935	ИП "Продукты-467"	Уфа	Россия	8-911-334-54-59
936	ПАО "Поставка-678"	Волгоград	Россия	8-923-799-82-71
937	АО "Снабжение-206"	Москва	Россия	8-977-927-22-19
938	ЗАО "Снабжение-683"	Казань	Россия	8-910-305-69-58
939	ПАО "Продукты-715"	Барнаул	Россия	8-939-401-10-77
940	ПАО "Снабжение-985"	Краснодар	Россия	8-930-213-31-52
941	ПАО "Продукты-589"	Красноярск	Россия	8-908-807-35-37
942	ИП "Торговля-850"	Воронеж	Россия	8-954-703-95-41
943	АО "ОптМаркет-328"	Челябинск	Россия	8-947-846-63-44
944	ЗАО "Продукты-541"	Челябинск	Россия	8-920-430-51-69
945	ООО "Ритейл-506"	Воронеж	Россия	8-924-540-41-12
946	ЗАО "Продукты-761"	Челябинск	Россия	8-969-854-51-41
947	ЗАО "Ритейл-528"	Пермь	Россия	8-900-310-47-42
948	АО "Поставка-219"	Пермь	Россия	8-923-615-42-94
949	ЗАО "ОптМаркет-547"	Москва	Россия	8-961-512-81-44
950	ООО "Снабжение-861"	Волгоград	Россия	8-978-910-79-39
951	АО "Продукты-804"	Тюмень	Россия	8-999-717-93-34
952	ПАО "Торговля-271"	Красноярск	Россия	8-947-387-64-15
953	ИП "Торговля-942"	Нижний Новгород	Россия	8-935-221-99-36
954	ИП "Поставка-612"	Пермь	Россия	8-985-856-71-61
955	АО "Торговля-281"	Краснодар	Россия	8-909-631-83-82
956	ООО "ОптМаркет-145"	Челябинск	Россия	8-954-872-14-56
957	ИП "Торговля-977"	Пермь	Россия	8-970-982-61-56
958	ООО "Продукты-832"	Красноярск	Россия	8-919-655-71-69
959	ИП "Торговля-446"	Казань	Россия	8-977-795-77-64
960	ИП "Ритейл-927"	Санкт-Петербург	Россия	8-958-309-13-32
961	ООО "Снабжение-982"	Москва	Россия	8-965-207-12-64
962	ИП "ОптМаркет-291"	Челябинск	Россия	8-911-335-30-66
963	ЗАО "ОптМаркет-483"	Самара	Россия	8-944-505-44-89
964	ИП "ОптМаркет-522"	Москва	Россия	8-968-594-12-45
965	ПАО "Торговля-796"	Казань	Россия	8-956-412-99-49
966	ООО "Ритейл-591"	Екатеринбург	Россия	8-928-609-14-94
967	ЗАО "Ритейл-384"	Краснодар	Россия	8-911-278-78-19
968	АО "Снабжение-492"	Нижний Новгород	Россия	8-945-159-51-24
969	ПАО "Торговля-858"	Краснодар	Россия	8-937-390-72-71
970	ИП "ОптМаркет-857"	Нижний Новгород	Россия	8-932-652-59-85
971	ООО "Поставка-788"	Саратов	Россия	8-936-871-81-99
972	ЗАО "Поставка-189"	Самара	Россия	8-917-937-49-34
973	ПАО "Поставка-531"	Казань	Россия	8-962-894-33-31
974	ИП "Торговля-700"	Уфа	Россия	8-987-330-43-90
975	ЗАО "Ритейл-346"	Новосибирск	Россия	8-953-287-46-28
976	АО "Ритейл-221"	Иркутск	Россия	8-940-727-11-37
977	ЗАО "Торговля-197"	Омск	Россия	8-930-138-74-12
978	ООО "Торговля-119"	Барнаул	Россия	8-985-823-37-52
979	АО "Продукты-783"	Ростов-на-Дону	Россия	8-960-713-88-74
980	ООО "Ритейл-759"	Барнаул	Россия	8-987-810-61-20
981	АО "ОптМаркет-773"	Нижний Новгород	Россия	8-982-712-45-50
982	ИП "Поставка-865"	Красноярск	Россия	8-949-255-47-14
983	ИП "ОптМаркет-485"	Челябинск	Россия	8-955-588-44-22
984	ЗАО "ОптМаркет-667"	Челябинск	Россия	8-948-890-90-37
985	ООО "Продукты-917"	Тюмень	Россия	8-952-171-97-37
986	ЗАО "Ритейл-949"	Казань	Россия	8-915-684-81-76
987	ПАО "Поставка-563"	Барнаул	Россия	8-966-873-21-95
988	ЗАО "Торговля-146"	Тюмень	Россия	8-943-708-70-38
989	ЗАО "Поставка-751"	Ростов-на-Дону	Россия	8-907-209-81-58
990	ООО "Снабжение-587"	Омск	Россия	8-950-738-10-53
991	ЗАО "Продукты-283"	Нижний Новгород	Россия	8-946-883-58-10
992	АО "Ритейл-119"	Нижний Новгород	Россия	8-937-692-45-32
993	ИП "Ритейл-810"	Ростов-на-Дону	Россия	8-940-633-94-73
994	АО "Продукты-238"	Омск	Россия	8-936-208-75-32
995	ИП "Снабжение-578"	Саратов	Россия	8-976-858-60-44
996	АО "Поставка-576"	Санкт-Петербург	Россия	8-919-980-66-94
997	АО "Торговля-625"	Краснодар	Россия	8-969-450-49-19
998	ПАО "Ритейл-734"	Краснодар	Россия	8-984-650-56-20
999	ЗАО "Торговля-487"	Уфа	Россия	8-923-952-67-84
1000	ПАО "Снабжение-831"	Ростов-на-Дону	Россия	8-927-140-40-50
1001	ИП "Ритейл-611"	Красноярск	Россия	8-962-657-43-92
1002	ИП "Торговля-582"	Пермь	Россия	8-987-947-28-60
1003	ООО "Торговля-925"	Москва	Россия	8-930-581-64-95
1004	ЗАО "Поставка-591"	Омск	Россия	8-970-704-68-65
1005	АО "Продукты-242"	Ростов-на-Дону	Россия	8-911-111-94-75
1006	ИП "Торговля-915"	Ростов-на-Дону	Россия	8-959-314-62-38
1007	ЗАО "Продукты-562"	Краснодар	Россия	8-919-627-26-57
1008	ИП "Торговля-468"	Екатеринбург	Россия	8-967-570-68-49
1009	ЗАО "Ритейл-424"	Москва	Россия	8-916-840-95-13
1010	ПАО "Продукты-707"	Тюмень	Россия	8-911-352-40-68
1011	ООО "Снабжение-860"	Самара	Россия	8-982-731-79-86
1012	АО "Торговля-867"	Краснодар	Россия	8-949-163-93-91
1013	ИП "Ритейл-860"	Нижний Новгород	Россия	8-969-269-67-41
1014	ПАО "Поставка-665"	Волгоград	Россия	8-995-724-99-96
1015	ООО "Снабжение-953"	Челябинск	Россия	8-940-135-13-75
1016	АО "Поставка-259"	Волгоград	Россия	8-978-210-67-80
1017	ООО "Поставка-268"	Воронеж	Россия	8-970-857-47-11
1018	ООО "Ритейл-941"	Саратов	Россия	8-905-969-49-13
1019	ПАО "Продукты-725"	Омск	Россия	8-959-654-99-74
1020	ИП "Торговля-565"	Омск	Россия	8-930-241-40-98
1021	ИП "Ритейл-967"	Челябинск	Россия	8-980-342-33-59
1022	ИП "Ритейл-150"	Красноярск	Россия	8-969-785-19-77
1023	ООО "Поставка-446"	Новосибирск	Россия	8-957-864-57-97
1024	ЗАО "Ритейл-762"	Ростов-на-Дону	Россия	8-942-118-41-16
1025	ИП "Ритейл-762"	Москва	Россия	8-964-175-87-69
1026	ООО "Торговля-521"	Краснодар	Россия	8-906-163-70-74
1027	ПАО "Снабжение-277"	Воронеж	Россия	8-983-303-15-68
1028	ИП "Торговля-460"	Москва	Россия	8-967-150-52-90
1029	АО "Продукты-935"	Омск	Россия	8-978-419-63-85
1030	ИП "Продукты-373"	Краснодар	Россия	8-942-806-89-57
1031	ПАО "Снабжение-213"	Иркутск	Россия	8-925-590-63-61
1032	ООО "Продукты-353"	Уфа	Россия	8-995-536-44-48
1033	ИП "Снабжение-410"	Уфа	Россия	8-985-994-66-14
1034	АО "Ритейл-357"	Воронеж	Россия	8-998-885-83-67
1035	ИП "Поставка-582"	Саратов	Россия	8-953-661-88-36
1036	ПАО "Снабжение-239"	Новосибирск	Россия	8-936-267-29-18
1037	ООО "Поставка-934"	Краснодар	Россия	8-987-246-36-23
1038	ООО "Продукты-293"	Воронеж	Россия	8-984-853-74-40
1039	ПАО "Поставка-582"	Ростов-на-Дону	Россия	8-934-613-43-17
1040	ЗАО "ОптМаркет-547"	Челябинск	Россия	8-954-761-11-91
1041	ИП "Торговля-181"	Воронеж	Россия	8-901-955-99-49
1042	ООО "Торговля-763"	Уфа	Россия	8-982-895-30-60
1043	ЗАО "Ритейл-325"	Воронеж	Россия	8-973-441-60-97
1044	ЗАО "Ритейл-810"	Челябинск	Россия	8-903-611-94-40
1045	ИП "Ритейл-410"	Новосибирск	Россия	8-995-728-95-25
1046	АО "Поставка-719"	Казань	Россия	8-934-853-62-32
1047	ПАО "Поставка-399"	Краснодар	Россия	8-910-697-79-22
1048	ЗАО "Поставка-679"	Нижний Новгород	Россия	8-975-974-27-94
1049	ИП "Продукты-600"	Волгоград	Россия	8-918-540-26-92
1050	ЗАО "Торговля-488"	Тюмень	Россия	8-922-673-58-43
\.


--
-- TOC entry 3732 (class 0 OID 16855)
-- Dependencies: 237
-- Data for Name: invoice; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.invoice (invoice_id, order_id, amount, issue_date, payment_date, payment_status) FROM stdin;
1	1	15840	2024-03-15	\N	ожидание
2	2	18267	2024-03-21	\N	отменён
3	3	6283	2024-03-23	\N	ожидание
4	4	8278	2024-03-25	2024-03-28	оплачен
5	5	27027	2024-03-17	\N	отменён
6	6	9120	2024-03-27	\N	отменён
7	7	7222	2024-03-30	2024-04-01	оплачен
8	8	12481	2024-03-24	2024-03-28	оплачен
9	9	29205	2024-03-17	2024-03-22	оплачен
10	10	35945	2024-03-26	\N	ожидание
11	11	15064	2024-03-15	\N	отменён
12	12	14998	2024-03-22	\N	ожидание
13	13	1904	2024-03-26	2024-03-31	оплачен
14	14	22480	2024-03-20	2024-03-22	оплачен
15	15	27828	2024-03-15	2024-03-17	оплачен
16	16	14972	2024-03-21	\N	ожидание
17	17	19434	2024-03-15	\N	отменён
18	18	13652	2024-03-26	2024-03-27	оплачен
19	19	14310	2024-03-19	2024-03-24	оплачен
20	20	28000	2024-03-21	2024-03-24	оплачен
21	21	13340	2024-03-30	2024-04-02	оплачен
22	22	28782	2024-03-27	\N	отменён
23	23	20387	2024-03-28	2024-03-30	оплачен
24	24	18216	2024-03-22	\N	отменён
25	25	5575	2024-03-22	2024-03-23	оплачен
26	26	41013	2024-03-16	\N	отменён
27	27	28059	2024-03-18	\N	отменён
28	28	14586	2024-03-25	\N	ожидание
29	29	25093	2024-03-30	2024-04-02	оплачен
30	30	7900	2024-03-17	2024-03-19	оплачен
31	31	20198	2024-03-24	2024-03-29	оплачен
32	32	29336	2024-03-21	2024-03-23	оплачен
33	33	7765	2024-03-16	\N	отменён
34	34	24948	2024-03-25	\N	отменён
35	35	6298	2024-03-17	\N	ожидание
36	36	20103	2024-03-24	\N	ожидание
37	37	6528	2024-03-23	2024-03-27	оплачен
38	38	2055	2024-03-16	\N	ожидание
39	39	16938	2024-03-25	\N	отменён
40	40	23170	2024-03-21	2024-03-26	оплачен
41	41	4128	2024-03-16	\N	отменён
42	42	24206	2024-03-15	\N	ожидание
43	43	8692	2024-03-28	\N	ожидание
44	44	30571	2024-03-19	\N	ожидание
45	45	48294	2024-03-21	\N	ожидание
46	46	5184	2024-03-19	\N	отменён
47	47	16044	2024-03-25	2024-03-26	оплачен
48	48	7176	2024-03-24	2024-03-25	оплачен
49	49	7744	2024-03-23	\N	ожидание
50	50	12031	2024-03-16	\N	ожидание
51	51	42098	2024-03-29	\N	отменён
52	52	5838	2024-03-23	2024-03-26	оплачен
53	53	32869	2024-03-29	\N	отменён
54	54	8350	2024-03-15	\N	ожидание
55	55	28568	2024-03-27	2024-03-28	оплачен
56	56	14966	2024-03-26	\N	отменён
57	57	22476	2024-03-21	2024-03-26	оплачен
58	58	13372	2024-03-22	2024-03-27	оплачен
59	59	8880	2024-03-17	\N	отменён
60	60	6996	2024-03-24	\N	отменён
61	61	19065	2024-03-29	2024-03-31	оплачен
62	62	26330	2024-03-21	\N	отменён
63	63	13215	2024-03-21	\N	ожидание
64	64	6104	2024-03-27	\N	ожидание
65	65	12512	2024-03-26	2024-03-30	оплачен
66	66	21125	2024-03-16	2024-03-19	оплачен
67	67	9030	2024-03-28	\N	отменён
68	68	645	2024-03-17	2024-03-20	оплачен
69	69	7469	2024-03-25	\N	отменён
70	70	27956	2024-03-17	\N	отменён
71	71	33228	2024-03-21	\N	отменён
72	72	23010	2024-03-27	\N	отменён
73	73	24070	2024-03-15	\N	отменён
74	74	26561	2024-03-23	2024-03-27	оплачен
75	75	12253	2024-03-22	\N	ожидание
76	76	10785	2024-03-26	2024-03-28	оплачен
77	77	22172	2024-03-30	2024-03-31	оплачен
78	78	29839	2024-03-20	\N	отменён
79	79	17750	2024-03-30	\N	ожидание
80	80	6396	2024-03-27	\N	ожидание
81	81	6808	2024-03-20	\N	отменён
82	82	4599	2024-03-28	2024-04-02	оплачен
83	83	9162	2024-03-21	\N	отменён
84	84	900	2024-03-19	\N	ожидание
85	85	48920	2024-03-19	2024-03-21	оплачен
86	86	37817	2024-03-21	\N	отменён
87	87	42261	2024-03-21	\N	ожидание
88	88	20278	2024-03-20	2024-03-24	оплачен
89	89	22388	2024-03-28	2024-03-29	оплачен
90	90	3570	2024-03-22	\N	ожидание
91	91	13287	2024-03-15	\N	ожидание
92	92	7398	2024-03-27	2024-03-31	оплачен
93	93	12428	2024-03-25	\N	ожидание
94	94	23181	2024-03-27	\N	ожидание
95	95	25181	2024-03-19	\N	отменён
96	96	31600	2024-03-15	\N	ожидание
97	97	13480	2024-03-24	2024-03-26	оплачен
98	98	5130	2024-03-15	2024-03-17	оплачен
99	99	3132	2024-03-18	2024-03-22	оплачен
100	100	14631	2024-03-28	2024-04-02	оплачен
101	101	9408	2024-03-19	\N	отменён
102	102	10184	2024-03-27	\N	ожидание
103	103	17829	2024-03-29	2024-03-30	оплачен
104	104	10230	2024-03-16	\N	ожидание
105	105	7546	2024-03-29	2024-03-31	оплачен
106	106	26055	2024-03-28	2024-03-31	оплачен
107	107	38602	2024-03-22	\N	ожидание
108	108	24531	2024-03-19	2024-03-22	оплачен
109	109	1947	2024-03-27	\N	ожидание
110	110	18008	2024-03-17	\N	ожидание
111	111	33715	2024-03-18	\N	отменён
112	112	8602	2024-03-23	2024-03-24	оплачен
113	113	5775	2024-03-21	\N	отменён
114	114	5090	2024-03-15	2024-03-17	оплачен
115	115	2831	2024-03-15	\N	ожидание
116	116	8748	2024-03-18	\N	ожидание
117	117	16789	2024-03-21	\N	отменён
118	118	4960	2024-03-29	\N	отменён
119	119	17952	2024-03-23	\N	отменён
120	120	250	2024-03-16	\N	ожидание
121	121	8319	2024-03-21	2024-03-22	оплачен
122	122	11132	2024-03-25	\N	отменён
123	123	22270	2024-03-19	2024-03-23	оплачен
124	124	21456	2024-03-25	\N	ожидание
125	125	2082	2024-03-22	\N	ожидание
126	126	24283	2024-03-30	\N	отменён
127	127	9514	2024-03-22	2024-03-27	оплачен
128	128	39034	2024-03-28	2024-03-30	оплачен
129	129	12324	2024-03-26	\N	ожидание
130	130	18452	2024-03-26	\N	отменён
131	131	34480	2024-03-28	2024-04-01	оплачен
132	132	10276	2024-03-24	\N	отменён
133	133	25864	2024-03-26	\N	отменён
134	134	8700	2024-03-15	2024-03-20	оплачен
135	135	17086	2024-03-28	2024-04-02	оплачен
136	136	32844	2024-03-28	\N	ожидание
137	137	33876	2024-03-23	\N	отменён
138	138	20307	2024-03-29	\N	отменён
139	139	17701	2024-03-19	\N	ожидание
140	140	50286	2024-03-19	\N	отменён
141	141	21185	2024-03-21	2024-03-25	оплачен
142	142	28100	2024-03-17	\N	ожидание
143	143	25774	2024-03-22	\N	отменён
144	144	16458	2024-03-22	\N	ожидание
145	145	14838	2024-03-27	\N	отменён
146	146	29308	2024-03-30	\N	отменён
147	147	25698	2024-03-21	\N	ожидание
148	148	14964	2024-03-18	2024-03-22	оплачен
149	149	47184	2024-03-16	\N	ожидание
150	150	6252	2024-03-23	\N	отменён
151	151	6930	2024-03-28	\N	ожидание
152	152	3588	2024-03-18	\N	отменён
153	153	10767	2024-03-20	\N	отменён
154	154	20662	2024-03-27	\N	ожидание
155	155	14558	2024-03-19	\N	отменён
156	156	16239	2024-03-17	2024-03-18	оплачен
157	157	17645	2024-03-21	2024-03-24	оплачен
158	158	31731	2024-03-25	\N	ожидание
159	159	41763	2024-03-27	\N	отменён
160	160	16757	2024-03-21	\N	ожидание
161	161	30329	2024-03-29	\N	ожидание
162	162	1638	2024-03-28	\N	ожидание
163	163	19740	2024-03-17	\N	отменён
164	164	22496	2024-03-18	\N	ожидание
165	165	21925	2024-03-15	\N	отменён
166	166	5775	2024-03-23	\N	ожидание
167	167	6801	2024-03-19	\N	ожидание
168	168	12414	2024-03-25	\N	ожидание
169	169	19015	2024-03-17	\N	отменён
170	170	19314	2024-03-30	\N	отменён
171	171	5882	2024-03-27	2024-03-31	оплачен
172	172	3904	2024-03-23	2024-03-28	оплачен
173	173	25332	2024-03-25	2024-03-26	оплачен
174	174	30304	2024-03-20	2024-03-24	оплачен
175	175	6142	2024-03-15	\N	ожидание
176	176	25190	2024-03-20	2024-03-22	оплачен
177	177	4953	2024-03-21	2024-03-23	оплачен
178	178	46666	2024-03-30	\N	ожидание
179	179	25136	2024-03-19	\N	отменён
180	180	22882	2024-03-16	\N	ожидание
181	181	30267	2024-03-28	\N	ожидание
182	182	8778	2024-03-28	\N	ожидание
183	183	26295	2024-03-28	2024-04-01	оплачен
184	184	4800	2024-03-28	\N	ожидание
185	185	25812	2024-03-19	2024-03-21	оплачен
186	186	23122	2024-03-22	\N	ожидание
187	187	11459	2024-03-30	\N	отменён
188	188	12993	2024-03-22	\N	ожидание
189	189	8048	2024-03-26	2024-03-30	оплачен
190	190	23150	2024-03-15	\N	ожидание
191	191	12020	2024-03-17	2024-03-18	оплачен
192	192	27059	2024-03-28	\N	ожидание
193	193	16796	2024-03-25	2024-03-27	оплачен
194	194	1476	2024-03-15	\N	отменён
195	195	22461	2024-03-18	\N	отменён
196	196	3220	2024-03-22	\N	ожидание
197	197	7128	2024-03-26	2024-03-31	оплачен
198	198	14250	2024-03-29	\N	ожидание
199	199	20991	2024-03-26	2024-03-27	оплачен
200	200	17876	2024-03-15	2024-03-16	оплачен
201	201	8510	2024-03-28	2024-03-31	оплачен
202	202	24944	2024-03-15	\N	ожидание
203	203	23165	2024-03-16	\N	ожидание
204	204	9128	2024-03-20	\N	ожидание
205	205	38575	2024-03-21	\N	отменён
206	206	34385	2024-03-15	2024-03-17	оплачен
207	207	4148	2024-03-15	2024-03-20	оплачен
208	208	24722	2024-03-21	2024-03-22	оплачен
209	209	19120	2024-03-28	2024-03-30	оплачен
210	210	34484	2024-03-16	\N	отменён
211	211	27647	2024-03-27	2024-04-01	оплачен
212	212	43796	2024-03-27	\N	ожидание
213	213	15620	2024-03-25	\N	ожидание
214	214	25269	2024-03-26	2024-03-29	оплачен
215	215	42648	2024-03-30	\N	отменён
216	216	16530	2024-03-27	\N	отменён
217	217	25444	2024-03-28	\N	отменён
218	218	4894	2024-03-15	\N	ожидание
219	219	10159	2024-03-18	\N	ожидание
220	220	17085	2024-03-26	\N	отменён
221	221	4140	2024-03-25	2024-03-29	оплачен
222	222	8901	2024-03-30	\N	отменён
223	223	13200	2024-03-24	2024-03-25	оплачен
224	224	20910	2024-03-16	\N	отменён
225	225	33110	2024-03-22	2024-03-23	оплачен
226	226	12272	2024-03-23	2024-03-25	оплачен
227	227	22652	2024-03-27	\N	отменён
228	228	31467	2024-03-30	2024-04-01	оплачен
229	229	18865	2024-03-20	2024-03-23	оплачен
230	230	6419	2024-03-16	\N	отменён
231	231	3487	2024-03-27	\N	отменён
232	232	13035	2024-03-17	2024-03-18	оплачен
233	233	35523	2024-03-28	\N	отменён
234	234	10800	2024-03-24	\N	отменён
235	235	26717	2024-03-21	\N	ожидание
236	236	12075	2024-03-27	\N	отменён
237	237	15623	2024-03-29	\N	отменён
238	238	45136	2024-03-25	\N	отменён
239	239	10862	2024-03-22	2024-03-27	оплачен
240	240	24195	2024-03-24	\N	ожидание
241	241	39893	2024-03-24	\N	ожидание
242	242	36513	2024-03-29	\N	ожидание
243	243	46749	2024-03-17	2024-03-18	оплачен
244	244	24244	2024-03-28	\N	ожидание
245	245	4512	2024-03-15	2024-03-20	оплачен
246	246	19750	2024-03-28	2024-03-30	оплачен
247	247	23574	2024-03-29	\N	отменён
248	248	23093	2024-03-25	\N	отменён
249	249	21922	2024-03-18	2024-03-22	оплачен
250	250	32357	2024-03-18	2024-03-20	оплачен
251	251	20850	2024-03-27	2024-03-30	оплачен
252	252	10650	2024-03-23	2024-03-26	оплачен
253	253	44963	2024-03-18	2024-03-23	оплачен
254	254	7007	2024-03-21	\N	отменён
255	255	30515	2024-03-15	\N	отменён
256	256	23409	2024-03-19	2024-03-20	оплачен
257	257	8968	2024-03-21	\N	отменён
258	258	3894	2024-03-19	\N	отменён
259	259	32741	2024-03-21	2024-03-23	оплачен
260	260	14783	2024-03-23	2024-03-24	оплачен
261	261	8224	2024-03-16	2024-03-17	оплачен
262	262	7655	2024-03-25	\N	отменён
263	263	12264	2024-03-21	\N	ожидание
264	264	12780	2024-03-15	\N	ожидание
265	265	1166	2024-03-30	\N	ожидание
266	266	2101	2024-03-18	\N	ожидание
267	267	13022	2024-03-19	\N	ожидание
268	268	35476	2024-03-21	\N	отменён
269	269	4338	2024-03-27	\N	отменён
270	270	6006	2024-03-25	\N	отменён
271	271	51834	2024-03-17	\N	отменён
272	272	3422	2024-03-24	\N	ожидание
273	273	10434	2024-03-25	2024-03-26	оплачен
274	274	5961	2024-03-30	2024-04-02	оплачен
275	275	9060	2024-03-26	\N	отменён
276	276	465	2024-03-19	2024-03-20	оплачен
277	277	17296	2024-03-22	\N	отменён
278	278	9912	2024-03-18	\N	отменён
279	279	23166	2024-03-23	\N	отменён
280	280	19316	2024-03-19	2024-03-24	оплачен
281	281	18414	2024-03-18	\N	отменён
282	282	28236	2024-03-21	\N	отменён
283	283	29436	2024-03-22	\N	отменён
284	284	25780	2024-03-19	2024-03-20	оплачен
285	285	704	2024-03-29	2024-03-30	оплачен
286	286	21058	2024-03-16	\N	ожидание
287	287	33161	2024-03-30	\N	ожидание
288	288	8063	2024-03-27	\N	отменён
289	289	31647	2024-03-25	\N	отменён
290	290	22374	2024-03-16	\N	ожидание
291	291	8900	2024-03-29	\N	ожидание
292	292	34346	2024-03-16	\N	ожидание
293	293	1055	2024-03-22	\N	ожидание
294	294	50274	2024-03-19	\N	ожидание
295	295	4880	2024-03-19	\N	ожидание
296	296	16149	2024-03-30	\N	отменён
297	297	19680	2024-03-25	2024-03-29	оплачен
298	298	34294	2024-03-21	2024-03-23	оплачен
299	299	34980	2024-03-16	\N	ожидание
300	300	25430	2024-03-18	\N	отменён
301	301	35253	2024-03-16	\N	отменён
302	302	16888	2024-03-18	\N	ожидание
303	303	22775	2024-03-19	\N	отменён
304	304	24345	2024-03-28	\N	отменён
305	305	5495	2024-03-23	\N	отменён
306	306	12445	2024-03-15	2024-03-16	оплачен
307	307	22199	2024-03-16	\N	отменён
308	308	13181	2024-03-22	\N	отменён
309	309	3100	2024-03-27	\N	отменён
310	310	24171	2024-03-27	\N	ожидание
311	311	10806	2024-03-23	\N	отменён
312	312	8308	2024-03-23	\N	ожидание
313	313	16750	2024-03-20	\N	ожидание
314	314	1120	2024-03-22	2024-03-23	оплачен
315	315	56725	2024-03-19	2024-03-21	оплачен
316	316	16827	2024-03-21	2024-03-23	оплачен
317	317	2051	2024-03-18	2024-03-19	оплачен
318	318	59312	2024-03-26	\N	отменён
319	319	26606	2024-03-28	\N	отменён
320	320	19241	2024-03-15	\N	ожидание
321	321	42572	2024-03-16	\N	отменён
322	322	29621	2024-03-18	\N	ожидание
323	323	7452	2024-03-27	\N	отменён
324	324	26216	2024-03-18	\N	ожидание
325	325	17883	2024-03-28	\N	ожидание
326	326	2416	2024-03-24	\N	отменён
327	327	28934	2024-03-18	\N	отменён
328	328	27659	2024-03-16	2024-03-18	оплачен
329	329	26923	2024-03-29	\N	ожидание
330	330	6090	2024-03-25	\N	отменён
331	331	3324	2024-03-19	\N	отменён
332	332	11325	2024-03-23	\N	ожидание
333	333	9687	2024-03-27	\N	отменён
334	334	2604	2024-03-22	2024-03-27	оплачен
335	335	28188	2024-03-19	2024-03-22	оплачен
336	336	15788	2024-03-19	\N	ожидание
337	337	48571	2024-03-29	\N	ожидание
338	338	9706	2024-03-24	\N	ожидание
339	339	38738	2024-03-17	\N	ожидание
340	340	8352	2024-03-18	\N	ожидание
341	341	34542	2024-03-26	2024-03-30	оплачен
342	342	8526	2024-03-28	2024-03-29	оплачен
343	343	17212	2024-03-18	\N	отменён
344	344	25868	2024-03-18	\N	отменён
345	345	7220	2024-03-26	\N	отменён
346	346	34162	2024-03-21	\N	отменён
347	347	35229	2024-03-19	2024-03-24	оплачен
348	348	13690	2024-03-23	2024-03-25	оплачен
349	349	18587	2024-03-22	2024-03-25	оплачен
350	350	25560	2024-03-17	\N	ожидание
351	351	38878	2024-03-24	2024-03-28	оплачен
352	352	3761	2024-03-15	\N	ожидание
353	353	3102	2024-03-22	\N	отменён
354	354	26755	2024-03-24	\N	отменён
355	355	1104	2024-03-24	\N	ожидание
356	356	41448	2024-03-25	2024-03-29	оплачен
357	357	1330	2024-03-28	\N	ожидание
358	358	11388	2024-03-27	\N	отменён
359	359	16353	2024-03-20	2024-03-24	оплачен
360	360	11097	2024-03-18	2024-03-22	оплачен
361	361	22776	2024-03-25	2024-03-29	оплачен
362	362	43938	2024-03-19	2024-03-21	оплачен
363	363	5029	2024-03-21	\N	ожидание
364	364	23226	2024-03-23	\N	ожидание
365	365	41770	2024-03-22	\N	ожидание
366	366	1826	2024-03-17	\N	ожидание
367	367	13185	2024-03-20	2024-03-23	оплачен
368	368	8475	2024-03-21	\N	отменён
369	369	11222	2024-03-19	2024-03-22	оплачен
370	370	10332	2024-03-18	\N	отменён
371	371	672	2024-03-22	2024-03-24	оплачен
372	372	6902	2024-03-26	\N	отменён
373	373	6563	2024-03-30	2024-03-31	оплачен
374	374	31700	2024-03-22	2024-03-25	оплачен
375	375	2590	2024-03-23	\N	ожидание
376	376	17038	2024-03-29	\N	отменён
377	377	21996	2024-03-29	\N	отменён
378	378	36368	2024-03-29	\N	отменён
379	379	7989	2024-03-27	\N	отменён
380	380	28758	2024-03-20	\N	отменён
381	381	13156	2024-03-25	2024-03-26	оплачен
382	382	12960	2024-03-20	2024-03-22	оплачен
383	383	2832	2024-03-26	\N	отменён
384	384	18571	2024-03-28	\N	ожидание
385	385	1656	2024-03-23	\N	отменён
386	386	18919	2024-03-21	\N	ожидание
387	387	27678	2024-03-18	2024-03-20	оплачен
388	388	28174	2024-03-25	2024-03-27	оплачен
389	389	27373	2024-03-22	\N	отменён
390	390	6454	2024-03-15	\N	отменён
391	391	10842	2024-03-18	2024-03-22	оплачен
392	392	34259	2024-03-23	2024-03-24	оплачен
393	393	22390	2024-03-23	\N	отменён
394	394	2886	2024-03-17	\N	ожидание
395	395	17818	2024-03-30	\N	ожидание
396	396	14797	2024-03-26	2024-03-31	оплачен
397	397	3472	2024-03-28	\N	ожидание
398	398	805	2024-03-15	2024-03-18	оплачен
399	399	11158	2024-03-24	\N	ожидание
400	400	12712	2024-03-21	2024-03-23	оплачен
401	401	17100	2024-03-27	\N	отменён
402	402	24386	2024-03-22	\N	отменён
403	403	17516	2024-03-15	\N	ожидание
404	404	25086	2024-03-27	2024-03-29	оплачен
405	405	41397	2024-03-21	\N	ожидание
406	406	3906	2024-03-27	\N	отменён
407	407	16937	2024-03-24	2024-03-26	оплачен
408	408	9955	2024-03-17	\N	ожидание
409	409	43958	2024-03-27	\N	ожидание
410	410	16704	2024-03-18	2024-03-23	оплачен
411	411	34659	2024-03-21	\N	отменён
412	412	29683	2024-03-19	2024-03-20	оплачен
413	413	10842	2024-03-24	\N	отменён
414	414	11907	2024-03-17	\N	отменён
415	415	30142	2024-03-28	2024-03-29	оплачен
416	416	17765	2024-03-29	2024-04-02	оплачен
417	417	7342	2024-03-25	\N	отменён
418	418	17463	2024-03-30	\N	ожидание
419	419	24444	2024-03-29	\N	отменён
420	420	11105	2024-03-29	\N	ожидание
421	421	23162	2024-03-25	2024-03-29	оплачен
422	422	6279	2024-03-23	2024-03-28	оплачен
423	423	2310	2024-03-25	2024-03-30	оплачен
424	424	33866	2024-03-26	2024-03-31	оплачен
425	425	26900	2024-03-18	\N	отменён
426	426	4280	2024-03-22	\N	отменён
427	427	6320	2024-03-26	\N	отменён
428	428	35684	2024-03-15	\N	ожидание
429	429	11202	2024-03-22	\N	ожидание
430	430	7602	2024-03-30	2024-04-04	оплачен
431	431	18423	2024-03-23	\N	отменён
432	432	10082	2024-03-30	\N	ожидание
433	433	13514	2024-03-25	\N	отменён
434	434	9460	2024-03-19	\N	отменён
435	435	29170	2024-03-17	2024-03-22	оплачен
436	436	14370	2024-03-24	\N	ожидание
437	437	4247	2024-03-26	\N	ожидание
438	438	29998	2024-03-17	\N	ожидание
439	439	9004	2024-03-27	\N	ожидание
440	440	7080	2024-03-15	\N	отменён
441	441	21917	2024-03-26	\N	отменён
442	442	31624	2024-03-22	\N	отменён
443	443	30855	2024-03-18	2024-03-19	оплачен
444	444	3102	2024-03-16	\N	отменён
445	445	11378	2024-03-28	2024-03-30	оплачен
446	446	26305	2024-03-22	\N	отменён
447	447	26901	2024-03-17	\N	отменён
448	448	57293	2024-03-21	\N	ожидание
449	449	14454	2024-03-18	\N	отменён
450	450	43832	2024-03-29	2024-04-02	оплачен
451	451	13328	2024-03-21	2024-03-26	оплачен
452	452	12021	2024-03-24	\N	ожидание
453	453	9900	2024-03-29	\N	отменён
454	454	21896	2024-03-16	2024-03-19	оплачен
455	455	27800	2024-03-29	\N	отменён
456	456	9000	2024-03-30	\N	отменён
457	457	13135	2024-03-26	2024-03-27	оплачен
458	458	14053	2024-03-22	\N	отменён
459	459	11300	2024-03-15	\N	отменён
460	460	22430	2024-03-25	2024-03-30	оплачен
461	461	344	2024-03-29	\N	ожидание
462	462	7504	2024-03-21	\N	отменён
463	463	9604	2024-03-29	2024-04-03	оплачен
464	464	17865	2024-03-28	\N	отменён
465	465	13919	2024-03-22	\N	отменён
466	466	31023	2024-03-18	2024-03-20	оплачен
467	467	16679	2024-03-30	\N	ожидание
468	468	6144	2024-03-17	2024-03-21	оплачен
469	469	8074	2024-03-15	2024-03-19	оплачен
470	470	1465	2024-03-24	\N	ожидание
471	471	11011	2024-03-30	2024-04-03	оплачен
472	472	4500	2024-03-25	2024-03-26	оплачен
473	473	13726	2024-03-24	2024-03-29	оплачен
474	474	9336	2024-03-23	\N	ожидание
475	475	16908	2024-03-15	2024-03-20	оплачен
476	476	31672	2024-03-21	\N	отменён
477	477	1886	2024-03-18	2024-03-21	оплачен
478	478	17500	2024-03-27	\N	отменён
479	479	9918	2024-03-24	\N	ожидание
480	480	16225	2024-03-18	\N	отменён
481	481	2190	2024-03-23	\N	отменён
482	482	12772	2024-03-19	\N	отменён
483	483	34454	2024-03-30	\N	ожидание
484	484	12335	2024-03-24	\N	отменён
485	485	31302	2024-03-18	\N	отменён
486	486	12540	2024-03-27	2024-03-29	оплачен
487	487	6381	2024-03-18	\N	отменён
488	488	11020	2024-03-19	\N	отменён
489	489	24346	2024-03-17	\N	отменён
490	490	29115	2024-03-28	\N	ожидание
491	491	10160	2024-03-25	\N	отменён
492	492	27798	2024-03-17	\N	ожидание
493	493	42292	2024-03-29	\N	отменён
494	494	35396	2024-03-15	\N	отменён
495	495	7344	2024-03-24	2024-03-27	оплачен
496	496	15769	2024-03-21	\N	отменён
497	497	3276	2024-03-22	2024-03-27	оплачен
498	498	30809	2024-03-15	\N	отменён
499	499	12230	2024-03-30	\N	отменён
500	500	10199	2024-03-25	\N	отменён
501	501	9506	2024-03-26	\N	ожидание
502	502	6421	2024-03-20	\N	отменён
503	503	26975	2024-03-17	2024-03-19	оплачен
504	504	24394	2024-03-20	2024-03-22	оплачен
505	505	20087	2024-03-19	\N	отменён
506	506	10104	2024-03-16	2024-03-17	оплачен
507	507	11154	2024-03-15	\N	отменён
508	508	33132	2024-03-26	2024-03-30	оплачен
509	509	4844	2024-03-30	\N	отменён
510	510	52434	2024-03-17	\N	отменён
511	511	17688	2024-03-21	2024-03-25	оплачен
512	512	12028	2024-03-21	\N	ожидание
513	513	16443	2024-03-27	2024-04-01	оплачен
514	514	26172	2024-03-20	2024-03-23	оплачен
515	515	19032	2024-03-28	2024-04-01	оплачен
516	516	22865	2024-03-29	\N	отменён
517	517	15288	2024-03-18	2024-03-23	оплачен
518	518	6023	2024-03-28	\N	ожидание
519	519	18354	2024-03-18	\N	отменён
520	520	13845	2024-03-18	\N	отменён
521	521	19520	2024-03-22	2024-03-23	оплачен
522	522	13243	2024-03-19	2024-03-21	оплачен
523	523	3168	2024-03-15	2024-03-17	оплачен
524	524	14010	2024-03-22	\N	ожидание
525	525	22310	2024-03-22	\N	ожидание
526	526	22612	2024-03-26	\N	отменён
527	527	784	2024-03-30	\N	ожидание
528	528	6045	2024-03-18	\N	ожидание
529	529	25262	2024-03-30	2024-04-03	оплачен
530	530	3240	2024-03-24	2024-03-29	оплачен
531	531	51444	2024-03-19	\N	ожидание
532	532	17458	2024-03-27	\N	ожидание
533	533	31350	2024-03-28	\N	отменён
534	534	11316	2024-03-22	\N	ожидание
535	535	8609	2024-03-16	2024-03-20	оплачен
536	536	5024	2024-03-23	2024-03-26	оплачен
537	537	32895	2024-03-16	2024-03-18	оплачен
538	538	14906	2024-03-23	2024-03-27	оплачен
539	539	7070	2024-03-24	2024-03-29	оплачен
540	540	39780	2024-03-15	\N	отменён
541	541	23784	2024-03-17	\N	отменён
542	542	14418	2024-03-19	2024-03-21	оплачен
543	543	6216	2024-03-30	\N	отменён
544	544	17637	2024-03-27	2024-03-28	оплачен
545	545	19924	2024-03-23	\N	ожидание
546	546	18470	2024-03-22	\N	отменён
547	547	27063	2024-03-24	2024-03-25	оплачен
548	548	822	2024-03-24	\N	ожидание
549	549	10530	2024-03-16	\N	ожидание
550	550	21377	2024-03-16	\N	отменён
551	551	3146	2024-03-23	\N	ожидание
552	552	8556	2024-03-28	2024-04-01	оплачен
553	553	21758	2024-03-20	\N	отменён
554	554	25842	2024-03-19	2024-03-22	оплачен
555	555	18308	2024-03-18	\N	отменён
556	556	13426	2024-03-27	\N	ожидание
557	557	28903	2024-03-19	\N	отменён
558	558	16231	2024-03-24	\N	ожидание
559	559	3416	2024-03-22	2024-03-25	оплачен
560	560	33389	2024-03-18	2024-03-20	оплачен
561	561	17829	2024-03-20	2024-03-22	оплачен
562	562	5172	2024-03-20	2024-03-22	оплачен
563	563	180	2024-03-25	2024-03-27	оплачен
564	564	45626	2024-03-20	\N	отменён
565	565	19621	2024-03-30	\N	ожидание
566	566	3052	2024-03-20	2024-03-21	оплачен
567	567	36778	2024-03-17	2024-03-21	оплачен
568	568	27455	2024-03-21	2024-03-22	оплачен
569	569	8064	2024-03-30	\N	ожидание
570	570	15480	2024-03-15	\N	отменён
571	571	30525	2024-03-21	2024-03-22	оплачен
572	572	5225	2024-03-25	\N	ожидание
573	573	27768	2024-03-21	2024-03-23	оплачен
574	574	6345	2024-03-30	2024-03-31	оплачен
575	575	14386	2024-03-26	2024-03-28	оплачен
576	576	3050	2024-03-29	\N	ожидание
577	577	875	2024-03-30	\N	ожидание
578	578	10826	2024-03-24	\N	ожидание
579	579	8052	2024-03-27	2024-03-29	оплачен
580	580	5307	2024-03-22	2024-03-24	оплачен
581	581	35514	2024-03-29	\N	ожидание
582	582	19467	2024-03-27	2024-03-29	оплачен
583	583	35396	2024-03-24	2024-03-25	оплачен
584	584	4752	2024-03-17	\N	отменён
585	585	32504	2024-03-30	\N	ожидание
586	586	434	2024-03-19	\N	ожидание
587	587	17300	2024-03-21	\N	отменён
588	588	15280	2024-03-30	\N	ожидание
589	589	22743	2024-03-17	2024-03-18	оплачен
590	590	19359	2024-03-25	\N	отменён
591	591	8782	2024-03-18	\N	ожидание
592	592	7992	2024-03-17	2024-03-19	оплачен
593	593	2274	2024-03-27	2024-03-31	оплачен
594	594	11752	2024-03-18	2024-03-21	оплачен
595	595	4148	2024-03-20	\N	ожидание
596	596	26596	2024-03-19	2024-03-20	оплачен
597	597	19692	2024-03-20	2024-03-24	оплачен
598	598	18522	2024-03-19	2024-03-21	оплачен
599	599	8300	2024-03-17	\N	отменён
600	600	18756	2024-03-20	2024-03-21	оплачен
601	601	33915	2024-03-17	2024-03-18	оплачен
602	602	27537	2024-03-24	\N	ожидание
603	603	7305	2024-03-17	2024-03-22	оплачен
604	604	2490	2024-03-29	2024-03-31	оплачен
605	605	9380	2024-03-20	2024-03-24	оплачен
606	606	2303	2024-03-30	2024-04-01	оплачен
607	607	21104	2024-03-24	\N	ожидание
608	608	41168	2024-03-21	\N	ожидание
609	609	28381	2024-03-20	\N	отменён
610	610	33718	2024-03-16	2024-03-17	оплачен
611	611	14496	2024-03-15	\N	ожидание
612	612	26814	2024-03-16	2024-03-19	оплачен
613	613	15846	2024-03-30	\N	отменён
614	614	12857	2024-03-16	\N	ожидание
615	615	24337	2024-03-24	\N	ожидание
616	616	4313	2024-03-25	2024-03-27	оплачен
617	617	54431	2024-03-25	2024-03-27	оплачен
618	618	25051	2024-03-16	\N	ожидание
619	619	3304	2024-03-16	\N	отменён
620	620	21620	2024-03-20	\N	отменён
621	621	22680	2024-03-26	2024-03-28	оплачен
622	622	12100	2024-03-24	\N	отменён
623	623	8366	2024-03-23	\N	отменён
624	624	27667	2024-03-20	\N	ожидание
625	625	13370	2024-03-30	\N	ожидание
626	626	26850	2024-03-21	\N	ожидание
627	627	17557	2024-03-16	2024-03-19	оплачен
628	628	10445	2024-03-16	\N	отменён
629	629	53962	2024-03-29	2024-03-30	оплачен
630	630	9751	2024-03-23	\N	отменён
631	631	4592	2024-03-19	\N	ожидание
632	632	6938	2024-03-15	2024-03-16	оплачен
633	633	12938	2024-03-27	\N	ожидание
634	634	3000	2024-03-15	\N	ожидание
635	635	5687	2024-03-23	2024-03-25	оплачен
636	636	40865	2024-03-22	\N	ожидание
637	637	10905	2024-03-24	2024-03-27	оплачен
638	638	5943	2024-03-17	2024-03-19	оплачен
639	639	13244	2024-03-28	\N	ожидание
640	640	20095	2024-03-21	2024-03-24	оплачен
641	641	24840	2024-03-15	2024-03-16	оплачен
642	642	2912	2024-03-17	2024-03-22	оплачен
643	643	29417	2024-03-19	2024-03-24	оплачен
644	644	31517	2024-03-24	\N	ожидание
645	645	1020	2024-03-17	\N	ожидание
646	646	21025	2024-03-23	\N	отменён
647	647	10149	2024-03-21	2024-03-22	оплачен
648	648	2600	2024-03-26	\N	отменён
649	649	22175	2024-03-28	\N	ожидание
650	650	3186	2024-03-27	\N	отменён
651	651	7700	2024-03-30	\N	отменён
652	652	23476	2024-03-27	\N	ожидание
653	653	14761	2024-03-27	2024-04-01	оплачен
654	654	6588	2024-03-17	\N	ожидание
655	655	7785	2024-03-28	\N	ожидание
656	656	18220	2024-03-30	\N	ожидание
657	657	12377	2024-03-25	\N	ожидание
658	658	19130	2024-03-17	\N	отменён
659	659	10886	2024-03-27	\N	отменён
660	660	11281	2024-03-16	\N	отменён
661	661	28009	2024-03-26	\N	отменён
662	662	35836	2024-03-27	\N	отменён
663	663	18934	2024-03-21	\N	ожидание
664	664	42210	2024-03-20	2024-03-24	оплачен
665	665	9444	2024-03-15	2024-03-19	оплачен
666	666	13160	2024-03-24	2024-03-27	оплачен
667	667	13115	2024-03-27	\N	ожидание
668	668	28408	2024-03-24	2024-03-25	оплачен
669	669	20962	2024-03-26	\N	отменён
670	670	35981	2024-03-28	2024-03-31	оплачен
671	671	16731	2024-03-18	\N	отменён
672	672	9786	2024-03-18	\N	ожидание
673	673	11684	2024-03-28	\N	ожидание
674	674	2294	2024-03-21	\N	отменён
675	675	16211	2024-03-24	2024-03-25	оплачен
676	676	26315	2024-03-26	2024-03-30	оплачен
677	677	19200	2024-03-16	2024-03-18	оплачен
678	678	24525	2024-03-19	2024-03-22	оплачен
679	679	26624	2024-03-28	2024-03-31	оплачен
680	680	21584	2024-03-20	2024-03-25	оплачен
681	681	6600	2024-03-27	\N	отменён
682	682	8518	2024-03-19	\N	ожидание
683	683	25848	2024-03-24	\N	ожидание
684	684	1854	2024-03-18	\N	отменён
685	685	10751	2024-03-30	2024-04-03	оплачен
686	686	24369	2024-03-20	2024-03-22	оплачен
687	687	58914	2024-03-20	2024-03-22	оплачен
688	688	10584	2024-03-27	\N	отменён
689	689	7392	2024-03-30	2024-04-02	оплачен
690	690	37910	2024-03-23	2024-03-27	оплачен
691	691	33315	2024-03-18	2024-03-19	оплачен
692	692	6608	2024-03-27	\N	отменён
693	693	17562	2024-03-23	2024-03-27	оплачен
694	694	14211	2024-03-20	\N	отменён
695	695	25920	2024-03-24	\N	ожидание
696	696	30274	2024-03-23	\N	ожидание
697	697	10010	2024-03-17	\N	отменён
698	698	6500	2024-03-16	\N	отменён
699	699	20036	2024-03-19	\N	отменён
700	700	16171	2024-03-23	\N	ожидание
701	701	14464	2024-03-21	\N	ожидание
702	702	40993	2024-03-26	\N	отменён
703	703	26646	2024-03-21	2024-03-22	оплачен
704	704	9894	2024-03-24	2024-03-27	оплачен
705	705	30829	2024-03-26	\N	ожидание
706	706	24817	2024-03-25	\N	ожидание
707	707	11040	2024-03-21	\N	ожидание
708	708	14800	2024-03-30	\N	отменён
709	709	14331	2024-03-28	2024-03-31	оплачен
710	710	5943	2024-03-28	\N	отменён
711	711	9801	2024-03-15	\N	отменён
712	712	14951	2024-03-23	\N	ожидание
713	713	10112	2024-03-24	\N	ожидание
714	714	30328	2024-03-21	\N	отменён
715	715	14300	2024-03-28	2024-03-31	оплачен
716	716	33356	2024-03-18	2024-03-22	оплачен
717	717	40874	2024-03-20	2024-03-23	оплачен
718	718	35698	2024-03-17	\N	ожидание
719	719	7830	2024-03-23	\N	ожидание
720	720	12715	2024-03-19	2024-03-20	оплачен
721	721	14696	2024-03-17	\N	ожидание
722	722	36370	2024-03-18	2024-03-21	оплачен
723	723	22349	2024-03-30	2024-03-31	оплачен
724	724	972	2024-03-30	\N	ожидание
725	725	23939	2024-03-21	\N	отменён
726	726	14617	2024-03-18	2024-03-19	оплачен
727	727	14410	2024-03-21	\N	отменён
728	728	19188	2024-03-26	\N	отменён
729	729	23720	2024-03-29	\N	отменён
730	730	19189	2024-03-23	\N	ожидание
731	731	648	2024-03-30	2024-04-04	оплачен
732	732	6596	2024-03-23	\N	отменён
733	733	25206	2024-03-24	\N	отменён
734	734	280	2024-03-24	\N	отменён
735	735	12453	2024-03-17	\N	отменён
736	736	8262	2024-03-19	2024-03-24	оплачен
737	737	18854	2024-03-21	2024-03-22	оплачен
738	738	7128	2024-03-15	\N	отменён
739	739	10304	2024-03-26	\N	ожидание
740	740	4257	2024-03-19	2024-03-21	оплачен
741	741	20778	2024-03-18	2024-03-20	оплачен
742	742	11227	2024-03-20	\N	ожидание
743	743	45102	2024-03-24	2024-03-25	оплачен
744	744	39017	2024-03-20	\N	ожидание
745	745	954	2024-03-19	\N	отменён
746	746	32295	2024-03-19	2024-03-21	оплачен
747	747	33443	2024-03-22	\N	отменён
748	748	11772	2024-03-27	\N	ожидание
749	749	18292	2024-03-28	\N	ожидание
750	750	4560	2024-03-25	2024-03-27	оплачен
751	751	5865	2024-03-15	2024-03-20	оплачен
752	752	26297	2024-03-24	\N	ожидание
753	753	4861	2024-03-29	2024-03-31	оплачен
754	754	25228	2024-03-16	\N	отменён
755	755	10912	2024-03-19	\N	отменён
756	756	12696	2024-03-30	\N	отменён
757	757	366	2024-03-25	2024-03-30	оплачен
758	758	33420	2024-03-23	\N	отменён
759	759	6810	2024-03-26	\N	отменён
760	760	32976	2024-03-19	\N	отменён
761	761	23148	2024-03-15	\N	ожидание
762	762	18200	2024-03-22	2024-03-26	оплачен
763	763	10153	2024-03-24	2024-03-28	оплачен
764	764	45381	2024-03-21	\N	отменён
765	765	16723	2024-03-27	\N	отменён
766	766	32262	2024-03-19	2024-03-20	оплачен
767	767	20529	2024-03-24	\N	отменён
768	768	6563	2024-03-25	\N	отменён
769	769	36478	2024-03-30	\N	отменён
770	770	19596	2024-03-23	2024-03-27	оплачен
771	771	7386	2024-03-19	\N	отменён
772	772	1377	2024-03-24	\N	отменён
773	773	12240	2024-03-29	\N	отменён
774	774	15721	2024-03-23	\N	ожидание
775	775	15894	2024-03-28	2024-03-30	оплачен
776	776	11844	2024-03-30	\N	отменён
777	777	44597	2024-03-23	\N	отменён
778	778	7719	2024-03-16	2024-03-17	оплачен
779	779	40156	2024-03-18	\N	ожидание
780	780	15018	2024-03-24	\N	ожидание
781	781	50800	2024-03-16	\N	ожидание
782	782	24298	2024-03-17	\N	отменён
783	783	4896	2024-03-23	\N	отменён
784	784	14787	2024-03-30	2024-04-02	оплачен
785	785	28311	2024-03-17	\N	отменён
786	786	11055	2024-03-21	\N	ожидание
787	787	38500	2024-03-25	\N	ожидание
788	788	29377	2024-03-19	2024-03-24	оплачен
789	789	23828	2024-03-23	2024-03-27	оплачен
790	790	22773	2024-03-28	\N	ожидание
791	791	3276	2024-03-30	\N	ожидание
792	792	28140	2024-03-20	\N	ожидание
793	793	20322	2024-03-21	2024-03-23	оплачен
794	794	5190	2024-03-18	2024-03-21	оплачен
795	795	18592	2024-03-25	2024-03-26	оплачен
796	796	16042	2024-03-27	\N	ожидание
797	797	36134	2024-03-21	\N	отменён
798	798	28846	2024-03-18	\N	отменён
799	799	13074	2024-03-28	\N	ожидание
800	800	17418	2024-03-16	\N	отменён
801	801	10028	2024-03-21	\N	отменён
802	802	41833	2024-03-22	2024-03-24	оплачен
803	803	40525	2024-03-19	\N	отменён
804	804	24181	2024-03-15	2024-03-18	оплачен
805	805	3171	2024-03-29	\N	ожидание
806	806	11823	2024-03-24	2024-03-29	оплачен
807	807	9048	2024-03-30	\N	ожидание
808	808	5344	2024-03-27	\N	отменён
809	809	41301	2024-03-23	2024-03-24	оплачен
810	810	15736	2024-03-19	\N	ожидание
811	811	39142	2024-03-20	2024-03-25	оплачен
812	812	42510	2024-03-20	2024-03-22	оплачен
813	813	9403	2024-03-21	\N	отменён
814	814	41837	2024-03-16	2024-03-17	оплачен
815	815	14986	2024-03-23	\N	отменён
816	816	8463	2024-03-23	2024-03-24	оплачен
817	817	11639	2024-03-28	\N	отменён
818	818	1065	2024-03-15	2024-03-18	оплачен
819	819	48970	2024-03-20	\N	ожидание
820	820	15120	2024-03-28	2024-04-02	оплачен
821	821	18537	2024-03-30	\N	отменён
822	822	11139	2024-03-24	\N	отменён
823	823	21054	2024-03-28	\N	отменён
824	824	10948	2024-03-29	2024-03-31	оплачен
825	825	1656	2024-03-15	\N	отменён
826	826	752	2024-03-30	\N	отменён
827	827	2786	2024-03-16	\N	отменён
828	828	5649	2024-03-20	\N	ожидание
829	829	7770	2024-03-17	2024-03-20	оплачен
830	830	4620	2024-03-23	\N	отменён
831	831	13456	2024-03-27	\N	отменён
832	832	23398	2024-03-27	\N	ожидание
833	833	22313	2024-03-22	\N	отменён
834	834	25296	2024-03-22	2024-03-23	оплачен
835	835	23665	2024-03-28	\N	отменён
836	836	7068	2024-03-29	\N	отменён
837	837	20562	2024-03-24	\N	ожидание
838	838	43602	2024-03-18	\N	ожидание
839	839	17504	2024-03-30	2024-04-01	оплачен
840	840	12628	2024-03-28	\N	ожидание
841	841	1656	2024-03-18	2024-03-20	оплачен
842	842	7326	2024-03-21	\N	отменён
843	843	23067	2024-03-20	\N	отменён
844	844	20031	2024-03-21	\N	ожидание
845	845	6204	2024-03-24	\N	ожидание
846	846	41415	2024-03-26	2024-03-29	оплачен
847	847	3540	2024-03-27	\N	отменён
848	848	18244	2024-03-25	\N	отменён
849	849	7828	2024-03-28	\N	отменён
850	850	9648	2024-03-17	2024-03-21	оплачен
851	851	30866	2024-03-25	\N	отменён
852	852	16394	2024-03-25	2024-03-29	оплачен
853	853	3496	2024-03-15	\N	отменён
854	854	5160	2024-03-24	\N	отменён
855	855	13506	2024-03-19	\N	отменён
856	856	20033	2024-03-17	\N	ожидание
857	857	5017	2024-03-16	2024-03-21	оплачен
858	858	19019	2024-03-19	2024-03-23	оплачен
859	859	15567	2024-03-25	\N	ожидание
860	860	16038	2024-03-17	\N	ожидание
861	861	2948	2024-03-26	\N	отменён
862	862	15104	2024-03-28	\N	отменён
863	863	8343	2024-03-15	2024-03-17	оплачен
864	864	22924	2024-03-22	\N	ожидание
865	865	6785	2024-03-29	\N	ожидание
866	866	28140	2024-03-22	\N	ожидание
867	867	28072	2024-03-18	\N	отменён
868	868	7878	2024-03-19	2024-03-21	оплачен
869	869	17986	2024-03-29	\N	ожидание
870	870	11571	2024-03-23	2024-03-26	оплачен
871	871	13524	2024-03-30	\N	отменён
872	872	8640	2024-03-17	2024-03-22	оплачен
873	873	1620	2024-03-29	\N	ожидание
874	874	20814	2024-03-30	\N	отменён
875	875	15041	2024-03-24	2024-03-27	оплачен
876	876	14787	2024-03-18	2024-03-19	оплачен
877	877	11576	2024-03-17	2024-03-21	оплачен
878	878	10728	2024-03-22	2024-03-24	оплачен
879	879	4851	2024-03-29	\N	ожидание
880	880	11152	2024-03-26	\N	ожидание
881	881	17530	2024-03-23	2024-03-26	оплачен
882	882	27589	2024-03-29	\N	ожидание
883	883	14496	2024-03-28	2024-04-01	оплачен
884	884	22671	2024-03-25	2024-03-26	оплачен
885	885	22792	2024-03-21	\N	ожидание
886	886	14325	2024-03-18	\N	отменён
887	887	17666	2024-03-17	\N	отменён
888	888	36224	2024-03-26	2024-03-31	оплачен
889	889	10320	2024-03-20	2024-03-24	оплачен
890	890	5499	2024-03-18	\N	отменён
891	891	9936	2024-03-24	\N	ожидание
892	892	6674	2024-03-22	\N	отменён
893	893	13734	2024-03-25	\N	отменён
894	894	2068	2024-03-26	\N	ожидание
895	895	35341	2024-03-18	2024-03-23	оплачен
896	896	16762	2024-03-21	2024-03-23	оплачен
897	897	47835	2024-03-18	\N	ожидание
898	898	10509	2024-03-16	2024-03-20	оплачен
899	899	19230	2024-03-23	2024-03-28	оплачен
900	900	11606	2024-03-23	\N	отменён
901	901	12375	2024-03-30	2024-04-01	оплачен
902	902	17175	2024-03-20	\N	отменён
903	903	29028	2024-03-23	\N	ожидание
904	904	6270	2024-03-30	\N	отменён
905	905	6697	2024-03-29	\N	отменён
906	906	1520	2024-03-20	\N	отменён
907	907	43267	2024-03-20	2024-03-22	оплачен
908	908	15138	2024-03-17	\N	отменён
909	909	19516	2024-03-21	2024-03-26	оплачен
910	910	27868	2024-03-18	2024-03-23	оплачен
911	911	14999	2024-03-18	\N	ожидание
912	912	1728	2024-03-15	\N	ожидание
913	913	43892	2024-03-27	\N	ожидание
914	914	21248	2024-03-22	2024-03-27	оплачен
915	915	18931	2024-03-24	\N	ожидание
916	916	30696	2024-03-17	\N	отменён
917	917	27807	2024-03-23	\N	отменён
918	918	5474	2024-03-21	\N	ожидание
919	919	9933	2024-03-19	\N	отменён
920	920	15501	2024-03-17	\N	отменён
921	921	10499	2024-03-26	2024-03-28	оплачен
922	922	2870	2024-03-22	\N	ожидание
923	923	2934	2024-03-16	\N	отменён
924	924	15099	2024-03-19	\N	отменён
925	925	32706	2024-03-17	\N	ожидание
926	926	18260	2024-03-26	\N	ожидание
927	927	12099	2024-03-20	\N	ожидание
928	928	29679	2024-03-19	\N	отменён
929	929	5274	2024-03-23	\N	отменён
930	930	15725	2024-03-29	\N	отменён
931	931	22286	2024-03-23	\N	ожидание
932	932	19177	2024-03-18	2024-03-20	оплачен
933	933	16367	2024-03-16	2024-03-20	оплачен
934	934	15067	2024-03-30	\N	отменён
935	935	15740	2024-03-22	\N	ожидание
936	936	27122	2024-03-26	\N	отменён
937	937	21386	2024-03-21	\N	ожидание
938	938	16843	2024-03-20	\N	отменён
939	939	35061	2024-03-30	\N	ожидание
940	940	15834	2024-03-27	\N	ожидание
941	941	6006	2024-03-26	2024-03-27	оплачен
942	942	12806	2024-03-30	\N	отменён
943	943	22664	2024-03-24	\N	ожидание
944	944	3080	2024-03-15	2024-03-19	оплачен
945	945	9767	2024-03-27	\N	отменён
946	946	35119	2024-03-27	\N	ожидание
947	947	22408	2024-03-24	\N	ожидание
948	948	18400	2024-03-17	\N	ожидание
949	949	16654	2024-03-20	2024-03-22	оплачен
950	950	22138	2024-03-26	2024-03-29	оплачен
951	951	8600	2024-03-15	\N	отменён
952	952	19940	2024-03-23	2024-03-28	оплачен
953	953	15732	2024-03-19	\N	отменён
954	954	930	2024-03-19	\N	ожидание
955	955	22230	2024-03-25	2024-03-30	оплачен
956	956	38542	2024-03-24	\N	ожидание
957	957	21429	2024-03-23	\N	отменён
958	958	2350	2024-03-28	\N	ожидание
959	959	17168	2024-03-28	\N	ожидание
960	960	26474	2024-03-15	\N	отменён
961	961	2436	2024-03-27	\N	ожидание
962	962	15391	2024-03-16	\N	ожидание
963	963	7378	2024-03-21	\N	ожидание
964	964	28734	2024-03-16	\N	отменён
965	965	27615	2024-03-22	2024-03-27	оплачен
966	966	18634	2024-03-21	\N	ожидание
967	967	18191	2024-03-17	\N	отменён
968	968	23688	2024-03-27	2024-03-28	оплачен
969	969	18538	2024-03-16	\N	ожидание
970	970	29502	2024-03-25	2024-03-30	оплачен
971	971	14941	2024-03-19	\N	отменён
972	972	13570	2024-03-18	\N	отменён
973	973	5350	2024-03-24	\N	отменён
974	974	43346	2024-03-24	\N	ожидание
975	975	11456	2024-03-22	2024-03-25	оплачен
976	976	1056	2024-03-17	\N	отменён
977	977	19378	2024-03-30	\N	отменён
978	978	13685	2024-03-30	2024-04-01	оплачен
979	979	23784	2024-03-24	\N	ожидание
980	980	13286	2024-03-28	\N	ожидание
981	981	14596	2024-03-21	\N	ожидание
982	982	37620	2024-03-24	\N	отменён
983	983	15665	2024-03-28	2024-04-02	оплачен
984	984	3372	2024-03-21	\N	отменён
985	985	2240	2024-03-30	\N	отменён
986	986	2262	2024-03-23	\N	ожидание
987	987	22892	2024-03-16	\N	отменён
988	988	9639	2024-03-22	\N	ожидание
989	989	22002	2024-03-24	\N	отменён
990	990	11716	2024-03-25	\N	отменён
991	991	10950	2024-03-18	2024-03-19	оплачен
992	992	27991	2024-03-23	2024-03-25	оплачен
993	993	29902	2024-03-17	\N	ожидание
994	994	3762	2024-03-24	\N	отменён
995	995	32677	2024-03-20	2024-03-25	оплачен
996	996	17047	2024-03-27	\N	отменён
997	997	33419	2024-03-18	2024-03-19	оплачен
998	998	8756	2024-03-30	\N	отменён
999	999	42265	2024-03-28	2024-04-02	оплачен
1000	1000	12688	2024-03-27	\N	отменён
\.


--
-- TOC entry 3716 (class 0 OID 16702)
-- Dependencies: 221
-- Data for Name: manager; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.manager (manager_id, position_id, employee_code, full_name, phone_number) FROM stdin;
1	1	201	Сергеева Марина	8-901-123-45-67
2	2	202	Козлов Андрей	8-902-234-56-78
3	3	203	Павлова Ирина	8-903-345-67-89
4	1	204	Орлов Николай	8-904-456-78-90
5	4	205	Беляева Анна	8-905-567-89-01
6	5	206	Сидоров Алексей	8-906-678-90-12
7	2	207	Фролова Татьяна	8-907-789-01-23
8	3	208	Гаврилов Роман	8-908-890-12-34
9	4	209	Морозова Елена	8-909-901-23-45
10	5	210	Захаров Евгений	8-910-012-34-56
11	1	211	Куликова Ольга	8-911-111-22-33
12	2	212	Григорьев Максим	8-912-222-33-44
13	3	213	Шестакова Лилия	8-913-333-44-55
14	4	214	Егоров Дмитрий	8-914-444-55-66
15	5	215	Васильева Наталья	8-915-555-66-77
\.


--
-- TOC entry 3714 (class 0 OID 16695)
-- Dependencies: 219
-- Data for Name: manager_position; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.manager_position (position_id, position_name, salary_rate) FROM stdin;
1	Менеджер по продажам	60000
2	Старший менеджер	80000
3	Руководитель отдела	100000
4	Логист	55000
5	Аналитик продаж	70000
\.


--
-- TOC entry 3710 (class 0 OID 16672)
-- Dependencies: 215
-- Data for Name: manufacturer; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.manufacturer (manufacturer_id, company_name, city, country, tax_id) FROM stdin;
1	Фермерское хозяйство "Зелёный сад"	Краснодар	Россия	7701234567
2	Агрофирма "Фруктовый мир"	Ростов-на-Дону	Россия	7823456789
3	СПК "Овощной край"	Воронеж	Россия	5409876543
4	Тепличный комбинат "Южный"	Краснодар	Россия	7703344556
5	ООО "СеверАгро"	Архангельск	Россия	2901122334
6	ФХ "Дары Волги"	Волгоград	Россия	3405566778
7	ЗАО "Плодородие"	Белгород	Россия	3107788990
8	СПК "Уральские овощи"	Челябинск	Россия	7402233445
9	Агроферма "Зелёная долина"	Пенза	Россия	5806677889
\.


--
-- TOC entry 3730 (class 0 OID 16831)
-- Dependencies: 235
-- Data for Name: order_details; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.order_details (order_details_id, supply_details_id, order_id, total_price, quantity, unit_price, unit_measure) FROM stdin;
3985	438	1	16448	64	257	упаковка
3986	555	1	4840	20	242	упаковка
3987	1993	1	11125	89	125	ящик
3988	1609	2	7980	84	95	упаковка
3989	1380	3	4998	98	51	упаковка
3990	1323	4	1816	8	227	упаковка
3991	362	4	6039	61	99	упаковка
3992	768	4	19943	77	259	упаковка
3993	2922	5	25944	92	282	кг
3994	1993	5	18942	77	246	ящик
3995	146	5	1224	6	204	упаковка
3996	826	6	7068	62	114	упаковка
3997	2523	6	16632	84	198	кг
3998	2565	7	7511	29	259	упаковка
3999	2248	7	4950	50	99	кг
4000	2369	7	1764	18	98	кг
4001	2260	8	19095	95	201	упаковка
4002	1228	8	6882	62	111	кг
4003	1391	9	16351	83	197	ящик
4004	1906	9	3618	67	54	ящик
4005	2538	10	4235	35	121	упаковка
4006	637	10	3380	20	169	ящик
4007	1054	10	27448	94	292	упаковка
4008	653	11	24252	86	282	ящик
4009	1411	12	19188	82	234	кг
4010	657	13	1254	19	66	кг
4011	2840	14	10188	36	283	ящик
4012	424	14	24310	85	286	упаковка
4013	218	14	3276	39	84	упаковка
4014	1244	15	7584	79	96	ящик
4015	2559	15	15520	80	194	упаковка
4016	1667	15	4446	19	234	ящик
4017	1818	16	4640	80	58	ящик
4018	580	16	18492	69	268	упаковка
4019	519	17	11556	54	214	ящик
4020	2815	17	7130	31	230	кг
4021	424	18	6468	66	98	упаковка
4022	288	19	21300	75	284	упаковка
4023	2650	19	4680	26	180	ящик
4024	1478	19	6264	24	261	ящик
4025	2278	20	6060	30	202	кг
4026	193	21	7680	80	96	ящик
4027	392	21	7812	62	126	упаковка
4028	1269	22	650	13	50	упаковка
4029	2973	22	10374	38	273	кг
4030	1696	22	10476	97	108	упаковка
4031	2117	23	12375	45	275	кг
4032	1727	23	16290	90	181	кг
4033	1567	24	3760	40	94	упаковка
4034	1540	24	19536	74	264	кг
4035	26	24	300	4	75	ящик
4036	2955	25	6110	65	94	упаковка
4037	297	25	3657	69	53	кг
4038	881	26	18450	75	246	ящик
4039	2650	26	7150	25	286	кг
4040	2487	26	5025	75	67	ящик
4041	2181	27	9331	43	217	ящик
4042	1313	27	1638	13	126	ящик
4043	1365	28	4462	23	194	упаковка
4044	2838	28	4272	16	267	кг
4045	517	29	2035	11	185	упаковка
4046	651	30	6622	77	86	кг
4047	1015	30	4462	23	194	ящик
4048	1969	31	274	2	137	ящик
4049	638	31	11439	41	279	кг
4050	617	31	1072	4	268	кг
4051	718	32	8632	52	166	упаковка
4052	1922	32	21004	89	236	ящик
4053	908	32	5590	26	215	кг
4054	1712	33	2512	16	157	ящик
4055	1312	34	250	5	50	ящик
4056	1524	34	10528	56	188	кг
4057	512	35	3668	14	262	упаковка
4058	1622	35	3344	19	176	кг
4059	1543	35	5589	23	243	ящик
4060	137	36	2187	27	81	кг
4061	939	36	4200	14	300	упаковка
4062	2851	36	11098	62	179	упаковка
4063	1558	37	17024	64	266	кг
4064	2671	37	4060	58	70	кг
4065	439	38	3800	76	50	упаковка
4066	2375	39	15147	81	187	ящик
4067	2106	39	6512	74	88	ящик
4068	1016	39	14235	73	195	ящик
4069	1473	40	8866	62	143	ящик
4070	2228	41	115	1	115	ящик
4071	2421	41	10989	99	111	ящик
4072	686	41	23571	81	291	упаковка
4073	1894	42	7128	66	108	упаковка
4074	1853	42	1573	13	121	ящик
4075	898	42	14240	89	160	ящик
4076	2042	43	3528	21	168	кг
4077	754	43	12354	87	142	ящик
4078	2620	44	2178	11	198	ящик
4079	2465	44	7268	79	92	кг
4080	463	44	15368	68	226	упаковка
4081	2839	45	11565	45	257	упаковка
4082	1138	45	9918	58	171	упаковка
4083	2829	46	25380	90	282	упаковка
4084	2720	46	25415	85	299	ящик
4085	2405	46	2646	42	63	кг
4086	1381	47	2277	33	69	упаковка
4087	825	47	10005	87	115	упаковка
4088	2074	47	8920	40	223	кг
4089	197	48	17554	67	262	упаковка
4090	199	48	3162	62	51	упаковка
4091	1757	49	6494	34	191	ящик
4092	516	49	5733	49	117	упаковка
4093	1696	49	13776	48	287	ящик
4094	861	50	23322	78	299	упаковка
4095	2949	50	6300	28	225	ящик
4096	1662	51	5319	27	197	ящик
4097	320	51	11264	64	176	ящик
4098	1158	52	12384	96	129	ящик
4099	1486	53	3168	11	288	кг
4100	1172	53	13847	61	227	упаковка
4101	1372	54	3664	16	229	упаковка
4102	1625	55	747	3	249	упаковка
4103	1687	55	19076	76	251	кг
4104	1749	56	8604	36	239	ящик
4105	1313	57	24510	86	285	кг
4106	2119	57	15066	93	162	кг
4107	508	58	8694	63	138	ящик
4108	202	58	22194	81	274	кг
4109	1407	59	13860	55	252	упаковка
4110	583	59	7954	41	194	ящик
4111	2123	59	13440	70	192	ящик
4112	2978	60	5390	77	70	ящик
4113	1080	60	1704	6	284	ящик
4114	1516	61	8310	30	277	кг
4115	2080	61	5320	70	76	упаковка
4116	1735	62	16465	89	185	упаковка
4117	1704	63	10355	95	109	кг
4118	1318	63	7336	56	131	упаковка
4119	1821	64	7072	34	208	кг
4120	1670	64	7752	34	228	упаковка
4121	734	65	22041	93	237	упаковка
4122	770	65	18335	95	193	ящик
4123	418	65	7704	36	214	ящик
4124	50	66	350	2	175	упаковка
4125	590	67	6424	22	292	упаковка
4126	1143	67	14490	69	210	упаковка
4127	1102	68	6670	46	145	упаковка
4128	713	69	1494	6	249	ящик
4129	1778	69	3741	43	87	кг
4130	1611	69	1870	17	110	ящик
4131	2798	70	8910	99	90	упаковка
4132	2116	70	5481	27	203	упаковка
4133	2847	71	8280	60	138	кг
4134	2229	71	12460	89	140	кг
4135	1351	71	3042	26	117	упаковка
4136	1617	72	8432	34	248	кг
4137	2479	73	552	4	138	кг
4138	1997	74	2365	11	215	упаковка
4139	2130	74	3576	12	298	ящик
4140	1519	74	15228	94	162	упаковка
4141	934	75	4986	18	277	кг
4142	529	75	20951	73	287	ящик
4143	319	75	1580	10	158	ящик
4144	357	76	8234	46	179	упаковка
4145	2964	76	4420	20	221	кг
4146	924	77	18375	75	245	упаковка
4147	1073	77	12376	52	238	упаковка
4148	792	78	21402	87	246	ящик
4149	173	78	1665	15	111	ящик
4150	2668	78	8424	72	117	ящик
4151	874	79	4650	30	155	кг
4152	1601	80	18156	68	267	кг
4153	2769	81	2592	9	288	кг
4154	1400	81	19875	75	265	упаковка
4155	1176	81	4587	33	139	кг
4156	2266	82	20202	91	222	ящик
4157	2994	82	8004	29	276	упаковка
4158	941	83	16107	91	177	ящик
4159	2093	84	1176	6	196	ящик
4160	2214	85	5263	19	277	ящик
4161	228	85	12978	63	206	кг
4162	2153	86	4200	21	200	ящик
4163	148	86	2106	9	234	кг
4164	336	87	15960	95	168	кг
4165	2327	87	3344	38	88	кг
4166	2990	87	5040	48	105	ящик
4167	1632	88	16461	93	177	кг
4168	2392	89	3648	38	96	ящик
4169	2729	89	11825	55	215	упаковка
4170	1968	89	5616	26	216	кг
4171	586	90	1815	15	121	кг
4172	1255	90	18176	64	284	кг
4173	422	91	18150	75	242	упаковка
4174	631	91	13578	93	146	кг
4175	2590	92	6272	98	64	ящик
4176	79	92	3481	59	59	упаковка
4177	2631	93	19228	76	253	упаковка
4178	111	93	19656	91	216	ящик
4179	2577	94	4536	21	216	упаковка
4180	2057	94	10050	67	150	кг
4181	2014	94	2150	43	50	упаковка
4182	1273	95	2830	10	283	ящик
4183	554	95	9920	62	160	упаковка
4184	1641	95	2046	22	93	кг
4185	2174	96	1391	13	107	упаковка
4186	2390	96	20562	69	298	ящик
4187	1797	96	8096	92	88	упаковка
4188	854	97	1458	18	81	упаковка
4189	1964	97	2618	17	154	кг
4190	1864	97	2574	11	234	упаковка
4191	48	98	1184	8	148	кг
4192	2341	98	2304	9	256	упаковка
4193	25	99	13630	58	235	ящик
4194	2504	99	3653	13	281	ящик
4195	2470	100	1717	17	101	ящик
4196	880	101	18785	85	221	ящик
4197	928	101	14365	85	169	упаковка
4198	1084	102	2574	39	66	кг
4199	75	102	14553	77	189	кг
4200	842	103	2670	15	178	ящик
4201	1370	103	15372	61	252	ящик
4202	2939	104	7854	42	187	упаковка
4203	2730	104	6300	21	300	ящик
4204	1812	105	12095	41	295	ящик
4205	1621	105	7904	32	247	ящик
4206	462	105	15072	96	157	ящик
4207	2899	106	19760	95	208	упаковка
4208	1217	106	21576	87	248	ящик
4209	2873	107	2808	24	117	упаковка
4210	2417	107	5712	21	272	ящик
4211	2664	108	5727	69	83	упаковка
4212	1326	109	10170	45	226	кг
4213	305	110	1638	26	63	кг
4214	1977	110	22532	86	262	кг
4215	75	111	12900	100	129	кг
4216	2079	111	16200	72	225	кг
4217	380	111	19500	75	260	кг
4218	1893	112	17384	82	212	ящик
4219	2324	112	9177	57	161	ящик
4220	2880	112	3300	15	220	кг
4221	111	113	4235	77	55	кг
4222	1275	114	6438	74	87	кг
4223	2068	115	8415	99	85	упаковка
4224	325	116	19980	90	222	кг
4225	997	116	14307	57	251	упаковка
4226	2342	116	6666	33	202	упаковка
4227	2706	117	22596	84	269	ящик
4228	1265	117	223	1	223	ящик
4229	799	118	4554	18	253	упаковка
4230	2292	118	5856	24	244	упаковка
4231	1287	118	3374	14	241	ящик
4232	2093	119	11676	84	139	ящик
4233	1492	119	5966	38	157	упаковка
4234	1330	119	1300	20	65	упаковка
4235	426	120	2964	12	247	упаковка
4236	1434	121	8428	43	196	упаковка
4237	2398	122	15134	94	161	кг
4238	1283	122	15960	95	168	кг
4239	1466	122	8865	45	197	кг
4240	1960	123	8165	71	115	упаковка
4241	811	123	2378	41	58	упаковка
4242	2818	124	7056	98	72	упаковка
4243	1040	125	404	2	202	кг
4244	2461	125	8550	90	95	упаковка
4245	2717	125	2748	12	229	упаковка
4246	1552	126	3024	36	84	кг
4247	636	127	6390	90	71	упаковка
4248	454	128	688	4	172	упаковка
4249	2644	128	12692	76	167	кг
4250	1346	128	15890	70	227	упаковка
4251	2714	129	3906	18	217	ящик
4252	2222	129	24320	95	256	упаковка
4253	186	129	14195	85	167	ящик
4254	23	130	8040	30	268	ящик
4255	1286	130	8364	34	246	упаковка
4256	85	131	19152	72	266	кг
4257	2078	131	4318	34	127	кг
4258	2693	131	7104	64	111	кг
4259	663	132	12000	50	240	ящик
4260	2453	133	9576	63	152	кг
4261	2398	134	2925	13	225	ящик
4262	47	134	13416	52	258	ящик
4263	2072	135	21904	74	296	ящик
4264	750	135	2489	19	131	упаковка
4265	2137	136	6045	31	195	ящик
4266	2866	136	12558	69	182	кг
4267	1343	136	6750	45	150	упаковка
4268	1054	137	1972	34	58	кг
4269	923	137	10449	43	243	кг
4270	884	138	2331	9	259	упаковка
4271	543	138	20064	88	228	упаковка
4272	1543	139	12250	50	245	ящик
4273	920	139	2610	45	58	упаковка
4274	1885	140	15470	65	238	кг
4275	11	140	22468	82	274	ящик
4276	2342	141	15642	79	198	упаковка
4277	1157	142	4453	61	73	упаковка
4278	2221	142	18957	89	213	ящик
4279	379	143	14848	64	232	кг
4280	2718	143	3600	50	72	кг
4281	1542	143	1092	4	273	упаковка
4282	724	144	8401	31	271	ящик
4283	625	144	3657	53	69	ящик
4284	1094	144	5658	82	69	упаковка
4285	955	145	3006	18	167	ящик
4286	401	145	9321	39	239	кг
4287	280	145	5022	62	81	упаковка
4288	282	146	675	3	225	упаковка
4289	82	146	12420	46	270	упаковка
4290	2809	147	22484	77	292	ящик
4291	800	148	9114	42	217	упаковка
4292	76	148	1088	16	68	ящик
4293	433	149	14326	58	247	ящик
4294	116	150	7626	62	123	упаковка
4295	841	151	3720	20	186	упаковка
4296	498	151	4697	61	77	упаковка
4297	1963	151	17952	88	204	упаковка
4298	2717	152	1086	6	181	ящик
4299	109	153	9646	91	106	кг
4300	2390	153	10452	78	134	кг
4301	1160	154	7008	96	73	упаковка
4302	709	155	4464	62	72	упаковка
4303	1971	156	2146	29	74	упаковка
4304	853	156	3934	14	281	ящик
4305	215	157	1485	27	55	ящик
4306	1755	157	3528	12	294	упаковка
4307	2189	158	20196	68	297	упаковка
4308	560	158	3811	37	103	кг
4309	2053	158	2224	8	278	ящик
4310	1718	159	15876	84	189	кг
4311	513	159	3816	24	159	кг
4312	661	160	4600	20	230	кг
4313	48	161	8080	40	202	упаковка
4314	894	161	2226	42	53	кг
4315	718	162	10149	51	199	упаковка
4316	2570	162	3780	28	135	ящик
4317	2555	163	2760	15	184	упаковка
4318	23	163	1800	12	150	упаковка
4319	1344	163	1600	32	50	кг
4320	185	164	10126	61	166	ящик
4321	846	164	1320	12	110	ящик
4322	838	165	7668	54	142	упаковка
4323	2035	166	9231	51	181	упаковка
4324	60	166	23920	80	299	кг
4325	1781	167	9588	68	141	упаковка
4326	246	168	8806	34	259	упаковка
4327	1659	168	5616	72	78	кг
4328	1489	169	14691	59	249	кг
4329	1098	170	12062	74	163	ящик
4330	1586	170	13248	46	288	ящик
4331	592	171	5040	35	144	ящик
4332	1238	171	7358	26	283	кг
4333	295	172	5094	18	283	упаковка
4334	2705	172	1616	8	202	упаковка
4335	2354	173	8464	92	92	кг
4336	1968	174	10320	43	240	ящик
4337	2536	174	6784	53	128	упаковка
4338	2902	174	10758	66	163	кг
4339	1204	175	4290	33	130	кг
4340	807	175	5929	49	121	упаковка
4341	1484	176	9480	40	237	упаковка
4342	947	176	10004	82	122	кг
4343	2374	177	164	2	82	кг
4344	1562	177	7614	27	282	кг
4345	551	178	9310	38	245	ящик
4346	2888	179	6900	75	92	упаковка
4347	1139	180	3045	21	145	ящик
4348	2799	181	8928	31	288	ящик
4349	1491	182	1344	14	96	упаковка
4350	1058	183	4154	67	62	кг
4351	2622	183	4060	20	203	кг
4352	625	184	10185	97	105	ящик
4353	615	185	15708	77	204	упаковка
4354	2029	186	10600	40	265	ящик
4355	1303	187	8892	52	171	ящик
4356	985	187	441	7	63	кг
4357	562	187	7105	35	203	кг
4358	830	188	14784	88	168	кг
4359	854	188	12495	49	255	кг
4360	1084	188	23000	100	230	ящик
4361	2483	189	5400	100	54	ящик
4362	2578	190	19662	87	226	ящик
4363	572	190	12672	66	192	кг
4364	176	191	4624	16	289	ящик
4365	2211	192	7992	54	148	кг
4366	1058	192	14175	81	175	кг
4367	2151	192	10816	52	208	ящик
4368	2532	193	3402	42	81	упаковка
4369	2511	194	9900	33	300	кг
4370	486	194	12870	66	195	кг
4371	1232	195	16653	91	183	кг
4372	1651	195	13630	94	145	ящик
4373	130	195	2168	8	271	кг
4374	1626	196	7812	93	84	упаковка
4375	2547	197	13467	67	201	кг
4376	1263	197	5200	20	260	ящик
4377	300	197	8928	31	288	кг
4378	2431	198	25296	93	272	ящик
4379	2002	198	5180	35	148	упаковка
4380	219	199	990	10	99	упаковка
4381	1912	200	1872	8	234	ящик
4382	1048	200	13608	72	189	ящик
4383	349	200	9272	76	122	ящик
4384	1461	201	2232	31	72	упаковка
4385	2115	202	1805	19	95	кг
4386	2512	202	13338	57	234	упаковка
4387	2563	202	4505	85	53	упаковка
4388	1063	203	12744	72	177	упаковка
4389	1354	204	8700	87	100	ящик
4390	2022	204	11350	50	227	упаковка
4391	910	205	5960	40	149	кг
4392	2863	206	16555	77	215	упаковка
4393	730	206	18240	64	285	кг
4394	1320	207	6674	47	142	упаковка
4395	2760	208	1096	4	274	ящик
4396	536	209	7130	46	155	ящик
4397	2762	209	5612	61	92	упаковка
4398	1371	209	10087	77	131	ящик
4399	1331	210	3360	16	210	ящик
4400	1568	210	8874	34	261	кг
4401	1077	210	8712	33	264	ящик
4402	2530	211	10494	99	106	ящик
4403	1365	211	5771	29	199	упаковка
4404	1546	211	14476	94	154	упаковка
4405	97	212	962	13	74	упаковка
4406	2550	212	18352	62	296	упаковка
4407	558	213	686	7	98	ящик
4408	1145	214	15822	54	293	кг
4409	293	214	10045	35	287	кг
4410	2550	214	3621	17	213	ящик
4411	1246	215	3335	23	145	кг
4412	2950	215	13400	100	134	кг
4413	347	216	10906	41	266	ящик
4414	1163	217	9500	76	125	ящик
4415	2376	218	10388	53	196	ящик
4416	2685	218	1725	25	69	ящик
4417	1610	219	2520	9	280	кг
4418	2894	219	292	4	73	упаковка
4419	2324	220	6680	40	167	ящик
4420	2905	220	5890	38	155	кг
4421	2118	220	11300	100	113	кг
4422	587	221	9345	89	105	ящик
4423	493	222	18117	99	183	ящик
4424	1401	222	5980	65	92	кг
4425	702	222	13840	80	173	кг
4426	323	223	18711	63	297	кг
4427	2442	224	5400	90	60	ящик
4428	2631	224	3575	65	55	упаковка
4429	914	224	152	1	152	упаковка
4430	288	225	828	6	138	кг
4431	2348	225	7942	38	209	кг
4432	299	226	11466	39	294	упаковка
4433	2734	227	4160	52	80	ящик
4434	299	228	15300	90	170	ящик
4435	1662	228	5221	23	227	упаковка
4436	2045	228	945	7	135	ящик
4437	2362	229	13674	86	159	кг
4438	2607	229	20169	83	243	упаковка
4439	163	230	23306	86	271	упаковка
4440	2100	231	1961	37	53	ящик
4441	2617	231	5200	20	260	упаковка
4442	1452	231	13056	68	192	ящик
4443	2450	232	6290	34	185	упаковка
4444	247	233	1036	14	74	кг
4445	162	233	848	8	106	упаковка
4446	1070	234	3906	42	93	упаковка
4447	3	235	6006	66	91	ящик
4448	241	235	2884	14	206	кг
4449	2135	236	4042	47	86	кг
4450	1522	236	2046	11	186	упаковка
4451	1093	236	5655	29	195	упаковка
4452	913	237	9184	82	112	ящик
4453	2361	237	221	1	221	ящик
4454	5	238	1746	6	291	упаковка
4455	574	238	9025	95	95	ящик
4456	704	239	5208	56	93	кг
4457	1240	240	7488	48	156	кг
4458	2265	240	8400	60	140	упаковка
4459	2959	240	2655	9	295	ящик
4460	2158	241	3956	43	92	кг
4461	615	241	6237	27	231	кг
4462	214	242	729	3	243	ящик
4463	2667	242	14904	72	207	кг
4464	1912	242	3051	27	113	ящик
4465	2324	243	15477	77	201	кг
4466	1274	243	1760	22	80	ящик
4467	524	243	2662	11	242	ящик
4468	2441	244	918	9	102	ящик
4469	2853	244	11988	74	162	упаковка
4470	1770	244	9114	42	217	ящик
4471	953	245	9072	42	216	упаковка
4472	2051	246	285	5	57	упаковка
4473	666	246	4758	26	183	упаковка
4474	1011	246	3190	29	110	упаковка
4475	2078	247	8142	46	177	кг
4476	2092	247	1872	26	72	кг
4477	1646	248	8265	95	87	ящик
4478	2169	248	4896	72	68	ящик
4479	37	249	11439	93	123	упаковка
4480	1191	250	27645	95	291	упаковка
4481	919	250	3859	17	227	кг
4482	1757	250	24180	93	260	ящик
4483	560	251	6440	35	184	упаковка
4484	1020	251	18368	64	287	кг
4485	2905	252	25938	99	262	ящик
4486	1791	252	20250	75	270	ящик
4487	1953	253	13632	48	284	ящик
4488	495	253	8109	53	153	упаковка
4489	1638	253	2662	11	242	ящик
4490	1468	254	24055	85	283	упаковка
4491	522	254	5913	73	81	кг
4492	778	255	3392	16	212	упаковка
4493	2747	256	8640	96	90	кг
4494	1855	256	2184	39	56	кг
4495	29	257	6225	75	83	упаковка
4496	2283	258	13090	70	187	ящик
4497	682	258	2176	8	272	ящик
4498	812	258	4998	42	119	упаковка
4499	970	259	7650	90	85	ящик
4500	2421	260	12784	68	188	ящик
4501	2504	260	22656	96	236	ящик
4502	982	260	10098	66	153	упаковка
4503	2401	261	7055	85	83	упаковка
4504	1170	261	6384	24	266	кг
4505	1221	262	3520	44	80	упаковка
4506	376	262	935	11	85	упаковка
4507	807	263	5130	30	171	кг
4508	2735	263	9163	77	119	упаковка
4509	2635	264	2730	42	65	упаковка
4510	1932	264	5986	82	73	упаковка
4511	1149	265	19028	67	284	кг
4512	2429	265	3780	28	135	ящик
4513	2452	266	2900	50	58	кг
4514	1167	266	1764	6	294	кг
4515	2015	267	25203	93	271	кг
4516	2341	267	2430	30	81	упаковка
4517	937	268	4212	26	162	ящик
4518	1429	268	14240	89	160	упаковка
4519	400	268	3523	13	271	кг
4520	2702	269	28028	98	286	кг
4521	2593	270	12595	55	229	упаковка
4522	2495	271	2938	13	226	ящик
4523	2216	272	5700	57	100	кг
4524	117	272	10858	61	178	ящик
4525	2826	272	9730	35	278	ящик
4526	1059	273	1856	29	64	упаковка
4527	1150	274	7275	97	75	ящик
4528	2378	274	2925	15	195	ящик
4529	1859	274	12643	47	269	ящик
4530	834	275	7728	69	112	упаковка
4531	1727	275	561	11	51	кг
4532	602	275	8118	99	82	ящик
4533	761	276	5900	59	100	упаковка
4534	2539	276	11248	38	296	упаковка
4535	2245	276	10659	57	187	кг
4536	61	277	7680	32	240	ящик
4537	594	277	10366	71	146	ящик
4538	589	278	4760	17	280	кг
4539	1371	279	2652	34	78	кг
4540	2005	279	1746	9	194	ящик
4541	519	280	7956	36	221	ящик
4542	97	280	2142	9	238	кг
4543	1850	281	24402	83	294	упаковка
4544	2684	281	8820	35	252	кг
4545	2121	281	8640	80	108	упаковка
4546	1951	282	18568	88	211	ящик
4547	2216	283	7383	69	107	кг
4548	1132	283	9588	68	141	ящик
4549	1943	283	13750	55	250	ящик
4550	1814	284	10250	50	205	ящик
4551	624	284	20295	99	205	упаковка
4552	568	285	18778	82	229	кг
4553	1688	285	7350	25	294	упаковка
4554	1168	286	3876	38	102	упаковка
4555	2994	286	14820	95	156	упаковка
4556	903	286	6396	41	156	кг
4557	374	287	2436	21	116	ящик
4558	1847	287	11858	77	154	кг
4559	2945	287	1398	6	233	кг
4560	2227	288	17640	70	252	ящик
4561	884	289	6192	24	258	кг
4562	327	290	5332	62	86	кг
4563	951	290	8220	30	274	упаковка
4564	578	290	8646	66	131	кг
4565	2599	291	249	1	249	упаковка
4566	804	291	6785	59	115	ящик
4567	2304	292	6532	46	142	кг
4568	1352	293	1425	15	95	кг
4569	1665	293	1326	17	78	ящик
4570	2968	294	17664	96	184	ящик
4571	1563	295	8232	98	84	кг
4572	2549	296	2116	23	92	упаковка
4573	2133	297	16256	64	254	ящик
4574	1311	297	2700	25	108	упаковка
4575	2937	298	17658	81	218	ящик
4576	2580	298	4964	68	73	ящик
4577	2271	298	19500	65	300	упаковка
4578	2290	299	9348	41	228	упаковка
4579	665	300	5910	30	197	упаковка
4580	2887	300	5256	18	292	ящик
4581	558	300	15300	90	170	упаковка
4582	2217	301	11954	86	139	ящик
4583	363	302	192	3	64	кг
4584	1641	303	9576	84	114	кг
4585	2639	303	3690	30	123	упаковка
4586	1320	303	3534	38	93	кг
4587	1404	304	7668	27	284	упаковка
4588	2755	305	960	10	96	ящик
4589	2223	305	9776	52	188	ящик
4590	2092	306	4464	18	248	упаковка
4591	1131	306	20860	70	298	кг
4592	680	307	5566	22	253	упаковка
4593	155	307	184	2	92	кг
4594	190	307	1652	14	118	ящик
4595	275	308	9006	38	237	упаковка
4596	297	309	6440	23	280	кг
4597	1126	309	5852	77	76	упаковка
4598	1159	309	19136	92	208	упаковка
4599	12	310	12348	98	126	упаковка
4600	481	310	9460	43	220	упаковка
4601	2236	310	8305	55	151	ящик
4602	1295	311	8556	46	186	кг
4603	1465	312	8686	43	202	ящик
4604	2004	312	12648	68	186	кг
4605	872	312	15635	53	295	упаковка
4606	1454	313	5192	22	236	кг
4607	2377	314	15904	71	224	кг
4608	516	315	1270	10	127	ящик
4609	196	315	20680	88	235	ящик
4610	548	316	17712	82	216	ящик
4611	2224	316	4575	25	183	упаковка
4612	2517	316	14250	95	150	ящик
4613	1000	317	4110	30	137	упаковка
4614	6	317	9300	100	93	кг
4615	449	318	2619	9	291	кг
4616	120	319	2860	22	130	кг
4617	2497	320	7452	69	108	упаковка
4618	343	320	486	3	162	ящик
4619	2875	320	4840	44	110	ящик
4620	1139	321	6417	23	279	ящик
4621	2317	322	10922	86	127	упаковка
4622	214	322	11232	72	156	ящик
4623	2944	323	455	7	65	ящик
4624	218	323	12285	45	273	упаковка
4625	2434	324	2808	52	54	ящик
4626	288	324	9620	74	130	кг
4627	1999	325	2392	23	104	упаковка
4628	1364	325	2187	9	243	упаковка
4629	434	326	28809	99	291	кг
4630	2944	326	7336	56	131	упаковка
4631	2787	326	13013	91	143	ящик
4632	538	327	12048	48	251	ящик
4633	245	327	9196	44	209	кг
4634	22	328	18894	94	201	ящик
4635	2720	329	9020	82	110	упаковка
4636	2141	329	11534	79	146	упаковка
4637	1700	330	9728	76	128	упаковка
4638	2729	331	9635	47	205	упаковка
4639	2605	332	2268	42	54	упаковка
4640	31	333	968	4	242	упаковка
4641	2141	334	3854	47	82	ящик
4642	208	335	7500	60	125	кг
4643	1711	335	20800	80	260	кг
4644	582	336	7056	56	126	ящик
4645	62	336	5808	48	121	кг
4646	815	336	7198	59	122	упаковка
4647	92	337	8600	86	100	кг
4648	2455	337	5060	46	110	ящик
4649	1804	337	20251	77	263	кг
4650	1302	338	15810	62	255	кг
4651	2643	338	9202	43	214	кг
4652	331	338	10647	91	117	упаковка
4653	300	339	10354	62	167	кг
4654	554	339	6789	31	219	кг
4655	2978	339	10380	60	173	кг
4656	2423	340	25714	86	299	ящик
4657	2336	341	8480	53	160	кг
4658	1284	341	2100	28	75	ящик
4659	976	342	26400	88	300	упаковка
4660	1122	343	7317	27	271	ящик
4661	2123	343	8758	58	151	упаковка
4662	2395	343	10680	60	178	кг
4663	1181	344	12096	84	144	кг
4664	1500	344	8591	71	121	кг
4665	2636	345	1470	15	98	упаковка
4666	2767	345	3794	14	271	кг
4667	1610	345	17955	63	285	кг
4668	2297	346	1008	8	126	упаковка
4669	630	346	2970	18	165	кг
4670	1164	346	12464	82	152	кг
4671	1890	347	364	4	91	ящик
4672	421	347	24376	88	277	упаковка
4673	1291	348	4290	55	78	кг
4674	599	348	14308	73	196	упаковка
4675	1629	348	10045	35	287	кг
4676	481	349	1540	22	70	ящик
4677	288	349	21408	96	223	ящик
4678	1774	349	191	1	191	упаковка
4679	2112	350	8815	41	215	ящик
4680	1502	351	700	5	140	ящик
4681	333	351	4692	23	204	кг
4682	1198	351	10416	56	186	упаковка
4683	153	352	12960	45	288	упаковка
4684	2369	352	8280	60	138	упаковка
4685	829	352	17812	61	292	кг
4686	1302	353	4059	41	99	упаковка
4687	1671	353	4717	53	89	ящик
4688	1854	354	6192	86	72	упаковка
4689	1277	355	11187	99	113	упаковка
4690	2456	355	8789	47	187	кг
4691	1815	355	14322	93	154	ящик
4692	1245	356	1760	32	55	ящик
4693	1846	357	6235	29	215	ящик
4694	1504	358	2415	23	105	кг
4695	2326	358	12168	78	156	ящик
4696	412	358	11790	45	262	ящик
4697	288	359	17670	93	190	ящик
4698	2474	359	13900	50	278	кг
4699	311	359	17762	83	214	кг
4700	939	360	16240	70	232	кг
4701	2185	360	20592	88	234	кг
4702	1958	360	7854	34	231	кг
4703	1327	361	19491	89	219	кг
4704	556	361	10062	39	258	ящик
4705	1854	361	16450	70	235	упаковка
4706	762	362	891	11	81	упаковка
4707	1521	363	15656	76	206	ящик
4708	401	364	5805	43	135	кг
4709	2197	364	19012	98	194	кг
4710	2186	365	15921	87	183	кг
4711	382	366	696	8	87	ящик
4712	778	366	4200	50	84	ящик
4713	2446	366	23465	95	247	кг
4714	2922	367	7616	32	238	упаковка
4715	497	367	10176	48	212	кг
4716	670	368	12818	58	221	кг
4717	1816	368	876	12	73	кг
4718	126	368	12920	76	170	упаковка
4719	1005	369	4440	60	74	кг
4720	1643	370	7380	60	123	упаковка
4721	1219	370	212	1	212	упаковка
4722	1282	371	8580	44	195	упаковка
4723	1412	372	12690	45	282	кг
4724	1398	372	3713	47	79	кг
4725	695	372	14701	61	241	кг
4726	2801	373	10165	95	107	упаковка
4727	208	373	12348	49	252	упаковка
4728	672	373	25160	85	296	кг
4729	2452	374	4158	33	126	ящик
4730	2299	374	5576	41	136	кг
4731	1415	375	12482	79	158	ящик
4732	2141	375	14224	56	254	упаковка
4733	1422	375	5436	36	151	упаковка
4734	1154	376	12236	76	161	кг
4735	1645	377	3658	31	118	кг
4736	1786	377	3828	33	116	кг
4737	2799	378	7752	51	152	упаковка
4738	953	378	14652	74	198	упаковка
4739	142	378	14287	91	157	ящик
4740	2047	379	4240	20	212	кг
4741	63	379	16146	78	207	упаковка
4742	1494	379	24010	98	245	упаковка
4743	548	380	660	3	220	кг
4744	2805	380	18699	69	271	ящик
4745	1459	381	375	5	75	упаковка
4746	2594	381	7128	27	264	упаковка
4747	1382	382	8769	79	111	ящик
4748	1175	382	8479	61	139	упаковка
4749	2646	383	1914	11	174	ящик
4750	423	383	13860	60	231	кг
4751	1167	384	9116	86	106	упаковка
4752	2900	384	5004	18	278	упаковка
4753	1579	385	5500	50	110	упаковка
4754	2737	385	18270	90	203	ящик
4755	2551	386	161	1	161	ящик
4756	1725	387	23904	96	249	кг
4757	2523	387	2964	39	76	кг
4758	689	387	13930	70	199	кг
4759	1880	388	20500	82	250	ящик
4760	2699	388	2900	10	290	кг
4761	963	389	12375	75	165	упаковка
4762	996	389	8280	30	276	ящик
4763	681	389	9176	74	124	кг
4764	2293	390	2610	10	261	упаковка
4765	1889	391	19952	86	232	упаковка
4766	455	391	2590	10	259	кг
4767	2133	391	5560	20	278	ящик
4768	2017	392	6408	72	89	ящик
4769	1531	392	2121	21	101	ящик
4770	913	392	4588	74	62	кг
4771	2320	393	6125	49	125	ящик
4772	1297	393	11058	57	194	упаковка
4773	1800	393	8470	70	121	кг
4774	523	394	550	2	275	кг
4775	425	395	14016	48	292	кг
4776	389	395	11395	53	215	упаковка
4777	743	396	10570	70	151	кг
4778	380	396	13200	100	132	кг
4779	1534	397	1593	27	59	упаковка
4780	1979	398	2445	15	163	ящик
4781	962	398	8820	98	90	кг
4782	174	398	13024	88	148	упаковка
4783	1529	399	2020	10	202	кг
4784	2565	399	3720	20	186	ящик
4785	2976	400	5560	40	139	кг
4786	280	400	8883	63	141	кг
4787	2414	401	5664	24	236	ящик
4788	2877	401	2592	16	162	ящик
4789	2627	402	1104	12	92	кг
4790	474	402	3300	50	66	упаковка
4791	1720	402	3886	29	134	кг
4792	792	403	8118	66	123	кг
4793	1860	403	1485	11	135	упаковка
4794	331	404	5432	97	56	кг
4795	1869	405	14432	88	164	кг
4796	1869	405	1160	20	58	кг
4797	924	405	8085	35	231	ящик
4798	1503	406	3380	20	169	ящик
4799	1670	406	13160	70	188	кг
4800	1908	406	2750	50	55	ящик
4801	1737	407	6768	72	94	кг
4802	2639	407	4970	70	71	упаковка
4803	2404	407	5018	26	193	кг
4804	1210	408	4183	47	89	кг
4805	2024	409	9805	53	185	ящик
4806	569	409	13617	51	267	упаковка
4807	2696	410	3887	13	299	кг
4808	2353	411	4110	30	137	упаковка
4809	2282	411	2060	20	103	ящик
4810	2806	412	13485	87	155	кг
4811	1383	413	12654	57	222	ящик
4812	2112	414	4134	53	78	упаковка
4813	2759	414	10800	90	120	упаковка
4814	2833	414	10856	92	118	упаковка
4815	1854	415	7560	70	108	упаковка
4816	2980	415	20210	94	215	ящик
4817	2295	416	6840	30	228	ящик
4818	1997	416	2408	28	86	кг
4819	647	416	10428	44	237	упаковка
4820	945	417	4470	30	149	ящик
4821	1231	417	14790	85	174	упаковка
4822	2157	418	1122	6	187	упаковка
4823	604	418	4654	26	179	ящик
4824	2420	418	25628	86	298	упаковка
4825	1798	419	18980	73	260	кг
4826	2036	419	9246	69	134	кг
4827	2319	420	5829	67	87	упаковка
4828	1622	420	4860	90	54	кг
4829	244	421	4212	18	234	упаковка
4830	253	421	7304	44	166	упаковка
4831	1801	421	5712	28	204	упаковка
4832	353	422	1740	30	58	упаковка
4833	1448	422	11097	81	137	упаковка
4834	2393	423	348	6	58	ящик
4835	575	423	4050	30	135	ящик
4836	1458	423	11392	64	178	упаковка
4837	456	424	916	4	229	кг
4838	1141	424	23571	81	291	кг
4839	1389	424	9280	40	232	ящик
4840	574	425	8640	64	135	ящик
4841	923	426	4160	16	260	ящик
4842	1910	426	11343	57	199	ящик
4843	314	427	13908	57	244	упаковка
4844	461	427	12906	54	239	упаковка
4845	979	428	9900	45	220	упаковка
4846	1198	428	8568	42	204	кг
4847	2623	429	8050	70	115	ящик
4848	2273	429	9955	55	181	ящик
4849	2957	430	7938	49	162	кг
4850	259	430	3195	45	71	упаковка
4851	2776	430	4978	19	262	ящик
4852	522	431	6625	25	265	упаковка
4853	244	432	11304	72	157	ящик
4854	960	433	5451	79	69	упаковка
4855	2045	433	5698	77	74	кг
4856	1588	434	12376	56	221	упаковка
4857	354	435	6063	43	141	упаковка
4858	2376	435	10137	93	109	упаковка
4859	1848	436	10710	63	170	упаковка
4860	1002	436	4080	51	80	упаковка
4861	2954	437	5100	17	300	ящик
4862	2292	438	13135	71	185	упаковка
4863	651	438	2387	11	217	кг
4864	848	439	2506	14	179	упаковка
4865	168	439	18626	67	278	упаковка
4866	1487	440	8080	80	101	упаковка
4867	2644	440	10800	45	240	упаковка
4868	632	441	3612	21	172	ящик
4869	118	441	2652	51	52	упаковка
4870	1032	442	870	6	145	кг
4871	510	442	4026	33	122	ящик
4872	305	443	16660	68	245	ящик
4873	1597	443	5609	71	79	кг
4874	2732	443	12376	52	238	кг
4875	2517	444	4160	64	65	ящик
4876	567	444	1064	19	56	ящик
4877	1414	444	8464	92	92	упаковка
4878	667	445	3657	69	53	кг
4879	1124	445	17856	72	248	кг
4880	2101	445	16800	56	300	упаковка
4881	628	446	7161	93	77	ящик
4882	728	446	5248	82	64	ящик
4883	854	447	3819	67	57	кг
4884	382	447	4950	50	99	упаковка
4885	43	447	7600	80	95	ящик
4886	2924	448	12168	72	169	ящик
4887	2616	449	910	13	70	кг
4888	2148	449	12516	42	298	упаковка
4889	399	450	21336	84	254	ящик
4890	551	450	11679	51	229	кг
4891	156	451	19116	81	236	упаковка
4892	1392	451	3675	21	175	ящик
4893	231	451	1343	17	79	кг
4894	881	452	8208	57	144	кг
4895	363	453	17812	61	292	кг
4896	1215	453	7550	50	151	кг
4897	2447	453	14300	65	220	кг
4898	38	454	20619	87	237	упаковка
4899	458	454	4850	25	194	кг
4900	1284	455	14025	55	255	кг
4901	2995	456	1070	5	214	упаковка
4902	250	456	1140	19	60	кг
4903	1043	457	2790	45	62	ящик
4904	987	457	15566	86	181	кг
4905	438	457	5194	53	98	ящик
4906	1286	458	5616	36	156	упаковка
4907	1970	458	10296	72	143	упаковка
4908	1816	459	17816	68	262	упаковка
4909	2075	460	890	5	178	ящик
4910	1712	461	1512	12	126	упаковка
4911	1739	461	4710	30	157	кг
4912	2884	461	5226	67	78	кг
4913	1422	462	6205	85	73	упаковка
4914	932	463	15400	55	280	упаковка
4915	1374	463	5408	52	104	упаковка
4916	2145	463	19035	81	235	ящик
4917	1055	464	5270	85	62	кг
4918	254	464	9831	87	113	ящик
4919	2056	465	3648	32	114	ящик
4920	1461	465	13621	53	257	упаковка
4921	142	465	10810	46	235	ящик
4922	1386	466	9984	64	156	кг
4923	301	467	2394	9	266	упаковка
4924	582	468	5346	33	162	кг
4925	1100	468	4836	93	52	кг
4926	2532	469	4063	17	239	упаковка
4927	1894	469	602	7	86	кг
4928	2698	469	25276	89	284	упаковка
4929	2454	470	18177	73	249	упаковка
4930	238	470	7992	36	222	упаковка
4931	2453	471	14127	51	277	ящик
4932	2219	472	400	5	80	кг
4933	2339	473	4897	59	83	ящик
4934	2868	474	210	2	105	ящик
4935	1649	474	14500	100	145	кг
4936	1126	475	16425	73	225	кг
4937	1236	476	12054	41	294	ящик
4938	943	476	11880	40	297	упаковка
4939	1780	477	6188	68	91	упаковка
4940	2232	477	12006	46	261	кг
4941	2115	478	7275	75	97	кг
4942	2990	478	15336	72	213	кг
4943	2209	479	4602	78	59	кг
4944	414	479	16714	61	274	ящик
4945	2207	479	3528	49	72	ящик
4946	534	480	2418	31	78	упаковка
4947	1216	481	25740	90	286	упаковка
4948	2260	482	7896	28	282	кг
4949	1164	482	6630	51	130	ящик
4950	2362	482	6318	39	162	упаковка
4951	1497	483	7137	61	117	упаковка
4952	666	483	12975	75	173	ящик
4953	1130	484	11899	73	163	упаковка
4954	1006	484	3888	48	81	упаковка
4955	705	484	8372	46	182	упаковка
4956	1591	485	2640	30	88	кг
4957	2811	485	672	12	56	упаковка
4958	558	485	6931	29	239	кг
4959	2208	486	23200	80	290	кг
4960	774	486	8704	34	256	ящик
4961	566	486	20976	76	276	ящик
4962	1639	487	1584	18	88	ящик
4963	167	487	3916	44	89	упаковка
4964	2737	488	1782	33	54	кг
4965	1288	488	11115	95	117	упаковка
4966	262	488	672	7	96	кг
4967	98	489	24650	85	290	кг
4968	2787	490	393	3	131	кг
4969	1911	491	16644	76	219	ящик
4970	872	491	10296	44	234	кг
4971	781	492	2656	16	166	ящик
4972	2341	493	9211	61	151	упаковка
4973	1059	493	10672	92	116	ящик
4974	264	494	14943	51	293	ящик
4975	1563	495	2520	35	72	упаковка
4976	562	495	9794	83	118	упаковка
4977	931	495	1376	16	86	кг
4978	2934	496	910	14	65	упаковка
4979	1096	496	10449	43	243	ящик
4980	2718	496	3876	68	57	упаковка
4981	591	497	25608	97	264	ящик
4982	2034	498	8536	97	88	ящик
4983	559	498	2233	11	203	кг
4984	1867	499	3596	58	62	упаковка
4985	1296	500	5225	95	55	ящик
4986	1698	500	14469	91	159	упаковка
4987	336	501	12265	55	223	ящик
4988	2001	501	1764	28	63	ящик
4989	10	501	158	1	158	упаковка
4990	830	502	8280	40	207	кг
4991	1905	502	6006	21	286	ящик
4992	2619	502	12035	83	145	кг
4993	528	503	22016	86	256	упаковка
4994	2809	504	11480	56	205	кг
4995	860	504	20720	70	296	кг
4996	2047	505	4515	21	215	ящик
4997	1175	505	3375	25	135	кг
4998	88	506	3969	27	147	кг
4999	2826	507	11025	75	147	кг
5000	1021	507	23318	89	262	упаковка
5001	2871	508	10412	76	137	ящик
5002	2599	508	8640	64	135	упаковка
5003	1543	508	1419	11	129	упаковка
5004	2363	509	6320	79	80	упаковка
5005	1249	509	8100	75	108	кг
5006	1611	510	14707	77	191	кг
5007	2331	511	5070	65	78	упаковка
5008	1007	511	15225	75	203	ящик
5009	1767	511	17346	59	294	упаковка
5010	1659	512	10176	64	159	ящик
5011	795	513	1408	22	64	упаковка
5012	1191	513	17630	82	215	упаковка
5013	580	514	1704	6	284	кг
5014	2275	514	2464	16	154	кг
5015	19	515	12840	60	214	ящик
5016	1753	516	15600	52	300	упаковка
5017	2290	517	5278	91	58	ящик
5018	310	518	13776	56	246	ящик
5019	1783	518	4002	46	87	кг
5020	2284	518	5145	35	147	ящик
5021	1324	519	10976	49	224	кг
5022	1820	519	21560	88	245	кг
5023	2133	519	1405	5	281	кг
5024	1823	520	2590	14	185	упаковка
5025	1732	521	9191	91	101	упаковка
5026	966	522	7938	27	294	кг
5027	686	522	3904	61	64	упаковка
5028	1097	523	8460	94	90	ящик
5029	285	523	3048	12	254	ящик
5030	1881	524	4257	33	129	кг
5031	231	525	239	1	239	ящик
5032	1492	525	23375	85	275	кг
5033	1142	526	28200	100	282	ящик
5034	2554	526	1200	5	240	упаковка
5035	2415	526	1725	25	69	упаковка
5036	2461	527	3640	70	52	кг
5037	528	527	16280	74	220	ящик
5038	2522	528	576	6	96	упаковка
5039	2343	529	25207	91	277	ящик
5040	820	529	6048	21	288	ящик
5041	2905	530	4524	39	116	ящик
5042	2159	530	7587	27	281	кг
5043	2865	531	410	5	82	кг
5044	2523	532	2340	9	260	упаковка
5045	972	532	9396	81	116	ящик
5046	1649	533	9353	47	199	ящик
5047	2801	533	19125	85	225	упаковка
5048	1246	533	9805	37	265	упаковка
5049	2792	534	1660	20	83	кг
5050	1229	535	15120	80	189	ящик
5051	2215	535	25568	94	272	ящик
5052	2490	535	3915	15	261	кг
5053	685	536	5538	39	142	упаковка
5054	1691	536	4374	18	243	упаковка
5055	251	536	13301	47	283	упаковка
5056	1990	537	2958	29	102	ящик
5057	1236	537	5620	20	281	упаковка
5058	677	537	2745	15	183	ящик
5059	137	538	5190	30	173	кг
5060	278	539	15399	87	177	кг
5061	1118	540	4830	70	69	кг
5062	409	541	13338	54	247	кг
5063	102	541	8877	33	269	кг
5064	2591	541	5896	67	88	кг
5065	2146	542	5778	27	214	упаковка
5066	2617	543	21840	91	240	ящик
5067	1637	544	4209	69	61	ящик
5068	2326	545	5192	59	88	упаковка
5069	1853	545	16236	99	164	упаковка
5070	1173	546	5776	38	152	упаковка
5071	686	547	2912	26	112	упаковка
5072	1625	548	11640	60	194	кг
5073	2381	548	7168	64	112	кг
5074	781	549	3277	29	113	упаковка
5075	328	549	10560	66	160	упаковка
5076	2161	550	4628	26	178	ящик
5077	2724	551	13764	93	148	ящик
5078	505	551	5146	83	62	кг
5079	988	552	19199	73	263	ящик
5080	1001	552	13489	47	287	упаковка
5081	91	553	8816	76	116	кг
5082	2473	554	6468	28	231	ящик
5083	2522	554	265	5	53	кг
5084	2038	554	1352	8	169	кг
5085	2349	555	9424	76	124	ящик
5086	1525	555	240	2	120	кг
5087	1251	555	5504	43	128	кг
5088	946	556	19440	80	243	ящик
5089	742	556	8621	37	233	кг
5090	1051	556	28000	100	280	ящик
5091	929	557	4107	37	111	кг
5092	440	558	2130	30	71	ящик
5093	2845	558	9614	46	209	ящик
5094	981	559	7986	66	121	ящик
5095	1651	559	4048	44	92	ящик
5096	1392	559	3419	13	263	упаковка
5097	1739	560	285	5	57	упаковка
5098	491	561	11529	63	183	кг
5099	2904	561	11098	62	179	упаковка
5100	1113	562	4268	44	97	ящик
5101	2964	562	6035	71	85	кг
5102	2905	562	12298	43	286	кг
5103	2091	563	20100	67	300	упаковка
5104	2418	564	8856	36	246	упаковка
5105	888	564	9438	66	143	кг
5106	1511	564	2752	32	86	кг
5107	1964	565	1290	6	215	упаковка
5108	773	565	1920	24	80	упаковка
5109	2300	566	6175	25	247	упаковка
5110	2485	566	5320	38	140	упаковка
5111	1158	567	8170	38	215	кг
5112	2576	567	2808	12	234	кг
5113	2782	568	71	1	71	ящик
5114	839	568	6292	44	143	упаковка
5115	1910	569	14790	87	170	упаковка
5116	324	569	24272	82	296	упаковка
5117	2907	570	672	7	96	кг
5118	2219	570	24252	94	258	ящик
5119	1078	571	16685	71	235	ящик
5120	1103	571	5238	27	194	ящик
5121	720	571	14697	71	207	упаковка
5122	2654	572	4312	28	154	кг
5123	2177	572	4428	27	164	упаковка
5124	656	572	14744	76	194	кг
5125	2564	573	1177	11	107	кг
5126	772	573	67	1	67	ящик
5127	851	573	9380	70	134	кг
5128	718	574	6727	31	217	кг
5129	1652	574	7221	87	83	кг
5130	2206	574	3074	58	53	кг
5131	258	575	9653	49	197	упаковка
5132	1307	575	18721	97	193	ящик
5133	1683	575	1539	9	171	упаковка
5134	1475	576	18315	99	185	ящик
5135	1890	577	1620	18	90	упаковка
5136	2117	577	24288	88	276	упаковка
5137	111	577	18291	91	201	ящик
5138	2832	578	11252	58	194	ящик
5139	251	578	11180	52	215	упаковка
5140	1447	578	4560	48	95	ящик
5141	1539	579	1464	6	244	упаковка
5142	2197	580	8555	59	145	упаковка
5143	2851	580	28215	95	297	кг
5144	2384	580	19760	80	247	упаковка
5145	1639	581	4182	82	51	ящик
5146	2040	581	1512	14	108	ящик
5147	285	582	9450	70	135	кг
5148	1243	582	7200	48	150	упаковка
5149	235	582	1155	7	165	кг
5150	2081	583	15456	84	184	упаковка
5151	2164	584	13515	53	255	ящик
5152	1991	584	1364	22	62	ящик
5153	2669	584	21896	92	238	ящик
5154	2423	585	11684	92	127	ящик
5155	1563	585	27451	97	283	кг
5156	2660	585	8446	41	206	упаковка
5157	2553	586	3367	37	91	упаковка
5158	2384	586	5976	83	72	кг
5159	205	586	2880	32	90	ящик
5160	1533	587	15249	69	221	кг
5161	2888	587	4324	23	188	кг
5162	403	587	6848	64	107	упаковка
5163	2370	588	13559	91	149	упаковка
5164	2718	589	3360	24	140	кг
5165	63	590	3399	33	103	ящик
5166	2714	591	26315	95	277	кг
5167	992	591	6560	82	80	упаковка
5168	802	591	9250	37	250	упаковка
5169	916	592	3164	28	113	кг
5170	24	593	801	9	89	ящик
5171	605	594	10773	81	133	упаковка
5172	21	595	198	2	99	упаковка
5173	138	595	22610	85	266	упаковка
5174	2273	595	11130	70	159	упаковка
5175	2155	596	3335	23	145	ящик
5176	2040	597	6072	66	92	упаковка
5177	2137	597	5092	19	268	ящик
5178	1518	597	2183	37	59	упаковка
5179	933	598	9145	31	295	упаковка
5180	2131	598	25935	95	273	кг
5181	2588	598	1323	21	63	ящик
5182	2360	599	3450	15	230	кг
5183	2050	599	3728	16	233	ящик
5184	2969	600	8568	34	252	кг
5185	1245	600	14157	99	143	упаковка
5186	422	600	3960	66	60	ящик
5187	358	601	1460	5	292	упаковка
5188	409	601	7821	99	79	упаковка
5189	2883	601	1650	30	55	кг
5190	942	602	11184	48	233	кг
5191	2118	603	1692	6	282	кг
5192	1622	603	9272	61	152	ящик
5193	668	604	4980	20	249	упаковка
5194	25	604	4379	29	151	кг
5195	1395	605	5523	21	263	ящик
5196	541	606	1947	11	177	ящик
5197	2535	606	19558	77	254	ящик
5198	2015	606	6528	68	96	кг
5199	1610	607	1925	11	175	ящик
5200	1010	607	11592	63	184	упаковка
5201	454	607	3760	20	188	упаковка
5202	137	608	10725	55	195	упаковка
5203	769	608	1679	23	73	упаковка
5204	2007	608	5540	20	277	кг
5205	826	609	11616	88	132	упаковка
5206	1655	610	8136	72	113	упаковка
5207	2784	610	13775	95	145	кг
5208	1370	611	11856	78	152	упаковка
5209	1310	612	3376	16	211	кг
5210	1704	612	26400	88	300	кг
5211	2680	613	4425	59	75	ящик
5212	1690	613	3270	30	109	упаковка
5213	796	613	14916	66	226	ящик
5214	837	614	10998	47	234	ящик
5215	1160	615	19458	94	207	упаковка
5216	1757	615	10413	39	267	ящик
5217	2598	615	13776	56	246	ящик
5218	514	616	5700	30	190	кг
5219	865	616	15312	66	232	упаковка
5220	2866	616	384	6	64	ящик
5221	2167	617	8512	32	266	кг
5222	101	618	6440	23	280	кг
5223	247	619	4800	60	80	ящик
5224	2048	619	11676	42	278	упаковка
5225	1636	620	845	13	65	кг
5226	1927	620	3888	24	162	упаковка
5227	951	621	3610	38	95	ящик
5228	1034	621	20889	99	211	упаковка
5229	1478	622	5670	45	126	ящик
5230	1714	623	4428	36	123	ящик
5231	880	624	5066	34	149	кг
5232	2582	625	536	8	67	упаковка
5233	2235	625	5280	66	80	упаковка
5234	2440	626	5092	76	67	упаковка
5235	94	626	1330	10	133	упаковка
5236	807	627	15300	68	225	упаковка
5237	2419	627	17085	85	201	упаковка
5238	244	627	6810	30	227	ящик
5239	2826	628	3705	39	95	упаковка
5240	178	629	1311	19	69	кг
5241	1482	629	3348	31	108	кг
5242	768	629	11174	74	151	ящик
5243	555	630	6930	30	231	упаковка
5244	203	630	15996	62	258	упаковка
5245	53	631	2375	25	95	ящик
5246	231	631	28812	98	294	ящик
5247	1854	631	5934	69	86	ящик
5248	2868	632	1769	29	61	упаковка
5249	2584	632	20972	98	214	ящик
5250	340	633	6400	100	64	ящик
5251	2520	633	21440	80	268	ящик
5252	1768	633	3699	27	137	ящик
5253	484	634	3388	14	242	кг
5254	1738	634	7956	68	117	упаковка
5255	1746	634	2597	49	53	ящик
5256	2319	635	22446	86	261	ящик
5257	376	635	17296	94	184	кг
5258	501	636	2442	22	111	ящик
5259	1212	637	4140	18	230	ящик
5260	62	637	1178	19	62	упаковка
5261	1404	637	11312	56	202	упаковка
5262	1247	638	1539	19	81	кг
5263	1599	639	22506	93	242	кг
5264	254	639	6552	72	91	кг
5265	1112	640	2808	27	104	ящик
5266	1323	640	3822	26	147	кг
5267	1706	641	1728	32	54	ящик
5268	1557	641	10291	41	251	ящик
5269	69	642	11088	44	252	ящик
5270	2153	643	5220	58	90	кг
5271	123	643	269	1	269	ящик
5272	2740	643	6322	58	109	упаковка
5273	2070	644	10530	45	234	кг
5274	2663	644	21888	76	288	ящик
5275	1336	644	3726	23	162	ящик
5276	1092	645	8008	77	104	ящик
5277	716	645	292	2	146	упаковка
5278	2074	646	9782	73	134	кг
5279	1556	646	20550	75	274	ящик
5280	1411	647	474	2	237	ящик
5281	1379	647	12238	58	211	кг
5282	2849	647	4599	63	73	упаковка
5283	573	648	798	3	266	ящик
5284	1789	648	18966	87	218	кг
5285	2225	649	3192	56	57	ящик
5286	806	650	3936	32	123	кг
5287	795	650	6804	84	81	ящик
5288	2424	650	246	3	82	ящик
5289	1460	651	7900	79	100	упаковка
5290	196	651	13179	69	191	ящик
5291	1277	651	17290	91	190	кг
5292	489	652	10560	40	264	кг
5293	1374	652	17280	60	288	кг
5294	2685	652	6834	51	134	ящик
5295	2966	653	15576	66	236	кг
5296	2486	654	15198	51	298	ящик
5297	2810	654	7310	85	86	упаковка
5298	2234	655	2242	19	118	ящик
5299	1630	655	1440	15	96	кг
5300	449	656	945	7	135	ящик
5301	2603	656	6392	34	188	ящик
5302	2004	657	14036	58	242	ящик
5303	1743	658	912	4	228	кг
5304	781	658	8159	41	199	упаковка
5305	206	658	14190	86	165	ящик
5306	1535	659	11074	49	226	кг
5307	2957	659	1326	6	221	ящик
5308	1346	659	1190	14	85	ящик
5309	317	660	9752	46	212	ящик
5310	2965	660	1840	23	80	кг
5311	953	660	9614	38	253	упаковка
5312	2655	661	810	5	162	ящик
5313	805	661	8580	39	220	ящик
5314	1643	662	7504	67	112	кг
5315	1726	662	16146	69	234	ящик
5316	2503	662	1255	5	251	упаковка
5317	1263	663	6764	89	76	ящик
5318	483	664	8190	91	90	кг
5319	1961	664	21297	93	229	ящик
5320	843	664	4464	24	186	кг
5321	80	665	4578	42	109	упаковка
5322	1638	665	9520	56	170	упаковка
5323	833	665	10260	60	171	ящик
5324	1317	666	3690	41	90	упаковка
5325	446	666	1444	19	76	ящик
5326	1351	667	5845	35	167	ящик
5327	2850	667	7119	63	113	упаковка
5328	1922	667	16929	81	209	кг
5329	197	668	11174	74	151	ящик
5330	1201	668	9546	43	222	ящик
5331	1897	669	23933	91	263	кг
5332	2410	670	2058	21	98	кг
5333	1479	670	2184	26	84	ящик
5334	1328	671	1620	12	135	кг
5335	927	672	1792	32	56	упаковка
5336	975	672	22991	83	277	ящик
5337	898	672	5494	67	82	ящик
5338	2018	673	2820	15	188	упаковка
5339	481	673	10074	46	219	ящик
5340	1217	674	1560	12	130	кг
5341	264	674	1660	10	166	кг
5342	1406	675	4753	49	97	ящик
5343	91	675	8989	89	101	ящик
5344	945	675	5945	29	205	ящик
5345	1213	676	3648	16	228	ящик
5346	469	677	7920	60	132	упаковка
5347	1346	677	2773	47	59	кг
5348	1253	677	9702	63	154	упаковка
5349	1801	678	3420	57	60	упаковка
5350	405	678	14112	96	147	упаковка
5351	947	679	13050	45	290	кг
5352	1097	679	5301	31	171	кг
5353	1859	679	9917	47	211	кг
5354	1927	680	4864	19	256	ящик
5355	1567	680	5840	80	73	упаковка
5356	922	681	2464	14	176	кг
5357	2230	681	11352	86	132	ящик
5358	2197	682	2067	39	53	упаковка
5359	2721	682	1216	8	152	ящик
5360	2189	683	6468	77	84	кг
5361	2096	683	2552	44	58	кг
5362	2239	684	18490	86	215	кг
5363	1696	685	816	12	68	ящик
5364	1467	685	354	3	118	ящик
5365	66	686	5252	26	202	упаковка
5366	2561	686	6744	24	281	ящик
5367	2574	686	9945	39	255	упаковка
5368	2872	687	19250	70	275	кг
5369	574	687	2650	25	106	ящик
5370	1012	688	4074	14	291	кг
5371	423	689	1040	5	208	кг
5372	2532	689	13038	82	159	ящик
5373	2303	690	3321	41	81	упаковка
5374	417	690	7689	33	233	кг
5375	458	691	12375	99	125	кг
5376	2077	692	7084	44	161	ящик
5377	438	692	4108	26	158	кг
5378	1064	692	2600	10	260	упаковка
5379	2130	693	2140	20	107	упаковка
5380	2271	694	24453	99	247	упаковка
5381	307	694	8692	82	106	ящик
5382	1945	695	19520	80	244	упаковка
5383	2124	695	14288	76	188	ящик
5384	1080	696	15456	92	168	ящик
5385	1225	696	15640	68	230	кг
5386	967	697	6256	92	68	кг
5387	1545	698	10875	87	125	ящик
5388	868	698	8340	60	139	кг
5389	13	698	24948	84	297	упаковка
5390	869	699	9720	81	120	кг
5391	175	699	2076	12	173	ящик
5392	2089	699	852	12	71	упаковка
5393	1455	700	21240	72	295	упаковка
5394	1200	701	15678	78	201	упаковка
5395	381	702	2805	51	55	кг
5396	2080	702	9130	83	110	кг
5397	1517	702	9372	71	132	упаковка
5398	52	703	10521	63	167	упаковка
5399	209	704	1548	12	129	кг
5400	2223	705	5513	37	149	кг
5401	253	705	11775	75	157	кг
5402	1667	706	12705	77	165	кг
5403	1570	707	6200	100	62	кг
5404	1378	707	1526	14	109	упаковка
5405	952	707	1085	7	155	упаковка
5406	2302	708	9384	92	102	кг
5407	112	708	3663	33	111	ящик
5408	40	708	3795	69	55	кг
5409	379	709	10575	45	235	кг
5410	982	709	126	2	63	ящик
5411	599	710	21449	89	241	упаковка
5412	2661	710	21054	87	242	кг
5413	1399	711	5382	26	207	кг
5414	2881	711	2321	11	211	упаковка
5415	793	711	2944	23	128	кг
5416	470	712	5985	95	63	кг
5417	539	713	7315	35	209	ящик
5418	101	713	1440	18	80	кг
5419	23	713	18530	85	218	ящик
5420	1092	714	3476	44	79	кг
5421	828	715	1633	23	71	кг
5422	127	715	14751	99	149	упаковка
5423	1074	716	16798	74	227	кг
5424	2836	716	1260	20	63	ящик
5425	2355	716	19199	73	263	ящик
5426	1734	717	22386	82	273	упаковка
5427	514	718	13500	54	250	упаковка
5428	1975	718	5180	28	185	кг
5429	2715	719	10010	91	110	упаковка
5430	1415	719	3450	50	69	кг
5431	10	719	18700	100	187	ящик
5432	2236	720	2964	12	247	упаковка
5433	1689	721	4728	24	197	ящик
5434	498	721	19832	67	296	ящик
5435	891	722	6477	51	127	кг
5436	412	722	7665	35	219	кг
5437	1270	723	2769	13	213	ящик
5438	2468	723	15130	85	178	кг
5439	168	724	1650	22	75	ящик
5440	1164	725	159	3	53	кг
5441	1500	726	12189	51	239	упаковка
5442	278	727	12994	73	178	упаковка
5443	2744	728	1236	12	103	ящик
5444	2896	728	8820	30	294	ящик
5445	529	729	2964	57	52	ящик
5446	1949	729	2444	47	52	кг
5447	1052	729	19118	79	242	ящик
5448	314	730	10080	80	126	кг
5449	1649	730	3016	52	58	упаковка
5450	237	730	11968	88	136	ящик
5451	1060	731	22308	78	286	кг
5452	108	732	4725	25	189	кг
5453	2206	732	1196	4	299	кг
5454	1010	732	8874	87	102	ящик
5455	1812	733	1825	25	73	ящик
5456	1256	734	5865	51	115	упаковка
5457	2421	735	6510	30	217	кг
5458	1952	736	4200	30	140	ящик
5459	1693	736	1834	14	131	упаковка
5460	640	737	4256	28	152	ящик
5461	2554	738	29400	100	294	ящик
5462	1132	738	2340	18	130	упаковка
5463	1316	738	19240	74	260	ящик
5464	570	739	7350	50	147	кг
5465	1631	739	3178	14	227	ящик
5466	2233	740	6417	31	207	ящик
5467	814	740	3885	15	259	упаковка
5468	420	740	2079	27	77	упаковка
5469	2583	741	18907	73	259	кг
5470	2078	742	22854	78	293	кг
5471	920	743	3680	23	160	кг
5472	2725	744	606	6	101	упаковка
5473	2014	745	8816	58	152	кг
5474	1419	745	10208	44	232	кг
5475	2282	746	6328	28	226	упаковка
5476	1259	746	25668	93	276	ящик
5477	1874	747	11186	47	238	кг
5478	2120	747	642	6	107	упаковка
5479	448	747	3864	56	69	кг
5480	1070	748	3828	58	66	ящик
5481	169	749	23205	85	273	ящик
5482	564	749	786	6	131	упаковка
5483	2656	749	13332	66	202	кг
5484	2626	750	7645	55	139	упаковка
5485	1083	750	3456	24	144	ящик
5486	241	750	25168	88	286	ящик
5487	2667	751	5964	28	213	кг
5488	1754	752	9600	80	120	ящик
5489	1379	752	13338	78	171	кг
5490	1286	753	11058	38	291	ящик
5491	1067	753	3828	58	66	упаковка
5492	2233	753	18157	67	271	кг
5493	291	754	4464	31	144	ящик
5494	991	754	5115	33	155	кг
5495	739	755	10948	92	119	кг
5496	1406	755	1150	10	115	ящик
5497	2369	756	2180	10	218	упаковка
5498	2522	756	7684	68	113	кг
5499	2948	756	2695	11	245	упаковка
5500	393	757	16425	75	219	упаковка
5501	1851	757	5270	85	62	кг
5502	1036	757	1160	8	145	кг
5503	2901	758	11868	69	172	кг
5504	1604	758	13281	57	233	ящик
5505	1150	758	9696	48	202	ящик
5506	2818	759	7644	78	98	упаковка
5507	1849	759	9552	48	199	упаковка
5508	598	760	2755	29	95	упаковка
5509	315	760	840	5	168	ящик
5510	1394	760	9306	66	141	упаковка
5511	2032	761	873	3	291	упаковка
5512	1889	762	3740	68	55	ящик
5513	1573	763	5980	92	65	кг
5514	2041	763	4980	20	249	упаковка
5515	2525	764	7917	29	273	кг
5516	2735	764	19040	70	272	ящик
5517	1813	764	9256	52	178	упаковка
5518	2083	765	2576	28	92	ящик
5519	2923	765	5785	89	65	ящик
5520	625	766	9415	35	269	упаковка
5521	2659	766	3713	47	79	кг
5522	2721	767	16600	100	166	ящик
5523	408	767	8736	56	156	упаковка
5524	1736	767	1400	20	70	ящик
5525	2025	768	14136	76	186	упаковка
5526	2292	768	4680	52	90	упаковка
5527	2802	769	17625	75	235	упаковка
5528	926	769	7080	60	118	ящик
5529	2175	770	9894	34	291	кг
5530	1767	771	16037	79	203	упаковка
5531	2507	771	10703	77	139	упаковка
5532	1280	771	6510	35	186	ящик
5533	2359	772	8120	56	145	упаковка
5534	1763	772	3392	64	53	кг
5535	2562	772	18550	70	265	ящик
5536	2453	773	6182	22	281	упаковка
5537	863	773	1584	6	264	упаковка
5538	522	774	372	4	93	упаковка
5539	1110	774	12361	47	263	упаковка
5540	1679	775	2430	30	81	упаковка
5541	2867	775	7956	34	234	ящик
5542	1720	775	13392	62	216	кг
5543	1600	776	8736	78	112	упаковка
5544	1043	777	8967	49	183	упаковка
5545	1043	778	13284	81	164	ящик
5546	324	778	24112	88	274	ящик
5547	1484	778	6350	25	254	ящик
5548	896	779	5271	21	251	ящик
5549	2432	780	20732	73	284	упаковка
5550	816	780	6903	39	177	кг
5551	1847	780	1152	4	288	упаковка
5552	2038	781	13536	47	288	упаковка
5553	1109	781	8600	43	200	упаковка
5554	1758	781	20370	70	291	упаковка
5555	2922	782	22500	75	300	ящик
5556	417	783	15840	55	288	кг
5557	1606	783	8316	28	297	упаковка
5558	85	783	13588	79	172	кг
5559	1473	784	18615	73	255	кг
5560	1069	784	5643	33	171	ящик
5561	2700	784	21344	92	232	кг
5562	132	785	5668	52	109	упаковка
5563	1801	786	15656	76	206	упаковка
5564	2590	786	12090	62	195	упаковка
5565	2140	786	4202	22	191	упаковка
5566	2666	787	13268	62	214	кг
5567	2907	787	9537	51	187	упаковка
5568	2200	787	5572	28	199	кг
5569	2541	788	840	14	60	ящик
5570	20	788	9240	77	120	ящик
5571	126	788	1998	27	74	ящик
5572	2166	789	15436	68	227	кг
5573	467	789	11008	43	256	упаковка
5574	2500	790	18942	77	246	ящик
5575	973	791	5825	25	233	кг
5576	1937	791	3416	14	244	упаковка
5577	334	791	7680	96	80	ящик
5578	883	792	6200	25	248	ящик
5579	641	792	11562	41	282	ящик
5580	1743	793	3300	55	60	кг
5581	679	793	6912	64	108	ящик
5582	457	793	4371	47	93	кг
5583	2806	794	11256	56	201	кг
5584	1707	794	5264	28	188	кг
5585	1901	794	17633	77	229	упаковка
5586	2295	795	5846	74	79	кг
5587	2856	795	13455	45	299	ящик
5588	2451	795	19788	97	204	упаковка
5589	435	796	1440	15	96	кг
5590	202	797	3120	48	65	кг
5591	2787	798	3038	14	217	ящик
5592	2489	799	28700	100	287	упаковка
5593	11	799	1872	26	72	ящик
5594	1910	799	19796	98	202	ящик
5595	182	800	2664	12	222	упаковка
5596	2211	800	2355	15	157	ящик
5597	2962	801	8536	88	97	ящик
5598	312	801	728	14	52	ящик
5599	771	801	8084	47	172	упаковка
5600	1853	802	1963	13	151	ящик
5601	1632	803	4536	28	162	упаковка
5602	1912	803	6552	36	182	кг
5603	285	803	7128	81	88	кг
5604	2573	804	6962	59	118	ящик
5605	45	805	10578	82	129	упаковка
5606	1439	806	2337	19	123	кг
5607	586	806	3456	18	192	кг
5608	1559	806	2145	33	65	ящик
5609	416	807	652	4	163	ящик
5610	2052	808	71	1	71	ящик
5611	2487	808	13524	46	294	ящик
5612	1311	808	2160	16	135	кг
5613	2281	809	7000	50	140	кг
5614	2619	809	5475	25	219	упаковка
5615	982	809	6014	31	194	кг
5616	1813	810	5586	57	98	ящик
5617	2026	811	8475	75	113	кг
5618	2551	812	900	18	50	ящик
5619	1942	813	684	9	76	ящик
5620	884	814	10206	42	243	упаковка
5621	889	814	3927	17	231	упаковка
5622	434	814	1170	18	65	упаковка
5623	1659	815	10850	70	155	упаковка
5624	2781	816	4440	74	60	кг
5625	1198	816	5418	86	63	кг
5626	1260	817	5208	56	93	кг
5627	1578	817	9216	64	144	ящик
5628	2439	817	20468	86	238	упаковка
5629	1902	818	2910	30	97	кг
5630	373	818	8268	78	106	ящик
5631	2089	819	2415	23	105	упаковка
5632	442	820	10300	50	206	упаковка
5633	12	820	2810	10	281	ящик
5634	2561	821	4176	36	116	ящик
5635	1627	821	1159	19	61	ящик
5636	2527	821	969	17	57	кг
5637	2428	822	7007	77	91	кг
5638	1937	823	9176	74	124	ящик
5639	1596	823	1484	28	53	упаковка
5640	1059	824	2690	10	269	кг
5641	1878	824	1936	11	176	упаковка
5642	2383	824	3150	14	225	ящик
5643	1336	825	5037	73	69	ящик
5644	83	826	8733	41	213	упаковка
5645	1427	826	3332	28	119	кг
5646	459	827	3800	25	152	ящик
5647	2540	827	23661	99	239	упаковка
5648	89	828	7557	33	229	упаковка
5649	2840	828	5320	40	133	ящик
5650	468	828	23030	94	245	ящик
5651	1448	829	8253	63	131	ящик
5652	2924	829	10985	65	169	кг
5653	2321	830	8217	99	83	кг
5654	2997	830	10388	98	106	кг
5655	2792	830	1080	10	108	кг
5656	792	831	6435	65	99	упаковка
5657	2652	831	18600	62	300	кг
5658	2077	831	14514	59	246	кг
5659	1545	832	13250	53	250	упаковка
5660	1339	833	6390	30	213	ящик
5661	2662	833	990	10	99	упаковка
5662	1804	833	12956	79	164	упаковка
5663	824	834	3346	14	239	упаковка
5664	289	835	5184	18	288	упаковка
5665	817	836	2398	11	218	кг
5666	26	836	15680	70	224	кг
5667	1075	836	10865	41	265	упаковка
5668	2014	837	15665	65	241	ящик
5669	1769	837	6375	75	85	ящик
5670	2064	838	12864	48	268	кг
5671	1464	838	13696	64	214	упаковка
5672	508	838	9300	50	186	кг
5673	2469	839	1326	6	221	упаковка
5674	1407	839	16184	68	238	упаковка
5675	160	839	19228	76	253	кг
5676	163	840	18988	94	202	ящик
5677	2469	841	2096	16	131	упаковка
5678	2624	842	12702	87	146	ящик
5679	703	842	3296	16	206	кг
5680	667	843	11421	81	141	ящик
5681	680	844	5289	41	129	упаковка
5682	175	845	1476	18	82	кг
5683	14	845	1554	6	259	ящик
5684	592	846	5472	38	144	кг
5685	181	846	3495	15	233	кг
5686	1035	846	17466	71	246	ящик
5687	883	847	1848	7	264	кг
5688	1810	848	15989	59	271	упаковка
5689	923	849	5658	23	246	упаковка
5690	2370	850	19053	87	219	ящик
5691	2539	850	498	6	83	упаковка
5692	1370	851	3679	13	283	упаковка
5693	532	851	4280	40	107	ящик
5694	2362	852	6279	23	273	упаковка
5695	2844	853	5408	26	208	ящик
5696	1601	854	1332	12	111	кг
5697	456	855	8281	49	169	кг
5698	2676	855	4389	33	133	упаковка
5699	375	856	10251	51	201	ящик
5700	2554	856	2511	9	279	упаковка
5701	1483	857	5680	80	71	кг
5702	884	858	3560	40	89	кг
5703	1428	858	1210	5	242	кг
5704	971	858	26500	100	265	кг
5705	2150	859	4697	77	61	упаковка
5706	2794	859	3844	31	124	кг
5707	1272	860	6600	55	120	кг
5708	2660	860	7469	97	77	ящик
5709	851	861	5688	79	72	упаковка
5710	2040	861	684	4	171	упаковка
5711	958	861	7106	34	209	кг
5712	787	862	7154	73	98	упаковка
5713	2156	862	1526	14	109	кг
5714	1349	862	1728	27	64	кг
5715	17	863	5243	49	107	упаковка
5716	1126	863	6400	40	160	упаковка
5717	1740	864	594	11	54	ящик
5718	498	865	12300	100	123	упаковка
5719	1631	865	3660	20	183	ящик
5720	150	865	13172	74	178	ящик
5721	2192	866	5612	92	61	упаковка
5722	1169	867	14208	96	148	ящик
5723	2227	867	835	5	167	кг
5724	103	867	14560	65	224	кг
5725	983	868	3120	26	120	кг
5726	359	868	6106	71	86	упаковка
5727	2478	869	6386	62	103	упаковка
5728	717	870	3465	35	99	упаковка
5729	123	870	22200	74	300	кг
5730	2170	870	2821	31	91	ящик
5731	2283	871	26208	96	273	кг
5732	874	871	7169	67	107	упаковка
5733	383	872	11638	46	253	упаковка
5734	1554	873	13300	76	175	упаковка
5735	346	874	14500	100	145	ящик
5736	2838	874	6129	27	227	упаковка
5737	284	875	8352	58	144	кг
5738	85	875	3168	18	176	кг
5739	2258	876	8944	43	208	упаковка
5740	711	876	4725	21	225	упаковка
5741	1547	876	3288	24	137	кг
5742	1250	877	7400	25	296	упаковка
5743	797	877	16077	69	233	упаковка
5744	2236	878	3816	18	212	кг
5745	1071	878	4386	51	86	ящик
5746	2779	878	1696	8	212	ящик
5747	1501	879	19440	80	243	кг
5748	2132	880	3860	20	193	кг
5749	2344	881	10488	57	184	ящик
5750	195	881	10184	67	152	ящик
5751	1647	881	976	4	244	ящик
5752	481	882	14304	48	298	упаковка
5753	1919	882	2412	9	268	упаковка
5754	1675	883	11060	79	140	упаковка
5755	1629	883	2052	9	228	упаковка
5756	1377	884	10650	50	213	кг
5757	2422	884	8232	49	168	упаковка
5758	1455	885	7488	64	117	ящик
5759	939	885	11977	59	203	упаковка
5760	777	885	2808	24	117	ящик
5761	2768	886	11135	85	131	ящик
5762	2337	886	3760	47	80	кг
5763	1841	887	16800	100	168	ящик
5764	654	887	1420	5	284	кг
5765	441	888	11880	54	220	ящик
5766	2522	888	4104	27	152	ящик
5767	1750	888	408	4	102	кг
5768	1459	889	17172	81	212	упаковка
5769	476	890	305	5	61	ящик
5770	1176	890	868	4	217	упаковка
5771	906	891	9916	37	268	ящик
5772	2309	891	1791	9	199	упаковка
5773	2237	892	23422	98	239	ящик
5774	1693	893	27918	99	282	упаковка
5775	1821	893	5472	57	96	упаковка
5776	1352	894	8918	49	182	упаковка
5777	213	894	1734	17	102	ящик
5778	761	895	675	9	75	кг
5779	810	896	17182	71	242	упаковка
5780	2966	896	1989	13	153	кг
5781	2119	897	18924	83	228	ящик
5782	916	897	3252	12	271	ящик
5783	422	897	14100	75	188	ящик
5784	2513	898	9776	52	188	кг
5785	1920	898	1417	13	109	упаковка
5786	1337	898	1540	28	55	упаковка
5787	118	899	1624	14	116	кг
5788	2387	899	11163	61	183	упаковка
5789	2198	899	15744	82	192	упаковка
5790	555	900	6806	82	83	ящик
5791	293	900	10736	88	122	ящик
5792	917	901	4845	51	95	упаковка
5793	664	902	242	2	121	ящик
5794	886	902	5704	46	124	кг
5795	2629	902	10695	69	155	упаковка
5796	2876	903	8400	60	140	кг
5797	43	903	13550	50	271	упаковка
5798	2396	904	6439	47	137	ящик
5799	2310	904	3135	55	57	кг
5800	2958	905	1364	22	62	кг
5801	1893	905	15323	77	199	упаковка
5802	2150	906	2940	10	294	упаковка
5803	749	907	13662	54	253	ящик
5804	653	908	4757	71	67	упаковка
5805	1619	909	18105	85	213	кг
5806	755	909	15635	59	265	упаковка
5807	2347	910	5632	32	176	ящик
5808	90	911	1287	13	99	ящик
5809	2111	911	16320	68	240	упаковка
5810	314	912	8064	84	96	упаковка
5811	849	912	21296	88	242	кг
5812	2917	912	14378	91	158	кг
5813	1285	913	1960	7	280	ящик
5814	1298	914	22825	83	275	упаковка
5815	1888	914	20832	84	248	упаковка
5816	1148	915	17030	65	262	кг
5817	461	916	10725	39	275	ящик
5818	873	916	5244	69	76	упаковка
5819	335	917	1610	23	70	кг
5820	2551	917	8750	35	250	упаковка
5821	1650	918	6350	25	254	упаковка
5822	1623	918	8614	73	118	ящик
5823	328	919	14500	100	145	кг
5824	933	920	20448	96	213	ящик
5825	1317	921	20304	72	282	упаковка
5826	1145	921	18957	89	213	упаковка
5827	1433	921	19845	81	245	кг
5828	183	922	7224	28	258	упаковка
5829	1	922	10744	79	136	ящик
5830	456	922	6960	30	232	ящик
5831	2670	923	11036	62	178	ящик
5832	2019	923	18139	97	187	упаковка
5833	467	923	1881	9	209	упаковка
5834	1694	924	264	1	264	кг
5835	1550	925	14691	59	249	упаковка
5836	1320	926	1012	4	253	кг
5837	2570	926	4096	16	256	кг
5838	493	926	913	11	83	кг
5839	2932	927	756	9	84	упаковка
5840	2846	927	11248	76	148	ящик
5841	1258	928	5586	49	114	упаковка
5842	562	929	13515	51	265	ящик
5843	2605	929	2574	22	117	ящик
5844	2178	930	2660	38	70	ящик
5845	1621	931	4788	84	57	кг
5846	2982	932	5792	32	181	ящик
5847	2116	933	4950	22	225	ящик
5848	1681	934	6708	86	78	кг
5849	1800	934	8308	62	134	упаковка
5850	99	934	1722	21	82	упаковка
5851	2825	935	2660	10	266	кг
5852	2974	936	14145	69	205	упаковка
5853	763	936	4650	30	155	кг
5854	1920	937	12480	48	260	ящик
5855	1781	938	13937	77	181	упаковка
5856	1431	939	17563	91	193	ящик
5857	2836	939	4496	16	281	кг
5858	1827	940	4448	32	139	кг
5859	1249	940	93	1	93	кг
5860	694	940	1536	24	64	кг
5861	131	941	3402	27	126	ящик
5862	1055	942	606	3	202	кг
5863	2668	942	20945	71	295	кг
5864	351	943	16262	94	173	ящик
5865	1549	943	1888	8	236	кг
5866	1459	943	17391	93	187	кг
5867	2045	944	10472	56	187	кг
5868	517	944	10585	73	145	ящик
5869	1894	945	6642	82	81	упаковка
5870	1157	945	20661	97	213	упаковка
5871	2320	946	4536	18	252	ящик
5872	1042	946	6006	78	77	ящик
5873	1376	946	2620	10	262	ящик
5874	2816	947	10200	68	150	ящик
5875	1174	947	18382	91	202	ящик
5876	1696	947	6030	45	134	кг
5877	559	948	8694	54	161	ящик
5878	2037	949	15531	93	167	кг
5879	306	950	27354	97	282	упаковка
5880	1862	950	5328	24	222	упаковка
5881	101	951	2921	23	127	ящик
5882	1453	952	12516	84	149	кг
5883	2805	953	1767	19	93	кг
5884	1989	953	3180	15	212	кг
5885	227	954	498	6	83	ящик
5886	2	955	21112	91	232	упаковка
5887	2671	955	6716	46	146	ящик
5888	171	956	13246	74	179	упаковка
5889	38	957	14950	65	230	кг
5890	2121	957	7824	48	163	кг
5891	2684	958	11857	71	167	упаковка
5892	21	958	7128	27	264	упаковка
5893	682	959	5536	32	173	кг
5894	2524	959	10250	50	205	упаковка
5895	2038	959	12593	49	257	упаковка
5896	2152	960	135	1	135	ящик
5897	923	961	8640	40	216	упаковка
5898	2394	962	747	3	249	кг
5899	315	963	7182	54	133	ящик
5900	689	963	4664	88	53	кг
5901	2760	963	8684	52	167	кг
5902	2833	964	2112	12	176	кг
5903	988	965	3294	18	183	ящик
5904	2565	965	4420	65	68	кг
5905	700	965	4488	66	68	упаковка
5906	141	966	8372	91	92	кг
5907	605	966	7623	33	231	упаковка
5908	430	967	10032	57	176	упаковка
5909	2070	967	13872	48	289	упаковка
5910	182	967	9519	57	167	упаковка
5911	2213	968	2640	12	220	кг
5912	2937	968	19104	96	199	упаковка
5913	2133	968	244	4	61	ящик
5914	1004	969	3096	43	72	ящик
5915	1047	969	5280	24	220	упаковка
5916	1963	969	6432	48	134	упаковка
5917	281	970	8924	92	97	упаковка
5918	1099	971	2964	19	156	кг
5919	895	971	2530	23	110	кг
5920	6	972	20296	86	236	ящик
5921	2802	972	20196	99	204	ящик
5922	398	972	11026	74	149	кг
5923	298	973	2086	7	298	кг
5924	254	974	17514	63	278	ящик
5925	159	974	7874	62	127	кг
5926	692	975	16352	73	224	упаковка
5927	2685	975	20328	84	242	ящик
5928	2430	975	12825	95	135	кг
5929	2480	976	11356	68	167	кг
5930	1385	976	9048	39	232	кг
5931	523	976	4836	26	186	ящик
5932	2318	977	21804	79	276	кг
5933	2046	977	4260	30	142	кг
5934	711	978	876	6	146	кг
5935	2419	978	14647	97	151	ящик
5936	834	978	3045	15	203	ящик
5937	629	979	13320	60	222	ящик
5938	1559	980	1350	6	225	кг
5939	18	981	4080	68	60	ящик
5940	1115	981	10797	59	183	кг
5941	2153	981	9620	37	260	кг
5942	756	982	777	7	111	ящик
5943	1775	982	3304	59	56	упаковка
5944	158	982	6083	77	79	кг
5945	2066	983	2596	11	236	ящик
5946	2559	984	2227	17	131	кг
5947	1892	985	18308	92	199	ящик
5948	97	985	7348	44	167	ящик
5949	629	986	10952	74	148	кг
5950	1805	987	11658	67	174	упаковка
5951	2615	987	14774	83	178	упаковка
5952	2873	988	5332	86	62	кг
5953	252	988	22616	88	257	кг
5954	532	989	10317	57	181	ящик
5955	188	990	7260	30	242	кг
5956	1483	990	11250	75	150	ящик
5957	2822	990	4636	76	61	кг
5958	587	991	11094	43	258	кг
5959	866	991	4408	38	116	упаковка
5960	2026	992	6162	26	237	кг
5961	2203	992	5129	23	223	кг
5962	1776	992	564	3	188	упаковка
5963	1744	993	5670	45	126	ящик
5964	2674	993	12485	55	227	упаковка
5965	1538	994	20740	85	244	ящик
5966	743	994	9027	59	153	упаковка
5967	1096	995	17374	73	238	упаковка
5968	669	996	8052	44	183	ящик
5969	2832	996	4095	45	91	ящик
5970	982	997	2448	18	136	упаковка
5971	2253	998	5148	78	66	кг
5972	487	998	6586	37	178	ящик
5973	606	998	5934	69	86	кг
5974	608	999	4600	20	230	упаковка
5975	1185	999	23552	92	256	упаковка
5976	200	1000	15235	55	277	упаковка
\.


--
-- TOC entry 3722 (class 0 OID 16734)
-- Dependencies: 227
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.orders (order_id, customer_id, order_date, delivery_date, payment_status, processing_status, manager_id, branch_id, delivery_address) FROM stdin;
1	939	2024-03-13	2024-03-18	ожидание	завершён	2	7	Не указан
2	928	2024-03-03	2024-03-05	отменён	новый	11	6	Не указан
3	847	2024-03-06	2024-03-09	оплачен	новый	8	1	Не указан
4	861	2024-03-26	2024-03-28	ожидание	отменён	13	8	Не указан
5	799	2024-03-06	2024-03-07	оплачен	в обработке	11	1	Не указан
6	63	2024-03-08	2024-03-10	ожидание	новый	3	10	Не указан
7	230	2024-03-01	2024-03-05	ожидание	отменён	2	9	Не указан
8	244	2024-03-23	2024-03-27	ожидание	отменён	8	4	Не указан
9	878	2024-03-25	2024-03-28	оплачен	отменён	10	10	Не указан
10	585	2024-03-15	2024-03-19	отменён	завершён	8	9	Не указан
11	453	2024-03-04	2024-03-06	оплачен	новый	10	6	Не указан
12	49	2024-03-24	2024-03-27	ожидание	в обработке	10	8	Не указан
13	360	2024-03-12	2024-03-16	оплачен	завершён	15	1	Не указан
14	706	2024-03-22	2024-03-26	оплачен	отменён	15	7	Не указан
15	606	2024-03-18	2024-03-20	ожидание	новый	12	3	Не указан
16	377	2024-03-31	2024-04-01	оплачен	завершён	11	5	Не указан
17	495	2024-03-03	2024-03-04	отменён	отменён	2	6	Не указан
18	215	2024-03-24	2024-03-29	отменён	в обработке	14	3	Не указан
19	670	2024-03-18	2024-03-20	ожидание	завершён	6	10	Не указан
20	267	2024-03-06	2024-03-08	ожидание	отменён	2	3	Не указан
21	372	2024-03-18	2024-03-19	ожидание	завершён	14	1	Не указан
22	226	2024-03-04	2024-03-09	ожидание	завершён	13	3	Не указан
23	817	2024-03-04	2024-03-09	оплачен	завершён	8	6	Не указан
24	939	2024-03-18	2024-03-20	оплачен	в обработке	7	2	Не указан
25	847	2024-03-20	2024-03-21	отменён	отменён	12	4	Не указан
26	470	2024-03-10	2024-03-13	ожидание	завершён	14	6	Не указан
27	274	2024-03-21	2024-03-23	ожидание	в обработке	2	5	Не указан
28	640	2024-03-26	2024-03-30	отменён	отменён	6	1	Не указан
29	72	2024-03-11	2024-03-14	оплачен	завершён	13	6	Не указан
30	929	2024-03-03	2024-03-05	отменён	новый	5	4	Не указан
31	738	2024-03-07	2024-03-12	ожидание	в обработке	8	6	Не указан
32	844	2024-03-11	2024-03-13	оплачен	новый	15	2	Не указан
33	154	2024-03-25	2024-03-29	ожидание	завершён	11	6	Не указан
34	786	2024-03-12	2024-03-14	оплачен	завершён	9	6	Не указан
35	616	2024-03-13	2024-03-14	отменён	новый	9	6	Не указан
36	464	2024-03-28	2024-04-02	оплачен	отменён	5	7	Не указан
37	543	2024-03-30	2024-03-31	ожидание	отменён	12	2	Не указан
38	9	2024-03-23	2024-03-25	оплачен	отменён	10	10	Не указан
39	207	2024-03-11	2024-03-12	оплачен	новый	15	2	Не указан
40	191	2024-03-05	2024-03-10	отменён	в обработке	12	5	Не указан
41	1000	2024-03-05	2024-03-08	ожидание	отменён	12	1	Не указан
42	90	2024-03-05	2024-03-06	оплачен	отменён	12	7	Не указан
43	455	2024-03-07	2024-03-09	ожидание	завершён	14	9	Не указан
44	918	2024-03-18	2024-03-20	оплачен	в обработке	14	5	Не указан
45	961	2024-03-11	2024-03-14	отменён	отменён	15	8	Не указан
46	910	2024-03-17	2024-03-19	отменён	завершён	1	8	Не указан
47	539	2024-03-14	2024-03-19	ожидание	отменён	6	7	Не указан
48	807	2024-03-26	2024-03-31	отменён	завершён	3	10	Не указан
49	923	2024-03-08	2024-03-10	ожидание	новый	11	8	Не указан
50	471	2024-03-18	2024-03-23	ожидание	отменён	7	9	Не указан
51	543	2024-03-04	2024-03-06	оплачен	в обработке	8	4	Не указан
52	984	2024-03-14	2024-03-15	отменён	новый	5	5	Не указан
53	602	2024-03-22	2024-03-27	отменён	завершён	1	2	Не указан
54	768	2024-03-16	2024-03-21	ожидание	завершён	1	4	Не указан
55	692	2024-03-18	2024-03-19	ожидание	новый	14	9	Не указан
56	318	2024-03-21	2024-03-22	ожидание	отменён	4	9	Не указан
57	429	2024-03-31	2024-04-03	отменён	в обработке	15	6	Не указан
58	829	2024-03-05	2024-03-06	оплачен	отменён	15	10	Не указан
59	683	2024-03-22	2024-03-26	ожидание	новый	13	3	Не указан
60	739	2024-03-06	2024-03-10	оплачен	новый	1	3	Не указан
61	860	2024-03-18	2024-03-21	ожидание	новый	3	10	Не указан
62	611	2024-03-18	2024-03-20	отменён	завершён	3	7	Не указан
63	986	2024-03-13	2024-03-17	отменён	отменён	2	7	Не указан
64	603	2024-03-21	2024-03-26	ожидание	завершён	2	9	Не указан
65	562	2024-03-19	2024-03-22	отменён	в обработке	14	3	Не указан
66	538	2024-03-20	2024-03-23	отменён	в обработке	12	9	Не указан
67	627	2024-03-20	2024-03-22	отменён	отменён	3	4	Не указан
68	113	2024-03-22	2024-03-24	ожидание	в обработке	15	1	Не указан
69	803	2024-03-20	2024-03-25	ожидание	в обработке	7	4	Не указан
70	445	2024-03-24	2024-03-26	отменён	в обработке	11	9	Не указан
71	863	2024-03-31	2024-04-05	ожидание	завершён	15	1	Не указан
72	374	2024-03-01	2024-03-03	оплачен	завершён	10	3	Не указан
73	342	2024-03-26	2024-03-30	оплачен	в обработке	13	2	Не указан
74	455	2024-03-09	2024-03-14	отменён	отменён	1	6	Не указан
75	214	2024-03-10	2024-03-15	ожидание	в обработке	6	3	Не указан
76	688	2024-03-30	2024-03-31	ожидание	в обработке	12	7	Не указан
77	225	2024-03-25	2024-03-30	отменён	новый	7	1	Не указан
78	949	2024-03-30	2024-04-02	ожидание	новый	9	9	Не указан
79	503	2024-03-16	2024-03-17	ожидание	отменён	4	1	Не указан
80	786	2024-03-22	2024-03-25	отменён	завершён	11	10	Не указан
81	667	2024-03-26	2024-03-31	отменён	отменён	10	7	Не указан
82	473	2024-03-06	2024-03-09	ожидание	завершён	8	7	Не указан
83	21	2024-03-10	2024-03-11	оплачен	новый	11	7	Не указан
84	499	2024-03-09	2024-03-14	отменён	завершён	4	4	Не указан
85	647	2024-03-18	2024-03-20	отменён	новый	9	10	Не указан
86	789	2024-03-15	2024-03-17	отменён	новый	12	4	Не указан
87	785	2024-03-28	2024-03-30	отменён	отменён	5	4	Не указан
88	371	2024-03-04	2024-03-09	оплачен	отменён	13	9	Не указан
89	107	2024-03-27	2024-03-31	оплачен	завершён	15	10	Не указан
90	724	2024-03-01	2024-03-06	ожидание	завершён	5	8	Не указан
91	505	2024-03-23	2024-03-27	отменён	новый	3	1	Не указан
92	615	2024-03-02	2024-03-04	отменён	завершён	6	8	Не указан
93	701	2024-03-22	2024-03-24	ожидание	в обработке	1	2	Не указан
94	681	2024-03-02	2024-03-06	ожидание	в обработке	10	8	Не указан
95	322	2024-03-11	2024-03-14	отменён	завершён	9	3	Не указан
96	936	2024-03-09	2024-03-12	оплачен	завершён	3	1	Не указан
97	402	2024-03-05	2024-03-07	ожидание	отменён	6	9	Не указан
98	809	2024-03-29	2024-03-30	оплачен	новый	13	8	Не указан
99	975	2024-03-30	2024-04-04	оплачен	завершён	10	4	Не указан
100	166	2024-03-26	2024-03-30	оплачен	завершён	13	4	Не указан
101	633	2024-03-06	2024-03-07	отменён	завершён	14	7	Не указан
102	425	2024-03-11	2024-03-16	оплачен	в обработке	9	4	Не указан
103	958	2024-03-14	2024-03-17	оплачен	завершён	12	7	Не указан
104	501	2024-03-24	2024-03-28	ожидание	завершён	10	10	Не указан
105	108	2024-03-08	2024-03-13	оплачен	отменён	7	4	Не указан
106	541	2024-03-25	2024-03-29	оплачен	завершён	14	2	Не указан
107	397	2024-03-22	2024-03-25	ожидание	отменён	12	6	Не указан
108	277	2024-03-06	2024-03-10	оплачен	новый	1	9	Не указан
109	701	2024-03-03	2024-03-06	оплачен	завершён	3	8	Не указан
110	291	2024-03-04	2024-03-07	оплачен	завершён	10	6	Не указан
111	586	2024-03-05	2024-03-08	отменён	в обработке	9	9	Не указан
112	577	2024-03-08	2024-03-13	оплачен	завершён	8	5	Не указан
113	337	2024-03-25	2024-03-26	ожидание	в обработке	11	1	Не указан
114	490	2024-03-07	2024-03-11	ожидание	завершён	7	1	Не указан
115	83	2024-03-24	2024-03-25	ожидание	отменён	12	9	Не указан
116	551	2024-03-07	2024-03-10	ожидание	в обработке	3	1	Не указан
117	98	2024-03-28	2024-04-02	отменён	отменён	5	1	Не указан
118	44	2024-03-15	2024-03-18	отменён	отменён	13	1	Не указан
119	192	2024-03-03	2024-03-04	ожидание	в обработке	2	3	Не указан
120	693	2024-03-18	2024-03-21	оплачен	отменён	4	1	Не указан
121	28	2024-03-19	2024-03-24	ожидание	новый	14	7	Не указан
122	531	2024-03-13	2024-03-14	оплачен	отменён	5	10	Не указан
123	707	2024-03-06	2024-03-11	отменён	в обработке	1	2	Не указан
124	992	2024-03-13	2024-03-16	ожидание	завершён	7	10	Не указан
125	794	2024-03-26	2024-03-30	оплачен	отменён	1	3	Не указан
126	412	2024-03-15	2024-03-17	отменён	в обработке	13	3	Не указан
127	120	2024-03-11	2024-03-14	оплачен	новый	12	5	Не указан
128	419	2024-03-09	2024-03-14	ожидание	завершён	12	5	Не указан
129	720	2024-03-19	2024-03-24	оплачен	завершён	6	4	Не указан
130	702	2024-03-03	2024-03-06	ожидание	завершён	15	8	Не указан
131	327	2024-03-05	2024-03-10	ожидание	новый	7	8	Не указан
132	638	2024-03-17	2024-03-19	отменён	завершён	15	8	Не указан
133	44	2024-03-27	2024-03-28	ожидание	новый	7	10	Не указан
134	190	2024-03-18	2024-03-23	ожидание	в обработке	11	5	Не указан
135	593	2024-03-04	2024-03-08	отменён	отменён	9	8	Не указан
136	683	2024-03-23	2024-03-26	ожидание	завершён	8	7	Не указан
137	770	2024-03-19	2024-03-20	оплачен	отменён	5	7	Не указан
138	198	2024-03-31	2024-04-04	оплачен	в обработке	11	8	Не указан
139	556	2024-03-18	2024-03-22	ожидание	отменён	10	5	Не указан
140	872	2024-03-04	2024-03-05	оплачен	отменён	9	5	Не указан
141	320	2024-03-14	2024-03-17	оплачен	завершён	8	4	Не указан
142	450	2024-03-08	2024-03-13	ожидание	новый	11	7	Не указан
143	166	2024-03-18	2024-03-21	отменён	отменён	3	5	Не указан
144	355	2024-03-09	2024-03-11	ожидание	новый	6	1	Не указан
145	175	2024-03-13	2024-03-18	оплачен	в обработке	4	8	Не указан
146	669	2024-03-31	2024-04-03	ожидание	новый	15	4	Не указан
147	652	2024-03-17	2024-03-19	ожидание	завершён	4	10	Не указан
148	563	2024-03-30	2024-04-03	ожидание	отменён	12	7	Не указан
149	825	2024-03-03	2024-03-05	отменён	новый	11	2	Не указан
150	744	2024-03-01	2024-03-03	отменён	новый	5	10	Не указан
151	901	2024-03-17	2024-03-18	оплачен	отменён	11	1	Не указан
152	57	2024-03-04	2024-03-06	оплачен	новый	14	9	Не указан
153	972	2024-03-23	2024-03-24	ожидание	отменён	2	10	Не указан
154	454	2024-03-03	2024-03-06	ожидание	отменён	13	7	Не указан
155	541	2024-03-06	2024-03-07	ожидание	завершён	8	10	Не указан
156	598	2024-03-28	2024-03-30	отменён	новый	5	6	Не указан
157	851	2024-03-25	2024-03-30	ожидание	завершён	10	9	Не указан
158	776	2024-03-12	2024-03-13	оплачен	новый	8	5	Не указан
159	242	2024-03-15	2024-03-20	ожидание	отменён	2	3	Не указан
160	447	2024-03-27	2024-04-01	ожидание	завершён	14	10	Не указан
161	31	2024-03-19	2024-03-23	оплачен	завершён	11	3	Не указан
162	526	2024-03-29	2024-04-03	ожидание	отменён	10	6	Не указан
163	15	2024-03-12	2024-03-17	оплачен	завершён	10	10	Не указан
164	903	2024-03-06	2024-03-11	оплачен	завершён	2	9	Не указан
165	926	2024-03-27	2024-03-31	ожидание	отменён	10	10	Не указан
166	331	2024-03-08	2024-03-11	оплачен	новый	3	7	Не указан
167	725	2024-03-08	2024-03-11	отменён	в обработке	10	4	Не указан
168	319	2024-03-01	2024-03-05	ожидание	завершён	15	5	Не указан
169	549	2024-03-15	2024-03-18	отменён	отменён	11	10	Не указан
170	241	2024-03-31	2024-04-03	оплачен	завершён	12	8	Не указан
171	712	2024-03-01	2024-03-04	отменён	новый	2	10	Не указан
172	671	2024-03-10	2024-03-11	отменён	новый	3	7	Не указан
173	968	2024-03-10	2024-03-14	ожидание	завершён	4	5	Не указан
174	986	2024-03-28	2024-03-31	ожидание	новый	6	10	Не указан
175	431	2024-03-10	2024-03-13	отменён	завершён	10	8	Не указан
176	207	2024-03-22	2024-03-24	отменён	новый	1	1	Не указан
177	484	2024-03-04	2024-03-07	ожидание	отменён	13	2	Не указан
178	444	2024-03-28	2024-04-02	отменён	завершён	8	1	Не указан
179	123	2024-03-13	2024-03-17	ожидание	завершён	1	5	Не указан
180	261	2024-03-23	2024-03-25	отменён	завершён	3	8	Не указан
181	100	2024-03-31	2024-04-05	отменён	в обработке	15	8	Не указан
182	51	2024-03-12	2024-03-15	ожидание	в обработке	10	1	Не указан
183	767	2024-03-31	2024-04-04	ожидание	новый	9	6	Не указан
184	388	2024-03-25	2024-03-26	отменён	в обработке	7	5	Не указан
185	240	2024-03-19	2024-03-24	ожидание	отменён	10	4	Не указан
186	448	2024-03-07	2024-03-12	ожидание	в обработке	11	3	Не указан
187	733	2024-03-22	2024-03-23	ожидание	завершён	3	5	Не указан
188	787	2024-03-21	2024-03-25	отменён	в обработке	10	5	Не указан
189	821	2024-03-14	2024-03-15	оплачен	завершён	2	1	Не указан
190	454	2024-03-19	2024-03-21	ожидание	в обработке	1	3	Не указан
191	15	2024-03-14	2024-03-15	отменён	новый	2	9	Не указан
192	447	2024-03-17	2024-03-20	отменён	в обработке	1	6	Не указан
193	224	2024-03-17	2024-03-21	оплачен	завершён	11	7	Не указан
194	537	2024-03-18	2024-03-19	ожидание	завершён	8	8	Не указан
195	227	2024-03-11	2024-03-15	отменён	новый	15	4	Не указан
196	825	2024-03-12	2024-03-15	ожидание	в обработке	15	8	Не указан
197	819	2024-03-21	2024-03-24	отменён	новый	8	1	Не указан
198	452	2024-03-04	2024-03-07	отменён	в обработке	6	8	Не указан
199	65	2024-03-09	2024-03-12	ожидание	отменён	2	5	Не указан
200	656	2024-03-09	2024-03-14	ожидание	отменён	9	3	Не указан
201	442	2024-03-20	2024-03-23	ожидание	завершён	4	10	Не указан
202	395	2024-03-11	2024-03-14	оплачен	завершён	5	10	Не указан
203	125	2024-03-17	2024-03-22	ожидание	новый	15	8	Не указан
204	935	2024-03-18	2024-03-19	ожидание	завершён	1	8	Не указан
205	962	2024-03-27	2024-03-30	отменён	завершён	9	4	Не указан
206	389	2024-03-13	2024-03-15	оплачен	отменён	3	4	Не указан
207	422	2024-03-06	2024-03-09	ожидание	в обработке	11	4	Не указан
208	323	2024-03-04	2024-03-08	оплачен	в обработке	4	5	Не указан
209	533	2024-03-09	2024-03-11	отменён	новый	14	5	Не указан
210	213	2024-03-02	2024-03-05	ожидание	в обработке	3	10	Не указан
211	785	2024-03-27	2024-03-29	оплачен	новый	6	1	Не указан
212	828	2024-03-31	2024-04-03	отменён	новый	9	5	Не указан
213	17	2024-03-17	2024-03-22	отменён	завершён	6	5	Не указан
214	891	2024-03-30	2024-03-31	ожидание	отменён	4	10	Не указан
215	842	2024-03-23	2024-03-28	отменён	в обработке	5	8	Не указан
216	204	2024-03-29	2024-04-02	оплачен	завершён	3	3	Не указан
217	386	2024-03-21	2024-03-23	отменён	в обработке	9	1	Не указан
218	60	2024-03-05	2024-03-10	отменён	в обработке	6	10	Не указан
219	241	2024-03-26	2024-03-27	оплачен	отменён	13	3	Не указан
220	216	2024-03-27	2024-03-31	отменён	отменён	2	1	Не указан
221	540	2024-03-21	2024-03-26	отменён	в обработке	7	5	Не указан
222	689	2024-03-31	2024-04-02	отменён	завершён	15	5	Не указан
223	455	2024-03-20	2024-03-21	отменён	завершён	11	3	Не указан
224	208	2024-03-31	2024-04-04	оплачен	новый	2	4	Не указан
225	874	2024-03-01	2024-03-02	отменён	новый	1	8	Не указан
226	47	2024-03-22	2024-03-23	ожидание	отменён	5	10	Не указан
227	557	2024-03-21	2024-03-23	отменён	новый	1	7	Не указан
228	837	2024-03-23	2024-03-28	оплачен	завершён	9	5	Не указан
229	622	2024-03-22	2024-03-25	отменён	завершён	2	8	Не указан
230	390	2024-03-14	2024-03-19	оплачен	в обработке	10	3	Не указан
231	566	2024-03-30	2024-03-31	ожидание	завершён	9	10	Не указан
232	242	2024-03-10	2024-03-15	отменён	новый	9	7	Не указан
233	474	2024-03-04	2024-03-09	ожидание	отменён	7	4	Не указан
234	133	2024-03-24	2024-03-28	отменён	в обработке	3	8	Не указан
235	759	2024-03-14	2024-03-16	отменён	новый	10	5	Не указан
236	966	2024-03-10	2024-03-12	ожидание	отменён	6	3	Не указан
237	713	2024-03-28	2024-03-29	ожидание	отменён	13	5	Не указан
238	728	2024-03-06	2024-03-07	ожидание	завершён	2	7	Не указан
239	539	2024-03-17	2024-03-21	отменён	завершён	6	1	Не указан
240	126	2024-03-30	2024-04-03	отменён	завершён	7	7	Не указан
241	240	2024-03-17	2024-03-18	отменён	в обработке	12	7	Не указан
242	604	2024-03-14	2024-03-15	ожидание	в обработке	11	8	Не указан
243	737	2024-03-03	2024-03-08	отменён	отменён	7	6	Не указан
244	597	2024-03-22	2024-03-25	отменён	новый	12	5	Не указан
245	965	2024-03-16	2024-03-17	оплачен	отменён	2	6	Не указан
246	358	2024-03-02	2024-03-06	ожидание	новый	11	8	Не указан
247	656	2024-03-22	2024-03-27	ожидание	в обработке	6	7	Не указан
248	846	2024-03-15	2024-03-19	оплачен	новый	15	1	Не указан
249	20	2024-03-01	2024-03-05	отменён	завершён	15	10	Не указан
250	817	2024-03-18	2024-03-19	оплачен	новый	2	10	Не указан
251	401	2024-03-09	2024-03-11	оплачен	отменён	2	9	Не указан
252	738	2024-03-25	2024-03-26	ожидание	в обработке	2	4	Не указан
253	462	2024-03-29	2024-04-03	отменён	отменён	5	4	Не указан
254	330	2024-03-07	2024-03-12	ожидание	в обработке	8	5	Не указан
255	531	2024-03-02	2024-03-06	отменён	завершён	14	5	Не указан
256	546	2024-03-10	2024-03-15	оплачен	отменён	9	1	Не указан
257	106	2024-03-14	2024-03-16	оплачен	новый	11	10	Не указан
258	770	2024-03-20	2024-03-21	отменён	в обработке	10	2	Не указан
259	667	2024-03-16	2024-03-20	оплачен	завершён	4	7	Не указан
260	114	2024-03-15	2024-03-19	отменён	новый	1	10	Не указан
261	667	2024-03-15	2024-03-16	оплачен	новый	3	4	Не указан
262	934	2024-03-24	2024-03-25	оплачен	завершён	2	1	Не указан
263	791	2024-03-06	2024-03-07	отменён	в обработке	4	4	Не указан
264	27	2024-03-24	2024-03-27	ожидание	завершён	13	8	Не указан
265	338	2024-03-13	2024-03-15	оплачен	отменён	14	10	Не указан
266	296	2024-03-04	2024-03-08	оплачен	завершён	6	3	Не указан
267	865	2024-03-02	2024-03-07	отменён	отменён	5	7	Не указан
268	539	2024-03-21	2024-03-25	отменён	в обработке	13	5	Не указан
269	115	2024-03-09	2024-03-11	ожидание	завершён	3	6	Не указан
270	235	2024-03-23	2024-03-28	ожидание	отменён	13	2	Не указан
271	763	2024-03-21	2024-03-22	отменён	отменён	5	5	Не указан
272	697	2024-03-11	2024-03-13	отменён	завершён	12	2	Не указан
273	724	2024-03-23	2024-03-28	ожидание	в обработке	11	8	Не указан
274	648	2024-03-18	2024-03-23	ожидание	отменён	14	10	Не указан
275	148	2024-03-29	2024-03-31	оплачен	новый	12	3	Не указан
276	601	2024-03-21	2024-03-24	отменён	в обработке	15	7	Не указан
277	243	2024-03-17	2024-03-20	оплачен	новый	4	2	Не указан
278	663	2024-03-21	2024-03-22	ожидание	новый	9	4	Не указан
279	968	2024-03-02	2024-03-04	оплачен	завершён	2	2	Не указан
280	330	2024-03-02	2024-03-03	отменён	в обработке	1	3	Не указан
281	539	2024-03-19	2024-03-24	отменён	отменён	6	4	Не указан
282	133	2024-03-09	2024-03-14	ожидание	завершён	15	1	Не указан
283	817	2024-03-30	2024-03-31	оплачен	завершён	8	4	Не указан
284	407	2024-03-24	2024-03-26	отменён	новый	5	10	Не указан
285	808	2024-03-14	2024-03-17	ожидание	новый	13	3	Не указан
286	90	2024-03-21	2024-03-26	оплачен	новый	7	5	Не указан
287	487	2024-03-10	2024-03-12	отменён	отменён	6	8	Не указан
288	266	2024-03-22	2024-03-25	ожидание	в обработке	1	2	Не указан
289	459	2024-03-29	2024-04-02	ожидание	новый	6	6	Не указан
290	387	2024-03-13	2024-03-16	отменён	отменён	4	8	Не указан
291	924	2024-03-11	2024-03-14	ожидание	новый	3	9	Не указан
292	138	2024-03-25	2024-03-30	ожидание	в обработке	9	7	Не указан
293	641	2024-03-24	2024-03-26	оплачен	в обработке	5	9	Не указан
294	241	2024-03-02	2024-03-04	оплачен	в обработке	3	7	Не указан
295	382	2024-03-17	2024-03-19	отменён	завершён	12	9	Не указан
296	854	2024-03-16	2024-03-18	отменён	отменён	12	3	Не указан
297	270	2024-03-09	2024-03-12	оплачен	отменён	15	5	Не указан
298	665	2024-03-24	2024-03-28	ожидание	новый	6	10	Не указан
299	678	2024-03-27	2024-04-01	отменён	новый	4	8	Не указан
300	983	2024-03-01	2024-03-03	ожидание	новый	15	5	Не указан
301	198	2024-03-11	2024-03-16	ожидание	новый	1	4	Не указан
302	215	2024-03-12	2024-03-16	отменён	новый	10	3	Не указан
303	122	2024-03-14	2024-03-15	отменён	завершён	4	10	Не указан
304	249	2024-03-04	2024-03-05	ожидание	в обработке	10	5	Не указан
305	16	2024-03-13	2024-03-14	оплачен	отменён	8	10	Не указан
306	671	2024-03-08	2024-03-12	отменён	новый	1	6	Не указан
307	831	2024-03-30	2024-04-04	оплачен	отменён	4	1	Не указан
308	98	2024-03-14	2024-03-17	оплачен	новый	7	10	Не указан
309	827	2024-03-13	2024-03-14	отменён	отменён	8	7	Не указан
310	593	2024-03-15	2024-03-20	ожидание	в обработке	4	6	Не указан
311	515	2024-03-18	2024-03-20	оплачен	отменён	12	6	Не указан
312	721	2024-03-21	2024-03-24	отменён	отменён	8	4	Не указан
313	526	2024-03-11	2024-03-14	отменён	новый	7	8	Не указан
314	407	2024-03-30	2024-04-04	отменён	в обработке	5	4	Не указан
315	436	2024-03-20	2024-03-22	отменён	отменён	5	9	Не указан
316	887	2024-03-06	2024-03-09	оплачен	новый	14	2	Не указан
317	936	2024-03-13	2024-03-18	оплачен	отменён	4	9	Не указан
318	100	2024-03-24	2024-03-27	отменён	в обработке	12	9	Не указан
319	569	2024-03-03	2024-03-04	ожидание	в обработке	7	3	Не указан
320	823	2024-03-31	2024-04-03	оплачен	в обработке	1	10	Не указан
321	355	2024-03-05	2024-03-09	оплачен	новый	8	2	Не указан
322	329	2024-03-17	2024-03-22	отменён	завершён	6	2	Не указан
323	682	2024-03-15	2024-03-17	ожидание	новый	4	5	Не указан
324	195	2024-03-15	2024-03-18	отменён	завершён	9	8	Не указан
325	476	2024-03-19	2024-03-22	ожидание	новый	2	7	Не указан
326	374	2024-03-03	2024-03-08	ожидание	завершён	2	10	Не указан
327	208	2024-03-18	2024-03-22	отменён	в обработке	3	1	Не указан
328	568	2024-03-06	2024-03-10	оплачен	новый	15	6	Не указан
329	303	2024-03-10	2024-03-12	отменён	новый	14	4	Не указан
330	768	2024-03-05	2024-03-07	оплачен	отменён	9	10	Не указан
331	313	2024-03-11	2024-03-12	отменён	отменён	11	7	Не указан
332	401	2024-03-15	2024-03-18	отменён	отменён	12	4	Не указан
333	438	2024-03-25	2024-03-26	оплачен	в обработке	9	10	Не указан
334	847	2024-03-27	2024-03-31	оплачен	новый	2	10	Не указан
335	74	2024-03-29	2024-03-30	отменён	завершён	2	7	Не указан
336	230	2024-03-24	2024-03-26	отменён	новый	1	3	Не указан
337	455	2024-03-10	2024-03-15	отменён	завершён	11	7	Не указан
338	20	2024-03-28	2024-04-02	отменён	новый	4	4	Не указан
339	164	2024-03-22	2024-03-26	ожидание	завершён	14	3	Не указан
340	912	2024-03-28	2024-03-31	отменён	отменён	12	4	Не указан
341	739	2024-03-18	2024-03-22	ожидание	отменён	13	9	Не указан
342	230	2024-03-13	2024-03-15	оплачен	завершён	3	4	Не указан
343	129	2024-03-16	2024-03-21	оплачен	завершён	5	4	Не указан
344	765	2024-03-01	2024-03-02	оплачен	отменён	5	1	Не указан
345	425	2024-03-04	2024-03-06	отменён	отменён	13	7	Не указан
346	427	2024-03-18	2024-03-19	ожидание	завершён	1	7	Не указан
347	537	2024-03-08	2024-03-13	ожидание	завершён	8	1	Не указан
348	243	2024-03-20	2024-03-25	оплачен	завершён	4	3	Не указан
349	352	2024-03-23	2024-03-28	отменён	в обработке	5	3	Не указан
350	446	2024-03-11	2024-03-12	ожидание	завершён	13	4	Не указан
351	383	2024-03-15	2024-03-20	отменён	завершён	3	8	Не указан
352	210	2024-03-25	2024-03-29	отменён	в обработке	6	9	Не указан
353	515	2024-03-22	2024-03-25	оплачен	новый	13	10	Не указан
354	291	2024-03-11	2024-03-12	оплачен	новый	13	5	Не указан
355	922	2024-03-17	2024-03-20	ожидание	завершён	12	1	Не указан
356	638	2024-03-16	2024-03-17	отменён	завершён	9	5	Не указан
357	932	2024-03-06	2024-03-07	ожидание	завершён	14	3	Не указан
358	814	2024-03-29	2024-04-03	отменён	новый	3	3	Не указан
359	273	2024-03-09	2024-03-12	оплачен	отменён	1	8	Не указан
360	525	2024-03-30	2024-04-02	оплачен	новый	12	9	Не указан
361	511	2024-03-03	2024-03-06	оплачен	отменён	6	2	Не указан
362	291	2024-03-03	2024-03-07	ожидание	в обработке	10	7	Не указан
363	256	2024-03-25	2024-03-29	оплачен	в обработке	5	10	Не указан
364	938	2024-03-21	2024-03-22	оплачен	завершён	12	3	Не указан
365	41	2024-03-09	2024-03-10	отменён	завершён	14	1	Не указан
366	920	2024-03-23	2024-03-28	ожидание	завершён	3	10	Не указан
367	448	2024-03-18	2024-03-23	ожидание	в обработке	10	1	Не указан
368	206	2024-03-27	2024-04-01	ожидание	завершён	4	3	Не указан
369	188	2024-03-05	2024-03-08	отменён	новый	12	1	Не указан
370	15	2024-03-07	2024-03-09	ожидание	завершён	3	5	Не указан
371	512	2024-03-11	2024-03-13	оплачен	в обработке	4	4	Не указан
372	639	2024-03-03	2024-03-06	оплачен	новый	9	6	Не указан
373	784	2024-03-05	2024-03-10	оплачен	завершён	6	10	Не указан
374	520	2024-03-28	2024-03-29	оплачен	отменён	10	10	Не указан
375	662	2024-03-25	2024-03-27	оплачен	отменён	5	9	Не указан
376	804	2024-03-25	2024-03-30	отменён	новый	3	2	Не указан
377	196	2024-03-29	2024-04-01	ожидание	в обработке	5	3	Не указан
378	190	2024-03-24	2024-03-28	оплачен	завершён	13	4	Не указан
379	359	2024-03-02	2024-03-03	отменён	в обработке	6	2	Не указан
380	141	2024-03-20	2024-03-21	отменён	отменён	5	1	Не указан
381	638	2024-03-10	2024-03-14	оплачен	новый	13	9	Не указан
382	743	2024-03-20	2024-03-22	ожидание	отменён	12	3	Не указан
383	715	2024-03-03	2024-03-04	оплачен	в обработке	12	3	Не указан
384	581	2024-03-07	2024-03-09	ожидание	завершён	5	8	Не указан
385	469	2024-03-28	2024-03-31	оплачен	завершён	6	6	Не указан
386	569	2024-03-17	2024-03-19	отменён	завершён	1	2	Не указан
387	519	2024-03-21	2024-03-25	отменён	новый	3	3	Не указан
388	172	2024-03-28	2024-03-29	оплачен	в обработке	9	2	Не указан
389	469	2024-03-03	2024-03-08	оплачен	в обработке	6	6	Не указан
390	48	2024-03-26	2024-03-27	ожидание	новый	7	9	Не указан
391	445	2024-03-28	2024-04-02	отменён	завершён	15	4	Не указан
392	250	2024-03-08	2024-03-11	отменён	отменён	11	7	Не указан
393	318	2024-03-06	2024-03-09	ожидание	отменён	4	4	Не указан
394	683	2024-03-10	2024-03-15	ожидание	отменён	14	9	Не указан
395	289	2024-03-02	2024-03-04	оплачен	отменён	11	4	Не указан
396	466	2024-03-17	2024-03-19	отменён	в обработке	3	3	Не указан
397	710	2024-03-25	2024-03-28	оплачен	в обработке	3	10	Не указан
398	714	2024-03-30	2024-04-02	ожидание	в обработке	2	1	Не указан
399	110	2024-03-19	2024-03-22	ожидание	завершён	6	7	Не указан
400	232	2024-03-14	2024-03-16	ожидание	новый	10	1	Не указан
401	571	2024-03-02	2024-03-04	отменён	отменён	7	9	Не указан
402	176	2024-03-18	2024-03-21	ожидание	отменён	4	10	Не указан
403	277	2024-03-05	2024-03-06	отменён	завершён	1	2	Не указан
404	889	2024-03-29	2024-04-02	отменён	новый	1	7	Не указан
405	689	2024-03-22	2024-03-23	ожидание	отменён	12	4	Не указан
406	79	2024-03-03	2024-03-04	отменён	отменён	2	8	Не указан
407	395	2024-03-22	2024-03-27	ожидание	в обработке	12	4	Не указан
408	855	2024-03-12	2024-03-17	ожидание	завершён	12	5	Не указан
409	679	2024-03-28	2024-03-30	ожидание	завершён	6	6	Не указан
410	23	2024-03-11	2024-03-15	оплачен	в обработке	3	8	Не указан
411	374	2024-03-30	2024-04-01	оплачен	в обработке	10	7	Не указан
412	697	2024-03-20	2024-03-24	ожидание	завершён	15	10	Не указан
413	663	2024-03-23	2024-03-24	оплачен	отменён	7	5	Не указан
414	897	2024-03-16	2024-03-18	отменён	отменён	12	5	Не указан
415	471	2024-03-28	2024-03-29	отменён	завершён	8	9	Не указан
416	28	2024-03-02	2024-03-06	оплачен	завершён	11	2	Не указан
417	84	2024-03-29	2024-03-30	ожидание	завершён	6	5	Не указан
418	802	2024-03-31	2024-04-02	ожидание	в обработке	8	5	Не указан
419	537	2024-03-07	2024-03-08	отменён	новый	15	3	Не указан
420	668	2024-03-05	2024-03-06	ожидание	в обработке	5	2	Не указан
421	340	2024-03-29	2024-04-02	ожидание	отменён	11	5	Не указан
422	336	2024-03-01	2024-03-05	ожидание	новый	6	2	Не указан
423	383	2024-03-27	2024-04-01	отменён	завершён	4	8	Не указан
424	963	2024-03-22	2024-03-23	ожидание	новый	3	8	Не указан
425	656	2024-03-06	2024-03-08	отменён	завершён	15	6	Не указан
426	936	2024-03-28	2024-03-31	оплачен	новый	1	5	Не указан
427	797	2024-03-08	2024-03-13	ожидание	в обработке	4	7	Не указан
428	216	2024-03-14	2024-03-17	отменён	новый	4	7	Не указан
429	883	2024-03-19	2024-03-22	оплачен	завершён	10	9	Не указан
430	140	2024-03-24	2024-03-29	ожидание	в обработке	13	10	Не указан
431	629	2024-03-11	2024-03-13	отменён	завершён	2	8	Не указан
432	845	2024-03-13	2024-03-14	отменён	отменён	8	10	Не указан
433	962	2024-03-01	2024-03-02	ожидание	в обработке	7	9	Не указан
434	929	2024-03-14	2024-03-17	оплачен	отменён	3	10	Не указан
435	184	2024-03-02	2024-03-05	оплачен	завершён	7	1	Не указан
436	71	2024-03-28	2024-03-29	оплачен	завершён	4	3	Не указан
437	680	2024-03-11	2024-03-14	ожидание	в обработке	5	8	Не указан
438	892	2024-03-14	2024-03-16	отменён	в обработке	11	1	Не указан
439	503	2024-03-12	2024-03-16	отменён	в обработке	8	9	Не указан
440	192	2024-03-09	2024-03-13	отменён	в обработке	8	9	Не указан
441	403	2024-03-23	2024-03-24	ожидание	новый	4	8	Не указан
442	948	2024-03-17	2024-03-22	ожидание	завершён	5	6	Не указан
443	110	2024-03-05	2024-03-08	отменён	в обработке	9	2	Не указан
444	275	2024-03-05	2024-03-09	ожидание	завершён	15	1	Не указан
445	522	2024-03-20	2024-03-23	оплачен	в обработке	7	4	Не указан
446	276	2024-03-13	2024-03-15	оплачен	отменён	2	7	Не указан
447	272	2024-03-02	2024-03-05	отменён	отменён	15	2	Не указан
448	338	2024-03-06	2024-03-07	ожидание	новый	3	6	Не указан
449	186	2024-03-01	2024-03-02	отменён	новый	13	5	Не указан
450	451	2024-03-14	2024-03-16	отменён	отменён	3	2	Не указан
451	688	2024-03-02	2024-03-04	ожидание	завершён	6	9	Не указан
452	349	2024-03-12	2024-03-14	оплачен	отменён	1	6	Не указан
453	713	2024-03-17	2024-03-20	оплачен	в обработке	15	7	Не указан
454	534	2024-03-08	2024-03-10	отменён	отменён	5	5	Не указан
455	168	2024-03-13	2024-03-17	оплачен	новый	7	10	Не указан
456	666	2024-03-05	2024-03-06	ожидание	в обработке	9	10	Не указан
457	936	2024-03-06	2024-03-09	ожидание	завершён	15	7	Не указан
458	905	2024-03-13	2024-03-17	оплачен	в обработке	8	10	Не указан
459	597	2024-03-16	2024-03-20	ожидание	завершён	1	4	Не указан
460	176	2024-03-26	2024-03-30	отменён	отменён	3	3	Не указан
461	865	2024-03-12	2024-03-14	оплачен	отменён	12	4	Не указан
462	263	2024-03-30	2024-04-03	отменён	отменён	12	1	Не указан
463	327	2024-03-08	2024-03-11	оплачен	отменён	15	8	Не указан
464	744	2024-03-19	2024-03-23	отменён	отменён	11	5	Не указан
465	629	2024-03-14	2024-03-17	ожидание	завершён	13	7	Не указан
466	579	2024-03-11	2024-03-16	ожидание	новый	8	8	Не указан
467	990	2024-03-05	2024-03-10	ожидание	новый	12	10	Не указан
468	851	2024-03-24	2024-03-25	ожидание	в обработке	7	3	Не указан
469	607	2024-03-31	2024-04-01	отменён	завершён	11	2	Не указан
470	838	2024-03-01	2024-03-05	ожидание	новый	6	6	Не указан
471	138	2024-03-05	2024-03-06	ожидание	новый	7	5	Не указан
472	132	2024-03-24	2024-03-25	отменён	завершён	14	8	Не указан
473	728	2024-03-01	2024-03-05	отменён	завершён	15	5	Не указан
474	340	2024-03-18	2024-03-22	оплачен	новый	1	8	Не указан
475	123	2024-03-10	2024-03-15	оплачен	в обработке	6	4	Не указан
476	942	2024-03-06	2024-03-10	отменён	отменён	11	2	Не указан
477	889	2024-03-06	2024-03-11	ожидание	в обработке	10	10	Не указан
478	617	2024-03-10	2024-03-13	ожидание	завершён	7	3	Не указан
479	224	2024-03-02	2024-03-04	ожидание	в обработке	12	7	Не указан
480	50	2024-03-19	2024-03-21	отменён	новый	5	2	Не указан
481	223	2024-03-13	2024-03-18	ожидание	завершён	4	2	Не указан
482	98	2024-03-26	2024-03-31	отменён	завершён	14	9	Не указан
483	151	2024-03-27	2024-03-28	отменён	новый	1	1	Не указан
484	190	2024-03-08	2024-03-12	ожидание	в обработке	9	8	Не указан
485	87	2024-03-05	2024-03-08	отменён	новый	6	5	Не указан
486	324	2024-03-10	2024-03-14	ожидание	новый	8	10	Не указан
487	296	2024-03-26	2024-03-27	отменён	в обработке	8	9	Не указан
488	135	2024-03-05	2024-03-09	ожидание	в обработке	15	6	Не указан
489	737	2024-03-01	2024-03-04	отменён	новый	12	1	Не указан
490	73	2024-03-21	2024-03-26	оплачен	отменён	13	6	Не указан
491	592	2024-03-30	2024-03-31	ожидание	отменён	2	7	Не указан
492	452	2024-03-02	2024-03-05	оплачен	в обработке	13	6	Не указан
493	649	2024-03-31	2024-04-03	отменён	новый	8	7	Не указан
494	805	2024-03-28	2024-03-31	ожидание	в обработке	9	1	Не указан
495	897	2024-03-01	2024-03-03	отменён	новый	1	8	Не указан
496	974	2024-03-05	2024-03-09	оплачен	завершён	15	7	Не указан
497	216	2024-03-29	2024-03-30	отменён	отменён	3	5	Не указан
498	57	2024-03-20	2024-03-22	ожидание	завершён	12	10	Не указан
499	359	2024-03-30	2024-04-01	отменён	завершён	14	10	Не указан
500	583	2024-03-13	2024-03-14	оплачен	завершён	2	4	Не указан
501	900	2024-03-05	2024-03-09	ожидание	в обработке	15	7	Не указан
502	849	2024-03-20	2024-03-21	отменён	завершён	1	1	Не указан
503	554	2024-03-11	2024-03-15	ожидание	отменён	9	8	Не указан
504	884	2024-03-28	2024-03-29	отменён	отменён	3	4	Не указан
505	962	2024-03-08	2024-03-10	ожидание	завершён	3	8	Не указан
506	995	2024-03-15	2024-03-17	ожидание	завершён	14	6	Не указан
507	254	2024-03-01	2024-03-04	оплачен	отменён	13	4	Не указан
508	409	2024-03-25	2024-03-29	ожидание	отменён	6	8	Не указан
509	617	2024-03-12	2024-03-17	ожидание	новый	6	3	Не указан
510	462	2024-03-08	2024-03-11	ожидание	отменён	5	4	Не указан
511	32	2024-03-16	2024-03-18	ожидание	отменён	3	3	Не указан
512	911	2024-03-17	2024-03-20	ожидание	завершён	12	6	Не указан
513	552	2024-03-21	2024-03-25	ожидание	отменён	6	1	Не указан
514	591	2024-03-29	2024-03-30	ожидание	в обработке	2	3	Не указан
515	832	2024-03-06	2024-03-09	оплачен	отменён	10	3	Не указан
516	941	2024-03-09	2024-03-11	ожидание	новый	13	8	Не указан
517	272	2024-03-01	2024-03-04	оплачен	новый	7	5	Не указан
518	833	2024-03-04	2024-03-05	ожидание	в обработке	3	1	Не указан
519	847	2024-03-30	2024-04-04	отменён	завершён	2	10	Не указан
520	643	2024-03-01	2024-03-05	отменён	в обработке	6	2	Не указан
521	936	2024-03-14	2024-03-18	отменён	отменён	4	2	Не указан
522	585	2024-03-06	2024-03-07	оплачен	в обработке	14	1	Не указан
523	400	2024-03-09	2024-03-12	отменён	завершён	7	5	Не указан
524	709	2024-03-03	2024-03-06	отменён	отменён	15	4	Не указан
525	699	2024-03-24	2024-03-26	отменён	завершён	13	1	Не указан
526	669	2024-03-26	2024-03-31	ожидание	завершён	6	6	Не указан
527	145	2024-03-17	2024-03-18	оплачен	отменён	8	5	Не указан
528	424	2024-03-14	2024-03-18	отменён	завершён	4	6	Не указан
529	505	2024-03-28	2024-03-31	отменён	завершён	5	10	Не указан
530	74	2024-03-31	2024-04-05	оплачен	отменён	1	2	Не указан
531	492	2024-03-14	2024-03-15	оплачен	новый	12	2	Не указан
532	706	2024-03-08	2024-03-13	отменён	отменён	3	10	Не указан
533	535	2024-03-12	2024-03-13	ожидание	отменён	6	5	Не указан
534	237	2024-03-11	2024-03-14	оплачен	завершён	12	4	Не указан
535	538	2024-03-30	2024-03-31	ожидание	завершён	9	5	Не указан
536	780	2024-03-24	2024-03-25	оплачен	в обработке	7	10	Не указан
537	880	2024-03-08	2024-03-11	отменён	завершён	14	2	Не указан
538	720	2024-03-18	2024-03-22	оплачен	завершён	15	5	Не указан
539	79	2024-03-24	2024-03-27	оплачен	в обработке	2	4	Не указан
540	782	2024-03-29	2024-04-03	оплачен	в обработке	11	8	Не указан
541	610	2024-03-06	2024-03-10	отменён	завершён	14	9	Не указан
542	892	2024-03-20	2024-03-23	отменён	отменён	7	5	Не указан
543	722	2024-03-19	2024-03-21	отменён	новый	2	10	Не указан
544	423	2024-03-30	2024-04-02	ожидание	завершён	2	8	Не указан
545	939	2024-03-08	2024-03-11	оплачен	новый	15	6	Не указан
546	175	2024-03-04	2024-03-08	ожидание	завершён	9	3	Не указан
547	585	2024-03-17	2024-03-20	отменён	отменён	5	10	Не указан
548	783	2024-03-23	2024-03-28	ожидание	отменён	15	5	Не указан
549	961	2024-03-20	2024-03-25	оплачен	новый	1	1	Не указан
550	352	2024-03-30	2024-04-02	отменён	завершён	7	10	Не указан
551	576	2024-03-31	2024-04-02	отменён	завершён	5	3	Не указан
552	783	2024-03-30	2024-04-02	оплачен	отменён	12	2	Не указан
553	654	2024-03-14	2024-03-18	ожидание	завершён	3	7	Не указан
554	326	2024-03-25	2024-03-30	отменён	отменён	10	3	Не указан
555	341	2024-03-29	2024-03-31	отменён	в обработке	5	8	Не указан
556	931	2024-03-06	2024-03-09	отменён	новый	2	9	Не указан
557	672	2024-03-19	2024-03-20	ожидание	новый	9	4	Не указан
558	791	2024-03-12	2024-03-16	оплачен	отменён	4	6	Не указан
559	223	2024-03-18	2024-03-20	оплачен	завершён	15	3	Не указан
560	68	2024-03-18	2024-03-19	отменён	новый	4	8	Не указан
561	635	2024-03-30	2024-03-31	оплачен	в обработке	8	9	Не указан
562	551	2024-03-27	2024-03-31	отменён	в обработке	6	9	Не указан
563	490	2024-03-20	2024-03-23	ожидание	в обработке	3	9	Не указан
564	490	2024-03-02	2024-03-03	оплачен	новый	15	2	Не указан
565	811	2024-03-10	2024-03-15	ожидание	новый	9	5	Не указан
566	219	2024-03-09	2024-03-13	оплачен	завершён	8	4	Не указан
567	104	2024-03-01	2024-03-06	отменён	новый	1	8	Не указан
568	956	2024-03-26	2024-03-27	ожидание	завершён	7	1	Не указан
569	398	2024-03-12	2024-03-17	ожидание	новый	10	1	Не указан
570	526	2024-03-11	2024-03-16	оплачен	новый	7	2	Не указан
571	654	2024-03-16	2024-03-18	оплачен	завершён	13	3	Не указан
572	365	2024-03-01	2024-03-03	ожидание	отменён	10	3	Не указан
573	832	2024-03-08	2024-03-12	оплачен	завершён	10	9	Не указан
574	739	2024-03-24	2024-03-25	ожидание	новый	7	7	Не указан
575	34	2024-03-04	2024-03-09	оплачен	в обработке	11	4	Не указан
576	381	2024-03-31	2024-04-01	отменён	отменён	8	3	Не указан
577	159	2024-03-10	2024-03-14	оплачен	отменён	7	3	Не указан
578	574	2024-03-20	2024-03-22	оплачен	отменён	8	6	Не указан
579	652	2024-03-05	2024-03-07	ожидание	отменён	12	5	Не указан
580	226	2024-03-28	2024-03-31	оплачен	завершён	12	8	Не указан
581	997	2024-03-30	2024-04-03	оплачен	отменён	2	3	Не указан
582	210	2024-03-29	2024-04-02	ожидание	новый	1	1	Не указан
583	639	2024-03-11	2024-03-14	отменён	отменён	15	9	Не указан
584	973	2024-03-27	2024-04-01	отменён	новый	8	7	Не указан
585	820	2024-03-03	2024-03-04	оплачен	отменён	6	6	Не указан
586	160	2024-03-11	2024-03-12	отменён	новый	7	1	Не указан
587	703	2024-03-22	2024-03-25	оплачен	отменён	15	3	Не указан
588	766	2024-03-22	2024-03-25	отменён	завершён	3	7	Не указан
589	625	2024-03-26	2024-03-28	оплачен	в обработке	2	9	Не указан
590	679	2024-03-31	2024-04-02	оплачен	завершён	14	7	Не указан
591	605	2024-03-11	2024-03-13	ожидание	новый	12	5	Не указан
592	207	2024-03-01	2024-03-02	оплачен	новый	4	4	Не указан
593	894	2024-03-05	2024-03-07	отменён	завершён	13	4	Не указан
594	57	2024-03-21	2024-03-24	ожидание	завершён	11	5	Не указан
595	850	2024-03-09	2024-03-12	оплачен	завершён	14	5	Не указан
596	324	2024-03-12	2024-03-15	ожидание	новый	15	8	Не указан
597	16	2024-03-15	2024-03-18	оплачен	новый	8	5	Не указан
598	526	2024-03-20	2024-03-22	ожидание	в обработке	14	9	Не указан
599	581	2024-03-18	2024-03-21	отменён	в обработке	5	7	Не указан
600	589	2024-03-24	2024-03-26	оплачен	в обработке	12	4	Не указан
601	28	2024-03-12	2024-03-13	оплачен	новый	6	9	Не указан
602	377	2024-03-18	2024-03-21	отменён	отменён	12	6	Не указан
603	994	2024-03-31	2024-04-04	оплачен	новый	12	7	Не указан
604	736	2024-03-19	2024-03-22	ожидание	отменён	1	5	Не указан
605	76	2024-03-01	2024-03-05	оплачен	новый	3	1	Не указан
606	726	2024-03-25	2024-03-29	ожидание	завершён	8	8	Не указан
607	924	2024-03-10	2024-03-14	оплачен	новый	10	8	Не указан
608	854	2024-03-21	2024-03-24	ожидание	новый	1	7	Не указан
609	166	2024-03-04	2024-03-06	оплачен	завершён	6	8	Не указан
610	572	2024-03-19	2024-03-22	ожидание	завершён	9	6	Не указан
611	227	2024-03-10	2024-03-15	ожидание	отменён	2	3	Не указан
612	927	2024-03-22	2024-03-26	отменён	завершён	6	4	Не указан
613	77	2024-03-17	2024-03-21	отменён	отменён	2	9	Не указан
614	560	2024-03-24	2024-03-28	ожидание	завершён	5	4	Не указан
615	463	2024-03-17	2024-03-20	оплачен	отменён	10	3	Не указан
616	45	2024-03-30	2024-04-04	ожидание	новый	4	6	Не указан
617	467	2024-03-16	2024-03-17	отменён	завершён	9	3	Не указан
618	970	2024-03-11	2024-03-12	ожидание	завершён	14	9	Не указан
619	501	2024-03-20	2024-03-25	ожидание	отменён	11	1	Не указан
620	534	2024-03-16	2024-03-20	отменён	отменён	1	4	Не указан
621	931	2024-03-11	2024-03-13	оплачен	отменён	1	4	Не указан
622	723	2024-03-18	2024-03-22	оплачен	завершён	11	6	Не указан
623	930	2024-03-21	2024-03-23	ожидание	в обработке	7	8	Не указан
624	795	2024-03-10	2024-03-15	оплачен	новый	14	5	Не указан
625	574	2024-03-22	2024-03-24	отменён	новый	12	3	Не указан
626	419	2024-03-09	2024-03-13	оплачен	новый	3	5	Не указан
627	694	2024-03-06	2024-03-11	отменён	завершён	5	10	Не указан
628	936	2024-03-14	2024-03-19	отменён	отменён	11	1	Не указан
629	409	2024-03-04	2024-03-05	отменён	новый	2	9	Не указан
630	950	2024-03-15	2024-03-16	отменён	отменён	4	3	Не указан
631	770	2024-03-07	2024-03-11	отменён	отменён	8	3	Не указан
632	253	2024-03-09	2024-03-14	отменён	в обработке	13	9	Не указан
633	6	2024-03-19	2024-03-20	ожидание	завершён	13	5	Не указан
634	834	2024-03-13	2024-03-16	отменён	завершён	11	7	Не указан
635	813	2024-03-15	2024-03-18	оплачен	новый	8	9	Не указан
636	497	2024-03-14	2024-03-18	оплачен	отменён	12	5	Не указан
637	99	2024-03-29	2024-03-31	оплачен	завершён	1	1	Не указан
638	788	2024-03-21	2024-03-25	отменён	отменён	4	3	Не указан
639	606	2024-03-26	2024-03-27	отменён	новый	2	8	Не указан
640	628	2024-03-13	2024-03-16	оплачен	отменён	8	10	Не указан
641	267	2024-03-24	2024-03-28	отменён	завершён	11	9	Не указан
642	897	2024-03-15	2024-03-19	отменён	завершён	1	3	Не указан
643	958	2024-03-20	2024-03-23	оплачен	в обработке	3	10	Не указан
644	505	2024-03-23	2024-03-26	отменён	в обработке	8	2	Не указан
645	801	2024-03-19	2024-03-20	ожидание	завершён	9	9	Не указан
646	806	2024-03-30	2024-04-03	ожидание	в обработке	6	10	Не указан
647	549	2024-03-01	2024-03-02	отменён	новый	15	7	Не указан
648	553	2024-03-25	2024-03-30	ожидание	в обработке	4	1	Не указан
649	800	2024-03-29	2024-03-31	отменён	отменён	11	1	Не указан
650	716	2024-03-13	2024-03-18	оплачен	новый	9	8	Не указан
651	319	2024-03-10	2024-03-15	ожидание	новый	6	2	Не указан
652	854	2024-03-15	2024-03-16	оплачен	завершён	10	6	Не указан
653	227	2024-03-17	2024-03-21	отменён	отменён	3	3	Не указан
654	742	2024-03-25	2024-03-27	оплачен	новый	6	7	Не указан
655	468	2024-03-16	2024-03-20	ожидание	отменён	5	5	Не указан
656	684	2024-03-09	2024-03-10	ожидание	завершён	1	2	Не указан
657	248	2024-03-25	2024-03-30	оплачен	новый	4	9	Не указан
658	446	2024-03-08	2024-03-10	оплачен	в обработке	15	4	Не указан
659	21	2024-03-10	2024-03-13	оплачен	завершён	10	2	Не указан
660	583	2024-03-28	2024-03-30	отменён	новый	6	6	Не указан
661	997	2024-03-06	2024-03-09	оплачен	новый	13	5	Не указан
662	326	2024-03-06	2024-03-11	ожидание	в обработке	9	9	Не указан
663	672	2024-03-02	2024-03-03	отменён	отменён	12	4	Не указан
664	740	2024-03-30	2024-04-04	ожидание	новый	12	1	Не указан
665	59	2024-03-09	2024-03-14	отменён	в обработке	7	4	Не указан
666	742	2024-03-10	2024-03-12	ожидание	завершён	11	8	Не указан
667	231	2024-03-08	2024-03-13	ожидание	завершён	12	3	Не указан
668	839	2024-03-29	2024-03-31	отменён	завершён	15	5	Не указан
669	793	2024-03-17	2024-03-22	оплачен	новый	9	6	Не указан
670	855	2024-03-01	2024-03-03	оплачен	новый	14	1	Не указан
671	794	2024-03-06	2024-03-11	отменён	завершён	5	6	Не указан
672	931	2024-03-26	2024-03-31	оплачен	новый	12	1	Не указан
673	470	2024-03-03	2024-03-04	ожидание	отменён	7	2	Не указан
674	281	2024-03-03	2024-03-04	оплачен	в обработке	11	5	Не указан
675	64	2024-03-11	2024-03-12	отменён	отменён	12	2	Не указан
676	6	2024-03-03	2024-03-06	оплачен	в обработке	7	2	Не указан
677	126	2024-03-15	2024-03-17	ожидание	отменён	15	8	Не указан
678	461	2024-03-16	2024-03-18	оплачен	новый	1	4	Не указан
679	334	2024-03-08	2024-03-12	отменён	отменён	3	9	Не указан
680	803	2024-03-11	2024-03-15	оплачен	завершён	6	6	Не указан
681	863	2024-03-17	2024-03-19	оплачен	в обработке	7	4	Не указан
682	61	2024-03-08	2024-03-12	отменён	новый	2	9	Не указан
683	688	2024-03-26	2024-03-31	отменён	новый	14	2	Не указан
684	294	2024-03-07	2024-03-12	ожидание	новый	10	6	Не указан
685	974	2024-03-17	2024-03-19	ожидание	новый	13	9	Не указан
686	755	2024-03-02	2024-03-05	оплачен	в обработке	11	5	Не указан
687	833	2024-03-08	2024-03-10	оплачен	завершён	7	3	Не указан
688	101	2024-03-26	2024-03-28	отменён	в обработке	12	1	Не указан
689	483	2024-03-22	2024-03-27	ожидание	завершён	9	1	Не указан
690	816	2024-03-21	2024-03-23	отменён	отменён	15	2	Не указан
691	96	2024-03-21	2024-03-25	оплачен	в обработке	15	6	Не указан
692	179	2024-03-23	2024-03-27	отменён	отменён	15	3	Не указан
693	990	2024-03-01	2024-03-05	оплачен	завершён	4	8	Не указан
694	61	2024-03-13	2024-03-14	оплачен	новый	11	5	Не указан
695	57	2024-03-16	2024-03-18	оплачен	отменён	14	7	Не указан
696	513	2024-03-29	2024-04-01	отменён	завершён	12	7	Не указан
697	850	2024-03-20	2024-03-21	отменён	отменён	10	7	Не указан
698	548	2024-03-22	2024-03-26	отменён	в обработке	2	10	Не указан
699	51	2024-03-11	2024-03-16	оплачен	новый	6	6	Не указан
700	7	2024-03-05	2024-03-07	ожидание	завершён	2	3	Не указан
701	964	2024-03-27	2024-03-30	отменён	завершён	5	3	Не указан
702	121	2024-03-19	2024-03-21	отменён	новый	10	2	Не указан
703	552	2024-03-09	2024-03-11	ожидание	в обработке	9	4	Не указан
704	437	2024-03-14	2024-03-16	оплачен	новый	7	8	Не указан
705	813	2024-03-10	2024-03-15	оплачен	в обработке	1	3	Не указан
706	713	2024-03-27	2024-04-01	оплачен	новый	15	4	Не указан
707	801	2024-03-08	2024-03-09	ожидание	в обработке	10	8	Не указан
708	982	2024-03-13	2024-03-17	оплачен	новый	2	6	Не указан
709	488	2024-03-24	2024-03-29	отменён	в обработке	8	5	Не указан
710	778	2024-03-06	2024-03-09	оплачен	отменён	10	5	Не указан
711	946	2024-03-02	2024-03-04	отменён	в обработке	4	2	Не указан
712	638	2024-03-28	2024-03-29	оплачен	в обработке	7	2	Не указан
713	146	2024-03-05	2024-03-07	отменён	отменён	4	10	Не указан
714	377	2024-03-14	2024-03-17	отменён	новый	4	10	Не указан
715	765	2024-03-03	2024-03-07	оплачен	новый	11	8	Не указан
716	69	2024-03-08	2024-03-11	отменён	в обработке	3	5	Не указан
717	166	2024-03-02	2024-03-05	ожидание	завершён	10	5	Не указан
718	495	2024-03-03	2024-03-04	ожидание	отменён	10	8	Не указан
719	18	2024-03-17	2024-03-20	оплачен	в обработке	3	2	Не указан
720	619	2024-03-07	2024-03-12	ожидание	отменён	8	10	Не указан
721	412	2024-03-27	2024-03-29	отменён	отменён	8	1	Не указан
722	610	2024-03-30	2024-03-31	оплачен	новый	6	6	Не указан
723	892	2024-03-21	2024-03-22	отменён	в обработке	6	10	Не указан
724	484	2024-03-04	2024-03-09	отменён	в обработке	15	3	Не указан
725	303	2024-03-25	2024-03-30	оплачен	завершён	10	10	Не указан
726	131	2024-03-07	2024-03-08	отменён	новый	8	3	Не указан
727	440	2024-03-06	2024-03-11	оплачен	завершён	7	7	Не указан
728	577	2024-03-21	2024-03-25	ожидание	завершён	7	6	Не указан
729	615	2024-03-10	2024-03-13	ожидание	отменён	3	2	Не указан
730	773	2024-03-07	2024-03-08	оплачен	завершён	14	7	Не указан
731	454	2024-03-26	2024-03-29	ожидание	завершён	3	10	Не указан
732	5	2024-03-02	2024-03-06	отменён	новый	11	9	Не указан
733	257	2024-03-14	2024-03-19	оплачен	в обработке	7	9	Не указан
734	714	2024-03-15	2024-03-19	отменён	в обработке	14	1	Не указан
735	185	2024-03-09	2024-03-13	отменён	в обработке	1	8	Не указан
736	900	2024-03-15	2024-03-16	отменён	в обработке	9	2	Не указан
737	327	2024-03-04	2024-03-08	ожидание	новый	8	2	Не указан
738	140	2024-03-25	2024-03-29	ожидание	новый	11	9	Не указан
739	451	2024-03-09	2024-03-10	оплачен	отменён	14	1	Не указан
740	383	2024-03-23	2024-03-27	отменён	отменён	11	6	Не указан
741	539	2024-03-08	2024-03-12	ожидание	в обработке	10	4	Не указан
742	394	2024-03-28	2024-04-02	отменён	новый	8	7	Не указан
743	449	2024-03-25	2024-03-30	ожидание	в обработке	15	4	Не указан
744	257	2024-03-23	2024-03-25	оплачен	отменён	3	5	Не указан
745	46	2024-03-16	2024-03-20	ожидание	отменён	11	10	Не указан
746	609	2024-03-17	2024-03-21	отменён	завершён	11	4	Не указан
747	290	2024-03-11	2024-03-16	ожидание	в обработке	6	8	Не указан
748	575	2024-03-14	2024-03-16	оплачен	завершён	9	5	Не указан
749	457	2024-03-04	2024-03-09	ожидание	в обработке	15	7	Не указан
750	615	2024-03-17	2024-03-19	ожидание	в обработке	6	10	Не указан
751	30	2024-03-02	2024-03-07	отменён	завершён	9	3	Не указан
752	962	2024-03-17	2024-03-20	ожидание	отменён	4	2	Не указан
753	390	2024-03-23	2024-03-25	отменён	новый	7	6	Не указан
754	467	2024-03-31	2024-04-01	ожидание	в обработке	13	1	Не указан
755	985	2024-03-31	2024-04-05	отменён	завершён	15	10	Не указан
756	603	2024-03-27	2024-03-31	оплачен	в обработке	6	9	Не указан
757	328	2024-03-01	2024-03-02	ожидание	завершён	13	5	Не указан
758	910	2024-03-09	2024-03-13	оплачен	в обработке	3	5	Не указан
759	228	2024-03-08	2024-03-12	ожидание	завершён	7	9	Не указан
760	18	2024-03-28	2024-03-30	отменён	в обработке	14	9	Не указан
761	42	2024-03-20	2024-03-23	ожидание	в обработке	9	5	Не указан
762	58	2024-03-31	2024-04-01	ожидание	отменён	2	2	Не указан
763	405	2024-03-11	2024-03-13	оплачен	завершён	8	10	Не указан
764	292	2024-03-11	2024-03-15	оплачен	завершён	10	5	Не указан
765	636	2024-03-27	2024-03-31	оплачен	завершён	4	4	Не указан
766	586	2024-03-22	2024-03-27	оплачен	отменён	4	10	Не указан
767	221	2024-03-25	2024-03-26	оплачен	в обработке	6	4	Не указан
768	684	2024-03-22	2024-03-23	оплачен	новый	14	4	Не указан
769	198	2024-03-07	2024-03-09	оплачен	завершён	4	5	Не указан
770	362	2024-03-27	2024-03-31	ожидание	завершён	1	9	Не указан
771	512	2024-03-26	2024-03-29	отменён	новый	6	6	Не указан
772	894	2024-03-29	2024-03-31	оплачен	отменён	9	7	Не указан
773	473	2024-03-13	2024-03-16	отменён	в обработке	3	5	Не указан
774	564	2024-03-27	2024-03-29	отменён	новый	9	1	Не указан
775	100	2024-03-04	2024-03-05	оплачен	в обработке	11	7	Не указан
776	901	2024-03-29	2024-04-01	отменён	отменён	7	3	Не указан
777	46	2024-03-26	2024-03-28	отменён	новый	5	6	Не указан
778	916	2024-03-09	2024-03-11	оплачен	новый	5	10	Не указан
779	230	2024-03-02	2024-03-06	оплачен	отменён	13	9	Не указан
780	200	2024-03-09	2024-03-13	оплачен	новый	9	9	Не указан
781	586	2024-03-17	2024-03-19	ожидание	в обработке	3	9	Не указан
782	76	2024-03-20	2024-03-21	оплачен	в обработке	8	2	Не указан
783	264	2024-03-27	2024-03-28	оплачен	отменён	2	1	Не указан
784	823	2024-03-11	2024-03-12	отменён	завершён	3	1	Не указан
785	522	2024-03-26	2024-03-31	ожидание	в обработке	4	2	Не указан
786	563	2024-03-24	2024-03-29	ожидание	отменён	13	7	Не указан
787	165	2024-03-11	2024-03-16	ожидание	в обработке	4	3	Не указан
788	796	2024-03-21	2024-03-23	оплачен	завершён	7	4	Не указан
789	512	2024-03-01	2024-03-04	оплачен	в обработке	11	8	Не указан
790	212	2024-03-02	2024-03-04	ожидание	отменён	2	10	Не указан
791	637	2024-03-15	2024-03-18	отменён	в обработке	3	8	Не указан
792	991	2024-03-28	2024-03-29	отменён	новый	15	4	Не указан
793	920	2024-03-02	2024-03-05	оплачен	завершён	15	5	Не указан
794	743	2024-03-04	2024-03-05	оплачен	в обработке	5	5	Не указан
795	121	2024-03-06	2024-03-11	оплачен	в обработке	7	8	Не указан
796	546	2024-03-12	2024-03-14	отменён	в обработке	14	5	Не указан
797	260	2024-03-01	2024-03-03	оплачен	отменён	3	6	Не указан
798	1000	2024-03-20	2024-03-23	отменён	завершён	14	6	Не указан
799	866	2024-03-28	2024-03-30	отменён	завершён	8	6	Не указан
800	168	2024-03-11	2024-03-16	отменён	новый	5	10	Не указан
801	40	2024-03-23	2024-03-25	ожидание	отменён	10	5	Не указан
802	641	2024-03-29	2024-04-02	ожидание	в обработке	10	9	Не указан
803	374	2024-03-16	2024-03-21	ожидание	новый	14	4	Не указан
804	439	2024-03-08	2024-03-10	отменён	новый	13	4	Не указан
805	434	2024-03-07	2024-03-11	оплачен	новый	5	6	Не указан
806	136	2024-03-25	2024-03-27	отменён	завершён	11	6	Не указан
807	362	2024-03-25	2024-03-30	оплачен	отменён	7	8	Не указан
808	564	2024-03-08	2024-03-10	ожидание	в обработке	5	1	Не указан
809	466	2024-03-29	2024-03-30	оплачен	в обработке	4	5	Не указан
810	230	2024-03-13	2024-03-15	отменён	новый	10	8	Не указан
811	142	2024-03-07	2024-03-11	отменён	завершён	13	10	Не указан
812	219	2024-03-06	2024-03-09	ожидание	новый	1	3	Не указан
813	493	2024-03-14	2024-03-18	оплачен	в обработке	14	5	Не указан
814	11	2024-03-14	2024-03-15	отменён	завершён	11	3	Не указан
815	110	2024-03-05	2024-03-08	оплачен	новый	15	4	Не указан
816	198	2024-03-11	2024-03-15	отменён	завершён	4	3	Не указан
817	647	2024-03-16	2024-03-17	ожидание	новый	12	3	Не указан
818	795	2024-03-29	2024-03-30	ожидание	в обработке	9	7	Не указан
819	710	2024-03-04	2024-03-09	ожидание	отменён	11	3	Не указан
820	520	2024-03-14	2024-03-17	оплачен	отменён	15	1	Не указан
821	631	2024-03-05	2024-03-09	ожидание	завершён	14	10	Не указан
822	719	2024-03-09	2024-03-12	ожидание	в обработке	6	9	Не указан
823	631	2024-03-12	2024-03-15	оплачен	в обработке	15	10	Не указан
824	116	2024-03-17	2024-03-21	оплачен	новый	11	9	Не указан
825	452	2024-03-02	2024-03-07	оплачен	в обработке	9	5	Не указан
826	501	2024-03-19	2024-03-23	отменён	отменён	15	7	Не указан
827	161	2024-03-08	2024-03-12	отменён	новый	5	9	Не указан
828	409	2024-03-14	2024-03-15	отменён	в обработке	14	8	Не указан
829	696	2024-03-16	2024-03-18	отменён	завершён	7	1	Не указан
830	374	2024-03-21	2024-03-25	ожидание	новый	6	1	Не указан
831	864	2024-03-19	2024-03-24	оплачен	отменён	15	10	Не указан
832	462	2024-03-31	2024-04-03	отменён	отменён	13	9	Не указан
833	469	2024-03-28	2024-04-01	оплачен	отменён	5	10	Не указан
834	139	2024-03-22	2024-03-26	ожидание	отменён	2	5	Не указан
835	450	2024-03-03	2024-03-07	отменён	новый	3	3	Не указан
836	10	2024-03-19	2024-03-21	отменён	новый	15	7	Не указан
837	587	2024-03-21	2024-03-26	оплачен	в обработке	13	10	Не указан
838	66	2024-03-21	2024-03-26	ожидание	в обработке	8	3	Не указан
839	811	2024-03-24	2024-03-25	ожидание	новый	2	7	Не указан
840	846	2024-03-02	2024-03-06	оплачен	отменён	12	5	Не указан
841	996	2024-03-08	2024-03-10	отменён	в обработке	5	8	Не указан
842	331	2024-03-09	2024-03-11	ожидание	отменён	11	2	Не указан
843	271	2024-03-25	2024-03-28	ожидание	завершён	2	3	Не указан
844	658	2024-03-17	2024-03-18	оплачен	новый	1	6	Не указан
845	860	2024-03-11	2024-03-14	ожидание	новый	2	2	Не указан
846	574	2024-03-05	2024-03-09	ожидание	завершён	3	4	Не указан
847	378	2024-03-31	2024-04-05	оплачен	в обработке	7	3	Не указан
848	936	2024-03-03	2024-03-06	отменён	в обработке	2	1	Не указан
849	16	2024-03-22	2024-03-23	оплачен	отменён	15	6	Не указан
850	298	2024-03-10	2024-03-15	ожидание	в обработке	9	10	Не указан
851	717	2024-03-24	2024-03-27	оплачен	в обработке	7	10	Не указан
852	474	2024-03-07	2024-03-10	отменён	новый	2	9	Не указан
853	351	2024-03-27	2024-03-29	ожидание	новый	4	2	Не указан
854	726	2024-03-25	2024-03-27	оплачен	новый	5	4	Не указан
855	735	2024-03-31	2024-04-04	ожидание	отменён	14	2	Не указан
856	306	2024-03-02	2024-03-04	отменён	завершён	15	9	Не указан
857	108	2024-03-09	2024-03-14	ожидание	отменён	2	10	Не указан
858	581	2024-03-19	2024-03-20	оплачен	новый	9	1	Не указан
859	437	2024-03-13	2024-03-15	оплачен	завершён	5	4	Не указан
860	643	2024-03-06	2024-03-08	ожидание	завершён	8	5	Не указан
861	228	2024-03-19	2024-03-21	ожидание	в обработке	10	3	Не указан
862	524	2024-03-27	2024-03-29	отменён	отменён	3	10	Не указан
863	297	2024-03-27	2024-03-30	оплачен	в обработке	11	7	Не указан
864	861	2024-03-09	2024-03-12	отменён	отменён	9	9	Не указан
865	897	2024-03-20	2024-03-24	оплачен	отменён	15	2	Не указан
866	892	2024-03-08	2024-03-10	ожидание	отменён	4	8	Не указан
867	667	2024-03-16	2024-03-17	оплачен	завершён	1	3	Не указан
868	129	2024-03-07	2024-03-08	отменён	завершён	1	5	Не указан
869	695	2024-03-07	2024-03-12	отменён	завершён	1	1	Не указан
870	469	2024-03-28	2024-03-29	отменён	новый	3	2	Не указан
871	586	2024-03-21	2024-03-25	оплачен	в обработке	14	10	Не указан
872	523	2024-03-28	2024-03-31	ожидание	отменён	14	7	Не указан
873	681	2024-03-29	2024-04-02	ожидание	в обработке	1	10	Не указан
874	859	2024-03-05	2024-03-07	оплачен	завершён	9	10	Не указан
875	905	2024-03-20	2024-03-23	отменён	в обработке	8	5	Не указан
876	646	2024-03-14	2024-03-16	оплачен	завершён	13	9	Не указан
877	127	2024-03-10	2024-03-15	оплачен	отменён	15	9	Не указан
878	523	2024-03-03	2024-03-06	ожидание	завершён	5	6	Не указан
879	917	2024-03-26	2024-03-31	отменён	завершён	11	8	Не указан
880	408	2024-03-27	2024-03-29	оплачен	завершён	10	9	Не указан
881	291	2024-03-22	2024-03-25	отменён	в обработке	2	8	Не указан
882	613	2024-03-15	2024-03-18	ожидание	отменён	9	1	Не указан
883	313	2024-03-08	2024-03-09	ожидание	завершён	4	10	Не указан
884	763	2024-03-23	2024-03-26	отменён	новый	14	10	Не указан
885	523	2024-03-25	2024-03-28	отменён	завершён	3	2	Не указан
886	304	2024-03-13	2024-03-14	оплачен	отменён	6	1	Не указан
887	909	2024-03-22	2024-03-27	ожидание	в обработке	14	9	Не указан
888	811	2024-03-11	2024-03-15	отменён	завершён	8	8	Не указан
889	424	2024-03-05	2024-03-08	ожидание	в обработке	15	6	Не указан
890	31	2024-03-07	2024-03-08	отменён	отменён	7	6	Не указан
891	50	2024-03-25	2024-03-29	ожидание	завершён	10	6	Не указан
892	340	2024-03-02	2024-03-07	ожидание	завершён	5	1	Не указан
893	828	2024-03-05	2024-03-10	ожидание	завершён	1	1	Не указан
894	450	2024-03-30	2024-04-03	ожидание	отменён	11	5	Не указан
895	994	2024-03-17	2024-03-18	отменён	в обработке	1	4	Не указан
896	367	2024-03-25	2024-03-30	отменён	новый	3	7	Не указан
897	768	2024-03-20	2024-03-25	отменён	новый	3	4	Не указан
898	560	2024-03-10	2024-03-13	ожидание	завершён	5	4	Не указан
899	133	2024-03-15	2024-03-20	ожидание	в обработке	10	4	Не указан
900	365	2024-03-10	2024-03-15	ожидание	новый	8	4	Не указан
901	546	2024-03-21	2024-03-26	ожидание	новый	4	1	Не указан
902	433	2024-03-09	2024-03-10	отменён	новый	10	7	Не указан
903	649	2024-03-25	2024-03-28	отменён	завершён	6	9	Не указан
904	397	2024-03-29	2024-04-01	ожидание	новый	3	6	Не указан
905	565	2024-03-20	2024-03-21	ожидание	новый	5	8	Не указан
906	38	2024-03-22	2024-03-24	отменён	в обработке	13	2	Не указан
907	833	2024-03-06	2024-03-07	ожидание	новый	13	9	Не указан
908	397	2024-03-19	2024-03-23	ожидание	в обработке	2	6	Не указан
909	783	2024-03-14	2024-03-17	отменён	новый	15	10	Не указан
910	644	2024-03-06	2024-03-10	ожидание	отменён	1	9	Не указан
911	467	2024-03-30	2024-04-03	отменён	отменён	4	4	Не указан
912	666	2024-03-22	2024-03-24	ожидание	отменён	12	6	Не указан
913	922	2024-03-14	2024-03-18	отменён	завершён	9	4	Не указан
914	516	2024-03-17	2024-03-18	оплачен	в обработке	8	10	Не указан
915	756	2024-03-23	2024-03-28	отменён	завершён	15	6	Не указан
916	614	2024-03-18	2024-03-23	ожидание	новый	14	5	Не указан
917	260	2024-03-25	2024-03-28	оплачен	новый	13	2	Не указан
918	235	2024-03-24	2024-03-26	ожидание	завершён	6	4	Не указан
919	592	2024-03-17	2024-03-21	отменён	завершён	7	10	Не указан
920	309	2024-03-09	2024-03-11	отменён	отменён	9	7	Не указан
921	865	2024-03-08	2024-03-12	отменён	новый	8	10	Не указан
922	827	2024-03-14	2024-03-17	ожидание	завершён	5	4	Не указан
923	626	2024-03-16	2024-03-20	оплачен	новый	14	5	Не указан
924	59	2024-03-24	2024-03-28	ожидание	завершён	6	6	Не указан
925	463	2024-03-06	2024-03-08	оплачен	отменён	2	8	Не указан
926	503	2024-03-25	2024-03-27	ожидание	в обработке	7	1	Не указан
927	443	2024-03-22	2024-03-26	оплачен	новый	1	6	Не указан
928	46	2024-03-25	2024-03-28	ожидание	завершён	4	1	Не указан
929	669	2024-03-12	2024-03-16	ожидание	новый	15	3	Не указан
930	392	2024-03-06	2024-03-09	отменён	в обработке	14	2	Не указан
931	581	2024-03-02	2024-03-03	ожидание	в обработке	4	9	Не указан
932	909	2024-03-29	2024-03-31	ожидание	завершён	5	4	Не указан
933	9	2024-03-16	2024-03-21	отменён	отменён	8	4	Не указан
934	782	2024-03-03	2024-03-08	ожидание	в обработке	6	4	Не указан
935	768	2024-03-25	2024-03-27	отменён	отменён	1	9	Не указан
936	222	2024-03-03	2024-03-07	отменён	завершён	8	5	Не указан
937	834	2024-03-07	2024-03-12	оплачен	завершён	12	5	Не указан
938	398	2024-03-04	2024-03-09	оплачен	отменён	15	6	Не указан
939	169	2024-03-18	2024-03-23	оплачен	в обработке	10	10	Не указан
940	878	2024-03-08	2024-03-11	ожидание	завершён	2	3	Не указан
941	724	2024-03-02	2024-03-04	оплачен	в обработке	8	7	Не указан
942	556	2024-03-18	2024-03-22	оплачен	отменён	14	8	Не указан
943	943	2024-03-07	2024-03-09	отменён	отменён	6	3	Не указан
944	268	2024-03-12	2024-03-13	оплачен	отменён	2	1	Не указан
945	404	2024-03-26	2024-03-29	ожидание	новый	10	2	Не указан
946	868	2024-03-06	2024-03-08	отменён	завершён	11	2	Не указан
947	648	2024-03-05	2024-03-09	оплачен	отменён	6	10	Не указан
948	449	2024-03-13	2024-03-17	отменён	завершён	11	2	Не указан
949	560	2024-03-23	2024-03-24	ожидание	новый	5	8	Не указан
950	215	2024-03-25	2024-03-30	ожидание	в обработке	14	5	Не указан
951	455	2024-03-20	2024-03-25	ожидание	новый	6	3	Не указан
952	600	2024-03-21	2024-03-25	отменён	завершён	5	10	Не указан
953	89	2024-03-28	2024-03-30	ожидание	завершён	6	9	Не указан
954	976	2024-03-08	2024-03-10	оплачен	новый	2	2	Не указан
955	875	2024-03-22	2024-03-25	оплачен	новый	3	6	Не указан
956	795	2024-03-20	2024-03-25	отменён	завершён	7	1	Не указан
957	438	2024-03-05	2024-03-10	отменён	в обработке	9	7	Не указан
958	871	2024-03-28	2024-04-02	оплачен	новый	3	8	Не указан
959	933	2024-03-17	2024-03-19	ожидание	новый	4	2	Не указан
960	819	2024-03-04	2024-03-08	оплачен	отменён	7	4	Не указан
961	257	2024-03-02	2024-03-06	оплачен	в обработке	12	5	Не указан
962	864	2024-03-02	2024-03-03	ожидание	отменён	5	3	Не указан
963	856	2024-03-29	2024-04-02	отменён	отменён	15	1	Не указан
964	199	2024-03-22	2024-03-26	отменён	в обработке	2	8	Не указан
965	130	2024-03-14	2024-03-16	отменён	новый	3	1	Не указан
966	412	2024-03-31	2024-04-05	оплачен	завершён	15	2	Не указан
967	87	2024-03-17	2024-03-18	отменён	отменён	8	2	Не указан
968	638	2024-03-17	2024-03-20	ожидание	завершён	9	8	Не указан
969	536	2024-03-01	2024-03-05	ожидание	новый	15	9	Не указан
970	305	2024-03-18	2024-03-19	оплачен	отменён	8	5	Не указан
971	939	2024-03-07	2024-03-08	отменён	отменён	9	1	Не указан
972	365	2024-03-13	2024-03-14	ожидание	в обработке	2	3	Не указан
973	725	2024-03-23	2024-03-25	ожидание	новый	1	5	Не указан
974	888	2024-03-28	2024-04-01	отменён	отменён	1	2	Не указан
975	665	2024-03-24	2024-03-25	оплачен	отменён	9	2	Не указан
976	15	2024-03-01	2024-03-06	ожидание	отменён	14	8	Не указан
977	866	2024-03-19	2024-03-23	ожидание	завершён	8	9	Не указан
978	961	2024-03-24	2024-03-28	ожидание	в обработке	4	5	Не указан
979	321	2024-03-07	2024-03-12	ожидание	в обработке	13	5	Не указан
980	972	2024-03-06	2024-03-07	оплачен	завершён	15	4	Не указан
981	783	2024-03-09	2024-03-13	ожидание	новый	12	8	Не указан
982	26	2024-03-21	2024-03-23	отменён	новый	10	4	Не указан
983	730	2024-03-05	2024-03-10	ожидание	новый	15	1	Не указан
984	696	2024-03-08	2024-03-09	ожидание	завершён	1	6	Не указан
985	862	2024-03-13	2024-03-16	отменён	новый	15	3	Не указан
986	937	2024-03-28	2024-04-02	оплачен	в обработке	13	9	Не указан
987	159	2024-03-10	2024-03-13	отменён	в обработке	4	8	Не указан
988	481	2024-03-17	2024-03-21	отменён	в обработке	11	6	Не указан
989	968	2024-03-16	2024-03-19	оплачен	завершён	10	5	Не указан
990	879	2024-03-08	2024-03-11	оплачен	в обработке	13	8	Не указан
991	218	2024-03-31	2024-04-01	отменён	в обработке	13	2	Не указан
992	103	2024-03-30	2024-04-04	ожидание	завершён	7	8	Не указан
993	160	2024-03-01	2024-03-02	оплачен	отменён	14	9	Не указан
994	483	2024-03-21	2024-03-25	ожидание	завершён	6	1	Не указан
995	465	2024-03-15	2024-03-20	ожидание	в обработке	14	8	Не указан
996	273	2024-03-23	2024-03-28	оплачен	в обработке	14	4	Не указан
997	436	2024-03-02	2024-03-06	ожидание	в обработке	10	7	Не указан
998	556	2024-03-08	2024-03-12	оплачен	отменён	3	3	Не указан
999	234	2024-03-23	2024-03-27	оплачен	новый	10	7	Не указан
1000	207	2024-03-07	2024-03-12	оплачен	новый	9	9	Не указан
\.


--
-- TOC entry 3712 (class 0 OID 16681)
-- Dependencies: 217
-- Data for Name: product; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product (product_id, manufacturer_id, product_name, stock_quantity, description) FROM stdin;
1	1	Картофель	5000	Мытый, урожай 2024 года, сорт "Гала"
2	2	Морковь	4000	Свежая, сорт "Нантская"
3	3	Свёкла	3500	Красная, крупная
4	4	Лук репчатый	3000	Жёлтый, острый
5	5	Чеснок	1500	Крупный зубок, в сетках
6	6	Капуста белокочанная	6000	Тугая, крупная
7	7	Капуста краснокочанная	2000	Фиолетовая
8	8	Капуста цветная	1200	Мелкие кочаны
9	1	Огурцы	2200	Гладкие, сорт "Зозуля"
10	2	Помидоры	1800	Сорт "Сливка"
11	3	Перец сладкий	1600	Жёлтый, красный
12	4	Редис	1400	Хрустящий, сорт "18 дней"
13	5	Зелёный лук	1300	Свежий, в пучках
14	6	Укроп	1000	Пучки по 100 г
15	7	Петрушка	1000	Кудрявая, пучками
16	8	Яблоки	5000	Сорт "Симиренко"
17	9	Груши	2500	Сорт "Конференция"
18	8	Сливы	2000	Фиолетовые, мягкие
19	1	Кабачки	3000	Светлые, молодые
20	2	Баклажаны	1800	Сорт "Блэк Бьюти"
21	3	Тыква	1000	Мускатная
22	4	Салат Айсберг	1200	Хрустящий, свежий
23	5	Брокколи	1300	Зелёные соцветия
24	6	Щавель	900	Свежий, в пучках
25	7	Шпинат	950	Молодые листья
26	8	Мангольд	870	Яркие листья
27	9	Лук-порей	1100	Мясистый стебель
28	8	Фасоль стручковая	1400	Замороженная
29	1	Горошек зелёный	1300	Консервированный
30	2	Кукуруза сладкая	1600	Консервированная
31	3	Морская капуста	800	Салатная
32	4	Клюква	700	Свежая, северная
33	5	Брусника	750	Собрана в лесу
34	6	Ежевика	950	Спелая
35	7	Малина	1100	Ароматная
36	8	Клубника	2000	Сорт "Виктория"
37	9	Черешня	1700	Крупная, сладкая
38	7	Вишня	1600	Кисло-сладкая
39	1	Абрикосы	1500	Мягкие, ароматные
40	2	Персики	1400	Сочные, бархатистые
41	3	Нектарины	1300	Гладкие, сладкие
42	4	Гранат	1200	Зернистый
43	5	Хурма	900	Без терпкости
44	6	Лимоны	1800	Крупные, жёлтые
45	7	Апельсины	2200	Сладкие, сочные
46	8	Мандарины	2100	Лёгко очищаются
47	9	Арбуз	3000	Без косточек
48	9	Дыня	2800	Сорт "Колхозница"
\.


--
-- TOC entry 3724 (class 0 OID 16770)
-- Dependencies: 229
-- Data for Name: supplier; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.supplier (supplier_id, company_name, address, city, country, tax_id) FROM stdin;
1	ИП "БиоПродукт-869"	ул. Товарная, д. 81	Новосибирск	Россия	8346207630
2	ИП "Урожай-649"	ул. Товарная, д. 97	Пермь	Россия	8166095684
3	ИП "Фермер-562"	ул. Складская, д. 29	Краснодар	Россия	1012640059
4	ЗАО "СнабжениеРегион-248"	ул. Складская, д. 5	Ростов-на-Дону	Россия	5351533961
5	ИП "ПродуктТрейд-869"	ул. Полевая, д. 92	Воронеж	Россия	4877520447
6	ООО "Поставкин-667"	ул. Полевая, д. 14	Краснодар	Россия	9504461711
7	ЗАО "ОвощМаркет-726"	ул. Лесная, д. 45	Пермь	Россия	5788501658
8	АО "ПродуктТрейд-721"	ул. Товарная, д. 62	Казань	Россия	5869469602
9	АО "БиоПродукт-137"	ул. Центральная, д. 85	Екатеринбург	Россия	3883338539
10	АО "Фермер-795"	ул. Полевая, д. 47	Москва	Россия	2712930234
11	ООО "ПродуктТрейд-214"	ул. Лесная, д. 62	Воронеж	Россия	1667052804
12	АО "Поставкин-608"	ул. Центральная, д. 35	Пермь	Россия	9966961012
13	АО "Оптовик-358"	ул. Товарная, д. 99	Воронеж	Россия	4428175325
14	ИП "Урожай-537"	ул. Складская, д. 37	Москва	Россия	3570602905
15	ООО "СнабжениеРегион-354"	ул. Полевая, д. 61	Москва	Россия	2119382655
16	ЗАО "Фермер-870"	ул. Товарная, д. 84	Пермь	Россия	3033354050
17	ЗАО "Фермер-977"	ул. Товарная, д. 78	Самара	Россия	8586953980
18	ООО "ФруктСнаб-904"	ул. Лесная, д. 23	Краснодар	Россия	2079621090
19	ИП "ПродуктТрейд-825"	ул. Товарная, д. 95	Москва	Россия	3898046005
20	АО "ПродуктТрейд-356"	ул. Центральная, д. 19	Воронеж	Россия	9008034453
21	АО "СнабжениеРегион-691"	ул. Полевая, д. 13	Ростов-на-Дону	Россия	9147750223
22	ЗАО "ФруктСнаб-886"	ул. Товарная, д. 41	Казань	Россия	1451283483
23	ЗАО "Оптовик-965"	ул. Складская, д. 15	Самара	Россия	1956908098
24	ИП "ФруктСнаб-989"	ул. Полевая, д. 3	Пермь	Россия	5025349462
25	ООО "Оптовик-706"	ул. Центральная, д. 81	Самара	Россия	5112296752
26	ООО "АгроСнаб-966"	ул. Лесная, д. 36	Москва	Россия	7704401905
27	ИП "Оптовик-756"	ул. Складская, д. 32	Самара	Россия	3062517984
28	ООО "Урожай-691"	ул. Полевая, д. 68	Казань	Россия	8059931272
29	АО "Оптовик-676"	ул. Лесная, д. 91	Пермь	Россия	9937907540
30	ЗАО "АгроСнаб-423"	ул. Складская, д. 86	Пермь	Россия	8992259747
31	ООО "ОвощМаркет-125"	ул. Товарная, д. 71	Санкт-Петербург	Россия	1832591151
32	ИП "СнабжениеРегион-162"	ул. Товарная, д. 66	Самара	Россия	9839041931
33	ЗАО "Урожай-149"	ул. Складская, д. 13	Краснодар	Россия	8093193154
34	АО "Фермер-996"	ул. Складская, д. 20	Москва	Россия	2218047125
35	ЗАО "Фермер-571"	ул. Центральная, д. 71	Пермь	Россия	5267311395
36	АО "СнабжениеРегион-937"	ул. Товарная, д. 3	Пермь	Россия	5736028158
37	АО "Оптовик-987"	ул. Полевая, д. 58	Ростов-на-Дону	Россия	9069833195
38	ЗАО "Поставкин-673"	ул. Товарная, д. 10	Санкт-Петербург	Россия	3168485669
39	ИП "ПродуктТрейд-354"	ул. Центральная, д. 34	Новосибирск	Россия	2101425630
40	АО "ОвощМаркет-243"	ул. Полевая, д. 40	Екатеринбург	Россия	3832576763
41	ООО "ФруктСнаб-766"	ул. Полевая, д. 56	Казань	Россия	8606472726
42	ЗАО "Фермер-103"	ул. Лесная, д. 53	Ростов-на-Дону	Россия	7535594988
43	ООО "БиоПродукт-766"	ул. Складская, д. 72	Краснодар	Россия	3086304422
44	ЗАО "Оптовик-853"	ул. Товарная, д. 88	Воронеж	Россия	8806986274
45	ООО "АгроСнаб-298"	ул. Центральная, д. 32	Санкт-Петербург	Россия	3330702793
46	ИП "ОвощМаркет-403"	ул. Полевая, д. 44	Новосибирск	Россия	9041894626
47	АО "ФруктСнаб-671"	ул. Полевая, д. 78	Екатеринбург	Россия	3776826727
48	ЗАО "ПродуктТрейд-180"	ул. Центральная, д. 42	Екатеринбург	Россия	5217874449
49	ИП "Поставкин-736"	ул. Складская, д. 65	Новосибирск	Россия	4020082219
50	ИП "ПродуктТрейд-981"	ул. Товарная, д. 26	Краснодар	Россия	4804906804
\.


--
-- TOC entry 3726 (class 0 OID 16781)
-- Dependencies: 231
-- Data for Name: supply; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.supply (supply_id, batch_number, processing_status, supply_date, branch_id, supplier_id) FROM stdin;
1	1000	завершена	2024-02-15	3	32
2	1001	отменена	2024-01-09	1	2
3	1002	отменена	2024-01-14	7	35
4	1003	в обработке	2024-01-30	2	11
5	1004	отменена	2024-01-05	1	32
6	1005	отменена	2024-03-22	4	35
7	1006	в обработке	2024-03-15	7	43
8	1007	в обработке	2024-01-09	10	33
9	1008	отменена	2024-03-31	6	14
10	1009	в обработке	2024-03-30	8	47
11	1010	отменена	2024-03-20	8	17
12	1011	отменена	2024-03-15	9	16
13	1012	отменена	2024-02-04	9	26
14	1013	отменена	2024-03-23	3	1
15	1014	завершена	2024-01-26	4	32
16	1015	в обработке	2024-02-18	5	33
17	1016	в обработке	2024-02-23	2	4
18	1017	отменена	2024-01-14	2	42
19	1018	в обработке	2024-03-18	6	21
20	1019	завершена	2024-01-14	5	45
21	1020	завершена	2024-02-22	2	28
22	1021	завершена	2024-02-08	8	31
23	1022	завершена	2024-03-20	9	6
24	1023	отменена	2024-03-03	10	27
25	1024	завершена	2024-03-09	5	32
26	1025	отменена	2024-01-21	7	30
27	1026	завершена	2024-01-05	2	31
28	1027	в обработке	2024-03-03	9	30
29	1028	завершена	2024-01-14	5	33
30	1029	в обработке	2024-02-06	8	34
31	1030	завершена	2024-03-26	10	16
32	1031	в обработке	2024-01-05	7	26
33	1032	в обработке	2024-02-20	8	27
34	1033	отменена	2024-02-29	7	29
35	1034	отменена	2024-01-14	3	2
36	1035	отменена	2024-03-01	9	27
37	1036	отменена	2024-03-08	9	14
38	1037	отменена	2024-01-17	5	17
39	1038	отменена	2024-02-04	8	36
40	1039	завершена	2024-01-04	8	50
41	1040	завершена	2024-01-30	9	10
42	1041	завершена	2024-01-23	5	50
43	1042	в обработке	2024-02-14	2	10
44	1043	в обработке	2024-02-12	6	14
45	1044	в обработке	2024-01-14	6	40
46	1045	отменена	2024-03-15	1	43
47	1046	отменена	2024-03-29	6	25
48	1047	завершена	2024-01-26	9	15
49	1048	отменена	2024-02-07	9	32
50	1049	отменена	2024-01-27	1	39
51	1050	отменена	2024-01-10	9	49
52	1051	завершена	2024-02-09	5	49
53	1052	завершена	2024-03-02	8	22
54	1053	отменена	2024-01-30	4	7
55	1054	в обработке	2024-02-20	8	25
56	1055	завершена	2024-01-15	7	25
57	1056	отменена	2024-01-22	7	5
58	1057	отменена	2024-03-24	3	24
59	1058	завершена	2024-03-22	1	28
60	1059	в обработке	2024-01-20	4	7
61	1060	в обработке	2024-01-05	7	16
62	1061	отменена	2024-01-08	9	37
63	1062	в обработке	2024-01-23	2	12
64	1063	завершена	2024-03-17	3	14
65	1064	отменена	2024-02-13	9	30
66	1065	отменена	2024-03-05	5	32
67	1066	в обработке	2024-01-04	8	35
68	1067	завершена	2024-01-28	7	27
69	1068	в обработке	2024-02-03	3	13
70	1069	завершена	2024-02-01	3	37
71	1070	завершена	2024-03-24	8	45
72	1071	в обработке	2024-03-18	9	27
73	1072	в обработке	2024-02-05	5	37
74	1073	в обработке	2024-02-09	10	8
75	1074	в обработке	2024-02-15	8	49
76	1075	отменена	2024-03-28	1	36
77	1076	отменена	2024-02-13	10	21
78	1077	в обработке	2024-02-29	8	28
79	1078	отменена	2024-03-08	5	10
80	1079	в обработке	2024-03-21	2	13
81	1080	завершена	2024-01-25	2	17
82	1081	завершена	2024-02-07	4	47
83	1082	завершена	2024-03-21	4	39
84	1083	в обработке	2024-03-05	8	47
85	1084	отменена	2024-02-07	9	33
86	1085	завершена	2024-01-01	3	19
87	1086	отменена	2024-03-21	9	8
88	1087	в обработке	2024-02-14	2	45
89	1088	отменена	2024-01-01	5	6
90	1089	завершена	2024-03-19	7	28
91	1090	завершена	2024-02-13	10	25
92	1091	завершена	2024-02-16	4	14
93	1092	в обработке	2024-01-07	8	26
94	1093	завершена	2024-02-02	9	17
95	1094	отменена	2024-01-31	1	22
96	1095	завершена	2024-02-14	2	28
97	1096	в обработке	2024-02-19	10	18
98	1097	отменена	2024-03-27	3	10
99	1098	завершена	2024-01-31	8	3
100	1099	в обработке	2024-01-05	1	27
101	1100	отменена	2024-01-10	7	35
102	1101	отменена	2024-01-25	7	30
103	1102	в обработке	2024-03-09	10	6
104	1103	в обработке	2024-01-09	10	3
105	1104	отменена	2024-02-23	9	17
106	1105	в обработке	2024-01-13	9	42
107	1106	завершена	2024-02-17	9	7
108	1107	отменена	2024-02-05	5	26
109	1108	в обработке	2024-03-16	4	39
110	1109	отменена	2024-01-25	1	18
111	1110	отменена	2024-02-21	4	36
112	1111	завершена	2024-03-23	4	48
113	1112	в обработке	2024-01-28	9	49
114	1113	в обработке	2024-02-15	3	35
115	1114	в обработке	2024-02-03	9	35
116	1115	завершена	2024-01-28	3	33
117	1116	завершена	2024-03-29	2	44
118	1117	завершена	2024-03-18	7	47
119	1118	в обработке	2024-01-22	9	7
120	1119	в обработке	2024-03-14	10	2
121	1120	отменена	2024-03-29	2	10
122	1121	отменена	2024-03-17	10	25
123	1122	завершена	2024-01-27	10	23
124	1123	отменена	2024-01-26	8	41
125	1124	отменена	2024-03-11	3	42
126	1125	в обработке	2024-03-02	2	39
127	1126	завершена	2024-01-19	9	47
128	1127	отменена	2024-01-16	9	41
129	1128	в обработке	2024-01-02	2	12
130	1129	отменена	2024-03-05	10	44
131	1130	отменена	2024-02-23	1	45
132	1131	отменена	2024-03-17	6	19
133	1132	отменена	2024-02-17	6	2
134	1133	в обработке	2024-01-17	7	5
135	1134	отменена	2024-03-14	1	43
136	1135	отменена	2024-01-22	7	10
137	1136	завершена	2024-01-09	7	18
138	1137	в обработке	2024-02-23	9	7
139	1138	отменена	2024-02-18	5	8
140	1139	завершена	2024-02-08	1	36
141	1140	завершена	2024-02-16	4	41
142	1141	отменена	2024-03-30	1	35
143	1142	отменена	2024-03-10	1	47
144	1143	в обработке	2024-01-13	6	43
145	1144	завершена	2024-03-15	9	43
146	1145	в обработке	2024-03-22	1	15
147	1146	завершена	2024-03-23	9	30
148	1147	отменена	2024-01-15	2	34
149	1148	завершена	2024-03-27	7	28
150	1149	отменена	2024-03-07	2	1
151	1150	завершена	2024-01-06	3	13
152	1151	в обработке	2024-03-22	10	43
153	1152	отменена	2024-01-08	1	29
154	1153	завершена	2024-02-03	5	28
155	1154	завершена	2024-01-01	4	37
156	1155	в обработке	2024-01-27	10	1
157	1156	в обработке	2024-03-21	10	7
158	1157	в обработке	2024-01-22	7	15
159	1158	в обработке	2024-01-06	4	18
160	1159	отменена	2024-03-20	3	46
161	1160	завершена	2024-02-02	4	25
162	1161	в обработке	2024-02-11	2	8
163	1162	отменена	2024-01-09	4	48
164	1163	завершена	2024-03-31	4	10
165	1164	завершена	2024-02-11	9	30
166	1165	отменена	2024-03-25	10	34
167	1166	завершена	2024-02-11	6	8
168	1167	в обработке	2024-03-02	7	24
169	1168	завершена	2024-01-31	2	1
170	1169	в обработке	2024-03-03	9	10
171	1170	отменена	2024-01-29	1	44
172	1171	завершена	2024-03-28	10	49
173	1172	завершена	2024-03-09	9	19
174	1173	отменена	2024-02-20	7	50
175	1174	завершена	2024-02-13	6	34
176	1175	в обработке	2024-01-22	1	47
177	1176	отменена	2024-01-24	2	35
178	1177	в обработке	2024-03-25	10	3
179	1178	отменена	2024-02-04	2	23
180	1179	завершена	2024-03-29	3	24
181	1180	отменена	2024-02-18	1	30
182	1181	отменена	2024-02-02	5	1
183	1182	отменена	2024-02-25	5	32
184	1183	в обработке	2024-03-14	7	10
185	1184	в обработке	2024-02-21	1	21
186	1185	завершена	2024-01-03	6	1
187	1186	отменена	2024-01-06	2	47
188	1187	в обработке	2024-02-01	9	46
189	1188	в обработке	2024-03-10	5	33
190	1189	в обработке	2024-03-05	9	26
191	1190	в обработке	2024-01-31	10	8
192	1191	отменена	2024-01-21	3	27
193	1192	завершена	2024-02-01	2	24
194	1193	завершена	2024-02-12	8	49
195	1194	отменена	2024-02-21	6	49
196	1195	отменена	2024-01-03	3	45
197	1196	в обработке	2024-02-10	5	35
198	1197	завершена	2024-03-07	5	9
199	1198	в обработке	2024-03-07	1	28
200	1199	в обработке	2024-03-02	6	5
201	1200	завершена	2024-02-12	3	19
202	1201	отменена	2024-01-24	2	37
203	1202	в обработке	2024-03-19	1	19
204	1203	отменена	2024-01-09	6	44
205	1204	в обработке	2024-01-09	4	4
206	1205	завершена	2024-03-15	8	17
207	1206	в обработке	2024-02-17	7	47
208	1207	завершена	2024-01-31	8	33
209	1208	завершена	2024-03-20	4	1
210	1209	в обработке	2024-02-11	6	5
211	1210	завершена	2024-02-29	7	3
212	1211	завершена	2024-03-02	10	39
213	1212	завершена	2024-01-16	4	10
214	1213	отменена	2024-03-16	5	20
215	1214	отменена	2024-03-25	1	3
216	1215	в обработке	2024-03-05	6	8
217	1216	завершена	2024-03-29	1	4
218	1217	отменена	2024-02-24	9	28
219	1218	отменена	2024-01-18	4	17
220	1219	завершена	2024-03-24	2	38
221	1220	завершена	2024-02-26	6	5
222	1221	отменена	2024-03-15	10	18
223	1222	завершена	2024-03-18	9	40
224	1223	в обработке	2024-02-12	1	26
225	1224	в обработке	2024-03-06	3	16
226	1225	завершена	2024-01-17	4	21
227	1226	отменена	2024-02-26	10	38
228	1227	завершена	2024-03-10	1	10
229	1228	завершена	2024-03-31	6	13
230	1229	в обработке	2024-02-26	6	40
347	1346	завершена	2024-02-10	8	49
231	1230	в обработке	2024-03-03	7	30
232	1231	в обработке	2024-03-01	3	8
233	1232	отменена	2024-02-14	4	49
234	1233	отменена	2024-03-27	7	32
235	1234	в обработке	2024-01-13	2	20
236	1235	завершена	2024-03-29	3	6
237	1236	завершена	2024-03-25	9	28
238	1237	в обработке	2024-02-06	9	32
239	1238	завершена	2024-02-04	10	6
240	1239	в обработке	2024-02-26	8	25
241	1240	отменена	2024-03-31	8	17
242	1241	завершена	2024-01-31	4	11
243	1242	в обработке	2024-01-12	1	28
244	1243	в обработке	2024-02-22	5	32
245	1244	завершена	2024-01-16	1	36
246	1245	в обработке	2024-01-03	10	34
247	1246	завершена	2024-01-22	4	31
248	1247	завершена	2024-01-28	4	28
249	1248	завершена	2024-03-06	10	7
250	1249	завершена	2024-03-14	7	9
251	1250	завершена	2024-01-13	6	6
252	1251	отменена	2024-01-24	7	24
253	1252	в обработке	2024-01-16	5	26
254	1253	в обработке	2024-01-27	10	6
255	1254	отменена	2024-01-26	6	22
256	1255	в обработке	2024-01-23	1	10
257	1256	завершена	2024-02-18	3	7
258	1257	отменена	2024-02-07	4	14
259	1258	завершена	2024-02-27	10	25
260	1259	в обработке	2024-03-05	7	27
261	1260	в обработке	2024-03-26	8	40
262	1261	завершена	2024-01-13	3	37
263	1262	отменена	2024-01-21	6	6
264	1263	завершена	2024-03-08	7	39
265	1264	в обработке	2024-02-28	3	38
266	1265	завершена	2024-02-03	8	31
267	1266	отменена	2024-01-30	10	46
268	1267	отменена	2024-02-08	9	43
269	1268	отменена	2024-02-02	10	33
270	1269	в обработке	2024-03-22	10	50
271	1270	отменена	2024-03-18	4	48
272	1271	завершена	2024-03-30	10	21
273	1272	отменена	2024-01-02	8	23
274	1273	отменена	2024-02-24	5	25
275	1274	завершена	2024-02-04	10	41
276	1275	отменена	2024-02-27	1	19
277	1276	завершена	2024-03-24	10	6
278	1277	отменена	2024-01-05	2	24
279	1278	отменена	2024-02-16	10	9
280	1279	завершена	2024-01-03	2	24
281	1280	отменена	2024-02-02	5	41
282	1281	завершена	2024-02-10	5	7
283	1282	в обработке	2024-01-24	2	29
284	1283	завершена	2024-01-18	9	11
285	1284	завершена	2024-01-12	6	33
286	1285	завершена	2024-01-05	2	22
287	1286	завершена	2024-02-07	4	6
288	1287	завершена	2024-02-24	9	5
289	1288	в обработке	2024-02-17	2	16
290	1289	в обработке	2024-02-16	9	32
291	1290	отменена	2024-03-23	2	29
292	1291	отменена	2024-02-08	5	39
293	1292	в обработке	2024-03-17	7	49
294	1293	завершена	2024-03-01	6	50
295	1294	завершена	2024-01-19	10	21
296	1295	отменена	2024-01-22	1	17
297	1296	завершена	2024-02-05	4	28
298	1297	завершена	2024-01-20	9	30
299	1298	в обработке	2024-03-19	2	46
300	1299	отменена	2024-01-12	5	28
301	1300	завершена	2024-01-04	8	39
302	1301	отменена	2024-03-24	3	47
303	1302	завершена	2024-01-05	9	30
304	1303	в обработке	2024-03-28	2	29
305	1304	в обработке	2024-03-31	6	34
306	1305	в обработке	2024-03-12	4	33
307	1306	завершена	2024-01-13	10	35
308	1307	завершена	2024-01-16	5	36
309	1308	завершена	2024-03-13	10	33
310	1309	в обработке	2024-01-15	1	4
311	1310	завершена	2024-03-14	1	27
312	1311	завершена	2024-03-03	5	7
313	1312	в обработке	2024-01-25	7	18
314	1313	завершена	2024-01-27	9	39
315	1314	отменена	2024-02-01	6	11
316	1315	завершена	2024-01-07	10	17
317	1316	завершена	2024-03-08	1	25
318	1317	отменена	2024-02-02	4	50
319	1318	завершена	2024-01-08	1	30
320	1319	завершена	2024-01-21	8	20
321	1320	в обработке	2024-02-26	3	24
322	1321	отменена	2024-02-13	7	32
323	1322	отменена	2024-03-18	10	31
324	1323	отменена	2024-01-28	4	11
325	1324	завершена	2024-02-19	1	43
326	1325	завершена	2024-03-04	10	42
327	1326	отменена	2024-01-27	6	43
328	1327	отменена	2024-02-20	9	38
329	1328	в обработке	2024-03-31	6	11
330	1329	в обработке	2024-03-27	8	24
331	1330	в обработке	2024-03-19	7	16
332	1331	отменена	2024-01-14	10	38
333	1332	завершена	2024-03-01	10	26
334	1333	в обработке	2024-03-11	10	31
335	1334	в обработке	2024-03-30	3	42
336	1335	в обработке	2024-01-22	10	38
337	1336	отменена	2024-03-26	4	22
338	1337	отменена	2024-03-12	1	46
339	1338	завершена	2024-02-23	3	48
340	1339	завершена	2024-03-19	7	32
341	1340	в обработке	2024-03-15	1	5
342	1341	завершена	2024-02-05	4	35
343	1342	отменена	2024-01-03	7	35
344	1343	в обработке	2024-01-31	8	29
345	1344	отменена	2024-03-01	1	25
346	1345	отменена	2024-01-15	2	31
348	1347	отменена	2024-02-08	9	3
349	1348	в обработке	2024-02-24	6	32
350	1349	завершена	2024-01-25	8	4
351	1350	отменена	2024-01-26	2	37
352	1351	отменена	2024-02-20	9	38
353	1352	в обработке	2024-03-05	1	12
354	1353	в обработке	2024-01-01	5	13
355	1354	в обработке	2024-01-04	9	27
356	1355	отменена	2024-02-26	10	12
357	1356	в обработке	2024-01-06	6	8
358	1357	завершена	2024-03-16	3	32
359	1358	отменена	2024-01-29	9	46
360	1359	в обработке	2024-01-29	9	50
361	1360	отменена	2024-03-16	2	47
362	1361	отменена	2024-02-14	1	20
363	1362	в обработке	2024-02-24	6	38
364	1363	отменена	2024-02-22	6	32
365	1364	отменена	2024-03-09	10	49
366	1365	отменена	2024-02-28	7	1
367	1366	в обработке	2024-03-29	5	29
368	1367	в обработке	2024-02-14	5	20
369	1368	завершена	2024-02-29	10	48
370	1369	отменена	2024-03-30	1	10
371	1370	в обработке	2024-02-22	1	37
372	1371	завершена	2024-01-07	9	41
373	1372	в обработке	2024-01-09	4	6
374	1373	завершена	2024-03-15	3	40
375	1374	завершена	2024-03-11	6	47
376	1375	завершена	2024-03-09	5	10
377	1376	отменена	2024-01-27	8	10
378	1377	отменена	2024-03-01	10	30
379	1378	отменена	2024-02-16	9	28
380	1379	в обработке	2024-02-29	1	21
381	1380	отменена	2024-01-23	10	5
382	1381	завершена	2024-03-16	7	32
383	1382	отменена	2024-02-11	1	2
384	1383	в обработке	2024-01-18	7	28
385	1384	отменена	2024-01-22	5	16
386	1385	отменена	2024-02-12	8	9
387	1386	в обработке	2024-02-28	3	37
388	1387	в обработке	2024-01-25	3	40
389	1388	отменена	2024-03-30	7	35
390	1389	отменена	2024-03-04	6	3
391	1390	отменена	2024-01-21	3	12
392	1391	завершена	2024-01-10	6	10
393	1392	завершена	2024-02-22	3	14
394	1393	завершена	2024-01-04	4	41
395	1394	отменена	2024-02-20	5	10
396	1395	завершена	2024-03-22	1	14
397	1396	завершена	2024-03-02	3	37
398	1397	в обработке	2024-02-29	6	36
399	1398	в обработке	2024-02-17	5	43
400	1399	отменена	2024-03-07	10	1
401	1400	отменена	2024-03-14	7	5
402	1401	завершена	2024-01-09	8	14
403	1402	завершена	2024-02-24	6	5
404	1403	в обработке	2024-01-01	9	26
405	1404	завершена	2024-01-03	2	25
406	1405	в обработке	2024-03-13	5	27
407	1406	в обработке	2024-02-29	10	13
408	1407	отменена	2024-01-25	8	13
409	1408	в обработке	2024-01-30	10	50
410	1409	в обработке	2024-02-25	7	47
411	1410	отменена	2024-01-27	8	30
412	1411	отменена	2024-01-22	7	42
413	1412	отменена	2024-02-29	9	3
414	1413	в обработке	2024-03-10	10	25
415	1414	отменена	2024-01-12	1	21
416	1415	отменена	2024-01-28	4	10
417	1416	завершена	2024-03-18	6	23
418	1417	завершена	2024-03-29	7	5
419	1418	завершена	2024-03-13	7	43
420	1419	в обработке	2024-03-16	8	26
421	1420	отменена	2024-02-24	5	17
422	1421	отменена	2024-01-16	1	9
423	1422	отменена	2024-03-12	6	41
424	1423	в обработке	2024-01-04	8	21
425	1424	отменена	2024-02-26	10	49
426	1425	отменена	2024-03-12	5	12
427	1426	завершена	2024-03-14	6	25
428	1427	отменена	2024-02-24	2	10
429	1428	в обработке	2024-03-10	5	43
430	1429	завершена	2024-01-06	5	49
431	1430	отменена	2024-01-25	1	22
432	1431	отменена	2024-02-15	3	6
433	1432	в обработке	2024-01-01	2	10
434	1433	отменена	2024-03-17	5	7
435	1434	завершена	2024-03-06	2	28
436	1435	завершена	2024-03-19	2	37
437	1436	отменена	2024-01-07	6	44
438	1437	завершена	2024-01-30	8	7
439	1438	в обработке	2024-01-23	7	24
440	1439	отменена	2024-01-28	7	33
441	1440	завершена	2024-03-04	4	1
442	1441	отменена	2024-02-12	1	28
443	1442	в обработке	2024-02-22	8	33
444	1443	отменена	2024-01-20	9	8
445	1444	завершена	2024-01-30	5	12
446	1445	отменена	2024-02-17	8	31
447	1446	завершена	2024-01-22	5	31
448	1447	завершена	2024-02-14	1	47
449	1448	завершена	2024-01-22	5	30
450	1449	отменена	2024-01-14	9	48
451	1450	в обработке	2024-02-24	2	31
452	1451	завершена	2024-03-27	2	43
453	1452	в обработке	2024-03-14	4	29
454	1453	в обработке	2024-03-25	6	42
455	1454	отменена	2024-02-25	8	21
456	1455	отменена	2024-02-20	9	16
457	1456	отменена	2024-01-27	2	14
458	1457	завершена	2024-03-03	5	20
459	1458	в обработке	2024-01-25	1	28
460	1459	завершена	2024-01-18	2	47
461	1460	отменена	2024-02-15	6	2
462	1461	завершена	2024-03-24	5	20
463	1462	завершена	2024-01-10	2	14
464	1463	в обработке	2024-01-13	6	23
465	1464	в обработке	2024-03-25	7	41
466	1465	отменена	2024-01-17	4	12
467	1466	отменена	2024-03-10	8	2
468	1467	в обработке	2024-01-12	10	10
469	1468	в обработке	2024-03-11	10	37
470	1469	отменена	2024-01-05	2	8
471	1470	в обработке	2024-02-16	5	21
472	1471	отменена	2024-03-05	2	36
473	1472	завершена	2024-01-30	6	50
474	1473	отменена	2024-02-05	5	18
475	1474	в обработке	2024-01-20	10	36
476	1475	в обработке	2024-02-21	2	12
477	1476	в обработке	2024-02-01	2	19
478	1477	в обработке	2024-01-14	8	35
479	1478	в обработке	2024-03-22	5	11
480	1479	отменена	2024-02-14	4	11
481	1480	отменена	2024-03-22	3	12
482	1481	завершена	2024-01-02	7	37
483	1482	отменена	2024-01-12	6	46
484	1483	в обработке	2024-02-18	6	8
485	1484	отменена	2024-01-01	3	46
486	1485	в обработке	2024-02-22	5	37
487	1486	в обработке	2024-01-27	6	26
488	1487	завершена	2024-01-26	7	21
489	1488	отменена	2024-02-25	5	45
490	1489	завершена	2024-01-26	5	46
491	1490	в обработке	2024-01-20	10	8
492	1491	в обработке	2024-03-03	5	4
493	1492	завершена	2024-01-30	3	13
494	1493	завершена	2024-03-22	7	35
495	1494	отменена	2024-01-23	3	5
496	1495	завершена	2024-03-15	7	25
497	1496	отменена	2024-02-27	2	42
498	1497	завершена	2024-02-08	10	32
499	1498	отменена	2024-02-25	10	41
500	1499	в обработке	2024-02-07	7	32
501	1500	завершена	2024-03-26	8	31
502	1501	отменена	2024-01-16	6	3
503	1502	завершена	2024-03-01	2	24
504	1503	в обработке	2024-03-09	5	46
505	1504	в обработке	2024-02-23	8	49
506	1505	отменена	2024-01-12	4	10
507	1506	в обработке	2024-03-20	5	28
508	1507	завершена	2024-01-17	1	20
509	1508	в обработке	2024-02-12	7	6
510	1509	отменена	2024-03-27	8	5
511	1510	в обработке	2024-03-27	9	26
512	1511	завершена	2024-02-21	2	16
513	1512	в обработке	2024-03-16	1	46
514	1513	в обработке	2024-02-06	6	19
515	1514	завершена	2024-02-05	8	40
516	1515	завершена	2024-02-19	1	16
517	1516	отменена	2024-03-26	7	2
518	1517	в обработке	2024-02-02	4	45
519	1518	отменена	2024-01-19	7	22
520	1519	в обработке	2024-03-15	5	16
521	1520	завершена	2024-03-25	9	22
522	1521	отменена	2024-01-25	4	48
523	1522	в обработке	2024-02-27	8	17
524	1523	завершена	2024-01-04	2	47
525	1524	в обработке	2024-03-12	10	26
526	1525	завершена	2024-03-24	2	21
527	1526	отменена	2024-02-16	2	46
528	1527	в обработке	2024-02-06	3	5
529	1528	завершена	2024-02-18	8	3
530	1529	в обработке	2024-03-03	10	43
531	1530	отменена	2024-01-19	4	38
532	1531	отменена	2024-02-08	6	10
533	1532	отменена	2024-01-07	3	49
534	1533	отменена	2024-02-10	2	46
535	1534	завершена	2024-02-17	9	25
536	1535	отменена	2024-01-09	2	6
537	1536	отменена	2024-02-26	5	9
538	1537	в обработке	2024-02-23	2	48
539	1538	отменена	2024-02-08	4	25
540	1539	в обработке	2024-03-14	4	1
541	1540	отменена	2024-01-03	10	39
542	1541	в обработке	2024-03-13	7	47
543	1542	в обработке	2024-02-08	9	29
544	1543	завершена	2024-02-15	3	49
545	1544	отменена	2024-02-08	7	29
546	1545	завершена	2024-03-02	9	47
547	1546	отменена	2024-01-30	5	31
548	1547	отменена	2024-03-20	3	13
549	1548	отменена	2024-01-11	10	26
550	1549	в обработке	2024-03-25	4	10
551	1550	в обработке	2024-01-19	4	28
552	1551	в обработке	2024-01-05	6	6
553	1552	в обработке	2024-01-05	9	10
554	1553	завершена	2024-02-05	6	4
555	1554	завершена	2024-02-11	3	4
556	1555	завершена	2024-03-05	9	43
557	1556	в обработке	2024-01-10	8	48
558	1557	отменена	2024-03-08	5	14
559	1558	завершена	2024-03-24	6	25
560	1559	завершена	2024-02-09	5	26
561	1560	отменена	2024-03-09	1	36
562	1561	завершена	2024-03-20	10	27
563	1562	завершена	2024-02-20	8	45
564	1563	завершена	2024-01-24	1	25
565	1564	отменена	2024-02-16	6	44
566	1565	завершена	2024-03-15	2	30
567	1566	завершена	2024-01-21	1	22
568	1567	отменена	2024-03-17	2	6
569	1568	в обработке	2024-01-14	10	36
570	1569	отменена	2024-03-23	5	43
571	1570	завершена	2024-03-11	5	13
572	1571	отменена	2024-01-13	7	25
573	1572	в обработке	2024-03-09	10	43
574	1573	в обработке	2024-03-22	8	46
575	1574	в обработке	2024-03-05	6	21
576	1575	завершена	2024-02-25	10	26
577	1576	в обработке	2024-03-01	3	12
578	1577	завершена	2024-01-09	8	3
579	1578	в обработке	2024-03-02	2	4
580	1579	отменена	2024-02-15	8	12
581	1580	завершена	2024-02-03	9	3
582	1581	в обработке	2024-01-02	1	13
583	1582	отменена	2024-02-26	2	35
584	1583	в обработке	2024-02-26	3	17
585	1584	завершена	2024-03-16	10	26
586	1585	отменена	2024-03-13	9	1
587	1586	завершена	2024-03-10	6	50
588	1587	в обработке	2024-02-07	3	13
589	1588	в обработке	2024-01-18	3	42
590	1589	отменена	2024-03-11	6	32
591	1590	завершена	2024-02-06	1	3
592	1591	отменена	2024-02-12	7	29
593	1592	отменена	2024-03-03	9	27
594	1593	отменена	2024-01-19	1	46
595	1594	отменена	2024-02-23	1	24
596	1595	отменена	2024-03-12	8	4
597	1596	отменена	2024-02-01	1	11
598	1597	отменена	2024-03-22	2	8
599	1598	в обработке	2024-02-06	10	12
600	1599	отменена	2024-03-03	3	8
601	1600	в обработке	2024-01-25	1	45
602	1601	в обработке	2024-03-08	9	47
603	1602	завершена	2024-03-15	1	18
604	1603	отменена	2024-01-01	5	35
605	1604	завершена	2024-03-04	5	18
606	1605	в обработке	2024-03-14	10	50
607	1606	в обработке	2024-03-31	9	39
608	1607	завершена	2024-01-31	3	16
609	1608	отменена	2024-02-16	7	24
610	1609	отменена	2024-03-17	5	37
611	1610	завершена	2024-02-21	6	9
612	1611	завершена	2024-02-22	6	30
613	1612	отменена	2024-01-15	10	34
614	1613	завершена	2024-01-09	2	47
615	1614	в обработке	2024-02-26	2	8
616	1615	отменена	2024-01-11	6	24
617	1616	отменена	2024-03-03	1	32
618	1617	отменена	2024-03-24	4	24
619	1618	в обработке	2024-01-23	8	12
620	1619	в обработке	2024-01-27	6	32
621	1620	завершена	2024-02-25	1	50
622	1621	завершена	2024-02-03	1	14
623	1622	отменена	2024-01-03	3	7
624	1623	в обработке	2024-02-27	9	12
625	1624	завершена	2024-02-19	10	8
626	1625	завершена	2024-03-24	6	48
627	1626	завершена	2024-01-07	7	15
628	1627	завершена	2024-03-23	2	41
629	1628	отменена	2024-02-15	10	25
630	1629	отменена	2024-02-21	1	43
631	1630	завершена	2024-01-10	7	39
632	1631	в обработке	2024-03-03	2	3
633	1632	завершена	2024-01-31	10	35
634	1633	завершена	2024-03-14	3	7
635	1634	в обработке	2024-03-24	2	44
636	1635	в обработке	2024-03-07	2	26
637	1636	отменена	2024-02-19	2	44
638	1637	отменена	2024-03-31	6	38
639	1638	завершена	2024-02-15	8	27
640	1639	отменена	2024-03-02	4	2
641	1640	отменена	2024-03-11	1	49
642	1641	в обработке	2024-02-02	3	12
643	1642	завершена	2024-02-18	8	1
644	1643	в обработке	2024-03-14	4	47
645	1644	отменена	2024-03-04	2	33
646	1645	в обработке	2024-01-12	9	39
647	1646	в обработке	2024-03-03	1	18
648	1647	завершена	2024-02-07	6	17
649	1648	завершена	2024-02-22	1	29
650	1649	отменена	2024-01-25	8	8
651	1650	отменена	2024-01-27	6	2
652	1651	отменена	2024-01-12	3	9
653	1652	в обработке	2024-01-08	5	20
654	1653	завершена	2024-03-01	3	42
655	1654	в обработке	2024-02-06	4	35
656	1655	отменена	2024-01-08	1	27
657	1656	завершена	2024-01-10	2	22
658	1657	отменена	2024-03-08	10	46
659	1658	в обработке	2024-01-12	10	10
660	1659	в обработке	2024-01-31	4	27
661	1660	отменена	2024-01-12	10	42
662	1661	в обработке	2024-03-01	4	44
663	1662	отменена	2024-01-30	2	30
664	1663	в обработке	2024-03-16	9	35
665	1664	завершена	2024-02-15	7	43
666	1665	отменена	2024-02-15	5	29
667	1666	завершена	2024-03-17	5	1
668	1667	в обработке	2024-01-02	6	32
669	1668	отменена	2024-03-30	10	29
670	1669	отменена	2024-02-03	1	5
671	1670	в обработке	2024-01-06	10	28
672	1671	отменена	2024-02-03	9	17
673	1672	отменена	2024-02-11	3	22
674	1673	завершена	2024-01-10	1	11
675	1674	завершена	2024-02-04	9	35
676	1675	завершена	2024-03-19	10	34
677	1676	в обработке	2024-01-19	5	14
678	1677	отменена	2024-02-29	7	41
679	1678	отменена	2024-03-08	5	35
680	1679	в обработке	2024-03-16	2	35
681	1680	в обработке	2024-03-06	1	19
682	1681	в обработке	2024-02-19	10	33
683	1682	в обработке	2024-02-27	8	45
684	1683	завершена	2024-03-04	3	26
685	1684	в обработке	2024-01-23	7	49
686	1685	в обработке	2024-02-02	2	39
687	1686	в обработке	2024-03-20	1	29
688	1687	отменена	2024-03-06	2	45
689	1688	завершена	2024-03-10	9	15
690	1689	в обработке	2024-03-30	1	30
691	1690	отменена	2024-02-04	8	50
692	1691	в обработке	2024-02-02	8	10
693	1692	завершена	2024-03-27	9	18
694	1693	завершена	2024-02-28	9	25
695	1694	завершена	2024-01-07	7	11
696	1695	отменена	2024-02-08	7	22
697	1696	завершена	2024-02-26	9	12
698	1697	завершена	2024-01-03	7	47
699	1698	отменена	2024-02-07	8	22
700	1699	отменена	2024-03-17	6	22
701	1700	отменена	2024-01-05	4	28
702	1701	в обработке	2024-01-12	4	19
703	1702	завершена	2024-03-04	3	47
704	1703	в обработке	2024-01-11	7	28
705	1704	завершена	2024-02-26	9	13
706	1705	отменена	2024-02-22	8	14
707	1706	отменена	2024-02-05	3	17
708	1707	завершена	2024-03-03	3	43
709	1708	завершена	2024-01-06	8	34
710	1709	отменена	2024-03-22	2	28
711	1710	завершена	2024-03-25	5	9
712	1711	отменена	2024-02-26	3	44
713	1712	завершена	2024-01-10	7	30
714	1713	завершена	2024-01-16	4	26
715	1714	в обработке	2024-01-25	10	37
716	1715	завершена	2024-03-03	4	1
717	1716	отменена	2024-01-02	1	4
718	1717	завершена	2024-03-13	5	9
719	1718	в обработке	2024-01-26	6	4
720	1719	в обработке	2024-02-13	10	38
721	1720	отменена	2024-03-07	2	49
722	1721	в обработке	2024-02-02	2	22
723	1722	завершена	2024-02-08	3	35
724	1723	в обработке	2024-03-09	7	24
725	1724	в обработке	2024-02-03	2	7
726	1725	завершена	2024-03-07	3	44
727	1726	завершена	2024-01-26	10	25
728	1727	завершена	2024-03-25	2	33
729	1728	отменена	2024-03-14	10	35
730	1729	отменена	2024-03-17	9	26
731	1730	в обработке	2024-01-08	10	50
732	1731	отменена	2024-02-12	4	16
733	1732	отменена	2024-02-08	8	1
734	1733	в обработке	2024-02-25	1	44
735	1734	отменена	2024-02-15	9	7
736	1735	в обработке	2024-02-25	7	30
737	1736	в обработке	2024-03-11	5	1
738	1737	завершена	2024-02-02	10	7
739	1738	отменена	2024-03-22	1	41
740	1739	в обработке	2024-03-23	8	29
741	1740	отменена	2024-03-14	5	30
742	1741	в обработке	2024-01-06	6	31
743	1742	в обработке	2024-01-12	3	15
744	1743	завершена	2024-01-08	8	41
745	1744	в обработке	2024-02-08	10	5
746	1745	завершена	2024-01-25	6	31
747	1746	завершена	2024-02-18	10	44
748	1747	отменена	2024-02-24	1	16
749	1748	в обработке	2024-02-01	5	42
750	1749	в обработке	2024-03-10	8	18
751	1750	завершена	2024-02-15	5	32
752	1751	в обработке	2024-01-19	8	3
753	1752	отменена	2024-03-14	9	35
754	1753	отменена	2024-01-02	3	22
755	1754	отменена	2024-02-07	9	7
756	1755	отменена	2024-03-06	8	30
757	1756	в обработке	2024-03-19	3	39
758	1757	завершена	2024-01-09	9	44
759	1758	в обработке	2024-03-24	2	28
760	1759	в обработке	2024-01-24	3	9
761	1760	завершена	2024-02-25	5	20
762	1761	отменена	2024-03-19	6	17
763	1762	в обработке	2024-03-29	8	10
764	1763	отменена	2024-01-17	1	9
765	1764	завершена	2024-02-27	10	40
766	1765	отменена	2024-02-14	9	11
767	1766	в обработке	2024-01-25	5	9
768	1767	в обработке	2024-03-01	6	23
769	1768	отменена	2024-01-02	1	31
770	1769	отменена	2024-02-21	8	9
771	1770	отменена	2024-02-27	3	7
772	1771	отменена	2024-03-22	1	29
773	1772	завершена	2024-03-04	2	24
774	1773	в обработке	2024-02-10	5	28
775	1774	в обработке	2024-03-15	2	7
776	1775	завершена	2024-03-04	5	35
777	1776	в обработке	2024-02-14	9	3
778	1777	завершена	2024-02-22	1	43
779	1778	завершена	2024-03-12	7	15
780	1779	завершена	2024-02-06	8	37
781	1780	отменена	2024-03-23	9	24
782	1781	завершена	2024-02-10	5	44
783	1782	отменена	2024-01-18	2	3
784	1783	отменена	2024-03-12	10	35
785	1784	отменена	2024-01-22	1	9
786	1785	завершена	2024-03-16	10	46
787	1786	отменена	2024-02-29	9	18
788	1787	в обработке	2024-03-09	9	36
789	1788	завершена	2024-02-12	8	18
790	1789	отменена	2024-03-05	4	16
791	1790	завершена	2024-03-17	2	40
792	1791	завершена	2024-03-10	2	34
793	1792	завершена	2024-01-04	5	33
794	1793	в обработке	2024-02-20	8	4
795	1794	отменена	2024-03-07	1	26
796	1795	отменена	2024-02-28	2	50
797	1796	отменена	2024-02-21	7	45
798	1797	в обработке	2024-02-13	3	33
799	1798	в обработке	2024-01-02	5	14
800	1799	завершена	2024-03-18	3	45
801	1800	в обработке	2024-01-22	4	13
802	1801	в обработке	2024-02-04	8	43
803	1802	в обработке	2024-03-28	8	46
804	1803	завершена	2024-03-07	8	28
805	1804	в обработке	2024-01-06	2	12
806	1805	в обработке	2024-01-16	6	19
807	1806	завершена	2024-01-01	6	28
808	1807	завершена	2024-02-11	9	34
809	1808	завершена	2024-03-22	5	15
810	1809	в обработке	2024-03-04	9	36
811	1810	завершена	2024-03-24	9	19
812	1811	отменена	2024-02-07	4	29
813	1812	в обработке	2024-03-31	9	37
814	1813	в обработке	2024-01-10	9	34
815	1814	завершена	2024-02-06	7	23
816	1815	завершена	2024-02-07	2	50
817	1816	отменена	2024-03-22	3	23
818	1817	в обработке	2024-02-01	9	2
819	1818	в обработке	2024-03-11	8	48
820	1819	в обработке	2024-03-04	7	41
821	1820	завершена	2024-03-30	9	18
822	1821	отменена	2024-01-25	10	13
823	1822	завершена	2024-01-01	5	30
824	1823	отменена	2024-02-01	6	16
825	1824	отменена	2024-01-13	4	6
826	1825	в обработке	2024-02-01	3	21
827	1826	в обработке	2024-03-18	6	8
828	1827	завершена	2024-01-04	2	2
829	1828	завершена	2024-03-20	3	35
830	1829	завершена	2024-03-16	3	27
831	1830	отменена	2024-01-06	8	9
832	1831	завершена	2024-03-18	2	8
833	1832	завершена	2024-02-18	4	35
834	1833	завершена	2024-01-02	2	30
835	1834	отменена	2024-01-26	7	8
836	1835	в обработке	2024-01-01	7	23
837	1836	завершена	2024-03-08	4	24
838	1837	завершена	2024-01-26	4	11
839	1838	отменена	2024-02-26	1	9
840	1839	отменена	2024-03-05	1	18
841	1840	завершена	2024-01-15	8	14
842	1841	завершена	2024-02-17	8	6
843	1842	в обработке	2024-03-24	7	28
844	1843	в обработке	2024-03-27	9	1
845	1844	в обработке	2024-03-22	10	5
846	1845	в обработке	2024-03-24	10	14
847	1846	отменена	2024-01-30	4	2
848	1847	отменена	2024-03-02	4	5
849	1848	в обработке	2024-02-09	4	7
850	1849	завершена	2024-02-14	7	25
851	1850	завершена	2024-01-27	2	1
852	1851	завершена	2024-03-26	5	8
853	1852	завершена	2024-02-06	5	4
854	1853	отменена	2024-01-09	9	31
855	1854	завершена	2024-01-29	7	24
856	1855	в обработке	2024-02-28	10	12
857	1856	отменена	2024-02-09	6	11
858	1857	в обработке	2024-02-14	9	27
859	1858	в обработке	2024-02-24	7	30
860	1859	в обработке	2024-03-20	10	18
861	1860	в обработке	2024-03-23	1	26
862	1861	в обработке	2024-03-09	8	49
863	1862	завершена	2024-01-08	4	19
864	1863	отменена	2024-02-09	5	43
865	1864	в обработке	2024-01-07	2	34
866	1865	в обработке	2024-02-01	3	36
867	1866	завершена	2024-01-25	10	26
868	1867	отменена	2024-02-28	6	8
869	1868	отменена	2024-03-29	6	32
870	1869	в обработке	2024-02-18	3	24
871	1870	в обработке	2024-01-25	1	36
872	1871	завершена	2024-02-03	6	50
873	1872	в обработке	2024-02-10	6	17
874	1873	завершена	2024-02-29	10	12
875	1874	отменена	2024-02-24	4	14
876	1875	отменена	2024-01-26	7	4
877	1876	завершена	2024-01-30	5	27
878	1877	в обработке	2024-03-01	4	38
879	1878	отменена	2024-01-26	2	18
880	1879	в обработке	2024-03-17	10	48
881	1880	в обработке	2024-01-15	9	8
882	1881	отменена	2024-01-28	9	18
883	1882	в обработке	2024-03-05	3	36
884	1883	в обработке	2024-03-09	4	13
885	1884	в обработке	2024-03-04	5	38
886	1885	завершена	2024-01-06	7	48
887	1886	отменена	2024-03-29	2	50
888	1887	завершена	2024-02-13	8	1
889	1888	отменена	2024-02-21	5	28
890	1889	завершена	2024-02-01	7	41
891	1890	в обработке	2024-01-07	9	48
892	1891	отменена	2024-03-11	4	45
893	1892	в обработке	2024-01-24	3	15
894	1893	завершена	2024-02-09	3	35
895	1894	завершена	2024-01-14	4	21
896	1895	в обработке	2024-01-19	2	40
897	1896	отменена	2024-03-26	5	29
898	1897	отменена	2024-01-18	9	28
899	1898	в обработке	2024-02-29	8	50
900	1899	в обработке	2024-02-26	2	8
901	1900	в обработке	2024-02-09	1	24
902	1901	отменена	2024-01-09	10	48
903	1902	завершена	2024-01-17	7	6
904	1903	в обработке	2024-03-30	8	19
905	1904	отменена	2024-03-28	6	44
906	1905	завершена	2024-01-18	4	17
907	1906	завершена	2024-02-22	9	47
908	1907	завершена	2024-03-12	8	14
909	1908	отменена	2024-03-12	5	40
910	1909	завершена	2024-01-20	6	5
911	1910	завершена	2024-02-20	1	43
912	1911	завершена	2024-02-18	2	45
913	1912	отменена	2024-01-23	2	29
914	1913	завершена	2024-01-12	7	40
915	1914	отменена	2024-03-29	1	36
916	1915	в обработке	2024-01-18	4	24
917	1916	завершена	2024-03-08	2	21
918	1917	отменена	2024-01-25	5	34
919	1918	в обработке	2024-01-09	3	23
920	1919	завершена	2024-03-07	1	11
921	1920	отменена	2024-02-13	7	8
922	1921	в обработке	2024-03-22	10	17
923	1922	завершена	2024-03-03	6	8
924	1923	отменена	2024-03-02	6	16
925	1924	завершена	2024-03-14	5	20
926	1925	завершена	2024-03-16	9	46
927	1926	отменена	2024-01-14	2	6
928	1927	завершена	2024-02-20	4	50
929	1928	отменена	2024-01-20	3	18
930	1929	завершена	2024-02-17	1	47
931	1930	в обработке	2024-01-27	7	28
932	1931	отменена	2024-03-26	7	43
933	1932	отменена	2024-03-30	3	15
934	1933	завершена	2024-01-23	5	40
935	1934	завершена	2024-02-18	9	18
936	1935	в обработке	2024-01-30	4	31
937	1936	завершена	2024-02-04	8	46
938	1937	отменена	2024-01-03	4	21
939	1938	отменена	2024-03-21	7	22
940	1939	завершена	2024-03-26	3	13
941	1940	завершена	2024-01-12	4	42
942	1941	отменена	2024-02-05	4	13
943	1942	завершена	2024-03-22	4	9
944	1943	в обработке	2024-03-07	8	43
945	1944	отменена	2024-01-28	2	43
946	1945	отменена	2024-01-16	4	38
947	1946	отменена	2024-03-22	3	21
948	1947	завершена	2024-01-10	5	2
949	1948	завершена	2024-02-12	8	40
950	1949	отменена	2024-02-05	8	35
951	1950	в обработке	2024-03-17	10	36
952	1951	в обработке	2024-01-20	5	13
953	1952	завершена	2024-01-20	6	25
954	1953	отменена	2024-01-20	5	36
955	1954	завершена	2024-03-07	1	48
956	1955	в обработке	2024-03-21	3	44
957	1956	в обработке	2024-02-24	4	50
958	1957	завершена	2024-02-14	6	25
959	1958	отменена	2024-01-24	5	10
960	1959	в обработке	2024-03-27	4	36
961	1960	завершена	2024-01-30	4	33
962	1961	в обработке	2024-01-24	9	38
963	1962	отменена	2024-01-30	8	36
964	1963	завершена	2024-01-20	4	14
965	1964	в обработке	2024-02-03	8	44
966	1965	в обработке	2024-03-01	4	44
967	1966	отменена	2024-01-14	6	48
968	1967	завершена	2024-01-31	7	25
969	1968	отменена	2024-01-18	4	35
970	1969	завершена	2024-01-28	1	11
971	1970	в обработке	2024-03-10	1	1
972	1971	отменена	2024-01-24	5	47
973	1972	завершена	2024-03-14	10	37
974	1973	отменена	2024-02-28	6	10
975	1974	завершена	2024-03-22	8	13
976	1975	отменена	2024-02-27	3	36
977	1976	завершена	2024-03-29	9	45
978	1977	в обработке	2024-01-09	2	29
979	1978	завершена	2024-02-10	6	22
980	1979	завершена	2024-03-17	4	21
981	1980	в обработке	2024-01-03	2	7
982	1981	завершена	2024-03-22	2	32
983	1982	отменена	2024-02-02	2	34
984	1983	в обработке	2024-01-08	4	12
985	1984	отменена	2024-02-24	7	26
986	1985	в обработке	2024-03-20	9	41
987	1986	отменена	2024-01-31	4	36
988	1987	в обработке	2024-02-22	2	12
989	1988	в обработке	2024-01-04	2	33
990	1989	отменена	2024-02-09	2	13
991	1990	в обработке	2024-02-23	7	18
992	1991	завершена	2024-03-11	9	37
993	1992	отменена	2024-03-08	2	29
994	1993	отменена	2024-02-20	6	40
995	1994	отменена	2024-03-05	1	29
996	1995	завершена	2024-02-03	8	41
997	1996	в обработке	2024-02-09	6	20
998	1997	завершена	2024-02-03	7	38
999	1998	отменена	2024-01-08	9	28
1000	1999	отменена	2024-01-01	6	39
\.


--
-- TOC entry 3728 (class 0 OID 16812)
-- Dependencies: 233
-- Data for Name: supply_details; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.supply_details (supply_details_id, product_id, supply_id, delivery_price, quantity, remaining_quantity, unit_measure, weight_per_unit, expiration_date, unit_price, comments) FROM stdin;
1	29	1	17	68	56	тонна	7	2024-06-26	27	
2	29	1	57	247	212	упаковка	3	2024-10-25	75	
3	41	2	35	214	126	упаковка	8	2024-09-06	46	Органик
4	43	2	24	317	145	ящик	5	2024-08-18	25	
5	14	3	83	276	123	кг	4	2024-07-19	101	
6	37	3	61	309	129	тонна	7	2024-09-17	80	
7	21	3	22	255	5	тонна	2	2024-07-18	25	Без ГМО
8	22	4	76	89	17	упаковка	4	2024-08-30	94	Хранить в прохладном месте
9	44	4	65	400	218	упаковка	3	2024-11-23	71	Хранить в прохладном месте
10	35	4	22	429	124	тонна	10	2024-07-15	36	Органик
11	28	5	18	199	81	кг	1	2024-09-20	22	Хранить в прохладном месте
12	8	5	89	89	22	кг	3	2024-10-26	97	
13	8	6	79	70	15	ящик	3	2024-06-04	88	Органик
14	46	6	73	397	142	ящик	3	2024-09-28	87	Хранить в прохладном месте
15	2	7	34	416	138	кг	5	2024-07-30	37	Органик
16	23	7	74	499	415	ящик	3	2024-06-10	84	
17	16	8	28	49	44	ящик	1	2024-07-22	33	
18	39	8	98	428	328	упаковка	2	2024-07-03	108	Хранить в прохладном месте
19	41	8	64	192	60	тонна	1	2024-09-28	70	
20	46	8	55	119	117	упаковка	1	2024-09-23	60	
21	47	9	91	26	0	кг	8	2024-09-13	95	
22	2	9	55	245	191	кг	9	2024-08-20	71	Хранить в прохладном месте
23	12	9	65	376	109	упаковка	4	2024-06-10	69	Органик
24	17	10	19	438	264	тонна	9	2024-08-31	24	
25	45	10	72	178	122	упаковка	3	2024-10-08	78	
26	41	11	75	388	122	кг	3	2024-08-16	78	Хранить в прохладном месте
27	33	11	15	49	9	кг	4	2024-11-09	26	
28	5	11	68	366	148	тонна	1	2024-07-17	72	
29	41	11	10	168	163	кг	5	2024-11-03	19	Хранить в прохладном месте
30	46	12	27	396	9	упаковка	5	2024-10-04	33	
31	48	12	68	185	78	упаковка	2	2024-07-12	79	Органик
32	15	13	97	264	90	кг	6	2024-06-02	98	Хранить в прохладном месте
33	4	13	96	10	7	упаковка	3	2024-09-11	115	Органик
34	47	13	78	145	133	упаковка	4	2024-07-02	84	Хранить в прохладном месте
35	25	13	64	399	59	ящик	9	2024-09-05	78	
36	32	14	79	480	453	кг	9	2024-11-13	94	Без ГМО
37	47	14	97	106	59	упаковка	1	2024-11-14	107	Органик
38	1	14	57	411	302	упаковка	9	2024-09-05	59	Органик
39	33	15	58	273	42	кг	4	2024-09-05	68	
40	2	15	51	487	312	кг	5	2024-11-15	59	Хранить в прохладном месте
41	4	15	82	333	190	кг	3	2024-09-09	93	Хранить в прохладном месте
42	21	15	94	405	336	тонна	7	2024-09-02	110	
43	29	16	59	258	6	упаковка	5	2024-11-18	60	
44	45	16	25	72	63	кг	7	2024-07-06	33	Хранить в прохладном месте
45	18	16	21	496	158	тонна	8	2024-06-09	34	Без ГМО
46	18	16	29	412	228	упаковка	4	2024-09-25	46	
47	34	17	14	96	83	ящик	8	2024-09-01	20	
48	37	17	66	261	86	кг	10	2024-07-29	80	Без ГМО
49	24	17	64	54	7	упаковка	3	2024-08-22	76	
50	13	17	87	155	52	кг	8	2024-07-19	90	
51	22	18	54	147	24	тонна	8	2024-07-07	56	Без ГМО
52	47	18	33	394	272	тонна	2	2024-09-02	44	Без ГМО
53	43	18	38	302	121	ящик	6	2024-08-21	53	Без ГМО
54	40	19	75	86	51	упаковка	7	2024-07-15	89	Хранить в прохладном месте
55	33	19	16	480	138	упаковка	2	2024-10-28	34	Органик
56	47	19	86	26	19	кг	6	2024-06-20	87	Органик
57	4	20	44	318	53	кг	3	2024-07-01	59	
58	20	20	78	391	136	кг	10	2024-07-30	82	
59	45	20	35	310	9	тонна	2	2024-09-13	40	Хранить в прохладном месте
60	43	21	72	190	89	кг	7	2024-09-18	84	
61	40	21	39	459	442	ящик	9	2024-09-07	57	Хранить в прохладном месте
62	45	21	98	169	120	упаковка	2	2024-06-11	100	Органик
63	7	22	100	135	18	тонна	1	2024-10-31	113	
64	7	22	76	39	21	кг	9	2024-07-11	89	
65	20	22	54	238	192	кг	10	2024-07-25	68	
66	14	22	86	398	31	ящик	1	2024-10-13	95	Хранить в прохладном месте
67	22	23	91	432	190	ящик	3	2024-08-05	111	Органик
68	24	23	50	287	81	упаковка	10	2024-06-13	52	
69	22	23	44	152	20	ящик	8	2024-09-12	52	
70	5	24	34	274	108	тонна	2	2024-09-18	50	Хранить в прохладном месте
71	10	24	51	353	339	тонна	8	2024-09-07	65	Органик
72	21	25	52	459	374	тонна	2	2024-06-20	66	Без ГМО
73	33	25	24	222	194	ящик	9	2024-08-10	37	Хранить в прохладном месте
74	42	25	32	163	122	тонна	2	2024-06-05	48	
75	2	26	71	369	94	ящик	1	2024-09-27	87	
76	26	26	18	484	47	кг	9	2024-11-28	21	Органик
77	42	26	68	103	45	тонна	10	2024-08-04	88	Органик
78	22	27	20	165	74	тонна	7	2024-10-17	29	Без ГМО
79	38	27	52	63	38	тонна	3	2024-11-16	59	
80	23	27	10	63	19	упаковка	10	2024-09-17	20	Без ГМО
81	41	27	82	129	71	тонна	1	2024-08-22	97	
82	11	28	74	301	291	упаковка	4	2024-06-17	75	Хранить в прохладном месте
83	34	28	36	346	171	тонна	5	2024-08-11	45	
84	16	28	36	423	316	ящик	1	2024-10-23	54	
85	46	28	49	41	14	кг	3	2024-06-02	65	
86	23	29	13	236	77	упаковка	4	2024-11-25	30	Органик
87	34	29	52	495	279	ящик	5	2024-07-09	63	Без ГМО
88	16	29	25	417	12	упаковка	7	2024-06-11	35	
89	45	30	20	37	20	кг	9	2024-07-20	31	Хранить в прохладном месте
90	25	30	95	80	70	кг	9	2024-06-05	113	
91	12	30	23	194	8	кг	9	2024-11-20	41	Без ГМО
92	18	31	31	145	107	тонна	6	2024-11-18	51	Органик
93	31	31	40	239	235	тонна	4	2024-09-24	59	
94	26	31	18	462	312	упаковка	9	2024-10-10	19	Без ГМО
95	33	31	47	493	374	кг	6	2024-08-14	64	Органик
96	2	32	76	103	6	ящик	8	2024-06-15	83	
97	3	32	25	47	37	кг	8	2024-09-05	44	Без ГМО
98	12	32	92	486	296	кг	6	2024-09-06	109	Хранить в прохладном месте
99	34	32	34	198	165	ящик	4	2024-07-19	47	Без ГМО
100	26	33	85	196	128	ящик	4	2024-06-06	91	Хранить в прохладном месте
101	47	33	53	339	256	тонна	3	2024-11-11	58	
102	16	33	68	460	36	кг	2	2024-07-14	75	
103	7	33	74	471	173	тонна	8	2024-10-12	83	
104	22	34	75	158	108	тонна	4	2024-06-25	92	Хранить в прохладном месте
105	23	34	59	356	237	ящик	4	2024-11-06	69	Без ГМО
106	27	35	55	280	143	тонна	3	2024-06-12	59	Органик
107	10	35	34	36	7	ящик	8	2024-10-26	49	Органик
108	44	35	47	298	298	тонна	8	2024-08-01	65	
109	21	35	31	125	23	ящик	1	2024-11-21	49	Органик
110	42	36	60	270	38	ящик	8	2024-11-16	67	Без ГМО
111	26	36	60	132	54	тонна	4	2024-09-02	64	
112	35	36	90	193	57	тонна	1	2024-07-08	110	Хранить в прохладном месте
113	30	37	98	448	436	ящик	4	2024-11-08	106	
114	20	37	49	372	218	тонна	5	2024-09-20	63	Органик
115	8	37	27	450	216	упаковка	9	2024-08-26	36	
116	39	38	74	192	109	ящик	7	2024-08-02	89	Хранить в прохладном месте
117	47	38	96	112	31	тонна	5	2024-09-12	104	
118	46	39	55	220	100	кг	7	2024-09-25	64	Органик
119	24	39	67	42	35	ящик	5	2024-10-29	80	Без ГМО
120	13	40	76	272	270	кг	9	2024-06-12	93	Без ГМО
121	11	40	34	443	348	тонна	1	2024-10-15	51	Без ГМО
122	21	40	84	411	375	кг	10	2024-10-08	104	
123	39	41	71	335	208	тонна	2	2024-11-27	87	
124	14	41	16	197	7	кг	4	2024-09-13	32	Хранить в прохладном месте
125	5	41	80	345	335	ящик	10	2024-07-24	85	Органик
126	30	41	14	161	117	ящик	5	2024-07-14	32	
127	45	42	95	180	42	кг	6	2024-10-26	115	Органик
128	23	42	66	340	178	упаковка	3	2024-08-27	69	Органик
129	14	42	41	375	270	ящик	9	2024-08-27	47	Органик
130	8	42	13	346	33	ящик	9	2024-09-24	19	Без ГМО
131	7	43	99	17	2	тонна	3	2024-10-25	113	
132	4	43	19	341	197	тонна	4	2024-09-21	27	Хранить в прохладном месте
133	37	43	79	205	200	кг	10	2024-09-21	97	Хранить в прохладном месте
134	47	44	42	180	59	кг	5	2024-09-10	43	Без ГМО
135	7	44	57	28	23	упаковка	2	2024-10-20	61	
136	35	45	82	113	72	упаковка	8	2024-10-26	84	Без ГМО
137	12	45	58	273	114	тонна	4	2024-08-20	71	
138	37	45	49	438	362	кг	6	2024-06-05	65	Органик
139	19	45	76	200	44	кг	6	2024-10-18	90	
140	19	46	73	211	59	упаковка	3	2024-09-15	81	
141	29	46	41	19	10	кг	10	2024-08-07	46	Без ГМО
142	22	46	60	404	245	ящик	1	2024-09-04	70	Без ГМО
143	11	46	85	173	43	кг	8	2024-06-13	96	
144	5	47	43	463	370	тонна	4	2024-06-03	45	
145	2	47	51	349	170	упаковка	3	2024-10-13	70	Хранить в прохладном месте
146	36	47	82	202	87	упаковка	3	2024-08-15	88	
147	14	48	98	498	129	тонна	1	2024-10-07	110	Без ГМО
148	14	48	100	399	141	кг	7	2024-10-06	118	Хранить в прохладном месте
149	48	49	68	256	106	кг	8	2024-06-03	79	
150	44	49	64	50	0	ящик	8	2024-07-15	65	Без ГМО
151	5	49	67	303	68	тонна	1	2024-11-18	75	Хранить в прохладном месте
152	3	49	52	25	11	упаковка	6	2024-11-11	53	
153	24	50	63	496	366	тонна	9	2024-07-17	71	Органик
154	20	50	55	223	165	упаковка	8	2024-09-19	64	
155	31	50	75	422	69	ящик	3	2024-07-07	94	Органик
156	3	50	70	467	130	тонна	9	2024-09-28	83	
157	31	51	72	102	18	тонна	4	2024-09-13	85	
158	15	51	59	133	97	ящик	5	2024-11-26	73	Без ГМО
159	7	52	55	178	77	кг	8	2024-06-25	62	
160	3	52	36	246	188	упаковка	10	2024-08-06	53	
161	40	52	36	68	5	упаковка	4	2024-10-18	44	Без ГМО
162	40	52	47	307	193	кг	6	2024-10-11	57	Без ГМО
163	21	53	12	158	129	тонна	3	2024-07-07	30	Органик
164	14	53	60	242	92	ящик	5	2024-11-13	69	Хранить в прохладном месте
165	11	53	73	47	5	кг	7	2024-06-27	93	
166	43	53	76	456	315	тонна	3	2024-10-19	93	Без ГМО
167	31	54	12	241	62	кг	8	2024-08-15	21	Хранить в прохладном месте
168	34	54	63	73	37	тонна	7	2024-09-10	82	Без ГМО
169	11	55	43	146	63	кг	6	2024-06-22	49	Без ГМО
170	9	55	91	203	12	тонна	5	2024-09-21	96	Хранить в прохладном месте
171	34	56	44	301	188	тонна	3	2024-11-17	59	Хранить в прохладном месте
172	41	56	41	138	107	тонна	4	2024-07-22	43	Органик
173	19	56	54	153	149	тонна	8	2024-10-06	73	
174	44	56	44	19	16	тонна	9	2024-09-04	47	
175	22	57	64	218	203	ящик	3	2024-08-07	81	Органик
176	2	57	68	99	43	кг	6	2024-09-09	82	
177	6	57	26	407	76	ящик	9	2024-09-19	42	Хранить в прохладном месте
178	44	57	21	384	51	тонна	5	2024-07-09	29	Хранить в прохладном месте
179	35	58	10	105	91	упаковка	4	2024-09-22	12	Хранить в прохладном месте
180	22	58	73	114	59	кг	8	2024-06-18	81	
181	17	59	94	148	47	кг	2	2024-10-29	114	Хранить в прохладном месте
182	43	59	64	438	163	упаковка	2	2024-09-07	80	Без ГМО
183	22	60	50	398	157	упаковка	9	2024-09-11	63	Органик
184	1	60	24	68	0	ящик	10	2024-07-20	36	
185	14	60	28	325	203	тонна	9	2024-07-28	29	Без ГМО
186	31	61	91	292	55	кг	8	2024-08-13	109	Хранить в прохладном месте
187	37	61	85	329	75	упаковка	3	2024-11-12	95	
188	40	61	63	83	38	ящик	4	2024-07-08	80	Органик
189	4	61	46	145	87	кг	5	2024-11-01	52	
190	21	62	93	124	23	кг	10	2024-10-18	106	Без ГМО
191	21	62	56	150	136	упаковка	8	2024-08-15	64	
192	35	63	81	399	366	кг	8	2024-10-16	83	
193	29	63	10	230	24	упаковка	6	2024-09-28	12	Без ГМО
194	15	64	81	364	304	кг	3	2024-08-27	82	
195	41	64	94	474	305	тонна	5	2024-11-26	100	Органик
196	3	64	34	20	6	кг	4	2024-07-31	45	Органик
197	30	64	88	58	28	ящик	6	2024-06-12	108	Органик
198	32	65	84	197	128	тонна	4	2024-10-30	93	
199	5	65	75	194	118	тонна	1	2024-06-19	83	
200	31	65	90	299	74	тонна	8	2024-09-07	105	
201	4	65	31	342	218	кг	3	2024-07-06	48	Без ГМО
202	17	66	83	64	0	упаковка	3	2024-07-23	93	
203	37	66	67	331	19	ящик	2	2024-07-28	71	Хранить в прохладном месте
204	30	66	85	486	440	упаковка	1	2024-08-02	97	Органик
205	12	66	84	48	7	тонна	10	2024-11-17	93	
206	47	67	29	407	151	упаковка	4	2024-07-02	38	
207	11	67	72	299	100	ящик	8	2024-08-18	84	
208	33	68	98	333	9	упаковка	7	2024-08-01	102	Хранить в прохладном месте
209	17	68	99	313	127	тонна	3	2024-09-16	109	
210	24	68	21	340	41	ящик	6	2024-09-13	33	Хранить в прохладном месте
211	13	68	85	37	8	кг	3	2024-08-13	89	Органик
212	23	69	31	390	85	ящик	2	2024-08-04	37	Без ГМО
213	40	69	19	53	21	кг	3	2024-11-28	38	
214	14	69	55	440	411	тонна	9	2024-09-29	60	
215	24	69	10	401	114	упаковка	1	2024-07-14	16	Хранить в прохладном месте
216	42	70	14	271	135	упаковка	6	2024-10-17	31	
217	5	70	89	500	479	тонна	3	2024-07-23	98	
218	48	70	14	307	158	тонна	1	2024-08-21	33	Без ГМО
219	12	70	42	408	163	кг	2	2024-09-21	45	Хранить в прохладном месте
220	25	71	16	177	37	тонна	6	2024-07-30	32	Хранить в прохладном месте
221	25	71	82	33	26	кг	2	2024-10-15	90	Без ГМО
222	41	71	28	489	403	ящик	10	2024-11-10	36	Органик
223	18	72	58	45	39	упаковка	4	2024-06-03	65	Органик
224	47	72	90	64	24	кг	2	2024-07-12	102	Органик
225	39	72	33	284	47	кг	5	2024-07-25	34	Органик
226	13	73	14	125	116	упаковка	7	2024-08-19	25	Органик
227	36	73	52	373	229	кг	8	2024-10-14	67	Без ГМО
228	16	73	35	264	92	тонна	1	2024-08-19	38	
229	7	73	74	282	72	тонна	9	2024-06-07	78	Без ГМО
230	37	74	79	280	280	кг	2	2024-08-19	98	
231	6	74	50	449	39	ящик	9	2024-10-22	59	Без ГМО
232	35	75	56	248	80	тонна	7	2024-11-24	68	
233	12	75	36	175	16	ящик	6	2024-07-02	49	
234	20	76	81	73	14	тонна	7	2024-11-05	89	Без ГМО
235	7	76	89	442	48	тонна	8	2024-11-21	109	
236	21	76	95	495	74	упаковка	8	2024-06-01	107	Без ГМО
237	11	76	54	104	81	упаковка	1	2024-06-09	66	
238	35	77	81	384	303	кг	3	2024-10-15	101	Хранить в прохладном месте
239	42	77	45	150	111	ящик	3	2024-08-02	57	Органик
240	14	77	96	333	80	ящик	10	2024-09-08	105	
241	46	78	74	428	396	ящик	10	2024-10-19	93	
242	35	78	29	274	122	упаковка	1	2024-10-17	41	
243	44	79	41	187	63	упаковка	10	2024-06-11	57	Хранить в прохладном месте
244	41	79	73	91	5	кг	9	2024-07-30	76	
245	4	80	59	18	11	тонна	6	2024-07-03	75	Хранить в прохладном месте
246	2	80	41	204	72	ящик	2	2024-09-15	56	
247	37	80	16	243	13	ящик	4	2024-11-23	20	Хранить в прохладном месте
248	44	81	29	474	250	упаковка	9	2024-09-16	42	
249	28	81	42	120	51	кг	5	2024-08-20	53	
250	32	81	52	302	3	упаковка	1	2024-09-13	57	
251	14	81	41	62	26	тонна	6	2024-08-08	49	
252	48	82	25	186	179	ящик	6	2024-07-29	35	
253	4	82	82	53	30	кг	9	2024-09-10	84	Органик
254	10	82	63	264	75	ящик	10	2024-10-12	64	Хранить в прохладном месте
255	40	82	48	421	311	ящик	3	2024-08-01	54	Органик
256	4	83	87	16	1	тонна	5	2024-07-27	95	Хранить в прохладном месте
257	48	83	48	430	143	ящик	1	2024-07-08	66	
258	19	83	51	406	69	ящик	7	2024-07-24	59	Органик
259	17	83	26	408	72	ящик	4	2024-11-22	45	
260	37	84	50	203	114	упаковка	9	2024-07-02	61	Без ГМО
261	30	84	81	319	147	кг	8	2024-09-12	91	
262	46	85	96	498	497	тонна	5	2024-06-05	112	
263	18	85	28	388	342	упаковка	2	2024-06-27	33	Хранить в прохладном месте
264	41	85	85	63	18	тонна	1	2024-10-13	97	
265	5	86	63	297	229	кг	2	2024-06-06	81	Без ГМО
266	38	86	40	125	119	упаковка	6	2024-08-09	48	Без ГМО
267	33	86	63	66	48	ящик	7	2024-07-15	83	Без ГМО
268	34	86	30	359	358	кг	3	2024-07-01	31	Хранить в прохладном месте
269	47	87	74	477	325	ящик	6	2024-07-01	86	
270	45	87	86	261	117	тонна	5	2024-09-21	101	
271	48	88	46	486	263	упаковка	4	2024-11-15	65	Хранить в прохладном месте
272	27	88	79	388	133	тонна	9	2024-11-20	92	Органик
273	40	88	16	241	182	кг	9	2024-07-21	23	Хранить в прохладном месте
274	13	88	53	212	69	тонна	9	2024-06-11	65	Хранить в прохладном месте
275	11	89	97	452	65	кг	2	2024-06-09	112	Органик
276	22	89	10	45	30	тонна	3	2024-07-07	20	Органик
277	46	89	81	301	3	упаковка	4	2024-08-16	88	Без ГМО
278	35	89	45	310	92	упаковка	4	2024-10-13	65	Хранить в прохладном месте
279	16	90	90	397	223	тонна	8	2024-07-16	102	Органик
280	22	90	75	90	36	тонна	8	2024-09-13	83	
281	6	90	24	338	230	ящик	8	2024-10-13	44	
282	33	91	46	387	93	ящик	3	2024-10-29	50	Хранить в прохладном месте
283	6	91	62	152	59	тонна	10	2024-08-01	80	Без ГМО
284	27	91	37	396	113	упаковка	1	2024-10-14	49	
285	3	92	54	130	64	упаковка	10	2024-09-08	57	Хранить в прохладном месте
286	9	92	82	179	35	ящик	6	2024-09-08	85	Хранить в прохладном месте
287	45	92	51	141	65	упаковка	5	2024-10-04	65	Хранить в прохладном месте
288	47	92	82	207	179	упаковка	6	2024-09-23	101	
289	13	93	43	238	139	тонна	8	2024-08-11	51	
290	11	93	23	150	27	ящик	7	2024-06-08	42	Хранить в прохладном месте
291	40	94	66	329	172	упаковка	1	2024-09-13	76	
292	9	94	36	270	237	тонна	2	2024-09-15	53	
293	3	94	29	114	113	тонна	1	2024-06-29	40	Без ГМО
294	13	94	69	290	248	тонна	6	2024-09-26	86	Органик
295	1	95	68	46	31	тонна	4	2024-08-07	80	Органик
296	13	95	12	442	243	тонна	3	2024-09-20	22	
297	16	95	23	18	17	ящик	8	2024-06-07	40	Органик
298	23	96	88	284	279	тонна	2	2024-06-08	89	Органик
299	14	96	50	159	50	упаковка	9	2024-07-16	70	
300	31	96	87	163	142	упаковка	2	2024-09-16	103	
301	35	96	65	292	63	тонна	4	2024-08-27	71	Хранить в прохладном месте
302	2	97	91	500	11	упаковка	4	2024-11-26	102	
303	1	97	92	234	17	тонна	7	2024-08-20	104	
304	1	97	95	127	125	тонна	6	2024-07-04	99	Хранить в прохладном месте
305	6	98	33	351	157	упаковка	3	2024-08-28	36	
306	21	98	82	430	166	ящик	6	2024-08-06	91	Без ГМО
307	41	98	32	285	136	ящик	1	2024-09-30	50	Без ГМО
308	5	98	37	25	0	ящик	8	2024-10-07	42	Без ГМО
309	48	99	57	63	26	тонна	9	2024-11-17	63	
310	2	99	77	359	84	упаковка	3	2024-07-10	85	
311	26	99	99	245	23	ящик	7	2024-10-02	118	Без ГМО
312	16	99	41	145	33	ящик	2	2024-08-18	49	Хранить в прохладном месте
313	42	100	71	294	76	тонна	4	2024-10-09	80	Хранить в прохладном месте
314	7	100	43	206	21	кг	6	2024-06-18	59	
315	33	101	76	148	134	упаковка	9	2024-09-22	89	
316	19	101	29	88	70	ящик	4	2024-09-10	45	Хранить в прохладном месте
317	47	101	30	183	120	ящик	10	2024-06-02	39	Без ГМО
318	20	101	25	98	10	кг	3	2024-06-27	39	Без ГМО
319	27	102	58	364	219	тонна	6	2024-11-23	72	
320	1	102	72	241	142	тонна	10	2024-08-10	84	Без ГМО
321	42	102	76	196	71	тонна	5	2024-09-20	81	Без ГМО
322	41	102	91	171	61	кг	5	2024-07-09	93	Хранить в прохладном месте
323	9	103	36	320	259	ящик	3	2024-07-08	46	Без ГМО
324	45	103	15	76	7	ящик	2	2024-09-30	31	
325	13	103	36	330	22	упаковка	1	2024-07-22	42	Без ГМО
326	16	104	63	86	83	кг	10	2024-07-14	80	Хранить в прохладном месте
327	47	104	36	339	73	тонна	3	2024-08-22	49	
328	4	105	62	473	148	упаковка	4	2024-07-02	76	Органик
329	12	105	29	71	30	упаковка	4	2024-09-23	46	Без ГМО
330	32	105	18	282	145	тонна	7	2024-10-07	34	
331	42	106	28	60	47	ящик	4	2024-06-15	37	Без ГМО
332	47	106	42	101	22	кг	9	2024-10-31	43	Хранить в прохладном месте
333	15	106	45	80	72	тонна	10	2024-07-31	55	Без ГМО
334	2	107	94	189	103	упаковка	9	2024-09-18	104	Без ГМО
335	36	107	12	337	244	упаковка	3	2024-08-17	16	Без ГМО
336	25	108	39	229	94	ящик	2	2024-08-14	46	
337	16	108	63	290	112	кг	7	2024-10-27	83	Хранить в прохладном месте
338	8	108	70	190	93	упаковка	7	2024-11-27	77	Без ГМО
339	26	109	51	159	43	упаковка	5	2024-08-25	60	Органик
340	31	109	11	207	62	тонна	8	2024-06-19	28	
341	2	110	34	14	14	упаковка	9	2024-10-27	38	
342	10	110	75	57	48	кг	9	2024-06-25	83	Органик
343	23	110	96	438	221	кг	4	2024-11-22	106	Без ГМО
344	9	111	96	211	176	тонна	5	2024-10-11	101	Органик
345	34	111	33	238	63	упаковка	9	2024-06-02	35	Хранить в прохладном месте
346	36	111	72	246	36	кг	8	2024-11-10	79	Хранить в прохладном месте
347	14	112	54	149	127	тонна	7	2024-06-19	55	Хранить в прохладном месте
348	20	112	46	217	6	кг	3	2024-10-24	66	
349	20	113	89	52	13	кг	10	2024-06-19	99	
350	11	113	71	347	238	ящик	4	2024-08-20	91	Без ГМО
351	22	114	72	273	78	тонна	2	2024-08-24	86	Без ГМО
352	46	114	57	262	141	ящик	9	2024-07-16	59	
353	4	115	89	274	49	тонна	1	2024-10-30	99	
354	10	115	58	343	333	тонна	1	2024-09-13	76	Хранить в прохладном месте
355	29	115	33	138	53	ящик	5	2024-10-14	34	
356	47	116	72	208	142	кг	10	2024-10-03	84	
357	5	116	31	219	28	упаковка	4	2024-11-03	43	
358	9	116	100	327	51	упаковка	2	2024-09-02	115	
359	45	116	58	391	24	ящик	3	2024-09-20	68	Органик
360	2	117	96	330	163	ящик	7	2024-08-10	98	Органик
361	24	117	23	321	139	упаковка	9	2024-07-24	30	
362	30	118	20	397	196	тонна	1	2024-10-06	32	Без ГМО
363	31	118	59	66	3	тонна	4	2024-06-18	73	Органик
364	7	118	50	472	330	упаковка	5	2024-10-11	63	Хранить в прохладном месте
365	42	119	11	457	53	упаковка	8	2024-08-25	26	
366	12	119	45	173	147	упаковка	9	2024-11-16	51	Хранить в прохладном месте
367	29	119	77	104	24	ящик	7	2024-11-06	81	Органик
368	23	119	47	262	10	ящик	1	2024-09-05	64	Без ГМО
369	26	120	13	239	61	ящик	1	2024-08-11	25	
370	19	120	45	473	403	упаковка	1	2024-06-19	59	
371	27	120	63	91	28	упаковка	1	2024-06-07	69	
372	7	121	86	311	263	тонна	2	2024-10-13	102	Без ГМО
373	31	121	21	308	282	упаковка	7	2024-10-01	24	
374	8	121	92	490	465	кг	9	2024-11-10	106	Хранить в прохладном месте
375	37	122	20	150	146	ящик	2	2024-07-20	26	Без ГМО
376	47	122	61	409	202	ящик	3	2024-09-26	74	
377	33	123	48	449	144	ящик	4	2024-07-08	60	Без ГМО
378	34	123	52	172	50	упаковка	5	2024-09-02	54	
379	47	123	19	25	8	упаковка	7	2024-06-12	28	Хранить в прохладном месте
380	19	124	82	414	402	кг	1	2024-10-17	91	Без ГМО
381	37	124	97	262	105	упаковка	9	2024-07-28	114	Хранить в прохладном месте
382	5	124	30	354	1	упаковка	2	2024-10-20	47	
383	46	125	91	360	165	ящик	9	2024-09-11	108	Хранить в прохладном месте
384	15	125	95	365	40	кг	9	2024-09-04	96	
385	44	125	85	352	5	упаковка	3	2024-07-02	87	Хранить в прохладном месте
386	25	126	89	241	202	упаковка	4	2024-08-31	99	
387	37	126	51	129	34	ящик	10	2024-07-04	69	Хранить в прохладном месте
388	10	126	72	289	128	кг	3	2024-11-04	87	Хранить в прохладном месте
389	26	127	24	196	71	ящик	4	2024-11-26	35	Хранить в прохладном месте
390	7	127	91	97	19	упаковка	9	2024-09-16	96	
391	31	127	62	459	197	тонна	2	2024-07-06	82	Без ГМО
392	42	128	83	184	130	ящик	6	2024-07-19	84	
393	23	128	50	495	89	тонна	3	2024-09-04	60	Хранить в прохладном месте
394	47	128	34	198	154	упаковка	6	2024-07-13	38	Органик
395	40	129	46	454	408	кг	5	2024-08-17	62	Без ГМО
396	28	129	25	89	25	кг	7	2024-07-06	30	Хранить в прохладном месте
397	18	130	31	406	328	ящик	8	2024-07-19	34	
398	26	130	96	430	385	упаковка	2	2024-09-24	116	Органик
399	34	130	32	444	206	упаковка	2	2024-10-02	42	Органик
400	15	131	78	51	3	тонна	10	2024-07-07	80	Органик
401	33	131	45	291	0	кг	2	2024-06-25	59	Органик
402	11	131	57	396	227	ящик	8	2024-10-01	76	
403	29	132	65	323	235	кг	9	2024-11-25	69	
404	4	132	75	437	127	ящик	3	2024-10-13	79	Органик
405	6	132	12	216	13	тонна	7	2024-06-20	32	
406	47	132	50	233	128	упаковка	5	2024-07-06	51	
407	33	133	78	219	74	ящик	3	2024-06-05	79	Без ГМО
408	19	133	58	244	91	кг	9	2024-10-26	77	
409	26	134	74	203	179	ящик	4	2024-11-10	81	Хранить в прохладном месте
410	29	134	91	101	66	упаковка	2	2024-10-22	100	Хранить в прохладном месте
411	26	135	23	371	110	упаковка	5	2024-07-12	28	Хранить в прохладном месте
412	14	135	94	177	50	тонна	8	2024-10-12	111	Органик
576	41	192	55	186	83	кг	5	2024-10-12	57	Без ГМО
413	20	136	16	164	13	ящик	10	2024-08-16	17	Хранить в прохладном месте
414	44	136	13	149	22	упаковка	6	2024-07-02	18	
415	24	136	26	82	49	кг	10	2024-07-08	38	Без ГМО
416	32	137	35	293	237	ящик	6	2024-07-10	38	Органик
417	26	137	50	384	16	ящик	8	2024-07-08	55	Без ГМО
418	45	137	92	498	469	упаковка	9	2024-08-27	94	Без ГМО
419	26	138	73	82	21	кг	8	2024-09-08	82	Без ГМО
420	15	138	59	209	81	тонна	6	2024-07-23	70	Органик
421	45	139	64	22	10	ящик	7	2024-07-03	66	Хранить в прохладном месте
422	44	139	51	170	28	тонна	9	2024-11-06	54	
423	28	140	96	414	129	кг	8	2024-06-08	98	Без ГМО
424	39	140	87	364	300	упаковка	2	2024-10-03	88	Без ГМО
425	34	141	100	215	50	тонна	2	2024-08-19	103	
426	39	141	72	443	25	кг	7	2024-07-18	78	Органик
427	16	142	70	100	23	кг	2	2024-11-10	71	Без ГМО
428	42	142	80	474	68	кг	6	2024-07-13	99	
429	46	142	77	333	248	упаковка	3	2024-06-03	92	Органик
430	18	142	71	101	30	упаковка	4	2024-09-01	75	Без ГМО
431	18	143	84	23	3	тонна	5	2024-11-01	87	Хранить в прохладном месте
432	42	143	85	97	27	упаковка	3	2024-06-10	100	Хранить в прохладном месте
433	32	144	91	160	61	кг	5	2024-07-31	106	
434	40	144	35	438	44	кг	6	2024-11-11	46	Органик
435	25	145	22	413	172	ящик	5	2024-07-30	30	
436	11	145	91	352	18	упаковка	5	2024-10-10	103	
437	3	145	45	32	16	ящик	9	2024-10-25	58	Хранить в прохладном месте
438	31	145	87	481	452	ящик	2	2024-11-12	98	
439	22	146	19	411	73	тонна	3	2024-10-14	33	Органик
440	9	146	41	470	203	кг	5	2024-11-17	48	Хранить в прохладном месте
441	32	146	14	314	240	кг	8	2024-09-07	26	Органик
442	29	146	71	441	368	ящик	6	2024-07-28	87	
443	39	147	83	205	46	кг	7	2024-07-12	94	
444	19	147	39	105	43	ящик	8	2024-07-13	57	
445	7	147	67	45	23	кг	7	2024-11-10	71	Без ГМО
446	3	148	53	100	35	ящик	4	2024-10-30	66	Органик
447	31	148	35	420	291	ящик	4	2024-06-28	51	Хранить в прохладном месте
448	40	148	60	132	96	кг	6	2024-11-18	73	Без ГМО
449	27	149	83	228	139	кг	4	2024-07-06	97	Без ГМО
450	26	149	40	419	279	тонна	9	2024-09-27	55	Хранить в прохладном месте
451	22	149	91	56	49	ящик	8	2024-10-09	94	Органик
452	13	149	71	75	8	упаковка	3	2024-09-26	89	Хранить в прохладном месте
453	39	150	70	196	32	кг	3	2024-11-05	87	Без ГМО
454	14	150	49	181	84	упаковка	3	2024-10-29	66	
455	30	150	95	244	107	упаковка	2	2024-10-30	103	Хранить в прохладном месте
456	39	151	17	75	72	упаковка	2	2024-06-28	37	
457	41	151	25	422	263	кг	10	2024-09-30	34	Органик
458	35	151	20	160	62	ящик	8	2024-08-25	32	Хранить в прохладном месте
459	42	151	28	380	262	кг	4	2024-08-12	31	
460	31	152	43	127	127	ящик	1	2024-06-06	48	
461	35	152	91	359	170	кг	4	2024-09-14	97	Хранить в прохладном месте
462	35	152	89	378	250	кг	1	2024-10-21	97	
463	45	153	59	293	76	кг	6	2024-08-03	72	Органик
464	31	153	52	254	41	кг	5	2024-10-23	59	Органик
465	33	153	12	445	209	ящик	4	2024-10-14	22	
466	6	154	15	105	34	упаковка	4	2024-06-06	29	Органик
467	13	154	68	309	53	кг	1	2024-07-20	74	
468	8	155	22	492	434	ящик	1	2024-11-16	29	
469	14	155	78	61	56	ящик	1	2024-07-28	94	Без ГМО
470	38	155	30	402	154	тонна	2	2024-08-05	41	
471	37	156	53	387	158	кг	1	2024-11-02	70	Органик
472	12	156	23	66	37	упаковка	4	2024-10-08	40	Без ГМО
473	31	157	33	193	58	кг	4	2024-09-26	47	Органик
474	14	157	75	139	87	тонна	10	2024-08-05	92	Органик
475	23	158	39	128	35	ящик	9	2024-11-13	51	Хранить в прохладном месте
476	31	158	90	495	154	упаковка	7	2024-06-03	108	
477	1	159	62	444	359	ящик	2	2024-06-27	69	
478	42	159	46	360	74	ящик	8	2024-07-02	52	Хранить в прохладном месте
479	26	159	79	207	86	упаковка	2	2024-06-08	98	Без ГМО
480	8	160	74	28	10	тонна	10	2024-06-25	87	Без ГМО
481	33	160	96	16	5	тонна	8	2024-07-22	97	Без ГМО
482	29	160	79	312	137	тонна	6	2024-09-30	80	Хранить в прохладном месте
483	11	161	30	401	40	кг	6	2024-08-13	31	
484	28	161	14	405	269	ящик	8	2024-10-07	24	Органик
485	47	161	94	92	60	упаковка	1	2024-11-01	112	
486	36	161	74	413	151	тонна	8	2024-09-19	88	Органик
487	33	162	56	64	59	кг	5	2024-09-02	60	Без ГМО
488	4	162	89	423	188	упаковка	3	2024-06-11	104	Органик
489	3	162	39	14	12	кг	3	2024-10-28	57	Хранить в прохладном месте
490	40	163	61	199	166	ящик	3	2024-07-21	76	
491	1	163	65	249	226	ящик	3	2024-08-19	67	Без ГМО
492	5	164	66	61	26	упаковка	1	2024-07-09	85	Без ГМО
493	45	164	21	441	148	кг	3	2024-06-28	32	Без ГМО
494	16	165	32	72	26	ящик	5	2024-10-03	49	
577	34	192	97	223	29	упаковка	4	2024-07-10	109	
495	12	165	23	341	172	тонна	9	2024-10-12	34	Хранить в прохладном месте
496	35	166	78	59	50	тонна	6	2024-07-18	93	Органик
497	43	166	25	222	122	кг	10	2024-09-19	39	Хранить в прохладном месте
498	36	166	93	255	88	тонна	5	2024-07-13	107	Органик
499	3	166	37	37	11	упаковка	1	2024-06-06	50	Органик
500	23	167	100	196	145	ящик	7	2024-07-25	104	Без ГМО
501	47	167	97	88	13	кг	2	2024-06-12	103	Хранить в прохладном месте
502	5	167	57	162	162	ящик	9	2024-11-08	58	Органик
503	32	168	17	293	53	ящик	5	2024-11-01	19	
504	4	168	21	70	31	тонна	9	2024-09-15	29	Хранить в прохладном месте
505	23	168	29	323	80	упаковка	1	2024-08-25	37	
506	2	169	68	78	25	ящик	5	2024-10-02	69	
507	31	169	27	436	375	ящик	3	2024-07-29	37	
508	29	169	89	11	11	упаковка	4	2024-10-15	93	
509	8	170	12	102	74	тонна	3	2024-07-03	32	Без ГМО
510	14	170	42	385	273	упаковка	3	2024-10-12	44	Органик
511	30	170	72	272	71	упаковка	4	2024-11-14	75	Хранить в прохладном месте
512	21	170	18	38	21	ящик	6	2024-07-17	30	Без ГМО
513	48	171	18	199	107	кг	9	2024-06-04	24	Хранить в прохладном месте
514	47	171	58	374	275	ящик	6	2024-10-07	60	
515	4	171	15	422	260	тонна	10	2024-09-02	21	Хранить в прохладном месте
516	39	172	98	401	309	ящик	10	2024-07-11	116	Без ГМО
517	44	172	53	76	59	тонна	6	2024-07-20	73	Хранить в прохладном месте
518	27	173	31	330	272	ящик	2	2024-10-15	45	
519	25	173	16	288	136	упаковка	6	2024-07-06	25	
520	40	173	20	330	152	упаковка	5	2024-10-08	40	
521	4	173	72	41	27	упаковка	5	2024-06-13	89	
522	9	174	90	62	55	кг	3	2024-09-14	102	
523	21	174	23	259	113	ящик	2	2024-11-05	41	Хранить в прохладном месте
524	2	174	79	87	7	ящик	1	2024-10-16	81	Без ГМО
525	12	174	11	183	8	упаковка	4	2024-07-09	18	
526	5	175	33	18	9	упаковка	2	2024-07-25	49	
527	8	175	75	277	226	упаковка	6	2024-10-06	89	Органик
528	37	175	19	253	79	упаковка	5	2024-06-13	27	
529	26	176	82	88	1	ящик	1	2024-10-31	99	Без ГМО
530	36	176	70	281	202	кг	6	2024-11-02	79	Без ГМО
531	19	176	33	439	157	тонна	3	2024-11-20	45	Органик
532	24	177	52	233	72	тонна	2	2024-08-02	70	Хранить в прохладном месте
533	44	177	75	383	367	тонна	5	2024-07-01	85	Хранить в прохладном месте
534	41	177	85	299	113	упаковка	4	2024-07-19	96	Органик
535	3	177	78	256	40	ящик	3	2024-08-24	80	
536	35	178	95	333	5	кг	8	2024-09-22	110	Органик
537	10	178	19	397	95	тонна	10	2024-08-21	27	
538	15	179	52	187	34	кг	1	2024-06-01	71	Без ГМО
539	32	179	49	327	205	упаковка	10	2024-10-18	67	
540	11	179	94	160	91	упаковка	9	2024-11-08	107	
541	27	180	50	300	138	кг	4	2024-07-28	55	
542	38	180	47	305	154	ящик	5	2024-08-16	63	Хранить в прохладном месте
543	33	180	80	74	68	тонна	8	2024-07-01	94	Без ГМО
544	45	181	47	250	27	упаковка	1	2024-10-15	52	
545	30	181	12	148	52	тонна	3	2024-06-06	32	
546	48	181	73	422	26	упаковка	3	2024-09-10	77	
547	12	181	68	294	229	тонна	8	2024-09-03	87	Без ГМО
548	4	182	93	460	150	упаковка	9	2024-11-02	101	
549	38	182	36	479	429	ящик	4	2024-11-03	41	Без ГМО
550	29	183	25	237	102	тонна	7	2024-10-27	26	Хранить в прохладном месте
551	11	183	51	214	55	ящик	2	2024-09-16	71	
552	47	184	69	201	37	тонна	6	2024-06-24	72	
553	28	184	94	456	361	тонна	4	2024-10-15	105	Без ГМО
554	7	185	72	445	9	ящик	8	2024-09-16	73	
555	33	185	29	139	35	ящик	3	2024-09-18	37	Хранить в прохладном месте
556	12	185	61	192	186	тонна	7	2024-08-18	79	Без ГМО
557	14	186	95	480	85	упаковка	6	2024-08-14	112	
558	36	186	92	180	51	кг	8	2024-09-30	106	Хранить в прохладном месте
559	21	186	31	436	241	упаковка	10	2024-10-14	38	Хранить в прохладном месте
560	24	186	83	41	11	ящик	10	2024-10-03	102	Хранить в прохладном месте
561	29	187	36	326	151	ящик	7	2024-11-07	45	Органик
562	46	187	99	357	341	кг	2	2024-06-21	112	
563	9	187	16	199	191	кг	3	2024-10-12	17	
564	40	188	69	460	294	ящик	1	2024-06-19	89	Хранить в прохладном месте
565	46	188	54	492	140	кг	9	2024-10-13	57	Органик
566	1	188	12	134	124	тонна	5	2024-06-01	28	
567	12	188	36	296	99	тонна	7	2024-10-21	56	Органик
568	27	189	42	30	13	ящик	5	2024-09-19	54	
569	35	189	80	138	32	тонна	5	2024-11-05	86	Хранить в прохладном месте
570	33	190	39	93	30	ящик	2	2024-07-05	47	Без ГМО
571	11	190	17	261	204	ящик	10	2024-11-21	34	Органик
572	36	191	15	247	189	упаковка	8	2024-06-23	30	Хранить в прохладном месте
573	8	191	24	95	2	кг	5	2024-08-26	33	Органик
574	2	191	91	386	219	ящик	4	2024-06-21	97	
575	11	192	28	228	159	тонна	7	2024-08-08	46	Органик
578	3	192	39	365	263	упаковка	2	2024-07-21	41	Органик
579	15	193	85	275	119	кг	6	2024-06-24	97	
580	18	193	56	47	41	тонна	5	2024-08-24	75	
581	13	193	91	22	0	упаковка	6	2024-10-13	103	Органик
582	46	193	98	322	239	ящик	5	2024-11-20	100	Без ГМО
583	16	194	39	209	19	кг	5	2024-08-07	43	Без ГМО
584	13	194	85	56	40	ящик	10	2024-10-03	101	Органик
585	24	194	87	209	45	ящик	7	2024-09-20	90	Без ГМО
586	23	194	20	159	9	тонна	7	2024-06-08	23	Без ГМО
587	16	195	18	242	131	упаковка	10	2024-10-29	25	
588	30	195	93	243	31	кг	10	2024-06-24	95	Без ГМО
589	6	195	59	481	459	упаковка	9	2024-10-02	67	
590	35	196	73	467	209	тонна	2	2024-09-22	92	
591	25	196	69	177	162	упаковка	9	2024-09-10	72	Органик
592	10	196	23	368	304	ящик	1	2024-06-15	24	
593	15	196	77	10	1	кг	6	2024-10-02	87	
594	32	197	49	441	388	тонна	7	2024-07-10	65	Без ГМО
595	39	197	66	311	187	ящик	1	2024-07-14	68	
596	41	197	50	371	39	тонна	2	2024-10-23	67	
597	1	197	49	250	138	ящик	2	2024-11-21	58	Хранить в прохладном месте
598	18	198	33	484	233	упаковка	2	2024-09-21	46	
599	46	198	83	331	0	кг	7	2024-11-12	84	
600	15	198	79	283	84	ящик	3	2024-10-21	94	
601	42	198	45	59	59	кг	9	2024-10-01	61	
602	18	199	52	206	145	тонна	3	2024-07-05	61	
603	43	199	35	24	5	упаковка	4	2024-08-31	37	Без ГМО
604	38	200	59	160	95	упаковка	8	2024-06-06	73	Без ГМО
605	47	200	61	394	202	кг	6	2024-10-05	73	
606	14	200	92	123	10	кг	6	2024-08-30	94	Хранить в прохладном месте
607	22	200	95	251	86	упаковка	7	2024-06-08	99	Органик
608	13	201	25	362	232	кг	10	2024-07-16	35	Хранить в прохладном месте
609	40	201	52	190	70	ящик	10	2024-09-07	54	
610	32	201	52	49	4	ящик	9	2024-08-09	69	
611	47	202	92	309	46	ящик	7	2024-10-22	101	
612	31	202	51	161	151	упаковка	10	2024-11-21	57	
613	47	202	45	332	251	упаковка	7	2024-10-08	59	Хранить в прохладном месте
614	42	203	20	373	189	упаковка	7	2024-11-09	37	Хранить в прохладном месте
615	43	203	21	134	133	упаковка	6	2024-11-26	33	Хранить в прохладном месте
616	34	204	90	449	112	тонна	9	2024-07-14	99	Без ГМО
617	32	204	21	317	12	ящик	8	2024-08-09	27	Органик
618	15	204	57	334	104	кг	3	2024-10-19	60	Хранить в прохладном месте
619	45	205	80	445	261	кг	6	2024-08-19	98	
620	46	205	72	272	209	тонна	4	2024-09-13	92	
621	45	205	97	452	279	упаковка	3	2024-09-22	101	
622	46	205	87	213	71	ящик	7	2024-07-10	103	Без ГМО
623	38	206	69	402	245	тонна	4	2024-07-13	72	Без ГМО
624	2	206	100	398	48	упаковка	7	2024-06-14	101	
625	6	206	85	320	96	упаковка	7	2024-10-08	94	
626	9	206	78	30	10	кг	10	2024-11-28	83	
627	10	207	50	483	214	тонна	9	2024-10-27	64	Хранить в прохладном месте
628	41	207	50	452	221	кг	6	2024-10-03	70	
629	12	208	18	221	151	ящик	9	2024-09-14	36	
630	18	208	55	441	107	ящик	8	2024-09-03	64	Органик
631	28	208	70	461	298	тонна	5	2024-06-30	75	
632	18	209	56	394	142	тонна	9	2024-06-14	74	
633	37	209	30	253	36	упаковка	8	2024-06-18	49	Без ГМО
634	39	209	24	350	263	ящик	5	2024-06-16	33	
635	21	209	93	37	33	тонна	10	2024-09-12	109	
636	15	210	96	135	43	тонна	7	2024-07-10	107	Без ГМО
637	35	210	61	27	24	ящик	5	2024-07-31	79	Без ГМО
638	3	210	67	75	59	упаковка	6	2024-08-13	84	
639	24	210	96	269	59	ящик	8	2024-10-23	104	Без ГМО
640	44	211	14	134	121	кг	5	2024-07-05	15	Хранить в прохладном месте
641	36	211	82	418	174	тонна	8	2024-07-29	92	Без ГМО
642	35	212	66	46	25	упаковка	10	2024-06-12	79	
643	3	212	24	258	184	тонна	10	2024-09-21	37	
644	43	213	30	178	82	упаковка	7	2024-08-02	40	Без ГМО
645	39	213	96	380	276	кг	2	2024-09-27	110	Хранить в прохладном месте
646	7	214	32	379	153	кг	7	2024-10-09	35	Без ГМО
647	14	214	57	123	101	упаковка	2	2024-10-15	69	
648	22	215	55	126	2	кг	9	2024-09-01	57	Без ГМО
649	46	215	84	101	55	кг	8	2024-10-04	96	Без ГМО
650	4	215	44	471	362	упаковка	9	2024-07-09	49	
651	5	216	98	456	115	упаковка	3	2024-06-09	110	Органик
652	32	216	94	466	105	кг	8	2024-06-16	112	
653	34	216	37	105	1	упаковка	3	2024-09-26	39	Хранить в прохладном месте
654	46	217	61	421	265	тонна	7	2024-08-20	64	
655	21	217	18	266	217	упаковка	5	2024-06-24	23	Хранить в прохладном месте
656	4	218	47	146	93	кг	4	2024-07-22	59	Органик
657	17	218	45	444	385	тонна	9	2024-10-30	62	
658	14	218	83	91	11	упаковка	8	2024-10-18	84	
659	37	218	73	197	55	тонна	7	2024-11-23	87	
660	24	219	98	172	3	упаковка	5	2024-07-08	117	
661	5	219	84	274	90	ящик	1	2024-09-16	90	Хранить в прохладном месте
662	5	220	100	156	21	ящик	7	2024-07-03	113	Органик
663	32	220	16	141	96	кг	10	2024-10-15	34	
664	14	220	49	80	34	упаковка	3	2024-06-07	68	Хранить в прохладном месте
665	45	220	51	274	77	тонна	6	2024-11-12	57	
666	10	221	56	109	46	кг	3	2024-09-28	60	
667	4	221	39	293	44	тонна	5	2024-08-26	49	
668	39	221	68	412	130	кг	1	2024-09-25	76	Без ГМО
669	26	221	97	375	302	кг	6	2024-06-24	109	Органик
670	2	222	96	321	222	тонна	4	2024-07-27	101	Без ГМО
671	20	222	75	331	300	кг	3	2024-09-19	77	
672	33	222	80	359	323	тонна	4	2024-06-25	88	
673	41	223	18	498	257	тонна	5	2024-09-23	35	Хранить в прохладном месте
674	44	223	88	422	358	тонна	8	2024-11-11	99	Органик
675	30	223	40	225	124	ящик	1	2024-11-08	60	Органик
676	13	224	46	164	127	упаковка	7	2024-06-20	59	
677	5	224	85	12	1	ящик	5	2024-08-24	91	
678	6	224	85	313	157	кг	10	2024-07-22	92	Органик
679	11	224	60	486	30	упаковка	4	2024-09-28	74	Без ГМО
680	39	225	64	490	414	ящик	6	2024-06-14	77	Хранить в прохладном месте
681	11	225	69	480	248	тонна	10	2024-10-15	75	Хранить в прохладном месте
682	14	225	20	430	116	ящик	4	2024-08-29	29	Хранить в прохладном месте
683	34	225	18	174	123	упаковка	4	2024-07-09	30	
684	38	226	71	224	67	упаковка	2	2024-07-06	80	Без ГМО
685	48	226	53	269	267	упаковка	3	2024-11-08	69	
686	8	226	63	361	236	упаковка	4	2024-09-26	73	
687	18	227	85	497	160	кг	10	2024-10-24	86	
688	21	227	15	285	59	упаковка	7	2024-11-17	18	
689	29	227	99	465	52	кг	7	2024-11-21	108	
690	45	228	43	491	210	ящик	6	2024-06-20	49	
691	4	228	83	237	120	тонна	3	2024-09-06	97	
692	8	228	51	11	8	тонна	9	2024-07-07	54	
693	30	229	28	168	123	упаковка	9	2024-10-14	43	Без ГМО
694	47	229	85	41	6	упаковка	1	2024-10-23	98	Хранить в прохладном месте
695	44	230	38	91	21	упаковка	5	2024-07-17	56	
696	1	230	26	63	31	кг	2	2024-09-04	32	
697	37	231	97	33	12	тонна	8	2024-06-20	116	
698	33	231	100	413	204	кг	6	2024-06-29	109	
699	34	231	87	409	258	тонна	9	2024-07-06	98	
700	35	232	47	470	360	тонна	2	2024-09-26	58	Без ГМО
701	25	232	93	36	18	упаковка	10	2024-09-17	98	Органик
702	6	232	14	126	3	ящик	3	2024-08-26	31	Без ГМО
703	22	233	24	127	43	кг	8	2024-11-17	43	
704	3	233	78	465	306	кг	7	2024-10-27	83	
705	20	233	40	157	131	кг	4	2024-10-19	41	Хранить в прохладном месте
706	46	234	38	15	2	упаковка	7	2024-11-27	55	Хранить в прохладном месте
707	1	234	21	52	2	ящик	4	2024-07-05	41	Хранить в прохладном месте
708	5	235	30	296	164	упаковка	1	2024-09-27	35	Хранить в прохладном месте
709	33	235	98	223	177	тонна	1	2024-09-15	106	Без ГМО
710	11	236	96	265	6	упаковка	7	2024-09-13	116	
711	25	236	94	241	201	упаковка	6	2024-11-15	101	Хранить в прохладном месте
712	40	237	42	191	86	ящик	7	2024-10-26	60	Без ГМО
713	22	237	94	262	130	ящик	6	2024-06-19	110	
714	16	238	56	194	69	упаковка	10	2024-09-18	66	
715	31	238	33	443	354	ящик	9	2024-09-02	45	
716	9	238	67	88	36	кг	7	2024-10-16	72	Хранить в прохладном месте
717	17	239	55	360	92	упаковка	5	2024-09-15	62	Без ГМО
718	45	239	77	275	243	ящик	5	2024-11-13	83	
719	2	239	99	24	14	тонна	5	2024-08-15	104	Без ГМО
720	12	240	14	202	92	ящик	5	2024-06-08	21	Органик
721	38	240	36	151	64	кг	5	2024-07-13	51	
722	28	241	45	366	214	упаковка	1	2024-08-12	50	Хранить в прохладном месте
723	42	241	97	473	137	тонна	3	2024-08-02	114	
724	8	241	96	497	234	кг	5	2024-06-28	103	Хранить в прохладном месте
725	13	241	44	108	54	упаковка	6	2024-09-02	64	Хранить в прохладном месте
726	14	242	61	262	258	ящик	3	2024-06-08	63	Хранить в прохладном месте
727	17	242	56	210	46	упаковка	10	2024-07-05	67	Хранить в прохладном месте
728	26	242	49	318	33	кг	8	2024-09-14	63	Хранить в прохладном месте
729	32	242	63	469	30	упаковка	10	2024-08-10	76	Без ГМО
730	28	243	29	367	160	ящик	2	2024-07-15	41	Органик
731	28	243	78	468	9	кг	5	2024-07-16	86	
732	30	243	71	279	39	ящик	7	2024-06-23	84	
733	1	243	89	315	243	кг	7	2024-10-18	104	
734	43	244	29	336	124	тонна	4	2024-08-15	36	Органик
735	32	244	79	151	47	ящик	4	2024-07-19	93	
736	13	244	72	389	201	кг	3	2024-07-04	79	Без ГМО
737	11	245	92	247	103	тонна	9	2024-09-12	94	Без ГМО
738	42	245	47	106	39	кг	4	2024-09-28	48	Органик
739	19	245	100	106	91	ящик	9	2024-06-09	109	Хранить в прохладном месте
740	45	245	66	178	13	кг	1	2024-10-11	83	
741	36	246	22	293	115	ящик	6	2024-08-06	40	Хранить в прохладном месте
742	17	246	28	324	61	тонна	9	2024-07-01	40	
743	12	247	10	54	9	ящик	4	2024-08-04	27	
744	17	247	67	20	7	ящик	3	2024-11-23	68	Органик
745	12	247	76	101	48	упаковка	9	2024-06-06	90	Без ГМО
746	45	248	39	441	27	упаковка	2	2024-08-13	48	
747	35	248	78	199	9	кг	9	2024-10-19	92	
748	47	248	11	139	37	ящик	10	2024-06-27	28	Органик
749	15	249	100	57	23	кг	9	2024-10-29	109	Хранить в прохладном месте
750	29	249	69	451	260	упаковка	3	2024-08-02	70	Органик
751	40	249	81	39	8	упаковка	5	2024-06-20	86	
752	34	250	99	79	16	упаковка	10	2024-11-20	115	Органик
753	19	250	79	500	213	упаковка	5	2024-10-18	82	Без ГМО
754	28	251	15	246	112	ящик	10	2024-11-20	22	
755	42	251	59	347	346	упаковка	6	2024-07-26	76	
756	15	251	66	452	105	кг	2	2024-06-20	67	
757	32	251	73	445	193	упаковка	1	2024-09-01	82	Без ГМО
758	43	252	39	311	237	кг	5	2024-11-10	42	Без ГМО
759	39	252	22	111	78	кг	6	2024-06-13	28	
760	35	252	64	133	81	тонна	4	2024-10-10	68	
761	5	252	70	428	234	кг	1	2024-09-29	87	
762	48	253	39	339	214	тонна	8	2024-09-21	44	Без ГМО
763	35	253	13	31	21	кг	10	2024-10-12	20	Органик
764	4	253	16	486	354	тонна	1	2024-07-09	31	Без ГМО
765	19	254	57	267	144	ящик	6	2024-10-24	62	Без ГМО
766	37	254	74	313	103	упаковка	8	2024-07-15	79	Без ГМО
767	43	254	80	67	3	ящик	9	2024-11-21	91	Хранить в прохладном месте
768	4	255	65	251	56	ящик	6	2024-09-14	78	
769	41	255	57	253	174	кг	6	2024-07-21	73	
770	29	256	53	334	110	ящик	6	2024-09-15	73	
771	28	256	87	73	41	ящик	9	2024-11-05	91	
772	17	256	56	377	137	ящик	4	2024-09-13	62	
773	6	256	54	55	52	упаковка	9	2024-07-30	67	Органик
774	16	257	89	148	109	ящик	1	2024-06-09	105	Хранить в прохладном месте
775	47	257	92	389	307	ящик	9	2024-08-29	103	Хранить в прохладном месте
776	48	257	77	435	275	кг	2	2024-09-19	93	Органик
777	35	257	14	180	140	ящик	1	2024-10-08	27	Без ГМО
778	1	258	20	425	237	упаковка	10	2024-10-28	30	
779	7	258	79	102	60	упаковка	4	2024-07-06	82	
780	27	258	44	411	43	кг	2	2024-07-26	49	Органик
781	35	259	39	326	240	упаковка	9	2024-07-22	42	
782	46	259	51	389	101	ящик	7	2024-07-10	53	
783	44	260	18	146	87	упаковка	5	2024-09-17	34	Органик
784	37	260	37	131	25	ящик	10	2024-07-03	41	
785	4	260	45	427	110	тонна	7	2024-10-28	47	Хранить в прохладном месте
786	20	260	42	494	62	кг	2	2024-07-23	47	Хранить в прохладном месте
787	1	261	32	418	233	упаковка	8	2024-09-06	35	Органик
788	39	261	18	44	1	кг	9	2024-07-06	30	Хранить в прохладном месте
789	2	261	88	106	93	ящик	9	2024-10-23	100	
790	47	261	39	211	170	тонна	6	2024-06-26	45	Без ГМО
791	34	262	99	346	162	кг	4	2024-06-23	107	Хранить в прохладном месте
792	40	262	10	305	22	тонна	9	2024-11-06	11	Без ГМО
793	35	262	16	304	97	кг	10	2024-08-31	18	Органик
794	17	262	10	192	16	кг	4	2024-10-19	16	Хранить в прохладном месте
795	36	263	40	477	442	кг	10	2024-06-25	48	
796	38	263	56	441	125	тонна	7	2024-11-19	65	Органик
797	48	264	38	440	23	упаковка	10	2024-06-06	44	Органик
798	4	264	22	149	108	упаковка	10	2024-08-04	33	Хранить в прохладном месте
799	1	264	32	397	392	кг	7	2024-06-24	40	Хранить в прохладном месте
800	22	264	14	404	77	упаковка	10	2024-10-15	23	Хранить в прохладном месте
801	4	265	61	107	70	кг	7	2024-07-16	69	
802	26	265	53	394	335	ящик	6	2024-10-09	72	Без ГМО
803	31	265	93	88	79	кг	7	2024-08-15	94	
804	8	265	57	418	221	кг	6	2024-09-16	64	Органик
805	8	266	96	245	9	тонна	3	2024-10-20	110	
806	15	266	18	107	24	упаковка	8	2024-10-08	19	Хранить в прохладном месте
807	42	266	65	82	30	тонна	6	2024-11-13	73	Без ГМО
808	47	267	43	389	131	кг	3	2024-11-11	63	Без ГМО
809	47	267	76	423	42	кг	9	2024-09-08	92	
810	6	268	21	46	7	тонна	4	2024-08-14	38	Без ГМО
811	22	268	14	47	12	упаковка	7	2024-07-13	15	Органик
812	18	268	39	161	76	упаковка	1	2024-06-19	50	
813	23	269	42	151	147	кг	6	2024-06-17	51	Без ГМО
814	9	269	78	244	29	тонна	8	2024-08-07	88	
815	41	269	33	75	75	кг	2	2024-10-09	47	Хранить в прохладном месте
816	42	270	95	482	78	упаковка	4	2024-08-09	102	
817	33	270	68	172	164	кг	7	2024-10-27	71	Без ГМО
818	47	270	66	326	10	ящик	5	2024-09-26	75	Хранить в прохладном месте
819	40	271	13	312	51	кг	8	2024-09-24	28	
820	14	271	57	98	68	тонна	10	2024-09-08	73	Органик
821	2	272	58	89	17	тонна	3	2024-08-12	77	
822	30	272	93	74	30	тонна	5	2024-06-16	96	Без ГМО
823	37	272	43	377	180	ящик	9	2024-09-30	47	Хранить в прохладном месте
824	5	273	78	278	211	ящик	10	2024-09-24	98	
825	3	273	69	109	9	упаковка	1	2024-09-06	76	Органик
826	26	274	66	365	325	тонна	7	2024-09-09	69	Без ГМО
827	11	274	94	77	62	тонна	6	2024-11-12	100	
828	15	274	79	187	187	кг	2	2024-08-26	87	
829	9	274	52	178	113	кг	5	2024-11-11	55	Хранить в прохладном месте
830	26	275	64	313	296	упаковка	6	2024-11-07	76	Органик
831	20	275	10	48	13	тонна	7	2024-06-05	11	
832	47	275	58	20	8	кг	1	2024-09-18	65	
833	34	276	29	330	24	ящик	4	2024-08-14	30	Хранить в прохладном месте
834	16	276	93	424	314	упаковка	9	2024-11-21	103	
835	36	276	50	251	28	кг	4	2024-07-02	64	Хранить в прохладном месте
836	4	276	50	101	7	кг	2	2024-11-22	64	
837	47	277	95	231	173	кг	2	2024-11-11	111	Органик
838	48	277	38	298	141	тонна	4	2024-09-23	51	Хранить в прохладном месте
839	1	278	38	488	425	тонна	3	2024-08-14	58	Без ГМО
840	20	278	91	328	207	кг	3	2024-11-22	96	
841	43	278	48	123	99	кг	2	2024-09-21	64	Без ГМО
842	13	279	88	292	34	ящик	4	2024-09-20	90	
843	48	279	48	359	14	ящик	7	2024-06-14	62	Хранить в прохладном месте
844	7	280	18	243	64	тонна	10	2024-10-22	25	Без ГМО
845	27	280	38	107	67	упаковка	8	2024-09-02	51	Хранить в прохладном месте
846	11	280	59	139	113	упаковка	2	2024-06-20	70	
847	25	280	86	318	123	ящик	3	2024-07-22	90	
848	19	281	91	96	0	кг	3	2024-09-18	99	
849	19	281	69	359	207	упаковка	10	2024-11-12	79	Без ГМО
850	1	281	16	204	98	упаковка	2	2024-08-11	17	
851	20	282	92	465	246	тонна	8	2024-09-17	105	Без ГМО
852	28	282	85	96	44	упаковка	9	2024-09-02	96	
853	33	282	94	466	160	упаковка	6	2024-07-04	111	Без ГМО
854	27	283	74	316	301	ящик	9	2024-09-16	77	Органик
855	28	283	20	399	134	ящик	3	2024-09-24	32	
856	20	283	94	285	171	упаковка	6	2024-11-17	107	Без ГМО
857	2	284	19	338	8	кг	8	2024-10-30	33	Хранить в прохладном месте
858	4	284	58	132	24	упаковка	9	2024-08-03	68	
859	16	285	59	141	90	ящик	2	2024-06-14	76	
860	33	285	40	247	151	тонна	8	2024-08-26	53	Органик
861	17	286	12	31	15	упаковка	3	2024-06-15	25	Хранить в прохладном месте
862	20	286	37	210	79	ящик	9	2024-07-12	38	Органик
863	27	286	24	144	81	кг	7	2024-06-24	30	
864	25	287	91	212	126	тонна	8	2024-06-22	95	
865	42	287	51	10	4	упаковка	5	2024-06-02	54	
866	11	288	52	384	45	упаковка	8	2024-09-07	60	Хранить в прохладном месте
867	6	288	97	387	36	тонна	4	2024-07-04	98	Хранить в прохладном месте
868	43	289	54	240	185	ящик	1	2024-10-23	59	
869	20	289	19	154	60	упаковка	1	2024-08-14	34	Без ГМО
870	3	289	75	212	17	кг	4	2024-11-19	85	Органик
871	13	290	32	212	108	ящик	5	2024-06-25	44	
872	29	290	91	346	170	тонна	1	2024-11-04	109	Хранить в прохладном месте
873	19	290	80	234	202	кг	4	2024-07-20	82	Без ГМО
874	31	291	29	322	258	тонна	2	2024-08-06	38	Органик
875	3	291	17	314	102	кг	1	2024-08-02	26	Без ГМО
876	39	292	49	84	52	кг	10	2024-06-25	50	
877	39	292	98	304	114	кг	3	2024-08-25	100	Хранить в прохладном месте
878	41	293	52	364	26	тонна	1	2024-07-08	58	Без ГМО
879	35	293	92	414	52	тонна	8	2024-07-13	100	
880	37	294	90	135	80	тонна	9	2024-11-08	97	
881	1	294	42	128	61	кг	10	2024-06-29	52	Без ГМО
882	42	294	74	331	111	упаковка	3	2024-11-01	79	
883	4	294	51	360	351	кг	10	2024-06-22	65	
884	28	295	48	116	57	тонна	5	2024-10-13	66	Органик
885	25	295	69	466	159	тонна	5	2024-11-04	74	Без ГМО
886	28	295	19	170	155	ящик	3	2024-09-20	35	
887	44	295	63	187	11	тонна	8	2024-06-26	73	
888	44	296	99	72	45	ящик	4	2024-07-18	104	Органик
889	26	296	12	213	153	кг	3	2024-09-07	25	Органик
890	34	296	92	461	100	кг	3	2024-10-31	94	
891	35	296	73	28	21	тонна	1	2024-08-12	80	
892	13	297	64	211	109	упаковка	8	2024-08-30	79	Без ГМО
893	9	297	95	338	323	кг	5	2024-07-31	99	Хранить в прохладном месте
894	9	297	22	434	16	кг	10	2024-07-12	26	Органик
895	24	297	88	119	49	тонна	4	2024-09-04	99	Без ГМО
896	9	298	66	352	43	ящик	6	2024-06-04	84	
897	16	298	20	218	63	кг	9	2024-09-07	39	Органик
898	15	299	22	327	141	ящик	8	2024-11-15	26	Без ГМО
899	21	299	47	17	8	ящик	6	2024-10-27	56	Хранить в прохладном месте
900	12	299	84	139	85	кг	2	2024-10-16	102	Без ГМО
901	37	299	67	310	151	ящик	10	2024-08-21	78	Хранить в прохладном месте
902	31	300	90	377	58	упаковка	2	2024-10-15	98	
903	47	300	33	451	341	ящик	9	2024-06-16	35	Органик
904	19	300	73	434	97	кг	1	2024-07-31	77	Органик
905	7	300	15	41	5	кг	6	2024-06-05	33	Без ГМО
906	43	301	37	104	13	кг	5	2024-11-21	50	
907	1	301	28	25	22	тонна	10	2024-07-09	34	Без ГМО
908	7	301	15	458	199	тонна	10	2024-06-27	19	Хранить в прохладном месте
909	20	302	86	468	290	ящик	1	2024-07-19	99	Без ГМО
910	21	302	43	75	14	тонна	5	2024-06-17	51	Без ГМО
911	16	302	54	153	82	упаковка	2	2024-08-23	64	Органик
1077	47	358	80	176	74	упаковка	4	2024-10-26	93	Органик
912	44	302	13	154	106	ящик	2	2024-09-13	26	Хранить в прохладном месте
913	18	303	35	84	3	кг	8	2024-09-10	43	
914	31	303	89	31	6	тонна	8	2024-10-05	103	Хранить в прохладном месте
915	25	303	90	436	188	кг	3	2024-06-03	94	
916	33	303	59	208	205	упаковка	1	2024-06-25	63	Без ГМО
917	37	304	48	148	91	ящик	9	2024-07-30	67	Хранить в прохладном месте
918	33	304	85	220	68	упаковка	5	2024-08-31	99	Хранить в прохладном месте
919	3	305	41	39	3	ящик	10	2024-09-04	52	Хранить в прохладном месте
920	27	305	99	280	79	упаковка	2	2024-08-09	102	
921	1	306	36	343	89	упаковка	5	2024-06-05	46	
922	36	306	88	261	44	упаковка	6	2024-11-04	106	
923	36	307	87	360	250	тонна	8	2024-09-10	93	
924	18	307	11	290	42	кг	9	2024-09-27	27	
925	10	308	28	417	385	упаковка	2	2024-07-06	38	Без ГМО
926	8	308	22	149	66	упаковка	9	2024-07-27	29	Хранить в прохладном месте
927	42	309	68	165	164	ящик	2	2024-08-26	81	Органик
928	8	309	31	251	45	упаковка	2	2024-07-13	33	Хранить в прохладном месте
929	10	310	36	30	0	кг	8	2024-07-26	50	
930	10	310	37	132	42	упаковка	2	2024-07-13	43	
931	21	311	27	324	256	упаковка	9	2024-06-16	41	
932	29	311	62	216	123	тонна	2	2024-09-05	76	
933	23	311	15	102	57	тонна	6	2024-08-19	25	Органик
934	40	311	50	231	179	кг	3	2024-07-26	59	Органик
935	26	312	82	393	362	упаковка	4	2024-08-17	88	
936	21	312	60	302	197	тонна	3	2024-08-31	61	
937	35	312	37	380	332	ящик	7	2024-09-21	39	Без ГМО
938	4	313	57	128	87	тонна	10	2024-07-06	67	
939	3	313	96	285	235	упаковка	7	2024-10-22	112	
940	33	313	94	342	39	тонна	9	2024-08-03	100	Органик
941	41	314	100	362	349	ящик	3	2024-06-05	112	Органик
942	31	314	87	244	67	тонна	4	2024-10-03	107	
943	43	314	78	61	4	кг	5	2024-09-13	80	Без ГМО
944	32	314	41	263	110	ящик	9	2024-06-11	53	Без ГМО
945	48	315	31	11	1	упаковка	10	2024-06-01	44	
946	3	315	65	224	178	кг	1	2024-07-18	74	
947	25	315	65	159	61	тонна	4	2024-11-20	69	
948	44	315	71	348	314	кг	5	2024-07-05	85	Без ГМО
949	42	316	41	125	115	упаковка	8	2024-11-23	43	
950	12	316	54	421	144	ящик	2	2024-06-11	59	Хранить в прохладном месте
951	19	316	24	351	154	тонна	6	2024-08-18	40	Без ГМО
952	27	316	24	424	111	ящик	4	2024-06-27	40	Хранить в прохладном месте
953	9	317	63	267	255	упаковка	9	2024-07-13	74	Органик
954	26	317	55	394	368	кг	2	2024-06-08	60	Без ГМО
955	39	318	61	68	62	кг	5	2024-08-11	73	Хранить в прохладном месте
956	4	318	82	115	55	упаковка	1	2024-06-15	101	
957	1	318	86	394	250	тонна	2	2024-10-17	98	
958	8	318	24	220	39	упаковка	6	2024-07-14	31	Без ГМО
959	7	319	27	204	94	тонна	1	2024-06-01	31	Хранить в прохладном месте
960	31	319	100	394	244	упаковка	3	2024-08-09	109	Без ГМО
961	7	319	12	224	133	ящик	1	2024-09-30	29	
962	47	320	76	360	37	ящик	4	2024-09-03	93	Без ГМО
963	11	320	39	302	147	тонна	10	2024-06-25	49	
964	11	321	19	315	128	упаковка	6	2024-07-02	35	Хранить в прохладном месте
965	14	321	22	212	131	ящик	1	2024-10-05	37	Без ГМО
966	7	321	87	391	25	ящик	10	2024-07-07	89	Органик
967	8	322	56	158	58	кг	7	2024-06-11	66	Без ГМО
968	7	322	43	35	32	упаковка	6	2024-07-25	63	Без ГМО
969	16	322	42	309	74	тонна	2	2024-11-02	54	
970	47	322	90	215	215	кг	4	2024-11-02	98	Органик
971	16	323	56	265	237	кг	3	2024-06-30	75	Хранить в прохладном месте
972	32	323	14	412	44	кг	2	2024-08-12	15	Хранить в прохладном месте
973	9	323	30	486	245	кг	6	2024-07-18	34	
974	3	324	46	339	71	кг	5	2024-08-08	66	Без ГМО
975	18	324	14	198	40	тонна	1	2024-10-15	34	Органик
976	39	324	79	494	77	тонна	9	2024-08-13	99	Без ГМО
977	39	325	35	298	98	тонна	4	2024-11-14	46	Органик
978	16	325	26	318	294	ящик	2	2024-10-12	34	Хранить в прохладном месте
979	9	325	50	197	107	ящик	6	2024-09-24	65	Хранить в прохладном месте
980	13	325	73	171	24	кг	6	2024-07-29	90	Органик
981	30	326	13	45	38	тонна	8	2024-11-03	31	Органик
982	20	326	69	124	39	тонна	4	2024-11-16	75	Органик
983	19	327	18	319	19	тонна	8	2024-11-22	37	
984	12	327	58	293	270	кг	10	2024-09-24	69	
985	39	328	93	173	18	упаковка	2	2024-07-14	94	Хранить в прохладном месте
986	6	328	55	213	100	кг	3	2024-08-11	71	Хранить в прохладном месте
987	9	329	74	269	210	упаковка	10	2024-07-03	81	
988	31	329	18	66	51	упаковка	10	2024-09-15	20	Без ГМО
989	45	329	86	271	8	тонна	4	2024-07-13	101	Органик
990	44	329	98	127	120	ящик	6	2024-06-23	109	Без ГМО
991	20	330	56	437	360	тонна	4	2024-09-17	67	Без ГМО
992	42	330	60	181	51	кг	7	2024-07-31	65	
993	46	330	63	145	53	тонна	4	2024-08-30	69	Без ГМО
994	17	330	61	212	41	упаковка	3	2024-11-02	73	Хранить в прохладном месте
995	34	331	13	314	103	упаковка	3	2024-06-30	30	
996	34	331	24	135	89	тонна	5	2024-08-04	40	Органик
997	1	331	12	441	340	кг	9	2024-09-13	30	Органик
998	36	332	29	468	32	ящик	9	2024-10-08	43	Органик
999	33	332	75	209	199	кг	9	2024-07-28	95	Органик
1000	40	333	89	252	234	упаковка	10	2024-06-24	98	Без ГМО
1001	16	333	30	389	207	упаковка	4	2024-07-08	42	
1002	33	333	42	163	101	упаковка	9	2024-08-11	58	Хранить в прохладном месте
1003	3	334	58	166	13	кг	3	2024-07-28	63	
1004	7	334	35	465	228	упаковка	3	2024-11-21	54	Без ГМО
1005	38	334	55	191	19	ящик	5	2024-06-20	71	Хранить в прохладном месте
1006	20	335	48	17	2	тонна	5	2024-08-21	51	Без ГМО
1007	38	335	61	91	13	кг	2	2024-07-26	64	Хранить в прохладном месте
1008	35	336	86	79	67	упаковка	9	2024-07-24	105	Без ГМО
1009	33	336	75	316	83	тонна	6	2024-10-25	94	
1010	22	336	77	301	40	ящик	4	2024-10-31	78	Хранить в прохладном месте
1011	28	337	34	223	93	ящик	4	2024-07-31	40	
1012	37	337	36	386	244	кг	8	2024-08-23	44	Органик
1013	41	338	70	486	465	кг	5	2024-10-21	86	Хранить в прохладном месте
1014	33	338	28	293	83	кг	8	2024-09-10	29	Органик
1015	9	338	62	48	10	тонна	1	2024-07-11	80	
1016	40	339	44	306	91	ящик	2	2024-06-04	55	Без ГМО
1017	17	339	32	212	157	ящик	10	2024-09-06	49	
1018	26	340	42	487	112	ящик	3	2024-09-09	51	Хранить в прохладном месте
1019	5	340	82	252	63	упаковка	10	2024-11-08	90	Хранить в прохладном месте
1020	17	341	49	255	56	ящик	8	2024-08-17	57	Без ГМО
1021	9	341	44	179	111	тонна	3	2024-06-02	64	Органик
1022	8	342	65	271	206	упаковка	5	2024-06-16	78	Без ГМО
1023	3	342	34	195	60	тонна	3	2024-08-19	52	Без ГМО
1024	18	343	26	227	114	тонна	3	2024-07-14	29	Органик
1025	46	343	83	310	51	ящик	7	2024-10-31	87	Хранить в прохладном месте
1026	1	343	85	486	474	кг	10	2024-11-10	105	Органик
1027	22	344	53	495	235	упаковка	6	2024-06-11	71	Органик
1028	3	344	59	294	84	упаковка	8	2024-08-11	68	
1029	29	344	23	369	129	упаковка	4	2024-07-19	41	
1030	25	345	19	413	377	упаковка	6	2024-09-18	28	Органик
1031	20	345	54	246	235	ящик	8	2024-09-13	59	
1032	23	345	71	11	5	тонна	6	2024-06-23	74	
1033	24	346	92	425	165	кг	10	2024-07-29	97	Органик
1034	13	346	48	287	228	тонна	2	2024-11-23	62	
1035	25	346	74	154	114	ящик	3	2024-07-01	85	
1036	32	346	45	469	260	ящик	3	2024-10-08	61	Органик
1037	43	347	82	460	206	ящик	7	2024-07-30	95	Хранить в прохладном месте
1038	23	347	89	415	9	ящик	4	2024-07-24	95	Органик
1039	24	347	64	205	4	ящик	3	2024-08-11	66	Органик
1040	7	347	70	111	3	упаковка	1	2024-09-28	71	
1041	21	348	52	34	34	упаковка	3	2024-09-10	61	
1042	22	348	99	263	236	кг	3	2024-06-15	102	
1043	16	348	43	171	27	тонна	7	2024-11-02	44	Органик
1044	36	348	85	432	417	упаковка	4	2024-09-26	90	Хранить в прохладном месте
1045	26	349	36	178	154	тонна	9	2024-11-22	39	
1046	45	349	89	33	17	ящик	7	2024-10-01	94	Хранить в прохладном месте
1047	4	350	28	315	250	тонна	7	2024-07-13	46	Хранить в прохладном месте
1048	41	350	13	167	33	упаковка	4	2024-11-23	19	Без ГМО
1049	25	350	26	438	238	кг	5	2024-10-09	42	
1050	47	350	13	13	13	ящик	6	2024-06-22	25	Органик
1051	14	351	61	176	167	кг	8	2024-07-09	78	Органик
1052	5	351	32	191	119	упаковка	8	2024-11-04	44	Хранить в прохладном месте
1053	26	351	61	347	249	кг	6	2024-08-28	76	
1054	40	351	100	249	242	тонна	1	2024-10-21	102	
1055	11	352	97	272	25	ящик	6	2024-06-09	117	Без ГМО
1056	17	352	79	191	171	кг	2	2024-08-18	98	Органик
1057	39	352	17	464	359	кг	9	2024-10-27	28	
1058	35	353	86	41	8	упаковка	1	2024-11-19	104	Органик
1059	17	353	53	95	10	упаковка	10	2024-09-05	63	Без ГМО
1060	11	353	71	130	108	ящик	6	2024-11-15	77	
1061	33	353	97	492	382	тонна	4	2024-10-24	107	Хранить в прохладном месте
1062	1	354	61	112	71	тонна	2	2024-06-14	79	Органик
1063	36	354	63	52	21	кг	2	2024-07-27	75	Без ГМО
1064	32	354	57	373	76	ящик	9	2024-10-26	66	Хранить в прохладном месте
1065	27	354	83	88	30	упаковка	8	2024-09-01	85	Без ГМО
1066	17	355	17	422	391	кг	4	2024-07-25	21	
1067	21	355	66	187	120	ящик	3	2024-08-20	80	
1068	6	356	27	344	60	упаковка	8	2024-11-16	35	Без ГМО
1069	2	356	55	120	113	ящик	10	2024-10-26	58	Без ГМО
1070	7	356	88	265	140	кг	3	2024-08-30	89	Без ГМО
1071	5	356	78	263	69	кг	2	2024-10-20	85	Без ГМО
1072	32	357	100	136	49	ящик	1	2024-06-27	117	Органик
1073	9	357	12	466	459	кг	3	2024-06-27	31	Органик
1074	16	357	47	415	357	кг	9	2024-06-27	59	
1075	30	357	26	171	125	ящик	6	2024-10-04	28	Органик
1076	7	358	21	137	51	кг	6	2024-10-31	26	
1078	16	359	97	126	98	кг	5	2024-10-25	102	Органик
1079	19	359	81	375	45	ящик	7	2024-09-14	95	
1080	35	359	41	20	2	кг	1	2024-11-23	46	
1081	38	360	34	499	489	ящик	4	2024-10-19	36	Хранить в прохладном месте
1082	44	360	39	113	37	тонна	2	2024-06-25	40	Без ГМО
1083	42	360	27	175	53	упаковка	4	2024-08-07	29	Органик
1084	5	361	66	382	142	кг	2	2024-08-03	74	
1085	16	361	53	136	122	тонна	7	2024-07-27	59	
1086	15	362	49	385	95	тонна	8	2024-06-08	59	Органик
1087	3	362	65	59	9	тонна	8	2024-08-29	81	Органик
1088	3	362	53	245	161	тонна	1	2024-09-05	66	Хранить в прохладном месте
1089	2	363	67	317	12	упаковка	10	2024-08-19	79	
1090	30	363	24	89	42	упаковка	8	2024-07-03	42	Хранить в прохладном месте
1091	28	364	35	389	119	упаковка	9	2024-11-19	47	Без ГМО
1092	28	364	99	162	64	тонна	4	2024-07-27	112	
1093	18	364	100	196	10	тонна	7	2024-11-16	107	
1094	44	365	87	116	25	упаковка	2	2024-10-22	90	Хранить в прохладном месте
1095	12	365	68	81	58	ящик	9	2024-07-05	71	Органик
1096	39	365	54	242	194	ящик	1	2024-07-25	69	
1097	34	366	30	88	51	ящик	3	2024-08-09	35	Без ГМО
1098	6	366	83	414	241	кг	6	2024-08-31	99	Без ГМО
1099	11	366	63	283	152	кг	4	2024-09-25	67	Без ГМО
1100	2	367	52	325	322	кг	4	2024-06-02	60	
1101	45	367	27	88	18	ящик	4	2024-11-04	43	
1102	22	368	83	44	30	кг	8	2024-08-11	97	
1103	7	368	49	67	48	упаковка	4	2024-11-02	67	Хранить в прохладном месте
1104	7	369	32	174	45	ящик	5	2024-07-21	50	
1105	26	369	10	391	363	тонна	8	2024-10-03	22	Без ГМО
1106	23	369	69	458	294	кг	10	2024-08-03	88	Без ГМО
1107	33	370	89	421	416	кг	7	2024-07-19	97	
1108	31	370	99	124	114	тонна	4	2024-06-23	106	Без ГМО
1109	31	370	93	187	164	ящик	1	2024-06-20	96	
1110	10	370	82	409	52	кг	3	2024-07-03	90	
1111	48	371	100	197	126	тонна	1	2024-10-23	102	Без ГМО
1112	1	371	63	60	5	кг	10	2024-06-24	82	Без ГМО
1113	7	372	87	417	159	ящик	5	2024-06-13	100	
1114	10	372	94	331	248	упаковка	7	2024-10-08	103	
1115	45	373	58	478	437	ящик	6	2024-10-07	63	
1116	37	373	65	93	25	ящик	1	2024-10-31	66	Хранить в прохладном месте
1117	6	374	54	222	94	ящик	3	2024-10-21	71	
1118	33	374	31	93	36	тонна	4	2024-08-22	34	Без ГМО
1119	48	374	31	64	0	тонна	1	2024-08-19	51	Хранить в прохладном месте
1120	14	374	63	95	33	ящик	3	2024-09-04	83	
1121	20	375	61	148	112	кг	2	2024-06-08	71	
1122	20	375	26	162	22	тонна	9	2024-07-12	29	
1123	29	376	95	292	150	упаковка	2	2024-08-20	112	
1124	40	376	72	96	18	ящик	9	2024-07-16	84	Без ГМО
1125	24	377	95	212	192	кг	1	2024-10-04	107	Хранить в прохладном месте
1126	8	377	20	241	101	упаковка	3	2024-09-15	33	
1127	40	378	21	406	144	тонна	5	2024-09-29	23	
1128	7	378	53	345	136	упаковка	10	2024-07-27	60	
1129	48	379	81	281	217	кг	6	2024-09-15	89	
1130	32	379	57	363	325	упаковка	6	2024-06-14	60	
1131	32	379	80	385	309	упаковка	5	2024-08-27	88	Органик
1132	43	380	80	481	63	тонна	5	2024-09-21	93	Без ГМО
1133	34	380	15	304	211	кг	2	2024-07-29	33	Органик
1134	3	380	54	174	114	тонна	1	2024-06-11	66	
1135	33	380	24	153	136	тонна	5	2024-06-24	27	
1136	35	381	88	474	39	тонна	5	2024-11-04	96	Без ГМО
1137	48	381	70	398	16	тонна	7	2024-10-17	82	Органик
1138	30	381	20	226	139	ящик	3	2024-10-04	37	Органик
1139	31	382	43	175	65	кг	6	2024-10-28	50	
1140	18	382	92	268	248	кг	4	2024-10-07	97	Без ГМО
1141	16	382	28	28	0	упаковка	6	2024-08-26	32	Органик
1142	20	382	84	72	54	ящик	1	2024-06-21	93	Хранить в прохладном месте
1143	18	383	45	259	61	кг	7	2024-07-01	54	Хранить в прохладном месте
1144	24	383	23	467	321	ящик	8	2024-08-10	25	Органик
1145	1	383	64	160	97	кг	8	2024-10-27	66	Хранить в прохладном месте
1146	25	383	92	432	45	кг	1	2024-06-19	106	Без ГМО
1147	3	384	89	15	8	упаковка	10	2024-06-12	92	Без ГМО
1148	22	384	32	262	74	кг	7	2024-10-25	52	
1149	46	385	84	108	45	кг	9	2024-08-21	88	Хранить в прохладном месте
1150	48	385	95	101	60	ящик	1	2024-06-26	104	Без ГМО
1151	13	385	26	92	60	тонна	3	2024-09-20	37	Органик
1152	47	385	89	242	98	тонна	9	2024-08-17	95	
1153	6	386	23	107	97	упаковка	8	2024-09-19	25	Органик
1154	47	386	55	437	407	упаковка	7	2024-09-16	73	
1155	12	386	19	146	66	упаковка	5	2024-08-03	34	
1156	26	387	48	212	38	тонна	4	2024-06-02	68	
1157	16	387	97	128	34	кг	9	2024-07-18	116	Органик
1158	35	387	68	373	51	ящик	6	2024-08-22	77	
1159	7	387	100	479	242	ящик	9	2024-10-01	117	Без ГМО
1160	42	388	100	491	430	ящик	4	2024-10-18	107	Без ГМО
1161	2	388	66	405	62	кг	2	2024-08-15	74	Без ГМО
1162	4	388	48	27	3	ящик	2	2024-08-01	54	Без ГМО
1163	8	389	44	404	332	ящик	2	2024-08-16	48	Без ГМО
1164	33	389	15	173	52	упаковка	6	2024-08-23	21	Хранить в прохладном месте
1165	43	389	63	429	391	кг	5	2024-11-14	66	Без ГМО
1166	32	389	58	242	35	тонна	3	2024-10-19	70	Хранить в прохладном месте
1167	41	390	32	356	227	упаковка	5	2024-08-12	35	
1168	31	390	51	127	21	кг	2	2024-06-02	58	Органик
1169	41	390	41	401	54	кг	10	2024-11-18	46	
1170	26	391	90	73	46	ящик	1	2024-07-27	96	Органик
1171	11	391	42	207	7	упаковка	5	2024-11-14	48	
1172	36	391	51	67	0	тонна	10	2024-10-29	71	
1173	8	392	28	280	180	ящик	4	2024-09-28	39	
1174	42	392	87	465	99	тонна	5	2024-09-16	92	Органик
1175	29	393	40	85	64	упаковка	9	2024-10-06	44	
1176	45	393	54	77	1	упаковка	9	2024-09-07	63	Без ГМО
1177	7	393	71	408	277	тонна	5	2024-11-23	82	Без ГМО
1178	40	394	65	232	55	тонна	8	2024-10-19	74	Органик
1179	24	394	32	471	333	тонна	7	2024-11-27	44	Хранить в прохладном месте
1180	48	394	37	412	217	тонна	6	2024-08-19	55	
1181	35	394	72	249	127	ящик	2	2024-07-13	83	Органик
1182	8	395	17	387	369	упаковка	7	2024-11-21	36	Без ГМО
1183	25	395	32	460	381	кг	8	2024-06-21	40	Без ГМО
1184	25	395	64	144	113	ящик	8	2024-07-09	72	
1185	2	396	62	283	223	упаковка	3	2024-10-20	75	
1186	42	396	56	153	116	кг	9	2024-11-19	65	
1187	35	396	26	275	74	кг	5	2024-09-18	34	Хранить в прохладном месте
1188	29	397	74	168	111	кг	5	2024-09-02	78	Органик
1189	1	397	92	73	55	кг	10	2024-09-15	111	
1190	42	398	15	482	322	тонна	10	2024-09-30	32	Без ГМО
1191	25	398	100	459	37	кг	8	2024-06-04	110	Без ГМО
1192	36	399	20	253	133	упаковка	9	2024-07-13	28	Органик
1193	7	399	76	251	197	упаковка	2	2024-06-16	91	Органик
1194	24	400	40	73	51	кг	4	2024-08-27	56	
1195	11	400	95	459	291	тонна	7	2024-07-23	112	
1196	36	400	85	335	74	упаковка	3	2024-08-30	105	Хранить в прохладном месте
1197	15	400	77	287	84	кг	1	2024-08-09	78	Без ГМО
1198	19	401	10	321	278	тонна	5	2024-09-03	26	Хранить в прохладном месте
1199	21	401	87	400	350	упаковка	4	2024-07-31	91	Органик
1200	8	401	25	442	315	упаковка	6	2024-08-16	33	
1201	39	402	33	262	103	тонна	8	2024-09-28	53	
1202	5	402	72	239	108	кг	1	2024-06-12	89	
1203	46	402	14	168	69	кг	4	2024-06-10	32	
1204	37	403	24	327	260	кг	8	2024-07-05	25	Хранить в прохладном месте
1205	46	403	17	119	14	упаковка	2	2024-11-05	36	
1206	47	403	47	366	11	кг	2	2024-09-27	55	Без ГМО
1207	25	403	44	72	9	ящик	3	2024-08-19	60	Хранить в прохладном месте
1208	30	404	30	180	101	упаковка	8	2024-08-02	41	
1209	33	404	72	390	327	тонна	4	2024-09-26	80	Органик
1210	2	404	14	14	4	ящик	4	2024-07-26	15	
1211	6	404	70	194	32	тонна	7	2024-11-03	85	Хранить в прохладном месте
1212	45	405	94	35	1	кг	5	2024-07-11	96	
1213	30	405	88	270	232	кг	2	2024-06-06	91	Органик
1214	16	405	87	444	31	кг	4	2024-06-14	102	
1215	18	405	46	349	170	упаковка	5	2024-11-23	65	
1216	23	406	55	263	101	тонна	10	2024-08-24	74	Хранить в прохладном месте
1217	6	406	36	464	33	ящик	3	2024-11-04	41	Без ГМО
1218	44	406	99	118	66	упаковка	8	2024-07-21	119	
1219	37	407	96	239	197	тонна	10	2024-11-04	107	
1220	4	407	10	482	166	ящик	1	2024-09-29	28	
1221	5	407	39	398	197	упаковка	10	2024-06-10	47	Без ГМО
1222	5	407	88	320	53	кг	1	2024-10-17	98	
1223	25	408	15	260	201	ящик	9	2024-06-20	16	Органик
1224	22	408	62	414	203	упаковка	10	2024-07-18	72	Без ГМО
1225	44	408	97	447	445	ящик	7	2024-11-20	100	
1226	36	408	31	96	23	тонна	10	2024-06-03	33	
1227	7	409	44	357	269	ящик	10	2024-11-07	58	Органик
1228	48	409	70	259	2	тонна	7	2024-07-12	79	Без ГМО
1229	45	410	27	346	53	тонна	1	2024-10-01	39	
1230	29	410	22	208	178	ящик	3	2024-08-16	36	Без ГМО
1231	15	410	84	394	52	ящик	7	2024-10-20	97	
1232	35	410	91	106	4	упаковка	1	2024-10-30	92	Без ГМО
1233	23	411	28	103	5	ящик	9	2024-10-28	40	Хранить в прохладном месте
1234	4	411	29	234	199	упаковка	3	2024-07-17	41	
1235	28	411	24	444	103	упаковка	6	2024-10-11	44	
1236	48	412	70	250	70	тонна	6	2024-11-28	84	
1237	9	412	27	271	34	тонна	7	2024-10-09	30	Органик
1238	21	412	79	219	6	упаковка	10	2024-10-30	89	Органик
1239	21	413	39	40	39	упаковка	5	2024-09-26	48	Хранить в прохладном месте
1240	29	413	36	372	262	тонна	2	2024-11-16	55	Хранить в прохладном месте
1241	42	414	81	306	31	упаковка	2	2024-06-06	99	Хранить в прохладном месте
1242	19	414	51	132	55	упаковка	5	2024-06-09	62	
1243	8	415	71	152	40	ящик	4	2024-08-08	77	
1244	42	415	80	21	2	ящик	7	2024-06-07	85	Хранить в прохладном месте
1245	14	416	57	163	44	упаковка	10	2024-11-01	75	Хранить в прохладном месте
1246	4	416	27	381	309	упаковка	2	2024-11-03	44	Без ГМО
1247	41	416	26	495	107	тонна	5	2024-09-10	37	Органик
1248	12	416	54	299	242	кг	3	2024-09-19	60	Хранить в прохладном месте
1249	16	417	35	69	24	упаковка	9	2024-06-06	42	Органик
1250	46	417	44	292	126	упаковка	7	2024-07-04	47	Органик
1251	2	417	70	234	173	упаковка	4	2024-06-02	77	Хранить в прохладном месте
1252	8	418	100	82	39	упаковка	7	2024-10-18	118	
1253	36	418	31	242	24	кг	5	2024-09-30	40	Органик
1254	40	418	93	295	288	ящик	5	2024-09-03	112	Органик
1255	26	418	23	221	17	тонна	5	2024-11-08	27	Хранить в прохладном месте
1256	24	419	34	115	63	ящик	10	2024-09-17	42	Хранить в прохладном месте
1257	10	419	57	134	99	тонна	6	2024-08-05	74	Без ГМО
1258	29	419	45	133	27	ящик	5	2024-09-15	55	
1259	46	419	12	101	73	тонна	3	2024-09-14	13	Органик
1260	8	420	80	341	312	ящик	3	2024-11-11	96	
1261	12	420	78	196	101	ящик	6	2024-09-19	83	
1262	38	420	22	460	64	упаковка	9	2024-08-05	39	
1263	21	420	82	389	306	кг	7	2024-07-06	83	
1264	3	421	77	302	190	тонна	8	2024-07-18	78	Хранить в прохладном месте
1265	10	421	50	433	251	тонна	5	2024-09-11	61	Без ГМО
1266	27	421	43	237	155	тонна	8	2024-07-28	44	Органик
1267	35	421	22	475	104	кг	7	2024-11-16	33	Без ГМО
1268	46	422	19	299	128	тонна	5	2024-06-17	26	Хранить в прохладном месте
1269	6	422	11	18	10	кг	6	2024-08-10	17	Хранить в прохладном месте
1270	14	422	30	434	15	упаковка	2	2024-08-10	40	Без ГМО
1271	32	423	81	184	68	упаковка	6	2024-09-20	98	Без ГМО
1272	6	423	57	254	128	тонна	10	2024-07-17	74	Хранить в прохладном месте
1273	33	423	76	153	93	упаковка	10	2024-08-11	90	Органик
1274	2	423	58	198	122	тонна	8	2024-10-31	72	
1275	5	424	51	241	91	кг	2	2024-08-07	60	Без ГМО
1276	21	424	85	271	56	кг	1	2024-08-27	91	Хранить в прохладном месте
1277	40	425	26	242	166	кг	10	2024-10-28	43	
1278	46	425	100	427	320	упаковка	3	2024-09-22	114	
1279	24	426	99	113	9	упаковка	3	2024-11-06	101	
1280	40	426	72	481	364	кг	3	2024-09-05	89	
1281	39	426	62	184	177	упаковка	3	2024-11-12	79	Хранить в прохладном месте
1282	6	426	35	471	462	тонна	9	2024-10-31	38	
1283	46	427	81	344	117	упаковка	1	2024-06-21	90	
1284	44	427	27	301	52	ящик	9	2024-10-05	32	Органик
1285	48	428	93	250	212	тонна	2	2024-08-17	94	Органик
1286	10	428	59	277	196	упаковка	4	2024-09-24	64	Без ГМО
1287	32	428	20	93	8	ящик	10	2024-09-04	24	
1288	3	429	76	67	40	кг	10	2024-06-28	93	Без ГМО
1289	45	429	61	403	321	тонна	5	2024-07-14	69	Хранить в прохладном месте
1290	26	429	82	186	53	тонна	2	2024-08-05	84	Хранить в прохладном месте
1291	19	429	26	432	211	тонна	6	2024-09-18	38	Без ГМО
1292	32	430	14	392	30	кг	7	2024-10-27	27	Без ГМО
1293	35	430	35	122	59	ящик	10	2024-10-26	47	Без ГМО
1294	30	430	90	235	198	кг	5	2024-06-05	105	
1295	7	431	22	450	18	тонна	2	2024-09-22	23	Хранить в прохладном месте
1296	1	431	91	500	359	тонна	2	2024-07-21	94	Без ГМО
1297	3	431	86	298	268	упаковка	6	2024-09-30	98	
1298	31	432	42	39	37	ящик	10	2024-09-20	61	Хранить в прохладном месте
1299	38	432	65	305	197	кг	5	2024-06-06	66	Без ГМО
1300	8	432	37	443	80	упаковка	9	2024-06-19	50	Органик
1301	9	432	18	297	77	упаковка	4	2024-10-15	30	
1302	14	433	35	331	317	упаковка	2	2024-11-07	37	Органик
1303	10	433	54	249	86	кг	1	2024-11-16	71	Хранить в прохладном месте
1304	23	433	43	124	9	упаковка	8	2024-07-06	57	
1305	15	433	36	399	134	упаковка	8	2024-11-27	50	Хранить в прохладном месте
1306	35	434	18	140	116	ящик	6	2024-10-02	35	Хранить в прохладном месте
1307	42	434	49	230	117	ящик	1	2024-09-01	59	
1308	33	434	56	36	2	тонна	4	2024-07-16	72	Органик
1309	48	435	53	177	139	упаковка	3	2024-11-20	68	Хранить в прохладном месте
1310	40	435	38	231	155	ящик	4	2024-06-23	50	Органик
1311	7	435	79	250	118	кг	10	2024-06-03	88	Хранить в прохладном месте
1312	14	436	23	326	219	кг	3	2024-08-21	43	
1313	35	436	38	298	250	тонна	3	2024-10-23	43	Хранить в прохладном месте
1314	1	437	100	198	4	ящик	9	2024-10-15	120	Без ГМО
1315	32	437	71	144	87	тонна	4	2024-06-03	91	Органик
1316	11	438	94	357	80	ящик	1	2024-11-17	97	
1317	22	438	70	216	186	кг	3	2024-08-02	78	Без ГМО
1318	3	438	26	16	0	тонна	3	2024-11-12	42	Хранить в прохладном месте
1319	18	439	34	162	85	упаковка	3	2024-11-09	40	
1320	4	439	35	267	132	кг	5	2024-06-04	38	
1321	15	440	46	414	191	упаковка	6	2024-10-11	56	Органик
1322	47	440	73	144	110	ящик	7	2024-11-03	85	Без ГМО
1323	12	440	95	167	18	кг	5	2024-09-20	114	
1324	19	440	80	37	2	кг	6	2024-06-10	95	Хранить в прохладном месте
1325	7	441	45	316	214	упаковка	5	2024-06-15	59	Хранить в прохладном месте
1326	9	441	72	149	74	кг	1	2024-10-05	84	
1327	47	441	88	212	2	упаковка	3	2024-11-08	98	
1328	10	441	42	170	7	упаковка	10	2024-10-23	58	Органик
1329	43	442	79	218	35	кг	9	2024-07-18	93	
1330	44	442	71	167	25	кг	7	2024-08-02	75	
1331	24	442	38	90	74	ящик	9	2024-09-13	40	
1332	44	442	18	308	185	ящик	7	2024-11-25	30	Органик
1333	23	443	12	414	16	ящик	8	2024-06-12	31	Хранить в прохладном месте
1334	6	443	56	491	188	упаковка	5	2024-08-20	58	Органик
1335	11	443	41	71	19	кг	9	2024-09-15	48	Хранить в прохладном месте
1336	21	443	71	261	80	тонна	4	2024-11-08	75	Без ГМО
1337	21	444	33	406	65	ящик	7	2024-09-29	42	
1338	11	444	42	413	63	упаковка	9	2024-08-19	59	
1339	29	445	22	296	255	ящик	4	2024-09-29	28	
1340	10	445	59	126	117	тонна	5	2024-10-10	70	Хранить в прохладном месте
1341	13	445	38	107	22	ящик	2	2024-11-17	41	Хранить в прохладном месте
1342	42	445	73	22	5	тонна	8	2024-07-31	77	
1343	14	446	100	421	93	кг	8	2024-06-13	105	Органик
1344	27	446	21	74	50	кг	1	2024-06-05	26	
1345	42	446	100	83	47	ящик	1	2024-07-03	111	
1346	30	446	36	439	347	упаковка	10	2024-06-23	42	
1347	32	447	92	107	98	упаковка	3	2024-09-23	107	Органик
1348	12	447	79	135	5	упаковка	4	2024-10-04	94	
1349	32	447	13	239	164	упаковка	9	2024-08-21	33	Без ГМО
1350	44	447	56	104	23	кг	3	2024-07-24	63	
1351	4	448	31	44	32	кг	7	2024-06-28	45	Хранить в прохладном месте
1352	24	448	23	155	123	упаковка	10	2024-08-06	33	
1353	23	448	10	281	186	кг	3	2024-06-26	23	Без ГМО
1354	7	448	95	456	195	упаковка	4	2024-07-02	101	
1355	9	449	70	56	1	упаковка	9	2024-11-15	79	Без ГМО
1356	24	449	73	402	150	ящик	8	2024-07-10	79	Без ГМО
1357	5	450	23	469	155	кг	10	2024-07-09	33	
1358	43	450	95	57	19	ящик	9	2024-08-02	108	
1359	45	450	31	324	208	кг	10	2024-06-06	42	
1360	13	450	86	98	44	тонна	3	2024-09-15	89	Без ГМО
1361	16	451	15	473	169	упаковка	10	2024-07-15	31	Без ГМО
1362	24	451	68	423	337	тонна	1	2024-06-21	85	Без ГМО
1363	3	451	72	99	88	упаковка	5	2024-10-02	74	
1364	1	452	20	153	94	кг	4	2024-11-02	21	Без ГМО
1365	17	452	32	480	446	кг	6	2024-09-20	52	
1366	6	453	75	171	80	тонна	10	2024-06-16	80	Без ГМО
1367	29	453	48	325	8	тонна	3	2024-11-06	57	Органик
1368	5	454	94	466	33	кг	5	2024-09-18	107	Органик
1369	4	454	66	336	103	тонна	7	2024-07-27	86	
1370	7	454	16	316	218	кг	4	2024-08-04	23	
1371	7	454	54	456	355	тонна	5	2024-07-25	60	Органик
1372	3	455	43	426	209	кг	4	2024-09-23	50	
1373	5	455	33	309	292	ящик	2	2024-06-16	47	Органик
1374	40	455	23	178	171	ящик	9	2024-10-08	30	
1375	1	455	73	59	33	кг	5	2024-10-30	92	Органик
1376	37	456	37	80	75	кг	4	2024-10-09	49	
1377	44	456	41	76	60	тонна	9	2024-09-15	48	Без ГМО
1378	31	456	99	304	164	упаковка	2	2024-09-28	115	Хранить в прохладном месте
1379	33	456	24	147	72	упаковка	6	2024-10-19	29	Органик
1380	6	457	86	477	127	упаковка	3	2024-10-29	93	
1381	21	457	94	36	20	ящик	2	2024-09-04	109	Без ГМО
1382	45	458	57	259	80	упаковка	6	2024-10-04	62	
1383	10	458	69	208	114	кг	1	2024-06-25	88	
1384	42	459	12	332	252	ящик	10	2024-08-21	25	Без ГМО
1385	26	459	78	496	442	кг	9	2024-07-22	84	Органик
1386	26	459	24	207	111	ящик	5	2024-08-14	43	Хранить в прохладном месте
1387	44	459	40	317	94	кг	4	2024-11-15	46	Хранить в прохладном месте
1388	34	460	33	149	49	упаковка	2	2024-08-31	36	Органик
1389	1	460	34	160	35	тонна	4	2024-10-01	41	Без ГМО
1390	18	460	61	414	184	кг	4	2024-09-17	72	
1391	47	460	68	125	7	тонна	8	2024-07-09	71	
1392	36	461	67	64	28	ящик	5	2024-06-02	83	Органик
1393	30	461	91	412	367	тонна	7	2024-10-09	110	Органик
1394	9	461	26	254	240	кг	6	2024-07-29	46	Хранить в прохладном месте
1395	22	461	12	89	71	кг	4	2024-07-25	15	Хранить в прохладном месте
1396	27	462	81	278	207	тонна	10	2024-09-03	99	
1397	38	462	94	469	189	кг	8	2024-08-03	113	Органик
1398	3	463	62	381	211	кг	1	2024-08-09	65	Без ГМО
1399	9	463	33	120	4	тонна	3	2024-09-11	46	Органик
1400	12	463	57	190	153	упаковка	4	2024-10-24	58	
1401	24	464	82	264	171	тонна	4	2024-07-30	100	Хранить в прохладном месте
1402	5	464	19	386	257	тонна	4	2024-08-06	31	
1403	48	464	12	161	46	упаковка	7	2024-10-23	21	Хранить в прохладном месте
1404	32	465	77	163	60	упаковка	6	2024-06-10	89	
1405	14	465	57	246	92	кг	6	2024-11-04	63	
1406	33	466	35	375	48	упаковка	3	2024-06-29	55	Хранить в прохладном месте
1407	41	466	54	85	34	тонна	10	2024-10-11	59	
1408	37	467	98	41	21	ящик	10	2024-09-13	108	Без ГМО
1409	10	467	62	157	76	тонна	6	2024-08-11	67	
1410	25	467	75	286	113	тонна	9	2024-08-20	92	Органик
1411	10	468	56	300	230	ящик	9	2024-08-16	73	Без ГМО
1412	35	468	35	96	47	ящик	5	2024-08-28	55	Хранить в прохладном месте
1413	17	469	17	310	161	упаковка	10	2024-10-31	28	Хранить в прохладном месте
1414	15	469	56	232	67	кг	9	2024-10-24	68	
1415	30	469	89	352	351	тонна	10	2024-08-12	102	
1416	16	470	36	193	84	кг	1	2024-06-24	48	Хранить в прохладном месте
1417	35	470	22	150	139	тонна	7	2024-09-21	36	Без ГМО
1418	18	470	40	183	44	кг	5	2024-06-01	57	Органик
1419	45	471	59	57	27	ящик	5	2024-08-18	73	Органик
1420	47	471	24	129	99	упаковка	10	2024-09-09	25	Хранить в прохладном месте
1421	4	471	16	185	134	кг	7	2024-06-15	21	
1422	29	472	66	48	44	тонна	10	2024-09-24	79	
1423	43	472	94	39	9	ящик	4	2024-11-12	114	
1424	16	472	71	71	54	ящик	6	2024-09-26	79	Органик
1425	37	473	10	62	18	кг	7	2024-10-03	14	
1426	2	473	75	344	180	кг	10	2024-10-01	87	
1427	45	474	96	312	192	тонна	3	2024-11-22	98	Хранить в прохладном месте
1428	31	474	71	340	315	кг	3	2024-09-22	88	
1429	30	475	76	252	169	кг	3	2024-09-26	85	
1430	5	475	66	494	346	тонна	8	2024-10-07	70	Хранить в прохладном месте
1431	7	475	17	154	20	кг	4	2024-06-07	32	Хранить в прохладном месте
1432	38	475	32	463	341	упаковка	8	2024-08-03	45	
1433	34	476	38	55	10	упаковка	1	2024-08-08	49	Органик
1434	11	476	41	190	1	кг	9	2024-08-15	57	
1435	23	477	77	384	178	ящик	6	2024-06-02	94	Без ГМО
1436	32	477	27	227	15	тонна	6	2024-08-05	31	Хранить в прохладном месте
1437	36	477	78	110	38	ящик	4	2024-07-22	90	
1438	28	478	63	366	209	упаковка	2	2024-08-23	70	
1439	24	478	26	478	166	упаковка	5	2024-06-11	29	Органик
1440	9	478	90	183	46	ящик	1	2024-11-28	91	
1441	16	479	77	305	260	упаковка	2	2024-06-20	90	Хранить в прохладном месте
1442	1	479	68	165	119	упаковка	1	2024-10-23	71	
1443	15	479	69	243	157	кг	6	2024-06-24	79	
1444	9	479	59	280	22	упаковка	6	2024-10-18	69	Хранить в прохладном месте
1445	35	480	38	419	289	тонна	2	2024-11-11	51	Органик
1446	3	480	26	176	154	кг	1	2024-10-21	42	
1447	2	480	33	30	2	тонна	9	2024-10-15	39	Органик
1448	16	481	39	36	16	кг	5	2024-06-26	57	Хранить в прохладном месте
1449	21	481	77	193	51	ящик	7	2024-09-22	82	
1450	22	481	11	421	400	ящик	4	2024-07-28	20	
1451	2	482	82	296	228	тонна	10	2024-10-06	85	Хранить в прохладном месте
1452	12	482	36	290	161	тонна	1	2024-10-13	50	Хранить в прохладном месте
1453	4	483	27	143	14	упаковка	10	2024-09-13	44	
1454	9	483	96	30	4	кг	1	2024-09-13	106	Органик
1455	37	483	39	195	192	кг	5	2024-06-21	49	
1456	30	484	55	469	435	кг	7	2024-10-11	68	Хранить в прохладном месте
1457	12	484	20	71	10	ящик	8	2024-10-18	29	Органик
1458	19	484	38	157	0	упаковка	4	2024-11-06	45	
1459	48	484	33	85	37	ящик	7	2024-09-07	45	
1460	34	485	81	206	10	ящик	7	2024-07-30	92	Органик
1461	35	485	64	111	14	тонна	6	2024-09-07	84	
1462	14	485	30	249	159	ящик	1	2024-10-26	35	Органик
1463	41	485	83	298	49	кг	6	2024-11-04	93	
1464	46	486	56	405	100	ящик	3	2024-11-23	68	
1465	24	486	72	237	152	ящик	7	2024-09-19	86	Хранить в прохладном месте
1466	23	487	23	246	235	упаковка	2	2024-08-03	33	Хранить в прохладном месте
1467	44	487	64	207	114	ящик	4	2024-10-18	80	
1468	4	487	79	419	183	тонна	5	2024-07-19	93	
1469	13	488	70	55	16	ящик	2	2024-07-25	84	
1470	30	488	72	196	11	тонна	8	2024-08-18	88	Без ГМО
1471	21	488	97	431	185	ящик	8	2024-07-14	116	Без ГМО
1472	29	489	97	36	10	тонна	3	2024-07-12	107	
1473	21	489	45	45	16	ящик	6	2024-11-01	54	
1474	39	489	39	329	240	ящик	5	2024-08-06	46	
1475	6	490	18	240	55	ящик	7	2024-07-24	21	Хранить в прохладном месте
1476	32	490	14	357	93	тонна	4	2024-10-12	28	Органик
1477	28	491	91	304	254	ящик	3	2024-06-16	96	Органик
1478	14	491	20	450	93	упаковка	4	2024-06-12	26	
1479	38	491	33	269	232	кг	6	2024-06-29	45	
1480	11	492	83	102	9	тонна	1	2024-11-23	84	Хранить в прохладном месте
1481	2	492	93	213	174	упаковка	3	2024-10-18	110	Хранить в прохладном месте
1482	35	492	43	334	97	кг	5	2024-11-09	57	
1483	46	492	84	270	2	кг	8	2024-09-17	94	
1484	41	493	12	105	0	упаковка	8	2024-06-02	31	
1485	11	493	12	55	23	кг	5	2024-09-08	31	Органик
1486	10	494	90	127	40	кг	8	2024-07-15	103	Хранить в прохладном месте
1487	16	494	53	213	37	ящик	7	2024-07-04	65	Без ГМО
1488	11	494	68	166	132	тонна	10	2024-10-24	76	
1489	16	494	44	491	49	кг	8	2024-09-20	64	
1490	44	495	12	417	247	тонна	9	2024-08-14	16	Без ГМО
1491	7	495	59	19	10	тонна	10	2024-11-13	70	Без ГМО
1492	3	495	83	86	35	тонна	3	2024-10-09	86	
1493	9	495	36	391	357	ящик	10	2024-06-01	56	
1494	44	496	55	377	123	упаковка	5	2024-11-21	59	Без ГМО
1495	21	496	98	267	224	тонна	3	2024-08-02	106	Хранить в прохладном месте
1496	24	496	28	378	156	кг	9	2024-08-25	39	Без ГМО
1497	38	496	36	422	265	ящик	8	2024-07-23	43	Без ГМО
1498	39	497	52	300	106	кг	4	2024-07-24	64	Хранить в прохладном месте
1499	24	497	17	206	47	ящик	6	2024-11-16	37	Хранить в прохладном месте
1500	48	497	77	292	152	упаковка	7	2024-11-14	80	Органик
1501	33	497	46	290	17	упаковка	7	2024-09-10	60	
1502	42	498	32	468	450	ящик	5	2024-10-18	49	Органик
1503	8	498	21	301	128	кг	8	2024-09-19	39	Органик
1504	25	499	44	417	397	тонна	10	2024-06-14	58	
1505	25	499	47	136	97	упаковка	4	2024-10-14	63	
1506	33	499	53	101	78	упаковка	8	2024-10-24	72	Органик
1507	39	499	56	287	29	кг	9	2024-11-18	64	Органик
1508	12	500	69	467	236	кг	7	2024-06-13	84	Хранить в прохладном месте
1509	6	500	62	320	133	тонна	5	2024-10-21	72	
1510	20	500	75	87	76	кг	2	2024-11-01	78	Без ГМО
1511	12	500	27	489	422	тонна	3	2024-07-29	28	
1512	25	501	95	36	12	упаковка	2	2024-10-07	110	Органик
1513	5	501	78	255	170	кг	3	2024-10-13	80	
1514	42	501	40	374	247	тонна	7	2024-06-07	49	Хранить в прохладном месте
1515	8	502	30	215	66	ящик	4	2024-06-25	42	Без ГМО
1516	19	502	72	317	94	упаковка	3	2024-07-02	83	Без ГМО
1517	12	502	66	94	41	упаковка	1	2024-08-16	72	Органик
1518	28	502	53	149	112	тонна	8	2024-10-22	73	Хранить в прохладном месте
1519	8	503	27	200	104	упаковка	2	2024-07-08	42	Хранить в прохладном месте
1520	25	503	56	377	189	упаковка	1	2024-11-01	74	
1521	38	503	36	185	23	кг	9	2024-09-22	52	
1522	28	503	31	456	155	упаковка	4	2024-08-31	47	
1523	11	504	27	314	312	ящик	7	2024-11-21	37	
1524	11	504	16	69	67	упаковка	8	2024-09-18	34	
1525	32	504	59	275	31	ящик	10	2024-09-02	69	
1526	10	505	42	289	158	ящик	1	2024-08-27	46	
1527	40	505	19	437	43	кг	6	2024-07-24	26	
1528	5	505	12	445	211	упаковка	7	2024-07-02	27	
1529	16	506	39	18	2	упаковка	9	2024-07-19	42	Органик
1530	15	506	65	419	207	кг	2	2024-11-07	66	Без ГМО
1531	21	506	81	263	59	тонна	5	2024-09-25	87	
1532	36	506	21	228	174	тонна	7	2024-10-29	29	
1533	41	507	54	169	101	ящик	3	2024-11-13	64	
1534	26	507	52	243	130	упаковка	5	2024-09-04	65	Без ГМО
1535	32	508	60	327	133	упаковка	5	2024-08-18	70	Хранить в прохладном месте
1536	29	508	63	288	110	тонна	10	2024-11-25	77	Органик
1537	43	508	80	484	268	кг	8	2024-10-27	83	Хранить в прохладном месте
1538	21	509	86	262	152	тонна	7	2024-09-04	101	Органик
1539	7	509	75	288	244	упаковка	5	2024-11-09	79	
1540	2	509	28	105	66	упаковка	4	2024-09-17	35	Хранить в прохладном месте
1541	42	509	48	251	91	ящик	5	2024-06-13	62	Органик
1542	44	510	33	410	55	упаковка	9	2024-06-09	50	Хранить в прохладном месте
1543	1	510	74	448	3	упаковка	9	2024-06-22	76	Без ГМО
1544	38	510	65	451	93	тонна	2	2024-07-08	82	
1545	28	510	25	342	339	тонна	6	2024-09-10	44	
1546	34	511	17	252	29	тонна	7	2024-08-18	19	Органик
1547	5	511	72	455	264	ящик	4	2024-07-11	74	
1548	18	511	74	15	13	тонна	4	2024-06-28	83	Хранить в прохладном месте
1549	29	512	65	420	5	упаковка	6	2024-07-16	68	Хранить в прохладном месте
1550	23	512	16	162	37	кг	4	2024-10-25	29	Без ГМО
1551	45	512	74	417	124	тонна	10	2024-09-28	91	
1552	35	513	94	70	39	тонна	4	2024-09-25	109	
1553	23	513	63	410	406	кг	1	2024-06-19	72	Без ГМО
1554	38	513	71	485	46	кг	3	2024-07-04	91	
1555	2	514	41	455	182	упаковка	4	2024-06-09	50	Без ГМО
1556	11	514	74	399	242	тонна	7	2024-07-12	92	Хранить в прохладном месте
1557	11	514	38	423	284	кг	6	2024-11-13	41	
1558	16	515	72	297	218	упаковка	10	2024-08-21	76	
1559	41	515	87	337	109	упаковка	3	2024-07-07	107	Без ГМО
1560	16	516	84	78	63	кг	4	2024-09-29	97	Органик
1561	20	516	49	356	328	упаковка	5	2024-10-02	58	
1562	36	516	76	375	316	тонна	8	2024-06-12	83	Органик
1563	12	516	17	460	152	ящик	2	2024-07-09	31	Органик
1564	27	517	11	86	57	кг	5	2024-07-14	18	
1565	44	517	72	414	112	упаковка	8	2024-08-24	85	Хранить в прохладном месте
1566	3	517	68	493	265	ящик	8	2024-06-05	82	
1567	12	517	45	312	291	упаковка	10	2024-07-18	57	
1568	40	518	69	192	2	ящик	2	2024-11-08	76	Органик
1569	9	518	64	168	40	тонна	7	2024-07-08	67	Органик
1570	47	518	73	484	427	ящик	10	2024-06-26	77	
1571	40	518	82	55	13	ящик	9	2024-11-20	90	
1572	39	519	66	45	5	тонна	7	2024-06-26	68	Без ГМО
1573	28	519	47	418	350	ящик	9	2024-09-26	56	
1574	6	519	43	256	204	упаковка	3	2024-11-15	53	Без ГМО
1575	38	520	62	370	354	упаковка	10	2024-06-18	63	Органик
1576	19	520	34	50	43	кг	4	2024-10-20	49	
1577	8	520	80	318	302	ящик	8	2024-06-21	96	Органик
1578	46	520	56	103	58	кг	2	2024-08-10	66	Хранить в прохладном месте
1579	12	521	22	55	14	кг	6	2024-06-09	37	Органик
1580	43	521	93	255	103	ящик	9	2024-07-13	98	Органик
1581	20	521	79	28	3	упаковка	6	2024-11-23	81	
1582	8	522	34	139	22	упаковка	5	2024-08-01	51	
1583	44	522	84	125	38	упаковка	10	2024-07-24	98	Хранить в прохладном месте
1584	6	522	84	392	14	кг	10	2024-07-26	88	Органик
1585	38	522	18	309	4	ящик	4	2024-09-09	21	
1586	21	523	88	61	9	тонна	3	2024-06-21	101	Органик
1587	47	523	82	239	172	ящик	9	2024-11-07	91	
1588	19	523	41	281	149	кг	9	2024-08-22	53	Без ГМО
1589	45	523	16	372	95	ящик	8	2024-10-12	19	Органик
1590	33	524	94	247	56	ящик	3	2024-11-05	95	Без ГМО
1591	7	524	28	198	133	упаковка	10	2024-06-29	47	
1592	29	524	20	487	483	ящик	6	2024-08-19	37	
1593	16	524	27	84	15	упаковка	1	2024-11-16	38	
1594	34	525	25	413	284	кг	6	2024-10-07	44	Хранить в прохладном месте
1595	35	525	37	70	29	кг	6	2024-07-28	49	
1596	38	525	31	262	201	тонна	5	2024-06-15	40	Органик
1597	7	525	94	151	93	ящик	4	2024-09-05	100	Хранить в прохладном месте
1598	11	526	19	196	182	тонна	7	2024-10-02	36	
1599	17	526	90	147	12	упаковка	8	2024-07-29	102	Без ГМО
1600	36	526	100	117	96	упаковка	4	2024-06-10	119	Без ГМО
1601	18	526	93	19	8	кг	9	2024-07-14	112	Без ГМО
1602	4	527	69	341	168	тонна	8	2024-09-23	85	Хранить в прохладном месте
1603	23	527	74	219	201	ящик	6	2024-11-19	80	Хранить в прохладном месте
1604	9	527	29	404	403	тонна	10	2024-08-26	48	
1605	35	528	29	372	327	тонна	7	2024-06-07	49	
1606	23	528	80	375	183	ящик	10	2024-11-11	94	
1607	6	529	67	419	266	тонна	4	2024-11-03	79	Без ГМО
1608	32	529	47	98	60	ящик	9	2024-11-16	59	Хранить в прохладном месте
1609	40	529	89	254	56	упаковка	4	2024-10-14	99	
1610	33	530	11	90	1	кг	8	2024-07-05	16	Хранить в прохладном месте
1611	21	530	15	455	190	упаковка	3	2024-10-05	20	
1612	17	530	40	169	15	тонна	7	2024-07-13	44	
1613	11	530	74	207	188	упаковка	5	2024-10-23	80	
1614	46	531	78	277	217	тонна	6	2024-10-24	90	Без ГМО
1615	18	531	83	223	94	ящик	6	2024-07-21	86	
1616	44	532	49	76	15	упаковка	9	2024-10-14	57	Без ГМО
1617	8	532	94	432	167	ящик	3	2024-06-08	95	Без ГМО
1618	2	533	84	315	210	упаковка	10	2024-10-02	90	
1619	17	533	90	107	102	кг	3	2024-11-20	99	Хранить в прохладном месте
1620	28	533	99	173	133	кг	7	2024-08-20	108	Органик
1621	37	533	41	178	84	упаковка	4	2024-10-25	52	Органик
1622	47	534	34	419	162	тонна	3	2024-11-12	41	Хранить в прохладном месте
1623	14	534	30	75	53	упаковка	7	2024-09-20	41	
1624	37	534	20	431	352	кг	5	2024-10-03	38	
1625	40	534	59	432	182	кг	10	2024-06-29	66	
1626	38	535	15	470	176	ящик	1	2024-09-30	35	Органик
1627	3	535	33	270	38	упаковка	2	2024-06-10	48	
1628	19	535	64	113	92	кг	5	2024-07-16	71	
1629	28	536	19	220	159	тонна	5	2024-09-08	29	Хранить в прохладном месте
1630	45	536	42	307	217	тонна	6	2024-06-15	49	Хранить в прохладном месте
1631	27	537	18	124	75	упаковка	9	2024-11-13	29	Хранить в прохладном месте
1632	47	537	79	68	39	ящик	4	2024-06-16	93	
1633	19	538	74	447	337	ящик	4	2024-08-25	92	Без ГМО
1634	2	538	56	52	43	кг	4	2024-10-21	69	
1635	45	538	31	467	291	тонна	2	2024-10-09	43	Хранить в прохладном месте
1636	41	539	100	111	88	упаковка	3	2024-08-12	117	Органик
1637	44	539	45	373	136	ящик	10	2024-11-07	51	Без ГМО
1638	14	539	64	70	44	ящик	1	2024-09-12	74	
1639	35	539	84	323	39	ящик	6	2024-09-14	99	
1640	20	540	82	310	33	ящик	7	2024-10-15	85	Без ГМО
1641	23	540	100	140	132	кг	5	2024-11-23	110	Органик
1642	36	541	80	212	61	тонна	1	2024-11-28	100	Хранить в прохладном месте
1643	19	541	58	274	71	тонна	6	2024-10-03	77	Без ГМО
1644	48	542	25	130	53	кг	5	2024-06-28	42	Органик
1645	44	542	27	272	37	упаковка	9	2024-10-19	39	
1646	45	543	11	312	309	тонна	3	2024-11-27	17	Органик
1647	41	543	27	134	104	тонна	6	2024-09-30	30	
1648	29	543	81	92	10	кг	8	2024-11-28	88	
1649	30	544	20	344	279	упаковка	5	2024-08-08	31	Хранить в прохладном месте
1650	3	544	67	416	364	тонна	2	2024-09-28	75	
1651	40	544	63	172	50	кг	3	2024-10-19	80	Органик
1652	8	545	60	308	30	кг	9	2024-09-02	72	Хранить в прохладном месте
1653	13	545	48	189	118	упаковка	7	2024-07-26	65	Органик
1654	13	545	29	186	89	упаковка	4	2024-08-04	40	
1655	31	545	98	120	23	тонна	7	2024-10-15	99	
1656	42	546	34	314	279	ящик	4	2024-08-08	35	Без ГМО
1657	3	546	63	407	104	ящик	2	2024-07-26	75	Органик
1658	12	547	48	42	27	ящик	7	2024-10-08	59	Без ГМО
1659	5	547	54	488	467	тонна	4	2024-07-18	69	
1660	47	548	85	97	76	упаковка	7	2024-06-27	93	Органик
1661	18	548	62	273	141	кг	8	2024-07-28	73	
1662	3	549	45	417	341	упаковка	2	2024-11-01	46	Органик
1663	42	549	61	354	277	упаковка	2	2024-11-08	62	Хранить в прохладном месте
1664	45	549	68	207	56	тонна	5	2024-08-12	88	
1665	19	550	58	361	225	упаковка	3	2024-08-06	65	
1666	40	550	98	318	298	кг	3	2024-11-26	104	Хранить в прохладном месте
1667	4	550	69	299	38	кг	8	2024-11-09	79	
1668	46	550	70	246	212	тонна	6	2024-08-30	88	
1669	39	551	67	43	40	кг	3	2024-06-08	81	Без ГМО
1670	46	551	74	270	82	упаковка	1	2024-10-19	94	Органик
1671	13	551	41	246	106	ящик	3	2024-11-04	54	Хранить в прохладном месте
1672	44	551	31	265	243	упаковка	2	2024-06-25	34	Органик
1673	25	552	47	154	137	упаковка	6	2024-06-26	56	
1674	35	552	95	358	190	кг	3	2024-08-16	108	
1675	3	552	43	422	306	тонна	6	2024-08-25	46	
1676	37	552	90	426	72	ящик	1	2024-10-08	109	Хранить в прохладном месте
1677	14	553	50	390	182	тонна	5	2024-07-28	62	Без ГМО
1678	8	553	67	380	266	тонна	9	2024-06-07	83	Органик
1679	40	553	35	113	87	упаковка	8	2024-09-07	43	
1680	48	553	51	60	35	кг	8	2024-10-04	71	
1681	34	554	13	16	11	кг	2	2024-07-12	24	
1682	22	554	73	388	181	упаковка	9	2024-11-24	81	Хранить в прохладном месте
1683	20	554	62	367	88	кг	2	2024-07-23	73	Органик
1684	4	554	80	55	11	ящик	10	2024-09-17	91	Хранить в прохладном месте
1685	25	555	86	82	74	кг	10	2024-10-12	97	Хранить в прохладном месте
1686	2	555	34	287	70	ящик	9	2024-07-16	37	Без ГМО
1687	30	555	32	303	282	ящик	10	2024-08-14	38	Хранить в прохладном месте
1688	9	555	54	152	149	ящик	4	2024-11-06	64	
1689	11	556	91	387	215	тонна	3	2024-10-22	92	Органик
1690	7	556	96	379	248	ящик	5	2024-10-13	113	Органик
1691	27	556	50	119	40	тонна	10	2024-08-11	64	Органик
1692	15	557	21	19	4	упаковка	7	2024-09-09	27	Хранить в прохладном месте
1693	4	557	95	91	39	ящик	3	2024-09-13	97	Органик
1694	5	557	39	279	77	тонна	8	2024-08-17	55	Органик
1695	42	558	77	75	9	тонна	1	2024-08-04	78	Органик
1696	5	558	63	336	327	тонна	7	2024-11-18	80	Без ГМО
1697	8	559	28	138	97	тонна	8	2024-11-22	41	Органик
1698	18	559	59	89	10	упаковка	8	2024-07-29	69	Без ГМО
1699	13	559	32	455	408	ящик	4	2024-11-18	44	
1700	36	560	83	281	4	кг	7	2024-10-10	91	Органик
1701	28	560	39	270	78	тонна	4	2024-07-03	48	
1702	32	560	26	422	214	кг	8	2024-08-27	31	Органик
1703	6	560	79	398	276	упаковка	7	2024-09-28	89	Органик
1704	34	561	84	64	16	кг	6	2024-07-20	100	Хранить в прохладном месте
1705	7	561	77	97	88	ящик	2	2024-07-20	92	
1706	5	561	71	46	38	ящик	9	2024-08-26	80	Хранить в прохладном месте
1707	1	561	35	364	277	упаковка	2	2024-10-11	45	Органик
1708	44	562	25	360	312	упаковка	4	2024-11-04	36	Хранить в прохладном месте
1709	30	562	26	377	307	кг	1	2024-08-31	43	Хранить в прохладном месте
1710	34	562	43	207	109	ящик	5	2024-09-13	56	Органик
1711	34	563	63	49	28	упаковка	7	2024-06-19	76	Без ГМО
1712	29	563	79	357	255	ящик	5	2024-09-29	87	
1713	26	563	92	454	167	тонна	7	2024-09-24	96	Органик
1714	22	563	46	454	237	упаковка	6	2024-09-07	56	
1715	39	564	48	402	260	кг	9	2024-09-10	63	
1716	16	564	88	431	228	упаковка	7	2024-06-29	90	Без ГМО
1717	13	564	89	227	2	упаковка	1	2024-11-24	95	
1718	31	564	69	225	16	ящик	6	2024-09-13	89	Без ГМО
1719	10	565	96	28	17	тонна	7	2024-11-02	112	Хранить в прохладном месте
1720	27	565	94	151	102	ящик	1	2024-11-21	111	Органик
1721	4	566	80	143	10	упаковка	1	2024-06-06	81	Органик
1722	39	566	13	174	114	кг	2	2024-06-22	28	
1723	17	567	74	485	204	тонна	7	2024-10-10	87	Без ГМО
1724	32	567	41	369	105	ящик	8	2024-10-20	46	
1725	24	568	35	471	102	упаковка	10	2024-11-01	46	Органик
1726	26	568	12	247	193	ящик	1	2024-10-31	17	Хранить в прохладном месте
1727	1	568	11	300	150	кг	2	2024-07-23	18	
1728	17	569	41	183	177	тонна	5	2024-06-09	48	
1729	32	569	81	405	259	кг	2	2024-10-18	85	
1730	41	570	63	205	92	кг	2	2024-09-29	74	
1731	5	570	98	18	12	кг	2	2024-06-11	117	
1732	45	571	70	229	133	ящик	9	2024-11-11	87	
1733	44	571	17	481	137	тонна	3	2024-09-06	29	Органик
1734	5	571	84	359	98	упаковка	2	2024-08-27	92	
1735	16	572	23	383	19	ящик	8	2024-07-07	24	Без ГМО
1736	27	572	43	466	202	кг	2	2024-10-21	46	Хранить в прохладном месте
1737	10	572	90	348	196	кг	8	2024-08-30	108	
1738	48	573	93	126	23	кг	10	2024-06-27	96	
1739	31	573	65	238	198	кг	7	2024-09-26	66	Без ГМО
1740	47	573	75	175	51	упаковка	6	2024-11-28	79	Хранить в прохладном месте
1741	37	573	97	330	5	ящик	9	2024-08-10	114	Без ГМО
1742	47	574	78	431	236	упаковка	9	2024-06-05	82	
1743	48	574	15	176	114	ящик	5	2024-08-11	29	Хранить в прохладном месте
1744	18	575	76	499	364	упаковка	7	2024-07-21	93	Без ГМО
1745	28	575	50	491	315	тонна	2	2024-10-18	57	Хранить в прохладном месте
1746	22	576	14	395	73	упаковка	7	2024-11-18	30	
1747	39	576	31	105	96	тонна	8	2024-06-11	41	Хранить в прохладном месте
1748	6	576	85	436	290	ящик	2	2024-09-05	97	
1749	48	576	22	331	319	кг	9	2024-09-26	32	
1750	2	577	13	118	91	тонна	6	2024-11-14	18	
1751	46	577	92	21	11	кг	1	2024-06-05	101	Хранить в прохладном месте
1752	12	577	55	81	51	кг	6	2024-08-24	66	Хранить в прохладном месте
1753	42	577	92	491	487	ящик	8	2024-07-02	107	Без ГМО
1754	42	578	98	412	98	кг	5	2024-10-21	115	Без ГМО
1755	21	578	32	376	77	кг	9	2024-09-08	40	Хранить в прохладном месте
1756	44	578	59	401	254	ящик	3	2024-11-03	63	Хранить в прохладном месте
1757	3	579	72	334	103	упаковка	3	2024-11-19	83	
1758	16	579	35	214	118	кг	7	2024-06-23	39	Органик
1759	16	579	15	461	424	тонна	4	2024-10-19	24	Хранить в прохладном месте
1760	25	580	67	449	204	кг	2	2024-10-19	78	Хранить в прохладном месте
1761	14	580	58	396	322	упаковка	7	2024-06-09	76	Хранить в прохладном месте
1762	36	580	77	338	303	кг	1	2024-08-02	88	Хранить в прохладном месте
1763	15	581	91	279	237	тонна	10	2024-08-31	111	Без ГМО
1764	21	581	58	443	164	кг	1	2024-09-10	77	
1765	19	581	92	326	210	тонна	6	2024-10-09	101	Хранить в прохладном месте
1766	43	582	53	198	136	ящик	2	2024-06-26	56	
1767	26	582	79	231	103	ящик	7	2024-09-21	99	Хранить в прохладном месте
1768	21	582	92	330	115	ящик	10	2024-07-03	111	Без ГМО
1769	17	583	25	285	90	упаковка	5	2024-09-22	43	Органик
1770	46	583	75	154	113	ящик	1	2024-08-10	78	
1771	12	583	93	265	139	тонна	3	2024-07-28	101	
1772	8	584	16	80	55	кг	5	2024-08-21	33	Хранить в прохладном месте
1773	46	584	37	421	295	кг	8	2024-07-01	40	
1774	48	585	28	394	162	упаковка	1	2024-11-09	34	Без ГМО
1775	30	585	100	453	59	ящик	7	2024-08-25	102	
1776	2	585	63	310	306	упаковка	3	2024-08-22	66	Органик
1777	4	585	68	149	46	тонна	3	2024-11-22	81	
1778	15	586	94	32	21	кг	6	2024-11-04	105	
1779	34	586	72	310	299	кг	10	2024-11-27	84	Без ГМО
1780	20	586	44	226	76	тонна	10	2024-06-19	57	
1781	3	587	38	254	110	упаковка	4	2024-07-30	48	Хранить в прохладном месте
1782	26	587	36	51	29	ящик	6	2024-09-20	51	Органик
1783	45	588	23	226	59	ящик	5	2024-08-18	38	
1784	44	588	26	375	315	упаковка	3	2024-07-26	38	
1785	33	589	59	56	51	кг	3	2024-06-02	63	
1786	46	589	98	41	0	кг	8	2024-11-15	104	Органик
1787	13	589	19	109	16	тонна	1	2024-11-26	22	Органик
1788	28	589	11	261	231	кг	1	2024-08-07	17	Без ГМО
1789	43	590	70	280	272	тонна	5	2024-09-13	89	
1790	42	590	85	398	393	упаковка	8	2024-06-17	99	Без ГМО
1791	5	590	37	444	335	кг	2	2024-07-28	53	Хранить в прохладном месте
1792	21	590	40	477	97	кг	2	2024-06-25	51	Органик
1793	27	591	47	494	119	тонна	4	2024-07-14	66	
1794	4	591	52	446	236	тонна	1	2024-09-22	67	Органик
1795	7	592	25	222	48	кг	4	2024-07-08	26	Без ГМО
1796	10	592	57	356	349	упаковка	6	2024-07-31	65	Органик
1797	25	592	41	112	48	тонна	7	2024-09-18	58	Органик
1798	25	593	82	363	312	упаковка	8	2024-07-31	97	Органик
1799	19	593	42	397	41	тонна	1	2024-09-03	52	Органик
1800	2	594	10	68	61	ящик	6	2024-06-06	30	
1801	42	594	28	203	21	ящик	8	2024-09-09	35	
1802	1	595	91	477	86	упаковка	4	2024-11-20	93	
1803	25	595	57	402	313	тонна	7	2024-06-02	67	
1804	35	596	12	81	21	ящик	9	2024-08-29	30	Органик
1805	20	596	58	473	447	тонна	9	2024-06-26	59	Хранить в прохладном месте
1806	27	596	44	29	2	ящик	3	2024-09-14	63	
1807	47	596	36	212	177	кг	9	2024-08-01	38	Органик
1808	11	597	98	234	59	тонна	10	2024-06-10	105	
1809	19	597	48	233	177	ящик	9	2024-08-22	53	
1810	31	597	15	43	22	упаковка	4	2024-09-10	24	
1811	24	597	27	167	14	кг	10	2024-09-03	28	Хранить в прохладном месте
1812	19	598	22	389	142	кг	8	2024-06-09	25	Без ГМО
1813	30	598	62	492	475	кг	2	2024-07-06	68	
1814	6	598	34	397	39	тонна	1	2024-10-20	49	
1815	38	598	85	481	356	упаковка	2	2024-11-03	102	
1816	40	599	34	87	0	тонна	2	2024-07-11	50	
1817	45	599	33	458	213	ящик	4	2024-06-27	34	Органик
1818	9	600	29	486	258	ящик	5	2024-06-22	31	
1819	43	600	52	232	226	кг	2	2024-06-25	72	
1820	14	600	71	98	62	упаковка	2	2024-07-09	75	
1821	9	601	77	297	12	тонна	6	2024-11-22	78	Без ГМО
1822	9	601	23	481	335	тонна	7	2024-08-26	37	Органик
1823	37	602	84	302	250	кг	9	2024-10-19	92	
1824	39	602	75	327	217	тонна	5	2024-08-19	84	Без ГМО
1825	17	603	89	112	100	упаковка	10	2024-09-20	103	
1826	6	603	83	252	206	кг	5	2024-11-21	94	
1827	14	603	11	247	218	упаковка	7	2024-11-14	26	
1828	24	603	66	486	296	кг	10	2024-07-23	74	
1829	26	604	38	483	64	кг	4	2024-09-06	51	Без ГМО
1830	20	604	42	102	80	ящик	4	2024-08-18	52	
1831	19	604	54	184	164	кг	9	2024-11-25	63	Без ГМО
1832	32	604	12	13	3	упаковка	1	2024-07-18	24	
1833	10	605	56	134	54	кг	10	2024-10-01	61	Без ГМО
1834	15	605	24	472	114	ящик	4	2024-10-28	30	
1835	43	605	96	274	154	ящик	10	2024-09-29	103	
1836	16	606	18	19	6	тонна	2	2024-10-24	23	Без ГМО
1837	21	606	87	42	41	кг	9	2024-10-25	99	
1838	43	607	74	170	53	кг	1	2024-11-25	80	Без ГМО
1839	38	607	76	211	148	тонна	6	2024-08-21	93	
1840	1	608	15	252	116	упаковка	8	2024-10-12	16	Органик
1841	26	608	34	208	72	упаковка	6	2024-06-02	43	Хранить в прохладном месте
1842	48	608	53	241	235	упаковка	4	2024-08-16	59	Органик
1843	19	608	21	465	191	ящик	6	2024-07-29	36	Без ГМО
1844	43	609	52	290	274	кг	5	2024-07-27	67	Без ГМО
1845	7	609	31	398	259	ящик	6	2024-08-08	47	Органик
1846	26	610	45	217	199	кг	9	2024-11-25	61	
1847	19	610	82	387	114	кг	5	2024-08-03	93	Хранить в прохладном месте
1848	8	611	98	79	73	упаковка	5	2024-06-01	107	Без ГМО
1849	39	611	23	164	123	ящик	10	2024-11-28	37	
1850	34	611	76	102	95	кг	7	2024-11-14	88	Без ГМО
1851	38	612	58	434	432	кг	5	2024-08-13	63	Без ГМО
1852	29	612	13	106	76	кг	8	2024-10-29	24	Хранить в прохладном месте
1853	27	612	69	159	105	тонна	6	2024-10-04	89	
1854	2	612	100	321	203	кг	4	2024-07-27	117	
1855	36	613	62	235	126	упаковка	4	2024-10-22	67	Органик
1856	46	613	73	193	63	кг	4	2024-08-23	83	Органик
1857	19	614	80	348	205	тонна	6	2024-09-01	81	
1858	44	614	88	437	332	тонна	7	2024-09-16	98	Без ГМО
1859	33	615	10	134	52	ящик	7	2024-11-27	26	Без ГМО
1860	13	615	27	406	198	кг	5	2024-08-05	29	
1861	24	616	34	108	104	тонна	5	2024-08-28	46	
1862	9	616	77	217	204	ящик	10	2024-07-20	86	Хранить в прохладном месте
1863	28	617	42	366	121	упаковка	5	2024-10-29	49	Без ГМО
1864	35	617	78	459	273	упаковка	7	2024-07-04	97	Хранить в прохладном месте
1865	10	617	14	424	46	ящик	8	2024-11-12	20	Без ГМО
1866	23	618	14	323	240	упаковка	9	2024-06-06	31	Хранить в прохладном месте
1867	20	618	10	134	84	упаковка	1	2024-11-26	12	Органик
1868	24	618	83	77	44	упаковка	8	2024-10-31	98	
1869	31	618	89	257	107	тонна	6	2024-08-20	92	
1870	47	619	30	144	104	тонна	6	2024-07-29	37	
1871	7	619	34	16	14	тонна	1	2024-07-08	40	
1872	38	619	99	204	173	упаковка	8	2024-06-12	107	Без ГМО
1873	18	619	84	381	198	упаковка	3	2024-08-05	99	Органик
1874	48	620	37	482	286	тонна	4	2024-08-28	43	Без ГМО
1875	4	620	15	335	204	тонна	5	2024-09-25	20	
1876	10	620	74	121	109	кг	2	2024-11-20	78	
1877	36	620	32	164	125	ящик	2	2024-10-26	48	Органик
1878	24	621	82	48	36	кг	4	2024-08-13	99	Органик
1879	35	621	15	158	156	упаковка	10	2024-11-27	20	Без ГМО
1880	48	621	14	85	46	ящик	2	2024-06-08	21	Органик
1881	7	621	81	462	209	упаковка	1	2024-11-13	96	Органик
1882	1	622	74	401	6	ящик	6	2024-11-10	90	Хранить в прохладном месте
1883	40	622	72	245	113	тонна	2	2024-11-26	78	
1884	41	622	69	27	7	ящик	1	2024-08-20	76	Хранить в прохладном месте
1885	38	623	42	147	16	тонна	5	2024-10-05	58	Органик
1886	7	623	46	481	328	кг	4	2024-08-20	65	Органик
1887	21	623	39	234	171	кг	9	2024-09-21	59	Без ГМО
1888	8	624	32	300	253	ящик	8	2024-10-03	36	Органик
1889	45	624	63	40	13	ящик	6	2024-10-23	78	
1890	5	624	28	226	196	упаковка	9	2024-11-07	35	Органик
1891	26	625	31	368	317	упаковка	9	2024-08-19	34	
1892	26	625	46	263	181	упаковка	4	2024-06-18	57	Органик
1893	11	625	85	388	239	кг	3	2024-09-18	102	
1894	39	625	34	239	106	упаковка	8	2024-07-22	39	Хранить в прохладном месте
1895	47	626	84	312	196	тонна	4	2024-09-02	96	Органик
1896	10	626	28	88	56	ящик	3	2024-07-12	48	Хранить в прохладном месте
1897	1	626	19	426	281	кг	6	2024-11-23	29	
1898	23	627	53	40	3	кг	1	2024-10-07	65	Органик
1899	38	627	71	372	370	упаковка	5	2024-06-12	73	Без ГМО
1900	34	628	47	330	258	ящик	7	2024-11-07	55	Без ГМО
1901	6	628	11	435	375	упаковка	4	2024-11-06	13	Без ГМО
1902	29	628	88	82	31	кг	1	2024-07-04	100	
1903	22	629	68	367	233	тонна	3	2024-09-05	76	
1904	16	629	14	133	20	упаковка	9	2024-10-12	25	Без ГМО
1905	26	629	27	308	263	тонна	2	2024-06-21	34	Хранить в прохладном месте
1906	14	629	47	250	241	тонна	8	2024-07-13	67	Без ГМО
1907	37	630	73	127	80	кг	3	2024-07-10	80	Органик
1908	2	630	46	489	47	ящик	3	2024-09-21	48	
1909	26	630	46	218	39	ящик	10	2024-11-02	56	Хранить в прохладном месте
1910	27	630	61	56	33	упаковка	10	2024-11-03	62	Без ГМО
1911	12	631	70	269	92	упаковка	10	2024-08-16	85	
1912	48	631	30	44	8	кг	2	2024-08-31	31	Хранить в прохладном месте
1913	7	631	73	317	145	тонна	5	2024-08-22	77	Органик
1914	2	632	67	196	108	кг	4	2024-06-08	75	
1915	27	632	77	298	159	ящик	10	2024-10-04	87	Без ГМО
1916	47	633	23	323	113	тонна	1	2024-06-11	35	Органик
1917	41	633	53	176	45	тонна	9	2024-07-30	66	Без ГМО
1918	5	633	90	184	148	кг	4	2024-07-01	104	Хранить в прохладном месте
1919	30	634	34	491	401	тонна	8	2024-11-11	53	Без ГМО
1920	29	634	35	343	287	упаковка	4	2024-08-28	36	Органик
1921	35	635	42	317	146	упаковка	1	2024-10-18	50	Органик
1922	47	635	100	208	179	упаковка	1	2024-06-19	110	
1923	34	636	19	299	277	ящик	7	2024-11-08	26	
1924	47	636	96	89	44	кг	9	2024-07-17	110	Хранить в прохладном месте
1925	33	637	42	473	347	ящик	3	2024-09-06	55	
1926	12	637	11	189	128	упаковка	6	2024-07-23	27	Хранить в прохладном месте
1927	40	637	81	391	98	кг	3	2024-09-05	91	
1928	2	638	58	449	277	кг	1	2024-11-27	71	Хранить в прохладном месте
1929	24	638	31	12	1	кг	3	2024-10-03	38	Без ГМО
1930	9	638	57	299	251	тонна	1	2024-10-13	66	
1931	18	638	72	492	87	ящик	9	2024-10-28	75	
1932	36	639	71	490	404	упаковка	6	2024-10-18	80	Хранить в прохладном месте
1933	41	639	83	116	61	тонна	7	2024-06-01	95	Органик
1934	40	640	53	108	56	тонна	10	2024-10-14	70	Органик
1935	17	640	68	380	286	кг	3	2024-11-18	74	Хранить в прохладном месте
1936	30	640	35	291	195	упаковка	1	2024-09-14	44	Хранить в прохладном месте
1937	34	640	94	343	125	кг	5	2024-06-13	106	Хранить в прохладном месте
1938	17	641	39	410	334	кг	2	2024-09-09	50	
1939	37	641	77	99	73	ящик	3	2024-06-03	92	Хранить в прохладном месте
1940	30	642	92	226	144	ящик	1	2024-09-17	109	
1941	41	642	80	52	26	тонна	1	2024-11-15	85	Органик
1942	11	642	37	71	39	тонна	7	2024-11-16	50	Без ГМО
1943	31	643	48	252	102	упаковка	8	2024-06-10	56	
1944	11	643	79	222	112	кг	6	2024-10-17	98	Без ГМО
1945	10	643	73	254	32	ящик	5	2024-08-29	81	
1946	8	643	78	225	132	упаковка	1	2024-11-18	95	Органик
1947	10	644	32	58	13	тонна	6	2024-11-16	51	Без ГМО
1948	9	644	90	112	71	упаковка	3	2024-10-20	109	
1949	34	644	10	328	110	упаковка	9	2024-11-15	16	Органик
1950	30	645	61	394	138	упаковка	1	2024-10-17	77	Органик
1951	21	645	24	458	108	тонна	5	2024-07-19	42	
1952	47	646	98	179	86	ящик	1	2024-08-25	117	Хранить в прохладном месте
1953	37	646	91	338	310	кг	9	2024-11-02	105	Органик
1954	15	647	95	167	164	тонна	6	2024-09-14	107	Без ГМО
1955	7	647	65	68	67	ящик	8	2024-11-26	67	Без ГМО
1956	4	648	80	32	15	упаковка	8	2024-10-22	94	Органик
1957	16	648	88	187	28	упаковка	6	2024-07-06	102	Органик
1958	30	649	38	372	368	тонна	8	2024-10-01	39	Хранить в прохладном месте
1959	33	649	29	429	418	упаковка	2	2024-09-18	45	Хранить в прохладном месте
1960	37	649	86	111	91	ящик	6	2024-11-04	102	Без ГМО
1961	23	649	89	330	124	упаковка	6	2024-08-16	93	Хранить в прохладном месте
1962	26	650	45	439	251	ящик	3	2024-06-15	58	
1963	20	650	26	288	206	упаковка	4	2024-10-29	32	
1964	39	650	77	252	67	упаковка	3	2024-06-16	92	
1965	23	650	86	125	94	тонна	5	2024-09-28	106	
1966	32	651	67	13	4	ящик	1	2024-06-04	73	Без ГМО
1967	2	651	72	112	103	ящик	7	2024-11-17	87	Органик
1968	36	651	94	423	376	ящик	5	2024-10-09	106	Хранить в прохладном месте
1969	11	651	56	380	159	упаковка	6	2024-11-21	58	Без ГМО
1970	47	652	28	196	8	ящик	7	2024-06-27	30	Органик
1971	4	652	77	238	103	упаковка	5	2024-09-20	79	Хранить в прохладном месте
1972	14	652	26	247	183	упаковка	7	2024-10-15	44	
1973	12	653	65	454	170	тонна	8	2024-11-25	73	Без ГМО
1974	11	653	13	153	127	тонна	8	2024-11-10	21	Хранить в прохладном месте
1975	18	653	63	472	80	тонна	3	2024-10-01	75	Органик
1976	17	654	17	178	71	кг	1	2024-11-18	18	Без ГМО
1977	21	654	100	319	195	упаковка	8	2024-10-02	114	Органик
1978	1	654	59	231	198	тонна	1	2024-10-04	67	Органик
1979	1	654	83	264	104	ящик	3	2024-10-29	94	Без ГМО
1980	45	655	32	427	267	упаковка	1	2024-07-25	47	Хранить в прохладном месте
1981	14	655	92	382	372	кг	4	2024-06-22	96	
1982	22	656	86	72	52	тонна	7	2024-06-07	91	Органик
1983	19	656	80	64	42	упаковка	5	2024-07-21	89	
1984	9	657	53	337	294	ящик	5	2024-11-17	66	Хранить в прохладном месте
1985	27	657	31	219	181	кг	6	2024-08-03	37	
1986	48	658	82	246	237	ящик	4	2024-10-23	93	
1987	46	658	43	94	77	кг	2	2024-11-02	58	
1988	43	659	30	462	313	кг	4	2024-10-30	50	
1989	47	659	10	32	29	ящик	7	2024-06-28	21	
1990	26	659	56	414	356	упаковка	6	2024-10-20	60	Хранить в прохладном месте
1991	41	660	22	162	8	тонна	7	2024-09-07	27	Без ГМО
1992	37	660	89	10	10	кг	9	2024-11-04	97	
1993	37	661	66	331	208	кг	3	2024-09-30	69	Органик
1994	18	661	70	381	260	упаковка	9	2024-08-21	72	
1995	5	662	49	196	9	кг	3	2024-09-28	56	Без ГМО
1996	29	662	36	171	129	ящик	1	2024-07-25	44	Хранить в прохладном месте
1997	3	662	42	255	49	ящик	4	2024-10-04	62	
1998	31	663	24	273	122	ящик	4	2024-07-19	29	Органик
1999	41	663	56	50	4	кг	6	2024-07-14	57	Органик
2000	27	663	24	490	443	ящик	9	2024-08-07	43	Хранить в прохладном месте
2001	45	664	99	125	103	упаковка	4	2024-10-04	115	Хранить в прохладном месте
2002	7	664	78	434	302	тонна	5	2024-06-25	91	Органик
2003	42	664	70	202	30	тонна	2	2024-06-02	86	
2004	44	664	92	497	382	упаковка	6	2024-08-20	109	
2005	24	665	67	358	294	кг	2	2024-10-31	85	Хранить в прохладном месте
2006	47	665	72	371	66	тонна	9	2024-11-28	75	Хранить в прохладном месте
2007	18	666	95	117	18	кг	10	2024-11-20	100	Органик
2008	9	666	56	336	276	тонна	6	2024-09-01	57	Без ГМО
2009	7	667	95	390	378	упаковка	3	2024-10-20	106	Без ГМО
2010	28	667	76	364	103	упаковка	6	2024-11-11	96	Без ГМО
2011	38	668	20	179	63	упаковка	3	2024-09-29	21	Без ГМО
2012	36	668	29	137	121	кг	4	2024-07-19	41	Хранить в прохладном месте
2013	13	668	16	25	2	ящик	3	2024-08-25	31	Без ГМО
2014	32	669	65	348	302	ящик	9	2024-09-29	85	Без ГМО
2015	13	669	90	301	23	тонна	5	2024-07-26	98	Без ГМО
2016	39	669	17	477	131	кг	3	2024-07-11	29	Органик
2017	25	669	55	309	235	ящик	4	2024-11-26	57	Без ГМО
2018	3	670	54	95	0	кг	8	2024-10-07	62	Хранить в прохладном месте
2019	32	670	59	228	34	кг	8	2024-06-15	65	
2020	37	670	71	202	150	тонна	10	2024-10-24	83	
2021	47	671	42	398	183	упаковка	4	2024-10-22	54	Органик
2022	44	671	48	267	251	кг	3	2024-09-03	55	Без ГМО
2023	23	672	74	305	93	тонна	10	2024-07-09	83	
2024	4	672	29	53	10	ящик	5	2024-07-13	41	
2025	8	673	48	51	41	кг	8	2024-07-01	54	Органик
2026	3	673	39	217	210	кг	1	2024-10-01	52	Без ГМО
2027	11	673	77	79	28	ящик	6	2024-11-10	93	
2028	14	674	12	226	152	кг	10	2024-06-08	30	Органик
2029	36	674	19	118	92	кг	8	2024-07-14	20	Без ГМО
2030	42	675	67	40	23	тонна	8	2024-07-06	84	Органик
2031	7	675	68	206	45	упаковка	7	2024-10-25	72	
2032	24	675	19	259	22	упаковка	5	2024-07-26	27	Хранить в прохладном месте
2033	8	676	34	178	24	тонна	10	2024-09-10	41	Хранить в прохладном месте
2034	23	676	98	44	14	ящик	6	2024-11-11	104	Органик
2035	19	676	74	299	193	кг	9	2024-10-11	92	Без ГМО
2036	15	676	40	160	27	кг	6	2024-08-21	46	Хранить в прохладном месте
2037	24	677	21	210	140	кг	8	2024-11-26	33	
2038	35	677	36	485	369	ящик	4	2024-07-16	46	Без ГМО
2039	10	677	61	176	54	ящик	2	2024-10-24	66	Органик
2040	40	678	50	372	171	тонна	4	2024-11-25	58	Органик
2041	18	678	91	46	10	тонна	5	2024-10-25	104	
2042	18	678	76	387	369	кг	6	2024-08-05	83	
2043	48	679	56	174	46	ящик	8	2024-08-24	70	Хранить в прохладном месте
2044	43	679	65	18	14	кг	8	2024-07-30	68	Органик
2045	10	679	92	310	51	ящик	7	2024-07-15	111	
2046	16	680	95	310	147	ящик	3	2024-06-20	101	Хранить в прохладном месте
2047	13	680	78	135	15	ящик	8	2024-08-30	93	
2048	1	680	98	345	250	ящик	1	2024-09-01	100	Хранить в прохладном месте
2049	22	680	43	264	164	тонна	8	2024-07-05	45	Органик
2050	40	681	80	395	394	ящик	1	2024-06-05	97	
2051	48	681	91	15	8	упаковка	7	2024-09-25	108	Органик
2052	12	682	88	432	366	ящик	6	2024-06-29	103	
2053	27	682	100	235	155	тонна	10	2024-07-11	118	
2054	9	682	71	321	66	тонна	7	2024-07-25	91	
2055	9	682	10	388	287	упаковка	4	2024-10-18	14	Без ГМО
2056	37	683	11	136	130	тонна	6	2024-08-15	16	Органик
2057	13	683	90	43	24	тонна	5	2024-06-14	110	Без ГМО
2058	21	683	87	183	134	упаковка	7	2024-09-21	88	Без ГМО
2059	12	684	68	300	244	тонна	1	2024-09-06	71	Хранить в прохладном месте
2060	6	684	64	402	127	ящик	9	2024-07-11	66	Без ГМО
2061	39	684	46	460	29	упаковка	6	2024-09-28	48	Хранить в прохладном месте
2062	27	685	62	111	100	упаковка	6	2024-08-27	67	Органик
2063	22	685	13	379	134	кг	8	2024-09-08	16	
2064	13	686	84	305	161	тонна	2	2024-06-15	89	
2065	40	686	81	395	247	кг	5	2024-07-18	93	Без ГМО
2066	10	686	70	323	12	кг	7	2024-09-28	72	Без ГМО
2067	45	687	97	384	224	ящик	6	2024-06-06	99	Органик
2068	28	687	28	175	123	кг	8	2024-06-12	33	Органик
2069	47	687	96	483	184	ящик	1	2024-07-04	116	
2070	31	688	93	331	40	упаковка	9	2024-06-26	99	
2071	43	688	27	209	123	упаковка	9	2024-07-10	38	
2072	32	689	32	359	102	тонна	3	2024-07-20	33	Без ГМО
2073	44	689	29	223	118	ящик	5	2024-07-10	35	Без ГМО
2074	45	689	80	45	42	тонна	2	2024-07-26	86	
2075	48	690	58	452	173	ящик	2	2024-06-20	76	
2076	26	690	22	335	95	тонна	10	2024-10-04	27	Хранить в прохладном месте
2077	43	690	13	47	25	ящик	7	2024-10-24	30	Хранить в прохладном месте
2078	39	690	98	315	112	кг	5	2024-07-14	111	Хранить в прохладном месте
2079	19	691	40	117	82	упаковка	2	2024-06-17	46	
2080	11	691	63	480	165	упаковка	10	2024-09-05	67	Органик
2081	23	691	85	328	223	кг	9	2024-10-03	102	
2082	14	691	57	292	80	упаковка	8	2024-11-06	63	
2083	43	692	75	238	107	ящик	9	2024-09-03	82	Без ГМО
2084	24	692	41	334	269	тонна	1	2024-06-23	61	Без ГМО
2085	27	693	62	231	13	упаковка	10	2024-11-06	74	Хранить в прохладном месте
2086	22	693	56	457	351	тонна	10	2024-08-04	59	
2087	19	694	30	387	8	упаковка	7	2024-11-15	37	
2088	48	694	60	46	22	кг	3	2024-07-03	67	
2089	23	694	54	402	288	упаковка	9	2024-08-08	66	Хранить в прохладном месте
2090	40	694	80	303	300	кг	6	2024-08-04	94	
2091	23	695	38	456	202	тонна	5	2024-08-24	46	
2092	40	695	14	69	21	ящик	3	2024-09-02	31	Без ГМО
2093	40	695	67	83	20	упаковка	9	2024-06-17	80	Хранить в прохладном месте
2094	2	696	73	353	102	ящик	1	2024-07-19	76	
2095	39	696	12	487	450	кг	2	2024-09-16	17	Без ГМО
2096	13	696	53	200	156	кг	8	2024-09-27	69	Органик
2097	34	697	29	468	201	тонна	3	2024-08-12	48	
2098	2	697	52	327	43	ящик	9	2024-10-09	55	
2099	48	698	96	158	15	кг	7	2024-06-24	106	
2100	17	698	20	304	81	ящик	1	2024-11-24	40	Органик
2101	19	698	21	185	102	кг	8	2024-10-13	29	Хранить в прохладном месте
2102	18	698	93	166	40	кг	7	2024-09-19	97	
2103	28	699	33	428	308	тонна	10	2024-08-19	48	Без ГМО
2104	40	699	39	479	350	ящик	6	2024-10-26	40	
2105	13	700	47	210	209	кг	10	2024-06-07	59	Хранить в прохладном месте
2106	6	700	13	120	70	упаковка	2	2024-08-01	22	Органик
2107	39	700	18	414	396	упаковка	4	2024-09-05	21	Без ГМО
2108	18	700	92	111	96	кг	8	2024-06-10	103	
2109	5	701	22	368	212	упаковка	2	2024-09-29	35	
2110	41	701	90	38	27	ящик	7	2024-11-15	107	Без ГМО
2111	19	702	54	293	225	упаковка	2	2024-09-25	73	
2112	8	702	100	475	168	кг	8	2024-09-19	114	Хранить в прохладном месте
2113	22	703	57	282	112	ящик	2	2024-09-14	65	Без ГМО
2114	17	703	44	213	100	упаковка	4	2024-11-04	53	Без ГМО
2115	47	703	89	340	176	кг	9	2024-08-12	96	
2116	35	703	78	173	134	упаковка	3	2024-09-18	86	Без ГМО
2117	17	704	81	108	34	упаковка	10	2024-06-19	83	Хранить в прохладном месте
2118	12	704	83	270	220	упаковка	10	2024-11-09	92	Без ГМО
2119	47	704	99	462	349	кг	5	2024-11-22	116	Без ГМО
2120	23	705	82	288	204	упаковка	1	2024-06-24	89	
2121	14	705	11	384	235	кг	10	2024-09-07	13	
2122	22	706	56	336	285	ящик	2	2024-09-11	62	
2123	28	706	100	197	1	упаковка	6	2024-06-16	101	
2124	13	707	29	295	210	ящик	1	2024-10-24	38	Без ГМО
2125	22	707	63	378	338	ящик	10	2024-11-03	83	
2126	41	707	97	198	83	упаковка	5	2024-10-04	115	
2127	33	707	83	206	158	упаковка	3	2024-10-25	96	Без ГМО
2128	46	708	71	24	11	ящик	6	2024-08-09	79	Без ГМО
2129	40	708	15	263	75	кг	9	2024-07-25	18	
2130	11	708	98	442	137	тонна	9	2024-08-04	114	Хранить в прохладном месте
2131	9	709	27	370	346	ящик	8	2024-11-18	36	Без ГМО
2132	20	709	17	100	56	кг	6	2024-10-21	18	Без ГМО
2133	32	709	57	171	43	тонна	8	2024-11-13	68	Органик
2134	45	709	67	229	6	ящик	1	2024-07-28	72	
2135	19	710	21	197	111	упаковка	4	2024-06-19	26	
2136	38	710	49	493	443	тонна	8	2024-06-24	57	
2137	16	710	37	245	244	ящик	6	2024-08-15	38	
2138	19	711	10	129	87	кг	7	2024-11-06	16	
2139	30	711	73	453	311	упаковка	7	2024-11-28	89	
2140	39	711	14	205	62	тонна	4	2024-08-12	25	Органик
2141	31	712	68	415	48	кг	10	2024-07-28	73	Хранить в прохладном месте
2142	8	712	58	259	26	кг	4	2024-11-14	66	
2143	23	713	10	498	331	упаковка	3	2024-10-14	14	Хранить в прохладном месте
2144	9	713	71	320	247	кг	7	2024-07-12	88	Без ГМО
2145	21	713	50	214	188	упаковка	1	2024-10-11	59	Органик
2146	10	714	12	128	53	ящик	4	2024-06-06	20	Хранить в прохладном месте
2147	10	714	41	171	14	кг	7	2024-09-17	61	
2148	36	714	64	381	343	кг	6	2024-06-23	78	Без ГМО
2149	22	715	87	298	245	упаковка	10	2024-06-01	92	Хранить в прохладном месте
2150	21	715	51	252	209	кг	2	2024-09-10	65	Хранить в прохладном месте
2151	7	716	83	269	257	тонна	3	2024-06-15	99	
2152	16	716	19	448	350	кг	7	2024-06-25	24	Хранить в прохладном месте
2153	6	716	22	429	11	упаковка	10	2024-09-02	31	Органик
2154	13	717	94	359	131	тонна	8	2024-08-08	97	
2155	14	717	95	77	68	ящик	6	2024-10-09	115	
2156	1	718	67	425	339	тонна	2	2024-09-23	75	
2157	7	718	78	306	209	кг	3	2024-10-23	81	
2158	15	718	77	112	102	ящик	8	2024-06-24	95	Хранить в прохладном месте
2159	8	719	83	312	44	упаковка	8	2024-10-16	87	
2160	40	719	53	450	449	тонна	9	2024-06-30	60	Без ГМО
2161	31	720	46	467	163	упаковка	6	2024-11-02	56	Органик
2162	37	720	53	264	190	ящик	10	2024-08-29	72	Без ГМО
2163	6	720	61	300	128	ящик	10	2024-10-28	79	
2164	32	721	52	377	364	упаковка	5	2024-06-22	72	Хранить в прохладном месте
2165	35	721	57	315	216	кг	7	2024-06-27	71	Хранить в прохладном месте
2166	4	721	46	366	285	кг	2	2024-11-25	56	Органик
2167	1	722	45	169	115	упаковка	5	2024-08-12	58	
2168	42	722	100	491	385	ящик	2	2024-09-07	116	
2169	7	723	47	437	276	ящик	1	2024-06-29	63	
2170	2	723	45	399	149	кг	2	2024-06-06	51	
2171	2	723	29	10	6	тонна	4	2024-07-12	40	Хранить в прохладном месте
2172	2	724	89	361	146	тонна	9	2024-11-15	107	
2173	19	724	72	300	16	ящик	2	2024-07-24	82	Органик
2174	34	724	47	458	203	упаковка	6	2024-10-02	53	Органик
2175	28	724	91	180	132	упаковка	10	2024-06-12	95	
2176	8	725	16	273	140	ящик	6	2024-11-11	36	Без ГМО
2177	42	725	69	218	53	тонна	9	2024-07-16	78	
2178	29	725	78	444	385	упаковка	2	2024-08-07	83	
2179	11	726	79	118	21	кг	3	2024-10-04	91	Органик
2180	35	726	95	349	312	тонна	6	2024-08-19	97	
2181	30	727	32	269	247	ящик	3	2024-07-04	51	
2182	33	727	77	316	11	кг	1	2024-06-09	82	Хранить в прохладном месте
2183	20	727	41	77	3	ящик	9	2024-06-15	54	
2184	27	728	87	17	14	тонна	10	2024-08-25	97	Без ГМО
2185	47	728	83	384	359	упаковка	6	2024-07-06	100	Органик
2186	21	728	29	193	34	ящик	5	2024-10-12	38	Без ГМО
2187	48	729	71	404	333	тонна	3	2024-08-02	88	Хранить в прохладном месте
2188	29	729	24	414	377	упаковка	2	2024-08-11	33	Хранить в прохладном месте
2189	2	730	41	463	316	кг	2	2024-11-26	55	
2190	1	730	39	189	48	кг	6	2024-10-01	41	
2191	46	730	26	466	407	тонна	7	2024-11-11	28	
2192	44	730	72	242	80	кг	3	2024-08-08	89	Хранить в прохладном месте
2193	36	731	66	432	248	ящик	9	2024-06-06	84	Без ГМО
2194	34	731	80	399	117	ящик	4	2024-07-26	96	
2195	1	731	87	283	119	ящик	4	2024-08-29	95	
2196	32	731	86	347	325	ящик	2	2024-10-19	99	Без ГМО
2197	30	732	81	190	95	упаковка	6	2024-09-29	99	Без ГМО
2198	19	732	79	269	250	ящик	5	2024-11-05	83	
2199	8	732	51	428	51	кг	2	2024-06-13	57	Без ГМО
2200	48	733	22	485	83	упаковка	7	2024-11-14	33	
2201	13	733	20	157	103	ящик	10	2024-07-13	21	
2202	25	734	42	196	133	упаковка	1	2024-11-07	47	
2203	29	734	50	147	88	упаковка	1	2024-11-16	51	
2204	37	735	59	104	19	кг	5	2024-11-02	63	
2205	15	735	47	320	274	ящик	7	2024-10-15	51	Органик
2206	7	736	18	214	117	упаковка	5	2024-06-27	21	
2207	37	736	67	469	93	тонна	2	2024-08-29	68	Органик
2208	39	736	34	143	65	упаковка	6	2024-07-22	36	Органик
2209	4	736	78	35	22	ящик	4	2024-08-31	96	Без ГМО
2210	23	737	81	470	227	тонна	8	2024-09-26	85	Хранить в прохладном месте
2211	26	737	92	143	53	кг	9	2024-06-16	109	
2212	28	737	36	63	48	кг	2	2024-07-28	46	
2213	7	738	51	72	27	ящик	5	2024-06-12	52	Без ГМО
2214	16	738	16	184	7	кг	3	2024-06-25	21	
2215	26	738	17	41	36	ящик	5	2024-08-17	19	
2216	34	739	41	61	17	ящик	7	2024-07-10	44	
2217	25	739	20	400	181	упаковка	10	2024-06-29	22	Без ГМО
2218	4	740	77	447	414	ящик	2	2024-11-15	96	Хранить в прохладном месте
2219	14	740	59	455	134	тонна	1	2024-09-05	78	
2220	20	740	64	372	361	кг	9	2024-10-10	65	
2221	46	741	22	310	10	упаковка	10	2024-08-24	42	
2222	34	741	37	207	123	упаковка	3	2024-09-15	44	Без ГМО
2223	9	741	79	499	477	упаковка	2	2024-07-18	91	
2224	27	742	77	72	2	упаковка	8	2024-07-02	97	Органик
2225	28	742	73	363	149	упаковка	5	2024-09-06	77	Без ГМО
2226	22	742	51	428	54	кг	4	2024-06-01	57	Без ГМО
2227	48	742	95	353	208	кг	6	2024-11-03	104	Без ГМО
2228	13	743	19	98	2	ящик	10	2024-08-02	39	
2229	34	743	63	193	148	тонна	4	2024-09-03	70	Органик
2230	1	744	55	79	27	кг	2	2024-08-03	69	Хранить в прохладном месте
2231	39	744	95	250	43	тонна	5	2024-09-08	115	Без ГМО
2232	30	744	20	320	132	кг	10	2024-10-22	23	
2233	40	745	33	334	17	ящик	2	2024-09-30	53	
2234	15	745	22	450	272	кг	3	2024-08-04	26	Без ГМО
2235	3	745	44	119	6	ящик	10	2024-06-04	48	Органик
2236	15	746	68	85	76	упаковка	6	2024-06-02	79	Хранить в прохладном месте
2237	42	746	38	82	48	упаковка	5	2024-11-12	48	Органик
2238	39	746	62	194	56	кг	7	2024-09-21	69	
2239	30	746	84	483	436	упаковка	2	2024-06-28	102	Органик
2240	33	747	92	364	153	ящик	5	2024-08-10	96	
2241	30	747	58	11	8	кг	5	2024-08-21	63	Органик
2242	9	748	52	387	275	кг	10	2024-09-27	63	Хранить в прохладном месте
2243	2	748	92	28	14	ящик	10	2024-09-27	111	Органик
2244	14	748	41	138	35	кг	10	2024-06-23	59	
2245	25	748	28	482	299	упаковка	3	2024-09-30	45	Органик
2246	9	749	66	182	87	упаковка	1	2024-10-09	68	Без ГМО
2247	25	749	40	397	61	тонна	3	2024-11-06	57	Хранить в прохладном месте
2248	32	749	20	110	11	упаковка	1	2024-09-30	25	Хранить в прохладном месте
2249	26	750	79	20	14	упаковка	2	2024-11-24	96	Без ГМО
2250	35	750	62	353	84	ящик	3	2024-07-21	64	Хранить в прохладном месте
2251	32	750	24	235	9	ящик	7	2024-07-24	30	Органик
2252	40	751	56	84	14	упаковка	2	2024-09-13	76	Органик
2253	8	751	46	210	184	упаковка	4	2024-09-27	66	Органик
2254	1	752	77	436	247	ящик	9	2024-07-23	92	
2255	35	752	24	269	52	упаковка	5	2024-09-25	38	Хранить в прохладном месте
2256	45	752	69	437	233	кг	8	2024-07-27	76	
2257	18	752	57	249	144	тонна	8	2024-06-05	60	Хранить в прохладном месте
2258	37	753	54	444	87	тонна	3	2024-06-08	69	Хранить в прохладном месте
2259	32	753	68	129	122	тонна	4	2024-08-04	76	
2260	2	753	44	244	3	кг	8	2024-08-31	59	Без ГМО
2261	18	754	10	285	226	упаковка	4	2024-06-26	19	Без ГМО
2262	1	754	57	186	113	упаковка	2	2024-11-27	58	Без ГМО
2263	36	754	25	86	14	ящик	5	2024-08-13	40	Органик
2264	32	754	86	119	3	упаковка	8	2024-06-17	100	
2265	32	755	49	280	255	тонна	6	2024-07-15	51	
2266	21	755	27	165	159	упаковка	1	2024-10-29	29	Без ГМО
2267	45	756	40	265	31	кг	8	2024-06-22	52	
2268	46	756	97	164	112	тонна	8	2024-08-14	100	Без ГМО
2269	16	757	63	433	347	тонна	1	2024-07-01	75	Без ГМО
2270	29	757	23	367	18	упаковка	1	2024-09-30	42	
2271	35	757	23	195	153	ящик	7	2024-11-19	34	Без ГМО
2272	32	758	47	162	108	ящик	6	2024-09-03	62	Хранить в прохладном месте
2273	32	758	80	213	60	тонна	1	2024-09-14	98	
2274	42	758	65	452	452	кг	7	2024-08-18	79	
2275	42	758	52	192	157	кг	7	2024-10-31	64	
2276	17	759	56	138	80	ящик	1	2024-10-25	69	
2277	48	759	40	78	67	тонна	1	2024-06-06	44	Хранить в прохладном месте
2278	30	759	74	80	24	кг	4	2024-08-03	94	
2279	8	760	48	424	255	тонна	9	2024-08-02	50	
2280	39	760	84	96	17	кг	5	2024-07-31	90	Органик
2281	26	761	82	490	1	кг	9	2024-11-20	97	
2282	15	761	42	441	329	кг	5	2024-07-03	55	
2283	14	761	21	461	149	ящик	3	2024-11-05	28	
2284	8	762	37	135	43	кг	6	2024-07-20	52	Хранить в прохладном месте
2285	10	762	46	253	7	кг	10	2024-09-03	50	Хранить в прохладном месте
2286	31	762	15	402	333	тонна	1	2024-09-11	27	Хранить в прохладном месте
2287	32	762	88	193	160	упаковка	10	2024-07-22	104	
2288	42	763	16	198	40	ящик	7	2024-08-12	22	Без ГМО
2289	21	763	93	226	191	ящик	9	2024-08-05	105	
2290	13	764	53	445	191	тонна	9	2024-08-07	65	Органик
2291	12	764	22	117	82	ящик	3	2024-06-18	33	
2292	34	765	49	12	0	упаковка	1	2024-10-25	61	
2293	26	765	95	347	154	ящик	3	2024-08-09	100	Хранить в прохладном месте
2294	18	765	50	475	139	тонна	1	2024-10-14	66	Без ГМО
2295	6	766	34	383	180	упаковка	9	2024-11-26	49	Органик
2296	20	766	85	249	237	упаковка	10	2024-06-25	98	
2297	2	766	92	346	229	упаковка	2	2024-09-28	98	Без ГМО
2298	20	767	88	357	136	кг	2	2024-11-13	91	Хранить в прохладном месте
2299	6	767	12	267	93	ящик	10	2024-10-07	27	Органик
2300	35	768	91	456	26	тонна	8	2024-09-06	105	Хранить в прохладном месте
2301	48	768	88	52	47	тонна	3	2024-06-22	101	Без ГМО
2302	8	769	16	119	6	тонна	8	2024-06-19	30	Без ГМО
2303	40	769	75	241	108	упаковка	2	2024-08-28	89	Хранить в прохладном месте
2304	14	769	56	467	399	ящик	10	2024-11-01	68	
2305	45	770	39	109	62	кг	2	2024-08-10	54	Органик
2306	2	770	16	123	71	тонна	2	2024-10-29	21	
2307	47	771	84	169	12	ящик	10	2024-07-10	85	Хранить в прохладном месте
2308	3	771	70	10	9	тонна	2	2024-11-02	77	
2309	18	772	47	387	288	тонна	5	2024-11-15	50	Хранить в прохладном месте
2310	13	772	65	24	10	тонна	10	2024-07-10	66	
2311	47	773	24	57	5	тонна	5	2024-09-17	32	Органик
2312	34	773	34	313	56	упаковка	1	2024-06-08	49	
2313	2	773	90	375	95	упаковка	4	2024-07-02	105	Хранить в прохладном месте
2314	28	773	86	392	56	упаковка	10	2024-09-04	95	
2315	45	774	11	268	58	упаковка	2	2024-08-22	19	Органик
2316	21	774	39	70	37	ящик	10	2024-11-03	57	Органик
2317	24	774	55	436	187	тонна	6	2024-11-15	74	Органик
2318	47	774	90	257	5	ящик	3	2024-08-03	96	Без ГМО
2319	4	775	84	26	5	ящик	2	2024-11-05	95	
2320	44	775	29	399	153	тонна	7	2024-07-19	41	Без ГМО
2321	46	775	34	183	143	упаковка	5	2024-07-28	35	Хранить в прохладном месте
2322	39	776	87	14	3	ящик	10	2024-11-23	102	Органик
2323	28	776	88	44	16	упаковка	6	2024-10-02	94	Без ГМО
2324	48	776	81	487	275	тонна	7	2024-11-06	100	Хранить в прохладном месте
2325	29	776	58	334	178	кг	4	2024-11-06	74	Органик
2326	19	777	82	450	407	ящик	4	2024-07-18	99	Органик
2327	1	777	19	217	105	кг	4	2024-07-24	28	
2328	39	777	32	270	212	ящик	5	2024-10-03	43	
2329	48	778	14	454	0	упаковка	10	2024-11-22	30	Без ГМО
2330	17	778	79	260	44	упаковка	1	2024-09-26	96	Без ГМО
2331	46	778	13	449	58	кг	9	2024-07-31	29	
2332	48	778	73	236	15	тонна	3	2024-10-28	76	Органик
2333	11	779	97	216	42	кг	6	2024-11-15	98	
2334	24	779	85	121	79	тонна	9	2024-11-25	89	Без ГМО
2335	34	779	24	482	222	кг	6	2024-09-20	35	
2336	26	780	80	162	61	кг	2	2024-11-28	97	
2337	6	780	12	35	30	тонна	9	2024-11-21	16	
2338	6	781	92	41	17	кг	3	2024-10-01	101	
2339	41	781	26	92	11	тонна	2	2024-09-19	35	
2340	48	782	53	446	32	упаковка	2	2024-10-30	65	Хранить в прохладном месте
2341	14	782	35	287	246	ящик	3	2024-08-02	40	Без ГМО
2342	12	783	86	420	137	тонна	8	2024-07-15	102	Органик
2343	7	783	55	111	67	упаковка	10	2024-10-28	64	Органик
2344	35	783	65	77	27	тонна	5	2024-10-03	77	Без ГМО
2345	32	783	14	274	232	упаковка	5	2024-07-08	26	
2346	9	784	79	439	161	тонна	7	2024-07-30	96	Хранить в прохладном месте
2347	39	784	56	500	53	ящик	1	2024-09-28	72	
2348	24	784	55	170	137	упаковка	10	2024-08-20	72	
2349	6	784	60	303	131	ящик	5	2024-11-20	65	
2350	38	785	89	122	17	упаковка	9	2024-06-29	104	Без ГМО
2351	3	785	88	282	101	кг	8	2024-06-14	105	
2352	46	785	37	123	38	кг	2	2024-11-17	45	Хранить в прохладном месте
2353	18	786	28	116	92	кг	7	2024-08-01	35	Органик
2354	22	786	92	147	21	кг	8	2024-07-15	103	
2355	43	786	15	356	266	упаковка	2	2024-07-05	18	
2356	43	786	100	177	37	кг	8	2024-08-15	116	Хранить в прохладном месте
2357	17	787	17	147	6	тонна	6	2024-09-13	32	
2358	19	787	33	343	136	кг	10	2024-08-07	49	
2359	46	787	82	414	316	тонна	5	2024-11-20	97	Без ГМО
2360	27	788	34	467	448	упаковка	9	2024-09-04	41	
2361	1	788	18	241	87	кг	4	2024-06-19	28	Хранить в прохладном месте
2362	42	788	30	324	196	ящик	10	2024-09-28	45	Хранить в прохладном месте
2363	40	789	96	257	122	тонна	9	2024-06-16	100	
2364	26	789	48	300	215	тонна	6	2024-10-17	59	Без ГМО
2365	28	789	54	101	25	ящик	6	2024-11-20	68	
2366	44	789	69	352	228	упаковка	7	2024-08-21	83	Без ГМО
2367	19	790	95	455	156	тонна	6	2024-06-24	111	
2368	42	790	44	412	401	тонна	8	2024-06-01	53	
2369	29	790	97	259	146	тонна	3	2024-09-16	110	Без ГМО
2370	31	791	83	15	5	кг	5	2024-07-19	95	Органик
2371	12	791	98	310	295	кг	2	2024-07-01	101	Органик
2372	3	792	100	28	10	тонна	3	2024-10-30	115	
2373	24	792	53	65	27	ящик	7	2024-11-28	56	
2374	5	792	14	352	352	тонна	10	2024-10-17	23	Без ГМО
2375	35	793	16	97	33	кг	6	2024-09-29	20	Органик
2376	35	793	19	330	233	кг	2	2024-06-03	31	
2377	3	793	51	142	32	ящик	4	2024-07-11	67	
2378	38	793	70	347	94	тонна	9	2024-11-28	82	
2379	38	794	93	290	223	упаковка	9	2024-11-12	95	Хранить в прохладном месте
2380	38	794	29	298	285	тонна	3	2024-07-22	30	Без ГМО
2381	20	794	58	324	104	упаковка	8	2024-08-06	69	
2382	26	795	83	43	24	тонна	7	2024-10-23	89	
2383	18	795	41	217	151	тонна	10	2024-08-22	51	
2384	38	795	88	486	405	упаковка	5	2024-06-19	94	
2385	35	795	29	482	66	упаковка	8	2024-06-15	44	Хранить в прохладном месте
2386	43	796	85	196	18	ящик	4	2024-08-24	86	Органик
2387	10	796	54	40	29	ящик	6	2024-11-27	72	Без ГМО
2388	38	796	80	240	173	ящик	10	2024-10-27	85	
2389	7	796	96	33	4	упаковка	10	2024-10-19	108	Без ГМО
2390	8	797	74	301	167	ящик	10	2024-10-02	78	Без ГМО
2391	7	797	61	313	282	ящик	9	2024-11-11	73	Хранить в прохладном месте
2392	43	798	62	60	28	ящик	10	2024-06-06	75	Хранить в прохладном месте
2393	36	798	35	214	157	тонна	8	2024-11-20	44	Органик
2394	24	799	91	287	188	упаковка	7	2024-10-16	98	Без ГМО
2395	14	799	87	384	74	ящик	6	2024-10-05	88	
2396	5	799	76	470	263	упаковка	4	2024-07-19	78	
2397	13	799	30	14	10	кг	1	2024-06-28	31	Без ГМО
2398	39	800	59	29	25	ящик	5	2024-06-14	61	Без ГМО
2399	37	800	82	300	96	тонна	6	2024-08-01	97	Органик
2400	43	800	82	358	344	ящик	4	2024-10-04	97	Без ГМО
2401	47	801	18	68	63	ящик	10	2024-10-04	29	Без ГМО
2402	8	801	95	350	319	упаковка	5	2024-07-04	109	Органик
2403	28	802	53	387	158	упаковка	7	2024-07-23	67	
2404	23	802	41	155	79	тонна	6	2024-07-21	45	Хранить в прохладном месте
2405	28	802	47	261	95	кг	1	2024-11-21	60	Хранить в прохладном месте
2406	20	803	21	476	405	кг	2	2024-11-05	38	Органик
2407	36	803	98	369	224	упаковка	10	2024-06-01	112	Хранить в прохладном месте
2408	7	803	93	372	8	упаковка	9	2024-11-18	104	
2409	29	803	58	133	97	ящик	4	2024-07-16	76	
2410	15	804	18	381	81	ящик	7	2024-06-22	23	Без ГМО
2411	20	804	38	194	98	ящик	3	2024-08-29	46	Без ГМО
2412	37	804	29	285	20	упаковка	7	2024-08-06	44	
2413	27	805	18	255	76	кг	2	2024-11-21	35	Органик
2414	14	805	14	224	62	ящик	5	2024-08-17	31	
2415	21	805	10	111	31	кг	1	2024-07-15	19	
2416	19	806	36	223	70	кг	4	2024-11-21	45	
2417	30	806	88	45	3	тонна	2	2024-07-31	108	Органик
2418	4	806	39	112	49	тонна	10	2024-10-26	56	Хранить в прохладном месте
2419	1	807	50	357	16	тонна	5	2024-11-10	68	
2420	24	807	48	81	74	ящик	8	2024-11-18	51	
2421	9	807	83	373	42	тонна	4	2024-06-29	103	Без ГМО
2422	1	807	73	69	69	кг	7	2024-08-15	76	Без ГМО
2423	25	808	88	340	169	ящик	2	2024-06-28	97	Органик
2424	23	808	65	245	47	ящик	1	2024-10-06	67	
2425	2	808	21	287	222	кг	9	2024-09-01	31	
2426	15	808	55	125	86	упаковка	9	2024-08-31	72	Органик
2427	4	809	65	179	95	кг	4	2024-10-12	75	
2428	15	809	96	35	28	тонна	5	2024-06-18	104	Без ГМО
2429	24	809	49	230	15	кг	2	2024-09-17	64	
2430	34	810	58	470	442	ящик	4	2024-09-27	66	Без ГМО
2431	14	810	35	382	204	упаковка	5	2024-07-14	43	
2432	28	811	60	462	37	ящик	8	2024-06-01	62	Органик
2433	9	811	74	91	24	кг	5	2024-10-10	91	Органик
2434	7	811	63	133	22	тонна	7	2024-10-13	78	Хранить в прохладном месте
2435	35	811	56	283	258	ящик	6	2024-10-12	62	
2436	22	812	55	70	60	тонна	6	2024-09-18	59	
2437	16	812	41	429	268	кг	7	2024-07-11	59	
2438	5	812	60	267	137	упаковка	6	2024-07-24	64	
2439	1	812	98	220	171	тонна	9	2024-08-09	102	Органик
2440	34	813	73	58	14	упаковка	4	2024-07-23	86	
2441	17	813	25	271	267	упаковка	4	2024-06-02	34	Хранить в прохладном месте
2442	10	813	78	161	68	кг	10	2024-08-09	94	Хранить в прохладном месте
2443	41	813	85	53	12	упаковка	8	2024-08-05	102	Хранить в прохладном месте
2444	35	814	90	228	201	упаковка	8	2024-09-16	110	Органик
2445	9	814	34	471	183	упаковка	10	2024-10-17	45	
2446	42	814	67	330	289	кг	8	2024-10-03	69	Без ГМО
2447	17	814	11	379	106	тонна	8	2024-11-06	16	
2448	29	815	54	472	207	тонна	10	2024-06-24	67	Хранить в прохладном месте
2449	13	815	46	226	142	тонна	2	2024-10-29	51	Органик
2450	26	815	24	481	111	ящик	9	2024-07-24	42	Органик
2451	5	815	73	327	44	упаковка	8	2024-06-13	81	Хранить в прохладном месте
2452	34	816	29	138	53	тонна	5	2024-10-10	30	
2453	40	816	51	481	478	тонна	6	2024-10-25	66	Без ГМО
2454	37	817	16	20	11	ящик	2	2024-08-28	21	Без ГМО
2455	23	817	24	149	14	упаковка	2	2024-07-03	39	
2456	16	818	11	455	254	кг	2	2024-08-10	31	Хранить в прохладном месте
2457	25	818	24	105	15	кг	7	2024-08-19	36	Органик
2458	23	818	41	417	65	кг	10	2024-06-02	51	Без ГМО
2459	29	819	82	222	156	кг	3	2024-07-15	87	Без ГМО
2460	17	819	59	26	1	ящик	2	2024-10-24	76	Хранить в прохладном месте
2461	42	820	29	237	86	упаковка	2	2024-11-11	35	Хранить в прохладном месте
2462	27	820	71	200	191	кг	1	2024-06-19	75	
2463	29	820	62	163	72	ящик	8	2024-07-09	74	Без ГМО
2464	42	820	31	492	188	кг	7	2024-10-29	43	
2465	20	821	76	136	38	упаковка	4	2024-07-21	93	Хранить в прохладном месте
2466	38	821	31	160	93	упаковка	10	2024-08-24	46	Хранить в прохладном месте
2467	46	821	64	189	101	ящик	7	2024-10-27	66	
2468	32	822	84	241	204	тонна	7	2024-07-19	104	
2469	38	822	95	383	365	упаковка	8	2024-09-05	102	Без ГМО
2470	3	822	25	219	1	кг	3	2024-10-19	36	Без ГМО
2471	1	822	25	26	7	тонна	1	2024-06-20	34	Хранить в прохладном месте
2472	6	823	68	423	288	кг	7	2024-07-08	72	
2473	30	823	19	252	98	упаковка	5	2024-11-20	31	Органик
2474	45	823	51	287	35	ящик	3	2024-06-02	63	Органик
2475	5	823	73	247	178	кг	3	2024-06-27	81	Органик
2476	13	824	72	422	355	кг	3	2024-10-30	92	
2477	6	824	90	56	52	упаковка	7	2024-07-12	93	Хранить в прохладном месте
2478	11	824	59	474	5	ящик	2	2024-08-22	62	
2479	14	825	17	17	1	тонна	3	2024-06-09	18	Без ГМО
2480	35	825	61	195	141	ящик	1	2024-10-18	71	
2481	31	825	29	378	303	тонна	2	2024-06-01	30	Без ГМО
2482	17	825	28	35	27	кг	3	2024-06-21	46	Без ГМО
2483	27	826	99	315	92	кг	1	2024-07-26	107	Органик
2484	25	826	48	111	60	кг	7	2024-08-23	56	Органик
2485	14	827	34	263	217	упаковка	8	2024-10-04	37	Органик
2486	10	827	81	426	295	упаковка	4	2024-10-15	99	
2487	13	827	16	418	325	ящик	1	2024-10-16	34	Органик
2488	6	828	84	238	12	упаковка	5	2024-10-01	89	
2489	36	828	22	493	45	тонна	8	2024-10-12	42	Без ГМО
2490	34	829	41	216	177	тонна	6	2024-06-20	56	Хранить в прохладном месте
2491	34	829	86	209	79	тонна	10	2024-09-23	90	Органик
2492	6	830	72	375	269	тонна	6	2024-11-08	74	Хранить в прохладном месте
2493	23	830	88	499	430	кг	10	2024-08-13	103	
2494	45	831	88	208	46	тонна	1	2024-09-03	91	Без ГМО
2495	29	831	21	216	191	ящик	1	2024-09-11	34	Органик
2496	18	832	46	468	107	кг	9	2024-10-28	58	
2497	40	832	51	318	231	тонна	4	2024-10-03	55	
2498	5	832	95	380	283	ящик	1	2024-10-10	108	
2499	32	833	22	289	151	тонна	2	2024-10-01	23	
2500	6	833	46	34	34	кг	2	2024-11-21	52	
2501	47	833	39	485	194	ящик	3	2024-10-10	50	
2502	33	833	34	155	7	упаковка	9	2024-10-10	39	Органик
2503	17	834	88	285	248	тонна	5	2024-09-03	107	
2504	45	834	52	15	1	тонна	7	2024-06-09	71	Без ГМО
2505	11	835	98	107	11	упаковка	2	2024-11-13	100	Органик
2506	33	835	93	57	3	кг	6	2024-07-13	101	Органик
2507	43	835	58	31	17	упаковка	3	2024-10-12	68	Без ГМО
2508	18	836	93	440	303	кг	10	2024-07-30	98	
2509	15	836	98	311	226	кг	7	2024-10-18	113	Хранить в прохладном месте
2510	4	836	18	499	419	тонна	5	2024-11-01	28	Без ГМО
2511	4	837	63	436	74	тонна	5	2024-10-23	73	
2512	4	837	10	308	16	тонна	4	2024-09-24	20	Без ГМО
2513	1	837	17	192	93	тонна	10	2024-08-01	21	Хранить в прохладном месте
2514	38	837	72	20	13	кг	2	2024-10-21	77	Органик
2515	14	838	77	32	27	упаковка	10	2024-10-06	95	
2516	4	838	61	82	0	тонна	9	2024-10-15	70	Без ГМО
2517	23	839	31	458	15	упаковка	8	2024-10-10	35	Без ГМО
2518	40	839	64	490	14	упаковка	5	2024-09-09	80	
2519	34	839	77	356	267	ящик	2	2024-06-06	95	
2520	17	840	10	143	44	тонна	6	2024-06-05	14	Органик
2521	14	840	98	340	241	ящик	5	2024-09-10	101	
2522	17	840	19	459	97	упаковка	10	2024-06-08	28	Без ГМО
2523	30	841	28	311	217	кг	4	2024-11-02	33	
2524	48	841	16	476	402	упаковка	3	2024-09-12	22	Без ГМО
2525	13	841	69	83	23	кг	2	2024-07-10	86	Без ГМО
2526	29	842	27	150	18	тонна	6	2024-07-27	38	Без ГМО
2527	21	842	53	493	65	тонна	3	2024-11-07	64	
2528	43	843	24	450	295	упаковка	10	2024-08-15	32	Без ГМО
2529	20	843	22	113	33	тонна	2	2024-06-19	39	Без ГМО
2530	39	843	76	425	78	кг	1	2024-09-16	87	
2531	43	844	51	47	46	ящик	7	2024-11-20	55	Без ГМО
2532	34	844	57	420	198	ящик	7	2024-09-27	62	
2533	12	845	58	312	167	ящик	3	2024-07-09	70	Органик
2534	22	845	76	278	205	тонна	6	2024-08-07	90	
2535	3	846	74	339	185	кг	6	2024-09-16	91	
2536	1	846	63	232	87	тонна	2	2024-06-28	65	Хранить в прохладном месте
2537	10	846	89	484	17	ящик	1	2024-09-14	108	
2538	28	846	13	104	65	кг	9	2024-08-13	32	Хранить в прохладном месте
2539	6	847	46	317	23	кг	6	2024-10-19	61	Без ГМО
2540	7	847	49	159	49	упаковка	6	2024-07-03	68	
2541	43	847	62	353	173	ящик	1	2024-11-04	82	Органик
2542	28	848	17	325	307	ящик	10	2024-07-07	28	Без ГМО
2543	4	848	70	338	112	кг	9	2024-08-31	89	Хранить в прохладном месте
2544	26	848	65	389	62	упаковка	10	2024-09-25	76	Хранить в прохладном месте
2545	23	848	89	499	294	упаковка	6	2024-11-22	91	
2546	40	849	67	317	21	упаковка	9	2024-10-04	83	Без ГМО
2547	39	849	68	80	60	тонна	5	2024-10-26	88	Хранить в прохладном месте
2548	19	849	98	412	188	упаковка	4	2024-09-19	112	Органик
2549	11	850	61	159	133	ящик	2	2024-06-20	68	Органик
2550	12	850	88	250	206	кг	10	2024-06-14	107	
2551	5	850	57	239	190	ящик	2	2024-06-03	76	
2552	46	850	56	266	173	кг	1	2024-06-22	62	
2553	48	851	59	275	132	кг	4	2024-09-15	61	
2554	3	851	99	55	46	тонна	8	2024-07-31	110	Без ГМО
2555	19	851	63	277	199	тонна	1	2024-11-12	65	Без ГМО
2556	41	851	34	13	11	кг	8	2024-06-14	53	
2557	35	852	24	42	25	ящик	7	2024-06-03	42	Хранить в прохладном месте
2558	42	852	100	84	49	ящик	3	2024-07-20	116	Без ГМО
2559	7	852	30	424	47	ящик	9	2024-10-09	49	Без ГМО
2560	21	852	18	55	44	тонна	7	2024-08-19	22	
2561	40	853	20	440	346	кг	7	2024-08-22	22	
2562	30	853	74	110	43	упаковка	3	2024-06-06	92	
2563	24	853	19	440	299	тонна	10	2024-06-03	20	Хранить в прохладном месте
2564	2	853	29	118	101	упаковка	5	2024-06-16	39	Органик
2565	27	854	86	227	184	кг	8	2024-08-01	97	Без ГМО
2566	28	854	65	431	224	упаковка	5	2024-11-26	79	Без ГМО
2567	26	855	63	85	23	ящик	10	2024-08-08	78	
2568	3	855	13	116	2	кг	7	2024-10-11	22	
2569	33	855	77	462	100	кг	2	2024-07-17	94	
2570	17	855	32	351	8	тонна	7	2024-11-01	42	Органик
2571	21	856	26	187	110	кг	10	2024-08-08	37	
2572	28	856	61	228	15	кг	6	2024-10-07	66	Без ГМО
2573	36	857	86	56	41	упаковка	3	2024-09-26	97	Хранить в прохладном месте
2574	23	857	34	191	83	кг	4	2024-11-19	48	Хранить в прохладном месте
2575	12	858	24	335	49	ящик	9	2024-10-03	26	
2576	35	858	48	77	19	ящик	2	2024-08-22	58	
2577	4	858	63	374	316	тонна	3	2024-10-23	76	
2578	23	859	30	288	223	ящик	8	2024-07-02	40	
2579	12	859	14	40	16	упаковка	4	2024-07-15	34	Хранить в прохладном месте
2580	11	859	27	70	33	упаковка	8	2024-11-24	45	
2581	10	860	14	400	72	упаковка	6	2024-11-20	21	Органик
2582	47	860	73	370	269	упаковка	6	2024-10-03	79	Без ГМО
2583	27	860	95	175	110	кг	7	2024-09-26	102	Хранить в прохладном месте
2584	41	860	100	71	30	кг	3	2024-08-03	118	Без ГМО
2585	39	861	44	25	19	ящик	5	2024-10-27	47	
2586	29	861	13	380	351	тонна	9	2024-09-16	30	
2587	32	862	23	391	360	ящик	4	2024-09-25	34	Органик
2588	13	862	72	144	139	кг	8	2024-08-18	86	Без ГМО
2589	2	862	81	321	320	кг	8	2024-10-15	89	Без ГМО
2590	41	863	70	481	357	упаковка	10	2024-11-07	86	Хранить в прохладном месте
2591	4	863	43	398	30	кг	10	2024-07-20	63	Без ГМО
2592	44	864	50	340	241	тонна	1	2024-11-26	62	Без ГМО
2593	14	864	16	415	26	ящик	5	2024-06-22	32	Хранить в прохладном месте
2594	13	864	67	331	95	кг	6	2024-06-27	76	Без ГМО
2595	15	865	34	283	225	упаковка	5	2024-10-12	45	Без ГМО
2596	7	865	61	212	68	ящик	3	2024-11-03	76	
2597	23	865	35	349	327	упаковка	9	2024-11-18	42	Органик
2598	2	866	84	270	196	ящик	4	2024-11-05	90	Хранить в прохладном месте
2599	20	866	85	41	37	упаковка	2	2024-07-09	98	
2600	37	866	90	76	20	ящик	5	2024-10-10	108	Без ГМО
2601	5	866	100	155	53	ящик	10	2024-08-09	109	Органик
2602	31	867	74	230	28	ящик	8	2024-09-18	83	Органик
2603	22	867	93	255	157	ящик	9	2024-11-05	109	
2604	5	867	87	244	10	ящик	2	2024-08-26	101	
2605	28	868	69	176	168	кг	4	2024-06-15	86	
2606	12	868	28	164	3	тонна	4	2024-06-15	40	
2607	20	868	83	407	30	кг	9	2024-10-24	98	
2608	47	869	43	108	65	тонна	6	2024-08-05	59	
2609	33	869	61	317	193	упаковка	6	2024-06-09	81	Хранить в прохладном месте
2610	9	869	15	424	28	ящик	3	2024-07-07	26	
2611	36	870	85	215	176	тонна	5	2024-07-01	95	
2612	28	870	37	174	115	кг	7	2024-11-08	54	Хранить в прохладном месте
2613	47	871	33	250	242	упаковка	6	2024-10-24	42	
2614	22	871	55	264	9	упаковка	8	2024-11-08	63	
2615	10	872	76	445	186	ящик	6	2024-11-23	95	Хранить в прохладном месте
2616	40	872	93	284	261	кг	6	2024-10-31	110	Хранить в прохладном месте
2617	45	873	14	125	24	кг	2	2024-06-01	21	
2618	3	873	65	183	173	тонна	8	2024-07-11	67	
2619	22	874	42	352	171	упаковка	2	2024-11-20	52	Без ГМО
2620	45	874	21	286	19	ящик	9	2024-09-20	34	
2621	30	875	66	77	23	кг	7	2024-07-04	67	
2622	23	875	13	249	108	кг	4	2024-07-10	15	Хранить в прохладном месте
2623	15	876	94	327	66	кг	8	2024-09-12	110	Хранить в прохладном месте
2624	31	876	58	76	9	кг	5	2024-09-27	78	
2625	9	876	59	108	6	упаковка	7	2024-08-06	74	
2626	39	876	98	147	73	упаковка	9	2024-11-18	111	
2627	25	877	54	48	11	упаковка	7	2024-09-29	61	Хранить в прохладном месте
2628	5	877	71	294	294	ящик	2	2024-09-01	87	Органик
2629	25	878	72	407	290	упаковка	1	2024-06-29	74	Органик
2630	31	878	88	426	345	тонна	3	2024-09-05	97	Органик
2631	25	879	58	406	348	тонна	1	2024-11-05	66	
2632	7	879	84	213	192	ящик	8	2024-08-26	98	Органик
2633	26	879	15	152	49	ящик	7	2024-09-25	33	
2634	46	879	28	277	250	ящик	10	2024-11-01	45	
2635	7	880	79	469	207	упаковка	2	2024-11-26	90	Органик
2636	16	880	20	190	130	упаковка	10	2024-09-20	40	Хранить в прохладном месте
2637	18	880	28	62	18	ящик	4	2024-09-14	39	
2638	14	881	22	133	57	кг	10	2024-08-08	28	Без ГМО
2639	29	881	89	184	179	ящик	1	2024-11-24	95	
2640	41	881	14	213	193	кг	8	2024-09-18	24	Органик
2641	9	881	26	45	35	ящик	9	2024-10-22	28	Органик
2642	11	882	22	348	269	ящик	4	2024-10-22	29	
2643	20	882	67	193	177	кг	10	2024-08-25	86	Хранить в прохладном месте
2644	48	883	73	129	79	упаковка	7	2024-08-02	82	Без ГМО
2645	2	883	32	386	91	ящик	7	2024-06-19	49	Хранить в прохладном месте
2646	1	883	47	451	88	упаковка	8	2024-07-11	49	Органик
2647	35	883	98	292	107	кг	3	2024-11-13	110	Хранить в прохладном месте
2648	20	884	69	39	35	ящик	2	2024-08-22	76	Без ГМО
2649	35	884	50	180	152	ящик	4	2024-09-05	57	Хранить в прохладном месте
2650	3	885	68	94	81	ящик	8	2024-06-26	79	Органик
2651	8	885	79	369	182	ящик	3	2024-07-14	99	Органик
2652	29	885	95	110	60	ящик	8	2024-06-04	97	Органик
2653	23	885	40	488	340	тонна	5	2024-06-19	52	Без ГМО
2654	40	886	53	131	55	ящик	2	2024-11-05	62	Хранить в прохладном месте
2655	48	886	26	279	223	ящик	10	2024-09-29	32	Органик
2656	15	886	42	107	66	ящик	1	2024-08-26	56	Без ГМО
2657	11	887	80	315	192	ящик	4	2024-07-03	84	
2658	3	887	46	236	180	кг	3	2024-08-25	50	Хранить в прохладном месте
2659	10	888	71	498	245	тонна	8	2024-07-09	88	
2660	22	888	56	173	153	упаковка	2	2024-06-23	66	Органик
2661	33	889	66	263	225	ящик	9	2024-08-04	84	
2662	42	889	70	479	340	тонна	2	2024-11-27	84	
2663	27	890	95	238	66	кг	8	2024-06-26	102	
2664	6	890	65	443	186	ящик	8	2024-09-24	79	Без ГМО
2665	4	891	27	343	100	ящик	2	2024-10-20	32	
2666	5	891	29	443	426	тонна	1	2024-09-17	39	
2667	41	892	91	440	323	ящик	4	2024-07-09	95	Хранить в прохладном месте
2668	15	892	66	166	165	ящик	7	2024-06-09	75	Хранить в прохладном месте
2669	41	893	36	136	9	ящик	9	2024-08-20	49	Хранить в прохладном месте
2670	42	893	66	355	93	упаковка	9	2024-07-30	70	Органик
2671	24	893	44	60	43	упаковка	4	2024-08-08	55	Без ГМО
2672	33	894	18	361	356	тонна	6	2024-11-16	26	
2673	7	894	14	89	8	тонна	7	2024-06-03	27	Органик
2674	1	894	59	289	135	кг	7	2024-11-04	68	
2675	41	894	52	190	70	тонна	9	2024-09-06	63	
2676	14	895	88	442	346	ящик	6	2024-07-30	102	Без ГМО
2677	25	895	14	448	361	ящик	3	2024-11-27	26	Без ГМО
2678	13	896	94	362	258	кг	1	2024-07-12	108	Органик
2679	40	896	10	437	331	ящик	1	2024-09-12	11	
2680	37	897	27	471	264	упаковка	1	2024-10-26	40	
2681	21	897	87	295	213	упаковка	6	2024-09-04	96	
2682	11	897	22	230	102	кг	2	2024-10-19	38	
2683	25	898	49	209	84	кг	5	2024-09-05	64	Без ГМО
2684	19	898	17	267	8	тонна	6	2024-06-21	27	
2685	18	898	14	241	187	кг	6	2024-07-14	17	
2686	11	898	68	75	43	кг	4	2024-07-17	83	Хранить в прохладном месте
2687	3	899	24	57	12	тонна	8	2024-07-09	29	Хранить в прохладном месте
2688	28	899	98	445	57	упаковка	6	2024-07-27	111	Без ГМО
2689	4	899	56	78	43	ящик	6	2024-10-17	62	
2690	47	899	79	314	114	ящик	3	2024-07-14	83	Органик
2691	25	900	93	218	182	ящик	2	2024-06-04	94	Хранить в прохладном месте
2692	10	900	76	481	315	кг	7	2024-07-13	94	Без ГМО
2693	25	900	99	136	14	упаковка	9	2024-08-29	114	Хранить в прохладном месте
2694	37	901	96	419	194	ящик	10	2024-11-10	98	Хранить в прохладном месте
2695	32	901	81	310	281	кг	4	2024-08-02	85	Органик
2696	11	901	20	151	46	ящик	10	2024-09-07	36	Хранить в прохладном месте
2697	26	902	59	369	57	упаковка	5	2024-07-06	66	
2698	18	902	74	446	226	тонна	2	2024-09-19	84	Хранить в прохладном месте
2699	20	902	36	190	189	упаковка	2	2024-10-25	50	
2700	7	903	69	341	31	упаковка	7	2024-08-15	73	
2701	19	903	89	117	53	ящик	3	2024-10-29	94	
2702	4	903	75	361	127	ящик	1	2024-06-03	89	Хранить в прохладном месте
2703	25	904	90	134	121	тонна	8	2024-10-26	106	Хранить в прохладном месте
2704	27	904	10	461	118	кг	5	2024-08-14	19	Хранить в прохладном месте
2705	32	904	42	436	160	тонна	4	2024-10-01	45	
2706	1	904	77	133	19	упаковка	7	2024-06-21	95	
2707	36	905	47	223	127	тонна	8	2024-10-06	57	
2708	22	905	62	289	192	ящик	9	2024-09-28	63	Хранить в прохладном месте
2709	7	905	79	253	155	тонна	1	2024-08-05	94	
2710	37	906	98	373	64	упаковка	8	2024-09-11	101	Без ГМО
2711	11	906	32	225	0	ящик	1	2024-10-19	44	
2712	10	906	40	127	9	кг	3	2024-07-06	52	Хранить в прохладном месте
2713	47	906	12	400	84	упаковка	9	2024-10-10	29	
2714	22	907	98	408	288	кг	2	2024-08-08	113	Хранить в прохладном месте
2715	18	907	13	493	272	кг	5	2024-06-21	28	Органик
2716	28	908	96	231	212	ящик	5	2024-10-18	97	Без ГМО
2717	2	908	71	23	4	кг	3	2024-11-19	84	Органик
2718	34	909	81	286	110	кг	4	2024-07-01	92	Хранить в прохладном месте
2719	31	909	79	467	192	кг	2	2024-06-10	91	Без ГМО
2720	8	910	28	314	191	упаковка	8	2024-10-05	48	
2721	23	910	99	215	45	ящик	10	2024-09-05	111	Хранить в прохладном месте
2722	6	910	45	369	149	кг	2	2024-09-13	48	
2723	11	910	45	43	35	кг	6	2024-08-17	47	Органик
2724	11	911	95	12	11	тонна	6	2024-11-22	107	
2725	12	911	10	403	391	тонна	8	2024-09-29	19	Органик
2726	31	912	58	79	59	упаковка	3	2024-06-08	72	Без ГМО
2727	19	912	33	158	82	упаковка	4	2024-10-24	44	
2728	47	912	82	11	1	упаковка	10	2024-10-03	101	
2729	7	913	24	127	44	ящик	6	2024-07-03	33	Органик
2730	35	913	29	298	173	ящик	3	2024-07-23	41	
2731	45	913	98	34	6	тонна	1	2024-08-08	117	Без ГМО
2732	36	914	83	239	216	упаковка	5	2024-07-06	86	
2733	40	914	10	118	8	упаковка	4	2024-06-26	11	Хранить в прохладном месте
2734	44	915	63	29	10	упаковка	8	2024-07-21	69	Хранить в прохладном месте
2735	35	915	24	408	166	тонна	4	2024-11-05	40	
2736	14	916	45	497	311	упаковка	6	2024-11-22	54	Органик
2737	32	916	91	352	149	тонна	6	2024-10-26	110	
2738	25	917	20	102	34	ящик	4	2024-08-22	27	Органик
2739	38	917	98	167	62	упаковка	7	2024-11-19	105	
2740	15	918	75	483	169	ящик	4	2024-07-31	86	
2741	6	918	73	227	35	ящик	3	2024-09-02	93	
2742	47	918	81	31	25	кг	8	2024-11-03	84	Хранить в прохладном месте
2743	11	918	73	135	124	ящик	6	2024-08-04	85	
2744	6	919	44	20	5	кг	7	2024-08-31	47	Без ГМО
2745	5	919	55	392	232	ящик	6	2024-07-29	60	Без ГМО
2746	41	919	90	439	182	ящик	3	2024-11-08	95	Органик
2747	9	919	28	55	40	тонна	10	2024-09-07	43	Без ГМО
2748	23	920	12	338	44	тонна	4	2024-11-16	27	Хранить в прохладном месте
2749	22	920	43	186	99	кг	4	2024-10-15	61	Органик
2750	24	920	30	88	62	ящик	4	2024-07-07	43	
2751	30	921	76	83	43	ящик	9	2024-10-29	94	
2752	22	921	93	394	17	упаковка	3	2024-06-03	95	Органик
2753	21	921	13	286	76	тонна	7	2024-09-08	24	
2754	27	922	13	190	94	тонна	4	2024-08-15	29	
2755	42	922	70	60	27	упаковка	10	2024-08-27	76	
2756	16	922	78	231	138	тонна	1	2024-07-19	84	Органик
2757	24	922	10	414	182	ящик	10	2024-07-07	23	Без ГМО
2758	47	923	30	480	412	тонна	6	2024-06-19	35	
2759	29	923	10	63	8	тонна	6	2024-08-22	23	Органик
2760	18	923	59	492	81	ящик	7	2024-11-20	63	
2761	20	923	70	91	12	тонна	7	2024-07-25	78	
2762	40	924	77	298	189	кг	2	2024-11-01	91	Без ГМО
2763	8	924	56	377	33	кг	4	2024-08-01	70	Органик
2764	9	924	64	202	56	ящик	6	2024-10-29	84	Без ГМО
2765	35	925	55	483	47	ящик	1	2024-11-27	59	Органик
2766	45	925	47	310	37	тонна	1	2024-08-17	48	Без ГМО
2767	5	926	55	229	165	ящик	10	2024-09-14	69	
2768	32	926	81	156	76	ящик	8	2024-06-27	96	Органик
2769	15	926	18	298	173	тонна	6	2024-10-29	24	Хранить в прохладном месте
2770	16	927	63	469	343	кг	3	2024-07-29	75	
2771	24	927	88	270	133	тонна	2	2024-08-08	95	Без ГМО
2772	17	927	65	100	4	упаковка	4	2024-08-12	66	Хранить в прохладном месте
2773	30	927	96	169	115	кг	1	2024-10-28	107	
2774	33	928	37	333	200	кг	9	2024-06-19	53	Органик
2775	3	928	88	134	34	ящик	1	2024-08-03	106	
2776	39	928	68	163	11	кг	4	2024-07-20	75	
2777	28	928	80	289	258	ящик	10	2024-09-22	96	Без ГМО
2778	47	929	54	429	105	тонна	5	2024-09-25	66	Хранить в прохладном месте
2779	1	929	29	349	24	кг	7	2024-06-11	44	
2780	24	930	11	482	227	кг	1	2024-07-21	26	Хранить в прохладном месте
2781	21	930	80	199	15	кг	9	2024-11-20	96	Без ГМО
2782	34	931	91	237	7	ящик	5	2024-08-02	104	
2783	25	931	44	115	22	ящик	2	2024-10-06	55	Без ГМО
2784	2	931	34	186	25	тонна	4	2024-11-09	39	Органик
2785	15	932	95	363	218	тонна	9	2024-06-13	97	Хранить в прохладном месте
2786	24	932	41	417	86	тонна	2	2024-09-28	56	
2787	1	932	100	417	335	упаковка	8	2024-07-26	114	Без ГМО
2788	1	932	16	341	187	упаковка	6	2024-06-24	25	
2789	25	933	31	208	29	кг	2	2024-10-05	43	
2790	4	933	54	83	13	тонна	6	2024-10-21	69	
2791	17	934	31	213	6	кг	7	2024-06-05	40	Хранить в прохладном месте
2792	47	934	78	214	107	тонна	4	2024-07-27	92	
2793	39	934	77	87	56	упаковка	10	2024-08-19	87	
2794	14	935	94	435	352	тонна	4	2024-08-17	112	Без ГМО
2795	27	935	33	195	82	тонна	9	2024-07-18	42	Органик
2796	48	935	86	146	85	ящик	9	2024-06-11	91	Органик
2797	17	935	67	240	193	ящик	2	2024-09-16	83	Хранить в прохладном месте
2798	35	936	69	421	151	ящик	4	2024-08-28	89	Органик
2799	26	936	58	89	54	упаковка	3	2024-10-01	63	Хранить в прохладном месте
2800	16	937	62	152	69	ящик	3	2024-09-17	82	Органик
2801	23	937	89	417	12	ящик	8	2024-07-17	95	Хранить в прохладном месте
2802	31	937	87	494	255	ящик	3	2024-11-07	93	Органик
2803	13	938	25	17	6	ящик	5	2024-07-28	37	Без ГМО
2804	14	938	64	497	4	кг	4	2024-06-08	78	Хранить в прохладном месте
2805	11	938	38	460	390	кг	10	2024-07-22	58	
2806	11	938	67	195	195	упаковка	1	2024-10-17	68	
2807	4	939	14	361	32	ящик	1	2024-06-29	21	
2808	17	939	58	15	1	упаковка	6	2024-10-22	70	
2809	31	939	91	471	466	ящик	4	2024-07-23	92	
2810	19	939	71	210	69	тонна	3	2024-10-24	89	Органик
2811	24	940	14	289	285	ящик	5	2024-10-28	32	Хранить в прохладном месте
2812	48	940	72	402	297	упаковка	1	2024-09-07	79	
2813	44	940	64	409	199	тонна	9	2024-11-08	74	
2814	36	941	65	317	183	упаковка	10	2024-11-24	78	Органик
2815	7	941	25	275	263	кг	5	2024-11-22	44	
2816	32	941	99	168	39	упаковка	8	2024-09-26	116	Без ГМО
2817	12	942	61	464	163	ящик	2	2024-10-11	80	Без ГМО
2818	42	942	54	144	17	ящик	6	2024-09-06	55	Органик
2819	22	943	90	149	52	ящик	4	2024-09-26	102	Хранить в прохладном месте
2820	15	943	32	40	34	упаковка	10	2024-06-04	37	Органик
2821	5	943	58	28	11	упаковка	7	2024-08-15	64	
2822	14	944	94	13	7	ящик	7	2024-09-21	105	Хранить в прохладном месте
2823	38	944	15	119	111	упаковка	10	2024-10-21	18	Органик
2824	8	944	73	69	41	тонна	6	2024-11-23	80	Хранить в прохладном месте
2825	2	945	83	291	66	тонна	10	2024-09-05	98	Без ГМО
2826	10	945	13	411	379	кг	7	2024-09-21	17	Хранить в прохладном месте
2827	15	946	39	212	176	упаковка	4	2024-06-10	57	
2828	44	946	32	349	219	тонна	4	2024-10-04	33	
2829	29	946	52	474	168	тонна	4	2024-09-15	54	
2830	32	946	27	356	17	упаковка	8	2024-11-23	35	
2831	5	947	100	12	11	упаковка	7	2024-08-09	109	Без ГМО
2832	17	947	65	341	331	ящик	1	2024-11-19	74	
2833	39	947	100	129	55	упаковка	3	2024-11-22	118	Без ГМО
2834	48	948	74	124	108	кг	1	2024-09-09	75	Органик
2835	4	948	75	365	15	упаковка	9	2024-06-20	81	Хранить в прохладном месте
2836	12	948	91	414	345	ящик	3	2024-08-11	106	
2837	32	949	45	86	50	ящик	10	2024-06-18	46	Органик
2838	43	949	61	41	23	ящик	1	2024-09-21	71	Органик
2839	9	950	31	377	126	упаковка	8	2024-10-30	47	
2840	21	950	63	317	193	кг	10	2024-11-21	68	Органик
2841	17	950	98	90	53	тонна	9	2024-06-12	112	Без ГМО
2842	47	950	43	484	118	кг	9	2024-11-02	53	
2843	9	951	74	495	354	кг	7	2024-06-20	81	
2844	30	951	93	212	123	тонна	2	2024-11-17	96	Хранить в прохладном месте
2845	7	952	40	81	73	упаковка	5	2024-08-05	48	
2846	1	952	90	198	60	кг	6	2024-11-11	102	
2847	7	952	60	349	161	кг	1	2024-08-09	76	Органик
2848	3	953	60	60	5	упаковка	1	2024-11-12	73	
2849	31	953	67	146	87	тонна	4	2024-09-02	70	
2850	1	953	48	248	188	ящик	9	2024-11-12	66	Органик
2851	4	953	52	102	30	упаковка	9	2024-10-01	66	Органик
2852	27	954	11	473	415	тонна	3	2024-08-19	31	Органик
2853	27	954	75	27	14	упаковка	6	2024-09-05	94	Органик
2854	43	954	100	24	17	кг	1	2024-07-06	117	Органик
2855	37	954	80	447	356	кг	3	2024-09-08	86	Органик
2856	31	955	22	131	83	ящик	8	2024-07-15	34	
2857	1	955	83	29	26	тонна	1	2024-10-22	88	
2858	16	955	93	156	0	тонна	3	2024-10-18	104	Органик
2859	17	956	29	420	243	упаковка	6	2024-10-23	38	
2860	31	956	48	88	26	ящик	4	2024-08-06	57	Органик
2861	44	956	59	218	205	тонна	3	2024-08-04	61	Без ГМО
2862	14	957	77	338	67	кг	7	2024-08-01	97	
2863	1	957	81	452	278	кг	6	2024-11-25	87	Без ГМО
2864	10	957	61	476	382	тонна	4	2024-07-25	64	Органик
2865	21	957	32	324	323	упаковка	10	2024-10-12	34	
2866	37	958	14	143	90	кг	9	2024-06-11	16	
2867	17	958	69	27	16	упаковка	6	2024-11-03	73	
2868	8	958	84	36	15	упаковка	1	2024-07-22	87	
2869	45	958	99	121	33	кг	5	2024-08-05	109	Хранить в прохладном месте
2870	21	959	11	424	391	ящик	6	2024-06-01	25	Без ГМО
2871	38	959	53	402	21	тонна	9	2024-11-13	62	Органик
2872	18	960	81	155	93	кг	5	2024-10-31	87	
2873	29	960	62	185	7	кг	4	2024-06-10	69	Без ГМО
2874	45	960	52	473	73	ящик	10	2024-06-26	72	
2875	6	960	37	112	11	ящик	4	2024-10-21	46	Без ГМО
2876	11	961	15	170	110	кг	10	2024-07-10	16	Органик
2877	37	961	28	390	251	упаковка	4	2024-11-19	47	Без ГМО
2878	30	961	100	226	142	ящик	10	2024-07-27	110	
2879	3	961	12	196	115	тонна	10	2024-06-15	25	
2880	21	962	64	41	6	ящик	7	2024-10-03	66	Органик
2881	21	962	25	199	167	ящик	1	2024-06-25	35	
2882	34	962	21	384	150	тонна	9	2024-06-20	39	
2883	26	963	95	104	43	ящик	10	2024-10-09	97	Без ГМО
2884	40	963	48	392	218	тонна	6	2024-08-21	54	
2885	1	963	78	160	7	кг	2	2024-09-21	97	Органик
2886	1	964	32	433	170	упаковка	7	2024-09-16	47	
2887	15	964	61	122	81	кг	7	2024-10-23	71	
2888	21	964	10	244	233	упаковка	2	2024-08-24	11	Без ГМО
2889	16	964	63	305	267	кг	8	2024-07-14	65	
2890	12	965	81	152	98	упаковка	3	2024-09-19	82	
2891	40	965	90	201	6	ящик	2	2024-08-16	96	Хранить в прохладном месте
2892	45	965	61	282	65	кг	1	2024-09-04	75	
2893	4	965	29	175	161	ящик	7	2024-10-10	41	Хранить в прохладном месте
2894	32	966	32	267	48	ящик	10	2024-08-30	45	
2895	32	966	89	177	7	кг	3	2024-06-10	95	
2896	36	966	76	195	129	ящик	2	2024-11-01	81	Хранить в прохладном месте
2897	46	966	11	355	43	ящик	4	2024-09-25	21	
2898	8	967	59	108	6	кг	6	2024-10-01	75	Хранить в прохладном месте
2899	41	967	88	313	265	ящик	10	2024-08-29	105	
2900	25	967	90	137	101	упаковка	6	2024-06-17	93	
2901	5	968	19	126	63	ящик	8	2024-11-24	34	Без ГМО
2902	43	968	10	142	42	тонна	7	2024-06-01	22	
2903	12	969	34	203	93	тонна	4	2024-10-12	42	Органик
2904	27	969	81	366	230	тонна	2	2024-10-20	83	
2905	24	969	91	376	306	тонна	6	2024-06-26	93	Хранить в прохладном месте
2906	36	969	67	440	155	кг	7	2024-06-26	73	Без ГМО
2907	30	970	80	132	92	ящик	9	2024-10-02	89	
2908	48	970	90	251	136	тонна	10	2024-10-01	93	Органик
2909	26	971	68	387	159	тонна	9	2024-06-07	72	
2910	43	971	55	431	375	ящик	6	2024-07-15	73	
2911	29	972	52	237	133	ящик	6	2024-06-20	64	Хранить в прохладном месте
2912	34	972	69	304	24	кг	7	2024-06-24	89	Органик
2913	29	973	81	19	2	тонна	7	2024-09-12	88	
2914	20	973	18	281	135	упаковка	10	2024-11-26	37	
2915	3	973	72	271	78	ящик	4	2024-07-15	83	Без ГМО
2916	15	974	45	344	232	кг	1	2024-09-09	46	
2917	30	974	91	457	8	тонна	7	2024-07-05	101	Органик
2918	21	974	64	301	164	ящик	10	2024-10-11	69	
2919	46	974	90	206	115	тонна	3	2024-06-10	106	
2920	45	975	60	391	15	тонна	4	2024-11-03	63	
2921	16	975	23	282	78	тонна	5	2024-10-16	43	Хранить в прохладном месте
2922	36	976	51	374	144	ящик	3	2024-10-03	55	
2923	2	976	86	30	9	кг	2	2024-11-18	106	Хранить в прохладном месте
2924	36	976	45	483	384	кг	4	2024-06-14	58	
2925	7	977	92	188	151	упаковка	6	2024-07-05	104	
2926	33	977	18	324	170	тонна	8	2024-07-14	28	Хранить в прохладном месте
2927	9	978	15	34	31	упаковка	5	2024-08-31	23	Органик
2928	34	978	50	66	24	ящик	1	2024-07-26	64	Органик
2929	1	978	33	130	115	кг	2	2024-11-28	47	Без ГМО
2930	17	979	72	88	79	тонна	7	2024-06-13	73	
2931	14	979	97	411	150	тонна	3	2024-06-23	99	
2932	5	979	17	153	74	кг	2	2024-10-04	32	Без ГМО
2933	14	980	16	98	86	упаковка	10	2024-07-29	36	Без ГМО
2934	34	980	48	237	194	упаковка	5	2024-08-19	58	Без ГМО
2935	42	981	40	488	412	упаковка	4	2024-11-10	42	Органик
2936	12	981	88	357	278	упаковка	10	2024-11-14	104	Хранить в прохладном месте
2937	17	981	17	493	245	упаковка	6	2024-10-24	18	Без ГМО
2938	25	981	73	272	142	ящик	2	2024-09-18	93	
2939	35	982	96	131	20	упаковка	5	2024-08-27	108	Без ГМО
2940	29	982	11	377	372	тонна	10	2024-07-08	31	Без ГМО
2941	20	982	44	436	322	тонна	3	2024-09-04	59	
2942	7	982	59	131	84	ящик	9	2024-07-12	63	
2943	20	983	51	93	56	тонна	10	2024-08-12	52	
2944	8	983	68	351	347	ящик	2	2024-10-09	77	
2945	23	983	38	357	279	ящик	2	2024-06-11	40	Без ГМО
2946	44	983	36	53	0	кг	7	2024-07-29	51	Органик
2947	9	984	88	200	42	тонна	9	2024-11-28	98	Без ГМО
2948	41	984	44	27	19	кг	2	2024-09-16	60	Без ГМО
2949	42	985	91	186	109	ящик	10	2024-06-29	100	Без ГМО
2950	25	985	53	76	48	упаковка	1	2024-10-23	68	
2951	39	985	74	228	2	ящик	2	2024-10-04	90	Хранить в прохладном месте
2952	37	985	20	212	35	упаковка	6	2024-11-19	30	
2953	30	986	19	464	105	тонна	8	2024-09-20	23	
2954	38	986	15	61	13	упаковка	5	2024-11-27	17	Без ГМО
2955	46	986	55	284	51	ящик	10	2024-11-19	71	Без ГМО
2956	40	986	15	266	251	ящик	8	2024-11-22	35	Хранить в прохладном месте
2957	34	987	19	114	88	ящик	3	2024-09-08	32	Без ГМО
2958	31	987	93	52	20	ящик	10	2024-07-12	95	Без ГМО
2959	36	987	59	254	29	упаковка	3	2024-07-07	75	Органик
2960	30	987	41	237	222	кг	8	2024-09-19	60	Органик
2961	37	988	52	126	45	упаковка	9	2024-07-26	55	Хранить в прохладном месте
2962	5	988	84	25	3	тонна	3	2024-10-06	92	Хранить в прохладном месте
2963	8	989	72	245	25	упаковка	9	2024-07-24	74	Хранить в прохладном месте
2964	22	989	64	310	259	ящик	4	2024-08-30	65	Без ГМО
2965	26	989	20	443	90	ящик	8	2024-08-19	31	
2966	38	990	58	286	205	тонна	10	2024-10-17	64	Органик
2967	16	990	21	357	164	ящик	8	2024-09-21	33	Без ГМО
2968	27	991	99	397	241	ящик	8	2024-10-03	112	Без ГМО
2969	28	991	29	319	33	ящик	5	2024-11-10	41	
2970	25	991	53	79	15	тонна	4	2024-09-03	73	
2971	37	991	32	308	90	кг	4	2024-11-13	44	Органик
2972	31	992	44	18	7	кг	4	2024-07-08	56	
2973	20	992	99	69	65	тонна	10	2024-08-23	109	Без ГМО
2974	31	992	10	60	39	ящик	7	2024-09-22	27	
2975	25	992	36	244	210	тонна	4	2024-07-11	48	
2976	27	993	25	248	168	упаковка	6	2024-08-13	38	Органик
2977	17	993	39	27	12	кг	10	2024-11-06	53	
2978	43	993	88	170	140	упаковка	3	2024-09-18	105	Органик
2979	26	993	26	12	6	ящик	9	2024-08-31	29	Без ГМО
2980	3	994	70	413	282	упаковка	10	2024-11-24	83	Хранить в прохладном месте
2981	3	994	73	479	14	упаковка	4	2024-08-19	88	Без ГМО
2982	23	995	36	62	33	ящик	10	2024-06-19	39	Хранить в прохладном месте
2983	10	995	56	269	247	кг	10	2024-10-13	65	Органик
2984	6	995	33	455	369	ящик	4	2024-08-05	35	Без ГМО
2985	12	996	34	197	44	ящик	3	2024-07-08	45	Органик
2986	9	996	57	482	106	кг	7	2024-06-19	72	Без ГМО
2987	42	996	60	146	116	тонна	2	2024-07-19	73	Органик
2988	5	996	18	312	63	упаковка	10	2024-10-10	38	Органик
2989	20	997	57	181	40	ящик	10	2024-09-26	59	Без ГМО
2990	47	997	44	424	334	упаковка	10	2024-07-25	62	Хранить в прохладном месте
2991	37	997	55	476	442	тонна	8	2024-11-20	63	
2992	46	998	86	373	150	кг	8	2024-11-06	106	Хранить в прохладном месте
2993	18	998	47	13	7	упаковка	4	2024-06-15	62	Органик
2994	34	999	67	422	256	ящик	8	2024-06-08	69	Без ГМО
2995	36	999	65	322	47	ящик	3	2024-08-25	74	
2996	43	1000	32	442	44	тонна	10	2024-08-09	34	Хранить в прохладном месте
2997	43	1000	77	334	164	ящик	6	2024-11-22	94	Органик
2998	2	1000	70	27	17	ящик	7	2024-09-11	77	
\.


--
-- TOC entry 3734 (class 0 OID 16870)
-- Dependencies: 239
-- Data for Name: supply_invoice; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.supply_invoice (supply_invoice_id, supply_id, amount, issue_date, payment_date, payment_status) FROM stdin;
1	1	79343	2024-03-15	2024-03-16	оплачен
2	2	68168	2024-02-27	\N	отменён
3	3	43503	2024-03-02	\N	ожидание
4	4	25840	2024-03-15	2024-03-25	оплачен
5	5	28502	2024-02-18	2024-02-23	оплачен
6	6	26998	2024-02-29	\N	ожидание
7	7	41693	2024-03-09	2024-03-19	оплачен
8	8	90248	2024-02-15	2024-02-20	оплачен
9	9	82191	2024-03-13	2024-03-21	оплачен
10	10	15089	2024-03-03	2024-03-08	оплачен
11	11	45521	2024-02-26	2024-03-04	оплачен
12	12	90016	2024-02-27	2024-03-06	оплачен
13	13	81494	2024-02-17	\N	отменён
14	14	66545	2024-03-04	2024-03-09	оплачен
15	15	30154	2024-02-21	\N	ожидание
16	16	80003	2024-03-09	\N	отменён
17	17	27088	2024-02-15	\N	ожидание
18	18	42036	2024-03-09	\N	ожидание
19	19	21064	2024-03-13	\N	отменён
20	20	86001	2024-02-27	2024-03-06	оплачен
21	21	98988	2024-02-18	2024-02-26	оплачен
22	22	76140	2024-02-29	\N	отменён
23	23	17424	2024-03-03	\N	ожидание
24	24	74838	2024-03-08	\N	отменён
25	25	40875	2024-02-17	2024-02-19	оплачен
26	26	95532	2024-03-05	\N	отменён
27	27	16545	2024-02-29	2024-03-04	оплачен
28	28	63578	2024-03-07	\N	отменён
29	29	10212	2024-02-27	2024-02-28	оплачен
30	30	52402	2024-02-19	\N	ожидание
31	31	82489	2024-03-16	\N	отменён
32	32	17308	2024-03-13	\N	ожидание
33	33	35675	2024-03-06	2024-03-15	оплачен
34	34	16169	2024-02-22	\N	ожидание
35	35	87057	2024-02-15	2024-02-18	оплачен
36	36	64239	2024-03-09	2024-03-17	оплачен
37	37	68135	2024-02-23	\N	ожидание
38	38	37602	2024-03-03	\N	отменён
39	39	72525	2024-03-04	2024-03-08	оплачен
40	40	34841	2024-03-03	\N	ожидание
41	41	46784	2024-02-19	2024-02-23	оплачен
42	42	74152	2024-02-19	\N	ожидание
43	43	67903	2024-03-16	\N	отменён
44	44	30415	2024-02-25	\N	ожидание
45	45	82313	2024-03-03	2024-03-07	оплачен
46	46	28330	2024-02-28	\N	отменён
47	47	50825	2024-02-25	\N	отменён
48	48	65040	2024-03-16	\N	отменён
49	49	79350	2024-02-29	2024-03-05	оплачен
50	50	26209	2024-03-09	\N	отменён
51	51	78276	2024-02-18	\N	ожидание
52	52	86874	2024-03-11	\N	отменён
53	53	24881	2024-03-11	\N	отменён
54	54	11348	2024-03-04	\N	отменён
55	55	49653	2024-03-08	\N	отменён
56	56	25028	2024-03-03	\N	отменён
57	57	26860	2024-02-19	2024-02-26	оплачен
58	58	17580	2024-02-15	\N	ожидание
59	59	49262	2024-02-18	\N	отменён
60	60	26290	2024-02-26	2024-03-01	оплачен
61	61	81425	2024-03-11	\N	ожидание
62	62	51215	2024-02-23	\N	отменён
63	63	69064	2024-02-17	\N	ожидание
64	64	55409	2024-02-29	2024-03-01	оплачен
65	65	81189	2024-03-12	2024-03-21	оплачен
66	66	72014	2024-03-12	\N	отменён
67	67	61094	2024-03-06	2024-03-12	оплачен
68	68	87664	2024-03-16	\N	отменён
69	69	48526	2024-03-13	\N	отменён
70	70	50518	2024-03-14	2024-03-15	оплачен
71	71	75819	2024-03-01	2024-03-03	оплачен
72	72	47640	2024-02-23	\N	отменён
73	73	71808	2024-03-02	2024-03-11	оплачен
74	74	53773	2024-02-29	\N	ожидание
75	75	66759	2024-03-03	\N	ожидание
76	76	40947	2024-03-12	\N	ожидание
77	77	34719	2024-02-26	2024-03-06	оплачен
78	78	45124	2024-03-13	\N	ожидание
79	79	37300	2024-03-11	\N	ожидание
80	80	27722	2024-03-16	\N	ожидание
81	81	57072	2024-03-08	\N	ожидание
82	82	35905	2024-02-26	2024-03-01	оплачен
83	83	24718	2024-03-12	\N	ожидание
84	84	95531	2024-03-04	\N	отменён
85	85	84494	2024-03-14	\N	ожидание
86	86	18834	2024-02-22	2024-02-29	оплачен
87	87	40599	2024-02-25	\N	ожидание
88	88	33694	2024-02-21	\N	отменён
89	89	54849	2024-03-09	\N	отменён
90	90	60873	2024-02-28	\N	отменён
91	91	72178	2024-02-28	2024-03-05	оплачен
92	92	56117	2024-02-20	\N	отменён
93	93	97442	2024-03-10	\N	ожидание
94	94	19329	2024-02-18	2024-02-21	оплачен
95	95	96223	2024-03-10	\N	отменён
96	96	15008	2024-03-15	\N	ожидание
97	97	65158	2024-02-23	2024-02-26	оплачен
98	98	41549	2024-03-13	2024-03-14	оплачен
99	99	58449	2024-02-28	\N	ожидание
100	100	23455	2024-03-12	2024-03-14	оплачен
101	101	85192	2024-02-27	\N	ожидание
102	102	21905	2024-02-22	\N	ожидание
103	103	93580	2024-02-19	\N	ожидание
104	104	95326	2024-02-21	2024-02-22	оплачен
105	105	20285	2024-03-01	2024-03-11	оплачен
106	106	24594	2024-03-16	\N	отменён
107	107	95197	2024-02-21	\N	отменён
108	108	87515	2024-03-01	2024-03-06	оплачен
109	109	37513	2024-03-10	\N	отменён
110	110	45601	2024-03-13	\N	отменён
111	111	68730	2024-03-01	2024-03-02	оплачен
112	112	40559	2024-02-29	2024-03-02	оплачен
113	113	87157	2024-03-03	\N	отменён
114	114	15001	2024-02-25	2024-02-29	оплачен
115	115	99217	2024-03-02	\N	отменён
116	116	73490	2024-02-27	2024-02-28	оплачен
117	117	42189	2024-03-15	\N	ожидание
118	118	49753	2024-03-03	\N	отменён
119	119	36093	2024-03-11	2024-03-21	оплачен
120	120	34487	2024-02-23	\N	отменён
121	121	52286	2024-03-08	2024-03-18	оплачен
122	122	11329	2024-02-24	2024-03-02	оплачен
123	123	11246	2024-03-14	\N	отменён
124	124	94727	2024-03-05	\N	отменён
125	125	59020	2024-03-09	\N	отменён
126	126	57842	2024-03-14	\N	ожидание
127	127	21038	2024-03-16	2024-03-23	оплачен
128	128	41032	2024-03-15	2024-03-18	оплачен
129	129	97444	2024-02-21	\N	отменён
130	130	30933	2024-02-26	2024-03-05	оплачен
131	131	24705	2024-03-01	\N	отменён
132	132	47829	2024-02-23	\N	отменён
133	133	27761	2024-03-12	\N	отменён
134	134	11556	2024-02-29	\N	ожидание
135	135	67850	2024-02-24	\N	ожидание
136	136	79321	2024-03-13	\N	ожидание
137	137	94829	2024-02-28	2024-03-02	оплачен
138	138	41263	2024-02-15	\N	отменён
139	139	65423	2024-02-16	\N	отменён
140	140	61198	2024-03-15	\N	отменён
141	141	76081	2024-03-16	\N	отменён
142	142	48018	2024-02-29	\N	отменён
143	143	70293	2024-03-12	\N	отменён
144	144	68583	2024-03-05	2024-03-08	оплачен
145	145	39709	2024-02-20	\N	ожидание
146	146	46167	2024-02-22	\N	ожидание
147	147	71037	2024-03-06	\N	отменён
148	148	34780	2024-03-06	\N	ожидание
149	149	24658	2024-03-10	\N	отменён
150	150	57041	2024-03-14	2024-03-22	оплачен
151	151	81284	2024-02-26	\N	ожидание
152	152	54427	2024-03-03	\N	ожидание
153	153	50589	2024-02-19	\N	ожидание
154	154	60554	2024-02-20	\N	ожидание
155	155	18677	2024-03-04	\N	отменён
156	156	94799	2024-02-15	\N	ожидание
157	157	59741	2024-03-02	\N	ожидание
158	158	60489	2024-02-20	\N	отменён
159	159	56347	2024-03-02	\N	отменён
160	160	58929	2024-03-13	\N	ожидание
161	161	59804	2024-02-17	\N	отменён
162	162	26044	2024-03-03	2024-03-08	оплачен
163	163	73725	2024-03-09	\N	ожидание
164	164	96819	2024-02-16	\N	ожидание
165	165	53263	2024-02-18	\N	ожидание
166	166	60359	2024-03-02	\N	ожидание
167	167	20106	2024-02-27	\N	ожидание
168	168	19790	2024-03-12	\N	отменён
169	169	56067	2024-03-11	\N	отменён
170	170	54434	2024-02-25	\N	ожидание
171	171	61355	2024-03-10	\N	отменён
172	172	26391	2024-02-18	\N	ожидание
173	173	64692	2024-02-26	2024-03-02	оплачен
174	174	68872	2024-02-17	\N	отменён
175	175	74305	2024-03-05	\N	отменён
176	176	30307	2024-03-12	\N	ожидание
177	177	21729	2024-02-23	\N	ожидание
178	178	10901	2024-02-23	\N	ожидание
179	179	94136	2024-03-12	\N	отменён
180	180	61931	2024-02-17	\N	ожидание
181	181	77988	2024-02-17	\N	отменён
182	182	82539	2024-03-12	\N	отменён
183	183	80363	2024-03-15	\N	ожидание
184	184	24727	2024-03-07	\N	отменён
185	185	70077	2024-02-28	\N	ожидание
186	186	38345	2024-02-24	\N	отменён
187	187	90816	2024-02-19	2024-02-25	оплачен
188	188	78451	2024-02-25	2024-02-29	оплачен
189	189	20979	2024-02-22	2024-02-25	оплачен
190	190	63984	2024-03-14	2024-03-20	оплачен
191	191	79820	2024-03-10	\N	отменён
192	192	75372	2024-03-13	\N	ожидание
193	193	84877	2024-02-23	\N	отменён
194	194	39692	2024-03-03	2024-03-12	оплачен
195	195	12348	2024-02-19	\N	отменён
196	196	33630	2024-03-12	2024-03-14	оплачен
197	197	25372	2024-02-23	2024-02-26	оплачен
198	198	10721	2024-02-15	\N	ожидание
199	199	29283	2024-03-13	\N	ожидание
200	200	30447	2024-03-04	\N	ожидание
201	201	12003	2024-02-29	\N	ожидание
202	202	84018	2024-03-09	\N	ожидание
203	203	32438	2024-03-02	2024-03-05	оплачен
204	204	75380	2024-03-06	\N	отменён
205	205	39364	2024-02-17	\N	отменён
206	206	66364	2024-03-11	2024-03-17	оплачен
207	207	20247	2024-03-10	\N	отменён
208	208	56116	2024-03-05	2024-03-15	оплачен
209	209	30184	2024-03-15	\N	ожидание
210	210	72012	2024-03-05	\N	ожидание
211	211	86890	2024-03-02	\N	отменён
212	212	47853	2024-03-15	\N	отменён
213	213	34369	2024-03-07	2024-03-08	оплачен
214	214	36294	2024-02-21	\N	отменён
215	215	52038	2024-03-01	\N	отменён
216	216	47837	2024-03-03	2024-03-11	оплачен
217	217	93958	2024-02-17	\N	ожидание
218	218	84468	2024-03-11	\N	отменён
219	219	52536	2024-03-02	\N	отменён
220	220	11077	2024-03-13	2024-03-16	оплачен
221	221	65622	2024-03-04	\N	ожидание
222	222	56187	2024-03-06	2024-03-09	оплачен
223	223	45238	2024-02-16	\N	ожидание
224	224	52884	2024-03-02	\N	отменён
225	225	29718	2024-03-13	\N	ожидание
226	226	49404	2024-03-16	\N	ожидание
227	227	10632	2024-03-06	2024-03-08	оплачен
228	228	29345	2024-03-12	2024-03-17	оплачен
229	229	73033	2024-02-25	\N	ожидание
230	230	48188	2024-02-23	\N	отменён
231	231	29738	2024-03-06	2024-03-15	оплачен
232	232	30030	2024-02-15	\N	ожидание
233	233	17340	2024-03-06	\N	отменён
234	234	53331	2024-03-16	2024-03-21	оплачен
235	235	93545	2024-03-08	2024-03-18	оплачен
236	236	63940	2024-02-22	2024-02-27	оплачен
237	237	23907	2024-02-18	2024-02-22	оплачен
238	238	62895	2024-02-24	2024-02-26	оплачен
239	239	43553	2024-03-06	\N	отменён
240	240	89075	2024-02-21	2024-02-25	оплачен
241	241	21974	2024-03-15	\N	отменён
242	242	46505	2024-02-18	2024-02-27	оплачен
243	243	71016	2024-03-04	\N	отменён
244	244	34823	2024-03-01	\N	ожидание
245	245	29052	2024-03-14	\N	отменён
246	246	68433	2024-02-19	\N	ожидание
247	247	85182	2024-02-25	2024-03-02	оплачен
248	248	78345	2024-02-18	\N	ожидание
249	249	49851	2024-03-15	\N	ожидание
250	250	89587	2024-02-27	2024-03-03	оплачен
251	251	54588	2024-03-03	\N	ожидание
252	252	75275	2024-03-09	\N	ожидание
253	253	42057	2024-03-11	\N	ожидание
254	254	42774	2024-03-15	\N	отменён
255	255	66391	2024-02-28	2024-03-06	оплачен
256	256	86249	2024-03-02	\N	ожидание
257	257	42606	2024-02-16	\N	отменён
258	258	30467	2024-03-13	\N	ожидание
259	259	81217	2024-03-12	2024-03-21	оплачен
260	260	87767	2024-03-11	\N	отменён
261	261	43559	2024-02-23	\N	отменён
262	262	83427	2024-03-16	\N	отменён
263	263	10043	2024-02-18	2024-02-26	оплачен
264	264	98672	2024-02-20	\N	отменён
265	265	90348	2024-03-16	\N	отменён
266	266	50258	2024-03-06	\N	ожидание
267	267	20712	2024-02-22	\N	ожидание
268	268	90711	2024-02-19	\N	ожидание
269	269	10143	2024-02-29	\N	ожидание
270	270	84876	2024-02-18	\N	отменён
271	271	87711	2024-02-18	2024-02-27	оплачен
272	272	30474	2024-02-27	\N	отменён
273	273	58271	2024-02-28	\N	ожидание
274	274	17058	2024-02-17	\N	ожидание
275	275	54388	2024-02-21	\N	ожидание
276	276	33040	2024-02-21	\N	ожидание
277	277	73701	2024-02-28	2024-03-02	оплачен
278	278	79299	2024-02-23	\N	отменён
279	279	87599	2024-03-11	\N	отменён
280	280	50663	2024-02-27	\N	ожидание
281	281	77809	2024-02-28	\N	ожидание
282	282	65836	2024-02-19	2024-02-20	оплачен
283	283	29766	2024-02-29	\N	ожидание
284	284	62652	2024-03-04	\N	ожидание
285	285	95091	2024-03-05	2024-03-13	оплачен
286	286	53707	2024-02-23	\N	ожидание
287	287	27328	2024-02-28	\N	ожидание
288	288	86353	2024-03-03	2024-03-09	оплачен
289	289	93858	2024-02-29	\N	отменён
290	290	95508	2024-03-05	\N	отменён
291	291	82044	2024-02-17	\N	отменён
292	292	59483	2024-03-16	2024-03-26	оплачен
293	293	70827	2024-03-11	\N	ожидание
294	294	82637	2024-02-27	\N	отменён
295	295	22567	2024-03-08	2024-03-11	оплачен
296	296	81309	2024-02-29	2024-03-05	оплачен
297	297	10838	2024-02-29	\N	отменён
298	298	78183	2024-02-21	\N	отменён
299	299	42972	2024-02-23	2024-02-26	оплачен
300	300	40891	2024-03-03	\N	отменён
301	301	60551	2024-02-16	2024-02-17	оплачен
302	302	33600	2024-02-27	\N	отменён
303	303	61364	2024-03-01	2024-03-10	оплачен
304	304	85190	2024-02-19	2024-02-27	оплачен
305	305	11086	2024-02-28	\N	ожидание
306	306	36662	2024-02-20	\N	отменён
307	307	83487	2024-02-29	\N	отменён
308	308	88649	2024-02-24	\N	ожидание
309	309	36439	2024-02-19	2024-02-25	оплачен
310	310	31641	2024-03-12	2024-03-21	оплачен
311	311	20893	2024-03-11	\N	ожидание
312	312	65590	2024-02-17	\N	отменён
313	313	56496	2024-02-25	2024-03-01	оплачен
314	314	52546	2024-02-27	2024-03-05	оплачен
315	315	86079	2024-02-27	2024-03-06	оплачен
316	316	22888	2024-03-08	2024-03-11	оплачен
317	317	60309	2024-03-01	\N	отменён
318	318	72147	2024-02-17	\N	ожидание
319	319	91683	2024-03-14	2024-03-23	оплачен
320	320	58773	2024-02-17	\N	ожидание
321	321	21691	2024-03-15	2024-03-16	оплачен
322	322	95585	2024-03-05	2024-03-13	оплачен
323	323	65118	2024-02-25	2024-03-06	оплачен
324	324	70210	2024-03-15	\N	ожидание
325	325	92466	2024-02-23	\N	ожидание
326	326	75108	2024-03-08	\N	отменён
327	327	12794	2024-03-03	\N	ожидание
328	328	57045	2024-03-13	\N	отменён
329	329	32573	2024-02-23	\N	ожидание
330	330	82312	2024-03-07	2024-03-11	оплачен
331	331	35812	2024-02-15	\N	отменён
332	332	83881	2024-02-27	\N	ожидание
333	333	54601	2024-03-06	\N	отменён
334	334	78760	2024-02-27	2024-03-06	оплачен
335	335	66309	2024-02-26	\N	ожидание
336	336	45887	2024-03-14	\N	отменён
337	337	30958	2024-02-15	\N	ожидание
338	338	79787	2024-03-09	2024-03-19	оплачен
339	339	33890	2024-02-26	\N	ожидание
340	340	16204	2024-03-07	\N	отменён
341	341	58015	2024-02-23	\N	отменён
342	342	99363	2024-02-19	2024-02-24	оплачен
343	343	55139	2024-02-26	\N	ожидание
344	344	69211	2024-02-22	\N	отменён
345	345	34421	2024-03-16	\N	отменён
346	346	13469	2024-03-10	\N	ожидание
347	347	25873	2024-02-20	\N	отменён
348	348	11943	2024-03-12	\N	ожидание
349	349	64902	2024-03-13	\N	ожидание
350	350	66127	2024-02-18	\N	отменён
351	351	26855	2024-02-20	2024-02-21	оплачен
352	352	78232	2024-03-04	\N	отменён
353	353	84555	2024-03-09	\N	ожидание
354	354	85330	2024-03-04	2024-03-06	оплачен
355	355	44931	2024-02-20	2024-02-26	оплачен
356	356	99925	2024-02-21	\N	отменён
357	357	34873	2024-02-16	\N	отменён
358	358	36761	2024-03-04	\N	отменён
359	359	31405	2024-03-02	\N	ожидание
360	360	93794	2024-02-16	\N	ожидание
361	361	23860	2024-02-27	\N	отменён
362	362	71747	2024-03-07	\N	ожидание
363	363	95720	2024-02-28	2024-03-06	оплачен
364	364	37702	2024-02-16	\N	отменён
365	365	47451	2024-03-14	\N	отменён
366	366	35103	2024-02-18	2024-02-21	оплачен
367	367	90160	2024-03-12	\N	отменён
368	368	89600	2024-02-20	\N	ожидание
369	369	84738	2024-03-12	2024-03-21	оплачен
370	370	22828	2024-03-07	2024-03-17	оплачен
371	371	20228	2024-03-14	2024-03-20	оплачен
372	372	68854	2024-03-08	\N	отменён
373	373	74105	2024-02-23	2024-02-26	оплачен
374	374	56534	2024-02-20	\N	отменён
375	375	60799	2024-02-27	\N	отменён
376	376	88376	2024-02-22	\N	отменён
377	377	99866	2024-02-22	2024-02-25	оплачен
378	378	81313	2024-03-08	\N	ожидание
379	379	65148	2024-02-21	2024-02-25	оплачен
380	380	53844	2024-02-17	\N	отменён
381	381	22767	2024-03-14	\N	ожидание
382	382	13782	2024-02-21	2024-02-23	оплачен
383	383	57245	2024-03-16	\N	отменён
384	384	41680	2024-03-10	\N	отменён
385	385	10484	2024-03-03	2024-03-08	оплачен
386	386	20320	2024-02-16	\N	отменён
387	387	70813	2024-02-20	\N	отменён
388	388	78027	2024-03-05	2024-03-12	оплачен
389	389	66308	2024-03-06	2024-03-07	оплачен
390	390	75910	2024-03-15	2024-03-19	оплачен
391	391	41128	2024-03-14	\N	отменён
392	392	40349	2024-02-27	2024-03-08	оплачен
393	393	41404	2024-03-08	2024-03-18	оплачен
394	394	86913	2024-03-06	\N	отменён
395	395	50290	2024-02-26	\N	ожидание
396	396	28439	2024-02-20	\N	ожидание
397	397	73360	2024-02-21	\N	отменён
398	398	37608	2024-03-15	\N	ожидание
399	399	79907	2024-02-19	\N	ожидание
400	400	46144	2024-02-26	2024-02-27	оплачен
401	401	61753	2024-03-15	\N	отменён
402	402	58692	2024-03-16	\N	ожидание
403	403	89780	2024-02-21	\N	ожидание
404	404	29044	2024-03-14	2024-03-17	оплачен
405	405	37830	2024-02-23	\N	отменён
406	406	65315	2024-02-20	\N	ожидание
407	407	61278	2024-03-06	\N	отменён
408	408	13809	2024-03-06	\N	отменён
409	409	84345	2024-03-16	\N	ожидание
410	410	81453	2024-03-15	2024-03-21	оплачен
411	411	69431	2024-02-25	2024-02-27	оплачен
412	412	84339	2024-03-05	2024-03-14	оплачен
413	413	80860	2024-02-27	\N	ожидание
414	414	80125	2024-02-28	2024-03-09	оплачен
415	415	18857	2024-02-26	2024-03-02	оплачен
416	416	77908	2024-03-12	\N	ожидание
417	417	69598	2024-03-02	\N	отменён
418	418	56297	2024-02-26	2024-02-28	оплачен
419	419	33401	2024-03-05	2024-03-12	оплачен
420	420	62021	2024-02-20	2024-02-28	оплачен
421	421	82731	2024-03-01	2024-03-08	оплачен
422	422	23992	2024-02-25	2024-02-27	оплачен
423	423	17081	2024-03-12	2024-03-13	оплачен
424	424	53700	2024-02-24	2024-03-05	оплачен
425	425	98615	2024-03-16	\N	ожидание
426	426	84577	2024-03-03	\N	ожидание
427	427	32154	2024-03-07	2024-03-09	оплачен
428	428	63241	2024-03-08	\N	ожидание
429	429	95091	2024-03-09	\N	отменён
430	430	39065	2024-03-02	\N	отменён
431	431	55603	2024-02-19	\N	отменён
432	432	83267	2024-02-21	\N	ожидание
433	433	49318	2024-03-12	\N	отменён
434	434	50971	2024-03-13	2024-03-19	оплачен
435	435	91058	2024-02-21	\N	ожидание
436	436	52642	2024-02-21	2024-02-27	оплачен
437	437	70825	2024-03-03	\N	отменён
438	438	68232	2024-03-16	\N	ожидание
439	439	19322	2024-02-23	\N	ожидание
440	440	89508	2024-03-05	\N	ожидание
441	441	37812	2024-02-29	\N	ожидание
442	442	61293	2024-03-13	2024-03-16	оплачен
443	443	38149	2024-03-07	\N	ожидание
444	444	93949	2024-02-22	\N	ожидание
445	445	55066	2024-03-01	\N	отменён
446	446	75251	2024-02-29	\N	отменён
447	447	17294	2024-02-17	2024-02-25	оплачен
448	448	24419	2024-03-14	2024-03-19	оплачен
449	449	30074	2024-02-23	2024-02-25	оплачен
450	450	29198	2024-02-21	2024-02-23	оплачен
451	451	64551	2024-03-12	2024-03-19	оплачен
452	452	10790	2024-03-16	2024-03-25	оплачен
453	453	13482	2024-03-14	\N	отменён
454	454	22168	2024-03-07	\N	отменён
455	455	74374	2024-03-03	2024-03-06	оплачен
456	456	66262	2024-03-15	2024-03-20	оплачен
457	457	24470	2024-03-13	2024-03-22	оплачен
458	458	14402	2024-02-22	\N	ожидание
459	459	19143	2024-03-07	2024-03-08	оплачен
460	460	75949	2024-03-03	\N	отменён
461	461	25154	2024-02-20	\N	ожидание
462	462	32227	2024-02-15	2024-02-16	оплачен
463	463	77928	2024-02-24	2024-02-28	оплачен
464	464	26683	2024-03-01	2024-03-06	оплачен
465	465	98217	2024-02-29	2024-03-06	оплачен
466	466	48071	2024-03-09	\N	ожидание
467	467	59233	2024-02-15	2024-02-25	оплачен
468	468	17076	2024-02-29	\N	отменён
469	469	10496	2024-02-26	2024-03-02	оплачен
470	470	86959	2024-03-07	2024-03-13	оплачен
471	471	10284	2024-03-08	2024-03-14	оплачен
472	472	70714	2024-02-22	\N	ожидание
473	473	36686	2024-02-17	\N	ожидание
474	474	94307	2024-02-26	\N	ожидание
475	475	68968	2024-03-01	2024-03-10	оплачен
476	476	73927	2024-03-15	\N	ожидание
477	477	21172	2024-03-09	2024-03-19	оплачен
478	478	16338	2024-02-19	\N	отменён
479	479	36565	2024-03-08	\N	отменён
480	480	23393	2024-02-23	\N	отменён
481	481	78481	2024-03-14	\N	отменён
482	482	29300	2024-02-16	\N	ожидание
483	483	19597	2024-03-14	2024-03-19	оплачен
484	484	46004	2024-03-10	2024-03-20	оплачен
485	485	57318	2024-03-09	\N	ожидание
486	486	37345	2024-03-05	\N	ожидание
487	487	11367	2024-03-03	\N	отменён
488	488	28328	2024-02-18	2024-02-19	оплачен
489	489	56246	2024-03-04	2024-03-11	оплачен
490	490	73105	2024-03-16	2024-03-25	оплачен
491	491	84802	2024-03-01	\N	отменён
492	492	84191	2024-03-03	\N	отменён
493	493	51110	2024-02-17	2024-02-18	оплачен
494	494	93006	2024-03-11	2024-03-13	оплачен
495	495	40869	2024-03-01	\N	ожидание
496	496	91258	2024-03-10	\N	ожидание
497	497	89961	2024-03-06	\N	ожидание
498	498	33934	2024-03-12	\N	ожидание
499	499	63353	2024-03-10	2024-03-17	оплачен
500	500	34332	2024-02-27	\N	отменён
501	501	84312	2024-03-08	\N	ожидание
502	502	53436	2024-02-19	\N	отменён
503	503	95762	2024-02-29	2024-03-09	оплачен
504	504	25661	2024-02-29	2024-03-06	оплачен
505	505	56950	2024-03-02	\N	отменён
506	506	10398	2024-02-26	\N	отменён
507	507	19440	2024-02-18	\N	ожидание
508	508	32656	2024-02-24	\N	ожидание
509	509	83438	2024-02-29	\N	отменён
510	510	32984	2024-02-20	2024-02-27	оплачен
511	511	74921	2024-03-12	\N	отменён
512	512	45013	2024-03-08	2024-03-15	оплачен
513	513	84762	2024-02-23	2024-02-24	оплачен
514	514	94406	2024-02-25	2024-03-04	оплачен
515	515	91281	2024-03-05	2024-03-06	оплачен
516	516	43177	2024-02-18	\N	отменён
517	517	11751	2024-03-04	2024-03-07	оплачен
518	518	25075	2024-03-06	2024-03-07	оплачен
519	519	84832	2024-02-19	\N	отменён
520	520	30797	2024-03-09	\N	отменён
521	521	55076	2024-03-14	\N	ожидание
522	522	91514	2024-02-15	\N	отменён
523	523	44782	2024-02-26	\N	отменён
524	524	98706	2024-02-20	\N	отменён
525	525	34732	2024-02-25	\N	отменён
526	526	58632	2024-03-07	2024-03-10	оплачен
527	527	14817	2024-02-23	\N	отменён
528	528	14935	2024-02-18	\N	ожидание
529	529	36911	2024-03-15	2024-03-22	оплачен
530	530	64840	2024-03-12	\N	отменён
531	531	93583	2024-03-03	2024-03-05	оплачен
532	532	80104	2024-03-01	\N	ожидание
533	533	37970	2024-03-13	2024-03-18	оплачен
534	534	92346	2024-03-11	2024-03-18	оплачен
535	535	75628	2024-03-10	\N	отменён
536	536	13234	2024-03-13	\N	ожидание
537	537	42550	2024-02-15	2024-02-19	оплачен
538	538	20526	2024-03-02	2024-03-09	оплачен
539	539	15845	2024-03-14	\N	отменён
540	540	58409	2024-02-29	\N	отменён
541	541	10272	2024-02-18	\N	ожидание
542	542	55361	2024-02-19	\N	ожидание
543	543	37296	2024-03-01	2024-03-05	оплачен
544	544	70608	2024-02-21	\N	ожидание
545	545	84705	2024-03-02	\N	ожидание
546	546	18052	2024-02-19	\N	отменён
547	547	16395	2024-02-18	\N	отменён
548	548	93116	2024-03-06	\N	отменён
549	549	22019	2024-02-27	\N	ожидание
550	550	56624	2024-02-28	\N	отменён
551	551	68203	2024-02-19	\N	ожидание
552	552	27100	2024-02-18	\N	ожидание
553	553	72477	2024-03-14	\N	ожидание
554	554	39018	2024-03-02	\N	отменён
555	555	26424	2024-02-16	\N	отменён
556	556	40412	2024-02-23	2024-02-29	оплачен
557	557	59192	2024-02-23	\N	ожидание
558	558	52533	2024-03-12	2024-03-18	оплачен
559	559	94074	2024-02-16	\N	ожидание
560	560	80466	2024-03-10	2024-03-19	оплачен
561	561	55030	2024-03-14	\N	ожидание
562	562	35059	2024-03-07	2024-03-15	оплачен
563	563	77701	2024-02-23	\N	ожидание
564	564	85494	2024-03-11	\N	отменён
565	565	61160	2024-03-01	\N	ожидание
566	566	62940	2024-02-19	\N	отменён
567	567	70559	2024-02-19	2024-02-24	оплачен
568	568	85257	2024-03-08	\N	отменён
569	569	16805	2024-02-23	2024-02-29	оплачен
570	570	26434	2024-02-19	\N	ожидание
571	571	62574	2024-03-05	\N	отменён
572	572	10346	2024-03-13	\N	отменён
573	573	66604	2024-02-25	\N	отменён
574	574	99507	2024-02-15	2024-02-19	оплачен
575	575	15055	2024-03-16	\N	ожидание
576	576	59157	2024-02-26	2024-03-03	оплачен
577	577	61796	2024-03-05	2024-03-13	оплачен
578	578	35314	2024-02-17	\N	отменён
579	579	20967	2024-03-08	2024-03-09	оплачен
580	580	33757	2024-03-01	2024-03-06	оплачен
581	581	16882	2024-03-09	\N	ожидание
582	582	91559	2024-02-17	\N	отменён
583	583	37838	2024-02-19	\N	ожидание
584	584	17557	2024-03-14	\N	ожидание
585	585	94657	2024-03-10	\N	отменён
586	586	33191	2024-02-18	\N	ожидание
587	587	43777	2024-03-06	\N	ожидание
588	588	26071	2024-02-24	\N	отменён
589	589	20024	2024-02-26	\N	отменён
590	590	38637	2024-02-27	2024-03-04	оплачен
591	591	57638	2024-03-10	\N	ожидание
592	592	30594	2024-03-01	\N	отменён
593	593	61215	2024-03-05	\N	отменён
594	594	81496	2024-02-15	\N	ожидание
595	595	62671	2024-03-12	\N	отменён
596	596	19783	2024-02-21	\N	ожидание
597	597	25685	2024-02-17	\N	ожидание
598	598	24275	2024-03-03	\N	отменён
599	599	99310	2024-02-25	\N	отменён
600	600	66526	2024-02-25	\N	отменён
601	601	91641	2024-02-28	\N	отменён
602	602	86053	2024-03-16	2024-03-18	оплачен
603	603	50632	2024-03-12	2024-03-14	оплачен
604	604	19542	2024-02-28	\N	отменён
605	605	71893	2024-03-04	2024-03-05	оплачен
606	606	81488	2024-03-04	2024-03-13	оплачен
607	607	80343	2024-03-11	\N	ожидание
608	608	36764	2024-03-03	\N	отменён
609	609	92375	2024-02-24	2024-02-27	оплачен
610	610	13079	2024-03-16	2024-03-17	оплачен
611	611	96158	2024-03-07	2024-03-15	оплачен
612	612	34918	2024-02-22	\N	ожидание
613	613	12851	2024-02-29	\N	ожидание
614	614	62846	2024-03-02	\N	ожидание
615	615	95439	2024-02-17	2024-02-20	оплачен
616	616	77052	2024-02-20	\N	ожидание
617	617	73030	2024-03-12	\N	ожидание
618	618	94205	2024-02-29	\N	отменён
619	619	18081	2024-03-09	\N	ожидание
620	620	15312	2024-02-20	\N	отменён
621	621	97340	2024-02-19	\N	ожидание
622	622	32675	2024-03-02	\N	ожидание
623	623	52432	2024-02-25	\N	отменён
624	624	77731	2024-03-09	\N	ожидание
625	625	79011	2024-02-23	\N	отменён
626	626	35308	2024-02-18	\N	ожидание
627	627	12168	2024-02-25	\N	отменён
628	628	14999	2024-02-25	\N	ожидание
629	629	47445	2024-03-13	\N	ожидание
630	630	60635	2024-02-25	\N	ожидание
631	631	59746	2024-03-07	\N	отменён
632	632	49691	2024-03-05	\N	ожидание
633	633	77284	2024-02-18	\N	отменён
634	634	74898	2024-03-15	\N	ожидание
635	635	16176	2024-02-25	\N	ожидание
636	636	11092	2024-02-25	\N	отменён
637	637	72423	2024-02-19	\N	отменён
638	638	61429	2024-03-01	\N	ожидание
639	639	54979	2024-03-09	\N	ожидание
640	640	56340	2024-02-16	2024-02-21	оплачен
641	641	39902	2024-02-23	\N	ожидание
642	642	50478	2024-03-04	\N	отменён
643	643	97863	2024-02-18	\N	отменён
644	644	60179	2024-03-15	2024-03-25	оплачен
645	645	35277	2024-02-28	\N	отменён
646	646	93870	2024-02-27	2024-02-29	оплачен
647	647	77370	2024-03-11	\N	ожидание
648	648	83239	2024-03-16	2024-03-22	оплачен
649	649	86349	2024-02-26	\N	отменён
650	650	49323	2024-03-14	\N	отменён
651	651	25675	2024-02-15	2024-02-19	оплачен
652	652	17976	2024-02-24	2024-02-29	оплачен
653	653	48027	2024-02-18	2024-02-22	оплачен
654	654	62314	2024-02-28	2024-02-29	оплачен
655	655	69841	2024-02-26	\N	ожидание
656	656	46085	2024-03-01	2024-03-04	оплачен
657	657	70002	2024-02-18	\N	ожидание
658	658	72930	2024-03-08	2024-03-18	оплачен
659	659	62494	2024-03-14	2024-03-17	оплачен
660	660	75832	2024-03-07	2024-03-15	оплачен
661	661	74476	2024-02-19	\N	отменён
662	662	35302	2024-02-22	\N	ожидание
663	663	88801	2024-02-21	\N	ожидание
664	664	12006	2024-02-25	\N	отменён
665	665	92863	2024-03-06	\N	отменён
666	666	67914	2024-02-26	\N	ожидание
667	667	26075	2024-03-13	\N	отменён
668	668	91528	2024-02-23	\N	отменён
669	669	47696	2024-02-22	2024-02-25	оплачен
670	670	44296	2024-02-18	\N	отменён
671	671	85659	2024-03-11	2024-03-15	оплачен
672	672	51125	2024-03-04	\N	отменён
673	673	53837	2024-02-24	\N	отменён
674	674	85596	2024-02-17	2024-02-20	оплачен
675	675	57658	2024-02-21	\N	отменён
676	676	14847	2024-03-16	\N	отменён
677	677	86259	2024-03-03	2024-03-04	оплачен
678	678	36718	2024-03-06	\N	отменён
679	679	92729	2024-02-29	\N	ожидание
680	680	88046	2024-03-03	\N	отменён
681	681	48194	2024-03-03	\N	ожидание
682	682	88705	2024-02-27	\N	ожидание
683	683	19600	2024-03-13	2024-03-14	оплачен
684	684	93893	2024-02-25	2024-03-04	оплачен
685	685	20842	2024-02-15	\N	ожидание
686	686	38876	2024-03-08	\N	ожидание
687	687	85858	2024-02-19	\N	отменён
688	688	96716	2024-02-27	\N	отменён
689	689	99968	2024-02-21	\N	отменён
690	690	12228	2024-03-06	2024-03-14	оплачен
691	691	81221	2024-03-10	2024-03-17	оплачен
692	692	18608	2024-02-15	\N	ожидание
693	693	38270	2024-03-12	\N	ожидание
694	694	51629	2024-03-04	\N	отменён
695	695	81408	2024-03-03	\N	отменён
696	696	70965	2024-03-05	\N	ожидание
697	697	11498	2024-02-20	2024-03-01	оплачен
698	698	45567	2024-03-04	\N	отменён
699	699	79477	2024-02-18	\N	отменён
700	700	54159	2024-03-09	2024-03-17	оплачен
701	701	55469	2024-02-24	\N	отменён
702	702	84042	2024-03-06	\N	ожидание
703	703	17292	2024-02-17	2024-02-22	оплачен
704	704	50041	2024-02-29	2024-03-10	оплачен
705	705	96608	2024-02-21	2024-03-01	оплачен
706	706	89899	2024-02-27	2024-03-01	оплачен
707	707	45873	2024-03-12	2024-03-14	оплачен
708	708	37204	2024-03-05	\N	ожидание
709	709	56156	2024-03-08	2024-03-12	оплачен
710	710	65795	2024-02-27	\N	ожидание
711	711	79062	2024-03-11	2024-03-20	оплачен
712	712	45925	2024-02-24	2024-02-29	оплачен
713	713	46822	2024-02-23	2024-02-26	оплачен
714	714	57311	2024-03-01	2024-03-09	оплачен
715	715	92517	2024-02-28	\N	ожидание
716	716	57800	2024-02-16	2024-02-25	оплачен
717	717	68190	2024-03-10	\N	отменён
718	718	51180	2024-02-27	\N	ожидание
719	719	71844	2024-02-29	\N	ожидание
720	720	67395	2024-02-21	\N	отменён
721	721	97562	2024-02-16	\N	отменён
722	722	62562	2024-02-25	\N	отменён
723	723	91641	2024-03-14	2024-03-23	оплачен
724	724	87860	2024-02-24	\N	отменён
725	725	50188	2024-03-09	2024-03-17	оплачен
726	726	86156	2024-03-15	2024-03-22	оплачен
727	727	10106	2024-02-16	2024-02-18	оплачен
728	728	59972	2024-03-07	2024-03-12	оплачен
729	729	29842	2024-02-16	\N	ожидание
730	730	51992	2024-02-19	2024-02-28	оплачен
731	731	34498	2024-03-15	\N	отменён
732	732	89255	2024-02-26	\N	отменён
733	733	75797	2024-03-15	\N	ожидание
734	734	99863	2024-03-10	2024-03-15	оплачен
735	735	55770	2024-03-12	\N	ожидание
736	736	79270	2024-03-10	\N	ожидание
737	737	39834	2024-02-27	\N	отменён
738	738	19802	2024-02-24	\N	ожидание
739	739	81575	2024-03-09	\N	отменён
740	740	35049	2024-02-23	2024-02-29	оплачен
741	741	46416	2024-02-28	\N	отменён
742	742	28273	2024-02-20	2024-02-28	оплачен
743	743	77577	2024-02-27	\N	ожидание
744	744	17796	2024-02-21	\N	ожидание
745	745	89114	2024-02-17	2024-02-24	оплачен
746	746	64214	2024-03-15	2024-03-18	оплачен
747	747	56433	2024-03-02	\N	ожидание
748	748	64359	2024-03-09	2024-03-16	оплачен
749	749	66550	2024-02-23	2024-02-29	оплачен
750	750	95638	2024-03-03	\N	ожидание
751	751	49565	2024-03-06	\N	отменён
752	752	87455	2024-03-02	2024-03-09	оплачен
753	753	61725	2024-02-28	2024-03-05	оплачен
754	754	77306	2024-03-11	2024-03-18	оплачен
755	755	86478	2024-02-16	\N	отменён
756	756	29061	2024-03-05	\N	ожидание
757	757	22732	2024-02-15	2024-02-20	оплачен
758	758	69919	2024-03-03	2024-03-04	оплачен
759	759	61154	2024-03-13	\N	ожидание
760	760	58365	2024-02-15	2024-02-17	оплачен
761	761	42710	2024-03-09	2024-03-15	оплачен
762	762	92008	2024-03-12	\N	ожидание
763	763	99251	2024-02-15	2024-02-23	оплачен
764	764	81709	2024-03-09	\N	отменён
765	765	97018	2024-03-02	\N	отменён
766	766	69893	2024-02-29	\N	ожидание
767	767	60390	2024-03-14	2024-03-17	оплачен
768	768	87119	2024-03-11	\N	ожидание
769	769	67096	2024-03-15	\N	отменён
770	770	93412	2024-02-23	\N	ожидание
771	771	42378	2024-02-19	2024-02-27	оплачен
772	772	97507	2024-03-05	2024-03-14	оплачен
773	773	86917	2024-02-19	2024-02-25	оплачен
774	774	36530	2024-03-04	\N	ожидание
775	775	97853	2024-02-26	\N	ожидание
776	776	40812	2024-03-12	\N	отменён
777	777	27675	2024-03-14	\N	отменён
778	778	50880	2024-02-25	2024-02-27	оплачен
779	779	40208	2024-03-15	\N	отменён
780	780	91553	2024-03-02	2024-03-06	оплачен
781	781	24025	2024-02-26	\N	отменён
782	782	12643	2024-03-14	\N	отменён
783	783	58865	2024-02-15	\N	ожидание
784	784	10762	2024-02-29	\N	отменён
785	785	21017	2024-03-11	\N	отменён
786	786	30056	2024-02-22	2024-02-25	оплачен
787	787	93116	2024-03-13	\N	отменён
788	788	27807	2024-03-04	\N	ожидание
789	789	58414	2024-03-02	2024-03-06	оплачен
790	790	80069	2024-03-07	2024-03-08	оплачен
791	791	28228	2024-03-05	\N	ожидание
792	792	48608	2024-02-26	2024-03-07	оплачен
793	793	78613	2024-03-04	\N	ожидание
794	794	59343	2024-03-08	2024-03-15	оплачен
795	795	31045	2024-03-10	\N	ожидание
796	796	80411	2024-03-04	2024-03-10	оплачен
797	797	82449	2024-03-15	\N	ожидание
798	798	70500	2024-03-15	2024-03-20	оплачен
799	799	45208	2024-03-15	\N	ожидание
800	800	41164	2024-02-24	\N	ожидание
801	801	14893	2024-02-24	2024-02-27	оплачен
802	802	22179	2024-03-02	2024-03-11	оплачен
803	803	91010	2024-03-12	\N	отменён
804	804	35922	2024-02-24	\N	отменён
805	805	42220	2024-02-28	\N	ожидание
806	806	20537	2024-03-04	\N	ожидание
807	807	59136	2024-03-09	\N	отменён
808	808	18878	2024-02-26	2024-03-06	оплачен
809	809	17994	2024-02-21	\N	отменён
810	810	93494	2024-02-25	\N	ожидание
811	811	65062	2024-02-15	\N	ожидание
812	812	13611	2024-03-13	\N	отменён
813	813	44338	2024-02-22	2024-02-27	оплачен
814	814	76806	2024-02-21	2024-02-23	оплачен
815	815	73336	2024-03-11	2024-03-20	оплачен
816	816	48998	2024-03-14	\N	ожидание
817	817	64735	2024-02-22	2024-02-26	оплачен
818	818	96315	2024-03-02	2024-03-03	оплачен
819	819	99154	2024-03-09	2024-03-14	оплачен
820	820	10621	2024-02-22	\N	отменён
821	821	41718	2024-02-25	\N	ожидание
822	822	17726	2024-03-01	\N	отменён
823	823	99204	2024-02-16	2024-02-23	оплачен
824	824	68610	2024-02-27	\N	ожидание
825	825	71559	2024-02-16	2024-02-20	оплачен
826	826	92693	2024-02-15	\N	ожидание
827	827	29087	2024-02-28	\N	отменён
828	828	28536	2024-03-06	\N	отменён
829	829	14350	2024-02-23	\N	отменён
830	830	81778	2024-02-24	2024-03-05	оплачен
831	831	10485	2024-03-05	2024-03-11	оплачен
832	832	48745	2024-03-10	\N	ожидание
833	833	50648	2024-02-16	\N	отменён
834	834	56252	2024-03-14	\N	отменён
835	835	89256	2024-03-07	2024-03-12	оплачен
836	836	56027	2024-03-08	\N	отменён
837	837	91397	2024-03-02	\N	отменён
838	838	67988	2024-03-13	\N	отменён
839	839	90239	2024-02-15	\N	отменён
840	840	95034	2024-02-26	\N	отменён
841	841	97351	2024-02-19	2024-02-20	оплачен
842	842	92087	2024-02-17	\N	ожидание
843	843	18660	2024-03-10	\N	ожидание
844	844	64865	2024-02-18	2024-02-25	оплачен
845	845	92012	2024-02-25	2024-02-29	оплачен
846	846	86475	2024-02-18	2024-02-22	оплачен
847	847	39105	2024-02-16	2024-02-21	оплачен
848	848	39061	2024-02-23	\N	отменён
849	849	78652	2024-03-02	\N	отменён
850	850	35136	2024-03-06	2024-03-08	оплачен
851	851	98976	2024-02-17	\N	ожидание
852	852	89889	2024-03-10	2024-03-20	оплачен
853	853	11222	2024-03-03	\N	отменён
854	854	60262	2024-03-15	\N	ожидание
855	855	76888	2024-03-02	2024-03-10	оплачен
856	856	42215	2024-02-21	2024-03-01	оплачен
857	857	13316	2024-02-20	\N	отменён
858	858	30231	2024-02-22	\N	отменён
859	859	66254	2024-03-04	2024-03-13	оплачен
860	860	18712	2024-03-02	\N	отменён
861	861	50843	2024-02-22	\N	отменён
862	862	82005	2024-03-08	2024-03-14	оплачен
863	863	55480	2024-03-05	\N	ожидание
864	864	83106	2024-03-13	\N	ожидание
865	865	89095	2024-03-06	\N	отменён
866	866	42882	2024-02-20	\N	отменён
867	867	87193	2024-02-16	2024-02-18	оплачен
868	868	98694	2024-02-24	\N	отменён
869	869	64892	2024-02-20	2024-02-25	оплачен
870	870	32630	2024-02-27	\N	ожидание
871	871	96463	2024-03-07	\N	ожидание
872	872	48584	2024-02-16	2024-02-19	оплачен
873	873	84383	2024-02-26	\N	ожидание
874	874	89340	2024-03-03	\N	ожидание
875	875	27015	2024-02-15	\N	ожидание
876	876	11194	2024-03-03	\N	отменён
877	877	43476	2024-02-16	\N	ожидание
878	878	14916	2024-02-25	\N	отменён
879	879	32658	2024-03-07	\N	ожидание
880	880	84803	2024-02-18	\N	ожидание
881	881	59716	2024-02-23	\N	отменён
882	882	41355	2024-03-01	\N	отменён
883	883	91468	2024-03-09	\N	отменён
884	884	27143	2024-03-08	\N	отменён
885	885	58522	2024-03-01	2024-03-07	оплачен
886	886	90756	2024-03-13	\N	ожидание
887	887	51866	2024-03-05	\N	ожидание
888	888	22410	2024-02-27	\N	отменён
889	889	80986	2024-02-21	\N	отменён
890	890	36598	2024-02-21	\N	ожидание
891	891	26022	2024-03-09	\N	ожидание
892	892	42543	2024-02-16	\N	отменён
893	893	98578	2024-03-02	\N	ожидание
894	894	48616	2024-03-02	2024-03-09	оплачен
895	895	19524	2024-02-26	2024-02-28	оплачен
896	896	98497	2024-02-22	\N	отменён
897	897	74198	2024-03-15	\N	отменён
898	898	66421	2024-03-04	\N	ожидание
899	899	30920	2024-03-13	2024-03-18	оплачен
900	900	77096	2024-03-14	\N	отменён
901	901	47958	2024-02-19	2024-02-27	оплачен
902	902	41688	2024-03-04	\N	отменён
903	903	16867	2024-03-15	\N	отменён
904	904	33732	2024-02-20	\N	ожидание
905	905	63724	2024-02-23	\N	отменён
906	906	33580	2024-03-06	\N	ожидание
907	907	20190	2024-02-20	\N	ожидание
908	908	47763	2024-02-20	\N	ожидание
909	909	18008	2024-02-28	\N	отменён
910	910	73524	2024-02-21	2024-02-28	оплачен
911	911	86296	2024-03-15	2024-03-19	оплачен
912	912	95449	2024-02-25	\N	ожидание
913	913	82801	2024-02-25	2024-02-28	оплачен
914	914	31438	2024-03-16	\N	отменён
915	915	24139	2024-02-29	\N	ожидание
916	916	20903	2024-02-21	\N	ожидание
917	917	32212	2024-03-05	\N	ожидание
918	918	69491	2024-03-02	2024-03-12	оплачен
919	919	78158	2024-03-08	2024-03-14	оплачен
920	920	52773	2024-02-21	\N	ожидание
921	921	87546	2024-03-01	\N	ожидание
922	922	77879	2024-03-02	\N	ожидание
923	923	92921	2024-02-26	\N	ожидание
924	924	97467	2024-03-07	2024-03-11	оплачен
925	925	33149	2024-03-07	\N	ожидание
926	926	53082	2024-03-08	\N	отменён
927	927	50955	2024-02-19	\N	отменён
928	928	24698	2024-03-01	2024-03-06	оплачен
929	929	76687	2024-03-06	\N	отменён
930	930	86976	2024-02-29	\N	ожидание
931	931	48305	2024-02-28	\N	отменён
932	932	64563	2024-02-26	\N	отменён
933	933	45165	2024-02-29	\N	ожидание
934	934	77131	2024-03-08	\N	ожидание
935	935	87452	2024-03-02	\N	отменён
936	936	61599	2024-03-01	\N	отменён
937	937	93267	2024-03-15	\N	ожидание
938	938	28468	2024-02-21	\N	отменён
939	939	31007	2024-03-15	2024-03-24	оплачен
940	940	86161	2024-03-03	2024-03-11	оплачен
941	941	21722	2024-03-01	\N	ожидание
942	942	27443	2024-02-15	\N	ожидание
943	943	95916	2024-02-21	\N	ожидание
944	944	96038	2024-03-07	\N	отменён
945	945	28890	2024-03-06	2024-03-13	оплачен
946	946	29814	2024-03-09	2024-03-13	оплачен
947	947	65550	2024-03-10	2024-03-20	оплачен
948	948	10144	2024-02-22	2024-02-26	оплачен
949	949	54676	2024-03-09	2024-03-13	оплачен
950	950	39432	2024-02-27	\N	ожидание
951	951	13204	2024-03-07	\N	отменён
952	952	70422	2024-02-27	\N	ожидание
953	953	59001	2024-02-22	2024-02-26	оплачен
954	954	28463	2024-03-03	\N	ожидание
955	955	37699	2024-02-25	\N	отменён
956	956	66414	2024-03-03	\N	отменён
957	957	49757	2024-03-02	2024-03-11	оплачен
958	958	21574	2024-02-20	\N	отменён
959	959	90139	2024-02-21	\N	отменён
960	960	96491	2024-02-29	\N	отменён
961	961	64134	2024-03-10	2024-03-16	оплачен
962	962	63378	2024-03-04	2024-03-09	оплачен
963	963	29502	2024-02-26	\N	ожидание
964	964	18593	2024-03-15	2024-03-25	оплачен
965	965	49670	2024-02-20	\N	отменён
966	966	66337	2024-02-17	2024-02-25	оплачен
967	967	15591	2024-02-24	\N	ожидание
968	968	84522	2024-03-06	2024-03-15	оплачен
969	969	63459	2024-03-16	2024-03-19	оплачен
970	970	61192	2024-03-11	2024-03-17	оплачен
971	971	31086	2024-02-22	\N	ожидание
972	972	21449	2024-03-03	2024-03-06	оплачен
973	973	73349	2024-03-11	2024-03-20	оплачен
974	974	26069	2024-03-16	2024-03-22	оплачен
975	975	86941	2024-02-23	2024-02-25	оплачен
976	976	20089	2024-03-03	2024-03-10	оплачен
977	977	17414	2024-02-18	\N	ожидание
978	978	58677	2024-02-22	\N	отменён
979	979	68120	2024-03-12	2024-03-17	оплачен
980	980	38662	2024-03-15	2024-03-23	оплачен
981	981	14635	2024-02-19	\N	отменён
982	982	16786	2024-02-23	2024-02-28	оплачен
983	983	26537	2024-02-25	\N	отменён
984	984	31910	2024-03-07	\N	отменён
985	985	42605	2024-03-11	2024-03-17	оплачен
986	986	69668	2024-02-27	2024-03-08	оплачен
987	987	77652	2024-02-18	2024-02-19	оплачен
988	988	50843	2024-03-01	\N	ожидание
989	989	53554	2024-03-03	\N	отменён
990	990	54183	2024-03-14	\N	отменён
991	991	63345	2024-03-01	\N	отменён
992	992	92109	2024-03-11	2024-03-13	оплачен
993	993	86391	2024-02-25	\N	отменён
994	994	91796	2024-03-06	\N	ожидание
995	995	91982	2024-03-13	\N	отменён
996	996	56112	2024-02-21	\N	отменён
997	997	13479	2024-03-04	\N	ожидание
998	998	75058	2024-02-16	2024-02-24	оплачен
999	999	61151	2024-02-16	\N	ожидание
1000	1000	86235	2024-03-05	\N	отменён
\.


--
-- TOC entry 3754 (class 0 OID 0)
-- Dependencies: 222
-- Name: branch_branch_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.branch_branch_id_seq', 10, true);


--
-- TOC entry 3755 (class 0 OID 0)
-- Dependencies: 224
-- Name: customer_customer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.customer_customer_id_seq', 1050, true);


--
-- TOC entry 3756 (class 0 OID 0)
-- Dependencies: 236
-- Name: invoice_invoice_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.invoice_invoice_id_seq', 1000, true);


--
-- TOC entry 3757 (class 0 OID 0)
-- Dependencies: 220
-- Name: manager_manager_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.manager_manager_id_seq', 15, true);


--
-- TOC entry 3758 (class 0 OID 0)
-- Dependencies: 218
-- Name: manager_position_position_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.manager_position_position_id_seq', 1, false);


--
-- TOC entry 3759 (class 0 OID 0)
-- Dependencies: 214
-- Name: manufacturer_manufacturer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.manufacturer_manufacturer_id_seq', 9, true);


--
-- TOC entry 3760 (class 0 OID 0)
-- Dependencies: 234
-- Name: order_details_order_details_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.order_details_order_details_id_seq', 5976, true);


--
-- TOC entry 3761 (class 0 OID 0)
-- Dependencies: 226
-- Name: orders_order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.orders_order_id_seq', 1000, true);


--
-- TOC entry 3762 (class 0 OID 0)
-- Dependencies: 216
-- Name: product_product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.product_product_id_seq', 48, true);


--
-- TOC entry 3763 (class 0 OID 0)
-- Dependencies: 228
-- Name: supplier_supplier_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.supplier_supplier_id_seq', 50, true);


--
-- TOC entry 3764 (class 0 OID 0)
-- Dependencies: 232
-- Name: supply_details_supply_details_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.supply_details_supply_details_id_seq', 2998, true);


--
-- TOC entry 3765 (class 0 OID 0)
-- Dependencies: 238
-- Name: supply_invoice_supply_invoice_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.supply_invoice_supply_invoice_id_seq', 1000, true);


--
-- TOC entry 3766 (class 0 OID 0)
-- Dependencies: 230
-- Name: supply_supply_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.supply_supply_id_seq', 1000, true);


--
-- TOC entry 3535 (class 2606 OID 16725)
-- Name: branch branch_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.branch
    ADD CONSTRAINT branch_pkey PRIMARY KEY (branch_id);


--
-- TOC entry 3537 (class 2606 OID 16732)
-- Name: customer customer_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer
    ADD CONSTRAINT customer_pkey PRIMARY KEY (customer_id);


--
-- TOC entry 3551 (class 2606 OID 16862)
-- Name: invoice invoice_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoice
    ADD CONSTRAINT invoice_pkey PRIMARY KEY (invoice_id);


--
-- TOC entry 3529 (class 2606 OID 16709)
-- Name: manager manager_employee_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.manager
    ADD CONSTRAINT manager_employee_code_key UNIQUE (employee_code);


--
-- TOC entry 3531 (class 2606 OID 16711)
-- Name: manager manager_phone_number_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.manager
    ADD CONSTRAINT manager_phone_number_key UNIQUE (phone_number);


--
-- TOC entry 3533 (class 2606 OID 16707)
-- Name: manager manager_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.manager
    ADD CONSTRAINT manager_pkey PRIMARY KEY (manager_id);


--
-- TOC entry 3527 (class 2606 OID 16700)
-- Name: manager_position manager_position_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.manager_position
    ADD CONSTRAINT manager_position_pkey PRIMARY KEY (position_id);


--
-- TOC entry 3521 (class 2606 OID 16677)
-- Name: manufacturer manufacturer_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.manufacturer
    ADD CONSTRAINT manufacturer_pkey PRIMARY KEY (manufacturer_id);


--
-- TOC entry 3523 (class 2606 OID 16679)
-- Name: manufacturer manufacturer_tax_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.manufacturer
    ADD CONSTRAINT manufacturer_tax_id_key UNIQUE (tax_id);


--
-- TOC entry 3549 (class 2606 OID 16836)
-- Name: order_details order_details_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_details
    ADD CONSTRAINT order_details_pkey PRIMARY KEY (order_details_id);


--
-- TOC entry 3539 (class 2606 OID 16741)
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (order_id);


--
-- TOC entry 3525 (class 2606 OID 16688)
-- Name: product product_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT product_pkey PRIMARY KEY (product_id);


--
-- TOC entry 3541 (class 2606 OID 16777)
-- Name: supplier supplier_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.supplier
    ADD CONSTRAINT supplier_pkey PRIMARY KEY (supplier_id);


--
-- TOC entry 3543 (class 2606 OID 16779)
-- Name: supplier supplier_tax_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.supplier
    ADD CONSTRAINT supplier_tax_id_key UNIQUE (tax_id);


--
-- TOC entry 3547 (class 2606 OID 16819)
-- Name: supply_details supply_details_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.supply_details
    ADD CONSTRAINT supply_details_pkey PRIMARY KEY (supply_details_id);


--
-- TOC entry 3553 (class 2606 OID 16877)
-- Name: supply_invoice supply_invoice_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.supply_invoice
    ADD CONSTRAINT supply_invoice_pkey PRIMARY KEY (supply_invoice_id);


--
-- TOC entry 3545 (class 2606 OID 16787)
-- Name: supply supply_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.supply
    ADD CONSTRAINT supply_pkey PRIMARY KEY (supply_id);


--
-- TOC entry 3565 (class 2606 OID 16863)
-- Name: invoice invoice_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoice
    ADD CONSTRAINT invoice_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(order_id);


--
-- TOC entry 3555 (class 2606 OID 16712)
-- Name: manager manager_position_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.manager
    ADD CONSTRAINT manager_position_id_fkey FOREIGN KEY (position_id) REFERENCES public.manager_position(position_id);


--
-- TOC entry 3563 (class 2606 OID 16842)
-- Name: order_details order_details_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_details
    ADD CONSTRAINT order_details_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(order_id);


--
-- TOC entry 3564 (class 2606 OID 16837)
-- Name: order_details order_details_supply_details_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_details
    ADD CONSTRAINT order_details_supply_details_id_fkey FOREIGN KEY (supply_details_id) REFERENCES public.supply_details(supply_details_id);


--
-- TOC entry 3556 (class 2606 OID 16752)
-- Name: orders orders_branch_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_branch_id_fkey FOREIGN KEY (branch_id) REFERENCES public.branch(branch_id);


--
-- TOC entry 3557 (class 2606 OID 16742)
-- Name: orders orders_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customer(customer_id);


--
-- TOC entry 3558 (class 2606 OID 16747)
-- Name: orders orders_manager_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_manager_id_fkey FOREIGN KEY (manager_id) REFERENCES public.manager(manager_id) ON DELETE SET NULL;


--
-- TOC entry 3554 (class 2606 OID 16689)
-- Name: product product_manufacturer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT product_manufacturer_id_fkey FOREIGN KEY (manufacturer_id) REFERENCES public.manufacturer(manufacturer_id);


--
-- TOC entry 3559 (class 2606 OID 16788)
-- Name: supply supply_branch_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.supply
    ADD CONSTRAINT supply_branch_id_fkey FOREIGN KEY (branch_id) REFERENCES public.branch(branch_id);


--
-- TOC entry 3561 (class 2606 OID 16820)
-- Name: supply_details supply_details_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.supply_details
    ADD CONSTRAINT supply_details_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.product(product_id);


--
-- TOC entry 3562 (class 2606 OID 16825)
-- Name: supply_details supply_details_supply_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.supply_details
    ADD CONSTRAINT supply_details_supply_id_fkey FOREIGN KEY (supply_id) REFERENCES public.supply(supply_id);


--
-- TOC entry 3566 (class 2606 OID 16878)
-- Name: supply_invoice supply_invoice_supply_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.supply_invoice
    ADD CONSTRAINT supply_invoice_supply_id_fkey FOREIGN KEY (supply_id) REFERENCES public.supply(supply_id);


--
-- TOC entry 3560 (class 2606 OID 16793)
-- Name: supply supply_supplier_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.supply
    ADD CONSTRAINT supply_supplier_id_fkey FOREIGN KEY (supplier_id) REFERENCES public.supplier(supplier_id);


-- Completed on 2025-04-03 15:22:45 MSK

--
-- PostgreSQL database dump complete
--

