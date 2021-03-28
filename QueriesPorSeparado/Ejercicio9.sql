use university;
SELECT  t1.name AS 'alumno',
        t5.name AS 'Profesor', t5.dept_name, t5.salary

FROM    section t3
        INNER JOIN teaches t4 ON
		t3.course_id = t4.course_id	AND
		t4.sec_id    = t3.sec_id	AND
		t4.semester  = t3.semester	AND
		t4.year      = t3.year

        INNER JOIN instructor t5   ON t4.ID = t5.ID
        INNER JOIN takes t2 ON
		t2.course_id = t3.course_id 	AND
		t2.sec_id    = t3.sec_id	AND
		t2.semester  = t3.semester	AND
		t2.year      = t3.year
        INNER JOIN student t1   ON t1.ID = t2.ID

WHERE t1.name='Sanchez'
ORDER BY t3.semester;