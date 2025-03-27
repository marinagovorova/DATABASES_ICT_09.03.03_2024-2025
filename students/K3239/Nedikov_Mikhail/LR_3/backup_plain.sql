--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4
-- Dumped by pg_dump version 17.4

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
-- Name: bank_system; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE bank_system WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'ru-RU';


ALTER DATABASE bank_system OWNER TO postgres;

\connect bank_system

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
-- Name: Payment_Type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."Payment_Type" AS ENUM (
    'annuity',
    'differentiated'
);


ALTER TYPE public."Payment_Type" OWNER TO postgres;

--
-- Name: check_credit_payment_date(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.check_credit_payment_date() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Проверка, что дата в пределах срока кредита
    IF NEW."Date" < (SELECT "Signing_Date" FROM public."Credit_Contract" WHERE "Credit_Contract_ID" = NEW."Credit_Contract_ID")
       OR NEW."Date" > (SELECT "End_Date" FROM public."Credit_Contract" WHERE "Credit_Contract_ID" = NEW."Credit_Contract_ID") THEN
        RAISE EXCEPTION 'Date must be within the credit contract period';
    END IF;
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.check_credit_payment_date() OWNER TO postgres;

--
-- Name: check_payment_date(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.check_payment_date() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Проверка, что дата в пределах срока вклада
    IF NEW."Date" < (SELECT "Opening_Date" FROM public."Deposit_Contract" WHERE "Deposit_Contract_ID" = NEW."Deposit_Contract_ID")
       OR NEW."Date" > (SELECT "End_Date" FROM public."Deposit_Contract" WHERE "Deposit_Contract_ID" = NEW."Deposit_Contract_ID") THEN
        RAISE EXCEPTION 'Date must be within the deposit contract period';
    END IF;
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.check_payment_date() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: Client; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Client" (
    "PhoneNumber" character varying(10) NOT NULL,
    "E-mail" character varying NOT NULL,
    "Surname" character varying NOT NULL,
    "Name" character varying NOT NULL,
    "Patronymic" character varying,
    "Date_of_birth" date NOT NULL,
    "Place_of_birth" text NOT NULL,
    "ID_client" uuid NOT NULL,
    CONSTRAINT "Проверка_имени" CHECK ((("Name")::text ~ '^[А-Яа-яЁё]+$'::text)),
    CONSTRAINT "Проверка_отчества" CHECK ((("Patronymic")::text ~ '^[А-Яа-яЁё]+$'::text)),
    CONSTRAINT "Проверка_почты" CHECK ((("E-mail")::text ~ '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'::text)),
    CONSTRAINT "Проверка_телефона" CHECK ((("PhoneNumber")::text ~ '^[0-9]{10}$'::text)),
    CONSTRAINT "Проверка_фамилии" CHECK ((("Surname")::text ~ '^[А-Яа-яЁё]+$'::text))
);


ALTER TABLE public."Client" OWNER TO postgres;

--
-- Name: Client_Passport_Data; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Client_Passport_Data" (
    "Passport_ID" uuid NOT NULL,
    "Client_ID" uuid NOT NULL,
    "Series" character varying(4) NOT NULL,
    "Number" character varying(6) NOT NULL,
    "Issuance_Code" character varying(6) NOT NULL,
    "Registration_Address" text NOT NULL,
    "Issuance_Date" date NOT NULL,
    CONSTRAINT "Проверка_кода_выдачи" CHECK ((("Issuance_Code")::text ~ '^[0-9]{6}$'::text)),
    CONSTRAINT "Проверка_номера" CHECK ((("Number")::text ~ '^[0-9]{6}$'::text)),
    CONSTRAINT "Проверка_серии" CHECK ((("Series")::text ~ '^[0-9]{4}$'::text))
);


ALTER TABLE public."Client_Passport_Data" OWNER TO postgres;

--
-- Name: Credit_Contract; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Credit_Contract" (
    "Credit_Contract_ID" uuid NOT NULL,
    "Credit_Data_ID" uuid NOT NULL,
    "Client_ID" uuid NOT NULL,
    "Employee_ID" uuid NOT NULL,
    "Signing_Date" date NOT NULL,
    "End_Date" date NOT NULL,
    "Amount" double precision NOT NULL,
    "Interest_Rate" double precision NOT NULL,
    CONSTRAINT "Credit_Contract_Amount_check" CHECK (("Amount" > (0)::double precision)),
    CONSTRAINT "Credit_Contract_Interest_Rate_check" CHECK (("Interest_Rate" > (0)::double precision)),
    CONSTRAINT "Credit_Contract_Signing_Date_check" CHECK (("Signing_Date" <= CURRENT_DATE)),
    CONSTRAINT "Credit_Contract_check" CHECK (("End_Date" > "Signing_Date"))
);


ALTER TABLE public."Credit_Contract" OWNER TO postgres;

--
-- Name: Credit_Data; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Credit_Data" (
    "Loan_Data_ID" uuid NOT NULL,
    "Name" character varying(255) NOT NULL,
    "Description" text,
    "Payment_Type" public."Payment_Type" NOT NULL
);


ALTER TABLE public."Credit_Data" OWNER TO postgres;

--
-- Name: Credit_Payment_Schedule; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Credit_Payment_Schedule" (
    "Payment_Schedule_ID" uuid NOT NULL,
    "Credit_Contract_ID" uuid NOT NULL,
    "Date" date NOT NULL,
    "Amount" double precision NOT NULL,
    "Remaining_Debt" double precision NOT NULL,
    "Actual_Payment_Date" date,
    CONSTRAINT "Payment_Schedule_for_Credit_Amount_check" CHECK (("Amount" > (0)::double precision)),
    CONSTRAINT "Payment_Schedule_for_Credit_Remaining_Debt_check" CHECK (("Remaining_Debt" >= (0)::double precision))
);


ALTER TABLE public."Credit_Payment_Schedule" OWNER TO postgres;

--
-- Name: Currency; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Currency" (
    "Currency_ID" uuid NOT NULL,
    "Name" character varying(255) NOT NULL,
    "Symbol" character varying(10) NOT NULL
);


ALTER TABLE public."Currency" OWNER TO postgres;

--
-- Name: Deposit_Contract; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Deposit_Contract" (
    "Deposit_Contract_ID" uuid NOT NULL,
    "Deposit_ID" uuid NOT NULL,
    "Client_ID" uuid NOT NULL,
    "Opening_Date" date NOT NULL,
    "Deposit_Term" integer NOT NULL,
    "Deposit_Amount" double precision NOT NULL,
    "Employee_ID" uuid NOT NULL,
    CONSTRAINT "Deposit_Contract_Deposit_Amount_check" CHECK (("Deposit_Amount" > (0)::double precision)),
    CONSTRAINT "Deposit_Contract_Deposit_Term_check" CHECK (("Deposit_Term" > 0)),
    CONSTRAINT "Deposit_Contract_Opening_Date_check" CHECK (("Opening_Date" <= CURRENT_DATE))
);


ALTER TABLE public."Deposit_Contract" OWNER TO postgres;

--
-- Name: Deposit_Data; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Deposit_Data" (
    "Deposit_Data_ID" uuid NOT NULL,
    "Name" character varying(255) NOT NULL,
    "Description" text,
    "Min_Amount" double precision NOT NULL,
    "Min_Term" integer NOT NULL,
    "Interest_Rate" double precision NOT NULL,
    CONSTRAINT "Deposit_Data_Interest_Rate_check" CHECK (("Interest_Rate" > (0)::double precision)),
    CONSTRAINT "Deposit_Data_Min_Amount_check" CHECK (("Min_Amount" > (0)::double precision)),
    CONSTRAINT "Deposit_Data_Min_Term_check" CHECK (("Min_Term" > 0))
);


ALTER TABLE public."Deposit_Data" OWNER TO postgres;

--
-- Name: Deposit_Payment_Schedule; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Deposit_Payment_Schedule" (
    "Payment_Schedule_ID" uuid NOT NULL,
    "Deposit_Contract_ID" uuid NOT NULL,
    "Date" date NOT NULL,
    "Amount" double precision NOT NULL,
    CONSTRAINT "Deposit_Payment_Schedule_Amount_check" CHECK (("Amount" > (0)::double precision))
);


ALTER TABLE public."Deposit_Payment_Schedule" OWNER TO postgres;

--
-- Name: Employee; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Employee" (
    "Employee_ID" uuid NOT NULL,
    "Phone" character varying(10) NOT NULL,
    "Email" character varying(255) NOT NULL,
    "Surname" character varying(255) NOT NULL,
    "First_Name" character varying(255) NOT NULL,
    "Middle_Name" character varying(255),
    "Date_of_Birth" date NOT NULL,
    "Place_of_Birth" text NOT NULL,
    CONSTRAINT check_email CHECK ((("Email")::text ~ '^[A-Za-z0-9._%+-А-Яа-яЁё]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'::text)),
    CONSTRAINT check_phone CHECK ((("Phone")::text ~ '^\+?[0-9]{10}$'::text))
);


ALTER TABLE public."Employee" OWNER TO postgres;

--
-- Name: Employee_Passport_Data; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Employee_Passport_Data" (
    "Passport_ID" uuid NOT NULL,
    "Employee_ID" uuid NOT NULL,
    "Series" character varying(4) NOT NULL,
    "Number" character varying(6) NOT NULL,
    "Issuance_Code" character varying(6) NOT NULL,
    "Registration_Address" text NOT NULL,
    "Issuance_Date" date NOT NULL,
    CONSTRAINT check_issuance_code CHECK ((("Issuance_Code")::text ~ '^[0-9]{6}$'::text)),
    CONSTRAINT check_number CHECK ((("Number")::text ~ '^[0-9]{6}$'::text)),
    CONSTRAINT check_series CHECK ((("Series")::text ~ '^[0-9]{4}$'::text))
);


ALTER TABLE public."Employee_Passport_Data" OWNER TO postgres;

--
-- Name: Employee_Position; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Employee_Position" (
    "Position_Employee_ID" uuid NOT NULL,
    "Employee_ID" uuid NOT NULL,
    "Position_ID" uuid NOT NULL,
    "Rate" double precision NOT NULL,
    CONSTRAINT "Employee_Position_Rate_check" CHECK ((("Rate" >= (0)::double precision) AND ("Rate" <= (1)::double precision)))
);


ALTER TABLE public."Employee_Position" OWNER TO postgres;

--
-- Name: Position; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Position" (
    "Position_ID" uuid NOT NULL,
    "Name" character varying(255) NOT NULL,
    "Salary" double precision NOT NULL,
    CONSTRAINT "Position_Salary_check" CHECK (("Salary" > (0)::double precision))
);


ALTER TABLE public."Position" OWNER TO postgres;

--
-- Data for Name: Client; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Client" ("PhoneNumber", "E-mail", "Surname", "Name", "Patronymic", "Date_of_birth", "Place_of_birth", "ID_client") FROM stdin;
\.


--
-- Data for Name: Client_Passport_Data; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Client_Passport_Data" ("Passport_ID", "Client_ID", "Series", "Number", "Issuance_Code", "Registration_Address", "Issuance_Date") FROM stdin;
\.


--
-- Data for Name: Credit_Contract; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Credit_Contract" ("Credit_Contract_ID", "Credit_Data_ID", "Client_ID", "Employee_ID", "Signing_Date", "End_Date", "Amount", "Interest_Rate") FROM stdin;
\.


--
-- Data for Name: Credit_Data; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Credit_Data" ("Loan_Data_ID", "Name", "Description", "Payment_Type") FROM stdin;
\.


--
-- Data for Name: Credit_Payment_Schedule; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Credit_Payment_Schedule" ("Payment_Schedule_ID", "Credit_Contract_ID", "Date", "Amount", "Remaining_Debt", "Actual_Payment_Date") FROM stdin;
\.


--
-- Data for Name: Currency; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Currency" ("Currency_ID", "Name", "Symbol") FROM stdin;
52bf0ee0-43d1-4487-b466-c4da68947b7b	RUB	₽
756727fe-8db0-410d-a43b-53e372636e63	USD	$
7e933a4c-7f89-4dc9-9005-4b7d597794c1	EUR	€
\.


--
-- Data for Name: Deposit_Contract; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Deposit_Contract" ("Deposit_Contract_ID", "Deposit_ID", "Client_ID", "Opening_Date", "Deposit_Term", "Deposit_Amount", "Employee_ID") FROM stdin;
\.


--
-- Data for Name: Deposit_Data; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Deposit_Data" ("Deposit_Data_ID", "Name", "Description", "Min_Amount", "Min_Term", "Interest_Rate") FROM stdin;
fd2a9c5b-d332-4c49-b74d-04f1e0683c83	Сберегательный	Стандартный вклад с капитализацией процентов	10000	6	7.5
ab7c148a-7ae5-4ce4-96ea-db9b76e7d934	Пенсионный	Специальный вклад для пенсионеров	5000	3	8.2
\.


--
-- Data for Name: Deposit_Payment_Schedule; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Deposit_Payment_Schedule" ("Payment_Schedule_ID", "Deposit_Contract_ID", "Date", "Amount") FROM stdin;
\.


--
-- Data for Name: Employee; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Employee" ("Employee_ID", "Phone", "Email", "Surname", "First_Name", "Middle_Name", "Date_of_Birth", "Place_of_Birth") FROM stdin;
\.


--
-- Data for Name: Employee_Passport_Data; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Employee_Passport_Data" ("Passport_ID", "Employee_ID", "Series", "Number", "Issuance_Code", "Registration_Address", "Issuance_Date") FROM stdin;
\.


--
-- Data for Name: Employee_Position; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Employee_Position" ("Position_Employee_ID", "Employee_ID", "Position_ID", "Rate") FROM stdin;
\.


--
-- Data for Name: Position; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Position" ("Position_ID", "Name", "Salary") FROM stdin;
28de3e52-592b-4552-a3c7-34eb518c5032	Кассир	50000
cccd4452-2caf-4404-be8f-e5434795978b	Менеджер	75000
750e073d-5c9c-4179-a41d-4ff27e3de5f8	Аналитик	90000
9e2a3cb3-3684-4ddf-88cd-4f90bdb9af81	Кредитный специалист	75000
e59f85e2-dfff-4470-bc54-336d24d33e21	Менеджер по вкладам	70000
\.


--
-- Name: Client_Passport_Data Client_Passport_Data_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Client_Passport_Data"
    ADD CONSTRAINT "Client_Passport_Data_pkey" PRIMARY KEY ("Passport_ID");


--
-- Name: Client Client_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Client"
    ADD CONSTRAINT "Client_pkey" PRIMARY KEY ("ID_client");


--
-- Name: Credit_Contract Credit_Contract_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Credit_Contract"
    ADD CONSTRAINT "Credit_Contract_pkey" PRIMARY KEY ("Credit_Contract_ID");


--
-- Name: Currency Currency_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Currency"
    ADD CONSTRAINT "Currency_pkey" PRIMARY KEY ("Currency_ID");


--
-- Name: Deposit_Contract Deposit_Contract_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Deposit_Contract"
    ADD CONSTRAINT "Deposit_Contract_pkey" PRIMARY KEY ("Deposit_Contract_ID");


--
-- Name: Deposit_Data Deposit_Data_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Deposit_Data"
    ADD CONSTRAINT "Deposit_Data_pkey" PRIMARY KEY ("Deposit_Data_ID");


--
-- Name: Deposit_Payment_Schedule Deposit_Payment_Schedule_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Deposit_Payment_Schedule"
    ADD CONSTRAINT "Deposit_Payment_Schedule_pkey" PRIMARY KEY ("Payment_Schedule_ID");


--
-- Name: Employee_Passport_Data Employee_Passport_Data_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Employee_Passport_Data"
    ADD CONSTRAINT "Employee_Passport_Data_pkey" PRIMARY KEY ("Passport_ID");


--
-- Name: Employee_Position Employee_Position_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Employee_Position"
    ADD CONSTRAINT "Employee_Position_pkey" PRIMARY KEY ("Position_Employee_ID");


--
-- Name: Employee Employee_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Employee"
    ADD CONSTRAINT "Employee_pkey" PRIMARY KEY ("Employee_ID");


--
-- Name: Credit_Data Loan_Data_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Credit_Data"
    ADD CONSTRAINT "Loan_Data_pkey" PRIMARY KEY ("Loan_Data_ID");


--
-- Name: Credit_Payment_Schedule Payment_Schedule_for_Credit_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Credit_Payment_Schedule"
    ADD CONSTRAINT "Payment_Schedule_for_Credit_pkey" PRIMARY KEY ("Payment_Schedule_ID");


--
-- Name: Position Position_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Position"
    ADD CONSTRAINT "Position_pkey" PRIMARY KEY ("Position_ID");


--
-- Name: Currency unique_currency_name; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Currency"
    ADD CONSTRAINT unique_currency_name UNIQUE ("Name");


--
-- Name: Deposit_Data unique_deposit_name; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Deposit_Data"
    ADD CONSTRAINT unique_deposit_name UNIQUE ("Name");


--
-- Name: Employee unique_email; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Employee"
    ADD CONSTRAINT unique_email UNIQUE ("Email");


--
-- Name: Credit_Data unique_loan_name; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Credit_Data"
    ADD CONSTRAINT unique_loan_name UNIQUE ("Name");


--
-- Name: Employee unique_phone; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Employee"
    ADD CONSTRAINT unique_phone UNIQUE ("Phone");


--
-- Name: Position unique_position_name; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Position"
    ADD CONSTRAINT unique_position_name UNIQUE ("Name");


--
-- Name: Employee_Passport_Data unique_series_number; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Employee_Passport_Data"
    ADD CONSTRAINT unique_series_number UNIQUE ("Series", "Number");


--
-- Name: Client Уникальная_почта; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Client"
    ADD CONSTRAINT "Уникальная_почта" UNIQUE ("E-mail");


--
-- Name: Client_Passport_Data Уникальная_серия_и_номер; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Client_Passport_Data"
    ADD CONSTRAINT "Уникальная_серия_и_номер" UNIQUE ("Series", "Number");


--
-- Name: Client Уникальный_номер_телефона; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Client"
    ADD CONSTRAINT "Уникальный_номер_телефона" UNIQUE ("PhoneNumber");


--
-- Name: Credit_Payment_Schedule trigger_check_credit_payment_date; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trigger_check_credit_payment_date BEFORE INSERT OR UPDATE ON public."Credit_Payment_Schedule" FOR EACH ROW EXECUTE FUNCTION public.check_credit_payment_date();


--
-- Name: Deposit_Payment_Schedule trigger_check_payment_date; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trigger_check_payment_date BEFORE INSERT OR UPDATE ON public."Deposit_Payment_Schedule" FOR EACH ROW EXECUTE FUNCTION public.check_payment_date();


--
-- Name: Credit_Contract fk_credit_contract_to_client; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Credit_Contract"
    ADD CONSTRAINT fk_credit_contract_to_client FOREIGN KEY ("Client_ID") REFERENCES public."Client"("ID_client") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Credit_Contract fk_credit_contract_to_credit; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Credit_Contract"
    ADD CONSTRAINT fk_credit_contract_to_credit FOREIGN KEY ("Credit_Data_ID") REFERENCES public."Credit_Data"("Loan_Data_ID") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Credit_Contract fk_credit_contract_to_employee; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Credit_Contract"
    ADD CONSTRAINT fk_credit_contract_to_employee FOREIGN KEY ("Employee_ID") REFERENCES public."Employee"("Employee_ID") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Deposit_Contract fk_deposit_contract_to_client; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Deposit_Contract"
    ADD CONSTRAINT fk_deposit_contract_to_client FOREIGN KEY ("Client_ID") REFERENCES public."Client"("ID_client") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Deposit_Contract fk_deposit_contract_to_deposit; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Deposit_Contract"
    ADD CONSTRAINT fk_deposit_contract_to_deposit FOREIGN KEY ("Deposit_ID") REFERENCES public."Deposit_Data"("Deposit_Data_ID") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Deposit_Contract fk_deposit_contract_to_employee; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Deposit_Contract"
    ADD CONSTRAINT fk_deposit_contract_to_employee FOREIGN KEY ("Employee_ID") REFERENCES public."Employee"("Employee_ID") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Employee_Passport_Data fk_employee_passport_data_to_employees; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Employee_Passport_Data"
    ADD CONSTRAINT fk_employee_passport_data_to_employees FOREIGN KEY ("Employee_ID") REFERENCES public."Employee"("Employee_ID") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Employee_Position fk_employee_position_to_employee; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Employee_Position"
    ADD CONSTRAINT fk_employee_position_to_employee FOREIGN KEY ("Employee_ID") REFERENCES public."Employee"("Employee_ID") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Employee_Position fk_employee_position_to_position; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Employee_Position"
    ADD CONSTRAINT fk_employee_position_to_position FOREIGN KEY ("Position_ID") REFERENCES public."Position"("Position_ID") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Client_Passport_Data fk_passport_data_to_clients; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Client_Passport_Data"
    ADD CONSTRAINT fk_passport_data_to_clients FOREIGN KEY ("Client_ID") REFERENCES public."Client"("ID_client") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Credit_Payment_Schedule fk_payment_schedule_to_credit_contract; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Credit_Payment_Schedule"
    ADD CONSTRAINT fk_payment_schedule_to_credit_contract FOREIGN KEY ("Credit_Contract_ID") REFERENCES public."Credit_Contract"("Credit_Contract_ID") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Deposit_Payment_Schedule fk_payment_schedule_to_deposit_contract; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Deposit_Payment_Schedule"
    ADD CONSTRAINT fk_payment_schedule_to_deposit_contract FOREIGN KEY ("Deposit_Contract_ID") REFERENCES public."Deposit_Contract"("Deposit_Contract_ID") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

