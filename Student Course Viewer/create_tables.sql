CREATE DATABASE IF NOT EXISTS NCAT;
USE NCAT;

CREATE TABLE roles (
    id VARCHAR(50) PRIMARY KEY NOT NULL,
    role VARCHAR(30) NOT NULL
);

CREATE TABLE major (
    id INT PRIMARY KEY NOT NULL,
    major VARCHAR(30) NOT NULL 
);

CREATE TABLE Users (
	ID INT PRIMARY KEY AUTO_INCREMENT,
	username VARCHAR(50) UNIQUE NOT NULL,
	userpassword VARCHAR(50) NOT NULL,
	fname VARCHAR(50) NOT NULL,
	lname VARCHAR(50) NOT NULL,
	roleID VARCHAR(30) NOT NULL,
	majorid INT,
    FOREIGN KEY (roleID) REFERENCES roles(id),
    FOREIGN KEY (majorid) REFERENCES major(id)
);

CREATE TABLE roster (
    id INT PRIMARY KEY NOT NULL,
    class VARCHAR(50) NOT NULL,
    code VARCHAR(10) NOT NULL
);

-- Junction table for many-to-many relationship between users and roster
CREATE TABLE rosterclass (
    rosterid INT NOT NULL,
    userid INT NOT NULL,
    PRIMARY KEY (rosterid, userid),
    FOREIGN KEY (rosterid) REFERENCES roster(id),
    FOREIGN KEY (userid) REFERENCES users(ID)
);

-- View that holds & displays Student's Classes
CREATE VIEW Student_Classes AS
SELECT
    u.ID AS user_id,
    r.id AS class_id,
    r.class AS class_name,
    r.code AS class_code
FROM Users u
JOIN rosterclass rc ON u.ID = rc.userid
JOIN roster r ON rc.rosterid = r.id;
