-- Drop user if exists
DROP USER IF EXISTS 'auth_user'@'localhost';

-- Drop database if exists
DROP DATABASE IF EXISTS auth;

-- Create user and database
CREATE USER 'auth_user'@'localhost' IDENTIFIED BY 'Aauth123';

CREATE DATABASE auth;

GRANT ALL PRIVILEGES ON auth.* TO 'auth_user'@'localhost';

-- Swith to the new database
USE auth;

-- Create user table
CREATE TABLE user (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  email VARCHAR(255) NOT NULL UNIQUE,
  password VARCHAR(255) NOT NULL
);

-- Insert sample data
INSERT INTO user (email, password) VALUES ('bob@bobmail.com', 'Admin123')
