-- CONSTRAINTS FOR `students` TABLE
ALTER TABLE students
    ADD CONSTRAINT pk_students PRIMARY KEY (id);
ALTER TABLE students
    ADD CONSTRAINT  uq_students_phone_numbers UNIQUE (phone_numbers);
ALTER TABLE students
    ADD CONSTRAINT uq_students_name_surname_phone_numbers UNIQUE (name, surname, phone_numbers);

-- CONSTRAINTS FOR `subjects` TABLE
ALTER TABLE subjects
    ADD CONSTRAINT pk_subjects PRIMARY KEY (id);
ALTER TABLE subjects
    ADD CONSTRAINT uq_subjects_name_tutor UNIQUE (name, tutor);

-- CONSTRAINTS FOR `results` TABLE
ALTER TABLE results
    ADD CONSTRAINT pk_results PRIMARY KEY (student_id, subject_id);
ALTER TABLE results
    ADD CONSTRAINT fk_results_students FOREIGN KEY (student_id) REFERENCES students (id);
ALTER TABLE results
    ADD CONSTRAINT fk_results_subjects FOREIGN KEY (subject_id) REFERENCES subjects (id);

-- INDEXES FOR `students` TABLE
CREATE INDEX ix_students_phone_numbers ON students USING gist (phone_numbers);
CREATE INDEX ix_students_name ON students USING hash (name);
CREATE INDEX ix_students_surname ON students USING gin (surname);
CREATE INDEX ix_students_name_surname ON students USING hash (name, surname);

-- INDEXES FOR `subjects` TABLE
CREATE INDEX ix_subjects_name ON subjects USING hash (name);
CREATE INDEX ix_subjects_tutor ON subjects USING gin (tutor);

-- INDEXES FOR `results` TABLE
CREATE INDEX ix_results_mark ON results USING btree (mark);