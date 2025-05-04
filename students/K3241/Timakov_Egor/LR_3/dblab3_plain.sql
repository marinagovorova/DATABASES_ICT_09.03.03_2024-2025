CREATE DATABASE CarRent;

-- TABLE: Client
CREATE TABLE Client(
    ID integer PRIMARY KEY,
    Fullname varchar(90) NOT NULL CHECK (Fullname ~ '^[А-Яа-я\\s]+$'), -- Только кириллица и пробелы
    Passport_data varchar(10) UNIQUE NOT NULL CHECK (Passport_data ~ '^[0-9]+$'), -- Только цифры
    Driving_lincense_data varchar(45) UNIQUE NOT NULL CHECK (Driving_lincense_data ~ '^[0-9]+$'), -- Только цифры
    address varchar(45) NOT NULL CHECK (address ~ '^[А-Яа-я\\s]+$'), -- Только кириллица и пробелы
    phone_number varchar(11) UNIQUE NOT NULL CHECK (phone_number ~ '^[0-9\\+]+$') -- Только цифры и знак "+"
);

-- TABLE: Position
CREATE TABLE Position(
    ID integer PRIMARY KEY,
    job_code varchar(10) UNIQUE NOT NULL,
    name varchar(45) UNIQUE NOT NULL
);

-- TABLE: Manager
CREATE TABLE Manager(
    ID integer PRIMARY KEY,
    Fullname varchar(90) NOT NULL CHECK (Fullname ~ '^[А-Яа-я\\s]+$'), -- Только кириллица и пробелы
    Passport_data varchar(10) UNIQUE NOT NULL CHECK (Passport_data ~ '^[0-9]+$'), -- Только цифры
    Salary money CHECK (Salary > money '0') -- Только положительные значения
);

-- TABLE: Position_held
CREATE TABLE Position_held(
    ID integer PRIMARY KEY,
    Manager_id integer NOT NULL REFERENCES Manager(ID),
    begin_date date NOT NULL CHECK (begin_date > now()), -- Только будущее
    end_date date CHECK (end_date >= begin_date),
    Position_id integer REFERENCES Position(ID)
);

-- TABLE: Article_traffic_law
CREATE TABLE Article_traffic_law(
    ID integer PRIMARY KEY,
    Number_of_Article varchar(20) CHECK (Number_of_Article ~ '^[0-9.]+$'), -- Только цифры и точки
    Amount money CHECK (Amount > money '0'), -- Только положительные значения
    Other_cost money CHECK (Other_cost > money '0') -- Только положительные значения
);

-- TABLE: Brand
CREATE TABLE Brand(
    ID integer PRIMARY KEY,
    name varchar(20) NOT NULL CHECK (name ~ '^[A-Z]+$'), -- Только заглавные латинские буквы
    Technical_Data varchar(4) NOT NULL CHECK (Technical_Data IN ('АКПП', 'МКПП')), -- Только указанные значения
    Collateral_value money NOT NULL CHECK (Collateral_value > money '0'), -- Только положительные значения
    Insurance money NOT NULL CHECK (Insurance > money '0'), -- Только положительные значения
    Class varchar(10)
);

-- TABLE: Car
CREATE TABLE Car(
    ID integer PRIMARY KEY,
    License_plate varchar(10) NOT NULL UNIQUE CHECK (License_plate ~ '^[АВЕКМНОРСТУХ0-9]+$'), -- Только допустимые русские буквы и цифры
    Insurance_data varchar(45) NOT NULL UNIQUE CHECK (Insurance_data ~ '^[0-9]+$'), -- Только цифры
    Passport_data varchar(45) NOT NULL UNIQUE CHECK (Passport_data ~ '^[0-9]+$'), -- Только цифры
    Color varchar(45) NOT NULL,
    VIN varchar(18) NOT NULL UNIQUE CHECK (VIN ~ '^[0-9A-Z]+$'), -- Только заглавные латинские буквы и цифры
    Brand_id integer REFERENCES Brand(ID)
);

-- TABLE: Contract
CREATE TABLE Contract(
    ID integer PRIMARY KEY,
    Begin_Date date NOT NULL CHECK (Begin_Date > now()), -- Только будущее
    End_date date NOT NULL CHECK (End_date > Begin_Date), -- Дата окончания после даты начала
    Rental_cost money NOT NULL CHECK (Rental_cost >= money '0'), -- Неотрицательное значение
    Renewal_date date,
    Renewal_hours time CHECK (Renewal_hours > time '00:00:00'), -- Время больше 00:00:00
    Client_id integer REFERENCES Client(ID),
    Car_id integer REFERENCES Car(ID),
    Manager_id integer REFERENCES Manager(ID)
);

-- FUNCTION: set_renewal_date
CREATE OR REPLACE FUNCTION set_renewal_date()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.End_date <= CURRENT_DATE THEN
        NEW.Renewal_date := CURRENT_DATE;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- TRIGGER: trg_set_renewal_date
CREATE TRIGGER trg_set_renewal_date
    BEFORE INSERT OR UPDATE ON Contract
    FOR EACH ROW
    EXECUTE FUNCTION set_renewal_date();

-- TABLE: Fine
CREATE TABLE Fine(
    ID integer PRIMARY KEY,
    Number varchar(20) UNIQUE NOT NULL CHECK (Number ~ '^[0-9]+$'), -- Только цифры
    Date date NOT NULL CHECK (Date < now()), -- Только прошедшие даты
    Article_id integer REFERENCES Article_traffic_law(ID),
    Contract_id integer REFERENCES Contract(ID)
);

-- TABLE: Act
CREATE TABLE Act(
    ID integer PRIMARY KEY,
    Contract_ID integer NOT NULL REFERENCES Contract(ID),
    Type varchar(20) NOT NULL CHECK (Type IN ('Прием', 'Передача')), -- Только «Прием» или «Передача»
    Condition varchar(90) CHECK (Condition ~ '^[А-Яа-я\\s]+$') -- Только кириллица и пробелы
);
