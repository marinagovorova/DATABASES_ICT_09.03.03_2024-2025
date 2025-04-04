--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4 (Debian 17.4-1.pgdg120+2)
-- Dumped by pg_dump version 17.0

-- Started on 2025-04-01 12:21:30 MSK

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
-- TOC entry 3567 (class 1262 OID 16384)
-- Name: lab3db; Type: DATABASE; Schema: -; Owner: user
--

CREATE DATABASE lab3db WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE lab3db OWNER TO "user";

\connect lab3db

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
-- TOC entry 4 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: pg_database_owner
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO pg_database_owner;

--
-- TOC entry 3568 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: pg_database_owner
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 226 (class 1259 OID 16426)
-- Name: carriage; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.carriage (
    carriage_id integer NOT NULL,
    number character varying(10) NOT NULL,
    type character varying(50) NOT NULL,
    seat_count integer NOT NULL,
    CONSTRAINT carriage_number_check CHECK (((number)::text <> ''::text)),
    CONSTRAINT carriage_seat_count_check CHECK ((seat_count > 0)),
    CONSTRAINT carriage_type_check CHECK (((type)::text <> ''::text))
);


ALTER TABLE public.carriage OWNER TO "user";

--
-- TOC entry 225 (class 1259 OID 16425)
-- Name: carriage_carriage_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.carriage_carriage_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.carriage_carriage_id_seq OWNER TO "user";

--
-- TOC entry 3569 (class 0 OID 0)
-- Dependencies: 225
-- Name: carriage_carriage_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.carriage_carriage_id_seq OWNED BY public.carriage.carriage_id;


--
-- TOC entry 228 (class 1259 OID 16436)
-- Name: passenger; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.passenger (
    passenger_id integer NOT NULL,
    last_name character varying(50) NOT NULL,
    first_name character varying(50) NOT NULL,
    middle_name character varying(50) NOT NULL,
    CONSTRAINT passenger_first_name_check CHECK (((first_name)::text <> ''::text)),
    CONSTRAINT passenger_last_name_check CHECK (((last_name)::text <> ''::text)),
    CONSTRAINT passenger_middle_name_check CHECK (((middle_name)::text <> ''::text))
);


ALTER TABLE public.passenger OWNER TO "user";

--
-- TOC entry 227 (class 1259 OID 16435)
-- Name: passenger_passenger_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.passenger_passenger_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.passenger_passenger_id_seq OWNER TO "user";

--
-- TOC entry 3570 (class 0 OID 0)
-- Dependencies: 227
-- Name: passenger_passenger_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.passenger_passenger_id_seq OWNED BY public.passenger.passenger_id;


--
-- TOC entry 242 (class 1259 OID 16581)
-- Name: passport; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.passport (
    passport_id integer NOT NULL,
    valid_from date NOT NULL,
    valid_to date NOT NULL,
    passport_data character varying(20) NOT NULL,
    passenger_id integer NOT NULL,
    CONSTRAINT chk_passport_dates CHECK ((valid_from < valid_to)),
    CONSTRAINT passport_passport_data_check CHECK (((passport_data)::text <> ''::text))
);


ALTER TABLE public.passport OWNER TO "user";

--
-- TOC entry 241 (class 1259 OID 16580)
-- Name: passport_passport_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.passport_passport_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.passport_passport_id_seq OWNER TO "user";

--
-- TOC entry 3571 (class 0 OID 0)
-- Dependencies: 241
-- Name: passport_passport_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.passport_passport_id_seq OWNED BY public.passport.passport_id;


--
-- TOC entry 220 (class 1259 OID 16396)
-- Name: purchase_method; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.purchase_method (
    purchase_method_id integer NOT NULL,
    name character varying(50) NOT NULL,
    CONSTRAINT purchase_method_name_check CHECK (((name)::text <> ''::text))
);


ALTER TABLE public.purchase_method OWNER TO "user";

--
-- TOC entry 219 (class 1259 OID 16395)
-- Name: purchase_method_purchase_method_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.purchase_method_purchase_method_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.purchase_method_purchase_method_id_seq OWNER TO "user";

--
-- TOC entry 3572 (class 0 OID 0)
-- Dependencies: 219
-- Name: purchase_method_purchase_method_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.purchase_method_purchase_method_id_seq OWNED BY public.purchase_method.purchase_method_id;


--
-- TOC entry 222 (class 1259 OID 16404)
-- Name: route; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.route (
    route_id integer NOT NULL,
    route_number integer NOT NULL,
    CONSTRAINT route_route_number_check CHECK ((route_number > 0))
);


ALTER TABLE public.route OWNER TO "user";

--
-- TOC entry 221 (class 1259 OID 16403)
-- Name: route_route_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.route_route_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.route_route_id_seq OWNER TO "user";

--
-- TOC entry 3573 (class 0 OID 0)
-- Dependencies: 221
-- Name: route_route_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.route_route_id_seq OWNED BY public.route.route_id;


--
-- TOC entry 246 (class 1259 OID 16612)
-- Name: route_stop; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.route_stop (
    stop_id integer NOT NULL,
    arrival_time date NOT NULL,
    departure_time date NOT NULL,
    stop_duration interval NOT NULL,
    route_id integer NOT NULL,
    station_id integer NOT NULL
);


ALTER TABLE public.route_stop OWNER TO "user";

--
-- TOC entry 245 (class 1259 OID 16611)
-- Name: route_stop_stop_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.route_stop_stop_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.route_stop_stop_id_seq OWNER TO "user";

--
-- TOC entry 3574 (class 0 OID 0)
-- Dependencies: 245
-- Name: route_stop_stop_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.route_stop_stop_id_seq OWNED BY public.route_stop.stop_id;


--
-- TOC entry 244 (class 1259 OID 16597)
-- Name: schedule; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.schedule (
    schedule_id integer NOT NULL,
    schedule_number character varying(10) NOT NULL,
    trip_id integer NOT NULL,
    CONSTRAINT schedule_schedule_number_check CHECK (((schedule_number)::text <> ''::text))
);


ALTER TABLE public.schedule OWNER TO "user";

--
-- TOC entry 243 (class 1259 OID 16596)
-- Name: schedule_schedule_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.schedule_schedule_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.schedule_schedule_id_seq OWNER TO "user";

--
-- TOC entry 3575 (class 0 OID 0)
-- Dependencies: 243
-- Name: schedule_schedule_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.schedule_schedule_id_seq OWNED BY public.schedule.schedule_id;


--
-- TOC entry 238 (class 1259 OID 16519)
-- Name: seat; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.seat (
    seat_id integer NOT NULL,
    number character varying(10) NOT NULL,
    type character varying(50) NOT NULL,
    status character varying(50) NOT NULL,
    carriage_id integer NOT NULL,
    train_composition_id integer NOT NULL,
    CONSTRAINT seat_number_check CHECK (((number)::text <> ''::text)),
    CONSTRAINT seat_status_check CHECK (((status)::text <> ''::text)),
    CONSTRAINT seat_type_check CHECK (((type)::text <> ''::text))
);


ALTER TABLE public.seat OWNER TO "user";

--
-- TOC entry 237 (class 1259 OID 16518)
-- Name: seat_seat_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.seat_seat_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seat_seat_id_seq OWNER TO "user";

--
-- TOC entry 3576 (class 0 OID 0)
-- Dependencies: 237
-- Name: seat_seat_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.seat_seat_id_seq OWNED BY public.seat.seat_id;


--
-- TOC entry 230 (class 1259 OID 16446)
-- Name: station; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.station (
    station_id integer NOT NULL,
    name character varying(100) NOT NULL,
    location character varying(255) NOT NULL,
    town_id integer NOT NULL,
    CONSTRAINT station_location_check CHECK (((location)::text <> ''::text)),
    CONSTRAINT station_name_check CHECK (((name)::text <> ''::text))
);


ALTER TABLE public.station OWNER TO "user";

--
-- TOC entry 229 (class 1259 OID 16445)
-- Name: station_station_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.station_station_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.station_station_id_seq OWNER TO "user";

--
-- TOC entry 3577 (class 0 OID 0)
-- Dependencies: 229
-- Name: station_station_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.station_station_id_seq OWNED BY public.station.station_id;


--
-- TOC entry 240 (class 1259 OID 16541)
-- Name: ticket; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.ticket (
    ticket_id integer NOT NULL,
    price numeric(10,2) NOT NULL,
    sale_date date NOT NULL,
    sale_type character varying(50) NOT NULL,
    status character varying(50) NOT NULL,
    trip_id integer NOT NULL,
    station_id integer NOT NULL,
    seat_id integer NOT NULL,
    purchase_method_id integer NOT NULL,
    passenger_id integer NOT NULL,
    ticket_office_id integer NOT NULL,
    CONSTRAINT ticket_price_check CHECK ((price > (0)::numeric)),
    CONSTRAINT ticket_sale_type_check CHECK (((sale_type)::text <> ''::text)),
    CONSTRAINT ticket_status_check CHECK (((status)::text <> ''::text))
);


ALTER TABLE public.ticket OWNER TO "user";

--
-- TOC entry 236 (class 1259 OID 16503)
-- Name: ticket_office; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.ticket_office (
    ticket_office_id integer NOT NULL,
    number character varying(10) NOT NULL,
    address character varying(255) NOT NULL,
    town_id integer NOT NULL,
    CONSTRAINT ticket_office_address_check CHECK (((address)::text <> ''::text)),
    CONSTRAINT ticket_office_number_check CHECK (((number)::text <> ''::text))
);


ALTER TABLE public.ticket_office OWNER TO "user";

--
-- TOC entry 235 (class 1259 OID 16502)
-- Name: ticket_office_ticket_office_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.ticket_office_ticket_office_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.ticket_office_ticket_office_id_seq OWNER TO "user";

--
-- TOC entry 3578 (class 0 OID 0)
-- Dependencies: 235
-- Name: ticket_office_ticket_office_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.ticket_office_ticket_office_id_seq OWNED BY public.ticket_office.ticket_office_id;


--
-- TOC entry 239 (class 1259 OID 16540)
-- Name: ticket_ticket_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.ticket_ticket_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.ticket_ticket_id_seq OWNER TO "user";

--
-- TOC entry 3579 (class 0 OID 0)
-- Dependencies: 239
-- Name: ticket_ticket_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.ticket_ticket_id_seq OWNED BY public.ticket.ticket_id;


--
-- TOC entry 218 (class 1259 OID 16386)
-- Name: town; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.town (
    town_id integer NOT NULL,
    name character varying(100) NOT NULL,
    location character varying(255) NOT NULL,
    type character varying(50) NOT NULL,
    CONSTRAINT town_location_check CHECK (((location)::text <> ''::text)),
    CONSTRAINT town_name_check CHECK (((name)::text <> ''::text)),
    CONSTRAINT town_type_check CHECK (((type)::text <> ''::text))
);


ALTER TABLE public.town OWNER TO "user";

--
-- TOC entry 217 (class 1259 OID 16385)
-- Name: town_town_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.town_town_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.town_town_id_seq OWNER TO "user";

--
-- TOC entry 3580 (class 0 OID 0)
-- Dependencies: 217
-- Name: town_town_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.town_town_id_seq OWNED BY public.town.town_id;


--
-- TOC entry 224 (class 1259 OID 16414)
-- Name: train; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.train (
    train_id integer NOT NULL,
    name character varying(100) NOT NULL,
    number character varying(10) NOT NULL,
    type character varying(50) NOT NULL,
    CONSTRAINT train_name_check CHECK (((name)::text <> ''::text)),
    CONSTRAINT train_number_check CHECK (((number)::text <> ''::text)),
    CONSTRAINT train_type_check CHECK (((type)::text <> ''::text))
);


ALTER TABLE public.train OWNER TO "user";

--
-- TOC entry 234 (class 1259 OID 16479)
-- Name: train_composition; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.train_composition (
    train_composition_id integer NOT NULL,
    train_id integer NOT NULL,
    carriage_id integer NOT NULL,
    trip_id integer NOT NULL
);


ALTER TABLE public.train_composition OWNER TO "user";

--
-- TOC entry 233 (class 1259 OID 16478)
-- Name: train_composition_train_composition_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.train_composition_train_composition_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.train_composition_train_composition_id_seq OWNER TO "user";

--
-- TOC entry 3581 (class 0 OID 0)
-- Dependencies: 233
-- Name: train_composition_train_composition_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.train_composition_train_composition_id_seq OWNED BY public.train_composition.train_composition_id;


--
-- TOC entry 223 (class 1259 OID 16413)
-- Name: train_train_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.train_train_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.train_train_id_seq OWNER TO "user";

--
-- TOC entry 3582 (class 0 OID 0)
-- Dependencies: 223
-- Name: train_train_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.train_train_id_seq OWNED BY public.train.train_id;


--
-- TOC entry 232 (class 1259 OID 16460)
-- Name: trip; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.trip (
    trip_id integer NOT NULL,
    arrival_date date NOT NULL,
    departure_date date NOT NULL,
    trip_type character varying(50) NOT NULL,
    route_id integer NOT NULL,
    train_id integer NOT NULL,
    CONSTRAINT chk_trip_dates CHECK ((departure_date < arrival_date)),
    CONSTRAINT trip_trip_type_check CHECK (((trip_type)::text <> ''::text))
);


ALTER TABLE public.trip OWNER TO "user";

--
-- TOC entry 231 (class 1259 OID 16459)
-- Name: trip_trip_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.trip_trip_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.trip_trip_id_seq OWNER TO "user";

--
-- TOC entry 3583 (class 0 OID 0)
-- Dependencies: 231
-- Name: trip_trip_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.trip_trip_id_seq OWNED BY public.trip.trip_id;


--
-- TOC entry 3284 (class 2604 OID 16429)
-- Name: carriage carriage_id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.carriage ALTER COLUMN carriage_id SET DEFAULT nextval('public.carriage_carriage_id_seq'::regclass);


--
-- TOC entry 3285 (class 2604 OID 16439)
-- Name: passenger passenger_id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.passenger ALTER COLUMN passenger_id SET DEFAULT nextval('public.passenger_passenger_id_seq'::regclass);


--
-- TOC entry 3292 (class 2604 OID 16584)
-- Name: passport passport_id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.passport ALTER COLUMN passport_id SET DEFAULT nextval('public.passport_passport_id_seq'::regclass);


--
-- TOC entry 3281 (class 2604 OID 16399)
-- Name: purchase_method purchase_method_id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.purchase_method ALTER COLUMN purchase_method_id SET DEFAULT nextval('public.purchase_method_purchase_method_id_seq'::regclass);


--
-- TOC entry 3282 (class 2604 OID 16407)
-- Name: route route_id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.route ALTER COLUMN route_id SET DEFAULT nextval('public.route_route_id_seq'::regclass);


--
-- TOC entry 3294 (class 2604 OID 16615)
-- Name: route_stop stop_id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.route_stop ALTER COLUMN stop_id SET DEFAULT nextval('public.route_stop_stop_id_seq'::regclass);


--
-- TOC entry 3293 (class 2604 OID 16600)
-- Name: schedule schedule_id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.schedule ALTER COLUMN schedule_id SET DEFAULT nextval('public.schedule_schedule_id_seq'::regclass);


--
-- TOC entry 3290 (class 2604 OID 16522)
-- Name: seat seat_id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.seat ALTER COLUMN seat_id SET DEFAULT nextval('public.seat_seat_id_seq'::regclass);


--
-- TOC entry 3286 (class 2604 OID 16449)
-- Name: station station_id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.station ALTER COLUMN station_id SET DEFAULT nextval('public.station_station_id_seq'::regclass);


--
-- TOC entry 3291 (class 2604 OID 16544)
-- Name: ticket ticket_id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.ticket ALTER COLUMN ticket_id SET DEFAULT nextval('public.ticket_ticket_id_seq'::regclass);


--
-- TOC entry 3289 (class 2604 OID 16506)
-- Name: ticket_office ticket_office_id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.ticket_office ALTER COLUMN ticket_office_id SET DEFAULT nextval('public.ticket_office_ticket_office_id_seq'::regclass);


--
-- TOC entry 3280 (class 2604 OID 16389)
-- Name: town town_id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.town ALTER COLUMN town_id SET DEFAULT nextval('public.town_town_id_seq'::regclass);


--
-- TOC entry 3283 (class 2604 OID 16417)
-- Name: train train_id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.train ALTER COLUMN train_id SET DEFAULT nextval('public.train_train_id_seq'::regclass);


--
-- TOC entry 3288 (class 2604 OID 16482)
-- Name: train_composition train_composition_id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.train_composition ALTER COLUMN train_composition_id SET DEFAULT nextval('public.train_composition_train_composition_id_seq'::regclass);


--
-- TOC entry 3287 (class 2604 OID 16463)
-- Name: trip trip_id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.trip ALTER COLUMN trip_id SET DEFAULT nextval('public.trip_trip_id_seq'::regclass);


--
-- TOC entry 3541 (class 0 OID 16426)
-- Dependencies: 226
-- Data for Name: carriage; Type: TABLE DATA; Schema: public; Owner: user
--

INSERT INTO public.carriage VALUES (1, '01', 'Купе', 36);
INSERT INTO public.carriage VALUES (2, '02', 'Плацкарт', 54);
INSERT INTO public.carriage VALUES (3, '03', 'СВ', 18);


--
-- TOC entry 3543 (class 0 OID 16436)
-- Dependencies: 228
-- Data for Name: passenger; Type: TABLE DATA; Schema: public; Owner: user
--

INSERT INTO public.passenger VALUES (1, 'Иванов', 'Иван', 'Иванович');
INSERT INTO public.passenger VALUES (2, 'Петров', 'Пётр', 'Петрович');
INSERT INTO public.passenger VALUES (3, 'Сидорова', 'Марина', 'Андреевна');


--
-- TOC entry 3557 (class 0 OID 16581)
-- Dependencies: 242
-- Data for Name: passport; Type: TABLE DATA; Schema: public; Owner: user
--

INSERT INTO public.passport VALUES (1, '2020-01-01', '2030-01-01', '1234 567890', 1);
INSERT INTO public.passport VALUES (2, '2021-05-10', '2031-05-10', '0987 654321', 2);
INSERT INTO public.passport VALUES (3, '2019-08-12', '2029-08-12', '1111 222222', 3);


--
-- TOC entry 3535 (class 0 OID 16396)
-- Dependencies: 220
-- Data for Name: purchase_method; Type: TABLE DATA; Schema: public; Owner: user
--

INSERT INTO public.purchase_method VALUES (1, 'Онлайн');
INSERT INTO public.purchase_method VALUES (2, 'В кассе');
INSERT INTO public.purchase_method VALUES (3, 'Мобильное приложение');


--
-- TOC entry 3537 (class 0 OID 16404)
-- Dependencies: 222
-- Data for Name: route; Type: TABLE DATA; Schema: public; Owner: user
--

INSERT INTO public.route VALUES (1, 101);
INSERT INTO public.route VALUES (2, 202);
INSERT INTO public.route VALUES (3, 303);


--
-- TOC entry 3561 (class 0 OID 16612)
-- Dependencies: 246
-- Data for Name: route_stop; Type: TABLE DATA; Schema: public; Owner: user
--

INSERT INTO public.route_stop VALUES (1, '2025-06-09', '2025-06-09', '00:30:00', 1, 1);
INSERT INTO public.route_stop VALUES (2, '2025-07-14', '2025-07-14', '00:45:00', 2, 2);
INSERT INTO public.route_stop VALUES (3, '2025-08-19', '2025-08-19', '01:00:00', 3, 3);


--
-- TOC entry 3559 (class 0 OID 16597)
-- Dependencies: 244
-- Data for Name: schedule; Type: TABLE DATA; Schema: public; Owner: user
--

INSERT INTO public.schedule VALUES (1, 'SCH1', 1);
INSERT INTO public.schedule VALUES (2, 'SCH2', 2);
INSERT INTO public.schedule VALUES (3, 'SCH3', 3);


--
-- TOC entry 3553 (class 0 OID 16519)
-- Dependencies: 238
-- Data for Name: seat; Type: TABLE DATA; Schema: public; Owner: user
--

INSERT INTO public.seat VALUES (1, '10', 'Верхнее', 'Свободно', 1, 1);
INSERT INTO public.seat VALUES (2, '22', 'Нижнее', 'Свободно', 1, 1);
INSERT INTO public.seat VALUES (3, '11', 'Окно', 'Свободно', 2, 2);


--
-- TOC entry 3545 (class 0 OID 16446)
-- Dependencies: 230
-- Data for Name: station; Type: TABLE DATA; Schema: public; Owner: user
--

INSERT INTO public.station VALUES (1, 'Казанский вокзал', 'Москва, Краснопрудная ул. 2', 1);
INSERT INTO public.station VALUES (2, 'Московский вокзал', 'Санкт-Петербург, Невский пр.85', 2);
INSERT INTO public.station VALUES (3, 'Вокзал Казань-1', 'Казань, Привокзальная пл. 1', 3);


--
-- TOC entry 3555 (class 0 OID 16541)
-- Dependencies: 240
-- Data for Name: ticket; Type: TABLE DATA; Schema: public; Owner: user
--

INSERT INTO public.ticket VALUES (1, 1500.00, '2025-06-01', 'Обычная продажа', 'Куплен', 1, 1, 1, 1, 1, 1);
INSERT INTO public.ticket VALUES (2, 3200.00, '2025-07-01', 'Предварительная', 'Куплен', 2, 2, 2, 2, 2, 2);
INSERT INTO public.ticket VALUES (3, 2200.00, '2025-08-01', 'Онлайн', 'Куплен', 3, 3, 3, 3, 3, 3);


--
-- TOC entry 3551 (class 0 OID 16503)
-- Dependencies: 236
-- Data for Name: ticket_office; Type: TABLE DATA; Schema: public; Owner: user
--

INSERT INTO public.ticket_office VALUES (1, '001', 'Москва, ул. Ленина 10', 1);
INSERT INTO public.ticket_office VALUES (2, '002', 'Санкт-Петербург, ул. Пушкина 20', 2);
INSERT INTO public.ticket_office VALUES (3, '003', 'Казань, ул. Баумана 15', 3);


--
-- TOC entry 3533 (class 0 OID 16386)
-- Dependencies: 218
-- Data for Name: town; Type: TABLE DATA; Schema: public; Owner: user
--

INSERT INTO public.town VALUES (1, 'Москва', 'Россия, г. Москва', 'город');
INSERT INTO public.town VALUES (2, 'Санкт-Петербург', 'Россия, г. Санкт-Петербург', 'город');
INSERT INTO public.town VALUES (3, 'Казань', 'Россия, Республика Татарстан', 'город');


--
-- TOC entry 3539 (class 0 OID 16414)
-- Dependencies: 224
-- Data for Name: train; Type: TABLE DATA; Schema: public; Owner: user
--

INSERT INTO public.train VALUES (1, 'Сапсан', '001A', 'Скоростной');
INSERT INTO public.train VALUES (2, 'Ласточка', '720B', 'Пригородный');
INSERT INTO public.train VALUES (3, 'Таврия', '163', 'Дальнего следования');


--
-- TOC entry 3549 (class 0 OID 16479)
-- Dependencies: 234
-- Data for Name: train_composition; Type: TABLE DATA; Schema: public; Owner: user
--

INSERT INTO public.train_composition VALUES (1, 1, 1, 1);
INSERT INTO public.train_composition VALUES (2, 2, 2, 2);
INSERT INTO public.train_composition VALUES (3, 3, 3, 3);


--
-- TOC entry 3547 (class 0 OID 16460)
-- Dependencies: 232
-- Data for Name: trip; Type: TABLE DATA; Schema: public; Owner: user
--

INSERT INTO public.trip VALUES (1, '2025-06-10', '2025-06-09', 'Обычный', 1, 1);
INSERT INTO public.trip VALUES (2, '2025-07-15', '2025-07-14', 'Скоростной', 2, 2);
INSERT INTO public.trip VALUES (3, '2025-08-20', '2025-08-19', 'Пассажирский', 3, 3);


--
-- TOC entry 3584 (class 0 OID 0)
-- Dependencies: 225
-- Name: carriage_carriage_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.carriage_carriage_id_seq', 3, true);


--
-- TOC entry 3585 (class 0 OID 0)
-- Dependencies: 227
-- Name: passenger_passenger_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.passenger_passenger_id_seq', 3, true);


--
-- TOC entry 3586 (class 0 OID 0)
-- Dependencies: 241
-- Name: passport_passport_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.passport_passport_id_seq', 3, true);


--
-- TOC entry 3587 (class 0 OID 0)
-- Dependencies: 219
-- Name: purchase_method_purchase_method_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.purchase_method_purchase_method_id_seq', 3, true);


--
-- TOC entry 3588 (class 0 OID 0)
-- Dependencies: 221
-- Name: route_route_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.route_route_id_seq', 3, true);


--
-- TOC entry 3589 (class 0 OID 0)
-- Dependencies: 245
-- Name: route_stop_stop_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.route_stop_stop_id_seq', 3, true);


--
-- TOC entry 3590 (class 0 OID 0)
-- Dependencies: 243
-- Name: schedule_schedule_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.schedule_schedule_id_seq', 3, true);


--
-- TOC entry 3591 (class 0 OID 0)
-- Dependencies: 237
-- Name: seat_seat_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.seat_seat_id_seq', 3, true);


--
-- TOC entry 3592 (class 0 OID 0)
-- Dependencies: 229
-- Name: station_station_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.station_station_id_seq', 3, true);


--
-- TOC entry 3593 (class 0 OID 0)
-- Dependencies: 235
-- Name: ticket_office_ticket_office_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.ticket_office_ticket_office_id_seq', 3, true);


--
-- TOC entry 3594 (class 0 OID 0)
-- Dependencies: 239
-- Name: ticket_ticket_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.ticket_ticket_id_seq', 3, true);


--
-- TOC entry 3595 (class 0 OID 0)
-- Dependencies: 217
-- Name: town_town_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.town_town_id_seq', 3, true);


--
-- TOC entry 3596 (class 0 OID 0)
-- Dependencies: 233
-- Name: train_composition_train_composition_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.train_composition_train_composition_id_seq', 3, true);


--
-- TOC entry 3597 (class 0 OID 0)
-- Dependencies: 223
-- Name: train_train_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.train_train_id_seq', 3, true);


--
-- TOC entry 3598 (class 0 OID 0)
-- Dependencies: 231
-- Name: trip_trip_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.trip_trip_id_seq', 3, true);


--
-- TOC entry 3337 (class 2606 OID 16434)
-- Name: carriage carriage_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.carriage
    ADD CONSTRAINT carriage_pkey PRIMARY KEY (carriage_id);


--
-- TOC entry 3339 (class 2606 OID 16444)
-- Name: passenger passenger_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.passenger
    ADD CONSTRAINT passenger_pkey PRIMARY KEY (passenger_id);


--
-- TOC entry 3359 (class 2606 OID 16588)
-- Name: passport passport_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.passport
    ADD CONSTRAINT passport_pkey PRIMARY KEY (passport_id);


--
-- TOC entry 3327 (class 2606 OID 16402)
-- Name: purchase_method purchase_method_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.purchase_method
    ADD CONSTRAINT purchase_method_pkey PRIMARY KEY (purchase_method_id);


--
-- TOC entry 3329 (class 2606 OID 16410)
-- Name: route route_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.route
    ADD CONSTRAINT route_pkey PRIMARY KEY (route_id);


--
-- TOC entry 3331 (class 2606 OID 16412)
-- Name: route route_route_number_key; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.route
    ADD CONSTRAINT route_route_number_key UNIQUE (route_number);


--
-- TOC entry 3367 (class 2606 OID 16617)
-- Name: route_stop route_stop_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.route_stop
    ADD CONSTRAINT route_stop_pkey PRIMARY KEY (stop_id);


--
-- TOC entry 3363 (class 2606 OID 16603)
-- Name: schedule schedule_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.schedule
    ADD CONSTRAINT schedule_pkey PRIMARY KEY (schedule_id);


--
-- TOC entry 3353 (class 2606 OID 16527)
-- Name: seat seat_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.seat
    ADD CONSTRAINT seat_pkey PRIMARY KEY (seat_id);


--
-- TOC entry 3341 (class 2606 OID 16453)
-- Name: station station_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.station
    ADD CONSTRAINT station_pkey PRIMARY KEY (station_id);


--
-- TOC entry 3349 (class 2606 OID 16512)
-- Name: ticket_office ticket_office_number_key; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.ticket_office
    ADD CONSTRAINT ticket_office_number_key UNIQUE (number);


--
-- TOC entry 3351 (class 2606 OID 16510)
-- Name: ticket_office ticket_office_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.ticket_office
    ADD CONSTRAINT ticket_office_pkey PRIMARY KEY (ticket_office_id);


--
-- TOC entry 3357 (class 2606 OID 16549)
-- Name: ticket ticket_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.ticket
    ADD CONSTRAINT ticket_pkey PRIMARY KEY (ticket_id);


--
-- TOC entry 3325 (class 2606 OID 16394)
-- Name: town town_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.town
    ADD CONSTRAINT town_pkey PRIMARY KEY (town_id);


--
-- TOC entry 3345 (class 2606 OID 16484)
-- Name: train_composition train_composition_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.train_composition
    ADD CONSTRAINT train_composition_pkey PRIMARY KEY (train_composition_id);


--
-- TOC entry 3333 (class 2606 OID 16424)
-- Name: train train_number_key; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.train
    ADD CONSTRAINT train_number_key UNIQUE (number);


--
-- TOC entry 3335 (class 2606 OID 16422)
-- Name: train train_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.train
    ADD CONSTRAINT train_pkey PRIMARY KEY (train_id);


--
-- TOC entry 3343 (class 2606 OID 16467)
-- Name: trip trip_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.trip
    ADD CONSTRAINT trip_pkey PRIMARY KEY (trip_id);


--
-- TOC entry 3347 (class 2606 OID 16486)
-- Name: train_composition uq_carriage_trip; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.train_composition
    ADD CONSTRAINT uq_carriage_trip UNIQUE (carriage_id, trip_id);


--
-- TOC entry 3361 (class 2606 OID 16590)
-- Name: passport uq_passport_data; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.passport
    ADD CONSTRAINT uq_passport_data UNIQUE (passport_data);


--
-- TOC entry 3365 (class 2606 OID 16605)
-- Name: schedule uq_schedule_number; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.schedule
    ADD CONSTRAINT uq_schedule_number UNIQUE (schedule_number);


--
-- TOC entry 3355 (class 2606 OID 16529)
-- Name: seat uq_seat_number_in_carriage; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.seat
    ADD CONSTRAINT uq_seat_number_in_carriage UNIQUE (number, carriage_id);


--
-- TOC entry 3371 (class 2606 OID 16492)
-- Name: train_composition fk_composition_carriage; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.train_composition
    ADD CONSTRAINT fk_composition_carriage FOREIGN KEY (carriage_id) REFERENCES public.carriage(carriage_id) MATCH FULL DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3372 (class 2606 OID 16487)
-- Name: train_composition fk_composition_train; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.train_composition
    ADD CONSTRAINT fk_composition_train FOREIGN KEY (train_id) REFERENCES public.train(train_id) MATCH FULL DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3373 (class 2606 OID 16497)
-- Name: train_composition fk_composition_trip; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.train_composition
    ADD CONSTRAINT fk_composition_trip FOREIGN KEY (trip_id) REFERENCES public.trip(trip_id) MATCH FULL DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3374 (class 2606 OID 16513)
-- Name: ticket_office fk_office_town; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.ticket_office
    ADD CONSTRAINT fk_office_town FOREIGN KEY (town_id) REFERENCES public.town(town_id) MATCH FULL DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3383 (class 2606 OID 16591)
-- Name: passport fk_passport_passenger; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.passport
    ADD CONSTRAINT fk_passport_passenger FOREIGN KEY (passenger_id) REFERENCES public.passenger(passenger_id) MATCH FULL DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3384 (class 2606 OID 16606)
-- Name: schedule fk_schedule_trip; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.schedule
    ADD CONSTRAINT fk_schedule_trip FOREIGN KEY (trip_id) REFERENCES public.trip(trip_id) MATCH FULL DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3375 (class 2606 OID 16530)
-- Name: seat fk_seat_carriage; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.seat
    ADD CONSTRAINT fk_seat_carriage FOREIGN KEY (carriage_id) REFERENCES public.carriage(carriage_id) MATCH FULL DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3376 (class 2606 OID 16535)
-- Name: seat fk_seat_composition; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.seat
    ADD CONSTRAINT fk_seat_composition FOREIGN KEY (train_composition_id) REFERENCES public.train_composition(train_composition_id) MATCH FULL DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3368 (class 2606 OID 16454)
-- Name: station fk_station_town; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.station
    ADD CONSTRAINT fk_station_town FOREIGN KEY (town_id) REFERENCES public.town(town_id) MATCH FULL DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3385 (class 2606 OID 16618)
-- Name: route_stop fk_stop_route; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.route_stop
    ADD CONSTRAINT fk_stop_route FOREIGN KEY (route_id) REFERENCES public.route(route_id) MATCH FULL DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3386 (class 2606 OID 16623)
-- Name: route_stop fk_stop_station; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.route_stop
    ADD CONSTRAINT fk_stop_station FOREIGN KEY (station_id) REFERENCES public.station(station_id) MATCH FULL DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3377 (class 2606 OID 16565)
-- Name: ticket fk_ticket_method; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.ticket
    ADD CONSTRAINT fk_ticket_method FOREIGN KEY (purchase_method_id) REFERENCES public.purchase_method(purchase_method_id) MATCH FULL DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3378 (class 2606 OID 16575)
-- Name: ticket fk_ticket_office; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.ticket
    ADD CONSTRAINT fk_ticket_office FOREIGN KEY (ticket_office_id) REFERENCES public.ticket_office(ticket_office_id) MATCH FULL DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3379 (class 2606 OID 16570)
-- Name: ticket fk_ticket_passenger; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.ticket
    ADD CONSTRAINT fk_ticket_passenger FOREIGN KEY (passenger_id) REFERENCES public.passenger(passenger_id) MATCH FULL DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3380 (class 2606 OID 16560)
-- Name: ticket fk_ticket_seat; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.ticket
    ADD CONSTRAINT fk_ticket_seat FOREIGN KEY (seat_id) REFERENCES public.seat(seat_id) MATCH FULL DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3381 (class 2606 OID 16555)
-- Name: ticket fk_ticket_station; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.ticket
    ADD CONSTRAINT fk_ticket_station FOREIGN KEY (station_id) REFERENCES public.station(station_id) MATCH FULL DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3382 (class 2606 OID 16550)
-- Name: ticket fk_ticket_trip; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.ticket
    ADD CONSTRAINT fk_ticket_trip FOREIGN KEY (trip_id) REFERENCES public.trip(trip_id) MATCH FULL DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3369 (class 2606 OID 16468)
-- Name: trip fk_trip_route; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.trip
    ADD CONSTRAINT fk_trip_route FOREIGN KEY (route_id) REFERENCES public.route(route_id) MATCH FULL DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3370 (class 2606 OID 16473)
-- Name: trip fk_trip_train; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.trip
    ADD CONSTRAINT fk_trip_train FOREIGN KEY (train_id) REFERENCES public.train(train_id) MATCH FULL DEFERRABLE INITIALLY DEFERRED;


-- Completed on 2025-04-01 12:21:31 MSK

--
-- PostgreSQL database dump complete
--

