USE master
GO

/*******************************************************************************
   Drop database if it exists
********************************************************************************/
IF EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'SU25_SWP391')
BEGIN
ALTER DATABASE SU25_SWP391  SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
DROP DATABASE SU25_SWP391 ;
END

GO
CREATE DATABASE SU25_SWP391 
GO
USE SU25_SWP391 
GO

CREATE TABLE [Team_Number] (
    [team_numberID] [int] IDENTITY(1,1) NOT NULL,
    [team_number] [nvarchar](50) NOT NULL, 
    CONSTRAINT [PK_Team_Number] PRIMARY KEY CLUSTERED ([team_numberID] ASC)
);
GO

-- Bảng Categories vẫn giữ nguyên
CREATE TABLE [Categories] (
    [caID] [int] IDENTITY(1,1) NOT NULL,
    [categories_name] [nvarchar](50) NOT NULL,
    [categories_img] [nvarchar](220) NULL,
    [description] [nvarchar](500) NULL,
    [statusCate] [bit] NULL,
    CONSTRAINT [PK_Categories] PRIMARY KEY CLUSTERED ([caID] ASC)
);
GO

-- Bảng Duration vẫn giữ nguyên
CREATE TABLE [Duration] (
    [durationID] [int] IDENTITY(1,1) NOT NULL,
    [duration_name] [nvarchar](50) NOT NULL,
    CONSTRAINT [PK_Duration] PRIMARY KEY CLUSTERED ([durationID] ASC)
);
GO

-- Bảng JobType vẫn giữ nguyên
CREATE TABLE [JobType] (
    [jobID] [int] IDENTITY(1,1) NOT NULL,
    [job_name] [nvarchar](50) NOT NULL,
    CONSTRAINT [PK_JobType] PRIMARY KEY CLUSTERED ([jobID] ASC)
);
GO

-- Bảng Degree vẫn giữ nguyên (lưu ý tên cột là dregeeID)
CREATE TABLE [Degree] (
    [dregeeID] [int] IDENTITY(1,1) NOT NULL, 
    [degree_name] [nvarchar](50) NOT NULL,
    CONSTRAINT [PK_Degree] PRIMARY KEY CLUSTERED ([dregeeID] ASC)
);
GO

-- Bảng Expertise vẫn giữ nguyên
CREATE TABLE [Expertise] (
    [ExpertiseID] [int] IDENTITY(1,1) NOT NULL,
    [ExpertiseName] [nvarchar](500) NULL,
    CONSTRAINT [PK_Expertise] PRIMARY KEY CLUSTERED ([ExpertiseID] ASC)
);
GO

-- Bảng User đã bị xóa

-- Bảng Skill_Set vẫn giữ nguyên, chỉ phụ thuộc Expertise
CREATE TABLE [Skill_Set] (
    [skill_set_ID] [int] IDENTITY(1,1) NOT NULL,
    [skill_set_name] [nvarchar](50) NOT NULL,
    [description] [nvarchar](max) NULL,
    [statusSkill] [bit] NULL,
    [ExpertiID] [int] NULL, 
    CONSTRAINT [PK_Skill_Set] PRIMARY KEY CLUSTERED ([skill_set_ID] ASC),
    CONSTRAINT [FK_Skill_Set_Expertise] FOREIGN KEY ([ExpertiID]) REFERENCES [Expertise]([ExpertiseID])
);
GO

-- Chỉnh sửa bảng Admin: Xóa userID, thêm username, password, status
CREATE TABLE [Admin] (
    [adminID] [int] IDENTITY(1,1) NOT NULL,
    [username] [nvarchar](50) NOT NULL, -- Thêm username
    [password] [nvarchar](50) NOT NULL, -- Thêm password
    [first_name] [nvarchar](50) NOT NULL,
    [last_name] [nvarchar](50) NOT NULL,
    [phone] [nvarchar](50) NOT NULL,
    [email] [nvarchar](50) NOT NULL,
    [image] [nvarchar](220) NULL,
    [status] [nvarchar](50) NOT NULL, -- Thêm status
    CONSTRAINT [PK_Admin] PRIMARY KEY CLUSTERED ([adminID] ASC),
    CONSTRAINT [UQ_Admin_Username] UNIQUE NONCLUSTERED ([username] ASC), -- Username nên là duy nhất
    CONSTRAINT [UQ_Admin_Email] UNIQUE NONCLUSTERED ([email] ASC)
);
GO

-- Chỉnh sửa bảng Recruiter: Xóa userID, thêm username, password, status
CREATE TABLE [Recruiter] (
    [recruiterID] [int] IDENTITY(1,1) NOT NULL,
    [username] [nvarchar](50) NOT NULL, -- Thêm username
    [password] [nvarchar](50) NOT NULL, -- Thêm password
    [first_name] [nvarchar](50) NOT NULL,
    [last_name] [nvarchar](50) NOT NULL,
    [gender] [bit] NOT NULL, -- 0 hoặc 1
    [dob] [date] NOT NULL,
    [image] [varchar](100) NULL,
	[money] [int] NOT NULL,
    [email_contact] [varchar](30) NOT NULL, 
    [phone_contact] [varchar](15) NOT NULL, 
    [status] [nvarchar](50) NOT NULL, -- Thêm status
    CONSTRAINT [PK_Recruiter] PRIMARY KEY CLUSTERED ([recruiterID] ASC),
    CONSTRAINT [UQ_Recruiter_Username] UNIQUE NONCLUSTERED ([username] ASC), -- Username nên là duy nhất
    CONSTRAINT [UQ_Recruiter_EmailContact] UNIQUE NONCLUSTERED ([email_contact] ASC),
    CONSTRAINT [UQ_Recruiter_PhoneContact] UNIQUE NONCLUSTERED ([phone_contact] ASC)
);
GO

-- Chỉnh sửa bảng Freelancer: Xóa userID, thêm username, password, status
CREATE TABLE [Freelancer] (
    [freelanceID] [int] IDENTITY(1,1) NOT NULL, 
    [username] [nvarchar](50) NOT NULL, -- Thêm username
    [password] [nvarchar](50) NOT NULL, -- Thêm password
    [first_name] [nvarchar](50) NOT NULL,
    [last_name] [nvarchar](50) NOT NULL,
    [image] [nvarchar](220) NULL,
    [gender] [bit] NOT NULL, 
    [dob] [date] NOT NULL,
    [describe] [nvarchar](max) NULL,
    [email__contact] [nvarchar](30) NOT NULL, -- Lưu ý tên cột email__contact
    [phone_contact] [varchar](15) NOT NULL, 
    [status] [nvarchar](50) NOT NULL, -- Thêm status
    CONSTRAINT [PK_Freelancer] PRIMARY KEY CLUSTERED ([freelanceID] ASC),
    CONSTRAINT [UQ_Freelancer_Username] UNIQUE NONCLUSTERED ([username] ASC), -- Username nên là duy nhất
    CONSTRAINT [UQ_Freelancer_EmailContact] UNIQUE NONCLUSTERED ([email__contact] ASC),
    CONSTRAINT [UQ_Freelancer_PhoneContact] UNIQUE NONCLUSTERED ([phone_contact] ASC)
);
GO

-- Bảng Blogs vẫn giữ nguyên, tham chiếu đến adminID trong bảng Admin
CREATE TABLE [Blogs] (
    [blogID] [int] IDENTITY(1,1) NOT NULL,
    [title] [nvarchar](220) NULL,
    [image] [nvarchar](220) NULL,
    [date_blog] [date] NOT NULL,
    [description] [nvarchar](max) NULL,
    [tag] [nvarchar](50) NULL,
    [adminID] [int] NOT NULL, -- Khóa ngoại tới Admin tạo blog
    [statusBlog] [bit] NULL,
    CONSTRAINT [PK_Blogs] PRIMARY KEY CLUSTERED ([blogID] ASC),
    CONSTRAINT [FK_Blogs_Admin] FOREIGN KEY ([adminID]) REFERENCES [Admin]([adminID])
);
GO

-- Bảng Company vẫn giữ nguyên, tham chiếu đến team_numberID và recruiterID
CREATE TABLE [Company] (
    [companyID] [int] IDENTITY(1,1) NOT NULL,
    [company_name] [nvarchar](50) NOT NULL,
    [team_numberID] [int] NOT NULL,
    [established_on] [date] NULL,
    [logo] [nvarchar](220) NULL,
    [website] [nvarchar](220) NULL,
    [describe] [nvarchar](max) NULL,
    [location] [nvarchar](500) NULL,
    [recruiterID] [int] NOT NULL,
    CONSTRAINT [PK_Company] PRIMARY KEY CLUSTERED ([companyID] ASC),
    CONSTRAINT [UQ_Company_RecruiterID] UNIQUE NONCLUSTERED ([recruiterID] ASC), -- Mỗi Recruiter quản lý 1 Công ty
    CONSTRAINT [FK_Company_TeamNumber] FOREIGN KEY ([team_numberID]) REFERENCES [Team_Number]([team_numberID]),
    CONSTRAINT [FK_Company_Recruiter] FOREIGN KEY ([recruiterID]) REFERENCES [Recruiter]([recruiterID])
);
GO

-- Bảng Education vẫn giữ nguyên, tham chiếu đến freelanceID và dregeeID
CREATE TABLE [Education] (
    [educationID] [int] IDENTITY(1,1) NOT NULL,
    [university_name] [nvarchar](50) NULL,
    [start_date] [date] NULL,
    [end_date] [date] NULL,
    [freelanceID] [int] NOT NULL, 
    [degreeID] [int] NOT NULL, 
    CONSTRAINT [PK_Education] PRIMARY KEY CLUSTERED ([educationID] ASC),
    CONSTRAINT [FK_Education_Freelancer] FOREIGN KEY ([freelanceID]) REFERENCES [Freelancer]([freelanceID]),
    CONSTRAINT [FK_Education_Degree] FOREIGN KEY ([degreeID]) REFERENCES [Degree]([dregeeID]) -- Tham chiếu đến dregeeID
);
GO

-- Bảng Experience vẫn giữ nguyên, tham chiếu đến freelanceID
CREATE TABLE [Experience] (
    [experienceID] [int] IDENTITY(1,1) NOT NULL,
    [experience_work_name] [nvarchar](50) NULL,
    [position] [nvarchar](50) NULL,
    [start_date] [date] NULL,
    [end_date] [date] NULL,
    [your_project] [nvarchar](220) NULL,
    [freelanceID] [int] NOT NULL, 
    CONSTRAINT [PK_Experience] PRIMARY KEY CLUSTERED ([experienceID] ASC),
    CONSTRAINT [FK_Experience_Freelancer] FOREIGN KEY ([freelanceID]) REFERENCES [Freelancer]([freelanceID])
);
GO

-- Bảng Post vẫn giữ nguyên các cột cũ
CREATE TABLE [Post] (
    [postID] [int] IDENTITY(1,1) NOT NULL,
    [title] [nvarchar](50) NULL,
    [image] [nvarchar](220) NULL,
    [job_type_ID] [int] NOT NULL,
    [durationID] [int] NOT NULL,
    [date_post] [date] NOT NULL,
    [expired] [date] NULL,
    [quantity] [int] NOT NULL,
    [description] [nvarchar](max) NULL,
    [budget] [int] NULL,
    [location] [nvarchar](50) NULL,
    [skill] [nvarchar](50) NULL, 
    [recruiterID] [int] NOT NULL,
    [status] [int] NULL, 
    [caID] [int] NOT NULL,
    [checking] [int] NULL,
    -- Thêm cột khóa ngoại để kết nối với Admin duyệt/kiểm tra bài đăng
    -- [approvedByAdminID] [int] NULL, -- Cột này sẽ được thêm bằng ALTER TABLE bên dưới
    CONSTRAINT [PK_Post] PRIMARY KEY CLUSTERED ([postID] ASC),
    CONSTRAINT [FK_Post_JobType] FOREIGN KEY ([job_type_ID]) REFERENCES [JobType]([jobID]),
    CONSTRAINT [FK_Post_Duration] FOREIGN KEY ([durationID]) REFERENCES [Duration]([durationID]),
    CONSTRAINT [FK_Post_Recruiter] FOREIGN KEY ([recruiterID]) REFERENCES [Recruiter]([recruiterID]),
    CONSTRAINT [FK_Post_Categories] FOREIGN KEY ([caID]) REFERENCES [Categories]([caID])
);
GO

-- Thêm cột và khóa ngoại vào bảng Post để tham chiếu Admin
ALTER TABLE [Post]
ADD [approvedByAdminID] INT NULL; -- Cột để ghi lại Admin nào đã duyệt bài đăng
GO

ALTER TABLE [Post]
ADD CONSTRAINT [FK_Post_AdminApprovedBy] FOREIGN KEY ([approvedByAdminID]) REFERENCES [Admin]([adminID]);
GO


-- Bảng Mark vẫn giữ nguyên, tham chiếu đến RecruiterID và FreelancerID
CREATE TABLE [Mark] (
    [MarkID] [int] IDENTITY(1,1) NOT NULL,
    [RecruiterID] [int] NULL, 
    [FreelancerID] [int] NULL, 
    CONSTRAINT [PK_Mark] PRIMARY KEY CLUSTERED ([MarkID] ASC),
    CONSTRAINT [FK_Mark_Recruiter] FOREIGN KEY ([RecruiterID]) REFERENCES [Recruiter]([recruiterID]),
    CONSTRAINT [FK_Mark_Freelancer] FOREIGN KEY ([FreelancerID]) REFERENCES [Freelancer]([freelanceID]) -- Tham chiếu đến freelanceID
);
GO

-- Bảng Skills vẫn giữ nguyên, tham chiếu đến skill_set_ID và freelancerID
CREATE TABLE [Skills] (
    [skillID] [int] IDENTITY(1,1) NOT NULL,
    [skill_set_ID] [int] NOT NULL,
    [freelancerID] [int] NOT NULL, 
    [level] [int] NULL, 
    CONSTRAINT [PK_Skills] PRIMARY KEY CLUSTERED ([skillID] ASC),
    CONSTRAINT [UQ_Skills_SkillSetID_FreelancerID] UNIQUE NONCLUSTERED ([skill_set_ID] ASC, [freelancerID] ASC), -- Đảm bảo duy nhất cặp skill_set và freelancer
    CONSTRAINT [FK_Skills_SkillSet] FOREIGN KEY ([skill_set_ID]) REFERENCES [Skill_Set]([skill_set_ID]),
    CONSTRAINT [FK_Skills_Freelancer] FOREIGN KEY ([freelancerID]) REFERENCES [Freelancer]([freelanceID]) -- Tham chiếu đến freelanceID
);
GO

-- Bảng JobApply vẫn giữ nguyên, tham chiếu đến freelanceID và postID
CREATE TABLE [JobApply] (
    [applyID] [int] IDENTITY(1,1) NOT NULL,
    [freelanceID] [int] NOT NULL, 
    [postID] [int] NOT NULL,
    [status] [nvarchar](50) NULL,
    [dateApply] [date] NULL,
    [Resume] [nvarchar](500) NULL, 
    CONSTRAINT [PK_JobApply] PRIMARY KEY CLUSTERED ([applyID] ASC),
    -- Ràng buộc UNIQUE có thể cần nếu mỗi freelancer chỉ ứng tuyển 1 lần cho 1 post
    -- CONSTRAINT [UQ_JobApply_FreelanceID_PostID] UNIQUE NONCLUSTERED ([freelanceID] ASC, [postID] ASC),
    CONSTRAINT [FK_JobApply_Freelancer] FOREIGN KEY ([freelanceID]) REFERENCES [Freelancer]([freelanceID]),
    CONSTRAINT [FK_JobApply_Post] FOREIGN KEY ([postID]) REFERENCES [Post]([postID])
);
GO

-- Bảng FreelancerFavorites vẫn giữ nguyên, tham chiếu đến freelanceID và postID
CREATE TABLE [FreelancerFavorites] (
    [favoritesID] [int] IDENTITY(1,1) NOT NULL,
    [freelanceID] [int] NOT NULL, 
    [postID] [int] NOT NULL,
    CONSTRAINT [PK_FreelancerFavorites] PRIMARY KEY CLUSTERED ([favoritesID] ASC),
    CONSTRAINT [UQ_FreelancerFavorites_FreelanceID_PostID] UNIQUE NONCLUSTERED ([freelanceID] ASC, [postID] ASC), -- Đảm bảo duy nhất cặp freelancer và post
    CONSTRAINT [FK_FreelancerFavorites_Freelancer] FOREIGN KEY ([freelanceID]) REFERENCES [Freelancer]([freelanceID]),
    CONSTRAINT [FK_FreelancerFavorites_Post] FOREIGN KEY ([postID]) REFERENCES [Post]([postID])
);
GO

-- Bảng Report vẫn giữ nguyên các cột cũ
CREATE TABLE [Report] (
    [ReportID] [int] IDENTITY(1,1) NOT NULL,
    [freelancerID] [int] NOT NULL, 
    [postID] [int] NOT NULL,
    [dateReport] [datetime] NULL, 
    [messeage] [nvarchar](max) NULL, 
    -- Thêm cột khóa ngoại để kết nối với Admin xử lý báo cáo
    -- [handledByAdminID] [int] NULL, -- Cột này sẽ được thêm bằng ALTER TABLE bên dưới
    -- [handlingStatus] [nvarchar](50) NULL, -- Cột này cũng sẽ được thêm bằng ALTER TABLE
    CONSTRAINT [PK_Report] PRIMARY KEY CLUSTERED ([ReportID] ASC),
    CONSTRAINT [FK_Report_Freelancer] FOREIGN KEY ([freelancerID]) REFERENCES [Freelancer]([freelanceID]), -- Tham chiếu đến freelanceID
    CONSTRAINT [FK_Report_Post] FOREIGN KEY ([postID]) REFERENCES [Post]([postID])
);
GO

-- Thêm cột và khóa ngoại vào bảng Report để tham chiếu Admin
ALTER TABLE [Report]
ADD [handledByAdminID] INT NULL; -- Cột để ghi lại Admin nào đã xử lý báo cáo
GO

ALTER TABLE [Report]
ADD CONSTRAINT [FK_Report_AdminHandledBy] FOREIGN KEY ([handledByAdminID]) REFERENCES [Admin]([adminID]);
GO

ALTER TABLE [Report]
ADD [handlingStatus] NVARCHAR(50) NULL; -- Cột để lưu trạng thái xử lý báo cáo (ví dụ: 'Pending', 'Resolved')
GO


-- Thêm cột và khóa ngoại vào bảng Recruiter để tham chiếu Admin
ALTER TABLE [Recruiter]
ADD [statusChangedByAdminID] INT NULL; -- Cột để ghi lại Admin nào đã thay đổi trạng thái Recruiter
GO

ALTER TABLE [Recruiter]
ADD CONSTRAINT [FK_Recruiter_AdminStatusChangedBy] FOREIGN KEY ([statusChangedByAdminID]) REFERENCES [Admin]([adminID]);
GO


-- Thêm cột và khóa ngoại vào bảng Freelancer để tham chiếu Admin
ALTER TABLE [Freelancer]
ADD [statusChangedByAdminID] INT NULL; -- Cột để ghi lại Admin nào đã thay đổi trạng thái Freelancer
GO

ALTER TABLE [Freelancer]
ADD CONSTRAINT [FK_Freelancer_AdminStatusChangedBy] FOREIGN KEY ([statusChangedByAdminID]) REFERENCES [Admin]([adminID]);
GO

-- Tạo bảng RecruiterTransaction
CREATE TABLE [RecruiterTransaction] (
    [transactionID] [int] IDENTITY(1,1) NOT NULL, -- Khóa chính, tự tăng
    [recruiterID] [int] NOT NULL, -- Khóa ngoại liên kết với bảng Recruiter
    [transactionType] [nvarchar](50) NOT NULL, -- Loại giao dịch (ví dụ: 'Deposit', 'Post Payment', 'Refund')
    [amount] [decimal](18, 2) NOT NULL, -- Số tiền giao dịch (số dương cho tiền vào, số âm cho tiền ra)
    [transactionDate] [datetime] NOT NULL DEFAULT SYSUTCDATETIME(), -- Thời điểm giao dịch xảy ra, mặc định là thời gian hệ thống UTC hiện tại
    [description] [nvarchar](max) NULL, -- Mô tả chi tiết về giao dịch (ví dụ: "Nạp 500.000 VNĐ", "Thanh toán phí đăng bài 'Tuyển Java Developer'")
    [status] [nvarchar](50) NOT NULL DEFAULT 'Completed', -- Trạng thái giao dịch ('Completed', 'Pending', 'Failed', 'Refunded')
    [relatedPostID] [int] NULL, -- Tùy chọn: Liên kết đến ID bài đăng nếu giao dịch liên quan đến phí đăng bài
    -- Có thể thêm các cột khác như: processingFee, paymentGatewayReference, v.v.

    CONSTRAINT [PK_RecruiterTransaction] PRIMARY KEY CLUSTERED ([transactionID] ASC),
    -- Ràng buộc khóa ngoại tới bảng Recruiter
    CONSTRAINT [FK_RecruiterTransaction_Recruiter] FOREIGN KEY ([recruiterID]) REFERENCES [Recruiter]([recruiterID]),
    -- Ràng buộc khóa ngoại tùy chọn tới bảng Post (nếu giao dịch liên quan đến bài đăng)
    CONSTRAINT [FK_RecruiterTransaction_Post] FOREIGN KEY ([relatedPostID]) REFERENCES [Post]([postID])
);