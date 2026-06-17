-- ==============================================================
-- Файл: lab5_procedures.sql
-- Содержит три процедуры (функции) для работы с базой данных:
-- 1. fn_add_student_with_data
-- 2. fn_record_attestation
-- 3. fn_transfer_student_between_groups
-- ==============================================================

-- ==============================================================
-- 1. Процедура: добавление нового студента с его паспортными данными
--    Возвращает созданный student_id
-- ==============================================================

CREATE OR REPLACE FUNCTION fn_add_student_with_data(
    p_full_name       VARCHAR,
    p_passport_data   CHAR(10),
    p_contact_info    VARCHAR,
    p_passport_issue  DATE,
    p_passport_expire DATE
) RETURNS INTEGER AS $$
DECLARE
    new_student_id INTEGER;
BEGIN
    -- Вставляем запись в таблицу Student и получаем новый student_id
    INSERT INTO Student(full_name)
    VALUES (p_full_name)
    RETURNING student_id INTO new_student_id;

    -- Вставляем запись в таблицу Student_Data
    INSERT INTO Student_Data(
      student_id,
      passport_data,
      contact_info,
      passport_issue_date,
      passport_expire_date
    ) VALUES (
      new_student_id,
      p_passport_data,
      p_contact_info,
      p_passport_issue,
      p_passport_expire
    );

    -- Возвращаем идентификатор созданного студента
    RETURN new_student_id;
END;
$$ LANGUAGE plpgsql;


-- ==============================================================
-- 2. Процедура: безопасная запись результатов аттестации
--    Проверяет, что студент числится в расписании по данной дисциплине,
--    прежде чем вставить запись в табл. Attestation.
-- ==============================================================

CREATE OR REPLACE FUNCTION fn_record_attestation(
    p_student_id      INTEGER,
    p_subject_id      INTEGER,
    p_practice_hours  INTEGER,
    p_grade           INTEGER,
    p_assessment_date DATE
) RETURNS VOID AS $$
DECLARE
    tmp_cnt        INTEGER;
    student_exists INTEGER;
    subject_exists INTEGER;
BEGIN
    -- 1. Базовые проверки
    IF p_student_id IS NULL THEN
      RAISE EXCEPTION 'student_id обязателен';
    END IF;
    IF p_subject_id IS NULL THEN
      RAISE EXCEPTION 'subject_id обязателен';
    END IF;
    IF p_grade IS NULL OR p_grade < 0 OR p_grade > 100 THEN
      RAISE EXCEPTION 'grade должен быть 0..100';
    END IF;
    IF p_practice_hours IS NULL OR p_practice_hours < 0 THEN
      RAISE EXCEPTION 'practice_hours не может быть отрицательным';
    END IF;
    IF p_assessment_date IS NULL THEN
      RAISE EXCEPTION 'assessment_date обязателен';
    ELSIF p_assessment_date > CURRENT_DATE THEN
      RAISE EXCEPTION 'assessment_date (%) не может быть в будущем', p_assessment_date;
    END IF;

    -- 2. Проверка существования студента
    SELECT COUNT(*) INTO student_exists
      FROM student
      WHERE student_id = p_student_id;
    IF student_exists = 0 THEN
      RAISE EXCEPTION 'Студента с id = % не существует', p_student_id;
    END IF;

    -- 3. Проверка существования предмета
    SELECT COUNT(*) INTO subject_exists
      FROM discipline
      WHERE subject_id = p_subject_id;
    IF subject_exists = 0 THEN
      RAISE EXCEPTION 'Дисциплины с id = % не существует', p_subject_id;
    END IF;

    -- 4. Проверка, что студент числится в расписании
    SELECT COUNT(*) INTO tmp_cnt
      FROM schedule AS s
      JOIN "student in a group" AS sg ON sg.group_id = s.group_id
      WHERE sg.student_id = p_student_id
        AND s.subject_id  = p_subject_id;
    IF tmp_cnt = 0 THEN
      RAISE EXCEPTION 'Студент % не числится на дисциплине %', p_student_id, p_subject_id;
    END IF;

    -- 5. Вставка результата
    INSERT INTO "Certification"(
      student_id,
      subject_id,
      practice_hours,
      grade,
      assessment_date
    ) VALUES (
      p_student_id,
      p_subject_id,
      p_practice_hours,
      p_grade,
      p_assessment_date
    );
END;
$$ LANGUAGE plpgsql;


-- ==============================================================
-- 3. Процедура: перевод студента из одной группы в другую
--    Проверяет вместимость новой группы, удаляет старую запись и
--    создаёт новую запись в Student_in_Group с текущей датой.
-- ==============================================================

CREATE OR REPLACE FUNCTION fn_transfer_student_between_groups(
    p_student_id   INTEGER,
    p_new_group_id INTEGER
) RETURNS VOID AS $$
DECLARE
    cur_count     INTEGER;
    cur_max       INTEGER;
    old_group_id  INTEGER;
BEGIN
    -- Находим текущую (последнюю) запись студента в Student_in_Group
    SELECT group_id
      INTO old_group_id
    FROM Student_in_Group
    WHERE student_id = p_student_id
    ORDER BY enrollment_date DESC
    LIMIT 1;

    IF old_group_id IS NULL THEN
      RAISE EXCEPTION 
        'Студент % не состоит ни в одной группе', 
        p_student_id;
    END IF;

    -- Проверяем текущую численность новой группы
    SELECT COUNT(*) 
      INTO cur_count
    FROM Student_in_Group
    WHERE group_id = p_new_group_id;

    -- Получаем максимальный размер новой группы
    SELECT max_size 
      INTO cur_max
    FROM "Group"
    WHERE group_id = p_new_group_id;

    IF cur_count >= cur_max THEN
      RAISE EXCEPTION 
        'Группа % уже заполнена (max_size = %)', 
        p_new_group_id, cur_max;
    END IF;

    -- Удаляем старую запись о принадлежности студента к группе
    DELETE FROM Student_in_Group
    WHERE student_id = p_student_id
      AND group_id = old_group_id;

    -- Вставляем новую запись с текущей датой
    INSERT INTO Student_in_Group(
      student_id,
      group_id,
      enrollment_date
    ) VALUES (
      p_student_id,
      p_new_group_id,
      CURRENT_DATE
    );
END;
$$ LANGUAGE plpgsql;
