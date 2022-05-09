CREATE OR REPLACE FUNCTION select_student_in_red_zone()
    RETURNS TABLE
            (
                id      INT,
                name    VARCHAR(50),
                surname VARCHAR(50),
                date_of_birth DATE,
                phone_numbers VARCHAR(19),
                primary_skill VARCHAR(100)
            )
AS
$$
BEGIN
    RETURN QUERY SELECT s.id, s.name, s.surname, s.date_of_birth, s.phone_numbers, s.primary_skill
    FROM results r
             JOIN students s on r.student_id = s.id AND r.mark <= 3
    GROUP BY s.id
    HAVING count(*) >= 2;
END;
$$ LANGUAGE plpgsql;