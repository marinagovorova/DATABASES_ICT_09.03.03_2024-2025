--
-- PostgreSQL database dump
--

-- Dumped from database version 16.8
-- Dumped by pg_dump version 16.8

-- Started on 2025-05-05 17:13:13

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

DROP DATABASE IF EXISTS schedule;
--
-- TOC entry 4995 (class 1262 OID 16398)
-- Name: schedule; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE schedule WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'ru-RU';


ALTER DATABASE schedule OWNER TO postgres;

\connect schedule

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
-- TOC entry 6 (class 2615 OID 16399)
-- Name: hr; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA hr;


ALTER SCHEMA hr OWNER TO postgres;

--
-- TOC entry 7 (class 2615 OID 16400)
-- Name: schedule_for_students; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA schedule_for_students;


ALTER SCHEMA schedule_for_students OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 250 (class 1259 OID 16617)
-- Name: Classroom; Type: TABLE; Schema: schedule_for_students; Owner: postgres
--

CREATE TABLE schedule_for_students."Classroom" (
    classroom_number integer NOT NULL,
    seating_capacity integer NOT NULL,
    venue_id integer NOT NULL,
    room_type_id integer NOT NULL,
    department_id integer NOT NULL
);


ALTER TABLE schedule_for_students."Classroom" OWNER TO postgres;

--
-- TOC entry 249 (class 1259 OID 16616)
-- Name: Classroom_classroom_number_seq; Type: SEQUENCE; Schema: schedule_for_students; Owner: postgres
--

CREATE SEQUENCE schedule_for_students."Classroom_classroom_number_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE schedule_for_students."Classroom_classroom_number_seq" OWNER TO postgres;

--
-- TOC entry 4996 (class 0 OID 0)
-- Dependencies: 249
-- Name: Classroom_classroom_number_seq; Type: SEQUENCE OWNED BY; Schema: schedule_for_students; Owner: postgres
--

ALTER SEQUENCE schedule_for_students."Classroom_classroom_number_seq" OWNED BY schedule_for_students."Classroom".classroom_number;


--
-- TOC entry 218 (class 1259 OID 16402)
-- Name: Department; Type: TABLE; Schema: schedule_for_students; Owner: postgres
--

CREATE TABLE schedule_for_students."Department" (
    department_id integer NOT NULL,
    name character varying(100) NOT NULL
);


ALTER TABLE schedule_for_students."Department" OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 16461)
-- Name: Discipline; Type: TABLE; Schema: schedule_for_students; Owner: postgres
--

CREATE TABLE schedule_for_students."Discipline" (
    discipline_id integer NOT NULL,
    name character varying(100) NOT NULL,
    lecture_hours integer,
    practice_hours integer,
    lab_hours integer
);


ALTER TABLE schedule_for_students."Discipline" OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 16470)
-- Name: Discipline_StudyPlan; Type: TABLE; Schema: schedule_for_students; Owner: postgres
--

CREATE TABLE schedule_for_students."Discipline_StudyPlan" (
    discipline_studyplan_id integer NOT NULL,
    discipline_id integer NOT NULL,
    study_plan_id integer NOT NULL,
    semester integer NOT NULL,
    lesson_id integer,
    CONSTRAINT chk_semester CHECK (((semester >= 1) AND (semester <= 10)))
);


ALTER TABLE schedule_for_students."Discipline_StudyPlan" OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 16469)
-- Name: Discipline_StudyPlan_discipline_studyplan_id_seq; Type: SEQUENCE; Schema: schedule_for_students; Owner: postgres
--

CREATE SEQUENCE schedule_for_students."Discipline_StudyPlan_discipline_studyplan_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE schedule_for_students."Discipline_StudyPlan_discipline_studyplan_id_seq" OWNER TO postgres;

--
-- TOC entry 4997 (class 0 OID 0)
-- Dependencies: 227
-- Name: Discipline_StudyPlan_discipline_studyplan_id_seq; Type: SEQUENCE OWNED BY; Schema: schedule_for_students; Owner: postgres
--

ALTER SEQUENCE schedule_for_students."Discipline_StudyPlan_discipline_studyplan_id_seq" OWNED BY schedule_for_students."Discipline_StudyPlan".discipline_studyplan_id;


--
-- TOC entry 225 (class 1259 OID 16460)
-- Name: Discipline_discipline_id_seq; Type: SEQUENCE; Schema: schedule_for_students; Owner: postgres
--

CREATE SEQUENCE schedule_for_students."Discipline_discipline_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE schedule_for_students."Discipline_discipline_id_seq" OWNER TO postgres;

--
-- TOC entry 4998 (class 0 OID 0)
-- Dependencies: 225
-- Name: Discipline_discipline_id_seq; Type: SEQUENCE OWNED BY; Schema: schedule_for_students; Owner: postgres
--

ALTER SEQUENCE schedule_for_students."Discipline_discipline_id_seq" OWNED BY schedule_for_students."Discipline".discipline_id;


--
-- TOC entry 220 (class 1259 OID 16411)
-- Name: Study_Direction; Type: TABLE; Schema: schedule_for_students; Owner: postgres
--

CREATE TABLE schedule_for_students."Study_Direction" (
    study_direction_id integer NOT NULL,
    name character varying(100) NOT NULL,
    direction character varying(20)
);


ALTER TABLE schedule_for_students."Study_Direction" OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16410)
-- Name: Study_Direction _study_direction_id _seq; Type: SEQUENCE; Schema: schedule_for_students; Owner: postgres
--

CREATE SEQUENCE schedule_for_students."Study_Direction _study_direction_id _seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE schedule_for_students."Study_Direction _study_direction_id _seq" OWNER TO postgres;

--
-- TOC entry 4999 (class 0 OID 0)
-- Dependencies: 219
-- Name: Study_Direction _study_direction_id _seq; Type: SEQUENCE OWNED BY; Schema: schedule_for_students; Owner: postgres
--

ALTER SEQUENCE schedule_for_students."Study_Direction _study_direction_id _seq" OWNED BY schedule_for_students."Study_Direction".study_direction_id;


--
-- TOC entry 217 (class 1259 OID 16401)
-- Name: department_department_id_seq; Type: SEQUENCE; Schema: schedule_for_students; Owner: postgres
--

CREATE SEQUENCE schedule_for_students.department_department_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE schedule_for_students.department_department_id_seq OWNER TO postgres;

--
-- TOC entry 5000 (class 0 OID 0)
-- Dependencies: 217
-- Name: department_department_id_seq; Type: SEQUENCE OWNED BY; Schema: schedule_for_students; Owner: postgres
--

ALTER SEQUENCE schedule_for_students.department_department_id_seq OWNED BY schedule_for_students."Department".department_id;


--
-- TOC entry 222 (class 1259 OID 16425)
-- Name: Educational_Program; Type: TABLE; Schema: schedule_for_students; Owner: postgres
--

CREATE TABLE schedule_for_students."Educational_Program" (
    department_id integer DEFAULT nextval('schedule_for_students.department_department_id_seq'::regclass) NOT NULL,
    study_direction_id integer DEFAULT nextval('schedule_for_students."Study_Direction _study_direction_id _seq"'::regclass) NOT NULL,
    name character varying(100) NOT NULL,
    program_id integer NOT NULL
);


ALTER TABLE schedule_for_students."Educational_Program" OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16424)
-- Name: Educational_Program_program_id _seq; Type: SEQUENCE; Schema: schedule_for_students; Owner: postgres
--

CREATE SEQUENCE schedule_for_students."Educational_Program_program_id _seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE schedule_for_students."Educational_Program_program_id _seq" OWNER TO postgres;

--
-- TOC entry 5001 (class 0 OID 0)
-- Dependencies: 221
-- Name: Educational_Program_program_id _seq; Type: SEQUENCE OWNED BY; Schema: schedule_for_students; Owner: postgres
--

ALTER SEQUENCE schedule_for_students."Educational_Program_program_id _seq" OWNED BY schedule_for_students."Educational_Program".program_id;


--
-- TOC entry 252 (class 1259 OID 16639)
-- Name: Lesson; Type: TABLE; Schema: schedule_for_students; Owner: postgres
--

CREATE TABLE schedule_for_students."Lesson" (
    lesson_id integer NOT NULL,
    start_datetime timestamp with time zone NOT NULL,
    end_datetime timestamp with time zone NOT NULL,
    teacher_id integer NOT NULL,
    lesson_type_id integer NOT NULL,
    discipline_id integer NOT NULL,
    group_id integer NOT NULL,
    classroom_number integer NOT NULL
);


ALTER TABLE schedule_for_students."Lesson" OWNER TO postgres;

--
-- TOC entry 244 (class 1259 OID 16589)
-- Name: Lesson_Type; Type: TABLE; Schema: schedule_for_students; Owner: postgres
--

CREATE TABLE schedule_for_students."Lesson_Type" (
    lesson_type_id integer NOT NULL,
    lesson_type_name character varying(50) NOT NULL
);


ALTER TABLE schedule_for_students."Lesson_Type" OWNER TO postgres;

--
-- TOC entry 243 (class 1259 OID 16588)
-- Name: Lesson_Type_lesson_type_id_seq; Type: SEQUENCE; Schema: schedule_for_students; Owner: postgres
--

CREATE SEQUENCE schedule_for_students."Lesson_Type_lesson_type_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE schedule_for_students."Lesson_Type_lesson_type_id_seq" OWNER TO postgres;

--
-- TOC entry 5002 (class 0 OID 0)
-- Dependencies: 243
-- Name: Lesson_Type_lesson_type_id_seq; Type: SEQUENCE OWNED BY; Schema: schedule_for_students; Owner: postgres
--

ALTER SEQUENCE schedule_for_students."Lesson_Type_lesson_type_id_seq" OWNED BY schedule_for_students."Lesson_Type".lesson_type_id;


--
-- TOC entry 251 (class 1259 OID 16638)
-- Name: Lesson_lesson_id_seq; Type: SEQUENCE; Schema: schedule_for_students; Owner: postgres
--

CREATE SEQUENCE schedule_for_students."Lesson_lesson_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE schedule_for_students."Lesson_lesson_id_seq" OWNER TO postgres;

--
-- TOC entry 5003 (class 0 OID 0)
-- Dependencies: 251
-- Name: Lesson_lesson_id_seq; Type: SEQUENCE OWNED BY; Schema: schedule_for_students; Owner: postgres
--

ALTER SEQUENCE schedule_for_students."Lesson_lesson_id_seq" OWNED BY schedule_for_students."Lesson".lesson_id;


--
-- TOC entry 238 (class 1259 OID 16538)
-- Name: Position; Type: TABLE; Schema: schedule_for_students; Owner: postgres
--

CREATE TABLE schedule_for_students."Position" (
    position_id integer NOT NULL,
    position_name character varying(100) NOT NULL
);


ALTER TABLE schedule_for_students."Position" OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 16537)
-- Name: Position_position_id_seq; Type: SEQUENCE; Schema: schedule_for_students; Owner: postgres
--

CREATE SEQUENCE schedule_for_students."Position_position_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE schedule_for_students."Position_position_id_seq" OWNER TO postgres;

--
-- TOC entry 5004 (class 0 OID 0)
-- Dependencies: 237
-- Name: Position_position_id_seq; Type: SEQUENCE OWNED BY; Schema: schedule_for_students; Owner: postgres
--

ALTER SEQUENCE schedule_for_students."Position_position_id_seq" OWNED BY schedule_for_students."Position".position_id;


--
-- TOC entry 248 (class 1259 OID 16608)
-- Name: Room_Type; Type: TABLE; Schema: schedule_for_students; Owner: postgres
--

CREATE TABLE schedule_for_students."Room_Type" (
    room_type_id integer NOT NULL,
    room_type_name character varying(50) NOT NULL
);


ALTER TABLE schedule_for_students."Room_Type" OWNER TO postgres;

--
-- TOC entry 247 (class 1259 OID 16607)
-- Name: Room_Type_room_type_id_seq; Type: SEQUENCE; Schema: schedule_for_students; Owner: postgres
--

CREATE SEQUENCE schedule_for_students."Room_Type_room_type_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE schedule_for_students."Room_Type_room_type_id_seq" OWNER TO postgres;

--
-- TOC entry 5005 (class 0 OID 0)
-- Dependencies: 247
-- Name: Room_Type_room_type_id_seq; Type: SEQUENCE OWNED BY; Schema: schedule_for_students; Owner: postgres
--

ALTER SEQUENCE schedule_for_students."Room_Type_room_type_id_seq" OWNED BY schedule_for_students."Room_Type".room_type_id;


--
-- TOC entry 232 (class 1259 OID 16501)
-- Name: Student; Type: TABLE; Schema: schedule_for_students; Owner: postgres
--

CREATE TABLE schedule_for_students."Student" (
    student_id integer NOT NULL,
    full_name character varying(100) NOT NULL,
    gender character(1) NOT NULL,
    email character(100) NOT NULL,
    birth_date date NOT NULL
);


ALTER TABLE schedule_for_students."Student" OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 16488)
-- Name: Student_Group; Type: TABLE; Schema: schedule_for_students; Owner: postgres
--

CREATE TABLE schedule_for_students."Student_Group" (
    group_id integer NOT NULL,
    study_plan_id integer NOT NULL,
    start_date date,
    end_date date
);


ALTER TABLE schedule_for_students."Student_Group" OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 16510)
-- Name: Student_Group_Membership; Type: TABLE; Schema: schedule_for_students; Owner: postgres
--

CREATE TABLE schedule_for_students."Student_Group_Membership" (
    student_group_membership_id integer NOT NULL,
    group_id integer NOT NULL,
    student_id integer NOT NULL,
    membership_start_date date NOT NULL,
    membership_end_date date,
    status character varying(15),
    CONSTRAINT chk_membership_end_date CHECK (((membership_end_date > membership_start_date) OR (membership_end_date IS NULL))),
    CONSTRAINT chk_membership_start_date CHECK ((membership_start_date < CURRENT_DATE))
);


ALTER TABLE schedule_for_students."Student_Group_Membership" OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 16509)
-- Name: Student_Group_Membership_student_group_membership_id_seq; Type: SEQUENCE; Schema: schedule_for_students; Owner: postgres
--

CREATE SEQUENCE schedule_for_students."Student_Group_Membership_student_group_membership_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE schedule_for_students."Student_Group_Membership_student_group_membership_id_seq" OWNER TO postgres;

--
-- TOC entry 5006 (class 0 OID 0)
-- Dependencies: 233
-- Name: Student_Group_Membership_student_group_membership_id_seq; Type: SEQUENCE OWNED BY; Schema: schedule_for_students; Owner: postgres
--

ALTER SEQUENCE schedule_for_students."Student_Group_Membership_student_group_membership_id_seq" OWNED BY schedule_for_students."Student_Group_Membership".student_group_membership_id;


--
-- TOC entry 229 (class 1259 OID 16487)
-- Name: Student_Group_group_id_seq; Type: SEQUENCE; Schema: schedule_for_students; Owner: postgres
--

CREATE SEQUENCE schedule_for_students."Student_Group_group_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE schedule_for_students."Student_Group_group_id_seq" OWNER TO postgres;

--
-- TOC entry 5007 (class 0 OID 0)
-- Dependencies: 229
-- Name: Student_Group_group_id_seq; Type: SEQUENCE OWNED BY; Schema: schedule_for_students; Owner: postgres
--

ALTER SEQUENCE schedule_for_students."Student_Group_group_id_seq" OWNED BY schedule_for_students."Student_Group".group_id;


--
-- TOC entry 231 (class 1259 OID 16500)
-- Name: Student_student_id_seq; Type: SEQUENCE; Schema: schedule_for_students; Owner: postgres
--

CREATE SEQUENCE schedule_for_students."Student_student_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE schedule_for_students."Student_student_id_seq" OWNER TO postgres;

--
-- TOC entry 5008 (class 0 OID 0)
-- Dependencies: 231
-- Name: Student_student_id_seq; Type: SEQUENCE OWNED BY; Schema: schedule_for_students; Owner: postgres
--

ALTER SEQUENCE schedule_for_students."Student_student_id_seq" OWNED BY schedule_for_students."Student".student_id;


--
-- TOC entry 224 (class 1259 OID 16446)
-- Name: Study_Plan; Type: TABLE; Schema: schedule_for_students; Owner: postgres
--

CREATE TABLE schedule_for_students."Study_Plan" (
    study_plan_id integer NOT NULL,
    name character varying(100) NOT NULL,
    year_admitted integer NOT NULL,
    program_id integer NOT NULL,
    CONSTRAINT chk_year_admitted CHECK ((year_admitted > 2000))
);


ALTER TABLE schedule_for_students."Study_Plan" OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16445)
-- Name: Study_Plan_study_plan_id_seq; Type: SEQUENCE; Schema: schedule_for_students; Owner: postgres
--

CREATE SEQUENCE schedule_for_students."Study_Plan_study_plan_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE schedule_for_students."Study_Plan_study_plan_id_seq" OWNER TO postgres;

--
-- TOC entry 5009 (class 0 OID 0)
-- Dependencies: 223
-- Name: Study_Plan_study_plan_id_seq; Type: SEQUENCE OWNED BY; Schema: schedule_for_students; Owner: postgres
--

ALTER SEQUENCE schedule_for_students."Study_Plan_study_plan_id_seq" OWNED BY schedule_for_students."Study_Plan".study_plan_id;


--
-- TOC entry 236 (class 1259 OID 16529)
-- Name: Teacher; Type: TABLE; Schema: schedule_for_students; Owner: postgres
--

CREATE TABLE schedule_for_students."Teacher" (
    teacher_id integer NOT NULL,
    full_name character varying(100) NOT NULL
);


ALTER TABLE schedule_for_students."Teacher" OWNER TO postgres;

--
-- TOC entry 240 (class 1259 OID 16547)
-- Name: Teacher_Position; Type: TABLE; Schema: schedule_for_students; Owner: postgres
--

CREATE TABLE schedule_for_students."Teacher_Position" (
    teacher_position_id integer NOT NULL,
    position_id integer NOT NULL,
    teacher_id integer NOT NULL,
    start_date date NOT NULL,
    end_date date,
    CONSTRAINT chk_end_date CHECK (((end_date > start_date) OR (end_date IS NULL))),
    CONSTRAINT chk_start_date CHECK ((start_date <= CURRENT_DATE))
);


ALTER TABLE schedule_for_students."Teacher_Position" OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 16546)
-- Name: Teacher_Position_teacher_position_id_seq; Type: SEQUENCE; Schema: schedule_for_students; Owner: postgres
--

CREATE SEQUENCE schedule_for_students."Teacher_Position_teacher_position_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE schedule_for_students."Teacher_Position_teacher_position_id_seq" OWNER TO postgres;

--
-- TOC entry 5010 (class 0 OID 0)
-- Dependencies: 239
-- Name: Teacher_Position_teacher_position_id_seq; Type: SEQUENCE OWNED BY; Schema: schedule_for_students; Owner: postgres
--

ALTER SEQUENCE schedule_for_students."Teacher_Position_teacher_position_id_seq" OWNED BY schedule_for_students."Teacher_Position".teacher_position_id;


--
-- TOC entry 242 (class 1259 OID 16566)
-- Name: Teacher_Workload; Type: TABLE; Schema: schedule_for_students; Owner: postgres
--

CREATE TABLE schedule_for_students."Teacher_Workload" (
    workload_id integer NOT NULL,
    teacher_id integer NOT NULL,
    group_id integer NOT NULL,
    discipline_id integer NOT NULL,
    semester integer NOT NULL,
    study_plan_id integer
);


ALTER TABLE schedule_for_students."Teacher_Workload" OWNER TO postgres;

--
-- TOC entry 241 (class 1259 OID 16565)
-- Name: Teacher_Workload_workload_id_seq; Type: SEQUENCE; Schema: schedule_for_students; Owner: postgres
--

CREATE SEQUENCE schedule_for_students."Teacher_Workload_workload_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE schedule_for_students."Teacher_Workload_workload_id_seq" OWNER TO postgres;

--
-- TOC entry 5011 (class 0 OID 0)
-- Dependencies: 241
-- Name: Teacher_Workload_workload_id_seq; Type: SEQUENCE OWNED BY; Schema: schedule_for_students; Owner: postgres
--

ALTER SEQUENCE schedule_for_students."Teacher_Workload_workload_id_seq" OWNED BY schedule_for_students."Teacher_Workload".workload_id;


--
-- TOC entry 235 (class 1259 OID 16528)
-- Name: Teacher_teacher_id_seq; Type: SEQUENCE; Schema: schedule_for_students; Owner: postgres
--

CREATE SEQUENCE schedule_for_students."Teacher_teacher_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE schedule_for_students."Teacher_teacher_id_seq" OWNER TO postgres;

--
-- TOC entry 5012 (class 0 OID 0)
-- Dependencies: 235
-- Name: Teacher_teacher_id_seq; Type: SEQUENCE OWNED BY; Schema: schedule_for_students; Owner: postgres
--

ALTER SEQUENCE schedule_for_students."Teacher_teacher_id_seq" OWNED BY schedule_for_students."Teacher".teacher_id;


--
-- TOC entry 246 (class 1259 OID 16599)
-- Name: Venue; Type: TABLE; Schema: schedule_for_students; Owner: postgres
--

CREATE TABLE schedule_for_students."Venue" (
    venue_id integer NOT NULL,
    name character varying(100) NOT NULL,
    address character varying(200) NOT NULL
);


ALTER TABLE schedule_for_students."Venue" OWNER TO postgres;

--
-- TOC entry 245 (class 1259 OID 16598)
-- Name: Venue_venue_id_seq; Type: SEQUENCE; Schema: schedule_for_students; Owner: postgres
--

CREATE SEQUENCE schedule_for_students."Venue_venue_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE schedule_for_students."Venue_venue_id_seq" OWNER TO postgres;

--
-- TOC entry 5013 (class 0 OID 0)
-- Dependencies: 245
-- Name: Venue_venue_id_seq; Type: SEQUENCE OWNED BY; Schema: schedule_for_students; Owner: postgres
--

ALTER SEQUENCE schedule_for_students."Venue_venue_id_seq" OWNED BY schedule_for_students."Venue".venue_id;


--
-- TOC entry 4739 (class 2604 OID 16620)
-- Name: Classroom classroom_number; Type: DEFAULT; Schema: schedule_for_students; Owner: postgres
--

ALTER TABLE ONLY schedule_for_students."Classroom" ALTER COLUMN classroom_number SET DEFAULT nextval('schedule_for_students."Classroom_classroom_number_seq"'::regclass);


--
-- TOC entry 4721 (class 2604 OID 16831)
-- Name: Department department_id; Type: DEFAULT; Schema: schedule_for_students; Owner: postgres
--

ALTER TABLE ONLY schedule_for_students."Department" ALTER COLUMN department_id SET DEFAULT nextval('schedule_for_students.department_department_id_seq'::regclass);


--
-- TOC entry 4727 (class 2604 OID 16464)
-- Name: Discipline discipline_id; Type: DEFAULT; Schema: schedule_for_students; Owner: postgres
--

ALTER TABLE ONLY schedule_for_students."Discipline" ALTER COLUMN discipline_id SET DEFAULT nextval('schedule_for_students."Discipline_discipline_id_seq"'::regclass);


--
-- TOC entry 4728 (class 2604 OID 16473)
-- Name: Discipline_StudyPlan discipline_studyplan_id; Type: DEFAULT; Schema: schedule_for_students; Owner: postgres
--

ALTER TABLE ONLY schedule_for_students."Discipline_StudyPlan" ALTER COLUMN discipline_studyplan_id SET DEFAULT nextval('schedule_for_students."Discipline_StudyPlan_discipline_studyplan_id_seq"'::regclass);


--
-- TOC entry 4725 (class 2604 OID 16430)
-- Name: Educational_Program program_id; Type: DEFAULT; Schema: schedule_for_students; Owner: postgres
--

ALTER TABLE ONLY schedule_for_students."Educational_Program" ALTER COLUMN program_id SET DEFAULT nextval('schedule_for_students."Educational_Program_program_id _seq"'::regclass);


--
-- TOC entry 4740 (class 2604 OID 16642)
-- Name: Lesson lesson_id; Type: DEFAULT; Schema: schedule_for_students; Owner: postgres
--

ALTER TABLE ONLY schedule_for_students."Lesson" ALTER COLUMN lesson_id SET DEFAULT nextval('schedule_for_students."Lesson_lesson_id_seq"'::regclass);


--
-- TOC entry 4736 (class 2604 OID 16592)
-- Name: Lesson_Type lesson_type_id; Type: DEFAULT; Schema: schedule_for_students; Owner: postgres
--

ALTER TABLE ONLY schedule_for_students."Lesson_Type" ALTER COLUMN lesson_type_id SET DEFAULT nextval('schedule_for_students."Lesson_Type_lesson_type_id_seq"'::regclass);


--
-- TOC entry 4733 (class 2604 OID 16541)
-- Name: Position position_id; Type: DEFAULT; Schema: schedule_for_students; Owner: postgres
--

ALTER TABLE ONLY schedule_for_students."Position" ALTER COLUMN position_id SET DEFAULT nextval('schedule_for_students."Position_position_id_seq"'::regclass);


--
-- TOC entry 4738 (class 2604 OID 16611)
-- Name: Room_Type room_type_id; Type: DEFAULT; Schema: schedule_for_students; Owner: postgres
--

ALTER TABLE ONLY schedule_for_students."Room_Type" ALTER COLUMN room_type_id SET DEFAULT nextval('schedule_for_students."Room_Type_room_type_id_seq"'::regclass);


--
-- TOC entry 4730 (class 2604 OID 16504)
-- Name: Student student_id; Type: DEFAULT; Schema: schedule_for_students; Owner: postgres
--

ALTER TABLE ONLY schedule_for_students."Student" ALTER COLUMN student_id SET DEFAULT nextval('schedule_for_students."Student_student_id_seq"'::regclass);


--
-- TOC entry 4729 (class 2604 OID 16491)
-- Name: Student_Group group_id; Type: DEFAULT; Schema: schedule_for_students; Owner: postgres
--

ALTER TABLE ONLY schedule_for_students."Student_Group" ALTER COLUMN group_id SET DEFAULT nextval('schedule_for_students."Student_Group_group_id_seq"'::regclass);


--
-- TOC entry 4731 (class 2604 OID 16513)
-- Name: Student_Group_Membership student_group_membership_id; Type: DEFAULT; Schema: schedule_for_students; Owner: postgres
--

ALTER TABLE ONLY schedule_for_students."Student_Group_Membership" ALTER COLUMN student_group_membership_id SET DEFAULT nextval('schedule_for_students."Student_Group_Membership_student_group_membership_id_seq"'::regclass);


--
-- TOC entry 4722 (class 2604 OID 16414)
-- Name: Study_Direction study_direction_id; Type: DEFAULT; Schema: schedule_for_students; Owner: postgres
--

ALTER TABLE ONLY schedule_for_students."Study_Direction" ALTER COLUMN study_direction_id SET DEFAULT nextval('schedule_for_students."Study_Direction _study_direction_id _seq"'::regclass);


--
-- TOC entry 4726 (class 2604 OID 16449)
-- Name: Study_Plan study_plan_id; Type: DEFAULT; Schema: schedule_for_students; Owner: postgres
--

ALTER TABLE ONLY schedule_for_students."Study_Plan" ALTER COLUMN study_plan_id SET DEFAULT nextval('schedule_for_students."Study_Plan_study_plan_id_seq"'::regclass);


--
-- TOC entry 4732 (class 2604 OID 16532)
-- Name: Teacher teacher_id; Type: DEFAULT; Schema: schedule_for_students; Owner: postgres
--

ALTER TABLE ONLY schedule_for_students."Teacher" ALTER COLUMN teacher_id SET DEFAULT nextval('schedule_for_students."Teacher_teacher_id_seq"'::regclass);


--
-- TOC entry 4734 (class 2604 OID 16550)
-- Name: Teacher_Position teacher_position_id; Type: DEFAULT; Schema: schedule_for_students; Owner: postgres
--

ALTER TABLE ONLY schedule_for_students."Teacher_Position" ALTER COLUMN teacher_position_id SET DEFAULT nextval('schedule_for_students."Teacher_Position_teacher_position_id_seq"'::regclass);


--
-- TOC entry 4735 (class 2604 OID 16569)
-- Name: Teacher_Workload workload_id; Type: DEFAULT; Schema: schedule_for_students; Owner: postgres
--

ALTER TABLE ONLY schedule_for_students."Teacher_Workload" ALTER COLUMN workload_id SET DEFAULT nextval('schedule_for_students."Teacher_Workload_workload_id_seq"'::regclass);


--
-- TOC entry 4737 (class 2604 OID 16602)
-- Name: Venue venue_id; Type: DEFAULT; Schema: schedule_for_students; Owner: postgres
--

ALTER TABLE ONLY schedule_for_students."Venue" ALTER COLUMN venue_id SET DEFAULT nextval('schedule_for_students."Venue_venue_id_seq"'::regclass);


--
-- TOC entry 4987 (class 0 OID 16617)
-- Dependencies: 250
-- Data for Name: Classroom; Type: TABLE DATA; Schema: schedule_for_students; Owner: postgres
--

INSERT INTO schedule_for_students."Classroom" (classroom_number, seating_capacity, venue_id, room_type_id, department_id) VALUES (1, 120, 1, 1, 1);


--
-- TOC entry 4955 (class 0 OID 16402)
-- Dependencies: 218
-- Data for Name: Department; Type: TABLE DATA; Schema: schedule_for_students; Owner: postgres
--

INSERT INTO schedule_for_students."Department" (department_id, name) VALUES (1, 'Engineering Faculty');


--
-- TOC entry 4963 (class 0 OID 16461)
-- Dependencies: 226
-- Data for Name: Discipline; Type: TABLE DATA; Schema: schedule_for_students; Owner: postgres
--

INSERT INTO schedule_for_students."Discipline" (discipline_id, name, lecture_hours, practice_hours, lab_hours) VALUES (1, 'Engineering Basics', NULL, NULL, NULL);


--
-- TOC entry 4965 (class 0 OID 16470)
-- Dependencies: 228
-- Data for Name: Discipline_StudyPlan; Type: TABLE DATA; Schema: schedule_for_students; Owner: postgres
--

INSERT INTO schedule_for_students."Discipline_StudyPlan" (discipline_studyplan_id, discipline_id, study_plan_id, semester, lesson_id) VALUES (1, 1, 2, 1, NULL);


--
-- TOC entry 4959 (class 0 OID 16425)
-- Dependencies: 222
-- Data for Name: Educational_Program; Type: TABLE DATA; Schema: schedule_for_students; Owner: postgres
--

INSERT INTO schedule_for_students."Educational_Program" (department_id, study_direction_id, name, program_id) VALUES (1, 3, 'BEng General', 3);


--
-- TOC entry 4989 (class 0 OID 16639)
-- Dependencies: 252
-- Data for Name: Lesson; Type: TABLE DATA; Schema: schedule_for_students; Owner: postgres
--

INSERT INTO schedule_for_students."Lesson" (lesson_id, start_datetime, end_datetime, teacher_id, lesson_type_id, discipline_id, group_id, classroom_number) VALUES (2, '2023-09-10 10:00:00+03', '2023-09-10 11:30:00+03', 1, 1, 1, 1, 1);
INSERT INTO schedule_for_students."Lesson" (lesson_id, start_datetime, end_datetime, teacher_id, lesson_type_id, discipline_id, group_id, classroom_number) VALUES (3, '2023-09-10 12:00:00+03', '2023-09-10 13:30:00+03', 1, 1, 1, 2, 1);
INSERT INTO schedule_for_students."Lesson" (lesson_id, start_datetime, end_datetime, teacher_id, lesson_type_id, discipline_id, group_id, classroom_number) VALUES (4, '2023-09-10 14:00:00+03', '2023-09-10 15:30:00+03', 1, 1, 1, 3, 1);


--
-- TOC entry 4981 (class 0 OID 16589)
-- Dependencies: 244
-- Data for Name: Lesson_Type; Type: TABLE DATA; Schema: schedule_for_students; Owner: postgres
--

INSERT INTO schedule_for_students."Lesson_Type" (lesson_type_id, lesson_type_name) VALUES (1, 'Lecture');


--
-- TOC entry 4975 (class 0 OID 16538)
-- Dependencies: 238
-- Data for Name: Position; Type: TABLE DATA; Schema: schedule_for_students; Owner: postgres
--

INSERT INTO schedule_for_students."Position" (position_id, position_name) VALUES (1, 'Professor');


--
-- TOC entry 4985 (class 0 OID 16608)
-- Dependencies: 248
-- Data for Name: Room_Type; Type: TABLE DATA; Schema: schedule_for_students; Owner: postgres
--

INSERT INTO schedule_for_students."Room_Type" (room_type_id, room_type_name) VALUES (1, 'Lecture Hall');


--
-- TOC entry 4969 (class 0 OID 16501)
-- Dependencies: 232
-- Data for Name: Student; Type: TABLE DATA; Schema: schedule_for_students; Owner: postgres
--

INSERT INTO schedule_for_students."Student" (student_id, full_name, gender, email, birth_date) VALUES (1, 'Ivanov Ivan Ivanovich', 'M', 'ivanov1@example.com                                                                                 ', '2002-01-15');
INSERT INTO schedule_for_students."Student" (student_id, full_name, gender, email, birth_date) VALUES (2, 'Petrova Maria Sergeevna', 'F', 'petrova2@example.com                                                                                ', '2003-05-21');
INSERT INTO schedule_for_students."Student" (student_id, full_name, gender, email, birth_date) VALUES (3, 'Sidorov Alexey Petrovich', 'M', 'sidorov3@example.com                                                                                ', '2001-09-10');
INSERT INTO schedule_for_students."Student" (student_id, full_name, gender, email, birth_date) VALUES (4, 'Smirnova Olga Viktorovna', 'F', 'smirnova4@example.com                                                                               ', '2004-02-05');
INSERT INTO schedule_for_students."Student" (student_id, full_name, gender, email, birth_date) VALUES (5, 'Kuznetsov Nikolay Egorovich', 'M', 'kuznetsov5@example.com                                                                              ', '2002-12-12');
INSERT INTO schedule_for_students."Student" (student_id, full_name, gender, email, birth_date) VALUES (6, 'Popova Elena Pavlovna', 'F', 'popova6@example.com                                                                                 ', '2003-03-18');
INSERT INTO schedule_for_students."Student" (student_id, full_name, gender, email, birth_date) VALUES (7, 'Volkov Anton Andreevich', 'M', 'volkov7@example.com                                                                                 ', '2000-07-07');
INSERT INTO schedule_for_students."Student" (student_id, full_name, gender, email, birth_date) VALUES (8, 'Fedorova Anastasia Dmitrievna', 'F', 'fedorova8@example.com                                                                               ', '2001-10-25');
INSERT INTO schedule_for_students."Student" (student_id, full_name, gender, email, birth_date) VALUES (9, 'Semenov Artem Olegovich', 'M', 'semenov9@example.com                                                                                ', '2002-04-14');
INSERT INTO schedule_for_students."Student" (student_id, full_name, gender, email, birth_date) VALUES (10, 'Morozova Daria Alekseevna', 'F', 'morozova10@example.com                                                                              ', '2003-06-30');
INSERT INTO schedule_for_students."Student" (student_id, full_name, gender, email, birth_date) VALUES (11, 'Michelle Vazquez', 'F', 'robertmendez@wilson.com                                                                             ', '2005-02-08');
INSERT INTO schedule_for_students."Student" (student_id, full_name, gender, email, birth_date) VALUES (12, 'Patty Blackburn', 'M', 'sherriandrade@gmail.com                                                                             ', '2004-03-22');
INSERT INTO schedule_for_students."Student" (student_id, full_name, gender, email, birth_date) VALUES (13, 'Stacey Wilkins', 'F', 'bhernandez@hotmail.com                                                                              ', '2002-03-07');
INSERT INTO schedule_for_students."Student" (student_id, full_name, gender, email, birth_date) VALUES (14, 'David Adams', 'M', 'ftaylor@hicks-little.info                                                                           ', '2003-01-06');
INSERT INTO schedule_for_students."Student" (student_id, full_name, gender, email, birth_date) VALUES (15, 'Brandon Smith', 'F', 'rodriguezkeith@ware-odonnell.org                                                                    ', '2005-12-29');
INSERT INTO schedule_for_students."Student" (student_id, full_name, gender, email, birth_date) VALUES (16, 'Cynthia Singh', 'M', 'dwillis@carroll.biz                                                                                 ', '2001-06-20');
INSERT INTO schedule_for_students."Student" (student_id, full_name, gender, email, birth_date) VALUES (17, 'John Willis', 'F', 'snyderphillip@hotmail.com                                                                           ', '2004-02-24');
INSERT INTO schedule_for_students."Student" (student_id, full_name, gender, email, birth_date) VALUES (18, 'Brenda Bowen', 'F', 'nelsonjohnson@wright.com                                                                            ', '2000-11-29');
INSERT INTO schedule_for_students."Student" (student_id, full_name, gender, email, birth_date) VALUES (19, 'Kelly Hodge', 'M', 'madison96@bell.com                                                                                  ', '2003-08-02');
INSERT INTO schedule_for_students."Student" (student_id, full_name, gender, email, birth_date) VALUES (20, 'Timothy Jones', 'F', 'lawrencegordon@hotmail.com                                                                          ', '2002-09-30');
INSERT INTO schedule_for_students."Student" (student_id, full_name, gender, email, birth_date) VALUES (21, 'Crystal Bell', 'F', 'john78@mitchell.com                                                                                 ', '2000-08-24');
INSERT INTO schedule_for_students."Student" (student_id, full_name, gender, email, birth_date) VALUES (22, 'James Maldonado', 'M', 'leekaren@yahoo.com                                                                                  ', '2000-12-12');
INSERT INTO schedule_for_students."Student" (student_id, full_name, gender, email, birth_date) VALUES (23, 'Karen Rowe', 'F', 'mark33@garcia.com                                                                                   ', '2000-05-07');
INSERT INTO schedule_for_students."Student" (student_id, full_name, gender, email, birth_date) VALUES (24, 'Kimberly Gonzalez', 'M', 'paul21@prince.org                                                                                   ', '2002-11-04');
INSERT INTO schedule_for_students."Student" (student_id, full_name, gender, email, birth_date) VALUES (25, 'Chris Burke', 'F', 'kimberlygomez@jenkins.org                                                                           ', '2003-12-02');
INSERT INTO schedule_for_students."Student" (student_id, full_name, gender, email, birth_date) VALUES (26, 'Barbara Howard', 'F', 'holmesanthony@howard.com                                                                            ', '2004-05-29');
INSERT INTO schedule_for_students."Student" (student_id, full_name, gender, email, birth_date) VALUES (27, 'Gregory Wilkinson', 'F', 'harrislaura@williams.com                                                                            ', '2004-04-14');
INSERT INTO schedule_for_students."Student" (student_id, full_name, gender, email, birth_date) VALUES (28, 'Andrea Tucker', 'M', 'melinda13@johnson-johnson.org                                                                       ', '2002-01-23');
INSERT INTO schedule_for_students."Student" (student_id, full_name, gender, email, birth_date) VALUES (29, 'Erin Fitzgerald', 'M', 'tiffany38@yahoo.com                                                                                 ', '2003-06-01');
INSERT INTO schedule_for_students."Student" (student_id, full_name, gender, email, birth_date) VALUES (30, 'Brittany Evans', 'F', 'daniel95@gmail.com                                                                                  ', '2001-09-15');
INSERT INTO schedule_for_students."Student" (student_id, full_name, gender, email, birth_date) VALUES (31, 'Lindsey Guerra', 'F', 'greenadam@hunt-martin.com                                                                           ', '2003-02-20');
INSERT INTO schedule_for_students."Student" (student_id, full_name, gender, email, birth_date) VALUES (32, 'Lori Lee', 'F', 'michaelcarter@hotmail.com                                                                           ', '2000-02-18');
INSERT INTO schedule_for_students."Student" (student_id, full_name, gender, email, birth_date) VALUES (33, 'Eric Chandler', 'F', 'heatherjackson@clarke.com                                                                           ', '2003-04-19');
INSERT INTO schedule_for_students."Student" (student_id, full_name, gender, email, birth_date) VALUES (34, 'Daniel Mendez', 'M', 'vanessa27@hotmail.com                                                                               ', '2004-06-22');
INSERT INTO schedule_for_students."Student" (student_id, full_name, gender, email, birth_date) VALUES (35, 'Julie Horton', 'F', 'helen58@moore.com                                                                                   ', '2000-06-17');
INSERT INTO schedule_for_students."Student" (student_id, full_name, gender, email, birth_date) VALUES (36, 'Tina Chan', 'F', 'randy65@rice.com                                                                                    ', '2002-07-12');


--
-- TOC entry 4967 (class 0 OID 16488)
-- Dependencies: 230
-- Data for Name: Student_Group; Type: TABLE DATA; Schema: schedule_for_students; Owner: postgres
--

INSERT INTO schedule_for_students."Student_Group" (group_id, study_plan_id, start_date, end_date) VALUES (1, 2, NULL, NULL);
INSERT INTO schedule_for_students."Student_Group" (group_id, study_plan_id, start_date, end_date) VALUES (2, 2, NULL, NULL);
INSERT INTO schedule_for_students."Student_Group" (group_id, study_plan_id, start_date, end_date) VALUES (3, 2, NULL, NULL);


--
-- TOC entry 4971 (class 0 OID 16510)
-- Dependencies: 234
-- Data for Name: Student_Group_Membership; Type: TABLE DATA; Schema: schedule_for_students; Owner: postgres
--

INSERT INTO schedule_for_students."Student_Group_Membership" (student_group_membership_id, group_id, student_id, membership_start_date, membership_end_date, status) VALUES (1, 1, 12, '2023-09-01', NULL, NULL);
INSERT INTO schedule_for_students."Student_Group_Membership" (student_group_membership_id, group_id, student_id, membership_start_date, membership_end_date, status) VALUES (2, 1, 11, '2023-09-01', NULL, NULL);
INSERT INTO schedule_for_students."Student_Group_Membership" (student_group_membership_id, group_id, student_id, membership_start_date, membership_end_date, status) VALUES (3, 1, 10, '2023-09-01', NULL, NULL);
INSERT INTO schedule_for_students."Student_Group_Membership" (student_group_membership_id, group_id, student_id, membership_start_date, membership_end_date, status) VALUES (4, 1, 9, '2023-09-01', NULL, NULL);
INSERT INTO schedule_for_students."Student_Group_Membership" (student_group_membership_id, group_id, student_id, membership_start_date, membership_end_date, status) VALUES (5, 1, 8, '2023-09-01', NULL, NULL);
INSERT INTO schedule_for_students."Student_Group_Membership" (student_group_membership_id, group_id, student_id, membership_start_date, membership_end_date, status) VALUES (6, 1, 7, '2023-09-01', NULL, NULL);
INSERT INTO schedule_for_students."Student_Group_Membership" (student_group_membership_id, group_id, student_id, membership_start_date, membership_end_date, status) VALUES (7, 1, 6, '2023-09-01', NULL, NULL);
INSERT INTO schedule_for_students."Student_Group_Membership" (student_group_membership_id, group_id, student_id, membership_start_date, membership_end_date, status) VALUES (8, 1, 5, '2023-09-01', NULL, NULL);
INSERT INTO schedule_for_students."Student_Group_Membership" (student_group_membership_id, group_id, student_id, membership_start_date, membership_end_date, status) VALUES (9, 1, 4, '2023-09-01', NULL, NULL);
INSERT INTO schedule_for_students."Student_Group_Membership" (student_group_membership_id, group_id, student_id, membership_start_date, membership_end_date, status) VALUES (10, 1, 3, '2023-09-01', NULL, NULL);
INSERT INTO schedule_for_students."Student_Group_Membership" (student_group_membership_id, group_id, student_id, membership_start_date, membership_end_date, status) VALUES (11, 1, 2, '2023-09-01', NULL, NULL);
INSERT INTO schedule_for_students."Student_Group_Membership" (student_group_membership_id, group_id, student_id, membership_start_date, membership_end_date, status) VALUES (12, 1, 1, '2023-09-01', NULL, NULL);
INSERT INTO schedule_for_students."Student_Group_Membership" (student_group_membership_id, group_id, student_id, membership_start_date, membership_end_date, status) VALUES (13, 2, 24, '2023-09-01', NULL, NULL);
INSERT INTO schedule_for_students."Student_Group_Membership" (student_group_membership_id, group_id, student_id, membership_start_date, membership_end_date, status) VALUES (14, 2, 23, '2023-09-01', NULL, NULL);
INSERT INTO schedule_for_students."Student_Group_Membership" (student_group_membership_id, group_id, student_id, membership_start_date, membership_end_date, status) VALUES (15, 2, 22, '2023-09-01', NULL, NULL);
INSERT INTO schedule_for_students."Student_Group_Membership" (student_group_membership_id, group_id, student_id, membership_start_date, membership_end_date, status) VALUES (16, 2, 21, '2023-09-01', NULL, NULL);
INSERT INTO schedule_for_students."Student_Group_Membership" (student_group_membership_id, group_id, student_id, membership_start_date, membership_end_date, status) VALUES (17, 2, 20, '2023-09-01', NULL, NULL);
INSERT INTO schedule_for_students."Student_Group_Membership" (student_group_membership_id, group_id, student_id, membership_start_date, membership_end_date, status) VALUES (18, 2, 19, '2023-09-01', NULL, NULL);
INSERT INTO schedule_for_students."Student_Group_Membership" (student_group_membership_id, group_id, student_id, membership_start_date, membership_end_date, status) VALUES (19, 2, 18, '2023-09-01', NULL, NULL);
INSERT INTO schedule_for_students."Student_Group_Membership" (student_group_membership_id, group_id, student_id, membership_start_date, membership_end_date, status) VALUES (20, 2, 17, '2023-09-01', NULL, NULL);
INSERT INTO schedule_for_students."Student_Group_Membership" (student_group_membership_id, group_id, student_id, membership_start_date, membership_end_date, status) VALUES (21, 2, 16, '2023-09-01', NULL, NULL);
INSERT INTO schedule_for_students."Student_Group_Membership" (student_group_membership_id, group_id, student_id, membership_start_date, membership_end_date, status) VALUES (22, 2, 15, '2023-09-01', NULL, NULL);
INSERT INTO schedule_for_students."Student_Group_Membership" (student_group_membership_id, group_id, student_id, membership_start_date, membership_end_date, status) VALUES (23, 2, 14, '2023-09-01', NULL, NULL);
INSERT INTO schedule_for_students."Student_Group_Membership" (student_group_membership_id, group_id, student_id, membership_start_date, membership_end_date, status) VALUES (24, 2, 13, '2023-09-01', NULL, NULL);
INSERT INTO schedule_for_students."Student_Group_Membership" (student_group_membership_id, group_id, student_id, membership_start_date, membership_end_date, status) VALUES (25, 3, 36, '2023-09-01', NULL, NULL);
INSERT INTO schedule_for_students."Student_Group_Membership" (student_group_membership_id, group_id, student_id, membership_start_date, membership_end_date, status) VALUES (26, 3, 35, '2023-09-01', NULL, NULL);
INSERT INTO schedule_for_students."Student_Group_Membership" (student_group_membership_id, group_id, student_id, membership_start_date, membership_end_date, status) VALUES (27, 3, 34, '2023-09-01', NULL, NULL);
INSERT INTO schedule_for_students."Student_Group_Membership" (student_group_membership_id, group_id, student_id, membership_start_date, membership_end_date, status) VALUES (28, 3, 33, '2023-09-01', NULL, NULL);
INSERT INTO schedule_for_students."Student_Group_Membership" (student_group_membership_id, group_id, student_id, membership_start_date, membership_end_date, status) VALUES (29, 3, 32, '2023-09-01', NULL, NULL);
INSERT INTO schedule_for_students."Student_Group_Membership" (student_group_membership_id, group_id, student_id, membership_start_date, membership_end_date, status) VALUES (30, 3, 31, '2023-09-01', NULL, NULL);
INSERT INTO schedule_for_students."Student_Group_Membership" (student_group_membership_id, group_id, student_id, membership_start_date, membership_end_date, status) VALUES (31, 3, 30, '2023-09-01', NULL, NULL);
INSERT INTO schedule_for_students."Student_Group_Membership" (student_group_membership_id, group_id, student_id, membership_start_date, membership_end_date, status) VALUES (32, 3, 29, '2023-09-01', NULL, NULL);
INSERT INTO schedule_for_students."Student_Group_Membership" (student_group_membership_id, group_id, student_id, membership_start_date, membership_end_date, status) VALUES (33, 3, 28, '2023-09-01', NULL, NULL);
INSERT INTO schedule_for_students."Student_Group_Membership" (student_group_membership_id, group_id, student_id, membership_start_date, membership_end_date, status) VALUES (34, 3, 27, '2023-09-01', NULL, NULL);
INSERT INTO schedule_for_students."Student_Group_Membership" (student_group_membership_id, group_id, student_id, membership_start_date, membership_end_date, status) VALUES (35, 3, 26, '2023-09-01', NULL, NULL);
INSERT INTO schedule_for_students."Student_Group_Membership" (student_group_membership_id, group_id, student_id, membership_start_date, membership_end_date, status) VALUES (36, 3, 25, '2023-09-01', NULL, NULL);


--
-- TOC entry 4957 (class 0 OID 16411)
-- Dependencies: 220
-- Data for Name: Study_Direction; Type: TABLE DATA; Schema: schedule_for_students; Owner: postgres
--

INSERT INTO schedule_for_students."Study_Direction" (study_direction_id, name, direction) VALUES (3, 'Engineering', NULL);


--
-- TOC entry 4961 (class 0 OID 16446)
-- Dependencies: 224
-- Data for Name: Study_Plan; Type: TABLE DATA; Schema: schedule_for_students; Owner: postgres
--

INSERT INTO schedule_for_students."Study_Plan" (study_plan_id, name, year_admitted, program_id) VALUES (2, 'Engineering', 2023, 3);


--
-- TOC entry 4973 (class 0 OID 16529)
-- Dependencies: 236
-- Data for Name: Teacher; Type: TABLE DATA; Schema: schedule_for_students; Owner: postgres
--

INSERT INTO schedule_for_students."Teacher" (teacher_id, full_name) VALUES (1, 'Ivanova Maria Andreevna');


--
-- TOC entry 4977 (class 0 OID 16547)
-- Dependencies: 240
-- Data for Name: Teacher_Position; Type: TABLE DATA; Schema: schedule_for_students; Owner: postgres
--

INSERT INTO schedule_for_students."Teacher_Position" (teacher_position_id, position_id, teacher_id, start_date, end_date) VALUES (1, 1, 1, '2020-09-01', NULL);


--
-- TOC entry 4979 (class 0 OID 16566)
-- Dependencies: 242
-- Data for Name: Teacher_Workload; Type: TABLE DATA; Schema: schedule_for_students; Owner: postgres
--

INSERT INTO schedule_for_students."Teacher_Workload" (workload_id, teacher_id, group_id, discipline_id, semester, study_plan_id) VALUES (1, 1, 1, 1, 1, NULL);
INSERT INTO schedule_for_students."Teacher_Workload" (workload_id, teacher_id, group_id, discipline_id, semester, study_plan_id) VALUES (2, 1, 2, 1, 1, NULL);
INSERT INTO schedule_for_students."Teacher_Workload" (workload_id, teacher_id, group_id, discipline_id, semester, study_plan_id) VALUES (3, 1, 3, 1, 1, NULL);


--
-- TOC entry 4983 (class 0 OID 16599)
-- Dependencies: 246
-- Data for Name: Venue; Type: TABLE DATA; Schema: schedule_for_students; Owner: postgres
--

INSERT INTO schedule_for_students."Venue" (venue_id, name, address) VALUES (1, 'Main Campus', '1 University Ave');


--
-- TOC entry 5014 (class 0 OID 0)
-- Dependencies: 249
-- Name: Classroom_classroom_number_seq; Type: SEQUENCE SET; Schema: schedule_for_students; Owner: postgres
--

SELECT pg_catalog.setval('schedule_for_students."Classroom_classroom_number_seq"', 1, true);


--
-- TOC entry 5015 (class 0 OID 0)
-- Dependencies: 227
-- Name: Discipline_StudyPlan_discipline_studyplan_id_seq; Type: SEQUENCE SET; Schema: schedule_for_students; Owner: postgres
--

SELECT pg_catalog.setval('schedule_for_students."Discipline_StudyPlan_discipline_studyplan_id_seq"', 1, true);


--
-- TOC entry 5016 (class 0 OID 0)
-- Dependencies: 225
-- Name: Discipline_discipline_id_seq; Type: SEQUENCE SET; Schema: schedule_for_students; Owner: postgres
--

SELECT pg_catalog.setval('schedule_for_students."Discipline_discipline_id_seq"', 1, true);


--
-- TOC entry 5017 (class 0 OID 0)
-- Dependencies: 221
-- Name: Educational_Program_program_id _seq; Type: SEQUENCE SET; Schema: schedule_for_students; Owner: postgres
--

SELECT pg_catalog.setval('schedule_for_students."Educational_Program_program_id _seq"', 3, true);


--
-- TOC entry 5018 (class 0 OID 0)
-- Dependencies: 243
-- Name: Lesson_Type_lesson_type_id_seq; Type: SEQUENCE SET; Schema: schedule_for_students; Owner: postgres
--

SELECT pg_catalog.setval('schedule_for_students."Lesson_Type_lesson_type_id_seq"', 1, true);


--
-- TOC entry 5019 (class 0 OID 0)
-- Dependencies: 251
-- Name: Lesson_lesson_id_seq; Type: SEQUENCE SET; Schema: schedule_for_students; Owner: postgres
--

SELECT pg_catalog.setval('schedule_for_students."Lesson_lesson_id_seq"', 4, true);


--
-- TOC entry 5020 (class 0 OID 0)
-- Dependencies: 237
-- Name: Position_position_id_seq; Type: SEQUENCE SET; Schema: schedule_for_students; Owner: postgres
--

SELECT pg_catalog.setval('schedule_for_students."Position_position_id_seq"', 1, true);


--
-- TOC entry 5021 (class 0 OID 0)
-- Dependencies: 247
-- Name: Room_Type_room_type_id_seq; Type: SEQUENCE SET; Schema: schedule_for_students; Owner: postgres
--

SELECT pg_catalog.setval('schedule_for_students."Room_Type_room_type_id_seq"', 1, true);


--
-- TOC entry 5022 (class 0 OID 0)
-- Dependencies: 233
-- Name: Student_Group_Membership_student_group_membership_id_seq; Type: SEQUENCE SET; Schema: schedule_for_students; Owner: postgres
--

SELECT pg_catalog.setval('schedule_for_students."Student_Group_Membership_student_group_membership_id_seq"', 36, true);


--
-- TOC entry 5023 (class 0 OID 0)
-- Dependencies: 229
-- Name: Student_Group_group_id_seq; Type: SEQUENCE SET; Schema: schedule_for_students; Owner: postgres
--

SELECT pg_catalog.setval('schedule_for_students."Student_Group_group_id_seq"', 3, true);


--
-- TOC entry 5024 (class 0 OID 0)
-- Dependencies: 231
-- Name: Student_student_id_seq; Type: SEQUENCE SET; Schema: schedule_for_students; Owner: postgres
--

SELECT pg_catalog.setval('schedule_for_students."Student_student_id_seq"', 36, true);


--
-- TOC entry 5025 (class 0 OID 0)
-- Dependencies: 219
-- Name: Study_Direction _study_direction_id _seq; Type: SEQUENCE SET; Schema: schedule_for_students; Owner: postgres
--

SELECT pg_catalog.setval('schedule_for_students."Study_Direction _study_direction_id _seq"', 3, true);


--
-- TOC entry 5026 (class 0 OID 0)
-- Dependencies: 223
-- Name: Study_Plan_study_plan_id_seq; Type: SEQUENCE SET; Schema: schedule_for_students; Owner: postgres
--

SELECT pg_catalog.setval('schedule_for_students."Study_Plan_study_plan_id_seq"', 2, true);


--
-- TOC entry 5027 (class 0 OID 0)
-- Dependencies: 239
-- Name: Teacher_Position_teacher_position_id_seq; Type: SEQUENCE SET; Schema: schedule_for_students; Owner: postgres
--

SELECT pg_catalog.setval('schedule_for_students."Teacher_Position_teacher_position_id_seq"', 1, true);


--
-- TOC entry 5028 (class 0 OID 0)
-- Dependencies: 241
-- Name: Teacher_Workload_workload_id_seq; Type: SEQUENCE SET; Schema: schedule_for_students; Owner: postgres
--

SELECT pg_catalog.setval('schedule_for_students."Teacher_Workload_workload_id_seq"', 3, true);


--
-- TOC entry 5029 (class 0 OID 0)
-- Dependencies: 235
-- Name: Teacher_teacher_id_seq; Type: SEQUENCE SET; Schema: schedule_for_students; Owner: postgres
--

SELECT pg_catalog.setval('schedule_for_students."Teacher_teacher_id_seq"', 1, true);


--
-- TOC entry 5030 (class 0 OID 0)
-- Dependencies: 245
-- Name: Venue_venue_id_seq; Type: SEQUENCE SET; Schema: schedule_for_students; Owner: postgres
--

SELECT pg_catalog.setval('schedule_for_students."Venue_venue_id_seq"', 1, true);


--
-- TOC entry 5031 (class 0 OID 0)
-- Dependencies: 217
-- Name: department_department_id_seq; Type: SEQUENCE SET; Schema: schedule_for_students; Owner: postgres
--

SELECT pg_catalog.setval('schedule_for_students.department_department_id_seq', 3, true);


--
-- TOC entry 4785 (class 2606 OID 16622)
-- Name: Classroom Classroom_pkey; Type: CONSTRAINT; Schema: schedule_for_students; Owner: postgres
--

ALTER TABLE ONLY schedule_for_students."Classroom"
    ADD CONSTRAINT "Classroom_pkey" PRIMARY KEY (classroom_number);


--
-- TOC entry 4753 (class 2606 OID 16409)
-- Name: Department Department_pkey; Type: CONSTRAINT; Schema: schedule_for_students; Owner: postgres
--

ALTER TABLE ONLY schedule_for_students."Department"
    ADD CONSTRAINT "Department_pkey" PRIMARY KEY (department_id);


--
-- TOC entry 4763 (class 2606 OID 16476)
-- Name: Discipline_StudyPlan Discipline_StudyPlan_pkey; Type: CONSTRAINT; Schema: schedule_for_students; Owner: postgres
--

ALTER TABLE ONLY schedule_for_students."Discipline_StudyPlan"
    ADD CONSTRAINT "Discipline_StudyPlan_pkey" PRIMARY KEY (discipline_studyplan_id);


--
-- TOC entry 4761 (class 2606 OID 16468)
-- Name: Discipline Discipline_pkey; Type: CONSTRAINT; Schema: schedule_for_students; Owner: postgres
--

ALTER TABLE ONLY schedule_for_students."Discipline"
    ADD CONSTRAINT "Discipline_pkey" PRIMARY KEY (discipline_id);


--
-- TOC entry 4757 (class 2606 OID 16434)
-- Name: Educational_Program Educational_Program_pkey; Type: CONSTRAINT; Schema: schedule_for_students; Owner: postgres
--

ALTER TABLE ONLY schedule_for_students."Educational_Program"
    ADD CONSTRAINT "Educational_Program_pkey" PRIMARY KEY (program_id);


--
-- TOC entry 4779 (class 2606 OID 16596)
-- Name: Lesson_Type Lesson_Type_pkey; Type: CONSTRAINT; Schema: schedule_for_students; Owner: postgres
--

ALTER TABLE ONLY schedule_for_students."Lesson_Type"
    ADD CONSTRAINT "Lesson_Type_pkey" PRIMARY KEY (lesson_type_id);


--
-- TOC entry 4787 (class 2606 OID 16645)
-- Name: Lesson Lesson_pkey; Type: CONSTRAINT; Schema: schedule_for_students; Owner: postgres
--

ALTER TABLE ONLY schedule_for_students."Lesson"
    ADD CONSTRAINT "Lesson_pkey" PRIMARY KEY (lesson_id);


--
-- TOC entry 4773 (class 2606 OID 16545)
-- Name: Position Position_pkey; Type: CONSTRAINT; Schema: schedule_for_students; Owner: postgres
--

ALTER TABLE ONLY schedule_for_students."Position"
    ADD CONSTRAINT "Position_pkey" PRIMARY KEY (position_id);


--
-- TOC entry 4783 (class 2606 OID 16615)
-- Name: Room_Type Room_Type_pkey; Type: CONSTRAINT; Schema: schedule_for_students; Owner: postgres
--

ALTER TABLE ONLY schedule_for_students."Room_Type"
    ADD CONSTRAINT "Room_Type_pkey" PRIMARY KEY (room_type_id);


--
-- TOC entry 4769 (class 2606 OID 16517)
-- Name: Student_Group_Membership Student_Group_Membership_pkey; Type: CONSTRAINT; Schema: schedule_for_students; Owner: postgres
--

ALTER TABLE ONLY schedule_for_students."Student_Group_Membership"
    ADD CONSTRAINT "Student_Group_Membership_pkey" PRIMARY KEY (student_group_membership_id);


--
-- TOC entry 4765 (class 2606 OID 16494)
-- Name: Student_Group Student_Group_pkey; Type: CONSTRAINT; Schema: schedule_for_students; Owner: postgres
--

ALTER TABLE ONLY schedule_for_students."Student_Group"
    ADD CONSTRAINT "Student_Group_pkey" PRIMARY KEY (group_id);


--
-- TOC entry 4767 (class 2606 OID 16508)
-- Name: Student Student_pkey; Type: CONSTRAINT; Schema: schedule_for_students; Owner: postgres
--

ALTER TABLE ONLY schedule_for_students."Student"
    ADD CONSTRAINT "Student_pkey" PRIMARY KEY (student_id);


--
-- TOC entry 4755 (class 2606 OID 16418)
-- Name: Study_Direction Study_Direction _pkey; Type: CONSTRAINT; Schema: schedule_for_students; Owner: postgres
--

ALTER TABLE ONLY schedule_for_students."Study_Direction"
    ADD CONSTRAINT "Study_Direction _pkey" PRIMARY KEY (study_direction_id);


--
-- TOC entry 4759 (class 2606 OID 16454)
-- Name: Study_Plan Study_Plan_pkey; Type: CONSTRAINT; Schema: schedule_for_students; Owner: postgres
--

ALTER TABLE ONLY schedule_for_students."Study_Plan"
    ADD CONSTRAINT "Study_Plan_pkey" PRIMARY KEY (study_plan_id);


--
-- TOC entry 4775 (class 2606 OID 16554)
-- Name: Teacher_Position Teacher_Position_pkey; Type: CONSTRAINT; Schema: schedule_for_students; Owner: postgres
--

ALTER TABLE ONLY schedule_for_students."Teacher_Position"
    ADD CONSTRAINT "Teacher_Position_pkey" PRIMARY KEY (teacher_position_id);


--
-- TOC entry 4777 (class 2606 OID 16572)
-- Name: Teacher_Workload Teacher_Workload_pkey; Type: CONSTRAINT; Schema: schedule_for_students; Owner: postgres
--

ALTER TABLE ONLY schedule_for_students."Teacher_Workload"
    ADD CONSTRAINT "Teacher_Workload_pkey" PRIMARY KEY (workload_id);


--
-- TOC entry 4771 (class 2606 OID 16536)
-- Name: Teacher Teacher_pkey; Type: CONSTRAINT; Schema: schedule_for_students; Owner: postgres
--

ALTER TABLE ONLY schedule_for_students."Teacher"
    ADD CONSTRAINT "Teacher_pkey" PRIMARY KEY (teacher_id);


--
-- TOC entry 4781 (class 2606 OID 16606)
-- Name: Venue Venue_pkey; Type: CONSTRAINT; Schema: schedule_for_students; Owner: postgres
--

ALTER TABLE ONLY schedule_for_students."Venue"
    ADD CONSTRAINT "Venue_pkey" PRIMARY KEY (venue_id);


--
-- TOC entry 4743 (class 2606 OID 16835)
-- Name: Student_Group chk_end_date; Type: CHECK CONSTRAINT; Schema: schedule_for_students; Owner: postgres
--

ALTER TABLE schedule_for_students."Student_Group"
    ADD CONSTRAINT chk_end_date CHECK ((end_date > start_date)) NOT VALID;


--
-- TOC entry 4750 (class 2606 OID 16754)
-- Name: Teacher_Workload chk_semester; Type: CHECK CONSTRAINT; Schema: schedule_for_students; Owner: postgres
--

ALTER TABLE schedule_for_students."Teacher_Workload"
    ADD CONSTRAINT chk_semester CHECK (((semester >= 1) AND (semester <= 10))) NOT VALID;


--
-- TOC entry 4744 (class 2606 OID 16834)
-- Name: Student_Group chk_start_date; Type: CHECK CONSTRAINT; Schema: schedule_for_students; Owner: postgres
--

ALTER TABLE schedule_for_students."Student_Group"
    ADD CONSTRAINT chk_start_date CHECK ((start_date <= now())) NOT VALID;


--
-- TOC entry 4751 (class 2606 OID 16832)
-- Name: Lesson chk_start_datetime; Type: CHECK CONSTRAINT; Schema: schedule_for_students; Owner: postgres
--

ALTER TABLE schedule_for_students."Lesson"
    ADD CONSTRAINT chk_start_datetime CHECK ((start_datetime <= now())) NOT VALID;


--
-- TOC entry 4747 (class 2606 OID 16833)
-- Name: Student_Group_Membership chk_status; Type: CHECK CONSTRAINT; Schema: schedule_for_students; Owner: postgres
--

ALTER TABLE schedule_for_students."Student_Group_Membership"
    ADD CONSTRAINT chk_status CHECK (((status)::text = ANY ((ARRAY['Обучающийся'::character varying, 'Отчислен'::character varying, 'АО'::character varying, 'Выпускник'::character varying])::text[]))) NOT VALID;


--
-- TOC entry 4806 (class 2606 OID 16666)
-- Name: Lesson classroom_number; Type: FK CONSTRAINT; Schema: schedule_for_students; Owner: postgres
--

ALTER TABLE ONLY schedule_for_students."Lesson"
    ADD CONSTRAINT classroom_number FOREIGN KEY (classroom_number) REFERENCES schedule_for_students."Classroom"(classroom_number) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 4803 (class 2606 OID 16633)
-- Name: Classroom department_id; Type: FK CONSTRAINT; Schema: schedule_for_students; Owner: postgres
--

ALTER TABLE ONLY schedule_for_students."Classroom"
    ADD CONSTRAINT department_id FOREIGN KEY (department_id) REFERENCES schedule_for_students."Department"(department_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 4791 (class 2606 OID 16477)
-- Name: Discipline_StudyPlan discipline_id; Type: FK CONSTRAINT; Schema: schedule_for_students; Owner: postgres
--

ALTER TABLE ONLY schedule_for_students."Discipline_StudyPlan"
    ADD CONSTRAINT discipline_id FOREIGN KEY (discipline_id) REFERENCES schedule_for_students."Discipline"(discipline_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 4799 (class 2606 OID 16583)
-- Name: Teacher_Workload discipline_id; Type: FK CONSTRAINT; Schema: schedule_for_students; Owner: postgres
--

ALTER TABLE ONLY schedule_for_students."Teacher_Workload"
    ADD CONSTRAINT discipline_id FOREIGN KEY (discipline_id) REFERENCES schedule_for_students."Discipline"(discipline_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 4807 (class 2606 OID 16656)
-- Name: Lesson discipline_id; Type: FK CONSTRAINT; Schema: schedule_for_students; Owner: postgres
--

ALTER TABLE ONLY schedule_for_students."Lesson"
    ADD CONSTRAINT discipline_id FOREIGN KEY (discipline_id) REFERENCES schedule_for_students."Discipline"(discipline_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 4788 (class 2606 OID 16435)
-- Name: Educational_Program fk_educational_program_department; Type: FK CONSTRAINT; Schema: schedule_for_students; Owner: postgres
--

ALTER TABLE ONLY schedule_for_students."Educational_Program"
    ADD CONSTRAINT fk_educational_program_department FOREIGN KEY (department_id) REFERENCES schedule_for_students."Department"(department_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 4789 (class 2606 OID 16440)
-- Name: Educational_Program fk_educational_program_studydirection; Type: FK CONSTRAINT; Schema: schedule_for_students; Owner: postgres
--

ALTER TABLE ONLY schedule_for_students."Educational_Program"
    ADD CONSTRAINT fk_educational_program_studydirection FOREIGN KEY (study_direction_id) REFERENCES schedule_for_students."Study_Direction"(study_direction_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 4795 (class 2606 OID 16518)
-- Name: Student_Group_Membership group_id; Type: FK CONSTRAINT; Schema: schedule_for_students; Owner: postgres
--

ALTER TABLE ONLY schedule_for_students."Student_Group_Membership"
    ADD CONSTRAINT group_id FOREIGN KEY (group_id) REFERENCES schedule_for_students."Student_Group"(group_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4800 (class 2606 OID 16578)
-- Name: Teacher_Workload group_id; Type: FK CONSTRAINT; Schema: schedule_for_students; Owner: postgres
--

ALTER TABLE ONLY schedule_for_students."Teacher_Workload"
    ADD CONSTRAINT group_id FOREIGN KEY (group_id) REFERENCES schedule_for_students."Student_Group"(group_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 4808 (class 2606 OID 16661)
-- Name: Lesson group_id; Type: FK CONSTRAINT; Schema: schedule_for_students; Owner: postgres
--

ALTER TABLE ONLY schedule_for_students."Lesson"
    ADD CONSTRAINT group_id FOREIGN KEY (group_id) REFERENCES schedule_for_students."Student_Group"(group_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 4792 (class 2606 OID 16841)
-- Name: Discipline_StudyPlan lesson_id; Type: FK CONSTRAINT; Schema: schedule_for_students; Owner: postgres
--

ALTER TABLE ONLY schedule_for_students."Discipline_StudyPlan"
    ADD CONSTRAINT lesson_id FOREIGN KEY (lesson_id) REFERENCES schedule_for_students."Lesson"(lesson_id) ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;


--
-- TOC entry 4809 (class 2606 OID 16651)
-- Name: Lesson lesson_type_id; Type: FK CONSTRAINT; Schema: schedule_for_students; Owner: postgres
--

ALTER TABLE ONLY schedule_for_students."Lesson"
    ADD CONSTRAINT lesson_type_id FOREIGN KEY (lesson_type_id) REFERENCES schedule_for_students."Lesson_Type"(lesson_type_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 4797 (class 2606 OID 16555)
-- Name: Teacher_Position position_id; Type: FK CONSTRAINT; Schema: schedule_for_students; Owner: postgres
--

ALTER TABLE ONLY schedule_for_students."Teacher_Position"
    ADD CONSTRAINT position_id FOREIGN KEY (position_id) REFERENCES schedule_for_students."Position"(position_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 4790 (class 2606 OID 16455)
-- Name: Study_Plan program_id; Type: FK CONSTRAINT; Schema: schedule_for_students; Owner: postgres
--

ALTER TABLE ONLY schedule_for_students."Study_Plan"
    ADD CONSTRAINT program_id FOREIGN KEY (program_id) REFERENCES schedule_for_students."Educational_Program"(program_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 4804 (class 2606 OID 16628)
-- Name: Classroom room_type_id; Type: FK CONSTRAINT; Schema: schedule_for_students; Owner: postgres
--

ALTER TABLE ONLY schedule_for_students."Classroom"
    ADD CONSTRAINT room_type_id FOREIGN KEY (room_type_id) REFERENCES schedule_for_students."Room_Type"(room_type_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 4796 (class 2606 OID 16523)
-- Name: Student_Group_Membership student_id; Type: FK CONSTRAINT; Schema: schedule_for_students; Owner: postgres
--

ALTER TABLE ONLY schedule_for_students."Student_Group_Membership"
    ADD CONSTRAINT student_id FOREIGN KEY (student_id) REFERENCES schedule_for_students."Student"(student_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4793 (class 2606 OID 16482)
-- Name: Discipline_StudyPlan study_plan_id; Type: FK CONSTRAINT; Schema: schedule_for_students; Owner: postgres
--

ALTER TABLE ONLY schedule_for_students."Discipline_StudyPlan"
    ADD CONSTRAINT study_plan_id FOREIGN KEY (study_plan_id) REFERENCES schedule_for_students."Study_Plan"(study_plan_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 4794 (class 2606 OID 16495)
-- Name: Student_Group study_plan_id; Type: FK CONSTRAINT; Schema: schedule_for_students; Owner: postgres
--

ALTER TABLE ONLY schedule_for_students."Student_Group"
    ADD CONSTRAINT study_plan_id FOREIGN KEY (study_plan_id) REFERENCES schedule_for_students."Study_Plan"(study_plan_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 4801 (class 2606 OID 16836)
-- Name: Teacher_Workload study_plan_id; Type: FK CONSTRAINT; Schema: schedule_for_students; Owner: postgres
--

ALTER TABLE ONLY schedule_for_students."Teacher_Workload"
    ADD CONSTRAINT study_plan_id FOREIGN KEY (study_plan_id) REFERENCES schedule_for_students."Study_Plan"(study_plan_id) ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;


--
-- TOC entry 4798 (class 2606 OID 16560)
-- Name: Teacher_Position teacher_id; Type: FK CONSTRAINT; Schema: schedule_for_students; Owner: postgres
--

ALTER TABLE ONLY schedule_for_students."Teacher_Position"
    ADD CONSTRAINT teacher_id FOREIGN KEY (teacher_id) REFERENCES schedule_for_students."Teacher"(teacher_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 4802 (class 2606 OID 16573)
-- Name: Teacher_Workload teacher_id; Type: FK CONSTRAINT; Schema: schedule_for_students; Owner: postgres
--

ALTER TABLE ONLY schedule_for_students."Teacher_Workload"
    ADD CONSTRAINT teacher_id FOREIGN KEY (teacher_id) REFERENCES schedule_for_students."Teacher"(teacher_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 4810 (class 2606 OID 16646)
-- Name: Lesson teacher_id; Type: FK CONSTRAINT; Schema: schedule_for_students; Owner: postgres
--

ALTER TABLE ONLY schedule_for_students."Lesson"
    ADD CONSTRAINT teacher_id FOREIGN KEY (teacher_id) REFERENCES schedule_for_students."Teacher"(teacher_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 4805 (class 2606 OID 16623)
-- Name: Classroom venue_id; Type: FK CONSTRAINT; Schema: schedule_for_students; Owner: postgres
--

ALTER TABLE ONLY schedule_for_students."Classroom"
    ADD CONSTRAINT venue_id FOREIGN KEY (venue_id) REFERENCES schedule_for_students."Venue"(venue_id) ON UPDATE CASCADE ON DELETE RESTRICT;


-- Completed on 2025-05-05 17:13:14

--
-- PostgreSQL database dump complete
--

