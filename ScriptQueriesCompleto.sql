use university;
/*EJ 1	aqui se ver que ID es primary key y dept_name es foreign.
*/
describe instructor;
/*2 en la parte de cretae table instructor, vemos como pone primary key(ID) y luego pone foign key (dept_name)

 cat DDL.sql

3 /* a)*/
	 select dept_name, name from instructor where dept_name like 'Physics';
  /* b)*/
	 select count(ID) as Numero_de_instructores from instructor where ID like '%';
 /* c)*/
	select name, salary from instructor order by salary DESC;

/*4  a)*/
 	select semester, year, grade, course_id from takes where course_id like 'CS-101';
 /* b)*/
	select min(capacity), max(capacity) from classroom;


/*5*/
	 select budget, budget*20/100+budget as aumento from department order by budget desc;


/*6*/
SELECT DISTINCT
	name, dept_name,tot_cred,
	t2.course_id,
	semester, year, t2.grade
FROM
	student t1

INNER JOIN
	takes t2 ON t1.ID = t2.ID

WHERE name = 'Sanchez';

/*7*/

SELECT DISTINCT
	name, dept_name,tot_cred,
	t2.course_id,semester, year,t2.grade

FROM student t1
INNER JOIN takes t2 ON t1.ID = t2.ID
WHERE dept_name = 'Comp. Sci.';

/*8*/
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


/*student t1, takes t2, section t3, teaches t4,instructor t5*/
/*EJERCICIO 9*/
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
ORDER BY t3.semester
;

/*EJERCICIO 10*/
SELECT 	t1.name, t1.tot_cred,
	t2.semester, t2.year, t2.grade,
	t4.title, t4.dept_name, t4.credits

FROM	course t4
	INNER JOIN section t3 	ON t4.course_id = t3.course_id
	INNER JOIN takes t2 	ON t3.course_id = t2.course_id
	INNER JOIN student t1 	ON t2.ID = t1.ID

WHERE t1.name = 'Levy';