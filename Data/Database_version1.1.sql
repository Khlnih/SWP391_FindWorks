PRINT 'Inserting data into Team_Number...';
INSERT INTO [Team_Number] ([team_number]) VALUES
(N'1-10 nhân viên'),
(N'11-50 nhân viên'),
(N'51-200 nhân viên'),
(N'201-500 nhân viên'),
(N'Trên 500 nhân viên');
GO

PRINT 'Inserting data into Categories...';
INSERT INTO [Categories] ([category_name], [category_img], [description], [isActive]) VALUES
(N'Phát triển Web', N'/img/cat/web.png', N'Lập trình website, ứng dụng web.', 1),
(N'Phát triển Mobile', N'/img/cat/mobile.png', N'Lập trình ứng dụng cho iOS, Android.', 1),
(N'Thiết kế Đồ họa', N'/img/cat/design.png', N'Logo, UI/UX, banner.', 1),
(N'Viết lách & Dịch thuật', N'/img/cat/writing.png', N'Bài viết blog, content marketing, dịch thuật.', 1),
(N'Marketing Digital', N'/img/cat/marketing.png', N'SEO, SEM, Social Media Marketing.', 1),
(N'Khác', N'/img/cat/other.png', N'Các danh mục khác.', 0);
GO

PRINT 'Inserting data into Duration...';
INSERT INTO [Duration] ([duration_name]) VALUES
(N'Dưới 1 tháng'),
(N'1-3 tháng'),
(N'3-6 tháng'),
(N'Trên 6 tháng'),
(N'Theo dự án');
GO

PRINT 'Inserting data into JobType...';
INSERT INTO [JobType] ([job_type_name]) VALUES
(N'Toàn thời gian'),
(N'Bán thời gian'),
(N'Hợp đồng'),
(N'Freelance'),
(N'Thực tập');
GO

PRINT 'Inserting data into Degree...';
INSERT INTO [Degree] ([degree_name]) VALUES
(N'Không yêu cầu'),
(N'Trung cấp'),
(N'Cao đẳng'),
(N'Đại học'),
(N'Thạc sĩ'),
(N'Tiến sĩ'),
(N'Chứng chỉ nghề');
GO

PRINT 'Inserting data into Expertise...';
INSERT INTO [Expertise] ([expertiseName]) VALUES
(N'Phát triển Frontend'),
(N'Phát triển Backend'),
(N'Phát triển Full-stack'),
(N'Thiết kế UI/UX'),
(N'Viết nội dung SEO'),
(N'Quản lý dự án');
GO

-- 2. Bảng phụ thuộc vào nhóm 1
PRINT 'Inserting data into Admin...';
-- SỬA LỖI: Email phải là duy nhất
INSERT INTO [Admin] ([username], [password_hash], [first_name], [last_name], [phone], [email_contact], [image], [status]) VALUES
(N'superadmin', N'hashed_admin_pass_123', N'Quản', N'Trị Viên', N'0909123456', N'superadmin.unique@fpt.edu.vn', N'/img/admin/super.jpg', N'Active'),
(N'mod01', N'hashed_mod_pass_456', N'Điều', N'Phối Viên', N'0908765432', N'mod01.unique@fpt.edu.vn', N'/img/admin/mod.jpg', N'Active'),
(N'disabled_admin', N'hashed_disabled_pass', N'Admin', N'Cũ', N'0901112222', N'old.admin.unique@fpt.edu.vn', NULL, N'Inactive');
GO

PRINT 'Inserting data into Skill_Set...';
INSERT INTO [Skill_Set] ([skill_set_name], [description], [isActive], [expertiseID]) VALUES
(N'ReactJS', N'Thư viện JavaScript cho giao diện người dùng', 1, 1), -- skill_set_ID = 1
(N'Angular', N'Framework phát triển ứng dụng web', 1, 1),          -- skill_set_ID = 2
(N'Node.js', N'Runtime JavaScript phía server', 1, 2),             -- skill_set_ID = 3
(N'Java Spring Boot', N'Framework Java cho microservices', 1, 2),  -- skill_set_ID = 4
(N'Python Django', N'Framework Python cho web', 1, 2),            -- skill_set_ID = 5
(N'Figma', N'Công cụ thiết kế UI/UX', 1, 4),                       -- skill_set_ID = 6
(N'Adobe Photoshop', N'Chỉnh sửa ảnh chuyên nghiệp', 1, 4),       -- skill_set_ID = 7
(N'SEO Writing', N'Viết bài chuẩn SEO', 1, 5),                    -- skill_set_ID = 8
(N'Agile Scrum', N'Phương pháp quản lý dự án linh hoạt', 1, 6),    -- skill_set_ID = 9
(N'SQL', N'Ngôn ngữ truy vấn cơ sở dữ liệu', 1, NULL),             -- skill_set_ID = 10
(N'Git', N'Hệ thống quản lý phiên bản', 1, 3);                     -- skill_set_ID = 11
GO

-- 3. Bảng phụ thuộc vào Admin và các bảng cơ bản khác
PRINT 'Inserting data into Recruiter...';
-- SỬA LỖI: Số điện thoại phải là duy nhất
INSERT INTO [Recruiter] (username, [password], [first_name], [last_name], [gender], [dob], [image], [money], [email_contact], [phone_contact], [status], [statusChangedByAdminID]) VALUES
('Dk1',N'hashed_rec_pass_1', N'An', N'Nguyễn Văn', 1, '1988-07-10', N'/img/rec/an_nv.jpg', 1000000.00, N'an.nguyen@companyX.com', N'0912345001', N'Active', 1),
('Dk3',N'hashed_rec_pass_2', N'Bình', N'Trần Thị', 0, '1992-03-15', N'/img/rec/binh_tt.jpg', 500000.00, N'binh.tran@companyY.com', N'0912345002', N'Active', 1),
('Dk4',N'hashed_rec_pass_3', N'Châu', N'Lê Minh', 1, '1995-11-20', NULL, 0.00, N'chau.le@newcorp.com', N'0912345003', N'PendingVerification', NULL),
('Dk2',N'hashed_rec_pass_4', N'Dũng', N'Phạm Tiến', 1, '1985-01-01', N'/img/rec/dung_pt.jpg', 10000.00, N'dung.pham@oldcorp.com', N'0912345004', N'Suspended', 2);
GO

PRINT 'Inserting data into Freelancer...';
-- SỬA LỖI: Số điện thoại phải là duy nhất
INSERT INTO [Freelancer] (username,[password], [first_name], [last_name], [image], [gender], [dob], [describe], [email_contact], [phone_contact], [status], [statusChangedByAdminID]) VALUES
('Dk1',N'hashed_free_pass_1', N'Lan', N'Hồ Thị', N'/img/free/lan_ht.jpg', 0, '1996-05-20',  N'Chuyên gia ReactJS với 5 năm kinh nghiệm, đam mê tạo ra các giao diện người dùng đẹp và hiệu quả.', N'lan.ho@email.com', N'0987654001', N'Active', 1),
('Dk7',N'hashed_free_pass_2', N'Sơn', N'Đặng Văn', N'/img/free/son_dv.jpg', 1, '1993-09-01', N'Backend developer mạnh về Java Spring Boot và Microservices. Có kinh nghiệm làm việc với các hệ thống lớn.', N'son.dang@email.com', N'0987654002', N'Active', 1),
('Dk6',N'hashed_free_pass_3', N'Mai', N'Nguyễn Thị', N'/img/free/mai_nt.jpg', 0, '1999-12-12', N'UI/UX designer trẻ trung, sáng tạo, thành thạo Figma và Adobe Creative Suite.', N'mai.nguyen@email.com', N'0987654003', N'PendingVerification', NULL),
('Dk5',N'hashed_free_pass_4', N'Khánh', N'Lý Hoàng', NULL, 1, '1990-02-28', N'Copywriter chuyên nghiệp, có khả năng viết nội dung quảng cáo, PR, và SEO.', N'khanh.ly@email.com', N'0987654004', N'Suspended', 2),
('Dk4',N'hashed_free_pass_5', N'Vy', N'Trần Thảo', N'/img/free/vy_tt.jpg', 0, '1997-07-07', N'Full-stack developer với kinh nghiệm làm việc trên cả Node.js và React. Yêu thích các dự án thử thách.', N'vy.tran@email.com', N'0987654005', N'Active', 1);
GO

PRINT 'Inserting data into Blogs...';
INSERT INTO [Blogs] ([title], [image], [date_blog], [description], [tag], [adminID], [isActive]) VALUES
(N'Xu hướng Freelance 2025', N'/img/blog/trend2025.jpg', '2024-07-01', N'Các kỹ năng và ngành nghề freelance nào sẽ lên ngôi trong năm tới?', N'Freelance, Xu hướng, Kỹ năng', 1, 1),
(N'Bí quyết quản lý thời gian hiệu quả cho Freelancer', N'/img/blog/time_management.jpg', '2024-06-15', N'Làm thế nào để cân bằng công việc và cuộc sống khi làm việc tự do?', N'Thời gian, Năng suất, Freelancer', 2, 1),
(N'Xây dựng thương hiệu cá nhân cho Freelancer', N'/img/blog/personal_branding.jpg', '2024-05-20', N'Tạo dựng uy tín và thu hút khách hàng tiềm năng.', N'Thương hiệu, Marketing, Cá nhân', 1, 0);
GO

PRINT 'Inserting data into AccountTiers...';
INSERT INTO [AccountTiers] ([tierName], [description], [userTypeScope], [price], [durationDays], [features], [isActive], [adminID_managed_by]) VALUES
(N'Recruiter Miễn phí', N'Gói cơ bản cho Nhà tuyển dụng.', N'Recruiter', 0.00, NULL, N'{"max_posts_monthly": 2, "view_applicant_limit": 10}', 1, 1),
(N'Recruiter Pro', N'Nhiều tính năng hơn cho Nhà tuyển dụng chuyên nghiệp.', N'Recruiter', 299000.00, 30, N'{"max_posts_monthly": 10, "featured_posts": 2, "advanced_search": true}', 1, 1),
(N'Freelancer Cơ bản', N'Hiển thị hồ sơ cơ bản.', N'Jobseeker', 0.00, NULL, N'{"apply_limit_monthly": 5}', 1, 2),
(N'Freelancer Premium', N'Nổi bật hồ sơ và tăng cơ hội việc làm.', N'Jobseeker', 99000.00, 30, N'{"apply_limit_monthly": 20, "featured_profile": true, "skill_highlight": true}', 1, 2);
GO

-- 4. Bảng phụ thuộc vào các nhóm trước
PRINT 'Inserting data into Company...';
-- SỬA LỖI: Mỗi recruiterID chỉ được liên kết với một Company
INSERT INTO [Company] ([company_name], [team_numberID], [established_on], [logo], [website], [describe], [location], [recruiterID]) VALUES
(N'Công ty Giải Pháp X', 2, '2015-06-01', N'/img/logo/companyX.png', N'https://companyX.com', N'Chuyên cung cấp giải pháp phần mềm doanh nghiệp.', N'TP. Hồ Chí Minh', 1),
(N'Tập đoàn Sáng Tạo Y', 4, '2010-01-20', N'/img/logo/companyY.png', N'https://companyY.vn', N'Đi đầu trong lĩnh vực công nghệ và đổi mới.', N'Hà Nội', 2);
-- Recruiter 3 (recruiterID=3) và Recruiter 4 (recruiterID=4) có thể có công ty riêng nếu muốn
-- INSERT INTO [Company] ([company_name], [team_numberID], [established_on], [logo], [website], [describe], [location], [recruiterID]) VALUES
-- (N'NewCorp Solutions', 1, '2023-01-01', N'/img/logo/newcorp.png', N'https://newcorp.com', N'Startup về công nghệ mới.', N'Đà Nẵng', 3);
GO

PRINT 'Inserting data into Education...';
INSERT INTO [Education] ([university_name], [start_date], [end_date], [freelancerID], [degreeID]) VALUES
(N'Đại học Bách Khoa TPHCM', '2014-09-01', '2018-09-30', 1, 4), -- Lan (freelancerID=1), Đại học
(N'Đại học FPT', '2012-09-01', '2016-09-30', 2, 4), -- Sơn (freelancerID=2), Đại học
(N'Arena Multimedia', '2020-03-01', '2022-03-01', 3, 7), -- Mai (freelancerID=3), Chứng chỉ
(N'Cao đẳng Kinh tế Đối ngoại', '2015-09-01', '2018-06-30', 5, 3); -- Vy (freelancerID=5), Cao đẳng
GO

PRINT 'Inserting data into Experience...';
INSERT INTO [Experience] ([experience_work_name], [position], [start_date], [end_date], [your_project], [freelancerID]) VALUES
(N'Công ty ABC', N'Frontend Developer', '2019-01-01', '2021-12-31', N'Tham gia phát triển hệ thống e-commerce', 1),
(N'Dự án Freelance XYZ', N'ReactJS Developer', '2022-01-01', NULL, N'Xây dựng ứng dụng quản lý kho cho khách hàng Úc', 1),
(N'Công ty DEF', N'Java Developer', '2017-01-01', '2020-06-30', N'Phát triển module thanh toán cho ngân hàng', 2),
(N'Freelance UI/UX', N'UI/UX Designer', '2022-05-01', NULL, N'Thiết kế giao diện cho nhiều ứng dụng mobile và web', 3),
(N'Startup GHI', N'Full-stack Developer', '2019-01-10', '2021-05-15', N'Xây dựng MVP cho sản phẩm SaaS', 5);
GO

PRINT 'Inserting data into Post...';
-- Giả sử recruiterID và adminID đã được insert thành công
INSERT INTO [Post] ([title], [image], [jobTypeID], [durationID], [date_post], [expired_date], [quantity], [description], [budget_min], [budget_max], [budget_type], [location], [recruiterID], [statusPost], [categoryID], [approvedByAdminID]) VALUES
(N'Tuyển Frontend Developer (ReactJS)', N'/img/post/react_dev.jpg', 4, 2, '2024-07-10 10:00:00', '2024-08-10 23:59:59', 2, N'Cần tuyển gấp 2 bạn ReactJS Developer có kinh nghiệm từ 2 năm. Yêu cầu thành thạo Redux, REST API.', 15000000, 25000000, N'Fixed', N'Remote hoặc TP.HCM', 1, N'Approved', 1, 1), -- postID = 1
(N'Tìm Java Backend Developer (Spring Boot)', N'/img/post/java_dev.jpg', 3, 3, '2024-07-05 14:30:00', '2024-09-05 23:59:59', 1, N'Dự án dài hạn cần 1 Java Developer có kinh nghiệm làm việc với Spring Boot, Microservices. Có cơ hội làm việc onsite Singapore.', 500000, 800000, N'Hourly', N'Hà Nội (Ưu tiên)', 2, N'Approved', 1, 1), -- postID = 2
(N'Thiết kế UI/UX cho ứng dụng Mobile Fitness', N'/img/post/uiux_fitness.jpg', 4, 1, '2024-07-12 09:00:00', '2024-07-25 23:59:59', 1, N'Cần designer có kinh nghiệm thiết kế app mobile, ưu tiên đã làm sản phẩm về fitness. Yêu cầu portfolio.', 10000000, 18000000, N'Range', N'Remote', 1, N'Pending', 3, NULL), -- postID = 3
(N'Viết bài SEO cho website Du lịch (Tiếng Anh)', N'/img/post/seo_travel.jpg', 4, 4, '2024-06-20 11:00:00', '2024-12-31 23:59:59', 5, N'Cần cộng tác viên viết bài SEO tiếng Anh cho website du lịch, chủ đề đa dạng. Yêu cầu khả năng viết tốt, hiểu biết về SEO onpage.', 300000, 500000, N'Per Article', N'Remote', 2, N'Approved', 4, 2), -- postID = 4
(N'Thực tập sinh Marketing Online', N'/img/post/intern_mkt.jpg', 5, 2, '2024-07-15 16:00:00', '2024-08-15 23:59:59', 3, N'Cơ hội thực tập cho các bạn sinh viên đam mê Marketing. Được đào tạo và làm việc thực tế.', 0, 3000000, N'Fixed', N'TP. Hồ Chí Minh', 1, N'Draft', 5, NULL), -- postID = 5
(N'Post đã hết hạn', N'/img/post/expired.jpg', 4, 1, '2024-01-01 08:00:00', '2024-02-01 23:59:59', 1, N'Mô tả post đã hết hạn.', 5000000, 7000000, N'Fixed', N'Remote', 2, N'Expired', 2, 1); -- postID = 6
GO

-- 5. Bảng phụ thuộc nhiều (Many-to-Many, Junction tables)
PRINT 'Inserting data into Post_Skills...';
-- Đảm bảo postID và skill_set_ID tồn tại
INSERT INTO [Post_Skills] ([postID], [skill_set_ID]) VALUES
(1, 1), (1, 10), (1, 11), -- Post 1 (React Dev) needs ReactJS (1), SQL (10), Git (11)
(2, 4), (2, 10), (2, 11), -- Post 2 (Java Dev) needs Spring Boot (4), SQL (10), Git (11)
(3, 6), (3, 7),           -- Post 3 (UI/UX) needs Figma (6), Photoshop (7)
(4, 8);                   -- Post 4 (SEO Writer) needs SEO Writing (8)
GO

PRINT 'Inserting data into Mark...'; -- Recruiter đánh dấu Freelancer
-- Đảm bảo recruiterID và freelancerID tồn tại
INSERT INTO [Mark] ([recruiterID], [freelancerID], [markedDate]) VALUES
(1, 1, '2024-07-11 09:00:00'), -- Recruiter 1 đánh dấu Freelancer 1
(1, 5, '2024-07-12 10:00:00'), -- Recruiter 1 đánh dấu Freelancer 5
(2, 2, '2024-07-06 15:00:00'); -- Recruiter 2 đánh dấu Freelancer 2
GO

PRINT 'Inserting data into Skills...'; -- Kỹ năng của Freelancer
-- Đảm bảo skill_set_ID và freelancerID tồn tại
INSERT INTO [Skills] ([skill_set_ID], [freelancerID], [level]) VALUES
(1, 1, 5), (10, 1, 4), (11, 1, 5), -- Lan (1): ReactJS (1), SQL (10), Git (11)
(4, 2, 5), (10, 2, 4), (3, 2, 3), -- Sơn (2): Spring Boot (4), SQL (10), Node.js (3)
(6, 3, 5), (7, 3, 4),             -- Mai (3): Figma (6), Photoshop (7)
(5, 5, 4), (1, 5, 3), (3, 5, 4); -- Vy (5): Python Django (5), ReactJS (1), Node.js (3)
GO

PRINT 'Inserting data into JobApply...';
-- Đảm bảo freelancerID và postID tồn tại
INSERT INTO [JobApply] ([freelancerID], [postID], [statusApply], [dateApply], [coverLetter], [resumePath]) VALUES
(1, 1, N'Shortlisted', '2024-07-11 11:00:00', N'Dear Recruiter, I am very interested in the ReactJS Developer position...', N'/resumes/lan_ho_react.pdf'),
(5, 1, N'Viewed', '2024-07-12 09:30:00', N'Xin chào, tôi thấy tin tuyển dụng ReactJS Developer và muốn ứng tuyển...', N'/resumes/vy_tran_fullstack.pdf'),
(2, 2, N'Interviewing', '2024-07-07 10:00:00', N'To Company Y, I have extensive experience with Spring Boot...', N'/resumes/son_dang_java.pdf'),
(3, 3, N'Pending', '2024-07-13 14:00:00', N'Kính gửi Anh/Chị, Em xin ứng tuyển vị trí UI/UX Designer...', N'/resumes/mai_nguyen_uiux.pdf'),
(1, 4, N'Offered', '2024-06-25 10:00:00', N'I would like to apply for the SEO Content Writer role...', N'/resumes/lan_ho_writer.pdf'),
(5, 6, N'Rejected', '2024-01-05 10:00:00', N'Ứng tuyển vào post đã hết hạn.', N'/resumes/vy_tran_old.pdf');
GO

PRINT 'Inserting data into FreelancerFavorites...';
-- Đảm bảo freelancerID và postID tồn tại
INSERT INTO [FreelancerFavorites] ([freelancerID], [postID], [favoritedDate]) VALUES
(1, 2, '2024-07-08 10:00:00'), -- Lan (1) thích post Java (2)
(5, 3, '2024-07-13 09:00:00'), -- Vy (5) thích post UI/UX (3)
(2, 1, '2024-07-11 14:00:00'); -- Sơn (2) thích post React (1)
GO

PRINT 'Inserting data into Report...';
-- Đảm bảo reporter_freelancerID và reported_postID tồn tại
INSERT INTO [Report] ([reporter_freelancerID], [reported_postID], [dateReport], [message], [handledByAdminID], [handlingStatus], [adminNotes]) VALUES
(1, 6, '2024-01-10 10:00:00', N'Tin tuyển dụng này đã hết hạn từ lâu nhưng vẫn hiển thị.', 1, N'Resolved_NoAction', N'Post đã được hệ thống tự chuyển sang Expired. Không cần xử lý thêm.'),
(5, 3, '2024-07-14 11:00:00', N'Yêu cầu về budget trong mô tả không rõ ràng.', NULL, N'Pending', NULL);
GO

-- 6. Bảng RecruiterTransaction và UserTierSubscriptions (Xử lý cẩn thận)

-- Giao dịch không liên quan đến gói đăng ký
PRINT 'Inserting data into RecruiterTransaction (non-subscription)...';
-- Đảm bảo recruiterID và relatedPostID (nếu có) tồn tại
INSERT INTO [RecruiterTransaction] ([recruiterID], [transactionType], [amount], [transactionDate], [description], [statusTransaction], [relatedPostID], [relatedTierSubscriptionID]) VALUES
(1, N'Deposit', 500000.00, '2024-07-01 09:00:00', N'Nạp tiền vào tài khoản', N'Completed', NULL, NULL),
(2, N'Deposit', 300000.00, '2024-07-02 10:00:00', N'Nạp tiền vào tài khoản', N'Completed', NULL, NULL),
(1, N'PostPayment', 50000.00, '2024-07-10 10:05:00', N'Phí đăng tin: Tuyển Frontend Developer (ReactJS)', N'Completed', 1, NULL),
(2, N'PostPayment', 70000.00, '2024-07-05 14:35:00', N'Phí đăng tin nổi bật: Tìm Java Backend Developer', N'Completed', 2, NULL);
GO

-- Xử lý đăng ký gói cho Recruiter
PRINT 'Processing Recruiter Tier Subscription for Recruiter 1...';
-- Giả sử Recruiter 1 (recruiterID=1) đăng ký gói Recruiter Pro (tierID=2 trong AccountTiers, giá 299000)
DECLARE @Recruiter1TransactionID INT;
DECLARE @Recruiter1SubscriptionID INT;

-- Bước 1: Tạo giao dịch thanh toán cho gói
INSERT INTO [RecruiterTransaction] ([recruiterID], [transactionType], [amount], [transactionDate], [description], [statusTransaction], [relatedPostID], [relatedTierSubscriptionID])
VALUES (1, N'TierSubscription', 299000.00, GETDATE(), N'Thanh toán gói Recruiter Pro', N'Completed', NULL, NULL);
SET @Recruiter1TransactionID = SCOPE_IDENTITY();

-- Bước 2: Tạo bản ghi đăng ký gói
INSERT INTO [UserTierSubscriptions] ([recruiterID], [freelancerID], [tierID], [startDate], [endDate], [transactionID], [isActiveSubscription])
VALUES (1, NULL, 2, GETDATE(), DATEADD(day, 30, GETDATE()), @Recruiter1TransactionID, 1); -- tierID=2 là Recruiter Pro
SET @Recruiter1SubscriptionID = SCOPE_IDENTITY();

-- Bước 3: Cập nhật RecruiterTransaction với ID của UserTierSubscription
UPDATE [RecruiterTransaction]
SET [relatedTierSubscriptionID] = @Recruiter1SubscriptionID
WHERE [transactionID] = @Recruiter1TransactionID;
PRINT 'Recruiter 1 subscribed to Recruiter Pro.';
GO


-- Xử lý đăng ký gói cho Freelancer
PRINT 'Processing Freelancer Tier Subscription for Freelancer 1...';
-- Giả sử Freelancer 1 (freelancerID=1) đăng ký gói Freelancer Premium (tierID=4 trong AccountTiers, giá 99000)
DECLARE @Freelancer1SubscriptionID INT;

INSERT INTO [UserTierSubscriptions] ([recruiterID], [freelancerID], [tierID], [startDate], [endDate], [transactionID], [isActiveSubscription])
VALUES (NULL, 1, 4, GETDATE(), DATEADD(day, 30, GETDATE()), NULL, 1); -- tierID=4 là Freelancer Premium, transactionID là NULL
SET @Freelancer1SubscriptionID = SCOPE_IDENTITY();
PRINT 'Freelancer 1 subscribed to Freelancer Premium. Payment transaction handled externally (transactionID is NULL).';
GO


-- (Tùy chọn) Kích hoạt lại tất cả các ràng buộc khóa ngoại
PRINT 'Enabling all foreign key constraints...';
EXEC sp_MSforeachtable "ALTER TABLE ? WITH CHECK CHECK CONSTRAINT ALL";
GO

PRINT 'All data has been inserted and constraints re-enabled.';
GO

PRINT 'Inserting data into FreelancerLocation...';
GO

-- Giả sử các freelancerID tương ứng với thứ tự insert trong bảng Freelancer:
-- 1: Lan Hồ Thị
-- 2: Sơn Đặng Văn
-- 3: Mai Nguyễn Thị
-- 4: Khánh Lý Hoàng
-- 5: Vy Trần Thảo

INSERT INTO [FreelancerLocation] ([freelancerID], [city], [country], [work_preference], [location_notes]) VALUES
(
    1, -- Lan Hồ Thị
    N'TP. Hồ Chí Minh',
    N'Việt Nam',
    N'Hybrid',
    N'Ưu tiên làm việc tại các quận trung tâm TP.HCM hoặc làm việc từ xa. Sẵn sàng onsite 2-3 ngày/tuần.'
),
(
    2, -- Sơn Đặng Văn
    N'Hà Nội',
    N'Việt Nam',
    N'On-site',
    N'Mong muốn làm việc tại văn phòng ở Hà Nội để dễ dàng trao đổi với team.'
),
(
    3, -- Mai Nguyễn Thị
    N'Đà Nẵng',
    N'Việt Nam',
    N'Remote',
    N'Chủ yếu làm việc từ xa. Có thể đến văn phòng tại Đà Nẵng nếu dự án yêu cầu (không thường xuyên).'
),
(
    4, -- Khánh Lý Hoàng (Có thể không có thông tin vị trí cụ thể hoặc chỉ làm remote)
    NULL, -- Không có thành phố cụ thể
    N'Việt Nam', -- Vẫn là người Việt Nam
    N'Remote',
    N'Chỉ nhận các dự án làm việc từ xa hoàn toàn.'
),
(
    5, -- Vy Trần Thảo
    N'TP. Hồ Chí Minh',
    N'Việt Nam',
    N'Negotiable',
    N'Linh hoạt giữa làm việc từ xa và tại chỗ tại TP.HCM, tùy thuộc vào yêu cầu dự án.'
);
GO

PRINT 'Data inserted into FreelancerLocation successfully.';
GO