USE master
GO

/*******************************************************************************
   Drop database if it exists
********************************************************************************/
IF EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'SU25_SWP391_V2') -- Đổi tên DB để không ghi đè bản cũ ngay
BEGIN
ALTER DATABASE SU25_SWP391_V2  SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
DROP DATABASE SU25_SWP391_V2 ;
END

GO
CREATE DATABASE SU25_SWP391_V2
GO
USE SU25_SWP391_V2
GO

CREATE TABLE [Team_Number] (
    [team_numberID] [int] IDENTITY(1,1) NOT NULL,
    [team_number] [nvarchar](50) NOT NULL,
    CONSTRAINT [PK_Team_Number] PRIMARY KEY CLUSTERED ([team_numberID] ASC)
);
GO

CREATE TABLE [Categories] (
    [categoryID] [int] IDENTITY(1,1) NOT NULL, -- Đổi caID thành categoryID cho rõ nghĩa
    [category_name] [nvarchar](50) NOT NULL,  -- Đổi categories_name
    [category_img] [nvarchar](220) NULL,
    [description] [nvarchar](500) NULL,
    [isActive] [bit] NULL DEFAULT 1, -- Đổi statusCate thành isActive
    CONSTRAINT [PK_Categories] PRIMARY KEY CLUSTERED ([categoryID] ASC)
);
GO

CREATE TABLE [Duration] (
    [durationID] [int] IDENTITY(1,1) NOT NULL,
    [duration_name] [nvarchar](50) NOT NULL,
    CONSTRAINT [PK_Duration] PRIMARY KEY CLUSTERED ([durationID] ASC)
);
GO

CREATE TABLE [JobType] (
    [jobTypeID] [int] IDENTITY(1,1) NOT NULL, -- Đổi jobID thành jobTypeID
    [job_type_name] [nvarchar](50) NOT NULL, -- Đổi job_name
    CONSTRAINT [PK_JobType] PRIMARY KEY CLUSTERED ([jobTypeID] ASC)
);
GO

CREATE TABLE [Degree] (
    [degreeID] [int] IDENTITY(1,1) NOT NULL, -- Sửa dregeeID thành degreeID
    [degree_name] [nvarchar](50) NOT NULL,
    CONSTRAINT [PK_Degree] PRIMARY KEY CLUSTERED ([degreeID] ASC)
);
GO

CREATE TABLE [Expertise] (
    [expertiseID] [int] IDENTITY(1,1) NOT NULL, -- Sửa ExpertiseID
    [expertiseName] [nvarchar](500) NULL,    -- Sửa ExpertiseName
    CONSTRAINT [PK_Expertise] PRIMARY KEY CLUSTERED ([expertiseID] ASC)
);
GO

CREATE TABLE [Skill_Set] (
    [skill_set_ID] [int] IDENTITY(1,1) NOT NULL,
    [skill_set_name] [nvarchar](50) NOT NULL,
    [description] [nvarchar](max) NULL,
    [isActive] [bit] NULL DEFAULT 1, -- Đổi statusSkill thành isActive
    [expertiseID] [int] NULL,         -- Sửa ExpertiID thành expertiseID
    CONSTRAINT [PK_Skill_Set] PRIMARY KEY CLUSTERED ([skill_set_ID] ASC),
    CONSTRAINT [FK_Skill_Set_Expertise] FOREIGN KEY ([expertiseID]) REFERENCES [Expertise]([expertiseID])
);
GO

CREATE TABLE [Admin] (
    [adminID] [int] IDENTITY(1,1) NOT NULL,
    [username] [nvarchar](50) NOT NULL,
    [password_hash] [nvarchar](255) NOT NULL, -- Đổi tên và kiểu dữ liệu cho password
    [first_name] [nvarchar](50) NOT NULL,
    [last_name] [nvarchar](50) NOT NULL,
    [phone] [nvarchar](50) NOT NULL,
    [email_contact] [nvarchar](50) NOT NULL,
    [image] [nvarchar](220) NULL,
    [status] [nvarchar](50) NOT NULL, -- Ví dụ: 'Active', 'Inactive'
    CONSTRAINT [PK_Admin] PRIMARY KEY CLUSTERED ([adminID] ASC),
    CONSTRAINT [UQ_Admin_Username] UNIQUE NONCLUSTERED ([username] ASC),
    CONSTRAINT [UQ_Admin_Email] UNIQUE NONCLUSTERED ([email_contact] ASC)
);
GO

CREATE TABLE [Recruiter] (
    [recruiterID] [int] IDENTITY(1,1) NOT NULL,
    [username] [nvarchar](50) NOT NULL, 
    [password] [nvarchar](255) NOT NULL, 
    [first_name] [nvarchar](50) NOT NULL,
    [last_name] [nvarchar](50) NOT NULL,
    [gender] [bit] NOT NULL,
    [dob] [date] NOT NULL,
    [image] [varchar](220) NULL, -- varchar(100) có thể hơi ngắn cho path dài
	[money] [decimal](18,2) NOT NULL DEFAULT 0.00, -- Đổi sang decimal
    [email_contact] [varchar](50) NOT NULL, -- Tăng độ dài varchar
    [phone_contact] [varchar](15) NOT NULL,
    [status] [nvarchar](50) NOT NULL, -- Ví dụ: 'PendingVerification', 'Active', 'Suspended'
    [statusChangedByAdminID] [int] NULL,
    CONSTRAINT [PK_Recruiter] PRIMARY KEY CLUSTERED ([recruiterID] ASC),
    CONSTRAINT [UQ_Recruiter_Username] UNIQUE NONCLUSTERED ([username] ASC), -- Nếu giữ lại username
    CONSTRAINT [UQ_Recruiter_EmailContact] UNIQUE NONCLUSTERED ([email_contact] ASC),
    CONSTRAINT [UQ_Recruiter_PhoneContact] UNIQUE NONCLUSTERED ([phone_contact] ASC),
    CONSTRAINT [FK_Recruiter_AdminStatusChangedBy] FOREIGN KEY ([statusChangedByAdminID]) REFERENCES [Admin]([adminID])
);
GO


CREATE TABLE [Freelancer] (
    [freelancerID] [int] IDENTITY(1,1) NOT NULL, -- Đổi freelanceID
    [username] [nvarchar](50) NOT NULL, 
    [password] [nvarchar](255) NOT NULL, 
    [first_name] [nvarchar](50) NOT NULL,
    [last_name] [nvarchar](50) NOT NULL,
    [image] [nvarchar](220) NULL,
    [gender] [bit] NOT NULL,
    [dob] [date] NOT NULL,
    [describe] [nvarchar](max) NULL,
    [email_contact] [nvarchar](50) NOT NULL, -- Sửa email__contact, tăng độ dài
    [phone_contact] [varchar](15) NOT NULL,
    [status] [nvarchar](50) NOT NULL, -- Ví dụ: 'PendingVerification', 'Active', 'Suspended'
    [statusChangedByAdminID] [int] NULL,
    CONSTRAINT [PK_Freelancer] PRIMARY KEY CLUSTERED ([freelancerID] ASC),
    CONSTRAINT [UQ_Freelancer_Username] UNIQUE NONCLUSTERED ([username] ASC), -- Nếu giữ lại username
    CONSTRAINT [UQ_Freelancer_EmailContact] UNIQUE NONCLUSTERED ([email_contact] ASC),
    CONSTRAINT [UQ_Freelancer_PhoneContact] UNIQUE NONCLUSTERED ([phone_contact] ASC),
    CONSTRAINT [FK_Freelancer_AdminStatusChangedBy] FOREIGN KEY ([statusChangedByAdminID]) REFERENCES [Admin]([adminID])
);
GO

 ALTER TABLE [Freelancer]
ADD [money] [decimal](18, 2) NOT NULL DEFAULT 0.00;
GO 




CREATE TABLE [Blogs] (
    [blogID] [int] IDENTITY(1,1) NOT NULL,
    [title] [nvarchar](220) NULL,
    [image] [nvarchar](220) NULL,
    [date_blog] [date] NOT NULL,
    [description] [nvarchar](max) NULL,
    [tag] [nvarchar](50) NULL,
    [adminID] [int] NOT NULL,
    [isActive] [bit] NULL DEFAULT 1, -- Đổi statusBlog thành isActive
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
    CONSTRAINT [UQ_Company_RecruiterID] UNIQUE NONCLUSTERED ([recruiterID] ASC),
    CONSTRAINT [FK_Company_TeamNumber] FOREIGN KEY ([team_numberID]) REFERENCES [Team_Number]([team_numberID]),
    CONSTRAINT [FK_Company_Recruiter] FOREIGN KEY ([recruiterID]) REFERENCES [Recruiter]([recruiterID])
);
GO

CREATE TABLE [Education] (
    [educationID] [int] IDENTITY(1,1) NOT NULL,
    [university_name] [nvarchar](50) NULL,
    [start_date] [date] NULL,
    [end_date] [date] NULL,
    [freelancerID] [int] NOT NULL, -- Đổi freelanceID
    [degreeID] [int] NOT NULL,
    CONSTRAINT [PK_Education] PRIMARY KEY CLUSTERED ([educationID] ASC),
    CONSTRAINT [FK_Education_Freelancer] FOREIGN KEY ([freelancerID]) REFERENCES [Freelancer]([freelancerID]),
    CONSTRAINT [FK_Education_Degree] FOREIGN KEY ([degreeID]) REFERENCES [Degree]([degreeID])
);
GO

CREATE TABLE [Experience] (
    [experienceID] [int] IDENTITY(1,1) NOT NULL,
    [experience_work_name] [nvarchar](50) NULL,
    [position] [nvarchar](50) NULL,
    [start_date] [date] NULL,
    [end_date] [date] NULL,
    [your_project] [nvarchar](220) NULL,
    [freelancerID] [int] NOT NULL, -- Đổi freelanceID
    CONSTRAINT [PK_Experience] PRIMARY KEY CLUSTERED ([experienceID] ASC),
    CONSTRAINT [FK_Experience_Freelancer] FOREIGN KEY ([freelancerID]) REFERENCES [Freelancer]([freelancerID])
);
GO

CREATE TABLE [Post] (
    [postID] [int] IDENTITY(1,1) NOT NULL,
    [title] [nvarchar](220) NULL, -- Tăng độ dài title
    [image] [nvarchar](220) NULL,
    [jobTypeID] [int] NOT NULL, -- Đổi job_type_ID
    [durationID] [int] NOT NULL,
    [date_post] [datetime] NOT NULL DEFAULT GETDATE(), -- Dùng datetime và default
    [expired_date] [datetime] NULL, -- Đổi tên expired
    [quantity] [int] NOT NULL,
    [description] [nvarchar](max) NULL,
    [budget_min] [decimal](18,2) NULL, -- Tách budget thành min/max hoặc range
    [budget_max] [decimal](18,2) NULL,
    [budget_type] [nvarchar](20) NULL, -- 'Fixed', 'Hourly', 'Range'
    [location] [nvarchar](255) NULL, -- Tăng độ dài location
    [recruiterID] [int] NOT NULL,
    [statusPost] [nvarchar](20) NOT NULL DEFAULT 'Pending', -- 'Pending', 'Approved', 'Rejected', 'Expired', 'Closed', 'Draft'
    [categoryID] [int] NOT NULL, -- Đổi caID
    [approvedByAdminID] [int] NULL,
    CONSTRAINT [PK_Post] PRIMARY KEY CLUSTERED ([postID] ASC),
    CONSTRAINT [FK_Post_JobType] FOREIGN KEY ([jobTypeID]) REFERENCES [JobType]([jobTypeID]),
    CONSTRAINT [FK_Post_Duration] FOREIGN KEY ([durationID]) REFERENCES [Duration]([durationID]),
    CONSTRAINT [FK_Post_Recruiter] FOREIGN KEY ([recruiterID]) REFERENCES [Recruiter]([recruiterID]),
    CONSTRAINT [FK_Post_Categories] FOREIGN KEY ([categoryID]) REFERENCES [Categories]([categoryID]),
    CONSTRAINT [FK_Post_AdminApprovedBy] FOREIGN KEY ([approvedByAdminID]) REFERENCES [Admin]([adminID]),
    CONSTRAINT [CK_Post_Status] CHECK ([statusPost] IN ('Pending', 'Approved', 'Rejected', 'Expired', 'Closed', 'Draft', 'Paused'))
);
GO

-- Bảng liên kết Post và Skill_Set (Many-to-Many)
CREATE TABLE [Post_Skills] (
    [postID] [int] NOT NULL,
    [skill_set_ID] [int] NOT NULL,
    CONSTRAINT [PK_Post_Skills] PRIMARY KEY CLUSTERED ([postID] ASC, [skill_set_ID] ASC),
    CONSTRAINT [FK_Post_Skills_Post] FOREIGN KEY ([postID]) REFERENCES [Post]([postID]) ON DELETE CASCADE,
    CONSTRAINT [FK_Post_Skills_Skill_Set] FOREIGN KEY ([skill_set_ID]) REFERENCES [Skill_Set]([skill_set_ID]) ON DELETE CASCADE
);
GO

CREATE TABLE [Mark] (
    [MarkID] [int] IDENTITY(1,1) NOT NULL,
    [recruiterID] [int] NULL,
    [freelancerID] [int] NULL,
    [markedDate] [datetime] NOT NULL DEFAULT GETDATE(),
    CONSTRAINT [PK_Mark] PRIMARY KEY CLUSTERED ([MarkID] ASC),
    CONSTRAINT [FK_Mark_Recruiter] FOREIGN KEY ([recruiterID]) REFERENCES [Recruiter]([recruiterID]),
    CONSTRAINT [FK_Mark_Freelancer] FOREIGN KEY ([freelancerID]) REFERENCES [Freelancer]([freelancerID]),
    CONSTRAINT [UQ_Mark_Recruiter_Freelancer] UNIQUE ([recruiterID], [freelancerID]) -- Nếu muốn mỗi cặp là duy nhất
);
GO

CREATE TABLE [Skills] ( -- Kỹ năng của Freelancer
    [skillID] [int] IDENTITY(1,1) NOT NULL,
    [skill_set_ID] [int] NOT NULL,
    [freelancerID] [int] NOT NULL, -- Đổi freelancerID
    [level] [tinyint] NULL, -- Ví dụ 1-5 hoặc %
    CONSTRAINT [PK_Skills] PRIMARY KEY CLUSTERED ([skillID] ASC),
    CONSTRAINT [UQ_Skills_SkillSetID_FreelancerID] UNIQUE NONCLUSTERED ([skill_set_ID] ASC, [freelancerID] ASC),
    CONSTRAINT [FK_Skills_SkillSet] FOREIGN KEY ([skill_set_ID]) REFERENCES [Skill_Set]([skill_set_ID]),
    CONSTRAINT [FK_Skills_Freelancer] FOREIGN KEY ([freelancerID]) REFERENCES [Freelancer]([freelancerID])
);
GO

CREATE TABLE [JobApply] (
    [applyID] [int] IDENTITY(1,1) NOT NULL,
    [freelancerID] [int] NOT NULL, -- Đổi freelanceID
    [postID] [int] NOT NULL,
    [statusApply] [nvarchar](50) NOT NULL DEFAULT 'Pending', -- 'Pending', 'Viewed', 'Shortlisted', 'Interviewing', 'Offered', 'Hired', 'Rejected', 'Withdrawn'
    [dateApply] [datetime] NOT NULL DEFAULT GETDATE(),
    [coverLetter] [nvarchar](max) NULL, -- Thêm cover letter
    [resumePath] [nvarchar](500) NULL, -- Đổi tên Resume thành resumePath
    CONSTRAINT [PK_JobApply] PRIMARY KEY CLUSTERED ([applyID] ASC),
    CONSTRAINT [UQ_JobApply_FreelancerID_PostID] UNIQUE NONCLUSTERED ([freelancerID] ASC, [postID] ASC), -- Mỗi freelancer chỉ apply 1 lần/post
    CONSTRAINT [FK_JobApply_Freelancer] FOREIGN KEY ([freelancerID]) REFERENCES [Freelancer]([freelancerID]),
    CONSTRAINT [FK_JobApply_Post] FOREIGN KEY ([postID]) REFERENCES [Post]([postID])
);
GO

CREATE TABLE [FreelancerFavorites] ( -- Bài đăng Freelancer yêu thích
    [favoritesID] [int] IDENTITY(1,1) NOT NULL,
    [freelancerID] [int] NOT NULL, -- Đổi freelanceID
    [postID] [int] NOT NULL,
    [favoritedDate] [datetime] NOT NULL DEFAULT GETDATE(),
    CONSTRAINT [PK_FreelancerFavorites] PRIMARY KEY CLUSTERED ([favoritesID] ASC),
    CONSTRAINT [UQ_FreelancerFavorites_FreelancerID_PostID] UNIQUE NONCLUSTERED ([freelancerID] ASC, [postID] ASC),
    CONSTRAINT [FK_FreelancerFavorites_Freelancer] FOREIGN KEY ([freelancerID]) REFERENCES [Freelancer]([freelancerID]),
    CONSTRAINT [FK_FreelancerFavorites_Post] FOREIGN KEY ([postID]) REFERENCES [Post]([postID])
);
GO



CREATE TABLE [Report] (
    [reportID] [int] IDENTITY(1,1) NOT NULL,
    [reporter_freelancerID] [int] NOT NULL, -- Đổi freelanceID
    [reported_postID] [int] NOT NULL,
    [dateReport] [datetime] NOT NULL DEFAULT GETDATE(),
    [message] [nvarchar](max) NULL,
    [handledByAdminID] [int] NULL,
    [handlingStatus] [nvarchar](50) NULL DEFAULT 'Pending', -- 'Pending', 'Investigating', 'Resolved_ActionTaken', 'Resolved_NoAction'
    [adminNotes] [nvarchar](max) NULL, -- Ghi chú của Admin khi xử lý
    CONSTRAINT [PK_Report] PRIMARY KEY CLUSTERED ([ReportID] ASC),
    CONSTRAINT [FK_Report_Freelancer] FOREIGN KEY ([reporter_freelancerID]) REFERENCES [Freelancer]([freelancerID]),
    CONSTRAINT [FK_Report_Post] FOREIGN KEY ([reported_postID]) REFERENCES [Post]([postID]),
    CONSTRAINT [FK_Report_AdminHandledBy] FOREIGN KEY ([handledByAdminID]) REFERENCES [Admin]([adminID])
);
GO

CREATE TABLE [RecruiterTransaction] (
    [transactionID] [int] IDENTITY(1,1) NOT NULL,
    [recruiterID] [int] NOT NULL,
    [transactionType] [nvarchar](50) NOT NULL, -- 'Deposit', 'PostPayment', 'Refund', 'TierSubscription'
    [amount] [decimal](18, 2) NOT NULL,
    [transactionDate] [datetime] NOT NULL DEFAULT SYSUTCDATETIME(),
    [description] [nvarchar](max) NULL,
    [statusTransaction] [nvarchar](50) NOT NULL DEFAULT 'Completed', -- 'Completed', 'Pending', 'Failed', 'Refunded'
    [relatedPostID] [int] NULL,
    [relatedTierSubscriptionID] [int] NULL, -- Thêm liên kết đến gói đăng ký
    CONSTRAINT [PK_RecruiterTransaction] PRIMARY KEY CLUSTERED ([transactionID] ASC),
    CONSTRAINT [FK_RecruiterTransaction_Recruiter] FOREIGN KEY ([recruiterID]) REFERENCES [Recruiter]([recruiterID]),
    CONSTRAINT [FK_RecruiterTransaction_Post] FOREIGN KEY ([relatedPostID]) REFERENCES [Post]([postID])
    -- FK đến UserTierSubscriptions sẽ được thêm sau khi bảng đó được tạo
);
GO

-- Bảng quản lý gói dịch vụ / cấp bậc tài khoản
CREATE TABLE [AccountTiers] (
    [tierID] [int] IDENTITY(1,1) NOT NULL,
    [tierName] [nvarchar](100) NOT NULL,
    [description] [nvarchar](max) NULL,
    [userTypeScope] [nvarchar](20) NOT NULL,
    [price] [decimal](18, 2) NOT NULL DEFAULT 0.00,
    [durationDays] [int] NULL, 
    [features] [nvarchar](max) NULL,
    [isActive] [bit] NOT NULL DEFAULT 1,
    [adminID_managed_by] [int] NULL,
	[postlimit] [int] NULL,
    CONSTRAINT [PK_AccountTiers] PRIMARY KEY CLUSTERED ([tierID] ASC),
    CONSTRAINT [FK_AccountTiers_Admin] FOREIGN KEY ([adminID_managed_by]) REFERENCES [Admin]([adminID]),
    CONSTRAINT [CK_AccountTiers_UserTypeScope] CHECK ([userTypeScope] IN ('Recruiter', 'Jobseeker', 'Any'))
);
GO

-- Bảng ghi lại việc người dùng đăng ký gói dịch vụ
CREATE TABLE [UserTierSubscriptions] (
    [subscriptionID] [int] IDENTITY(1,1) NOT NULL,
    [recruiterID] [int] NULL, -- FK đến Recruiter nếu userType là Recruiter
    [freelancerID] [int] NULL, -- FK đến Freelancer nếu userType là Freelancer
    [tierID] [int] NOT NULL,
    [startDate] [datetime] NOT NULL DEFAULT GETDATE(),
    [endDate] [datetime] NULL,
    [transactionID] [int] NULL, -- Liên kết với giao dịch thanh toán
    [isActiveSubscription] [int] NOT NULL DEFAULT 1, -- Trạng thái của gói đăng ký này (có thể hết hạn nhưng vẫn active trong quá khứ)
    CONSTRAINT [PK_UserTierSubscriptions] PRIMARY KEY CLUSTERED ([subscriptionID] ASC),
    CONSTRAINT [FK_UserTierSubscriptions_AccountTiers] FOREIGN KEY ([tierID]) REFERENCES [AccountTiers]([tierID]),
    CONSTRAINT [FK_UserTierSubscriptions_Recruiter] FOREIGN KEY ([recruiterID]) REFERENCES [Recruiter]([recruiterID]),
    CONSTRAINT [FK_UserTierSubscriptions_Freelancer] FOREIGN KEY ([freelancerID]) REFERENCES [Freelancer]([freelancerID]),
    CONSTRAINT [FK_UserTierSubscriptions_RecruiterTransaction] FOREIGN KEY ([transactionID]) REFERENCES [RecruiterTransaction]([transactionID]),
    CONSTRAINT [CK_UserTierSubscriptions_UserLink] CHECK (
        ([recruiterID] IS NOT NULL AND [freelancerID] IS NULL) OR
        ([recruiterID] IS NULL AND [freelancerID] IS NOT NULL)
    ) -- Đảm bảo chỉ một trong recruiterID hoặc freelancerID được set
);
GO

-- Thêm khóa ngoại từ RecruiterTransaction sang UserTierSubscriptions
ALTER TABLE [RecruiterTransaction]
ADD CONSTRAINT [FK_RecruiterTransaction_UserTierSubscription]
FOREIGN KEY ([relatedTierSubscriptionID]) REFERENCES [UserTierSubscriptions]([subscriptionID]);
GO

-- Thêm các bảng được đề xuất khác (Reviews, Notifications) nếu bạn muốn
-- CREATE TABLE [Reviews] ( ... );
-- CREATE TABLE [Notifications] ( ... );
CREATE TABLE [Notifications] (
    [notificationID] [int] IDENTITY(1,1) NOT NULL,

    [recipient_freelancerID] [int] NULL,
    [recipient_recruiterID] [int] NULL,

    -- Notification Content
    [message] [nvarchar](max) NOT NULL,         -- The main content/text of the notification
    [notificationType] [nvarchar](50) NULL,     -- Optional: Helps categorize notifications (e.g., 'ApplicationUpdate', 'PostStatus', 'AdminMessage')

    -- Status
    [isRead] [int] NOT NULL DEFAULT 0,          -- Flag indicating if the recipient has read the notification
    [readDate] [datetime] NULL,                 -- Timestamp of when the notification was marked as read (can be NULL if not read)

    -- Source of Notification / Admin Link
    [createdBy_adminID] [int] NULL,             -- FK to Admin. Indicates if an Admin created or was involved in this notification.
                                                -- This fulfills the "khóa ngoại với Admin" requirement.

    CONSTRAINT [PK_Notifications] PRIMARY KEY CLUSTERED ([notificationID] ASC),

    -- Foreign Keys for Recipients
    CONSTRAINT [FK_Notifications_RecipientFreelancer_Simplified] FOREIGN KEY ([recipient_freelancerID]) REFERENCES [Freelancer]([freelancerID]) ON DELETE CASCADE,
    CONSTRAINT [FK_Notifications_RecipientRecruiter_Simplified] FOREIGN KEY ([recipient_recruiterID]) REFERENCES [Recruiter]([recruiterID]) ON DELETE CASCADE,

    -- Foreign Key for the Admin involved with the notification
    CONSTRAINT [FK_Notifications_CreatedByAdmin_Simplified] FOREIGN KEY ([createdBy_adminID]) REFERENCES [Admin]([adminID]) ON DELETE SET NULL,

    -- Constraint to ensure the notification is targeted to a specific user type.
    CONSTRAINT [CK_Notification_TargetUser_Simplified] CHECK (
        ([recipient_freelancerID] IS NOT NULL AND [recipient_recruiterID] IS NULL) OR
        ([recipient_freelancerID] IS NULL AND [recipient_recruiterID] IS NOT NULL)
    )
);
GO

PRINT 'Highly Simplified Notifications table created successfully.';
GO

CREATE TABLE [FreelancerLocation] (
    [freelancerLocationID] [int] IDENTITY(1,1) NOT NULL,
    [freelancerID] [int] NOT NULL,
    [city] [nvarchar](100) NULL,                      
    [country] [nvarchar](100) NOT NULL,                
    [work_preference] [nvarchar](50) NOT NULL DEFAULT 'Negotiable',
    [location_notes] [nvarchar](500) NULL,           
    CONSTRAINT [PK_FreelancerLocation] PRIMARY KEY CLUSTERED ([freelancerLocationID] ASC),
    CONSTRAINT [FK_FreelancerLocation_Freelancer] FOREIGN KEY ([freelancerID]) REFERENCES [Freelancer]([freelancerID]) ON DELETE CASCADE,
    CONSTRAINT [UQ_FreelancerLocation_FreelancerID] UNIQUE NONCLUSTERED ([freelancerID] ASC) -- Đảm bảo mỗi freelancer chỉ có một mục vị trí
);
GO





-- Thêm CHECK constraint để giới hạn các giá trị cho trường work_preference
ALTER TABLE [FreelancerLocation]
ADD CONSTRAINT [CK_FreelancerLocation_WorkPreference]
CHECK ([work_preference] IN ('Remote', 'On-site', 'Hybrid', 'Negotiable'));
GO

PRINT 'Bang FreelancerLocation (phien ban chi tiet hon mot chut) da duoc tao thanh cong.';
GO

CREATE TABLE [FreelancerTransaction] (
    [transactionID] [int] IDENTITY(1,1) NOT NULL,
    [freelancerID] [int] NOT NULL,
    [transactionType] [nvarchar](50) NOT NULL,
    [amount] [decimal](18, 2) NOT NULL,
    [transactionDate] [datetime] NOT NULL DEFAULT GETDATE(),
    [description] [nvarchar](max) NULL,
    [statusTransaction] [nvarchar](50) NOT NULL DEFAULT 'Pending',
    [relatedPostID] [int] NULL,
    [relatedTierSubscriptionID] [int] NULL,

    CONSTRAINT [PK_FreelancerTransaction] PRIMARY KEY CLUSTERED ([transactionID] ASC),

    -- *** CÁC RÀNG BUỘC QUAN TRỌNG ***

    -- 1. Khóa ngoại đến Freelancer (bạn đã có)
    CONSTRAINT [FK_FreelancerTransaction_Freelancer] FOREIGN KEY ([freelancerID]) REFERENCES [Freelancer]([freelancerID]) ON DELETE CASCADE,

    -- 2. Khóa ngoại đến Post (bị thiếu)
    CONSTRAINT [FK_FreelancerTransaction_Post] FOREIGN KEY ([relatedPostID]) REFERENCES [Post]([postID]) ON DELETE SET NULL,

    -- 3. Khóa ngoại đến UserTierSubscriptions (bị thiếu)
    CONSTRAINT [FK_FreelancerTransaction_UserTierSubscription] FOREIGN KEY ([relatedTierSubscriptionID]) REFERENCES [UserTierSubscriptions]([subscriptionID]) ON DELETE SET NULL,

    
);
GO


PRINT 'Bang [FreelancerTransaction] da duoc tao lai thanh cong voi day du cac rang buoc.';
GO



IF (OBJECT_ID('CK_UserTierSubscriptions_IsActive', 'C') IS NOT NULL)
BEGIN
    ALTER TABLE [UserTierSubscriptions] DROP CONSTRAINT [CK_UserTierSubscriptions_IsActive];
END
GO

-- Thêm constraint mới với các giá trị được phép là 0, 1, 2
ALTER TABLE [UserTierSubscriptions]
ADD CONSTRAINT [CK_UserTierSubscriptions_IsActive]
CHECK ([isActiveSubscription] IN (0, 1, 2));
GO

PRINT 'Constraint [CK_UserTierSubscriptions_IsActive] da duoc cap nhat de chap nhan gia tri 0, 1, 2.';
GO


-- Kiểm tra xem trigger có tồn tại trong cơ sở dữ liệu không
IF OBJECT_ID ('[dbo].[trg_EnsureSingleActiveSubscription]', 'TR') IS NOT NULL
BEGIN
    -- Nếu có, thực hiện lệnh xóa trigger
    DROP TRIGGER [dbo].[trg_EnsureSingleActiveSubscription];
    PRINT 'Trigger [trg_EnsureSingleActiveSubscription] da duoc xoa thanh cong.';
END
ELSE
BEGIN
    -- Nếu không, thông báo rằng trigger không tồn tại
    PRINT 'Trigger [trg_EnsureSingleActiveSubscription] khong ton tai de xoa.';
END
GO


CREATE OR ALTER TRIGGER [dbo].[trg_EnsureSingleActiveSubscription]
ON [dbo].[UserTierSubscriptions]
AFTER UPDATE
AS
BEGIN
    -- Ngăn SQL Server trả về số dòng bị ảnh hưởng
    SET NOCOUNT ON;

    -- Chỉ thực thi logic nếu cột 'isActiveSubscription' được cập nhật
    -- và có ít nhất một dòng được cập nhật thành trạng thái 0 (Hoạt động).
    IF NOT UPDATE(isActiveSubscription) OR NOT EXISTS (SELECT 1 FROM inserted WHERE isActiveSubscription = 0)
    BEGIN
        RETURN;
    END; -- Dấu chấm phẩy có thể đặt ở đây hoặc trước WITH đều được, nhưng đặt trước WITH rõ ràng hơn.

    -- *** SỬA LỖI: Thêm dấu chấm phẩy ở đây ***
    ;WITH NewlyActivatedSubs AS (
        SELECT
            subscriptionID,
            recruiterID,
            freelancerID
        FROM
            inserted -- Bảng ảo chứa các dòng SAU KHI được cập nhật
        WHERE
            isActiveSubscription = 0 -- Trạng thái 0: Hoạt động
    )

    -- Cập nhật các gói đăng ký CŨ đang hoạt động của cùng người dùng thành trạng thái 2 (Không hoạt động)
    UPDATE uts
    SET
        uts.isActiveSubscription = 2 -- Đổi trạng thái thành "2: Không hoạt động"
    FROM
        [dbo].[UserTierSubscriptions] AS uts
    INNER JOIN
        NewlyActivatedSubs AS nas ON
        -- Kết nối dựa trên ID của Recruiter hoặc Freelancer
        (uts.recruiterID IS NOT NULL AND uts.recruiterID = nas.recruiterID)
        OR
        (uts.freelancerID IS NOT NULL AND uts.freelancerID = nas.freelancerID)
    WHERE
        -- Điều kiện để cập nhật:
        -- 1. Gói đăng ký phải đang ở trạng thái 0 (Hoạt động)
        uts.isActiveSubscription = 0
        -- 2. Gói đăng ký này không phải là gói vừa được kích hoạt
        AND uts.subscriptionID <> nas.subscriptionID;
END
GO

PRINT 'Trigger [trg_EnsureSingleActiveSubscription] da duoc tao/cap nhat thanh cong.';
GO

-- Kiểm tra và xóa trigger cũ nếu tồn tại để tạo mới
IF OBJECT_ID ('[dbo].[trg_UpdateRecruiterMoneyOnTransaction]', 'TR') IS NOT NULL
BEGIN
    DROP TRIGGER [dbo].[trg_UpdateRecruiterMoneyOnTransaction];
    PRINT 'Trigger [trg_UpdateRecruiterMoneyOnTransaction] da duoc xoa de tao moi.';
END
GO

CREATE TRIGGER [dbo].[trg_UpdateRecruiterMoneyOnTransaction]
ON [dbo].[RecruiterTransaction]
AFTER INSERT, UPDATE, DELETE -- Kích hoạt trigger khi có hành động Thêm, Sửa, hoặc Xóa
AS
BEGIN
    -- Ngăn SQL Server trả về số dòng bị ảnh hưởng, giúp tăng hiệu năng
    SET NOCOUNT ON;

    -- Bảng tạm để tính toán tổng số tiền thay đổi cho mỗi Recruiter bị ảnh hưởng
    -- Thiết kế này đảm bảo trigger hoạt động đúng ngay cả khi có nhiều giao dịch được thêm/sửa/xóa cùng lúc
    ;WITH BalanceChanges AS (
        -- Xử lý các giao dịch được THÊM MỚI hoặc CẬP NHẬT
        SELECT
            i.recruiterID,
            -- Nếu là 'Deposit' thì cộng tiền, ngược lại thì trừ tiền
            CASE
                WHEN i.transactionType = 'Deposit' THEN i.amount
                ELSE -i.amount
            END AS ChangeAmount
        FROM
            inserted i -- 'inserted' là bảng ảo chứa các dòng vừa được thêm/sửa

        UNION ALL

        -- Xử lý các giao dịch bị XÓA hoặc CẬP NHẬT (phần cũ của dòng được cập nhật)
        SELECT
            d.recruiterID,
            -- Logic ngược lại: Nếu xóa một giao dịch 'Deposit', ta phải TRỪ tiền đi. Nếu xóa một giao dịch trừ tiền, ta phải CỘNG tiền lại.
            CASE
                WHEN d.transactionType = 'Deposit' THEN -d.amount
                ELSE d.amount
            END AS ChangeAmount
        FROM
            deleted d -- 'deleted' là bảng ảo chứa các dòng vừa bị xóa/sửa
    )
    -- Cập nhật bảng Recruiter bằng cách cộng tổng số tiền thay đổi
    UPDATE r
    SET
        r.money = r.money + bc.TotalChange
    FROM
        dbo.Recruiter r
    INNER JOIN (
        -- Gom nhóm các thay đổi theo từng recruiterID để chỉ phải cập nhật mỗi Recruiter một lần duy nhất
        SELECT recruiterID, SUM(ChangeAmount) AS TotalChange
        FROM BalanceChanges
        GROUP BY recruiterID
    ) AS bc ON r.recruiterID = bc.recruiterID;

END
GO

PRINT 'Trigger [trg_UpdateRecruiterMoneyOnTransaction] da duoc tao thanh cong.';
GO


-- Kiểm tra và xóa trigger cũ nếu tồn tại để tạo mới
IF OBJECT_ID ('[dbo].[trg_UpdateFreelancerMoneyOnTransaction]', 'TR') IS NOT NULL
BEGIN
    DROP TRIGGER [dbo].[trg_UpdateFreelancerMoneyOnTransaction];
    PRINT 'Trigger [trg_UpdateFreelancerMoneyOnTransaction] da duoc xoa de tao moi.';
END
GO

CREATE TRIGGER [dbo].[trg_UpdateFreelancerMoneyOnTransaction]
ON [dbo].[FreelancerTransaction]
AFTER INSERT, UPDATE, DELETE -- Kích hoạt trigger khi Thêm, Sửa, hoặc Xóa giao dịch
AS
BEGIN
    -- Ngăn SQL Server trả về số dòng bị ảnh hưởng
    SET NOCOUNT ON;

    -- Bảng tạm để tính toán tổng số tiền thay đổi cho mỗi Freelancer bị ảnh hưởng
    ;WITH BalanceChanges AS (
        -- Xử lý các giao dịch được THÊM MỚI hoặc CẬP NHẬT (phần dữ liệu mới)
        SELECT
            i.freelancerID,
            -- Logic: Cộng tiền nếu là thanh toán, thưởng, hoàn tiền. Trừ tiền cho các trường hợp còn lại.
            CASE
                WHEN i.transactionType IN ('PaymentReceived', 'Bonus', 'Refund') THEN i.amount
                ELSE -i.amount
            END AS ChangeAmount
        FROM
            inserted i

        UNION ALL

        -- Xử lý các giao dịch bị XÓA hoặc CẬP NHẬT (phần dữ liệu cũ)
        SELECT
            d.freelancerID,
            -- Logic ngược lại: Nếu xóa một giao dịch cộng tiền, ta phải TRỪ đi. Nếu xóa một giao dịch trừ tiền, ta phải CỘNG lại.
            CASE
                WHEN d.transactionType IN ('Deposit', 'Bonus', 'Refund') THEN -d.amount
                ELSE d.amount
            END AS ChangeAmount
        FROM
            deleted d
    )
    -- Cập nhật bảng Freelancer bằng cách cộng tổng số tiền thay đổi
    UPDATE f
    SET
        f.money = f.money + bc.TotalChange
    FROM
        dbo.Freelancer f
    INNER JOIN (
        -- Gom nhóm các thay đổi theo từng freelancerID để cập nhật hiệu quả
        SELECT freelancerID, SUM(ChangeAmount) AS TotalChange
        FROM BalanceChanges
        GROUP BY freelancerID
    ) AS bc ON f.freelancerID = bc.freelancerID;

END
GO

PRINT 'Trigger [trg_UpdateFreelancerMoneyOnTransaction] da duoc tao thanh cong.';
GO