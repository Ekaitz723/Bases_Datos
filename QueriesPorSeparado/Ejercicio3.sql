use university;
select dept_name, name from instructor where dept_name like 'Physics';
select count(ID) as Numero_de_instructores from instructor where ID like '%';
select name, salary from instructor order by salary DESC;