CREATE OR REPLACE FUNCTION calculate_avg_mark_by_student_name(student_id int)
    RETURNS FLOAT
AS
$$
DECLARE
    result FLOAT;
BEGIN
    SELECT avg(r.mark)
    INTO result
    FROM results r
             JOIN students s ON r.student_id = student_id;
    RETURN result;
END;
$$ LANGUAGE plpgsql;

SELECT "calculate_avg_mark_by_student_name"(1);