--
-- PostgreSQL database dump
--

-- Dumped from database version 17.5 (Debian 17.5-1.pgdg120+1)
-- Dumped by pg_dump version 17.5 (Debian 17.5-1.pgdg120+1)

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
-- Name: lab-3; Type: DATABASE; Schema: -; Owner: db
--

CREATE DATABASE "lab-3" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE "lab-3" OWNER TO db;

\encoding SQL_ASCII
\connect -reuse-previous=on "dbname='lab-3'"

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
-- Name: lab_3; Type: SCHEMA; Schema: -; Owner: db
--

CREATE SCHEMA lab_3;


ALTER SCHEMA lab_3 OWNER TO db;

--
-- Name: SCHEMA lab_3; Type: COMMENT; Schema: -; Owner: db
--

COMMENT ON SCHEMA lab_3 IS 'схема для 3 лабы';


--
-- Name: add_new_deposit(integer, integer, integer, integer, integer, integer, date, integer); Type: PROCEDURE; Schema: lab_3; Owner: db
--

CREATE PROCEDURE lab_3.add_new_deposit(IN p_contract_number integer, IN p_employee_id integer, IN p_currency_code integer, IN p_client_id integer, IN p_deposit_type_id integer, IN p_initial_amount integer, IN p_start_date date, IN p_length integer)
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_status VARCHAR(6) := 'открыт';
    v_percent INTEGER;
BEGIN
    SELECT Процент_по_вкладу INTO v_percent
    FROM lab_3."Виды вкладов"
    WHERE "ID_вида_вклада" = p_deposit_type_id;

    INSERT INTO lab_3.Вклады (
        Номер_договора_вклада,
        "ID_сотрудника",
        Код_валюты,
        "ID_клиента",
        "ID_вида_вклада",
        Начальная_сумма_вклада,
        Дата_начала_вклада,
        Срок_вклада,
        Статус_вклада
    ) VALUES (
        p_contract_number,
        p_employee_id,
        p_currency_code,
        p_client_id,
        p_deposit_type_id,
        p_initial_amount,
        p_start_date,
        p_length,
        v_status
    );
END;
$$;


ALTER PROCEDURE lab_3.add_new_deposit(IN p_contract_number integer, IN p_employee_id integer, IN p_currency_code integer, IN p_client_id integer, IN p_deposit_type_id integer, IN p_initial_amount integer, IN p_start_date date, IN p_length integer) OWNER TO db;

--
-- Name: check_kredit_params(); Type: FUNCTION; Schema: lab_3; Owner: db
--

CREATE FUNCTION lab_3.check_kredit_params() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    min_rate INTEGER;
    max_rate INTEGER;
    min_term INTEGER;
    max_term INTEGER;
BEGIN
    SELECT
        Минимальная_процентная_ставка,
        Максимальная_процентная_ставка,
        Минимальный_срок_кредита,
        Максимальный_срок_кредита
    INTO min_rate, max_rate, min_term, max_term
    FROM lab_3."Виды кредитов"
    WHERE "ID_вида_кредита" = NEW."ID_вида_кредита";

    IF NEW.Процентная_ставка < min_rate OR NEW.Процентная_ставка > max_rate THEN
        RAISE EXCEPTION 'Процентная ставка (%) должна быть между % и % для вида кредита %',
            NEW.Процентная_ставка, min_rate, max_rate, NEW."ID_вида_кредита";
    END IF;

    IF NEW.Срок_кредита < min_term OR NEW.Срок_кредита > max_term THEN
        RAISE EXCEPTION 'Срок кредита (%) должен быть между % и % месяцев для вида кредита %',
            NEW.Срок_кредита, min_term, max_term, NEW."ID_вида_кредита";
    END IF;

    RETURN NEW;
END;
$$;


ALTER FUNCTION lab_3.check_kredit_params() OWNER TO db;

--
-- Name: check_vklad_params(); Type: FUNCTION; Schema: lab_3; Owner: db
--

CREATE FUNCTION lab_3.check_vklad_params() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    min_sum INTEGER;
    max_sum INTEGER;
    min_term INTEGER;
    max_term INTEGER;
BEGIN
    SELECT 
        Минимальная_сумма_вклада,
        Максимальная_сумма_вклада,
        Минимальный_срок_вклада,
        Максимальный_срок_вклада
    INTO min_sum, max_sum, min_term, max_term
    FROM lab_3."Виды вкладов"
    WHERE "ID_вида_вклада" = NEW."ID_вида_вклада";

    IF NEW.Начальная_сумма_вклада < min_sum OR NEW.Начальная_сумма_вклада > max_sum THEN
        RAISE EXCEPTION 'Сумма вклада (%) должна быть между % и % для вида вклада %',
            NEW.Начальная_сумма_вклада, min_sum, max_sum, NEW."ID_вида_вклада";
    END IF;

    IF NEW.Срок_вклада < min_term OR NEW.Срок_вклада > max_term THEN
        RAISE EXCEPTION 'Срок вклада (%) должен быть между % и % месяцев для вида вклада %',
            NEW.Срок_вклада, min_term, max_term, NEW."ID_вида_вклада";
    END IF;

    RETURN NEW;
END;
$$;


ALTER FUNCTION lab_3.check_vklad_params() OWNER TO db;

--
-- Name: get_client_deposit_info(integer, refcursor); Type: PROCEDURE; Schema: lab_3; Owner: db
--

CREATE PROCEDURE lab_3.get_client_deposit_info(IN p_client_id integer, IN ref refcursor DEFAULT 'client_deposit_cursor'::refcursor)
    LANGUAGE plpgsql
    AS $$
BEGIN
    OPEN ref FOR
    WITH deposit_calc AS (
        SELECT
            v.Номер_договора_вклада,
            v.Начальная_сумма_вклада,
            vv.Процент_по_вкладу,
            ROUND(
                v.Начальная_сумма_вклада::NUMERIC *
                POWER(
                    1 + vv.Процент_по_вкладу::NUMERIC / 100.0 / 12,
                    EXTRACT(YEAR FROM AGE(CURRENT_DATE, v.Дата_начала_вклада)) * 12 +
                    EXTRACT(MONTH FROM AGE(CURRENT_DATE, v.Дата_начала_вклада))
                ),
                2
            ) AS Текущая_сумма_вклада
        FROM lab_3.Вклады v
        JOIN lab_3."Виды вкладов" vv ON v."ID_вида_вклада" = vv."ID_вида_вклада"
        WHERE v."ID_клиента" = p_client_id
          AND v.Статус_вклада = 'открыт'
    )
    SELECT
        Номер_договора_вклада,
        Начальная_сумма_вклада,
        Процент_по_вкладу,
        Текущая_сумма_вклада,
        ROUND(
            Текущая_сумма_вклада * (Процент_по_вкладу::NUMERIC / 100.0 / 12),
            2
        ) AS Процент_за_месяц
    FROM deposit_calc;
END;
$$;


ALTER PROCEDURE lab_3.get_client_deposit_info(IN p_client_id integer, IN ref refcursor) OWNER TO db;

--
-- Name: get_clients_without_debt(refcursor); Type: PROCEDURE; Schema: lab_3; Owner: db
--

CREATE PROCEDURE lab_3.get_clients_without_debt(IN ref refcursor DEFAULT 'clients_no_debt_cursor'::refcursor)
    LANGUAGE plpgsql
    AS $$
BEGIN
    OPEN ref FOR
    SELECT DISTINCT
        k."ID_клиента",
        k."ФИО_клиента"
    FROM lab_3.Клиенты k
    WHERE NOT EXISTS (
        -- Есть ли у клиента хотя бы одна НЕВЫПЛАЧЕННАЯ выплата по кредиту?
        SELECT 1
        FROM lab_3.Кредиты kr
        JOIN lab_3."Выплаты по кредиту" v 
            ON kr."Номер_договора_кредита" = v."Номер_договора_кредита"
        WHERE kr."ID_клиента" = k."ID_клиента"
          AND v."Статус_выплаты_по_кредиту" = 'не выплачена'
    );
END;
$$;


ALTER PROCEDURE lab_3.get_clients_without_debt(IN ref refcursor) OWNER TO db;

--
-- Name: add_new_deposit(integer, integer, integer, integer, integer, integer, date, integer); Type: PROCEDURE; Schema: public; Owner: db
--

CREATE PROCEDURE public.add_new_deposit(IN p_contract_number integer, IN p_employee_id integer, IN p_currency_code integer, IN p_client_id integer, IN p_deposit_type_id integer, IN p_initial_amount integer, IN p_start_date date, IN p_length integer)
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_end_date DATE;
    v_total_payout INTEGER;
    v_status VARCHAR(6) := 'открыт';
    v_percent INTEGER;
BEGIN
    SELECT Процент_по_вкладу INTO v_percent
    FROM lab_3."Виды вкладов"
    WHERE "ID_вида_вклада" = p_deposit_type_id;

    v_end_date := p_start_date + INTERVAL '1 month' * p_length;

    v_total_payout := p_initial_amount * POWER(1 + v_percent / 12, p_length);

    INSERT INTO lab_3.Вклады (
        Номер_договора_вклада,
        "ID_сотрудника",
        Код_валюты,
        "ID_клиента",
        "ID_вида_вклада",
        Суммарная_выплата,
        Начальная_сумма_вклада,
        Дата_начала_вклада,
        Срок_вклада,
        Статус_вклада,
        Дата_конца_вклада
    ) VALUES (
        p_contract_number,
        p_employee_id,
        p_currency_code,
        p_client_id,
        p_deposit_type_id,
        v_total_payout,
        p_initial_amount,
        p_start_date,
        p_length,
        v_status,
        v_end_date
    );
END;
$$;


ALTER PROCEDURE public.add_new_deposit(IN p_contract_number integer, IN p_employee_id integer, IN p_currency_code integer, IN p_client_id integer, IN p_deposit_type_id integer, IN p_initial_amount integer, IN p_start_date date, IN p_length integer) OWNER TO db;

--
-- Name: get_client_deposit_info(integer, refcursor); Type: PROCEDURE; Schema: public; Owner: db
--

CREATE PROCEDURE public.get_client_deposit_info(IN p_client_id integer, IN ref refcursor DEFAULT 'client_deposit_cursor'::refcursor)
    LANGUAGE plpgsql
    AS $$
BEGIN
    OPEN ref FOR
    WITH deposit_calc AS (
        SELECT
            v.Номер_договора_вклада,
            v.Начальная_сумма_вклада,
            vv.Процент_по_вкладу,
            ROUND(
                v.Начальная_сумма_вклада::NUMERIC *
                POWER(
                    1 + vv.Процент_по_вкладу::NUMERIC / 100.0 / 12,
                    EXTRACT(YEAR FROM AGE(CURRENT_DATE, v.Дата_начала_вклада)) * 12 +
                    EXTRACT(MONTH FROM AGE(CURRENT_DATE, v.Дата_начала_вклада))
                ),
                2
            ) AS Текущая_сумма_вклада
        FROM lab_3.Вклады v
        JOIN lab_3."Виды вкладов" vv ON v."ID_вида_вклада" = vv."ID_вида_вклада"
        WHERE v."ID_клиента" = p_client_id
          AND v.Статус_вклада = 'открыт'
    )
    SELECT
        Номер_договора_вклада,
        Начальная_сумма_вклада,
        Процент_по_вкладу,
        Текущая_сумма_вклада,
        ROUND(
            Текущая_сумма_вклада * (Процент_по_вкладу::NUMERIC / 100.0 / 12),
            2
        ) AS Процент_за_месяц
    FROM deposit_calc;
END;
$$;


ALTER PROCEDURE public.get_client_deposit_info(IN p_client_id integer, IN ref refcursor) OWNER TO db;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: Валюты; Type: TABLE; Schema: lab_3; Owner: db
--

CREATE TABLE lab_3."Валюты" (
    "Код_валюты" integer NOT NULL,
    "Наименование_валюты" character varying(30) NOT NULL,
    "Страна" character varying(59) NOT NULL
);


ALTER TABLE lab_3."Валюты" OWNER TO db;

--
-- Name: Валюты_Код_валюты_seq; Type: SEQUENCE; Schema: lab_3; Owner: db
--

CREATE SEQUENCE lab_3."Валюты_Код_валюты_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE lab_3."Валюты_Код_валюты_seq" OWNER TO db;

--
-- Name: Валюты_Код_валюты_seq; Type: SEQUENCE OWNED BY; Schema: lab_3; Owner: db
--

ALTER SEQUENCE lab_3."Валюты_Код_валюты_seq" OWNED BY lab_3."Валюты"."Код_валюты";


--
-- Name: Виды вкладов; Type: TABLE; Schema: lab_3; Owner: db
--

CREATE TABLE lab_3."Виды вкладов" (
    "ID_вида_вклада" integer NOT NULL,
    "Минимальный_срок_вклада" integer NOT NULL,
    "Максимальный_срок_вклада" integer NOT NULL,
    "Минимальная_сумма_вклада" integer NOT NULL,
    "Максимальная_сумма_вклада" integer NOT NULL,
    "Наименование_вклада" character varying(30) NOT NULL,
    "Описание_вклада" character varying(500) NOT NULL,
    "Процент_по_вкладу" real NOT NULL,
    CONSTRAINT "Виды вкладов_check" CHECK (("Максимальный_срок_вклада" >= "Минимальный_срок_вклада")),
    CONSTRAINT "Виды вкладов_check1" CHECK (("Максимальная_сумма_вклада" >= "Минимальная_сумма_вклада")),
    CONSTRAINT "Виды вкладов_Минимальная_сумма_check" CHECK (("Минимальная_сумма_вклада" > 0)),
    CONSTRAINT "Виды вкладов_Минимальный_срок__check" CHECK (("Минимальный_срок_вклада" > 0)),
    CONSTRAINT "Виды вкладов_Процент_по_вкладу_check" CHECK ((("Процент_по_вкладу" > (0)::double precision) AND ("Процент_по_вкладу" < (100)::double precision)))
);


ALTER TABLE lab_3."Виды вкладов" OWNER TO db;

--
-- Name: Виды вкладов_ID_вида_вклада_seq; Type: SEQUENCE; Schema: lab_3; Owner: db
--

CREATE SEQUENCE lab_3."Виды вкладов_ID_вида_вклада_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE lab_3."Виды вкладов_ID_вида_вклада_seq" OWNER TO db;

--
-- Name: Виды вкладов_ID_вида_вклада_seq; Type: SEQUENCE OWNED BY; Schema: lab_3; Owner: db
--

ALTER SEQUENCE lab_3."Виды вкладов_ID_вида_вклада_seq" OWNED BY lab_3."Виды вкладов"."ID_вида_вклада";


--
-- Name: Виды кредитов; Type: TABLE; Schema: lab_3; Owner: db
--

CREATE TABLE lab_3."Виды кредитов" (
    "ID_вида_кредита" integer NOT NULL,
    "Минимальный_срок_кредита" integer NOT NULL,
    "Максимальный_срок_кредита" integer NOT NULL,
    "Минимальная_процентная_ставка" integer NOT NULL,
    "Максимальная_процентная_ставка" integer NOT NULL,
    "Наименование_кредита" character varying(30) NOT NULL,
    "Описание_кредита" character varying(500) NOT NULL,
    CONSTRAINT "Виды кредитов_check" CHECK (("Максимальный_срок_кредита" >= "Минимальный_срок_кредита")),
    CONSTRAINT "Виды кредитов_check1" CHECK (("Максимальная_процентная_ставка" >= "Минимальная_процентная_ставка")),
    CONSTRAINT "Виды кредитов_Минимальная_проц_check" CHECK (("Минимальная_процентная_ставка" > 0)),
    CONSTRAINT "Виды кредитов_Минимальный_срок_check" CHECK (("Минимальный_срок_кредита" > 0))
);


ALTER TABLE lab_3."Виды кредитов" OWNER TO db;

--
-- Name: Виды кредитов_ID_вида_кредита_seq; Type: SEQUENCE; Schema: lab_3; Owner: db
--

CREATE SEQUENCE lab_3."Виды кредитов_ID_вида_кредита_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE lab_3."Виды кредитов_ID_вида_кредита_seq" OWNER TO db;

--
-- Name: Виды кредитов_ID_вида_кредита_seq; Type: SEQUENCE OWNED BY; Schema: lab_3; Owner: db
--

ALTER SEQUENCE lab_3."Виды кредитов_ID_вида_кредита_seq" OWNED BY lab_3."Виды кредитов"."ID_вида_кредита";


--
-- Name: Вклады; Type: TABLE; Schema: lab_3; Owner: db
--

CREATE TABLE lab_3."Вклады" (
    "Номер_договора_вклада" integer NOT NULL,
    "ID_сотрудника" integer NOT NULL,
    "Код_валюты" integer NOT NULL,
    "ID_клиента" integer NOT NULL,
    "ID_вида_вклада" integer NOT NULL,
    "Начальная_сумма_вклада" real NOT NULL,
    "Дата_начала_вклада" date NOT NULL,
    "Срок_вклада" integer NOT NULL,
    "Статус_вклада" character varying(6) NOT NULL,
    CONSTRAINT "Вклады_Начальная_сумма_вклада_check" CHECK (("Начальная_сумма_вклада" > (0)::double precision)),
    CONSTRAINT "Вклады_Срок_вклада_check" CHECK (("Срок_вклада" > 0)),
    CONSTRAINT "Вклады_Статус_вклада_check" CHECK ((("Статус_вклада")::text = ANY ((ARRAY['открыт'::character varying, 'закрыт'::character varying])::text[])))
);


ALTER TABLE lab_3."Вклады" OWNER TO db;

--
-- Name: Выплаты по вкладу; Type: TABLE; Schema: lab_3; Owner: db
--

CREATE TABLE lab_3."Выплаты по вкладу" (
    "ID_выплаты_по_вкладу" integer NOT NULL,
    "Номер_договора_вклада" integer NOT NULL,
    "Сумма_выплаты_по_вкладу" real NOT NULL,
    "Статус_выплаты_по_вкладу" character varying(12) NOT NULL,
    "Дата_выплаты_по_вкладу" date NOT NULL,
    "Фактическая_дата_выплаты_по_вклад" date,
    CONSTRAINT "Выплаты по вкла_Статус_выплаты__check" CHECK ((("Статус_выплаты_по_вкладу")::text = ANY ((ARRAY['выплачена'::character varying, 'не выплачена'::character varying])::text[]))),
    CONSTRAINT "Выплаты по вкла_Сумма_выплаты_п_check" CHECK (("Сумма_выплаты_по_вкладу" > (0)::double precision)),
    CONSTRAINT "Выплаты по вкладу_check" CHECK (("Фактическая_дата_выплаты_по_вклад" >= "Дата_выплаты_по_вкладу"))
);


ALTER TABLE lab_3."Выплаты по вкладу" OWNER TO db;

--
-- Name: Выплаты по вкла_ID_выплаты_по_вкл_seq; Type: SEQUENCE; Schema: lab_3; Owner: db
--

CREATE SEQUENCE lab_3."Выплаты по вкла_ID_выплаты_по_вкл_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE lab_3."Выплаты по вкла_ID_выплаты_по_вкл_seq" OWNER TO db;

--
-- Name: Выплаты по вкла_ID_выплаты_по_вкл_seq; Type: SEQUENCE OWNED BY; Schema: lab_3; Owner: db
--

ALTER SEQUENCE lab_3."Выплаты по вкла_ID_выплаты_по_вкл_seq" OWNED BY lab_3."Выплаты по вкладу"."ID_выплаты_по_вкладу";


--
-- Name: Выплаты по кредиту; Type: TABLE; Schema: lab_3; Owner: db
--

CREATE TABLE lab_3."Выплаты по кредиту" (
    "ID_выплаты_по_кредиту" integer NOT NULL,
    "Номер_договора_кредита" integer NOT NULL,
    "Сумма_выплаты_по_кредиту" real NOT NULL,
    "Статус_выплаты_по_кредиту" character varying(12) NOT NULL,
    "Дата_выплаты_по_кредиту" date NOT NULL,
    "Фактическая_дата_выплаты_по_креди" date,
    "Сумма_выплаты_по_процентам" real NOT NULL,
    CONSTRAINT "Выплаты по кред_Статус_выплаты__check" CHECK ((("Статус_выплаты_по_кредиту")::text = ANY ((ARRAY['выплачена'::character varying, 'не выплачена'::character varying])::text[]))),
    CONSTRAINT "Выплаты по кред_Сумма_выплаты_п_check" CHECK (("Сумма_выплаты_по_кредиту" > (0)::double precision)),
    CONSTRAINT "Выплаты по кредиту_check" CHECK (("Фактическая_дата_выплаты_по_креди" >= "Дата_выплаты_по_кредиту")),
    CONSTRAINT "Выплаты по кредиту_check1" CHECK ((("Сумма_выплаты_по_процентам" > (0)::double precision) AND (("Сумма_выплаты_по_процентам")::double precision <= "Сумма_выплаты_по_кредиту")))
);


ALTER TABLE lab_3."Выплаты по кредиту" OWNER TO db;

--
-- Name: Выплаты по кред_ID_выплаты_по_кре_seq; Type: SEQUENCE; Schema: lab_3; Owner: db
--

CREATE SEQUENCE lab_3."Выплаты по кред_ID_выплаты_по_кре_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE lab_3."Выплаты по кред_ID_выплаты_по_кре_seq" OWNER TO db;

--
-- Name: Выплаты по кред_ID_выплаты_по_кре_seq; Type: SEQUENCE OWNED BY; Schema: lab_3; Owner: db
--

ALTER SEQUENCE lab_3."Выплаты по кред_ID_выплаты_по_кре_seq" OWNED BY lab_3."Выплаты по кредиту"."ID_выплаты_по_кредиту";


--
-- Name: Клиенты; Type: TABLE; Schema: lab_3; Owner: db
--

CREATE TABLE lab_3."Клиенты" (
    "ID_клиента" integer NOT NULL,
    "Телефон_клиента" character(12) NOT NULL,
    "Номер_паспорта_клиента" character(10) NOT NULL,
    "ФИО_клиента" character varying(50) NOT NULL,
    "Адрес_клиента" character varying(200) NOT NULL,
    "Email_клиента" character varying(100) NOT NULL
);


ALTER TABLE lab_3."Клиенты" OWNER TO db;

--
-- Name: Кредиты; Type: TABLE; Schema: lab_3; Owner: db
--

CREATE TABLE lab_3."Кредиты" (
    "Номер_договора_кредита" integer NOT NULL,
    "ID_сотрудника" integer NOT NULL,
    "Код_валюты" integer NOT NULL,
    "ID_клиента" integer NOT NULL,
    "ID_вида_кредита" integer NOT NULL,
    "Процентная_ставка" real NOT NULL,
    "Сумма_кредита" real NOT NULL,
    "Дата_начала_кредита" date NOT NULL,
    "Срок_кредита" integer NOT NULL,
    "Статус_кредита" character varying(8) NOT NULL,
    "Задолженность" real NOT NULL,
    CONSTRAINT "Кредиты_Задолженность_check" CHECK (("Задолженность" >= (0)::double precision)),
    CONSTRAINT "Кредиты_Процентная_ставка_check" CHECK ((("Процентная_ставка" > (0)::double precision) AND ("Процентная_ставка" < (100)::double precision))),
    CONSTRAINT "Кредиты_Срок_кредита_check" CHECK (("Срок_кредита" > 0)),
    CONSTRAINT "Кредиты_Статус_кредита_check" CHECK ((("Статус_кредита")::text = ANY ((ARRAY['открыт'::character varying, 'выплачен'::character varying])::text[]))),
    CONSTRAINT "Кредиты_Сумма_кредита_check" CHECK (("Сумма_кредита" > (0)::double precision))
);


ALTER TABLE lab_3."Кредиты" OWNER TO db;

--
-- Name: Должники; Type: VIEW; Schema: lab_3; Owner: db
--

CREATE VIEW lab_3."Должники" AS
 SELECT DISTINCT k."ID_клиента",
    k."ФИО_клиента"
   FROM ((lab_3."Клиенты" k
     JOIN lab_3."Кредиты" kr ON ((k."ID_клиента" = kr."ID_клиента")))
     JOIN lab_3."Выплаты по кредиту" v ON ((kr."Номер_договора_кредита" = v."Номер_договора_кредита")))
  WHERE ((v."Статус_выплаты_по_кредиту")::text = 'не выплачена'::text);


ALTER VIEW lab_3."Должники" OWNER TO db;

--
-- Name: VIEW "Должники"; Type: COMMENT; Schema: lab_3; Owner: db
--

COMMENT ON VIEW lab_3."Должники" IS 'клиенты банка, имеющих задолженности по кредитам.';


--
-- Name: Должности; Type: TABLE; Schema: lab_3; Owner: db
--

CREATE TABLE lab_3."Должности" (
    "ID_должности" integer NOT NULL,
    "Описание_должности" character varying(500) NOT NULL,
    "Оклад" integer NOT NULL,
    "Название_должности" character varying(30) NOT NULL,
    CONSTRAINT "check_Оклад" CHECK (("Оклад" > 16242))
);


ALTER TABLE lab_3."Должности" OWNER TO db;

--
-- Name: Должности_ID_должности_seq; Type: SEQUENCE; Schema: lab_3; Owner: db
--

CREATE SEQUENCE lab_3."Должности_ID_должности_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE lab_3."Должности_ID_должности_seq" OWNER TO db;

--
-- Name: Должности_ID_должности_seq; Type: SEQUENCE OWNED BY; Schema: lab_3; Owner: db
--

ALTER SEQUENCE lab_3."Должности_ID_должности_seq" OWNED BY lab_3."Должности"."ID_должности";


--
-- Name: Клиенты_ID_клиента_seq; Type: SEQUENCE; Schema: lab_3; Owner: db
--

CREATE SEQUENCE lab_3."Клиенты_ID_клиента_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE lab_3."Клиенты_ID_клиента_seq" OWNER TO db;

--
-- Name: Клиенты_ID_клиента_seq; Type: SEQUENCE OWNED BY; Schema: lab_3; Owner: db
--

ALTER SEQUENCE lab_3."Клиенты_ID_клиента_seq" OWNED BY lab_3."Клиенты"."ID_клиента";


--
-- Name: Сотрудники; Type: TABLE; Schema: lab_3; Owner: db
--

CREATE TABLE lab_3."Сотрудники" (
    "ID_сотрудника" integer NOT NULL,
    "Телефон_сотрудника" character(12) NOT NULL,
    "Номер_паспорта_сотрудника" character(10) NOT NULL,
    "ФИО_сотрудника" character varying(50) NOT NULL,
    "Адрес_сотрудника" character varying(500) NOT NULL,
    "ID_должности" integer NOT NULL,
    "Дата_рождения_сотрудника" date
);


ALTER TABLE lab_3."Сотрудники" OWNER TO db;

--
-- Name: Сотрудники_ID_сотрудника_seq; Type: SEQUENCE; Schema: lab_3; Owner: db
--

CREATE SEQUENCE lab_3."Сотрудники_ID_сотрудника_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE lab_3."Сотрудники_ID_сотрудника_seq" OWNER TO db;

--
-- Name: Сотрудники_ID_сотрудника_seq; Type: SEQUENCE OWNED BY; Schema: lab_3; Owner: db
--

ALTER SEQUENCE lab_3."Сотрудники_ID_сотрудника_seq" OWNED BY lab_3."Сотрудники"."ID_сотрудника";


--
-- Name: Сотрудники_кредиты_за_месяц; Type: VIEW; Schema: lab_3; Owner: db
--

CREATE VIEW lab_3."Сотрудники_кредиты_за_месяц" AS
 SELECT s."ID_сотрудника",
    s."ФИО_сотрудника",
    d."Название_должности",
    k."Номер_договора_кредита",
    k."Сумма_кредита",
    k."Процентная_ставка",
    k."Дата_начала_кредита",
    k."Статус_кредита"
   FROM ((lab_3."Сотрудники" s
     JOIN lab_3."Должности" d ON ((s."ID_должности" = d."ID_должности")))
     JOIN lab_3."Кредиты" k ON ((s."ID_сотрудника" = k."ID_сотрудника")))
  WHERE ((k."Дата_начала_кредита" >= (CURRENT_DATE - '1 mon'::interval)) AND (k."Дата_начала_кредита" <= CURRENT_DATE));


ALTER VIEW lab_3."Сотрудники_кредиты_за_месяц" OWNER TO db;

--
-- Name: VIEW "Сотрудники_кредиты_за_месяц"; Type: COMMENT; Schema: lab_3; Owner: db
--

COMMENT ON VIEW lab_3."Сотрудники_кредиты_за_месяц" IS 'сведения обо всех сотрудниках банка и заключенных ими договорах по кредитам за прошедший месяц';


--
-- Name: Валюты Код_валюты; Type: DEFAULT; Schema: lab_3; Owner: db
--

ALTER TABLE ONLY lab_3."Валюты" ALTER COLUMN "Код_валюты" SET DEFAULT nextval('lab_3."Валюты_Код_валюты_seq"'::regclass);


--
-- Name: Виды вкладов ID_вида_вклада; Type: DEFAULT; Schema: lab_3; Owner: db
--

ALTER TABLE ONLY lab_3."Виды вкладов" ALTER COLUMN "ID_вида_вклада" SET DEFAULT nextval('lab_3."Виды вкладов_ID_вида_вклада_seq"'::regclass);


--
-- Name: Виды кредитов ID_вида_кредита; Type: DEFAULT; Schema: lab_3; Owner: db
--

ALTER TABLE ONLY lab_3."Виды кредитов" ALTER COLUMN "ID_вида_кредита" SET DEFAULT nextval('lab_3."Виды кредитов_ID_вида_кредита_seq"'::regclass);


--
-- Name: Выплаты по вкладу ID_выплаты_по_вкладу; Type: DEFAULT; Schema: lab_3; Owner: db
--

ALTER TABLE ONLY lab_3."Выплаты по вкладу" ALTER COLUMN "ID_выплаты_по_вкладу" SET DEFAULT nextval('lab_3."Выплаты по вкла_ID_выплаты_по_вкл_seq"'::regclass);


--
-- Name: Выплаты по кредиту ID_выплаты_по_кредиту; Type: DEFAULT; Schema: lab_3; Owner: db
--

ALTER TABLE ONLY lab_3."Выплаты по кредиту" ALTER COLUMN "ID_выплаты_по_кредиту" SET DEFAULT nextval('lab_3."Выплаты по кред_ID_выплаты_по_кре_seq"'::regclass);


--
-- Name: Должности ID_должности; Type: DEFAULT; Schema: lab_3; Owner: db
--

ALTER TABLE ONLY lab_3."Должности" ALTER COLUMN "ID_должности" SET DEFAULT nextval('lab_3."Должности_ID_должности_seq"'::regclass);


--
-- Name: Клиенты ID_клиента; Type: DEFAULT; Schema: lab_3; Owner: db
--

ALTER TABLE ONLY lab_3."Клиенты" ALTER COLUMN "ID_клиента" SET DEFAULT nextval('lab_3."Клиенты_ID_клиента_seq"'::regclass);


--
-- Name: Сотрудники ID_сотрудника; Type: DEFAULT; Schema: lab_3; Owner: db
--

ALTER TABLE ONLY lab_3."Сотрудники" ALTER COLUMN "ID_сотрудника" SET DEFAULT nextval('lab_3."Сотрудники_ID_сотрудника_seq"'::regclass);


--
-- Data for Name: Валюты; Type: TABLE DATA; Schema: lab_3; Owner: db
--

INSERT INTO lab_3."Валюты" ("Код_валюты", "Наименование_валюты", "Страна") VALUES (1, 'Российский рубль', 'Россия');
INSERT INTO lab_3."Валюты" ("Код_валюты", "Наименование_валюты", "Страна") VALUES (2, 'Доллар США', 'США');
INSERT INTO lab_3."Валюты" ("Код_валюты", "Наименование_валюты", "Страна") VALUES (3, 'Евро', 'Еврозона');
INSERT INTO lab_3."Валюты" ("Код_валюты", "Наименование_валюты", "Страна") VALUES (4, 'Фунт', 'Великобритания');


--
-- Data for Name: Виды вкладов; Type: TABLE DATA; Schema: lab_3; Owner: db
--

INSERT INTO lab_3."Виды вкладов" ("ID_вида_вклада", "Минимальный_срок_вклада", "Максимальный_срок_вклада", "Минимальная_сумма_вклада", "Максимальная_сумма_вклада", "Наименование_вклада", "Описание_вклада", "Процент_по_вкладу") VALUES (1, 1, 12, 10000, 1000000, 'Депозит Старт', 'Простой вклад для начинающих', 5);
INSERT INTO lab_3."Виды вкладов" ("ID_вида_вклада", "Минимальный_срок_вклада", "Максимальный_срок_вклада", "Минимальная_сумма_вклада", "Максимальная_сумма_вклада", "Наименование_вклада", "Описание_вклада", "Процент_по_вкладу") VALUES (2, 6, 36, 50000, 5000000, 'Депозит Премиум', 'Высокий процент для крупных вкладов', 8);


--
-- Data for Name: Виды кредитов; Type: TABLE DATA; Schema: lab_3; Owner: db
--

INSERT INTO lab_3."Виды кредитов" ("ID_вида_кредита", "Минимальный_срок_кредита", "Максимальный_срок_кредита", "Минимальная_процентная_ставка", "Максимальная_процентная_ставка", "Наименование_кредита", "Описание_кредита") VALUES (1, 6, 24, 10, 18, 'Потребительский', 'Кредит на любые цели');
INSERT INTO lab_3."Виды кредитов" ("ID_вида_кредита", "Минимальный_срок_кредита", "Максимальный_срок_кредита", "Минимальная_процентная_ставка", "Максимальная_процентная_ставка", "Наименование_кредита", "Описание_кредита") VALUES (2, 12, 60, 8, 15, 'Ипотечный', 'Кредит на покупку жилья');


--
-- Data for Name: Вклады; Type: TABLE DATA; Schema: lab_3; Owner: db
--

INSERT INTO lab_3."Вклады" ("Номер_договора_вклада", "ID_сотрудника", "Код_валюты", "ID_клиента", "ID_вида_вклада", "Начальная_сумма_вклада", "Дата_начала_вклада", "Срок_вклада", "Статус_вклада") VALUES (10002, 1, 1, 2, 2, 500000, '2025-08-01', 24, 'открыт');
INSERT INTO lab_3."Вклады" ("Номер_договора_вклада", "ID_сотрудника", "Код_валюты", "ID_клиента", "ID_вида_вклада", "Начальная_сумма_вклада", "Дата_начала_вклада", "Срок_вклада", "Статус_вклада") VALUES (10003, 1, 4, 1, 2, 400000, '2025-07-01', 24, 'открыт');
INSERT INTO lab_3."Вклады" ("Номер_договора_вклада", "ID_сотрудника", "Код_валюты", "ID_клиента", "ID_вида_вклада", "Начальная_сумма_вклада", "Дата_начала_вклада", "Срок_вклада", "Статус_вклада") VALUES (10004, 1, 4, 4, 2, 50000, '2025-07-01', 24, 'открыт');
INSERT INTO lab_3."Вклады" ("Номер_договора_вклада", "ID_сотрудника", "Код_валюты", "ID_клиента", "ID_вида_вклада", "Начальная_сумма_вклада", "Дата_начала_вклада", "Срок_вклада", "Статус_вклада") VALUES (10001, 2, 1, 1, 1, 500000, '2025-08-01', 12, 'открыт');
INSERT INTO lab_3."Вклады" ("Номер_договора_вклада", "ID_сотрудника", "Код_валюты", "ID_клиента", "ID_вида_вклада", "Начальная_сумма_вклада", "Дата_начала_вклада", "Срок_вклада", "Статус_вклада") VALUES (10006, 1, 2, 1, 1, 50000, '2025-08-20', 12, 'открыт');


--
-- Data for Name: Выплаты по вкладу; Type: TABLE DATA; Schema: lab_3; Owner: db
--

INSERT INTO lab_3."Выплаты по вкладу" ("ID_выплаты_по_вкладу", "Номер_договора_вклада", "Сумма_выплаты_по_вкладу", "Статус_выплаты_по_вкладу", "Дата_выплаты_по_вкладу", "Фактическая_дата_выплаты_по_вклад") VALUES (1, 10001, 410.96, 'выплачена', '2025-09-01', '2025-09-01');
INSERT INTO lab_3."Выплаты по вкладу" ("ID_выплаты_по_вкладу", "Номер_договора_вклада", "Сумма_выплаты_по_вкладу", "Статус_выплаты_по_вкладу", "Дата_выплаты_по_вкладу", "Фактическая_дата_выплаты_по_вклад") VALUES (2, 10002, 3287.67, 'выплачена', '2025-09-01', '2025-09-01');
INSERT INTO lab_3."Выплаты по вкладу" ("ID_выплаты_по_вкладу", "Номер_договора_вклада", "Сумма_выплаты_по_вкладу", "Статус_выплаты_по_вкладу", "Дата_выплаты_по_вкладу", "Фактическая_дата_выплаты_по_вклад") VALUES (3, 10003, 2630.14, 'выплачена', '2025-08-01', '2025-08-01');
INSERT INTO lab_3."Выплаты по вкладу" ("ID_выплаты_по_вкладу", "Номер_договора_вклада", "Сумма_выплаты_по_вкладу", "Статус_выплаты_по_вкладу", "Дата_выплаты_по_вкладу", "Фактическая_дата_выплаты_по_вклад") VALUES (4, 10004, 328.77, 'выплачена', '2025-08-01', '2025-08-01');
INSERT INTO lab_3."Выплаты по вкладу" ("ID_выплаты_по_вкладу", "Номер_договора_вклада", "Сумма_выплаты_по_вкладу", "Статус_выплаты_по_вкладу", "Дата_выплаты_по_вкладу", "Фактическая_дата_выплаты_по_вклад") VALUES (6, 10004, 341.96, 'выплачена', '2025-09-01', '2025-09-01');
INSERT INTO lab_3."Выплаты по вкладу" ("ID_выплаты_по_вкладу", "Номер_договора_вклада", "Сумма_выплаты_по_вкладу", "Статус_выплаты_по_вкладу", "Дата_выплаты_по_вкладу", "Фактическая_дата_выплаты_по_вклад") VALUES (5, 10003, 2735.68, 'выплачена', '2025-09-01', '2025-09-01');


--
-- Data for Name: Выплаты по кредиту; Type: TABLE DATA; Schema: lab_3; Owner: db
--

INSERT INTO lab_3."Выплаты по кредиту" ("ID_выплаты_по_кредиту", "Номер_договора_кредита", "Сумма_выплаты_по_кредиту", "Статус_выплаты_по_кредиту", "Дата_выплаты_по_кредиту", "Фактическая_дата_выплаты_по_креди", "Сумма_выплаты_по_процентам") VALUES (1, 20001, 7415, 'выплачена', '2025-09-01', '2025-09-01', 2000);
INSERT INTO lab_3."Выплаты по кредиту" ("ID_выплаты_по_кредиту", "Номер_договора_кредита", "Сумма_выплаты_по_кредиту", "Статус_выплаты_по_кредиту", "Дата_выплаты_по_кредиту", "Фактическая_дата_выплаты_по_креди", "Сумма_выплаты_по_процентам") VALUES (2, 20002, 38741, 'выплачена', '2025-09-01', '2025-09-01', 25000);
INSERT INTO lab_3."Выплаты по кредиту" ("ID_выплаты_по_кредиту", "Номер_договора_кредита", "Сумма_выплаты_по_кредиту", "Статус_выплаты_по_кредиту", "Дата_выплаты_по_кредиту", "Фактическая_дата_выплаты_по_креди", "Сумма_выплаты_по_процентам") VALUES (5, 20003, 54802.26, 'не выплачена', '2025-09-01', NULL, 26303.74);
INSERT INTO lab_3."Выплаты по кредиту" ("ID_выплаты_по_кредиту", "Номер_договора_кредита", "Сумма_выплаты_по_кредиту", "Статус_выплаты_по_кредиту", "Дата_выплаты_по_кредиту", "Фактическая_дата_выплаты_по_креди", "Сумма_выплаты_по_процентам") VALUES (4, 20004, 7958.67, 'выплачена', '2025-08-01', '2025-08-01', 833.33);
INSERT INTO lab_3."Выплаты по кредиту" ("ID_выплаты_по_кредиту", "Номер_договора_кредита", "Сумма_выплаты_по_кредиту", "Статус_выплаты_по_кредиту", "Дата_выплаты_по_кредиту", "Фактическая_дата_выплаты_по_креди", "Сумма_выплаты_по_процентам") VALUES (6, 20004, 8024.99, 'выплачена', '2025-09-01', '2025-09-01', 767.01);
INSERT INTO lab_3."Выплаты по кредиту" ("ID_выплаты_по_кредиту", "Номер_договора_кредита", "Сумма_выплаты_по_кредиту", "Статус_выплаты_по_кредиту", "Дата_выплаты_по_кредиту", "Фактическая_дата_выплаты_по_креди", "Сумма_выплаты_по_процентам") VALUES (3, 20003, 54439.33, 'выплачена', '2025-08-01', '2025-08-08', 26666.67);


--
-- Data for Name: Должности; Type: TABLE DATA; Schema: lab_3; Owner: db
--

INSERT INTO lab_3."Должности" ("ID_должности", "Описание_должности", "Оклад", "Название_должности") VALUES (1, 'Консультант по вкладам', 25000, 'Консультант');
INSERT INTO lab_3."Должности" ("ID_должности", "Описание_должности", "Оклад", "Название_должности") VALUES (2, 'Кредитный специалист', 30000, 'Специалист');
INSERT INTO lab_3."Должности" ("ID_должности", "Описание_должности", "Оклад", "Название_должности") VALUES (3, 'Руководитель отдела', 50000, 'Руководитель');


--
-- Data for Name: Клиенты; Type: TABLE DATA; Schema: lab_3; Owner: db
--

INSERT INTO lab_3."Клиенты" ("ID_клиента", "Телефон_клиента", "Номер_паспорта_клиента", "ФИО_клиента", "Адрес_клиента", "Email_клиента") VALUES (1, '+79998887766', '3212345678', 'Иванов Иван Иванович', 'г. Москва, ул. Ленина 15, кв. 10', 'ivanov@example.com');
INSERT INTO lab_3."Клиенты" ("ID_клиента", "Телефон_клиента", "Номер_паспорта_клиента", "ФИО_клиента", "Адрес_клиента", "Email_клиента") VALUES (2, '+79876543210', '1287654321', 'Петрова Анна Сергеевна', 'г. Санкт-Петербург, пр. Невский 25, кв. 5', 'petrova@example.com');
INSERT INTO lab_3."Клиенты" ("ID_клиента", "Телефон_клиента", "Номер_паспорта_клиента", "ФИО_клиента", "Адрес_клиента", "Email_клиента") VALUES (3, '+79641231212', '1234567890', 'Турищев Артем Игорвеич', 'г. Владивосток, ул. Спиридонова 42, кв.5 ', 'artemt@example.com');
INSERT INTO lab_3."Клиенты" ("ID_клиента", "Телефон_клиента", "Номер_паспорта_клиента", "ФИО_клиента", "Адрес_клиента", "Email_клиента") VALUES (4, '+79641232121', '0987654321', 'Воробьева Ангелина', 'г. Санкт-Петербург, пр. Авиаторов балтики 25, кв. 5', 'pigeonangel@example.com');


--
-- Data for Name: Кредиты; Type: TABLE DATA; Schema: lab_3; Owner: db
--

INSERT INTO lab_3."Кредиты" ("Номер_договора_кредита", "ID_сотрудника", "Код_валюты", "ID_клиента", "ID_вида_кредита", "Процентная_ставка", "Сумма_кредита", "Дата_начала_кредита", "Срок_кредита", "Статус_кредита", "Задолженность") VALUES (20004, 2, 3, 4, 1, 10, 100000, '2025-07-01', 12, 'открыт', 84016.34);
INSERT INTO lab_3."Кредиты" ("Номер_договора_кредита", "ID_сотрудника", "Код_валюты", "ID_клиента", "ID_вида_кредита", "Процентная_ставка", "Сумма_кредита", "Дата_начала_кредита", "Срок_кредита", "Статус_кредита", "Задолженность") VALUES (20003, 2, 3, 3, 2, 8, 4e+06, '2025-07-01', 60, 'открыт', 3.9718645e+06);
INSERT INTO lab_3."Кредиты" ("Номер_договора_кредита", "ID_сотрудника", "Код_валюты", "ID_клиента", "ID_вида_кредита", "Процентная_ставка", "Сумма_кредита", "Дата_начала_кредита", "Срок_кредита", "Статус_кредита", "Задолженность") VALUES (20002, 2, 1, 2, 2, 10, 3e+06, '2025-08-01', 60, 'открыт', 2.961259e+06);
INSERT INTO lab_3."Кредиты" ("Номер_договора_кредита", "ID_сотрудника", "Код_валюты", "ID_клиента", "ID_вида_кредита", "Процентная_ставка", "Сумма_кредита", "Дата_начала_кредита", "Срок_кредита", "Статус_кредита", "Задолженность") VALUES (20001, 2, 1, 1, 1, 12, 200000, '2025-08-01', 24, 'открыт', 192585);


--
-- Data for Name: Сотрудники; Type: TABLE DATA; Schema: lab_3; Owner: db
--

INSERT INTO lab_3."Сотрудники" ("ID_сотрудника", "Телефон_сотрудника", "Номер_паспорта_сотрудника", "ФИО_сотрудника", "Адрес_сотрудника", "ID_должности", "Дата_рождения_сотрудника") VALUES (1, '+79001112233', 'EF11223344', 'Сидоров Сергей Петрович', 'г. Москва, ул. Тверская 5, кв. 20', 1, '1990-03-15');
INSERT INTO lab_3."Сотрудники" ("ID_сотрудника", "Телефон_сотрудника", "Номер_паспорта_сотрудника", "ФИО_сотрудника", "Адрес_сотрудника", "ID_должности", "Дата_рождения_сотрудника") VALUES (2, '+79012223344', 'GH55667788', 'Кузнецова Мария Андреевна', 'г. Москва, ул. Арбат 10, кв. 15', 2, '1988-07-22');


--
-- Name: Валюты_Код_валюты_seq; Type: SEQUENCE SET; Schema: lab_3; Owner: db
--

SELECT pg_catalog.setval('lab_3."Валюты_Код_валюты_seq"', 21, true);


--
-- Name: Виды вкладов_ID_вида_вклада_seq; Type: SEQUENCE SET; Schema: lab_3; Owner: db
--

SELECT pg_catalog.setval('lab_3."Виды вкладов_ID_вида_вклада_seq"', 2, true);


--
-- Name: Виды кредитов_ID_вида_кредита_seq; Type: SEQUENCE SET; Schema: lab_3; Owner: db
--

SELECT pg_catalog.setval('lab_3."Виды кредитов_ID_вида_кредита_seq"', 2, true);


--
-- Name: Выплаты по вкла_ID_выплаты_по_вкл_seq; Type: SEQUENCE SET; Schema: lab_3; Owner: db
--

SELECT pg_catalog.setval('lab_3."Выплаты по вкла_ID_выплаты_по_вкл_seq"', 2, true);


--
-- Name: Выплаты по кред_ID_выплаты_по_кре_seq; Type: SEQUENCE SET; Schema: lab_3; Owner: db
--

SELECT pg_catalog.setval('lab_3."Выплаты по кред_ID_выплаты_по_кре_seq"', 2, true);


--
-- Name: Должности_ID_должности_seq; Type: SEQUENCE SET; Schema: lab_3; Owner: db
--

SELECT pg_catalog.setval('lab_3."Должности_ID_должности_seq"', 27, true);


--
-- Name: Клиенты_ID_клиента_seq; Type: SEQUENCE SET; Schema: lab_3; Owner: db
--

SELECT pg_catalog.setval('lab_3."Клиенты_ID_клиента_seq"', 13, true);


--
-- Name: Сотрудники_ID_сотрудника_seq; Type: SEQUENCE SET; Schema: lab_3; Owner: db
--

SELECT pg_catalog.setval('lab_3."Сотрудники_ID_сотрудника_seq"', 6, true);


--
-- Name: Валюты Валюты_pkey; Type: CONSTRAINT; Schema: lab_3; Owner: db
--

ALTER TABLE ONLY lab_3."Валюты"
    ADD CONSTRAINT "Валюты_pkey" PRIMARY KEY ("Код_валюты");


--
-- Name: Валюты Валюты_Наименование_валюты_check; Type: CHECK CONSTRAINT; Schema: lab_3; Owner: db
--

ALTER TABLE lab_3."Валюты"
    ADD CONSTRAINT "Валюты_Наименование_валюты_check" CHECK ((("Наименование_валюты")::text ~ '^[a-zA-Zа-яА-Я[:space:]]+$'::text)) NOT VALID;


--
-- Name: Валюты Валюты_Страна_check; Type: CHECK CONSTRAINT; Schema: lab_3; Owner: db
--

ALTER TABLE lab_3."Валюты"
    ADD CONSTRAINT "Валюты_Страна_check" CHECK ((("Страна")::text ~ '^[a-zA-Zа-яА-Я[:space:]-]+$'::text)) NOT VALID;


--
-- Name: Виды вкладов Виды вкладов_pkey; Type: CONSTRAINT; Schema: lab_3; Owner: db
--

ALTER TABLE ONLY lab_3."Виды вкладов"
    ADD CONSTRAINT "Виды вкладов_pkey" PRIMARY KEY ("ID_вида_вклада");


--
-- Name: Виды вкладов Виды вкладов_Наименование_вкла_check; Type: CHECK CONSTRAINT; Schema: lab_3; Owner: db
--

ALTER TABLE lab_3."Виды вкладов"
    ADD CONSTRAINT "Виды вкладов_Наименование_вкла_check" CHECK ((("Наименование_вклада")::text ~ '^[a-zA-Zа-яА-Я0-9[:space:][:punct:]]+$'::text)) NOT VALID;


--
-- Name: Виды кредитов Виды кредитов_pkey; Type: CONSTRAINT; Schema: lab_3; Owner: db
--

ALTER TABLE ONLY lab_3."Виды кредитов"
    ADD CONSTRAINT "Виды кредитов_pkey" PRIMARY KEY ("ID_вида_кредита");


--
-- Name: Виды кредитов Виды кредитов_Наименование_кре_check; Type: CHECK CONSTRAINT; Schema: lab_3; Owner: db
--

ALTER TABLE lab_3."Виды кредитов"
    ADD CONSTRAINT "Виды кредитов_Наименование_кре_check" CHECK ((("Наименование_кредита")::text ~ '^[a-zA-Zа-яА-Я0-9[:space:][:punct:]]+$'::text)) NOT VALID;


--
-- Name: Вклады Вклады_pkey; Type: CONSTRAINT; Schema: lab_3; Owner: db
--

ALTER TABLE ONLY lab_3."Вклады"
    ADD CONSTRAINT "Вклады_pkey" PRIMARY KEY ("Номер_договора_вклада");


--
-- Name: Выплаты по вкладу Выплаты по вкладу_pkey; Type: CONSTRAINT; Schema: lab_3; Owner: db
--

ALTER TABLE ONLY lab_3."Выплаты по вкладу"
    ADD CONSTRAINT "Выплаты по вкладу_pkey" PRIMARY KEY ("ID_выплаты_по_вкладу");


--
-- Name: Выплаты по кредиту Выплаты по кредиту_pkey; Type: CONSTRAINT; Schema: lab_3; Owner: db
--

ALTER TABLE ONLY lab_3."Выплаты по кредиту"
    ADD CONSTRAINT "Выплаты по кредиту_pkey" PRIMARY KEY ("ID_выплаты_по_кредиту");


--
-- Name: Должности Должности_pkey; Type: CONSTRAINT; Schema: lab_3; Owner: db
--

ALTER TABLE ONLY lab_3."Должности"
    ADD CONSTRAINT "Должности_pkey" PRIMARY KEY ("ID_должности");


--
-- Name: Должности Должности_Название_должности_check; Type: CHECK CONSTRAINT; Schema: lab_3; Owner: db
--

ALTER TABLE lab_3."Должности"
    ADD CONSTRAINT "Должности_Название_должности_check" CHECK ((("Название_должности")::text ~ '^[a-zA-Zа-яА-Я0-9[:space:]]+$'::text)) NOT VALID;


--
-- Name: Должности Должности_Описание_должности_check; Type: CHECK CONSTRAINT; Schema: lab_3; Owner: db
--

ALTER TABLE lab_3."Должности"
    ADD CONSTRAINT "Должности_Описание_должности_check" CHECK ((("Описание_должности")::text ~ '^[a-zA-Zа-яА-Я0-9[:space:][:punct:]]+$'::text)) NOT VALID;


--
-- Name: Клиенты Клиенты_Email_клиента_check; Type: CHECK CONSTRAINT; Schema: lab_3; Owner: db
--

ALTER TABLE lab_3."Клиенты"
    ADD CONSTRAINT "Клиенты_Email_клиента_check" CHECK ((("Email_клиента")::text ~ '^[^@[:space:]]+@[^@[:space:]]+\.[^@[:space:]]+$'::text)) NOT VALID;


--
-- Name: Клиенты Клиенты_pkey; Type: CONSTRAINT; Schema: lab_3; Owner: db
--

ALTER TABLE ONLY lab_3."Клиенты"
    ADD CONSTRAINT "Клиенты_pkey" PRIMARY KEY ("ID_клиента");


--
-- Name: Клиенты Клиенты_Номер_паспорта_клиента_check; Type: CHECK CONSTRAINT; Schema: lab_3; Owner: db
--

ALTER TABLE lab_3."Клиенты"
    ADD CONSTRAINT "Клиенты_Номер_паспорта_клиента_check" CHECK (("Номер_паспорта_клиента" ~ '^[a-zA-Zа-яА-Я0-9]+$'::text)) NOT VALID;


--
-- Name: Клиенты Клиенты_Телефон_клиента_check; Type: CHECK CONSTRAINT; Schema: lab_3; Owner: db
--

ALTER TABLE lab_3."Клиенты"
    ADD CONSTRAINT "Клиенты_Телефон_клиента_check" CHECK (("Телефон_клиента" ~ '^\+[0-9]{11}$'::text)) NOT VALID;


--
-- Name: Клиенты Клиенты_ФИО_клиента_check; Type: CHECK CONSTRAINT; Schema: lab_3; Owner: db
--

ALTER TABLE lab_3."Клиенты"
    ADD CONSTRAINT "Клиенты_ФИО_клиента_check" CHECK ((("ФИО_клиента")::text ~ '^[a-zA-Zа-яА-Я0-9[:space:]-]+$'::text)) NOT VALID;


--
-- Name: Кредиты Кредиты_pkey; Type: CONSTRAINT; Schema: lab_3; Owner: db
--

ALTER TABLE ONLY lab_3."Кредиты"
    ADD CONSTRAINT "Кредиты_pkey" PRIMARY KEY ("Номер_договора_кредита");


--
-- Name: Сотрудники Сотрудники_pkey; Type: CONSTRAINT; Schema: lab_3; Owner: db
--

ALTER TABLE ONLY lab_3."Сотрудники"
    ADD CONSTRAINT "Сотрудники_pkey" PRIMARY KEY ("ID_сотрудника");


--
-- Name: Сотрудники Сотрудники_Номер_паспорта_сот_check1; Type: CHECK CONSTRAINT; Schema: lab_3; Owner: db
--

ALTER TABLE lab_3."Сотрудники"
    ADD CONSTRAINT "Сотрудники_Номер_паспорта_сот_check1" CHECK (("Номер_паспорта_сотрудника" ~ '^[a-zA-Zа-яА-Я0-9]+$'::text)) NOT VALID;


--
-- Name: Сотрудники Сотрудники_Телефон_сотрудника_check; Type: CHECK CONSTRAINT; Schema: lab_3; Owner: db
--

ALTER TABLE lab_3."Сотрудники"
    ADD CONSTRAINT "Сотрудники_Телефон_сотрудника_check" CHECK (("Телефон_сотрудника" ~ '^\+[0-9]{11}$'::text)) NOT VALID;


--
-- Name: Сотрудники Сотрудники_ФИО_сотрудника_check; Type: CHECK CONSTRAINT; Schema: lab_3; Owner: db
--

ALTER TABLE lab_3."Сотрудники"
    ADD CONSTRAINT "Сотрудники_ФИО_сотрудника_check" CHECK ((("ФИО_сотрудника")::text ~ '^[a-zA-Zа-яА-Я0-9[:space:]-]+$'::text)) NOT VALID;


--
-- Name: Кредиты trg_check_kredit_params; Type: TRIGGER; Schema: lab_3; Owner: db
--

CREATE TRIGGER trg_check_kredit_params BEFORE INSERT OR UPDATE ON lab_3."Кредиты" FOR EACH ROW EXECUTE FUNCTION lab_3.check_kredit_params();


--
-- Name: Вклады trg_check_vklad_params; Type: TRIGGER; Schema: lab_3; Owner: db
--

CREATE TRIGGER trg_check_vklad_params BEFORE INSERT OR UPDATE ON lab_3."Вклады" FOR EACH ROW EXECUTE FUNCTION lab_3.check_vklad_params();


--
-- Name: Вклады Вклады_ID_вида_вклада_fkey; Type: FK CONSTRAINT; Schema: lab_3; Owner: db
--

ALTER TABLE ONLY lab_3."Вклады"
    ADD CONSTRAINT "Вклады_ID_вида_вклада_fkey" FOREIGN KEY ("ID_вида_вклада") REFERENCES lab_3."Виды вкладов"("ID_вида_вклада") NOT VALID;


--
-- Name: Вклады Вклады_ID_клиента_fkey; Type: FK CONSTRAINT; Schema: lab_3; Owner: db
--

ALTER TABLE ONLY lab_3."Вклады"
    ADD CONSTRAINT "Вклады_ID_клиента_fkey" FOREIGN KEY ("ID_клиента") REFERENCES lab_3."Клиенты"("ID_клиента") NOT VALID;


--
-- Name: Вклады Вклады_ID_сотрудника_fkey; Type: FK CONSTRAINT; Schema: lab_3; Owner: db
--

ALTER TABLE ONLY lab_3."Вклады"
    ADD CONSTRAINT "Вклады_ID_сотрудника_fkey" FOREIGN KEY ("ID_сотрудника") REFERENCES lab_3."Сотрудники"("ID_сотрудника");


--
-- Name: Вклады Вклады_Код_валюты_fkey; Type: FK CONSTRAINT; Schema: lab_3; Owner: db
--

ALTER TABLE ONLY lab_3."Вклады"
    ADD CONSTRAINT "Вклады_Код_валюты_fkey" FOREIGN KEY ("Код_валюты") REFERENCES lab_3."Валюты"("Код_валюты") NOT VALID;


--
-- Name: Выплаты по вкладу Выплаты по вкла_Номер_договора__fkey; Type: FK CONSTRAINT; Schema: lab_3; Owner: db
--

ALTER TABLE ONLY lab_3."Выплаты по вкладу"
    ADD CONSTRAINT "Выплаты по вкла_Номер_договора__fkey" FOREIGN KEY ("Номер_договора_вклада") REFERENCES lab_3."Вклады"("Номер_договора_вклада");


--
-- Name: Выплаты по кредиту Выплаты по кред_Номер_договора__fkey; Type: FK CONSTRAINT; Schema: lab_3; Owner: db
--

ALTER TABLE ONLY lab_3."Выплаты по кредиту"
    ADD CONSTRAINT "Выплаты по кред_Номер_договора__fkey" FOREIGN KEY ("Номер_договора_кредита") REFERENCES lab_3."Кредиты"("Номер_договора_кредита");


--
-- Name: Кредиты Кредиты_ID_вида_кредита_fkey; Type: FK CONSTRAINT; Schema: lab_3; Owner: db
--

ALTER TABLE ONLY lab_3."Кредиты"
    ADD CONSTRAINT "Кредиты_ID_вида_кредита_fkey" FOREIGN KEY ("ID_вида_кредита") REFERENCES lab_3."Виды кредитов"("ID_вида_кредита");


--
-- Name: Кредиты Кредиты_ID_клиента_fkey; Type: FK CONSTRAINT; Schema: lab_3; Owner: db
--

ALTER TABLE ONLY lab_3."Кредиты"
    ADD CONSTRAINT "Кредиты_ID_клиента_fkey" FOREIGN KEY ("ID_клиента") REFERENCES lab_3."Клиенты"("ID_клиента");


--
-- Name: Кредиты Кредиты_ID_сотрудника_fkey; Type: FK CONSTRAINT; Schema: lab_3; Owner: db
--

ALTER TABLE ONLY lab_3."Кредиты"
    ADD CONSTRAINT "Кредиты_ID_сотрудника_fkey" FOREIGN KEY ("ID_сотрудника") REFERENCES lab_3."Сотрудники"("ID_сотрудника");


--
-- Name: Кредиты Кредиты_Код_валюты_fkey; Type: FK CONSTRAINT; Schema: lab_3; Owner: db
--

ALTER TABLE ONLY lab_3."Кредиты"
    ADD CONSTRAINT "Кредиты_Код_валюты_fkey" FOREIGN KEY ("Код_валюты") REFERENCES lab_3."Валюты"("Код_валюты");


--
-- Name: Сотрудники Сотрудники_ID_должности_fkey; Type: FK CONSTRAINT; Schema: lab_3; Owner: db
--

ALTER TABLE ONLY lab_3."Сотрудники"
    ADD CONSTRAINT "Сотрудники_ID_должности_fkey" FOREIGN KEY ("ID_должности") REFERENCES lab_3."Должности"("ID_должности");


--
-- PostgreSQL database dump complete
--

