--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4 (Debian 17.4-1.pgdg120+2)
-- Dumped by pg_dump version 17.0

-- Started on 2025-04-13 02:26:04 MSK

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
-- TOC entry 3561 (class 1262 OID 16384)
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
-- TOC entry 3562 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: pg_database_owner
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 230 (class 1259 OID 16460)
-- Name: carriage; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.carriage (
    carriage_id integer NOT NULL,
    carriage_number character varying(10) NOT NULL,
    carriage_type character varying(50) NOT NULL,
    seat_count integer NOT NULL,
    CONSTRAINT carriage_carriage_number_check CHECK (((carriage_number)::text <> ''::text)),
    CONSTRAINT carriage_carriage_type_check CHECK (((carriage_type)::text = ANY ((ARRAY['Купе'::character varying, 'Плацкарт'::character varying, 'СВ'::character varying])::text[]))),
    CONSTRAINT carriage_seat_count_check CHECK ((seat_count > 0))
);


ALTER TABLE public.carriage OWNER TO "user";

--
-- TOC entry 229 (class 1259 OID 16459)
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
-- TOC entry 3563 (class 0 OID 0)
-- Dependencies: 229
-- Name: carriage_carriage_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.carriage_carriage_id_seq OWNED BY public.carriage.carriage_id;


--
-- TOC entry 224 (class 1259 OID 16422)
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
-- TOC entry 223 (class 1259 OID 16421)
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
-- TOC entry 3564 (class 0 OID 0)
-- Dependencies: 223
-- Name: passenger_passenger_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.passenger_passenger_id_seq OWNED BY public.passenger.passenger_id;


--
-- TOC entry 226 (class 1259 OID 16432)
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
-- TOC entry 225 (class 1259 OID 16431)
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
-- TOC entry 3565 (class 0 OID 0)
-- Dependencies: 225
-- Name: passport_passport_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.passport_passport_id_seq OWNED BY public.passport.passport_id;


--
-- TOC entry 222 (class 1259 OID 16414)
-- Name: purchase_method; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.purchase_method (
    purchase_method_id integer NOT NULL,
    name character varying(50) NOT NULL,
    CONSTRAINT purchase_method_name_check CHECK (((name)::text = ANY ((ARRAY['Онлайн'::character varying, 'В кассе'::character varying, 'Мобильное приложение'::character varying])::text[])))
);


ALTER TABLE public.purchase_method OWNER TO "user";

--
-- TOC entry 221 (class 1259 OID 16413)
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
-- TOC entry 3566 (class 0 OID 0)
-- Dependencies: 221
-- Name: purchase_method_purchase_method_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.purchase_method_purchase_method_id_seq OWNED BY public.purchase_method.purchase_method_id;


--
-- TOC entry 232 (class 1259 OID 16470)
-- Name: route; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.route (
    route_id integer NOT NULL,
    route_number integer NOT NULL,
    train_type character varying(50) NOT NULL,
    departure_time time without time zone NOT NULL,
    arrival_time time without time zone NOT NULL,
    frequency character varying(50) NOT NULL,
    departure_station_id integer,
    arrival_station_id integer,
    CONSTRAINT chk_route_times CHECK ((departure_time < arrival_time)),
    CONSTRAINT route_frequency_check CHECK (((frequency)::text = ANY ((ARRAY['Ежедневно'::character varying, 'По будням'::character varying, 'По выходным'::character varying])::text[]))),
    CONSTRAINT route_route_number_check CHECK ((route_number > 0)),
    CONSTRAINT route_train_type_check CHECK (((train_type)::text = ANY ((ARRAY['Скоростной'::character varying, 'Пригородный'::character varying, 'Дальнего следования'::character varying])::text[])))
);


ALTER TABLE public.route OWNER TO "user";

--
-- TOC entry 231 (class 1259 OID 16469)
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
-- TOC entry 3567 (class 0 OID 0)
-- Dependencies: 231
-- Name: route_route_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.route_route_id_seq OWNED BY public.route.route_id;


--
-- TOC entry 244 (class 1259 OID 16620)
-- Name: route_stop; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.route_stop (
    stop_id integer NOT NULL,
    stop_order integer NOT NULL,
    arrival_time time without time zone NOT NULL,
    departure_time time without time zone NOT NULL,
    stop_duration interval NOT NULL,
    route_id integer NOT NULL,
    station_id integer NOT NULL,
    CONSTRAINT route_stop_stop_order_check CHECK ((stop_order > 0))
);


ALTER TABLE public.route_stop OWNER TO "user";

--
-- TOC entry 243 (class 1259 OID 16619)
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
-- TOC entry 3568 (class 0 OID 0)
-- Dependencies: 243
-- Name: route_stop_stop_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.route_stop_stop_id_seq OWNED BY public.route_stop.stop_id;


--
-- TOC entry 238 (class 1259 OID 16536)
-- Name: seat; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.seat (
    seat_id integer NOT NULL,
    seat_number character varying(10) NOT NULL,
    seat_type character varying(50) NOT NULL,
    status character varying(50) NOT NULL,
    carriage_id integer NOT NULL,
    train_composition_id integer NOT NULL,
    CONSTRAINT seat_seat_number_check CHECK (((seat_number)::text <> ''::text)),
    CONSTRAINT seat_seat_type_check CHECK (((seat_type)::text = ANY ((ARRAY['Верхнее'::character varying, 'Нижнее'::character varying, 'Окно'::character varying, 'Проход'::character varying])::text[]))),
    CONSTRAINT seat_status_check CHECK (((status)::text = ANY ((ARRAY['Свободно'::character varying, 'Занято'::character varying, 'Забронировано'::character varying])::text[])))
);


ALTER TABLE public.seat OWNER TO "user";

--
-- TOC entry 237 (class 1259 OID 16535)
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
-- TOC entry 3569 (class 0 OID 0)
-- Dependencies: 237
-- Name: seat_seat_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.seat_seat_id_seq OWNED BY public.seat.seat_id;


--
-- TOC entry 220 (class 1259 OID 16400)
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
-- TOC entry 219 (class 1259 OID 16399)
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
-- TOC entry 3570 (class 0 OID 0)
-- Dependencies: 219
-- Name: station_station_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.station_station_id_seq OWNED BY public.station.station_id;


--
-- TOC entry 242 (class 1259 OID 16574)
-- Name: ticket; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.ticket (
    ticket_id integer NOT NULL,
    price numeric(10,2) NOT NULL,
    sale_date date NOT NULL,
    sale_type character varying(50) NOT NULL,
    status character varying(50) NOT NULL,
    trip_id integer NOT NULL,
    station_departure_id integer,
    station_arrival_id integer,
    seat_id integer NOT NULL,
    purchase_method_id integer NOT NULL,
    passport_id integer NOT NULL,
    ticket_office_id integer NOT NULL,
    CONSTRAINT chk_ticket_stations CHECK (((station_departure_id IS NULL) OR (station_arrival_id IS NULL) OR (station_departure_id <> station_arrival_id))),
    CONSTRAINT ticket_price_check CHECK ((price > (0)::numeric)),
    CONSTRAINT ticket_sale_type_check CHECK (((sale_type)::text = ANY ((ARRAY['Онлайн'::character varying, 'Обычная продажа'::character varying, 'Предварительная'::character varying])::text[]))),
    CONSTRAINT ticket_status_check CHECK (((status)::text = ANY ((ARRAY['Куплен'::character varying, 'Возврат'::character varying, 'Аннулирован'::character varying])::text[])))
);


ALTER TABLE public.ticket OWNER TO "user";

--
-- TOC entry 240 (class 1259 OID 16558)
-- Name: ticket_office; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.ticket_office (
    ticket_office_id integer NOT NULL,
    office_number character varying(10) NOT NULL,
    address character varying(255) NOT NULL,
    town_id integer NOT NULL,
    CONSTRAINT ticket_office_address_check CHECK (((address)::text <> ''::text)),
    CONSTRAINT ticket_office_office_number_check CHECK (((office_number)::text <> ''::text))
);


ALTER TABLE public.ticket_office OWNER TO "user";

--
-- TOC entry 239 (class 1259 OID 16557)
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
-- TOC entry 3571 (class 0 OID 0)
-- Dependencies: 239
-- Name: ticket_office_ticket_office_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.ticket_office_ticket_office_id_seq OWNED BY public.ticket_office.ticket_office_id;


--
-- TOC entry 241 (class 1259 OID 16573)
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
-- TOC entry 3572 (class 0 OID 0)
-- Dependencies: 241
-- Name: ticket_ticket_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.ticket_ticket_id_seq OWNED BY public.ticket.ticket_id;


--
-- TOC entry 218 (class 1259 OID 16390)
-- Name: town; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.town (
    town_id integer NOT NULL,
    name character varying(100) NOT NULL,
    location character varying(255) NOT NULL,
    type character varying(50) NOT NULL,
    CONSTRAINT town_location_check CHECK (((location)::text <> ''::text)),
    CONSTRAINT town_name_check CHECK (((name)::text <> ''::text)),
    CONSTRAINT town_type_check CHECK (((type)::text = ANY ((ARRAY['город'::character varying, 'посёлок'::character varying, 'село'::character varying])::text[])))
);


ALTER TABLE public.town OWNER TO "user";

--
-- TOC entry 217 (class 1259 OID 16389)
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
-- TOC entry 3573 (class 0 OID 0)
-- Dependencies: 217
-- Name: town_town_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.town_town_id_seq OWNED BY public.town.town_id;


--
-- TOC entry 228 (class 1259 OID 16448)
-- Name: train; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.train (
    train_id integer NOT NULL,
    name character varying(100) NOT NULL,
    number character varying(10) NOT NULL,
    type character varying(50) NOT NULL,
    CONSTRAINT train_name_check CHECK (((name)::text <> ''::text)),
    CONSTRAINT train_number_check CHECK (((number)::text <> ''::text)),
    CONSTRAINT train_type_check CHECK (((type)::text = ANY ((ARRAY['Скоростной'::character varying, 'Пригородный'::character varying, 'Дальнего следования'::character varying])::text[])))
);


ALTER TABLE public.train OWNER TO "user";

--
-- TOC entry 236 (class 1259 OID 16512)
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
-- TOC entry 235 (class 1259 OID 16511)
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
-- TOC entry 3574 (class 0 OID 0)
-- Dependencies: 235
-- Name: train_composition_train_composition_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.train_composition_train_composition_id_seq OWNED BY public.train_composition.train_composition_id;


--
-- TOC entry 227 (class 1259 OID 16447)
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
-- TOC entry 3575 (class 0 OID 0)
-- Dependencies: 227
-- Name: train_train_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.train_train_id_seq OWNED BY public.train.train_id;


--
-- TOC entry 234 (class 1259 OID 16493)
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
    CONSTRAINT trip_trip_type_check CHECK (((trip_type)::text = ANY ((ARRAY['Обычный'::character varying, 'Скоростной'::character varying, 'Пассажирский'::character varying])::text[])))
);


ALTER TABLE public.trip OWNER TO "user";

--
-- TOC entry 233 (class 1259 OID 16492)
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
-- TOC entry 3576 (class 0 OID 0)
-- Dependencies: 233
-- Name: trip_trip_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.trip_trip_id_seq OWNED BY public.trip.trip_id;


--
-- TOC entry 3281 (class 2604 OID 16463)
-- Name: carriage carriage_id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.carriage ALTER COLUMN carriage_id SET DEFAULT nextval('public.carriage_carriage_id_seq'::regclass);


--
-- TOC entry 3278 (class 2604 OID 16425)
-- Name: passenger passenger_id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.passenger ALTER COLUMN passenger_id SET DEFAULT nextval('public.passenger_passenger_id_seq'::regclass);


--
-- TOC entry 3279 (class 2604 OID 16435)
-- Name: passport passport_id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.passport ALTER COLUMN passport_id SET DEFAULT nextval('public.passport_passport_id_seq'::regclass);


--
-- TOC entry 3277 (class 2604 OID 16417)
-- Name: purchase_method purchase_method_id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.purchase_method ALTER COLUMN purchase_method_id SET DEFAULT nextval('public.purchase_method_purchase_method_id_seq'::regclass);


--
-- TOC entry 3282 (class 2604 OID 16473)
-- Name: route route_id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.route ALTER COLUMN route_id SET DEFAULT nextval('public.route_route_id_seq'::regclass);


--
-- TOC entry 3288 (class 2604 OID 16623)
-- Name: route_stop stop_id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.route_stop ALTER COLUMN stop_id SET DEFAULT nextval('public.route_stop_stop_id_seq'::regclass);


--
-- TOC entry 3285 (class 2604 OID 16539)
-- Name: seat seat_id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.seat ALTER COLUMN seat_id SET DEFAULT nextval('public.seat_seat_id_seq'::regclass);


--
-- TOC entry 3276 (class 2604 OID 16403)
-- Name: station station_id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.station ALTER COLUMN station_id SET DEFAULT nextval('public.station_station_id_seq'::regclass);


--
-- TOC entry 3287 (class 2604 OID 16577)
-- Name: ticket ticket_id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.ticket ALTER COLUMN ticket_id SET DEFAULT nextval('public.ticket_ticket_id_seq'::regclass);


--
-- TOC entry 3286 (class 2604 OID 16561)
-- Name: ticket_office ticket_office_id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.ticket_office ALTER COLUMN ticket_office_id SET DEFAULT nextval('public.ticket_office_ticket_office_id_seq'::regclass);


--
-- TOC entry 3275 (class 2604 OID 16393)
-- Name: town town_id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.town ALTER COLUMN town_id SET DEFAULT nextval('public.town_town_id_seq'::regclass);


--
-- TOC entry 3280 (class 2604 OID 16451)
-- Name: train train_id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.train ALTER COLUMN train_id SET DEFAULT nextval('public.train_train_id_seq'::regclass);


--
-- TOC entry 3284 (class 2604 OID 16515)
-- Name: train_composition train_composition_id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.train_composition ALTER COLUMN train_composition_id SET DEFAULT nextval('public.train_composition_train_composition_id_seq'::regclass);


--
-- TOC entry 3283 (class 2604 OID 16496)
-- Name: trip trip_id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.trip ALTER COLUMN trip_id SET DEFAULT nextval('public.trip_trip_id_seq'::regclass);


--
-- TOC entry 3541 (class 0 OID 16460)
-- Dependencies: 230
-- Data for Name: carriage; Type: TABLE DATA; Schema: public; Owner: user
--

INSERT INTO public.carriage VALUES (1, '01', 'Купе', 36);
INSERT INTO public.carriage VALUES (2, '02', 'Плацкарт', 54);
INSERT INTO public.carriage VALUES (3, '03', 'СВ', 18);


--
-- TOC entry 3535 (class 0 OID 16422)
-- Dependencies: 224
-- Data for Name: passenger; Type: TABLE DATA; Schema: public; Owner: user
--

INSERT INTO public.passenger VALUES (1, 'Иванов', 'Иван', 'Иванович');
INSERT INTO public.passenger VALUES (2, 'Петров', 'Пётр', 'Петрович');
INSERT INTO public.passenger VALUES (3, 'Сидорова', 'Марина', 'Андреевна');


--
-- TOC entry 3537 (class 0 OID 16432)
-- Dependencies: 226
-- Data for Name: passport; Type: TABLE DATA; Schema: public; Owner: user
--

INSERT INTO public.passport VALUES (1, '2020-01-01', '2030-01-01', '1234 567890', 1);
INSERT INTO public.passport VALUES (2, '2021-05-10', '2031-05-10', '0987 654321', 2);
INSERT INTO public.passport VALUES (3, '2019-08-12', '2029-08-12', '1111 222222', 3);


--
-- TOC entry 3533 (class 0 OID 16414)
-- Dependencies: 222
-- Data for Name: purchase_method; Type: TABLE DATA; Schema: public; Owner: user
--

INSERT INTO public.purchase_method VALUES (1, 'Онлайн');
INSERT INTO public.purchase_method VALUES (2, 'В кассе');
INSERT INTO public.purchase_method VALUES (3, 'Мобильное приложение');


--
-- TOC entry 3543 (class 0 OID 16470)
-- Dependencies: 232
-- Data for Name: route; Type: TABLE DATA; Schema: public; Owner: user
--

INSERT INTO public.route VALUES (1, 101, 'Скоростной', '08:00:00', '12:30:00', 'Ежедневно', 1, 2);
INSERT INTO public.route VALUES (2, 202, 'Пригородный', '10:15:00', '15:00:00', 'По будням', 2, 3);
INSERT INTO public.route VALUES (3, 303, 'Дальнего следования', '06:45:00', '18:10:00', 'По выходным', 3, 1);


--
-- TOC entry 3555 (class 0 OID 16620)
-- Dependencies: 244
-- Data for Name: route_stop; Type: TABLE DATA; Schema: public; Owner: user
--

INSERT INTO public.route_stop VALUES (1, 1, '08:00:00', '08:05:00', '00:05:00', 1, 1);
INSERT INTO public.route_stop VALUES (2, 2, '10:15:00', '10:30:00', '00:15:00', 1, 2);
INSERT INTO public.route_stop VALUES (3, 1, '06:45:00', '06:50:00', '00:05:00', 2, 2);


--
-- TOC entry 3549 (class 0 OID 16536)
-- Dependencies: 238
-- Data for Name: seat; Type: TABLE DATA; Schema: public; Owner: user
--

INSERT INTO public.seat VALUES (1, '10', 'Верхнее', 'Свободно', 1, 1);
INSERT INTO public.seat VALUES (2, '22', 'Нижнее', 'Свободно', 1, 1);
INSERT INTO public.seat VALUES (3, '11', 'Окно', 'Свободно', 2, 2);


--
-- TOC entry 3531 (class 0 OID 16400)
-- Dependencies: 220
-- Data for Name: station; Type: TABLE DATA; Schema: public; Owner: user
--

INSERT INTO public.station VALUES (1, 'Казанский вокзал', 'Москва, Краснопрудная ул. 2', 1);
INSERT INTO public.station VALUES (2, 'Московский вокзал', 'Санкт-Петербург, Невский пр.85', 2);
INSERT INTO public.station VALUES (3, 'Вокзал Казань-1', 'Казань, Привокзальная пл. 1', 3);


--
-- TOC entry 3553 (class 0 OID 16574)
-- Dependencies: 242
-- Data for Name: ticket; Type: TABLE DATA; Schema: public; Owner: user
--

INSERT INTO public.ticket VALUES (1, 1500.00, '2025-06-01', 'Обычная продажа', 'Куплен', 1, 1, 2, 1, 1, 1, 1);
INSERT INTO public.ticket VALUES (2, 3200.00, '2025-07-01', 'Предварительная', 'Куплен', 2, 2, 3, 2, 2, 2, 2);
INSERT INTO public.ticket VALUES (3, 2200.00, '2025-08-01', 'Онлайн', 'Куплен', 3, 3, 1, 3, 3, 3, 3);


--
-- TOC entry 3551 (class 0 OID 16558)
-- Dependencies: 240
-- Data for Name: ticket_office; Type: TABLE DATA; Schema: public; Owner: user
--

INSERT INTO public.ticket_office VALUES (1, '001', 'Москва, ул. Ленина 10', 1);
INSERT INTO public.ticket_office VALUES (2, '002', 'Санкт-Петербург, ул. Пушкина 20', 2);
INSERT INTO public.ticket_office VALUES (3, '003', 'Казань, ул. Баумана 15', 3);


--
-- TOC entry 3529 (class 0 OID 16390)
-- Dependencies: 218
-- Data for Name: town; Type: TABLE DATA; Schema: public; Owner: user
--

INSERT INTO public.town VALUES (1, 'Москва', 'Россия, г. Москва', 'город');
INSERT INTO public.town VALUES (2, 'Санкт-Петербург', 'Россия, г. Санкт-Петербург', 'город');
INSERT INTO public.town VALUES (3, 'Казань', 'Россия, Республика Татарстан', 'город');


--
-- TOC entry 3539 (class 0 OID 16448)
-- Dependencies: 228
-- Data for Name: train; Type: TABLE DATA; Schema: public; Owner: user
--

INSERT INTO public.train VALUES (1, 'Сапсан', '001A', 'Скоростной');
INSERT INTO public.train VALUES (2, 'Ласточка', '720B', 'Пригородный');
INSERT INTO public.train VALUES (3, 'Таврия', '163', 'Дальнего следования');


--
-- TOC entry 3547 (class 0 OID 16512)
-- Dependencies: 236
-- Data for Name: train_composition; Type: TABLE DATA; Schema: public; Owner: user
--

INSERT INTO public.train_composition VALUES (1, 1, 1, 1);
INSERT INTO public.train_composition VALUES (2, 2, 2, 2);
INSERT INTO public.train_composition VALUES (3, 3, 3, 3);


--
-- TOC entry 3545 (class 0 OID 16493)
-- Dependencies: 234
-- Data for Name: trip; Type: TABLE DATA; Schema: public; Owner: user
--

INSERT INTO public.trip VALUES (1, '2025-06-10', '2025-06-09', 'Обычный', 1, 1);
INSERT INTO public.trip VALUES (2, '2025-07-15', '2025-07-14', 'Скоростной', 2, 2);
INSERT INTO public.trip VALUES (3, '2025-08-20', '2025-08-19', 'Пассажирский', 3, 3);


--
-- TOC entry 3577 (class 0 OID 0)
-- Dependencies: 229
-- Name: carriage_carriage_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.carriage_carriage_id_seq', 3, true);


--
-- TOC entry 3578 (class 0 OID 0)
-- Dependencies: 223
-- Name: passenger_passenger_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.passenger_passenger_id_seq', 3, true);


--
-- TOC entry 3579 (class 0 OID 0)
-- Dependencies: 225
-- Name: passport_passport_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.passport_passport_id_seq', 3, true);


--
-- TOC entry 3580 (class 0 OID 0)
-- Dependencies: 221
-- Name: purchase_method_purchase_method_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.purchase_method_purchase_method_id_seq', 3, true);


--
-- TOC entry 3581 (class 0 OID 0)
-- Dependencies: 231
-- Name: route_route_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.route_route_id_seq', 3, true);


--
-- TOC entry 3582 (class 0 OID 0)
-- Dependencies: 243
-- Name: route_stop_stop_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.route_stop_stop_id_seq', 3, true);


--
-- TOC entry 3583 (class 0 OID 0)
-- Dependencies: 237
-- Name: seat_seat_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.seat_seat_id_seq', 3, true);


--
-- TOC entry 3584 (class 0 OID 0)
-- Dependencies: 219
-- Name: station_station_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.station_station_id_seq', 3, true);


--
-- TOC entry 3585 (class 0 OID 0)
-- Dependencies: 239
-- Name: ticket_office_ticket_office_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.ticket_office_ticket_office_id_seq', 3, true);


--
-- TOC entry 3586 (class 0 OID 0)
-- Dependencies: 241
-- Name: ticket_ticket_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.ticket_ticket_id_seq', 3, true);


--
-- TOC entry 3587 (class 0 OID 0)
-- Dependencies: 217
-- Name: town_town_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.town_town_id_seq', 3, true);


--
-- TOC entry 3588 (class 0 OID 0)
-- Dependencies: 235
-- Name: train_composition_train_composition_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.train_composition_train_composition_id_seq', 3, true);


--
-- TOC entry 3589 (class 0 OID 0)
-- Dependencies: 227
-- Name: train_train_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.train_train_id_seq', 3, true);


--
-- TOC entry 3590 (class 0 OID 0)
-- Dependencies: 233
-- Name: trip_trip_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.trip_trip_id_seq', 3, true);


--
-- TOC entry 3339 (class 2606 OID 16468)
-- Name: carriage carriage_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.carriage
    ADD CONSTRAINT carriage_pkey PRIMARY KEY (carriage_id);


--
-- TOC entry 3329 (class 2606 OID 16430)
-- Name: passenger passenger_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.passenger
    ADD CONSTRAINT passenger_pkey PRIMARY KEY (passenger_id);


--
-- TOC entry 3331 (class 2606 OID 16439)
-- Name: passport passport_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.passport
    ADD CONSTRAINT passport_pkey PRIMARY KEY (passport_id);


--
-- TOC entry 3327 (class 2606 OID 16420)
-- Name: purchase_method purchase_method_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.purchase_method
    ADD CONSTRAINT purchase_method_pkey PRIMARY KEY (purchase_method_id);


--
-- TOC entry 3341 (class 2606 OID 16479)
-- Name: route route_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.route
    ADD CONSTRAINT route_pkey PRIMARY KEY (route_id);


--
-- TOC entry 3343 (class 2606 OID 16481)
-- Name: route route_route_number_key; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.route
    ADD CONSTRAINT route_route_number_key UNIQUE (route_number);


--
-- TOC entry 3361 (class 2606 OID 16626)
-- Name: route_stop route_stop_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.route_stop
    ADD CONSTRAINT route_stop_pkey PRIMARY KEY (stop_id);


--
-- TOC entry 3351 (class 2606 OID 16544)
-- Name: seat seat_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.seat
    ADD CONSTRAINT seat_pkey PRIMARY KEY (seat_id);


--
-- TOC entry 3325 (class 2606 OID 16407)
-- Name: station station_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.station
    ADD CONSTRAINT station_pkey PRIMARY KEY (station_id);


--
-- TOC entry 3355 (class 2606 OID 16567)
-- Name: ticket_office ticket_office_office_number_key; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.ticket_office
    ADD CONSTRAINT ticket_office_office_number_key UNIQUE (office_number);


--
-- TOC entry 3357 (class 2606 OID 16565)
-- Name: ticket_office ticket_office_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.ticket_office
    ADD CONSTRAINT ticket_office_pkey PRIMARY KEY (ticket_office_id);


--
-- TOC entry 3359 (class 2606 OID 16583)
-- Name: ticket ticket_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.ticket
    ADD CONSTRAINT ticket_pkey PRIMARY KEY (ticket_id);


--
-- TOC entry 3323 (class 2606 OID 16398)
-- Name: town town_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.town
    ADD CONSTRAINT town_pkey PRIMARY KEY (town_id);


--
-- TOC entry 3347 (class 2606 OID 16517)
-- Name: train_composition train_composition_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.train_composition
    ADD CONSTRAINT train_composition_pkey PRIMARY KEY (train_composition_id);


--
-- TOC entry 3335 (class 2606 OID 16458)
-- Name: train train_number_key; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.train
    ADD CONSTRAINT train_number_key UNIQUE (number);


--
-- TOC entry 3337 (class 2606 OID 16456)
-- Name: train train_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.train
    ADD CONSTRAINT train_pkey PRIMARY KEY (train_id);


--
-- TOC entry 3345 (class 2606 OID 16500)
-- Name: trip trip_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.trip
    ADD CONSTRAINT trip_pkey PRIMARY KEY (trip_id);


--
-- TOC entry 3349 (class 2606 OID 16519)
-- Name: train_composition uq_carriage_trip; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.train_composition
    ADD CONSTRAINT uq_carriage_trip UNIQUE (carriage_id, trip_id);


--
-- TOC entry 3333 (class 2606 OID 16441)
-- Name: passport uq_passport_data; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.passport
    ADD CONSTRAINT uq_passport_data UNIQUE (passport_data);


--
-- TOC entry 3353 (class 2606 OID 16546)
-- Name: seat uq_seat_number_in_carriage; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.seat
    ADD CONSTRAINT uq_seat_number_in_carriage UNIQUE (seat_number, carriage_id);


--
-- TOC entry 3363 (class 2606 OID 16442)
-- Name: passport passport_passenger_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.passport
    ADD CONSTRAINT passport_passenger_id_fkey FOREIGN KEY (passenger_id) REFERENCES public.passenger(passenger_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3364 (class 2606 OID 16487)
-- Name: route route_arrival_station_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.route
    ADD CONSTRAINT route_arrival_station_id_fkey FOREIGN KEY (arrival_station_id) REFERENCES public.station(station_id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 3365 (class 2606 OID 16482)
-- Name: route route_departure_station_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.route
    ADD CONSTRAINT route_departure_station_id_fkey FOREIGN KEY (departure_station_id) REFERENCES public.station(station_id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 3381 (class 2606 OID 16627)
-- Name: route_stop route_stop_route_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.route_stop
    ADD CONSTRAINT route_stop_route_id_fkey FOREIGN KEY (route_id) REFERENCES public.route(route_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3382 (class 2606 OID 16632)
-- Name: route_stop route_stop_station_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.route_stop
    ADD CONSTRAINT route_stop_station_id_fkey FOREIGN KEY (station_id) REFERENCES public.station(station_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3371 (class 2606 OID 16547)
-- Name: seat seat_carriage_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.seat
    ADD CONSTRAINT seat_carriage_id_fkey FOREIGN KEY (carriage_id) REFERENCES public.carriage(carriage_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3372 (class 2606 OID 16552)
-- Name: seat seat_train_composition_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.seat
    ADD CONSTRAINT seat_train_composition_id_fkey FOREIGN KEY (train_composition_id) REFERENCES public.train_composition(train_composition_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3362 (class 2606 OID 16408)
-- Name: station station_town_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.station
    ADD CONSTRAINT station_town_id_fkey FOREIGN KEY (town_id) REFERENCES public.town(town_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3373 (class 2606 OID 16568)
-- Name: ticket_office ticket_office_town_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.ticket_office
    ADD CONSTRAINT ticket_office_town_id_fkey FOREIGN KEY (town_id) REFERENCES public.town(town_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3374 (class 2606 OID 16609)
-- Name: ticket ticket_passport_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.ticket
    ADD CONSTRAINT ticket_passport_id_fkey FOREIGN KEY (passport_id) REFERENCES public.passport(passport_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3375 (class 2606 OID 16604)
-- Name: ticket ticket_purchase_method_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.ticket
    ADD CONSTRAINT ticket_purchase_method_id_fkey FOREIGN KEY (purchase_method_id) REFERENCES public.purchase_method(purchase_method_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3376 (class 2606 OID 16599)
-- Name: ticket ticket_seat_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.ticket
    ADD CONSTRAINT ticket_seat_id_fkey FOREIGN KEY (seat_id) REFERENCES public.seat(seat_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3377 (class 2606 OID 16594)
-- Name: ticket ticket_station_arrival_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.ticket
    ADD CONSTRAINT ticket_station_arrival_id_fkey FOREIGN KEY (station_arrival_id) REFERENCES public.station(station_id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 3378 (class 2606 OID 16589)
-- Name: ticket ticket_station_departure_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.ticket
    ADD CONSTRAINT ticket_station_departure_id_fkey FOREIGN KEY (station_departure_id) REFERENCES public.station(station_id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 3379 (class 2606 OID 16614)
-- Name: ticket ticket_ticket_office_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.ticket
    ADD CONSTRAINT ticket_ticket_office_id_fkey FOREIGN KEY (ticket_office_id) REFERENCES public.ticket_office(ticket_office_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3380 (class 2606 OID 16584)
-- Name: ticket ticket_trip_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.ticket
    ADD CONSTRAINT ticket_trip_id_fkey FOREIGN KEY (trip_id) REFERENCES public.trip(trip_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3368 (class 2606 OID 16525)
-- Name: train_composition train_composition_carriage_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.train_composition
    ADD CONSTRAINT train_composition_carriage_id_fkey FOREIGN KEY (carriage_id) REFERENCES public.carriage(carriage_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3369 (class 2606 OID 16520)
-- Name: train_composition train_composition_train_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.train_composition
    ADD CONSTRAINT train_composition_train_id_fkey FOREIGN KEY (train_id) REFERENCES public.train(train_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3370 (class 2606 OID 16530)
-- Name: train_composition train_composition_trip_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.train_composition
    ADD CONSTRAINT train_composition_trip_id_fkey FOREIGN KEY (trip_id) REFERENCES public.trip(trip_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3366 (class 2606 OID 16501)
-- Name: trip trip_route_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.trip
    ADD CONSTRAINT trip_route_id_fkey FOREIGN KEY (route_id) REFERENCES public.route(route_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3367 (class 2606 OID 16506)
-- Name: trip trip_train_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.trip
    ADD CONSTRAINT trip_train_id_fkey FOREIGN KEY (train_id) REFERENCES public.train(train_id) ON UPDATE CASCADE ON DELETE CASCADE;


-- Completed on 2025-04-13 02:26:04 MSK

--
-- PostgreSQL database dump complete
--

