CREATE DATABASE tv_platform;
USE tv_platform;

CREATE TABLE channels(
id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(20) NOT NULL,
description TEXT,
logo BLOB,
type ENUM('national', 'news', 'entertainment', 'movies', 'sports', 'kids', 'educational', 'music', 'religious'));

CREATE TABLE shows(
id INT PRIMARY KEY AUTO_INCREMENT,
channel_id INT NOT NULL,
title VARCHAR(250) NOT NULL,
description TEXT,
image BLOB,
type ENUM('show', 'movie', 'series'),
duration INT NOT NULL,
FOREIGN KEY(channel_id) REFERENCES channels(id) ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE schedule(
id INT PRIMARY KEY AUTO_INCREMENT,
channel_id INT NOT NULL,
show_id INT NOT NULL,
start_time DATETIME NOT NULL,
end_time DATETIME NOT NULL,
FOREIGN KEY (channel_id) REFERENCES channels(id) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (show_id) REFERENCES shows(id) ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE hosts(
id INT PRIMARY KEY AUTO_INCREMENT,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50) NOT NULL,
date_of_birth DATE,
gender ENUM('male', 'female'),
nationality VARCHAR(50),
experience INT CHECK (experience >= 0),
is_active BOOLEAN DEFAULT TRUE);

CREATE TABLE show_hosts(
show_id INT NOT NULL,
host_id INT NOT NULL,
PRIMARY KEY (show_id, host_id),
FOREIGN KEY (show_id) REFERENCES shows(id) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (host_id) REFERENCES hosts(id) ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE actors(
id INT PRIMARY KEY AUTO_INCREMENT,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50) NOT NULL,
date_of_birth DATE,
gender ENUM('male', 'female'),
nationality VARCHAR(50),
experience INT CHECK (experience >= 0),
is_active BOOLEAN DEFAULT TRUE);

CREATE TABLE show_actors(
show_id INT NOT NULL,
actor_id INT NOT NULL,
PRIMARY KEY (show_id, actor_id),
FOREIGN KEY (show_id) REFERENCES shows(id) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (actor_id) REFERENCES actors(id) ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE users(
id INT PRIMARY KEY AUTO_INCREMENT,
username VARCHAR(50) NOT NULL UNIQUE,
email VARCHAR(100) NOT NULL UNIQUE,
password VARCHAR(255) NOT NULL,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50) NOT NULL,
created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
last_login DATETIME DEFAULT NULL,
profile_picture BLOB);

CREATE TABLE votes(
id INT PRIMARY KEY AUTO_INCREMENT,
user_id INT NOT NULL,
show_id INT NOT NULL,
rating TINYINT NOT NULL CHECK (rating BETWEEN 1 AND 10),
comment TEXT,
vote_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (show_id) REFERENCES shows(id) ON DELETE CASCADE ON UPDATE CASCADE,
UNIQUE (user_id, show_id));

CREATE TABLE statistics(
id INT PRIMARY KEY AUTO_INCREMENT,
show_id INT NOT NULL,
period ENUM('daily', 'monthly', 'yearly') NOT NULL,
period_start DATE NOT NULL,
average_rating DECIMAL(3,2) NOT NULL,
total_votes INT NOT NULL DEFAULT 0,
created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
FOREIGN KEY (show_id) REFERENCES shows(id) ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE watchlist(
user_id INT NOT NULL,
show_id INT NOT NULL,
added_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
priority ENUM('low', 'medium', 'high') DEFAULT 'medium',
status ENUM('not started', 'in progress', 'completed') DEFAULT 'not started',
PRIMARY KEY (user_id, show_id),
FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (show_id) REFERENCES shows(id) ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE watch_history(
id INT PRIMARY KEY AUTO_INCREMENT,
user_id INT NOT NULL,
show_id INT NOT NULL,
watched_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
duration_watched INT NOT NULL, 
FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (show_id) REFERENCES shows(id) ON DELETE CASCADE ON UPDATE CASCADE);

INSERT INTO channels (name, description, logo, type) VALUES
('bTV', 'Развлекателен канал с обща насоченост', NULL, 'entertainment'),
('Nova', 'Общ канал с развлекателно съдържание', NULL, 'entertainment'),
('BNT1', 'Национален обществен канал', NULL, 'national'),
('Diema', 'Канал за филми и сериали', NULL, 'movies'),
('RING', 'Спортен канал с актуални новини', NULL, 'sports'),
('BabyTV', 'Канал за деца с образователно съдържание', NULL, 'kids'),
('National Geographic', 'Образователни документални филми', NULL, 'educational'),
('Darik Radio', 'Музика и новини', NULL, 'music'),
('HBO', 'Филмов канал с премиум съдържание', NULL, 'movies'),
('Cartoon Network', 'Канал за анимация и детски предавания', NULL, 'kids'),
('CNN', 'Новинарски канал с международни новини', NULL, 'news'),
('Discovery Channel', 'Документални предавания за наука и природа', NULL, 'educational');

INSERT INTO shows (channel_id, title, description, image, type, duration) VALUES
(1, 'Господари на ефира', 'Сатирично предаване с коментар на текущи събития.', NULL, 'show', 60),
(1, 'Смени жената', 'Реалити шоу за двойки, които променят живота си.', NULL, 'show', 45),
(2, 'MasterChef България', 'Кулинарно състезание между любители.', NULL, 'show', 90),
(2, 'Като две капки вода', 'Знаменитости имитират известни изпълнители.', NULL, 'show', 120),
(3, 'По света и у нас', 'Новинарско предаване с актуални новини.', NULL, 'show', 30),
(3, 'Истории без край', 'Драматичен сериал за човешките истории.', NULL, 'series', 60),
(4, 'Като за последно', 'Драматичен филм за семейни отношения.', NULL, 'movie', 110),
(5, 'Спортна треска', 'Седмичен преглед на спортни новини и анализ.', NULL, 'show', 60),
(6, 'Музикално пътешествие', 'Детско музикално предаване с песни и игри.', NULL, 'show', 30),
(7, 'Документални чудеса', 'Документални филми за природата и технологиите.', NULL, 'show', 45),
(8, 'Game of Thrones', 'Епична фентъзи сага.', NULL, 'series', 60),
(9, 'Tom and Jerry', 'Класическа анимация с котка и мишка.', NULL, 'show', 30),
(10, 'World News Tonight', 'Актуални международни новини.', NULL, 'show', 45),
(11, 'MythBusters', 'Научни експерименти и тестове на митове.', NULL, 'show', 50);

INSERT INTO schedule (channel_id, show_id, start_time, end_time) VALUES
(1, 1, '2024-03-24 20:00:00', '2024-03-24 21:00:00'),
(1, 2, '2024-03-24 21:30:00', '2024-03-24 22:15:00'),
(2, 3, '2024-03-24 19:00:00', '2024-03-24 20:30:00'),
(2, 4, '2024-03-24 21:00:00', '2024-03-24 23:00:00'),
(3, 5, '2024-03-24 18:00:00', '2024-03-24 18:30:00'),
(3, 6, '2024-03-24 20:00:00', '2024-03-24 21:00:00'),
(4, 7, '2024-03-24 22:00:00', '2024-03-24 23:50:00'),
(5, 8, '2024-03-24 17:00:00', '2024-03-24 18:00:00'),
(6, 9, '2024-03-24 16:00:00', '2024-03-24 16:30:00'),
(7, 10, '2024-03-24 19:30:00', '2024-03-24 20:15:00'),
(8, 11, '2024-03-25 21:00:00', '2024-03-25 22:00:00'),
(9, 12, '2024-03-25 10:00:00', '2024-03-25 10:30:00'),
(10, 13, '2024-03-25 18:00:00', '2024-03-25 18:45:00'),
(11, 14, '2024-03-25 20:00:00', '2024-03-25 20:50:00');

INSERT INTO hosts (first_name, last_name, date_of_birth, gender, nationality, experience, is_active) VALUES
('Георги', 'Кадурин', '1980-05-12', 'male', 'Българин', 15, TRUE),
('Нели', 'Тодорова', '1985-08-22', 'female', 'Българка', 12, TRUE),
('Иван', 'Звездев', '1975-07-15', 'male', 'Българин', 20, TRUE),
('Мария', 'Игнатова', '1977-02-03', 'female', 'Българка', 18, TRUE),
('Петър', 'Вълчанов', '1982-11-05', 'male', 'Българин', 10, TRUE),
('Никола', 'Тодоров', '1990-07-12', 'male', 'Българин', 5, TRUE),
('Елена', 'Стоянова', '1988-04-23', 'female', 'Българка', 8, TRUE);

INSERT INTO show_hosts (show_id, host_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(8, 1),
(9, 4),
(10, 5),
(13, 6),
(14, 7);


INSERT INTO actors (first_name, last_name, date_of_birth, gender, nationality, experience, is_active) VALUES
('Леонардо', 'Ди Каприо', '1974-11-11', 'male', 'Американец', 30, TRUE),
('Мерил', 'Стрийп', '1949-06-22', 'female', 'Американка', 40, TRUE),
('Крис', 'Хемсуърт', '1983-08-11', 'male', 'Австралиец', 20, TRUE),
('Хелън', 'Мирън', '1945-07-26', 'female', 'Британка', 50, TRUE),
('Иван', 'Андонов', '1968-03-15', 'male', 'Българин', 25, TRUE),
('Мария', 'Бакалова', '1996-06-04', 'female', 'Българка', 7, TRUE),
('Робърт', 'Де Ниро', '1943-08-17', 'male', 'Американец', 50, TRUE),
('Натали', 'Портман', '1981-06-09', 'female', 'Американка', 25, TRUE);

INSERT INTO show_actors (show_id, actor_id) VALUES
(6, 1),
(6, 2),
(7, 3),
(7, 4),
(7, 5),
(7, 6),
(11, 7);

INSERT INTO users (username, email, password, first_name, last_name, created_at, last_login, profile_picture) 
VALUES 
('ivan_p', 'ivan.p@example.com', 'hashedpassword1', 'Иван', 'Петров', '2024-03-21 08:15:00', '2024-03-25 09:30:00', NULL),
('maria_i', 'maria.i@example.com', 'hashedpassword2', 'Мария', 'Иванова', '2024-03-20 14:00:00', '2024-03-25 10:00:00', NULL),
('georgi_d', 'georgi.d@example.com', 'hashedpassword3', 'Георги', 'Димитров', '2024-03-19 16:45:00', '2024-03-24 16:15:00', NULL),
('nikolay_s', 'nikolay.s@example.com', 'hashedpassword4', 'Николай', 'Симеонов', '2024-03-18 11:20:00', '2024-03-23 14:50:00', NULL),
('elena_k', 'elena.k@example.com', 'hashedpassword5', 'Елена', 'Костова', '2024-03-17 19:05:00', '2024-03-22 20:10:00', NULL);

INSERT INTO votes (user_id, show_id, rating, comment) VALUES
(1, 1, 8, 'Много забавно предаване!'),
(2, 2, 7, 'Добро, но може и по-добро.'),
(3, 3, 9, 'Вкусно и интересно!'),
(1, 4, 6, 'Не ми допадна.'),
(2, 5, 7, 'Полезна информация.'),
(3, 6, 9, 'Страхотно изпълнение!'),
(1, 2, 8, 'Хареса ми формата на предаването.'),
(2, 3, 10, 'Невероятно вкусно и вдъхновяващо!'),
(3, 4, 5, 'Не беше толкова интересно, колкото очаквах.'),
(1, 5, 7, 'Добро предаване, но липсва разнообразие.'),
(2, 6, 9, 'Много силно изпълнение, заслужава висока оценка!'),
(3, 1, 7, 'Забавно, но може да се подобри.'),
(1, 3, 9, 'Много ми хареса този епизод!'),
(2, 4, 6, 'Средно, може и по-добре.'),
(3, 5, 8, 'Полезна информация, която ми помогна.'),
(4, 11, 9, 'Фантастична история!'),
(5, 12, 10, 'Любима анимация!');


INSERT INTO statistics (show_id, period, period_start, average_rating, total_votes) VALUES
(1, 'daily', '2024-03-23', 8.00, 1),
(2, 'monthly', '2024-03-01', 7.00, 1),
(3, 'monthly', '2024-03-01', 9.00, 1),
(4, 'yearly', '2024-01-01', 6.00, 1),
(6, 'daily', '2024-03-23', 9.00, 1),
(11, 'monthly', '2024-03-01', 9.00, 1),
(12, 'daily', '2024-03-25', 9.50, 1);

INSERT INTO watchlist (user_id, show_id, priority, status) VALUES
(1, 7, 'high', 'not started'),
(2, 6, 'medium', 'in progress'),
(3, 10, 'high', 'completed');

INSERT INTO watch_history (user_id, show_id, watched_at, duration_watched) VALUES
(1, 7, '2024-03-23 20:00:00', 150),
(2, 6, '2024-03-23 19:00:00', 148),
(3, 10, '2024-03-22 18:00:00', 130);

-- 2. Условие: Изведете предаванията, които имат продължителност над 45 минути и са от тип show.
SELECT title, duration, description, type
FROM shows
WHERE duration>45 AND type='show'
ORDER BY duration; 

-- 3. Условие: Изведете средния рейтинг и общия брой гласове за всяко предаване по тип (show, movie, series).
SELECT show_id, AVG(rating) AS avg_rating, COUNT(id) AS total_votes
FROM votes
GROUP BY show_id
ORDER BY avg_rating DESC;

-- 4. Условие: Изведете списък с предавания и техните водещи, които се излъчват след 20:00 часа.
SELECT s.title AS show_title, CONCAT(h.first_name,' ', h.last_name) AS full_name, sch.start_time
FROM schedule sch
INNER JOIN shows s ON sch.show_id = s.id
INNER JOIN show_hosts sh ON s.id = sh.show_id
INNER JOIN hosts h ON sh.host_id = h.id
WHERE TIME(sch.start_time) >= '20:00:00';

-- 5. Условие: Изведете всички предавания и броя на гласовете, ако има такива.
SELECT s.title AS show_title, COUNT(v.id) AS total_votes
FROM shows s
LEFT OUTER JOIN votes v ON s.id = v.show_id
GROUP BY s.id
ORDER BY total_votes DESC;

-- 6. Условие: Намерете потребителите, които не са гласували за най-високо оцененото предаване.
SELECT username, email
FROM users
WHERE id NOT IN (SELECT user_id FROM votes 
		WHERE show_id = (SELECT show_id FROM statistics ORDER BY average_rating DESC LIMIT 1));

-- 7. Условие: Изведете за всеки канал броя на предаванията и средния рейтинг на предаванията в този канал.
SELECT c.name AS channel_name, COUNT(s.id) AS count_shows, AVG(st.average_rating) AS avg_rating
FROM channels c
JOIN shows s ON c.id = s.channel_id
LEFT JOIN statistics st ON s.id = st.show_id
GROUP BY c.id
ORDER BY avg_rating DESC;

-- 8. Този тригер ще се задейства след вмъкване на нов запис в таблицата votes. Когато се добави нов глас, 
-- тригерът ще актуализира стойността на total_votes и average_rating в таблицата statistics за 
-- съответното предаване.

DELIMITER //

CREATE TRIGGER update_show_statistics_after_vote
AFTER INSERT ON votes
FOR EACH ROW
BEGIN
    DECLARE new_average_rating DECIMAL(3,2);

    SELECT AVG(rating)
    INTO new_average_rating
    FROM votes
    WHERE show_id = NEW.show_id;

    UPDATE statistics
    SET average_rating = new_average_rating
    WHERE show_id = NEW.show_id;

END //

DELIMITER ;

-- Извеждаме статистиката преди намесата на тригера
SELECT show_id, average_rating 
FROM statistics 
WHERE show_id = 1;

-- Добавяме нов vote
INSERT INTO votes (show_id, user_id, rating)
VALUES (1, 5, 4.5);

-- Извеждаме статистиката след тригера
SELECT show_id, average_rating 
FROM statistics 
WHERE show_id = 1;

-- 9. Процедура, която класифицира телевизионни предавания по продължителност в три категории:
	-- Дълго: Продължителност > 60 минути.
	-- Средно: Продължителност > 30 и ≤ 60 минути.
	-- Кратко: Продължителност ≤ 30 минути.

DELIMITER //

CREATE PROCEDURE classifyShows()
BEGIN
    DECLARE finished INT DEFAULT 0;
    DECLARE v_id INT;
    DECLARE v_title VARCHAR(255);
    DECLARE v_duration INT;
    DECLARE v_classification VARCHAR(20);

    DECLARE showCursor CURSOR FOR 
        SELECT id, title, duration FROM shows WHERE type = 'show';

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = 1;
    CREATE TEMPORARY TABLE IF NOT EXISTS temp_show_classification (
        show_id INT,
        title VARCHAR(255),
        duration INT,
        classification VARCHAR(20)
    );

    OPEN showCursor;

    SET finished = 0;

    show_loop: WHILE finished = 0 DO
        FETCH showCursor INTO v_id, v_title, v_duration;

        IF finished = 1 THEN 
            LEAVE show_loop;
        END IF;

        SET v_classification = CASE 
            WHEN v_duration > 60 THEN 'дълго'
            WHEN v_duration > 30 THEN 'средно'
            ELSE 'кратко'
        END;

        INSERT INTO temp_show_classification (show_id, title, duration, classification)
        VALUES (v_id, v_title, v_duration, v_classification);
    END WHILE;
    
    CLOSE showCursor;

    SELECT * FROM temp_show_classification;
    DROP TEMPORARY TABLE temp_show_classification;
END //

DELIMITER ;

CALL classifyShows();