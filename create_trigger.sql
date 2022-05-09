CREATE OR REPLACE FUNCTION update_last_updated_datetime_for_student()
    RETURNS TRIGGER
AS
$$
BEGIN
    NEW.updated_datetime = now();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tr_students_update
    AFTER UPDATE
    ON students
    FOR EACH ROW
EXECUTE PROCEDURE update_last_updated_datetime_for_student();