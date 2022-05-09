-- Find user by name (exact match)
EXPLAIN ANALYZE
SELECT *
FROM students
WHERE name = '3ad2c7e5bb959f5b6fd092a4b31cbfef';

-- Find user by surname (partial match)
EXPLAIN ANALYZE
SELECT *
FROM students
WHERE surname ILIKE '%e76a%';

-- Find user by phone number (partial match)
EXPLAIN ANALYZE
SELECT *
FROM students
WHERE phone_numbers ILIKE '%1%67';

-- Find user with marks by user surname (partial match)
EXPLAIN ANALYZE
SELECT s.*, r.mark
FROM results r
         JOIN students s ON r.student_id = s.id and s.surname ILIKE '%e76a%';