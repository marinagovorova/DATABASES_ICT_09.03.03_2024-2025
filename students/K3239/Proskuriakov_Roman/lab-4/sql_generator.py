from faker import Faker
import sqlite3
import random

fake = Faker()

print('INSERT INTO clients (surname, name, patronymic, phone_number, address) VALUES')

for _ in range(5000):
    surname = fake.last_name()
    name = fake.first_name()
    patronymic = fake.first_name() + '-' + fake.last_name()
    phone_number = ''.join(i for i in fake.phone_number() if (not i.isalpha() and i not in '-+().'))

    address = fake.address().replace('\n', ' ').replace(',', '').replace('.', '').replace('(', '')
    if len(address) < 20:
        continue
    
    substring_length = random.randint(20, min(50, len(address)))
    
    # Извлекаем подстроку
    address = address[:substring_length]

    print('(\'', end='')
    print(surname, name, patronymic, phone_number, address, sep='\', \'', end='\'')
    print('),')
