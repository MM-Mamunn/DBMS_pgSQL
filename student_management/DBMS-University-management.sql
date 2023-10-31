--create table department
create table department
(
	dept_name VARCHAR(30) PRIMARY KEY,
	building VARCHAR(30) NOT NULL,
	budget INTEGER NOT NULL
);
--alter table department alter column budget type real 

--insert
insert into department (
dept_name,building,budget
)
values 
	('CSE','Academic-1',10000000),
	('EEE','Academic-2',1000000),
	('CIVIL','Academic-3',12000000.0);

--create table course
create table course(
	course_id VARCHAR(30) PRIMARY KEY,
	title VARCHAR(30) NOT NULL,
	dept_name VARCHAR(30) REFERENCES department(dept_name) NOT NULL,
	credit real NOT NULL
	);
--alter table course alter column  title type VARCHAR(100) 

---insert
insert into course(
course_id,title,dept_name,credit
)
values
	('EEE-1101','Electrical Circuits 1','EEE',3),	
	('EEE-1102','Electrical Circuits 1 sessional','EEE',1.5),	
	('CE-1100','Civil Engineering Drawing and Digital Drafting','CIVIL',1.5),
	('CE-1103','Surveying','CIVIL',3),
	('CSE-1121','Computer Programmig 1','CSE',3),
	('CSE-1122','Computer Programmig 1 Lab','CSE',1.5);

--create section
create table section(
	course_id VARCHAR(30) REFERENCES course(course_id) NOT NULL,
	sec_id VARCHAR(30) primary key,
	semester VARCHAR(30) not null,
	year VARCHAR(10)  not null,
	building VARCHAR(30)  not null,
	room_number VARCHAR(30)  not null,
	time_slot_id TIME not null
	);

insert into section(
course_id,sec_id,semester,year,building,room_number,time_slot_id
)values
('EEE-1101','s1','1st','2023','Academic-2','101','11:00:00');
('EEE-1101','s2','1st','2023','Academic-2','102','11:40:00'),
('EEE-1102','s3','1st','2023','Academic-2','103','11:00:00'),
('EEE-1102','s4','1st','2023','Academic-2','104','11:40:00'),
('CE-1100','s5','2nd','2023','Academic-3','101','11:00:00'),
('CE-1100','s6','2nd','2023','Academic-3','102','11:40:00'),
('CE-1103','s7','3rd','2023','Academic-3','103','11:00:00'),
('CE-1103','s8','3rd','2023','Academic-3','104','11:40:00'),
('CSE-1121','s9','1st','2023','Academic-1','101','11:00:00'),
('CSE-1121','s10','1st','2023','Academic-1','102','11:40:00'),
('CSE-1122','s11','1st','2023','Academic-1','103','11:00:00'),
('CSE-1122','s12','1st','2023','Academic-1','104','11:40:00');


--create instructor
create table instructor(
	id VARCHAR(30) PRIMARY KEY,
	name VARCHAR(30) not null,
	dept_name VARCHAR(30) REFERENCES department(dept_name),
	salary real NOT NULL
	);
--ALTER TABLE instructor ALTER COLUMN dept_name SET NOT NULL;

--insert
insert into instructor(
id,name,dept_name,salary)
values
	('T1','Tanveer Ahsan','CSE',70000),
	('T2','Akash','CSE',50000),
	('T3','N M','CSE',50000);
	('T4','J A','EEE',50000),
	('T5','Y A','EEE',70000),
    ('T6','A B','CIVIL',50000),
	('T7','C D','CIVIL',70000);
	

--create teaches
create table teaches (
	id VARCHAR(30) REFERENCES instructor(id) not null,
	--course_id VARCHAR(30) REFERENCES course(course_id) not null,
	sec_id VARCHAR(30) REFERENCES section(sec_id)not null,
	semester varchar(30), 
	year varchar(30) 
	);

--insert
insert into teaches(
id,sec_id)
values
('T4','s1'),
('T5','s2'),
('T4','s3'),
('T5','s4'),
('T6','s5'),
('T6','s6'),
('T7','s7'),
('T7','s8'),
('T1','s9'),
('T2','s10'),
('T3','s11'),
('T2','s12');

--create student
create table student (
	id VARCHAR(30) primary key,
	name varchar (30) not null,
	dept_name varchar(30) references department(dept_name) NOT NULL,
	tot_cred real 
	);
--alter table student  alter column  name type VARCHAR(100) 
--insert
insert into student(
id,name,dept_name)
values
('C221043','Tawheedul Amin Siam','EEE'),
('C221059','Istahadul Haque Tasin','EEE'),
('C221046','Mamun Mahmud','CSE'),
('C221050','Rayhan Uddain','CSE'),
('C221060','Najmus Sakib Rafi','CIVIL'),
('C221076','Faisal Haque Rifat','CIVIL');

--create takes
create table takes(
	id VARCHAR(30) references student(id) NOT NULL,
	course_id varchar(30) references course(course_id) NOT NULL,
	sec_id varchar(30) references section(sec_id) NOT NULL,
	semester varchar(30), 
	year varchar(30),
	grade real check (grade >= 0 and grade <=4 or grade = NULL)
	);
	
--insert
insert into takes(
id,course_id,sec_id
)
values
('C221043','EEE-1101','s1'),
('C221043','EEE-1102','s3'),
('C221043','CE-1100','s5'),
('C221059','EEE-1101','s2'),
('C221046','EEE-1101','s2'),
('C221046','EEE-1102','s4'),
('C221046','CE-1100','s5'),
('C221046','CE-1103','s8'),
('C221046','CSE-1121','s9'),
('C221046','CSE-1122','s12'),
('C221050','CSE-1121','s9'),
('C221050','CSE-1122','s11'),
('C221050','EEE-1102','s3'),
('C221060','CE-1100','s6'),
('C221060','CE-1103','s7'),
('C221060','CSE-1122','s12'),
('C221076','CE-1103','s8'),
('C221076','CSE-1121','s10'),
('C221076','EEE-1101','s1');




--test queries
select * from department
select * from course
select * from instructor
select * from section
select * from student
select * from takes 
select * from teaches

--q1
select * from department
--q2
select * from course where credit != 3
--q3
select * from student order by id asc
--q4
select credit,count(*) as total from course group by credit
--q5
select dept_name,count(*) as total from instructor group by dept_name
--q6
select   name,title,sec_id from takes join student on takes.id= student.id join course on  course.course_id= takes.course_id where student.id = 'C221076'
--q6 if course_id is not a table of takes,only sec_id provided
select name ,title,temp2.sec_id from (select temp.sec_id,temp.name,section.course_id  from (select  takes.sec_id,name  from takes join student on takes.id =student.id and takes.id='C221076')as temp join section on temp.sec_id=section.sec_id) as temp2 join course on temp2.course_id = course.course_id  
--q7
select * from section where course_id = 'CSE-1121'

--extra

--all information of student with totall credit(By nested query)
	select student.name,student.id,temp2.sum from
    (
		select sid, sum(credit)   from 
		(
	   		select takes.id as sid, credit from takes join course on takes.course_id = course.course_id
  		)
		as temp group by sid
	) 
	as temp2 join student on temp2.sid = student.id where student.id='C221050'

--all information of student with totall credit
select student.id,sum(credit)
from takes 
join course on course.course_id = takes.course_id
join student on takes.id = student.id
group by student.id

---select all instructor of all student(by nested query)
 	select DISTINCT on (student.id,student.name,temp2.name) student.id,student.name,temp2.name as t_name  from 
 	(
		select temp.sid,instructor.name from
 		 (
			 select takes.id as sid ,teaches.id as tid from takes join teaches on takes.sec_id= teaches.sec_id
		 ) 
  		  as temp join instructor on temp.tid =instructor.id 
	) 
 	as temp2 join student on student.id = temp2.sid where id = 'C221050'

---select all instructor of all student
select   
student.id,student.name,instructor.name
from takes 
join teaches on takes.sec_id= teaches.sec_id
join instructor on instructor.id = teaches.id
join student on student.id = takes.id 
where student.id= 'C221050'
