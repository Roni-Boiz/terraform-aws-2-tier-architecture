-- Create a database if it doesn't exist
CREATE DATABASE IF NOT EXISTS foodshop;

-- Use the foodshop database
USE foodshop;


-- Create a table to store subscriber emails
CREATE TABLE IF NOT EXISTS subscribers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,
    subscribed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
-- Insert a new subscriber (example, replace with actual email input)
-- INSERT INTO subscribers (email) VALUES ('example@example.com');


-- Create a table to store booking requests
CREATE TABLE IF NOT EXISTS bookings (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    phone VARCHAR(15),
    number_of_persons INT,
    booking_date DATE,
    booking_time TIME,
    special_request TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
-- Insert a new booking request (example, replace with actual values)
-- INSERT INTO bookings (name, email, phone, number_of_persons, booking_date, booking_time, special_request) 
-- VALUES ('John Doe', 'john@example.com', '123-456-7890', 12, '2024-09-30', '17:00:00', 'Window seat preferred');


-- Create a table to store contact messages
CREATE TABLE IF NOT EXISTS contactus (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    phone VARCHAR(15),
    email VARCHAR(255) NOT NULL,
    message TEXT NOT NULL,
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
-- Insert a new contact message (example, replace with actual values)
-- INSERT INTO contactus (name, phone, email, message) 
-- VALUES ('John Doe', '123-456-7890', 'john@example.com', 'Hello, I have a question.');


-- Create a table to store comments
CREATE TABLE IF NOT EXISTS comments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    comment TEXT NOT NULL,
    submitted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
-- Insert a new comment (example, replace with actual values)
-- INSERT INTO comments (name, email, comment) 
-- VALUES ('John Doe', 'john@example.com', 'This is a comment.');
