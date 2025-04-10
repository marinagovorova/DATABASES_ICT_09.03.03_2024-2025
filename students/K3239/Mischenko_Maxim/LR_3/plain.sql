--
-- PostgreSQL database dump
--

-- Dumped from database version 15.4
-- Dumped by pg_dump version 15.4

-- Started on 2025-04-09 12:56:13

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
-- TOC entry 6 (class 2615 OID 17779)
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO postgres;

--
-- TOC entry 3469 (class 0 OID 0)
-- Dependencies: 6
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS '';


--
-- TOC entry 2 (class 3079 OID 16384)
-- Name: adminpack; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;


--
-- TOC entry 3471 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION adminpack; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 221 (class 1259 OID 17960)
-- Name: airports; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.airports (
    airport_code character varying(10) NOT NULL,
    country character varying(255),
    status character varying(255),
    city character varying(255),
    name character varying(255)
);


ALTER TABLE public.airports OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 18051)
-- Name: cash_registers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cash_registers (
    cash_register_id integer NOT NULL,
    address character varying(255),
    status character varying(50)
);


ALTER TABLE public.cash_registers OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 18050)
-- Name: cash_registers_cash_register_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cash_registers_cash_register_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cash_registers_cash_register_id_seq OWNER TO postgres;

--
-- TOC entry 3472 (class 0 OID 0)
-- Dependencies: 234
-- Name: cash_registers_cash_register_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cash_registers_cash_register_id_seq OWNED BY public.cash_registers.cash_register_id;


--
-- TOC entry 229 (class 1259 OID 18016)
-- Name: crew_assignments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.crew_assignments (
    crew_assignment_id integer NOT NULL,
    member_id integer,
    flight_id integer,
    actual_role character varying(255),
    medical_check_date timestamp without time zone,
    medical_status character varying(255),
    medical_reason character varying(255)
);


ALTER TABLE public.crew_assignments OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 18015)
-- Name: crew_assignments_crew_assignment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.crew_assignments_crew_assignment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.crew_assignments_crew_assignment_id_seq OWNER TO postgres;

--
-- TOC entry 3473 (class 0 OID 0)
-- Dependencies: 228
-- Name: crew_assignments_crew_assignment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.crew_assignments_crew_assignment_id_seq OWNED BY public.crew_assignments.crew_assignment_id;


--
-- TOC entry 227 (class 1259 OID 18002)
-- Name: crew_members; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.crew_members (
    member_id integer NOT NULL,
    company_id integer,
    full_name character varying(255),
    email character varying(255),
    phone_number character varying(20),
    passport_serial integer,
    passport_number integer,
    passport_region character varying(255),
    default_role character varying(255)
);


ALTER TABLE public.crew_members OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 18001)
-- Name: crew_members_member_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.crew_members_member_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.crew_members_member_id_seq OWNER TO postgres;

--
-- TOC entry 3474 (class 0 OID 0)
-- Dependencies: 226
-- Name: crew_members_member_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.crew_members_member_id_seq OWNED BY public.crew_members.member_id;


--
-- TOC entry 216 (class 1259 OID 17928)
-- Name: flight_company; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.flight_company (
    company_id integer NOT NULL,
    name character varying(255),
    country character varying(255)
);


ALTER TABLE public.flight_company OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 17927)
-- Name: flight_company_company_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.flight_company_company_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.flight_company_company_id_seq OWNER TO postgres;

--
-- TOC entry 3475 (class 0 OID 0)
-- Dependencies: 215
-- Name: flight_company_company_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.flight_company_company_id_seq OWNED BY public.flight_company.company_id;


--
-- TOC entry 225 (class 1259 OID 17985)
-- Name: flights; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.flights (
    flight_id integer NOT NULL,
    plane_id integer,
    route_id integer,
    status character varying(255),
    distance double precision,
    departure_datetime_real timestamp without time zone,
    arrival_datetime_real timestamp without time zone
);


ALTER TABLE public.flights OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 17984)
-- Name: flights_flight_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.flights_flight_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.flights_flight_id_seq OWNER TO postgres;

--
-- TOC entry 3476 (class 0 OID 0)
-- Dependencies: 224
-- Name: flights_flight_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.flights_flight_id_seq OWNED BY public.flights.flight_id;


--
-- TOC entry 231 (class 1259 OID 18035)
-- Name: passengers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.passengers (
    passenger_id integer NOT NULL,
    full_name character varying(255),
    passport_serial integer,
    passport_number integer,
    passport_region character varying(255),
    birth_date date
);


ALTER TABLE public.passengers OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 18034)
-- Name: passengers_passenger_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.passengers_passenger_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.passengers_passenger_id_seq OWNER TO postgres;

--
-- TOC entry 3477 (class 0 OID 0)
-- Dependencies: 230
-- Name: passengers_passenger_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.passengers_passenger_id_seq OWNED BY public.passengers.passenger_id;


--
-- TOC entry 218 (class 1259 OID 17937)
-- Name: plane_models; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.plane_models (
    model_id integer NOT NULL,
    engine_power double precision,
    fuel_consumption double precision,
    range double precision,
    cargo_capacity double precision,
    seat_count integer
);


ALTER TABLE public.plane_models OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 17936)
-- Name: plane_models_model_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.plane_models_model_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.plane_models_model_id_seq OWNER TO postgres;

--
-- TOC entry 3478 (class 0 OID 0)
-- Dependencies: 217
-- Name: plane_models_model_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.plane_models_model_id_seq OWNED BY public.plane_models.model_id;


--
-- TOC entry 220 (class 1259 OID 17944)
-- Name: planes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.planes (
    plane_id integer NOT NULL,
    model_id integer,
    company_id integer,
    status character varying(255),
    flight_hours double precision,
    last_maintenance_date date
);


ALTER TABLE public.planes OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 17943)
-- Name: planes_plane_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.planes_plane_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.planes_plane_id_seq OWNER TO postgres;

--
-- TOC entry 3479 (class 0 OID 0)
-- Dependencies: 219
-- Name: planes_plane_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.planes_plane_id_seq OWNED BY public.planes.plane_id;


--
-- TOC entry 223 (class 1259 OID 17968)
-- Name: schedule; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.schedule (
    route_id integer NOT NULL,
    arrival_airport_code character varying(10),
    departure_airport_code character varying(10),
    planned_time_arrival timestamp without time zone,
    planned_time_departure timestamp without time zone
);


ALTER TABLE public.schedule OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 17967)
-- Name: schedule_route_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.schedule_route_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.schedule_route_id_seq OWNER TO postgres;

--
-- TOC entry 3480 (class 0 OID 0)
-- Dependencies: 222
-- Name: schedule_route_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.schedule_route_id_seq OWNED BY public.schedule.route_id;


--
-- TOC entry 233 (class 1259 OID 18044)
-- Name: seats; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.seats (
    seat_id integer NOT NULL,
    seat_number character varying(10),
    seat_type character varying(50),
    base_price double precision,
    status character varying(50)
);


ALTER TABLE public.seats OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 18043)
-- Name: seats_seat_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seats_seat_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seats_seat_id_seq OWNER TO postgres;

--
-- TOC entry 3481 (class 0 OID 0)
-- Dependencies: 232
-- Name: seats_seat_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.seats_seat_id_seq OWNED BY public.seats.seat_id;


--
-- TOC entry 237 (class 1259 OID 18058)
-- Name: tickets; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tickets (
    ticket_id integer NOT NULL,
    flight_id integer,
    passenger_id integer,
    seat_id integer,
    sale_channel character varying(255),
    cash_register_id integer,
    additional_fee double precision,
    status character varying(255)
);


ALTER TABLE public.tickets OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 18057)
-- Name: tickets_ticket_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tickets_ticket_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tickets_ticket_id_seq OWNER TO postgres;

--
-- TOC entry 3482 (class 0 OID 0)
-- Dependencies: 236
-- Name: tickets_ticket_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tickets_ticket_id_seq OWNED BY public.tickets.ticket_id;


--
-- TOC entry 239 (class 1259 OID 18087)
-- Name: transit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.transit (
    transit_id integer NOT NULL,
    flight_id integer
);


ALTER TABLE public.transit OWNER TO postgres;

--
-- TOC entry 241 (class 1259 OID 18099)
-- Name: transit_stops; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.transit_stops (
    stop_id integer NOT NULL,
    transit_id integer,
    airport_code character varying(10),
    arrival_datetime timestamp without time zone,
    departure_datetime timestamp without time zone
);


ALTER TABLE public.transit_stops OWNER TO postgres;

--
-- TOC entry 240 (class 1259 OID 18098)
-- Name: transit_stops_stop_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.transit_stops_stop_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.transit_stops_stop_id_seq OWNER TO postgres;

--
-- TOC entry 3483 (class 0 OID 0)
-- Dependencies: 240
-- Name: transit_stops_stop_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.transit_stops_stop_id_seq OWNED BY public.transit_stops.stop_id;


--
-- TOC entry 238 (class 1259 OID 18086)
-- Name: transit_transit_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.transit_transit_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.transit_transit_id_seq OWNER TO postgres;

--
-- TOC entry 3484 (class 0 OID 0)
-- Dependencies: 238
-- Name: transit_transit_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.transit_transit_id_seq OWNED BY public.transit.transit_id;


--
-- TOC entry 3247 (class 2604 OID 18054)
-- Name: cash_registers cash_register_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cash_registers ALTER COLUMN cash_register_id SET DEFAULT nextval('public.cash_registers_cash_register_id_seq'::regclass);


--
-- TOC entry 3244 (class 2604 OID 18019)
-- Name: crew_assignments crew_assignment_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.crew_assignments ALTER COLUMN crew_assignment_id SET DEFAULT nextval('public.crew_assignments_crew_assignment_id_seq'::regclass);


--
-- TOC entry 3243 (class 2604 OID 18005)
-- Name: crew_members member_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.crew_members ALTER COLUMN member_id SET DEFAULT nextval('public.crew_members_member_id_seq'::regclass);


--
-- TOC entry 3238 (class 2604 OID 17931)
-- Name: flight_company company_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.flight_company ALTER COLUMN company_id SET DEFAULT nextval('public.flight_company_company_id_seq'::regclass);


--
-- TOC entry 3242 (class 2604 OID 17988)
-- Name: flights flight_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.flights ALTER COLUMN flight_id SET DEFAULT nextval('public.flights_flight_id_seq'::regclass);


--
-- TOC entry 3245 (class 2604 OID 18038)
-- Name: passengers passenger_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.passengers ALTER COLUMN passenger_id SET DEFAULT nextval('public.passengers_passenger_id_seq'::regclass);


--
-- TOC entry 3239 (class 2604 OID 17940)
-- Name: plane_models model_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.plane_models ALTER COLUMN model_id SET DEFAULT nextval('public.plane_models_model_id_seq'::regclass);


--
-- TOC entry 3240 (class 2604 OID 17947)
-- Name: planes plane_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.planes ALTER COLUMN plane_id SET DEFAULT nextval('public.planes_plane_id_seq'::regclass);


--
-- TOC entry 3241 (class 2604 OID 17971)
-- Name: schedule route_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schedule ALTER COLUMN route_id SET DEFAULT nextval('public.schedule_route_id_seq'::regclass);


--
-- TOC entry 3246 (class 2604 OID 18047)
-- Name: seats seat_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.seats ALTER COLUMN seat_id SET DEFAULT nextval('public.seats_seat_id_seq'::regclass);


--
-- TOC entry 3248 (class 2604 OID 18061)
-- Name: tickets ticket_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tickets ALTER COLUMN ticket_id SET DEFAULT nextval('public.tickets_ticket_id_seq'::regclass);


--
-- TOC entry 3249 (class 2604 OID 18090)
-- Name: transit transit_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transit ALTER COLUMN transit_id SET DEFAULT nextval('public.transit_transit_id_seq'::regclass);


--
-- TOC entry 3250 (class 2604 OID 18102)
-- Name: transit_stops stop_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transit_stops ALTER COLUMN stop_id SET DEFAULT nextval('public.transit_stops_stop_id_seq'::regclass);


--
-- TOC entry 3443 (class 0 OID 17960)
-- Dependencies: 221
-- Data for Name: airports; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.airports (airport_code, country, status, city, name) FROM stdin;
LED	Russia	Active	St. Petersburg	Pulkovo
JFK	USA	Active	New York	John F. Kennedy
\.


--
-- TOC entry 3457 (class 0 OID 18051)
-- Dependencies: 235
-- Data for Name: cash_registers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cash_registers (cash_register_id, address, status) FROM stdin;
\.


--
-- TOC entry 3451 (class 0 OID 18016)
-- Dependencies: 229
-- Data for Name: crew_assignments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.crew_assignments (crew_assignment_id, member_id, flight_id, actual_role, medical_check_date, medical_status, medical_reason) FROM stdin;
\.


--
-- TOC entry 3449 (class 0 OID 18002)
-- Dependencies: 227
-- Data for Name: crew_members; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.crew_members (member_id, company_id, full_name, email, phone_number, passport_serial, passport_number, passport_region, default_role) FROM stdin;
\.


--
-- TOC entry 3438 (class 0 OID 17928)
-- Dependencies: 216
-- Data for Name: flight_company; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.flight_company (company_id, name, country) FROM stdin;
1	Airline 1	Russia
2	Airline 2	USA
\.


--
-- TOC entry 3447 (class 0 OID 17985)
-- Dependencies: 225
-- Data for Name: flights; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.flights (flight_id, plane_id, route_id, status, distance, departure_datetime_real, arrival_datetime_real) FROM stdin;
\.


--
-- TOC entry 3453 (class 0 OID 18035)
-- Dependencies: 231
-- Data for Name: passengers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.passengers (passenger_id, full_name, passport_serial, passport_number, passport_region, birth_date) FROM stdin;
\.


--
-- TOC entry 3440 (class 0 OID 17937)
-- Dependencies: 218
-- Data for Name: plane_models; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.plane_models (model_id, engine_power, fuel_consumption, range, cargo_capacity, seat_count) FROM stdin;
1	3000	250	5000	20000	150
2	4000	300	7000	25000	200
\.


--
-- TOC entry 3442 (class 0 OID 17944)
-- Dependencies: 220
-- Data for Name: planes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.planes (plane_id, model_id, company_id, status, flight_hours, last_maintenance_date) FROM stdin;
1	1	1	Operational	1200	2025-01-01
2	2	2	Maintenance	800	2024-12-15
\.


--
-- TOC entry 3445 (class 0 OID 17968)
-- Dependencies: 223
-- Data for Name: schedule; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.schedule (route_id, arrival_airport_code, departure_airport_code, planned_time_arrival, planned_time_departure) FROM stdin;
\.


--
-- TOC entry 3455 (class 0 OID 18044)
-- Dependencies: 233
-- Data for Name: seats; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.seats (seat_id, seat_number, seat_type, base_price, status) FROM stdin;
\.


--
-- TOC entry 3459 (class 0 OID 18058)
-- Dependencies: 237
-- Data for Name: tickets; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tickets (ticket_id, flight_id, passenger_id, seat_id, sale_channel, cash_register_id, additional_fee, status) FROM stdin;
\.


--
-- TOC entry 3461 (class 0 OID 18087)
-- Dependencies: 239
-- Data for Name: transit; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.transit (transit_id, flight_id) FROM stdin;
\.


--
-- TOC entry 3463 (class 0 OID 18099)
-- Dependencies: 241
-- Data for Name: transit_stops; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.transit_stops (stop_id, transit_id, airport_code, arrival_datetime, departure_datetime) FROM stdin;
\.


--
-- TOC entry 3485 (class 0 OID 0)
-- Dependencies: 234
-- Name: cash_registers_cash_register_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cash_registers_cash_register_id_seq', 1, false);


--
-- TOC entry 3486 (class 0 OID 0)
-- Dependencies: 228
-- Name: crew_assignments_crew_assignment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.crew_assignments_crew_assignment_id_seq', 1, false);


--
-- TOC entry 3487 (class 0 OID 0)
-- Dependencies: 226
-- Name: crew_members_member_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.crew_members_member_id_seq', 1, false);


--
-- TOC entry 3488 (class 0 OID 0)
-- Dependencies: 215
-- Name: flight_company_company_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.flight_company_company_id_seq', 2, true);


--
-- TOC entry 3489 (class 0 OID 0)
-- Dependencies: 224
-- Name: flights_flight_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.flights_flight_id_seq', 1, false);


--
-- TOC entry 3490 (class 0 OID 0)
-- Dependencies: 230
-- Name: passengers_passenger_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.passengers_passenger_id_seq', 1, false);


--
-- TOC entry 3491 (class 0 OID 0)
-- Dependencies: 217
-- Name: plane_models_model_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.plane_models_model_id_seq', 2, true);


--
-- TOC entry 3492 (class 0 OID 0)
-- Dependencies: 219
-- Name: planes_plane_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.planes_plane_id_seq', 2, true);


--
-- TOC entry 3493 (class 0 OID 0)
-- Dependencies: 222
-- Name: schedule_route_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.schedule_route_id_seq', 1, false);


--
-- TOC entry 3494 (class 0 OID 0)
-- Dependencies: 232
-- Name: seats_seat_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seats_seat_id_seq', 1, false);


--
-- TOC entry 3495 (class 0 OID 0)
-- Dependencies: 236
-- Name: tickets_ticket_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tickets_ticket_id_seq', 1, false);


--
-- TOC entry 3496 (class 0 OID 0)
-- Dependencies: 240
-- Name: transit_stops_stop_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.transit_stops_stop_id_seq', 1, false);


--
-- TOC entry 3497 (class 0 OID 0)
-- Dependencies: 238
-- Name: transit_transit_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.transit_transit_id_seq', 1, false);


--
-- TOC entry 3258 (class 2606 OID 17966)
-- Name: airports airports_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.airports
    ADD CONSTRAINT airports_pkey PRIMARY KEY (airport_code);

-- Проверка статусов
ALTER TABLE public.airports
ADD CONSTRAINT check_airport_status CHECK (status IN ('active', 'closed', 'maintenance'));

ALTER TABLE public.cash_registers
ADD CONSTRAINT check_cash_register_status CHECK (status IN ('active', 'inactive'));

ALTER TABLE public.seats
ADD CONSTRAINT check_seat_status CHECK (status IN ('available', 'occupied', 'reserved'));

ALTER TABLE public.tickets
ADD CONSTRAINT check_ticket_status CHECK (status IN ('booked', 'cancelled', 'used'));

-- Чек: base_price больше 0
ALTER TABLE public.seats
ADD CONSTRAINT check_seat_price CHECK (base_price >= 0);

-- Чек: fuel_consumption, engine_power, range и т.д. положительные
ALTER TABLE public.plane_models
ADD CONSTRAINT check_engine_power CHECK (engine_power > 0);
ALTER TABLE public.plane_models
ADD CONSTRAINT check_fuel_consumption CHECK (fuel_consumption > 0);
ALTER TABLE public.plane_models
ADD CONSTRAINT check_range CHECK (range > 0);
ALTER TABLE public.plane_models
ADD CONSTRAINT check_seat_count CHECK (seat_count > 0);

-- Чек: distance в рейсе
ALTER TABLE public.flights
ADD CONSTRAINT check_flight_distance CHECK (distance >= 0);

-- Чек: дополнительные сборы в билете
ALTER TABLE public.tickets
ADD CONSTRAINT check_additional_fee CHECK (additional_fee >= 0);
--
-- TOC entry 3272 (class 2606 OID 18056)
-- Name: cash_registers cash_registers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cash_registers
    ADD CONSTRAINT cash_registers_pkey PRIMARY KEY (cash_register_id);


--
-- TOC entry 3266 (class 2606 OID 18023)
-- Name: crew_assignments crew_assignments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.crew_assignments
    ADD CONSTRAINT crew_assignments_pkey PRIMARY KEY (crew_assignment_id);


--
-- TOC entry 3264 (class 2606 OID 18009)
-- Name: crew_members crew_members_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.crew_members
    ADD CONSTRAINT crew_members_pkey PRIMARY KEY (member_id);


--
-- TOC entry 3252 (class 2606 OID 17935)
-- Name: flight_company flight_company_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.flight_company
    ADD CONSTRAINT flight_company_pkey PRIMARY KEY (company_id);


--
-- TOC entry 3262 (class 2606 OID 17990)
-- Name: flights flights_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.flights
    ADD CONSTRAINT flights_pkey PRIMARY KEY (flight_id);


--
-- TOC entry 3268 (class 2606 OID 18042)
-- Name: passengers passengers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.passengers
    ADD CONSTRAINT passengers_pkey PRIMARY KEY (passenger_id);


--
-- TOC entry 3254 (class 2606 OID 17942)
-- Name: plane_models plane_models_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.plane_models
    ADD CONSTRAINT plane_models_pkey PRIMARY KEY (model_id);


--
-- TOC entry 3256 (class 2606 OID 17949)
-- Name: planes planes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.planes
    ADD CONSTRAINT planes_pkey PRIMARY KEY (plane_id);


--
-- TOC entry 3260 (class 2606 OID 17973)
-- Name: schedule schedule_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schedule
    ADD CONSTRAINT schedule_pkey PRIMARY KEY (route_id);


--
-- TOC entry 3270 (class 2606 OID 18049)
-- Name: seats seats_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.seats
    ADD CONSTRAINT seats_pkey PRIMARY KEY (seat_id);


--
-- TOC entry 3274 (class 2606 OID 18065)
-- Name: tickets tickets_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tickets
    ADD CONSTRAINT tickets_pkey PRIMARY KEY (ticket_id);


--
-- TOC entry 3276 (class 2606 OID 18092)
-- Name: transit transit_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transit
    ADD CONSTRAINT transit_pkey PRIMARY KEY (transit_id);


--
-- TOC entry 3278 (class 2606 OID 18104)
-- Name: transit_stops transit_stops_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transit_stops
    ADD CONSTRAINT transit_stops_pkey PRIMARY KEY (stop_id);


--
-- TOC entry 3286 (class 2606 OID 18029)
-- Name: crew_assignments crew_assignments_flight_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.crew_assignments
    ADD CONSTRAINT crew_assignments_flight_id_fkey FOREIGN KEY (flight_id) REFERENCES public.flights(flight_id);


--
-- TOC entry 3287 (class 2606 OID 18024)
-- Name: crew_assignments crew_assignments_member_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.crew_assignments
    ADD CONSTRAINT crew_assignments_member_id_fkey FOREIGN KEY (member_id) REFERENCES public.crew_members(member_id);


--
-- TOC entry 3285 (class 2606 OID 18010)
-- Name: crew_members crew_members_company_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.crew_members
    ADD CONSTRAINT crew_members_company_id_fkey FOREIGN KEY (company_id) REFERENCES public.flight_company(company_id);

-- Уникальность email у экипажа
ALTER TABLE public.crew_members
ADD CONSTRAINT unique_email UNIQUE (email);

-- Уникальность телефона у экипажа
ALTER TABLE public.crew_members
ADD CONSTRAINT unique_phone_number UNIQUE (phone_number);

--
-- TOC entry 3283 (class 2606 OID 17991)
-- Name: flights flights_plane_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.flights
    ADD CONSTRAINT flights_plane_id_fkey FOREIGN KEY (plane_id) REFERENCES public.planes(plane_id);


--
-- TOC entry 3284 (class 2606 OID 17996)
-- Name: flights flights_route_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.flights
    ADD CONSTRAINT flights_route_id_fkey FOREIGN KEY (route_id) REFERENCES public.schedule(route_id);


--
-- TOC entry 3279 (class 2606 OID 17955)
-- Name: planes planes_company_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.planes
    ADD CONSTRAINT planes_company_id_fkey FOREIGN KEY (company_id) REFERENCES public.flight_company(company_id);


--
-- TOC entry 3280 (class 2606 OID 17950)
-- Name: planes planes_model_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.planes
    ADD CONSTRAINT planes_model_id_fkey FOREIGN KEY (model_id) REFERENCES public.plane_models(model_id);


--
-- TOC entry 3281 (class 2606 OID 17974)
-- Name: schedule schedule_arrival_airport_code_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schedule
    ADD CONSTRAINT schedule_arrival_airport_code_fkey FOREIGN KEY (arrival_airport_code) REFERENCES public.airports(airport_code);


--
-- TOC entry 3282 (class 2606 OID 17979)
-- Name: schedule schedule_departure_airport_code_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schedule
    ADD CONSTRAINT schedule_departure_airport_code_fkey FOREIGN KEY (departure_airport_code) REFERENCES public.airports(airport_code);


--
-- TOC entry 3288 (class 2606 OID 18081)
-- Name: tickets tickets_cash_register_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tickets
    ADD CONSTRAINT tickets_cash_register_id_fkey FOREIGN KEY (cash_register_id) REFERENCES public.cash_registers(cash_register_id);


--
-- TOC entry 3289 (class 2606 OID 18066)
-- Name: tickets tickets_flight_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tickets
    ADD CONSTRAINT tickets_flight_id_fkey FOREIGN KEY (flight_id) REFERENCES public.flights(flight_id);


--
-- TOC entry 3290 (class 2606 OID 18071)
-- Name: tickets tickets_passenger_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tickets
    ADD CONSTRAINT tickets_passenger_id_fkey FOREIGN KEY (passenger_id) REFERENCES public.passengers(passenger_id);


--
-- TOC entry 3291 (class 2606 OID 18076)
-- Name: tickets tickets_seat_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tickets
    ADD CONSTRAINT tickets_seat_id_fkey FOREIGN KEY (seat_id) REFERENCES public.seats(seat_id);


--
-- TOC entry 3292 (class 2606 OID 18093)
-- Name: transit transit_flight_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transit
    ADD CONSTRAINT transit_flight_id_fkey FOREIGN KEY (flight_id) REFERENCES public.flights(flight_id);


--
-- TOC entry 3293 (class 2606 OID 18110)
-- Name: transit_stops transit_stops_airport_code_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transit_stops
    ADD CONSTRAINT transit_stops_airport_code_fkey FOREIGN KEY (airport_code) REFERENCES public.airports(airport_code);


--
-- TOC entry 3294 (class 2606 OID 18105)
-- Name: transit_stops transit_stops_transit_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transit_stops
    ADD CONSTRAINT transit_stops_transit_id_fkey FOREIGN KEY (transit_id) REFERENCES public.transit(transit_id);


--
-- TOC entry 3470 (class 0 OID 0)
-- Dependencies: 6
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;


-- Completed on 2025-04-09 12:56:13

--
-- PostgreSQL database dump complete
--



-- ============================================
-- Create database
-- ============================================
CREATE DATABASE flight_management;
\c flight_management;

-- ============================================
-- Add comments to tables and columns
-- ============================================

-- Airports
COMMENT ON TABLE public.airports IS 'Справочник аэропортов';
COMMENT ON COLUMN public.airports.airport_code IS 'Уникальный код аэропорта (PK)';
COMMENT ON COLUMN public.airports.country IS 'Страна, где расположен аэропорт';
COMMENT ON COLUMN public.airports.city IS 'Город, где расположен аэропорт';
COMMENT ON COLUMN public.airports.status IS 'Текущий статус (действующий, закрыт и т.д.)';

-- Cash Registers
COMMENT ON TABLE public.cash_registers IS 'Кассы для продажи билетов';
COMMENT ON COLUMN public.cash_registers.cash_register_id IS 'Идентификатор кассы (PK)';
COMMENT ON COLUMN public.cash_registers.address IS 'Физический адрес кассы';
COMMENT ON COLUMN public.cash_registers.status IS 'Состояние кассы (активна, отключена)';

-- Crew Assignments
COMMENT ON TABLE public.crew_assignments IS 'Назначения экипажей на рейсы';
COMMENT ON COLUMN public.crew_assignments.member_id IS 'Ссылка на члена экипажа';
COMMENT ON COLUMN public.crew_assignments.flight_id IS 'Ссылка на рейс';
COMMENT ON COLUMN public.crew_assignments.actual_role IS 'Фактическая роль (пилот, бортпроводник и т.п.)';
COMMENT ON COLUMN public.crew_assignments.medical_check_date IS 'Дата прохождения медосмотра';
COMMENT ON COLUMN public.crew_assignments.medical_status IS 'Результат медосмотра';

-- ============================================
-- Sample data insertion
-- ============================================

-- Insert some airports
INSERT INTO public.airports (airport_code, country, status, city, name)
VALUES 
  ('LED', 'Russia', 'active', 'Saint Petersburg', 'Pulkovo'),
  ('SVO', 'Russia', 'active', 'Moscow', 'Sheremetyevo'),
  ('JFK', 'USA', 'active', 'New York', 'John F. Kennedy International');

-- Insert sample cash registers
INSERT INTO public.cash_registers (cash_register_id, address, status)
VALUES 
  (1, 'Terminal A, LED', 'active'),
  (2, 'Terminal B, SVO', 'active');

-- Insert sample crew assignment
INSERT INTO public.crew_assignments (crew_assignment_id, member_id, flight_id, actual_role, medical_check_date, medical_status)
VALUES 
  (1, 1, 1, 'Pilot', '2025-03-01 08:00:00', 'fit');

