--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4
-- Dumped by pg_dump version 17.4

-- Started on 2025-04-02 18:20:30

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
-- TOC entry 5003 (class 1262 OID 16390)
-- Name: courses; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE courses WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'ru-RU';


ALTER DATABASE courses OWNER TO postgres;

\connect courses

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
-- TOC entry 231 (class 1259 OID 16486)
-- Name: Аудитория; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Аудитория" (
    "номер_аудитории" character varying(5)[] NOT NULL,
    "код_подразделения" character varying(18)[],
    "id_тип_аудитории" integer NOT NULL,
    "id_корпуса" integer NOT NULL
);


ALTER TABLE public."Аудитория" OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16432)
-- Name: Виды_итоговой_аттестации; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Виды_итоговой_аттестации" (
    "код_видов_итог_аттестации" character varying(20)[] NOT NULL,
    "название" character varying(50)[]
);


ALTER TABLE public."Виды_итоговой_аттестации" OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16420)
-- Name: Группа; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Группа" (
    "id_группы" integer NOT NULL,
    "код_учебного_плана" character varying(8)[] NOT NULL,
    "номер_группы" character varying(6)[]
);


ALTER TABLE public."Группа" OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 16479)
-- Name: Дисциплина; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Дисциплина" (
    "код_дисциплины" character varying(20)[] NOT NULL,
    "название" character varying(50)[],
    "колво_часов" integer
);


ALTER TABLE public."Дисциплина" OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16446)
-- Name: Документ_об_окончании; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Документ_об_окончании" (
    "id_документа" integer NOT NULL,
    "id_слушателя" integer NOT NULL,
    "номер_документа" character varying(10)[],
    "дата_выдачи" date,
    "колво_часов" integer,
    "код_программы" character varying(8)[],
    "id_типа" integer NOT NULL
);


ALTER TABLE public."Документ_об_окончании" OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 16453)
-- Name: Должность; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Должность" (
    "id_должности" integer NOT NULL,
    "название" character varying(20)[]
);


ALTER TABLE public."Должность" OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 16507)
-- Name: Занятие; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Занятие" (
    "id_занятия" integer NOT NULL,
    "id_препода" integer NOT NULL,
    "код_дисциплины" character varying(20)[] NOT NULL,
    "номер_аудитории" character varying(5)[],
    "тип_занятия" character varying(15)[],
    "дата_занятия" date NOT NULL,
    "id_группы" integer NOT NULL
);


ALTER TABLE public."Занятие" OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 16460)
-- Name: История_должностей; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."История_должностей" (
    "id_истории_должностей" integer NOT NULL,
    "id_препода" integer NOT NULL,
    "id_должности" integer NOT NULL,
    "дата_с" date,
    "дата_по" date
);


ALTER TABLE public."История_должностей" OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 16500)
-- Name: Корпус; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Корпус" (
    "id_корпуса" integer NOT NULL,
    "название" character varying(20)[]
);


ALTER TABLE public."Корпус" OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16406)
-- Name: Образовательная_программа; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Образовательная_программа" (
    "код_образовательной_программы" character varying(20)[] NOT NULL,
    "код_типа_программы" character varying(20)[] NOT NULL,
    "код_подразделения" character varying(18)[] NOT NULL,
    "название" character varying(60)[]
);


ALTER TABLE public."Образовательная_программа" OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 16472)
-- Name: Подразделение; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Подразделение" (
    "код_подразделения" character varying(18)[] NOT NULL,
    "название" character varying(30)[]
);


ALTER TABLE public."Подразделение" OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 16465)
-- Name: Преподаватель; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Преподаватель" (
    "id_препода" integer NOT NULL,
    "фио" character varying(60)[]
);


ALTER TABLE public."Преподаватель" OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16392)
-- Name: Слушатель; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Слушатель" (
    "id_слушателя" integer NOT NULL,
    "ФИО" character varying(60)[],
    "паспорт_данные" character varying(10)[],
    "электр_почта" character varying(20)[]
);


ALTER TABLE public."Слушатель" OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16427)
-- Name: Состав_группы; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Состав_группы" (
    "id_записи" integer NOT NULL,
    "id_группы" integer NOT NULL,
    "id_слушателя" integer NOT NULL,
    "дата_нач_обуч" date,
    "дата_оконч_обуч" date
);


ALTER TABLE public."Состав_группы" OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16413)
-- Name: Состав_учебного_плана; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Состав_учебного_плана" (
    "код_состава_учебного_плана" character varying(20)[] NOT NULL,
    "код_видов_итог_аттестации" character varying(20)[] NOT NULL,
    "код_учебного_плана" character varying(8)[] NOT NULL,
    "код_дисциплины" character varying(20)[] NOT NULL
);


ALTER TABLE public."Состав_учебного_плана" OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 16493)
-- Name: Тип_аудитории; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Тип_аудитории" (
    "id_тип_аудитории" integer NOT NULL,
    "название_типа" character varying(50)[]
);


ALTER TABLE public."Тип_аудитории" OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 16439)
-- Name: Тип_док_об_окончании; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Тип_док_об_окончании" (
    "id_типа" integer NOT NULL,
    "тип_документа" character varying(20)[]
);


ALTER TABLE public."Тип_док_об_окончании" OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 16515)
-- Name: Тип_программы; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Тип_программы" (
    "код_типа_программы" character varying(20)[] NOT NULL,
    "название" character varying(60)[]
);


ALTER TABLE public."Тип_программы" OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16399)
-- Name: Учебный_план; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Учебный_план" (
    "код_учебного_плана" character varying(8)[] NOT NULL,
    "название" character varying(60)[],
    "специальность" character varying(10)[],
    "код_образовательной_программы" character varying(20)[] NOT NULL
);


ALTER TABLE public."Учебный_план" OWNER TO postgres;

--
-- TOC entry 4993 (class 0 OID 16486)
-- Dependencies: 231
-- Data for Name: Аудитория; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4985 (class 0 OID 16432)
-- Dependencies: 223
-- Data for Name: Виды_итоговой_аттестации; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4983 (class 0 OID 16420)
-- Dependencies: 221
-- Data for Name: Группа; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4992 (class 0 OID 16479)
-- Dependencies: 230
-- Data for Name: Дисциплина; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4987 (class 0 OID 16446)
-- Dependencies: 225
-- Data for Name: Документ_об_окончании; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4988 (class 0 OID 16453)
-- Dependencies: 226
-- Data for Name: Должность; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4996 (class 0 OID 16507)
-- Dependencies: 234
-- Data for Name: Занятие; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4989 (class 0 OID 16460)
-- Dependencies: 227
-- Data for Name: История_должностей; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4995 (class 0 OID 16500)
-- Dependencies: 233
-- Data for Name: Корпус; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4981 (class 0 OID 16406)
-- Dependencies: 219
-- Data for Name: Образовательная_программа; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4991 (class 0 OID 16472)
-- Dependencies: 229
-- Data for Name: Подразделение; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4990 (class 0 OID 16465)
-- Dependencies: 228
-- Data for Name: Преподаватель; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4979 (class 0 OID 16392)
-- Dependencies: 217
-- Data for Name: Слушатель; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4984 (class 0 OID 16427)
-- Dependencies: 222
-- Data for Name: Состав_группы; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4982 (class 0 OID 16413)
-- Dependencies: 220
-- Data for Name: Состав_учебного_плана; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4994 (class 0 OID 16493)
-- Dependencies: 232
-- Data for Name: Тип_аудитории; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4986 (class 0 OID 16439)
-- Dependencies: 224
-- Data for Name: Тип_док_об_окончании; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4997 (class 0 OID 16515)
-- Dependencies: 235
-- Data for Name: Тип_программы; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4980 (class 0 OID 16399)
-- Dependencies: 218
-- Data for Name: Учебный_план; Type: TABLE DATA; Schema: public; Owner: postgres
--



-- Completed on 2025-04-02 18:20:30

--
-- PostgreSQL database dump complete
--

