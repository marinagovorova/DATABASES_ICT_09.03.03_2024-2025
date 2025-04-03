--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4
-- Dumped by pg_dump version 17.4

-- Started on 2025-04-02 18:59:41

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
-- TOC entry 5014 (class 1262 OID 16390)
-- Name: laba1; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE laba1 WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'be-BY';


ALTER DATABASE laba1 OWNER TO postgres;

\connect laba1

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
-- TOC entry 6 (class 2615 OID 16970)
-- Name: laba1_schema; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA laba1_schema;


ALTER SCHEMA laba1_schema OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 218 (class 1259 OID 16971)
-- Name: Аудитория; Type: TABLE; Schema: laba1_schema; Owner: postgres
--

CREATE TABLE laba1_schema."Аудитория" (
    "номер_аудитории" character varying(5) NOT NULL,
    "код_подразделения" character varying(18),
    "id_тип_аудитории" integer NOT NULL,
    "id_корпуса" integer NOT NULL
);


ALTER TABLE laba1_schema."Аудитория" OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16974)
-- Name: Виды_итоговой_аттестации; Type: TABLE; Schema: laba1_schema; Owner: postgres
--

CREATE TABLE laba1_schema."Виды_итоговой_аттестации" (
    "код_видов_итог_аттестации" character varying(20) NOT NULL,
    "название" character varying(50)
);


ALTER TABLE laba1_schema."Виды_итоговой_аттестации" OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16977)
-- Name: Группа; Type: TABLE; Schema: laba1_schema; Owner: postgres
--

CREATE TABLE laba1_schema."Группа" (
    "id_группы" integer NOT NULL,
    "код_учебного_плана" character varying(8) NOT NULL,
    "номер_группы" character varying(6)
);


ALTER TABLE laba1_schema."Группа" OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16980)
-- Name: Дисциплна; Type: TABLE; Schema: laba1_schema; Owner: postgres
--

CREATE TABLE laba1_schema."Дисциплна" (
    "Код_дисциплины" character varying(20) NOT NULL,
    "название" character varying(50),
    "колво_часов" integer
);


ALTER TABLE laba1_schema."Дисциплна" OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16983)
-- Name: Документ_об_окончании; Type: TABLE; Schema: laba1_schema; Owner: postgres
--

CREATE TABLE laba1_schema."Документ_об_окончании" (
    "id_документа" integer NOT NULL,
    "id_слушателя" integer NOT NULL,
    "номер_документа" character varying(10),
    "дата_выдачи" date,
    "колво_часов" integer,
    "код_программы" character varying(8),
    "id_типа" integer
);


ALTER TABLE laba1_schema."Документ_об_окончании" OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16986)
-- Name: Должность; Type: TABLE; Schema: laba1_schema; Owner: postgres
--

CREATE TABLE laba1_schema."Должность" (
    "id_должности" integer NOT NULL,
    "название" character varying(20)
);


ALTER TABLE laba1_schema."Должность" OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 16989)
-- Name: Занятие; Type: TABLE; Schema: laba1_schema; Owner: postgres
--

CREATE TABLE laba1_schema."Занятие" (
    "id_занятия" integer NOT NULL,
    "id_препода" integer NOT NULL,
    "код_дисциплины" character varying(20) NOT NULL,
    "номер_аудитории" character varying(5),
    "тип_занятия" character varying(15),
    "дата_занятия" date NOT NULL,
    "id_группы" integer NOT NULL
);


ALTER TABLE laba1_schema."Занятие" OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16992)
-- Name: История_должностей; Type: TABLE; Schema: laba1_schema; Owner: postgres
--

CREATE TABLE laba1_schema."История_должностей" (
    "id_истории_должностей" integer NOT NULL,
    "id_препода" integer NOT NULL,
    "id_должности" integer NOT NULL,
    "дата_с" date,
    "дата_по" date
);


ALTER TABLE laba1_schema."История_должностей" OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 16995)
-- Name: Корпус; Type: TABLE; Schema: laba1_schema; Owner: postgres
--

CREATE TABLE laba1_schema."Корпус" (
    "id_корпуса" integer NOT NULL,
    "название" character varying(20)
);


ALTER TABLE laba1_schema."Корпус" OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 16998)
-- Name: Образовательная_программа; Type: TABLE; Schema: laba1_schema; Owner: postgres
--

CREATE TABLE laba1_schema."Образовательная_программа" (
    "код_образовательной_программы" character varying(20) NOT NULL,
    "код_типа_программы" character varying(20) NOT NULL,
    "код_подразделения" character varying(18) NOT NULL,
    "название" character varying(60)
);


ALTER TABLE laba1_schema."Образовательная_программа" OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 17001)
-- Name: Подразделение; Type: TABLE; Schema: laba1_schema; Owner: postgres
--

CREATE TABLE laba1_schema."Подразделение" (
    "код_подразделения" character varying(18) NOT NULL,
    "название" character varying(20)
);


ALTER TABLE laba1_schema."Подразделение" OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 17004)
-- Name: Преподаватель; Type: TABLE; Schema: laba1_schema; Owner: postgres
--

CREATE TABLE laba1_schema."Преподаватель" (
    "id_препода" integer NOT NULL,
    "ФИО" character varying(60)
);


ALTER TABLE laba1_schema."Преподаватель" OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 17007)
-- Name: Слушатель; Type: TABLE; Schema: laba1_schema; Owner: postgres
--

CREATE TABLE laba1_schema."Слушатель" (
    "id_слушателя" integer NOT NULL,
    "ФИО" character varying(60),
    "Паспорт_данные" character varying(20),
    "Электр_почта" character varying(20)
);


ALTER TABLE laba1_schema."Слушатель" OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 17010)
-- Name: Состав_группы; Type: TABLE; Schema: laba1_schema; Owner: postgres
--

CREATE TABLE laba1_schema."Состав_группы" (
    "id_записи" integer NOT NULL,
    "id_группы" integer NOT NULL,
    "id_слушателя" integer NOT NULL,
    "дата_нач_обуч" date,
    "дата_оконч_обуч" date
);


ALTER TABLE laba1_schema."Состав_группы" OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 17013)
-- Name: Состав_учебного_плана; Type: TABLE; Schema: laba1_schema; Owner: postgres
--

CREATE TABLE laba1_schema."Состав_учебного_плана" (
    "код_состава_учебного_плана" character varying(20) NOT NULL,
    "код_видов_итог_аттестации" character varying(8) NOT NULL,
    "код_учебного_плана" character varying(8) NOT NULL,
    "код_дисциплины" character varying(20) NOT NULL
);


ALTER TABLE laba1_schema."Состав_учебного_плана" OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 17016)
-- Name: Тип_аудитории; Type: TABLE; Schema: laba1_schema; Owner: postgres
--

CREATE TABLE laba1_schema."Тип_аудитории" (
    "id_тип_аудитории" integer NOT NULL,
    "название_типа" character varying(50)
);


ALTER TABLE laba1_schema."Тип_аудитории" OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 17019)
-- Name: Тип_док_об_окончании; Type: TABLE; Schema: laba1_schema; Owner: postgres
--

CREATE TABLE laba1_schema."Тип_док_об_окончании" (
    "id_типа" integer NOT NULL,
    "тип_документа" integer
);


ALTER TABLE laba1_schema."Тип_док_об_окончании" OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 17022)
-- Name: Тип_программы; Type: TABLE; Schema: laba1_schema; Owner: postgres
--

CREATE TABLE laba1_schema."Тип_программы" (
    "код_типа_программы" character varying(20) NOT NULL,
    "название" character varying(60)
);


ALTER TABLE laba1_schema."Тип_программы" OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 17025)
-- Name: Учебный_план; Type: TABLE; Schema: laba1_schema; Owner: postgres
--

CREATE TABLE laba1_schema."Учебный_план" (
    "Код_учебного_плана" character varying(8) NOT NULL,
    "название" character varying(60),
    "специальность" character varying(10),
    "код_образовательно_программы" character varying(20) NOT NULL
);


ALTER TABLE laba1_schema."Учебный_план" OWNER TO postgres;

--
-- TOC entry 4990 (class 0 OID 16971)
-- Dependencies: 218
-- Data for Name: Аудитория; Type: TABLE DATA; Schema: laba1_schema; Owner: postgres
--



--
-- TOC entry 4991 (class 0 OID 16974)
-- Dependencies: 219
-- Data for Name: Виды_итоговой_аттестации; Type: TABLE DATA; Schema: laba1_schema; Owner: postgres
--



--
-- TOC entry 4992 (class 0 OID 16977)
-- Dependencies: 220
-- Data for Name: Группа; Type: TABLE DATA; Schema: laba1_schema; Owner: postgres
--



--
-- TOC entry 4993 (class 0 OID 16980)
-- Dependencies: 221
-- Data for Name: Дисциплна; Type: TABLE DATA; Schema: laba1_schema; Owner: postgres
--



--
-- TOC entry 4994 (class 0 OID 16983)
-- Dependencies: 222
-- Data for Name: Документ_об_окончании; Type: TABLE DATA; Schema: laba1_schema; Owner: postgres
--



--
-- TOC entry 4995 (class 0 OID 16986)
-- Dependencies: 223
-- Data for Name: Должность; Type: TABLE DATA; Schema: laba1_schema; Owner: postgres
--



--
-- TOC entry 4996 (class 0 OID 16989)
-- Dependencies: 224
-- Data for Name: Занятие; Type: TABLE DATA; Schema: laba1_schema; Owner: postgres
--



--
-- TOC entry 4997 (class 0 OID 16992)
-- Dependencies: 225
-- Data for Name: История_должностей; Type: TABLE DATA; Schema: laba1_schema; Owner: postgres
--



--
-- TOC entry 4998 (class 0 OID 16995)
-- Dependencies: 226
-- Data for Name: Корпус; Type: TABLE DATA; Schema: laba1_schema; Owner: postgres
--



--
-- TOC entry 4999 (class 0 OID 16998)
-- Dependencies: 227
-- Data for Name: Образовательная_программа; Type: TABLE DATA; Schema: laba1_schema; Owner: postgres
--



--
-- TOC entry 5000 (class 0 OID 17001)
-- Dependencies: 228
-- Data for Name: Подразделение; Type: TABLE DATA; Schema: laba1_schema; Owner: postgres
--



--
-- TOC entry 5001 (class 0 OID 17004)
-- Dependencies: 229
-- Data for Name: Преподаватель; Type: TABLE DATA; Schema: laba1_schema; Owner: postgres
--



--
-- TOC entry 5002 (class 0 OID 17007)
-- Dependencies: 230
-- Data for Name: Слушатель; Type: TABLE DATA; Schema: laba1_schema; Owner: postgres
--



--
-- TOC entry 5003 (class 0 OID 17010)
-- Dependencies: 231
-- Data for Name: Состав_группы; Type: TABLE DATA; Schema: laba1_schema; Owner: postgres
--



--
-- TOC entry 5004 (class 0 OID 17013)
-- Dependencies: 232
-- Data for Name: Состав_учебного_плана; Type: TABLE DATA; Schema: laba1_schema; Owner: postgres
--



--
-- TOC entry 5005 (class 0 OID 17016)
-- Dependencies: 233
-- Data for Name: Тип_аудитории; Type: TABLE DATA; Schema: laba1_schema; Owner: postgres
--



--
-- TOC entry 5006 (class 0 OID 17019)
-- Dependencies: 234
-- Data for Name: Тип_док_об_окончании; Type: TABLE DATA; Schema: laba1_schema; Owner: postgres
--



--
-- TOC entry 5007 (class 0 OID 17022)
-- Dependencies: 235
-- Data for Name: Тип_программы; Type: TABLE DATA; Schema: laba1_schema; Owner: postgres
--



--
-- TOC entry 5008 (class 0 OID 17025)
-- Dependencies: 236
-- Data for Name: Учебный_план; Type: TABLE DATA; Schema: laba1_schema; Owner: postgres
--



--
-- TOC entry 4719 (class 2606 OID 40975)
-- Name: Слушатель CHECK FIO_Slyshatel; Type: CHECK CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE laba1_schema."Слушатель"
    ADD CONSTRAINT "CHECK FIO_Slyshatel" CHECK ((("ФИО")::text ~ '^[A-ZА-ЯЁ][a-zа-яё]+ [A-ZА-ЯЁ][a-zа-яё]+$'::text)) NOT VALID;


--
-- TOC entry 4718 (class 2606 OID 40976)
-- Name: Преподаватель CHECK FIO_prepod; Type: CHECK CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE laba1_schema."Преподаватель"
    ADD CONSTRAINT "CHECK FIO_prepod" CHECK ((("ФИО")::text ~ '^[A-ZА-ЯЁ][a-zа-яё]+ [A-ZА-ЯЁ][a-zа-яё]+$'::text)) NOT VALID;


--
-- TOC entry 4722 (class 2606 OID 40966)
-- Name: Состав_группы CHECK data_finish; Type: CHECK CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE laba1_schema."Состав_группы"
    ADD CONSTRAINT "CHECK data_finish" CHECK (("дата_оконч_обуч" > "дата_нач_обуч")) NOT VALID;


--
-- TOC entry 4716 (class 2606 OID 40972)
-- Name: История_должностей CHECK data_po; Type: CHECK CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE laba1_schema."История_должностей"
    ADD CONSTRAINT "CHECK data_po" CHECK (("дата_по" >= "дата_с")) NOT VALID;


--
-- TOC entry 4717 (class 2606 OID 40971)
-- Name: История_должностей CHECK data_s; Type: CHECK CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE laba1_schema."История_должностей"
    ADD CONSTRAINT "CHECK data_s" CHECK (("дата_с" > '1900-01-01'::date)) NOT VALID;


--
-- TOC entry 4723 (class 2606 OID 40965)
-- Name: Состав_группы CHECK data_start; Type: CHECK CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE laba1_schema."Состав_группы"
    ADD CONSTRAINT "CHECK data_start" CHECK (("дата_нач_обуч" > '1900-01-01'::date)) NOT VALID;


--
-- TOC entry 4713 (class 2606 OID 40969)
-- Name: Документ_об_окончании CHECK data_vidachi; Type: CHECK CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE laba1_schema."Документ_об_окончании"
    ADD CONSTRAINT "CHECK data_vidachi" CHECK (("дата_выдачи" > '1900-01-01'::date)) NOT VALID;


--
-- TOC entry 4720 (class 2606 OID 40973)
-- Name: Слушатель CHECK email; Type: CHECK CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE laba1_schema."Слушатель"
    ADD CONSTRAINT "CHECK email" CHECK ((("Электр_почта")::text ~ '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'::text)) NOT VALID;


--
-- TOC entry 4714 (class 2606 OID 40970)
-- Name: Документ_об_окончании CHECK kolicchestvo_hours; Type: CHECK CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE laba1_schema."Документ_об_окончании"
    ADD CONSTRAINT "CHECK kolicchestvo_hours" CHECK (("колво_часов" > 0)) NOT VALID;


--
-- TOC entry 4715 (class 2606 OID 40967)
-- Name: Документ_об_окончании CHECK number_dokument; Type: CHECK CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE laba1_schema."Документ_об_окончании"
    ADD CONSTRAINT "CHECK number_dokument" CHECK ((("номер_документа")::integer > 0)) NOT VALID;


--
-- TOC entry 4721 (class 2606 OID 40974)
-- Name: Слушатель CHECK passport; Type: CHECK CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE laba1_schema."Слушатель"
    ADD CONSTRAINT "CHECK passport" CHECK ((("Паспорт_данные")::text ~ '^\d{4} \d{6}$'::text)) NOT VALID;


--
-- TOC entry 4781 (class 2606 OID 32794)
-- Name: Преподаватель UNIQUE FIO; Type: CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Преподаватель"
    ADD CONSTRAINT "UNIQUE FIO" UNIQUE ("ФИО");


--
-- TOC entry 4763 (class 2606 OID 32826)
-- Name: Корпус UNIQUE ID korpusa; Type: CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Корпус"
    ADD CONSTRAINT "UNIQUE ID korpusa" UNIQUE ("id_корпуса");


--
-- TOC entry 4803 (class 2606 OID 32830)
-- Name: Тип_аудитории UNIQUE ID type auditorii; Type: CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Тип_аудитории"
    ADD CONSTRAINT "UNIQUE ID type auditorii" UNIQUE ("id_тип_аудитории");


--
-- TOC entry 4795 (class 2606 OID 32834)
-- Name: Состав_группы UNIQUE ID zapisi; Type: CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Состав_группы"
    ADD CONSTRAINT "UNIQUE ID zapisi" UNIQUE ("id_записи");


--
-- TOC entry 4749 (class 2606 OID 32818)
-- Name: Должность UNIQUE ID_dolzhnosti; Type: CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Должность"
    ADD CONSTRAINT "UNIQUE ID_dolzhnosti" UNIQUE ("id_должности");


--
-- TOC entry 4759 (class 2606 OID 32816)
-- Name: История_должностей UNIQUE ID_history_dolzhnoctey; Type: CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."История_должностей"
    ADD CONSTRAINT "UNIQUE ID_history_dolzhnoctey" UNIQUE ("id_истории_должностей");


--
-- TOC entry 4783 (class 2606 OID 32796)
-- Name: Преподаватель UNIQUE ID_prepod; Type: CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Преподаватель"
    ADD CONSTRAINT "UNIQUE ID_prepod" UNIQUE ("id_препода");


--
-- TOC entry 4787 (class 2606 OID 32804)
-- Name: Слушатель UNIQUE ID_slyshatel; Type: CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Слушатель"
    ADD CONSTRAINT "UNIQUE ID_slyshatel" UNIQUE ("id_слушателя");


--
-- TOC entry 4809 (class 2606 OID 32808)
-- Name: Тип_док_об_окончании UNIQUE ID_tipa; Type: CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Тип_док_об_окончании"
    ADD CONSTRAINT "UNIQUE ID_tipa" UNIQUE ("id_типа");


--
-- TOC entry 4739 (class 2606 OID 32786)
-- Name: Дисциплна UNIQUE Kod disciplin; Type: CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Дисциплна"
    ADD CONSTRAINT "UNIQUE Kod disciplin" UNIQUE ("Код_дисциплины");


--
-- TOC entry 4769 (class 2606 OID 32782)
-- Name: Образовательная_программа UNIQUE Nazvanie; Type: CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Образовательная_программа"
    ADD CONSTRAINT "UNIQUE Nazvanie" UNIQUE ("название");


--
-- TOC entry 4789 (class 2606 OID 32800)
-- Name: Слушатель UNIQUE Passport; Type: CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Слушатель"
    ADD CONSTRAINT "UNIQUE Passport" UNIQUE ("Паспорт_данные");


--
-- TOC entry 4791 (class 2606 OID 32802)
-- Name: Слушатель UNIQUE email; Type: CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Слушатель"
    ADD CONSTRAINT "UNIQUE email" UNIQUE ("Электр_почта");


--
-- TOC entry 4771 (class 2606 OID 32780)
-- Name: Образовательная_программа UNIQUE kod obraz program; Type: CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Образовательная_программа"
    ADD CONSTRAINT "UNIQUE kod obraz program" UNIQUE ("код_образовательной_программы");


--
-- TOC entry 4819 (class 2606 OID 32773)
-- Name: Учебный_план UNIQUE kod plana; Type: CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Учебный_план"
    ADD CONSTRAINT "UNIQUE kod plana" UNIQUE ("Код_учебного_плана");


--
-- TOC entry 4799 (class 2606 OID 32778)
-- Name: Состав_учебного_плана UNIQUE kod sostava; Type: CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Состав_учебного_плана"
    ADD CONSTRAINT "UNIQUE kod sostava" UNIQUE ("код_состава_учебного_плана");


--
-- TOC entry 4815 (class 2606 OID 32836)
-- Name: Тип_программы UNIQUE kod type programm; Type: CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Тип_программы"
    ADD CONSTRAINT "UNIQUE kod type programm" UNIQUE ("код_типа_программы");


--
-- TOC entry 4729 (class 2606 OID 32822)
-- Name: Виды_итоговой_аттестации UNIQUE kod vidov itog attestacii; Type: CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Виды_итоговой_аттестации"
    ADD CONSTRAINT "UNIQUE kod vidov itog attestacii" UNIQUE ("код_видов_итог_аттестации");


--
-- TOC entry 4775 (class 2606 OID 32812)
-- Name: Подразделение UNIQUE kod_podrazdelenia; Type: CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Подразделение"
    ADD CONSTRAINT "UNIQUE kod_podrazdelenia" UNIQUE ("код_подразделения");


--
-- TOC entry 4751 (class 2606 OID 32820)
-- Name: Должность UNIQUE nazvania dolzhnosti; Type: CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Должность"
    ADD CONSTRAINT "UNIQUE nazvania dolzhnosti" UNIQUE ("название");


--
-- TOC entry 4821 (class 2606 OID 24581)
-- Name: Учебный_план UNIQUE nazvanie; Type: CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Учебный_план"
    ADD CONSTRAINT "UNIQUE nazvanie" UNIQUE ("название");


--
-- TOC entry 4741 (class 2606 OID 32788)
-- Name: Дисциплна UNIQUE nazvanie dis; Type: CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Дисциплна"
    ADD CONSTRAINT "UNIQUE nazvanie dis" UNIQUE ("название");


--
-- TOC entry 4765 (class 2606 OID 32828)
-- Name: Корпус UNIQUE nazvanie korpusa; Type: CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Корпус"
    ADD CONSTRAINT "UNIQUE nazvanie korpusa" UNIQUE ("название");


--
-- TOC entry 4777 (class 2606 OID 32814)
-- Name: Подразделение UNIQUE nazvanie pod; Type: CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Подразделение"
    ADD CONSTRAINT "UNIQUE nazvanie pod" UNIQUE ("название");


--
-- TOC entry 4805 (class 2606 OID 32832)
-- Name: Тип_аудитории UNIQUE nazvanie type; Type: CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Тип_аудитории"
    ADD CONSTRAINT "UNIQUE nazvanie type" UNIQUE ("название_типа");


--
-- TOC entry 4731 (class 2606 OID 32824)
-- Name: Виды_итоговой_аттестации UNIQUE nazvanie vid itogovoi attestacii; Type: CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Виды_итоговой_аттестации"
    ADD CONSTRAINT "UNIQUE nazvanie vid itogovoi attestacii" UNIQUE ("название");


--
-- TOC entry 4725 (class 2606 OID 32798)
-- Name: Аудитория UNIQUE nomer_auditorii; Type: CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Аудитория"
    ADD CONSTRAINT "UNIQUE nomer_auditorii" UNIQUE ("номер_аудитории");


--
-- TOC entry 4745 (class 2606 OID 32806)
-- Name: Документ_об_окончании UNIQUE nomer_dokumenta; Type: CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Документ_об_окончании"
    ADD CONSTRAINT "UNIQUE nomer_dokumenta" UNIQUE ("номер_документа");


--
-- TOC entry 4735 (class 2606 OID 32792)
-- Name: Группа UNIQUE nomer_group; Type: CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Группа"
    ADD CONSTRAINT "UNIQUE nomer_group" UNIQUE ("номер_группы");


--
-- TOC entry 4811 (class 2606 OID 32810)
-- Name: Тип_док_об_окончании UNIQUE type_documenta; Type: CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Тип_док_об_окончании"
    ADD CONSTRAINT "UNIQUE type_documenta" UNIQUE ("тип_документа");


--
-- TOC entry 4755 (class 2606 OID 32790)
-- Name: Занятие UNIQUE zaniatia; Type: CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Занятие"
    ADD CONSTRAINT "UNIQUE zaniatia" UNIQUE ("id_занятия");


--
-- TOC entry 4727 (class 2606 OID 17029)
-- Name: Аудитория Аудитория_pkey; Type: CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Аудитория"
    ADD CONSTRAINT "Аудитория_pkey" PRIMARY KEY ("номер_аудитории");


--
-- TOC entry 4733 (class 2606 OID 17031)
-- Name: Виды_итоговой_аттестации Виды_итоговой_аттестации_pkey; Type: CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Виды_итоговой_аттестации"
    ADD CONSTRAINT "Виды_итоговой_аттестации_pkey" PRIMARY KEY ("код_видов_итог_аттестации");


--
-- TOC entry 4737 (class 2606 OID 17033)
-- Name: Группа Группа_pkey; Type: CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Группа"
    ADD CONSTRAINT "Группа_pkey" PRIMARY KEY ("id_группы");


--
-- TOC entry 4743 (class 2606 OID 17035)
-- Name: Дисциплна Дисциплна_pkey; Type: CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Дисциплна"
    ADD CONSTRAINT "Дисциплна_pkey" PRIMARY KEY ("Код_дисциплины");


--
-- TOC entry 4747 (class 2606 OID 17037)
-- Name: Документ_об_окончании Документ_об_окончании_pkey; Type: CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Документ_об_окончании"
    ADD CONSTRAINT "Документ_об_окончании_pkey" PRIMARY KEY ("id_документа");


--
-- TOC entry 4753 (class 2606 OID 17039)
-- Name: Должность Должность_pkey; Type: CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Должность"
    ADD CONSTRAINT "Должность_pkey" PRIMARY KEY ("id_должности");


--
-- TOC entry 4757 (class 2606 OID 17041)
-- Name: Занятие Занятие_pkey; Type: CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Занятие"
    ADD CONSTRAINT "Занятие_pkey" PRIMARY KEY ("id_занятия");


--
-- TOC entry 4761 (class 2606 OID 17043)
-- Name: История_должностей История_должностей_pkey; Type: CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."История_должностей"
    ADD CONSTRAINT "История_должностей_pkey" PRIMARY KEY ("id_истории_должностей");


--
-- TOC entry 4767 (class 2606 OID 17045)
-- Name: Корпус Корпус_pkey; Type: CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Корпус"
    ADD CONSTRAINT "Корпус_pkey" PRIMARY KEY ("id_корпуса");


--
-- TOC entry 4773 (class 2606 OID 17047)
-- Name: Образовательная_программа Образовательная_программа_pkey; Type: CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Образовательная_программа"
    ADD CONSTRAINT "Образовательная_программа_pkey" PRIMARY KEY ("код_образовательной_программы");


--
-- TOC entry 4779 (class 2606 OID 17049)
-- Name: Подразделение Подразделение_pkey; Type: CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Подразделение"
    ADD CONSTRAINT "Подразделение_pkey" PRIMARY KEY ("код_подразделения");


--
-- TOC entry 4785 (class 2606 OID 17051)
-- Name: Преподаватель Преподаватель_pkey; Type: CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Преподаватель"
    ADD CONSTRAINT "Преподаватель_pkey" PRIMARY KEY ("id_препода");


--
-- TOC entry 4793 (class 2606 OID 17053)
-- Name: Слушатель Слушатель_pkey; Type: CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Слушатель"
    ADD CONSTRAINT "Слушатель_pkey" PRIMARY KEY ("id_слушателя");


--
-- TOC entry 4797 (class 2606 OID 17055)
-- Name: Состав_группы Состав_группы_pkey; Type: CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Состав_группы"
    ADD CONSTRAINT "Состав_группы_pkey" PRIMARY KEY ("id_записи");


--
-- TOC entry 4801 (class 2606 OID 17057)
-- Name: Состав_учебного_плана Состав_учебного_плана_pkey; Type: CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Состав_учебного_плана"
    ADD CONSTRAINT "Состав_учебного_плана_pkey" PRIMARY KEY ("код_состава_учебного_плана");


--
-- TOC entry 4807 (class 2606 OID 17059)
-- Name: Тип_аудитории Тип_аудитории_pkey; Type: CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Тип_аудитории"
    ADD CONSTRAINT "Тип_аудитории_pkey" PRIMARY KEY ("id_тип_аудитории");


--
-- TOC entry 4813 (class 2606 OID 17061)
-- Name: Тип_док_об_окончании Тип_док_об_окончании_pkey; Type: CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Тип_док_об_окончании"
    ADD CONSTRAINT "Тип_док_об_окончании_pkey" PRIMARY KEY ("id_типа");


--
-- TOC entry 4817 (class 2606 OID 17063)
-- Name: Тип_программы Тип_программы_pkey; Type: CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Тип_программы"
    ADD CONSTRAINT "Тип_программы_pkey" PRIMARY KEY ("код_типа_программы");


--
-- TOC entry 4823 (class 2606 OID 17065)
-- Name: Учебный_план Учебный_план_pkey; Type: CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Учебный_план"
    ADD CONSTRAINT "Учебный_план_pkey" PRIMARY KEY ("Код_учебного_плана");


--
-- TOC entry 4844 (class 2606 OID 17066)
-- Name: Учебный_план FK; Type: FK CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Учебный_план"
    ADD CONSTRAINT "FK" FOREIGN KEY ("код_образовательно_программы") REFERENCES laba1_schema."Образовательная_программа"("код_образовательной_программы") NOT VALID;


--
-- TOC entry 4835 (class 2606 OID 17071)
-- Name: Образовательная_программа Внешний ключ; Type: FK CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Образовательная_программа"
    ADD CONSTRAINT "Внешний ключ" FOREIGN KEY ("код_типа_программы") REFERENCES laba1_schema."Тип_программы"("код_типа_программы") NOT VALID;


--
-- TOC entry 4839 (class 2606 OID 17076)
-- Name: Состав_учебного_плана Внешний ключ; Type: FK CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Состав_учебного_плана"
    ADD CONSTRAINT "Внешний ключ" FOREIGN KEY ("код_видов_итог_аттестации") REFERENCES laba1_schema."Виды_итоговой_аттестации"("код_видов_итог_аттестации") NOT VALID;


--
-- TOC entry 4829 (class 2606 OID 17081)
-- Name: Занятие Внешний ключ; Type: FK CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Занятие"
    ADD CONSTRAINT "Внешний ключ" FOREIGN KEY ("id_препода") REFERENCES laba1_schema."Преподаватель"("id_препода") NOT VALID;


--
-- TOC entry 4824 (class 2606 OID 17086)
-- Name: Аудитория Внешний ключ; Type: FK CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Аудитория"
    ADD CONSTRAINT "Внешний ключ" FOREIGN KEY ("код_подразделения") REFERENCES laba1_schema."Подразделение"("код_подразделения") NOT VALID;


--
-- TOC entry 4842 (class 2606 OID 17091)
-- Name: Тип_аудитории Внешний ключ; Type: FK CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Тип_аудитории"
    ADD CONSTRAINT "Внешний ключ" FOREIGN KEY ("название_типа") REFERENCES laba1_schema."Аудитория"("номер_аудитории") NOT VALID;


--
-- TOC entry 4837 (class 2606 OID 17096)
-- Name: Состав_группы Внешний ключ; Type: FK CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Состав_группы"
    ADD CONSTRAINT "Внешний ключ" FOREIGN KEY ("id_группы") REFERENCES laba1_schema."Группа"("id_группы") NOT VALID;


--
-- TOC entry 4827 (class 2606 OID 17101)
-- Name: Документ_об_окончании Внешний ключ; Type: FK CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Документ_об_окончании"
    ADD CONSTRAINT "Внешний ключ" FOREIGN KEY ("id_слушателя") REFERENCES laba1_schema."Слушатель"("id_слушателя") NOT VALID;


--
-- TOC entry 4843 (class 2606 OID 17106)
-- Name: Тип_док_об_окончании Внешний ключ; Type: FK CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Тип_док_об_окончании"
    ADD CONSTRAINT "Внешний ключ" FOREIGN KEY ("тип_документа") REFERENCES laba1_schema."Документ_об_окончании"("id_документа") NOT VALID;


--
-- TOC entry 4833 (class 2606 OID 17111)
-- Name: История_должностей Внешний ключ; Type: FK CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."История_должностей"
    ADD CONSTRAINT "Внешний ключ" FOREIGN KEY ("id_препода") REFERENCES laba1_schema."Преподаватель"("id_препода") NOT VALID;


--
-- TOC entry 4840 (class 2606 OID 17116)
-- Name: Состав_учебного_плана Внешний ключ 2; Type: FK CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Состав_учебного_плана"
    ADD CONSTRAINT "Внешний ключ 2" FOREIGN KEY ("код_дисциплины") REFERENCES laba1_schema."Дисциплна"("Код_дисциплины") NOT VALID;


--
-- TOC entry 4836 (class 2606 OID 17121)
-- Name: Образовательная_программа Внешний ключ 2; Type: FK CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Образовательная_программа"
    ADD CONSTRAINT "Внешний ключ 2" FOREIGN KEY ("код_подразделения") REFERENCES laba1_schema."Подразделение"("код_подразделения") NOT VALID;


--
-- TOC entry 4830 (class 2606 OID 17126)
-- Name: Занятие Внешний ключ 2; Type: FK CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Занятие"
    ADD CONSTRAINT "Внешний ключ 2" FOREIGN KEY ("код_дисциплины") REFERENCES laba1_schema."Дисциплна"("Код_дисциплины") NOT VALID;


--
-- TOC entry 4825 (class 2606 OID 17131)
-- Name: Аудитория Внешний ключ 2; Type: FK CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Аудитория"
    ADD CONSTRAINT "Внешний ключ 2" FOREIGN KEY ("id_тип_аудитории") REFERENCES laba1_schema."Тип_аудитории"("id_тип_аудитории") NOT VALID;


--
-- TOC entry 4828 (class 2606 OID 17136)
-- Name: Документ_об_окончании Внешний ключ 2; Type: FK CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Документ_об_окончании"
    ADD CONSTRAINT "Внешний ключ 2" FOREIGN KEY ("id_типа") REFERENCES laba1_schema."Тип_док_об_окончании"("id_типа") NOT VALID;


--
-- TOC entry 4834 (class 2606 OID 17141)
-- Name: История_должностей Внешний ключ 2; Type: FK CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."История_должностей"
    ADD CONSTRAINT "Внешний ключ 2" FOREIGN KEY ("id_должности") REFERENCES laba1_schema."Должность"("id_должности") NOT VALID;


--
-- TOC entry 4838 (class 2606 OID 40977)
-- Name: Состав_группы Внешний ключ 2; Type: FK CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Состав_группы"
    ADD CONSTRAINT "Внешний ключ 2" FOREIGN KEY ("id_слушателя") REFERENCES laba1_schema."Слушатель"("id_слушателя") NOT VALID;


--
-- TOC entry 4841 (class 2606 OID 17146)
-- Name: Состав_учебного_плана Внешний ключ 3; Type: FK CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Состав_учебного_плана"
    ADD CONSTRAINT "Внешний ключ 3" FOREIGN KEY ("код_учебного_плана") REFERENCES laba1_schema."Учебный_план"("Код_учебного_плана") NOT VALID;


--
-- TOC entry 4831 (class 2606 OID 17151)
-- Name: Занятие Внешний ключ 3; Type: FK CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Занятие"
    ADD CONSTRAINT "Внешний ключ 3" FOREIGN KEY ("номер_аудитории") REFERENCES laba1_schema."Аудитория"("номер_аудитории") NOT VALID;


--
-- TOC entry 4826 (class 2606 OID 17156)
-- Name: Аудитория Внешний ключ 3; Type: FK CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Аудитория"
    ADD CONSTRAINT "Внешний ключ 3" FOREIGN KEY ("id_корпуса") REFERENCES laba1_schema."Корпус"("id_корпуса") NOT VALID;


--
-- TOC entry 4832 (class 2606 OID 17161)
-- Name: Занятие Внешний ключ 4; Type: FK CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Занятие"
    ADD CONSTRAINT "Внешний ключ 4" FOREIGN KEY ("id_группы") REFERENCES laba1_schema."Группа"("id_группы") NOT VALID;


-- Completed on 2025-04-02 18:59:41

--
-- PostgreSQL database dump complete
--

