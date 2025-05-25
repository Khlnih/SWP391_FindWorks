-- Dữ liệu mẫu cho tất cả các bảng

-- Bảng Team_Number
INSERT INTO Team_Number (team_number) VALUES
('1-10 nhân viên'),
('11-50 nhân viên'),
('51-200 nhân viên'),
('201-500 nhân viên'),
('500+ nhân viên');

-- Bảng Categories
INSERT INTO Categories (categories_name, categories_img, description, statusCate) VALUES
('IT/Phần mềm', 'it.png', 'Các vị trí liên quan đến lập trình và phát triển phần mềm', 1),
('Marketing', 'marketing.png', 'Các vị trí liên quan đến marketing và quảng cáo', 1),
('Kinh doanh', 'business.png', 'Các vị trí liên quan đến kinh doanh và bán hàng', 1),
('Kế toán', 'accounting.png', 'Các vị trí liên quan đến kế toán và tài chính', 1),
('Nhân sự', 'hr.png', 'Các vị trí liên quan đến nhân sự và quản lý nhân viên', 1);

-- Bảng Duration
INSERT INTO Duration (duration_name) VALUES
('1-3 tháng'),
('3-6 tháng'),
('6-12 tháng'),
('1-2 năm'),
('2-3 năm'),
('3+ năm');

-- Bảng JobType
INSERT INTO JobType (job_name) VALUES
('Full-time'),
('Part-time'),
('Thực tập'),
('Freelance'),
('Remote');

-- Bảng Degree
INSERT INTO Degree (degree_name) VALUES
('Trung cấp'),
('Cao đẳng'),
('Đại học'),
('Thạc sĩ'),
('Tiến sĩ');

-- Bảng Expertise
INSERT INTO Expertise (ExpertiseName) VALUES
('Java Developer'),
('Frontend Developer'),
('Backend Developer'),
('Full Stack Developer'),
('DevOps Engineer');

-- Bảng Skill_Set
INSERT INTO Skill_Set (skill_set_name, description, statusSkill, ExpertiID) VALUES
('Java', 'Chuyên sâu về lập trình Java', 1, 1),
('JavaScript', 'Chuyên về lập trình JavaScript', 1, 2),
('Spring Boot', 'Framework Java', 1, 1),
('React.js', 'Framework JavaScript', 1, 2),
('Node.js', 'Môi trường runtime JavaScript', 1, 2),
('Python', 'Lập trình Python', 1, 3),
('SQL', 'Cơ sở dữ liệu', 1, 3),
('Git', 'Kiểm soát phiên bản', 1, 4),
('Docker', 'Container', 1, 5),
('AWS', 'Cloud Computing', 1, 5);

-- Bảng Admin (chỉ 1 admin)
INSERT INTO Admin (username, password, first_name, last_name, phone, email, image, status) VALUES
('admin1', 'admin123', 'Nguyễn', 'Văn A', '0987654321', 'admin1@example.com', 'admin1.jpg', 'active');

-- Bảng Recruiter
INSERT INTO Recruiter (username, password, first_name, last_name, gender, dob, image, money, email_contact, phone_contact, status) VALUES
('recruiter1', 'rec123', 'Nguyễn', 'Văn C', 1, '1990-01-01', 'rec1.jpg', 1000000, 'rec1@example.com', '0987654323', 'active'),
('recruiter2', 'rec456', 'Trần', 'Thị D', 0, '1991-01-01', 'rec2.jpg', 2000000, 'rec2@example.com', '0987654324', 'active'),
('recruiter3', 'rec789', 'Lê', 'Văn E', 1, '1992-01-01', 'rec3.jpg', 1500000, 'rec3@example.com', '0987654325', 'active'),
('recruiter4', 'rec101', 'Nguyễn', 'Thị F', 0, '1993-01-01', 'rec4.jpg', 2500000, 'rec4@example.com', '0987654326', 'active');

-- Bảng Freelancer
INSERT INTO Freelancer (username, password, first_name, last_name, image, gender, dob, describe, email__contact, phone_contact, status) VALUES
('freelancer1', 'free123', 'Nguyễn', 'Văn G', 'free1.jpg', 1, '1994-01-01', 'Chuyên Java Developer', 'free1@example.com', '0987654327', 'active'),
('freelancer2', 'free456', 'Trần', 'Thị H', 'free2.jpg', 0, '1995-01-01', 'Chuyên Frontend Developer', 'free2@example.com', '0987654328', 'active'),
('freelancer3', 'free789', 'Lê', 'Văn I', 'free3.jpg', 1, '1996-01-01', 'Chuyên Backend Developer', 'free3@example.com', '0987654329', 'active'),
('freelancer4', 'free101', 'Nguyễn', 'Thị J', 'free4.jpg', 0, '1997-01-01', 'Chuyên Full Stack Developer', 'free4@example.com', '0987654330', 'active');

-- Bảng Company
INSERT INTO Company (company_name, team_numberID, established_on, logo, website, describe, location, recruiterID) VALUES
('Tech Company', 2, '2010-01-01', 'techlogo.png', 'tech.com', 'Công ty công nghệ hàng đầu', 'Hà Nội', 1),
('Marketing Co.', 3, '2015-01-01', 'marketinglogo.png', 'marketing.com', 'Công ty marketing chuyên nghiệp', 'TP.HCM', 2),
('Edu Company', 4, '2018-01-01', 'edulogo.png', 'edu.com', 'Công ty giáo dục', 'Đà Nẵng', 3),
('FinTech Co.', 5, '2020-01-01', 'fintechlogo.png', 'fintech.com', 'Công ty tài chính', 'Hà Nội', 4);

-- Bảng Education
INSERT INTO Education (university_name, start_date, end_date, freelanceID, degreeID) VALUES
('ĐH Bách Khoa', '2010-09-01', '2014-06-30', 1, 3),
('ĐH FPT', '2011-09-01', '2015-06-30', 2, 3),
('ĐH Khoa Học Tự Nhiên', '2012-09-01', '2016-06-30', 3, 3),
('ĐH Kinh Tế', '2013-09-01', '2017-06-30', 4, 3);

-- Bảng Experience
INSERT INTO Experience (experience_work_name, position, start_date, end_date, your_project, freelanceID) VALUES
('Tech Company', 'Java Developer', '2014-07-01', '2016-06-30', 'Phát triển hệ thống quản lý', 1),
('Marketing Co.', 'Frontend Developer', '2015-07-01', '2017-06-30', 'Thiết kế giao diện web', 2),
('Edu Company', 'Backend Developer', '2016-07-01', '2018-06-30', 'Phát triển hệ thống học online', 3),
('FinTech Co.', 'Full Stack Developer', '2017-07-01', '2019-06-30', 'Phát triển ứng dụng tài chính', 4);

-- Bảng Skills
INSERT INTO Skills (skill_set_ID, freelancerID, level) VALUES
(1, 1, 5),  -- Java Developer - Freelancer 1
(2, 2, 5),  -- Frontend Developer - Freelancer 2
(3, 3, 5),  -- Backend Developer - Freelancer 3
(4, 4, 5),  -- Full Stack Developer - Freelancer 4
(5, 1, 4),  -- DevOps - Freelancer 1
(6, 2, 4),  -- Python - Freelancer 2
(7, 3, 4),  -- SQL - Freelancer 3
(8, 4, 4),  -- Git - Freelancer 4
(9, 1, 3),  -- Docker - Freelancer 1
(10, 2, 3); -- AWS - Freelancer 2

-- Bảng Blogs
INSERT INTO Blogs (title, image, date_blog, description, tag, adminID, statusBlog) VALUES
('Tìm hiểu về Java', 'java.jpg', '2023-05-01', 'Bài viết về lập trình Java', 'Java', 1, 1),
('React.js cơ bản', 'react.jpg', '2023-05-05', 'Hướng dẫn React.js', 'React', 1, 1),
('Spring Boot', 'spring.jpg', '2023-05-10', 'Khám phá Spring Boot', 'Spring', 1, 1),
('Node.js', 'node.jpg', '2023-05-15', 'Giới thiệu Node.js', 'Node', 1, 1),
('Frontend', 'frontend.jpg', '2023-05-20', 'Các công nghệ Frontend', 'Frontend', 1, 1);


-- Bảng JobApply
INSERT INTO JobApply (freelanceID, postID, status, dateApply, Resume) VALUES
(1, 1, 'pending', '2023-05-01', 'CV Java Developer'),
(2, 2, 'accepted', '2023-05-02', 'CV Frontend Developer'),
(3, 3, 'rejected', '2023-05-03', 'CV Backend Developer'),
(4, 4, 'pending', '2023-05-04', 'CV Full Stack Developer'),
(1, 5, 'accepted', '2023-05-05', 'CV DevOps Engineer');

-- Bảng FreelancerFavorites
INSERT INTO FreelancerFavorites (freelanceID, postID) VALUES
(1, 2),
(2, 3),
(3, 4),
(4, 5),
(1, 4);
