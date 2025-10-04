--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4
-- Dumped by pg_dump version 17.4

-- Started on 2025-04-11 05:48:24

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
    "номер_аудитории" character varying(5) NOT NULL,
    "код_подразделения" character varying(18),
    "id_тип_аудитории" integer NOT NULL,
    "id_корпуса" integer NOT NULL
);


ALTER TABLE public."Аудитория" OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16432)
-- Name: Виды_итоговой_аттестации; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Виды_итоговой_аттестации" (
    "код_видов_итог_аттестации" character varying(20) NOT NULL,
    "название" character varying(50)
);


ALTER TABLE public."Виды_итоговой_аттестации" OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16420)
-- Name: Группа; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Группа" (
    "id_группы" integer NOT NULL,
    "код_учебного_плана" character varying(8) NOT NULL,
    "номер_группы" character varying(6)
);


ALTER TABLE public."Группа" OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 16479)
-- Name: Дисциплина; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Дисциплина" (
    "код_дисциплины" character varying(20) NOT NULL,
    "название" character varying(50),
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
    "номер_документа" character varying(10),
    "дата_выдачи" date,
    "колво_часов" integer,
    "код_программы" character varying(8),
    "id_типа" integer NOT NULL
);


ALTER TABLE public."Документ_об_окончании" OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 16453)
-- Name: Должность; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Должность" (
    "id_должности" integer NOT NULL,
    "название" character varying(20)
);


ALTER TABLE public."Должность" OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 16507)
-- Name: Занятие; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Занятие" (
    "id_занятия" integer NOT NULL,
    "id_препода" integer NOT NULL,
    "код_дисциплины" character varying(20) NOT NULL,
    "номер_аудитории" character varying(5) NOT NULL,
    "тип_занятия" character varying(15),
    "дата_занятия" date,
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
    "название" character varying(20)
);


ALTER TABLE public."Корпус" OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16406)
-- Name: Образовательная_программа; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Образовательная_программа" (
    "код_образовательной_программы" character varying(20) NOT NULL,
    "код_типа_программы" character varying(20) NOT NULL,
    "код_подразделения" character varying(18) NOT NULL,
    "название" character varying(60)
);


ALTER TABLE public."Образовательная_программа" OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 16472)
-- Name: Подразделение; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Подразделение" (
    "код_подразделения" character varying(18) NOT NULL,
    "название" character varying(30)
);


ALTER TABLE public."Подразделение" OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 16465)
-- Name: Преподаватель; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Преподаватель" (
    "id_препода" integer NOT NULL,
    "фио" character varying(60)
);


ALTER TABLE public."Преподаватель" OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16392)
-- Name: Слушатель; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Слушатель" (
    "id_слушателя" integer NOT NULL,
    "ФИО" character varying(60),
    "паспорт_данные" character varying(20),
    "электр_почта" character varying(20)
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
    "код_состава_учебного_плана" character varying(20) NOT NULL,
    "код_видов_итог_аттестации" character varying(20) NOT NULL,
    "код_учебного_плана" character varying(8) NOT NULL,
    "код_дисциплины" character varying(20) NOT NULL
);


ALTER TABLE public."Состав_учебного_плана" OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 16493)
-- Name: Тип_аудитории; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Тип_аудитории" (
    "id_тип_аудитории" integer NOT NULL,
    "название_типа" character varying(50)
);


ALTER TABLE public."Тип_аудитории" OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 16439)
-- Name: Тип_док_об_окончании; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Тип_док_об_окончании" (
    "id_типа" integer NOT NULL,
    "тип_документа" character varying(20)
);


ALTER TABLE public."Тип_док_об_окончании" OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 16515)
-- Name: Тип_программы; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Тип_программы" (
    "код_типа_программы" character varying(20) NOT NULL,
    "название" character varying(60)
);


ALTER TABLE public."Тип_программы" OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16399)
-- Name: Учебный_план; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Учебный_план" (
    "код_учебного_плана" character varying(8) NOT NULL,
    "название" character varying(60),
    "специальность" character varying(10),
    "код_образовательной_программы" character varying(20) NOT NULL
);


ALTER TABLE public."Учебный_план" OWNER TO postgres;

--
-- TOC entry 4993 (class 0 OID 16486)
-- Dependencies: 231
-- Data for Name: Аудитория; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Аудитория" ("номер_аудитории", "код_подразделения", "id_тип_аудитории", "id_корпуса") VALUES ('А-101', 'ФИТ', 1, 1);
INSERT INTO public."Аудитория" ("номер_аудитории", "код_подразделения", "id_тип_аудитории", "id_корпуса") VALUES ('Б-202', 'ИДО', 2, 2);


--
-- TOC entry 4985 (class 0 OID 16432)
-- Dependencies: 223
-- Data for Name: Виды_итоговой_аттестации; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Виды_итоговой_аттестации" ("код_видов_итог_аттестации", "название") VALUES ('ЭКЗАМЕН', 'Экзамен');
INSERT INTO public."Виды_итоговой_аттестации" ("код_видов_итог_аттестации", "название") VALUES ('ЗАЧЕТ', 'Зачет');
INSERT INTO public."Виды_итоговой_аттестации" ("код_видов_итог_аттестации", "название") VALUES ('ДИПЛОМ', 'Защита диплома');


--
-- TOC entry 4983 (class 0 OID 16420)
-- Dependencies: 221
-- Data for Name: Группа; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Группа" ("id_группы", "код_учебного_плана", "номер_группы") VALUES (1, 'УП-001', 'ГР-101');
INSERT INTO public."Группа" ("id_группы", "код_учебного_плана", "номер_группы") VALUES (2, 'УП-002', 'ГР-202');


--
-- TOC entry 4992 (class 0 OID 16479)
-- Dependencies: 230
-- Data for Name: Дисциплина; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Дисциплина" ("код_дисциплины", "название", "колво_часов") VALUES ('ДИС-001', 'Основы программирования', 72);
INSERT INTO public."Дисциплина" ("код_дисциплины", "название", "колво_часов") VALUES ('ДИС-002', 'Веб-разработка', 108);


--
-- TOC entry 4987 (class 0 OID 16446)
-- Dependencies: 225
-- Data for Name: Документ_об_окончании; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Документ_об_окончании" ("id_документа", "id_слушателя", "номер_документа", "дата_выдачи", "колво_часов", "код_программы", "id_типа") VALUES (1, 1, 'УД-123', '2024-08-28', 72, 'ПРОГ-001', 1);
INSERT INTO public."Документ_об_окончании" ("id_документа", "id_слушателя", "номер_документа", "дата_выдачи", "колво_часов", "код_программы", "id_типа") VALUES (2, 2, 'ДП-456', '2024-06-30', 240, 'ПРОГ-002', 2);


--
-- TOC entry 4988 (class 0 OID 16453)
-- Dependencies: 226
-- Data for Name: Должность; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Должность" ("id_должности", "название") VALUES (1, 'Преподаватель');
INSERT INTO public."Должность" ("id_должности", "название") VALUES (2, 'Доцент');


--
-- TOC entry 4996 (class 0 OID 16507)
-- Dependencies: 234
-- Data for Name: Занятие; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Занятие" ("id_занятия", "id_препода", "код_дисциплины", "номер_аудитории", "тип_занятия", "дата_занятия", "id_группы") VALUES (1, 1, 'ДИС-001', 'А-101', 'Лекция', '2025-04-11', 1);
INSERT INTO public."Занятие" ("id_занятия", "id_препода", "код_дисциплины", "номер_аудитории", "тип_занятия", "дата_занятия", "id_группы") VALUES (2, 2, 'ДИС-002', 'Б-202', 'Практика', '2025-04-12', 2);


--
-- TOC entry 4989 (class 0 OID 16460)
-- Dependencies: 227
-- Data for Name: История_должностей; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."История_должностей" ("id_истории_должностей", "id_препода", "id_должности", "дата_с", "дата_по") VALUES (1, 1, 1, '2020-09-01', NULL);
INSERT INTO public."История_должностей" ("id_истории_должностей", "id_препода", "id_должности", "дата_с", "дата_по") VALUES (2, 2, 2, '2022-09-01', NULL);


--
-- TOC entry 4995 (class 0 OID 16500)
-- Dependencies: 233
-- Data for Name: Корпус; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Корпус" ("id_корпуса", "название") VALUES (1, 'Корпус А');
INSERT INTO public."Корпус" ("id_корпуса", "название") VALUES (2, 'Корпус Б');


--
-- TOC entry 4981 (class 0 OID 16406)
-- Dependencies: 219
-- Data for Name: Образовательная_программа; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Образовательная_программа" ("код_образовательной_программы", "код_типа_программы", "код_подразделения", "название") VALUES ('ПРОГ-001', 'ДПО', 'ИДО', 'Программа повышения квалификации "Разработка веб-приложений"');
INSERT INTO public."Образовательная_программа" ("код_образовательной_программы", "код_типа_программы", "код_подразделения", "название") VALUES ('ПРОГ-002', 'ПО', 'ФИТ', 'Бакалавриат "Прикладная информатика"');


--
-- TOC entry 4991 (class 0 OID 16472)
-- Dependencies: 229
-- Data for Name: Подразделение; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Подразделение" ("код_подразделения", "название") VALUES ('ИДО', 'Институт Доп Образования');
INSERT INTO public."Подразделение" ("код_подразделения", "название") VALUES ('ФИТ', 'Факультет Инф Технологий');


--
-- TOC entry 4990 (class 0 OID 16465)
-- Dependencies: 228
-- Data for Name: Преподаватель; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Преподаватель" ("id_препода", "фио") VALUES (1, 'Смирнов Иван Петрович');
INSERT INTO public."Преподаватель" ("id_препода", "фио") VALUES (2, 'Петрова Елена Алексеевна');


--
-- TOC entry 4979 (class 0 OID 16392)
-- Dependencies: 217
-- Data for Name: Слушатель; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Слушатель" ("id_слушателя", "ФИО", "паспорт_данные", "электр_почта") VALUES (1, 'Иванов Иван', '1234 567890', 'ivanov@example.com');
INSERT INTO public."Слушатель" ("id_слушателя", "ФИО", "паспорт_данные", "электр_почта") VALUES (2, 'Петров Петр', '5678 098765', 'petrov@example.com');


--
-- TOC entry 4984 (class 0 OID 16427)
-- Dependencies: 222
-- Data for Name: Состав_группы; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Состав_группы" ("id_записи", "id_группы", "id_слушателя", "дата_нач_обуч", "дата_оконч_обуч") VALUES (1, 1, 1, '2024-09-01', '2024-12-31');
INSERT INTO public."Состав_группы" ("id_записи", "id_группы", "id_слушателя", "дата_нач_обуч", "дата_оконч_обуч") VALUES (2, 2, 2, '2024-09-01', '2025-06-30');


--
-- TOC entry 4982 (class 0 OID 16413)
-- Dependencies: 220
-- Data for Name: Состав_учебного_плана; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Состав_учебного_плана" ("код_состава_учебного_плана", "код_видов_итог_аттестации", "код_учебного_плана", "код_дисциплины") VALUES ('СУП-001', 'ЭКЗАМЕН', 'УП-001', 'ДИС-001');
INSERT INTO public."Состав_учебного_плана" ("код_состава_учебного_плана", "код_видов_итог_аттестации", "код_учебного_плана", "код_дисциплины") VALUES ('СУП-002', 'ЗАЧЕТ', 'УП-001', 'ДИС-002');


--
-- TOC entry 4994 (class 0 OID 16493)
-- Dependencies: 232
-- Data for Name: Тип_аудитории; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Тип_аудитории" ("id_тип_аудитории", "название_типа") VALUES (1, 'Лекционная');
INSERT INTO public."Тип_аудитории" ("id_тип_аудитории", "название_типа") VALUES (2, 'Компьютерный класс');


--
-- TOC entry 4986 (class 0 OID 16439)
-- Dependencies: 224
-- Data for Name: Тип_док_об_окончании; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Тип_док_об_окончании" ("id_типа", "тип_документа") VALUES (1, 'Удостоверение');
INSERT INTO public."Тип_док_об_окончании" ("id_типа", "тип_документа") VALUES (2, 'Диплом');


--
-- TOC entry 4997 (class 0 OID 16515)
-- Dependencies: 235
-- Data for Name: Тип_программы; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Тип_программы" ("код_типа_программы", "название") VALUES ('ДПО', 'Дополнительное профессиональное образование');
INSERT INTO public."Тип_программы" ("код_типа_программы", "название") VALUES ('ПО', 'Основное образование');


--
-- TOC entry 4980 (class 0 OID 16399)
-- Dependencies: 218
-- Data for Name: Учебный_план; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Учебный_план" ("код_учебного_плана", "название", "специальность", "код_образовательной_программы") VALUES ('УП-001', 'Учебный план "Разработка веб-приложений"', '09.03.03', 'ПРОГ-001');
INSERT INTO public."Учебный_план" ("код_учебного_плана", "название", "специальность", "код_образовательной_программы") VALUES ('УП-002', 'Учебный план "Прикладная информатика"', '09.03.02', 'ПРОГ-002');


--
-- TOC entry 4715 (class 2606 OID 16657)
-- Name: Состав_группы check_data_nach_obuch; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public."Состав_группы"
    ADD CONSTRAINT check_data_nach_obuch CHECK (("дата_нач_обуч" <= CURRENT_DATE)) NOT VALID;


--
-- TOC entry 4716 (class 2606 OID 16658)
-- Name: Состав_группы check_data_okonch_obuch; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public."Состав_группы"
    ADD CONSTRAINT check_data_okonch_obuch CHECK (("дата_оконч_обуч" > "дата_нач_обуч")) NOT VALID;


--
-- TOC entry 4719 (class 2606 OID 16678)
-- Name: История_должностей check_data_po_posle_data_s; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public."История_должностей"
    ADD CONSTRAINT check_data_po_posle_data_s CHECK ((("дата_по" IS NULL) OR ("дата_по" >= "дата_с"))) NOT VALID;


--
-- TOC entry 4717 (class 2606 OID 16668)
-- Name: Документ_об_окончании check_data_vydachi; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public."Документ_об_окончании"
    ADD CONSTRAINT check_data_vydachi CHECK (("дата_выдачи" <= CURRENT_DATE)) NOT VALID;


--
-- TOC entry 4712 (class 2606 OID 24600)
-- Name: Слушатель check_email_format; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public."Слушатель"
    ADD CONSTRAINT check_email_format CHECK ((("электр_почта")::text ~ '^[a-zA-Z0-9.%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$'::text)) NOT VALID;


--
-- TOC entry 4713 (class 2606 OID 24580)
-- Name: Слушатель check_fio_slushatelya; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public."Слушатель"
    ADD CONSTRAINT check_fio_slushatelya CHECK ((("ФИО")::text ~ '^[A-ZА-ЯЁ][a-zа-яё]+ [A-ZА-ЯЁ][a-zа-яё]+$'::text)) NOT VALID;


--
-- TOC entry 4721 (class 2606 OID 16623)
-- Name: Тип_аудитории check_id_тип_аудитории; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public."Тип_аудитории"
    ADD CONSTRAINT "check_id_тип_аудитории" CHECK ((("id_тип_аудитории" >= 1) AND ("id_тип_аудитории" <= 3))) NOT VALID;


--
-- TOC entry 4720 (class 2606 OID 16638)
-- Name: Дисциплина check_kolvo_chasov; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public."Дисциплина"
    ADD CONSTRAINT check_kolvo_chasov CHECK (("колво_часов" > 0)) NOT VALID;


--
-- TOC entry 4718 (class 2606 OID 16669)
-- Name: Документ_об_окончании check_kolvo_chasov; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public."Документ_об_окончании"
    ADD CONSTRAINT check_kolvo_chasov CHECK (("колво_часов" > 0)) NOT VALID;


--
-- TOC entry 4714 (class 2606 OID 24611)
-- Name: Слушатель check_pasport_format; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public."Слушатель"
    ADD CONSTRAINT check_pasport_format CHECK ((("паспорт_данные")::text ~ '^\d{4} \d{6}$'::text)) NOT VALID;


--
-- TOC entry 4793 (class 2606 OID 24626)
-- Name: Аудитория Аудитория_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Аудитория"
    ADD CONSTRAINT "Аудитория_pkey" PRIMARY KEY ("номер_аудитории");


--
-- TOC entry 4795 (class 2606 OID 24628)
-- Name: Аудитория Аудитория_номер_аудитории_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Аудитория"
    ADD CONSTRAINT "Аудитория_номер_аудитории_key" UNIQUE ("номер_аудитории");


--
-- TOC entry 4753 (class 2606 OID 24696)
-- Name: Виды_итоговой_аттестации Виды_итоговой_а_код_видов_итог_а_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Виды_итоговой_аттестации"
    ADD CONSTRAINT "Виды_итоговой_а_код_видов_итог_а_key" UNIQUE ("код_видов_итог_аттестации");


--
-- TOC entry 4755 (class 2606 OID 24684)
-- Name: Виды_итоговой_аттестации Виды_итоговой_аттестац_название_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Виды_итоговой_аттестации"
    ADD CONSTRAINT "Виды_итоговой_аттестац_название_key" UNIQUE ("название");


--
-- TOC entry 4757 (class 2606 OID 24694)
-- Name: Виды_итоговой_аттестации Виды_итоговой_аттестации_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Виды_итоговой_аттестации"
    ADD CONSTRAINT "Виды_итоговой_аттестации_pkey" PRIMARY KEY ("код_видов_итог_аттестации");


--
-- TOC entry 4745 (class 2606 OID 16654)
-- Name: Группа Группа_id_группы_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Группа"
    ADD CONSTRAINT "Группа_id_группы_key" UNIQUE ("id_группы");


--
-- TOC entry 4747 (class 2606 OID 16426)
-- Name: Группа Группа_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Группа"
    ADD CONSTRAINT "Группа_pkey" PRIMARY KEY ("id_группы");


--
-- TOC entry 4787 (class 2606 OID 24768)
-- Name: Дисциплина Дисциплина_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Дисциплина"
    ADD CONSTRAINT "Дисциплина_pkey" PRIMARY KEY ("код_дисциплины");


--
-- TOC entry 4789 (class 2606 OID 24770)
-- Name: Дисциплина Дисциплина_код_дисциплины_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Дисциплина"
    ADD CONSTRAINT "Дисциплина_код_дисциплины_key" UNIQUE ("код_дисциплины");


--
-- TOC entry 4791 (class 2606 OID 24758)
-- Name: Дисциплина Дисциплина_название_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Дисциплина"
    ADD CONSTRAINT "Дисциплина_название_key" UNIQUE ("название");


--
-- TOC entry 4763 (class 2606 OID 16667)
-- Name: Документ_об_окончании Документ_об_окончан_id_документа_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Документ_об_окончании"
    ADD CONSTRAINT "Документ_об_окончан_id_документа_key" UNIQUE ("id_документа");


--
-- TOC entry 4765 (class 2606 OID 16452)
-- Name: Документ_об_окончании Документ_об_окончании_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Документ_об_окончании"
    ADD CONSTRAINT "Документ_об_окончании_pkey" PRIMARY KEY ("id_документа");


--
-- TOC entry 4767 (class 2606 OID 16680)
-- Name: Должность Должность_id_должности_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Должность"
    ADD CONSTRAINT "Должность_id_должности_key" UNIQUE ("id_должности");


--
-- TOC entry 4769 (class 2606 OID 16459)
-- Name: Должность Должность_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Должность"
    ADD CONSTRAINT "Должность_pkey" PRIMARY KEY ("id_должности");


--
-- TOC entry 4771 (class 2606 OID 24815)
-- Name: Должность Должность_название_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Должность"
    ADD CONSTRAINT "Должность_название_key" UNIQUE ("название");


--
-- TOC entry 4805 (class 2606 OID 16640)
-- Name: Занятие Занятие_id_занятия_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Занятие"
    ADD CONSTRAINT "Занятие_id_занятия_key" UNIQUE ("id_занятия");


--
-- TOC entry 4807 (class 2606 OID 16513)
-- Name: Занятие Занятие_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Занятие"
    ADD CONSTRAINT "Занятие_pkey" PRIMARY KEY ("id_занятия");


--
-- TOC entry 4773 (class 2606 OID 16677)
-- Name: История_должностей История_должнос_id_истории_должн_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."История_должностей"
    ADD CONSTRAINT "История_должнос_id_истории_должн_key" UNIQUE ("id_истории_должностей");


--
-- TOC entry 4775 (class 2606 OID 16464)
-- Name: История_должностей История_должностей_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."История_должностей"
    ADD CONSTRAINT "История_должностей_pkey" PRIMARY KEY ("id_истории_должностей");


--
-- TOC entry 4801 (class 2606 OID 16650)
-- Name: Корпус Корпус_id_корпуса_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Корпус"
    ADD CONSTRAINT "Корпус_id_корпуса_key" UNIQUE ("id_корпуса");


--
-- TOC entry 4803 (class 2606 OID 16506)
-- Name: Корпус Корпус_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Корпус"
    ADD CONSTRAINT "Корпус_pkey" PRIMARY KEY ("id_корпуса");


--
-- TOC entry 4735 (class 2606 OID 24903)
-- Name: Образовательная_программа Образовательна_код_образовател_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Образовательная_программа"
    ADD CONSTRAINT "Образовательна_код_образовател_key" UNIQUE ("код_образовательной_программы");


--
-- TOC entry 4737 (class 2606 OID 24833)
-- Name: Образовательная_программа Образовательная_прогр_название_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Образовательная_программа"
    ADD CONSTRAINT "Образовательная_прогр_название_key" UNIQUE ("название");


--
-- TOC entry 4739 (class 2606 OID 24901)
-- Name: Образовательная_программа Образовательная_программа_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Образовательная_программа"
    ADD CONSTRAINT "Образовательная_программа_pkey" PRIMARY KEY ("код_образовательной_программы");


--
-- TOC entry 4781 (class 2606 OID 24654)
-- Name: Подразделение Подразделение_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Подразделение"
    ADD CONSTRAINT "Подразделение_pkey" PRIMARY KEY ("код_подразделения");


--
-- TOC entry 4783 (class 2606 OID 24656)
-- Name: Подразделение Подразделение_код_подразделени_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Подразделение"
    ADD CONSTRAINT "Подразделение_код_подразделени_key" UNIQUE ("код_подразделения");


--
-- TOC entry 4785 (class 2606 OID 24843)
-- Name: Подразделение Подразделение_название_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Подразделение"
    ADD CONSTRAINT "Подразделение_название_key" UNIQUE ("название");


--
-- TOC entry 4777 (class 2606 OID 16646)
-- Name: Преподаватель Преподаватель_id_препода_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Преподаватель"
    ADD CONSTRAINT "Преподаватель_id_препода_key" UNIQUE ("id_препода");


--
-- TOC entry 4779 (class 2606 OID 16471)
-- Name: Преподаватель Преподаватель_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Преподаватель"
    ADD CONSTRAINT "Преподаватель_pkey" PRIMARY KEY ("id_препода");


--
-- TOC entry 4723 (class 2606 OID 16660)
-- Name: Слушатель Слушатель_id_слушателя_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Слушатель"
    ADD CONSTRAINT "Слушатель_id_слушателя_key" UNIQUE ("id_слушателя");


--
-- TOC entry 4725 (class 2606 OID 24599)
-- Name: Слушатель Слушатель_электр_почта_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Слушатель"
    ADD CONSTRAINT "Слушатель_электр_почта_key" UNIQUE ("электр_почта");


--
-- TOC entry 4749 (class 2606 OID 16656)
-- Name: Состав_группы Состав_группы_id_записи_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Состав_группы"
    ADD CONSTRAINT "Состав_группы_id_записи_key" UNIQUE ("id_записи");


--
-- TOC entry 4751 (class 2606 OID 16431)
-- Name: Состав_группы Состав_группы_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Состав_группы"
    ADD CONSTRAINT "Состав_группы_pkey" PRIMARY KEY ("id_записи");


--
-- TOC entry 4741 (class 2606 OID 24941)
-- Name: Состав_учебного_плана Состав_учебного_код_состава_уче_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Состав_учебного_плана"
    ADD CONSTRAINT "Состав_учебного_код_состава_уче_key" UNIQUE ("код_состава_учебного_плана");


--
-- TOC entry 4743 (class 2606 OID 24939)
-- Name: Состав_учебного_плана Состав_учебного_плана_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Состав_учебного_плана"
    ADD CONSTRAINT "Состав_учебного_плана_pkey" PRIMARY KEY ("код_состава_учебного_плана");


--
-- TOC entry 4797 (class 2606 OID 16652)
-- Name: Тип_аудитории Тип_аудитории_id_тип_аудитории_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Тип_аудитории"
    ADD CONSTRAINT "Тип_аудитории_id_тип_аудитории_key" UNIQUE ("id_тип_аудитории");


--
-- TOC entry 4799 (class 2606 OID 16499)
-- Name: Тип_аудитории Тип_аудитории_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Тип_аудитории"
    ADD CONSTRAINT "Тип_аудитории_pkey" PRIMARY KEY ("id_тип_аудитории");


--
-- TOC entry 4759 (class 2606 OID 16671)
-- Name: Тип_док_об_окончании Тип_док_об_окончании_id_типа_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Тип_док_об_окончании"
    ADD CONSTRAINT "Тип_док_об_окончании_id_типа_key" UNIQUE ("id_типа");


--
-- TOC entry 4761 (class 2606 OID 16445)
-- Name: Тип_док_об_окончании Тип_док_об_окончании_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Тип_док_об_окончании"
    ADD CONSTRAINT "Тип_док_об_окончании_pkey" PRIMARY KEY ("id_типа");


--
-- TOC entry 4809 (class 2606 OID 24924)
-- Name: Тип_программы Тип_программы_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Тип_программы"
    ADD CONSTRAINT "Тип_программы_pkey" PRIMARY KEY ("код_типа_программы");


--
-- TOC entry 4811 (class 2606 OID 24926)
-- Name: Тип_программы Тип_программы_код_типа_программ_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Тип_программы"
    ADD CONSTRAINT "Тип_программы_код_типа_программ_key" UNIQUE ("код_типа_программы");


--
-- TOC entry 4813 (class 2606 OID 24866)
-- Name: Тип_программы Тип_программы_название_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Тип_программы"
    ADD CONSTRAINT "Тип_программы_название_key" UNIQUE ("название");


--
-- TOC entry 4729 (class 2606 OID 24729)
-- Name: Учебный_план Учебный_план_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Учебный_план"
    ADD CONSTRAINT "Учебный_план_pkey" PRIMARY KEY ("код_учебного_плана");


--
-- TOC entry 4731 (class 2606 OID 24731)
-- Name: Учебный_план Учебный_план_код_учебного_плана_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Учебный_план"
    ADD CONSTRAINT "Учебный_план_код_учебного_плана_key" UNIQUE ("код_учебного_плана");


--
-- TOC entry 4733 (class 2606 OID 24884)
-- Name: Учебный_план Учебный_план_название_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Учебный_план"
    ADD CONSTRAINT "Учебный_план_название_key" UNIQUE ("название");


--
-- TOC entry 4727 (class 2606 OID 16398)
-- Name: Слушатель слушатель_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Слушатель"
    ADD CONSTRAINT "слушатель_pkey" PRIMARY KEY ("id_слушателя");


--
-- TOC entry 4827 (class 2606 OID 16597)
-- Name: Аудитория Аудитория_id_корпуса_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Аудитория"
    ADD CONSTRAINT "Аудитория_id_корпуса_fkey" FOREIGN KEY ("id_корпуса") REFERENCES public."Корпус"("id_корпуса") ON UPDATE RESTRICT ON DELETE RESTRICT NOT VALID;


--
-- TOC entry 4828 (class 2606 OID 16592)
-- Name: Аудитория Аудитория_id_тип_аудитории_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Аудитория"
    ADD CONSTRAINT "Аудитория_id_тип_аудитории_fkey" FOREIGN KEY ("id_тип_аудитории") REFERENCES public."Тип_аудитории"("id_тип_аудитории") ON UPDATE RESTRICT ON DELETE RESTRICT NOT VALID;


--
-- TOC entry 4829 (class 2606 OID 24678)
-- Name: Аудитория Аудитория_код_подразделения_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Аудитория"
    ADD CONSTRAINT "Аудитория_код_подразделения_fkey" FOREIGN KEY ("код_подразделения") REFERENCES public."Подразделение"("код_подразделения") ON UPDATE RESTRICT ON DELETE RESTRICT NOT VALID;


--
-- TOC entry 4820 (class 2606 OID 24747)
-- Name: Группа Группа_код_учебного_плана_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Группа"
    ADD CONSTRAINT "Группа_код_учебного_плана_fkey" FOREIGN KEY ("код_учебного_плана") REFERENCES public."Учебный_план"("код_учебного_плана") ON UPDATE RESTRICT ON DELETE RESTRICT NOT VALID;


--
-- TOC entry 4823 (class 2606 OID 16567)
-- Name: Документ_об_окончании Документ_об_окончан_id_слушателя_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Документ_об_окончании"
    ADD CONSTRAINT "Документ_об_окончан_id_слушателя_fkey" FOREIGN KEY ("id_слушателя") REFERENCES public."Слушатель"("id_слушателя") ON UPDATE RESTRICT ON DELETE RESTRICT NOT VALID;


--
-- TOC entry 4824 (class 2606 OID 16572)
-- Name: Документ_об_окончании Документ_об_окончании_id_типа_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Документ_об_окончании"
    ADD CONSTRAINT "Документ_об_окончании_id_типа_fkey" FOREIGN KEY ("id_типа") REFERENCES public."Тип_док_об_окончании"("id_типа") ON UPDATE RESTRICT ON DELETE RESTRICT NOT VALID;


--
-- TOC entry 4830 (class 2606 OID 16617)
-- Name: Занятие Занятие_id_группы_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Занятие"
    ADD CONSTRAINT "Занятие_id_группы_fkey" FOREIGN KEY ("id_группы") REFERENCES public."Группа"("id_группы") ON UPDATE RESTRICT ON DELETE RESTRICT NOT VALID;


--
-- TOC entry 4831 (class 2606 OID 16602)
-- Name: Занятие Занятие_id_препода_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Занятие"
    ADD CONSTRAINT "Занятие_id_препода_fkey" FOREIGN KEY ("id_препода") REFERENCES public."Преподаватель"("id_препода") ON UPDATE RESTRICT ON DELETE RESTRICT NOT VALID;


--
-- TOC entry 4832 (class 2606 OID 24796)
-- Name: Занятие Занятие_код_дисциплины_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Занятие"
    ADD CONSTRAINT "Занятие_код_дисциплины_fkey" FOREIGN KEY ("код_дисциплины") REFERENCES public."Дисциплина"("код_дисциплины") ON UPDATE RESTRICT ON DELETE RESTRICT NOT VALID;


--
-- TOC entry 4833 (class 2606 OID 24648)
-- Name: Занятие Занятие_номер_аудитории_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Занятие"
    ADD CONSTRAINT "Занятие_номер_аудитории_fkey" FOREIGN KEY ("номер_аудитории") REFERENCES public."Аудитория"("номер_аудитории") ON UPDATE RESTRICT ON DELETE RESTRICT NOT VALID;


--
-- TOC entry 4825 (class 2606 OID 16582)
-- Name: История_должностей История_должностей_id_должности_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."История_должностей"
    ADD CONSTRAINT "История_должностей_id_должности_fkey" FOREIGN KEY ("id_должности") REFERENCES public."Должность"("id_должности") ON UPDATE RESTRICT ON DELETE RESTRICT NOT VALID;


--
-- TOC entry 4826 (class 2606 OID 16577)
-- Name: История_должностей История_должностей_id_препода_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."История_должностей"
    ADD CONSTRAINT "История_должностей_id_препода_fkey" FOREIGN KEY ("id_препода") REFERENCES public."Преподаватель"("id_препода") ON UPDATE RESTRICT ON DELETE RESTRICT NOT VALID;


--
-- TOC entry 4815 (class 2606 OID 24673)
-- Name: Образовательная_программа Образовательна_код_подразделе_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Образовательная_программа"
    ADD CONSTRAINT "Образовательна_код_подразделе_fkey" FOREIGN KEY ("код_подразделения") REFERENCES public."Подразделение"("код_подразделения") ON UPDATE RESTRICT ON DELETE RESTRICT NOT VALID;


--
-- TOC entry 4816 (class 2606 OID 24933)
-- Name: Образовательная_программа Образовательна_код_типа_програ_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Образовательная_программа"
    ADD CONSTRAINT "Образовательна_код_типа_програ_fkey" FOREIGN KEY ("код_типа_программы") REFERENCES public."Тип_программы"("код_типа_программы") ON UPDATE RESTRICT ON DELETE RESTRICT NOT VALID;


--
-- TOC entry 4821 (class 2606 OID 16557)
-- Name: Состав_группы Состав_группы_id_группы_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Состав_группы"
    ADD CONSTRAINT "Состав_группы_id_группы_fkey" FOREIGN KEY ("id_группы") REFERENCES public."Группа"("id_группы") ON UPDATE RESTRICT ON DELETE RESTRICT NOT VALID;


--
-- TOC entry 4822 (class 2606 OID 16562)
-- Name: Состав_группы Состав_группы_id_слушателя_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Состав_группы"
    ADD CONSTRAINT "Состав_группы_id_слушателя_fkey" FOREIGN KEY ("id_слушателя") REFERENCES public."Слушатель"("id_слушателя") ON UPDATE RESTRICT ON DELETE RESTRICT NOT VALID;


--
-- TOC entry 4817 (class 2606 OID 24791)
-- Name: Состав_учебного_плана Состав_учебного__код_дисциплины_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Состав_учебного_плана"
    ADD CONSTRAINT "Состав_учебного__код_дисциплины_fkey" FOREIGN KEY ("код_дисциплины") REFERENCES public."Дисциплина"("код_дисциплины") ON UPDATE RESTRICT ON DELETE RESTRICT NOT VALID;


--
-- TOC entry 4818 (class 2606 OID 24711)
-- Name: Состав_учебного_плана Состав_учебного_код_видов_итог__fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Состав_учебного_плана"
    ADD CONSTRAINT "Состав_учебного_код_видов_итог__fkey" FOREIGN KEY ("код_видов_итог_аттестации") REFERENCES public."Виды_итоговой_аттестации"("код_видов_итог_аттестации") ON UPDATE RESTRICT ON DELETE RESTRICT NOT VALID;


--
-- TOC entry 4819 (class 2606 OID 24752)
-- Name: Состав_учебного_плана Состав_учебного_код_учебного_пл_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Состав_учебного_плана"
    ADD CONSTRAINT "Состав_учебного_код_учебного_пл_fkey" FOREIGN KEY ("код_учебного_плана") REFERENCES public."Учебный_план"("код_учебного_плана") ON UPDATE RESTRICT ON DELETE RESTRICT NOT VALID;


--
-- TOC entry 4814 (class 2606 OID 24912)
-- Name: Учебный_план Учебный_план_код_образовательн_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Учебный_план"
    ADD CONSTRAINT "Учебный_план_код_образовательн_fkey" FOREIGN KEY ("код_образовательной_программы") REFERENCES public."Образовательная_программа"("код_образовательной_программы") ON UPDATE RESTRICT ON DELETE RESTRICT NOT VALID;


-- Completed on 2025-04-11 05:48:25

--
-- PostgreSQL database dump complete
--

