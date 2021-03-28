use university;
SELECT 	t1.name, t1.tot_cred,
	t2.semester, t2.year, t2.grade,
	t4.title, t4.dept_name, t4.credits

FROM	course t4
	INNER JOIN section t3 	ON t4.course_id = t3.course_id
	INNER JOIN takes t2 	ON t3.course_id = t2.course_id
	INNER JOIN student t1 	ON t2.ID = t1.ID

WHERE t1.name = 'Levy';