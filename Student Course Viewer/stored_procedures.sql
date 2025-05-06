-- Stored Procedures called in Main Program/Application
USE NCAT;

-- Procedures used in Student menu:

DROP PROCEDURE IF EXISTS CheckLogin;
DELIMITER //

CREATE PROCEDURE CheckLogin(
	IN uname VARCHAR(50),
    IN pword VARCHAR(50)
)
BEGIN
	SELECT Users.ID, roles.role
    FROM Users
    JOIN roles ON Users.roleID = roles.id
    WHERE Users.username = uname AND Users.userpassword = pword;
END //

DELIMITER ;

DROP PROCEDURE IF EXISTS GetStudentClasses;
DELIMITER //

CREATE PROCEDURE GetStudentClasses(
	IN user_id INT
)
BEGIN
    SELECT class_id, class_name, class_code
    FROM student_classes
    WHERE user_id = user_id;
END //

DELIMITER ;

DROP PROCEDURE IF EXISTS DropClass;
DELIMITER //

CREATE PROCEDURE DropClass(
	IN user_id INT, 
	IN roster_id INT
)
BEGIN
    DELETE FROM rosterclass
    WHERE userid = user_id AND rosterid = roster_id;
END //

DELIMITER ;

-- Procedures used in Manager menu:

DROP PROCEDURE IF EXISTS GetStudentSchedule;
DELIMITER //

CREATE PROCEDURE GetStudentSchedule(
    IN student_id INT
)
BEGIN
    SELECT r.class, r.code
    FROM roster r
    JOIN rosterclass rc ON r.id = rc.rosterid
    WHERE rc.userid = student_id;
END //

DELIMITER ;

DROP PROCEDURE IF EXISTS GetClassRoster;
DELIMITER //

CREATE PROCEDURE GetClassRoster(
    IN roster_id INT
)
BEGIN
    SELECT u.fname, u.lname
    FROM Users u
    JOIN rosterclass rc ON u.ID = rc.userid
    WHERE rc.rosterid = roster_id;
END //

DELIMITER ;

DROP PROCEDURE IF EXISTS AddStudentToRoster;
DELIMITER //

CREATE PROCEDURE AddStudentToRoster(
    IN student_id INT,
    IN roster_id INT
)
BEGIN
    INSERT INTO rosterclass (userid, rosterid)
    VALUES (student_id, roster_id);
END //

DELIMITER ;

DROP PROCEDURE IF EXISTS DropStudentFromRoster;
DELIMITER //

CREATE PROCEDURE DropStudentFromRoster(
    IN student_id INT,
    IN roster_id INT
)
BEGIN
    DELETE FROM rosterclass
    WHERE userid = student_id AND rosterid = roster_id;
END //

DELIMITER ;

DROP PROCEDURE IF EXISTS AddNewStudent;
DELIMITER //

CREATE PROCEDURE AddNewStudent(
    IN uname VARCHAR(50),
    IN pword VARCHAR(50),
    IN fname VARCHAR(50),
    IN lname VARCHAR(50),
    IN major_id INT,
    OUT new_user_id INT
)
BEGIN
    INSERT INTO Users (username, userpassword, fname, lname, roleID, majorid)
    VALUES (uname, pword, fname, lname, 'stu', major_id);
    
    -- Get the ID of the newly inserted user
    SET new_user_id = LAST_INSERT_ID();
END //

DELIMITER ;
