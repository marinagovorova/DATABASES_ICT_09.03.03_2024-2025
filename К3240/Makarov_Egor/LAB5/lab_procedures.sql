

-- Процедура: понижаю цену у «залежавшихся» партий товара

DROP PROCEDURE IF EXISTS decrease_delivery_price_for_overstock(integer, integer);
CREATE OR REPLACE PROCEDURE decrease_delivery_price_for_overstock(
    _percent integer,  -- на сколько процентов снизить цену
    _days    integer   -- сколько дней хранится партия без скидки
)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Проверяю, что процент в диапазоне 0–100
    IF _percent < 0 OR _percent > 100 THEN
        RAISE EXCEPTION 'Неверный процент: % (должен быть от 0 до 100)', _percent;
    END IF;
    -- Проверяю, что дни неотрицательные
    IF _days < 0 THEN
        RAISE EXCEPTION 'Неверное значение дней: % (должно быть ≥ 0)', _days;
    END IF;

    -- Обновляю стоимость в "Scope of delivery" для партий старше _days
    UPDATE "Scope of delivery" AS sd
    SET "product_price" = sd."product_price" * (100 - _percent) / 100
    FROM "Shipment" AS s
    WHERE sd."shipment_id" = s."shipment_id"
      AND current_date - s."date_of_delivery" > _days;
    -- Снизил цену на _percent процентов для всех подходящих записей
END;
$$;


-- Процедура: считаю стоимость проданных за вчера партий

DROP PROCEDURE IF EXISTS calc_sold_batches_cost(OUT total_cost bigint);
CREATE OR REPLACE PROCEDURE calc_sold_batches_cost(OUT total_cost bigint)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Считаю сумму price * count по всем позициям из вчерашних заказов
    SELECT COALESCE(SUM(os."product_price" * os."product_count"), 0)
      INTO total_cost
    FROM "order structure" AS os
    JOIN "Order" AS o
      ON os."order_id" = o."order_id"
    WHERE o."order_date" >= (current_date - INTERVAL '1 day')
      AND o."order_date" < current_date;
    -- Записал результат в total_cost (0, если позиций не было)
END;
$$;
