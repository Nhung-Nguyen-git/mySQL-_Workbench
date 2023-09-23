use sakila;

-- --tạo bảng sih viên 
CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(255) NOT NULL,
    student_age INT
);

-- nhập thông tin bảng sinh viên--  
INSERT INTO Students ( student_id,student_name, student_age)
VALUES
    (1,'John Doe', 20),
    (2,'Jane Smith', 22),
    (3,'David Johnson', 19),
    (4,'Emily Davis', 21),
    (5,'Michael Wilson', 23),
    (6,'Sarah Brown', 20),
    (7,'Matthew Lee', 22),
    (8,'Olivia Evans', 19),
    (9,'William Harris', 21),
    (10,'Sophia Clark', 23),
    (11,'James Turner', 20),
    (12,'Emma Baker', 22),
    (13,'Daniel White', 19),
    (14,'Isabella Green', 21),
    (15,'Joseph Hall', 23),
    (16,'Ava Adams', 20),
    (17,'Alexander Nelson', 22),
    (18,'Grace King', 19),
    (19,'Benjamin Wright', 21),
    (20,'Chloe Turner', 23);

-- tạo bảng khóa học-- 
CREATE TABLE Courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(255) NOT NULL,
    course_description TEXT
);

-- --nhập thông tin khóa học 

INSERT INTO Courses (course_id,course_name, course_description)
VALUES
    (1,'Math', 'Introduction to Mathematics'),
    (2,'History', 'Introduction to World History'),
    (3,'English', 'Introduction to English Literature'),
    (4,'Physics', 'Introduction to Physics'),
    (5,'Biology', 'Introduction to Biology'),
    (6,'Chemistry', 'Introduction to Chemistry'),
    (7,'Computer Science', 'Introduction to Computer Science'),
    (8,'Psychology', 'Introduction to Psychology'),
    (9,'Economics', 'Introduction to Economics'),
    (10,'Art', 'Introduction to Art History');

 -- tạo bảng  Enrollments
CREATE TABLE Enrollments (
    enrollment_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);
-- Chèn các bản ghi cho các mối quan hệ n-n giữa sinh viên và khóa học.
INSERT INTO Enrollments (enrollment_id, student_id, course_id)
VALUES
    (1, 1, 1),  
    (2, 1, 2),  
    (3, 2, 1),  
    (4, 3, 3),  
    (5, 4, 2), 
    (6, 5, 4),  
    (7, 6, 3),  
    (8, 7, 1),  
    (9, 8, 4),  
    (10, 9, 2), 
    (11, 10, 3),
    (12, 11, 4),
    (13, 12, 1),
    (14, 13, 2),
    (15, 14, 3),
    (16, 15, 4),
    (17, 16, 1),
    (18, 17, 2),
    (19, 18, 3),
    (20, 19, 4);
    
    -- Lấy danh sách tất cả sinh viên và thông tin khóa học mà họ đã đăng ký.
SELECT Students.student_name, Courses.course_name
FROM Students
JOIN Enrollments ON Students.student_id = Enrollments.student_id
JOIN Courses ON Enrollments.course_id = Courses.course_id;


-- Lấy tên của tất cả các khóa học mà một sinh viên có id = 1
SELECT Courses.course_name
FROM Courses
JOIN Enrollments ON Courses.course_id = Enrollments.course_id
WHERE Enrollments.student_id = 1;
 
 
 -- Lấy tất cả các khóa học mà chưa có sinh viên nào đăng ký.
 SELECT Courses.course_name
FROM Courses
LEFT JOIN Enrollments ON Courses.course_id = Enrollments.course_id
WHERE Enrollments.student_id IS NULL;

-- Lấy tất cả sinh viên và thông tin khóa học mà họ đã đăng ký, sắp xếp theo tên sinh viên và tên khóa học.
 
SELECT Students.student_name, Courses.course_name
FROM Students
LEFT JOIN Enrollments ON Students.student_id = Enrollments.student_id
LEFT JOIN Courses ON Enrollments.course_id = Courses.course_id
ORDER BY Students.student_name, Courses.course_name;

-- --Lấy tất cả các sinh viên và thông tin của họ, cùng với tên khóa học mà họ đăng ký (nếu có).
 SELECT Students.student_name, Students.student_age, Courses.course_name
FROM Students
LEFT JOIN Enrollments ON Students.student_id = Enrollments.student_id
LEFT JOIN Courses ON Enrollments.course_id = Courses.course_id;

-- Lấy danh sách tất cả sinh viên và thông tin của họ, cùng với tên khóa học mà họ đăng ký (nếu có). Sắp xếp theo tên sinh viên và tuổi từ cao xuống thấp
 SELECT Students.student_name, Students.student_age, Courses.course_name
FROM Students
LEFT JOIN Enrollments ON Students.student_id = Enrollments.student_id
LEFT JOIN Courses ON Enrollments.course_id = Courses.course_id
ORDER BY Students.student_name ASC, Students.student_age DESC;

-- Lấy tất cả các khóa học và số lượng sinh viên đã đăng ký vào mỗi khóa học.

SELECT Courses.course_name, COUNT(Enrollments.student_id) AS enrollment_count
FROM Courses
LEFT JOIN Enrollments ON Courses.course_id = Enrollments.course_id
GROUP BY Courses.course_name;



