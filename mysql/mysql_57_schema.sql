CREATE DATABASE IF NOT EXISTS notejam;

USE notejam;

CREATE TABLE IF NOT EXISTS user (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(75) NOT NULL,
    password VARCHAR(128) NOT NULL
);

CREATE TABLE IF NOT EXISTS pad (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    user_id INT NOT NULL REFERENCES users(id)
);

CREATE TABLE IF NOT EXISTS note (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    pad_id INT REFERENCES pad(id),
    user_id INT NOT NULL REFERENCES users(id),
    name VARCHAR(100) NOT NULL,
    text text NOT NULL,
    created_at DATETIME NOT NULL,
    updated_at DATETIME NOT NULL
);
