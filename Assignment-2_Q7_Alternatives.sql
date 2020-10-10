CREATE DATABASE assignment2A;
USE assignment2A;

CREATE TABLE roles (
  role_id int not null auto_increment,
  role_name varchar(20),
  PRIMARY KEY (role_id)
);

CREATE TABLE department (
  dept_id int not null auto_increment,
  dept_name varchar(25),
  PRIMARY KEY (dept_id)
);

CREATE TABLE users (
  user_id int not null auto_increment,
  first_name varchar(15),
  last_name varchar(15),
  phone_number varchar(10),
  password varchar(25),
  role_id int,
  PRIMARY KEY (user_id),
  FOREIGN KEY (role_id) REFERENCES roles (role_id)
);

CREATE TABLE hospital_staff (
  staff_id int not null auto_increment,
  user_id int,
  dept_id int,
  qualification varchar(50),
  PRIMARY KEY (staff_id),
  FOREIGN KEY (user_id) REFERENCES users (user_id),
  FOREIGN KEY (dept_id) REFERENCES department (dept_id)
);

CREATE TABLE op_timings (
  op_timing_id int not null auto_increment,
  op_day varchar(10),
  start_time time,
  end_time time,
  PRIMARY KEY (op_timing_id)
);

-- To solve: Error Code: 1267. Illegal mix of collations (latin1_swedish_ci,IMPLICIT) and (utf8mb4_general_ci,COERCIBLE) for operation '='
SET collation_connection = 'utf8_general_ci';
ALTER DATABASE assignment2a CHARACTER SET utf8 COLLATE utf8_general_ci;
ALTER TABLE op_timings CONVERT TO CHARACTER SET utf8 COLLATE utf8_general_ci;

CREATE TABLE hospital_staff_op_timings (
  staff_id int,
  op_timing_id int,
  FOREIGN KEY (staff_id) REFERENCES hospital_staff (staff_id),
  FOREIGN KEY (op_timing_id) REFERENCES op_timings (op_timing_id)
);

CREATE TABLE booking (
  booking_id int not null auto_increment,
  patient_id int,
  booking_date date,
  dept_id int,
  staff_id int,
  op_timing_id int,
  booking_time datetime,
  PRIMARY KEY (booking_id),
  FOREIGN KEY (patient_id) REFERENCES patients (patient_id),
  FOREIGN KEY (dept_id) REFERENCES department (dept_id),
  FOREIGN KEY (staff_id) REFERENCES hospital_staff (staff_id),
  FOREIGN KEY (op_timing_id) REFERENCES op_timings (op_timing_id)
);

-- roles
INSERT INTO roles (role_id, role_name) VALUES (1, "Patient");
INSERT INTO roles (role_name) VALUES ("Doctor");
SELECT * FROM roles;

-- department
INSERT INTO department (dept_id, dept_name) VALUES (11, "Neurology");
INSERT INTO department (dept_name) VALUES ("Cardiology"), ("Radiology"), ("Gynocology"), ("General Medicine");
SELECT * FROM department; 

-- users
INSERT INTO users (user_id, first_name, last_name, phone_number, password, role_id) VALUES
(101, "Ananya", "Vinod", "6234567899", "ananya@123", 1);
INSERT INTO users (first_name, last_name, phone_number, password, role_id) VALUES
("Ann", "Susan", "6234567899", "ann@123", 1),
("Haripriya", "Jagannathan", "6234567899", "haripriya@123", 1),
("Nikhil", "Anil Kumar", "6234567899", "nikhil@123", 1),
("Sidharth", "Sujithlal", "6234567899", "sidharth@123", 1),
("Thejus", "Satheesan", "6234567899", "thejus@123", 1),
("Priya", "Sasidharan", "6234567899", "priya@123", 2),
("Arunraj", "Saraswathi", "6234567899", "arunraj@123", 2),
("Sreejith", "Mullakkal", "6234567899", "sreejith@123", 2),
("Nishin", "T N", "6234567899", "nishin@123", 2),
("Anusree", "Nambiar", "6234567899", "anusree@123", 2);
SELECT * FROM users;

-- hospital_staff
INSERT INTO hospital_staff (staff_id, user_id, dept_id, qualification) VALUES (1001,  107, 11, "MBBS, M.D(Medicine), DM(Neurology)");
INSERT INTO hospital_staff (user_id, dept_id, qualification) VALUES 
(108, 12, "MBBS, M.D(Medicine), DM(Cardiology)"),
(109, 15, "MBBS, M.D(Medicine), M.Sc(Medicine)"),
(110, 15, "MBBS, M.D(Medicine), M.D(Medicine)"),
(111, 14, "MBBS, M.D, DGO"); 
SELECT * FROM hospital_staff;

-- op_timings
ALTER TABLE op_timings AUTO_INCREMENT=2001; -- Starts id value from 2001
INSERT INTO op_timings (op_day, start_time, end_time) VALUES
("Monday", "09:00:00", "12:00:00"),
("Tuesday", "14:00:00", "17:00:00"),
("Wednesday", "10:00:00", "20:00:00"),
("Thursday", "11:00:00", "14:00:00"),
("Friday", "09:00:00", "18:00:00"),
("Saturday", "14:00:00", "18:00:00"),
("Sunday", "10:00:00", "14:00:00"),
("Monday", "16:00:00", "20:00:00");
SELECT * FROM op_timings;

-- hospital_staff_op_timings
INSERT INTO hospital_staff_op_timings (staff_id, op_timing_id) VALUES
(1001, 2005),
(1001, 2001),
(1002, 2002),
(1002, 2006),
(1003, 2001),
(1003, 2002),
(1003, 2005),
(1004, 2003),
(1004, 2004),
(1005, 2005),
(1005, 2007),
(1005, 2002),
(1002, 2008);
SELECT * FROM hospital_staff_op_timings;

-- booking
ALTER TABLE booking AUTO_INCREMENT=1000001;
INSERT INTO booking (patient_id, booking_date, dept_id, staff_id, op_timing_id, booking_time) VALUES
(3002, "2020-10-12", 15, 1003, 2001, "2020-10-09 20:10:40"), -- obtained using localtime()
(3004, "2020-10-10", 12, 1002, 2006, "2020-10-09 10:10:40"),
(3005, "2020-10-11", 14, 1005, 2007, "2020-10-06 16:10:40"),
(3006, "2020-10-13", 14, 1005, 2002, "2020-10-09 10:16:30"),
(3002, "2020-10-14", 15, 1004, 2003, "2020-10-08 10:16:30"),
(3004, "2020-10-19", 15, 1003, 2001, "2020-10-10 10:10:40"), 
(3002, "2020-10-17", 12, 1002, 2006, "2020-10-10 10:10:40"),
(3005, "2020-10-18", 14, 1005, 2007, "2020-10-10 16:10:30"),
(3006, "2020-10-20", 14, 1005, 2002, "2020-10-10 10:06:10"),
(3002, "2020-10-21", 15, 1004, 2003, "2020-10-10 08:56:20"),
(3004, "2020-10-19", 15, 1003, 2001, "2020-10-10 11:10:40"), 
(3002, "2020-10-19", 12, 1004, 2008, "2020-10-10 08:56:20");
SELECT * FROM booking;

-- 7. List all doctors available for a particular booking date by providing Day and time slot	
-- 7.1 Using Timings table directly and by providing day name														
SELECT u.first_name, u.last_name FROM users AS u RIGHT JOIN hospital_staff as hs ON u.user_id = hs.user_id  WHERE u.role_id = 2 AND hs.staff_id IN (
	SELECT h.staff_id FROM hospital_staff_op_timings AS h WHERE h.op_timing_id = (
		SELECT o.op_timing_id FROM op_timings AS o WHERE o.op_day="Monday" AND o.start_time ="09:00:00" AND o.end_time = "12:00:00"
	)
);

-- 7.2 Using Day name and time slot
SELECT u.first_name, u.last_name FROM users AS u RIGHT JOIN hospital_staff as hs ON u.user_id = hs.user_id  WHERE u.role_id = 2 AND hs.staff_id IN (
	SELECT h.staff_id FROM hospital_staff_op_timings AS h WHERE h.op_timing_id IN ( -- Staff working during op_timing
		SELECT o.op_timing_id FROM op_timings AS o WHERE o.op_day = ( 
			SELECT DISTINCT(DAYNAME(b.booking_date)) FROM booking as b WHERE DAYNAME(b.booking_date) = "Monday"
        ) AND o.start_time ="09:00:00" AND o.end_time = "12:00:00"
    )
);