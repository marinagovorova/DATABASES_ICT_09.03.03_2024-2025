/* проценты, просрочка, статус договора */
ALTER TABLE "Deposit_Contract"
    ADD COLUMN IF NOT EXISTS "Accrued_Interest" numeric(14,2) NOT NULL DEFAULT 0;

ALTER TABLE "Credit_Payment_Schedule"
    ADD COLUMN IF NOT EXISTS "Is_Overdue" boolean NOT NULL DEFAULT false;

ALTER TABLE "Credit_Contract"
    ADD COLUMN IF NOT EXISTS "Status" varchar(16) NOT NULL DEFAULT 'active'
        CHECK ("Status" IN ('active','closed'));


CREATE OR REPLACE FUNCTION check_payment_date()
RETURNS trigger AS
$$
DECLARE
    v_open date;
    v_term int;
    v_end  date;
BEGIN
    SELECT "Opening_Date", "Deposit_Term"
      INTO v_open, v_term
      FROM "Deposit_Contract"
     WHERE "Deposit_Contract_ID" = NEW."Deposit_Contract_ID";

    v_end := (v_open + (v_term || ' month')::interval)::date;

    IF NEW."Date" < v_open OR NEW."Date" > v_end THEN
        RAISE EXCEPTION
          'Payment date % outside contract period % — %',
          NEW."Date", v_open, v_end;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

        
/* 1 */
CREATE OR REPLACE FUNCTION trg_accrue_deposit_interest()
RETURNS trigger AS
$$
DECLARE v_rate numeric;
BEGIN
  SELECT dd."Interest_Rate"
    INTO v_rate
    FROM "Deposit_Contract" dc
    JOIN "Deposit_Data"    dd ON dd."Deposit_Data_ID" = dc."Deposit_ID"
   WHERE dc."Deposit_Contract_ID" = NEW."Deposit_Contract_ID";

  UPDATE "Deposit_Contract"
     SET "Accrued_Interest" =
         "Accrued_Interest" + (NEW."Amount" * v_rate / 100 / 12)
   WHERE "Deposit_Contract_ID" = NEW."Deposit_Contract_ID";

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS after_deposit_payment ON "Deposit_Payment_Schedule";
CREATE TRIGGER after_deposit_payment
AFTER INSERT ON "Deposit_Payment_Schedule"
FOR EACH ROW EXECUTE FUNCTION trg_accrue_deposit_interest();

/* 2 */
CREATE OR REPLACE FUNCTION trg_mark_overdue()
RETURNS trigger AS
$$
BEGIN
  IF NEW."Actual_Payment_Date" IS NULL
     AND NEW."Date" < CURRENT_DATE THEN
       NEW."Is_Overdue" := true;
  ELSE
       NEW."Is_Overdue" := false;
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS before_credit_payment_ins_upd
          ON "Credit_Payment_Schedule";
CREATE TRIGGER before_credit_payment_ins_upd
BEFORE INSERT OR UPDATE ON "Credit_Payment_Schedule"
FOR EACH ROW EXECUTE FUNCTION trg_mark_overdue();
/* 3 */
CREATE TABLE IF NOT EXISTS audit_employee (
  audit_id bigserial PRIMARY KEY,
  action   text,
  row_id   uuid,
  ts       timestamp DEFAULT now()
);

CREATE OR REPLACE FUNCTION trg_log_employee()
RETURNS trigger AS
$$
BEGIN
  INSERT INTO audit_employee(action,row_id)
  VALUES (TG_OP, COALESCE(NEW."Employee_ID", OLD."Employee_ID"));
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_audit_employee ON "Employee";
CREATE TRIGGER trg_audit_employee
AFTER INSERT OR UPDATE OR DELETE ON "Employee"
FOR EACH ROW EXECUTE FUNCTION trg_log_employee();
/* 4 */
CREATE OR REPLACE FUNCTION trg_check_min_deposit()
RETURNS trigger AS
$$
DECLARE v_min numeric;
BEGIN
  SELECT "Min_Amount" INTO v_min
  FROM   "Deposit_Data"
  WHERE  "Deposit_Data_ID" = NEW."Deposit_ID";

  IF NEW."Deposit_Amount" < v_min THEN
     RAISE EXCEPTION 'Deposit %. Amount % < minimal %',
                     NEW."Deposit_Contract_ID", NEW."Deposit_Amount", v_min;
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS check_min_deposit ON "Deposit_Contract";
CREATE TRIGGER check_min_deposit
BEFORE INSERT ON "Deposit_Contract"
FOR EACH ROW EXECUTE FUNCTION trg_check_min_deposit();
/* 5 */
CREATE OR REPLACE FUNCTION trg_lock_credit_rate()
RETURNS trigger AS
$$
BEGIN
  IF NEW."Interest_Rate" <> OLD."Interest_Rate" AND
     EXISTS (SELECT 1
             FROM "Credit_Payment_Schedule"
             WHERE "Credit_Contract_ID" = OLD."Credit_Contract_ID") THEN
     RAISE EXCEPTION 'Interest rate cannot be changed: payments already exist';
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS lock_credit_rate ON "Credit_Contract";
CREATE TRIGGER lock_credit_rate
BEFORE UPDATE ON "Credit_Contract"
FOR EACH ROW EXECUTE FUNCTION trg_lock_credit_rate();


/* 6 */
CREATE OR REPLACE FUNCTION trg_mark_credit_closed()
RETURNS trigger AS
$$
DECLARE rest numeric;
BEGIN
  SELECT SUM("Remaining_Debt")
    INTO rest
    FROM "Credit_Payment_Schedule"
   WHERE "Credit_Contract_ID" = NEW."Credit_Contract_ID";

  IF rest = 0 THEN
     UPDATE "Credit_Contract"
        SET "Status" = 'closed'
      WHERE "Credit_Contract_ID" = NEW."Credit_Contract_ID";
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS mark_credit_closed
          ON "Credit_Payment_Schedule";
CREATE TRIGGER mark_credit_closed
AFTER UPDATE ON "Credit_Payment_Schedule"
FOR EACH ROW EXECUTE FUNCTION trg_mark_credit_closed();

/* 7 */

CREATE OR REPLACE FUNCTION trg_protect_deposit_payment()
RETURNS trigger AS
$$
BEGIN
  IF OLD."Date" < CURRENT_DATE THEN
     RAISE EXCEPTION 'Cannot delete posted payment dated %', OLD."Date";
  END IF;
  RETURN OLD;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS protect_deposit_payment
          ON "Deposit_Payment_Schedule";
CREATE TRIGGER protect_deposit_payment
BEFORE DELETE ON "Deposit_Payment_Schedule"
FOR EACH ROW EXECUTE FUNCTION trg_protect_deposit_payment();
