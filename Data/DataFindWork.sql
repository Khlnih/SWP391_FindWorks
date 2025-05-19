CREATE DATABASE SU25_SWP391

CREATE TABLE [Role] (
    [roleID] [int] IDENTITY(1,1) NOT NULL,
    [role_name] [nvarchar](50) NOT NULL,
    CONSTRAINT [PK_Role] PRIMARY KEY CLUSTERED ([roleID] ASC)
);
GO

CREATE TABLE [Team_Number] (
    [team_numberID] [int] IDENTITY(1,1) NOT NULL,
    [team_number] [nvarchar](50) NOT NULL, 
    CONSTRAINT [PK_Team_Number] PRIMARY KEY CLUSTERED ([team_numberID] ASC)
);
GO

CREATE TABLE [Categories] (
    [caID] [int] IDENTITY(1,1) NOT NULL,
    [categories_name] [nvarchar](50) NOT NULL,
    [categories_img] [nvarchar](220) NULL,
    [description] [nvarchar](500) NULL,
    [statusCate] [bit] NULL,
    CONSTRAINT [PK_Categories] PRIMARY KEY CLUSTERED ([caID] ASC)
);
GO

CREATE TABLE [Duration] (
    [durationID] [int] IDENTITY(1,1) NOT NULL,
    [duration_name] [nvarchar](50) NOT NULL,
    CONSTRAINT [PK_Duration] PRIMARY KEY CLUSTERED ([durationID] ASC)
);
GO

CREATE TABLE [JobType] (
    [jobID] [int] IDENTITY(1,1) NOT NULL,
    [job_name] [nvarchar](50) NOT NULL,
    CONSTRAINT [PK_JobType] PRIMARY KEY CLUSTERED ([jobID] ASC)
);
GO

CREATE TABLE [Degree] (
    [dregeeID] [int] IDENTITY(1,1) NOT NULL, 
    [degree_name] [nvarchar](50) NOT NULL,
    CONSTRAINT [PK_Degree] PRIMARY KEY CLUSTERED ([dregeeID] ASC)
);
GO

CREATE TABLE [Expertise] (
    [ExpertiseID] [int] IDENTITY(1,1) NOT NULL,
    [ExpertiseName] [nvarchar](500) NULL,
    CONSTRAINT [PK_Expertise] PRIMARY KEY CLUSTERED ([ExpertiseID] ASC)
);
GO

CREATE TABLE [User] (
    [userID] [int] IDENTITY(1,1) NOT NULL,
    [username] [nvarchar](50) NOT NULL,
    [password] [nvarchar](50) NOT NULL,
    [email] [nvarchar](50) NOT NULL,
    [status] [nvarchar](50) NOT NULL,
    [roleID] [int] NOT NULL,
    [LevelPass] [bit] NULL,
    CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED ([userID] ASC),
    CONSTRAINT [UQ_User_Username] UNIQUE NONCLUSTERED ([username] ASC),
    CONSTRAINT [UQ_User_Email] UNIQUE NONCLUSTERED ([email] ASC),
    CONSTRAINT [FK_User_Role] FOREIGN KEY ([roleID]) REFERENCES [Role]([roleID])
);
GO

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

CREATE TABLE [Admin] (
    [adminID] [int] IDENTITY(1,1) NOT NULL,
    [first_name] [nvarchar](50) NOT NULL,
    [last_name] [nvarchar](50) NOT NULL,
    [phone] [nvarchar](50) NOT NULL,
    [email] [nvarchar](50) NOT NULL,
    [image] [nvarchar](220) NULL,
    [userID] [int] NOT NULL,
    CONSTRAINT [PK_Admin] PRIMARY KEY CLUSTERED ([adminID] ASC),
    CONSTRAINT [UQ_Admin_Email] UNIQUE NONCLUSTERED ([email] ASC),
    CONSTRAINT [UQ_Admin_UserID] UNIQUE NONCLUSTERED ([userID] ASC), 
    CONSTRAINT [FK_Admin_User] FOREIGN KEY ([userID]) REFERENCES [User]([userID])
);
GO

CREATE TABLE [Recruiter] (
    [recruiterID] [int] IDENTITY(1,1) NOT NULL,
    [first_name] [nvarchar](50) NOT NULL,
    [last_name] [nvarchar](50) NOT NULL,
    [gender] [bit] NOT NULL, -- 0 hoặc 1
    [dob] [date] NOT NULL,
    [image] [varchar](100) NULL,
    [email_contact] [varchar](30) NOT NULL, 
    [phone_contact] [varchar](15) NOT NULL, 
    [userID] [int] NOT NULL,
    CONSTRAINT [PK_Recruiter] PRIMARY KEY CLUSTERED ([recruiterID] ASC),
    CONSTRAINT [UQ_Recruiter_EmailContact] UNIQUE NONCLUSTERED ([email_contact] ASC),
    CONSTRAINT [UQ_Recruiter_PhoneContact] UNIQUE NONCLUSTERED ([phone_contact] ASC),
    CONSTRAINT [UQ_Recruiter_UserID] UNIQUE NONCLUSTERED ([userID] ASC), -- Mỗi User chỉ là Recruiter 1 lần
    CONSTRAINT [FK_Recruiter_User] FOREIGN KEY ([userID]) REFERENCES [User]([userID])
);
GO

CREATE TABLE [Freelancer] (
    [freelanceID] [int] IDENTITY(1,1) NOT NULL, 
    [first_name] [nvarchar](50) NOT NULL,
    [last_name] [nvarchar](50) NOT NULL,
    [image] [nvarchar](220) NULL,
    [gender] [bit] NOT NULL, 
    [dob] [date] NOT NULL,
    [describe] [nvarchar](max) NULL,
    [email__contact] [nvarchar](30) NOT NULL, 
    [phone_contact] [varchar](15) NOT NULL, 
    [userID] [int] NOT NULL,
    CONSTRAINT [PK_Freelancer] PRIMARY KEY CLUSTERED ([freelanceID] ASC),
    CONSTRAINT [UQ_Freelancer_EmailContact] UNIQUE NONCLUSTERED ([email__contact] ASC),
    CONSTRAINT [UQ_Freelancer_PhoneContact] UNIQUE NONCLUSTERED ([phone_contact] ASC),
    CONSTRAINT [UQ_Freelancer_UserID] UNIQUE NONCLUSTERED ([userID] ASC), 
    CONSTRAINT [FK_Freelancer_User] FOREIGN KEY ([userID]) REFERENCES [User]([userID])
);
GO

CREATE TABLE [Blogs] (
    [blogID] [int] IDENTITY(1,1) NOT NULL,
    [title] [nvarchar](220) NULL,
    [image] [nvarchar](220) NULL,
    [date_blog] [date] NOT NULL,
    [description] [nvarchar](max) NULL,
    [tag] [nvarchar](50) NULL,
    [adminID] [int] NOT NULL,
    [statusBlog] [bit] NULL,
    CONSTRAINT [PK_Blogs] PRIMARY KEY CLUSTERED ([blogID] ASC),
    CONSTRAINT [FK_Blogs_Admin] FOREIGN KEY ([adminID]) REFERENCES [Admin]([adminID])
);
GO

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
    CONSTRAINT [PK_Post] PRIMARY KEY CLUSTERED ([postID] ASC),
    CONSTRAINT [FK_Post_JobType] FOREIGN KEY ([job_type_ID]) REFERENCES [JobType]([jobID]),
    CONSTRAINT [FK_Post_Duration] FOREIGN KEY ([durationID]) REFERENCES [Duration]([durationID]),
    CONSTRAINT [FK_Post_Recruiter] FOREIGN KEY ([recruiterID]) REFERENCES [Recruiter]([recruiterID]),
    CONSTRAINT [FK_Post_Categories] FOREIGN KEY ([caID]) REFERENCES [Categories]([caID])
);
GO

CREATE TABLE [Mark] (
    [MarkID] [int] IDENTITY(1,1) NOT NULL,
    [RecruiterID] [int] NULL, 
    [FreelancerID] [int] NULL, 
    CONSTRAINT [PK_Mark] PRIMARY KEY CLUSTERED ([MarkID] ASC),
    CONSTRAINT [FK_Mark_Recruiter] FOREIGN KEY ([RecruiterID]) REFERENCES [Recruiter]([recruiterID]),
    CONSTRAINT [FK_Mark_Freelancer] FOREIGN KEY ([FreelancerID]) REFERENCES [Freelancer]([freelanceID]) -- Tham chiếu đến freelanceID
);
GO

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

CREATE TABLE [Report] (
    [ReportID] [int] IDENTITY(1,1) NOT NULL,
    [freelancerID] [int] NOT NULL, 
    [postID] [int] NOT NULL,
    [dateReport] [datetime] NULL, 
    [messeage] [nvarchar](max) NULL, 
    CONSTRAINT [PK_Report] PRIMARY KEY CLUSTERED ([ReportID] ASC),
    CONSTRAINT [FK_Report_Freelancer] FOREIGN KEY ([freelancerID]) REFERENCES [Freelancer]([freelanceID]), -- Tham chiếu đến freelanceID
    CONSTRAINT [FK_Report_Post] FOREIGN KEY ([postID]) REFERENCES [Post]([postID])
);
GO