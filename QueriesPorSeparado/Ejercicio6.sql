use university;
SELECT DISTINCT
	name, dept_name,tot_cred,
	t2.course_id,
	semester, year, t2.grade
FROM
	student t1

INNER JOIN
	takes t2 ON t1.ID = t2.ID

WHERE name = 'Sanchez';