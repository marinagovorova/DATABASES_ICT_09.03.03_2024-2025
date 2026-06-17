/*--------------------------------------------------------------
   lab5_procedures.sql   (ЛР-5, задание 1)
   ▸ P1  fn_deposit_info
   ▸ P2  sp_add_deposit
   ▸ P3  fn_clients_no_debt
  --------------------------------------------------------------*/

/* 0. Расширение для генерации UUID */
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

/*================================================================
  P1  fn_deposit_info
  ---------------------------------------------------------------
  Возвращает по клиенту:
    • id вклада;
    • актуальную сумму (вклад + начисленный %);
    • сумму процентов за последний календарный месяц.
================================================================*/
CREATE OR REPLACE FUNCTION fn_deposit_info(p_client uuid)
RETURNS TABLE (
  deposit_id       uuid,
  total_amount     numeric,
  percent_last_mo  numeric)
LANGUAGE plpgsql
AS $$
BEGIN
  RETURN QUERY
  SELECT dc."Deposit_Contract_ID",
         (dc."Deposit_Amount" + dc."Accrued_Interest")::numeric,  -- ← cast
         COALESCE((
           SELECT SUM(ps."Amount")
           FROM   "Deposit_Payment_Schedule" ps
           WHERE  ps."Deposit_Contract_ID" = dc."Deposit_Contract_ID"
             AND  ps."Date" >= date_trunc('month', current_date) - interval '1 month'
             AND  ps."Date" <  date_trunc('month', current_date)
         ), 0)::numeric
  FROM   "Deposit_Contract" dc
  WHERE  dc."Client_ID" = p_client;
END;
$$;


/*================================================================
  P2  sp_add_deposit
  ---------------------------------------------------------------
  Оформляет новый вклад клиенту.
    • p_deposit_data_id – тип вклада (FK -> Deposit_Data)
    • p_client_id       – клиент
    • p_currency_id     – валюта вклада
    • p_term_months     – срок (мес.)
    • p_amount          – сумма вклада
    • p_employee_id     – сотрудник-оформитель
================================================================*/
CREATE OR REPLACE PROCEDURE sp_add_deposit (
    p_deposit_data_id uuid,
    p_client_id       uuid,
    p_currency_id     uuid,
    p_term_months     int,
    p_amount          numeric,
    p_employee_id     uuid )
LANGUAGE plpgsql
AS $$
DECLARE
  v_id uuid := gen_random_uuid();
BEGIN
  INSERT INTO "Deposit_Contract"(
      "Deposit_Contract_ID",
      "Deposit_ID",
      "Client_ID",
      "Opening_Date",
      "Deposit_Term",
      "Deposit_Amount",
      "Employee_ID",
      "Currency_ID")
  VALUES (v_id,
          p_deposit_data_id,
          p_client_id,
          current_date,
          p_term_months,
          p_amount,
          p_employee_id,
          p_currency_id);

  RAISE NOTICE 'Deposit % added', v_id;
END;
$$;

/*================================================================
  P3  fn_clients_no_debt
  ---------------------------------------------------------------
  Возвращает всех клиентов, у которых НЕТ просроченных платежей
  по кредитам (поле Is_Overdue = true нигде не встречается).
================================================================*/
CREATE OR REPLACE FUNCTION fn_clients_no_debt()
RETURNS TABLE (
  client_id uuid,
  full_name text )
LANGUAGE plpgsql
AS $$
BEGIN
  RETURN QUERY
  SELECT c."ID_client",
         c."Surname" || ' ' || c."Name"
  FROM   "Client" c
  WHERE NOT EXISTS (
        SELECT 1
        FROM   "Credit_Contract" cc
        JOIN   "Credit_Payment_Schedule" ps
               ON ps."Credit_Contract_ID" = cc."Credit_Contract_ID"
        WHERE  cc."Client_ID" = c."ID_client"
          AND  ps."Is_Overdue" = true );
END;
$$;

/*=====  проверочные вызовы (можно закомментировать)  =============
-- SELECT * FROM fn_deposit_info('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa');
-- CALL   sp_add_deposit(
--        'fd2a9c5b-d332-4c49-b74d-04f1e0683c83',
--        'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa',
--        (SELECT "Currency_ID" FROM "Currency" WHERE "Name"='RUB'),
--        6, 50000,
--        '11111111-1111-1111-1111-111111111111');
-- SELECT * FROM fn_clients_no_debt();
==================================================================*/

