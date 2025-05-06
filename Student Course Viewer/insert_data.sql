USE NCAT;

INSERT INTO roles (id, role)
VALUES ('mgr', 'Manager'), ('stu', 'Student');

INSERT INTO major (id, major)
VALUES (1, 'Computer Science'), (2, 'Electrical Engineer');

INSERT INTO Users(username, userpassword, fname, lname, roleID, majorid)
VALUES ('Manager1', 'AggiePride1', 'Jawn', 'Dough', 'mgr', default), ('Student1', 'AggiePride2', 'Jane', 'Doe', 'stu', 1);

INSERT INTO roster(id, class, code)
VALUES (200, 'Computer Sci Sopho Colloquim Lecture', 'COMP'),
	   (221, 'Global Business Environment Lecture', 'MGMT'),
       (267, 'Database Design Lecture', 'COMP'),
       (300, 'Computer Sci Jr Colloquim Lecture', 'COMP'),
       (341, 'Intro Differential Equations Lecture', 'MATH'),
       (350, 'Operating Systems Lecture', 'COMP');
       
INSERT INTO rosterclass(rosterid, userid)
VALUES (200, 2), (221, 2), (267, 2), (300, 2), (341, 2), (350, 2);

