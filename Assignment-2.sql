CREATE DATABASE assignment2;
USE assignment2;

-- 1. Create tables for designed database

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
  op_day int,
  start_time time,
  end_time time,
  PRIMARY KEY (op_timing_id)
);

CREATE TABLE hospital_staff_op_timings (
  staff_id int,
  op_timing_id int,
  FOREIGN KEY (staff_id) REFERENCES hospital_staff (staff_id),
  FOREIGN KEY (op_timing_id) REFERENCES op_timings (op_timing_id)
);

CREATE TABLE patients (
  patient_id int not null auto_increment,
  user_id int,
  status char(2),
  PRIMARY KEY (patient_id),
  FOREIGN KEY (user_id) REFERENCES users (user_id)
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

-- 2. Create master data for each tables
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
-- Note: 0 = Monday, 1 = Tuesday, 2 = Wednesday, 3 = Thursday, 4 = Friday, 5 = Saturday, 6 = Sunday.
ALTER TABLE op_timings AUTO_INCREMENT=2001; -- Starts id value from 2001
INSERT INTO op_timings (op_day, start_time, end_time) VALUES
(0, "09:00:00", "12:00:00"),
(1, "14:00:00", "17:00:00"),
(2, "10:00:00", "20:00:00"),
(3, "11:00:00", "14:00:00"),
(4, "09:00:00", "18:00:00"),
(5, "14:00:00", "18:00:00"),
(6, "10:00:00", "14:00:00"),
(0, "16:00:00", "20:00:00");

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

-- patients
ALTER TABLE patients AUTO_INCREMENT=3001;
ALTER TABLE patients ADD CONSTRAINT chk_status CHECK ( status IN ('IP','OP'));
INSERT INTO patients (user_id, status) VALUES
(101, "IP"),
(102, "OP"),
(103, "IP"),
(104, "OP"),
(105, "OP"),
(106, "OP");
SELECT * FROM patients;

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

-- 3. Get the total bookings for a doctor
-- 3.1 For a particular doctor
SELECT COUNT(booking.staff_id), booking.staff_id, users.first_name, users.last_name FROM booking 
LEFT JOIN hospital_staff ON booking.staff_id = hospital_staff.staff_id
LEFT JOIN users ON hospital_staff.user_id = users.user_id WHERE booking.staff_id = 1005;

-- 3.2 For each doctor
SELECT COUNT(booking.patient_id), booking.staff_id, users.first_name, users.last_name FROM booking 
LEFT JOIN hospital_staff ON booking.staff_id = hospital_staff.staff_id
LEFT JOIN users ON hospital_staff.user_id = users.user_id GROUP BY booking.staff_id;

-- 4. List all the doctors when we provide department Id
SELECT h.staff_id, h.dept_id, h.qualification, u.first_name, u.last_name, u.phone_number FROM hospital_staff AS h 
LEFT JOIN users AS u ON h.user_id = u.user_id 
WHERE u.role_id = 2 AND h.dept_id = 15; -- Same output is obtained without role_id as we only have doctors in the table

-- 5. List all patients based on consulted doctor
SELECT b.patient_id, u.first_name, u.last_name FROM booking AS b 
LEFT JOIN patients AS p ON b.patient_id = p.patient_id  -- to get user id of patient to display name
LEFT JOIN users AS u ON p.user_id = u.user_id
WHERE b.staff_id = 1005;

-- 6. List all bookings with patient and doctor details
SELECT * FROM booking AS b 
JOIN patients as p ON b.patient_id = p.patient_id
JOIN hospital_staff AS h ON b.staff_id = h.staff_id ORDER BY b.booking_time DESC;

-- 7. List all available doctors for a given booking date
-- 7.1 Without providing Day or time slot: Gives doctors working at any OP timing for a given booking_date
SELECT u.first_name, u.last_name FROM users AS u RIGHT JOIN hospital_staff as hs ON u.user_id = hs.user_id  WHERE u.role_id = 2 AND hs.staff_id IN (
	SELECT h.staff_id FROM hospital_staff_op_timings AS h WHERE h.op_timing_id IN ( -- Staff working during op_timing
		SELECT o.op_timing_id FROM op_timings AS o WHERE o.op_day = ( -- Get OP timings for booking_date
			SELECT DISTINCT(WEEKDAY(b.booking_date)) FROM booking as b WHERE b.booking_date = "2020-10-12"
        )
    )
);
SELECT * FROM hospital_staff as h JOIN users as u on h.user_id = u.user_id JOIN booking as b ON h.staff_id = b.staff_id;

-- 7.2 Providing Day and time slot																				 -- Only doctors
SELECT u.first_name, u.last_name FROM users AS u RIGHT JOIN hospital_staff as hs ON u.user_id = hs.user_id  WHERE u.role_id = 2 AND hs.staff_id IN (
	SELECT h.staff_id FROM hospital_staff_op_timings AS h WHERE h.op_timing_id = (
		SELECT o.op_timing_id FROM op_timings AS o WHERE o.op_day=0 AND o.start_time ="09:00:00" AND o.end_time = "12:00:00"
	)
);

-- 8. Get OP list for a doctor for tomorrow's consultation with booking priority(token)
SELECT b.patient_id, u.first_name, u.last_name FROM booking AS b 
LEFT JOIN patients AS p ON b.patient_id = p.patient_id
LEFT JOIN users AS u ON p.user_id = u.user_id WHERE b.staff_id = 1005 AND b.booking_date="2020-10-13" ORDER BY b.booking_time DESC;

-- 9. Get doctors count in each department
SELECT COUNT(h.staff_id) , d.dept_name FROM hospital_staff AS h 
JOIN department AS d ON h.dept_id = d.dept_id
GROUP BY h.dept_id;

-- 10. Get each “OP time” booking count in each department for a given date
SELECT COUNT(b.op_timing_id), b.dept_id FROM booking AS b WHERE b.booking_date="2020-10-19" GROUP BY b.dept_id;

-- 11. Update the doctors qualification
UPDATE hospital_staff SET qualification="MBBS, M.D(Medicine), DM(Cardiology), PhD" WHERE user_id=108;
SELECT * FROM hospital_staff;

-- 12. Remove/Delete a booking
DELETE FROM booking WHERE booking_id = 1000002;
SELECT * FROM booking;