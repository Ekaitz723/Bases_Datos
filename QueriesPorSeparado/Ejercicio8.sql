use university;
SELECT
	t1.name,
	t2.building, t2.room_number, t2.capacity
FROM
	student t1
JOIN takes t3 ON t1.ID = t3.ID
JOIN section t4 ON t3.course_id = t4.course_id
JOIN classroom t2 ON t4.building = t2.building

WHERE
	t1.name = 'Sanchez';