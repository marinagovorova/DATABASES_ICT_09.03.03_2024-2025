--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4
-- Dumped by pg_dump version 17.4

-- Started on 2025-05-05 15:21:09

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

ALTER TABLE ONLY public.trip DROP CONSTRAINT trip_route_id_fkey;
ALTER TABLE ONLY public.trip DROP CONSTRAINT trip_bus_id_fkey;
ALTER TABLE ONLY public.ticket DROP CONSTRAINT ticket_trip_id_fkey;
ALTER TABLE ONLY public.ticket DROP CONSTRAINT ticket_passport_passenger_id_fkey;
ALTER TABLE ONLY public.route DROP CONSTRAINT route_start_settlement_id_fkey;
ALTER TABLE ONLY public.route DROP CONSTRAINT route_final_settlement_id_fkey;
ALTER TABLE ONLY public.route_composition DROP CONSTRAINT route_composition_settlement_id_fkey;
ALTER TABLE ONLY public.route_composition DROP CONSTRAINT route_composition_route_id_fkey;
ALTER TABLE ONLY public.passport_passenger DROP CONSTRAINT passport_passenger_passenger_id_fkey;
ALTER TABLE ONLY public.passport_driver DROP CONSTRAINT passport_driver_driver_id_fkey;
ALTER TABLE ONLY public.crew DROP CONSTRAINT crew_trip_id_fkey;
ALTER TABLE ONLY public.crew DROP CONSTRAINT crew_reason_id_fkey;
ALTER TABLE ONLY public.crew DROP CONSTRAINT crew_passport_driver_id_fkey;
ALTER TABLE ONLY public.bus DROP CONSTRAINT bus_bus_model_id_fkey;
ALTER TABLE ONLY public.trip DROP CONSTRAINT trip_pkey;
ALTER TABLE ONLY public.ticket DROP CONSTRAINT ticket_pkey;
ALTER TABLE ONLY public.settlement DROP CONSTRAINT settlement_pkey;
ALTER TABLE ONLY public.route DROP CONSTRAINT route_pkey;
ALTER TABLE ONLY public.route_composition DROP CONSTRAINT route_composition_pkey;
ALTER TABLE ONLY public.reason_for_disqualification DROP CONSTRAINT reason_for_disqualification_pkey;
ALTER TABLE ONLY public.passport_passenger DROP CONSTRAINT passport_passenger_pkey;
ALTER TABLE ONLY public.passport_passenger DROP CONSTRAINT passport_passenger_passenger_id_key;
ALTER TABLE ONLY public.passport_driver DROP CONSTRAINT passport_driver_pkey;
ALTER TABLE ONLY public.passport_driver DROP CONSTRAINT passport_driver_driver_id_key;
ALTER TABLE ONLY public.passenger DROP CONSTRAINT passenger_pkey;
ALTER TABLE ONLY public.medical_checkup DROP CONSTRAINT medical_checkup_pkey;
ALTER TABLE ONLY public.intermediate_stop DROP CONSTRAINT intermediate_stop_pkey;
ALTER TABLE ONLY public.driver DROP CONSTRAINT driver_pkey;
ALTER TABLE ONLY public.crew DROP CONSTRAINT crew_pkey;
ALTER TABLE ONLY public.bus DROP CONSTRAINT bus_pkey;
ALTER TABLE ONLY public.bus_model DROP CONSTRAINT bus_model_pkey;
ALTER TABLE public.trip ALTER COLUMN trip_id DROP DEFAULT;
ALTER TABLE public.ticket ALTER COLUMN ticket_id DROP DEFAULT;
ALTER TABLE public.settlement ALTER COLUMN settlement_id DROP DEFAULT;
ALTER TABLE public.route_composition ALTER COLUMN route_composition_id DROP DEFAULT;
ALTER TABLE public.route ALTER COLUMN route_id DROP DEFAULT;
ALTER TABLE public.reason_for_disqualification ALTER COLUMN reason_id DROP DEFAULT;
ALTER TABLE public.passport_passenger ALTER COLUMN passport_id DROP DEFAULT;
ALTER TABLE public.passport_driver ALTER COLUMN passport_id DROP DEFAULT;
ALTER TABLE public.passenger ALTER COLUMN passenger_id DROP DEFAULT;
ALTER TABLE public.medical_checkup ALTER COLUMN checkup_id DROP DEFAULT;
ALTER TABLE public.intermediate_stop ALTER COLUMN stop_id DROP DEFAULT;
ALTER TABLE public.driver ALTER COLUMN driver_id DROP DEFAULT;
ALTER TABLE public.crew ALTER COLUMN crew_id DROP DEFAULT;
ALTER TABLE public.bus_model ALTER COLUMN bus_model_id DROP DEFAULT;
ALTER TABLE public.bus ALTER COLUMN bus_id DROP DEFAULT;
DROP SEQUENCE public.trip_trip_id_seq;
DROP TABLE public.trip;
DROP SEQUENCE public.ticket_ticket_id_seq;
DROP TABLE public.ticket;
DROP SEQUENCE public.settlement_settlement_id_seq;
DROP TABLE public.settlement;
DROP SEQUENCE public.route_route_id_seq;
DROP SEQUENCE public.route_composition_route_composition_id_seq;
DROP TABLE public.route_composition;
DROP TABLE public.route;
DROP SEQUENCE public.reason_for_disqualification_reason_id_seq;
DROP TABLE public.reason_for_disqualification;
DROP SEQUENCE public.passport_passenger_passport_id_seq;
DROP TABLE public.passport_passenger;
DROP SEQUENCE public.passport_driver_passport_id_seq;
DROP TABLE public.passport_driver;
DROP SEQUENCE public.passenger_passenger_id_seq;
DROP TABLE public.passenger;
DROP SEQUENCE public.medical_checkup_checkup_id_seq;
DROP TABLE public.medical_checkup;
DROP SEQUENCE public.intermediate_stop_stop_id_seq;
DROP TABLE public.intermediate_stop;
DROP SEQUENCE public.driver_driver_id_seq;
DROP TABLE public.driver;
DROP SEQUENCE public.crew_crew_id_seq;
DROP TABLE public.crew;
DROP SEQUENCE public.bus_model_bus_model_id_seq;
DROP TABLE public.bus_model;
DROP SEQUENCE public.bus_bus_id_seq;
DROP TABLE public.bus;
DROP SCHEMA public;
--
-- TOC entry 4 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: pg_database_owner
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO pg_database_owner;

--
-- TOC entry 5008 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: pg_database_owner
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 226 (class 1259 OID 26401)
-- Name: bus; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bus (
    bus_id integer NOT NULL,
    bus_model_id integer,
    production_year integer,
    registration_number character varying(255)
);


ALTER TABLE public.bus OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 26400)
-- Name: bus_bus_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.bus_bus_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.bus_bus_id_seq OWNER TO postgres;

--
-- TOC entry 5009 (class 0 OID 0)
-- Dependencies: 225
-- Name: bus_bus_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.bus_bus_id_seq OWNED BY public.bus.bus_id;


--
-- TOC entry 224 (class 1259 OID 26392)
-- Name: bus_model; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bus_model (
    bus_model_id integer NOT NULL,
    manufacturer character varying(255),
    model_name character varying(255),
    seats_number integer NOT NULL
);


ALTER TABLE public.bus_model OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 26391)
-- Name: bus_model_bus_model_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.bus_model_bus_model_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.bus_model_bus_model_id_seq OWNER TO postgres;

--
-- TOC entry 5010 (class 0 OID 0)
-- Dependencies: 223
-- Name: bus_model_bus_model_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.bus_model_bus_model_id_seq OWNED BY public.bus_model.bus_model_id;


--
-- TOC entry 246 (class 1259 OID 26534)
-- Name: crew; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.crew (
    crew_id integer NOT NULL,
    trip_id integer,
    passport_driver_id integer,
    medical_status character varying(50),
    medical_checkup_date date,
    reason_id integer
);


ALTER TABLE public.crew OWNER TO postgres;

--
-- TOC entry 245 (class 1259 OID 26533)
-- Name: crew_crew_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.crew_crew_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.crew_crew_id_seq OWNER TO postgres;

--
-- TOC entry 5011 (class 0 OID 0)
-- Dependencies: 245
-- Name: crew_crew_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.crew_crew_id_seq OWNED BY public.crew.crew_id;


--
-- TOC entry 240 (class 1259 OID 26504)
-- Name: driver; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.driver (
    driver_id integer NOT NULL,
    full_name character varying(255),
    phone_number character varying(20)
);


ALTER TABLE public.driver OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 26503)
-- Name: driver_driver_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.driver_driver_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.driver_driver_id_seq OWNER TO postgres;

--
-- TOC entry 5012 (class 0 OID 0)
-- Dependencies: 239
-- Name: driver_driver_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.driver_driver_id_seq OWNED BY public.driver.driver_id;


--
-- TOC entry 218 (class 1259 OID 26119)
-- Name: intermediate_stop; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.intermediate_stop (
    stop_id integer NOT NULL,
    stop_number integer,
    settlement_id integer
);


ALTER TABLE public.intermediate_stop OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 26118)
-- Name: intermediate_stop_stop_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.intermediate_stop_stop_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.intermediate_stop_stop_id_seq OWNER TO postgres;

--
-- TOC entry 5013 (class 0 OID 0)
-- Dependencies: 217
-- Name: intermediate_stop_stop_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.intermediate_stop_stop_id_seq OWNED BY public.intermediate_stop.stop_id;


--
-- TOC entry 220 (class 1259 OID 26195)
-- Name: medical_checkup; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.medical_checkup (
    checkup_id integer NOT NULL,
    checkup_date timestamp without time zone,
    status character varying(45),
    driver_id integer,
    reason_id integer
);


ALTER TABLE public.medical_checkup OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 26194)
-- Name: medical_checkup_checkup_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.medical_checkup_checkup_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.medical_checkup_checkup_id_seq OWNER TO postgres;

--
-- TOC entry 5014 (class 0 OID 0)
-- Dependencies: 219
-- Name: medical_checkup_checkup_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.medical_checkup_checkup_id_seq OWNED BY public.medical_checkup.checkup_id;


--
-- TOC entry 234 (class 1259 OID 26464)
-- Name: passenger; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.passenger (
    passenger_id integer NOT NULL,
    full_name character varying(255) NOT NULL
);


ALTER TABLE public.passenger OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 26463)
-- Name: passenger_passenger_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.passenger_passenger_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.passenger_passenger_id_seq OWNER TO postgres;

--
-- TOC entry 5015 (class 0 OID 0)
-- Dependencies: 233
-- Name: passenger_passenger_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.passenger_passenger_id_seq OWNED BY public.passenger.passenger_id;


--
-- TOC entry 242 (class 1259 OID 26511)
-- Name: passport_driver; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.passport_driver (
    passport_id integer NOT NULL,
    series integer,
    number integer,
    issue_date date,
    issue_place character varying(255),
    registration_address character varying(255),
    driver_id integer
);


ALTER TABLE public.passport_driver OWNER TO postgres;

--
-- TOC entry 241 (class 1259 OID 26510)
-- Name: passport_driver_passport_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.passport_driver_passport_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.passport_driver_passport_id_seq OWNER TO postgres;

--
-- TOC entry 5016 (class 0 OID 0)
-- Dependencies: 241
-- Name: passport_driver_passport_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.passport_driver_passport_id_seq OWNED BY public.passport_driver.passport_id;


--
-- TOC entry 236 (class 1259 OID 26471)
-- Name: passport_passenger; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.passport_passenger (
    passport_id integer NOT NULL,
    series integer,
    number integer,
    issue_date date,
    issue_place character varying(255),
    registration_address character varying(255),
    passenger_id integer
);


ALTER TABLE public.passport_passenger OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 26470)
-- Name: passport_passenger_passport_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.passport_passenger_passport_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.passport_passenger_passport_id_seq OWNER TO postgres;

--
-- TOC entry 5017 (class 0 OID 0)
-- Dependencies: 235
-- Name: passport_passenger_passport_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.passport_passenger_passport_id_seq OWNED BY public.passport_passenger.passport_id;


--
-- TOC entry 244 (class 1259 OID 26527)
-- Name: reason_for_disqualification; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reason_for_disqualification (
    reason_id integer NOT NULL,
    disease character varying(255)
);


ALTER TABLE public.reason_for_disqualification OWNER TO postgres;

--
-- TOC entry 243 (class 1259 OID 26526)
-- Name: reason_for_disqualification_reason_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.reason_for_disqualification_reason_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.reason_for_disqualification_reason_id_seq OWNER TO postgres;

--
-- TOC entry 5018 (class 0 OID 0)
-- Dependencies: 243
-- Name: reason_for_disqualification_reason_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.reason_for_disqualification_reason_id_seq OWNED BY public.reason_for_disqualification.reason_id;


--
-- TOC entry 228 (class 1259 OID 26413)
-- Name: route; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.route (
    route_id integer NOT NULL,
    name character varying(255),
    start_settlement_id integer,
    final_settlement_id integer,
    departure_time time without time zone,
    arrival_time time without time zone,
    travel_time interval
);


ALTER TABLE public.route OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 26430)
-- Name: route_composition; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.route_composition (
    route_composition_id integer NOT NULL,
    route_id integer,
    settlement_id integer,
    stop_number integer,
    arrival_time time without time zone,
    stop_duration interval
);


ALTER TABLE public.route_composition OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 26429)
-- Name: route_composition_route_composition_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.route_composition_route_composition_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.route_composition_route_composition_id_seq OWNER TO postgres;

--
-- TOC entry 5019 (class 0 OID 0)
-- Dependencies: 229
-- Name: route_composition_route_composition_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.route_composition_route_composition_id_seq OWNED BY public.route_composition.route_composition_id;


--
-- TOC entry 227 (class 1259 OID 26412)
-- Name: route_route_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.route_route_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.route_route_id_seq OWNER TO postgres;

--
-- TOC entry 5020 (class 0 OID 0)
-- Dependencies: 227
-- Name: route_route_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.route_route_id_seq OWNED BY public.route.route_id;


--
-- TOC entry 222 (class 1259 OID 26385)
-- Name: settlement; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.settlement (
    settlement_id integer NOT NULL,
    name character varying(255) NOT NULL
);


ALTER TABLE public.settlement OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 26384)
-- Name: settlement_settlement_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.settlement_settlement_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.settlement_settlement_id_seq OWNER TO postgres;

--
-- TOC entry 5021 (class 0 OID 0)
-- Dependencies: 221
-- Name: settlement_settlement_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.settlement_settlement_id_seq OWNED BY public.settlement.settlement_id;


--
-- TOC entry 238 (class 1259 OID 26487)
-- Name: ticket; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ticket (
    ticket_id integer NOT NULL,
    trip_id integer,
    passport_passenger_id integer,
    seat_number integer,
    status character varying(50)
);


ALTER TABLE public.ticket OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 26486)
-- Name: ticket_ticket_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ticket_ticket_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.ticket_ticket_id_seq OWNER TO postgres;

--
-- TOC entry 5022 (class 0 OID 0)
-- Dependencies: 237
-- Name: ticket_ticket_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ticket_ticket_id_seq OWNED BY public.ticket.ticket_id;


--
-- TOC entry 232 (class 1259 OID 26447)
-- Name: trip; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.trip (
    trip_id integer NOT NULL,
    route_id integer,
    bus_id integer,
    departure_date date,
    status character varying(50),
    price numeric(10,2)
);


ALTER TABLE public.trip OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 26446)
-- Name: trip_trip_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.trip_trip_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.trip_trip_id_seq OWNER TO postgres;

--
-- TOC entry 5023 (class 0 OID 0)
-- Dependencies: 231
-- Name: trip_trip_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.trip_trip_id_seq OWNED BY public.trip.trip_id;


--
-- TOC entry 4769 (class 2604 OID 26404)
-- Name: bus bus_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bus ALTER COLUMN bus_id SET DEFAULT nextval('public.bus_bus_id_seq'::regclass);


--
-- TOC entry 4768 (class 2604 OID 26395)
-- Name: bus_model bus_model_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bus_model ALTER COLUMN bus_model_id SET DEFAULT nextval('public.bus_model_bus_model_id_seq'::regclass);


--
-- TOC entry 4779 (class 2604 OID 26537)
-- Name: crew crew_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.crew ALTER COLUMN crew_id SET DEFAULT nextval('public.crew_crew_id_seq'::regclass);


--
-- TOC entry 4776 (class 2604 OID 26507)
-- Name: driver driver_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.driver ALTER COLUMN driver_id SET DEFAULT nextval('public.driver_driver_id_seq'::regclass);


--
-- TOC entry 4765 (class 2604 OID 26122)
-- Name: intermediate_stop stop_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.intermediate_stop ALTER COLUMN stop_id SET DEFAULT nextval('public.intermediate_stop_stop_id_seq'::regclass);


--
-- TOC entry 4766 (class 2604 OID 26198)
-- Name: medical_checkup checkup_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.medical_checkup ALTER COLUMN checkup_id SET DEFAULT nextval('public.medical_checkup_checkup_id_seq'::regclass);


--
-- TOC entry 4773 (class 2604 OID 26467)
-- Name: passenger passenger_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.passenger ALTER COLUMN passenger_id SET DEFAULT nextval('public.passenger_passenger_id_seq'::regclass);


--
-- TOC entry 4777 (class 2604 OID 26514)
-- Name: passport_driver passport_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.passport_driver ALTER COLUMN passport_id SET DEFAULT nextval('public.passport_driver_passport_id_seq'::regclass);


--
-- TOC entry 4774 (class 2604 OID 26474)
-- Name: passport_passenger passport_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.passport_passenger ALTER COLUMN passport_id SET DEFAULT nextval('public.passport_passenger_passport_id_seq'::regclass);


--
-- TOC entry 4778 (class 2604 OID 26530)
-- Name: reason_for_disqualification reason_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reason_for_disqualification ALTER COLUMN reason_id SET DEFAULT nextval('public.reason_for_disqualification_reason_id_seq'::regclass);


--
-- TOC entry 4770 (class 2604 OID 26416)
-- Name: route route_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.route ALTER COLUMN route_id SET DEFAULT nextval('public.route_route_id_seq'::regclass);


--
-- TOC entry 4771 (class 2604 OID 26433)
-- Name: route_composition route_composition_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.route_composition ALTER COLUMN route_composition_id SET DEFAULT nextval('public.route_composition_route_composition_id_seq'::regclass);


--
-- TOC entry 4767 (class 2604 OID 26388)
-- Name: settlement settlement_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.settlement ALTER COLUMN settlement_id SET DEFAULT nextval('public.settlement_settlement_id_seq'::regclass);


--
-- TOC entry 4775 (class 2604 OID 26490)
-- Name: ticket ticket_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ticket ALTER COLUMN ticket_id SET DEFAULT nextval('public.ticket_ticket_id_seq'::regclass);


--
-- TOC entry 4772 (class 2604 OID 26450)
-- Name: trip trip_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trip ALTER COLUMN trip_id SET DEFAULT nextval('public.trip_trip_id_seq'::regclass);


--
-- TOC entry 4982 (class 0 OID 26401)
-- Dependencies: 226
-- Data for Name: bus; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.bus VALUES (1, 1, 2020, 'A777AA77');


--
-- TOC entry 4980 (class 0 OID 26392)
-- Dependencies: 224
-- Data for Name: bus_model; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.bus_model VALUES (1, 'GAZ', 'Gazelle', 12);


--
-- TOC entry 5002 (class 0 OID 26534)
-- Dependencies: 246
-- Data for Name: crew; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.crew VALUES (1, 1, 1, 'Passed', '2025-01-01', NULL);


--
-- TOC entry 4996 (class 0 OID 26504)
-- Dependencies: 240
-- Data for Name: driver; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.driver VALUES (1, 'Ivan Ivanich', '79992220222');


--
-- TOC entry 4974 (class 0 OID 26119)
-- Dependencies: 218
-- Data for Name: intermediate_stop; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.intermediate_stop VALUES (1, 1, 1);
INSERT INTO public.intermediate_stop VALUES (2, 2, 2);


--
-- TOC entry 4976 (class 0 OID 26195)
-- Dependencies: 220
-- Data for Name: medical_checkup; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.medical_checkup VALUES (1, '2025-04-01 09:00:00', 'Passed', 1, NULL);


--
-- TOC entry 4990 (class 0 OID 26464)
-- Dependencies: 234
-- Data for Name: passenger; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.passenger VALUES (1, 'Andrey Sahur');


--
-- TOC entry 4998 (class 0 OID 26511)
-- Dependencies: 242
-- Data for Name: passport_driver; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.passport_driver VALUES (1, 1234, 123456, '1999-05-01', 'Pskov', 'Pskov, Krasniy ave. 1', 1);


--
-- TOC entry 4992 (class 0 OID 26471)
-- Dependencies: 236
-- Data for Name: passport_passenger; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.passport_passenger VALUES (1, 1111, 777111, '2002-02-01', 'Moscow', 'Moscow, Lesnaya st. 13', 1);


--
-- TOC entry 5000 (class 0 OID 26527)
-- Dependencies: 244
-- Data for Name: reason_for_disqualification; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.reason_for_disqualification VALUES (1, 'Heart disease');


--
-- TOC entry 4984 (class 0 OID 26413)
-- Dependencies: 228
-- Data for Name: route; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.route VALUES (1, 'Moscow - St. Petersburg', 1, 2, '08:00:00', '15:00:00', '07:00:00');
INSERT INTO public.route VALUES (2, 'Pskov - Moscow', 3, 1, '09:00:00', '17:00:00', '08:00:00');


--
-- TOC entry 4986 (class 0 OID 26430)
-- Dependencies: 230
-- Data for Name: route_composition; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.route_composition VALUES (1, 1, 1, 1, '08:00:00', '00:10:00');
INSERT INTO public.route_composition VALUES (2, 1, 2, 2, '15:00:00', '00:00:00');


--
-- TOC entry 4978 (class 0 OID 26385)
-- Dependencies: 222
-- Data for Name: settlement; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.settlement VALUES (1, 'Moscow');
INSERT INTO public.settlement VALUES (2, 'St. Petersburg');
INSERT INTO public.settlement VALUES (3, 'Pskov');


--
-- TOC entry 4994 (class 0 OID 26487)
-- Dependencies: 238
-- Data for Name: ticket; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.ticket VALUES (1, 1, 1, 5, 'Booked');


--
-- TOC entry 4988 (class 0 OID 26447)
-- Dependencies: 232
-- Data for Name: trip; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.trip VALUES (1, 1, 1, '2025-01-01', 'Boarding', 1500.00);


--
-- TOC entry 5024 (class 0 OID 0)
-- Dependencies: 225
-- Name: bus_bus_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.bus_bus_id_seq', 1, true);


--
-- TOC entry 5025 (class 0 OID 0)
-- Dependencies: 223
-- Name: bus_model_bus_model_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.bus_model_bus_model_id_seq', 1, true);


--
-- TOC entry 5026 (class 0 OID 0)
-- Dependencies: 245
-- Name: crew_crew_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.crew_crew_id_seq', 1, true);


--
-- TOC entry 5027 (class 0 OID 0)
-- Dependencies: 239
-- Name: driver_driver_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.driver_driver_id_seq', 1, true);


--
-- TOC entry 5028 (class 0 OID 0)
-- Dependencies: 217
-- Name: intermediate_stop_stop_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.intermediate_stop_stop_id_seq', 2, true);


--
-- TOC entry 5029 (class 0 OID 0)
-- Dependencies: 219
-- Name: medical_checkup_checkup_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.medical_checkup_checkup_id_seq', 1, true);


--
-- TOC entry 5030 (class 0 OID 0)
-- Dependencies: 233
-- Name: passenger_passenger_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.passenger_passenger_id_seq', 1, true);


--
-- TOC entry 5031 (class 0 OID 0)
-- Dependencies: 241
-- Name: passport_driver_passport_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.passport_driver_passport_id_seq', 1, true);


--
-- TOC entry 5032 (class 0 OID 0)
-- Dependencies: 235
-- Name: passport_passenger_passport_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.passport_passenger_passport_id_seq', 1, true);


--
-- TOC entry 5033 (class 0 OID 0)
-- Dependencies: 243
-- Name: reason_for_disqualification_reason_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.reason_for_disqualification_reason_id_seq', 1, true);


--
-- TOC entry 5034 (class 0 OID 0)
-- Dependencies: 229
-- Name: route_composition_route_composition_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.route_composition_route_composition_id_seq', 2, true);


--
-- TOC entry 5035 (class 0 OID 0)
-- Dependencies: 227
-- Name: route_route_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.route_route_id_seq', 2, true);


--
-- TOC entry 5036 (class 0 OID 0)
-- Dependencies: 221
-- Name: settlement_settlement_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.settlement_settlement_id_seq', 3, true);


--
-- TOC entry 5037 (class 0 OID 0)
-- Dependencies: 237
-- Name: ticket_ticket_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ticket_ticket_id_seq', 1, true);


--
-- TOC entry 5038 (class 0 OID 0)
-- Dependencies: 231
-- Name: trip_trip_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.trip_trip_id_seq', 1, true);


--
-- TOC entry 4787 (class 2606 OID 26399)
-- Name: bus_model bus_model_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bus_model
    ADD CONSTRAINT bus_model_pkey PRIMARY KEY (bus_model_id);


--
-- TOC entry 4789 (class 2606 OID 26406)
-- Name: bus bus_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bus
    ADD CONSTRAINT bus_pkey PRIMARY KEY (bus_id);


--
-- TOC entry 4813 (class 2606 OID 26539)
-- Name: crew crew_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.crew
    ADD CONSTRAINT crew_pkey PRIMARY KEY (crew_id);


--
-- TOC entry 4805 (class 2606 OID 26509)
-- Name: driver driver_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.driver
    ADD CONSTRAINT driver_pkey PRIMARY KEY (driver_id);


--
-- TOC entry 4781 (class 2606 OID 26124)
-- Name: intermediate_stop intermediate_stop_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.intermediate_stop
    ADD CONSTRAINT intermediate_stop_pkey PRIMARY KEY (stop_id);


--
-- TOC entry 4783 (class 2606 OID 26200)
-- Name: medical_checkup medical_checkup_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.medical_checkup
    ADD CONSTRAINT medical_checkup_pkey PRIMARY KEY (checkup_id);


--
-- TOC entry 4797 (class 2606 OID 26469)
-- Name: passenger passenger_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.passenger
    ADD CONSTRAINT passenger_pkey PRIMARY KEY (passenger_id);


--
-- TOC entry 4807 (class 2606 OID 26520)
-- Name: passport_driver passport_driver_driver_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.passport_driver
    ADD CONSTRAINT passport_driver_driver_id_key UNIQUE (driver_id);


--
-- TOC entry 4809 (class 2606 OID 26518)
-- Name: passport_driver passport_driver_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.passport_driver
    ADD CONSTRAINT passport_driver_pkey PRIMARY KEY (passport_id);


--
-- TOC entry 4799 (class 2606 OID 26480)
-- Name: passport_passenger passport_passenger_passenger_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.passport_passenger
    ADD CONSTRAINT passport_passenger_passenger_id_key UNIQUE (passenger_id);


--
-- TOC entry 4801 (class 2606 OID 26478)
-- Name: passport_passenger passport_passenger_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.passport_passenger
    ADD CONSTRAINT passport_passenger_pkey PRIMARY KEY (passport_id);


--
-- TOC entry 4811 (class 2606 OID 26532)
-- Name: reason_for_disqualification reason_for_disqualification_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reason_for_disqualification
    ADD CONSTRAINT reason_for_disqualification_pkey PRIMARY KEY (reason_id);


--
-- TOC entry 4793 (class 2606 OID 26435)
-- Name: route_composition route_composition_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.route_composition
    ADD CONSTRAINT route_composition_pkey PRIMARY KEY (route_composition_id);


--
-- TOC entry 4791 (class 2606 OID 26418)
-- Name: route route_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.route
    ADD CONSTRAINT route_pkey PRIMARY KEY (route_id);


--
-- TOC entry 4785 (class 2606 OID 26390)
-- Name: settlement settlement_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.settlement
    ADD CONSTRAINT settlement_pkey PRIMARY KEY (settlement_id);


--
-- TOC entry 4803 (class 2606 OID 26492)
-- Name: ticket ticket_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ticket
    ADD CONSTRAINT ticket_pkey PRIMARY KEY (ticket_id);


--
-- TOC entry 4795 (class 2606 OID 26452)
-- Name: trip trip_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trip
    ADD CONSTRAINT trip_pkey PRIMARY KEY (trip_id);


--
-- TOC entry 4814 (class 2606 OID 26407)
-- Name: bus bus_bus_model_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bus
    ADD CONSTRAINT bus_bus_model_id_fkey FOREIGN KEY (bus_model_id) REFERENCES public.bus_model(bus_model_id);


--
-- TOC entry 4825 (class 2606 OID 26545)
-- Name: crew crew_passport_driver_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.crew
    ADD CONSTRAINT crew_passport_driver_id_fkey FOREIGN KEY (passport_driver_id) REFERENCES public.passport_driver(passport_id);


--
-- TOC entry 4826 (class 2606 OID 26550)
-- Name: crew crew_reason_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.crew
    ADD CONSTRAINT crew_reason_id_fkey FOREIGN KEY (reason_id) REFERENCES public.reason_for_disqualification(reason_id);


--
-- TOC entry 4827 (class 2606 OID 26540)
-- Name: crew crew_trip_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.crew
    ADD CONSTRAINT crew_trip_id_fkey FOREIGN KEY (trip_id) REFERENCES public.trip(trip_id);


--
-- TOC entry 4824 (class 2606 OID 26521)
-- Name: passport_driver passport_driver_driver_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.passport_driver
    ADD CONSTRAINT passport_driver_driver_id_fkey FOREIGN KEY (driver_id) REFERENCES public.driver(driver_id);


--
-- TOC entry 4821 (class 2606 OID 26481)
-- Name: passport_passenger passport_passenger_passenger_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.passport_passenger
    ADD CONSTRAINT passport_passenger_passenger_id_fkey FOREIGN KEY (passenger_id) REFERENCES public.passenger(passenger_id);


--
-- TOC entry 4817 (class 2606 OID 26436)
-- Name: route_composition route_composition_route_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.route_composition
    ADD CONSTRAINT route_composition_route_id_fkey FOREIGN KEY (route_id) REFERENCES public.route(route_id);


--
-- TOC entry 4818 (class 2606 OID 26441)
-- Name: route_composition route_composition_settlement_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.route_composition
    ADD CONSTRAINT route_composition_settlement_id_fkey FOREIGN KEY (settlement_id) REFERENCES public.settlement(settlement_id);


--
-- TOC entry 4815 (class 2606 OID 26424)
-- Name: route route_final_settlement_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.route
    ADD CONSTRAINT route_final_settlement_id_fkey FOREIGN KEY (final_settlement_id) REFERENCES public.settlement(settlement_id);


--
-- TOC entry 4816 (class 2606 OID 26419)
-- Name: route route_start_settlement_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.route
    ADD CONSTRAINT route_start_settlement_id_fkey FOREIGN KEY (start_settlement_id) REFERENCES public.settlement(settlement_id);


--
-- TOC entry 4822 (class 2606 OID 26498)
-- Name: ticket ticket_passport_passenger_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ticket
    ADD CONSTRAINT ticket_passport_passenger_id_fkey FOREIGN KEY (passport_passenger_id) REFERENCES public.passport_passenger(passport_id);


--
-- TOC entry 4823 (class 2606 OID 26493)
-- Name: ticket ticket_trip_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ticket
    ADD CONSTRAINT ticket_trip_id_fkey FOREIGN KEY (trip_id) REFERENCES public.trip(trip_id);


--
-- TOC entry 4819 (class 2606 OID 26458)
-- Name: trip trip_bus_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trip
    ADD CONSTRAINT trip_bus_id_fkey FOREIGN KEY (bus_id) REFERENCES public.bus(bus_id);


--
-- TOC entry 4820 (class 2606 OID 26453)
-- Name: trip trip_route_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trip
    ADD CONSTRAINT trip_route_id_fkey FOREIGN KEY (route_id) REFERENCES public.route(route_id);


-- Completed on 2025-05-05 15:21:09

--
-- PostgreSQL database dump complete
--

