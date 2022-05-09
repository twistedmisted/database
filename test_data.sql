CREATE OR REPLACE FUNCTION test_data() RETURNS VOID AS
$$
BEGIN
    -- INSERT TEST DATA FOR `students` TABLE (100 000 rows)
    INSERT INTO students(name, surname, date_of_birth, phone_numbers, primary_skill, created_datetime, updated_datetime)
    SELECT md5(random()::TEXT),
           md5(random()::TEXT),
           NOW() - '1 year'::INTERVAL * (RANDOM()::INT * 100),
           (select '+(380)-99-' || right('' || (n / 10000), 3) || '54-50-' || right('0' || (n % 10000), 2)),
           md5(random()::TEXT),
           NOW() - '1 year'::INTERVAL * (RANDOM()::INT * 100 + 18),
           NOW() - '1 day'::INTERVAL * (RANDOM()::INT * 100)
    FROM generate_series(1, 100000) n;

    -- INSERT TEST DATA FOR `subjects` TABLE (1 000 rows)
    INSERT INTO subjects(name, tutor)
    SELECT md5(random()::TEXT),
           md5(random()::TEXT)
    FROM generate_series(1, 1000);

    -- INSERT TEST DATA FOR `results` TABLE (1 000 000 rows)
    FOR i IN 1..10
        LOOP
            FOR j IN 1..100000
                LOOP
                    INSERT INTO results VALUES (DEFAULT, j, i, floor(random() * 5 + 1)::INT);
                END LOOP;
        END LOOP;
END;
$$ LANGUAGE plpgsql;