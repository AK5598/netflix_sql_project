create database netflix_project;
use netflix_project;

CREATE TABLE titles (
    title_id INT PRIMARY KEY,
    type VARCHAR(50),
    title TEXT,
    director VARCHAR(255),
    cast TEXT,
    country VARCHAR(255),
    date_added DATE,
    release_year YEAR,
    rating VARCHAR(10),
    duration VARCHAR(50),
    listed_in VARCHAR(255),
    description TEXT
);

CREATE TABLE genres (
    genre_id INT AUTO_INCREMENT PRIMARY KEY,
    genre_name VARCHAR(100)
);

CREATE TABLE title_genres (
    title_id INT,
    genre_id INT,
    PRIMARY KEY (title_id, genre_id),
    FOREIGN KEY (title_id) REFERENCES titles(title_id),
    FOREIGN KEY (genre_id) REFERENCES genres(genre_id)
);

CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(255),
    country VARCHAR(100),
    gender VARCHAR(10),
    age INT,
    signup_date DATE
);

CREATE TABLE watch_history (
    watch_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    title_id INT,
    watch_date DATE,
    device_used VARCHAR(100),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (title_id) REFERENCES titles(title_id)
);

CREATE TABLE ratings (
    rating_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    title_id INT,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    rating_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (title_id) REFERENCES titles(title_id)
);