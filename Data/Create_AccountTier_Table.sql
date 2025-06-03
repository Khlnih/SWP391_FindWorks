-- Create AccountTier table
CREATE TABLE AccountTier (
    tierID INT IDENTITY(1,1) PRIMARY KEY,
    tierName NVARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    durationDays INT NOT NULL,
    description NVARCHAR(500) NULL
);

-- Insert sample data
INSERT INTO AccountTier (tierName, price, durationDays, description)
VALUES 
('Basic', 9.99, 30, 'Basic package with standard features'),
('Premium', 19.99, 90, 'Premium package with advanced features'),
('Enterprise', 49.99, 365, 'Enterprise package with all features');

-- Verify the data
SELECT * FROM AccountTier;
