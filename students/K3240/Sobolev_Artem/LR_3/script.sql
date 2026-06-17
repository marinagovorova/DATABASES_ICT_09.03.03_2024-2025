--- подразделение ВУЗа
CREATE TABLE university_division (
	id SERIAL PRIMARY KEY,
	division_code INT UNIQUE NOT NULL CHECK(division_code >= 0), --- код подразделения
	division_name VARCHAR(100) UNIQUE NOT NULL --- направления подразделения
);

--- направление подготовки
CREATE TABLE training_direction (
	id SERIAL PRIMARY KEY,
	direction_code INT UNIQUE NOT NULL CHECK(direction_code >= 0), --- код направления
	direction_name VARCHAR(100) UNIQUE NOT NULL --- название направления
);

--- образовательная программа
CREATE TABLE education_program (
	id SERIAL PRIMARY KEY,
	education_code INT UNIQUE NOT NULL CHECK(education_code >= 0),
	number_hours INT NOT NULL CHECK(number_hours > 0),
	education_name VARCHAR(100) NOT NULL UNIQUE,
	division_id INT,
	direction_id INT, 
	FOREIGN KEY (division_id) REFERENCES university_division(id) ON DELETE RESTRICT,
	FOREIGN KEY (direction_id) REFERENCES training_direction(id) ON DELETE RESTRICT
);

--- Должность
CREATE TABLE staff_position (
	id SERIAL PRIMARY KEY,
	staff_name VARCHAR(30) NOT NULL --- название должности
);

--- Преподаватель
CREATE TABLE staff (
	id SERIAL PRIMARY KEY,
	first_name VARCHAR(30) NOT NULL, --- имя 
	last_name VARCHAR(30) NOT NULL, --- фамилия
	patronymic VARCHAR(30) --- отчество
);

--- История должностей
CREATE TABLE staff_history (
	id SERIAL PRIMARY KEY,
	start_date DATE NOT NULL, --- дата начала
	end_date DATE CHECK(end_date >= start_date), --- дата окончания
	position_id INT NOT NULL, --- связь с преподавателем
	staff_id INT NOT NULL, --- связь с должностью
	FOREIGN KEY (position_id) REFERENCES staff_position(id) ON DELETE RESTRICT,
	FOREIGN KEY (staff_id) REFERENCES staff(id) ON DELETE RESTRICT
);

--- Стипендия
CREATE TABLE scholarship (
	id SERIAL PRIMARY KEY,
	scholarship_name VARCHAR(50) NOT NULL UNIQUE --- название стипендии
);

--- Студент
CREATE TABLE student (
	id SERIAL PRIMARY KEY,
	gradebook_number INT NOT NULL UNIQUE CHECK(gradebook_number >= 0), --- номер зачетной книжки
	first_name VARCHAR(30) NOT NULL, --- имя
	last_name VARCHAR(30) NOT NULL, --- фамилия
	patronymic VARCHAR(30) --- отчество
);

--- Дисциплина
CREATE TABLE discipline (
	id SERIAL PRIMARY KEY,
	hours_count INT NOT NULL CHECK(hours_count > 0), --- объем часов
	discipline_name VARCHAR(30) UNIQUE --- название дисциплины
);

--- Аттестация
CREATE TABLE attestation (
	id SERIAL PRIMARY KEY,
	student_id INT NOT NULL, --- связь со студентом
	discipline_id INT NOT NULL, --- связь с  дисциплиной
	grade INT NOT NULL CHECK(grade BETWEEN 2 AND 5), --- оценка
	attempt_number INT NOT NULL CHECK(attempt_number BETWEEN 1 AND 3), --- попытка
	attestation_type VARCHAR(30) NOT NULL, --- тип аттестации
	FOREIGN KEY (student_id) REFERENCES student(id) ON DELETE RESTRICT,
	FOREIGN KEY (discipline_id) REFERENCES discipline(id) ON DELETE RESTRICT
);

--- Состав аттестационной комиссии
CREATE TABLE attestation_commission (
	id SERIAL PRIMARY KEY,
	staff_id INT NOT NULL, --- связь с преподавателем
	attestation_id INT NOT NULL, --- связь с аттестацией
	FOREIGN KEY(staff_id) REFERENCES staff(id) ON DELETE RESTRICT,
	FOREIGN KEY(attestation_id) REFERENCES attestation(id) ON DELETE CASCADE
);

--- Назначенная стипендия
CREATE TABLE award_scholarship (
	id SERIAL PRIMARY KEY,
	start_date DATE NOT NULL, --- дата начала 
	end_date DATE NOT NULL CHECK(end_date >= start_date), --- дата окончания
	description VARCHAR(100), --- описание
	student_id INT NOT NULL, --- связь со студентом
	scholarship_id INT NOT NULL, --- связь со стипендией
	FOREIGN KEY (student_id) REFERENCES student(id) ON DELETE CASCADE,
	FOREIGN KEY (scholarship_id) REFERENCES scholarship(id) ON DELETE CASCADE
);

--- Группа
CREATE table education_group (
	id SERIAL PRIMARY KEY,
	group_number INT UNIQUE NOT NULL CHECK(group_number >= 0), --- код группы
	education_program_id INT NOT NULL, --- связь с образовательной программой
	FOREIGN KEY (education_program_id) REFERENCES education_program(id) ON DELETE RESTRICT
);

--- Обучение
CREATE TABLE education (
	id SERIAL PRIMARY KEY,
	start_date DATE NOT NULL, --- дата начала обучения
	end_date DATE NOT NULL CHECK(end_date >= start_date), --- дата окончания обучения
	group_id INT NOT NULL, --- связь с группой
	student_id INT NOT NULL, --- связь со студентом
	FOREIGN KEY (group_id) REFERENCES education_group(id) ON DELETE RESTRICT,
	FOREIGN KEY (student_id) REFERENCES student(id) ON DELETE CASCADE
);

--- Расписание
CREATE TABLE schedule (
	id SERIAL PRIMARY KEY,
	start_date DATE NOT NULL, --- дата начала
	end_date DATE NOT NULL CHECK(end_date >= start_date), --- дата окончания
	place VARCHAR(50) NOT NULL, --- площадка
	education_group_id INT NOT NULL, --- связь с образовательной группой
	staff_id INT NOT NULL, --- связь с преподавателем
	discipline_id INT NOT NULL, --- связь с дисциплиной
	FOREIGN KEY (education_group_id) REFERENCES education_group(id) ON DELETE RESTRICT,
	FOREIGN KEY (staff_id) REFERENCES staff(id) ON DELETE RESTRICT,
	FOREIGN KEY (discipline_id) REFERENCES discipline(id) ON DELETE RESTRICT
);

--- Расписание сессии
CREATE TABLE session_schedule (
	id SERIAL PRIMARY KEY,
	classroom INT CHECK(classroom >= 0), --- аудитория
	area VARCHAR(100) NOT NULL, --- площадка
	exam_date TIMESTAMP NOT NULL CHECK(exam_date >= NOW()), --- дата экзамена
	education_group_id INT NOT NULL, --- связь с образовательной группой
	attestation_id INT NOT NULL, --- связь с аттестацией
	FOREIGN KEY (education_group_id) REFERENCES education_group(id) ON DELETE RESTRICT,
	FOREIGN KEY (attestation_id) REFERENCES attestation(id) ON DELETE CASCADE
);

--- Тип занятия
CREATE TABLE class_type (
	id SERIAL PRIMARY KEY,
	hours_count INT NOT NULL CHECK(hours_count > 0), --- объем часов
	type_name VARCHAR(50) NOT NULL UNIQUE, --- название типа занятия
	discipline_id INT NOT NULL, --- связь с дисциплиной
	FOREIGN KEY (discipline_id) REFERENCES discipline(id) ON DELETE RESTRICT
);

--- Учебный план
CREATE TABLE curriculum (
	id SERIAL PRIMARY KEY,
	education_program_id INT NOT NULL, --- связь с образовательной программой
	education_group_id INT NOT NULL, --- связь с учебной группой
	FOREIGN KEY(education_program_id) REFERENCES education_program(id) ON DELETE RESTRICT,
	FOREIGN KEY(education_group_id) REFERENCES education_group(id) ON DELETE RESTRICT
);

--- Состав учебного плана
CREATE TABLE composition_curriculum(
	id SERIAL PRIMARY KEY,
	hours_count INT NOT NULL CHECK(hours_count > 0), --- объем часов
	start_year INT NOT NULL CHECK(start_year BETWEEN 1900 AND 2100), --- год начала учебы
	discipline_id INT NOT NULL, --- связь с дисциплиной
	curriculum_id INT NOT NULL, --- связь с учебным планом
	FOREIGN KEY(discipline_id) REFERENCES discipline(id) ON DELETE RESTRICT,
	FOREIGN KEY(curriculum_id) REFERENCES curriculum(id) ON DELETE RESTRICT
);