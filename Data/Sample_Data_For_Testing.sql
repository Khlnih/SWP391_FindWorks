-- Sample Data for Testing Job Management Features
-- Run this after creating the main database structure

USE SU25_SWP391_V2;

-- Insert sample data for lookup tables first

-- Insert Categories (if not exists)
IF NOT EXISTS (SELECT 1 FROM Categories WHERE category_name = 'Technology')
BEGIN
    INSERT INTO Categories (category_name, category_img, description, isActive)
    VALUES
    ('Technology', 'https://via.placeholder.com/100x100/3498db/ffffff?text=TECH', 'Software development, IT, programming jobs', 1),
    ('Design & Creative', 'https://via.placeholder.com/100x100/e74c3c/ffffff?text=DESIGN', 'UI/UX design, graphic design, creative roles', 1),
    ('Marketing', 'https://via.placeholder.com/100x100/f39c12/ffffff?text=MKT', 'Digital marketing, content marketing, SEO', 1),
    ('Sales', 'https://via.placeholder.com/100x100/27ae60/ffffff?text=SALES', 'Sales representatives, business development', 1),
    ('Finance', 'https://via.placeholder.com/100x100/9b59b6/ffffff?text=FIN', 'Accounting, financial analysis, banking', 1),
    ('Healthcare', 'https://via.placeholder.com/100x100/1abc9c/ffffff?text=HEALTH', 'Medical, nursing, healthcare administration', 1),
    ('Education', 'https://via.placeholder.com/100x100/34495e/ffffff?text=EDU', 'Teaching, training, educational services', 1),
    ('Other', 'https://via.placeholder.com/100x100/95a5a6/ffffff?text=OTHER', 'Other job categories', 1);
END

-- Insert JobTypes (if not exists)
IF NOT EXISTS (SELECT 1 FROM JobType WHERE job_type_name = 'Full-time')
BEGIN
    INSERT INTO JobType (job_type_name)
    VALUES
    ('Full-time'),
    ('Part-time'),
    ('Contract'),
    ('Freelance'),
    ('Internship'),
    ('Temporary'),
    ('Remote'),
    ('Hybrid');
END

-- Insert Durations (if not exists)
IF NOT EXISTS (SELECT 1 FROM Duration WHERE duration_name = '1-3 months')
BEGIN
    INSERT INTO Duration (duration_name)
    VALUES
    ('1-3 months'),
    ('3-6 months'),
    ('6-12 months'),
    ('1-2 years'),
    ('2+ years'),
    ('Permanent'),
    ('Project-based'),
    ('Ongoing');
END

-- Insert sample recruiters (if not exists)
IF NOT EXISTS (SELECT 1 FROM Recruiter WHERE username = 'recruiter1')
BEGIN
    INSERT INTO Recruiter (username, password, first_name, last_name, gender, dob, money, email_contact, phone_contact, status)
    VALUES ('recruiter1', 'password123', 'John', 'Smith', 1, '1985-05-15', 1000.00, 'john.smith@company.com', '123-456-7890', 'Active');
END

IF NOT EXISTS (SELECT 1 FROM Recruiter WHERE username = 'recruiter2')
BEGIN
    INSERT INTO Recruiter (username, password, first_name, last_name, gender, dob, money, email_contact, phone_contact, status)
    VALUES ('recruiter2', 'password123', 'Sarah', 'Johnson', 0, '1988-08-22', 1500.00, 'sarah.johnson@techcorp.com', '098-765-4321', 'Active');
END

-- Insert sample freelancers (if not exists)
IF NOT EXISTS (SELECT 1 FROM Freelancer WHERE username = 'freelancer1')
BEGIN
    INSERT INTO Freelancer (username, password, first_name, last_name, gender, dob, describe, email_contact, phone_contact, status)
    VALUES ('freelancer1', 'password123', 'Mike', 'Wilson', 1, '1990-03-10', 'Experienced Java developer with 5+ years experience', 'mike.wilson@email.com', '555-123-4567', 'Active');
END

IF NOT EXISTS (SELECT 1 FROM Freelancer WHERE username = 'freelancer2')
BEGIN
    INSERT INTO Freelancer (username, password, first_name, last_name, gender, dob, describe, email_contact, phone_contact, status)
    VALUES ('freelancer2', 'password123', 'Emily', 'Davis', 0, '1992-07-18', 'UI/UX Designer specializing in web and mobile applications', 'emily.davis@email.com', '555-987-6543', 'Active');
END

-- Insert sample job posts
DECLARE @recruiter1_id INT = (SELECT recruiterID FROM Recruiter WHERE username = 'recruiter1');
DECLARE @recruiter2_id INT = (SELECT recruiterID FROM Recruiter WHERE username = 'recruiter2');

-- Job Post 1: Senior Java Developer
INSERT INTO Post (title, image, jobTypeID, durationID, expired_date, quantity, description, budget_min, budget_max, budget_type, location, recruiterID, statusPost, categoryID)
VALUES (
    'Senior Java Developer',
    'https://via.placeholder.com/100x100/3498db/ffffff?text=JAVA',
    1, -- Full-time
    5, -- Permanent
    DATEADD(month, 2, GETDATE()), -- Expires in 2 months
    2, -- 2 positions
    'We are looking for an experienced Senior Java Developer to join our dynamic team. 

Key Responsibilities:
- Design and develop high-quality Java applications
- Collaborate with cross-functional teams to define and implement new features
- Write clean, maintainable, and efficient code
- Participate in code reviews and mentor junior developers
- Troubleshoot and debug applications

Requirements:
- Bachelor''s degree in Computer Science or related field
- 5+ years of experience in Java development
- Strong knowledge of Spring Framework, Hibernate, and RESTful APIs
- Experience with microservices architecture
- Proficiency in SQL and database design
- Excellent problem-solving and communication skills

Benefits:
- Competitive salary and benefits package
- Flexible working hours
- Professional development opportunities
- Health insurance and retirement plans',
    80000.00, -- Min budget
    120000.00, -- Max budget
    'Annual', -- Budget type
    'San Francisco, CA',
    @recruiter1_id,
    'Approved',
    1 -- Technology category
);

-- Job Post 2: UI/UX Designer
INSERT INTO Post (title, image, jobTypeID, durationID, expired_date, quantity, description, budget_min, budget_max, budget_type, location, recruiterID, statusPost, categoryID)
VALUES (
    'UI/UX Designer - Remote',
    'https://via.placeholder.com/100x100/e74c3c/ffffff?text=UX',
    4, -- Freelance
    3, -- 6-12 months
    DATEADD(month, 1, GETDATE()), -- Expires in 1 month
    1, -- 1 position
    'Join our creative team as a UI/UX Designer and help us create amazing user experiences!

What you''ll do:
- Create wireframes, prototypes, and high-fidelity designs
- Conduct user research and usability testing
- Collaborate with developers to ensure design implementation
- Maintain and evolve our design system
- Present design concepts to stakeholders

What we''re looking for:
- 3+ years of UI/UX design experience
- Proficiency in Figma, Sketch, or Adobe Creative Suite
- Strong portfolio showcasing web and mobile designs
- Understanding of responsive design principles
- Experience with user research methodologies
- Excellent communication and presentation skills

This is a remote position with flexible hours. Perfect for someone looking for work-life balance while working on exciting projects!',
    60.00, -- Min budget per hour
    90.00, -- Max budget per hour
    'Hourly', -- Budget type
    'Remote',
    @recruiter2_id,
    'Approved',
    2 -- Design & Creative category
);

-- Job Post 3: Marketing Specialist
INSERT INTO Post (title, image, jobTypeID, durationID, expired_date, quantity, description, budget_min, budget_max, budget_type, location, recruiterID, statusPost, categoryID)
VALUES (
    'Digital Marketing Specialist',
    'https://via.placeholder.com/100x100/f39c12/ffffff?text=MKT',
    2, -- Part-time
    2, -- 3-6 months
    DATEADD(day, 45, GETDATE()), -- Expires in 45 days
    1, -- 1 position
    'We''re seeking a creative Digital Marketing Specialist to help grow our online presence and drive customer engagement.

Responsibilities:
- Develop and execute digital marketing campaigns
- Manage social media accounts and content creation
- Analyze campaign performance and optimize for better results
- Collaborate with the sales team to generate leads
- Create engaging content for various digital platforms

Requirements:
- 2+ years of digital marketing experience
- Knowledge of Google Analytics, Google Ads, and social media platforms
- Experience with email marketing tools
- Strong analytical and creative thinking skills
- Excellent written and verbal communication
- Bachelor''s degree in Marketing or related field preferred

This part-time position offers great flexibility and the opportunity to work with a growing startup!',
    25.00, -- Min budget per hour
    40.00, -- Max budget per hour
    'Hourly', -- Budget type
    'New York, NY (Hybrid)',
    @recruiter1_id,
    'Pending',
    3 -- Marketing category
);

-- Job Post 4: Project Manager
INSERT INTO Post (title, image, jobTypeID, durationID, expired_date, quantity, description, budget_min, budget_max, budget_type, location, recruiterID, statusPost, categoryID)
VALUES (
    'IT Project Manager',
    'https://via.placeholder.com/100x100/9b59b6/ffffff?text=PM',
    1, -- Full-time
    4, -- 1+ years
    DATEADD(month, 3, GETDATE()), -- Expires in 3 months
    1, -- 1 position
    'Lead exciting IT projects from conception to completion as our new IT Project Manager!

Key Responsibilities:
- Plan, execute, and monitor IT projects from start to finish
- Coordinate with cross-functional teams and stakeholders
- Manage project timelines, budgets, and resources
- Identify and mitigate project risks
- Ensure projects are delivered on time and within scope
- Facilitate team meetings and communicate project status

Qualifications:
- Bachelor''s degree in IT, Business, or related field
- 4+ years of project management experience
- PMP or Agile certification preferred
- Strong leadership and communication skills
- Experience with project management tools (Jira, Asana, etc.)
- Knowledge of software development lifecycle

We offer competitive compensation, comprehensive benefits, and opportunities for professional growth in a collaborative environment.',
    70000.00, -- Min budget
    95000.00, -- Max budget
    'Annual', -- Budget type
    'Austin, TX',
    @recruiter2_id,
    'Approved',
    1 -- Technology category
);

-- Job Post 5: Data Analyst (Draft status for testing)
INSERT INTO Post (title, image, jobTypeID, durationID, expired_date, quantity, description, budget_min, budget_max, budget_type, location, recruiterID, statusPost, categoryID)
VALUES (
    'Data Analyst - Entry Level',
    'https://via.placeholder.com/100x100/1abc9c/ffffff?text=DATA',
    5, -- Internship
    1, -- 1-3 months
    DATEADD(month, 1, GETDATE()), -- Expires in 1 month
    3, -- 3 positions
    'Great opportunity for recent graduates to start their career in data analysis!

What you''ll learn:
- Data collection and cleaning techniques
- Statistical analysis and visualization
- Working with SQL databases
- Creating reports and dashboards
- Business intelligence tools

Requirements:
- Recent graduate in Statistics, Mathematics, Computer Science, or related field
- Basic knowledge of SQL and Excel
- Familiarity with Python or R is a plus
- Strong analytical and problem-solving skills
- Attention to detail and accuracy
- Eagerness to learn and grow

This internship provides hands-on experience with real-world data projects and mentorship from senior analysts. Potential for full-time conversion based on performance.',
    15.00, -- Min budget per hour
    25.00, -- Max budget per hour
    'Hourly', -- Budget type
    'Chicago, IL',
    @recruiter1_id,
    'Draft',
    1 -- Technology category
);

-- Insert some sample favorites
DECLARE @freelancer1_id INT = (SELECT freelancerID FROM Freelancer WHERE username = 'freelancer1');
DECLARE @freelancer2_id INT = (SELECT freelancerID FROM Freelancer WHERE username = 'freelancer2');
DECLARE @post1_id INT = (SELECT TOP 1 postID FROM Post WHERE title LIKE '%Java%');
DECLARE @post2_id INT = (SELECT TOP 1 postID FROM Post WHERE title LIKE '%UI/UX%');

IF @freelancer1_id IS NOT NULL AND @post1_id IS NOT NULL
BEGIN
    INSERT INTO FreelancerFavorites (freelancerID, postID, favoritedDate)
    VALUES (@freelancer1_id, @post1_id, GETDATE());
END

IF @freelancer1_id IS NOT NULL AND @post2_id IS NOT NULL
BEGIN
    INSERT INTO FreelancerFavorites (freelancerID, postID, favoritedDate)
    VALUES (@freelancer1_id, @post2_id, DATEADD(hour, -2, GETDATE()));
END

IF @freelancer2_id IS NOT NULL AND @post2_id IS NOT NULL
BEGIN
    INSERT INTO FreelancerFavorites (freelancerID, postID, favoritedDate)
    VALUES (@freelancer2_id, @post2_id, DATEADD(day, -1, GETDATE()));
END

PRINT 'Sample data inserted successfully!';
PRINT 'You can now test the favorite features with:';
PRINT '- Login as recruiter1/password123 or recruiter2/password123 to manage jobs';
PRINT '- Login as freelancer1/password123 or freelancer2/password123 to test favorites';
PRINT '- View, create, edit, and delete job posts';
PRINT '- Add/remove favorites and view favorite list';
