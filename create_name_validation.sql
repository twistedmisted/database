CREATE OR REPLACE FUNCTION student_name_validation()
    RETURNS TRIGGER
AS
$$
BEGIN
    IF NEW.name ~~ '%#%' OR NEW.name ~~ '%@%' OR NEW.name ~~ '%$%' THEN
        RAISE EXCEPTION 'The student name is invalid';
    end if;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tr_students_insert
    BEFORE INSERT
    ON students
    FOR EACH ROW
EXECUTE PROCEDURE student_name_validation();