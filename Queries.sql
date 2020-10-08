CREATE DATABASE assignment1;
USE assignment1;

-- --------------------------------
-- TABLE CREATION
-- --------------------------------

CREATE TABLE Hospital (
  hospital_id INT NOT NULL AUTO_INCREMENT,
  hospital_name VARCHAR(50),
  hospital_address VARCHAR(100),
  PRIMARY KEY (hospital_id)
);

CREATE TABLE Roles (
  role_id INT NOT NULL AUTO_INCREMENT,
  role_name VARCHAR(15),
  PRIMARY KEY (role_id)
);

CREATE TABLE Speciality (
  speciality_id INT NOT NULL AUTO_INCREMENT,
  speciality_name VARCHAR(15),
  PRIMARY KEY (speciality_id)
);

CREATE TABLE Users (
  user_id INT NOT NULL AUTO_INCREMENT,
  first_name VARCHAR(20),
  last_name VARCHAR(20),
  role_id INT ,
  hospital_id INT ,
  email_id VARCHAR(50) UNIQUE,
  password VARCHAR(25),
  PRIMARY KEY (user_id),
  FOREIGN KEY (role_id) REFERENCES Roles (role_id),
  FOREIGN KEY (hospital_id) REFERENCES Hospital (hospital_id)
);

CREATE TABLE User_Speciality_Mapping (
  user_id INT,
  speciality_id INT,
  FOREIGN KEY (user_id) REFERENCES Users (user_id),
  FOREIGN KEY (speciality_id) REFERENCES Speciality (speciality_id)
);


-- 1. DATA INSERTION

-- 1.1 Hospital table
INSERT INTO Hospital (hospital_id, hospital_name, hospital_address) VALUES 
(100, "Credence Hospital - Multispecialty Family Hospital", "Near, Ulloor - Akkulam Rd, P T Chacko Nagar, Ulloor, Thiruvananthapuram, Kerala 695011");
INSERT INTO Hospital (hospital_name, hospital_address) VALUES 
("Sri Ramakrishna Ashrama Hospital", "Sasthamangalam Office Building Hospital Road, Sasthamangalam, Thiruvananthapuram, Kerala 695010");

SELECT * FROM Hospital;

-- 1.2 Roles table
ALTER TABLE Roles AUTO_INCREMENT=1; -- Starts id value from 1
INSERT INTO Roles (role_name) VALUES ("agent"), ("end-user");
SELECT * FROM Roles;

-- 1.3 Specialties table
ALTER TABLE Speciality AUTO_INCREMENT=1000; -- Starts id value from 1000
INSERT INTO Speciality (speciality_name) VALUES ("Lab"), ("Pharmacy"), ("Radiology"), ("Ortho"), ("Cardiology"), ("Reception"), ("ECG");
SELECT * FROM Speciality;

-- 1.4 Users table

-- 1.4.1 Adding End-users 
INSERT INTO Users (first_name, last_name, role_id, hospital_id, email_id, password) VALUES
("Ananya", "Vinod", 2, 100, "ananya@qburst.com", "ananya@123"),
("Ann", "Susan", 2, 101, "anns@qburst.com", "ann@123"),
("Haripriya", "Jagannathan", 2, 101, "haripriya@qburst.com", "haripriya@123"),
("Nikhil", "Anil Kumar", 2, 100, "nikhilanilkumar@qburst.com", "nikhil@123"),
("Sidharth", "Sujithlal", 2, 101, "sidharths@qburst.com", "sidharth@123"),
("Thejus", "Satheesan", 2, 100, "thejuss@qburst.com", "thejus@123");
SELECT * FROM Users where role_id = 2;

-- 1.4.2 Adding Agesnts
INSERT INTO Users (first_name, last_name, role_id, hospital_id, email_id, password) VALUES
("Priya", "Sasidharan", 1, 100, "priyas@qburst.com", "priya@123"),
("Arunraj", "Saraswathi", 1, 101, "arunrajs@qburst.com", "arunraj@123"),
("Sreejith", "Mullakkal", 1, 101, "sreejithmullakal@qburst.com", "sreejith@123"),
("Nishin", "T N", 1, 100, "nishin@qburst.com", "nishin@123"),
("Anusree", "Nambiar", 1, 101, "anusree@qburst.com", "anusree@123");
SELECT * FROM Users where role_id = 1;

SELECT * FROM Users;

-- 1.5 Adding Specialities to each user 
INSERT INTO User_Speciality_Mapping (user_id, speciality_id) VALUES
(1, 1000),
(2, 1002), (2, 1004),
(3, 1004), (3, 1006),
(4, 1000), (4, 1005),
(5, 1003),
(6, 1004),
(7, 1000), (7, 1001), (7, 1004), 
(8, 1006),
(9, 1004), (9, 1006),
(10, 1000), (10, 1002),
(11, 1003);

SELECT * FROM User_Speciality_Mapping;

-- 2. Check if a user nishin@qburst.com/qburst@23 present or not?
SELECT * FROM Users WHERE Users.email_id = "nishin@qburst.com" OR Users.email_id = "qburst@23";

-- 3. List all agents first name and last name matching your speciality

-- List all the agents
SELECT Users.first_name, Users.last_name FROM Users WHERE Users.user_id IN 
(
	-- Get user ids of other users that match with given user's specialities
	SELECT DISTINCT(User_Speciality_Mapping.user_id) FROM Speciality 
	JOIN User_Speciality_Mapping ON User_Speciality_Mapping.speciality_id = Speciality.speciality_id WHERE User_Speciality_Mapping.speciality_id IN 
	( 
		-- Get speciality id of the user
		SELECT User_Speciality_Mapping.speciality_id FROM Users
		JOIN User_Speciality_Mapping ON Users.user_id = User_Speciality_Mapping.user_id where Users.user_id = 3
    ) AND User_Speciality_Mapping.user_id != 3
) AND Users.role_id = 1;

