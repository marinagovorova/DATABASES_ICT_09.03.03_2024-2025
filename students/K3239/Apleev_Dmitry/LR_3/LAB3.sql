--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4
-- Dumped by pg_dump version 17.4

-- Started on 2025-05-26 14:48:21 MSK

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
-- TOC entry 884 (class 1247 OID 19144)
-- Name: booking_status_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.booking_status_enum AS ENUM (
    'booked',
    'checked_in',
    'checked_out',
    'canceled'
);


ALTER TYPE public.booking_status_enum OWNER TO postgres;

--
-- TOC entry 887 (class 1247 OID 19154)
-- Name: cleaning_status_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.cleaning_status_enum AS ENUM (
    'scheduled',
    'in_progress',
    'completed'
);


ALTER TYPE public.cleaning_status_enum OWNER TO postgres;

--
-- TOC entry 881 (class 1247 OID 19134)
-- Name: contract_type_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.contract_type_enum AS ENUM (
    'permanent',
    'temporary',
    'internship',
    'contract'
);


ALTER TYPE public.contract_type_enum OWNER TO postgres;

--
-- TOC entry 878 (class 1247 OID 19126)
-- Name: gender_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.gender_enum AS ENUM (
    'male',
    'female',
    'other'
);


ALTER TYPE public.gender_enum OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 246 (class 1259 OID 19369)
-- Name: cleaning; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cleaning (
    cleaning_id integer NOT NULL,
    room_id integer NOT NULL,
    contract_id integer NOT NULL,
    scheduled_at timestamp without time zone NOT NULL,
    status public.cleaning_status_enum DEFAULT 'scheduled'::public.cleaning_status_enum NOT NULL,
    CONSTRAINT cleaning_scheduled_at_check CHECK ((((status = 'scheduled'::public.cleaning_status_enum) AND (scheduled_at >= CURRENT_DATE)) OR (status <> 'scheduled'::public.cleaning_status_enum)))
);


ALTER TABLE public.cleaning OWNER TO postgres;

--
-- TOC entry 245 (class 1259 OID 19368)
-- Name: cleaning_cleaning_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cleaning_cleaning_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cleaning_cleaning_id_seq OWNER TO postgres;

--
-- TOC entry 3825 (class 0 OID 0)
-- Dependencies: 245
-- Name: cleaning_cleaning_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cleaning_cleaning_id_seq OWNED BY public.cleaning.cleaning_id;


--
-- TOC entry 218 (class 1259 OID 19162)
-- Name: client; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client (
    client_id integer NOT NULL,
    last_name character varying(45) NOT NULL,
    first_name character varying(45) NOT NULL,
    patronymic character varying(45),
    email character varying(254) NOT NULL,
    phone_number character varying(45) NOT NULL,
    permanent_address text NOT NULL,
    CONSTRAINT client_email_check CHECK ((POSITION(('@'::text) IN (email)) > 1)),
    CONSTRAINT client_first_name_check CHECK (((first_name)::text ~* '^[A-Za-zА-Яа-яЁё\- ]+$'::text)),
    CONSTRAINT client_last_name_check CHECK (((last_name)::text ~* '^[A-Za-zА-Яа-яЁё\- ]+$'::text)),
    CONSTRAINT client_patronymic_check CHECK (((patronymic IS NULL) OR ((patronymic)::text ~* '^[A-Za-zА-Яа-яЁё\- ]+$'::text))),
    CONSTRAINT client_phone_number_check CHECK (((phone_number)::text ~ '^\+\d{1,3}([ -]?\d+){4,5}$'::text))
);


ALTER TABLE public.client OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 19161)
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
-- TOC entry 3826 (class 0 OID 0)
-- Dependencies: 217
-- Name: client_client_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.client_client_id_seq OWNED BY public.client.client_id;


--
-- TOC entry 222 (class 1259 OID 19186)
-- Name: employee; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.employee (
    employee_id integer NOT NULL,
    last_name character varying(45) NOT NULL,
    first_name character varying(45) NOT NULL,
    patronymic character varying(45),
    gender public.gender_enum,
    CONSTRAINT employee_first_name_check CHECK (((first_name)::text ~* '^[A-Za-zА-Яа-яЁё\- ]+$'::text)),
    CONSTRAINT employee_last_name_check CHECK (((last_name)::text ~* '^[A-Za-zА-Яа-яЁё\- ]+$'::text)),
    CONSTRAINT employee_patronymic_check CHECK (((patronymic IS NULL) OR ((patronymic)::text ~* '^[A-Za-zА-Яа-яЁё\- ]+$'::text)))
);


ALTER TABLE public.employee OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 19185)
-- Name: employee_employee_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.employee_employee_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.employee_employee_id_seq OWNER TO postgres;

--
-- TOC entry 3827 (class 0 OID 0)
-- Dependencies: 221
-- Name: employee_employee_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.employee_employee_id_seq OWNED BY public.employee.employee_id;


--
-- TOC entry 224 (class 1259 OID 19196)
-- Name: employment_contract; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.employment_contract (
    contract_id integer NOT NULL,
    employee_id integer NOT NULL,
    post_id integer NOT NULL,
    contract_type public.contract_type_enum NOT NULL,
    status boolean DEFAULT true NOT NULL,
    rate_count numeric NOT NULL,
    contract_start_date date NOT NULL,
    contract_end_date date,
    CONSTRAINT employment_contract_check CHECK (((contract_end_date IS NULL) OR (contract_end_date > contract_start_date))),
    CONSTRAINT employment_contract_rate_count_check CHECK ((rate_count > (0)::numeric))
);


ALTER TABLE public.employment_contract OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 19195)
-- Name: employment_contract_contract_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.employment_contract_contract_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.employment_contract_contract_id_seq OWNER TO postgres;

--
-- TOC entry 3828 (class 0 OID 0)
-- Dependencies: 223
-- Name: employment_contract_contract_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.employment_contract_contract_id_seq OWNED BY public.employment_contract.contract_id;


--
-- TOC entry 226 (class 1259 OID 19218)
-- Name: facility; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.facility (
    facility_id integer NOT NULL,
    name character varying(45) NOT NULL,
    description text
);


ALTER TABLE public.facility OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 19217)
-- Name: facility_facility_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.facility_facility_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.facility_facility_id_seq OWNER TO postgres;

--
-- TOC entry 3829 (class 0 OID 0)
-- Dependencies: 225
-- Name: facility_facility_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.facility_facility_id_seq OWNED BY public.facility.facility_id;


--
-- TOC entry 228 (class 1259 OID 19227)
-- Name: hotel; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hotel (
    hotel_id integer NOT NULL,
    name character varying(45) NOT NULL,
    region character varying(45) NOT NULL,
    district character varying(45),
    street character varying(45),
    building character varying(45)
);


ALTER TABLE public.hotel OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 19234)
-- Name: hotel_facility; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hotel_facility (
    hotel_facility_id integer NOT NULL,
    hotel_id integer NOT NULL,
    facility_id integer NOT NULL
);


ALTER TABLE public.hotel_facility OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 19233)
-- Name: hotel_facility_hotel_facility_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.hotel_facility_hotel_facility_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.hotel_facility_hotel_facility_id_seq OWNER TO postgres;

--
-- TOC entry 3830 (class 0 OID 0)
-- Dependencies: 229
-- Name: hotel_facility_hotel_facility_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.hotel_facility_hotel_facility_id_seq OWNED BY public.hotel_facility.hotel_facility_id;


--
-- TOC entry 227 (class 1259 OID 19226)
-- Name: hotel_hotel_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.hotel_hotel_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.hotel_hotel_id_seq OWNER TO postgres;

--
-- TOC entry 3831 (class 0 OID 0)
-- Dependencies: 227
-- Name: hotel_hotel_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.hotel_hotel_id_seq OWNED BY public.hotel.hotel_id;


--
-- TOC entry 244 (class 1259 OID 19349)
-- Name: order_item; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_item (
    order_item_id integer NOT NULL,
    order_id integer NOT NULL,
    room_id integer NOT NULL,
    arrival_date date NOT NULL,
    departure_date date NOT NULL,
    booking_amount numeric(10,2) NOT NULL,
    booking_status public.booking_status_enum DEFAULT 'booked'::public.booking_status_enum NOT NULL,
    CONSTRAINT order_item_booking_amount_check CHECK (((booking_amount >= (0)::numeric) AND ((booking_status <> 'checked_in'::public.booking_status_enum) OR (booking_amount > (0)::numeric)))),
    CONSTRAINT order_item_check CHECK ((departure_date > arrival_date))
);


ALTER TABLE public.order_item OWNER TO postgres;

--
-- TOC entry 243 (class 1259 OID 19348)
-- Name: order_item_order_item_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.order_item_order_item_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.order_item_order_item_id_seq OWNER TO postgres;

--
-- TOC entry 3832 (class 0 OID 0)
-- Dependencies: 243
-- Name: order_item_order_item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.order_item_order_item_id_seq OWNED BY public.order_item.order_item_id;


--
-- TOC entry 242 (class 1259 OID 19331)
-- Name: orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orders (
    order_id integer NOT NULL,
    passport_id integer NOT NULL,
    contract_id integer NOT NULL,
    amount numeric(10,2) NOT NULL,
    payment_status boolean NOT NULL,
    overall_status boolean NOT NULL,
    CONSTRAINT orders_amount_check CHECK ((amount >= (0)::numeric))
);


ALTER TABLE public.orders OWNER TO postgres;

--
-- TOC entry 241 (class 1259 OID 19330)
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
-- TOC entry 3833 (class 0 OID 0)
-- Dependencies: 241
-- Name: orders_order_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.orders_order_id_seq OWNED BY public.orders.order_id;


--
-- TOC entry 240 (class 1259 OID 19316)
-- Name: passport_data; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.passport_data (
    passport_id integer NOT NULL,
    client_id integer NOT NULL,
    series character varying(10) NOT NULL,
    number character varying(15) NOT NULL,
    passport_issue_date date NOT NULL,
    passport_expiry_date date NOT NULL,
    CONSTRAINT passport_data_check CHECK ((passport_expiry_date > passport_issue_date)),
    CONSTRAINT passport_data_number_check CHECK (((number)::text ~ '^[A-Za-z0-9]{1,15}$'::text)),
    CONSTRAINT passport_data_series_check CHECK (((series)::text ~ '^[A-Za-z0-9]{1,10}$'::text))
);


ALTER TABLE public.passport_data OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 19315)
-- Name: passport_data_passport_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.passport_data_passport_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.passport_data_passport_id_seq OWNER TO postgres;

--
-- TOC entry 3834 (class 0 OID 0)
-- Dependencies: 239
-- Name: passport_data_passport_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.passport_data_passport_id_seq OWNED BY public.passport_data.passport_id;


--
-- TOC entry 220 (class 1259 OID 19176)
-- Name: post_list; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.post_list (
    post_id integer NOT NULL,
    title text NOT NULL,
    salary numeric NOT NULL,
    CONSTRAINT post_list_salary_check CHECK ((salary > (0)::numeric))
);


ALTER TABLE public.post_list OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 19175)
-- Name: post_list_post_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.post_list_post_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.post_list_post_id_seq OWNER TO postgres;

--
-- TOC entry 3835 (class 0 OID 0)
-- Dependencies: 219
-- Name: post_list_post_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.post_list_post_id_seq OWNED BY public.post_list.post_id;


--
-- TOC entry 248 (class 1259 OID 19388)
-- Name: promotion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.promotion (
    promotion_id integer NOT NULL,
    type_id integer NOT NULL,
    discount_value numeric(5,2) NOT NULL,
    is_active boolean DEFAULT true NOT NULL,
    start_date date,
    end_date date,
    CONSTRAINT chk_promo_dates CHECK (((start_date IS NULL) OR (end_date IS NULL) OR (start_date < end_date))),
    CONSTRAINT promotion_discount_value_check CHECK ((discount_value > (0)::numeric))
);


ALTER TABLE public.promotion OWNER TO postgres;

--
-- TOC entry 247 (class 1259 OID 19387)
-- Name: promotion_promotion_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.promotion_promotion_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.promotion_promotion_id_seq OWNER TO postgres;

--
-- TOC entry 3836 (class 0 OID 0)
-- Dependencies: 247
-- Name: promotion_promotion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.promotion_promotion_id_seq OWNED BY public.promotion.promotion_id;


--
-- TOC entry 238 (class 1259 OID 19296)
-- Name: room; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.room (
    room_id integer NOT NULL,
    hotel_id integer NOT NULL,
    room_number integer NOT NULL,
    type_id integer NOT NULL,
    CONSTRAINT room_room_number_check CHECK ((room_number > 0))
);


ALTER TABLE public.room OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 19295)
-- Name: room_room_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.room_room_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.room_room_id_seq OWNER TO postgres;

--
-- TOC entry 3837 (class 0 OID 0)
-- Dependencies: 237
-- Name: room_room_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.room_room_id_seq OWNED BY public.room.room_id;


--
-- TOC entry 232 (class 1259 OID 19253)
-- Name: room_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.room_type (
    type_id integer NOT NULL,
    class character varying(45) NOT NULL,
    capacity integer NOT NULL,
    CONSTRAINT room_type_capacity_check CHECK ((capacity >= 1))
);


ALTER TABLE public.room_type OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 19277)
-- Name: room_type_facility; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.room_type_facility (
    room_type_facility_id integer NOT NULL,
    type_id integer NOT NULL,
    facility_id integer NOT NULL
);


ALTER TABLE public.room_type_facility OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 19276)
-- Name: room_type_facility_room_type_facility_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.room_type_facility_room_type_facility_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.room_type_facility_room_type_facility_id_seq OWNER TO postgres;

--
-- TOC entry 3838 (class 0 OID 0)
-- Dependencies: 235
-- Name: room_type_facility_room_type_facility_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.room_type_facility_room_type_facility_id_seq OWNED BY public.room_type_facility.room_type_facility_id;


--
-- TOC entry 234 (class 1259 OID 19261)
-- Name: room_type_price; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.room_type_price (
    room_type_price_id integer NOT NULL,
    type_id integer NOT NULL,
    start_date date NOT NULL,
    end_date date NOT NULL,
    price numeric(10,2) NOT NULL,
    CONSTRAINT chk_price_dates CHECK ((end_date >= start_date)),
    CONSTRAINT room_type_price_price_check CHECK ((price >= (0)::numeric))
);


ALTER TABLE public.room_type_price OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 19260)
-- Name: room_type_price_room_type_price_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.room_type_price_room_type_price_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.room_type_price_room_type_price_id_seq OWNER TO postgres;

--
-- TOC entry 3839 (class 0 OID 0)
-- Dependencies: 233
-- Name: room_type_price_room_type_price_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.room_type_price_room_type_price_id_seq OWNED BY public.room_type_price.room_type_price_id;


--
-- TOC entry 231 (class 1259 OID 19252)
-- Name: room_type_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.room_type_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.room_type_type_id_seq OWNER TO postgres;

--
-- TOC entry 3840 (class 0 OID 0)
-- Dependencies: 231
-- Name: room_type_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.room_type_type_id_seq OWNED BY public.room_type.type_id;


--
-- TOC entry 249 (class 1259 OID 19407)
-- Name: view_client_orders; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.view_client_orders AS
 SELECT c.client_id AS "ID клиента",
    c.last_name AS "Фамилия",
    c.first_name AS "Имя",
    p.series AS "серия паспорта",
    p.number AS "номер паспорта",
    count(o.order_id) AS "Кол",
    COALESCE(sum(o.amount), (0)::numeric) AS "Общая сумма заказов"
   FROM ((public.client c
     JOIN public.passport_data p USING (client_id))
     JOIN public.orders o USING (passport_id))
  GROUP BY c.client_id, c.last_name, c.first_name, p.series, p.number;


ALTER VIEW public.view_client_orders OWNER TO postgres;

--
-- TOC entry 3557 (class 2604 OID 19372)
-- Name: cleaning cleaning_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cleaning ALTER COLUMN cleaning_id SET DEFAULT nextval('public.cleaning_cleaning_id_seq'::regclass);


--
-- TOC entry 3541 (class 2604 OID 19165)
-- Name: client client_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client ALTER COLUMN client_id SET DEFAULT nextval('public.client_client_id_seq'::regclass);


--
-- TOC entry 3543 (class 2604 OID 19189)
-- Name: employee employee_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee ALTER COLUMN employee_id SET DEFAULT nextval('public.employee_employee_id_seq'::regclass);


--
-- TOC entry 3544 (class 2604 OID 19199)
-- Name: employment_contract contract_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employment_contract ALTER COLUMN contract_id SET DEFAULT nextval('public.employment_contract_contract_id_seq'::regclass);


--
-- TOC entry 3546 (class 2604 OID 19221)
-- Name: facility facility_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.facility ALTER COLUMN facility_id SET DEFAULT nextval('public.facility_facility_id_seq'::regclass);


--
-- TOC entry 3547 (class 2604 OID 19230)
-- Name: hotel hotel_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hotel ALTER COLUMN hotel_id SET DEFAULT nextval('public.hotel_hotel_id_seq'::regclass);


--
-- TOC entry 3548 (class 2604 OID 19237)
-- Name: hotel_facility hotel_facility_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hotel_facility ALTER COLUMN hotel_facility_id SET DEFAULT nextval('public.hotel_facility_hotel_facility_id_seq'::regclass);


--
-- TOC entry 3555 (class 2604 OID 19352)
-- Name: order_item order_item_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_item ALTER COLUMN order_item_id SET DEFAULT nextval('public.order_item_order_item_id_seq'::regclass);


--
-- TOC entry 3554 (class 2604 OID 19334)
-- Name: orders order_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders ALTER COLUMN order_id SET DEFAULT nextval('public.orders_order_id_seq'::regclass);


--
-- TOC entry 3553 (class 2604 OID 19319)
-- Name: passport_data passport_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.passport_data ALTER COLUMN passport_id SET DEFAULT nextval('public.passport_data_passport_id_seq'::regclass);


--
-- TOC entry 3542 (class 2604 OID 19179)
-- Name: post_list post_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post_list ALTER COLUMN post_id SET DEFAULT nextval('public.post_list_post_id_seq'::regclass);


--
-- TOC entry 3559 (class 2604 OID 19391)
-- Name: promotion promotion_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.promotion ALTER COLUMN promotion_id SET DEFAULT nextval('public.promotion_promotion_id_seq'::regclass);


--
-- TOC entry 3552 (class 2604 OID 19299)
-- Name: room room_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.room ALTER COLUMN room_id SET DEFAULT nextval('public.room_room_id_seq'::regclass);


--
-- TOC entry 3549 (class 2604 OID 19256)
-- Name: room_type type_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.room_type ALTER COLUMN type_id SET DEFAULT nextval('public.room_type_type_id_seq'::regclass);


--
-- TOC entry 3551 (class 2604 OID 19280)
-- Name: room_type_facility room_type_facility_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.room_type_facility ALTER COLUMN room_type_facility_id SET DEFAULT nextval('public.room_type_facility_room_type_facility_id_seq'::regclass);


--
-- TOC entry 3550 (class 2604 OID 19264)
-- Name: room_type_price room_type_price_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.room_type_price ALTER COLUMN room_type_price_id SET DEFAULT nextval('public.room_type_price_room_type_price_id_seq'::regclass);


--
-- TOC entry 3817 (class 0 OID 19369)
-- Dependencies: 246
-- Data for Name: cleaning; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cleaning (cleaning_id, room_id, contract_id, scheduled_at, status) FROM stdin;
1	1	3	2025-06-10 12:00:00	completed
2	2	3	2025-06-10 13:00:00	completed
3	12	6	2025-09-20 11:30:00	completed
4	29	4	2026-01-02 14:00:00	completed
5	5	7	2025-06-15 16:00:00	in_progress
6	26	6	2025-07-16 10:00:00	scheduled
7	7	7	2025-05-05 15:30:00	completed
8	9	8	2025-11-25 12:45:00	completed
9	31	9	2025-08-25 11:15:00	in_progress
10	15	10	2025-05-15 17:00:00	completed
11	18	6	2025-07-26 13:30:00	completed
12	28	4	2025-09-08 10:30:00	scheduled
13	14	10	2025-05-16 09:45:00	completed
14	25	6	2025-07-16 11:00:00	scheduled
15	33	9	2025-10-07 12:20:00	scheduled
16	7	7	2025-08-11 10:00:00	scheduled
17	22	6	2025-08-05 14:00:00	in_progress
18	14	10	2025-07-26 13:30:00	completed
\.


--
-- TOC entry 3789 (class 0 OID 19162)
-- Dependencies: 218
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client (client_id, last_name, first_name, patronymic, email, phone_number, permanent_address) FROM stdin;
2	Ivanova	Maria	Sergeevna	maria.ivanova@example.com	+7-902-111-22-33	St Petersburg, Nevsky 15
3	Taylor	Sam	\N	sam.taylor@example.co.uk	+44-7911-123456	London, Baker St 221B
4	Schmidt	Anna	\N	anna.schmidt@example.de	+49-30-123456	Berlin, Unter den Linden 1
5	Kim	Min-soo	\N	msoo.kim@example.kr	+82-10-9876-5432	Seoul, Gangnam-gu 9
6	Garcia	Luis	Miguel	luis.garcia@example.es	+34-600-111-222	Madrid, Gran Via 40
7	Dubois	Claire	\N	claire.dubois@example.fr	+33-6-12-34-56-78	Paris, Rue de Rivoli 5
8	Johnson	Emily	\N	emily.johnson@example.com	+1-415-555-1234	San Francisco, Market St 1
9	Lopez	Carlos	\N	carlos.lopez@example.mx	+52-55-1234-5678	Mexico City, Reforma 10
10	Nakamura	Yuki	\N	yuki.nakamura@example.jp	+81-80-1234-5678	Tokyo, Shibuya 2
11	Kowalski	Piotr	\N	piotr.k@example.pl	+48-601-234-567	Warsaw, Nowy Świat 6
12	Ostergard	Lars	\N	lars.o@example.dk	+45-20-12-34-56	Copenhagen, Stroget 3
1	Sokolov	Egor	Vladimirovich	egor.sokolov@yandex.ru	+7-901-000-11-22	Moscow, Lenina 2
\.


--
-- TOC entry 3793 (class 0 OID 19186)
-- Dependencies: 222
-- Data for Name: employee; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.employee (employee_id, last_name, first_name, patronymic, gender) FROM stdin;
1	Ivanov	Sergey	Petrovich	\N
2	Petrova	Anna	Ivanovna	\N
3	Sidorov	Pavel	Andreevich	\N
4	Volkova	Maria	Sergeevna	\N
5	Smirnov	Denis	Alexandrovich	\N
6	Kuznetsova	Elena	Igorevna	\N
7	Orlov	Oleg	\N	\N
8	Morozova	Tatiana	\N	\N
9	Fedorov	Roman	Vladimirovich	\N
10	Belova	Olga	Nikolaevna	\N
\.


--
-- TOC entry 3795 (class 0 OID 19196)
-- Dependencies: 224
-- Data for Name: employment_contract; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.employment_contract (contract_id, employee_id, post_id, contract_type, status, rate_count, contract_start_date, contract_end_date) FROM stdin;
1	1	1	permanent	t	1.0	2025-01-01	\N
2	2	2	permanent	t	1.0	2025-02-01	\N
3	3	3	temporary	t	0.5	2025-03-15	2025-09-15
4	4	4	contract	t	1.0	2025-01-10	2025-12-31
5	5	5	permanent	t	1.5	2025-01-01	\N
6	6	6	temporary	t	1.0	2025-04-01	2025-10-01
7	7	3	internship	t	1.0	2025-02-15	2025-08-15
8	8	2	permanent	t	1.0	2025-05-01	\N
9	9	1	contract	t	1.0	2025-06-01	\N
10	10	5	temporary	t	1.0	2025-03-01	2026-02-28
\.


--
-- TOC entry 3797 (class 0 OID 19218)
-- Dependencies: 226
-- Data for Name: facility; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.facility (facility_id, name, description) FROM stdin;
1	Pool	Indoor heated pool
2	Fitness	24h gym
3	Sauna	Finnish sauna
4	Spa	Full-service spa
5	Restaurant	European cuisine
6	Conference	Conference hall
7	Parking	Underground parking
8	Wi-Fi	Free high-speed Wi-Fi
\.


--
-- TOC entry 3799 (class 0 OID 19227)
-- Dependencies: 228
-- Data for Name: hotel; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.hotel (hotel_id, name, region, district, street, building) FROM stdin;
1	Moscow Grand Hotel	Central	Tverskoy	Tverskaya	10
2	Neva Palace St Petersburg	North-West	Admiralteysky	Nevsky pr.	25
\.


--
-- TOC entry 3801 (class 0 OID 19234)
-- Dependencies: 230
-- Data for Name: hotel_facility; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.hotel_facility (hotel_facility_id, hotel_id, facility_id) FROM stdin;
193	1	1
194	1	2
195	1	3
196	1	5
197	1	7
198	1	8
199	2	1
200	2	2
201	2	4
202	2	5
203	2	6
204	2	8
\.


--
-- TOC entry 3815 (class 0 OID 19349)
-- Dependencies: 244
-- Data for Name: order_item; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.order_item (order_item_id, order_id, room_id, arrival_date, departure_date, booking_amount, booking_status) FROM stdin;
1	1	1	2025-06-05	2025-06-10	21000.00	booked
2	1	2	2025-06-05	2025-06-10	21000.00	booked
3	2	22	2025-06-15	2025-06-16	8800.00	checked_in
4	3	12	2025-09-10	2025-09-20	12600.00	checked_out
5	3	13	2025-09-10	2025-09-20	12600.00	checked_out
6	4	29	2025-12-24	2026-01-02	53000.00	canceled
7	5	5	2025-03-12	2025-03-15	15800.00	checked_in
8	6	26	2025-07-05	2025-07-15	30000.00	booked
9	7	7	2025-04-01	2025-04-05	18500.00	checked_out
10	8	9	2025-11-20	2025-11-25	36000.00	checked_in
11	8	34	2025-11-20	2025-11-25	36000.00	checked_in
12	9	31	2025-08-18	2025-08-25	64000.00	booked
13	10	15	2025-05-10	2025-05-15	28000.00	checked_out
14	11	5	2025-08-05	2025-08-10	22500.00	booked
15	11	6	2025-08-05	2025-08-10	19500.00	booked
16	12	22	2025-08-04	2025-08-12	52500.00	checked_in
17	13	18	2025-07-20	2025-07-25	39800.00	checked_out
18	14	28	2025-09-01	2025-09-07	61200.00	canceled
19	15	33	2025-10-02	2025-10-07	47000.00	booked
20	15	23	2025-10-02	2025-10-07	47000.00	booked
21	12	24	2025-08-04	2025-08-12	1.00	checked_in
22	13	19	2025-07-20	2025-07-25	0.00	checked_out
23	14	30	2025-09-01	2025-09-07	0.00	canceled
24	4	27	2025-12-24	2026-01-02	0.00	canceled
25	5	20	2025-03-12	2025-03-15	1.00	checked_in
26	6	25	2025-07-05	2025-07-15	0.00	booked
27	7	8	2025-04-01	2025-04-05	1.00	checked_out
28	9	32	2025-08-18	2025-08-25	0.00	booked
29	10	14	2025-05-10	2025-05-15	0.00	checked_out
30	11	4	2025-08-05	2025-08-10	0.00	booked
\.


--
-- TOC entry 3813 (class 0 OID 19331)
-- Dependencies: 242
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.orders (order_id, passport_id, contract_id, amount, payment_status, overall_status) FROM stdin;
11	11	1	42000.00	t	t
9	9	9	64000.00	f	t
15	3	5	94000.00	t	t
3	3	3	25200.00	t	f
5	5	5	15801.00	t	t
4	4	4	53000.00	f	f
10	10	10	28000.00	t	f
6	6	6	30000.00	f	f
14	2	4	61200.00	f	f
13	1	3	39800.00	t	t
2	2	2	8800.00	t	t
7	7	7	18501.00	t	f
12	12	2	52501.00	t	t
1	1	1	42000.00	t	t
8	8	8	72000.00	t	t
\.


--
-- TOC entry 3811 (class 0 OID 19316)
-- Dependencies: 240
-- Data for Name: passport_data; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.passport_data (passport_id, client_id, series, number, passport_issue_date, passport_expiry_date) FROM stdin;
1	1	9580	440518	2020-09-08	2030-09-07
2	2	AA	1234567	2021-06-01	2031-05-31
3	3	UK	998877	2019-05-20	2029-05-19
4	4	DE	C0123456	2018-03-15	2028-03-14
5	5	KR	M12345678	2022-11-22	2032-11-21
6	6	ES	BA765432	2020-01-10	2030-01-09
7	7	FR	12AB34567	2019-12-01	2029-11-30
8	8	USA	600123456	2021-07-07	2031-07-06
9	9	MX	A12345678	2020-04-04	2030-04-03
10	10	JP	TK1234567	2022-02-02	2032-02-01
11	11	PL	AH1234567	2019-08-18	2029-08-17
12	12	DK	XK123456	2020-10-30	2030-10-29
\.


--
-- TOC entry 3791 (class 0 OID 19176)
-- Dependencies: 220
-- Data for Name: post_list; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.post_list (post_id, title, salary) FROM stdin;
1	Manager	90000
2	Administrator	65000
3	Housekeeper	45000
4	Porter	42000
5	Security	40000
6	Chef	95000
\.


--
-- TOC entry 3819 (class 0 OID 19388)
-- Dependencies: 248
-- Data for Name: promotion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.promotion (promotion_id, type_id, discount_value, is_active, start_date, end_date) FROM stdin;
1	2	10.00	t	2025-06-01	2025-08-31
2	4	15.00	t	2025-12-15	2026-01-15
3	1	5.00	f	2025-03-01	2025-05-31
5	3	12.50	t	2026-04-01	2026-05-15
4	5	70.00	t	2025-09-01	2025-11-30
\.


--
-- TOC entry 3809 (class 0 OID 19296)
-- Dependencies: 238
-- Data for Name: room; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.room (room_id, hotel_id, room_number, type_id) FROM stdin;
1	1	1	1
2	1	2	1
3	1	3	2
4	1	4	2
5	1	5	3
6	1	6	3
7	1	7	4
8	1	8	4
9	1	9	5
10	1	10	5
11	1	11	1
12	1	12	2
13	1	13	3
14	1	14	4
15	1	15	5
16	1	16	2
17	1	17	3
18	1	18	4
19	1	19	1
20	1	20	5
21	2	1	1
22	2	2	1
23	2	3	2
24	2	4	2
25	2	5	3
26	2	6	3
27	2	7	4
28	2	8	4
29	2	9	5
30	2	10	5
31	2	11	2
32	2	12	3
33	2	13	4
34	2	14	1
35	2	15	5
36	2	16	2
37	2	17	3
38	2	18	4
39	2	19	1
40	2	20	5
\.


--
-- TOC entry 3803 (class 0 OID 19253)
-- Dependencies: 232
-- Data for Name: room_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.room_type (type_id, class, capacity) FROM stdin;
1	Single	1
2	Double	2
3	Twin	2
4	Suite	3
5	Deluxe	4
\.


--
-- TOC entry 3807 (class 0 OID 19277)
-- Dependencies: 236
-- Data for Name: room_type_facility; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.room_type_facility (room_type_facility_id, type_id, facility_id) FROM stdin;
157	1	8
158	2	8
159	3	8
160	4	1
161	4	3
162	4	4
163	4	5
164	5	1
165	5	2
166	5	3
167	5	4
168	5	5
\.


--
-- TOC entry 3805 (class 0 OID 19261)
-- Dependencies: 234
-- Data for Name: room_type_price; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.room_type_price (room_type_price_id, type_id, start_date, end_date, price) FROM stdin;
261	1	2025-06-01	2025-08-31	7000.00
262	2	2025-06-01	2025-08-31	9200.00
263	3	2025-06-01	2025-08-31	8800.00
264	4	2025-06-01	2025-08-31	14000.00
265	5	2025-06-01	2025-08-31	18000.00
266	1	2025-09-01	2025-11-30	6500.00
267	2	2025-09-01	2025-11-30	8800.00
268	3	2025-09-01	2025-11-30	8200.00
269	4	2025-09-01	2025-11-30	13200.00
270	5	2025-09-01	2025-11-30	17000.00
271	1	2025-12-01	2026-02-28	6000.00
272	2	2025-12-01	2026-02-28	8000.00
273	3	2025-12-01	2026-02-28	7600.00
274	4	2025-12-01	2026-02-28	12500.00
275	5	2025-12-01	2026-02-28	16000.00
276	1	2026-03-01	2026-05-31	6800.00
277	2	2026-03-01	2026-05-31	9000.00
278	3	2026-03-01	2026-05-31	8400.00
279	4	2026-03-01	2026-05-31	13500.00
280	5	2026-03-01	2026-05-31	17500.00
\.


--
-- TOC entry 3841 (class 0 OID 0)
-- Dependencies: 245
-- Name: cleaning_cleaning_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cleaning_cleaning_id_seq', 1, false);


--
-- TOC entry 3842 (class 0 OID 0)
-- Dependencies: 217
-- Name: client_client_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.client_client_id_seq', 1, false);


--
-- TOC entry 3843 (class 0 OID 0)
-- Dependencies: 221
-- Name: employee_employee_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.employee_employee_id_seq', 1, false);


--
-- TOC entry 3844 (class 0 OID 0)
-- Dependencies: 223
-- Name: employment_contract_contract_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.employment_contract_contract_id_seq', 1, false);


--
-- TOC entry 3845 (class 0 OID 0)
-- Dependencies: 225
-- Name: facility_facility_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.facility_facility_id_seq', 1, false);


--
-- TOC entry 3846 (class 0 OID 0)
-- Dependencies: 229
-- Name: hotel_facility_hotel_facility_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.hotel_facility_hotel_facility_id_seq', 204, true);


--
-- TOC entry 3847 (class 0 OID 0)
-- Dependencies: 227
-- Name: hotel_hotel_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.hotel_hotel_id_seq', 1, false);


--
-- TOC entry 3848 (class 0 OID 0)
-- Dependencies: 243
-- Name: order_item_order_item_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.order_item_order_item_id_seq', 1, false);


--
-- TOC entry 3849 (class 0 OID 0)
-- Dependencies: 241
-- Name: orders_order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.orders_order_id_seq', 18, true);


--
-- TOC entry 3850 (class 0 OID 0)
-- Dependencies: 239
-- Name: passport_data_passport_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.passport_data_passport_id_seq', 1, false);


--
-- TOC entry 3851 (class 0 OID 0)
-- Dependencies: 219
-- Name: post_list_post_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.post_list_post_id_seq', 1, false);


--
-- TOC entry 3852 (class 0 OID 0)
-- Dependencies: 247
-- Name: promotion_promotion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.promotion_promotion_id_seq', 1, false);


--
-- TOC entry 3853 (class 0 OID 0)
-- Dependencies: 237
-- Name: room_room_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.room_room_id_seq', 1, false);


--
-- TOC entry 3854 (class 0 OID 0)
-- Dependencies: 235
-- Name: room_type_facility_room_type_facility_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.room_type_facility_room_type_facility_id_seq', 168, true);


--
-- TOC entry 3855 (class 0 OID 0)
-- Dependencies: 233
-- Name: room_type_price_room_type_price_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.room_type_price_room_type_price_id_seq', 280, true);


--
-- TOC entry 3856 (class 0 OID 0)
-- Dependencies: 231
-- Name: room_type_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.room_type_type_id_seq', 1, false);


--
-- TOC entry 3622 (class 2606 OID 19376)
-- Name: cleaning cleaning_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cleaning
    ADD CONSTRAINT cleaning_pkey PRIMARY KEY (cleaning_id);


--
-- TOC entry 3586 (class 2606 OID 19174)
-- Name: client client_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT client_pkey PRIMARY KEY (client_id);


--
-- TOC entry 3590 (class 2606 OID 19194)
-- Name: employee employee_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee
    ADD CONSTRAINT employee_pkey PRIMARY KEY (employee_id);


--
-- TOC entry 3592 (class 2606 OID 19206)
-- Name: employment_contract employment_contract_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employment_contract
    ADD CONSTRAINT employment_contract_pkey PRIMARY KEY (contract_id);


--
-- TOC entry 3594 (class 2606 OID 19225)
-- Name: facility facility_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.facility
    ADD CONSTRAINT facility_pkey PRIMARY KEY (facility_id);


--
-- TOC entry 3598 (class 2606 OID 19239)
-- Name: hotel_facility hotel_facility_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hotel_facility
    ADD CONSTRAINT hotel_facility_pkey PRIMARY KEY (hotel_facility_id);


--
-- TOC entry 3596 (class 2606 OID 19232)
-- Name: hotel hotel_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hotel
    ADD CONSTRAINT hotel_pkey PRIMARY KEY (hotel_id);


--
-- TOC entry 3620 (class 2606 OID 19357)
-- Name: order_item order_item_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_item
    ADD CONSTRAINT order_item_pkey PRIMARY KEY (order_item_id);


--
-- TOC entry 3618 (class 2606 OID 19337)
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (order_id);


--
-- TOC entry 3616 (class 2606 OID 19324)
-- Name: passport_data passport_data_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.passport_data
    ADD CONSTRAINT passport_data_pkey PRIMARY KEY (passport_id);


--
-- TOC entry 3588 (class 2606 OID 19184)
-- Name: post_list post_list_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post_list
    ADD CONSTRAINT post_list_pkey PRIMARY KEY (post_id);


--
-- TOC entry 3624 (class 2606 OID 19396)
-- Name: promotion promotion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.promotion
    ADD CONSTRAINT promotion_pkey PRIMARY KEY (promotion_id);


--
-- TOC entry 3612 (class 2606 OID 19302)
-- Name: room room_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.room
    ADD CONSTRAINT room_pkey PRIMARY KEY (room_id);


--
-- TOC entry 3608 (class 2606 OID 19282)
-- Name: room_type_facility room_type_facility_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.room_type_facility
    ADD CONSTRAINT room_type_facility_pkey PRIMARY KEY (room_type_facility_id);


--
-- TOC entry 3602 (class 2606 OID 19259)
-- Name: room_type room_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.room_type
    ADD CONSTRAINT room_type_pkey PRIMARY KEY (type_id);


--
-- TOC entry 3604 (class 2606 OID 19268)
-- Name: room_type_price room_type_price_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.room_type_price
    ADD CONSTRAINT room_type_price_pkey PRIMARY KEY (room_type_price_id);


--
-- TOC entry 3600 (class 2606 OID 19241)
-- Name: hotel_facility uq_hotel_facility; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hotel_facility
    ADD CONSTRAINT uq_hotel_facility UNIQUE (hotel_id, facility_id);


--
-- TOC entry 3614 (class 2606 OID 19304)
-- Name: room uq_room_hotel_number; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.room
    ADD CONSTRAINT uq_room_hotel_number UNIQUE (hotel_id, room_number);


--
-- TOC entry 3610 (class 2606 OID 19284)
-- Name: room_type_facility uq_room_type_facility; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.room_type_facility
    ADD CONSTRAINT uq_room_type_facility UNIQUE (type_id, facility_id);


--
-- TOC entry 3606 (class 2606 OID 19270)
-- Name: room_type_price uq_room_type_price; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.room_type_price
    ADD CONSTRAINT uq_room_type_price UNIQUE (type_id, start_date, end_date);


--
-- TOC entry 3639 (class 2606 OID 19382)
-- Name: cleaning cleaning_contract_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cleaning
    ADD CONSTRAINT cleaning_contract_id_fkey FOREIGN KEY (contract_id) REFERENCES public.employment_contract(contract_id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3640 (class 2606 OID 19377)
-- Name: cleaning cleaning_room_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cleaning
    ADD CONSTRAINT cleaning_room_id_fkey FOREIGN KEY (room_id) REFERENCES public.room(room_id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3625 (class 2606 OID 19207)
-- Name: employment_contract employment_contract_employee_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employment_contract
    ADD CONSTRAINT employment_contract_employee_id_fkey FOREIGN KEY (employee_id) REFERENCES public.employee(employee_id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3626 (class 2606 OID 19212)
-- Name: employment_contract employment_contract_post_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employment_contract
    ADD CONSTRAINT employment_contract_post_id_fkey FOREIGN KEY (post_id) REFERENCES public.post_list(post_id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3627 (class 2606 OID 19247)
-- Name: hotel_facility hotel_facility_facility_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hotel_facility
    ADD CONSTRAINT hotel_facility_facility_id_fkey FOREIGN KEY (facility_id) REFERENCES public.facility(facility_id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3628 (class 2606 OID 19242)
-- Name: hotel_facility hotel_facility_hotel_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hotel_facility
    ADD CONSTRAINT hotel_facility_hotel_id_fkey FOREIGN KEY (hotel_id) REFERENCES public.hotel(hotel_id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3637 (class 2606 OID 19358)
-- Name: order_item order_item_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_item
    ADD CONSTRAINT order_item_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(order_id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3638 (class 2606 OID 19363)
-- Name: order_item order_item_room_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_item
    ADD CONSTRAINT order_item_room_id_fkey FOREIGN KEY (room_id) REFERENCES public.room(room_id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3635 (class 2606 OID 19343)
-- Name: orders orders_contract_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_contract_id_fkey FOREIGN KEY (contract_id) REFERENCES public.employment_contract(contract_id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3636 (class 2606 OID 19338)
-- Name: orders orders_passport_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_passport_id_fkey FOREIGN KEY (passport_id) REFERENCES public.passport_data(passport_id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3634 (class 2606 OID 19325)
-- Name: passport_data passport_data_client_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.passport_data
    ADD CONSTRAINT passport_data_client_id_fkey FOREIGN KEY (client_id) REFERENCES public.client(client_id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3641 (class 2606 OID 19397)
-- Name: promotion promotion_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.promotion
    ADD CONSTRAINT promotion_type_id_fkey FOREIGN KEY (type_id) REFERENCES public.room_type(type_id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3632 (class 2606 OID 19305)
-- Name: room room_hotel_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.room
    ADD CONSTRAINT room_hotel_id_fkey FOREIGN KEY (hotel_id) REFERENCES public.hotel(hotel_id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3630 (class 2606 OID 19290)
-- Name: room_type_facility room_type_facility_facility_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.room_type_facility
    ADD CONSTRAINT room_type_facility_facility_id_fkey FOREIGN KEY (facility_id) REFERENCES public.facility(facility_id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3631 (class 2606 OID 19285)
-- Name: room_type_facility room_type_facility_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.room_type_facility
    ADD CONSTRAINT room_type_facility_type_id_fkey FOREIGN KEY (type_id) REFERENCES public.room_type(type_id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3633 (class 2606 OID 19310)
-- Name: room room_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.room
    ADD CONSTRAINT room_type_id_fkey FOREIGN KEY (type_id) REFERENCES public.room_type(type_id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3629 (class 2606 OID 19271)
-- Name: room_type_price room_type_price_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.room_type_price
    ADD CONSTRAINT room_type_price_type_id_fkey FOREIGN KEY (type_id) REFERENCES public.room_type(type_id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


-- Completed on 2025-05-26 14:48:21 MSK

--
-- PostgreSQL database dump complete
--

