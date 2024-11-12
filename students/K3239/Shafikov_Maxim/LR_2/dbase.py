import uuid
from datetime import datetime, time, date
from typing import Optional
from pydantic import BaseModel


class Car(BaseModel):
    id: uuid.UUID  # pk, unique
    government_code: str  # unique
    model: str
    brand: str
    technical_specifications: str
    country_origin: str
    price: int
    year_of_production: int
    mileage: int
    last_maintenance: datetime
    is_owned_company: bool


class Employee(BaseModel):
    id: uuid.UUID  # pk, unique
    name: str
    surname: str
    patronymic: Optional[str]
    age: int
    phone: str  # unique
    passport: str  # unique

    address_id: uuid.UUID  # ForeignKey["Address"], One to many
    position_id: uuid.UUID  # ForeignKey["Position"], One to many
    category_id: uuid.UUID  # ForeignKey["Category"], One to many


class Driver(BaseModel):
    id: uuid.UUID  # pk, unique
    employee_id: uuid.UUID  # ForeignKey["Employee"], One to One


class Client(BaseModel):
    id: uuid.UUID  # pk, unique
    phone: str  # unique


class Order(BaseModel):
    id: uuid.UUID  # pk, unique
    call_date: date
    boarding_time: time
    drop_off_time: time
    distance: int
    waiting_time: int
    complaint: Optional[str]
    rate: Optional[int]  # between 1 and 5

    start_location_id: uuid.UUID  # ForeignKey["Address"], Many to one
    end_location: uuid.UUID  # ForeignKey["Address"], Many to one
    driver_id: uuid.UUID  # ForeignKey["Driver"], Many to one
    client_id: uuid.UUID  # ForeignKey["Client"], Many to one
    car_id: uuid.UUID  # ForeignKey["Car"], Many to one


class Payment(BaseModel):
    id: uuid.UUID  # pk, unique
    amount: int
    is_cash: bool

    order_id: uuid.UUID  # ForeignKey["Order"], One to one
    card_id: Optional[uuid.UUID]  # ForeignKey["Card"], Many to one


class Card(BaseModel):
    id: uuid.UUID  # pk, unique
    number: str  # unique
    expiry_date: date


class ClientCard(BaseModel):  # Промежуточная таблица для связи Many to many
    client_id: uuid.UUID  # ForeignKey["Client"], Many to many
    card_id: uuid.UUID  # ForeignKey["Card"], Many to many


class Address(BaseModel):
    id: uuid.UUID  # pk, unique
    country: str
    city: str
    street: str
    house_number: int
    building: Optional[int]
    flat: Optional[int]


class WeeklySchedule(BaseModel):
    id: uuid.UUID  # pk, unique
    day_of_week: int  # between 1 and 7
    start_time: time
    end_time: time

    driver_id: uuid.UUID  # ForeignKey["Driver"], Many to one


class Position(BaseModel):
    id: uuid.UUID  # pk, unique
    name: str
    description: str


class Category(BaseModel):
    id: uuid.UUID  # pk, unique
    name: str
    description: str
