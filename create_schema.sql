-- Design database for CDP program.
-- Your DB should store information
-- about students (name, surname, date of birth, phone numbers, primary skill,
-- created_datetime, updated_datetime etc.), subjects (subject name, tutor, etc.)
-- and exam results (student, subject, mark).
CREATE DATABASE module17;

CREATE TABLE students
(
    id               INT GENERATED ALWAYS AS IDENTITY NOT NULL,
    name             VARCHAR(50)                      NOT NULL,
    surname          VARCHAR(50)                      NOT NULL,
    date_of_birth    DATE                             NOT NULL,
    phone_numbers    VARCHAR(19)                      NOT NULL,
    primary_skill    VARCHAR(100)                     NOT NULL,
    created_datetime TIMESTAMP                        NOT NULL DEFAULT current_timestamp,
    updated_datetime TIMESTAMP                        NOT NULL DEFAULT current_timestamp
);

CREATE TABLE subjects
(
    id    INT GENERATED ALWAYS AS IDENTITY NOT NULL,
    name  VARCHAR(50)                      NOT NULL,
    tutor VARCHAR(50)                      NOT NULL
);

CREATE TABLE results
(
    student_id INT                              NOT NULL,
    subject_id INT                              NOT NULL,
    mark       INT                              NOT NULL
);