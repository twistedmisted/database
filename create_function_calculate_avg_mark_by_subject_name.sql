CREATE OR REPLACE FUNCTION calculate_avg_mark_by_subject_name(subject_name varchar(50))
    RETURNS FLOAT
AS
$$
DECLARE
    result FLOAT;
BEGIN
    SELECT avg(r.mark)
    INTO result
    FROM results r
             JOIN subjects s ON r.subject_id = s.id AND s.name = subject_name;
    RETURN result;
END;
$$ LANGUAGE plpgsql;

SELECT "calculate_avg_mark_by_subject_name"('f072301e370b4efdcfeb62c0ae3acdec');