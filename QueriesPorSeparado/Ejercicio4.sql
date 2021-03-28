use university;
select semester, year, grade, course_id from takes where course_id like 'CS-101';
select min(capacity), max(capacity) from classroom;