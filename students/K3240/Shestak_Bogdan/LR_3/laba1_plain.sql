--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4
-- Dumped by pg_dump version 17.4

-- Started on 2025-04-14 22:51:41

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
-- TOC entry 5012 (class 1262 OID 16390)
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
-- Name: Auditoria; Type: TABLE; Schema: laba1_schema; Owner: postgres
--

CREATE TABLE laba1_schema."Auditoria" (
    nomer_auditorii character varying(5) NOT NULL,
    kod_podrazdelenia character varying(18),
    id_tip_auditorii integer NOT NULL,
    id_korpusa integer NOT NULL
);


ALTER TABLE laba1_schema."Auditoria" OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16980)
-- Name: Disciplina; Type: TABLE; Schema: laba1_schema; Owner: postgres
--

CREATE TABLE laba1_schema."Disciplina" (
    kod_disciplini character varying(20) NOT NULL,
    name_disciplini character varying(50),
    kolvo_chasov integer
);


ALTER TABLE laba1_schema."Disciplina" OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16983)
-- Name: Document_ob_okonchanii; Type: TABLE; Schema: laba1_schema; Owner: postgres
--

CREATE TABLE laba1_schema."Document_ob_okonchanii" (
    id_documenta integer NOT NULL,
    id_slushatelia integer NOT NULL,
    nomer_documenta character varying(10),
    data_vidachi date,
    kolvo_chasov integer,
    kod_programmi character varying(8),
    id_type integer
);


ALTER TABLE laba1_schema."Document_ob_okonchanii" OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16986)
-- Name: Dolzhnost; Type: TABLE; Schema: laba1_schema; Owner: postgres
--

CREATE TABLE laba1_schema."Dolzhnost" (
    id_dolzhnosti integer NOT NULL,
    name_dolzhnosti character varying(20)
);


ALTER TABLE laba1_schema."Dolzhnost" OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16977)
-- Name: Group; Type: TABLE; Schema: laba1_schema; Owner: postgres
--

CREATE TABLE laba1_schema."Group" (
    id_group integer NOT NULL,
    kod_uchebnogo_plana character varying(8) NOT NULL,
    nomer_group character varying(6)
);


ALTER TABLE laba1_schema."Group" OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16992)
-- Name: History_dolzhnostei; Type: TABLE; Schema: laba1_schema; Owner: postgres
--

CREATE TABLE laba1_schema."History_dolzhnostei" (
    id_history_dolzhnostei integer NOT NULL,
    id_prepoda integer NOT NULL,
    id_dolzhnosti integer NOT NULL,
    data_s date,
    data_po date
);


ALTER TABLE laba1_schema."History_dolzhnostei" OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 16995)
-- Name: Korpus; Type: TABLE; Schema: laba1_schema; Owner: postgres
--

CREATE TABLE laba1_schema."Korpus" (
    id_korpusa integer NOT NULL,
    name_korpusa character varying(20)
);


ALTER TABLE laba1_schema."Korpus" OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 16998)
-- Name: Obrazovatelnaia_programma; Type: TABLE; Schema: laba1_schema; Owner: postgres
--

CREATE TABLE laba1_schema."Obrazovatelnaia_programma" (
    kod_obrazovatelnoi_programmi character varying(20) NOT NULL,
    kod_type_programm character varying(20) NOT NULL,
    kod_podrazdelenia character varying(18) NOT NULL,
    name_prog character varying(60)
);


ALTER TABLE laba1_schema."Obrazovatelnaia_programma" OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 17001)
-- Name: Podrazdelenie; Type: TABLE; Schema: laba1_schema; Owner: postgres
--

CREATE TABLE laba1_schema."Podrazdelenie" (
    kod_podrazdelenie character varying(18) NOT NULL,
    name_pod character varying(20)
);


ALTER TABLE laba1_schema."Podrazdelenie" OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 17004)
-- Name: Prepodavatel; Type: TABLE; Schema: laba1_schema; Owner: postgres
--

CREATE TABLE laba1_schema."Prepodavatel" (
    id_prepoda integer NOT NULL,
    "FIO" character varying(60)
);


ALTER TABLE laba1_schema."Prepodavatel" OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 17007)
-- Name: Slushatel; Type: TABLE; Schema: laba1_schema; Owner: postgres
--

CREATE TABLE laba1_schema."Slushatel" (
    id_slushatelia integer NOT NULL,
    "FIO" character varying(60),
    passport_danie character varying(20),
    email character varying(20)
);


ALTER TABLE laba1_schema."Slushatel" OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 17010)
-- Name: Sostav_group; Type: TABLE; Schema: laba1_schema; Owner: postgres
--

CREATE TABLE laba1_schema."Sostav_group" (
    id_zapisi integer NOT NULL,
    id_group integer NOT NULL,
    id_slushatelia integer NOT NULL,
    data_start_obuch date,
    data_finish_obuch date
);


ALTER TABLE laba1_schema."Sostav_group" OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 17013)
-- Name: Sostav_uchebnogo_plana; Type: TABLE; Schema: laba1_schema; Owner: postgres
--

CREATE TABLE laba1_schema."Sostav_uchebnogo_plana" (
    kod_sostav_uchebnogo_plana character varying(20) NOT NULL,
    kod_vidov_itog_attestacii character varying(8) NOT NULL,
    kod_uchebnogo_plana character varying(8) NOT NULL,
    kod_disciplini character varying(20) NOT NULL
);


ALTER TABLE laba1_schema."Sostav_uchebnogo_plana" OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 17016)
-- Name: Type_auditorii; Type: TABLE; Schema: laba1_schema; Owner: postgres
--

CREATE TABLE laba1_schema."Type_auditorii" (
    id_type_auditorii integer NOT NULL,
    name_type character varying(50)
);


ALTER TABLE laba1_schema."Type_auditorii" OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 17019)
-- Name: Type_docc_ob_okonchanii; Type: TABLE; Schema: laba1_schema; Owner: postgres
--

CREATE TABLE laba1_schema."Type_docc_ob_okonchanii" (
    id_type integer NOT NULL,
    type_documenta integer
);


ALTER TABLE laba1_schema."Type_docc_ob_okonchanii" OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 17022)
-- Name: Type_programm; Type: TABLE; Schema: laba1_schema; Owner: postgres
--

CREATE TABLE laba1_schema."Type_programm" (
    kod_type_programmi character varying(20) NOT NULL,
    name_type_prog character varying(60)
);


ALTER TABLE laba1_schema."Type_programm" OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 17025)
-- Name: Uchebni_plan; Type: TABLE; Schema: laba1_schema; Owner: postgres
--

CREATE TABLE laba1_schema."Uchebni_plan" (
    kod_uchebni_plana character varying(8) NOT NULL,
    name_ucheb_plan character varying(60),
    specialnost character varying(10),
    kod_obrazovatelnoi_programm character varying(20) NOT NULL
);


ALTER TABLE laba1_schema."Uchebni_plan" OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16974)
-- Name: Vidi_itogovoi_atestacii; Type: TABLE; Schema: laba1_schema; Owner: postgres
--

CREATE TABLE laba1_schema."Vidi_itogovoi_atestacii" (
    kod_vidov_itog_attestacii character varying(20) NOT NULL,
    name_itogov character varying(50)
);


ALTER TABLE laba1_schema."Vidi_itogovoi_atestacii" OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 16989)
-- Name: Zaniatie; Type: TABLE; Schema: laba1_schema; Owner: postgres
--

CREATE TABLE laba1_schema."Zaniatie" (
    id_zaniatia integer NOT NULL,
    id_prepoda integer NOT NULL,
    kod_disciplini character varying(20) NOT NULL,
    nomer_auditorii character varying(5),
    type_zaniatia character varying(15),
    data_zaniatia date NOT NULL,
    id_group integer NOT NULL
);


ALTER TABLE laba1_schema."Zaniatie" OWNER TO postgres;

--
-- TOC entry 4988 (class 0 OID 16971)
-- Dependencies: 218
-- Data for Name: Auditoria; Type: TABLE DATA; Schema: laba1_schema; Owner: postgres
--



--
-- TOC entry 4991 (class 0 OID 16980)
-- Dependencies: 221
-- Data for Name: Disciplina; Type: TABLE DATA; Schema: laba1_schema; Owner: postgres
--



--
-- TOC entry 4992 (class 0 OID 16983)
-- Dependencies: 222
-- Data for Name: Document_ob_okonchanii; Type: TABLE DATA; Schema: laba1_schema; Owner: postgres
--



--
-- TOC entry 4993 (class 0 OID 16986)
-- Dependencies: 223
-- Data for Name: Dolzhnost; Type: TABLE DATA; Schema: laba1_schema; Owner: postgres
--



--
-- TOC entry 4990 (class 0 OID 16977)
-- Dependencies: 220
-- Data for Name: Group; Type: TABLE DATA; Schema: laba1_schema; Owner: postgres
--



--
-- TOC entry 4995 (class 0 OID 16992)
-- Dependencies: 225
-- Data for Name: History_dolzhnostei; Type: TABLE DATA; Schema: laba1_schema; Owner: postgres
--



--
-- TOC entry 4996 (class 0 OID 16995)
-- Dependencies: 226
-- Data for Name: Korpus; Type: TABLE DATA; Schema: laba1_schema; Owner: postgres
--



--
-- TOC entry 4997 (class 0 OID 16998)
-- Dependencies: 227
-- Data for Name: Obrazovatelnaia_programma; Type: TABLE DATA; Schema: laba1_schema; Owner: postgres
--



--
-- TOC entry 4998 (class 0 OID 17001)
-- Dependencies: 228
-- Data for Name: Podrazdelenie; Type: TABLE DATA; Schema: laba1_schema; Owner: postgres
--



--
-- TOC entry 4999 (class 0 OID 17004)
-- Dependencies: 229
-- Data for Name: Prepodavatel; Type: TABLE DATA; Schema: laba1_schema; Owner: postgres
--



--
-- TOC entry 5000 (class 0 OID 17007)
-- Dependencies: 230
-- Data for Name: Slushatel; Type: TABLE DATA; Schema: laba1_schema; Owner: postgres
--



--
-- TOC entry 5001 (class 0 OID 17010)
-- Dependencies: 231
-- Data for Name: Sostav_group; Type: TABLE DATA; Schema: laba1_schema; Owner: postgres
--



--
-- TOC entry 5002 (class 0 OID 17013)
-- Dependencies: 232
-- Data for Name: Sostav_uchebnogo_plana; Type: TABLE DATA; Schema: laba1_schema; Owner: postgres
--



--
-- TOC entry 5003 (class 0 OID 17016)
-- Dependencies: 233
-- Data for Name: Type_auditorii; Type: TABLE DATA; Schema: laba1_schema; Owner: postgres
--



--
-- TOC entry 5004 (class 0 OID 17019)
-- Dependencies: 234
-- Data for Name: Type_docc_ob_okonchanii; Type: TABLE DATA; Schema: laba1_schema; Owner: postgres
--



--
-- TOC entry 5005 (class 0 OID 17022)
-- Dependencies: 235
-- Data for Name: Type_programm; Type: TABLE DATA; Schema: laba1_schema; Owner: postgres
--



--
-- TOC entry 5006 (class 0 OID 17025)
-- Dependencies: 236
-- Data for Name: Uchebni_plan; Type: TABLE DATA; Schema: laba1_schema; Owner: postgres
--



--
-- TOC entry 4989 (class 0 OID 16974)
-- Dependencies: 219
-- Data for Name: Vidi_itogovoi_atestacii; Type: TABLE DATA; Schema: laba1_schema; Owner: postgres
--



--
-- TOC entry 4994 (class 0 OID 16989)
-- Dependencies: 224
-- Data for Name: Zaniatie; Type: TABLE DATA; Schema: laba1_schema; Owner: postgres
--



--
-- TOC entry 4725 (class 2606 OID 17029)
-- Name: Auditoria Auditoria_pkey; Type: CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Auditoria"
    ADD CONSTRAINT "Auditoria_pkey" PRIMARY KEY (nomer_auditorii);


--
-- TOC entry 4719 (class 2606 OID 40975)
-- Name: Slushatel CHECK FIO_Slyshatel; Type: CHECK CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE laba1_schema."Slushatel"
    ADD CONSTRAINT "CHECK FIO_Slyshatel" CHECK ((("FIO")::text ~ '^[A-ZА-ЯЁ][a-zа-яё]+ [A-ZА-ЯЁ][a-zа-яё]+$'::text)) NOT VALID;


--
-- TOC entry 4718 (class 2606 OID 40976)
-- Name: Prepodavatel CHECK FIO_prepod; Type: CHECK CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE laba1_schema."Prepodavatel"
    ADD CONSTRAINT "CHECK FIO_prepod" CHECK ((("FIO")::text ~ '^[A-ZА-ЯЁ][a-zа-яё]+ [A-ZА-ЯЁ][a-zа-яё]+$'::text)) NOT VALID;


--
-- TOC entry 4722 (class 2606 OID 40966)
-- Name: Sostav_group CHECK data_finish; Type: CHECK CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE laba1_schema."Sostav_group"
    ADD CONSTRAINT "CHECK data_finish" CHECK ((data_finish_obuch > data_start_obuch)) NOT VALID;


--
-- TOC entry 4716 (class 2606 OID 40972)
-- Name: History_dolzhnostei CHECK data_po; Type: CHECK CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE laba1_schema."History_dolzhnostei"
    ADD CONSTRAINT "CHECK data_po" CHECK ((data_po >= data_s)) NOT VALID;


--
-- TOC entry 4717 (class 2606 OID 40971)
-- Name: History_dolzhnostei CHECK data_s; Type: CHECK CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE laba1_schema."History_dolzhnostei"
    ADD CONSTRAINT "CHECK data_s" CHECK ((data_s > '1900-01-01'::date)) NOT VALID;


--
-- TOC entry 4723 (class 2606 OID 40965)
-- Name: Sostav_group CHECK data_start; Type: CHECK CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE laba1_schema."Sostav_group"
    ADD CONSTRAINT "CHECK data_start" CHECK ((data_start_obuch > '1900-01-01'::date)) NOT VALID;


--
-- TOC entry 4713 (class 2606 OID 40969)
-- Name: Document_ob_okonchanii CHECK data_vidachi; Type: CHECK CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE laba1_schema."Document_ob_okonchanii"
    ADD CONSTRAINT "CHECK data_vidachi" CHECK ((data_vidachi > '1900-01-01'::date)) NOT VALID;


--
-- TOC entry 4720 (class 2606 OID 40973)
-- Name: Slushatel CHECK email; Type: CHECK CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE laba1_schema."Slushatel"
    ADD CONSTRAINT "CHECK email" CHECK (((email)::text ~ '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'::text)) NOT VALID;


--
-- TOC entry 4714 (class 2606 OID 40970)
-- Name: Document_ob_okonchanii CHECK kolicchestvo_hours; Type: CHECK CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE laba1_schema."Document_ob_okonchanii"
    ADD CONSTRAINT "CHECK kolicchestvo_hours" CHECK ((kolvo_chasov > 0)) NOT VALID;


--
-- TOC entry 4715 (class 2606 OID 40967)
-- Name: Document_ob_okonchanii CHECK number_dokument; Type: CHECK CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE laba1_schema."Document_ob_okonchanii"
    ADD CONSTRAINT "CHECK number_dokument" CHECK (((nomer_documenta)::integer > 0)) NOT VALID;


--
-- TOC entry 4721 (class 2606 OID 40974)
-- Name: Slushatel CHECK passport; Type: CHECK CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE laba1_schema."Slushatel"
    ADD CONSTRAINT "CHECK passport" CHECK (((passport_danie)::text ~ '^\d{4} \d{6}$'::text)) NOT VALID;


--
-- TOC entry 4739 (class 2606 OID 17035)
-- Name: Disciplina Disciplina_pkey; Type: CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Disciplina"
    ADD CONSTRAINT "Disciplina_pkey" PRIMARY KEY (kod_disciplini);


--
-- TOC entry 4745 (class 2606 OID 17037)
-- Name: Document_ob_okonchanii Document_ob_okonchanii_pkey; Type: CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Document_ob_okonchanii"
    ADD CONSTRAINT "Document_ob_okonchanii_pkey" PRIMARY KEY (id_documenta);


--
-- TOC entry 4749 (class 2606 OID 17039)
-- Name: Dolzhnost Dolzhnost_pkey; Type: CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Dolzhnost"
    ADD CONSTRAINT "Dolzhnost_pkey" PRIMARY KEY (id_dolzhnosti);


--
-- TOC entry 4735 (class 2606 OID 17033)
-- Name: Group Group_pkey; Type: CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Group"
    ADD CONSTRAINT "Group_pkey" PRIMARY KEY (id_group);


--
-- TOC entry 4759 (class 2606 OID 17043)
-- Name: History_dolzhnostei History_dolzhnostei_pkey; Type: CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."History_dolzhnostei"
    ADD CONSTRAINT "History_dolzhnostei_pkey" PRIMARY KEY (id_history_dolzhnostei);


--
-- TOC entry 4763 (class 2606 OID 17045)
-- Name: Korpus Korpus_pkey; Type: CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Korpus"
    ADD CONSTRAINT "Korpus_pkey" PRIMARY KEY (id_korpusa);


--
-- TOC entry 4769 (class 2606 OID 17047)
-- Name: Obrazovatelnaia_programma Obrazovatelnaia_programma_pkey; Type: CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Obrazovatelnaia_programma"
    ADD CONSTRAINT "Obrazovatelnaia_programma_pkey" PRIMARY KEY (kod_obrazovatelnoi_programmi);


--
-- TOC entry 4775 (class 2606 OID 17049)
-- Name: Podrazdelenie Podrazdelenie_pkey; Type: CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Podrazdelenie"
    ADD CONSTRAINT "Podrazdelenie_pkey" PRIMARY KEY (kod_podrazdelenie);


--
-- TOC entry 4781 (class 2606 OID 17051)
-- Name: Prepodavatel Prepodavatel_pkey; Type: CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Prepodavatel"
    ADD CONSTRAINT "Prepodavatel_pkey" PRIMARY KEY (id_prepoda);


--
-- TOC entry 4785 (class 2606 OID 17053)
-- Name: Slushatel Slushatel_pkey; Type: CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Slushatel"
    ADD CONSTRAINT "Slushatel_pkey" PRIMARY KEY (id_slushatelia);


--
-- TOC entry 4793 (class 2606 OID 17055)
-- Name: Sostav_group Sostav_group_pkey; Type: CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Sostav_group"
    ADD CONSTRAINT "Sostav_group_pkey" PRIMARY KEY (id_zapisi);


--
-- TOC entry 4797 (class 2606 OID 17057)
-- Name: Sostav_uchebnogo_plana Sostav_uchebnogo_plana_pkey; Type: CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Sostav_uchebnogo_plana"
    ADD CONSTRAINT "Sostav_uchebnogo_plana_pkey" PRIMARY KEY (kod_sostav_uchebnogo_plana);


--
-- TOC entry 4801 (class 2606 OID 17059)
-- Name: Type_auditorii Type_auditorii_pkey; Type: CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Type_auditorii"
    ADD CONSTRAINT "Type_auditorii_pkey" PRIMARY KEY (id_type_auditorii);


--
-- TOC entry 4807 (class 2606 OID 17061)
-- Name: Type_docc_ob_okonchanii Type_docc_ob_okonchanii_pkey; Type: CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Type_docc_ob_okonchanii"
    ADD CONSTRAINT "Type_docc_ob_okonchanii_pkey" PRIMARY KEY (id_type);


--
-- TOC entry 4813 (class 2606 OID 17063)
-- Name: Type_programm Type_programm_pkey; Type: CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Type_programm"
    ADD CONSTRAINT "Type_programm_pkey" PRIMARY KEY (kod_type_programmi);


--
-- TOC entry 4765 (class 2606 OID 32826)
-- Name: Korpus UNIQUE ID korpusa; Type: CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Korpus"
    ADD CONSTRAINT "UNIQUE ID korpusa" UNIQUE (id_korpusa);


--
-- TOC entry 4803 (class 2606 OID 32830)
-- Name: Type_auditorii UNIQUE ID type auditorii; Type: CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Type_auditorii"
    ADD CONSTRAINT "UNIQUE ID type auditorii" UNIQUE (id_type_auditorii);


--
-- TOC entry 4795 (class 2606 OID 32834)
-- Name: Sostav_group UNIQUE ID zapisi; Type: CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Sostav_group"
    ADD CONSTRAINT "UNIQUE ID zapisi" UNIQUE (id_zapisi);


--
-- TOC entry 4751 (class 2606 OID 32818)
-- Name: Dolzhnost UNIQUE ID_dolzhnosti; Type: CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Dolzhnost"
    ADD CONSTRAINT "UNIQUE ID_dolzhnosti" UNIQUE (id_dolzhnosti);


--
-- TOC entry 4761 (class 2606 OID 32816)
-- Name: History_dolzhnostei UNIQUE ID_history_dolzhnoctey; Type: CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."History_dolzhnostei"
    ADD CONSTRAINT "UNIQUE ID_history_dolzhnoctey" UNIQUE (id_history_dolzhnostei);


--
-- TOC entry 4783 (class 2606 OID 32796)
-- Name: Prepodavatel UNIQUE ID_prepod; Type: CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Prepodavatel"
    ADD CONSTRAINT "UNIQUE ID_prepod" UNIQUE (id_prepoda);


--
-- TOC entry 4787 (class 2606 OID 32804)
-- Name: Slushatel UNIQUE ID_slyshatel; Type: CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Slushatel"
    ADD CONSTRAINT "UNIQUE ID_slyshatel" UNIQUE (id_slushatelia);


--
-- TOC entry 4809 (class 2606 OID 32808)
-- Name: Type_docc_ob_okonchanii UNIQUE ID_tipa; Type: CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Type_docc_ob_okonchanii"
    ADD CONSTRAINT "UNIQUE ID_tipa" UNIQUE (id_type);


--
-- TOC entry 4741 (class 2606 OID 32786)
-- Name: Disciplina UNIQUE Kod disciplin; Type: CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Disciplina"
    ADD CONSTRAINT "UNIQUE Kod disciplin" UNIQUE (kod_disciplini);


--
-- TOC entry 4771 (class 2606 OID 32782)
-- Name: Obrazovatelnaia_programma UNIQUE Nazvanie; Type: CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Obrazovatelnaia_programma"
    ADD CONSTRAINT "UNIQUE Nazvanie" UNIQUE (name_prog);


--
-- TOC entry 4789 (class 2606 OID 32800)
-- Name: Slushatel UNIQUE Passport; Type: CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Slushatel"
    ADD CONSTRAINT "UNIQUE Passport" UNIQUE (passport_danie);


--
-- TOC entry 4791 (class 2606 OID 32802)
-- Name: Slushatel UNIQUE email; Type: CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Slushatel"
    ADD CONSTRAINT "UNIQUE email" UNIQUE (email);


--
-- TOC entry 4773 (class 2606 OID 32780)
-- Name: Obrazovatelnaia_programma UNIQUE kod obraz program; Type: CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Obrazovatelnaia_programma"
    ADD CONSTRAINT "UNIQUE kod obraz program" UNIQUE (kod_obrazovatelnoi_programmi);


--
-- TOC entry 4817 (class 2606 OID 32773)
-- Name: Uchebni_plan UNIQUE kod plana; Type: CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Uchebni_plan"
    ADD CONSTRAINT "UNIQUE kod plana" UNIQUE (kod_uchebni_plana);


--
-- TOC entry 4799 (class 2606 OID 32778)
-- Name: Sostav_uchebnogo_plana UNIQUE kod sostava; Type: CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Sostav_uchebnogo_plana"
    ADD CONSTRAINT "UNIQUE kod sostava" UNIQUE (kod_sostav_uchebnogo_plana);


--
-- TOC entry 4815 (class 2606 OID 32836)
-- Name: Type_programm UNIQUE kod type programm; Type: CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Type_programm"
    ADD CONSTRAINT "UNIQUE kod type programm" UNIQUE (kod_type_programmi);


--
-- TOC entry 4729 (class 2606 OID 32822)
-- Name: Vidi_itogovoi_atestacii UNIQUE kod vidov itog attestacii; Type: CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Vidi_itogovoi_atestacii"
    ADD CONSTRAINT "UNIQUE kod vidov itog attestacii" UNIQUE (kod_vidov_itog_attestacii);


--
-- TOC entry 4777 (class 2606 OID 32812)
-- Name: Podrazdelenie UNIQUE kod_podrazdelenia; Type: CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Podrazdelenie"
    ADD CONSTRAINT "UNIQUE kod_podrazdelenia" UNIQUE (kod_podrazdelenie);


--
-- TOC entry 4753 (class 2606 OID 32820)
-- Name: Dolzhnost UNIQUE nazvania dolzhnosti; Type: CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Dolzhnost"
    ADD CONSTRAINT "UNIQUE nazvania dolzhnosti" UNIQUE (name_dolzhnosti);


--
-- TOC entry 4819 (class 2606 OID 24581)
-- Name: Uchebni_plan UNIQUE nazvanie; Type: CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Uchebni_plan"
    ADD CONSTRAINT "UNIQUE nazvanie" UNIQUE (name_ucheb_plan);


--
-- TOC entry 4743 (class 2606 OID 32788)
-- Name: Disciplina UNIQUE nazvanie dis; Type: CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Disciplina"
    ADD CONSTRAINT "UNIQUE nazvanie dis" UNIQUE (name_disciplini);


--
-- TOC entry 4767 (class 2606 OID 32828)
-- Name: Korpus UNIQUE nazvanie korpusa; Type: CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Korpus"
    ADD CONSTRAINT "UNIQUE nazvanie korpusa" UNIQUE (name_korpusa);


--
-- TOC entry 4779 (class 2606 OID 32814)
-- Name: Podrazdelenie UNIQUE nazvanie pod; Type: CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Podrazdelenie"
    ADD CONSTRAINT "UNIQUE nazvanie pod" UNIQUE (name_pod);


--
-- TOC entry 4805 (class 2606 OID 32832)
-- Name: Type_auditorii UNIQUE nazvanie type; Type: CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Type_auditorii"
    ADD CONSTRAINT "UNIQUE nazvanie type" UNIQUE (name_type);


--
-- TOC entry 4731 (class 2606 OID 32824)
-- Name: Vidi_itogovoi_atestacii UNIQUE nazvanie vid itogovoi attestacii; Type: CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Vidi_itogovoi_atestacii"
    ADD CONSTRAINT "UNIQUE nazvanie vid itogovoi attestacii" UNIQUE (name_itogov);


--
-- TOC entry 4727 (class 2606 OID 32798)
-- Name: Auditoria UNIQUE nomer_auditorii; Type: CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Auditoria"
    ADD CONSTRAINT "UNIQUE nomer_auditorii" UNIQUE (nomer_auditorii);


--
-- TOC entry 4747 (class 2606 OID 32806)
-- Name: Document_ob_okonchanii UNIQUE nomer_dokumenta; Type: CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Document_ob_okonchanii"
    ADD CONSTRAINT "UNIQUE nomer_dokumenta" UNIQUE (nomer_documenta);


--
-- TOC entry 4737 (class 2606 OID 32792)
-- Name: Group UNIQUE nomer_group; Type: CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Group"
    ADD CONSTRAINT "UNIQUE nomer_group" UNIQUE (nomer_group);


--
-- TOC entry 4811 (class 2606 OID 32810)
-- Name: Type_docc_ob_okonchanii UNIQUE type_documenta; Type: CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Type_docc_ob_okonchanii"
    ADD CONSTRAINT "UNIQUE type_documenta" UNIQUE (type_documenta);


--
-- TOC entry 4755 (class 2606 OID 32790)
-- Name: Zaniatie UNIQUE zaniatia; Type: CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Zaniatie"
    ADD CONSTRAINT "UNIQUE zaniatia" UNIQUE (id_zaniatia);


--
-- TOC entry 4821 (class 2606 OID 17065)
-- Name: Uchebni_plan Uchebni_plan_pkey; Type: CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Uchebni_plan"
    ADD CONSTRAINT "Uchebni_plan_pkey" PRIMARY KEY (kod_uchebni_plana);


--
-- TOC entry 4733 (class 2606 OID 17031)
-- Name: Vidi_itogovoi_atestacii Vidi_itogovoi_atestacii_pkey; Type: CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Vidi_itogovoi_atestacii"
    ADD CONSTRAINT "Vidi_itogovoi_atestacii_pkey" PRIMARY KEY (kod_vidov_itog_attestacii);


--
-- TOC entry 4757 (class 2606 OID 17041)
-- Name: Zaniatie Zaniatie_pkey; Type: CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Zaniatie"
    ADD CONSTRAINT "Zaniatie_pkey" PRIMARY KEY (id_zaniatia);


--
-- TOC entry 4825 (class 2606 OID 17101)
-- Name: Document_ob_okonchanii Slushatel; Type: FK CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Document_ob_okonchanii"
    ADD CONSTRAINT "Slushatel" FOREIGN KEY (id_slushatelia) REFERENCES laba1_schema."Slushatel"(id_slushatelia) NOT VALID;


--
-- TOC entry 4826 (class 2606 OID 17136)
-- Name: Document_ob_okonchanii Type; Type: FK CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Document_ob_okonchanii"
    ADD CONSTRAINT "Type" FOREIGN KEY (id_type) REFERENCES laba1_schema."Type_docc_ob_okonchanii"(id_type) NOT VALID;


--
-- TOC entry 4841 (class 2606 OID 17106)
-- Name: Type_docc_ob_okonchanii document; Type: FK CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Type_docc_ob_okonchanii"
    ADD CONSTRAINT document FOREIGN KEY (type_documenta) REFERENCES laba1_schema."Document_ob_okonchanii"(id_documenta) NOT VALID;


--
-- TOC entry 4831 (class 2606 OID 17141)
-- Name: History_dolzhnostei dolzhnost; Type: FK CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."History_dolzhnostei"
    ADD CONSTRAINT dolzhnost FOREIGN KEY (id_dolzhnosti) REFERENCES laba1_schema."Dolzhnost"(id_dolzhnosti) NOT VALID;


--
-- TOC entry 4835 (class 2606 OID 17096)
-- Name: Sostav_group id_group; Type: FK CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Sostav_group"
    ADD CONSTRAINT id_group FOREIGN KEY (id_group) REFERENCES laba1_schema."Group"(id_group) NOT VALID;


--
-- TOC entry 4827 (class 2606 OID 17161)
-- Name: Zaniatie id_group; Type: FK CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Zaniatie"
    ADD CONSTRAINT id_group FOREIGN KEY (id_group) REFERENCES laba1_schema."Group"(id_group) NOT VALID;


--
-- TOC entry 4822 (class 2606 OID 17156)
-- Name: Auditoria id_korpusa; Type: FK CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Auditoria"
    ADD CONSTRAINT id_korpusa FOREIGN KEY (id_korpusa) REFERENCES laba1_schema."Korpus"(id_korpusa) NOT VALID;


--
-- TOC entry 4836 (class 2606 OID 40977)
-- Name: Sostav_group id_slushatel; Type: FK CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Sostav_group"
    ADD CONSTRAINT id_slushatel FOREIGN KEY (id_slushatelia) REFERENCES laba1_schema."Slushatel"(id_slushatelia) NOT VALID;


--
-- TOC entry 4823 (class 2606 OID 17131)
-- Name: Auditoria id_tip_auditorii; Type: FK CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Auditoria"
    ADD CONSTRAINT id_tip_auditorii FOREIGN KEY (id_tip_auditorii) REFERENCES laba1_schema."Type_auditorii"(id_type_auditorii) NOT VALID;


--
-- TOC entry 4837 (class 2606 OID 17116)
-- Name: Sostav_uchebnogo_plana kod_disciplini; Type: FK CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Sostav_uchebnogo_plana"
    ADD CONSTRAINT kod_disciplini FOREIGN KEY (kod_disciplini) REFERENCES laba1_schema."Disciplina"(kod_disciplini) NOT VALID;


--
-- TOC entry 4828 (class 2606 OID 17126)
-- Name: Zaniatie kod_disciplini; Type: FK CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Zaniatie"
    ADD CONSTRAINT kod_disciplini FOREIGN KEY (kod_disciplini) REFERENCES laba1_schema."Disciplina"(kod_disciplini) NOT VALID;


--
-- TOC entry 4842 (class 2606 OID 17066)
-- Name: Uchebni_plan kod_obrazovatelnoi_programm; Type: FK CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Uchebni_plan"
    ADD CONSTRAINT kod_obrazovatelnoi_programm FOREIGN KEY (kod_obrazovatelnoi_programm) REFERENCES laba1_schema."Obrazovatelnaia_programma"(kod_obrazovatelnoi_programmi) NOT VALID;


--
-- TOC entry 4824 (class 2606 OID 17086)
-- Name: Auditoria kod_podrazdelenia; Type: FK CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Auditoria"
    ADD CONSTRAINT kod_podrazdelenia FOREIGN KEY (kod_podrazdelenia) REFERENCES laba1_schema."Podrazdelenie"(kod_podrazdelenie) NOT VALID;


--
-- TOC entry 4833 (class 2606 OID 17121)
-- Name: Obrazovatelnaia_programma kod_podrazdelenia; Type: FK CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Obrazovatelnaia_programma"
    ADD CONSTRAINT kod_podrazdelenia FOREIGN KEY (kod_podrazdelenia) REFERENCES laba1_schema."Podrazdelenie"(kod_podrazdelenie) NOT VALID;


--
-- TOC entry 4838 (class 2606 OID 17146)
-- Name: Sostav_uchebnogo_plana kod_uchebnogo_plana; Type: FK CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Sostav_uchebnogo_plana"
    ADD CONSTRAINT kod_uchebnogo_plana FOREIGN KEY (kod_uchebnogo_plana) REFERENCES laba1_schema."Uchebni_plan"(kod_uchebni_plana) NOT VALID;


--
-- TOC entry 4839 (class 2606 OID 17076)
-- Name: Sostav_uchebnogo_plana kod_vidov_attestacii; Type: FK CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Sostav_uchebnogo_plana"
    ADD CONSTRAINT kod_vidov_attestacii FOREIGN KEY (kod_vidov_itog_attestacii) REFERENCES laba1_schema."Vidi_itogovoi_atestacii"(kod_vidov_itog_attestacii) NOT VALID;


--
-- TOC entry 4840 (class 2606 OID 17091)
-- Name: Type_auditorii name_type; Type: FK CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Type_auditorii"
    ADD CONSTRAINT name_type FOREIGN KEY (name_type) REFERENCES laba1_schema."Auditoria"(nomer_auditorii) NOT VALID;


--
-- TOC entry 4829 (class 2606 OID 17151)
-- Name: Zaniatie nomer_auditorii; Type: FK CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Zaniatie"
    ADD CONSTRAINT nomer_auditorii FOREIGN KEY (nomer_auditorii) REFERENCES laba1_schema."Auditoria"(nomer_auditorii) NOT VALID;


--
-- TOC entry 4830 (class 2606 OID 17081)
-- Name: Zaniatie prepod; Type: FK CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Zaniatie"
    ADD CONSTRAINT prepod FOREIGN KEY (id_prepoda) REFERENCES laba1_schema."Prepodavatel"(id_prepoda) NOT VALID;


--
-- TOC entry 4832 (class 2606 OID 17111)
-- Name: History_dolzhnostei prepod; Type: FK CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."History_dolzhnostei"
    ADD CONSTRAINT prepod FOREIGN KEY (id_prepoda) REFERENCES laba1_schema."Prepodavatel"(id_prepoda) NOT VALID;


--
-- TOC entry 4834 (class 2606 OID 17071)
-- Name: Obrazovatelnaia_programma type_programmi; Type: FK CONSTRAINT; Schema: laba1_schema; Owner: postgres
--

ALTER TABLE ONLY laba1_schema."Obrazovatelnaia_programma"
    ADD CONSTRAINT type_programmi FOREIGN KEY (kod_type_programm) REFERENCES laba1_schema."Type_programm"(kod_type_programmi) NOT VALID;


-- Completed on 2025-04-14 22:51:41

--
-- PostgreSQL database dump complete
--
