-- Хорошая статейка: https://aglamov.biz/jazyki-programmirovanija/bazy-dannyh/postgresql/indeksy-i-optimizacija-zaprosov-v-postgresql-uskorjaem-rabotu-bazy-dannyh?ysclid=m9gtwagkuw461171750

INSERT INTO "mainS".category (category_name) VALUES ('Базы данных');
INSERT INTO "mainS".category (category_name) VALUES ('Языки программирования');

INSERT INTO "mainS".book (ISBN, categoty_id, page_count, book_title, publish_start_date, under_publish) VALUES
('978-5-93700-287-7', 6 ,520, 'Путеводитель по базам данных', '2025-01-02', TRUE);

INSERT INTO "mainS".author (first_name, surname, last_name, email) VALUES
('Владимир', 'Комаров', 'Иванович', 'komarov@mail.ru');

INSERT INTO "mainS".authorship (author_id, book_id, author_order) VALUES
(11, 11, 1);

INSERT INTO "mainS".tz (book_id, has_illustrations, paper_type, binding_type) VALUES
(11, TRUE, 'мелованная бумага', 'твердый переплет');

INSERT INTO "mainS".edit (tz_id, author_id, author_order) VALUES
(11, 11, 1);

INSERT INTO "mainS".edition (tz_id, edition_date, retail_price, status, quantity, remaining) VALUES
(11, CURRENT_DATE, 700, 'в продаже', 200, 187);

SELECT * FROM "mainS".edition;

ALTER TABLE "mainS".book RENAME COLUMN categoty_id TO category_id;


-- Список книг, изданных в текущем году и относящихся к категории «Базы данных».
SELECT * FROM "mainS".book
JOIN "mainS".category ON book.category_id=category.category_id
JOIN "mainS".tz ON tz.book_id=book.book_id
JOIN "mainS".edition ON edition.tz_id=tz.tz_id
WHERE category_name = 'Базы данных' AND edition_date > '2025-01-01' AND status IN ('в продаже', 'распродан');

-- Список покупателей, заказавших книг на сумму, превышающую среднюю сумму заказа за последний календарный год.
SELECT DISTINCT c.customer_id,
       c.first_name,
       c.surname,
       c.last_name,
       SUM(i.invoice_amount) AS total_spent
FROM "mainS".customer c
JOIN "mainS".contract ct ON c.customer_id = ct.customer_id
JOIN "mainS".invoice i ON ct.contract_id = i.contract_id
WHERE i.invoice_date BETWEEN '2023-01-01' AND '2024-01-01'
GROUP BY c.customer_id, c.first_name, c.surname, c.last_name
HAVING SUM(i.invoice_amount) >
       (
         SELECT AVG(total_amount)
         FROM (
           SELECT SUM(i2.invoice_amount) AS total_amount
           FROM "mainS".invoice i2
           WHERE i2.invoice_date BETWEEN '2023-01-01' AND '2024-01-01'
           GROUP BY i2.contract_id
         ) AS subquery
       )
ORDER BY total_spent DESC;

-- Список книг, которые не заказывались в течение последних двух кварталов
SELECT b.book_id, b.book_title
FROM "mainS".book b
WHERE b.book_id NOT IN (
    SELECT DISTINCT book_id
    FROM "mainS".tz
    JOIN "mainS".edition ed ON tz.tz_id = ed.tz_id
    WHERE ed.edition_date >= CURRENT_DATE - INTERVAL '6 months'
);

SELECT b.book_id, b.book_title, b.ISBN
FROM "mainS".book b
WHERE b.book_id NOT IN (
    SELECT DISTINCT b2.book_id
    FROM "mainS".book b2
    JOIN "mainS".tz t ON b2.book_id = t.book_id
    JOIN "mainS".edition e ON t.tz_id = e.tz_id
    JOIN "mainS".order_line ol ON e.edition_id = ol.edition_id
    JOIN "mainS".contract c ON ol.contract_id = c.contract_id
    WHERE c.signing_date >= DATE_TRUNC('quarter', CURRENT_DATE) - INTERVAL '6 months'
)
ORDER BY b.book_title;

-- Список авторов, не написавших ни одной книги, относящейся к категории “Языки программирования“.
SELECT a.author_id, a.first_name, a.surname
FROM "mainS".author a
WHERE a.author_id NOT IN (
    SELECT DISTINCT auth.author_id
    FROM "mainS".author auth
    JOIN "mainS".authorship au ON auth.author_id = au.author_id
    JOIN "mainS".book b ON au.book_id = b.book_id
    JOIN "mainS".category c ON b.category_id = c.category_id
    WHERE c.category_name = 'Языки программирования'
);

-- Список книг, в названиях которых содержится слово “проектирование“ и которые присутствуют на базе в количестве, превышающем 50 экземпляров.
EXPLAIN SELECT b.book_id, b.book_title, b.ISBN, SUM(ed.remaining) as tottal_remaning
FROM "mainS".book b
JOIN "mainS".tz ON tz.book_id = b.book_id
JOIN "mainS".edition ed ON ed.tz_id = tz.tz_id
WHERE b.book_title LIKE '%проектирование%' AND ed.status = 'в продаже' AND ed.remaining > 50
GROUP BY b.book_id, b.book_title, b.ISBN;

-- Покупателя, сделавшего заказ на максимальную сумму за последний месяц.

-- select * from "mainS".contract;
-- INSERT INTO "mainS".contract (customer_id, employee_id, service_cost, signing_date, service_date, work_act, work_status, delivery_address)
-- VALUES (2, 21, 340000, '2025-04-01', '2025-05-01', 'act_006.pdf', 'выполняется', 'Москва, ул. Ленина, 10');

SELECT c.customer_id, c.first_name, c.surname, co.service_cost, co.signing_date
FROM "mainS".customer c
JOIN "mainS".contract co ON c.customer_id = co.customer_id
WHERE co.signing_date >= CURRENT_DATE - INTERVAL '1 month'
ORDER BY co.service_cost DESC;


-- Список книг, не попавших ни в один из заказов в течение последнего года
SELECT b.book_id, b.book_title, b.ISBN
FROM "mainS".book b
WHERE b.book_id NOT IN (
        SELECT DISTINCT b2.book_id
        FROM "mainS".book b2
        JOIN "mainS".tz t ON b2.book_id = t.book_id
        JOIN "mainS".edition e ON t.tz_id = e.tz_id
        JOIN "mainS".order_line ol ON e.edition_id = ol.edition_id
        JOIN "mainS".contract co ON ol.contract_id = co.contract_id
        WHERE co.signing_date >= CURRENT_DATE - INTERVAL '1 year'
    );


-- Представление содержащее сведения о количестве заказанных экземпляров каждой книги, изданной в текущем году
CREATE OR REPLACE VIEW "mainS".current_year_orders AS
SELECT b.book_id, b.book_title, b.ISBN, SUM(ol.quantity) AS total_ordered,
	COUNT(DISTINCT co.contract_id) AS order_count
FROM "mainS".book b
JOIN "mainS".tz t ON b.book_id = t.book_id
JOIN "mainS".edition e ON t.tz_id = e.tz_id
JOIN "mainS".order_line ol ON e.edition_id = ol.edition_id
JOIN "mainS".contract co ON ol.contract_id = co.contract_id
WHERE EXTRACT(YEAR FROM e.edition_date) = EXTRACT(YEAR FROM CURRENT_DATE)
GROUP BY b.book_id, b.book_title, b.ISBN
ORDER BY total_ordered DESC;

SELECT * FROM "mainS".current_year_orders;


-- Представление количество заказов по покупателям за последний год

CREATE OR REPLACE VIEW "mainS".customer_orders_last_year AS
SELECT c.customer_id, c.first_name || ' ' || c.surname AS customer_name,
    COUNT(co.contract_id) AS order_count,
    SUM(co.service_cost) AS total_spent
FROM "mainS".customer c
JOIN "mainS".contract co ON c.customer_id = co.customer_id
WHERE co.signing_date >= CURRENT_DATE - INTERVAL '1 year'
GROUP BY c.customer_id, customer_name
ORDER BY order_count DESC, total_spent DESC;

SELECT * FROM "mainS".customer_orders_last_year;


-- Запросы с подзапросами
UPDATE "mainS".post p
SET salary = salary * 1.15
WHERE p.post_name IN ('Редактор', 'Программист');

select * from "mainS".post;


select * from "mainS".employee;

INSERT INTO "mainS".employee (post_id, first_name, surname, last_name, email)
VALUES (
    (SELECT post_id FROM "mainS".post WHERE post_name = 'Редактор'),
    'Иван',
    'Петров',
	'Игоревич',
    'ivan.petrov2@example.com'
);



select * from "mainS".invoice;

-- Чтобы он читал индексы принулительно.  включает или отключает использование планировщиком планов последовательного сканирования
SET enable_seqscan = OFF;
SET enable_seqscan = ON;

-- Сначала удаляем все счета по старым контрактам
DELETE FROM "mainS".invoice
WHERE contract_id IN (
    SELECT contract_id
    FROM "mainS".contract
    WHERE signing_date < CURRENT_DATE - INTERVAL '10 years'
);

-- Затем удаляем сами контракты
DELETE FROM "mainS".contract
WHERE signing_date < CURRENT_DATE - INTERVAL '10 years';


-- Создание составного индкса
CREATE INDEX idx_book_id_title_isbn ON "mainS".book(book_id, book_title, ISBN);

-- Создание простого индекса
CREATE INDEX idx_contract_signing_date ON "mainS".contract(signing_date);
CREATE INDEX idx_invoice_contract_id ON "mainS".invoice(contract_id);

ANALYZE "mainS".contract;
ANALYZE "mainS".invoice;

DROP INDEX "mainS".idx_contract_signing_date;
DROP INDEX "mainS".idx_invoice_contract_id;
DROP INDEX "mainS".idx_book_id_title_isbn;
