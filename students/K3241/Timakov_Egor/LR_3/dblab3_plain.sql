CREATE DATABASE CarRent;s

-- TABLE: Client
CREATE TABLE Client(
    ID integer PRIMARY KEY,
    Fullname varchar(90) NOT NULL CHECK (Fullname ~* '^[А-Яа-яЁё ]+$'), -- Только кириллица и пробелы
    Passport_data varchar(10) UNIQUE NOT NULL CHECK (Passport_data ~* '^[0-9]+$'), -- Только цифры
    Driving_lincense_data varchar(45) UNIQUE NOT NULL CHECK (Driving_lincense_data ~* '^[0-9]+$'), -- Только цифры
    address varchar(45) NOT NULL CHECK (address ~* '^[А-Яа-яЁё ]+$'), -- Только кириллица и пробелы
    phone_number varchar(11) UNIQUE NOT NULL CHECK (phone_number ~* '^[0-9\\+]+$') -- Только цифры и знак "+"
);


-- Таблица должностей
CREATE TABLE Position(
    ID integer PRIMARY KEY,
    job_code varchar(10) UNIQUE NOT NULL,
    name varchar(45) UNIQUE NOT NULL,
    -- Базовый оклад для данной должности. Оклад > 0.
    Base_Salary money NOT NULL CHECK (Base_Salary > money '0')
);

-- Таблица менеджеров
CREATE TABLE Manager(
    ID integer PRIMARY KEY,
    -- ФИО только на кириллице и пробелах
    Fullname varchar(90) NOT NULL CHECK (Fullname ~* '^[А-Яа-яЁё ]+$'),
    -- Паспорт содержит только цифры
    Passport_data varchar(10) UNIQUE NOT NULL CHECK (Passport_data ~* '^[0-9]+$'),
    -- Телефон: только цифры или плюс
    phone_number varchar(11) UNIQUE NOT NULL CHECK (phone_number ~* '^[0-9\+]+$'),
    -- Email должен соответствовать формату адреса
    email varchar(90) UNIQUE NOT NULL CHECK (email ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$')
);



-- TABLE: Position_held
CREATE TABLE Position_held(
    ID integer PRIMARY KEY,
    Manager_id integer NOT NULL REFERENCES Manager(ID),
    begin_date date NOT NULL CHECK (begin_date > now()), -- Только будущее
    end_date date CHECK (end_date >= begin_date),
    Position_id integer REFERENCES Position(ID)
);
-- TABLE: Brand
CREATE TABLE Brand(
    ID integer PRIMARY KEY,
    name varchar(20) NOT NULL CHECK (name ~* '^[A-Z]+$'), -- Только заглавные латинские буквы
    Technical_Data varchar(4) NOT NULL CHECK (Technical_Data IN ('АКПП', 'МКПП')), -- Только указанные значения
    Collateral_value money NOT NULL CHECK (Collateral_value > money '0'), -- Только положительные значения
    Insurance money NOT NULL CHECK (Insurance > money '0'), -- Только положительные значения
    Class varchar(10)
);


-- TABLE: Car
CREATE TABLE Car(
    ID integer PRIMARY KEY,
    License_plate varchar(10) NOT NULL UNIQUE CHECK (License_plate ~* '^[АВЕКМНОРСТУХ0-9]+$'), -- Только допустимые русские буквы и цифры
    Insurance_data varchar(45) NOT NULL UNIQUE CHECK (Insurance_data ~* '^[0-9]+$'), -- Только цифры
    Passport_data varchar(45) NOT NULL UNIQUE CHECK (Passport_data ~* '^[0-9]+$'), -- Только цифры
    Color varchar(45) NOT NULL,
    VIN varchar(18) NOT NULL UNIQUE CHECK (VIN ~* '^[0-9A-Z]+$'), -- Только заглавные латинские буквы и цифры
    Brand_id integer REFERENCES Brand(ID),
    release_year varchar(4),
    model varchar(45) not null check ( model ~* '^[A-Za-z0-9._%+-]+$'),
    mileage integer
);

-- TABLE: Contract
CREATE TABLE Contract(
    ID integer PRIMARY KEY,
    Begin_Date date NOT NULL, --CHECK (Begin_Date > now()), -- Только будущее
    End_date date NOT NULL CHECK (End_date > Begin_Date), -- Дата окончания после даты начала
    Rental_cost money NOT NULL CHECK (Rental_cost >= money '0'), -- Неотрицательное значение
    Client_id integer REFERENCES Client(ID),
    Car_id integer REFERENCES Car(ID),
    Manager_id integer REFERENCES Manager(ID)
);


-- Таблица актов приема/передачи
CREATE TABLE Act(
    ID integer PRIMARY KEY,
    Contract_ID integer NOT NULL REFERENCES Contract(ID),
    -- Тип акта строго ограничен двумя значениями
    Type varchar(20) NOT NULL CHECK (Type IN ('Прием', 'Передача')),
    -- Состояние автомобиля описывается только кириллицей и пробелами
    Condition varchar(90) CHECK (Condition ~* '^[А-Яа-яЁё ]+$'),
    -- Дата и время подписания акта
    Signed_At timestamp NOT NULL DEFAULT now()
);

-- Продления договора
CREATE TABLE Contract_Extension(
    ID serial PRIMARY KEY,
    Contract_ID integer NOT NULL REFERENCES Contract(ID),
    -- Дата продления указывается точно
    Extension_Date timestamp NOT NULL DEFAULT now(),
    -- Продление возможно только на положительное количество дней
    Extended_Days integer NOT NULL CHECK (Extended_Days > 0)
);


-- TABLE: Article_traffic_law
CREATE TABLE Article_traffic_law(
    ID integer PRIMARY KEY,
    Number_of_Article varchar(20) CHECK (Number_of_Article ~* '^[0-9.]+$'), -- Только цифры и точки
    Amount money CHECK (Amount > money '0'), -- Только положительные значения
    Other_cost money CHECK (Other_cost > money '0') -- Только положительные значения
);
-- Нарушения правил
CREATE TABLE Fine(
    ID integer PRIMARY KEY,
    -- Уникальный номер штрафа, только цифры
    Number varchar(20) UNIQUE NOT NULL CHECK (Number ~* '^[0-9]+$'),
    -- Дата и время нарушения должны быть в прошлом
    DateTime timestamp NOT NULL CHECK (DateTime < now()),
    Article_id integer REFERENCES Article_traffic_law(ID),
    Contract_id integer REFERENCES Contract(ID),
    -- Статус оплаты может быть только один из двух вариантов
    Payment_Status varchar(15) NOT NULL CHECK (Payment_Status IN ('Не оплачено', 'Оплачено')),
    -- Оплата производится либо клиентом, либо фирмой
    Paid_By varchar(10) NOT NULL CHECK (Paid_By IN ('Клиент', 'Компания'))
);

-- Таблица аварий
CREATE TABLE Accident(
    ID serial PRIMARY KEY,
    Car_ID integer NOT NULL REFERENCES Car(ID),
    Contract_ID integer NOT NULL REFERENCES Contract(ID),
    -- Дата и время происшествия должны быть в прошлом
    Occurrence timestamp NOT NULL CHECK (Occurrence < now()),
    -- Описание обязательно
    Description text NOT NULL,
    -- Ущерб должен быть неотрицательным
    Damage_Cost money CHECK (Damage_Cost >= money '0')
);

-- Таблица с актуальной стоимостью аренды по бренду
CREATE TABLE Brand_Rental_Price(
    ID serial PRIMARY KEY,
    Brand_ID integer NOT NULL REFERENCES Brand(ID),
    -- Дата начала действия цены
    Effective_From date NOT NULL,
    -- Цена аренды за день должна быть положительной
    Daily_Price money NOT NULL CHECK (Daily_Price > money '0')
);
