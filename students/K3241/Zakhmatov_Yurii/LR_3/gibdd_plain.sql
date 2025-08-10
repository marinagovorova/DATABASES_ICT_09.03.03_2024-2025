--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4
-- Dumped by pg_dump version 17.4

-- Started on 2025-04-03 16:03:46

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

DROP DATABASE IF EXISTS " GIBDD";
--
-- TOC entry 5023 (class 1262 OID 16388)
-- Name:  GIBDD; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE " GIBDD" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'ru-RU';


ALTER DATABASE " GIBDD" OWNER TO postgres;

\encoding SQL_ASCII
\connect -reuse-previous=on "dbname=' GIBDD'"

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
-- TOC entry 5024 (class 0 OID 0)
-- Name:  GIBDD; Type: DATABASE PROPERTIES; Schema: -; Owner: postgres
--

ALTER DATABASE " GIBDD" CONNECTION LIMIT = 1;


\encoding SQL_ASCII
\connect -reuse-previous=on "dbname=' GIBDD'"

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
-- TOC entry 6 (class 2615 OID 17208)
-- Name: ГИБДД; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA "ГИБДД";


ALTER SCHEMA "ГИБДД" OWNER TO postgres;

--
-- TOC entry 869 (class 1247 OID 17218)
-- Name: размер_оплаты; Type: TYPE; Schema: ГИБДД; Owner: postgres
--

CREATE TYPE "ГИБДД"."размер_оплаты" AS ENUM (
    'Полный',
    'Частичный',
    'Не оплачен'
);


ALTER TYPE "ГИБДД"."размер_оплаты" OWNER TO postgres;

--
-- TOC entry 866 (class 1247 OID 17210)
-- Name: роль_участника; Type: TYPE; Schema: ГИБДД; Owner: postgres
--

CREATE TYPE "ГИБДД"."роль_участника" AS ENUM (
    'Виновник',
    'Потерпевший',
    'Неопределено'
);


ALTER TYPE "ГИБДД"."роль_участника" OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 229 (class 1259 OID 17279)
-- Name: Владелец; Type: TABLE; Schema: ГИБДД; Owner: postgres
--

CREATE TABLE "ГИБДД"."Владелец" (
    "id_Владельца" integer NOT NULL,
    "Номер_телефона" character varying(15) NOT NULL,
    "ФИО" character varying(255) NOT NULL,
    CONSTRAINT "Владелец_Номер_телефона_check" CHECK (((("Номер_телефона")::text ~ '^\+[0-9]+$'::text) AND ((length(("Номер_телефона")::text) >= 10) AND (length(("Номер_телефона")::text) <= 15)))),
    CONSTRAINT "Владелец_ФИО_check" CHECK (((("ФИО")::text ~ '^[А-Яа-яЁё\s-]+$'::text) AND (length(("ФИО")::text) >= 2)))
);


ALTER TABLE "ГИБДД"."Владелец" OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 17278)
-- Name: Владелец_id_Владельца_seq; Type: SEQUENCE; Schema: ГИБДД; Owner: postgres
--

CREATE SEQUENCE "ГИБДД"."Владелец_id_Владельца_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "ГИБДД"."Владелец_id_Владельца_seq" OWNER TO postgres;

--
-- TOC entry 5025 (class 0 OID 0)
-- Dependencies: 228
-- Name: Владелец_id_Владельца_seq; Type: SEQUENCE OWNED BY; Schema: ГИБДД; Owner: postgres
--

ALTER SEQUENCE "ГИБДД"."Владелец_id_Владельца_seq" OWNED BY "ГИБДД"."Владелец"."id_Владельца";


--
-- TOC entry 219 (class 1259 OID 17226)
-- Name: Водитель; Type: TABLE; Schema: ГИБДД; Owner: postgres
--

CREATE TABLE "ГИБДД"."Водитель" (
    "id_водителя" integer NOT NULL,
    "ФИО" character varying(255) NOT NULL,
    "Номер_телефона" character varying(15),
    "Адрес_проживания" character varying(255) NOT NULL,
    CONSTRAINT "Водитель_Адрес_проживания_check" CHECK ((length(("Адрес_проживания")::text) >= 2)),
    CONSTRAINT "Водитель_ФИО_check" CHECK (((("ФИО")::text ~ '^[А-Яа-яЁё\s-]+$'::text) AND (length(("ФИО")::text) >= 2)))
);


ALTER TABLE "ГИБДД"."Водитель" OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 17225)
-- Name: Водитель_id_водителя_seq; Type: SEQUENCE; Schema: ГИБДД; Owner: postgres
--

CREATE SEQUENCE "ГИБДД"."Водитель_id_водителя_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "ГИБДД"."Водитель_id_водителя_seq" OWNER TO postgres;

--
-- TOC entry 5026 (class 0 OID 0)
-- Dependencies: 218
-- Name: Водитель_id_водителя_seq; Type: SEQUENCE OWNED BY; Schema: ГИБДД; Owner: postgres
--

ALTER SEQUENCE "ГИБДД"."Водитель_id_водителя_seq" OWNED BY "ГИБДД"."Водитель"."id_водителя";


--
-- TOC entry 233 (class 1259 OID 17307)
-- Name: ДТП; Type: TABLE; Schema: ГИБДД; Owner: postgres
--

CREATE TABLE "ГИБДД"."ДТП" (
    "id_ДТП" integer NOT NULL,
    "id_инспектора" integer NOT NULL,
    "Координаты_аварии_широта" numeric(9,6) NOT NULL,
    "Координаты_аварии_долгота" numeric(9,6) NOT NULL,
    "Описание_аварии" text NOT NULL,
    "Дата_и_время_аварии" timestamp without time zone NOT NULL,
    "Вина_владельца" boolean NOT NULL,
    "Номер_протокола_аварии" character varying(50) NOT NULL,
    CONSTRAINT "ДТП_Номер_протокола_аварии_check" CHECK ((length(("Номер_протокола_аварии")::text) >= 1))
);


ALTER TABLE "ГИБДД"."ДТП" OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 17306)
-- Name: ДТП_id_ДТП_seq; Type: SEQUENCE; Schema: ГИБДД; Owner: postgres
--

CREATE SEQUENCE "ГИБДД"."ДТП_id_ДТП_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "ГИБДД"."ДТП_id_ДТП_seq" OWNER TO postgres;

--
-- TOC entry 5027 (class 0 OID 0)
-- Dependencies: 232
-- Name: ДТП_id_ДТП_seq; Type: SEQUENCE OWNED BY; Schema: ГИБДД; Owner: postgres
--

ALTER SEQUENCE "ГИБДД"."ДТП_id_ДТП_seq" OWNED BY "ГИБДД"."ДТП"."id_ДТП";


--
-- TOC entry 221 (class 1259 OID 17237)
-- Name: Инспектор; Type: TABLE; Schema: ГИБДД; Owner: postgres
--

CREATE TABLE "ГИБДД"."Инспектор" (
    "id_инспектора" integer NOT NULL,
    "Личный_номер_инспектора" integer NOT NULL,
    "ФИО" character varying(255) NOT NULL,
    "Звание" character varying(100) NOT NULL,
    CONSTRAINT "Инспектор_Звание_check" CHECK (((length(("Звание")::text) >= 2) AND (("Звание")::text ~ '^[А-Яа-яЁё\s-]+$'::text))),
    CONSTRAINT "Инспектор_ФИО_check" CHECK (((("ФИО")::text ~ '^[А-Яа-яЁё\s-]+$'::text) AND (length(("ФИО")::text) >= 2)))
);


ALTER TABLE "ГИБДД"."Инспектор" OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 17236)
-- Name: Инспектор_id_инспектора_seq; Type: SEQUENCE; Schema: ГИБДД; Owner: postgres
--

CREATE SEQUENCE "ГИБДД"."Инспектор_id_инспектора_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "ГИБДД"."Инспектор_id_инспектора_seq" OWNER TO postgres;

--
-- TOC entry 5028 (class 0 OID 0)
-- Dependencies: 220
-- Name: Инспектор_id_инспектора_seq; Type: SEQUENCE OWNED BY; Schema: ГИБДД; Owner: postgres
--

ALTER SEQUENCE "ГИБДД"."Инспектор_id_инспектора_seq" OWNED BY "ГИБДД"."Инспектор"."id_инспектора";


--
-- TOC entry 225 (class 1259 OID 17261)
-- Name: Нарушения_ПДД; Type: TABLE; Schema: ГИБДД; Owner: postgres
--

CREATE TABLE "ГИБДД"."Нарушения_ПДД" (
    "Код_нарушения" integer NOT NULL,
    "Вид_нарушения" character varying(255) NOT NULL,
    "Описание_нарушения" text NOT NULL
);


ALTER TABLE "ГИБДД"."Нарушения_ПДД" OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 17260)
-- Name: Нарушения_ПДД_Код_нарушения_seq; Type: SEQUENCE; Schema: ГИБДД; Owner: postgres
--

CREATE SEQUENCE "ГИБДД"."Нарушения_ПДД_Код_нарушения_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "ГИБДД"."Нарушения_ПДД_Код_нарушения_seq" OWNER TO postgres;

--
-- TOC entry 5029 (class 0 OID 0)
-- Dependencies: 224
-- Name: Нарушения_ПДД_Код_нарушения_seq; Type: SEQUENCE OWNED BY; Schema: ГИБДД; Owner: postgres
--

ALTER SEQUENCE "ГИБДД"."Нарушения_ПДД_Код_нарушения_seq" OWNED BY "ГИБДД"."Нарушения_ПДД"."Код_нарушения";


--
-- TOC entry 231 (class 1259 OID 17288)
-- Name: Период_владения; Type: TABLE; Schema: ГИБДД; Owner: postgres
--

CREATE TABLE "ГИБДД"."Период_владения" (
    "id_ПерВлад" integer NOT NULL,
    "id_ТС" integer NOT NULL,
    "id_Владельца" integer NOT NULL,
    "Владение_с" date NOT NULL,
    "Владение_по" date,
    CONSTRAINT "Период_владения_check" CHECK (("Владение_по" >= "Владение_с")),
    CONSTRAINT "Период_владения_check1" CHECK ((("Владение_по" IS NULL) OR ("Владение_по" >= "Владение_с")))
);


ALTER TABLE "ГИБДД"."Период_владения" OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 17287)
-- Name: Период_владения_id_ПерВлад_seq; Type: SEQUENCE; Schema: ГИБДД; Owner: postgres
--

CREATE SEQUENCE "ГИБДД"."Период_владения_id_ПерВлад_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "ГИБДД"."Период_владения_id_ПерВлад_seq" OWNER TO postgres;

--
-- TOC entry 5030 (class 0 OID 0)
-- Dependencies: 230
-- Name: Период_владения_id_ПерВлад_seq; Type: SEQUENCE OWNED BY; Schema: ГИБДД; Owner: postgres
--

ALTER SEQUENCE "ГИБДД"."Период_владения_id_ПерВлад_seq" OWNED BY "ГИБДД"."Период_владения"."id_ПерВлад";


--
-- TOC entry 237 (class 1259 OID 17356)
-- Name: Регистрация_нарушения; Type: TABLE; Schema: ГИБДД; Owner: postgres
--

CREATE TABLE "ГИБДД"."Регистрация_нарушения" (
    "id_нарушения" integer NOT NULL,
    "id_водителя" integer NOT NULL,
    "id_инспектора" integer NOT NULL,
    "id_штрафа" integer NOT NULL,
    "id_ТС" integer NOT NULL,
    "Код_нарушения" integer NOT NULL,
    "Срок_лишения_прав_управления_ТС" integer,
    "Координаты_нарушения_широта" numeric(9,6) NOT NULL,
    "Координаты_нарушения_долгота" numeric(9,6) NOT NULL,
    "Дата_и_время_нарушения" timestamp without time zone NOT NULL,
    CONSTRAINT "Регистрация_на_Срок_лишения_пр_check" CHECK ((("Срок_лишения_прав_управления_ТС" IS NULL) OR ("Срок_лишения_прав_управления_ТС" >= 0)))
);


ALTER TABLE "ГИБДД"."Регистрация_нарушения" OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 17355)
-- Name: Регистрация_нарушен_id_нарушения_seq; Type: SEQUENCE; Schema: ГИБДД; Owner: postgres
--

CREATE SEQUENCE "ГИБДД"."Регистрация_нарушен_id_нарушения_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "ГИБДД"."Регистрация_нарушен_id_нарушения_seq" OWNER TO postgres;

--
-- TOC entry 5031 (class 0 OID 0)
-- Dependencies: 236
-- Name: Регистрация_нарушен_id_нарушения_seq; Type: SEQUENCE OWNED BY; Schema: ГИБДД; Owner: postgres
--

ALTER SEQUENCE "ГИБДД"."Регистрация_нарушен_id_нарушения_seq" OWNED BY "ГИБДД"."Регистрация_нарушения"."id_нарушения";


--
-- TOC entry 223 (class 1259 OID 17248)
-- Name: Транспортное_средство; Type: TABLE; Schema: ГИБДД; Owner: postgres
--

CREATE TABLE "ГИБДД"."Транспортное_средство" (
    "id_ТС" integer NOT NULL,
    "Дата_регистрации_в_ГИБДД" date,
    "Модель_ТС" character varying(255),
    "Марка_ТС" character varying(255),
    "Дата_выпуска" date NOT NULL,
    "vin_код_ТС" character varying(17),
    "Номер_ТС" character varying(9) NOT NULL,
    "Категория_ТС" character varying(3) NOT NULL,
    CONSTRAINT "Транспортное_сред_Категория_ТС_check" CHECK ((length(("Категория_ТС")::text) >= 1)),
    CONSTRAINT "Транспортное_средство_check" CHECK (("Дата_регистрации_в_ГИБДД" >= "Дата_выпуска")),
    CONSTRAINT "Транспортное_средство_vin_код_ТС_check" CHECK ((("vin_код_ТС" IS NULL) OR (("vin_код_ТС")::text ~ '^[A-HJ-NPR-Z0-9]{17}$'::text))),
    CONSTRAINT "Транспортное_средство_Номер_ТС_check" CHECK (((("Номер_ТС")::text ~ '^[АВЕКМНОРСТУХ][0-9]{3}[АВЕКМНОРСТУХ]{2}[0-9]{2,3}$'::text) OR (("Номер_ТС")::text ~ '^[0-9]{4}[АВЕКМНОРСТУХ]{2}[0-9]{2}$'::text) OR (("Номер_ТС")::text ~ '^[АВЕКМНОРСТУХ][0-9]{2}[АВЕКМНОРСТУХ]{3}$'::text)))
);


ALTER TABLE "ГИБДД"."Транспортное_средство" OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 17247)
-- Name: Транспортное_средство_id_ТС_seq; Type: SEQUENCE; Schema: ГИБДД; Owner: postgres
--

CREATE SEQUENCE "ГИБДД"."Транспортное_средство_id_ТС_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "ГИБДД"."Транспортное_средство_id_ТС_seq" OWNER TO postgres;

--
-- TOC entry 5032 (class 0 OID 0)
-- Dependencies: 222
-- Name: Транспортное_средство_id_ТС_seq; Type: SEQUENCE OWNED BY; Schema: ГИБДД; Owner: postgres
--

ALTER SEQUENCE "ГИБДД"."Транспортное_средство_id_ТС_seq" OWNED BY "ГИБДД"."Транспортное_средство"."id_ТС";


--
-- TOC entry 235 (class 1259 OID 17322)
-- Name: Участник_ДТП; Type: TABLE; Schema: ГИБДД; Owner: postgres
--

CREATE TABLE "ГИБДД"."Участник_ДТП" (
    "id_уДТП" integer NOT NULL,
    "id_водителя" integer NOT NULL,
    "id_ДТП" integer NOT NULL,
    "Роль_участника" "ГИБДД"."роль_участника" NOT NULL,
    "id_ТС" integer
);


ALTER TABLE "ГИБДД"."Участник_ДТП" OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 17321)
-- Name: Участник_ДТП_id_уДТП_seq; Type: SEQUENCE; Schema: ГИБДД; Owner: postgres
--

CREATE SEQUENCE "ГИБДД"."Участник_ДТП_id_уДТП_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "ГИБДД"."Участник_ДТП_id_уДТП_seq" OWNER TO postgres;

--
-- TOC entry 5033 (class 0 OID 0)
-- Dependencies: 234
-- Name: Участник_ДТП_id_уДТП_seq; Type: SEQUENCE OWNED BY; Schema: ГИБДД; Owner: postgres
--

ALTER SEQUENCE "ГИБДД"."Участник_ДТП_id_уДТП_seq" OWNED BY "ГИБДД"."Участник_ДТП"."id_уДТП";


--
-- TOC entry 227 (class 1259 OID 17270)
-- Name: Штраф; Type: TABLE; Schema: ГИБДД; Owner: postgres
--

CREATE TABLE "ГИБДД"."Штраф" (
    "id_штрафа" integer NOT NULL,
    "Сумма_штрафа" integer NOT NULL,
    "Размер_оплаты" "ГИБДД"."размер_оплаты" NOT NULL,
    "Дата_и_время_оплаты" timestamp without time zone,
    "Статус_оплаты" boolean NOT NULL,
    "Номер_постановления_о_штрафе" character varying(50) NOT NULL,
    CONSTRAINT "Штраф_Номер_постановления_о_шт_check" CHECK ((length(("Номер_постановления_о_штрафе")::text) >= 1)),
    CONSTRAINT "Штраф_Сумма_штрафа_check" CHECK (("Сумма_штрафа" > 0))
);


ALTER TABLE "ГИБДД"."Штраф" OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 17269)
-- Name: Штраф_id_штрафа_seq; Type: SEQUENCE; Schema: ГИБДД; Owner: postgres
--

CREATE SEQUENCE "ГИБДД"."Штраф_id_штрафа_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "ГИБДД"."Штраф_id_штрафа_seq" OWNER TO postgres;

--
-- TOC entry 5034 (class 0 OID 0)
-- Dependencies: 226
-- Name: Штраф_id_штрафа_seq; Type: SEQUENCE OWNED BY; Schema: ГИБДД; Owner: postgres
--

ALTER SEQUENCE "ГИБДД"."Штраф_id_штрафа_seq" OWNED BY "ГИБДД"."Штраф"."id_штрафа";


--
-- TOC entry 4799 (class 2604 OID 17282)
-- Name: Владелец id_Владельца; Type: DEFAULT; Schema: ГИБДД; Owner: postgres
--

ALTER TABLE ONLY "ГИБДД"."Владелец" ALTER COLUMN "id_Владельца" SET DEFAULT nextval('"ГИБДД"."Владелец_id_Владельца_seq"'::regclass);


--
-- TOC entry 4794 (class 2604 OID 17229)
-- Name: Водитель id_водителя; Type: DEFAULT; Schema: ГИБДД; Owner: postgres
--

ALTER TABLE ONLY "ГИБДД"."Водитель" ALTER COLUMN "id_водителя" SET DEFAULT nextval('"ГИБДД"."Водитель_id_водителя_seq"'::regclass);


--
-- TOC entry 4801 (class 2604 OID 17310)
-- Name: ДТП id_ДТП; Type: DEFAULT; Schema: ГИБДД; Owner: postgres
--

ALTER TABLE ONLY "ГИБДД"."ДТП" ALTER COLUMN "id_ДТП" SET DEFAULT nextval('"ГИБДД"."ДТП_id_ДТП_seq"'::regclass);


--
-- TOC entry 4795 (class 2604 OID 17240)
-- Name: Инспектор id_инспектора; Type: DEFAULT; Schema: ГИБДД; Owner: postgres
--

ALTER TABLE ONLY "ГИБДД"."Инспектор" ALTER COLUMN "id_инспектора" SET DEFAULT nextval('"ГИБДД"."Инспектор_id_инспектора_seq"'::regclass);


--
-- TOC entry 4797 (class 2604 OID 17264)
-- Name: Нарушения_ПДД Код_нарушения; Type: DEFAULT; Schema: ГИБДД; Owner: postgres
--

ALTER TABLE ONLY "ГИБДД"."Нарушения_ПДД" ALTER COLUMN "Код_нарушения" SET DEFAULT nextval('"ГИБДД"."Нарушения_ПДД_Код_нарушения_seq"'::regclass);


--
-- TOC entry 4800 (class 2604 OID 17291)
-- Name: Период_владения id_ПерВлад; Type: DEFAULT; Schema: ГИБДД; Owner: postgres
--

ALTER TABLE ONLY "ГИБДД"."Период_владения" ALTER COLUMN "id_ПерВлад" SET DEFAULT nextval('"ГИБДД"."Период_владения_id_ПерВлад_seq"'::regclass);


--
-- TOC entry 4803 (class 2604 OID 17359)
-- Name: Регистрация_нарушения id_нарушения; Type: DEFAULT; Schema: ГИБДД; Owner: postgres
--

ALTER TABLE ONLY "ГИБДД"."Регистрация_нарушения" ALTER COLUMN "id_нарушения" SET DEFAULT nextval('"ГИБДД"."Регистрация_нарушен_id_нарушения_seq"'::regclass);


--
-- TOC entry 4796 (class 2604 OID 17251)
-- Name: Транспортное_средство id_ТС; Type: DEFAULT; Schema: ГИБДД; Owner: postgres
--

ALTER TABLE ONLY "ГИБДД"."Транспортное_средство" ALTER COLUMN "id_ТС" SET DEFAULT nextval('"ГИБДД"."Транспортное_средство_id_ТС_seq"'::regclass);


--
-- TOC entry 4802 (class 2604 OID 17325)
-- Name: Участник_ДТП id_уДТП; Type: DEFAULT; Schema: ГИБДД; Owner: postgres
--

ALTER TABLE ONLY "ГИБДД"."Участник_ДТП" ALTER COLUMN "id_уДТП" SET DEFAULT nextval('"ГИБДД"."Участник_ДТП_id_уДТП_seq"'::regclass);


--
-- TOC entry 4798 (class 2604 OID 17273)
-- Name: Штраф id_штрафа; Type: DEFAULT; Schema: ГИБДД; Owner: postgres
--

ALTER TABLE ONLY "ГИБДД"."Штраф" ALTER COLUMN "id_штрафа" SET DEFAULT nextval('"ГИБДД"."Штраф_id_штрафа_seq"'::regclass);


--
-- TOC entry 5009 (class 0 OID 17279)
-- Dependencies: 229
-- Data for Name: Владелец; Type: TABLE DATA; Schema: ГИБДД; Owner: postgres
--

COPY "ГИБДД"."Владелец" ("id_Владельца", "Номер_телефона", "ФИО") FROM stdin;
1	+79161234567	Иванов Иван Иванович
2	+79162345678	Петров Петр Петрович
3	+79163456789	Сидоров Алексей Владимирович
4	+79164567890	Кузнецова Анна Сергеевна
5	+79165678901	Смирнов Дмитрий Олегович
6	+79166789012	Васильева Елена Викторовна
7	+79167890123	Николаев Андрей Игоревич
8	+79168901234	Павлова Ольга Дмитриевна
9	+79169012345	Федоров Сергей Александрович
10	+79160123456	Козлова Мария Петровна
\.


--
-- TOC entry 4999 (class 0 OID 17226)
-- Dependencies: 219
-- Data for Name: Водитель; Type: TABLE DATA; Schema: ГИБДД; Owner: postgres
--

COPY "ГИБДД"."Водитель" ("id_водителя", "ФИО", "Номер_телефона", "Адрес_проживания") FROM stdin;
1	Иванов Иван Иванович	+79161234567	г. Москва, ул. Ленина, д. 10, кв. 5
2	Петров Петр Петрович	+79162345678	г. Москва, ул. Пушкина, д. 15, кв. 12
3	Сидоров Алексей Владимирович	+79163456789	г. Москва, пр. Мира, д. 20, кв. 34
4	Кузнецова Анна Сергеевна	+79164567890	г. Москва, ул. Гагарина, д. 5, кв. 7
5	Смирнов Дмитрий Олегович	+79165678901	г. Москва, ул. Солнечная, д. 12, кв. 9
6	Васильева Елена Викторовна	+79166789012	г. Москва, ул. Центральная, д. 1, кв. 11
7	Николаев Андрей Игоревич	+79167890123	г. Москва, ул. Лесная, д. 8, кв. 3
8	Павлова Ольга Дмитриевна	+79168901234	г. Москва, ул. Садовая, д. 4, кв. 6
9	Федоров Сергей Александрович	+79169012345	г. Москва, ул. Молодежная, д. 7, кв. 15
10	Козлова Мария Петровна	+79160123456	г. Москва, ул. Школьная, д. 3, кв. 8
11	Петя Здарова Петрович	+79213215251	г. Санкт-Петербург, Кронверский пр-кт, д. 31
\.


--
-- TOC entry 5013 (class 0 OID 17307)
-- Dependencies: 233
-- Data for Name: ДТП; Type: TABLE DATA; Schema: ГИБДД; Owner: postgres
--

COPY "ГИБДД"."ДТП" ("id_ДТП", "id_инспектора", "Координаты_аварии_широта", "Координаты_аварии_долгота", "Описание_аварии", "Дата_и_время_аварии", "Вина_владельца", "Номер_протокола_аварии") FROM stdin;
1	1	55.755825	37.617298	Столкновение двух автомобилей на перекрестке	2023-01-10 08:30:00	t	АВ-2023-0001
2	2	55.752023	37.617499	Наезд на препятствие	2023-02-15 14:45:00	t	АВ-2023-0002
3	3	55.758912	37.619876	Столкновение при перестроении	2023-03-20 17:20:00	f	АВ-2023-0003
4	4	55.751234	37.618765	Наезд на пешехода	2023-04-05 09:10:00	t	АВ-2023-0004
5	5	55.759876	37.615432	Заднее столкновение	2023-05-12 16:30:00	t	АВ-2023-0005
6	6	55.753456	37.614321	Съезд с дороги	2023-06-18 22:15:00	f	АВ-2023-0006
7	7	55.756789	37.612345	Столкновение на парковке	2023-07-25 11:50:00	t	АВ-2023-0007
8	8	55.754321	37.616789	Опрокидывание ТС	2023-08-30 19:40:00	t	АВ-2023-0008
9	9	55.757654	37.613456	Наезд на велосипедиста	2023-09-05 13:25:00	f	АВ-2023-0009
10	10	55.752345	37.615678	Столкновение с животным	2023-10-10 07:15:00	f	АВ-2023-0010
\.


--
-- TOC entry 5001 (class 0 OID 17237)
-- Dependencies: 221
-- Data for Name: Инспектор; Type: TABLE DATA; Schema: ГИБДД; Owner: postgres
--

COPY "ГИБДД"."Инспектор" ("id_инспектора", "Личный_номер_инспектора", "ФИО", "Звание") FROM stdin;
1	1001	Соколов Александр Васильевич	Капитан полиции
2	1002	Орлова Наталья Ивановна	Майор полиции
3	1003	Лебедев Михаил Сергеевич	Старший лейтенант полиции
4	1004	Громов Денис Петрович	Лейтенант полиции
5	1005	Воробьева Татьяна Алексеевна	Старший сержант полиции
6	1006	Зайцев Игорь Владимирович	Сержант полиции
7	1007	Белова Екатерина Андреевна	Младший сержант полиции
8	1008	Морозов Артем Дмитриевич	Старший лейтенант полиции
9	1009	Ковалева Юлия Сергеевна	Капитан полиции
10	1010	Новиков Павел Игоревич	Майор полиции
\.


--
-- TOC entry 5005 (class 0 OID 17261)
-- Dependencies: 225
-- Data for Name: Нарушения_ПДД; Type: TABLE DATA; Schema: ГИБДД; Owner: postgres
--

COPY "ГИБДД"."Нарушения_ПДД" ("Код_нарушения", "Вид_нарушения", "Описание_нарушения") FROM stdin;
1	Превышение скорости	Превышение установленной скорости движения ТС на величину от 20 до 40 км/ч
2	Проезд на красный свет	Проезд на запрещающий сигнал светофора
3	Непредоставление преимущества	Непредоставление преимущества в движении пешеходам или иным участникам дорожного движения
4	Нарушение правил стоянки	Стоянка в неположенном месте
5	Управление ТС в состоянии опьянения	Управление ТС в состоянии алкогольного или наркотического опьянения
6	Отсутствие страховки	Управление ТС без полиса ОСАГО
7	Непристегнутый ремень	Управление ТС водителем, не пристегнутым ремнем безопасности
8	Телефон за рулем	Использование телефона во время движения без hands-free
9	Несоблюдение дистанции	Несоблюдение безопасной дистанции до движущегося впереди ТС
10	Неисправности ТС	Управление ТС с неисправностями, при которых эксплуатация запрещена
\.


--
-- TOC entry 5011 (class 0 OID 17288)
-- Dependencies: 231
-- Data for Name: Период_владения; Type: TABLE DATA; Schema: ГИБДД; Owner: postgres
--

COPY "ГИБДД"."Период_владения" ("id_ПерВлад", "id_ТС", "id_Владельца", "Владение_с", "Владение_по") FROM stdin;
1	1	1	2018-05-15	\N
2	2	2	2019-03-20	\N
3	3	3	2017-11-10	2020-06-01
4	3	4	2020-06-01	\N
5	4	5	2020-02-25	\N
6	5	6	2016-07-30	2019-12-15
7	5	7	2019-12-15	\N
8	6	8	2019-09-15	\N
9	7	9	2018-12-05	\N
10	8	10	2020-04-10	\N
11	9	1	2017-06-20	2019-08-10
12	9	2	2019-08-10	\N
13	10	3	2019-11-30	\N
14	11	4	2020-01-15	\N
15	12	5	2019-05-20	\N
16	13	6	2018-08-12	\N
\.


--
-- TOC entry 5017 (class 0 OID 17356)
-- Dependencies: 237
-- Data for Name: Регистрация_нарушения; Type: TABLE DATA; Schema: ГИБДД; Owner: postgres
--

COPY "ГИБДД"."Регистрация_нарушения" ("id_нарушения", "id_водителя", "id_инспектора", "id_штрафа", "id_ТС", "Код_нарушения", "Срок_лишения_прав_управления_ТС", "Координаты_нарушения_широта", "Координаты_нарушения_долгота", "Дата_и_время_нарушения") FROM stdin;
1	1	1	1	1	1	\N	55.755825	37.617298	2023-01-05 09:15:00
2	2	2	2	2	2	\N	55.752023	37.617499	2023-02-10 14:30:00
3	3	3	3	3	5	12	55.758912	37.619876	2023-03-15 18:45:00
4	4	4	4	4	3	\N	55.751234	37.618765	2023-04-20 10:20:00
5	5	5	5	5	1	\N	55.759876	37.615432	2023-05-25 16:10:00
6	6	6	6	6	6	\N	55.753456	37.614321	2023-06-30 21:30:00
7	7	7	7	7	7	\N	55.756789	37.612345	2023-07-05 12:40:00
8	8	8	8	8	8	\N	55.754321	37.616789	2023-08-10 20:15:00
9	9	9	9	9	9	\N	55.757654	37.613456	2023-09-15 14:25:00
10	10	10	10	10	10	\N	55.752345	37.615678	2023-10-20 08:05:00
\.


--
-- TOC entry 5003 (class 0 OID 17248)
-- Dependencies: 223
-- Data for Name: Транспортное_средство; Type: TABLE DATA; Schema: ГИБДД; Owner: postgres
--

COPY "ГИБДД"."Транспортное_средство" ("id_ТС", "Дата_регистрации_в_ГИБДД", "Модель_ТС", "Марка_ТС", "Дата_выпуска", "vin_код_ТС", "Номер_ТС", "Категория_ТС") FROM stdin;
1	2018-05-15	Camry	Toyota	2018-01-10	JT2BF22K3W0156789	А123ВВ777	B
2	2019-03-20	Solaris	Hyundai	2019-01-15	Z94CB41BAER123456	О456ТК198	B
3	2017-11-10	Granta	Lada	2017-08-05	XTA219120K1234567	Е789КХ777	B
4	2020-02-25	Rio	Kia	2020-01-10	Z94K241BBLR234567	В321ОС777	B
5	2016-07-30	Focus	Ford	2016-05-12	WF0FXXGCDP5G12345	С654АВ777	B
6	2019-09-15	Vesta	Lada	2019-07-20	XTA219130K2345678	Т987УК777	B
7	2018-12-05	Logan	Renault	2018-10-01	VF1LSD0E482345678	М159ОР777	B
8	2020-04-10	Polo	Volkswagen	2020-03-01	WVWZZZ6RZHY123456	Н753ЕК777	B
9	2017-06-20	Creta	Hyundai	2017-04-15	ZAMCF41BBF1234567	Р258СН777	B
10	2019-11-30	RAV4	Toyota	2019-09-25	JTMBF3DV9KD123456	У951ВМ777	B
11	\N	Ninja 400	Kawasaki	2020-01-15	ML0NNK400FP123456	1234АА96	A
12	\N	GSX-R1000	Suzuki	2019-05-20	JS1GR7KA6A2101234	5678ВМ96	A
13	2018-08-12	Trailer 5T	Knott	2018-06-10	1N9BD26E8YN123456	А12ВВХ	E
\.


--
-- TOC entry 5015 (class 0 OID 17322)
-- Dependencies: 235
-- Data for Name: Участник_ДТП; Type: TABLE DATA; Schema: ГИБДД; Owner: postgres
--

COPY "ГИБДД"."Участник_ДТП" ("id_уДТП", "id_водителя", "id_ДТП", "Роль_участника", "id_ТС") FROM stdin;
14	1	1	Потерпевший	1
15	2	1	Виновник	2
16	3	1	Неопределено	3
\.


--
-- TOC entry 5007 (class 0 OID 17270)
-- Dependencies: 227
-- Data for Name: Штраф; Type: TABLE DATA; Schema: ГИБДД; Owner: postgres
--

COPY "ГИБДД"."Штраф" ("id_штрафа", "Сумма_штрафа", "Размер_оплаты", "Дата_и_время_оплаты", "Статус_оплаты", "Номер_постановления_о_штрафе") FROM stdin;
1	500	Полный	2023-01-15 14:30:00	t	18810123123456789
2	1000	Частичный	2023-02-20 10:15:00	t	18810220123456789
3	5000	Не оплачен	\N	f	18810305123456789
4	1500	Полный	2023-04-10 16:45:00	t	18810410123456789
5	2500	Не оплачен	\N	f	18810515123456789
6	30000	Полный	2023-06-25 09:20:00	t	18810625123456789
7	1000	Частичный	2023-07-30 11:10:00	t	18810730123456789
8	500	Полный	2023-08-05 13:25:00	t	18810805123456789
9	2000	Не оплачен	\N	f	18810910123456789
10	5000	Полный	2023-10-15 15:50:00	t	18811015123456789
\.


--
-- TOC entry 5035 (class 0 OID 0)
-- Dependencies: 228
-- Name: Владелец_id_Владельца_seq; Type: SEQUENCE SET; Schema: ГИБДД; Owner: postgres
--

SELECT pg_catalog.setval('"ГИБДД"."Владелец_id_Владельца_seq"', 10, true);


--
-- TOC entry 5036 (class 0 OID 0)
-- Dependencies: 218
-- Name: Водитель_id_водителя_seq; Type: SEQUENCE SET; Schema: ГИБДД; Owner: postgres
--

SELECT pg_catalog.setval('"ГИБДД"."Водитель_id_водителя_seq"', 11, true);


--
-- TOC entry 5037 (class 0 OID 0)
-- Dependencies: 232
-- Name: ДТП_id_ДТП_seq; Type: SEQUENCE SET; Schema: ГИБДД; Owner: postgres
--

SELECT pg_catalog.setval('"ГИБДД"."ДТП_id_ДТП_seq"', 10, true);


--
-- TOC entry 5038 (class 0 OID 0)
-- Dependencies: 220
-- Name: Инспектор_id_инспектора_seq; Type: SEQUENCE SET; Schema: ГИБДД; Owner: postgres
--

SELECT pg_catalog.setval('"ГИБДД"."Инспектор_id_инспектора_seq"', 10, true);


--
-- TOC entry 5039 (class 0 OID 0)
-- Dependencies: 224
-- Name: Нарушения_ПДД_Код_нарушения_seq; Type: SEQUENCE SET; Schema: ГИБДД; Owner: postgres
--

SELECT pg_catalog.setval('"ГИБДД"."Нарушения_ПДД_Код_нарушения_seq"', 10, true);


--
-- TOC entry 5040 (class 0 OID 0)
-- Dependencies: 230
-- Name: Период_владения_id_ПерВлад_seq; Type: SEQUENCE SET; Schema: ГИБДД; Owner: postgres
--

SELECT pg_catalog.setval('"ГИБДД"."Период_владения_id_ПерВлад_seq"', 16, true);


--
-- TOC entry 5041 (class 0 OID 0)
-- Dependencies: 236
-- Name: Регистрация_нарушен_id_нарушения_seq; Type: SEQUENCE SET; Schema: ГИБДД; Owner: postgres
--

SELECT pg_catalog.setval('"ГИБДД"."Регистрация_нарушен_id_нарушения_seq"', 10, true);


--
-- TOC entry 5042 (class 0 OID 0)
-- Dependencies: 222
-- Name: Транспортное_средство_id_ТС_seq; Type: SEQUENCE SET; Schema: ГИБДД; Owner: postgres
--

SELECT pg_catalog.setval('"ГИБДД"."Транспортное_средство_id_ТС_seq"', 13, true);


--
-- TOC entry 5043 (class 0 OID 0)
-- Dependencies: 234
-- Name: Участник_ДТП_id_уДТП_seq; Type: SEQUENCE SET; Schema: ГИБДД; Owner: postgres
--

SELECT pg_catalog.setval('"ГИБДД"."Участник_ДТП_id_уДТП_seq"', 16, true);


--
-- TOC entry 5044 (class 0 OID 0)
-- Dependencies: 226
-- Name: Штраф_id_штрафа_seq; Type: SEQUENCE SET; Schema: ГИБДД; Owner: postgres
--

SELECT pg_catalog.setval('"ГИБДД"."Штраф_id_штрафа_seq"', 10, true);


--
-- TOC entry 4833 (class 2606 OID 17286)
-- Name: Владелец Владелец_pkey; Type: CONSTRAINT; Schema: ГИБДД; Owner: postgres
--

ALTER TABLE ONLY "ГИБДД"."Владелец"
    ADD CONSTRAINT "Владелец_pkey" PRIMARY KEY ("id_Владельца");


--
-- TOC entry 4821 (class 2606 OID 17235)
-- Name: Водитель Водитель_pkey; Type: CONSTRAINT; Schema: ГИБДД; Owner: postgres
--

ALTER TABLE ONLY "ГИБДД"."Водитель"
    ADD CONSTRAINT "Водитель_pkey" PRIMARY KEY ("id_водителя");


--
-- TOC entry 4837 (class 2606 OID 17315)
-- Name: ДТП ДТП_pkey; Type: CONSTRAINT; Schema: ГИБДД; Owner: postgres
--

ALTER TABLE ONLY "ГИБДД"."ДТП"
    ADD CONSTRAINT "ДТП_pkey" PRIMARY KEY ("id_ДТП");


--
-- TOC entry 4823 (class 2606 OID 17244)
-- Name: Инспектор Инспектор_pkey; Type: CONSTRAINT; Schema: ГИБДД; Owner: postgres
--

ALTER TABLE ONLY "ГИБДД"."Инспектор"
    ADD CONSTRAINT "Инспектор_pkey" PRIMARY KEY ("id_инспектора");


--
-- TOC entry 4825 (class 2606 OID 17246)
-- Name: Инспектор Инспектор_Личный_номер_инспекто_key; Type: CONSTRAINT; Schema: ГИБДД; Owner: postgres
--

ALTER TABLE ONLY "ГИБДД"."Инспектор"
    ADD CONSTRAINT "Инспектор_Личный_номер_инспекто_key" UNIQUE ("Личный_номер_инспектора");


--
-- TOC entry 4829 (class 2606 OID 17268)
-- Name: Нарушения_ПДД Нарушения_ПДД_pkey; Type: CONSTRAINT; Schema: ГИБДД; Owner: postgres
--

ALTER TABLE ONLY "ГИБДД"."Нарушения_ПДД"
    ADD CONSTRAINT "Нарушения_ПДД_pkey" PRIMARY KEY ("Код_нарушения");


--
-- TOC entry 4835 (class 2606 OID 17295)
-- Name: Период_владения Период_владения_pkey; Type: CONSTRAINT; Schema: ГИБДД; Owner: postgres
--

ALTER TABLE ONLY "ГИБДД"."Период_владения"
    ADD CONSTRAINT "Период_владения_pkey" PRIMARY KEY ("id_ПерВлад");


--
-- TOC entry 4841 (class 2606 OID 17362)
-- Name: Регистрация_нарушения Регистрация_нарушения_pkey; Type: CONSTRAINT; Schema: ГИБДД; Owner: postgres
--

ALTER TABLE ONLY "ГИБДД"."Регистрация_нарушения"
    ADD CONSTRAINT "Регистрация_нарушения_pkey" PRIMARY KEY ("id_нарушения");


--
-- TOC entry 4827 (class 2606 OID 17259)
-- Name: Транспортное_средство Транспортное_средство_pkey; Type: CONSTRAINT; Schema: ГИБДД; Owner: postgres
--

ALTER TABLE ONLY "ГИБДД"."Транспортное_средство"
    ADD CONSTRAINT "Транспортное_средство_pkey" PRIMARY KEY ("id_ТС");


--
-- TOC entry 4839 (class 2606 OID 17327)
-- Name: Участник_ДТП Участник_ДТП_pkey; Type: CONSTRAINT; Schema: ГИБДД; Owner: postgres
--

ALTER TABLE ONLY "ГИБДД"."Участник_ДТП"
    ADD CONSTRAINT "Участник_ДТП_pkey" PRIMARY KEY ("id_уДТП");


--
-- TOC entry 4831 (class 2606 OID 17277)
-- Name: Штраф Штраф_pkey; Type: CONSTRAINT; Schema: ГИБДД; Owner: postgres
--

ALTER TABLE ONLY "ГИБДД"."Штраф"
    ADD CONSTRAINT "Штраф_pkey" PRIMARY KEY ("id_штрафа");


--
-- TOC entry 4844 (class 2606 OID 17316)
-- Name: ДТП ДТП_id_инспектора_fkey; Type: FK CONSTRAINT; Schema: ГИБДД; Owner: postgres
--

ALTER TABLE ONLY "ГИБДД"."ДТП"
    ADD CONSTRAINT "ДТП_id_инспектора_fkey" FOREIGN KEY ("id_инспектора") REFERENCES "ГИБДД"."Инспектор"("id_инспектора");


--
-- TOC entry 4842 (class 2606 OID 17301)
-- Name: Период_владения Период_владения_id_Владельца_fkey; Type: FK CONSTRAINT; Schema: ГИБДД; Owner: postgres
--

ALTER TABLE ONLY "ГИБДД"."Период_владения"
    ADD CONSTRAINT "Период_владения_id_Владельца_fkey" FOREIGN KEY ("id_Владельца") REFERENCES "ГИБДД"."Владелец"("id_Владельца");


--
-- TOC entry 4843 (class 2606 OID 17296)
-- Name: Период_владения Период_владения_id_ТС_fkey; Type: FK CONSTRAINT; Schema: ГИБДД; Owner: postgres
--

ALTER TABLE ONLY "ГИБДД"."Период_владения"
    ADD CONSTRAINT "Период_владения_id_ТС_fkey" FOREIGN KEY ("id_ТС") REFERENCES "ГИБДД"."Транспортное_средство"("id_ТС");


--
-- TOC entry 4848 (class 2606 OID 17383)
-- Name: Регистрация_нарушения Регистрация_нару_Код_нарушения_fkey; Type: FK CONSTRAINT; Schema: ГИБДД; Owner: postgres
--

ALTER TABLE ONLY "ГИБДД"."Регистрация_нарушения"
    ADD CONSTRAINT "Регистрация_нару_Код_нарушения_fkey" FOREIGN KEY ("Код_нарушения") REFERENCES "ГИБДД"."Нарушения_ПДД"("Код_нарушения");


--
-- TOC entry 4849 (class 2606 OID 17368)
-- Name: Регистрация_нарушения Регистрация_наруш_id_инспектора_fkey; Type: FK CONSTRAINT; Schema: ГИБДД; Owner: postgres
--

ALTER TABLE ONLY "ГИБДД"."Регистрация_нарушения"
    ADD CONSTRAINT "Регистрация_наруш_id_инспектора_fkey" FOREIGN KEY ("id_инспектора") REFERENCES "ГИБДД"."Инспектор"("id_инспектора");


--
-- TOC entry 4850 (class 2606 OID 17363)
-- Name: Регистрация_нарушения Регистрация_нарушен_id_водителя_fkey; Type: FK CONSTRAINT; Schema: ГИБДД; Owner: postgres
--

ALTER TABLE ONLY "ГИБДД"."Регистрация_нарушения"
    ADD CONSTRAINT "Регистрация_нарушен_id_водителя_fkey" FOREIGN KEY ("id_водителя") REFERENCES "ГИБДД"."Водитель"("id_водителя");


--
-- TOC entry 4851 (class 2606 OID 17378)
-- Name: Регистрация_нарушения Регистрация_нарушения_id_ТС_fkey; Type: FK CONSTRAINT; Schema: ГИБДД; Owner: postgres
--

ALTER TABLE ONLY "ГИБДД"."Регистрация_нарушения"
    ADD CONSTRAINT "Регистрация_нарушения_id_ТС_fkey" FOREIGN KEY ("id_ТС") REFERENCES "ГИБДД"."Транспортное_средство"("id_ТС");


--
-- TOC entry 4852 (class 2606 OID 17373)
-- Name: Регистрация_нарушения Регистрация_нарушения_id_штрафа_fkey; Type: FK CONSTRAINT; Schema: ГИБДД; Owner: postgres
--

ALTER TABLE ONLY "ГИБДД"."Регистрация_нарушения"
    ADD CONSTRAINT "Регистрация_нарушения_id_штрафа_fkey" FOREIGN KEY ("id_штрафа") REFERENCES "ГИБДД"."Штраф"("id_штрафа");


--
-- TOC entry 4845 (class 2606 OID 17333)
-- Name: Участник_ДТП Участник_ДТП_id_ДТП_fkey; Type: FK CONSTRAINT; Schema: ГИБДД; Owner: postgres
--

ALTER TABLE ONLY "ГИБДД"."Участник_ДТП"
    ADD CONSTRAINT "Участник_ДТП_id_ДТП_fkey" FOREIGN KEY ("id_ДТП") REFERENCES "ГИБДД"."ДТП"("id_ДТП");


--
-- TOC entry 4846 (class 2606 OID 25622)
-- Name: Участник_ДТП Участник_ДТП_id_ТС; Type: FK CONSTRAINT; Schema: ГИБДД; Owner: postgres
--

ALTER TABLE ONLY "ГИБДД"."Участник_ДТП"
    ADD CONSTRAINT "Участник_ДТП_id_ТС" FOREIGN KEY ("id_ТС") REFERENCES "ГИБДД"."Транспортное_средство"("id_ТС") NOT VALID;


--
-- TOC entry 4847 (class 2606 OID 17328)
-- Name: Участник_ДТП Участник_ДТП_id_водителя_fkey; Type: FK CONSTRAINT; Schema: ГИБДД; Owner: postgres
--

ALTER TABLE ONLY "ГИБДД"."Участник_ДТП"
    ADD CONSTRAINT "Участник_ДТП_id_водителя_fkey" FOREIGN KEY ("id_водителя") REFERENCES "ГИБДД"."Водитель"("id_водителя");


-- Completed on 2025-04-03 16:03:47

--
-- PostgreSQL database dump complete
--

