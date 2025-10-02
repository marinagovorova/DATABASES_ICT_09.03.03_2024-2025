--
-- PostgreSQL database dump
--

-- Dumped from database version 16.8
-- Dumped by pg_dump version 17.0

-- Started on 2025-06-17 09:15:36 MSK

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
-- TOC entry 6 (class 2615 OID 16399)
-- Name: lab3_schema; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA lab3_schema;


ALTER SCHEMA lab3_schema OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 249 (class 1259 OID 16684)
-- Name: completion_certificate; Type: TABLE; Schema: lab3_schema; Owner: postgres
--

CREATE TABLE lab3_schema.completion_certificate (
    certificate_id integer NOT NULL,
    contract_id integer,
    certificate_date date,
    status character varying(20)
);


ALTER TABLE lab3_schema.completion_certificate OWNER TO postgres;

--
-- TOC entry 248 (class 1259 OID 16683)
-- Name: completion_certificate_certificate_id_seq; Type: SEQUENCE; Schema: lab3_schema; Owner: postgres
--

CREATE SEQUENCE lab3_schema.completion_certificate_certificate_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE lab3_schema.completion_certificate_certificate_id_seq OWNER TO postgres;

--
-- TOC entry 3799 (class 0 OID 0)
-- Dependencies: 248
-- Name: completion_certificate_certificate_id_seq; Type: SEQUENCE OWNED BY; Schema: lab3_schema; Owner: postgres
--

ALTER SEQUENCE lab3_schema.completion_certificate_certificate_id_seq OWNED BY lab3_schema.completion_certificate.certificate_id;


--
-- TOC entry 227 (class 1259 OID 16497)
-- Name: contract; Type: TABLE; Schema: lab3_schema; Owner: postgres
--

CREATE TABLE lab3_schema.contract (
    contract_id integer NOT NULL,
    contract_date date,
    prepayment integer,
    balance integer,
    organization_id integer,
    manager_id integer,
    CONSTRAINT contract_balance_check CHECK ((balance >= 0)),
    CONSTRAINT contract_prepayment_check CHECK ((prepayment >= 0))
);


ALTER TABLE lab3_schema.contract OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 16496)
-- Name: contract_contract_id_seq; Type: SEQUENCE; Schema: lab3_schema; Owner: postgres
--

CREATE SEQUENCE lab3_schema.contract_contract_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE lab3_schema.contract_contract_id_seq OWNER TO postgres;

--
-- TOC entry 3800 (class 0 OID 0)
-- Dependencies: 226
-- Name: contract_contract_id_seq; Type: SEQUENCE OWNED BY; Schema: lab3_schema; Owner: postgres
--

ALTER SEQUENCE lab3_schema.contract_contract_id_seq OWNED BY lab3_schema.contract.contract_id;


--
-- TOC entry 243 (class 1259 OID 16644)
-- Name: control_schedule; Type: TABLE; Schema: lab3_schema; Owner: postgres
--

CREATE TABLE lab3_schema.control_schedule (
    control_id integer NOT NULL,
    task_id integer,
    control_date date NOT NULL,
    completion_percent numeric,
    failure_reason character varying(255),
    CONSTRAINT control_schedule_completion_percent_check CHECK (((completion_percent >= (0)::numeric) AND (completion_percent <= (100)::numeric)))
);


ALTER TABLE lab3_schema.control_schedule OWNER TO postgres;

--
-- TOC entry 242 (class 1259 OID 16643)
-- Name: control_schedule_control_id_seq; Type: SEQUENCE; Schema: lab3_schema; Owner: postgres
--

CREATE SEQUENCE lab3_schema.control_schedule_control_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE lab3_schema.control_schedule_control_id_seq OWNER TO postgres;

--
-- TOC entry 3801 (class 0 OID 0)
-- Dependencies: 242
-- Name: control_schedule_control_id_seq; Type: SEQUENCE OWNED BY; Schema: lab3_schema; Owner: postgres
--

ALTER SEQUENCE lab3_schema.control_schedule_control_id_seq OWNED BY lab3_schema.control_schedule.control_id;


--
-- TOC entry 251 (class 1259 OID 16697)
-- Name: department; Type: TABLE; Schema: lab3_schema; Owner: postgres
--

CREATE TABLE lab3_schema.department (
    department_id integer NOT NULL,
    name character varying(100) NOT NULL,
    phone character varying(20)
);


ALTER TABLE lab3_schema.department OWNER TO postgres;

--
-- TOC entry 250 (class 1259 OID 16696)
-- Name: department_department_id_seq; Type: SEQUENCE; Schema: lab3_schema; Owner: postgres
--

CREATE SEQUENCE lab3_schema.department_department_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE lab3_schema.department_department_id_seq OWNER TO postgres;

--
-- TOC entry 3802 (class 0 OID 0)
-- Dependencies: 250
-- Name: department_department_id_seq; Type: SEQUENCE OWNED BY; Schema: lab3_schema; Owner: postgres
--

ALTER SEQUENCE lab3_schema.department_department_id_seq OWNED BY lab3_schema.department.department_id;


--
-- TOC entry 221 (class 1259 OID 16466)
-- Name: employee; Type: TABLE; Schema: lab3_schema; Owner: postgres
--

CREATE TABLE lab3_schema.employee (
    employee_id integer NOT NULL,
    last_name character varying(50) NOT NULL,
    first_name character varying(50) NOT NULL,
    middle_name character varying(50),
    department_id integer,
    salary numeric,
    internal_number integer,
    CONSTRAINT employee_salary_check CHECK ((salary > (0)::numeric))
);


ALTER TABLE lab3_schema.employee OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16465)
-- Name: employee_employee_id_seq; Type: SEQUENCE; Schema: lab3_schema; Owner: postgres
--

CREATE SEQUENCE lab3_schema.employee_employee_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE lab3_schema.employee_employee_id_seq OWNER TO postgres;

--
-- TOC entry 3803 (class 0 OID 0)
-- Dependencies: 220
-- Name: employee_employee_id_seq; Type: SEQUENCE OWNED BY; Schema: lab3_schema; Owner: postgres
--

ALTER SEQUENCE lab3_schema.employee_employee_id_seq OWNED BY lab3_schema.employee.employee_id;


--
-- TOC entry 247 (class 1259 OID 16666)
-- Name: invoice; Type: TABLE; Schema: lab3_schema; Owner: postgres
--

CREATE TABLE lab3_schema.invoice (
    invoice_id integer NOT NULL,
    contract_id integer,
    invoice_type_id integer,
    amount integer,
    invoice_date date NOT NULL,
    CONSTRAINT invoice_amount_check CHECK ((amount >= 0))
);


ALTER TABLE lab3_schema.invoice OWNER TO postgres;

--
-- TOC entry 246 (class 1259 OID 16665)
-- Name: invoice_invoice_id_seq; Type: SEQUENCE; Schema: lab3_schema; Owner: postgres
--

CREATE SEQUENCE lab3_schema.invoice_invoice_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE lab3_schema.invoice_invoice_id_seq OWNER TO postgres;

--
-- TOC entry 3804 (class 0 OID 0)
-- Dependencies: 246
-- Name: invoice_invoice_id_seq; Type: SEQUENCE OWNED BY; Schema: lab3_schema; Owner: postgres
--

ALTER SEQUENCE lab3_schema.invoice_invoice_id_seq OWNED BY lab3_schema.invoice.invoice_id;


--
-- TOC entry 245 (class 1259 OID 16659)
-- Name: invoice_type; Type: TABLE; Schema: lab3_schema; Owner: postgres
--

CREATE TABLE lab3_schema.invoice_type (
    invoice_type_id integer NOT NULL,
    name character varying(20)
);


ALTER TABLE lab3_schema.invoice_type OWNER TO postgres;

--
-- TOC entry 244 (class 1259 OID 16658)
-- Name: invoice_type_invoice_type_id_seq; Type: SEQUENCE; Schema: lab3_schema; Owner: postgres
--

CREATE SEQUENCE lab3_schema.invoice_type_invoice_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE lab3_schema.invoice_type_invoice_type_id_seq OWNER TO postgres;

--
-- TOC entry 3805 (class 0 OID 0)
-- Dependencies: 244
-- Name: invoice_type_invoice_type_id_seq; Type: SEQUENCE OWNED BY; Schema: lab3_schema; Owner: postgres
--

ALTER SEQUENCE lab3_schema.invoice_type_invoice_type_id_seq OWNED BY lab3_schema.invoice_type.invoice_type_id;


--
-- TOC entry 217 (class 1259 OID 16445)
-- Name: organization; Type: TABLE; Schema: lab3_schema; Owner: postgres
--

CREATE TABLE lab3_schema.organization (
    organization_id integer NOT NULL,
    name character varying(100) NOT NULL,
    address character varying(200),
    contact_person character varying(50),
    phone character varying(20)
);


ALTER TABLE lab3_schema.organization OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 16444)
-- Name: organization_organization_id_seq; Type: SEQUENCE; Schema: lab3_schema; Owner: postgres
--

CREATE SEQUENCE lab3_schema.organization_organization_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE lab3_schema.organization_organization_id_seq OWNER TO postgres;

--
-- TOC entry 3806 (class 0 OID 0)
-- Dependencies: 216
-- Name: organization_organization_id_seq; Type: SEQUENCE OWNED BY; Schema: lab3_schema; Owner: postgres
--

ALTER SEQUENCE lab3_schema.organization_organization_id_seq OWNED BY lab3_schema.organization.organization_id;


--
-- TOC entry 219 (class 1259 OID 16459)
-- Name: position; Type: TABLE; Schema: lab3_schema; Owner: postgres
--

CREATE TABLE lab3_schema."position" (
    position_id integer NOT NULL,
    title character varying(100) NOT NULL
);


ALTER TABLE lab3_schema."position" OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 16563)
-- Name: position_history; Type: TABLE; Schema: lab3_schema; Owner: postgres
--

CREATE TABLE lab3_schema.position_history (
    history_id integer NOT NULL,
    position_id integer,
    employee_id integer,
    start_date date,
    end_date date
);


ALTER TABLE lab3_schema.position_history OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 16562)
-- Name: position_history_history_id_seq; Type: SEQUENCE; Schema: lab3_schema; Owner: postgres
--

CREATE SEQUENCE lab3_schema.position_history_history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE lab3_schema.position_history_history_id_seq OWNER TO postgres;

--
-- TOC entry 3807 (class 0 OID 0)
-- Dependencies: 232
-- Name: position_history_history_id_seq; Type: SEQUENCE OWNED BY; Schema: lab3_schema; Owner: postgres
--

ALTER SEQUENCE lab3_schema.position_history_history_id_seq OWNED BY lab3_schema.position_history.history_id;


--
-- TOC entry 218 (class 1259 OID 16458)
-- Name: position_position_id_seq; Type: SEQUENCE; Schema: lab3_schema; Owner: postgres
--

CREATE SEQUENCE lab3_schema.position_position_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE lab3_schema.position_position_id_seq OWNER TO postgres;

--
-- TOC entry 3808 (class 0 OID 0)
-- Dependencies: 218
-- Name: position_position_id_seq; Type: SEQUENCE OWNED BY; Schema: lab3_schema; Owner: postgres
--

ALTER SEQUENCE lab3_schema.position_position_id_seq OWNED BY lab3_schema."position".position_id;


--
-- TOC entry 229 (class 1259 OID 16516)
-- Name: project; Type: TABLE; Schema: lab3_schema; Owner: postgres
--

CREATE TABLE lab3_schema.project (
    project_id integer NOT NULL,
    name character varying(100) NOT NULL,
    start_date date,
    end_date date,
    manager_id integer,
    contract_id integer,
    status_id integer,
    organization_id integer,
    payment_status character varying(20),
    CONSTRAINT project_check CHECK ((end_date >= start_date)),
    CONSTRAINT project_start_date_check CHECK ((start_date >= CURRENT_DATE))
);


ALTER TABLE lab3_schema.project OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 16594)
-- Name: project_participation; Type: TABLE; Schema: lab3_schema; Owner: postgres
--

CREATE TABLE lab3_schema.project_participation (
    participation_id integer NOT NULL,
    employee_id integer,
    project_id integer,
    start_date date,
    end_date date,
    role_id integer,
    reward_type_id integer,
    reward_amount numeric,
    CONSTRAINT project_participation_reward_amount_check CHECK ((reward_amount >= (0)::numeric))
);


ALTER TABLE lab3_schema.project_participation OWNER TO postgres;

--
-- TOC entry 238 (class 1259 OID 16593)
-- Name: project_participation_participation_id_seq; Type: SEQUENCE; Schema: lab3_schema; Owner: postgres
--

CREATE SEQUENCE lab3_schema.project_participation_participation_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE lab3_schema.project_participation_participation_id_seq OWNER TO postgres;

--
-- TOC entry 3809 (class 0 OID 0)
-- Dependencies: 238
-- Name: project_participation_participation_id_seq; Type: SEQUENCE OWNED BY; Schema: lab3_schema; Owner: postgres
--

ALTER SEQUENCE lab3_schema.project_participation_participation_id_seq OWNED BY lab3_schema.project_participation.participation_id;


--
-- TOC entry 228 (class 1259 OID 16515)
-- Name: project_project_id_seq; Type: SEQUENCE; Schema: lab3_schema; Owner: postgres
--

CREATE SEQUENCE lab3_schema.project_project_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE lab3_schema.project_project_id_seq OWNER TO postgres;

--
-- TOC entry 3810 (class 0 OID 0)
-- Dependencies: 228
-- Name: project_project_id_seq; Type: SEQUENCE OWNED BY; Schema: lab3_schema; Owner: postgres
--

ALTER SEQUENCE lab3_schema.project_project_id_seq OWNED BY lab3_schema.project.project_id;


--
-- TOC entry 237 (class 1259 OID 16587)
-- Name: project_role; Type: TABLE; Schema: lab3_schema; Owner: postgres
--

CREATE TABLE lab3_schema.project_role (
    role_id integer NOT NULL,
    name character varying(20)
);


ALTER TABLE lab3_schema.project_role OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 16586)
-- Name: project_role_role_id_seq; Type: SEQUENCE; Schema: lab3_schema; Owner: postgres
--

CREATE SEQUENCE lab3_schema.project_role_role_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE lab3_schema.project_role_role_id_seq OWNER TO postgres;

--
-- TOC entry 3811 (class 0 OID 0)
-- Dependencies: 236
-- Name: project_role_role_id_seq; Type: SEQUENCE OWNED BY; Schema: lab3_schema; Owner: postgres
--

ALTER SEQUENCE lab3_schema.project_role_role_id_seq OWNED BY lab3_schema.project_role.role_id;


--
-- TOC entry 223 (class 1259 OID 16483)
-- Name: project_status; Type: TABLE; Schema: lab3_schema; Owner: postgres
--

CREATE TABLE lab3_schema.project_status (
    status_id integer NOT NULL,
    name character varying(20) NOT NULL
);


ALTER TABLE lab3_schema.project_status OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16482)
-- Name: project_status_status_id_seq; Type: SEQUENCE; Schema: lab3_schema; Owner: postgres
--

CREATE SEQUENCE lab3_schema.project_status_status_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE lab3_schema.project_status_status_id_seq OWNER TO postgres;

--
-- TOC entry 3812 (class 0 OID 0)
-- Dependencies: 222
-- Name: project_status_status_id_seq; Type: SEQUENCE OWNED BY; Schema: lab3_schema; Owner: postgres
--

ALTER SEQUENCE lab3_schema.project_status_status_id_seq OWNED BY lab3_schema.project_status.status_id;


--
-- TOC entry 235 (class 1259 OID 16580)
-- Name: reward_type; Type: TABLE; Schema: lab3_schema; Owner: postgres
--

CREATE TABLE lab3_schema.reward_type (
    reward_type_id integer NOT NULL,
    name character varying(20)
);


ALTER TABLE lab3_schema.reward_type OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 16579)
-- Name: reward_type_reward_type_id_seq; Type: SEQUENCE; Schema: lab3_schema; Owner: postgres
--

CREATE SEQUENCE lab3_schema.reward_type_reward_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE lab3_schema.reward_type_reward_type_id_seq OWNER TO postgres;

--
-- TOC entry 3813 (class 0 OID 0)
-- Dependencies: 234
-- Name: reward_type_reward_type_id_seq; Type: SEQUENCE OWNED BY; Schema: lab3_schema; Owner: postgres
--

ALTER SEQUENCE lab3_schema.reward_type_reward_type_id_seq OWNED BY lab3_schema.reward_type.reward_type_id;


--
-- TOC entry 231 (class 1259 OID 16545)
-- Name: task; Type: TABLE; Schema: lab3_schema; Owner: postgres
--

CREATE TABLE lab3_schema.task (
    task_id integer NOT NULL,
    project_id integer,
    start_date date,
    deadline date,
    status character varying(20),
    cost integer,
    status_id integer,
    CONSTRAINT task_cost_check CHECK ((cost > 0))
);


ALTER TABLE lab3_schema.task OWNER TO postgres;

--
-- TOC entry 241 (class 1259 OID 16624)
-- Name: task_participation; Type: TABLE; Schema: lab3_schema; Owner: postgres
--

CREATE TABLE lab3_schema.task_participation (
    participation_id integer NOT NULL,
    employee_id integer,
    task_id integer,
    start_date date,
    end_date date,
    completion_percent numeric,
    failure_reason character varying(255),
    CONSTRAINT task_participation_completion_percent_check CHECK (((completion_percent >= (0)::numeric) AND (completion_percent <= (100)::numeric)))
);


ALTER TABLE lab3_schema.task_participation OWNER TO postgres;

--
-- TOC entry 240 (class 1259 OID 16623)
-- Name: task_participation_participation_id_seq; Type: SEQUENCE; Schema: lab3_schema; Owner: postgres
--

CREATE SEQUENCE lab3_schema.task_participation_participation_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE lab3_schema.task_participation_participation_id_seq OWNER TO postgres;

--
-- TOC entry 3814 (class 0 OID 0)
-- Dependencies: 240
-- Name: task_participation_participation_id_seq; Type: SEQUENCE OWNED BY; Schema: lab3_schema; Owner: postgres
--

ALTER SEQUENCE lab3_schema.task_participation_participation_id_seq OWNED BY lab3_schema.task_participation.participation_id;


--
-- TOC entry 225 (class 1259 OID 16490)
-- Name: task_status; Type: TABLE; Schema: lab3_schema; Owner: postgres
--

CREATE TABLE lab3_schema.task_status (
    status_id integer NOT NULL,
    name character varying(20) NOT NULL
);


ALTER TABLE lab3_schema.task_status OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 16489)
-- Name: task_status_status_id_seq; Type: SEQUENCE; Schema: lab3_schema; Owner: postgres
--

CREATE SEQUENCE lab3_schema.task_status_status_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE lab3_schema.task_status_status_id_seq OWNER TO postgres;

--
-- TOC entry 3815 (class 0 OID 0)
-- Dependencies: 224
-- Name: task_status_status_id_seq; Type: SEQUENCE OWNED BY; Schema: lab3_schema; Owner: postgres
--

ALTER SEQUENCE lab3_schema.task_status_status_id_seq OWNED BY lab3_schema.task_status.status_id;


--
-- TOC entry 230 (class 1259 OID 16544)
-- Name: task_task_id_seq; Type: SEQUENCE; Schema: lab3_schema; Owner: postgres
--

CREATE SEQUENCE lab3_schema.task_task_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE lab3_schema.task_task_id_seq OWNER TO postgres;

--
-- TOC entry 3816 (class 0 OID 0)
-- Dependencies: 230
-- Name: task_task_id_seq; Type: SEQUENCE OWNED BY; Schema: lab3_schema; Owner: postgres
--

ALTER SEQUENCE lab3_schema.task_task_id_seq OWNED BY lab3_schema.task.task_id;


--
-- TOC entry 3545 (class 2604 OID 16687)
-- Name: completion_certificate certificate_id; Type: DEFAULT; Schema: lab3_schema; Owner: postgres
--

ALTER TABLE ONLY lab3_schema.completion_certificate ALTER COLUMN certificate_id SET DEFAULT nextval('lab3_schema.completion_certificate_certificate_id_seq'::regclass);


--
-- TOC entry 3534 (class 2604 OID 16500)
-- Name: contract contract_id; Type: DEFAULT; Schema: lab3_schema; Owner: postgres
--

ALTER TABLE ONLY lab3_schema.contract ALTER COLUMN contract_id SET DEFAULT nextval('lab3_schema.contract_contract_id_seq'::regclass);


--
-- TOC entry 3542 (class 2604 OID 16647)
-- Name: control_schedule control_id; Type: DEFAULT; Schema: lab3_schema; Owner: postgres
--

ALTER TABLE ONLY lab3_schema.control_schedule ALTER COLUMN control_id SET DEFAULT nextval('lab3_schema.control_schedule_control_id_seq'::regclass);


--
-- TOC entry 3546 (class 2604 OID 16700)
-- Name: department department_id; Type: DEFAULT; Schema: lab3_schema; Owner: postgres
--

ALTER TABLE ONLY lab3_schema.department ALTER COLUMN department_id SET DEFAULT nextval('lab3_schema.department_department_id_seq'::regclass);


--
-- TOC entry 3531 (class 2604 OID 16469)
-- Name: employee employee_id; Type: DEFAULT; Schema: lab3_schema; Owner: postgres
--

ALTER TABLE ONLY lab3_schema.employee ALTER COLUMN employee_id SET DEFAULT nextval('lab3_schema.employee_employee_id_seq'::regclass);


--
-- TOC entry 3544 (class 2604 OID 16669)
-- Name: invoice invoice_id; Type: DEFAULT; Schema: lab3_schema; Owner: postgres
--

ALTER TABLE ONLY lab3_schema.invoice ALTER COLUMN invoice_id SET DEFAULT nextval('lab3_schema.invoice_invoice_id_seq'::regclass);


--
-- TOC entry 3543 (class 2604 OID 16662)
-- Name: invoice_type invoice_type_id; Type: DEFAULT; Schema: lab3_schema; Owner: postgres
--

ALTER TABLE ONLY lab3_schema.invoice_type ALTER COLUMN invoice_type_id SET DEFAULT nextval('lab3_schema.invoice_type_invoice_type_id_seq'::regclass);


--
-- TOC entry 3529 (class 2604 OID 16448)
-- Name: organization organization_id; Type: DEFAULT; Schema: lab3_schema; Owner: postgres
--

ALTER TABLE ONLY lab3_schema.organization ALTER COLUMN organization_id SET DEFAULT nextval('lab3_schema.organization_organization_id_seq'::regclass);


--
-- TOC entry 3530 (class 2604 OID 16462)
-- Name: position position_id; Type: DEFAULT; Schema: lab3_schema; Owner: postgres
--

ALTER TABLE ONLY lab3_schema."position" ALTER COLUMN position_id SET DEFAULT nextval('lab3_schema.position_position_id_seq'::regclass);


--
-- TOC entry 3537 (class 2604 OID 16566)
-- Name: position_history history_id; Type: DEFAULT; Schema: lab3_schema; Owner: postgres
--

ALTER TABLE ONLY lab3_schema.position_history ALTER COLUMN history_id SET DEFAULT nextval('lab3_schema.position_history_history_id_seq'::regclass);


--
-- TOC entry 3535 (class 2604 OID 16519)
-- Name: project project_id; Type: DEFAULT; Schema: lab3_schema; Owner: postgres
--

ALTER TABLE ONLY lab3_schema.project ALTER COLUMN project_id SET DEFAULT nextval('lab3_schema.project_project_id_seq'::regclass);


--
-- TOC entry 3540 (class 2604 OID 16597)
-- Name: project_participation participation_id; Type: DEFAULT; Schema: lab3_schema; Owner: postgres
--

ALTER TABLE ONLY lab3_schema.project_participation ALTER COLUMN participation_id SET DEFAULT nextval('lab3_schema.project_participation_participation_id_seq'::regclass);


--
-- TOC entry 3539 (class 2604 OID 16590)
-- Name: project_role role_id; Type: DEFAULT; Schema: lab3_schema; Owner: postgres
--

ALTER TABLE ONLY lab3_schema.project_role ALTER COLUMN role_id SET DEFAULT nextval('lab3_schema.project_role_role_id_seq'::regclass);


--
-- TOC entry 3532 (class 2604 OID 16486)
-- Name: project_status status_id; Type: DEFAULT; Schema: lab3_schema; Owner: postgres
--

ALTER TABLE ONLY lab3_schema.project_status ALTER COLUMN status_id SET DEFAULT nextval('lab3_schema.project_status_status_id_seq'::regclass);


--
-- TOC entry 3538 (class 2604 OID 16583)
-- Name: reward_type reward_type_id; Type: DEFAULT; Schema: lab3_schema; Owner: postgres
--

ALTER TABLE ONLY lab3_schema.reward_type ALTER COLUMN reward_type_id SET DEFAULT nextval('lab3_schema.reward_type_reward_type_id_seq'::regclass);


--
-- TOC entry 3536 (class 2604 OID 16548)
-- Name: task task_id; Type: DEFAULT; Schema: lab3_schema; Owner: postgres
--

ALTER TABLE ONLY lab3_schema.task ALTER COLUMN task_id SET DEFAULT nextval('lab3_schema.task_task_id_seq'::regclass);


--
-- TOC entry 3541 (class 2604 OID 16627)
-- Name: task_participation participation_id; Type: DEFAULT; Schema: lab3_schema; Owner: postgres
--

ALTER TABLE ONLY lab3_schema.task_participation ALTER COLUMN participation_id SET DEFAULT nextval('lab3_schema.task_participation_participation_id_seq'::regclass);


--
-- TOC entry 3533 (class 2604 OID 16493)
-- Name: task_status status_id; Type: DEFAULT; Schema: lab3_schema; Owner: postgres
--

ALTER TABLE ONLY lab3_schema.task_status ALTER COLUMN status_id SET DEFAULT nextval('lab3_schema.task_status_status_id_seq'::regclass);


--
-- TOC entry 3791 (class 0 OID 16684)
-- Dependencies: 249
-- Data for Name: completion_certificate; Type: TABLE DATA; Schema: lab3_schema; Owner: postgres
--

COPY lab3_schema.completion_certificate (certificate_id, contract_id, certificate_date, status) FROM stdin;
1	1	2025-12-26	подписан
\.


--
-- TOC entry 3769 (class 0 OID 16497)
-- Dependencies: 227
-- Data for Name: contract; Type: TABLE DATA; Schema: lab3_schema; Owner: postgres
--

COPY lab3_schema.contract (contract_id, contract_date, prepayment, balance, organization_id, manager_id) FROM stdin;
1	2025-06-16	50000	100000	1	1
\.


--
-- TOC entry 3785 (class 0 OID 16644)
-- Dependencies: 243
-- Data for Name: control_schedule; Type: TABLE DATA; Schema: lab3_schema; Owner: postgres
--

COPY lab3_schema.control_schedule (control_id, task_id, control_date, completion_percent, failure_reason) FROM stdin;
1	2	2025-08-06	50	отпуск
2	2	2025-08-21	70	болезнь
\.


--
-- TOC entry 3793 (class 0 OID 16697)
-- Dependencies: 251
-- Data for Name: department; Type: TABLE DATA; Schema: lab3_schema; Owner: postgres
--

COPY lab3_schema.department (department_id, name, phone) FROM stdin;
1	Отдел разработки	111-111
2	Отдел аналитики	222-222
\.


--
-- TOC entry 3763 (class 0 OID 16466)
-- Dependencies: 221
-- Data for Name: employee; Type: TABLE DATA; Schema: lab3_schema; Owner: postgres
--

COPY lab3_schema.employee (employee_id, last_name, first_name, middle_name, department_id, salary, internal_number) FROM stdin;
1	Иванов	Иван	Иванович	1	60000	1001
2	Петров	Пётр	Петрович	2	55000	1002
\.


--
-- TOC entry 3789 (class 0 OID 16666)
-- Dependencies: 247
-- Data for Name: invoice; Type: TABLE DATA; Schema: lab3_schema; Owner: postgres
--

COPY lab3_schema.invoice (invoice_id, contract_id, invoice_type_id, amount, invoice_date) FROM stdin;
1	1	1	50000	2025-06-16
2	1	2	100000	2025-12-31
\.


--
-- TOC entry 3787 (class 0 OID 16659)
-- Dependencies: 245
-- Data for Name: invoice_type; Type: TABLE DATA; Schema: lab3_schema; Owner: postgres
--

COPY lab3_schema.invoice_type (invoice_type_id, name) FROM stdin;
1	Предоплата
2	Остаток
\.


--
-- TOC entry 3759 (class 0 OID 16445)
-- Dependencies: 217
-- Data for Name: organization; Type: TABLE DATA; Schema: lab3_schema; Owner: postgres
--

COPY lab3_schema.organization (organization_id, name, address, contact_person, phone) FROM stdin;
1	ООО Альфа	г. Москва, ул. Примерная, 1	Сидоров С.С.	89998887766
\.


--
-- TOC entry 3761 (class 0 OID 16459)
-- Dependencies: 219
-- Data for Name: position; Type: TABLE DATA; Schema: lab3_schema; Owner: postgres
--

COPY lab3_schema."position" (position_id, title) FROM stdin;
1	Разработчик
2	Аналитик
\.


--
-- TOC entry 3775 (class 0 OID 16563)
-- Dependencies: 233
-- Data for Name: position_history; Type: TABLE DATA; Schema: lab3_schema; Owner: postgres
--

COPY lab3_schema.position_history (history_id, position_id, employee_id, start_date, end_date) FROM stdin;
1	1	1	2025-06-16	\N
2	2	2	2025-06-16	\N
\.


--
-- TOC entry 3771 (class 0 OID 16516)
-- Dependencies: 229
-- Data for Name: project; Type: TABLE DATA; Schema: lab3_schema; Owner: postgres
--

COPY lab3_schema.project (project_id, name, start_date, end_date, manager_id, contract_id, status_id, organization_id, payment_status) FROM stdin;
1	Проект А	2025-06-23	2025-12-31	1	1	1	1	оплачено
\.


--
-- TOC entry 3781 (class 0 OID 16594)
-- Dependencies: 239
-- Data for Name: project_participation; Type: TABLE DATA; Schema: lab3_schema; Owner: postgres
--

COPY lab3_schema.project_participation (participation_id, employee_id, project_id, start_date, end_date, role_id, reward_type_id, reward_amount) FROM stdin;
1	1	1	2025-06-16	\N	2	2	150000
2	2	1	2025-06-17	\N	1	1	50000
\.


--
-- TOC entry 3779 (class 0 OID 16587)
-- Dependencies: 237
-- Data for Name: project_role; Type: TABLE DATA; Schema: lab3_schema; Owner: postgres
--

COPY lab3_schema.project_role (role_id, name) FROM stdin;
1	Исполнитель
2	Руководитель
\.


--
-- TOC entry 3765 (class 0 OID 16483)
-- Dependencies: 223
-- Data for Name: project_status; Type: TABLE DATA; Schema: lab3_schema; Owner: postgres
--

COPY lab3_schema.project_status (status_id, name) FROM stdin;
1	в работе
2	завершён
\.


--
-- TOC entry 3777 (class 0 OID 16580)
-- Dependencies: 235
-- Data for Name: reward_type; Type: TABLE DATA; Schema: lab3_schema; Owner: postgres
--

COPY lab3_schema.reward_type (reward_type_id, name) FROM stdin;
1	Разовая
2	Ежемесячная
\.


--
-- TOC entry 3773 (class 0 OID 16545)
-- Dependencies: 231
-- Data for Name: task; Type: TABLE DATA; Schema: lab3_schema; Owner: postgres
--

COPY lab3_schema.task (task_id, project_id, start_date, deadline, status, cost, status_id) FROM stdin;
1	1	2025-06-17	2025-07-17	выполнено	20000	1
2	1	2025-07-22	2025-08-21	не выполнено	30000	2
\.


--
-- TOC entry 3783 (class 0 OID 16624)
-- Dependencies: 241
-- Data for Name: task_participation; Type: TABLE DATA; Schema: lab3_schema; Owner: postgres
--

COPY lab3_schema.task_participation (participation_id, employee_id, task_id, start_date, end_date, completion_percent, failure_reason) FROM stdin;
1	2	1	2025-06-17	2025-07-17	100	\N
2	2	2	2025-07-22	2025-08-21	70	болезнь
\.


--
-- TOC entry 3767 (class 0 OID 16490)
-- Dependencies: 225
-- Data for Name: task_status; Type: TABLE DATA; Schema: lab3_schema; Owner: postgres
--

COPY lab3_schema.task_status (status_id, name) FROM stdin;
1	выполнено
2	не выполнено
\.


--
-- TOC entry 3817 (class 0 OID 0)
-- Dependencies: 248
-- Name: completion_certificate_certificate_id_seq; Type: SEQUENCE SET; Schema: lab3_schema; Owner: postgres
--

SELECT pg_catalog.setval('lab3_schema.completion_certificate_certificate_id_seq', 1, false);


--
-- TOC entry 3818 (class 0 OID 0)
-- Dependencies: 226
-- Name: contract_contract_id_seq; Type: SEQUENCE SET; Schema: lab3_schema; Owner: postgres
--

SELECT pg_catalog.setval('lab3_schema.contract_contract_id_seq', 1, true);


--
-- TOC entry 3819 (class 0 OID 0)
-- Dependencies: 242
-- Name: control_schedule_control_id_seq; Type: SEQUENCE SET; Schema: lab3_schema; Owner: postgres
--

SELECT pg_catalog.setval('lab3_schema.control_schedule_control_id_seq', 1, false);


--
-- TOC entry 3820 (class 0 OID 0)
-- Dependencies: 250
-- Name: department_department_id_seq; Type: SEQUENCE SET; Schema: lab3_schema; Owner: postgres
--

SELECT pg_catalog.setval('lab3_schema.department_department_id_seq', 8, true);


--
-- TOC entry 3821 (class 0 OID 0)
-- Dependencies: 220
-- Name: employee_employee_id_seq; Type: SEQUENCE SET; Schema: lab3_schema; Owner: postgres
--

SELECT pg_catalog.setval('lab3_schema.employee_employee_id_seq', 20, true);


--
-- TOC entry 3822 (class 0 OID 0)
-- Dependencies: 246
-- Name: invoice_invoice_id_seq; Type: SEQUENCE SET; Schema: lab3_schema; Owner: postgres
--

SELECT pg_catalog.setval('lab3_schema.invoice_invoice_id_seq', 1, false);


--
-- TOC entry 3823 (class 0 OID 0)
-- Dependencies: 244
-- Name: invoice_type_invoice_type_id_seq; Type: SEQUENCE SET; Schema: lab3_schema; Owner: postgres
--

SELECT pg_catalog.setval('lab3_schema.invoice_type_invoice_type_id_seq', 1, false);


--
-- TOC entry 3824 (class 0 OID 0)
-- Dependencies: 216
-- Name: organization_organization_id_seq; Type: SEQUENCE SET; Schema: lab3_schema; Owner: postgres
--

SELECT pg_catalog.setval('lab3_schema.organization_organization_id_seq', 1, true);


--
-- TOC entry 3825 (class 0 OID 0)
-- Dependencies: 232
-- Name: position_history_history_id_seq; Type: SEQUENCE SET; Schema: lab3_schema; Owner: postgres
--

SELECT pg_catalog.setval('lab3_schema.position_history_history_id_seq', 2, true);


--
-- TOC entry 3826 (class 0 OID 0)
-- Dependencies: 218
-- Name: position_position_id_seq; Type: SEQUENCE SET; Schema: lab3_schema; Owner: postgres
--

SELECT pg_catalog.setval('lab3_schema.position_position_id_seq', 20, true);


--
-- TOC entry 3827 (class 0 OID 0)
-- Dependencies: 238
-- Name: project_participation_participation_id_seq; Type: SEQUENCE SET; Schema: lab3_schema; Owner: postgres
--

SELECT pg_catalog.setval('lab3_schema.project_participation_participation_id_seq', 1, false);


--
-- TOC entry 3828 (class 0 OID 0)
-- Dependencies: 228
-- Name: project_project_id_seq; Type: SEQUENCE SET; Schema: lab3_schema; Owner: postgres
--

SELECT pg_catalog.setval('lab3_schema.project_project_id_seq', 1, true);


--
-- TOC entry 3829 (class 0 OID 0)
-- Dependencies: 236
-- Name: project_role_role_id_seq; Type: SEQUENCE SET; Schema: lab3_schema; Owner: postgres
--

SELECT pg_catalog.setval('lab3_schema.project_role_role_id_seq', 1, false);


--
-- TOC entry 3830 (class 0 OID 0)
-- Dependencies: 222
-- Name: project_status_status_id_seq; Type: SEQUENCE SET; Schema: lab3_schema; Owner: postgres
--

SELECT pg_catalog.setval('lab3_schema.project_status_status_id_seq', 2, true);


--
-- TOC entry 3831 (class 0 OID 0)
-- Dependencies: 234
-- Name: reward_type_reward_type_id_seq; Type: SEQUENCE SET; Schema: lab3_schema; Owner: postgres
--

SELECT pg_catalog.setval('lab3_schema.reward_type_reward_type_id_seq', 1, false);


--
-- TOC entry 3832 (class 0 OID 0)
-- Dependencies: 240
-- Name: task_participation_participation_id_seq; Type: SEQUENCE SET; Schema: lab3_schema; Owner: postgres
--

SELECT pg_catalog.setval('lab3_schema.task_participation_participation_id_seq', 1, false);


--
-- TOC entry 3833 (class 0 OID 0)
-- Dependencies: 224
-- Name: task_status_status_id_seq; Type: SEQUENCE SET; Schema: lab3_schema; Owner: postgres
--

SELECT pg_catalog.setval('lab3_schema.task_status_status_id_seq', 2, true);


--
-- TOC entry 3834 (class 0 OID 0)
-- Dependencies: 230
-- Name: task_task_id_seq; Type: SEQUENCE SET; Schema: lab3_schema; Owner: postgres
--

SELECT pg_catalog.setval('lab3_schema.task_task_id_seq', 1, false);


--
-- TOC entry 3592 (class 2606 OID 16689)
-- Name: completion_certificate completion_certificate_pkey; Type: CONSTRAINT; Schema: lab3_schema; Owner: postgres
--

ALTER TABLE ONLY lab3_schema.completion_certificate
    ADD CONSTRAINT completion_certificate_pkey PRIMARY KEY (certificate_id);


--
-- TOC entry 3570 (class 2606 OID 16504)
-- Name: contract contract_pkey; Type: CONSTRAINT; Schema: lab3_schema; Owner: postgres
--

ALTER TABLE ONLY lab3_schema.contract
    ADD CONSTRAINT contract_pkey PRIMARY KEY (contract_id);


--
-- TOC entry 3586 (class 2606 OID 16652)
-- Name: control_schedule control_schedule_pkey; Type: CONSTRAINT; Schema: lab3_schema; Owner: postgres
--

ALTER TABLE ONLY lab3_schema.control_schedule
    ADD CONSTRAINT control_schedule_pkey PRIMARY KEY (control_id);


--
-- TOC entry 3594 (class 2606 OID 16702)
-- Name: department department_pkey; Type: CONSTRAINT; Schema: lab3_schema; Owner: postgres
--

ALTER TABLE ONLY lab3_schema.department
    ADD CONSTRAINT department_pkey PRIMARY KEY (department_id);


--
-- TOC entry 3562 (class 2606 OID 16476)
-- Name: employee employee_internal_number_key; Type: CONSTRAINT; Schema: lab3_schema; Owner: postgres
--

ALTER TABLE ONLY lab3_schema.employee
    ADD CONSTRAINT employee_internal_number_key UNIQUE (internal_number);


--
-- TOC entry 3564 (class 2606 OID 16474)
-- Name: employee employee_pkey; Type: CONSTRAINT; Schema: lab3_schema; Owner: postgres
--

ALTER TABLE ONLY lab3_schema.employee
    ADD CONSTRAINT employee_pkey PRIMARY KEY (employee_id);


--
-- TOC entry 3590 (class 2606 OID 16672)
-- Name: invoice invoice_pkey; Type: CONSTRAINT; Schema: lab3_schema; Owner: postgres
--

ALTER TABLE ONLY lab3_schema.invoice
    ADD CONSTRAINT invoice_pkey PRIMARY KEY (invoice_id);


--
-- TOC entry 3588 (class 2606 OID 16664)
-- Name: invoice_type invoice_type_pkey; Type: CONSTRAINT; Schema: lab3_schema; Owner: postgres
--

ALTER TABLE ONLY lab3_schema.invoice_type
    ADD CONSTRAINT invoice_type_pkey PRIMARY KEY (invoice_type_id);


--
-- TOC entry 3558 (class 2606 OID 16450)
-- Name: organization organization_pkey; Type: CONSTRAINT; Schema: lab3_schema; Owner: postgres
--

ALTER TABLE ONLY lab3_schema.organization
    ADD CONSTRAINT organization_pkey PRIMARY KEY (organization_id);


--
-- TOC entry 3576 (class 2606 OID 16568)
-- Name: position_history position_history_pkey; Type: CONSTRAINT; Schema: lab3_schema; Owner: postgres
--

ALTER TABLE ONLY lab3_schema.position_history
    ADD CONSTRAINT position_history_pkey PRIMARY KEY (history_id);


--
-- TOC entry 3560 (class 2606 OID 16464)
-- Name: position position_pkey; Type: CONSTRAINT; Schema: lab3_schema; Owner: postgres
--

ALTER TABLE ONLY lab3_schema."position"
    ADD CONSTRAINT position_pkey PRIMARY KEY (position_id);


--
-- TOC entry 3582 (class 2606 OID 16602)
-- Name: project_participation project_participation_pkey; Type: CONSTRAINT; Schema: lab3_schema; Owner: postgres
--

ALTER TABLE ONLY lab3_schema.project_participation
    ADD CONSTRAINT project_participation_pkey PRIMARY KEY (participation_id);


--
-- TOC entry 3572 (class 2606 OID 16523)
-- Name: project project_pkey; Type: CONSTRAINT; Schema: lab3_schema; Owner: postgres
--

ALTER TABLE ONLY lab3_schema.project
    ADD CONSTRAINT project_pkey PRIMARY KEY (project_id);


--
-- TOC entry 3580 (class 2606 OID 16592)
-- Name: project_role project_role_pkey; Type: CONSTRAINT; Schema: lab3_schema; Owner: postgres
--

ALTER TABLE ONLY lab3_schema.project_role
    ADD CONSTRAINT project_role_pkey PRIMARY KEY (role_id);


--
-- TOC entry 3566 (class 2606 OID 16488)
-- Name: project_status project_status_pkey; Type: CONSTRAINT; Schema: lab3_schema; Owner: postgres
--

ALTER TABLE ONLY lab3_schema.project_status
    ADD CONSTRAINT project_status_pkey PRIMARY KEY (status_id);


--
-- TOC entry 3578 (class 2606 OID 16585)
-- Name: reward_type reward_type_pkey; Type: CONSTRAINT; Schema: lab3_schema; Owner: postgres
--

ALTER TABLE ONLY lab3_schema.reward_type
    ADD CONSTRAINT reward_type_pkey PRIMARY KEY (reward_type_id);


--
-- TOC entry 3584 (class 2606 OID 16632)
-- Name: task_participation task_participation_pkey; Type: CONSTRAINT; Schema: lab3_schema; Owner: postgres
--

ALTER TABLE ONLY lab3_schema.task_participation
    ADD CONSTRAINT task_participation_pkey PRIMARY KEY (participation_id);


--
-- TOC entry 3574 (class 2606 OID 16551)
-- Name: task task_pkey; Type: CONSTRAINT; Schema: lab3_schema; Owner: postgres
--

ALTER TABLE ONLY lab3_schema.task
    ADD CONSTRAINT task_pkey PRIMARY KEY (task_id);


--
-- TOC entry 3568 (class 2606 OID 16495)
-- Name: task_status task_status_pkey; Type: CONSTRAINT; Schema: lab3_schema; Owner: postgres
--

ALTER TABLE ONLY lab3_schema.task_status
    ADD CONSTRAINT task_status_pkey PRIMARY KEY (status_id);


--
-- TOC entry 3614 (class 2606 OID 16690)
-- Name: completion_certificate completion_certificate_contract_id_fkey; Type: FK CONSTRAINT; Schema: lab3_schema; Owner: postgres
--

ALTER TABLE ONLY lab3_schema.completion_certificate
    ADD CONSTRAINT completion_certificate_contract_id_fkey FOREIGN KEY (contract_id) REFERENCES lab3_schema.contract(contract_id);


--
-- TOC entry 3595 (class 2606 OID 16510)
-- Name: contract contract_manager_id_fkey; Type: FK CONSTRAINT; Schema: lab3_schema; Owner: postgres
--

ALTER TABLE ONLY lab3_schema.contract
    ADD CONSTRAINT contract_manager_id_fkey FOREIGN KEY (manager_id) REFERENCES lab3_schema.employee(employee_id);


--
-- TOC entry 3596 (class 2606 OID 16505)
-- Name: contract contract_organization_id_fkey; Type: FK CONSTRAINT; Schema: lab3_schema; Owner: postgres
--

ALTER TABLE ONLY lab3_schema.contract
    ADD CONSTRAINT contract_organization_id_fkey FOREIGN KEY (organization_id) REFERENCES lab3_schema.organization(organization_id);


--
-- TOC entry 3611 (class 2606 OID 16653)
-- Name: control_schedule control_schedule_task_id_fkey; Type: FK CONSTRAINT; Schema: lab3_schema; Owner: postgres
--

ALTER TABLE ONLY lab3_schema.control_schedule
    ADD CONSTRAINT control_schedule_task_id_fkey FOREIGN KEY (task_id) REFERENCES lab3_schema.task(task_id);


--
-- TOC entry 3612 (class 2606 OID 16673)
-- Name: invoice invoice_contract_id_fkey; Type: FK CONSTRAINT; Schema: lab3_schema; Owner: postgres
--

ALTER TABLE ONLY lab3_schema.invoice
    ADD CONSTRAINT invoice_contract_id_fkey FOREIGN KEY (contract_id) REFERENCES lab3_schema.contract(contract_id);


--
-- TOC entry 3613 (class 2606 OID 16678)
-- Name: invoice invoice_invoice_type_id_fkey; Type: FK CONSTRAINT; Schema: lab3_schema; Owner: postgres
--

ALTER TABLE ONLY lab3_schema.invoice
    ADD CONSTRAINT invoice_invoice_type_id_fkey FOREIGN KEY (invoice_type_id) REFERENCES lab3_schema.invoice_type(invoice_type_id);


--
-- TOC entry 3603 (class 2606 OID 16574)
-- Name: position_history position_history_employee_id_fkey; Type: FK CONSTRAINT; Schema: lab3_schema; Owner: postgres
--

ALTER TABLE ONLY lab3_schema.position_history
    ADD CONSTRAINT position_history_employee_id_fkey FOREIGN KEY (employee_id) REFERENCES lab3_schema.employee(employee_id);


--
-- TOC entry 3604 (class 2606 OID 16569)
-- Name: position_history position_history_position_id_fkey; Type: FK CONSTRAINT; Schema: lab3_schema; Owner: postgres
--

ALTER TABLE ONLY lab3_schema.position_history
    ADD CONSTRAINT position_history_position_id_fkey FOREIGN KEY (position_id) REFERENCES lab3_schema."position"(position_id);


--
-- TOC entry 3597 (class 2606 OID 16529)
-- Name: project project_contract_id_fkey; Type: FK CONSTRAINT; Schema: lab3_schema; Owner: postgres
--

ALTER TABLE ONLY lab3_schema.project
    ADD CONSTRAINT project_contract_id_fkey FOREIGN KEY (contract_id) REFERENCES lab3_schema.contract(contract_id);


--
-- TOC entry 3598 (class 2606 OID 16524)
-- Name: project project_manager_id_fkey; Type: FK CONSTRAINT; Schema: lab3_schema; Owner: postgres
--

ALTER TABLE ONLY lab3_schema.project
    ADD CONSTRAINT project_manager_id_fkey FOREIGN KEY (manager_id) REFERENCES lab3_schema.employee(employee_id);


--
-- TOC entry 3599 (class 2606 OID 16539)
-- Name: project project_organization_id_fkey; Type: FK CONSTRAINT; Schema: lab3_schema; Owner: postgres
--

ALTER TABLE ONLY lab3_schema.project
    ADD CONSTRAINT project_organization_id_fkey FOREIGN KEY (organization_id) REFERENCES lab3_schema.organization(organization_id);


--
-- TOC entry 3605 (class 2606 OID 16603)
-- Name: project_participation project_participation_employee_id_fkey; Type: FK CONSTRAINT; Schema: lab3_schema; Owner: postgres
--

ALTER TABLE ONLY lab3_schema.project_participation
    ADD CONSTRAINT project_participation_employee_id_fkey FOREIGN KEY (employee_id) REFERENCES lab3_schema.employee(employee_id);


--
-- TOC entry 3606 (class 2606 OID 16608)
-- Name: project_participation project_participation_project_id_fkey; Type: FK CONSTRAINT; Schema: lab3_schema; Owner: postgres
--

ALTER TABLE ONLY lab3_schema.project_participation
    ADD CONSTRAINT project_participation_project_id_fkey FOREIGN KEY (project_id) REFERENCES lab3_schema.project(project_id);


--
-- TOC entry 3607 (class 2606 OID 16618)
-- Name: project_participation project_participation_reward_type_id_fkey; Type: FK CONSTRAINT; Schema: lab3_schema; Owner: postgres
--

ALTER TABLE ONLY lab3_schema.project_participation
    ADD CONSTRAINT project_participation_reward_type_id_fkey FOREIGN KEY (reward_type_id) REFERENCES lab3_schema.reward_type(reward_type_id);


--
-- TOC entry 3608 (class 2606 OID 16613)
-- Name: project_participation project_participation_role_id_fkey; Type: FK CONSTRAINT; Schema: lab3_schema; Owner: postgres
--

ALTER TABLE ONLY lab3_schema.project_participation
    ADD CONSTRAINT project_participation_role_id_fkey FOREIGN KEY (role_id) REFERENCES lab3_schema.project_role(role_id);


--
-- TOC entry 3600 (class 2606 OID 16534)
-- Name: project project_status_id_fkey; Type: FK CONSTRAINT; Schema: lab3_schema; Owner: postgres
--

ALTER TABLE ONLY lab3_schema.project
    ADD CONSTRAINT project_status_id_fkey FOREIGN KEY (status_id) REFERENCES lab3_schema.project_status(status_id);


--
-- TOC entry 3609 (class 2606 OID 16633)
-- Name: task_participation task_participation_employee_id_fkey; Type: FK CONSTRAINT; Schema: lab3_schema; Owner: postgres
--

ALTER TABLE ONLY lab3_schema.task_participation
    ADD CONSTRAINT task_participation_employee_id_fkey FOREIGN KEY (employee_id) REFERENCES lab3_schema.employee(employee_id);


--
-- TOC entry 3610 (class 2606 OID 16638)
-- Name: task_participation task_participation_task_id_fkey; Type: FK CONSTRAINT; Schema: lab3_schema; Owner: postgres
--

ALTER TABLE ONLY lab3_schema.task_participation
    ADD CONSTRAINT task_participation_task_id_fkey FOREIGN KEY (task_id) REFERENCES lab3_schema.task(task_id);


--
-- TOC entry 3601 (class 2606 OID 16552)
-- Name: task task_project_id_fkey; Type: FK CONSTRAINT; Schema: lab3_schema; Owner: postgres
--

ALTER TABLE ONLY lab3_schema.task
    ADD CONSTRAINT task_project_id_fkey FOREIGN KEY (project_id) REFERENCES lab3_schema.project(project_id);


--
-- TOC entry 3602 (class 2606 OID 16557)
-- Name: task task_status_id_fkey; Type: FK CONSTRAINT; Schema: lab3_schema; Owner: postgres
--

ALTER TABLE ONLY lab3_schema.task
    ADD CONSTRAINT task_status_id_fkey FOREIGN KEY (status_id) REFERENCES lab3_schema.task_status(status_id);


-- Completed on 2025-06-17 09:15:36 MSK

--
-- PostgreSQL database dump complete
--

