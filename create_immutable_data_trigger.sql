CREATE OR REPLACE FUNCTION immutable_data_on_update()
    RETURNS TRIGGER
AS
$$
BEGIN
    IF exists(select 1 from student_address_updated where id = OLD.id) THEN
        UPDATE student_address_updated
        SET country    = NEW.country,
            city       = NEW.city,
            street     = NEW.street,
            home       = NEW.home,
            apartment  = NEW.apartment,
            student_id = NEW.student_id
        WHERE id = OLD.id;
    ELSE
        INSERT INTO student_address_updated
        VALUES (NEW.id, NEW.country, NEW.city, NEW.street, NEW.home, NEW.apartment, NEW.student_id);
    end if;
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tr_students_address_update
    BEFORE UPDATE
    ON student_address
    FOR EACH ROW
EXECUTE PROCEDURE immutable_data_on_update();

CREATE TABLE student_address
(
    id         INT GENERATED ALWAYS AS IDENTITY NOT NULL,
    country    VARCHAR(50)                      NOT NULL,
    city       VARCHAR(50)                      NOT NULL,
    street     VARCHAR(50)                      NOT NULL,
    home       VARCHAR(10)                      NOT NULL,
    apartment  INT,
    student_id INT                              NOT NULL,

    CONSTRAINT pk_student_address PRIMARY KEY (id),
    CONSTRAINT fk_student_address_students FOREIGN KEY (student_id) REFERENCES students (id)
);

CREATE TABLE student_address_updated
(
    id         INT         NOT NULL,
    country    VARCHAR(50) NOT NULL,
    city       VARCHAR(50) NOT NULL,
    street     VARCHAR(50) NOT NULL,
    home       VARCHAR(10) NOT NULL,
    apartment  INT,
    student_id INT         NOT NULL,

    CONSTRAINT pk_student_address_updated PRIMARY KEY (id),
    CONSTRAINT fk_student_address_updated_students FOREIGN KEY (student_id) REFERENCES students (id)
);

INSERT INTO student_address (country, city, street, home, apartment, student_id)
VALUES ('Ukraine', 'Kyiv', 'Victory St.', '19A', 10, 1),
       ('Ukraine', 'Kharkiv', 'Shevchenko St.', '2C', 35, 76345),
       ('Ukraine', 'Dnipro', 'Yaroslava Mudroho St.', '5', null, 12334),
       ('Ukraine', 'Sumy', 'Hetmana Mazepy St.', '35D', 13, 10000),
       ('Ukraine', 'Poltava', 'Naberezhna St.', '20', null, 15);

SELECT *
FROM student_address;

SELECT *
FROM student_address_updated;

update student_address set country = 'Poland' where id = 1;