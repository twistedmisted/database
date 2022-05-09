CREATE TABLE tables_snapshot AS
SELECT st.name as student_name, st.surname as student_surname, sb.name as subject_name, r.mark
FROM results r
         JOIN students st ON r.student_id = st.id
         JOIN subjects sb on sb.id = r.subject_id;