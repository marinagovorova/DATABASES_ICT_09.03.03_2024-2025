

-- 1.1) Триггер 1: BEFORE INSERT на таблицу "Order"
--     Задача:
--       • Проверяю, чтобы количество товаров (product_count) было > 0.
--       • Проверяю, чтобы итоговая цена продажи (selling_price) была > 0.
--       • В случае нарушения выбрасываю ошибку, иначе разрешаю вставку.
CREATE OR REPLACE FUNCTION trg_order_before_insert_validate()
RETURNS TRIGGER LANGUAGE plpgsql AS $$
BEGIN
    -- Проверяю, что количество товаров не отрицательное или ноль
    IF NEW."product_count" <= 0 THEN
        RAISE EXCEPTION 'Error: product_count = % (must be > 0)', NEW."product_count";
    END IF;
    -- Проверяю, что цена продажи положительна
    IF NEW."selling_price" <= 0 THEN
        RAISE EXCEPTION 'Error: selling_price = % (must be > 0)', NEW."selling_price";
    END IF;
    RETURN NEW;
END;
$$;
DROP TRIGGER IF EXISTS order_before_insert_validate ON "Order";
CREATE TRIGGER order_before_insert_validate
BEFORE INSERT ON "Order"
FOR EACH ROW
EXECUTE PROCEDURE trg_order_before_insert_validate();

--Триггер 2: AFTER INSERT на таблицу "Order"
--     Задача:
--       • Веду простой аудит: после каждого нового заказа добавляю строку
--         в таблицу order_audit (содержит order_id, время события, кто создал).
--       • Таблица order_audit создаётся здесь, если её ещё нет.
CREATE TABLE IF NOT EXISTS order_audit (
    audit_id   serial PRIMARY KEY,
    order_id   integer NOT NULL,
    event_time timestamp NOT NULL DEFAULT clock_timestamp(),
    changed_by text    NOT NULL DEFAULT current_user
);
CREATE OR REPLACE FUNCTION trg_order_after_insert_audit()
RETURNS TRIGGER LANGUAGE plpgsql AS $$
BEGIN
    -- Добавляю запись в журнал после вставки заказа
    INSERT INTO order_audit(order_id) VALUES (NEW."order_id");
    RETURN NULL;
END;
$$;
DROP TRIGGER IF EXISTS order_after_insert_audit ON "Order";
CREATE TRIGGER order_after_insert_audit
AFTER INSERT ON "Order"
FOR EACH ROW
EXECUTE PROCEDURE trg_order_after_insert_audit();

-- 1.3) Триггер 3: BEFORE INSERT на таблицу "Shipment"
--     Задача:
--       • Не разрешаю вставить запись со значением date_of_delivery позже текущей даты.
--       • В случае ошибки выбрасываю EXCEPTION, иначе разрешаю вставку.
CREATE OR REPLACE FUNCTION trg_shipment_before_insert_validate()
RETURNS TRIGGER LANGUAGE plpgsql AS $$
BEGIN
    -- Проверяю, что дата доставки не в будущем
    IF NEW."date_of_delivery" > current_date THEN
        RAISE EXCEPTION 'Error: date_of_delivery = % > current_date', NEW."date_of_delivery";
    END IF;
    RETURN NEW;
END;
$$;
DROP TRIGGER IF EXISTS shipment_before_insert_validate ON "Shipment";
CREATE TRIGGER shipment_before_insert_validate
BEFORE INSERT ON "Shipment"
FOR EACH ROW
EXECUTE PROCEDURE trg_shipment_before_insert_validate();
-- 1.4) Триггер 4: BEFORE INSERT на таблицу "Scope of delivery"
--     Задача:
--       • Убедиться, что product_price неотрицателен. Если price < 0 — ошибка.
CREATE OR REPLACE FUNCTION trg_scope_before_insert_validate_price()
RETURNS TRIGGER LANGUAGE plpgsql AS $$
BEGIN
    -- Проверяю, что цена товара не отрицательная
    IF NEW."product_price" < 0 THEN
        RAISE EXCEPTION 'Error: product_price = % (must be >= 0)', NEW."product_price";
    END IF;
    RETURN NEW;
END;
$$;
DROP TRIGGER IF EXISTS scope_before_insert_validate_price ON "Scope of delivery";
CREATE TRIGGER scope_before_insert_validate_price
BEFORE INSERT ON "Scope of delivery"
FOR EACH ROW
EXECUTE PROCEDURE trg_scope_before_insert_validate_price();

-- 1.5) Триггер 5: BEFORE INSERT на таблицу "Product price"
--     Задача:
--       • Проверяю, чтобы новый период действия (beginning_of_the_validity_period — end_of_the_validity_period)
--         не пересекался с уже существующими периодами для того же product_id.
--       • Если перекрытие есть, выбрасываю EXCEPTION, иначе вставка проходит.
CREATE OR REPLACE FUNCTION trg_product_price_before_insert_no_overlap()
RETURNS TRIGGER LANGUAGE plpgsql AS $$
DECLARE cnt INTEGER;
BEGIN
    -- Проверяю, что новый период не пересекается с существующими
    SELECT COUNT(*) INTO cnt
    FROM "Product price"
    WHERE "product_id" = NEW."product_id"
      AND NOT (
          NEW."end_of_the_validity_period" < "beginning_of_the_validity_period"
       OR NEW."beginning_of_the_validity_period" > "end_of_the_validity_period"
      );
    IF cnt > 0 THEN
        RAISE EXCEPTION 'Error: validity period overlap for product_id = %', NEW."product_id";
    END IF;
    RETURN NEW;
END;
$$;
DROP TRIGGER IF EXISTS product_price_before_insert_no_overlap ON "Product price";
CREATE TRIGGER product_price_before_insert_no_overlap
BEFORE INSERT ON "Product price"
FOR EACH ROW
EXECUTE PROCEDURE trg_product_price_before_insert_no_overlap();

-- 1.6) Триггер 6: BEFORE DELETE на таблицу "Customer"
--     Задача:
--       • Если для клиента (customer_id) уже есть связанные строки в "Order", то запрещаю удаление.
--       • Иначе удаление проходит.
CREATE OR REPLACE FUNCTION trg_customer_before_delete_no_orders()
RETURNS TRIGGER LANGUAGE plpgsql AS $$
DECLARE cnt INTEGER;
BEGIN
    -- Считаю заказы клиента
    SELECT COUNT(*) INTO cnt FROM "Order" WHERE "customer_id" = OLD."customer_id";
    IF cnt > 0 THEN
        RAISE EXCEPTION 'Error: cannot delete customer % – they have % order(s)', OLD."customer_id", cnt;
    END IF;
    RETURN OLD;
END;
$$;
DROP TRIGGER IF EXISTS customer_before_delete_no_orders ON "Customer";
CREATE TRIGGER customer_before_delete_no_orders
BEFORE DELETE ON "Customer"
FOR EACH ROW
EXECUTE PROCEDURE trg_customer_before_delete_no_orders();

-- 1.7) Триггер 7
-- проверка корректности входа/выхода сотрудника (таблица "post")

--     Задача:
--       • Проверяю, чтобы ending_of_the_period (если указан) не был раньше begging_of_the_period.
--       • Проверяю отсутствие «открытого» периода (ending_of IS NULL) для того же worker_id
--         (нельзя вставить новый период, пока предыдущий открытый не закрыт).
--       • Проверяю, чтобы новый закрытый период (if ending_of not NULL) не пересекал
--         существующие (закрытые) периоды для этого же worker_id.


-- Шаг 1: Проверка, что выход не раньше входа
CREATE OR REPLACE FUNCTION trg_post_before_ins_upd_validate()
RETURNS TRIGGER LANGUAGE plpgsql AS $$
DECLARE
    cnt INT;
BEGIN
    -- Шаг 1: Проверка, что выход не раньше входа
    IF NEW."ending_of_the_period" IS NOT NULL
       AND NEW."ending_of_the_period" < NEW."begging_of_the_period" THEN
        RAISE EXCEPTION 'Error: ending_of_the_period = % < begging_of_the_period = %',
            NEW."ending_of_the_period", NEW."begging_of_the_period";
    END IF;

    -- Шаг 2: Проверка, есть ли открытый период (ending_of IS NULL) для этого же worker_id,
    --         кроме текущей (если обновляем). Если есть – запрещаю вставку/обновление.
    SELECT COUNT(*) INTO cnt
    FROM "post"
    WHERE "worker_id" = NEW."worker_id"
      AND "ending_of_the_period" IS NULL
      AND COALESCE(NEW."current_ position_ id", -1) <> "current_ position_ id";
    IF cnt > 0 THEN
        RAISE EXCEPTION 'Error: worker % has an unfinished period (no ending_of)', NEW."worker_id";
    END IF;

    -- Шаг 3: Если у нового периода указан ending_of (т.е. он закрытый), то проверяю,
    --         что этот период не пересекается с любым другим существующим закрытым периодом.
    IF NEW."ending_of_the_period" IS NOT NULL THEN
        SELECT COUNT(*) INTO cnt
        FROM "post" AS p
        WHERE p."worker_id" = NEW."worker_id"
          AND p."current_ position_ id" <> COALESCE(NEW."current_ position_ id", -1)
          AND (
               -- (a) Начало нового периода внутри чужого
               (NEW."begging_of_the_period" BETWEEN p."begging_of_the_period" AND p."ending_of_the_period")
            OR -- (b) Конец нового периода внутри чужого
               (NEW."ending_of_the_period"   BETWEEN p."begging_of_the_period" AND p."ending_of_the_period")
            OR -- (c) Чужой период внутри нового
               (p."begging_of_the_period"     BETWEEN NEW."begging_of_the_period" AND NEW."ending_of_the_period")
          );
        IF cnt > 0 THEN
            RAISE EXCEPTION 'Error: period [%–%] overlaps existing for worker_id = %',
                NEW."begging_of_the_period", NEW."ending_of_the_period", NEW."worker_id";
        END IF;
    END IF;

    -- Если все проверки прошли, возвращаю NEW, чтобы INSERT/UPDATE продолжился
    RETURN NEW;
END;
$$;
DROP TRIGGER IF EXISTS post_before_ins_upd_validate ON "post";
CREATE TRIGGER post_before_ins_upd_validate
BEFORE INSERT OR UPDATE ON "post"
FOR EACH ROW
EXECUTE PROCEDURE trg_post_before_ins_upd_validate();



-- 2. ПРОВЕРКИ ДЛЯ КАЖДОГО ТРИГГЕРА 


-- -- Проверка 1 (Order BEFORE INSERT):
-- Попытка вставить заказ с отрицательным product_count  → Должна вылететь EXCEPTION
INSERT INTO "Order"("order_id","customer_id","worker_id","order_date","selling_price","product_count","status")
VALUES (200, 2, 10, current_date, 100, -1, 'N');

-- Попытка вставить заказ с нулевой selling_price → EXCEPTION
INSERT INTO "Order"("order_id","customer_id","worker_id","order_date","selling_price","product_count","status")
VALUES (201, 2, 10, current_date, 0, 5, 'N');

-- Корректный заказ → Вставка выполняется
INSERT INTO "Order"("order_id","customer_id","worker_id","order_date","selling_price","product_count","status")
VALUES (202, 2, 10, current_date, 150, 3, 'N');

-- -- Проверка 2 (Order AFTER INSERT, audit):
-- После вставки order_id = 202 должна появиться запись в order_audit:
SELECT * FROM order_audit WHERE order_id = 202;

-- Ещё один новый заказ → audit
INSERT INTO "Order"("order_id","customer_id","worker_id","order_date","selling_price","product_count","status")
VALUES (203, 2, 10, current_date, 200, 4, 'N');
SELECT * FROM order_audit WHERE order_id = 203;

-- -- Проверка 3 (Shipment BEFORE INSERT):
-- Попытка вставить shipment с датой в будущем → EXCEPTION
INSERT INTO "Shipment"("shipment_id","provider_id","worker_id","batch_number","date_of_delivery","status")
VALUES (300, 3000, 10, 700, current_date + 1, 'A');

-- Корректный shipment (date_of_delivery = current_date) → Вставка
INSERT INTO "Shipment"("shipment_id","provider_id","worker_id","batch_number","date_of_delivery","status")
VALUES (301, 3000, 10, 701, current_date, 'A');

-- -- Проверка 4 (Scope of delivery BEFORE INSERT):
-- Попытка вставить партию с отрицательной ценой → EXCEPTION
INSERT INTO "Scope of delivery"("shipment_composition","shipment_id","product_count","product_price","product_id")
VALUES (400, 301, 5, -250, 4000);

-- Корректная партия (price >= 0) → Вставка
INSERT INTO "Scope of delivery"("shipment_composition","shipment_id","product_count","product_price","product_id")
VALUES (401, 301, 5, 250, 4000);

-- -- Проверка 5 (Product price BEFORE INSERT):
-- Сначала «первый» период для product_id = 4000
INSERT INTO "Product price"("product_price_id","product_id","beginning_of_the_validity_period","end_of_the_validity_period")
VALUES (500, 4000, '2025-01-01', '2025-06-30');

-- Попытка вставить перекрывающий период → EXCEPTION
INSERT INTO "Product price"("product_price_id","product_id","beginning_of_the_validity_period","end_of_the_validity_period")
VALUES (501, 4000, '2025-06-01', '2025-12-31');

-- Неперекрывающий период (начало сразу после) → Вставка
INSERT INTO "Product price"("product_price_id","product_id","beginning_of_the_validity_period","end_of_the_validity_period")
VALUES (502, 4000, '2025-07-01', '2025-12-31');

-- -- Проверка 6 (Customer BEFORE DELETE):
-- Попытка удалить клиента, у которого есть заказы (order_id = 202,203) → EXCEPTION
DELETE FROM "Customer" WHERE "customer_id" = 2;

-- Удаляю заказы этого клиента, затем удаление клиента → должно пройти
DELETE FROM "Order" WHERE "customer_id" = 2;
DELETE FROM "Customer" WHERE "customer_id" = 2;


-- -- Проверка 7 (post BEFORE INSERT/UPDATE):
-- Шаг A: вставляю открытый период (ending_of_the_period = NULL) для worker_id = 10 → OK
INSERT INTO "post"("current_ position_ id","post_id","worker_id","begging_of_the_period","ending_of_the_period","status")
VALUES (8000, 700, 10, '2025-01-01', NULL, 'A');

-- Шаг B: попытка вставить второй открытый период для того же worker_id = 10 → EXCEPTION
INSERT INTO "post"("current_ position_ id","post_id","worker_id","begging_of_the_period","ending_of_the_period","status")
VALUES (8001, 701, 10, '2025-02-01', NULL, 'A');

-- Шаг C: закрываю первый период → OK
UPDATE "post"
SET "ending_of_the_period" = '2025-03-01'
WHERE "current_ position_ id" = 8000;

-- Шаг D: попытка вставить перекрывающий период (начало 2025-02-15) → EXCEPTION
INSERT INTO "post"("current_ position_ id","post_id","worker_id","begging_of_the_period","ending_of_the_period","status")
VALUES (8002, 702, 10, '2025-02-15', '2025-05-01', 'A');

-- Шаг E: вставка корректного нового периода (2025-03-02 – 2025-06-01) → OK
INSERT INTO "post"("current_ position_ id","post_id","worker_id","begging_of_the_period","ending_of_the_period","status")
VALUES (8003, 703, 10, '2025-03-02', '2025-06-01', 'A');

-- Шаг F: попытка обновить запись, установив ending_of_the_period < begging_of_the_period → EXCEPTION
UPDATE "post"
SET "ending_of_the_period" = '2025-01-01'
WHERE "current_ position_ id" = 8003;
