--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4
-- Dumped by pg_dump version 17.4

-- Started on 2025-05-11 19:59:00 MSK

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
-- TOC entry 240 (class 1259 OID 16645)
-- Name: box_office; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.box_office (
    id integer NOT NULL,
    address character varying(300) NOT NULL,
    city character varying(100) NOT NULL,
    number integer NOT NULL,
    status character varying(50) NOT NULL,
    CONSTRAINT box_office_address_check CHECK (((address)::text ~ '^[A-Za-zА-Яа-я0-9 .,\-]+$'::text)),
    CONSTRAINT box_office_city_check CHECK (((city)::text ~ '^[A-Za-zА-Яа-я \-]+$'::text)),
    CONSTRAINT box_office_number_check CHECK ((number > 0)),
    CONSTRAINT box_office_status_check CHECK (((status)::text = ANY ((ARRAY['закрыта навсегда'::character varying, 'закрыта временно'::character varying, 'открыта'::character varying])::text[])))
);


ALTER TABLE public.box_office OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 16644)
-- Name: box_office_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.box_office_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.box_office_id_seq OWNER TO postgres;

--
-- TOC entry 3785 (class 0 OID 0)
-- Dependencies: 239
-- Name: box_office_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.box_office_id_seq OWNED BY public.box_office.id;


--
-- TOC entry 230 (class 1259 OID 16551)
-- Name: carriage; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.carriage (
    id integer NOT NULL,
    number integer NOT NULL,
    status character varying(100) NOT NULL,
    id_type integer,
    CONSTRAINT check_carriage_number CHECK ((number > 0)),
    CONSTRAINT check_carriage_status CHECK (((status)::text = ANY ((ARRAY['готов'::character varying, 'в ремонте'::character varying, 'не готов'::character varying])::text[])))
);


ALTER TABLE public.carriage OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 16532)
-- Name: train; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.train (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    number integer NOT NULL,
    notes character varying(300),
    departure_station integer NOT NULL,
    arrival_station integer NOT NULL,
    departure_time time without time zone NOT NULL,
    arrival_time time without time zone NOT NULL,
    train_type character varying(100) NOT NULL,
    CONSTRAINT train_check CHECK ((departure_time <= arrival_time)),
    CONSTRAINT train_name_check1 CHECK (((name)::text ~ '^[A-Za-zА-Яа-яЁё \-]+$'::text)),
    CONSTRAINT train_number_check CHECK ((number > 0)),
    CONSTRAINT train_train_type_check CHECK (((train_type)::text = ANY ((ARRAY['скоростной'::character varying, 'скорый'::character varying, 'пассажирский'::character varying])::text[])))
);


ALTER TABLE public.train OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 16531)
-- Name: carriage_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.carriage_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.carriage_id_seq OWNER TO postgres;

--
-- TOC entry 3786 (class 0 OID 0)
-- Dependencies: 227
-- Name: carriage_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.carriage_id_seq OWNED BY public.train.id;


--
-- TOC entry 229 (class 1259 OID 16550)
-- Name: carriage_id_seq1; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.carriage_id_seq1
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.carriage_id_seq1 OWNER TO postgres;

--
-- TOC entry 3787 (class 0 OID 0)
-- Dependencies: 229
-- Name: carriage_id_seq1; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.carriage_id_seq1 OWNED BY public.carriage.id;


--
-- TOC entry 222 (class 1259 OID 16511)
-- Name: carriage_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.carriage_type (
    id integer NOT NULL,
    place_count integer NOT NULL,
    carriage_type character varying(50) NOT NULL,
    class_of_service character varying(50) NOT NULL,
    CONSTRAINT carriage_type_carriage_type_check CHECK (((carriage_type)::text = ANY ((ARRAY['купейный'::character varying, 'СВ'::character varying, 'плацкартный'::character varying, 'вагон-ресторан'::character varying])::text[]))),
    CONSTRAINT carriage_type_class_of_service_check CHECK (((class_of_service)::text = ANY ((ARRAY['комфорт'::character varying, 'бизнес'::character varying, 'эконом'::character varying])::text[]))),
    CONSTRAINT carriage_type_place_count_check CHECK ((place_count >= 0))
);


ALTER TABLE public.carriage_type OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16510)
-- Name: carriage_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.carriage_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.carriage_type_id_seq OWNER TO postgres;

--
-- TOC entry 3788 (class 0 OID 0)
-- Dependencies: 221
-- Name: carriage_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.carriage_type_id_seq OWNED BY public.carriage_type.id;


--
-- TOC entry 224 (class 1259 OID 16518)
-- Name: discount; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.discount (
    id integer NOT NULL,
    discount_amount integer NOT NULL,
    start_date date NOT NULL,
    end_date date NOT NULL,
    CONSTRAINT discount_check CHECK ((end_date >= start_date)),
    CONSTRAINT discount_check1 CHECK ((start_date <= end_date)),
    CONSTRAINT discount_discount_amount_check CHECK ((discount_amount >= 0))
);


ALTER TABLE public.discount OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16517)
-- Name: discount_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.discount_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.discount_id_seq OWNER TO postgres;

--
-- TOC entry 3789 (class 0 OID 0)
-- Dependencies: 223
-- Name: discount_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.discount_id_seq OWNED BY public.discount.id;


--
-- TOC entry 232 (class 1259 OID 16558)
-- Name: flight; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.flight (
    id integer NOT NULL,
    id_train integer NOT NULL,
    departure_date date,
    arrival_date date,
    status character varying(100) NOT NULL,
    CONSTRAINT flight_check CHECK ((departure_date <= arrival_date)),
    CONSTRAINT flight_status_check CHECK (((status)::text = ANY ((ARRAY['в пути'::character varying, 'прибывает'::character varying, 'отправлен'::character varying, 'задержан'::character varying, 'отменен'::character varying])::text[])))
);


ALTER TABLE public.flight OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 16557)
-- Name: flight_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.flight_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.flight_id_seq OWNER TO postgres;

--
-- TOC entry 3790 (class 0 OID 0)
-- Dependencies: 231
-- Name: flight_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.flight_id_seq OWNED BY public.flight.id;


--
-- TOC entry 234 (class 1259 OID 16570)
-- Name: flight_stops; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.flight_stops (
    id integer NOT NULL,
    id_train integer NOT NULL,
    id_station integer NOT NULL,
    departure_time time without time zone,
    arrival_time time without time zone,
    number_of_stops_in_turn integer NOT NULL,
    CONSTRAINT flight_stops_check CHECK ((departure_time <= arrival_time)),
    CONSTRAINT flight_stops_number_of_stops_in_turn_check CHECK ((number_of_stops_in_turn > 0))
);


ALTER TABLE public.flight_stops OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 16569)
-- Name: flight_stops_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.flight_stops_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.flight_stops_id_seq OWNER TO postgres;

--
-- TOC entry 3791 (class 0 OID 0)
-- Dependencies: 233
-- Name: flight_stops_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.flight_stops_id_seq OWNED BY public.flight_stops.id;


--
-- TOC entry 218 (class 1259 OID 16477)
-- Name: passenger; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.passenger (
    id integer NOT NULL,
    initial character varying(100) NOT NULL,
    email character varying(100) NOT NULL,
    phone_number character varying(100) NOT NULL,
    CONSTRAINT passenger_email_check CHECK (((email)::text ~ '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'::text)),
    CONSTRAINT passenger_initial_check2 CHECK (((initial)::text ~ '^[А-Яа-яЁё \-]+$'::text)),
    CONSTRAINT passenger_phone_number_check CHECK (((phone_number)::text ~ '^\+7\d{10}$'::text))
);


ALTER TABLE public.passenger OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16476)
-- Name: passenger_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.passenger_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.passenger_id_seq OWNER TO postgres;

--
-- TOC entry 3792 (class 0 OID 0)
-- Dependencies: 217
-- Name: passenger_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.passenger_id_seq OWNED BY public.passenger.id;


--
-- TOC entry 220 (class 1259 OID 16488)
-- Name: passport; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.passport (
    id integer NOT NULL,
    id_passenger integer NOT NULL,
    passport_data character varying(20) NOT NULL,
    date_of_issue date NOT NULL,
    date_of_expiry date NOT NULL,
    initial character varying(200) NOT NULL,
    CONSTRAINT passport_check CHECK ((date_of_issue <= date_of_expiry)),
    CONSTRAINT passport_initial_check CHECK (((initial)::text ~ '^[А-Яа-яЁёA-Za-z \-]+$'::text)),
    CONSTRAINT passport_passport_data_check CHECK (((passport_data)::text ~ '^\d{1,20}$'::text))
);


ALTER TABLE public.passport OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16487)
-- Name: passport_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.passport_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.passport_id_seq OWNER TO postgres;

--
-- TOC entry 3793 (class 0 OID 0)
-- Dependencies: 219
-- Name: passport_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.passport_id_seq OWNED BY public.passport.id;


--
-- TOC entry 238 (class 1259 OID 16610)
-- Name: seat; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.seat (
    id integer NOT NULL,
    id_train integer NOT NULL,
    number_in_carriage integer NOT NULL,
    service_class character varying(10) NOT NULL,
    CONSTRAINT seat_number_in_carriage_check CHECK ((number_in_carriage > 0)),
    CONSTRAINT seat_service_class_check CHECK (((service_class)::text = ANY ((ARRAY['комфорт'::character varying, 'бизнес'::character varying, 'эконом'::character varying])::text[])))
);


ALTER TABLE public.seat OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 16609)
-- Name: seat_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seat_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seat_id_seq OWNER TO postgres;

--
-- TOC entry 3794 (class 0 OID 0)
-- Dependencies: 237
-- Name: seat_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.seat_id_seq OWNED BY public.seat.id;


--
-- TOC entry 226 (class 1259 OID 16525)
-- Name: station; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.station (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    country character varying(100) NOT NULL,
    type_of_locality character varying(100) NOT NULL,
    CONSTRAINT station_country_check1 CHECK (((country)::text ~ '^[A-Za-zА-Яа-яЁё \-]+$'::text)),
    CONSTRAINT station_name_check CHECK (((name)::text ~ '^[A-Za-z0-9А-Яа-яЁё ,.\-]+$'::text)),
    CONSTRAINT station_type_of_locality_check CHECK (((type_of_locality)::text ~ '^[A-Za-zА-Яа-яЁё \-]+$'::text))
);


ALTER TABLE public.station OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16524)
-- Name: station_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.station_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.station_id_seq OWNER TO postgres;

--
-- TOC entry 3795 (class 0 OID 0)
-- Dependencies: 225
-- Name: station_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.station_id_seq OWNED BY public.station.id;


--
-- TOC entry 242 (class 1259 OID 16661)
-- Name: ticket; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ticket (
    id integer NOT NULL,
    id_flight integer NOT NULL,
    datetime_departure timestamp without time zone NOT NULL,
    datetime_arrival timestamp without time zone NOT NULL,
    dropoff_point integer NOT NULL,
    status character varying(15) NOT NULL,
    id_seat integer,
    boarding_point integer NOT NULL,
    price double precision NOT NULL,
    base_price double precision NOT NULL,
    purchase_date timestamp without time zone NOT NULL,
    id_passport integer,
    CONSTRAINT ticket_base_price_check CHECK ((base_price >= (0)::double precision)),
    CONSTRAINT ticket_check CHECK ((datetime_departure < datetime_arrival)),
    CONSTRAINT ticket_check1 CHECK ((datetime_arrival > datetime_departure)),
    CONSTRAINT ticket_check2 CHECK ((purchase_date < datetime_departure)),
    CONSTRAINT ticket_price_check CHECK ((price >= (0)::double precision)),
    CONSTRAINT ticket_status_check CHECK (((status)::text = ANY ((ARRAY['оплачен'::character varying, 'забронирован'::character varying, 'отменен'::character varying])::text[])))
);


ALTER TABLE public.ticket OWNER TO postgres;

--
-- TOC entry 241 (class 1259 OID 16660)
-- Name: ticket_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ticket_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.ticket_id_seq OWNER TO postgres;

--
-- TOC entry 3796 (class 0 OID 0)
-- Dependencies: 241
-- Name: ticket_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ticket_id_seq OWNED BY public.ticket.id;


--
-- TOC entry 236 (class 1259 OID 16587)
-- Name: train_consist; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.train_consist (
    id integer NOT NULL,
    id_flight integer NOT NULL,
    id_carriage integer NOT NULL,
    number integer NOT NULL,
    status character varying(100) NOT NULL,
    CONSTRAINT train_consist_number CHECK ((number > 0)),
    CONSTRAINT train_consist_status CHECK (((status)::text = ANY ((ARRAY['готов'::character varying, 'не готов'::character varying])::text[])))
);


ALTER TABLE public.train_consist OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 16586)
-- Name: train_consist_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.train_consist_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.train_consist_id_seq OWNER TO postgres;

--
-- TOC entry 3797 (class 0 OID 0)
-- Dependencies: 235
-- Name: train_consist_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.train_consist_id_seq OWNED BY public.train_consist.id;


--
-- TOC entry 3521 (class 2604 OID 16648)
-- Name: box_office id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.box_office ALTER COLUMN id SET DEFAULT nextval('public.box_office_id_seq'::regclass);


--
-- TOC entry 3516 (class 2604 OID 16554)
-- Name: carriage id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carriage ALTER COLUMN id SET DEFAULT nextval('public.carriage_id_seq1'::regclass);


--
-- TOC entry 3512 (class 2604 OID 16514)
-- Name: carriage_type id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carriage_type ALTER COLUMN id SET DEFAULT nextval('public.carriage_type_id_seq'::regclass);


--
-- TOC entry 3513 (class 2604 OID 16521)
-- Name: discount id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.discount ALTER COLUMN id SET DEFAULT nextval('public.discount_id_seq'::regclass);


--
-- TOC entry 3517 (class 2604 OID 16561)
-- Name: flight id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.flight ALTER COLUMN id SET DEFAULT nextval('public.flight_id_seq'::regclass);


--
-- TOC entry 3518 (class 2604 OID 16573)
-- Name: flight_stops id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.flight_stops ALTER COLUMN id SET DEFAULT nextval('public.flight_stops_id_seq'::regclass);


--
-- TOC entry 3510 (class 2604 OID 16480)
-- Name: passenger id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.passenger ALTER COLUMN id SET DEFAULT nextval('public.passenger_id_seq'::regclass);


--
-- TOC entry 3511 (class 2604 OID 16491)
-- Name: passport id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.passport ALTER COLUMN id SET DEFAULT nextval('public.passport_id_seq'::regclass);


--
-- TOC entry 3520 (class 2604 OID 16613)
-- Name: seat id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.seat ALTER COLUMN id SET DEFAULT nextval('public.seat_id_seq'::regclass);


--
-- TOC entry 3514 (class 2604 OID 16528)
-- Name: station id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.station ALTER COLUMN id SET DEFAULT nextval('public.station_id_seq'::regclass);


--
-- TOC entry 3522 (class 2604 OID 16664)
-- Name: ticket id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ticket ALTER COLUMN id SET DEFAULT nextval('public.ticket_id_seq'::regclass);


--
-- TOC entry 3515 (class 2604 OID 16535)
-- Name: train id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.train ALTER COLUMN id SET DEFAULT nextval('public.carriage_id_seq'::regclass);


--
-- TOC entry 3519 (class 2604 OID 16590)
-- Name: train_consist id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.train_consist ALTER COLUMN id SET DEFAULT nextval('public.train_consist_id_seq'::regclass);


--
-- TOC entry 3777 (class 0 OID 16645)
-- Dependencies: 240
-- Data for Name: box_office; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.box_office (id, address, city, number, status) FROM stdin;
312	Невский просп., 85	Санкт-Петербург	1	открыта
313	Невский просп., 85	Санкт-Петербург	2	открыта
314	Невский просп., 85	Санкт-Петербург	3	открыта
315	Заневский просп., 73	Санкт-Петербург	1	открыта
316	Заневский просп., 73	Санкт-Петербург	2	открыта
317	Заневский просп., 73	Санкт-Петербург	5	закрыта временно
318	Загородный проспект, 52	Санкт-Петербург	1	открыта
319	Загородный проспект, 52	Санкт-Петербург	2	открыта
320	Загородный проспект, 52	Санкт-Петербург	3	открыта
321	пл. Ленина 6, лит. Е	Санкт-Петербург	1	открыта
322	пл. Ленина 6, лит. Е	Санкт-Петербург	4	закрыта временно
323	пл. Ленина 6, лит. Е	Санкт-Петербург	3	открыта
324	наб. Обводного канала, 120	Санкт-Петербург	1	открыта
325	наб. Обводного канала, 120	Санкт-Петербург	2	открыта
326	наб. Обводного канала, 120	Санкт-Петербург	3	открыта
327	пл. Островского, д. 2	Санкт-Петербург	1	открыта
328	пл. Островского, д. 2	Санкт-Петербург	2	открыта
329	пл. Островского, д. 2	Санкт-Петербург	3	закрыта навсегда
330	Комсомольская пл., 3	Москва	1	открыта
331	Комсомольская пл., 3	Москва	2	открыта
332	Комсомольская пл., 3	Москва	3	закрыта навсегда
333	ж.д. станция Царицыно	Москва	1	открыта
334	ж.д. станция Царицыно	Москва	2	открыта
335	ж.д. станция Царицыно	Москва	3	открыта
336	ул. Красный Казанец, д.18, ж.д. станция Выхино, турникетный павильон	Москва	1	открыта
337	ул. Красный Казанец, д.18, ж.д. станция Выхино, турникетный павильон	Москва	2	открыта
338	ул. Красный Казанец, д.18, ж.д. станция Выхино, турникетный павильон	Москва	3	открыта
339	ул. Михневская, владение 1	Москва	1	открыта
340	ул. Михневская, владение 1	Москва	2	закрыта навсегда
341	ул. Михневская, владение 1	Москва	3	открыта
342	ул. Булатниковский проезд, владение 5 строение 1	Москва	1	открыта
343	ул. Булатниковский проезд, владение 5 строение 1	Москва	2	открыта
344	ул. Булатниковский проезд, владение 5 строение 1	Москва	3	открыта
345	пл. Савеловского вокзала, д. 2	Москва	1	открыта
346	пл. Савеловского вокзала, д. 2	Москва	2	открыта
347	пл. Савеловского вокзала, д. 2	Москва	3	открыта
348	Рижская площадь д. 1	Москва	1	открыта
349	Рижская площадь д. 1	Москва	2	открыта
350	Рижская площадь д. 1	Москва	3	открыта
351	площадь Павелецкая, дом 1А строение 1	Москва	1	открыта
352	площадь Павелецкая, дом 1А строение 1	Москва	2	открыта
353	площадь Павелецкая, дом 1А строение 1	Москва	3	открыта
354	пл. Тверская Застава, д. 7 стр. 3	Москва	1	открыта
355	пл. Тверская Застава, д. 7 стр. 3	Москва	2	открыта
356	пл. Тверская Застава, д. 7 стр. 3	Москва	3	открыта
357	Комсомольская пл. д. 5	Москва	1	открыта
358	Комсомольская пл. д. 5	Москва	2	открыта
359	Комсомольская пл. д. 5	Москва	4	закрыта временно
360	Комсомольская пл., д. 2	Москва	4	открыта
361	Комсомольская пл., д. 2	Москва	2	открыта
362	Комсомольская пл., д. 2	Москва	3	открыта
363	пл. Киевского вокзала, д. 2	Москва	1	открыта
364	пл. Киевского вокзала, д. 2	Москва	2	открыта
365	пл. Киевского вокзала, д. 2	Москва	3	открыта
366	пл. Киевского вокзала, д. 2	Москва	4	закрыта временно
367	пл. Киевского вокзала, д. 2	Москва	5	открыта
368	пл. Киевского вокзала, д. 2	Москва	6	открыта
369	ул. Земляной Вал, д. 29	Москва	1	открыта
370	ул. Земляной Вал, д. 29	Москва	2	открыта
371	ул. Земляной Вал, д. 29	Москва	3	открыта
372	ж.д. станция Лосиноостровская, Анадырский проезд д. 8 кор .2	Москва	1	закрыта временно
373	ж.д. станция Лосиноостровская, Анадырский проезд д. 8 кор .2	Москва	2	открыта
374	ж.д. станция Лосиноостровская, Анадырский проезд д. 8 кор .2	Москва	3	открыта
375	Стратонатов пр, 1 островная платформа, ст. Тушино	Москва	1	открыта
376	Стратонатов пр, 1 островная платформа, ст. Тушино	Москва	2	открыта
377	Стратонатов пр, 1 островная платформа, ст. Тушино	Москва	3	закрыта временно
378	Комсомольская площадь д. 4 а стр. 2.	Москва	1	открыта
379	Комсомольская площадь д. 4 а стр. 2.	Москва	2	открыта
380	Комсомольская площадь д. 4 а стр. 2.	Москва	3	открыта
381	Комсомольская площадь д. 4 а стр. 2.	Москва	5	открыта
382	Комсомольская площадь д. 4 а стр. 2.	Москва	6	открыта
383	Комсомольская площадь д. 4 а стр. 2.	Москва	7	закрыта временно
384	ул.Наро-Фоминская, ст.Солнечная	Москва	1	закрыта временно
385	ул.Наро-Фоминская, ст.Солнечная	Москва	2	открыта
386	ул.Наро-Фоминская, ст.Солнечная	Москва	3	открыта
387	улица Алеутская, дом 2	Владивосток	1	открыта
388	улица Алеутская, дом 2	Владивосток	2	открыта
389	улица Алеутская, дом 2	Владивосток	3	открыта
390	ул. Вокзальная, 1	Владивосток	1	открыта
391	ул. Вокзальная, 1	Владивосток	2	открыта
392	ул. Вокзальная, 1	Владивосток	3	открыта
393	ул. Русская, 2д	Владивосток	1	открыта
394	ул. Русская, 2д	Владивосток	2	открыта
395	ул. Русская, 2д	Владивосток	3	открыта
396	ул. Алеутская, 2	Владивосток	4	открыта
397	ул. Алеутская, 2	Владивосток	5	закрыта навсегда
398	ул. Алеутская, 2	Владивосток	6	закрыта временно
399	ул. Алеутская, 4	Владивосток	1	открыта
400	ул. Алеутская, 4	Владивосток	2	открыта
401	ул. Алеутская, 4	Владивосток	3	открыта
402	Океанский проспект, 1д.	Владивосток	1	закрыта навсегда
403	Океанский проспект, 1д.	Владивосток	2	открыта
404	Океанский проспект, 1д.	Владивосток	3	открыта
405	Калинина, 46, стр. 5.	Владивосток	1	закрыта временно
406	Калинина, 46, стр. 5.	Владивосток	2	открыта
407	Калинина, 46, стр. 5.	Владивосток	3	открыта
408	Калинина, 46, стр. 5.	Владивосток	4	закрыта навсегда
\.


--
-- TOC entry 3767 (class 0 OID 16551)
-- Dependencies: 230
-- Data for Name: carriage; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.carriage (id, number, status, id_type) FROM stdin;
361	1	в ремонте	68
362	2	не готов	59
363	3	в ремонте	51
364	4	в ремонте	57
365	5	готов	44
366	6	готов	63
367	7	в ремонте	38
368	8	готов	57
369	9	не готов	69
370	10	готов	47
371	11	готов	56
372	12	готов	61
373	13	не готов	41
374	14	готов	72
375	15	готов	67
376	16	не готов	44
377	17	не готов	68
378	18	не готов	46
379	19	в ремонте	41
380	20	не готов	43
381	21	готов	55
382	22	не готов	69
383	23	не готов	55
384	24	не готов	71
385	25	в ремонте	40
386	26	готов	66
387	27	не готов	72
388	28	не готов	39
389	29	не готов	59
390	30	в ремонте	71
\.


--
-- TOC entry 3759 (class 0 OID 16511)
-- Dependencies: 222
-- Data for Name: carriage_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.carriage_type (id, place_count, carriage_type, class_of_service) FROM stdin;
37	60	купейный	комфорт
38	60	купейный	бизнес
39	60	купейный	эконом
40	60	СВ	комфорт
41	60	СВ	бизнес
42	60	СВ	эконом
43	60	плацкартный	комфорт
44	60	плацкартный	бизнес
45	60	плацкартный	эконом
46	60	вагон-ресторан	комфорт
47	60	вагон-ресторан	бизнес
48	60	вагон-ресторан	эконом
49	40	купейный	комфорт
50	40	купейный	бизнес
51	40	купейный	эконом
52	40	СВ	комфорт
53	40	СВ	бизнес
54	40	СВ	эконом
55	40	плацкартный	комфорт
56	40	плацкартный	бизнес
57	40	плацкартный	эконом
58	40	вагон-ресторан	комфорт
59	40	вагон-ресторан	бизнес
60	40	вагон-ресторан	эконом
61	10	купейный	комфорт
62	10	купейный	бизнес
63	10	купейный	эконом
64	10	СВ	комфорт
65	10	СВ	бизнес
66	10	СВ	эконом
67	10	плацкартный	комфорт
68	10	плацкартный	бизнес
69	10	плацкартный	эконом
70	10	вагон-ресторан	комфорт
71	10	вагон-ресторан	бизнес
72	10	вагон-ресторан	эконом
\.


--
-- TOC entry 3761 (class 0 OID 16518)
-- Dependencies: 224
-- Data for Name: discount; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.discount (id, discount_amount, start_date, end_date) FROM stdin;
61	40	2025-05-07	2025-05-25
62	25	2025-01-21	2025-02-18
63	50	2025-02-04	2025-02-13
64	3	2025-04-05	2025-04-07
65	40	2025-01-09	2025-02-08
66	30	2025-05-05	2025-05-06
67	90	2025-07-04	2025-07-16
68	15	2025-12-01	2025-12-15
69	50	2025-04-02	2025-04-16
70	20	2025-02-19	2025-03-10
71	25	2025-08-29	2025-08-30
72	35	2025-07-08	2025-08-01
73	15	2025-03-13	2025-04-03
74	7	2025-05-13	2025-06-12
75	40	2025-08-11	2025-08-31
76	5	2025-12-13	2025-12-29
77	3	2025-10-17	2025-11-06
78	3	2025-05-13	2025-06-03
79	25	2025-07-20	2025-08-02
80	40	2025-12-08	2025-12-29
81	10	2025-06-26	2025-07-13
82	5	2025-01-01	2025-01-04
83	15	2025-05-01	2025-05-24
84	15	2025-11-22	2025-12-18
85	35	2025-01-29	2025-02-18
86	40	2025-09-29	2025-10-14
87	30	2025-12-03	2025-12-05
88	25	2025-07-25	2025-08-23
89	5	2025-06-19	2025-06-29
90	18	2025-08-19	2025-09-03
\.


--
-- TOC entry 3769 (class 0 OID 16558)
-- Dependencies: 232
-- Data for Name: flight; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.flight (id, id_train, departure_date, arrival_date, status) FROM stdin;
2	2	2025-03-17	2025-03-17	отменен
3	3	2025-03-15	2025-03-15	отправлен
4	3	2025-01-21	2025-01-21	задержан
6	4	2025-03-28	2025-03-28	задержан
7	5	2025-01-19	2025-01-19	в пути
11	7	2025-02-01	2025-02-01	в пути
13	8	2025-04-25	2025-04-25	прибывает
14	8	2025-03-07	2025-03-07	отменен
17	10	2025-01-08	2025-01-08	прибывает
19	12	2025-01-17	2025-01-17	отправлен
22	13	2025-04-19	2025-04-19	в пути
25	15	2025-04-28	2025-04-28	в пути
27	16	2025-01-02	2025-01-02	отменен
28	16	2025-04-29	2025-04-29	прибывает
30	17	2025-04-16	2025-04-16	прибывает
32	18	2025-01-23	2025-01-23	в пути
33	19	2025-05-28	2025-05-28	прибывает
37	21	2025-01-20	2025-01-20	задержан
38	21	2025-06-28	2025-06-28	задержан
40	22	2025-01-03	2025-01-03	прибывает
41	23	2025-04-16	2025-04-16	прибывает
42	23	2025-03-05	2025-03-05	отменен
47	26	2025-06-22	2025-06-22	в пути
48	26	2025-05-20	2025-05-20	отправлен
49	27	2025-06-23	2025-06-23	прибывает
50	27	2025-05-14	2025-05-14	задержан
\.


--
-- TOC entry 3771 (class 0 OID 16570)
-- Dependencies: 234
-- Data for Name: flight_stops; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.flight_stops (id, id_train, id_station, departure_time, arrival_time, number_of_stops_in_turn) FROM stdin;
231	2	28	\N	17:30:00	1
232	2	27	17:59:00	18:02:00	2
233	2	26	18:31:00	18:34:00	3
234	2	25	19:03:00	19:06:00	4
235	2	24	19:35:00	19:38:00	5
236	2	23	20:07:00	20:10:00	6
237	2	21	20:39:00	20:42:00	7
238	2	18	22:06:00	\N	8
239	3	30	\N	11:55:00	1
240	3	29	12:15:00	12:18:00	2
241	3	28	12:38:00	12:41:00	3
242	3	27	13:01:00	13:04:00	4
243	3	24	13:24:00	13:27:00	5
244	3	23	13:47:00	13:50:00	6
245	3	22	14:10:00	14:13:00	7
246	3	21	14:33:00	14:36:00	8
247	3	20	14:56:00	14:59:00	9
248	3	19	15:19:00	15:22:00	10
249	3	18	16:40:00	\N	11
250	4	30	\N	08:20:00	1
251	4	27	09:03:00	09:06:00	2
252	4	24	09:49:00	09:52:00	3
253	4	23	10:35:00	10:38:00	4
254	4	20	12:21:00	\N	5
255	5	6	\N	17:15:00	1
256	5	7	17:21:00	17:24:00	2
257	5	8	17:30:00	17:33:00	3
258	5	9	17:39:00	17:42:00	4
259	5	12	17:48:00	17:51:00	5
260	5	14	17:57:00	18:00:00	6
261	5	16	18:06:00	18:09:00	7
262	5	17	18:15:00	18:18:00	8
263	5	20	18:24:00	18:27:00	9
264	5	21	18:33:00	18:36:00	10
265	5	22	18:42:00	18:45:00	11
266	5	23	18:51:00	18:54:00	12
267	5	24	19:00:00	19:03:00	13
268	5	25	19:09:00	19:12:00	14
269	5	27	19:18:00	19:21:00	15
270	5	28	20:11:00	\N	16
271	6	6	\N	05:55:00	1
272	6	7	06:34:00	06:37:00	2
273	6	8	07:16:00	07:19:00	3
274	6	10	07:58:00	08:01:00	4
275	6	12	09:37:00	\N	5
276	7	27	\N	08:20:00	1
277	7	26	08:48:00	08:51:00	2
278	7	15	09:19:00	09:22:00	3
279	7	9	10:34:00	\N	4
280	8	12	\N	12:40:00	1
281	8	15	12:56:00	12:59:00	2
282	8	16	13:15:00	13:18:00	3
283	8	20	13:34:00	13:37:00	4
284	8	23	13:53:00	13:56:00	5
285	8	25	14:12:00	14:15:00	6
286	8	28	14:31:00	14:34:00	7
287	8	30	15:35:00	\N	8
288	9	14	\N	06:55:00	1
289	9	13	07:34:00	07:37:00	2
290	9	12	08:16:00	08:19:00	3
291	9	11	09:53:00	\N	4
292	10	6	\N	16:50:00	1
293	10	7	17:23:00	17:26:00	2
294	10	9	17:59:00	18:02:00	3
295	10	10	18:35:00	18:38:00	4
296	10	11	19:11:00	19:14:00	5
297	10	12	19:47:00	19:50:00	6
298	10	14	20:23:00	20:26:00	7
299	10	17	22:01:00	\N	8
300	12	28	\N	17:30:00	1
301	12	27	17:55:00	17:58:00	2
302	12	26	18:23:00	18:26:00	3
303	12	25	18:51:00	18:54:00	4
304	12	24	19:19:00	19:22:00	5
305	12	23	19:47:00	19:50:00	6
306	12	22	20:15:00	20:18:00	7
307	12	21	20:43:00	20:46:00	8
308	12	18	22:06:00	\N	9
309	13	30	\N	11:55:00	1
310	13	29	12:13:00	12:16:00	2
311	13	28	12:34:00	12:37:00	3
312	13	27	12:55:00	12:58:00	4
313	13	25	13:16:00	13:19:00	5
314	13	24	13:37:00	13:40:00	6
315	13	23	13:58:00	14:01:00	7
316	13	22	14:19:00	14:22:00	8
317	13	21	14:40:00	14:43:00	9
318	13	20	15:01:00	15:04:00	10
319	13	19	15:22:00	15:25:00	11
320	13	18	16:40:00	\N	12
321	14	30	\N	08:20:00	1
322	14	29	09:03:00	09:06:00	2
323	14	27	09:49:00	09:52:00	3
324	14	23	10:35:00	10:38:00	4
325	14	20	12:21:00	\N	5
326	15	6	\N	17:15:00	1
327	15	8	17:26:00	17:29:00	2
328	15	9	17:40:00	17:43:00	3
329	15	10	17:54:00	17:57:00	4
330	15	13	18:08:00	18:11:00	5
331	15	14	18:22:00	18:25:00	6
332	15	17	18:36:00	18:39:00	7
333	15	20	18:50:00	18:53:00	8
334	15	25	19:04:00	19:07:00	9
335	15	27	19:18:00	19:21:00	10
336	15	28	20:11:00	\N	11
337	16	6	\N	05:55:00	1
338	16	8	06:27:00	06:30:00	2
339	16	9	07:02:00	07:05:00	3
340	16	10	07:37:00	07:40:00	4
341	16	11	08:12:00	08:15:00	5
342	16	12	09:37:00	\N	6
343	17	27	\N	08:20:00	1
344	17	26	08:31:00	08:34:00	2
345	17	25	08:45:00	08:48:00	3
346	17	24	08:59:00	09:02:00	4
347	17	21	09:13:00	09:16:00	5
348	17	18	09:27:00	09:30:00	6
349	17	16	09:41:00	09:44:00	7
350	17	9	10:34:00	\N	8
351	18	12	\N	12:40:00	1
352	18	19	13:04:00	13:07:00	2
353	18	21	13:31:00	13:34:00	3
354	18	26	13:58:00	14:01:00	4
355	18	27	14:25:00	14:28:00	5
356	18	30	15:35:00	\N	6
357	19	14	\N	06:55:00	1
358	19	13	07:34:00	07:37:00	2
359	19	12	08:16:00	08:19:00	3
360	19	11	09:53:00	\N	4
361	20	6	\N	16:50:00	1
362	20	8	17:13:00	17:16:00	2
363	20	9	17:39:00	17:42:00	3
364	20	10	18:05:00	18:08:00	4
365	20	11	18:31:00	18:34:00	5
366	20	12	18:57:00	19:00:00	6
367	20	13	19:23:00	19:26:00	7
368	20	14	19:49:00	19:52:00	8
369	20	15	20:15:00	20:18:00	9
370	20	16	20:41:00	20:44:00	10
371	20	17	22:01:00	\N	11
372	21	26	\N	17:50:00	1
373	21	25	18:19:00	18:22:00	2
374	21	24	18:51:00	18:54:00	3
375	21	23	19:23:00	19:26:00	4
376	21	21	19:55:00	19:58:00	5
377	21	20	20:27:00	20:30:00	6
378	21	19	20:59:00	21:02:00	7
379	21	18	22:23:00	\N	8
380	22	8	\N	06:45:00	1
381	22	9	07:44:00	07:47:00	2
382	22	10	08:46:00	08:49:00	3
383	22	11	09:48:00	09:51:00	4
384	22	12	10:50:00	10:53:00	5
385	22	13	13:14:00	\N	6
386	23	18	\N	14:35:00	1
387	23	17	16:27:00	16:30:00	2
388	23	16	20:27:00	\N	3
389	24	27	\N	20:35:00	1
390	24	26	20:49:00	20:52:00	2
391	24	25	21:06:00	21:09:00	3
392	24	24	21:23:00	21:26:00	4
393	24	22	21:40:00	21:43:00	5
394	24	21	21:57:00	22:00:00	6
395	24	20	22:14:00	22:17:00	7
396	24	19	22:31:00	22:34:00	8
397	24	18	22:48:00	22:51:00	9
398	24	16	23:51:00	\N	10
399	25	23	\N	20:00:00	1
400	25	22	20:49:00	20:52:00	2
401	25	21	22:43:00	\N	3
402	26	11	\N	05:40:00	1
403	26	13	07:15:00	07:18:00	2
404	26	16	10:40:00	\N	3
405	27	8	\N	07:55:00	1
406	27	9	09:17:00	09:20:00	2
407	27	10	10:42:00	10:45:00	3
408	27	12	13:44:00	\N	4
409	28	6	\N	11:55:00	1
410	28	7	12:08:00	12:11:00	2
411	28	8	12:24:00	12:27:00	3
412	28	11	12:40:00	12:43:00	4
413	28	12	12:56:00	12:59:00	5
414	28	13	13:12:00	13:15:00	6
415	28	15	13:28:00	13:31:00	7
416	28	16	13:44:00	13:47:00	8
417	28	17	14:00:00	14:03:00	9
418	28	19	14:16:00	14:19:00	10
419	28	23	15:16:00	\N	11
420	29	23	\N	13:20:00	1
421	29	25	13:45:00	13:48:00	2
422	29	27	14:13:00	14:16:00	3
423	29	30	15:21:00	\N	4
\.


--
-- TOC entry 3755 (class 0 OID 16477)
-- Dependencies: 218
-- Data for Name: passenger; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.passenger (id, initial, email, phone_number) FROM stdin;
22	Иванов Сергей Александрович	sergei.ivanov@gmail.com	+79213456780
23	Петрова Мария Викторовна	maria.petrova@mail.ru	+79161234567
24	Сидоров Алексей Павлович	alexey.sidorov@yandex.ru	+79031239876
25	Кузнецова Анна Сергеевна	anna.kuznetsova@gmail.com	+79217654321
26	Морозов Дмитрий Владимирович	dmitry.morozov@mail.ru	+79051239876
27	Волкова Екатерина Игоревна	ekaterina.volkova@yandex.ru	+79214567890
28	Смирнов Павел Николаевич	pavel.smirnov@gmail.com	+79163456782
29	Федорова Ольга Дмитриевна	olga.fedorova@mail.ru	+79219876543
30	Михайлов Артем Сергеевич	artem.mikhailov@yandex.ru	+79034561234
31	Егорова Татьяна Ивановна	tatiana.egorova@gmail.com	+79211239876
32	Лебедев Владимир Павлович	vladimir.lebedev@mail.ru	+79169876543
33	Новикова Светлана Андреевна	svetlana.novikova@yandex.ru	+79215436789
34	Соловьев Максим Олегович	maxim.soloviev@gmail.com	+79031239875
35	Козлова Дарья Алексеевна	darya.kozlova@mail.ru	+79213456781
36	Попов Илья Владимирович	ilya.popov@yandex.ru	+79162345678
37	Романова Юлия Сергеевна	julia.romanova@gmail.com	+79217654322
38	Григорьев Андрей Михайлович	andrey.grigoriev@mail.ru	+79051239877
39	Васильева Наталья Павловна	natalia.vasileva@yandex.ru	+79214567891
40	Максимов Денис Викторович	denis.maximov@gmail.com	+79163456783
41	Дмитриева Елена Артемовна	elena.dmitrieva@mail.ru	+79219876544
\.


--
-- TOC entry 3757 (class 0 OID 16488)
-- Dependencies: 220
-- Data for Name: passport; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.passport (id, id_passenger, passport_data, date_of_issue, date_of_expiry, initial) FROM stdin;
6	22	1118689938	2023-11-29	2029-11-29	Иванов Сергей Александрович
7	23	0146064871	2021-01-20	2046-01-20	Петрова Мария Викторовна
8	24	0485445369	2021-04-05	2027-04-05	Сидоров Алексей Павлович
9	25	1296226831	2020-12-20	2026-12-20	Кузнецова Анна Сергеевна
10	26	0878213395	2020-08-11	2026-08-11	Морозов Дмитрий Владимирович
11	27	0494246257	2020-04-28	2045-04-28	Волкова Екатерина Игоревна
12	28	0615513756	2022-06-02	2047-06-02	Смирнов Павел Николаевич
13	29	0785450529	2022-07-26	2028-07-26	Федорова Ольга Дмитриевна
14	30	0502021721	2023-05-31	2028-05-31	Михайлов Артем Сергеевич
15	31	0148377085	2020-01-30	2025-01-30	Егорова Татьяна Ивановна
16	32	0844412146	2021-08-15	2027-08-15	Лебедев Владимир Павлович
17	33	0794723065	2024-07-05	2034-07-05	Новикова Светлана Андреевна
18	34	0717213075	2024-07-28	2034-07-28	Соловьев Максим Олегович
19	35	0659031557	2023-06-26	2048-06-26	Козлова Дарья Алексеевна
20	36	0202963810	2023-02-07	2033-02-07	Попов Илья Владимирович
21	37	1278279225	2022-12-24	2027-12-24	Романова Юлия Сергеевна
22	38	1109160559	2021-11-06	2031-11-06	Григорьев Андрей Михайлович
23	39	0346814869	2021-03-31	2046-03-31	Васильева Наталья Павловна
24	40	0483256404	2020-04-01	2045-04-01	Максимов Денис Викторович
25	41	1112122573	2024-11-10	2030-11-10	Дмитриева Елена Артемовна
\.


--
-- TOC entry 3775 (class 0 OID 16610)
-- Dependencies: 238
-- Data for Name: seat; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.seat (id, id_train, number_in_carriage, service_class) FROM stdin;
791	2	1	бизнес
792	2	2	бизнес
793	2	3	бизнес
794	2	4	бизнес
795	2	5	бизнес
796	2	6	бизнес
797	2	7	бизнес
798	2	8	бизнес
799	2	9	бизнес
800	2	10	бизнес
801	2	11	бизнес
802	2	12	бизнес
803	2	13	бизнес
804	2	14	бизнес
805	2	15	бизнес
806	2	16	бизнес
807	2	17	бизнес
808	2	18	бизнес
809	2	19	бизнес
810	2	20	бизнес
811	2	21	бизнес
812	2	22	бизнес
813	2	23	бизнес
814	2	24	бизнес
815	2	25	бизнес
816	2	26	бизнес
817	2	27	бизнес
818	2	28	бизнес
819	2	29	бизнес
820	2	30	бизнес
821	2	31	бизнес
822	2	32	бизнес
823	2	33	бизнес
824	2	34	бизнес
825	2	35	бизнес
826	2	36	бизнес
827	2	37	бизнес
828	2	38	бизнес
829	2	39	бизнес
830	2	40	бизнес
831	2	41	бизнес
832	2	42	бизнес
833	2	43	бизнес
834	2	44	бизнес
835	2	45	бизнес
836	2	46	бизнес
837	2	47	бизнес
838	2	48	бизнес
839	2	49	бизнес
840	2	50	бизнес
841	2	51	бизнес
842	2	52	бизнес
843	2	53	бизнес
844	2	54	бизнес
845	2	55	бизнес
846	2	56	бизнес
847	2	57	бизнес
848	2	58	бизнес
849	2	59	бизнес
850	2	60	бизнес
851	2	1	бизнес
852	2	2	бизнес
853	2	3	бизнес
854	2	4	бизнес
855	2	5	бизнес
856	2	6	бизнес
857	2	7	бизнес
858	2	8	бизнес
859	2	9	бизнес
860	2	10	бизнес
861	2	11	бизнес
862	2	12	бизнес
863	2	13	бизнес
864	2	14	бизнес
865	2	15	бизнес
866	2	16	бизнес
867	2	17	бизнес
868	2	18	бизнес
869	2	19	бизнес
870	2	20	бизнес
871	2	21	бизнес
872	2	22	бизнес
873	2	23	бизнес
874	2	24	бизнес
875	2	25	бизнес
876	2	26	бизнес
877	2	27	бизнес
878	2	28	бизнес
879	2	29	бизнес
880	2	30	бизнес
881	2	31	бизнес
882	2	32	бизнес
883	2	33	бизнес
884	2	34	бизнес
885	2	35	бизнес
886	2	36	бизнес
887	2	37	бизнес
888	2	38	бизнес
889	2	39	бизнес
890	2	40	бизнес
891	2	1	комфорт
892	2	2	комфорт
893	2	3	комфорт
894	2	4	комфорт
895	2	5	комфорт
896	2	6	комфорт
897	2	7	комфорт
898	2	8	комфорт
899	2	9	комфорт
900	2	10	комфорт
901	3	1	эконом
902	3	2	эконом
903	3	3	эконом
904	3	4	эконом
905	3	5	эконом
906	3	6	эконом
907	3	7	эконом
908	3	8	эконом
909	3	9	эконом
910	3	10	эконом
911	3	11	эконом
912	3	12	эконом
913	3	13	эконом
914	3	14	эконом
915	3	15	эконом
916	3	16	эконом
917	3	17	эконом
918	3	18	эконом
919	3	19	эконом
920	3	20	эконом
921	3	21	эконом
922	3	22	эконом
923	3	23	эконом
924	3	24	эконом
925	3	25	эконом
926	3	26	эконом
927	3	27	эконом
928	3	28	эконом
929	3	29	эконом
930	3	30	эконом
931	3	31	эконом
932	3	32	эконом
933	3	33	эконом
934	3	34	эконом
935	3	35	эконом
936	3	36	эконом
937	3	37	эконом
938	3	38	эконом
939	3	39	эконом
940	3	40	эконом
941	3	1	эконом
942	3	2	эконом
943	3	3	эконом
944	3	4	эконом
945	3	5	эконом
946	3	6	эконом
947	3	7	эконом
948	3	8	эконом
949	3	9	эконом
950	3	10	эконом
951	3	1	комфорт
952	3	2	комфорт
953	3	3	комфорт
954	3	4	комфорт
955	3	5	комфорт
956	3	6	комфорт
957	3	7	комфорт
958	3	8	комфорт
959	3	9	комфорт
960	3	10	комфорт
961	3	1	комфорт
962	3	2	комфорт
963	3	3	комфорт
964	3	4	комфорт
965	3	5	комфорт
966	3	6	комфорт
967	3	7	комфорт
968	3	8	комфорт
969	3	9	комфорт
970	3	10	комфорт
971	3	11	комфорт
972	3	12	комфорт
973	3	13	комфорт
974	3	14	комфорт
975	3	15	комфорт
976	3	16	комфорт
977	3	17	комфорт
978	3	18	комфорт
979	3	19	комфорт
980	3	20	комфорт
981	3	21	комфорт
982	3	22	комфорт
983	3	23	комфорт
984	3	24	комфорт
985	3	25	комфорт
986	3	26	комфорт
987	3	27	комфорт
988	3	28	комфорт
989	3	29	комфорт
990	3	30	комфорт
991	3	31	комфорт
992	3	32	комфорт
993	3	33	комфорт
994	3	34	комфорт
995	3	35	комфорт
996	3	36	комфорт
997	3	37	комфорт
998	3	38	комфорт
999	3	39	комфорт
1000	3	40	комфорт
1001	8	1	эконом
1002	8	2	эконом
1003	8	3	эконом
1004	8	4	эконом
1005	8	5	эконом
1006	8	6	эконом
1007	8	7	эконом
1008	8	8	эконом
1009	8	9	эконом
1010	8	10	эконом
1011	8	1	бизнес
1012	8	2	бизнес
1013	8	3	бизнес
1014	8	4	бизнес
1015	8	5	бизнес
1016	8	6	бизнес
1017	8	7	бизнес
1018	8	8	бизнес
1019	8	9	бизнес
1020	8	10	бизнес
1021	8	11	бизнес
1022	8	12	бизнес
1023	8	13	бизнес
1024	8	14	бизнес
1025	8	15	бизнес
1026	8	16	бизнес
1027	8	17	бизнес
1028	8	18	бизнес
1029	8	19	бизнес
1030	8	20	бизнес
1031	8	21	бизнес
1032	8	22	бизнес
1033	8	23	бизнес
1034	8	24	бизнес
1035	8	25	бизнес
1036	8	26	бизнес
1037	8	27	бизнес
1038	8	28	бизнес
1039	8	29	бизнес
1040	8	30	бизнес
1041	8	31	бизнес
1042	8	32	бизнес
1043	8	33	бизнес
1044	8	34	бизнес
1045	8	35	бизнес
1046	8	36	бизнес
1047	8	37	бизнес
1048	8	38	бизнес
1049	8	39	бизнес
1050	8	40	бизнес
1051	8	41	бизнес
1052	8	42	бизнес
1053	8	43	бизнес
1054	8	44	бизнес
1055	8	45	бизнес
1056	8	46	бизнес
1057	8	47	бизнес
1058	8	48	бизнес
1059	8	49	бизнес
1060	8	50	бизнес
1061	8	51	бизнес
1062	8	52	бизнес
1063	8	53	бизнес
1380	26	10	бизнес
1064	8	54	бизнес
1065	8	55	бизнес
1066	8	56	бизнес
1067	8	57	бизнес
1068	8	58	бизнес
1069	8	59	бизнес
1070	8	60	бизнес
1071	8	1	бизнес
1072	8	2	бизнес
1073	8	3	бизнес
1074	8	4	бизнес
1075	8	5	бизнес
1076	8	6	бизнес
1077	8	7	бизнес
1078	8	8	бизнес
1079	8	9	бизнес
1080	8	10	бизнес
1081	8	11	бизнес
1082	8	12	бизнес
1083	8	13	бизнес
1084	8	14	бизнес
1085	8	15	бизнес
1086	8	16	бизнес
1087	8	17	бизнес
1088	8	18	бизнес
1089	8	19	бизнес
1090	8	20	бизнес
1091	8	21	бизнес
1092	8	22	бизнес
1093	8	23	бизнес
1094	8	24	бизнес
1095	8	25	бизнес
1096	8	26	бизнес
1097	8	27	бизнес
1098	8	28	бизнес
1099	8	29	бизнес
1100	8	30	бизнес
1101	8	31	бизнес
1102	8	32	бизнес
1103	8	33	бизнес
1104	8	34	бизнес
1105	8	35	бизнес
1106	8	36	бизнес
1107	8	37	бизнес
1108	8	38	бизнес
1109	8	39	бизнес
1110	8	40	бизнес
1111	8	41	бизнес
1112	8	42	бизнес
1113	8	43	бизнес
1114	8	44	бизнес
1115	8	45	бизнес
1116	8	46	бизнес
1117	8	47	бизнес
1118	8	48	бизнес
1119	8	49	бизнес
1120	8	50	бизнес
1121	8	51	бизнес
1122	8	52	бизнес
1123	8	53	бизнес
1124	8	54	бизнес
1125	8	55	бизнес
1126	8	56	бизнес
1127	8	57	бизнес
1128	8	58	бизнес
1129	8	59	бизнес
1130	8	60	бизнес
1131	8	1	комфорт
1132	8	2	комфорт
1133	8	3	комфорт
1134	8	4	комфорт
1135	8	5	комфорт
1136	8	6	комфорт
1137	8	7	комфорт
1138	8	8	комфорт
1139	8	9	комфорт
1140	8	10	комфорт
1141	8	11	комфорт
1142	8	12	комфорт
1143	8	13	комфорт
1144	8	14	комфорт
1145	8	15	комфорт
1146	8	16	комфорт
1147	8	17	комфорт
1148	8	18	комфорт
1149	8	19	комфорт
1150	8	20	комфорт
1151	8	21	комфорт
1152	8	22	комфорт
1153	8	23	комфорт
1154	8	24	комфорт
1155	8	25	комфорт
1156	8	26	комфорт
1157	8	27	комфорт
1158	8	28	комфорт
1159	8	29	комфорт
1160	8	30	комфорт
1161	8	31	комфорт
1162	8	32	комфорт
1163	8	33	комфорт
1164	8	34	комфорт
1165	8	35	комфорт
1166	8	36	комфорт
1167	8	37	комфорт
1168	8	38	комфорт
1169	8	39	комфорт
1170	8	40	комфорт
1171	8	41	комфорт
1172	8	42	комфорт
1173	8	43	комфорт
1174	8	44	комфорт
1175	8	45	комфорт
1176	8	46	комфорт
1177	8	47	комфорт
1178	8	48	комфорт
1179	8	49	комфорт
1180	8	50	комфорт
1181	8	51	комфорт
1182	8	52	комфорт
1183	8	53	комфорт
1184	8	54	комфорт
1185	8	55	комфорт
1186	8	56	комфорт
1187	8	57	комфорт
1188	8	58	комфорт
1189	8	59	комфорт
1190	8	60	комфорт
1191	22	1	комфорт
1192	22	2	комфорт
1193	22	3	комфорт
1194	22	4	комфорт
1195	22	5	комфорт
1196	22	6	комфорт
1197	22	7	комфорт
1198	22	8	комфорт
1199	22	9	комфорт
1200	22	10	комфорт
1201	22	1	эконом
1202	22	2	эконом
1203	22	3	эконом
1204	22	4	эконом
1205	22	5	эконом
1206	22	6	эконом
1207	22	7	эконом
1208	22	8	эконом
1209	22	9	эконом
1210	22	10	эконом
1211	22	1	комфорт
1212	22	2	комфорт
1213	22	3	комфорт
1214	22	4	комфорт
1215	22	5	комфорт
1216	22	6	комфорт
1217	22	7	комфорт
1218	22	8	комфорт
1219	22	9	комфорт
1220	22	10	комфорт
1221	22	1	комфорт
1222	22	2	комфорт
1223	22	3	комфорт
1224	22	4	комфорт
1225	22	5	комфорт
1226	22	6	комфорт
1227	22	7	комфорт
1228	22	8	комфорт
1229	22	9	комфорт
1230	22	10	комфорт
1231	22	11	комфорт
1232	22	12	комфорт
1233	22	13	комфорт
1234	22	14	комфорт
1235	22	15	комфорт
1236	22	16	комфорт
1237	22	17	комфорт
1238	22	18	комфорт
1239	22	19	комфорт
1240	22	20	комфорт
1241	22	21	комфорт
1242	22	22	комфорт
1243	22	23	комфорт
1244	22	24	комфорт
1245	22	25	комфорт
1246	22	26	комфорт
1247	22	27	комфорт
1248	22	28	комфорт
1249	22	29	комфорт
1250	22	30	комфорт
1251	22	31	комфорт
1252	22	32	комфорт
1253	22	33	комфорт
1254	22	34	комфорт
1255	22	35	комфорт
1256	22	36	комфорт
1257	22	37	комфорт
1258	22	38	комфорт
1259	22	39	комфорт
1260	22	40	комфорт
1261	22	1	эконом
1262	22	2	эконом
1263	22	3	эконом
1264	22	4	эконом
1265	22	5	эконом
1266	22	6	эконом
1267	22	7	эконом
1268	22	8	эконом
1269	22	9	эконом
1270	22	10	эконом
1271	22	1	бизнес
1272	22	2	бизнес
1273	22	3	бизнес
1274	22	4	бизнес
1275	22	5	бизнес
1276	22	6	бизнес
1277	22	7	бизнес
1278	22	8	бизнес
1279	22	9	бизнес
1280	22	10	бизнес
1281	22	11	бизнес
1282	22	12	бизнес
1283	22	13	бизнес
1284	22	14	бизнес
1285	22	15	бизнес
1286	22	16	бизнес
1287	22	17	бизнес
1288	22	18	бизнес
1289	22	19	бизнес
1290	22	20	бизнес
1291	22	21	бизнес
1292	22	22	бизнес
1293	22	23	бизнес
1294	22	24	бизнес
1295	22	25	бизнес
1296	22	26	бизнес
1297	22	27	бизнес
1298	22	28	бизнес
1299	22	29	бизнес
1300	22	30	бизнес
1301	22	31	бизнес
1302	22	32	бизнес
1303	22	33	бизнес
1304	22	34	бизнес
1305	22	35	бизнес
1306	22	36	бизнес
1307	22	37	бизнес
1308	22	38	бизнес
1309	22	39	бизнес
1310	22	40	бизнес
1311	22	1	бизнес
1312	22	2	бизнес
1313	22	3	бизнес
1314	22	4	бизнес
1315	22	5	бизнес
1316	22	6	бизнес
1317	22	7	бизнес
1318	22	8	бизнес
1319	22	9	бизнес
1320	22	10	бизнес
1321	22	11	бизнес
1322	22	12	бизнес
1323	22	13	бизнес
1324	22	14	бизнес
1325	22	15	бизнес
1326	22	16	бизнес
1327	22	17	бизнес
1328	22	18	бизнес
1329	22	19	бизнес
1330	22	20	бизнес
1331	22	21	бизнес
1332	22	22	бизнес
1333	22	23	бизнес
1334	22	24	бизнес
1335	22	25	бизнес
1336	22	26	бизнес
1337	22	27	бизнес
1338	22	28	бизнес
1339	22	29	бизнес
1340	22	30	бизнес
1341	22	31	бизнес
1342	22	32	бизнес
1343	22	33	бизнес
1344	22	34	бизнес
1345	22	35	бизнес
1346	22	36	бизнес
1347	22	37	бизнес
1348	22	38	бизнес
1349	22	39	бизнес
1350	22	40	бизнес
1351	22	41	бизнес
1352	22	42	бизнес
1353	22	43	бизнес
1354	22	44	бизнес
1355	22	45	бизнес
1356	22	46	бизнес
1357	22	47	бизнес
1358	22	48	бизнес
1359	22	49	бизнес
1360	22	50	бизнес
1361	22	51	бизнес
1362	22	52	бизнес
1363	22	53	бизнес
1364	22	54	бизнес
1365	22	55	бизнес
1366	22	56	бизнес
1367	22	57	бизнес
1368	22	58	бизнес
1369	22	59	бизнес
1370	22	60	бизнес
1371	26	1	бизнес
1372	26	2	бизнес
1373	26	3	бизнес
1374	26	4	бизнес
1375	26	5	бизнес
1376	26	6	бизнес
1377	26	7	бизнес
1378	26	8	бизнес
1379	26	9	бизнес
1381	26	11	бизнес
1382	26	12	бизнес
1383	26	13	бизнес
1384	26	14	бизнес
1385	26	15	бизнес
1386	26	16	бизнес
1387	26	17	бизнес
1388	26	18	бизнес
1389	26	19	бизнес
1390	26	20	бизнес
1391	26	21	бизнес
1392	26	22	бизнес
1393	26	23	бизнес
1394	26	24	бизнес
1395	26	25	бизнес
1396	26	26	бизнес
1397	26	27	бизнес
1398	26	28	бизнес
1399	26	29	бизнес
1400	26	30	бизнес
1401	26	31	бизнес
1402	26	32	бизнес
1403	26	33	бизнес
1404	26	34	бизнес
1405	26	35	бизнес
1406	26	36	бизнес
1407	26	37	бизнес
1408	26	38	бизнес
1409	26	39	бизнес
1410	26	40	бизнес
1411	26	41	бизнес
1412	26	42	бизнес
1413	26	43	бизнес
1414	26	44	бизнес
1415	26	45	бизнес
1416	26	46	бизнес
1417	26	47	бизнес
1418	26	48	бизнес
1419	26	49	бизнес
1420	26	50	бизнес
1421	26	51	бизнес
1422	26	52	бизнес
1423	26	53	бизнес
1424	26	54	бизнес
1425	26	55	бизнес
1426	26	56	бизнес
1427	26	57	бизнес
1428	26	58	бизнес
1429	26	59	бизнес
1430	26	60	бизнес
1431	26	1	эконом
1432	26	2	эконом
1433	26	3	эконом
1434	26	4	эконом
1435	26	5	эконом
1436	26	6	эконом
1437	26	7	эконом
1438	26	8	эконом
1439	26	9	эконом
1440	26	10	эконом
1441	26	1	эконом
1442	26	2	эконом
1443	26	3	эконом
1444	26	4	эконом
1445	26	5	эконом
1446	26	6	эконом
1447	26	7	эконом
1448	26	8	эконом
1449	26	9	эконом
1450	26	10	эконом
1451	26	11	эконом
1452	26	12	эконом
1453	26	13	эконом
1454	26	14	эконом
1455	26	15	эконом
1456	26	16	эконом
1457	26	17	эконом
1458	26	18	эконом
1459	26	19	эконом
1460	26	20	эконом
1461	26	21	эконом
1462	26	22	эконом
1463	26	23	эконом
1464	26	24	эконом
1465	26	25	эконом
1466	26	26	эконом
1467	26	27	эконом
1468	26	28	эконом
1469	26	29	эконом
1470	26	30	эконом
1471	26	31	эконом
1472	26	32	эконом
1473	26	33	эконом
1474	26	34	эконом
1475	26	35	эконом
1476	26	36	эконом
1477	26	37	эконом
1478	26	38	эконом
1479	26	39	эконом
1480	26	40	эконом
1481	26	1	бизнес
1482	26	2	бизнес
1483	26	3	бизнес
1484	26	4	бизнес
1485	26	5	бизнес
1486	26	6	бизнес
1487	26	7	бизнес
1488	26	8	бизнес
1489	26	9	бизнес
1490	26	10	бизнес
1491	26	11	бизнес
1492	26	12	бизнес
1493	26	13	бизнес
1494	26	14	бизнес
1495	26	15	бизнес
1496	26	16	бизнес
1497	26	17	бизнес
1498	26	18	бизнес
1499	26	19	бизнес
1500	26	20	бизнес
1501	26	21	бизнес
1502	26	22	бизнес
1503	26	23	бизнес
1504	26	24	бизнес
1505	26	25	бизнес
1506	26	26	бизнес
1507	26	27	бизнес
1508	26	28	бизнес
1509	26	29	бизнес
1510	26	30	бизнес
1511	26	31	бизнес
1512	26	32	бизнес
1513	26	33	бизнес
1514	26	34	бизнес
1515	26	35	бизнес
1516	26	36	бизнес
1517	26	37	бизнес
1518	26	38	бизнес
1519	26	39	бизнес
1520	26	40	бизнес
1521	26	1	бизнес
1522	26	2	бизнес
1523	26	3	бизнес
1524	26	4	бизнес
1525	26	5	бизнес
1526	26	6	бизнес
1527	26	7	бизнес
1528	26	8	бизнес
1529	26	9	бизнес
1530	26	10	бизнес
1531	26	11	бизнес
1532	26	12	бизнес
1533	26	13	бизнес
1534	26	14	бизнес
1535	26	15	бизнес
1536	26	16	бизнес
1537	26	17	бизнес
1538	26	18	бизнес
1539	26	19	бизнес
1540	26	20	бизнес
1541	26	21	бизнес
1542	26	22	бизнес
1543	26	23	бизнес
1544	26	24	бизнес
1545	26	25	бизнес
1546	26	26	бизнес
1547	26	27	бизнес
1548	26	28	бизнес
1549	26	29	бизнес
1550	26	30	бизнес
1551	26	31	бизнес
1552	26	32	бизнес
1553	26	33	бизнес
1554	26	34	бизнес
1555	26	35	бизнес
1556	26	36	бизнес
1557	26	37	бизнес
1558	26	38	бизнес
1559	26	39	бизнес
1560	26	40	бизнес
1561	26	41	бизнес
1562	26	42	бизнес
1563	26	43	бизнес
1564	26	44	бизнес
1565	26	45	бизнес
1566	26	46	бизнес
1567	26	47	бизнес
1568	26	48	бизнес
1569	26	49	бизнес
1570	26	50	бизнес
1571	26	51	бизнес
1572	26	52	бизнес
1573	26	53	бизнес
1574	26	54	бизнес
1575	26	55	бизнес
1576	26	56	бизнес
1577	26	57	бизнес
1578	26	58	бизнес
1579	26	59	бизнес
1580	26	60	бизнес
\.


--
-- TOC entry 3763 (class 0 OID 16525)
-- Dependencies: 226
-- Data for Name: station; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.station (id, name, country, type_of_locality) FROM stdin;
6	г. Санкт-Петербург, Московский вокзал	Россия	город
7	г. Санкт-Петербург, Финляндский вокзал	Россия	город
8	г. Санкт-Петербург, Витебский железнодорожный вокзал	Россия	город
9	г. Санкт-Петербург, Ладожский вокзал	Россия	город
10	г. Санкт-Петербург, Балтийский вокзал	Россия	город
11	г. Санкт-Петербург, Удельная	Россия	город
12	г. Санкт-Петербург, Пушкинский	Россия	город
13	г. Лобня, МО, Лобня	Россия	город
14	п. Кустаревка, МО, Кустаревка	Россия	поселок
15	г. Бронницы, МО, Бронницы	Россия	город
16	г. Москва, Очаково	Россия	город
17	г. Москва, Марьина Роща	Россия	город
18	п. Ольгино, МО, Ольгино	Россия	поселок
19	г. Москва, Тестовская	Россия	город
20	г. Москва, Кутузовская	Россия	город
21	г. Москва, Петровско-Разумовская	Россия	город
22	г. Москва, Тимирязевская	Россия	город
23	г. Москва, Москва-Рижская	Россия	город
24	г. Москва, Савеловский вокзал	Россия	город
25	Республика Карелия, Петрозаводск	Россия	город
26	Республика Карелия, Шуйская	Россия	поселок
27	Республика Карелия, Суна	Россия	поселок
28	Республика Карелия, Заделье	Россия	деревня
29	Республика Карелия, Кондопога	Россия	город
30	Республика Карелия, Кедрозеро	Россия	поселок
\.


--
-- TOC entry 3779 (class 0 OID 16661)
-- Dependencies: 242
-- Data for Name: ticket; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ticket (id, id_flight, datetime_departure, datetime_arrival, dropoff_point, status, id_seat, boarding_point, price, base_price, purchase_date, id_passport) FROM stdin;
1543	2	2025-03-17 17:30:00	2025-03-17 20:39:00	28	забронирован	859	21	14434.506	13866	2025-02-03 00:00:00	24
1544	2	2025-03-17 17:30:00	2025-03-17 20:39:00	28	отменен	848	21	17901.005999999998	13866	2025-01-04 00:00:00	12
1545	2	2025-03-17 17:30:00	2025-03-17 20:39:00	28	забронирован	825	21	13907.597999999998	13866	2025-02-18 00:00:00	12
1546	2	2025-03-17 17:30:00	2025-03-17 20:39:00	28	забронирован	834	21	17901.005999999998	13866	2025-01-16 00:00:00	14
1547	2	2025-03-17 17:30:00	2025-03-17 20:39:00	28	оплачен	801	21	16126.158000000001	13866	2025-02-12 00:00:00	24
1548	2	2025-03-17 17:30:00	2025-03-17 20:39:00	28	отменен	817	21	16542.138000000003	13866	2025-02-03 00:00:00	22
1549	2	2025-03-17 17:30:00	2025-03-17 20:39:00	28	отменен	873	21	16126.158000000001	13866	2025-02-24 00:00:00	12
1550	2	2025-03-17 17:30:00	2025-03-17 20:39:00	28	оплачен	836	21	15446.724000000002	13866	2025-03-02 00:00:00	17
1551	2	2025-03-17 17:30:00	2025-03-17 20:39:00	28	забронирован	849	21	14448.372000000001	13866	2025-02-21 00:00:00	16
1552	2	2025-03-17 17:30:00	2025-03-17 20:39:00	28	оплачен	867	21	17887.14	13866	2025-02-15 00:00:00	7
1553	2	2025-03-17 18:34:00	2025-03-17 19:35:00	26	отменен	812	24	16385.45	13025	2025-01-07 00:00:00	19
1554	2	2025-03-17 18:34:00	2025-03-17 19:35:00	26	оплачен	877	24	16216.125000000002	13025	2025-02-24 00:00:00	9
1555	2	2025-03-17 18:34:00	2025-03-17 19:35:00	26	забронирован	807	24	14705.225	13025	2025-02-24 00:00:00	14
1556	2	2025-03-17 18:34:00	2025-03-17 19:35:00	26	забронирован	841	24	13103.15	13025	2025-01-18 00:00:00	20
1557	2	2025-03-17 18:34:00	2025-03-17 19:35:00	26	забронирован	791	24	14666.149999999998	13025	2025-02-26 00:00:00	21
1558	2	2025-03-17 18:34:00	2025-03-17 19:35:00	26	отменен	829	24	15122.025	13025	2025-01-02 00:00:00	6
1559	2	2025-03-17 18:34:00	2025-03-17 19:35:00	26	оплачен	818	24	13207.35	13025	2025-01-29 00:00:00	11
1560	2	2025-03-17 18:34:00	2025-03-17 19:35:00	26	отменен	815	24	15069.925000000001	13025	2025-02-18 00:00:00	7
1561	2	2025-03-17 18:34:00	2025-03-17 19:35:00	26	оплачен	833	24	17179.975	13025	2025-02-07 00:00:00	23
1562	2	2025-03-17 18:34:00	2025-03-17 19:35:00	26	оплачен	823	24	13220.374999999998	13025	2025-01-15 00:00:00	17
1563	2	2025-03-17 18:34:00	2025-03-17 19:35:00	26	отменен	852	24	14601.025	13025	2025-01-26 00:00:00	12
1564	2	2025-03-17 18:34:00	2025-03-17 19:35:00	26	оплачен	832	24	15643.025000000001	13025	2025-01-30 00:00:00	9
1565	2	2025-03-17 18:34:00	2025-03-17 19:35:00	26	отменен	876	24	16815.274999999998	13025	2025-03-13 00:00:00	14
1566	2	2025-03-17 18:34:00	2025-03-17 19:35:00	26	забронирован	859	24	14991.775	13025	2025-01-22 00:00:00	10
1567	2	2025-03-17 18:34:00	2025-03-17 19:35:00	26	отменен	792	24	14692.199999999999	13025	2025-01-05 00:00:00	14
1568	2	2025-03-17 18:34:00	2025-03-17 19:35:00	26	оплачен	889	24	14119.1	13025	2025-01-01 00:00:00	23
1569	2	2025-03-17 18:34:00	2025-03-17 19:35:00	26	отменен	886	24	14835.475	13025	2025-02-04 00:00:00	14
1570	2	2025-03-17 18:34:00	2025-03-17 19:35:00	26	оплачен	825	24	14731.275	13025	2025-03-12 00:00:00	17
1571	2	2025-03-17 18:34:00	2025-03-17 19:35:00	26	отменен	882	24	14679.175	13025	2025-02-06 00:00:00	13
1572	2	2025-03-17 18:34:00	2025-03-17 19:35:00	26	оплачен	862	24	17206.024999999998	13025	2025-02-14 00:00:00	7
1573	2	2025-03-17 18:34:00	2025-03-17 19:35:00	26	забронирован	880	24	16307.3	13025	2025-02-21 00:00:00	25
1574	2	2025-03-17 18:34:00	2025-03-17 19:35:00	26	оплачен	854	24	16437.55	13025	2025-02-24 00:00:00	11
1575	2	2025-03-17 18:34:00	2025-03-17 19:35:00	26	отменен	865	24	14392.625	13025	2025-03-10 00:00:00	20
1576	2	2025-03-17 18:34:00	2025-03-17 19:35:00	26	оплачен	883	24	15825.375000000002	13025	2025-01-24 00:00:00	20
1577	2	2025-03-17 18:34:00	2025-03-17 19:35:00	26	оплачен	814	24	15330.425000000001	13025	2025-02-20 00:00:00	21
1578	2	2025-03-17 17:30:00	2025-03-17 17:59:00	28	отменен	898	27	9184.833	7857	2025-02-13 00:00:00	10
1579	2	2025-03-17 17:30:00	2025-03-17 17:59:00	28	забронирован	892	27	8901.981	7857	2025-01-02 00:00:00	19
1580	2	2025-03-17 17:30:00	2025-03-17 17:59:00	28	забронирован	900	27	8509.131	7857	2025-02-15 00:00:00	16
1581	2	2025-03-17 17:30:00	2025-03-17 17:59:00	28	забронирован	896	27	9742.68	7857	2025-01-12 00:00:00	16
1582	2	2025-03-17 17:30:00	2025-03-17 17:59:00	28	забронирован	891	27	8736.984	7857	2025-01-30 00:00:00	23
1583	2	2025-03-17 17:30:00	2025-03-17 17:59:00	28	забронирован	897	27	8854.839	7857	2025-01-29 00:00:00	7
1584	3	2025-03-15 14:13:00	2025-03-15 15:19:00	22	оплачен	934	19	1586.1299999999999	1470	2025-03-13 00:00:00	23
1585	3	2025-03-15 14:13:00	2025-03-15 15:19:00	22	забронирован	936	19	1869.84	1470	2025-02-09 00:00:00	13
1586	3	2025-03-15 14:13:00	2025-03-15 15:19:00	22	забронирован	932	19	1544.9699999999998	1470	2025-02-14 00:00:00	11
1587	3	2025-03-15 14:13:00	2025-03-15 15:19:00	22	отменен	924	19	1590.5400000000002	1470	2025-01-05 00:00:00	7
1588	3	2025-03-15 14:13:00	2025-03-15 15:19:00	22	отменен	933	19	1680.21	1470	2025-01-29 00:00:00	16
1589	3	2025-03-15 14:13:00	2025-03-15 15:19:00	22	отменен	935	19	1739.01	1470	2025-02-20 00:00:00	21
1590	3	2025-03-15 14:13:00	2025-03-15 15:19:00	22	отменен	912	19	1636.11	1470	2025-01-20 00:00:00	6
1591	3	2025-03-15 14:13:00	2025-03-15 15:19:00	22	забронирован	937	19	1599.3600000000001	1470	2025-02-12 00:00:00	16
1592	3	2025-03-15 14:13:00	2025-03-15 15:19:00	22	забронирован	923	19	1768.41	1470	2025-02-27 00:00:00	21
1593	3	2025-03-15 14:13:00	2025-03-15 15:19:00	22	отменен	907	19	1766.9399999999998	1470	2025-02-10 00:00:00	15
1594	3	2025-03-15 14:13:00	2025-03-15 15:19:00	22	отменен	945	19	1825.74	1470	2025-01-17 00:00:00	24
1595	3	2025-03-15 14:13:00	2025-03-15 15:19:00	22	забронирован	919	19	1743.4199999999998	1470	2025-03-10 00:00:00	21
1596	3	2025-03-15 14:13:00	2025-03-15 15:19:00	22	отменен	940	19	1721.3700000000001	1470	2025-01-08 00:00:00	6
1597	3	2025-03-15 14:13:00	2025-03-15 15:19:00	22	отменен	916	19	1530.27	1470	2025-03-09 00:00:00	25
1598	3	2025-03-15 14:13:00	2025-03-15 15:19:00	22	отменен	939	19	1787.52	1470	2025-02-27 00:00:00	21
1599	3	2025-03-15 14:13:00	2025-03-15 15:19:00	22	отменен	910	19	1496.46	1470	2025-02-15 00:00:00	10
1600	3	2025-03-15 14:13:00	2025-03-15 15:19:00	22	забронирован	920	19	1915.4099999999999	1470	2025-01-14 00:00:00	10
1601	3	2025-03-15 14:13:00	2025-03-15 15:19:00	22	забронирован	909	19	1941.87	1470	2025-01-12 00:00:00	20
1602	3	2025-03-15 14:13:00	2025-03-15 15:19:00	22	отменен	938	19	1699.32	1470	2025-02-04 00:00:00	11
1603	3	2025-03-15 14:13:00	2025-03-15 15:19:00	22	отменен	925	19	1774.2900000000002	1470	2025-01-08 00:00:00	9
1604	3	2025-03-15 14:13:00	2025-03-15 15:19:00	22	отменен	906	19	1787.52	1470	2025-03-10 00:00:00	15
1605	3	2025-03-15 14:13:00	2025-03-15 15:19:00	22	забронирован	944	19	1483.2299999999998	1470	2025-01-07 00:00:00	17
1606	3	2025-03-15 14:13:00	2025-03-15 15:19:00	22	отменен	911	19	1896.3	1470	2025-03-09 00:00:00	19
1607	3	2025-03-15 14:13:00	2025-03-15 15:19:00	22	оплачен	905	19	1694.91	1470	2025-01-05 00:00:00	23
1608	3	2025-03-15 14:13:00	2025-03-15 15:19:00	22	оплачен	913	19	1709.6100000000001	1470	2025-03-08 00:00:00	16
1609	3	2025-03-15 14:13:00	2025-03-15 15:19:00	22	забронирован	929	19	1722.84	1470	2025-02-08 00:00:00	9
1610	3	2025-03-15 14:13:00	2025-03-15 15:19:00	22	отменен	930	19	1622.88	1470	2025-01-17 00:00:00	16
1611	3	2025-03-15 14:13:00	2025-03-15 15:19:00	22	оплачен	949	19	1687.56	1470	2025-03-14 00:00:00	21
1612	3	2025-03-15 14:13:00	2025-03-15 15:19:00	22	оплачен	947	19	1706.67	1470	2025-01-16 00:00:00	8
1613	3	2025-03-15 14:13:00	2025-03-15 15:19:00	22	забронирован	917	19	1539.09	1470	2025-03-04 00:00:00	10
1614	3	2025-03-15 14:13:00	2025-03-15 15:19:00	22	забронирован	927	19	1519.98	1470	2025-02-07 00:00:00	17
1615	3	2025-03-15 14:13:00	2025-03-15 15:19:00	22	отменен	908	19	1734.6	1470	2025-03-01 00:00:00	8
1616	3	2025-03-15 14:13:00	2025-03-15 15:19:00	22	оплачен	943	19	1837.5	1470	2025-02-16 00:00:00	11
1617	3	2025-03-15 14:13:00	2025-03-15 15:19:00	22	оплачен	922	19	1631.7	1470	2025-02-14 00:00:00	19
1618	3	2025-03-15 14:13:00	2025-03-15 15:19:00	22	оплачен	946	19	1609.6499999999999	1470	2025-03-04 00:00:00	23
1619	3	2025-03-15 11:55:00	2025-03-15 15:19:00	30	забронирован	934	19	2173.271	1777	2025-03-04 00:00:00	21
1620	3	2025-03-15 11:55:00	2025-03-15 15:19:00	30	забронирован	901	19	2004.456	1777	2025-02-26 00:00:00	6
1621	3	2025-03-15 11:55:00	2025-03-15 15:19:00	30	отменен	940	19	2112.853	1777	2025-03-05 00:00:00	8
1622	3	2025-03-15 11:55:00	2025-03-15 15:19:00	30	забронирован	933	19	1816.094	1777	2025-01-08 00:00:00	13
1623	3	2025-03-15 11:55:00	2025-03-15 15:19:00	30	отменен	912	19	2212.3650000000002	1777	2025-02-18 00:00:00	8
1624	3	2025-03-15 11:55:00	2025-03-15 15:19:00	30	оплачен	904	19	2162.609	1777	2025-01-21 00:00:00	24
1625	3	2025-03-15 11:55:00	2025-03-15 15:19:00	30	отменен	949	19	2313.654	1777	2025-01-25 00:00:00	19
1626	3	2025-03-15 11:55:00	2025-03-15 15:19:00	30	оплачен	920	19	2000.9019999999998	1777	2025-01-21 00:00:00	7
1627	3	2025-03-15 11:55:00	2025-03-15 15:19:00	30	забронирован	905	19	1988.463	1777	2025-01-21 00:00:00	7
1628	3	2025-03-15 11:55:00	2025-03-15 15:19:00	30	оплачен	916	19	2027.557	1777	2025-01-16 00:00:00	24
1629	3	2025-03-15 11:55:00	2025-03-15 15:19:00	30	отменен	944	19	2130.623	1777	2025-02-10 00:00:00	22
1630	3	2025-03-15 11:55:00	2025-03-15 15:19:00	30	забронирован	942	19	2006.233	1777	2025-02-08 00:00:00	12
1631	3	2025-03-15 11:55:00	2025-03-15 15:19:00	30	отменен	936	19	1951.1460000000002	1777	2025-01-13 00:00:00	21
1632	3	2025-03-15 11:55:00	2025-03-15 15:19:00	30	оплачен	927	19	1915.6060000000002	1777	2025-02-20 00:00:00	19
1633	3	2025-03-15 11:55:00	2025-03-15 15:19:00	30	отменен	932	19	2244.3509999999997	1777	2025-01-19 00:00:00	15
1634	3	2025-03-15 11:55:00	2025-03-15 15:19:00	30	оплачен	918	19	2267.452	1777	2025-02-25 00:00:00	15
1635	3	2025-03-15 11:55:00	2025-03-15 15:19:00	30	забронирован	911	19	2352.748	1777	2025-03-08 00:00:00	21
1636	3	2025-03-15 11:55:00	2025-03-15 15:19:00	30	оплачен	943	19	1878.289	1777	2025-01-04 00:00:00	8
1637	3	2025-03-15 11:55:00	2025-03-15 15:19:00	30	отменен	930	19	2024.003	1777	2025-01-05 00:00:00	21
1638	3	2025-03-15 11:55:00	2025-03-15 15:19:00	30	отменен	909	19	2082.644	1777	2025-01-29 00:00:00	19
1639	3	2025-03-15 11:55:00	2025-03-15 15:19:00	30	оплачен	937	19	2029.3339999999998	1777	2025-01-31 00:00:00	14
1640	3	2025-03-15 11:55:00	2025-03-15 15:19:00	30	забронирован	935	19	1801.878	1777	2025-01-02 00:00:00	16
1641	3	2025-03-15 11:55:00	2025-03-15 15:19:00	30	отменен	915	19	2231.912	1777	2025-01-24 00:00:00	20
1642	3	2025-03-15 11:55:00	2025-03-15 15:19:00	30	оплачен	907	19	1858.742	1777	2025-01-30 00:00:00	21
1643	3	2025-03-15 11:55:00	2025-03-15 15:19:00	30	забронирован	924	19	2079.0899999999997	1777	2025-02-27 00:00:00	22
1644	3	2025-03-15 11:55:00	2025-03-15 15:19:00	30	отменен	947	19	2269.229	1777	2025-01-18 00:00:00	9
1645	3	2025-03-15 11:55:00	2025-03-15 15:19:00	30	забронирован	919	19	2212.3650000000002	1777	2025-02-15 00:00:00	10
1646	3	2025-03-15 11:55:00	2025-03-15 15:19:00	30	забронирован	931	19	1940.4840000000002	1777	2025-03-14 00:00:00	18
1647	3	2025-03-15 11:55:00	2025-03-15 15:19:00	30	оплачен	928	19	2310.1	1777	2025-02-17 00:00:00	12
1648	3	2025-03-15 11:55:00	2025-03-15 15:19:00	30	забронирован	922	19	2084.4210000000003	1777	2025-01-23 00:00:00	11
1649	3	2025-03-15 11:55:00	2025-03-15 15:19:00	30	забронирован	946	19	1944.0380000000002	1777	2025-02-20 00:00:00	24
1650	3	2025-03-15 11:55:00	2025-03-15 15:19:00	30	забронирован	906	19	2247.9049999999997	1777	2025-02-12 00:00:00	20
1651	3	2025-03-15 11:55:00	2025-03-15 15:19:00	30	забронирован	948	19	2267.452	1777	2025-02-12 00:00:00	19
1652	3	2025-03-15 11:55:00	2025-03-15 15:19:00	30	забронирован	902	19	2151.947	1777	2025-01-06 00:00:00	8
1653	3	2025-03-15 12:41:00	2025-03-15 13:24:00	28	забронирован	968	24	8730.575	7127	2025-03-03 00:00:00	6
1654	3	2025-03-15 12:41:00	2025-03-15 13:24:00	28	отменен	966	24	7889.589	7127	2025-01-02 00:00:00	19
1655	3	2025-03-15 12:41:00	2025-03-15 13:24:00	28	оплачен	992	24	7347.936999999999	7127	2025-02-10 00:00:00	18
1656	3	2025-03-15 12:41:00	2025-03-15 13:24:00	28	оплачен	983	24	8794.718	7127	2025-01-18 00:00:00	24
1657	3	2025-03-15 12:41:00	2025-03-15 13:24:00	28	оплачен	993	24	7198.27	7127	2025-02-10 00:00:00	13
1658	3	2025-03-15 12:41:00	2025-03-15 13:24:00	28	отменен	961	24	7697.160000000001	7127	2025-01-13 00:00:00	22
1659	3	2025-03-15 12:41:00	2025-03-15 13:24:00	28	оплачен	962	24	9379.132	7127	2025-02-28 00:00:00	19
1660	3	2025-03-15 12:41:00	2025-03-15 13:24:00	28	забронирован	975	24	8908.75	7127	2025-02-27 00:00:00	15
1661	3	2025-03-15 12:41:00	2025-03-15 13:24:00	28	оплачен	996	24	7404.9529999999995	7127	2025-03-14 00:00:00	24
1662	3	2025-03-15 12:41:00	2025-03-15 13:24:00	28	забронирован	971	24	7903.843	7127	2025-01-13 00:00:00	7
1663	3	2025-03-15 12:41:00	2025-03-15 13:24:00	28	отменен	964	24	7276.6669999999995	7127	2025-02-08 00:00:00	18
1664	3	2025-03-15 12:41:00	2025-03-15 13:24:00	28	оплачен	973	24	7732.795	7127	2025-01-24 00:00:00	15
1665	3	2025-03-15 12:41:00	2025-03-15 13:24:00	28	забронирован	952	24	8267.32	7127	2025-03-07 00:00:00	8
1666	3	2025-03-15 12:41:00	2025-03-15 13:24:00	28	забронирован	1000	24	7226.778	7127	2025-02-03 00:00:00	24
1667	3	2025-03-15 12:41:00	2025-03-15 13:24:00	28	забронирован	979	24	8281.573999999999	7127	2025-01-16 00:00:00	11
1668	3	2025-03-15 12:41:00	2025-03-15 13:24:00	28	отменен	955	24	7476.223	7127	2025-02-15 00:00:00	22
1669	3	2025-03-15 12:41:00	2025-03-15 13:24:00	28	оплачен	956	24	8338.59	7127	2025-03-04 00:00:00	19
1670	3	2025-03-15 12:41:00	2025-03-15 13:24:00	28	отменен	989	24	7796.938000000001	7127	2025-02-16 00:00:00	11
1671	3	2025-03-15 12:41:00	2025-03-15 13:24:00	28	забронирован	988	24	7262.413	7127	2025-01-15 00:00:00	11
1672	3	2025-03-15 12:41:00	2025-03-15 13:24:00	28	отменен	969	24	7718.541	7127	2025-02-15 00:00:00	18
1673	3	2025-03-15 12:41:00	2025-03-15 13:24:00	28	оплачен	999	24	9172.448999999999	7127	2025-03-13 00:00:00	21
1674	3	2025-03-15 12:41:00	2025-03-15 13:24:00	28	отменен	990	24	9072.670999999998	7127	2025-02-16 00:00:00	12
1675	3	2025-03-15 12:41:00	2025-03-15 13:24:00	28	отменен	985	24	7483.35	7127	2025-02-20 00:00:00	8
1676	3	2025-03-15 12:41:00	2025-03-15 13:24:00	28	забронирован	980	24	9386.259	7127	2025-02-03 00:00:00	14
1677	3	2025-03-15 12:41:00	2025-03-15 13:24:00	28	оплачен	986	24	8424.114	7127	2025-02-25 00:00:00	16
1678	3	2025-03-15 12:41:00	2025-03-15 13:24:00	28	забронирован	998	24	7155.508	7127	2025-02-12 00:00:00	6
1679	3	2025-03-15 12:41:00	2025-03-15 13:24:00	28	забронирован	977	24	7889.589	7127	2025-02-06 00:00:00	23
1680	3	2025-03-15 12:41:00	2025-03-15 13:24:00	28	оплачен	959	24	8523.892	7127	2025-03-05 00:00:00	16
1681	3	2025-03-15 12:41:00	2025-03-15 13:24:00	28	отменен	976	24	9037.036	7127	2025-01-20 00:00:00	10
1682	3	2025-03-15 12:41:00	2025-03-15 13:24:00	28	забронирован	957	24	8409.859999999999	7127	2025-02-28 00:00:00	8
1683	3	2025-03-15 12:41:00	2025-03-15 13:24:00	28	забронирован	953	24	9400.512999999999	7127	2025-01-15 00:00:00	6
1684	3	2025-03-15 12:41:00	2025-03-15 13:24:00	28	оплачен	965	24	8559.527	7127	2025-01-04 00:00:00	18
1685	3	2025-03-15 12:41:00	2025-03-15 13:24:00	28	забронирован	958	24	7162.634999999999	7127	2025-01-04 00:00:00	20
1686	3	2025-03-15 12:41:00	2025-03-15 13:24:00	28	оплачен	997	24	9151.068000000001	7127	2025-02-21 00:00:00	9
1687	3	2025-03-15 12:41:00	2025-03-15 13:24:00	28	отменен	960	24	8751.956	7127	2025-01-01 00:00:00	12
1688	3	2025-03-15 12:41:00	2025-03-15 13:24:00	28	отменен	970	24	8345.717	7127	2025-01-14 00:00:00	6
1689	3	2025-03-15 12:41:00	2025-03-15 13:24:00	28	оплачен	954	24	7747.049	7127	2025-01-25 00:00:00	8
1690	3	2025-03-15 12:41:00	2025-03-15 13:24:00	28	забронирован	981	24	8951.512	7127	2025-01-25 00:00:00	18
1691	3	2025-03-15 12:41:00	2025-03-15 13:24:00	28	забронирован	967	24	7889.589	7127	2025-02-15 00:00:00	23
1692	3	2025-03-15 12:41:00	2025-03-15 13:24:00	28	забронирован	995	24	9165.322	7127	2025-01-18 00:00:00	6
1693	3	2025-03-15 12:41:00	2025-03-15 13:24:00	28	отменен	991	24	8409.859999999999	7127	2025-02-26 00:00:00	18
1694	3	2025-03-15 12:41:00	2025-03-15 13:24:00	28	оплачен	978	24	7768.43	7127	2025-01-29 00:00:00	16
1695	3	2025-03-15 12:41:00	2025-03-15 13:24:00	28	забронирован	951	24	7875.335	7127	2025-02-26 00:00:00	16
1696	3	2025-03-15 12:18:00	2025-03-15 14:56:00	29	отменен	972	20	9680.391	7317	2025-01-09 00:00:00	16
1697	3	2025-03-15 12:18:00	2025-03-15 14:56:00	29	оплачен	977	20	8509.671	7317	2025-01-30 00:00:00	12
1698	3	2025-03-15 12:18:00	2025-03-15 14:56:00	29	отменен	969	20	8034.066000000001	7317	2025-01-26 00:00:00	8
1699	3	2025-03-15 12:18:00	2025-03-15 14:56:00	29	отменен	960	20	9468.198	7317	2025-02-09 00:00:00	21
1700	3	2025-03-15 12:18:00	2025-03-15 14:56:00	29	отменен	982	20	9212.103	7317	2025-03-10 00:00:00	17
1701	3	2025-03-15 12:18:00	2025-03-15 14:56:00	29	отменен	954	20	8736.498	7317	2025-03-10 00:00:00	8
1702	3	2025-03-15 12:18:00	2025-03-15 14:56:00	29	оплачен	963	20	9416.979	7317	2025-02-09 00:00:00	8
1703	3	2025-03-15 12:18:00	2025-03-15 14:56:00	29	отменен	995	20	8041.383	7317	2025-02-01 00:00:00	6
1704	3	2025-03-15 12:18:00	2025-03-15 14:56:00	29	забронирован	961	20	7543.826999999999	7317	2025-01-13 00:00:00	21
1705	3	2025-03-15 12:18:00	2025-03-15 14:56:00	29	оплачен	953	20	8012.115	7317	2025-01-23 00:00:00	22
1706	3	2025-03-15 12:18:00	2025-03-15 14:56:00	29	отменен	979	20	9468.198	7317	2025-01-22 00:00:00	15
1707	3	2025-03-15 12:18:00	2025-03-15 14:56:00	29	забронирован	997	20	8853.57	7317	2025-02-17 00:00:00	9
1708	14	2025-03-07 12:40:00	2025-03-07 13:15:00	12	забронирован	1003	16	1962.195	1527	2025-03-04 00:00:00	18
1709	14	2025-03-07 12:40:00	2025-03-07 13:15:00	12	оплачен	1004	16	1682.7540000000001	1527	2025-01-12 00:00:00	23
1710	14	2025-03-07 12:40:00	2025-03-07 13:15:00	12	оплачен	1001	16	1687.335	1527	2025-01-21 00:00:00	14
1711	14	2025-03-07 12:40:00	2025-03-07 13:15:00	12	забронирован	1002	16	1705.6589999999999	1527	2025-03-01 00:00:00	16
1712	14	2025-03-07 12:40:00	2025-03-07 13:15:00	12	оплачен	1006	16	1737.7259999999999	1527	2025-01-16 00:00:00	19
1713	14	2025-03-07 12:40:00	2025-03-07 13:15:00	12	оплачен	1007	16	1675.119	1527	2025-01-24 00:00:00	10
1714	14	2025-03-07 12:40:00	2025-03-07 13:15:00	12	забронирован	1009	16	1974.4109999999998	1527	2025-02-10 00:00:00	20
1715	14	2025-03-07 12:40:00	2025-03-07 13:34:00	12	отменен	1103	20	16296.528	12692	2025-02-24 00:00:00	25
1716	14	2025-03-07 12:40:00	2025-03-07 13:34:00	12	отменен	1056	20	14989.252	12692	2025-02-28 00:00:00	15
1717	14	2025-03-07 12:40:00	2025-03-07 13:34:00	12	оплачен	1081	20	13428.136	12692	2025-01-08 00:00:00	23
1718	14	2025-03-07 12:40:00	2025-03-07 13:34:00	12	отменен	1040	20	14925.792	12692	2025-02-15 00:00:00	15
1719	14	2025-03-07 12:40:00	2025-03-07 13:34:00	12	оплачен	1059	20	15776.156	12692	2025-01-05 00:00:00	14
1720	14	2025-03-07 12:40:00	2025-03-07 13:34:00	12	забронирован	1088	20	14570.416	12692	2025-02-05 00:00:00	24
1721	14	2025-03-07 12:40:00	2025-03-07 13:34:00	12	отменен	1125	20	16918.435999999998	12692	2025-01-15 00:00:00	25
1722	14	2025-03-07 12:40:00	2025-03-07 13:34:00	12	отменен	1039	20	15915.768	12692	2025-01-20 00:00:00	12
1723	14	2025-03-07 12:40:00	2025-03-07 13:34:00	12	оплачен	1129	20	12869.688	12692	2025-02-20 00:00:00	21
1724	14	2025-03-07 12:40:00	2025-03-07 13:34:00	12	отменен	1062	20	13948.508	12692	2025-02-08 00:00:00	20
1725	14	2025-03-07 12:40:00	2025-03-07 13:34:00	12	оплачен	1130	20	15953.844	12692	2025-01-15 00:00:00	13
1726	14	2025-03-07 12:40:00	2025-03-07 13:34:00	12	забронирован	1123	20	13758.128	12692	2025-01-09 00:00:00	25
1727	14	2025-03-07 12:40:00	2025-03-07 13:34:00	12	оплачен	1084	20	13428.136	12692	2025-02-05 00:00:00	22
1728	14	2025-03-07 12:40:00	2025-03-07 13:34:00	12	отменен	1075	20	13263.14	12692	2025-02-21 00:00:00	8
1729	14	2025-03-07 12:40:00	2025-03-07 13:34:00	12	забронирован	1076	20	14151.58	12692	2025-01-20 00:00:00	14
1730	14	2025-03-07 12:40:00	2025-03-07 13:34:00	12	оплачен	1055	20	13516.98	12692	2025-01-18 00:00:00	12
1731	14	2025-03-07 12:40:00	2025-03-07 13:34:00	12	оплачен	1011	20	13923.124	12692	2025-02-14 00:00:00	21
1732	14	2025-03-07 12:40:00	2025-03-07 13:34:00	12	забронирован	1087	20	15205.016	12692	2025-02-19 00:00:00	23
1733	14	2025-03-07 12:40:00	2025-03-07 13:34:00	12	отменен	1043	20	16334.604	12692	2025-02-19 00:00:00	21
1734	14	2025-03-07 12:40:00	2025-03-07 13:34:00	12	забронирован	1063	20	13999.276	12692	2025-02-25 00:00:00	20
1735	14	2025-03-07 13:56:00	2025-03-07 14:31:00	23	отменен	1025	28	16747.16	13660	2025-01-08 00:00:00	17
1736	14	2025-03-07 13:56:00	2025-03-07 14:31:00	23	отменен	1114	28	14165.419999999998	13660	2025-02-09 00:00:00	9
1737	14	2025-03-07 13:56:00	2025-03-07 14:31:00	23	отменен	1016	28	16473.96	13660	2025-03-01 00:00:00	8
1738	14	2025-03-07 13:56:00	2025-03-07 14:31:00	23	забронирован	1106	28	17457.48	13660	2025-01-27 00:00:00	15
1739	14	2025-03-07 13:56:00	2025-03-07 14:31:00	23	оплачен	1095	28	17075	13660	2025-01-16 00:00:00	8
1740	14	2025-03-07 13:56:00	2025-03-07 14:31:00	23	забронирован	1086	28	17389.18	13660	2025-01-27 00:00:00	6
1741	14	2025-03-07 13:56:00	2025-03-07 14:31:00	23	оплачен	1059	28	17798.98	13660	2025-01-23 00:00:00	19
1742	14	2025-03-07 13:56:00	2025-03-07 14:31:00	23	отменен	1129	28	18113.16	13660	2025-02-06 00:00:00	10
1743	14	2025-03-07 13:56:00	2025-03-07 14:31:00	23	забронирован	1091	28	17894.600000000002	13660	2025-01-16 00:00:00	25
1744	14	2025-03-07 13:56:00	2025-03-07 14:31:00	23	отменен	1111	28	15790.96	13660	2025-02-09 00:00:00	9
1745	14	2025-03-07 13:56:00	2025-03-07 14:31:00	23	отменен	1082	28	14616.2	13660	2025-03-02 00:00:00	23
1746	14	2025-03-07 13:56:00	2025-03-07 14:31:00	23	отменен	1054	28	14711.82	13660	2025-02-17 00:00:00	16
1747	14	2025-03-07 13:56:00	2025-03-07 14:31:00	23	отменен	1065	28	16678.86	13660	2025-02-05 00:00:00	23
1748	14	2025-03-07 13:56:00	2025-03-07 14:31:00	23	оплачен	1120	28	14493.259999999998	13660	2025-02-06 00:00:00	23
1749	14	2025-03-07 13:56:00	2025-03-07 14:31:00	23	забронирован	1047	28	15531.42	13660	2025-03-07 00:00:00	16
1750	14	2025-03-07 13:56:00	2025-03-07 14:31:00	23	отменен	1127	28	16077.820000000002	13660	2025-01-27 00:00:00	14
1751	14	2025-03-07 13:56:00	2025-03-07 14:31:00	23	отменен	1103	28	14261.04	13660	2025-02-07 00:00:00	6
1752	14	2025-03-07 13:56:00	2025-03-07 14:31:00	23	отменен	1088	28	16446.64	13660	2025-01-04 00:00:00	23
1753	14	2025-03-07 13:56:00	2025-03-07 14:31:00	23	отменен	1062	28	15504.1	13660	2025-02-14 00:00:00	22
1754	14	2025-03-07 13:56:00	2025-03-07 14:31:00	23	оплачен	1046	28	16583.239999999998	13660	2025-01-26 00:00:00	24
1755	14	2025-03-07 13:56:00	2025-03-07 14:31:00	23	отменен	1109	28	17156.96	13660	2025-02-06 00:00:00	7
1756	14	2025-03-07 13:56:00	2025-03-07 14:31:00	23	забронирован	1060	28	16624.22	13660	2025-02-16 00:00:00	10
1757	14	2025-03-07 13:56:00	2025-03-07 14:31:00	23	отменен	1072	28	15695.34	13660	2025-01-12 00:00:00	21
1758	14	2025-03-07 13:56:00	2025-03-07 14:31:00	23	забронирован	1018	28	13878.56	13660	2025-01-26 00:00:00	15
1759	14	2025-03-07 13:56:00	2025-03-07 14:31:00	23	забронирован	1077	28	17006.7	13660	2025-02-10 00:00:00	9
1760	14	2025-03-07 13:56:00	2025-03-07 14:31:00	23	забронирован	1028	28	17894.600000000002	13660	2025-01-27 00:00:00	14
1761	14	2025-03-07 13:56:00	2025-03-07 14:31:00	23	отменен	1101	28	13700.979999999998	13660	2025-02-28 00:00:00	16
1762	14	2025-03-07 13:56:00	2025-03-07 14:31:00	23	отменен	1012	28	15545.079999999998	13660	2025-01-27 00:00:00	17
1763	14	2025-03-07 13:56:00	2025-03-07 14:31:00	23	оплачен	1080	28	15504.1	13660	2025-02-21 00:00:00	16
1764	14	2025-03-07 13:56:00	2025-03-07 14:31:00	23	оплачен	1021	28	17949.24	13660	2025-01-18 00:00:00	13
1765	14	2025-03-07 13:56:00	2025-03-07 14:31:00	23	забронирован	1068	28	13673.659999999998	13660	2025-03-07 00:00:00	21
1766	14	2025-03-07 13:56:00	2025-03-07 14:31:00	23	оплачен	1121	28	15968.54	13660	2025-02-10 00:00:00	15
1767	14	2025-03-07 13:56:00	2025-03-07 14:31:00	23	оплачен	1036	28	14602.539999999999	13660	2025-02-09 00:00:00	16
1768	14	2025-03-07 13:56:00	2025-03-07 14:31:00	23	отменен	1033	28	17539.44	13660	2025-01-01 00:00:00	14
1769	14	2025-03-07 13:56:00	2025-03-07 14:31:00	23	забронирован	1053	28	17798.98	13660	2025-02-27 00:00:00	12
1770	14	2025-03-07 13:56:00	2025-03-07 14:31:00	23	отменен	1078	28	14862.080000000002	13660	2025-01-15 00:00:00	9
1771	14	2025-03-07 12:40:00	2025-03-07 14:31:00	12	оплачен	1175	28	9791.748	8079	2025-01-30 00:00:00	7
1772	14	2025-03-07 12:40:00	2025-03-07 14:31:00	12	забронирован	1185	28	8143.632	8079	2025-02-16 00:00:00	16
1773	14	2025-03-07 12:40:00	2025-03-07 14:31:00	12	оплачен	1174	28	8248.659	8079	2025-03-04 00:00:00	15
1774	14	2025-03-07 12:40:00	2025-03-07 14:31:00	12	оплачен	1181	28	8709.162	8079	2025-01-11 00:00:00	23
1775	14	2025-03-07 12:40:00	2025-03-07 14:31:00	12	забронирован	1170	28	10042.197	8079	2025-01-11 00:00:00	12
1776	14	2025-03-07 12:40:00	2025-03-07 14:31:00	12	отменен	1143	28	8870.742	8079	2025-01-19 00:00:00	9
1777	14	2025-03-07 12:40:00	2025-03-07 14:31:00	12	отменен	1164	28	8870.742	8079	2025-01-09 00:00:00	18
1778	14	2025-03-07 12:40:00	2025-03-07 14:31:00	12	оплачен	1138	28	8426.396999999999	8079	2025-01-09 00:00:00	7
1779	14	2025-03-07 12:40:00	2025-03-07 14:31:00	12	отменен	1157	28	9250.455	8079	2025-01-31 00:00:00	9
1780	14	2025-03-07 12:40:00	2025-03-07 14:31:00	12	забронирован	1134	28	9630.168	8079	2025-02-28 00:00:00	24
1781	14	2025-03-07 12:40:00	2025-03-07 14:31:00	12	забронирован	1141	28	10494.621	8079	2025-02-27 00:00:00	13
1782	14	2025-03-07 12:40:00	2025-03-07 14:31:00	12	забронирован	1182	28	9662.484	8079	2025-01-10 00:00:00	23
1783	14	2025-03-07 12:40:00	2025-03-07 14:31:00	12	оплачен	1144	28	8264.817	8079	2025-01-23 00:00:00	18
1784	14	2025-03-07 12:40:00	2025-03-07 14:31:00	12	отменен	1178	28	8523.345	8079	2025-03-06 00:00:00	17
1785	14	2025-03-07 12:40:00	2025-03-07 14:31:00	12	забронирован	1163	28	9953.328	8079	2025-02-13 00:00:00	25
1786	14	2025-03-07 12:40:00	2025-03-07 14:31:00	12	оплачен	1180	28	9654.405	8079	2025-02-13 00:00:00	18
1787	14	2025-03-07 12:40:00	2025-03-07 14:31:00	12	отменен	1183	28	10114.908	8079	2025-01-07 00:00:00	13
1788	14	2025-03-07 12:40:00	2025-03-07 14:31:00	12	оплачен	1156	28	9840.222	8079	2025-01-26 00:00:00	21
1789	14	2025-03-07 12:40:00	2025-03-07 14:31:00	12	отменен	1152	28	10405.752	8079	2025-02-01 00:00:00	6
1790	14	2025-03-07 12:40:00	2025-03-07 14:31:00	12	оплачен	1176	28	10494.621	8079	2025-01-17 00:00:00	10
1791	14	2025-03-07 12:40:00	2025-03-07 14:31:00	12	забронирован	1161	28	10171.461	8079	2025-01-24 00:00:00	22
1792	14	2025-03-07 12:40:00	2025-03-07 14:31:00	12	оплачен	1189	28	9622.089	8079	2025-01-18 00:00:00	19
1793	14	2025-03-07 12:40:00	2025-03-07 14:31:00	12	оплачен	1188	28	9525.141	8079	2025-01-08 00:00:00	19
1794	14	2025-03-07 12:40:00	2025-03-07 14:31:00	12	оплачен	1147	28	8814.189	8079	2025-03-04 00:00:00	8
1795	14	2025-03-07 12:40:00	2025-03-07 14:31:00	12	забронирован	1187	28	10470.384	8079	2025-03-06 00:00:00	16
1796	14	2025-03-07 12:40:00	2025-03-07 14:31:00	12	забронирован	1139	28	8636.451	8079	2025-01-01 00:00:00	8
1797	14	2025-03-07 12:40:00	2025-03-07 14:31:00	12	отменен	1179	28	9791.748	8079	2025-03-04 00:00:00	13
1798	14	2025-03-07 12:40:00	2025-03-07 14:31:00	12	отменен	1186	28	8280.974999999999	8079	2025-02-23 00:00:00	18
1799	14	2025-03-07 12:40:00	2025-03-07 14:31:00	12	отменен	1153	28	8555.661	8079	2025-02-12 00:00:00	14
1800	14	2025-03-07 12:40:00	2025-03-07 14:31:00	12	забронирован	1135	28	10535.016	8079	2025-02-27 00:00:00	18
1801	14	2025-03-07 12:40:00	2025-03-07 14:31:00	12	оплачен	1146	28	8878.821	8079	2025-02-21 00:00:00	17
1802	14	2025-03-07 12:40:00	2025-03-07 14:31:00	12	отменен	1148	28	8345.607	8079	2025-02-10 00:00:00	23
1803	14	2025-03-07 12:40:00	2025-03-07 14:31:00	12	отменен	1136	28	8547.582	8079	2025-02-11 00:00:00	13
1804	14	2025-03-07 12:40:00	2025-03-07 14:31:00	12	забронирован	1169	28	9775.59	8079	2025-03-03 00:00:00	22
1805	14	2025-03-07 12:40:00	2025-03-07 14:31:00	12	забронирован	1154	28	8216.342999999999	8079	2025-02-02 00:00:00	24
1806	14	2025-03-07 12:40:00	2025-03-07 14:31:00	12	забронирован	1160	28	9622.089	8079	2025-03-01 00:00:00	10
1807	14	2025-03-07 12:40:00	2025-03-07 14:31:00	12	отменен	1177	28	9517.062	8079	2025-02-03 00:00:00	9
1808	14	2025-03-07 12:40:00	2025-03-07 14:31:00	12	оплачен	1132	28	8935.374000000002	8079	2025-02-02 00:00:00	15
1809	14	2025-03-07 12:40:00	2025-03-07 14:31:00	12	забронирован	1173	28	9500.903999999999	8079	2025-02-27 00:00:00	17
1810	14	2025-03-07 12:40:00	2025-03-07 14:31:00	12	оплачен	1162	28	8838.426000000001	8079	2025-01-01 00:00:00	6
1811	14	2025-03-07 12:40:00	2025-03-07 14:31:00	12	оплачен	1165	28	10228.014	8079	2025-01-25 00:00:00	24
1812	14	2025-03-07 12:40:00	2025-03-07 14:31:00	12	забронирован	1155	28	8313.291	8079	2025-02-19 00:00:00	24
1813	14	2025-03-07 12:40:00	2025-03-07 14:31:00	12	отменен	1145	28	8515.266	8079	2025-02-02 00:00:00	8
1814	14	2025-03-07 12:40:00	2025-03-07 14:31:00	12	оплачен	1166	28	9242.375999999998	8079	2025-03-02 00:00:00	18
1815	14	2025-03-07 12:40:00	2025-03-07 14:31:00	12	оплачен	1184	28	8951.532000000001	8079	2025-01-21 00:00:00	13
1816	14	2025-03-07 12:40:00	2025-03-07 14:31:00	12	отменен	1158	28	8426.396999999999	8079	2025-01-23 00:00:00	17
1817	14	2025-03-07 12:40:00	2025-03-07 14:31:00	12	забронирован	1140	28	9573.615	8079	2025-02-11 00:00:00	8
1818	14	2025-03-07 12:40:00	2025-03-07 14:31:00	12	отменен	1168	28	8717.241	8079	2025-01-05 00:00:00	22
1819	14	2025-03-07 12:40:00	2025-03-07 14:31:00	12	забронирован	1150	28	9678.642	8079	2025-01-11 00:00:00	15
1820	14	2025-03-07 12:40:00	2025-03-07 14:31:00	12	отменен	1167	28	9848.301000000001	8079	2025-02-05 00:00:00	16
1821	14	2025-03-07 12:40:00	2025-03-07 14:31:00	12	отменен	1149	28	8289.054	8079	2025-01-18 00:00:00	19
1822	14	2025-03-07 12:40:00	2025-03-07 14:31:00	12	забронирован	1133	28	8628.372000000001	8079	2025-02-20 00:00:00	22
1823	14	2025-03-07 12:40:00	2025-03-07 14:31:00	12	оплачен	1137	28	10171.461	8079	2025-02-05 00:00:00	21
1824	14	2025-03-07 12:40:00	2025-03-07 14:31:00	12	забронирован	1159	28	9872.538	8079	2025-02-27 00:00:00	14
1825	14	2025-03-07 12:40:00	2025-03-07 14:31:00	12	оплачен	1151	28	9428.193000000001	8079	2025-02-21 00:00:00	11
1826	14	2025-03-07 12:40:00	2025-03-07 14:31:00	12	отменен	1131	28	10026.039	8079	2025-02-19 00:00:00	20
1827	14	2025-03-07 12:40:00	2025-03-07 14:31:00	12	отменен	1172	28	9605.931	8079	2025-02-10 00:00:00	21
1828	40	2025-01-03 08:49:00	2025-01-03 10:50:00	10	отменен	1230	12	9786.953	8503	2025-01-01 00:00:00	21
1829	40	2025-01-03 08:49:00	2025-01-03 10:50:00	10	отменен	1239	12	9013.18	8503	2025-01-02 00:00:00	18
1830	40	2025-01-03 08:49:00	2025-01-03 10:50:00	10	отменен	1214	12	8715.574999999999	8503	2025-01-02 00:00:00	16
1831	40	2025-01-03 08:49:00	2025-01-03 10:50:00	10	забронирован	1246	12	10144.079	8503	2025-01-02 00:00:00	19
1832	40	2025-01-03 08:49:00	2025-01-03 10:50:00	10	отменен	1220	12	9940.007	8503	2025-01-03 00:00:00	8
1833	40	2025-01-03 08:49:00	2025-01-03 10:50:00	10	оплачен	1258	12	11079.409	8503	2025-01-02 00:00:00	8
1834	40	2025-01-03 08:49:00	2025-01-03 10:50:00	10	отменен	1225	12	9285.276	8503	2025-01-02 00:00:00	18
1835	40	2025-01-03 08:49:00	2025-01-03 10:50:00	10	отменен	1195	12	9931.503999999999	8503	2025-01-02 00:00:00	17
1836	40	2025-01-03 08:49:00	2025-01-03 10:50:00	10	отменен	1191	12	9667.911	8503	2025-01-01 00:00:00	8
1837	40	2025-01-03 08:49:00	2025-01-03 10:50:00	10	оплачен	1221	12	8860.126	8503	2025-01-03 00:00:00	22
1838	40	2025-01-03 08:49:00	2025-01-03 10:50:00	10	оплачен	1249	12	8817.610999999999	8503	2025-01-01 00:00:00	13
1839	40	2025-01-03 08:49:00	2025-01-03 10:50:00	10	забронирован	1248	12	10968.87	8503	2025-01-01 00:00:00	25
1840	40	2025-01-03 08:49:00	2025-01-03 10:50:00	10	оплачен	1247	12	10195.097	8503	2025-01-01 00:00:00	12
1841	40	2025-01-03 08:49:00	2025-01-03 10:50:00	10	оплачен	1238	12	10611.744	8503	2025-01-01 00:00:00	8
1842	40	2025-01-03 08:49:00	2025-01-03 10:50:00	10	оплачен	1227	12	9642.401999999998	8503	2025-01-03 00:00:00	8
1843	40	2025-01-03 08:49:00	2025-01-03 10:50:00	10	оплачен	1255	12	10373.66	8503	2025-01-01 00:00:00	24
1844	40	2025-01-03 08:49:00	2025-01-03 10:50:00	10	оплачен	1241	12	8817.610999999999	8503	2025-01-03 00:00:00	16
1845	40	2025-01-03 08:49:00	2025-01-03 10:50:00	10	оплачен	1236	12	11283.481	8503	2025-01-02 00:00:00	13
1846	40	2025-01-03 08:49:00	2025-01-03 10:50:00	10	отменен	1235	12	11291.984	8503	2025-01-02 00:00:00	25
1847	40	2025-01-03 08:49:00	2025-01-03 10:50:00	10	отменен	1240	12	9183.24	8503	2025-01-02 00:00:00	24
1848	40	2025-01-03 08:49:00	2025-01-03 10:50:00	10	забронирован	1250	12	10118.57	8503	2025-01-01 00:00:00	10
1849	40	2025-01-03 08:49:00	2025-01-03 10:50:00	10	отменен	1199	12	8732.581	8503	2025-01-01 00:00:00	13
1850	40	2025-01-03 08:49:00	2025-01-03 10:50:00	10	отменен	1213	12	10569.229000000001	8503	2025-01-02 00:00:00	23
1851	40	2025-01-03 08:49:00	2025-01-03 10:50:00	10	оплачен	1257	12	8809.108	8503	2025-01-01 00:00:00	20
1852	40	2025-01-03 08:49:00	2025-01-03 10:50:00	10	забронирован	1222	12	10101.564	8503	2025-01-01 00:00:00	23
1853	40	2025-01-03 08:49:00	2025-01-03 10:50:00	10	забронирован	1245	12	9642.401999999998	8503	2025-01-03 00:00:00	11
1854	40	2025-01-03 08:49:00	2025-01-03 10:50:00	10	оплачен	1226	12	9327.791	8503	2025-01-02 00:00:00	23
1855	40	2025-01-03 08:49:00	2025-01-03 10:50:00	10	забронирован	1254	12	11257.972	8503	2025-01-01 00:00:00	21
1856	40	2025-01-03 08:49:00	2025-01-03 10:50:00	10	забронирован	1244	12	9081.204	8503	2025-01-03 00:00:00	23
1857	40	2025-01-03 08:49:00	2025-01-03 10:50:00	10	забронирован	1231	12	9404.318000000001	8503	2025-01-02 00:00:00	14
1858	40	2025-01-03 08:49:00	2025-01-03 10:50:00	10	отменен	1211	12	9030.186	8503	2025-01-02 00:00:00	20
1859	40	2025-01-03 08:49:00	2025-01-03 10:50:00	10	отменен	1196	12	10807.313	8503	2025-01-01 00:00:00	17
1860	40	2025-01-03 08:49:00	2025-01-03 10:50:00	10	отменен	1252	12	9642.401999999998	8503	2025-01-01 00:00:00	10
1861	40	2025-01-03 08:49:00	2025-01-03 10:50:00	10	забронирован	1259	12	11155.936	8503	2025-01-03 00:00:00	18
1862	40	2025-01-03 08:49:00	2025-01-03 10:50:00	10	забронирован	1216	12	9888.989	8503	2025-01-03 00:00:00	21
1863	40	2025-01-03 08:49:00	2025-01-03 10:50:00	10	оплачен	1217	12	9625.395999999999	8503	2025-01-02 00:00:00	19
1864	40	2025-01-03 08:49:00	2025-01-03 10:50:00	10	оплачен	1233	12	10985.876	8503	2025-01-02 00:00:00	23
1865	40	2025-01-03 08:49:00	2025-01-03 10:50:00	10	отменен	1223	12	9991.025	8503	2025-01-01 00:00:00	23
1866	40	2025-01-03 08:49:00	2025-01-03 10:50:00	10	забронирован	1200	12	10628.75	8503	2025-01-03 00:00:00	20
1867	40	2025-01-03 08:49:00	2025-01-03 10:50:00	10	забронирован	1215	12	11249.469	8503	2025-01-01 00:00:00	21
1868	40	2025-01-03 08:49:00	2025-01-03 10:50:00	10	отменен	1194	12	10450.187	8503	2025-01-03 00:00:00	18
1869	40	2025-01-03 08:49:00	2025-01-03 10:50:00	10	забронирован	1228	12	10348.151	8503	2025-01-01 00:00:00	20
1870	40	2025-01-03 08:49:00	2025-01-03 10:50:00	10	отменен	1260	12	9132.222	8503	2025-01-02 00:00:00	12
1871	40	2025-01-03 08:49:00	2025-01-03 10:50:00	10	забронирован	1197	12	8622.042	8503	2025-01-03 00:00:00	6
1872	40	2025-01-03 08:49:00	2025-01-03 10:50:00	10	оплачен	1251	12	8707.072	8503	2025-01-02 00:00:00	19
1873	40	2025-01-03 08:49:00	2025-01-03 10:50:00	10	забронирован	1242	12	9948.51	8503	2025-01-03 00:00:00	16
1874	40	2025-01-03 08:49:00	2025-01-03 10:50:00	10	забронирован	1237	12	9285.276	8503	2025-01-01 00:00:00	11
1875	40	2025-01-03 08:49:00	2025-01-03 10:50:00	10	оплачен	1198	12	8783.599	8503	2025-01-01 00:00:00	14
1876	40	2025-01-03 08:49:00	2025-01-03 10:50:00	10	забронирован	1218	12	9999.528	8503	2025-01-02 00:00:00	18
1877	40	2025-01-03 08:49:00	2025-01-03 10:50:00	10	оплачен	1243	12	10662.762	8503	2025-01-01 00:00:00	17
1878	40	2025-01-03 08:49:00	2025-01-03 10:50:00	10	отменен	1212	12	9072.701	8503	2025-01-03 00:00:00	17
1879	40	2025-01-03 08:49:00	2025-01-03 10:50:00	10	забронирован	1253	12	10509.708	8503	2025-01-02 00:00:00	17
1880	40	2025-01-03 08:49:00	2025-01-03 10:50:00	10	забронирован	1234	12	10441.684	8503	2025-01-02 00:00:00	18
1881	40	2025-01-03 08:49:00	2025-01-03 10:50:00	10	забронирован	1193	12	10305.636	8503	2025-01-01 00:00:00	25
1882	40	2025-01-03 08:49:00	2025-01-03 10:50:00	10	забронирован	1229	12	11206.954	8503	2025-01-02 00:00:00	15
1883	40	2025-01-03 08:49:00	2025-01-03 10:50:00	10	отменен	1256	12	10994.378999999999	8503	2025-01-01 00:00:00	11
1884	40	2025-01-03 08:49:00	2025-01-03 10:50:00	10	забронирован	1219	12	9013.18	8503	2025-01-03 00:00:00	10
1885	40	2025-01-03 08:49:00	2025-01-03 10:50:00	10	забронирован	1232	12	10722.283	8503	2025-01-02 00:00:00	9
1886	40	2025-01-03 08:49:00	2025-01-03 10:50:00	10	забронирован	1192	12	10756.295	8503	2025-01-01 00:00:00	21
1887	40	2025-01-03 07:47:00	2025-01-03 13:14:00	9	оплачен	1262	13	1366.596	1044	2025-01-01 00:00:00	6
1888	40	2025-01-03 07:47:00	2025-01-03 13:14:00	9	оплачен	1261	13	1222.5240000000001	1044	2025-01-02 00:00:00	15
1889	40	2025-01-03 07:47:00	2025-01-03 13:14:00	9	оплачен	1204	13	1332.144	1044	2025-01-02 00:00:00	15
1890	40	2025-01-03 07:47:00	2025-01-03 13:14:00	9	забронирован	1210	13	1125.432	1044	2025-01-02 00:00:00	23
1891	40	2025-01-03 07:47:00	2025-01-03 13:14:00	9	оплачен	1209	13	1155.708	1044	2025-01-01 00:00:00	10
1892	40	2025-01-03 07:47:00	2025-01-03 13:14:00	9	отменен	1264	13	1377.036	1044	2025-01-02 00:00:00	25
1893	40	2025-01-03 07:47:00	2025-01-03 13:14:00	9	забронирован	1205	13	1055.484	1044	2025-01-03 00:00:00	25
1894	40	2025-01-03 07:47:00	2025-01-03 13:14:00	9	забронирован	1207	13	1256.9759999999999	1044	2025-01-01 00:00:00	8
1895	40	2025-01-03 07:47:00	2025-01-03 13:14:00	9	забронирован	1208	13	1250.712	1044	2025-01-01 00:00:00	9
1896	40	2025-01-03 07:47:00	2025-01-03 13:14:00	9	отменен	1269	13	1346.76	1044	2025-01-01 00:00:00	13
1897	40	2025-01-03 07:47:00	2025-01-03 13:14:00	9	оплачен	1270	13	1098.288	1044	2025-01-02 00:00:00	24
1898	40	2025-01-03 06:45:00	2025-01-03 08:46:00	8	отменен	1238	10	6417.024	5898	2025-01-02 00:00:00	24
1899	40	2025-01-03 06:45:00	2025-01-03 08:46:00	8	забронирован	1215	10	6983.232	5898	2025-01-02 00:00:00	23
1900	40	2025-01-03 06:45:00	2025-01-03 08:46:00	8	оплачен	1237	10	6004.164	5898	2025-01-01 00:00:00	15
1901	40	2025-01-03 06:45:00	2025-01-03 08:46:00	8	отменен	1245	10	6116.226	5898	2025-01-03 00:00:00	9
1902	40	2025-01-03 06:45:00	2025-01-03 08:46:00	8	оплачен	1251	10	6588.066	5898	2025-01-02 00:00:00	24
1903	40	2025-01-03 06:45:00	2025-01-03 08:46:00	8	забронирован	1253	10	6015.96	5898	2025-01-03 00:00:00	17
1904	40	2025-01-03 06:45:00	2025-01-03 08:46:00	8	оплачен	1258	10	7354.8060000000005	5898	2025-01-02 00:00:00	13
1905	40	2025-01-03 06:45:00	2025-01-03 08:46:00	8	забронирован	1197	10	6688.331999999999	5898	2025-01-03 00:00:00	16
1906	40	2025-01-03 06:45:00	2025-01-03 08:46:00	8	оплачен	1232	10	7767.665999999999	5898	2025-01-03 00:00:00	20
1907	40	2025-01-03 06:45:00	2025-01-03 08:46:00	8	оплачен	1252	10	6334.452	5898	2025-01-03 00:00:00	11
1908	40	2025-01-03 06:45:00	2025-01-03 08:46:00	8	отменен	1224	10	6122.124	5898	2025-01-02 00:00:00	8
1909	40	2025-01-03 06:45:00	2025-01-03 08:46:00	8	отменен	1219	10	7189.662	5898	2025-01-03 00:00:00	9
1910	40	2025-01-03 06:45:00	2025-01-03 08:46:00	8	оплачен	1244	10	6700.128	5898	2025-01-01 00:00:00	21
1911	40	2025-01-03 06:45:00	2025-01-03 08:46:00	8	отменен	1240	10	7437.378	5898	2025-01-03 00:00:00	23
1912	40	2025-01-03 06:45:00	2025-01-03 08:46:00	8	отменен	1230	10	6647.046	5898	2025-01-03 00:00:00	18
1913	40	2025-01-03 06:45:00	2025-01-03 08:46:00	8	оплачен	1247	10	7466.868	5898	2025-01-01 00:00:00	6
1914	40	2025-01-03 06:45:00	2025-01-03 08:46:00	8	отменен	1250	10	7720.482	5898	2025-01-01 00:00:00	15
1915	40	2025-01-03 06:45:00	2025-01-03 08:46:00	8	оплачен	1220	10	6688.331999999999	5898	2025-01-02 00:00:00	10
1916	40	2025-01-03 06:45:00	2025-01-03 08:46:00	8	оплачен	1214	10	7195.5599999999995	5898	2025-01-01 00:00:00	14
1917	40	2025-01-03 06:45:00	2025-01-03 08:46:00	8	отменен	1212	10	6540.882	5898	2025-01-01 00:00:00	14
1918	40	2025-01-03 06:45:00	2025-01-03 08:46:00	8	отменен	1248	10	6706.026	5898	2025-01-03 00:00:00	12
1919	40	2025-01-03 06:45:00	2025-01-03 08:46:00	8	отменен	1193	10	5986.469999999999	5898	2025-01-01 00:00:00	18
1920	40	2025-01-03 06:45:00	2025-01-03 08:46:00	8	забронирован	1242	10	6334.452	5898	2025-01-03 00:00:00	13
1921	40	2025-01-03 06:45:00	2025-01-03 08:46:00	8	забронирован	1195	10	6806.2919999999995	5898	2025-01-02 00:00:00	17
1922	40	2025-01-03 06:45:00	2025-01-03 08:46:00	8	отменен	1259	10	7260.438	5898	2025-01-02 00:00:00	24
1923	40	2025-01-03 06:45:00	2025-01-03 08:46:00	8	оплачен	1249	10	7749.972000000001	5898	2025-01-01 00:00:00	21
1924	40	2025-01-03 06:45:00	2025-01-03 08:46:00	8	отменен	1231	10	6063.144	5898	2025-01-02 00:00:00	15
1925	40	2025-01-03 06:45:00	2025-01-03 08:46:00	8	оплачен	1260	10	7844.34	5898	2025-01-03 00:00:00	13
1926	40	2025-01-03 06:45:00	2025-01-03 08:46:00	8	оплачен	1223	10	7230.948	5898	2025-01-01 00:00:00	25
1927	40	2025-01-03 06:45:00	2025-01-03 08:46:00	8	забронирован	1191	10	7685.094	5898	2025-01-02 00:00:00	15
1928	40	2025-01-03 06:45:00	2025-01-03 08:46:00	8	отменен	1233	10	7248.642000000001	5898	2025-01-02 00:00:00	11
1929	40	2025-01-03 06:45:00	2025-01-03 08:46:00	8	оплачен	1217	10	6440.616000000001	5898	2025-01-01 00:00:00	7
1930	40	2025-01-03 06:45:00	2025-01-03 08:46:00	8	оплачен	1235	10	7531.745999999999	5898	2025-01-01 00:00:00	22
1931	40	2025-01-03 06:45:00	2025-01-03 08:46:00	8	оплачен	1255	10	6930.150000000001	5898	2025-01-03 00:00:00	23
1932	40	2025-01-03 06:45:00	2025-01-03 08:46:00	8	отменен	1229	10	6210.594	5898	2025-01-01 00:00:00	24
1933	40	2025-01-03 06:45:00	2025-01-03 08:46:00	8	забронирован	1211	10	7372.5	5898	2025-01-02 00:00:00	6
1934	40	2025-01-03 06:45:00	2025-01-03 08:46:00	8	оплачен	1213	10	7655.604	5898	2025-01-02 00:00:00	22
1935	40	2025-01-03 06:45:00	2025-01-03 08:46:00	8	отменен	1192	10	7289.928	5898	2025-01-02 00:00:00	7
1936	40	2025-01-03 06:45:00	2025-01-03 08:46:00	8	оплачен	1221	10	7584.828	5898	2025-01-03 00:00:00	12
1937	40	2025-01-03 06:45:00	2025-01-03 08:46:00	8	оплачен	1239	10	6635.25	5898	2025-01-03 00:00:00	23
1938	40	2025-01-03 06:45:00	2025-01-03 08:46:00	8	забронирован	1227	10	6216.492	5898	2025-01-03 00:00:00	20
1939	40	2025-01-03 06:45:00	2025-01-03 08:46:00	8	оплачен	1194	10	7785.360000000001	5898	2025-01-01 00:00:00	15
1940	40	2025-01-03 06:45:00	2025-01-03 08:46:00	8	забронирован	1218	10	5980.572	5898	2025-01-02 00:00:00	22
1941	40	2025-01-03 06:45:00	2025-01-03 08:46:00	8	отменен	1254	10	6812.1900000000005	5898	2025-01-03 00:00:00	17
1942	40	2025-01-03 06:45:00	2025-01-03 08:46:00	8	отменен	1256	10	7443.276	5898	2025-01-01 00:00:00	8
1943	40	2025-01-03 06:45:00	2025-01-03 08:46:00	8	забронирован	1196	10	7726.38	5898	2025-01-01 00:00:00	17
1944	40	2025-01-03 06:45:00	2025-01-03 08:46:00	8	отменен	1216	10	7289.928	5898	2025-01-03 00:00:00	8
1945	40	2025-01-03 06:45:00	2025-01-03 08:46:00	8	оплачен	1257	10	6181.104	5898	2025-01-02 00:00:00	11
1946	40	2025-01-03 06:45:00	2025-01-03 08:46:00	8	забронирован	1198	10	6234.186	5898	2025-01-03 00:00:00	20
1947	40	2025-01-03 06:45:00	2025-01-03 08:46:00	8	отменен	1226	10	7313.5199999999995	5898	2025-01-03 00:00:00	9
1948	40	2025-01-03 06:45:00	2025-01-03 08:46:00	8	забронирован	1225	10	6428.820000000001	5898	2025-01-02 00:00:00	11
1949	40	2025-01-03 06:45:00	2025-01-03 08:46:00	8	оплачен	1241	10	7006.824	5898	2025-01-01 00:00:00	16
1950	40	2025-01-03 06:45:00	2025-01-03 08:46:00	8	забронирован	1246	10	6411.126	5898	2025-01-03 00:00:00	13
1951	40	2025-01-03 06:45:00	2025-01-03 08:46:00	8	оплачен	1222	10	7649.705999999999	5898	2025-01-03 00:00:00	6
1952	40	2025-01-03 08:49:00	2025-01-03 13:14:00	10	отменен	1234	13	10202.46	8765	2025-01-03 00:00:00	10
1953	40	2025-01-03 08:49:00	2025-01-03 13:14:00	10	оплачен	1225	13	11201.67	8765	2025-01-01 00:00:00	19
1954	40	2025-01-03 08:49:00	2025-01-03 13:14:00	10	отменен	1259	13	10553.06	8765	2025-01-02 00:00:00	17
1955	40	2025-01-03 08:49:00	2025-01-03 13:14:00	10	забронирован	1237	13	8835.12	8765	2025-01-02 00:00:00	22
1956	40	2025-01-03 08:49:00	2025-01-03 13:14:00	10	забронирован	1195	13	8843.884999999998	8765	2025-01-03 00:00:00	18
1957	40	2025-01-03 08:49:00	2025-01-03 13:14:00	10	оплачен	1223	13	9369.785	8765	2025-01-03 00:00:00	17
1958	40	2025-01-03 08:49:00	2025-01-03 13:14:00	10	отменен	1255	13	10377.76	8765	2025-01-03 00:00:00	8
1959	40	2025-01-03 08:49:00	2025-01-03 13:14:00	10	оплачен	1245	13	8878.945	8765	2025-01-03 00:00:00	17
1960	40	2025-01-03 08:49:00	2025-01-03 13:14:00	10	отменен	1254	13	11087.724999999999	8765	2025-01-02 00:00:00	20
1961	40	2025-01-03 08:49:00	2025-01-03 13:14:00	10	оплачен	1241	13	9247.074999999999	8765	2025-01-01 00:00:00	17
1962	40	2025-01-03 08:49:00	2025-01-03 13:14:00	10	отменен	1224	13	11403.265	8765	2025-01-03 00:00:00	14
1963	40	2025-01-03 08:49:00	2025-01-03 13:14:00	10	забронирован	1222	13	10833.539999999999	8765	2025-01-02 00:00:00	20
1964	40	2025-01-03 08:49:00	2025-01-03 13:14:00	10	забронирован	1242	13	9396.08	8765	2025-01-02 00:00:00	9
1965	40	2025-01-03 08:49:00	2025-01-03 13:14:00	10	отменен	1192	13	10114.81	8765	2025-01-01 00:00:00	20
1966	40	2025-01-03 08:49:00	2025-01-03 13:14:00	10	отменен	1252	13	10106.045	8765	2025-01-01 00:00:00	8
1967	40	2025-01-03 08:49:00	2025-01-03 13:14:00	10	забронирован	1228	13	11490.914999999999	8765	2025-01-02 00:00:00	18
1968	40	2025-01-03 08:49:00	2025-01-03 13:14:00	10	оплачен	1250	13	10447.88	8765	2025-01-02 00:00:00	24
1969	40	2025-01-03 08:49:00	2025-01-03 13:14:00	10	оплачен	1220	13	9334.725	8765	2025-01-03 00:00:00	18
1970	40	2025-01-03 08:49:00	2025-01-03 13:14:00	10	отменен	1219	13	8843.884999999998	8765	2025-01-03 00:00:00	10
1971	40	2025-01-03 08:49:00	2025-01-03 13:14:00	10	оплачен	1193	13	10588.119999999999	8765	2025-01-02 00:00:00	8
1972	40	2025-01-03 08:49:00	2025-01-03 13:14:00	10	отменен	1239	13	8878.945	8765	2025-01-02 00:00:00	20
1973	40	2025-01-03 08:49:00	2025-01-03 13:14:00	10	забронирован	1251	13	9816.800000000001	8765	2025-01-02 00:00:00	8
1974	40	2025-01-03 08:49:00	2025-01-03 13:14:00	10	оплачен	1215	13	10114.81	8765	2025-01-03 00:00:00	19
1975	40	2025-01-03 08:49:00	2025-01-03 13:14:00	10	отменен	1258	13	9448.67	8765	2025-01-01 00:00:00	24
1976	40	2025-01-03 08:49:00	2025-01-03 13:14:00	10	отменен	1243	13	9133.130000000001	8765	2025-01-03 00:00:00	23
1977	40	2025-01-03 08:49:00	2025-01-03 13:14:00	10	забронирован	1191	13	9860.625	8765	2025-01-01 00:00:00	25
1978	40	2025-01-03 08:49:00	2025-01-03 13:14:00	10	оплачен	1246	13	9396.08	8765	2025-01-01 00:00:00	25
1979	40	2025-01-03 08:49:00	2025-01-03 13:14:00	10	забронирован	1249	13	11254.26	8765	2025-01-03 00:00:00	23
1980	40	2025-01-03 08:49:00	2025-01-03 13:14:00	10	отменен	1213	13	10193.695	8765	2025-01-01 00:00:00	16
1981	40	2025-01-03 08:49:00	2025-01-03 13:14:00	10	забронирован	1197	13	10395.289999999999	8765	2025-01-03 00:00:00	19
1982	40	2025-01-03 08:49:00	2025-01-03 13:14:00	10	отменен	1247	13	11552.27	8765	2025-01-02 00:00:00	25
1983	40	2025-01-03 08:49:00	2025-01-03 13:14:00	10	забронирован	1211	13	9325.960000000001	8765	2025-01-03 00:00:00	10
1984	40	2025-01-03 08:49:00	2025-01-03 13:14:00	10	забронирован	1240	13	9492.494999999999	8765	2025-01-02 00:00:00	8
1985	40	2025-01-03 08:49:00	2025-01-03 13:14:00	10	оплачен	1256	13	8800.06	8765	2025-01-01 00:00:00	23
1986	40	2025-01-03 08:49:00	2025-01-03 13:14:00	10	оплачен	1229	13	10465.41	8765	2025-01-02 00:00:00	9
1987	40	2025-01-03 08:49:00	2025-01-03 13:14:00	10	забронирован	1244	13	9510.025	8765	2025-01-03 00:00:00	24
1988	40	2025-01-03 06:45:00	2025-01-03 07:44:00	8	отменен	1262	9	3440.151	2673	2025-01-02 00:00:00	8
1989	40	2025-01-03 06:45:00	2025-01-03 07:44:00	8	оплачен	1208	9	3485.592	2673	2025-01-03 00:00:00	6
1990	40	2025-01-03 06:45:00	2025-01-03 07:44:00	8	отменен	1263	9	2753.19	2673	2025-01-01 00:00:00	16
1991	40	2025-01-03 06:45:00	2025-01-03 07:44:00	8	оплачен	1261	9	3295.809	2673	2025-01-03 00:00:00	16
1992	40	2025-01-03 06:45:00	2025-01-03 07:44:00	8	забронирован	1268	9	2673	2673	2025-01-01 00:00:00	13
1993	40	2025-01-03 06:45:00	2025-01-03 07:44:00	8	оплачен	1202	9	3325.212	2673	2025-01-03 00:00:00	13
1994	40	2025-01-03 06:45:00	2025-01-03 07:44:00	8	оплачен	1210	9	3311.847	2673	2025-01-02 00:00:00	7
1995	40	2025-01-03 06:45:00	2025-01-03 07:44:00	8	забронирован	1267	9	2926.935	2673	2025-01-01 00:00:00	15
1996	40	2025-01-03 06:45:00	2025-01-03 07:44:00	8	забронирован	1269	9	2811.996	2673	2025-01-01 00:00:00	25
1997	40	2025-01-03 06:45:00	2025-01-03 07:44:00	8	отменен	1206	9	3223.638	2673	2025-01-01 00:00:00	10
1998	40	2025-01-03 06:45:00	2025-01-03 07:44:00	8	отменен	1205	9	2862.783	2673	2025-01-02 00:00:00	11
1999	40	2025-01-03 06:45:00	2025-01-03 07:44:00	8	забронирован	1204	9	2988.414	2673	2025-01-02 00:00:00	22
2000	40	2025-01-03 06:45:00	2025-01-03 07:44:00	8	оплачен	1270	9	3124.737	2673	2025-01-01 00:00:00	16
2001	40	2025-01-03 06:45:00	2025-01-03 07:44:00	8	оплачен	1209	9	3065.931	2673	2025-01-03 00:00:00	23
2002	40	2025-01-03 06:45:00	2025-01-03 07:44:00	8	оплачен	1207	9	3400.056	2673	2025-01-01 00:00:00	7
2003	40	2025-01-03 06:45:00	2025-01-03 07:44:00	8	отменен	1203	9	2961.684	2673	2025-01-01 00:00:00	10
2004	40	2025-01-03 09:51:00	2025-01-03 13:14:00	11	отменен	1334	13	12621.650000000001	11975	2025-01-02 00:00:00	16
2005	40	2025-01-03 09:51:00	2025-01-03 13:14:00	11	оплачен	1287	13	14789.125000000002	11975	2025-01-03 00:00:00	16
2006	40	2025-01-03 09:51:00	2025-01-03 13:14:00	11	забронирован	1281	13	12885.1	11975	2025-01-03 00:00:00	7
2007	40	2025-01-03 09:51:00	2025-01-03 13:14:00	11	оплачен	1279	13	13316.2	11975	2025-01-03 00:00:00	18
2008	40	2025-01-03 09:51:00	2025-01-03 13:14:00	11	отменен	1356	13	13435.95	11975	2025-01-01 00:00:00	18
2009	40	2025-01-03 09:51:00	2025-01-03 13:14:00	11	отменен	1317	13	13519.775	11975	2025-01-02 00:00:00	12
2010	40	2025-01-03 09:51:00	2025-01-03 13:14:00	11	оплачен	1361	13	13148.550000000001	11975	2025-01-01 00:00:00	24
2011	40	2025-01-03 09:51:00	2025-01-03 13:14:00	11	оплачен	1362	13	13579.65	11975	2025-01-01 00:00:00	17
2012	40	2025-01-03 09:51:00	2025-01-03 13:14:00	11	оплачен	1305	13	13986.8	11975	2025-01-01 00:00:00	25
2013	40	2025-01-03 09:51:00	2025-01-03 13:14:00	11	забронирован	1354	13	13890.999999999998	11975	2025-01-01 00:00:00	25
2014	40	2025-01-03 09:51:00	2025-01-03 13:14:00	11	забронирован	1346	13	13400.025	11975	2025-01-03 00:00:00	9
2015	40	2025-01-03 09:51:00	2025-01-03 13:14:00	11	отменен	1369	13	14777.15	11975	2025-01-01 00:00:00	12
2016	40	2025-01-03 09:51:00	2025-01-03 13:14:00	11	оплачен	1329	13	15699.224999999999	11975	2025-01-03 00:00:00	6
2017	40	2025-01-03 09:51:00	2025-01-03 13:14:00	11	отменен	1337	13	13148.550000000001	11975	2025-01-02 00:00:00	7
2018	40	2025-01-03 09:51:00	2025-01-03 13:14:00	11	забронирован	1272	13	15687.25	11975	2025-01-02 00:00:00	21
2019	40	2025-01-03 09:51:00	2025-01-03 13:14:00	11	забронирован	1298	13	13543.725	11975	2025-01-02 00:00:00	20
2020	40	2025-01-03 09:51:00	2025-01-03 13:14:00	11	отменен	1370	13	12334.25	11975	2025-01-01 00:00:00	20
2021	40	2025-01-03 07:47:00	2025-01-03 13:14:00	9	забронирован	1275	13	14954.535	11355	2025-01-02 00:00:00	21
2022	40	2025-01-03 07:47:00	2025-01-03 13:14:00	9	оплачен	1316	13	13671.42	11355	2025-01-01 00:00:00	8
2023	40	2025-01-03 07:47:00	2025-01-03 13:14:00	9	оплачен	1333	13	14488.98	11355	2025-01-03 00:00:00	16
2024	40	2025-01-03 07:47:00	2025-01-03 13:14:00	9	оплачен	1298	13	13898.52	11355	2025-01-02 00:00:00	9
2025	40	2025-01-03 07:47:00	2025-01-03 13:14:00	9	оплачен	1368	13	13784.97	11355	2025-01-01 00:00:00	12
2026	40	2025-01-03 07:47:00	2025-01-03 13:14:00	9	оплачен	1320	13	13512.449999999999	11355	2025-01-02 00:00:00	24
2027	40	2025-01-03 07:47:00	2025-01-03 13:14:00	9	отменен	1338	13	11650.23	11355	2025-01-02 00:00:00	7
2028	40	2025-01-03 07:47:00	2025-01-03 13:14:00	9	отменен	1285	13	13171.8	11355	2025-01-02 00:00:00	6
2029	40	2025-01-03 07:47:00	2025-01-03 13:14:00	9	отменен	1292	13	12138.494999999999	11355	2025-01-01 00:00:00	24
2030	40	2025-01-03 07:47:00	2025-01-03 13:14:00	9	оплачен	1360	13	12558.630000000001	11355	2025-01-03 00:00:00	6
2031	40	2025-01-03 07:47:00	2025-01-03 13:14:00	9	оплачен	1321	13	14398.14	11355	2025-01-01 00:00:00	24
2032	40	2025-01-03 07:47:00	2025-01-03 13:14:00	9	оплачен	1359	13	12910.635	11355	2025-01-03 00:00:00	12
2033	40	2025-01-03 07:47:00	2025-01-03 13:14:00	9	забронирован	1312	13	15045.375	11355	2025-01-03 00:00:00	18
2034	40	2025-01-03 07:47:00	2025-01-03 13:14:00	9	оплачен	1276	13	14999.955	11355	2025-01-03 00:00:00	19
2035	40	2025-01-03 07:47:00	2025-01-03 13:14:00	9	оплачен	1281	13	14863.695	11355	2025-01-03 00:00:00	23
2036	40	2025-01-03 07:47:00	2025-01-03 13:14:00	9	забронирован	1286	13	14670.66	11355	2025-01-03 00:00:00	7
2037	40	2025-01-03 07:47:00	2025-01-03 13:14:00	9	оплачен	1350	13	11865.974999999999	11355	2025-01-02 00:00:00	11
2038	40	2025-01-03 07:47:00	2025-01-03 13:14:00	9	забронирован	1352	13	11672.94	11355	2025-01-03 00:00:00	19
2039	40	2025-01-03 07:47:00	2025-01-03 13:14:00	9	забронирован	1326	13	11570.744999999999	11355	2025-01-03 00:00:00	17
2040	40	2025-01-03 07:47:00	2025-01-03 13:14:00	9	забронирован	1340	13	13001.475	11355	2025-01-02 00:00:00	17
2041	40	2025-01-03 07:47:00	2025-01-03 13:14:00	9	отменен	1273	13	12013.59	11355	2025-01-02 00:00:00	13
2042	40	2025-01-03 07:47:00	2025-01-03 13:14:00	9	забронирован	1328	13	12354.240000000002	11355	2025-01-02 00:00:00	10
2043	40	2025-01-03 07:47:00	2025-01-03 13:14:00	9	забронирован	1323	13	11479.904999999999	11355	2025-01-02 00:00:00	10
2044	40	2025-01-03 07:47:00	2025-01-03 13:14:00	9	отменен	1303	13	14613.884999999998	11355	2025-01-01 00:00:00	24
2045	40	2025-01-03 07:47:00	2025-01-03 13:14:00	9	отменен	1349	13	14227.814999999999	11355	2025-01-02 00:00:00	9
2046	40	2025-01-03 07:47:00	2025-01-03 13:14:00	9	оплачен	1367	13	12081.720000000001	11355	2025-01-02 00:00:00	10
2047	40	2025-01-03 07:47:00	2025-01-03 13:14:00	9	забронирован	1299	13	13887.165	11355	2025-01-03 00:00:00	12
2048	40	2025-01-03 07:47:00	2025-01-03 13:14:00	9	отменен	1354	13	13387.545	11355	2025-01-01 00:00:00	18
2049	40	2025-01-03 07:47:00	2025-01-03 13:14:00	9	отменен	1306	13	11491.26	11355	2025-01-02 00:00:00	25
2050	40	2025-01-03 07:47:00	2025-01-03 13:14:00	9	забронирован	1339	13	12569.985	11355	2025-01-02 00:00:00	13
2051	40	2025-01-03 07:47:00	2025-01-03 13:14:00	9	оплачен	1282	13	13478.385	11355	2025-01-01 00:00:00	6
2052	40	2025-01-03 07:47:00	2025-01-03 13:14:00	9	оплачен	1315	13	12819.795	11355	2025-01-01 00:00:00	25
2053	40	2025-01-03 07:47:00	2025-01-03 13:14:00	9	оплачен	1304	13	14716.08	11355	2025-01-02 00:00:00	12
2054	40	2025-01-03 07:47:00	2025-01-03 13:14:00	9	забронирован	1355	13	14943.18	11355	2025-01-02 00:00:00	17
2055	40	2025-01-03 07:47:00	2025-01-03 13:14:00	9	оплачен	1336	13	11990.880000000001	11355	2025-01-03 00:00:00	8
2056	40	2025-01-03 07:47:00	2025-01-03 13:14:00	9	оплачен	1364	13	14750.144999999999	11355	2025-01-03 00:00:00	9
2057	40	2025-01-03 07:47:00	2025-01-03 13:14:00	9	забронирован	1271	13	11582.1	11355	2025-01-01 00:00:00	11
2058	40	2025-01-03 07:47:00	2025-01-03 13:14:00	9	отменен	1353	13	14795.564999999999	11355	2025-01-01 00:00:00	12
2059	40	2025-01-03 07:47:00	2025-01-03 13:14:00	9	отменен	1314	13	14682.015	11355	2025-01-01 00:00:00	24
2060	40	2025-01-03 07:47:00	2025-01-03 13:14:00	9	отменен	1283	13	14943.18	11355	2025-01-02 00:00:00	14
2061	40	2025-01-03 07:47:00	2025-01-03 13:14:00	9	забронирован	1330	13	11366.355	11355	2025-01-03 00:00:00	18
2062	40	2025-01-03 07:47:00	2025-01-03 13:14:00	9	забронирован	1358	13	12638.115	11355	2025-01-02 00:00:00	20
2063	40	2025-01-03 07:47:00	2025-01-03 13:14:00	9	отменен	1280	13	13058.249999999998	11355	2025-01-03 00:00:00	16
2064	40	2025-01-03 07:47:00	2025-01-03 13:14:00	9	оплачен	1313	13	14557.11	11355	2025-01-01 00:00:00	8
2065	40	2025-01-03 07:47:00	2025-01-03 13:14:00	9	оплачен	1305	13	11377.71	11355	2025-01-02 00:00:00	11
2066	40	2025-01-03 07:47:00	2025-01-03 13:14:00	9	отменен	1347	13	12172.560000000001	11355	2025-01-01 00:00:00	21
2067	40	2025-01-03 07:47:00	2025-01-03 13:14:00	9	оплачен	1363	13	12240.69	11355	2025-01-01 00:00:00	8
2068	40	2025-01-03 07:47:00	2025-01-03 13:14:00	9	оплачен	1307	13	12036.300000000001	11355	2025-01-03 00:00:00	24
2069	40	2025-01-03 07:47:00	2025-01-03 13:14:00	9	забронирован	1290	13	11536.68	11355	2025-01-02 00:00:00	25
2070	40	2025-01-03 07:47:00	2025-01-03 13:14:00	9	оплачен	1334	13	13058.249999999998	11355	2025-01-02 00:00:00	18
2071	40	2025-01-03 07:47:00	2025-01-03 13:14:00	9	оплачен	1291	13	13183.155	11355	2025-01-03 00:00:00	16
2072	40	2025-01-03 07:47:00	2025-01-03 13:14:00	9	оплачен	1351	13	14295.945	11355	2025-01-01 00:00:00	12
2073	40	2025-01-03 07:47:00	2025-01-03 13:14:00	9	забронирован	1369	13	12104.43	11355	2025-01-01 00:00:00	11
2074	40	2025-01-03 07:47:00	2025-01-03 13:14:00	9	забронирован	1345	13	12558.630000000001	11355	2025-01-02 00:00:00	21
2075	40	2025-01-03 07:47:00	2025-01-03 13:14:00	9	забронирован	1288	13	11911.394999999999	11355	2025-01-02 00:00:00	21
2076	40	2025-01-03 07:47:00	2025-01-03 13:14:00	9	отменен	1329	13	12104.43	11355	2025-01-02 00:00:00	19
2077	40	2025-01-03 07:47:00	2025-01-03 13:14:00	9	отменен	1322	13	12547.275	11355	2025-01-01 00:00:00	22
2078	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	забронирован	1540	16	14150.539	12337	2025-02-04 00:00:00	25
2079	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	оплачен	1499	16	15729.675	12337	2025-06-18 00:00:00	18
2080	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	отменен	1518	16	14631.681999999999	12337	2025-06-02 00:00:00	22
2081	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	забронирован	1426	16	14125.865	12337	2025-01-26 00:00:00	13
2082	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	отменен	1411	16	13188.252999999999	12337	2025-05-30 00:00:00	10
2083	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	забронирован	1410	16	16395.873	12337	2025-03-09 00:00:00	15
2084	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	отменен	1503	16	14397.279	12337	2025-01-31 00:00:00	15
2085	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	оплачен	1490	16	12842.817	12337	2025-05-14 00:00:00	8
2086	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	оплачен	1531	16	14940.107000000002	12337	2025-04-04 00:00:00	11
2087	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	оплачен	1492	16	15840.708	12337	2025-03-23 00:00:00	16
2088	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	оплачен	1402	16	15236.195000000002	12337	2025-01-22 00:00:00	17
2089	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	оплачен	1406	16	15334.891000000001	12337	2025-04-20 00:00:00	22
2090	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	забронирован	1416	16	15223.858	12337	2025-04-03 00:00:00	13
2091	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	оплачен	1507	16	13360.971	12337	2025-02-14 00:00:00	9
2092	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	забронирован	1550	16	14656.356	12337	2025-01-12 00:00:00	11
2093	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	отменен	1379	16	12990.860999999999	12337	2025-05-07 00:00:00	24
2094	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	забронирован	1390	16	14434.289999999999	12337	2025-06-20 00:00:00	6
2095	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	забронирован	1423	16	12423.358999999999	12337	2025-04-02 00:00:00	6
2096	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	оплачен	1546	16	14249.235	12337	2025-02-08 00:00:00	10
2097	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	забронирован	1520	16	15976.414999999999	12337	2025-06-05 00:00:00	17
2098	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	отменен	1407	16	13385.645	12337	2025-01-23 00:00:00	19
2099	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	отменен	1529	16	15408.913	12337	2025-01-05 00:00:00	14
2100	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	забронирован	1538	16	12953.85	12337	2025-04-13 00:00:00	15
2101	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	отменен	1391	16	14804.4	12337	2025-01-27 00:00:00	11
2102	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	отменен	1493	16	13805.103	12337	2025-02-17 00:00:00	19
2103	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	оплачен	1573	16	14495.975	12337	2025-03-31 00:00:00	11
2104	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	отменен	1372	16	15445.924	12337	2025-03-25 00:00:00	9
2105	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	отменен	1482	16	14384.942	12337	2025-04-08 00:00:00	23
2106	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	забронирован	1498	16	14261.571999999998	12337	2025-01-07 00:00:00	19
2107	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	отменен	1560	16	12398.685	12337	2025-03-14 00:00:00	7
2108	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	отменен	1533	16	15495.272	12337	2025-02-17 00:00:00	18
2109	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	забронирован	1555	16	12522.054999999998	12337	2025-01-05 00:00:00	23
2110	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	отменен	1422	16	12361.674	12337	2025-03-29 00:00:00	10
2111	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	оплачен	1552	16	15088.151000000002	12337	2025-04-17 00:00:00	22
2112	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	оплачен	1527	16	14397.279	12337	2025-04-02 00:00:00	10
2113	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	забронирован	1486	16	16025.762999999999	12337	2025-04-23 00:00:00	16
2114	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	забронирован	1556	16	16001.089	12337	2025-02-15 00:00:00	7
2115	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	оплачен	1393	16	13434.993	12337	2025-05-09 00:00:00	9
2116	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	забронирован	1418	16	15149.836	12337	2025-05-27 00:00:00	15
2117	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	забронирован	1569	16	12879.828000000001	12337	2025-04-01 00:00:00	6
2118	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	забронирован	1374	16	12978.524000000001	12337	2025-03-09 00:00:00	20
2119	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	отменен	1521	16	13953.147	12337	2025-02-03 00:00:00	7
2120	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	оплачен	1504	16	13657.059	12337	2025-05-01 00:00:00	18
2121	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	отменен	1398	16	14261.571999999998	12337	2025-03-07 00:00:00	7
2122	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	забронирован	1489	16	12670.098999999998	12337	2025-03-26 00:00:00	7
2123	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	забронирован	1378	16	14446.627	12337	2025-01-01 00:00:00	6
2124	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	забронирован	1559	16	13817.44	12337	2025-05-22 00:00:00	23
2125	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	оплачен	1541	16	14779.725999999999	12337	2025-02-20 00:00:00	13
2126	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	отменен	1376	16	12411.022	12337	2025-01-24 00:00:00	6
2127	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	отменен	1554	16	15630.979	12337	2025-01-06 00:00:00	13
2128	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	оплачен	1397	16	15939.404	12337	2025-04-07 00:00:00	8
2129	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	забронирован	1508	16	15026.466	12337	2025-01-30 00:00:00	9
2130	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	забронирован	1519	16	14224.561	12337	2025-03-12 00:00:00	13
2131	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	забронирован	1502	16	14199.887	12337	2025-04-02 00:00:00	21
2132	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	забронирован	1384	16	15470.598	12337	2025-04-03 00:00:00	11
2133	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	забронирован	1542	16	12694.773	12337	2025-06-20 00:00:00	19
2134	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	оплачен	1576	16	16136.796	12337	2025-06-22 00:00:00	17
2135	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	оплачен	1428	16	15791.36	12337	2025-05-05 00:00:00	25
2136	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	забронирован	1525	16	12448.033	12337	2025-05-01 00:00:00	9
2137	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	отменен	1387	16	12645.425	12337	2025-01-31 00:00:00	8
2138	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	забронирован	1427	16	13472.004	12337	2025-05-10 00:00:00	19
2139	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	отменен	1495	16	16136.796	12337	2025-05-30 00:00:00	24
2140	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	отменен	1412	16	15137.499000000002	12337	2025-01-30 00:00:00	25
2141	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	отменен	1505	16	15766.686	12337	2025-01-01 00:00:00	19
2142	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	забронирован	1417	16	13891.462	12337	2025-03-03 00:00:00	18
2143	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	забронирован	1404	16	13928.473	12337	2025-05-14 00:00:00	20
2144	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	оплачен	1532	16	15927.067	12337	2025-01-12 00:00:00	11
2145	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	забронирован	1409	16	14014.831999999999	12337	2025-04-19 00:00:00	18
2146	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	забронирован	1512	16	15865.382	12337	2025-06-12 00:00:00	24
2147	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	отменен	1568	16	13731.081	12337	2025-04-09 00:00:00	8
2148	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	отменен	1501	16	16025.762999999999	12337	2025-05-11 00:00:00	7
2149	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	забронирован	1389	16	12867.491	12337	2025-05-18 00:00:00	12
2150	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	забронирован	1483	16	13089.556999999999	12337	2025-05-04 00:00:00	24
2151	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	отменен	1566	16	14372.605	12337	2025-01-08 00:00:00	6
2152	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	забронирован	1400	16	14249.235	12337	2025-05-07 00:00:00	12
2153	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	отменен	1371	16	15988.752	12337	2025-03-19 00:00:00	12
2154	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	забронирован	1488	16	12842.817	12337	2025-05-10 00:00:00	23
2155	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	забронирован	1537	16	16284.84	12337	2025-05-24 00:00:00	14
2156	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	оплачен	1570	16	14310.919999999998	12337	2025-04-20 00:00:00	11
2157	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	оплачен	1420	16	13064.883	12337	2025-04-20 00:00:00	18
2158	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	забронирован	1545	16	15643.316	12337	2025-02-11 00:00:00	12
2159	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	отменен	1394	16	15569.294	12337	2025-04-05 00:00:00	23
2160	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	забронирован	1415	16	13311.623	12337	2025-06-03 00:00:00	25
2161	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	забронирован	1534	16	13472.004	12337	2025-06-20 00:00:00	17
2162	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	оплачен	1516	16	13249.938	12337	2025-06-18 00:00:00	19
2163	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	отменен	1481	16	12756.458	12337	2025-06-20 00:00:00	17
2164	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	отменен	1430	16	13237.600999999999	12337	2025-01-04 00:00:00	10
2165	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	отменен	1551	16	13546.026000000002	12337	2025-06-16 00:00:00	13
2166	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	забронирован	1401	16	13249.938	12337	2025-04-01 00:00:00	6
2167	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	отменен	1539	16	12596.077	12337	2025-02-01 00:00:00	15
2168	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	забронирован	1523	16	15149.836	12337	2025-03-22 00:00:00	23
2169	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	забронирован	1575	16	12830.48	12337	2025-03-06 00:00:00	9
2170	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	забронирован	1522	16	12435.696	12337	2025-02-19 00:00:00	23
2171	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	забронирован	1399	16	14372.605	12337	2025-02-05 00:00:00	8
2172	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	отменен	1395	16	16346.525	12337	2025-04-14 00:00:00	6
2173	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	оплачен	1530	16	13854.451	12337	2025-05-01 00:00:00	21
2174	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	оплачен	1382	16	14471.301000000001	12337	2025-01-18 00:00:00	17
2175	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	оплачен	1380	16	13397.982000000002	12337	2025-01-02 00:00:00	8
2176	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	оплачен	1574	16	12793.469	12337	2025-01-27 00:00:00	18
2177	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	забронирован	1396	16	13200.59	12337	2025-06-09 00:00:00	22
2178	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	оплачен	1535	16	14767.389000000001	12337	2025-06-09 00:00:00	24
2179	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	оплачен	1388	16	14878.421999999999	12337	2025-05-22 00:00:00	22
2180	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	отменен	1547	16	15310.217	12337	2025-01-02 00:00:00	21
2181	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	отменен	1526	16	13792.766000000001	12337	2025-04-11 00:00:00	9
2182	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	оплачен	1578	16	12892.164999999999	12337	2025-04-20 00:00:00	12
2183	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	отменен	1571	16	16062.774000000001	12337	2025-02-18 00:00:00	8
2184	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	оплачен	1528	16	14668.693000000001	12337	2025-01-15 00:00:00	16
2185	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	отменен	1500	16	12534.392	12337	2025-03-03 00:00:00	7
2186	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	отменен	1485	16	12485.044	12337	2025-03-04 00:00:00	14
2187	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	оплачен	1548	16	15630.979	12337	2025-03-16 00:00:00	8
2188	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	забронирован	1511	16	15988.752	12337	2025-03-15 00:00:00	8
2189	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	отменен	1392	16	15717.338	12337	2025-04-11 00:00:00	11
2190	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	отменен	1419	16	13829.777	12337	2025-03-24 00:00:00	10
2191	47	2025-06-22 05:40:00	2025-06-22 07:15:00	11	оплачен	1454	13	3235.232	2626	2025-04-16 00:00:00	13
2192	47	2025-06-22 05:40:00	2025-06-22 07:15:00	11	забронирован	1475	13	3476.824	2626	2025-04-27 00:00:00	9
2193	47	2025-06-22 05:40:00	2025-06-22 07:15:00	11	оплачен	1467	13	3437.4339999999997	2626	2025-04-28 00:00:00	19
2194	47	2025-06-22 05:40:00	2025-06-22 07:15:00	11	забронирован	1476	13	2846.5840000000003	2626	2025-01-09 00:00:00	19
2195	47	2025-06-22 05:40:00	2025-06-22 07:15:00	11	забронирован	1446	13	3332.394	2626	2025-04-29 00:00:00	6
2196	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	забронирован	1453	16	2602.88	2324	2025-03-03 00:00:00	24
2197	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	забронирован	1467	16	2721.404	2324	2025-05-12 00:00:00	14
2198	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	забронирован	1432	16	2884.0840000000003	2324	2025-02-23 00:00:00	24
2199	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	отменен	1469	16	2707.46	2324	2025-02-02 00:00:00	10
2200	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	оплачен	1470	16	2972.3959999999997	2324	2025-02-07 00:00:00	12
2201	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	отменен	1463	16	2386.7479999999996	2324	2025-06-09 00:00:00	12
2202	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	забронирован	1444	16	3030.496	2324	2025-03-10 00:00:00	16
2203	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	забронирован	1455	16	2949.156	2324	2025-06-20 00:00:00	12
2204	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	оплачен	1477	16	2523.864	2324	2025-05-03 00:00:00	16
2205	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	забронирован	1441	16	2581.964	2324	2025-01-24 00:00:00	12
2206	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	отменен	1435	16	2721.404	2324	2025-03-16 00:00:00	10
2207	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	оплачен	1466	16	2990.988	2324	2025-05-05 00:00:00	21
2208	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	отменен	1474	16	2512.2439999999997	2324	2025-06-03 00:00:00	16
2209	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	забронирован	1451	16	2781.828	2324	2025-03-05 00:00:00	23
2210	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	оплачен	1449	16	2470.412	2324	2025-01-20 00:00:00	11
2211	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	забронирован	1450	16	3049.088	2324	2025-01-17 00:00:00	8
2212	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	отменен	1475	16	3070.004	2324	2025-02-08 00:00:00	16
2213	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	оплачен	1460	16	2500.6240000000003	2324	2025-03-16 00:00:00	6
2214	47	2025-06-22 05:40:00	2025-06-22 07:15:00	11	оплачен	1566	13	14147.952	11193	2025-06-02 00:00:00	14
2215	47	2025-06-22 05:40:00	2025-06-22 07:15:00	11	забронирован	1532	13	13700.232	11193	2025-03-30 00:00:00	21
2216	47	2025-06-22 05:40:00	2025-06-22 07:15:00	11	забронирован	1403	13	12636.897	11193	2025-05-17 00:00:00	15
2217	47	2025-06-22 05:40:00	2025-06-22 07:15:00	11	оплачен	1549	13	14685.216	11193	2025-05-22 00:00:00	6
2218	47	2025-06-22 05:40:00	2025-06-22 07:15:00	11	забронирован	1542	13	11461.632	11193	2025-04-05 00:00:00	25
2219	47	2025-06-22 05:40:00	2025-06-22 07:15:00	11	оплачен	1552	13	14662.83	11193	2025-04-29 00:00:00	9
2220	47	2025-06-22 05:40:00	2025-06-22 07:15:00	11	отменен	1575	13	14696.409	11193	2025-03-02 00:00:00	16
2221	47	2025-06-22 05:40:00	2025-06-22 07:15:00	11	забронирован	1530	13	11248.964999999998	11193	2025-05-12 00:00:00	25
2222	47	2025-06-22 05:40:00	2025-06-22 07:15:00	11	отменен	1381	13	12748.827	11193	2025-02-28 00:00:00	11
2223	47	2025-06-22 05:40:00	2025-06-22 07:15:00	11	оплачен	1528	13	12110.826000000001	11193	2025-04-16 00:00:00	14
2224	47	2025-06-22 05:40:00	2025-06-22 07:15:00	11	отменен	1506	13	14562.092999999999	11193	2025-05-27 00:00:00	17
2225	47	2025-06-22 05:40:00	2025-06-22 07:15:00	11	оплачен	1564	13	14517.321	11193	2025-03-16 00:00:00	11
2226	47	2025-06-22 05:40:00	2025-06-22 07:15:00	11	отменен	1510	13	12692.862	11193	2025-06-01 00:00:00	7
2227	47	2025-06-22 05:40:00	2025-06-22 07:15:00	11	оплачен	1402	13	11853.386999999999	11193	2025-01-21 00:00:00	25
2228	47	2025-06-22 05:40:00	2025-06-22 07:15:00	11	оплачен	1371	13	13689.039	11193	2025-04-02 00:00:00	24
2229	47	2025-06-22 05:40:00	2025-06-22 07:15:00	11	забронирован	1421	13	11763.842999999999	11193	2025-05-16 00:00:00	11
2230	47	2025-06-22 05:40:00	2025-06-22 07:15:00	11	оплачен	1551	13	11394.474	11193	2025-02-02 00:00:00	20
2231	47	2025-06-22 05:40:00	2025-06-22 07:15:00	11	оплачен	1384	13	13800.969000000001	11193	2025-05-03 00:00:00	20
2232	47	2025-06-22 05:40:00	2025-06-22 07:15:00	11	оплачен	1428	13	14248.688999999998	11193	2025-01-01 00:00:00	11
2233	47	2025-06-22 05:40:00	2025-06-22 07:15:00	11	оплачен	1496	13	11842.194000000001	11193	2025-06-02 00:00:00	21
2234	47	2025-06-22 05:40:00	2025-06-22 07:15:00	11	отменен	1392	13	13286.091	11193	2025-02-04 00:00:00	12
2235	47	2025-06-22 05:40:00	2025-06-22 07:15:00	11	забронирован	1397	13	14595.672	11193	2025-05-15 00:00:00	7
2236	47	2025-06-22 05:40:00	2025-06-22 07:15:00	11	оплачен	1562	13	13868.127	11193	2025-04-20 00:00:00	11
2237	47	2025-06-22 05:40:00	2025-06-22 07:15:00	11	забронирован	1409	13	11506.404	11193	2025-04-05 00:00:00	12
2238	47	2025-06-22 05:40:00	2025-06-22 07:15:00	11	забронирован	1407	13	14360.618999999999	11193	2025-01-22 00:00:00	18
2239	47	2025-06-22 05:40:00	2025-06-22 07:15:00	11	отменен	1404	13	12177.984	11193	2025-04-18 00:00:00	18
2240	47	2025-06-22 05:40:00	2025-06-22 07:15:00	11	отменен	1408	13	14058.408	11193	2025-06-16 00:00:00	14
2241	47	2025-06-22 05:40:00	2025-06-22 07:15:00	11	отменен	1410	13	13118.196	11193	2025-05-07 00:00:00	21
2242	47	2025-06-22 05:40:00	2025-06-22 07:15:00	11	отменен	1382	13	14584.479	11193	2025-04-09 00:00:00	20
2243	47	2025-06-22 05:40:00	2025-06-22 07:15:00	11	отменен	1405	13	13398.021	11193	2025-04-26 00:00:00	15
2244	47	2025-06-22 05:40:00	2025-06-22 07:15:00	11	забронирован	1411	13	12099.633	11193	2025-04-22 00:00:00	7
2245	47	2025-06-22 05:40:00	2025-06-22 07:15:00	11	отменен	1544	13	14080.794	11193	2025-05-12 00:00:00	12
2246	47	2025-06-22 05:40:00	2025-06-22 07:15:00	11	отменен	1486	13	14103.18	11193	2025-04-25 00:00:00	25
2247	47	2025-06-22 05:40:00	2025-06-22 07:15:00	11	забронирован	1427	13	14327.04	11193	2025-02-28 00:00:00	22
2248	47	2025-06-22 05:40:00	2025-06-22 07:15:00	11	оплачен	1426	13	11651.912999999999	11193	2025-06-07 00:00:00	7
2249	47	2025-06-22 05:40:00	2025-06-22 07:15:00	11	оплачен	1417	13	12625.703999999998	11193	2025-05-16 00:00:00	6
2250	47	2025-06-22 05:40:00	2025-06-22 07:15:00	11	отменен	1396	13	14080.794	11193	2025-05-02 00:00:00	21
2251	47	2025-06-22 05:40:00	2025-06-22 07:15:00	11	забронирован	1560	13	11998.896	11193	2025-05-14 00:00:00	13
2252	47	2025-06-22 05:40:00	2025-06-22 07:15:00	11	забронирован	1393	13	12256.335	11193	2025-04-14 00:00:00	23
2253	47	2025-06-22 05:40:00	2025-06-22 07:15:00	11	оплачен	1422	13	14853.110999999999	11193	2025-04-21 00:00:00	12
2254	47	2025-06-22 05:40:00	2025-06-22 07:15:00	11	оплачен	1394	13	13420.407000000001	11193	2025-05-19 00:00:00	10
2255	47	2025-06-22 05:40:00	2025-06-22 07:15:00	11	оплачен	1534	13	14226.302999999998	11193	2025-06-18 00:00:00	19
2256	47	2025-06-22 05:40:00	2025-06-22 07:15:00	11	оплачен	1380	13	13778.583	11193	2025-02-05 00:00:00	6
2257	47	2025-06-22 05:40:00	2025-06-22 07:15:00	11	забронирован	1490	13	14438.970000000001	11193	2025-02-18 00:00:00	19
2258	47	2025-06-22 05:40:00	2025-06-22 07:15:00	11	забронирован	1522	13	11842.194000000001	11193	2025-05-19 00:00:00	6
2259	47	2025-06-22 05:40:00	2025-06-22 07:15:00	11	оплачен	1518	13	14304.654	11193	2025-04-14 00:00:00	11
2260	47	2025-06-22 05:40:00	2025-06-22 07:15:00	11	оплачен	1503	13	14192.724	11193	2025-01-09 00:00:00	22
2261	47	2025-06-22 05:40:00	2025-06-22 07:15:00	11	оплачен	1375	13	13856.934	11193	2025-06-18 00:00:00	8
2262	47	2025-06-22 05:40:00	2025-06-22 07:15:00	11	отменен	1376	13	13308.477	11193	2025-05-01 00:00:00	7
2263	47	2025-06-22 05:40:00	2025-06-22 07:15:00	11	оплачен	1430	13	14483.742	11193	2025-02-14 00:00:00	19
2264	47	2025-06-22 05:40:00	2025-06-22 07:15:00	11	забронирован	1383	13	12368.265	11193	2025-05-11 00:00:00	7
2265	47	2025-06-22 05:40:00	2025-06-22 07:15:00	11	оплачен	1529	13	13666.653	11193	2025-02-15 00:00:00	23
2266	47	2025-06-22 05:40:00	2025-06-22 07:15:00	11	оплачен	1416	13	14271.074999999999	11193	2025-05-10 00:00:00	18
2267	47	2025-06-22 05:40:00	2025-06-22 07:15:00	11	оплачен	1420	13	14595.672	11193	2025-03-21 00:00:00	10
2268	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	отменен	1500	16	12331.592	10424	2025-04-28 00:00:00	12
2269	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	оплачен	1420	16	12143.960000000001	10424	2025-03-03 00:00:00	7
2270	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	оплачен	1402	16	10695.024	10424	2025-04-29 00:00:00	24
2271	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	оплачен	1531	16	10632.48	10424	2025-02-25 00:00:00	20
2272	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	оплачен	1510	16	13113.392	10424	2025-04-18 00:00:00	13
2273	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	оплачен	1423	16	10966.048	10424	2025-01-08 00:00:00	19
2274	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	оплачен	1428	16	13280.176	10424	2025-02-26 00:00:00	12
2275	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	забронирован	1482	16	12185.656	10424	2025-04-07 00:00:00	15
2276	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	забронирован	1557	16	13040.423999999999	10424	2025-04-18 00:00:00	19
2277	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	отменен	1483	16	12748.552000000001	10424	2025-03-26 00:00:00	11
2278	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	забронирован	1391	16	13446.960000000001	10424	2025-04-20 00:00:00	20
2279	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	забронирован	1404	16	11862.511999999999	10424	2025-01-22 00:00:00	7
2280	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	забронирован	1527	16	12821.52	10424	2025-05-23 00:00:00	20
2281	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	отменен	1571	16	11372.583999999999	10424	2025-01-30 00:00:00	14
2282	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	отменен	1526	16	13499.08	10424	2025-06-07 00:00:00	22
2283	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	оплачен	1569	16	13363.568000000001	10424	2025-04-28 00:00:00	10
2284	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	забронирован	1382	16	10684.599999999999	10424	2025-06-10 00:00:00	15
2285	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	отменен	1413	16	10444.848	10424	2025-05-30 00:00:00	12
2286	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	отменен	1553	16	13843.072	10424	2025-04-16 00:00:00	15
2287	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	оплачен	1511	16	13415.687999999998	10424	2025-02-13 00:00:00	24
2288	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	забронирован	1523	16	13728.408	10424	2025-06-03 00:00:00	18
2289	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	забронирован	1410	16	10997.32	10424	2025-03-24 00:00:00	23
2290	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	оплачен	1543	16	11591.488000000001	10424	2025-01-21 00:00:00	18
2291	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	отменен	1416	16	13863.92	10424	2025-01-08 00:00:00	7
2292	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	отменен	1490	16	11445.552000000001	10424	2025-05-12 00:00:00	12
2293	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	оплачен	1425	16	12748.552000000001	10424	2025-01-30 00:00:00	8
2294	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	забронирован	1573	16	12070.991999999998	10424	2025-05-10 00:00:00	17
2295	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	отменен	1532	16	11528.944000000001	10424	2025-01-13 00:00:00	14
2296	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	отменен	1537	16	11289.192	10424	2025-05-18 00:00:00	20
2297	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	забронирован	1549	16	12321.168	10424	2025-01-04 00:00:00	13
2298	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	оплачен	1508	16	13259.328	10424	2025-01-01 00:00:00	23
2299	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	оплачен	1516	16	13082.119999999999	10424	2025-05-20 00:00:00	17
2300	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	забронирован	1517	16	12758.976	10424	2025-03-11 00:00:00	10
2301	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	забронирован	1485	16	12904.912	10424	2025-04-12 00:00:00	12
2302	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	забронирован	1422	16	12060.568000000001	10424	2025-01-03 00:00:00	11
2303	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	отменен	1501	16	12904.912	10424	2025-03-27 00:00:00	19
2304	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	отменен	1418	16	12185.656	10424	2025-01-23 00:00:00	14
2305	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	забронирован	1400	16	13321.872	10424	2025-03-19 00:00:00	22
2306	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	оплачен	1406	16	10455.271999999999	10424	2025-02-05 00:00:00	9
2307	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	забронирован	1384	16	10809.687999999998	10424	2025-05-13 00:00:00	9
2308	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	оплачен	1560	16	12498.376	10424	2025-04-27 00:00:00	18
2309	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	отменен	1386	16	12143.960000000001	10424	2025-06-06 00:00:00	20
2310	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	оплачен	1525	16	13102.967999999999	10424	2025-02-24 00:00:00	8
2311	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	забронирован	1568	16	11237.072	10424	2025-02-15 00:00:00	6
2312	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	забронирован	1399	16	11257.92	10424	2025-04-13 00:00:00	12
2313	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	отменен	1491	16	12779.824	10424	2025-01-29 00:00:00	15
2314	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	забронирован	1487	16	12133.536	10424	2025-06-15 00:00:00	20
2315	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	забронирован	1411	16	13478.232	10424	2025-01-24 00:00:00	20
2316	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	оплачен	1486	16	13155.088	10424	2025-03-21 00:00:00	18
2317	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	отменен	1521	16	13217.632	10424	2025-06-07 00:00:00	19
2318	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	отменен	1421	16	13311.447999999999	10424	2025-02-27 00:00:00	9
2319	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	оплачен	1533	16	12831.944000000001	10424	2025-03-13 00:00:00	18
2320	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	отменен	1388	16	12519.224	10424	2025-01-31 00:00:00	20
2321	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	отменен	1520	16	12008.447999999999	10424	2025-02-10 00:00:00	20
2322	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	отменен	1488	16	11664.456	10424	2025-06-16 00:00:00	8
2323	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	отменен	1403	16	10934.776	10424	2025-02-08 00:00:00	20
2324	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	оплачен	1393	16	10747.143999999998	10424	2025-05-08 00:00:00	22
2325	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	забронирован	1379	16	10757.568000000001	10424	2025-04-26 00:00:00	6
2326	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	забронирован	1506	16	10465.696	10424	2025-04-04 00:00:00	10
2327	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	отменен	1381	16	10632.48	10424	2025-05-01 00:00:00	8
2328	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	оплачен	1377	16	12529.648	10424	2025-01-25 00:00:00	25
2329	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	оплачен	1371	16	11435.128	10424	2025-04-29 00:00:00	14
2330	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	отменен	1544	16	13332.295999999998	10424	2025-03-03 00:00:00	13
2331	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	оплачен	1522	16	13811.8	10424	2025-06-02 00:00:00	6
2332	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	отменен	1412	16	10611.632	10424	2025-05-24 00:00:00	8
2333	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	забронирован	1542	16	11674.880000000001	10424	2025-02-09 00:00:00	6
2334	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	забронирован	1372	16	12331.592	10424	2025-04-27 00:00:00	18
2335	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	оплачен	1401	16	13895.192	10424	2025-06-12 00:00:00	12
2336	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	отменен	1405	16	13457.384	10424	2025-05-14 00:00:00	17
2337	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	отменен	1554	16	13676.288	10424	2025-01-13 00:00:00	23
2338	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	оплачен	1387	16	11445.552000000001	10424	2025-06-11 00:00:00	15
2339	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	отменен	1558	16	10903.504	10424	2025-01-20 00:00:00	9
2340	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	отменен	1512	16	12800.672	10424	2025-04-11 00:00:00	16
2341	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	отменен	1562	16	10486.544	10424	2025-05-03 00:00:00	12
2342	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	забронирован	1545	16	13061.271999999999	10424	2025-04-14 00:00:00	23
2343	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	отменен	1407	16	10476.119999999999	10424	2025-06-04 00:00:00	22
2344	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	отменен	1395	16	10736.720000000001	10424	2025-04-07 00:00:00	17
2345	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	отменен	1414	16	12852.792000000001	10424	2025-02-04 00:00:00	25
2346	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	отменен	1398	16	10840.960000000001	10424	2025-05-22 00:00:00	13
2347	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	отменен	1567	16	13467.808	10424	2025-05-02 00:00:00	21
2348	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	оплачен	1495	16	11570.640000000001	10424	2025-04-16 00:00:00	9
2349	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	забронирован	1563	16	11153.68	10424	2025-03-23 00:00:00	17
2350	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	отменен	1394	16	12310.744	10424	2025-04-13 00:00:00	11
2351	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	забронирован	1498	16	13613.744	10424	2025-06-21 00:00:00	19
2352	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	отменен	1408	16	13217.632	10424	2025-02-01 00:00:00	13
2353	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	отменен	1529	16	12842.368	10424	2025-05-16 00:00:00	8
2354	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	оплачен	1397	16	11007.744	10424	2025-05-23 00:00:00	6
2355	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	забронирован	1546	16	10444.848	10424	2025-03-01 00:00:00	16
2356	47	2025-06-22 05:40:00	2025-06-22 10:40:00	11	забронирован	1550	16	13196.784	10424	2025-05-18 00:00:00	17
\.


--
-- TOC entry 3765 (class 0 OID 16532)
-- Dependencies: 228
-- Data for Name: train; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.train (id, name, number, notes, departure_station, arrival_station, departure_time, arrival_time, train_type) FROM stdin;
2	Сапсан	32	\N	28	18	17:30:00	22:06:00	скоростной
3	Стриж	18	\N	30	18	11:55:00	16:40:00	скорый
4	Сапсан	36	\N	30	20	08:20:00	12:21:00	скоростной
5	Сапсан	26	\N	6	28	17:15:00	20:11:00	скоростной
6	Ласточка	72	\N	6	12	05:55:00	09:37:00	скорый
7	Стриж	6	\N	27	9	08:20:00	10:34:00	скорый
8	Стриж	15	\N	12	30	12:40:00	15:35:00	скорый
9	Сапсан	63	\N	14	11	06:55:00	09:53:00	скоростной
10	Ласточка	65	\N	6	17	16:50:00	22:01:00	скорый
12	Сапсан	32	\N	28	18	17:30:00	22:06:00	скоростной
13	Стриж	18	\N	30	18	11:55:00	16:40:00	скорый
14	Сапсан	36	\N	30	20	08:20:00	12:21:00	скоростной
15	Сапсан	26	\N	6	28	17:15:00	20:11:00	скоростной
16	Ласточка	72	\N	6	12	05:55:00	09:37:00	скорый
17	Стриж	6	\N	27	9	08:20:00	10:34:00	скорый
18	Стриж	15	\N	12	30	12:40:00	15:35:00	скорый
19	Сапсан	63	\N	14	11	06:55:00	09:53:00	скоростной
20	Ласточка	65	\N	6	17	16:50:00	22:01:00	скорый
21	Аврора	73	\N	26	18	17:50:00	22:23:00	пассажирский
22	Сапсан	60	\N	8	13	06:45:00	13:14:00	скоростной
23	Сапсан	79	\N	18	16	14:35:00	20:27:00	скоростной
24	Стриж	86	\N	27	16	20:35:00	23:51:00	скорый
25	Стриж	91	\N	23	21	20:00:00	22:43:00	скорый
26	Стриж	89	\N	11	16	05:40:00	10:40:00	скорый
27	Сапсан	21	\N	8	12	07:55:00	13:44:00	скоростной
28	Стриж	67	\N	6	23	11:55:00	15:16:00	скорый
29	Сапсан	62	\N	23	30	13:20:00	15:21:00	скоростной
\.


--
-- TOC entry 3773 (class 0 OID 16587)
-- Dependencies: 236
-- Data for Name: train_consist; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.train_consist (id, id_flight, id_carriage, number, status) FROM stdin;
1	2	370	1	готов
2	2	371	2	готов
3	2	372	3	готов
4	3	368	1	готов
5	3	374	2	готов
6	3	375	3	готов
7	3	381	4	готов
8	14	369	1	не готов
9	14	373	2	не готов
10	14	376	3	не готов
11	14	380	4	не готов
12	40	372	1	готов
13	40	374	2	готов
14	40	375	3	готов
15	40	381	4	готов
16	40	386	5	готов
17	40	371	6	готов
18	40	370	7	готов
19	47	365	1	готов
20	47	366	2	готов
21	47	368	3	готов
22	47	371	4	готов
23	47	370	5	готов
\.


--
-- TOC entry 3798 (class 0 OID 0)
-- Dependencies: 239
-- Name: box_office_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.box_office_id_seq', 408, true);


--
-- TOC entry 3799 (class 0 OID 0)
-- Dependencies: 227
-- Name: carriage_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.carriage_id_seq', 29, true);


--
-- TOC entry 3800 (class 0 OID 0)
-- Dependencies: 229
-- Name: carriage_id_seq1; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.carriage_id_seq1', 390, true);


--
-- TOC entry 3801 (class 0 OID 0)
-- Dependencies: 221
-- Name: carriage_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.carriage_type_id_seq', 72, true);


--
-- TOC entry 3802 (class 0 OID 0)
-- Dependencies: 223
-- Name: discount_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.discount_id_seq', 90, true);


--
-- TOC entry 3803 (class 0 OID 0)
-- Dependencies: 231
-- Name: flight_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.flight_id_seq', 54, true);


--
-- TOC entry 3804 (class 0 OID 0)
-- Dependencies: 233
-- Name: flight_stops_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.flight_stops_id_seq', 423, true);


--
-- TOC entry 3805 (class 0 OID 0)
-- Dependencies: 217
-- Name: passenger_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.passenger_id_seq', 41, true);


--
-- TOC entry 3806 (class 0 OID 0)
-- Dependencies: 219
-- Name: passport_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.passport_id_seq', 25, true);


--
-- TOC entry 3807 (class 0 OID 0)
-- Dependencies: 237
-- Name: seat_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seat_id_seq', 1580, true);


--
-- TOC entry 3808 (class 0 OID 0)
-- Dependencies: 225
-- Name: station_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.station_id_seq', 30, true);


--
-- TOC entry 3809 (class 0 OID 0)
-- Dependencies: 241
-- Name: ticket_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ticket_id_seq', 2356, true);


--
-- TOC entry 3810 (class 0 OID 0)
-- Dependencies: 235
-- Name: train_consist_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.train_consist_id_seq', 23, true);


--
-- TOC entry 3591 (class 2606 OID 16654)
-- Name: box_office box_office_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.box_office
    ADD CONSTRAINT box_office_pkey PRIMARY KEY (id);


--
-- TOC entry 3579 (class 2606 OID 16539)
-- Name: train carriage_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.train
    ADD CONSTRAINT carriage_pkey PRIMARY KEY (id);


--
-- TOC entry 3581 (class 2606 OID 16556)
-- Name: carriage carriage_pkey1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carriage
    ADD CONSTRAINT carriage_pkey1 PRIMARY KEY (id);


--
-- TOC entry 3573 (class 2606 OID 16516)
-- Name: carriage_type carriage_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carriage_type
    ADD CONSTRAINT carriage_type_pkey PRIMARY KEY (id);


--
-- TOC entry 3575 (class 2606 OID 16523)
-- Name: discount discount_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.discount
    ADD CONSTRAINT discount_pkey PRIMARY KEY (id);


--
-- TOC entry 3583 (class 2606 OID 16563)
-- Name: flight flight_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.flight
    ADD CONSTRAINT flight_pkey PRIMARY KEY (id);


--
-- TOC entry 3585 (class 2606 OID 16575)
-- Name: flight_stops flight_stops_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.flight_stops
    ADD CONSTRAINT flight_stops_pkey PRIMARY KEY (id);


--
-- TOC entry 3563 (class 2606 OID 16484)
-- Name: passenger passenger_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.passenger
    ADD CONSTRAINT passenger_email_key UNIQUE (email);


--
-- TOC entry 3565 (class 2606 OID 16486)
-- Name: passenger passenger_phone_number_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.passenger
    ADD CONSTRAINT passenger_phone_number_key UNIQUE (phone_number);


--
-- TOC entry 3567 (class 2606 OID 16482)
-- Name: passenger passenger_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.passenger
    ADD CONSTRAINT passenger_pkey PRIMARY KEY (id);


--
-- TOC entry 3569 (class 2606 OID 16495)
-- Name: passport passport_passport_data_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.passport
    ADD CONSTRAINT passport_passport_data_key UNIQUE (passport_data);


--
-- TOC entry 3571 (class 2606 OID 16493)
-- Name: passport passport_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.passport
    ADD CONSTRAINT passport_pkey PRIMARY KEY (id);


--
-- TOC entry 3589 (class 2606 OID 16618)
-- Name: seat seat_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.seat
    ADD CONSTRAINT seat_pkey PRIMARY KEY (id);


--
-- TOC entry 3577 (class 2606 OID 16530)
-- Name: station station_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.station
    ADD CONSTRAINT station_pkey PRIMARY KEY (id);


--
-- TOC entry 3593 (class 2606 OID 16672)
-- Name: ticket ticket_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ticket
    ADD CONSTRAINT ticket_pkey PRIMARY KEY (id);


--
-- TOC entry 3587 (class 2606 OID 16592)
-- Name: train_consist train_consist_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.train_consist
    ADD CONSTRAINT train_consist_pkey PRIMARY KEY (id);


--
-- TOC entry 3595 (class 2606 OID 16545)
-- Name: train carriage_arrival_station_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.train
    ADD CONSTRAINT carriage_arrival_station_fkey FOREIGN KEY (arrival_station) REFERENCES public.station(id);


--
-- TOC entry 3596 (class 2606 OID 16540)
-- Name: train carriage_departure_station_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.train
    ADD CONSTRAINT carriage_departure_station_fkey FOREIGN KEY (departure_station) REFERENCES public.station(id);


--
-- TOC entry 3597 (class 2606 OID 16765)
-- Name: carriage fk_carriage_type; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carriage
    ADD CONSTRAINT fk_carriage_type FOREIGN KEY (id_type) REFERENCES public.carriage_type(id);


--
-- TOC entry 3604 (class 2606 OID 16770)
-- Name: ticket fk_ticket_passport; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ticket
    ADD CONSTRAINT fk_ticket_passport FOREIGN KEY (id_passport) REFERENCES public.passport(id);


--
-- TOC entry 3598 (class 2606 OID 16564)
-- Name: flight flight_id_train_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.flight
    ADD CONSTRAINT flight_id_train_fkey FOREIGN KEY (id_train) REFERENCES public.train(id);


--
-- TOC entry 3599 (class 2606 OID 16581)
-- Name: flight_stops flight_stops_id_station_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.flight_stops
    ADD CONSTRAINT flight_stops_id_station_fkey FOREIGN KEY (id_station) REFERENCES public.station(id);


--
-- TOC entry 3600 (class 2606 OID 16576)
-- Name: flight_stops flight_stops_id_train_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.flight_stops
    ADD CONSTRAINT flight_stops_id_train_fkey FOREIGN KEY (id_train) REFERENCES public.train(id);


--
-- TOC entry 3594 (class 2606 OID 16496)
-- Name: passport passport_id_passenger_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.passport
    ADD CONSTRAINT passport_id_passenger_fkey FOREIGN KEY (id_passenger) REFERENCES public.passenger(id);


--
-- TOC entry 3603 (class 2606 OID 16619)
-- Name: seat seat_id_train_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.seat
    ADD CONSTRAINT seat_id_train_fkey FOREIGN KEY (id_train) REFERENCES public.train(id);


--
-- TOC entry 3605 (class 2606 OID 16688)
-- Name: ticket ticket_boarding_point_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ticket
    ADD CONSTRAINT ticket_boarding_point_fkey FOREIGN KEY (boarding_point) REFERENCES public.station(id);


--
-- TOC entry 3606 (class 2606 OID 16678)
-- Name: ticket ticket_dropoff_point_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ticket
    ADD CONSTRAINT ticket_dropoff_point_fkey FOREIGN KEY (dropoff_point) REFERENCES public.station(id);


--
-- TOC entry 3607 (class 2606 OID 16683)
-- Name: ticket ticket_id_flight_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ticket
    ADD CONSTRAINT ticket_id_flight_fkey FOREIGN KEY (id_flight) REFERENCES public.flight(id);


--
-- TOC entry 3608 (class 2606 OID 16673)
-- Name: ticket ticket_id_seat_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ticket
    ADD CONSTRAINT ticket_id_seat_fkey FOREIGN KEY (id_seat) REFERENCES public.seat(id);


--
-- TOC entry 3601 (class 2606 OID 16598)
-- Name: train_consist train_consist_id_carriage_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.train_consist
    ADD CONSTRAINT train_consist_id_carriage_fkey FOREIGN KEY (id_carriage) REFERENCES public.carriage(id);


--
-- TOC entry 3602 (class 2606 OID 16593)
-- Name: train_consist train_consist_id_flight_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.train_consist
    ADD CONSTRAINT train_consist_id_flight_fkey FOREIGN KEY (id_flight) REFERENCES public.flight(id);


-- Completed on 2025-05-11 19:59:00 MSK

--
-- PostgreSQL database dump complete
--

