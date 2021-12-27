-- ***********************
-- Name: Siran Cao
-- ID: 159235209
-- Date: 10/01/2021
-- Purpose: Lab 03 DBS211
-- ***********************
SET AUTOCOMMIT ON;


-- Q1 Solution --

-- L5_MOVIES
CREATE TABLE L5_movies (
m_id    INT NOT NULL,
title   VARCHAR(35) NOT NULL,
release_year    INT NOT NULL,
director    INT NOT NULL,
score   DECIMAL(3,2)    NULL,
PRIMARY KEY (m_id),
CONSTRAINT movies_score_check CHECK (score < 5 AND score > 0)
);

-- L5_ACTORS
CREATE TABLE L5_actors (
a_id        INT         NOT NULL,
first_name  VARCHAR(20) NOT NULL,
last_name   VARCHAR(30) NOT NULL,
PRIMARY KEY (a_id)
);

-- L5_CASTINGS
CREATE TABLE L5_castings (
movie_id    INT NOT NULL,
actor_id    INT NOT NULL,
PRIMARY KEY (movie_id, actor_id),
CONSTRAINT castings_movie_fk FOREIGN KEY (movie_id) REFERENCES L5_movies(m_id) ON DELETE CASCADE,
CONSTRAINT castings_actor_fk FOREIGN KEY (actor_id) REFERENCES L5_actors(a_id) ON DELETE CASCADE
);

--L5_DIRECTORS  
CREATE TABLE L5_directors (
director_id INT NOT NULL,
first_name  VARCHAR(20) NOT NULL,
last_name   VARCHAR(30) NOT NULL,
PRIMARY KEY (director_id)
);


-- Q2 Solution --
ALTER TABLE L5_movies
ADD CONSTRAINT movies_director_fk FOREIGN KEY (director) REFERENCES L5_directors(director_id) ON DELETE SET NULL;


-- Q3 Solution --
ALTER TABLE L5_movies 
ADD CONSTRAINT movies_title_unique UNIQUE (title);


-- Q4 Solution --
INSERT ALL
    INTO L5_directors (director_id, first_name, last_name) VALUES (1010, 'Rob', 'Minkoff')
    INTO L5_directors (director_id, first_name, last_name) VALUES (1020, 'Bill', 'Condon')
    INTO L5_directors (director_id, first_name, last_name) VALUES (1050, 'Josh', 'Cooley')
    INTO L5_directors (director_id, first_name, last_name) VALUES (2010, 'Brad', 'Bird')
    INTO L5_directors (director_id, first_name, last_name) VALUES (3020, 'Lake', 'Bell')
SELECT * FROM dual;

ALTER TABLE L5_movies
DROP CONSTRAINT movies_score_check;

ALTER TABLE L5_movies
ADD CONSTRAINT movies_score_check CHECK (score <= 5 AND score >= 0);

INSERT ALL
    INTO L5_movies (m_id, title, release_year, director, score) VALUES (100, 'The Lion King', 2019, 3020, 3.50)
    INTO L5_movies (m_id, title, release_year, director, score) VALUES (200, 'Beauty and the Beast', 2017, 1050, 4.20)
    INTO L5_movies (m_id, title, release_year, director, score) VALUES (300, 'Toy Story4', 2019, 1020, 4.50)
    INTO L5_movies (m_id, title, release_year, director, score) VALUES (400, 'Mission Impossible', 2018, 2010, 5.00)
    INTO L5_movies (m_id, title, release_year, director, score) VALUES (500, 'The Secret Life of Pets', 2016, 1010, 3.90)
SELECT * FROM dual;


-- Q5 Solution --
DROP TABLE L5_castings;
DROP TABLE L5_movies;
DROP TABLE L5_directors;
DROP TABLE L5_actors;

-- The order of removing tables are important.
-- Because there're mutiple tables linked to another by foreign keys. For example the movies tbale has a foreign key of director which refer to the primary key of director table. 
-- If the director table was removed before movie table, the director column will be affected and cannot be null.
-- To prevent error, we should remove those child tables with foreign keys first and remove parents tables after. Or we can use DROP TABLE <tablename> Cascade Constraints;

