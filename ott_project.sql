
-- OTT Platform SQL Project
-- Schema and sample data for an OTT (Movie/Streaming) platform

-- DROP TABLES IF EXISTS (for rerun)
DROP TABLE IF EXISTS watch_history;
DROP TABLE IF EXISTS ratings;
DROP TABLE IF EXISTS subscriptions;
DROP TABLE IF EXISTS show_genres;
DROP TABLE IF EXISTS genres;
DROP TABLE IF EXISTS shows;
DROP TABLE IF EXISTS users;

-- USERS
CREATE TABLE users (
    user_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    signup_date DATE,
    city VARCHAR(50),
    country VARCHAR(50)
);

-- SHOWS (movies & series)
CREATE TABLE shows (
    show_id INT PRIMARY KEY,
    title VARCHAR(150),
    type VARCHAR(20), -- Movie or Series
    release_year INT,
    duration_minutes INT -- for movies: total duration, for series: avg episode duration
);

-- GENRES
CREATE TABLE genres (
    genre_id INT PRIMARY KEY,
    genre_name VARCHAR(50)
);

-- SHOW_GENRES (many-to-many)
CREATE TABLE show_genres (
    show_id INT,
    genre_id INT,
    PRIMARY KEY (show_id, genre_id)
);

-- SUBSCRIPTIONS
CREATE TABLE subscriptions (
    subscription_id INT PRIMARY KEY,
    user_id INT,
    plan VARCHAR(50),
    start_date DATE,
    end_date DATE,
    price DECIMAL(8,2)
);

-- WATCH HISTORY (each row = one viewing session)
CREATE TABLE watch_history (
    watch_id INT PRIMARY KEY,
    user_id INT,
    show_id INT,
    watch_date DATE,
    watch_time_minutes INT
);

-- RATINGS
CREATE TABLE ratings (
    rating_id INT PRIMARY KEY,
    user_id INT,
    show_id INT,
    rating INT, -- 1 to 5
    rating_date DATE
);

-- SAMPLE DATA: users
INSERT INTO users VALUES
(1,'Amit Sharma','amit@example.com','2024-01-05','Delhi','India'),
(2,'Riya Patel','riya@example.com','2024-02-10','Mumbai','India'),
(3,'Rahul Verma','rahul@example.com','2024-02-15','Lucknow','India'),
(4,'Sneha Gupta','sneha@example.com','2024-03-12','Pune','India'),
(5,'Karan Singh','karan@example.com','2024-03-20','Noida','India'),
(6,'Priya Rao','priya@example.com','2024-04-02','Bangalore','India'),
(7,'Neha Jain','neha@example.com','2024-04-15','Chennai','India'),
(8,'Vikram Das','vikram@example.com','2024-05-01','Hyderabad','India'),
(9,'Sonal Mehta','sonal@example.com','2024-05-10','Ahmedabad','India'),
(10,'Tarun Kapoor','tarun@example.com','2024-06-01','Kolkata','India');

-- SAMPLE DATA: shows
INSERT INTO shows VALUES
(101,'Galaxy Wars','Movie',2019,142),
(102,'Love & Coffee','Movie',2021,110),
(103,'Detective Lane','Series',2020,45),
(104,'Cooking with Joy','Series',2018,30),
(105,'Mystery Manor','Movie',2022,125),
(106,'Tech Talk','Series',2023,25),
(107,'Journey Home','Movie',2020,135),
(108,'Planet Earth: Redux','Series',2016,50),
(109,'City Lights','Movie',2017,105),
(110,'Future Code','Series',2024,40);

-- SAMPLE DATA: genres
INSERT INTO genres VALUES
(1,'Drama'),
(2,'Action'),
(3,'Romance'),
(4,'Comedy'),
(5,'Documentary'),
(6,'Mystery'),
(7,'Tech'),
(8,'Cooking');

-- SAMPLE DATA: show_genres
INSERT INTO show_genres VALUES
(101,2),(101,1),
(102,3),(102,4),
(103,6),(103,1),
(104,8),(104,4),
(105,6),(105,1),
(106,7),(106,1),
(107,1),(107,2),
(108,5),(108,1),
(109,4),(109,1),
(110,7),(110,2);

-- SAMPLE DATA: subscriptions
INSERT INTO subscriptions VALUES
(201,1,'Premium','2024-01-05','2025-01-04',499.00),
(202,2,'Standard','2024-02-10','2025-02-09',299.00),
(203,3,'Standard','2024-02-15','2024-08-14',299.00),
(204,4,'Basic','2024-03-12','2024-09-11',149.00),
(205,5,'Premium','2024-03-20','2025-03-19',499.00),
(206,6,'Basic','2024-04-02','2025-04-01',149.00),
(207,7,'Standard','2024-04-15','2025-04-14',299.00),
(208,8,'Premium','2024-05-01','2025-04-30',499.00),
(209,9,'Basic','2024-05-10','2025-05-09',149.00),
(210,10,'Standard','2024-06-01','2025-05-31',299.00);

-- SAMPLE DATA: watch_history
INSERT INTO watch_history VALUES
(301,1,101,'2024-01-10',142),
(302,1,103,'2024-01-15',45),
(303,2,102,'2024-02-12',110),
(304,2,104,'2024-02-20',30),
(305,3,103,'2024-02-18',40),
(306,4,105,'2024-03-15',125),
(307,5,107,'2024-03-22',135),
(308,6,106,'2024-04-05',25),
(309,7,104,'2024-04-20',28),
(310,8,108,'2024-05-10',50),
(311,9,109,'2024-05-15',105),
(312,10,110,'2024-06-05',40),
(313,1,102,'2024-06-10',110),
(314,2,101,'2024-06-12',140),
(315,3,105,'2024-06-15',120),
(316,4,103,'2024-06-18',46),
(317,5,102,'2024-06-22',110),
(318,6,107,'2024-07-01',135),
(319,7,110,'2024-07-03',40),
(320,8,101,'2024-07-05',142),
(321,9,106,'2024-07-10',25),
(322,10,108,'2024-07-12',48),
(323,1,108,'2024-07-15',50),
(324,2,105,'2024-07-18',125),
(325,3,109,'2024-07-20',105),
(326,4,110,'2024-07-22',40),
(327,5,103,'2024-07-25',44),
(328,6,104,'2024-07-28',30),
(329,7,101,'2024-07-30',142),
(330,8,102,'2024-08-02',110);

-- SAMPLE DATA: ratings
INSERT INTO ratings VALUES
(401,1,101,5,'2024-01-12'),
(402,1,103,4,'2024-01-16'),
(403,2,102,4,'2024-02-13'),
(404,2,104,3,'2024-02-21'),
(405,3,103,5,'2024-02-20'),
(406,4,105,4,'2024-03-16'),
(407,5,107,5,'2024-03-23'),
(408,6,106,3,'2024-04-06'),
(409,7,104,4,'2024-04-21'),
(410,8,108,5,'2024-05-11'),
(411,9,109,4,'2024-05-16'),
(412,10,110,5,'2024-06-06'),
(413,1,102,4,'2024-06-11'),
(414,2,101,5,'2024-06-13'),
(415,3,105,4,'2024-06-16'),
(416,4,103,4,'2024-06-19'),
(417,5,102,3,'2024-06-23'),
(418,6,107,4,'2024-07-02'),
(419,7,110,4,'2024-07-04'),
(420,8,101,5,'2024-07-06');
