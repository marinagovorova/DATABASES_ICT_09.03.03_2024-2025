-- ==============================================================
-- 1. Триггер: аудит изменений в паспортных/контактных данных студента
--    Таблица: "Student details"
--    Аудит-таблица: student_data_audit
-- ==============================================================

CREATE OR REPLACE FUNCTION fn_audit_student_data()
  RETURNS TRIGGER AS $$
BEGIN
  -- Я вставляю старые данные студента в таблицу аудита
  INSERT INTO student_data_audit (
    student_id,       -- id студента
    old_passport,     -- прежние паспортные данные
    old_contact,      -- прежние контактные данные
    old_issue_date,   -- прежняя дата выдачи паспорта
    old_expire_date,  -- прежняя дата истечения паспорта
    changed_at,       -- момент изменения
    changed_by        -- кто изменил (пользователь БД)
  ) VALUES (
    OLD.student_id,
    OLD.passport_data,
    OLD.contact_info,
    OLD.passport_issue_date,
    OLD.passport_expire_date,
    NOW(),
    current_user
  );
  -- Возвращаю NEW, чтобы обновление продолжилось
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Удаляю триггер, если он был, чтобы не было конфликта
DROP TRIGGER IF EXISTS trg_audit_student_data ON "Student details";

-- Создаю новый триггер на обновление "Student details"
CREATE TRIGGER trg_audit_student_data
  BEFORE UPDATE ON "Student details"
  FOR EACH ROW
  EXECUTE PROCEDURE fn_audit_student_data();


-- ==============================================================
-- 2. Триггер: проверка вместимости группы при вставке в "Student in a group"
--    Таблицы: "Student in a group", "Group"
-- ==============================================================

CREATE OR REPLACE FUNCTION fn_check_group_capacity()
  RETURNS TRIGGER AS $$
DECLARE
  cur_count INTEGER;
  cur_max   INTEGER;
BEGIN
  -- Я считаю, сколько студентов уже в этой группе
  SELECT COUNT(*) INTO cur_count
    FROM "Student in a group"
    WHERE group_id = NEW.group_id;

  -- Я получаю максимальный размер группы
  SELECT max_size INTO cur_max
    FROM "Group"
    WHERE group_id = NEW.group_id;

  -- Если группа переполнена, я выбрасываю исключение
  IF cur_count >= cur_max THEN
    RAISE EXCEPTION 'Невозможно добавить студента %, группа % заполнена (max_size = %)',
      NEW.student_id, NEW.group_id, cur_max;
  END IF;

  -- Возвращаю NEW, чтобы вставка продолжилась
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Удаляю старый триггер, если он существует
DROP TRIGGER IF EXISTS trg_check_group_capacity ON "Student in a group";

-- Создаю новый триггер перед вставкой в "Student in a group"
CREATE TRIGGER trg_check_group_capacity
  BEFORE INSERT ON "Student in a group"
  FOR EACH ROW
  EXECUTE PROCEDURE fn_check_group_capacity();


-- ==============================================================
-- 3. Триггер: автозаполнение program_id в "Document"
--    Таблицы: "Document", "Student in a group", "Group"
-- ==============================================================

CREATE OR REPLACE FUNCTION fn_fill_document_program()
  RETURNS TRIGGER AS $$
DECLARE
  last_group_program_id INTEGER;
BEGIN
  -- Я ищу последнюю группу студента, чтобы взять её program_id
  SELECT g.program_id
    INTO last_group_program_id
  FROM "Student in a group" AS sg
  JOIN "Group" AS g ON g.group_id = sg.group_id
  WHERE sg.student_id = NEW.student_id
  ORDER BY sg.enrollment_date DESC
  LIMIT 1;

  -- Если студент нигде не числится, я бросаю исключение
  IF last_group_program_id IS NULL THEN
    RAISE EXCEPTION 'Невозможно создать документ: студент % не числится в группе',
      NEW.student_id;
  END IF;

  -- Я подставляю program_id в NEW
  NEW.program_id := last_group_program_id;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Удаляю предыдущий триггер, если он есть
DROP TRIGGER IF EXISTS trg_fill_document_program ON "Document";

-- Создаю новый триггер перед вставкой в "Document"
CREATE TRIGGER trg_fill_document_program
  BEFORE INSERT ON "Document"
  FOR EACH ROW
  EXECUTE PROCEDURE fn_fill_document_program();


-- ==============================================================
-- 4. Триггер: проверка конфликтов в "Schedule"
--    Таблица: "Schedule"
-- ==============================================================

CREATE OR REPLACE FUNCTION fn_check_schedule_conflicts()
  RETURNS TRIGGER AS $$
DECLARE
  cnt_conflict INTEGER;
BEGIN
  -- Проверяю, свободен ли преподаватель в это время
  SELECT COUNT(*) INTO cnt_conflict
    FROM "Schedule"
    WHERE teacher_id   = NEW.teacher_id
      AND date         = NEW.date
      AND time         = NEW.time
      AND class_number = NEW.class_number
      AND semester     = NEW.semester;

  IF cnt_conflict > 0 THEN
    RAISE EXCEPTION 'Конфликт: преподаватель % уже занят в % % (пара %, семестр %)',
      NEW.teacher_id, NEW.date, NEW.time, NEW.class_number, NEW.semester;
  END IF;

  -- Проверяю, свободна ли аудитория в это же время
  SELECT COUNT(*) INTO cnt_conflict
    FROM "Schedule"
    WHERE classroom_id = NEW.classroom_id
      AND date         = NEW.date
      AND time         = NEW.time
      AND class_number = NEW.class_number
      AND semester     = NEW.semester;

  IF cnt_conflict > 0 THEN
    RAISE EXCEPTION 'Конфликт: аудитория % уже занята в % % (пара %, семестр %)',
      NEW.classroom_id, NEW.date, NEW.time, NEW.class_number, NEW.semester;
  END IF;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Удаляю старый триггер, если он есть
DROP TRIGGER IF EXISTS trg_check_schedule_conflicts ON "Schedule";

-- Создаю новый триггер перед вставкой или обновлением в "Schedule"
CREATE TRIGGER trg_check_schedule_conflicts
  BEFORE INSERT OR UPDATE ON "Schedule"
  FOR EACH ROW
  EXECUTE PROCEDURE fn_check_schedule_conflicts();


-- ==============================================================
-- 5. Триггер: защита старых записей в "Certification"
--    Таблица: "Certification"
-- ==============================================================

CREATE OR REPLACE FUNCTION fn_protect_old_certification()
  RETURNS TRIGGER AS $$
BEGIN
  -- Если прошёл месяц с даты аттестации, я запрещаю её изменение или удаление
  IF (TG_OP = 'UPDATE' OR TG_OP = 'DELETE')
     AND (OLD.assessment_date < CURRENT_DATE - INTERVAL '30 days') THEN
    RAISE EXCEPTION 'Нельзя % запись аттестации % за %: прошло более 30 дней',
      TG_OP, OLD.assessment_id, OLD.assessment_date;
  END IF;
  -- Возвращаю OLD, т. к. это BEFORE триггер
  RETURN OLD;
END;
$$ LANGUAGE plpgsql;

-- Удаляю прежний триггер, если он есть
DROP TRIGGER IF EXISTS trg_protect_old_certification ON "Certification";

-- Создаю новый триггер перед UPDATE или DELETE в "Certification"
CREATE TRIGGER trg_protect_old_certification
  BEFORE UPDATE OR DELETE ON "Certification"
  FOR EACH ROW
  EXECUTE PROCEDURE fn_protect_old_certification();


-- ==============================================================
-- 6. Триггер: обновление practice_hours в "Certification" после изменений в "Practice"
--    Таблицы: "Practice", "Certification"
-- ==============================================================

CREATE OR REPLACE FUNCTION fn_update_practice_hours_in_certification()
  RETURNS TRIGGER AS $$
DECLARE
  current_hours INTEGER;
BEGIN
  SELECT COALESCE(SUM(
    CASE
      WHEN p."Type" IN ('Laboratory', 'Individual') THEN 1
      ELSE 0
    END
  ), 0)
  INTO current_hours
  FROM "Practice" p
  WHERE p."Assessment_ID" = NEW."Assessment_ID";

  UPDATE "Certification"
    SET practice_hours = current_hours
  WHERE "assesament _id " = NEW."Assessment_ID";

  IF NOT FOUND THEN
    INSERT INTO "Certification" (
      "assesament _id ", "Student_ID", practice_hours
    ) VALUES (
      NEW."Assessment_ID", NEW."Student_ID ", current_hours
    );
  END IF;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;
DROP TRIGGER IF EXISTS trg_update_practice_hours ON "Practice";

CREATE TRIGGER trg_update_practice_hours
AFTER INSERT OR UPDATE OR DELETE ON "Practice"
FOR EACH ROW
EXECUTE FUNCTION fn_update_practice_hours_in_certification();


-- ==============================================================
-- 7. Триггер: проверка корректности «вход/выход» в time_punch
--    Таблица: "time_punch"
-- ==============================================================

CREATE OR REPLACE FUNCTION fn_check_in_out_strict()
  RETURNS TRIGGER AS $$
DECLARE
  last_rec RECORD;
BEGIN
  -- Получаю последнюю запись по этому сотруднику
  SELECT *
    INTO last_rec
  FROM time_punch
  WHERE employee_id = NEW.employee_id
  ORDER BY punch_time DESC
  LIMIT 1;

  -- Если записей ещё нет, то «выход» запрещён
  IF last_rec IS NULL THEN
    IF NEW.is_out_punch THEN
      RAISE EXCEPTION 'Нельзя вставить «выход» без «входа» для сотрудника %', NEW.employee_id;
    END IF;
    RETURN NEW;
  END IF;

  -- Запрещаю два «входа» подряд
  IF (NEW.is_out_punch = FALSE AND last_rec.is_out_punch = FALSE) THEN
    RAISE EXCEPTION 
      'Нельзя вставить два «входа» подряд для сотрудника % (последний вход был %)', 
      NEW.employee_id, last_rec.punch_time;
  END IF;

  -- Запрещаю два «выхода» подряд
  IF (NEW.is_out_punch = TRUE AND last_rec.is_out_punch = TRUE) THEN
    RAISE EXCEPTION 
      'Нельзя вставить два «выхода» подряд для сотрудника % (последний выход был %)', 
      NEW.employee_id, last_rec.punch_time;
  END IF;

  -- Если вставляется «выход» после «входа», проверяю, что время больше
  IF (NEW.is_out_punch = TRUE AND last_rec.is_out_punch = FALSE) THEN
    IF NEW.punch_time <= last_rec.punch_time THEN
      RAISE EXCEPTION 
        'Нельзя вставить «выход» со временем % раньше предыдущего «входа» % для сотрудника %', 
        NEW.punch_time, last_rec.punch_time, NEW.employee_id;
    END IF;
  END IF;

  -- Если вставляется «вход» после «выхода», проверяю, что время больше
  IF (NEW.is_out_punch = FALSE AND last_rec.is_out_punch = TRUE) THEN
    IF NEW.punch_time <= last_rec.punch_time THEN
      RAISE EXCEPTION 
        'Нельзя вставить «вход» со временем % раньше предыдущего «выхода» % для сотрудника %', 
        NEW.punch_time, last_rec.punch_time, NEW.employee_id;
    END IF;
  END IF;

  -- Общая проверка: время не может быть меньше или равно предыдущему
  IF NEW.punch_time <= last_rec.punch_time THEN
    RAISE EXCEPTION 
      'Нельзя указать время % раньше предыдущей отметки % для сотрудника %', 
      NEW.punch_time, last_rec.punch_time, NEW.employee_id;
  END IF;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Удаляю предыдущий триггер, если есть
DROP TRIGGER IF EXISTS trg_check_in_out_strict ON time_punch;

-- Создаю новый триггер перед вставкой в time_punch
CREATE TRIGGER trg_check_in_out_strict
  BEFORE INSERT ON time_punch
  FOR EACH ROW
  EXECUTE PROCEDURE fn_check_in_out_strict();




-- ===========================================
-- Тесты для триггеров 
-- ===========================================

-- ========== Тест 1: Аудит "Student details" ==========
-- Подготовка
INSERT INTO "Student"(full_name) VALUES ('Тест СИД') RETURNING student_id;  -- допустим, вернул 1001

INSERT INTO "Student details"(
  "Student_id",
  "Passport_data",
  "Contact_Info",
  "Passport_Issue_Data",
  "Passport_Expiry_Date"
) VALUES (
  1001,
  'AA11111111',
  'old@mail.ru',
  '2020-01-01',
  '2030-01-01'
);

-- Проверяю, что в аудите нет записей
SELECT COUNT(*) AS cnt_audit
FROM student_data_audit
WHERE student_id = 1001;  -- ожидаю 0

-- Выполняю обновление — должен сработать триггер
UPDATE "Student details"
SET "Contact_Info" = 'new@mail.ru'
WHERE "Student_id" = 1001;

-- Проверяю, что в аудите появилась запись со «старыми» данными
SELECT
  old_contact,
  old_passport,
  old_issue_date,
  old_expire_date,
  changed_by
FROM student_data_audit
WHERE student_id = 1001
ORDER BY changed_at DESC
LIMIT 1;
-- old_contact = 'old@mail.ru'
-- old_passport = 'AA11111111'
-- old_issue_date = '2020-01-01'
-- old_expire_date = '2030-01-01'


-- ========== Тест 2: Вместимость группы ==========
-- Подготовка
INSERT INTO "Group"(Program_ID, Max_Size, Start_Date, End_Date)
VALUES (1, 1, '2025-01-01', '2025-12-31')
RETURNING "Group_Id";  -- допустим, 2001

INSERT INTO "Student"(full_name) VALUES ('Студент1') RETURNING student_id;  -- 2002
-- первый студент проходит
INSERT INTO "Student in a group"(GROUP_id, Student_id, Enrollment_Date)
VALUES (2001, 2002, CURRENT_DATE);

INSERT INTO "Student"(full_name) VALUES ('Студент2') RETURNING student_id;  -- 2003
-- второму должно выдать ошибку вместимости
INSERT INTO "Student in a group"(GROUP_id, Student_id, Enrollment_Date)
VALUES (2001, 2003, CURRENT_DATE);
-- ожидаю: ERROR «Невозможно добавить студента 2003, группа 2001 заполнена (max_size = 1)»


-- ========== Тест 3: Автозаполнение program_id в "Document" ==========
-- Подготовка
-- 3.0. Чистим старые тестовые данные
DELETE FROM "Document"   WHERE "document_Id" IN (9001, 9002);
DELETE FROM "Student in a group" WHERE "GROUP_id" = 900;
DELETE FROM "Student"    WHERE "student_id "   IN (901, 902);
DELETE FROM "Group"      WHERE "Group_Id"     = 900;
DELETE FROM "Program"    WHERE "program_id"    = 90;

-- 3.1. Создаём программу
INSERT INTO "Program"(
  "program_id",
  "Name ",
  "Type ",
  "Duration_Hours ",
  "Completion _Document_Type ",
  "Assessment_Type "
) VALUES (
  90, 'ProgTest', 'T', 10, 'Doc', 'Exam'
);

-- 3.2. Создаём группу с Program_ID = 90
INSERT INTO "Group"(
  "Group_Id",
  "Program_ID",
  "Max_ Size ",
  "Start_Date ",
  "End_Date"
) VALUES (
  900, 90, 5, '2025-01-01', '2025-12-31'
);

-- 3.3. Создаём студента и записываем в группу
INSERT INTO "Student"(
  "student_id ",
  "full_name "
) VALUES (
  901, 'DocTest'
);
INSERT INTO "Student in a group"(
  "GROUP_id",
  "Student_id",
  "Enrollment_Date"
) VALUES (
  900, 901, CURRENT_DATE
);

-- 3.4. Вставляем документ без указания Program_id — триггер должен подставить 90
INSERT INTO "Document"(
  "document_Id",
  "student_ id ",
  "Document_Type ",
  "Issue_Date"
) VALUES (
  9001, 901, 'Diploma', '2025-06-07'
);

-- Проверяем, что program_id подставился автоматически
SELECT
  "Program_id"
FROM "Document"
WHERE "document_Id" = 9001;
-- Ожидается: 90

-- 3.5. Попытка для студента вне группы — должна упасть
INSERT INTO "Student"(
  "student_id ",
  "full_name "
) VALUES (
  902, 'NoGrp'
);

INSERT INTO "Document"(
  "document_Id",
  "student_ id ",
  "Document_Type ",
  "Issue_Date"
) VALUES (
  9002, 902, 'Act', '2025-06-07'
);
-- Ожидается: ERROR «Невозможно создать документ: студент 902 не числится в группе»


-- 4 тест 
-- 0. Удаляем тестовые данные, если они остались
DELETE FROM "Schedule" WHERE "shedule_id " IN (100, 101, 102, 103);
DELETE FROM "Group" WHERE "Group_Id" IN (50, 51, 52, 53);
DELETE FROM "Discipline" WHERE "subject_id" IN (1, 2, 3, 4);
DELETE FROM "Audience" WHERE "classroom_id " IN (10, 11);
DELETE FROM "Teacher" WHERE "teacher_id " IN (900, 901);

-- 1. Добавляем зависимые записи
INSERT INTO "Group"("Group_Id", "Program_ID", "Max_ Size ", "Start_Date ", "End_Date")
VALUES 
  (50, 1, 10, '2025-01-01', '2025-12-31'),
  (51, 1, 10, '2025-01-01', '2025-12-31'),
  (52, 1, 10, '2025-01-01', '2025-12-31'),
  (53, 1, 10, '2025-01-01', '2025-12-31');

INSERT INTO "Discipline"("subject_id", "Discipline_ID ", "Name ", "Hours ", "Assessment_Type ")
VALUES 
  (1, 1, 'Math', 36, 'Exam'),
  (2, 2, 'CS', 36, 'Exam'),
  (3, 3, 'Bio', 36, 'Test'),
  (4, 4, 'Phys', 36, 'Test');

INSERT INTO "Audience"("classroom_id ", "Type", "Number")
VALUES (10, 'Lecture', 101), (11, 'Seminar', 102);

INSERT INTO "Teacher"("teacher_id ", "Full_Name ", "Position", "Disciplines")
VALUES (900, 'Иванов И.И.', 'Профессор', 'Math'), (901, 'Петров П.П.', 'Доцент', 'Bio');

-- 2. Тест 1: первая пара — проходит успешно
INSERT INTO "Schedule"(
  "shedule_id ", "Subject_ID ", "Classroom_ID ", "Group_ID ",
  "Activity_ Type", "Class_Number", "Schedule_Date ", "Teacher_ID ",
  "Date ", "Time "
) VALUES (
  100, 1, 10, 50, 'Lecture', 1, '2025-06-15', 900, '2025-06-15', '09:00+03'
);

-- 3. Тест 2: конфликт по преподавателю – ожидается ОШИБКА
-- тот же преподаватель, дата, время, пара, семестр
INSERT INTO "Schedule"(
  "shedule_id ", "Subject_ID ", "Classroom_ID ", "Group_ID ",
  "Activity_ Type", "Class_Number", "Schedule_Date ", "Teacher_ID ",
  "Date ", "Time "
) VALUES (
  101, 2, 11, 51, 'Lecture', 1, '2025-06-15', 900, '2025-06-15', '09:00+03'
);

-- 4. Тест 3: конфликт по аудитории – ожидается ОШИБКА
-- та же аудитория, дата, время, пара, семестр
INSERT INTO "Schedule"(
  "shedule_id ", "Subject_ID ", "Classroom_ID ", "Group_ID ",
  "Activity_ Type", "Class_Number", "Schedule_Date ", "Teacher_ID ",
  "Date ", "Time "
) VALUES (
  102, 3, 10, 52, 'Seminar', 1, '2025-06-15', 901, '2025-06-15', '09:00+03'
);

-- 5. Тест 4: другая пара – проходит успешно
INSERT INTO "Schedule"(
  "shedule_id ", "Subject_ID ", "Classroom_ID ", "Group_ID ",
  "Activity_ Type", "Class_Number", "Schedule_Date ", "Teacher_ID ",
  "Date ", "Time "
) VALUES (
  103, 4, 10, 53, 'Seminar', 2, '2025-06-15', 900, '2025-06-15', '10:45+03'
);






-- Попытка для студента вне группы — должна выдать ошибку
INSERT INTO "Student"(full_name) VALUES ('NoGrp') RETURNING student_id;  -- 3003
INSERT INTO "Document"(student_id, "Document_Type", "Issue_Date")
VALUES (3003, 'Act', '2025-06-07');
-- ожидаю: ERROR «Невозможно создать документ: студент 3003 не числится в группе»




-- 1. Попытка вставить «выход» без предшествующего «входа» (ошибка)
INSERT INTO time_punch(employee_id, punch_time, is_out_punch)
VALUES (1, NOW(), TRUE);
-- ERROR: Нельзя вставить «выход» без «входа» для сотрудника 1

-- 2. Первый «вход» (успешно)
INSERT INTO time_punch(employee_id, punch_time, is_out_punch)
VALUES (1, NOW(), FALSE);
-- INSERT 0 1

-- 3. Второй «вход» подряд (ошибка: два входа подряд)
INSERT INTO time_punch(employee_id, punch_time, is_out_punch)
VALUES (1, NOW() + INTERVAL '1 hour', FALSE);
-- ERROR: Нельзя вставить два «входа» подряд для сотрудника 1 (последний вход был ...)

-- 4. «Выход» сразу после «входа» (успешно)
INSERT INTO time_punch(employee_id, punch_time, is_out_punch)
VALUES (1, NOW() + INTERVAL '2 hours', TRUE);
-- INSERT 0 1

-- 5. Снова «выход» подряд (ошибка: два выхода подряд)
INSERT INTO time_punch(employee_id, punch_time, is_out_punch)
VALUES (1, NOW() + INTERVAL '3 hours', TRUE);
-- ERROR: Нельзя вставить два «выхода» подряд для сотрудника 1 (последний выход был ...)

-- 6. «Выход» со временем раньше предыдущего «входа» (ошибка)
--    Здесь предыдущий «вход» был в NOW(), а «выход» ставят в NOW() - 1 hour
INSERT INTO time_punch(employee_id, punch_time, is_out_punch)
VALUES (1, NOW() - INTERVAL '1 hour', TRUE);
-- ERROR: Нельзя вставить «выход» со временем ... раньше предыдущего «входа» ...

-- 7. «Вход» с временем раньше предыдущего «выхода» (ошибка)
--    Предыдущий «выход» был в NOW() + 2 hours
INSERT INTO time_punch(employee_id, punch_time, is_out_punch)
VALUES (1, NOW() + INTERVAL '1 hour 30 minutes', FALSE);
-- ERROR: Нельзя вставить «вход» со временем ... раньше предыдущего «выхода» ...

-- 8. «Вход» спустя большой промежуток (например, 3 дня; разрешено)
INSERT INTO time_punch(employee_id, punch_time, is_out_punch)
VALUES (1, NOW() + INTERVAL '3 days', FALSE);
-- INSERT 0 1

-- 9. «Выход» спустя 2 часа после этого «входа» (успешно)
INSERT INTO time_punch(employee_id, punch_time, is_out_punch)
VALUES (1, NOW() + INTERVAL '3 days 2 hours', TRUE);
-- INSERT 0 1

-- 10. Попытка вставить «вход» с тем же временем, что был последний «выход» (ошибка)
--     Последний «выход» был в NOW() + 3 days 2 hours
INSERT INTO time_punch(employee_id, punch_time, is_out_punch)
VALUES (1, NOW() + INTERVAL '3 days 2 hours', FALSE);
-- ERROR: Нельзя указать время ... раньше предыдущей отметки ...

-- 11. Новый «вход» спустя ровно 1 минуту после последнего «выхода» (успешно)
INSERT INTO time_punch(employee_id, punch_time, is_out_punch)
VALUES (1, NOW() + INTERVAL '3 days 2 hours 1 minute', FALSE);
-- INSERT 0 1

-- 12. «Выход» спустя менее чем минуту (ошибка, время не строго больше)
--     Предыдущий «вход» был в NOW() + 3 days 2 hours 1 minute
INSERT INTO time_punch(employee_id, punch_time, is_out_punch)
VALUES (1, NOW() + INTERVAL '3 days 2 hours 1 minute', TRUE);
-- ERROR: Нельзя вставить «выход» со временем ... раньше предыдущего «входа» ...

-- 13. «Выход» спустя 1 минуту после предыдущего «входа» (успешно)
INSERT INTO time_punch(employee_id, punch_time, is_out_punch)
VALUES (1, NOW() + INTERVAL '3 days 2 hours 2 minutes', TRUE);
-- INSERT 0 1

-- 14. Попытка обновить запись (UPDATE) не проверяется триггером (только INSERT), поэтому проходит без ошибок:
UPDATE time_punch
SET punch_time = NOW()
WHERE id = 1;
-- UPDATE 1

-- 15. Нулевая дата или пустое время (если punch_time не NULL‑able, ошибка СУБД):
INSERT INTO time_punch(employee_id, is_out_punch)
VALUES (1, FALSE);
-- ERROR: Ошибка NOT NULL для punch_time. (В зависимости от схемы)

-- 16. Другой сотрудник вставляет «вход» (успешно)
INSERT INTO time_punch(employee_id, punch_time, is_out_punch)
VALUES (2, NOW(), FALSE);
-- INSERT 0 1

-- 17. Попытка «выхода» для сотрудника 2 с временем раньше его «входа» (ошибка)
INSERT INTO time_punch(employee_id, punch_time, is_out_punch)
VALUES (2, NOW() - INTERVAL '1 hour', TRUE);
-- ERROR: Нельзя вставить «выход» со временем ... раньше предыдущего «входа» ...
