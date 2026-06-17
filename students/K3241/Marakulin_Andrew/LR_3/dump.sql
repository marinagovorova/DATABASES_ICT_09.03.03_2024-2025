--
-- PostgreSQL database dump
--

-- Dumped from database version 14.17 (Debian 14.17-1.pgdg120+1)
-- Dumped by pg_dump version 14.17

-- Started on 2025-03-24 12:57:01 UTC

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
-- TOC entry 235 (class 1255 OID 24746)
-- Name: validate_deposit_min_amount(); Type: FUNCTION; Schema: public; Owner: admin
--

CREATE FUNCTION public.validate_deposit_min_amount() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    min_amt INTEGER;
BEGIN
    SELECT min_amount INTO min_amt
    FROM deposit_type
    WHERE deposit_type_id = NEW.deposit_type_id;

    IF NEW.deposit_amount < min_amt THEN
        RAISE EXCEPTION 'Deposit amount (%) must be >= minimum (%)', NEW.deposit_amount, min_amt;
    END IF;
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.validate_deposit_min_amount() OWNER TO admin;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 210 (class 1259 OID 24653)
-- Name: client; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.client (
    client_id integer NOT NULL,
    full_name character(18) NOT NULL,
    address character(18),
    phone character(18) NOT NULL,
    email character varying(320),
    CONSTRAINT client_address_check CHECK ((address ~ '^[A-Za-zА-Яа-яЁё0-9\.\,\-\ ]*$'::text)),
    CONSTRAINT client_email_check CHECK (((email)::text ~ '^[A-Za-z0-9\.\-_]+@[A-Za-z0-9\.\-]+\.[A-Za-z]{2,}$'::text)),
    CONSTRAINT client_full_name_check CHECK ((full_name ~ '^[A-Za-zА-Яа-яЁё\- ]{2,}$'::text)),
    CONSTRAINT client_phone_check CHECK ((phone ~ '^\+[0-9 ]+$'::text))
);


ALTER TABLE public.client OWNER TO admin;

--
-- TOC entry 209 (class 1259 OID 24652)
-- Name: client_client_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.client_client_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.client_client_id_seq OWNER TO admin;

--
-- TOC entry 3523 (class 0 OID 0)
-- Dependencies: 209
-- Name: client_client_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.client_client_id_seq OWNED BY public.client.client_id;


--
-- TOC entry 216 (class 1259 OID 24693)
-- Name: currency; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.currency (
    currency_code integer NOT NULL,
    currency_name character(30) NOT NULL,
    CONSTRAINT currency_currency_name_check CHECK ((currency_name ~ '^[A-Za-zА-Яа-яЁё\-\ ]+$'::text))
);


ALTER TABLE public.currency OWNER TO admin;

--
-- TOC entry 215 (class 1259 OID 24692)
-- Name: currency_currency_code_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.currency_currency_code_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.currency_currency_code_seq OWNER TO admin;

--
-- TOC entry 3524 (class 0 OID 0)
-- Dependencies: 215
-- Name: currency_currency_code_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.currency_currency_code_seq OWNED BY public.currency.currency_code;


--
-- TOC entry 218 (class 1259 OID 24701)
-- Name: currency_rate; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.currency_rate (
    rate_id integer NOT NULL,
    multiplier integer NOT NULL,
    buy_rate numeric NOT NULL,
    sell_rate numeric NOT NULL,
    rate_date date NOT NULL,
    currency_code integer NOT NULL,
    CONSTRAINT currency_rate_buy_rate_check CHECK ((buy_rate > (0)::numeric)),
    CONSTRAINT currency_rate_multiplier_check CHECK ((multiplier > 0)),
    CONSTRAINT currency_rate_sell_rate_check CHECK ((sell_rate > (0)::numeric))
);


ALTER TABLE public.currency_rate OWNER TO admin;

--
-- TOC entry 217 (class 1259 OID 24700)
-- Name: currency_rate_rate_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.currency_rate_rate_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.currency_rate_rate_id_seq OWNER TO admin;

--
-- TOC entry 3525 (class 0 OID 0)
-- Dependencies: 217
-- Name: currency_rate_rate_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.currency_rate_rate_id_seq OWNED BY public.currency_rate.rate_id;


--
-- TOC entry 220 (class 1259 OID 24718)
-- Name: deposit; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.deposit (
    deposit_id integer NOT NULL,
    document_url character(100) NOT NULL,
    return_amount numeric NOT NULL,
    deposit_amount numeric NOT NULL,
    actual_return_date timestamp without time zone,
    contract_url character(100) NOT NULL,
    contract_number character varying(30) NOT NULL,
    expected_return_date timestamp without time zone NOT NULL,
    deposit_date timestamp without time zone NOT NULL,
    passport_id integer NOT NULL,
    deposit_type_id integer NOT NULL,
    currency_code integer NOT NULL,
    CONSTRAINT deposit_contract_number_check CHECK ((TRIM(BOTH FROM contract_number) ~ '^[A-Za-zА-Яа-яЁё0-9\-\s]+$'::text)),
    CONSTRAINT deposit_contract_url_check CHECK ((TRIM(BOTH FROM contract_url) ~ '^https?://.+\.pdf$'::text)),
    CONSTRAINT deposit_deposit_amount_check CHECK ((deposit_amount >= (0)::numeric)),
    CONSTRAINT deposit_document_url_check CHECK ((TRIM(BOTH FROM document_url) ~ '^https?://.+\.pdf$'::text)),
    CONSTRAINT deposit_return_amount_check CHECK ((return_amount > (0)::numeric))
);


ALTER TABLE public.deposit OWNER TO admin;

--
-- TOC entry 219 (class 1259 OID 24717)
-- Name: deposit_deposit_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.deposit_deposit_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.deposit_deposit_id_seq OWNER TO admin;

--
-- TOC entry 3526 (class 0 OID 0)
-- Dependencies: 219
-- Name: deposit_deposit_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.deposit_deposit_id_seq OWNED BY public.deposit.deposit_id;


--
-- TOC entry 222 (class 1259 OID 24757)
-- Name: deposit_schedule; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.deposit_schedule (
    schedule_id integer NOT NULL,
    accrual_date timestamp without time zone NOT NULL,
    accrual_amount numeric NOT NULL,
    sequence_number integer NOT NULL,
    deposit_id integer NOT NULL,
    CONSTRAINT deposit_schedule_accrual_amount_check CHECK ((accrual_amount >= (0)::numeric)),
    CONSTRAINT deposit_schedule_sequence_number_check CHECK ((sequence_number >= 0))
);


ALTER TABLE public.deposit_schedule OWNER TO admin;

--
-- TOC entry 221 (class 1259 OID 24756)
-- Name: deposit_schedule_schedule_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.deposit_schedule_schedule_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.deposit_schedule_schedule_id_seq OWNER TO admin;

--
-- TOC entry 3527 (class 0 OID 0)
-- Dependencies: 221
-- Name: deposit_schedule_schedule_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.deposit_schedule_schedule_id_seq OWNED BY public.deposit_schedule.schedule_id;


--
-- TOC entry 214 (class 1259 OID 24680)
-- Name: deposit_type; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.deposit_type (
    deposit_type_id integer NOT NULL,
    name character varying(30),
    description character varying(100),
    min_term integer NOT NULL,
    min_amount integer NOT NULL,
    interest_rate integer NOT NULL,
    term integer NOT NULL,
    CONSTRAINT deposit_type_description_check CHECK (((description)::text ~ '^[A-Za-zА-Яа-яЁё0-9\-\.,%\s₽€¥\$]*$'::text)),
    CONSTRAINT deposit_type_interest_rate_check CHECK (((interest_rate > 0) AND (interest_rate < 99))),
    CONSTRAINT deposit_type_min_amount_check CHECK ((min_amount >= 0)),
    CONSTRAINT deposit_type_min_term_check CHECK ((min_term >= 0)),
    CONSTRAINT deposit_type_name_check CHECK (((name)::text ~ '^[A-Za-zА-Яа-яЁё0-9\-\.,\s]+$'::text)),
    CONSTRAINT deposit_type_term_check CHECK ((term > 0))
);


ALTER TABLE public.deposit_type OWNER TO admin;

--
-- TOC entry 213 (class 1259 OID 24679)
-- Name: deposit_type_deposit_type_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.deposit_type_deposit_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.deposit_type_deposit_type_id_seq OWNER TO admin;

--
-- TOC entry 3528 (class 0 OID 0)
-- Dependencies: 213
-- Name: deposit_type_deposit_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.deposit_type_deposit_type_id_seq OWNED BY public.deposit_type.deposit_type_id;


--
-- TOC entry 230 (class 1259 OID 24834)
-- Name: employee; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.employee (
    employee_id integer NOT NULL,
    full_name character(30) NOT NULL,
    birth_date timestamp without time zone NOT NULL,
    address character(50),
    phone character(20) NOT NULL,
    passport_data character varying(50) NOT NULL,
    salary numeric NOT NULL,
    CONSTRAINT employee_address_check CHECK ((address ~ '^[A-Za-zА-Яа-яЁё0-9\.\,\-\ ]*$'::text)),
    CONSTRAINT employee_full_name_check CHECK ((full_name ~ '^[A-Za-zА-Яа-яЁё\- ]{2,}$'::text)),
    CONSTRAINT employee_passport_data_check CHECK (((passport_data)::text ~ '^[A-Za-zА-Яа-яЁё0-9\-\.\ ]+$'::text)),
    CONSTRAINT employee_phone_check CHECK ((phone ~ '^\+7[0-9 ]+$'::text)),
    CONSTRAINT employee_salary_check CHECK ((salary > (0)::numeric))
);


ALTER TABLE public.employee OWNER TO admin;

--
-- TOC entry 229 (class 1259 OID 24833)
-- Name: employee_employee_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.employee_employee_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.employee_employee_id_seq OWNER TO admin;

--
-- TOC entry 3529 (class 0 OID 0)
-- Dependencies: 229
-- Name: employee_employee_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.employee_employee_id_seq OWNED BY public.employee.employee_id;


--
-- TOC entry 234 (class 1259 OID 24860)
-- Name: employee_position; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.employee_position (
    id integer NOT NULL,
    start_date timestamp without time zone NOT NULL,
    end_date timestamp without time zone,
    employee_id integer NOT NULL,
    position_id integer NOT NULL,
    CONSTRAINT employee_position_check CHECK ((end_date >= start_date))
);


ALTER TABLE public.employee_position OWNER TO admin;

--
-- TOC entry 233 (class 1259 OID 24859)
-- Name: employee_position_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.employee_position_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.employee_position_id_seq OWNER TO admin;

--
-- TOC entry 3530 (class 0 OID 0)
-- Dependencies: 233
-- Name: employee_position_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.employee_position_id_seq OWNED BY public.employee_position.id;


--
-- TOC entry 226 (class 1259 OID 24784)
-- Name: loan; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.loan (
    loan_id integer NOT NULL,
    document_url character varying(100) NOT NULL,
    loan_date timestamp without time zone NOT NULL,
    loan_amount numeric NOT NULL,
    due_date timestamp without time zone NOT NULL,
    trustee character varying(50) NOT NULL,
    loan_type_id integer NOT NULL,
    currency_code integer NOT NULL,
    passport_id integer NOT NULL,
    contract_url character varying(100) NOT NULL,
    contract_number character varying(30) NOT NULL,
    monthly_payment numeric NOT NULL,
    expected_close_date timestamp without time zone NOT NULL,
    actual_close_date timestamp without time zone,
    CONSTRAINT loan_check CHECK ((due_date >= loan_date)),
    CONSTRAINT loan_check1 CHECK ((actual_close_date >= loan_date)),
    CONSTRAINT loan_contract_number_check CHECK ((TRIM(BOTH FROM contract_number) ~ '^[A-Za-zА-Яа-яЁё0-9\-\s]+$'::text)),
    CONSTRAINT loan_contract_url_check CHECK (((contract_url)::text ~ '^https?://.*\.pdf$'::text)),
    CONSTRAINT loan_document_url_check CHECK (((document_url)::text ~ '^https?://.*\.pdf$'::text)),
    CONSTRAINT loan_loan_amount_check CHECK ((loan_amount > (0)::numeric)),
    CONSTRAINT loan_monthly_payment_check CHECK ((monthly_payment > (0)::numeric)),
    CONSTRAINT loan_trustee_check CHECK ((TRIM(BOTH FROM trustee) ~ '^[A-Za-zА-Яа-яЁё0-9\-\,\.\:\s]+$'::text))
);


ALTER TABLE public.loan OWNER TO admin;

--
-- TOC entry 225 (class 1259 OID 24783)
-- Name: loan_loan_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.loan_loan_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.loan_loan_id_seq OWNER TO admin;

--
-- TOC entry 3531 (class 0 OID 0)
-- Dependencies: 225
-- Name: loan_loan_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.loan_loan_id_seq OWNED BY public.loan.loan_id;


--
-- TOC entry 228 (class 1259 OID 24816)
-- Name: loan_schedule; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.loan_schedule (
    schedule_id integer NOT NULL,
    payment_date timestamp without time zone NOT NULL,
    payment_amount numeric NOT NULL,
    balance numeric NOT NULL,
    actual_payment_date timestamp without time zone,
    sequence_number integer NOT NULL,
    interest_payment numeric NOT NULL,
    loan_id integer NOT NULL,
    CONSTRAINT loan_schedule_balance_check CHECK ((balance >= (0)::numeric)),
    CONSTRAINT loan_schedule_interest_payment_check CHECK ((interest_payment >= (0)::numeric)),
    CONSTRAINT loan_schedule_payment_amount_check CHECK ((payment_amount >= (0)::numeric)),
    CONSTRAINT loan_schedule_sequence_number_check CHECK ((sequence_number >= 0))
);


ALTER TABLE public.loan_schedule OWNER TO admin;

--
-- TOC entry 227 (class 1259 OID 24815)
-- Name: loan_schedule_schedule_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.loan_schedule_schedule_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.loan_schedule_schedule_id_seq OWNER TO admin;

--
-- TOC entry 3532 (class 0 OID 0)
-- Dependencies: 227
-- Name: loan_schedule_schedule_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.loan_schedule_schedule_id_seq OWNED BY public.loan_schedule.schedule_id;


--
-- TOC entry 224 (class 1259 OID 24773)
-- Name: loan_type; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.loan_type (
    loan_type_id integer NOT NULL,
    term integer NOT NULL,
    interest_rate integer NOT NULL,
    name character varying(30),
    type character varying(30),
    CONSTRAINT loan_type_interest_rate_check CHECK (((interest_rate > 0) AND (interest_rate < 99))),
    CONSTRAINT loan_type_name_check CHECK (((name)::text ~ '^[A-Za-zА-Яа-яЁё0-9\-\.,\s]+$'::text)),
    CONSTRAINT loan_type_term_check CHECK ((term > 0)),
    CONSTRAINT loan_type_type_check CHECK (((type)::text ~ '^[A-Za-zА-Яа-яЁё0-9\-\.,\s]+$'::text))
);


ALTER TABLE public.loan_type OWNER TO admin;

--
-- TOC entry 223 (class 1259 OID 24772)
-- Name: loan_type_loan_type_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.loan_type_loan_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.loan_type_loan_type_id_seq OWNER TO admin;

--
-- TOC entry 3533 (class 0 OID 0)
-- Dependencies: 223
-- Name: loan_type_loan_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.loan_type_loan_type_id_seq OWNED BY public.loan_type.loan_type_id;


--
-- TOC entry 212 (class 1259 OID 24664)
-- Name: passport; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.passport (
    passport_id integer NOT NULL,
    series character(20),
    number character(20) NOT NULL,
    issue_date timestamp without time zone NOT NULL,
    issued_by character varying(30) NOT NULL,
    full_name character(18) NOT NULL,
    client_id integer NOT NULL,
    CONSTRAINT passport_full_name_check CHECK ((full_name ~ '^[A-Za-zА-Яа-яЁё\- ]{2,}$'::text)),
    CONSTRAINT passport_issued_by_check CHECK (((issued_by)::text ~ '^[A-Za-zА-Яа-яЁё0-9\- ]+$'::text)),
    CONSTRAINT passport_number_check CHECK ((number ~ '^[A-Za-zА-Яа-яЁё0-9\- ]+$'::text)),
    CONSTRAINT passport_series_check CHECK ((series ~ '^[A-Za-zА-Яа-яЁё0-9 ]+$'::text))
);


ALTER TABLE public.passport OWNER TO admin;

--
-- TOC entry 211 (class 1259 OID 24663)
-- Name: passport_passport_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.passport_passport_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.passport_passport_id_seq OWNER TO admin;

--
-- TOC entry 3534 (class 0 OID 0)
-- Dependencies: 211
-- Name: passport_passport_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.passport_passport_id_seq OWNED BY public.passport.passport_id;


--
-- TOC entry 232 (class 1259 OID 24848)
-- Name: position; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public."position" (
    position_id integer NOT NULL,
    name character varying(50),
    salary numeric NOT NULL,
    vacancies integer NOT NULL,
    CONSTRAINT position_name_check CHECK (((name)::text ~ '^[A-Za-zА-Яа-яЁё0-9\-\,\.\ ]*$'::text)),
    CONSTRAINT position_salary_check CHECK ((salary >= (0)::numeric)),
    CONSTRAINT position_vacancies_check CHECK ((vacancies >= 0))
);


ALTER TABLE public."position" OWNER TO admin;

--
-- TOC entry 231 (class 1259 OID 24847)
-- Name: position_position_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.position_position_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.position_position_id_seq OWNER TO admin;

--
-- TOC entry 3535 (class 0 OID 0)
-- Dependencies: 231
-- Name: position_position_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.position_position_id_seq OWNED BY public."position".position_id;


--
-- TOC entry 3251 (class 2604 OID 24656)
-- Name: client client_id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client ALTER COLUMN client_id SET DEFAULT nextval('public.client_client_id_seq'::regclass);


--
-- TOC entry 3268 (class 2604 OID 24696)
-- Name: currency currency_code; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.currency ALTER COLUMN currency_code SET DEFAULT nextval('public.currency_currency_code_seq'::regclass);


--
-- TOC entry 3270 (class 2604 OID 24704)
-- Name: currency_rate rate_id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.currency_rate ALTER COLUMN rate_id SET DEFAULT nextval('public.currency_rate_rate_id_seq'::regclass);


--
-- TOC entry 3274 (class 2604 OID 24721)
-- Name: deposit deposit_id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.deposit ALTER COLUMN deposit_id SET DEFAULT nextval('public.deposit_deposit_id_seq'::regclass);


--
-- TOC entry 3280 (class 2604 OID 24760)
-- Name: deposit_schedule schedule_id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.deposit_schedule ALTER COLUMN schedule_id SET DEFAULT nextval('public.deposit_schedule_schedule_id_seq'::regclass);


--
-- TOC entry 3261 (class 2604 OID 24683)
-- Name: deposit_type deposit_type_id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.deposit_type ALTER COLUMN deposit_type_id SET DEFAULT nextval('public.deposit_type_deposit_type_id_seq'::regclass);


--
-- TOC entry 3302 (class 2604 OID 24837)
-- Name: employee employee_id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.employee ALTER COLUMN employee_id SET DEFAULT nextval('public.employee_employee_id_seq'::regclass);


--
-- TOC entry 3312 (class 2604 OID 24863)
-- Name: employee_position id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.employee_position ALTER COLUMN id SET DEFAULT nextval('public.employee_position_id_seq'::regclass);


--
-- TOC entry 3288 (class 2604 OID 24787)
-- Name: loan loan_id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.loan ALTER COLUMN loan_id SET DEFAULT nextval('public.loan_loan_id_seq'::regclass);


--
-- TOC entry 3297 (class 2604 OID 24819)
-- Name: loan_schedule schedule_id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.loan_schedule ALTER COLUMN schedule_id SET DEFAULT nextval('public.loan_schedule_schedule_id_seq'::regclass);


--
-- TOC entry 3283 (class 2604 OID 24776)
-- Name: loan_type loan_type_id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.loan_type ALTER COLUMN loan_type_id SET DEFAULT nextval('public.loan_type_loan_type_id_seq'::regclass);


--
-- TOC entry 3256 (class 2604 OID 24667)
-- Name: passport passport_id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.passport ALTER COLUMN passport_id SET DEFAULT nextval('public.passport_passport_id_seq'::regclass);


--
-- TOC entry 3308 (class 2604 OID 24851)
-- Name: position position_id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."position" ALTER COLUMN position_id SET DEFAULT nextval('public.position_position_id_seq'::regclass);


--
-- TOC entry 3493 (class 0 OID 24653)
-- Dependencies: 210
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.client (client_id, full_name, address, phone, email) FROM stdin;
11	Иванов Иван       	ул. Ленина, 10    	+7 9123456789     	ivanov@mail.ru
12	Петров-Петр Петр  	пр. Мира, 15      	+7 9012345678     	petrov@mail.com
13	Сидоров Сидор     	ул. Гагарина, 7   	+7 9001112233     	sidorov@mail.org
\.


--
-- TOC entry 3499 (class 0 OID 24693)
-- Dependencies: 216
-- Data for Name: currency; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.currency (currency_code, currency_name) FROM stdin;
3	Рубль                         
4	Доллар США                    
5	Евро                          
\.


--
-- TOC entry 3501 (class 0 OID 24701)
-- Dependencies: 218
-- Data for Name: currency_rate; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.currency_rate (rate_id, multiplier, buy_rate, sell_rate, rate_date, currency_code) FROM stdin;
1	3	1.00	1.00	2025-03-01	3
2	3	75.50	76.00	2025-03-01	4
3	3	83.20	83.80	2025-03-01	5
\.


--
-- TOC entry 3503 (class 0 OID 24718)
-- Dependencies: 220
-- Data for Name: deposit; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.deposit (deposit_id, document_url, return_amount, deposit_amount, actual_return_date, contract_url, contract_number, expected_return_date, deposit_date, passport_id, deposit_type_id, currency_code) FROM stdin;
2	https://bank.ru/docs/deposit1.pdf                                                                   	10500	10000	\N	https://bank.ru/contracts/d1.pdf                                                                    	D1-001	2026-03-23 00:00:00	2025-03-23 00:00:00	20	3	3
3	https://bank.ru/docs/deposit2.pdf                                                                   	5250	5000	\N	https://bank.ru/contracts/d2.pdf                                                                    	D2-002	2025-09-23 00:00:00	2025-03-23 00:00:00	21	4	4
4	https://bank.ru/docs/deposit3.pdf                                                                   	53500	50000	\N	https://bank.ru/contracts/d3.pdf                                                                    	D3-003	2027-03-23 00:00:00	2025-03-23 00:00:00	22	5	5
\.


--
-- TOC entry 3505 (class 0 OID 24757)
-- Dependencies: 222
-- Data for Name: deposit_schedule; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.deposit_schedule (schedule_id, accrual_date, accrual_amount, sequence_number, deposit_id) FROM stdin;
1	2025-09-23 00:00:00	250	1	2
2	2026-03-23 00:00:00	500	2	2
3	2025-06-23 00:00:00	100	1	3
\.


--
-- TOC entry 3497 (class 0 OID 24680)
-- Dependencies: 214
-- Data for Name: deposit_type; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.deposit_type (deposit_type_id, name, description, min_term, min_amount, interest_rate, term) FROM stdin;
3	Стандартный	Обычный вклад	6	10000	5	12
4	Накопительный	Вклад с капитализацией	3	5000	4	6
5	Премиум	Высокая ставка	12	50000	7	24
\.


--
-- TOC entry 3513 (class 0 OID 24834)
-- Dependencies: 230
-- Data for Name: employee; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.employee (employee_id, full_name, birth_date, address, phone, passport_data, salary) FROM stdin;
1	Иванова Мария                 	1985-07-15 00:00:00	ул. Пушкина, 5                                    	+7 9011112223       	AB 1234 567890	50000
2	Петров Алексей                	1990-11-30 00:00:00	пр. Ленина, 20                                    	+7 9022223334       	CD 9876 543210	60000
3	Смирнов Олег                  	1980-03-10 00:00:00	ул. Чехова, 12                                    	+7 9033334445       	EF 1122 334455	55000
\.


--
-- TOC entry 3517 (class 0 OID 24860)
-- Dependencies: 234
-- Data for Name: employee_position; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.employee_position (id, start_date, end_date, employee_id, position_id) FROM stdin;
1	2020-01-01 00:00:00	\N	1	1
2	2021-06-01 00:00:00	\N	2	2
3	2019-03-01 00:00:00	2024-12-31 00:00:00	3	3
\.


--
-- TOC entry 3509 (class 0 OID 24784)
-- Dependencies: 226
-- Data for Name: loan; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.loan (loan_id, document_url, loan_date, loan_amount, due_date, trustee, loan_type_id, currency_code, passport_id, contract_url, contract_number, monthly_payment, expected_close_date, actual_close_date) FROM stdin;
1	https://bank.ru/docs/loan1.pdf	2025-01-01 00:00:00	100000	2026-01-01 00:00:00	Иванов Иван	2	3	20	https://bank.ru/contracts/l1.pdf	L1-001	8500	2026-01-01 00:00:00	\N
2	https://bank.ru/docs/loan2.pdf	2025-02-01 00:00:00	500000	2027-02-01 00:00:00	Петров-Петр Петр	3	4	21	https://bank.ru/contracts/l2.pdf	L2-002	23000	2027-02-01 00:00:00	\N
3	https://bank.ru/docs/loan3.pdf	2025-03-01 00:00:00	300000	2028-03-01 00:00:00	Сидоров Сидор	4	5	22	https://bank.ru/contracts/l3.pdf	L3-003	11500	2028-03-01 00:00:00	\N
\.


--
-- TOC entry 3511 (class 0 OID 24816)
-- Dependencies: 228
-- Data for Name: loan_schedule; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.loan_schedule (schedule_id, payment_date, payment_amount, balance, actual_payment_date, sequence_number, interest_payment, loan_id) FROM stdin;
1	2025-04-01 00:00:00	8500	91500	2025-04-01 00:00:00	1	500	1
2	2025-05-01 00:00:00	8500	83000	\N	2	450	1
3	2025-04-01 00:00:00	23000	477000	2025-04-01 00:00:00	1	1000	2
\.


--
-- TOC entry 3507 (class 0 OID 24773)
-- Dependencies: 224
-- Data for Name: loan_type; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.loan_type (loan_type_id, term, interest_rate, name, type) FROM stdin;
2	12	10	Потребительский	Cash
3	24	8	Автокредит	Auto
4	36	12	Ипотека	Mortgage
\.


--
-- TOC entry 3495 (class 0 OID 24664)
-- Dependencies: 212
-- Data for Name: passport; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.passport (passport_id, series, number, issue_date, issued_by, full_name, client_id) FROM stdin;
20	6019                	123479              	2010-05-20 00:00:00	УФМС Москва	Иванов Иван       	11
21	0985                	907543              	2015-08-01 00:00:00	ОВД Санкт-Петербург	Петров-Петр Петр  	12
22	1679                	368701              	2012-11-15 00:00:00	УФМС Казань	Сидоров Сидор     	13
\.


--
-- TOC entry 3515 (class 0 OID 24848)
-- Dependencies: 232
-- Data for Name: position; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public."position" (position_id, name, salary, vacancies) FROM stdin;
1	Менеджер	50000	2
2	Кассир	40000	3
3	Аналитик	60000	1
\.


--
-- TOC entry 3536 (class 0 OID 0)
-- Dependencies: 209
-- Name: client_client_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.client_client_id_seq', 13, true);


--
-- TOC entry 3537 (class 0 OID 0)
-- Dependencies: 215
-- Name: currency_currency_code_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.currency_currency_code_seq', 5, true);


--
-- TOC entry 3538 (class 0 OID 0)
-- Dependencies: 217
-- Name: currency_rate_rate_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.currency_rate_rate_id_seq', 3, true);


--
-- TOC entry 3539 (class 0 OID 0)
-- Dependencies: 219
-- Name: deposit_deposit_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.deposit_deposit_id_seq', 4, true);


--
-- TOC entry 3540 (class 0 OID 0)
-- Dependencies: 221
-- Name: deposit_schedule_schedule_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.deposit_schedule_schedule_id_seq', 3, true);


--
-- TOC entry 3541 (class 0 OID 0)
-- Dependencies: 213
-- Name: deposit_type_deposit_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.deposit_type_deposit_type_id_seq', 5, true);


--
-- TOC entry 3542 (class 0 OID 0)
-- Dependencies: 229
-- Name: employee_employee_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.employee_employee_id_seq', 3, true);


--
-- TOC entry 3543 (class 0 OID 0)
-- Dependencies: 233
-- Name: employee_position_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.employee_position_id_seq', 3, true);


--
-- TOC entry 3544 (class 0 OID 0)
-- Dependencies: 225
-- Name: loan_loan_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.loan_loan_id_seq', 3, true);


--
-- TOC entry 3545 (class 0 OID 0)
-- Dependencies: 227
-- Name: loan_schedule_schedule_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.loan_schedule_schedule_id_seq', 3, true);


--
-- TOC entry 3546 (class 0 OID 0)
-- Dependencies: 223
-- Name: loan_type_loan_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.loan_type_loan_type_id_seq', 4, true);


--
-- TOC entry 3547 (class 0 OID 0)
-- Dependencies: 211
-- Name: passport_passport_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.passport_passport_id_seq', 22, true);


--
-- TOC entry 3548 (class 0 OID 0)
-- Dependencies: 231
-- Name: position_position_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.position_position_id_seq', 3, true);


--
-- TOC entry 3315 (class 2606 OID 24662)
-- Name: client client_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT client_pkey PRIMARY KEY (client_id);


--
-- TOC entry 3321 (class 2606 OID 24699)
-- Name: currency currency_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.currency
    ADD CONSTRAINT currency_pkey PRIMARY KEY (currency_code);


--
-- TOC entry 3323 (class 2606 OID 24711)
-- Name: currency_rate currency_rate_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.currency_rate
    ADD CONSTRAINT currency_rate_pkey PRIMARY KEY (rate_id);


--
-- TOC entry 3325 (class 2606 OID 24730)
-- Name: deposit deposit_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.deposit
    ADD CONSTRAINT deposit_pkey PRIMARY KEY (deposit_id);


--
-- TOC entry 3327 (class 2606 OID 24766)
-- Name: deposit_schedule deposit_schedule_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.deposit_schedule
    ADD CONSTRAINT deposit_schedule_pkey PRIMARY KEY (schedule_id);


--
-- TOC entry 3319 (class 2606 OID 24691)
-- Name: deposit_type deposit_type_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.deposit_type
    ADD CONSTRAINT deposit_type_pkey PRIMARY KEY (deposit_type_id);


--
-- TOC entry 3335 (class 2606 OID 24846)
-- Name: employee employee_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.employee
    ADD CONSTRAINT employee_pkey PRIMARY KEY (employee_id);


--
-- TOC entry 3339 (class 2606 OID 24866)
-- Name: employee_position employee_position_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.employee_position
    ADD CONSTRAINT employee_position_pkey PRIMARY KEY (id);


--
-- TOC entry 3331 (class 2606 OID 24799)
-- Name: loan loan_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.loan
    ADD CONSTRAINT loan_pkey PRIMARY KEY (loan_id);


--
-- TOC entry 3333 (class 2606 OID 24827)
-- Name: loan_schedule loan_schedule_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.loan_schedule
    ADD CONSTRAINT loan_schedule_pkey PRIMARY KEY (schedule_id);


--
-- TOC entry 3329 (class 2606 OID 24782)
-- Name: loan_type loan_type_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.loan_type
    ADD CONSTRAINT loan_type_pkey PRIMARY KEY (loan_type_id);


--
-- TOC entry 3317 (class 2606 OID 24673)
-- Name: passport passport_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.passport
    ADD CONSTRAINT passport_pkey PRIMARY KEY (passport_id);


--
-- TOC entry 3337 (class 2606 OID 24858)
-- Name: position position_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."position"
    ADD CONSTRAINT position_pkey PRIMARY KEY (position_id);


--
-- TOC entry 3352 (class 2620 OID 24747)
-- Name: deposit trg_deposit_min_amount; Type: TRIGGER; Schema: public; Owner: admin
--

CREATE TRIGGER trg_deposit_min_amount BEFORE INSERT OR UPDATE ON public.deposit FOR EACH ROW EXECUTE FUNCTION public.validate_deposit_min_amount();


--
-- TOC entry 3341 (class 2606 OID 24712)
-- Name: currency_rate currency_rate_currency_code_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.currency_rate
    ADD CONSTRAINT currency_rate_currency_code_fkey FOREIGN KEY (currency_code) REFERENCES public.currency(currency_code);


--
-- TOC entry 3344 (class 2606 OID 24741)
-- Name: deposit deposit_currency_code_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.deposit
    ADD CONSTRAINT deposit_currency_code_fkey FOREIGN KEY (currency_code) REFERENCES public.currency(currency_code);


--
-- TOC entry 3343 (class 2606 OID 24736)
-- Name: deposit deposit_deposit_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.deposit
    ADD CONSTRAINT deposit_deposit_type_id_fkey FOREIGN KEY (deposit_type_id) REFERENCES public.deposit_type(deposit_type_id);


--
-- TOC entry 3342 (class 2606 OID 24731)
-- Name: deposit deposit_passport_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.deposit
    ADD CONSTRAINT deposit_passport_id_fkey FOREIGN KEY (passport_id) REFERENCES public.passport(passport_id);


--
-- TOC entry 3345 (class 2606 OID 24767)
-- Name: deposit_schedule deposit_schedule_deposit_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.deposit_schedule
    ADD CONSTRAINT deposit_schedule_deposit_id_fkey FOREIGN KEY (deposit_id) REFERENCES public.deposit(deposit_id);


--
-- TOC entry 3350 (class 2606 OID 24867)
-- Name: employee_position employee_position_employee_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.employee_position
    ADD CONSTRAINT employee_position_employee_id_fkey FOREIGN KEY (employee_id) REFERENCES public.employee(employee_id);


--
-- TOC entry 3351 (class 2606 OID 24872)
-- Name: employee_position employee_position_position_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.employee_position
    ADD CONSTRAINT employee_position_position_id_fkey FOREIGN KEY (position_id) REFERENCES public."position"(position_id);


--
-- TOC entry 3347 (class 2606 OID 24805)
-- Name: loan loan_currency_code_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.loan
    ADD CONSTRAINT loan_currency_code_fkey FOREIGN KEY (currency_code) REFERENCES public.currency(currency_code);


--
-- TOC entry 3346 (class 2606 OID 24800)
-- Name: loan loan_loan_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.loan
    ADD CONSTRAINT loan_loan_type_id_fkey FOREIGN KEY (loan_type_id) REFERENCES public.loan_type(loan_type_id);


--
-- TOC entry 3348 (class 2606 OID 24810)
-- Name: loan loan_passport_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.loan
    ADD CONSTRAINT loan_passport_id_fkey FOREIGN KEY (passport_id) REFERENCES public.passport(passport_id);


--
-- TOC entry 3349 (class 2606 OID 24828)
-- Name: loan_schedule loan_schedule_loan_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.loan_schedule
    ADD CONSTRAINT loan_schedule_loan_id_fkey FOREIGN KEY (loan_id) REFERENCES public.loan(loan_id);


--
-- TOC entry 3340 (class 2606 OID 24674)
-- Name: passport passport_client_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.passport
    ADD CONSTRAINT passport_client_id_fkey FOREIGN KEY (client_id) REFERENCES public.client(client_id);


-- Completed on 2025-03-24 12:57:01 UTC

--
-- PostgreSQL database dump complete
--

