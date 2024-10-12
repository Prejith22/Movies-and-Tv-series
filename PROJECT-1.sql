-- What were the top 10 Movies according to IMDB score?
SELECT title, type,imdb
FROM MOVIES_SHOWS
WHERE imdb >= 8.0
AND type = 'MOVIE'
ORDER BY imdb DESC
LIMIT 10;

-- What were the top 10 TV Series according to IMDB score? 
SELECT title, 
type, imdb
FROM MOVIES_SHOWS
WHERE imdb_score >= 8.0
AND type = 'TV Series'
ORDER BY imdb_score DESC
LIMIT 10;

-- What were the bottom 10 Movies according to IMDB score?
 SELECT title, 
type, imdb
FROM MOVIES_SHOWS
WHERE type = 'MOVIE'
ORDER BY imdb ASC
LIMIT 10;

-- What were the bottom 10 TV Series according to IMDB score? 
SELECT title, 
type, imdb
FROM MOVIES_SHOWS
WHERE type = 'TV Series'
ORDER BY imdb ASC
LIMIT 10;

-- What were the average IMDB scores for TV Series and Movies? 
SELECT DISTINCT type, 
ROUND(AVG(imdb),2) AS avg_imdb_score
FROM MOVIES_SHOWS
GROUP BY type ;

-- Count of Movies and TV Series in each decade
SELECT CONCAT(FLOOR(year / 10) * 10, 's') AS decade,
COUNT(*) AS movies_shows_count
FROM MOVIES_SHOWS
WHERE year > 1980
GROUP BY CONCAT(FLOOR(year / 10) * 10, 's')
ORDER BY decade;

-- What were the average IMDB for each age certification for TV Series and Movies?
SELECT DISTINCT certification, 
ROUND(AVG(imdb),2) AS avg_imdb_score
FROM MOVIES_SHOWS
GROUP BY certification
ORDER BY avg_imdb_score DESC;

-- What were the 3 most common age certifications for Movies?
SELECT certification, 
COUNT(*) AS certification_count
FROM MOVIES_SHOWS
WHERE type = 'Movie' 
AND certification != 'N/A'
GROUP BY certification
ORDER BY certification_count DESC
LIMIT 3;

-- What were the 3 most common age certifications for TV Series?
SELECT certification, 
COUNT(*) AS certification_count
FROM MOVIES_SHOWS
WHERE type = 'TV Series' 
AND certification != 'N/A'
GROUP BY certification
ORDER BY certification_count DESC
LIMIT 3;

-- Which shows have the most episodes?
SELECT title, 
SUM(episodes) AS total_seasons
FROM MOVIES_SHOWS
WHERE type = 'TV Series'
GROUP BY title
ORDER BY total_seasons DESC
LIMIT 10;

-- Which genres had the most Movies? 
SELECT genres, 
COUNT(*) AS title_count
FROM MOVIES_SHOWS
WHERE type = 'Movie'
GROUP BY genres
ORDER BY title_count DESC
LIMIT 10;

-- Which genres had the most TV Series? 
SELECT genres, 
COUNT(*) AS title_count
FROM MOVIES_SHOWS
WHERE type = 'TV Series'
GROUP BY genres
ORDER BY title_count DESC
LIMIT 10;

-- Who were the top 5 actors that appeared the most in Movies/TV Series? 
SELECT DISTINCT Actors , 
COUNT(*) AS number_of_appearences 
FROM caste
GROUP BY Actors
ORDER BY number_of_appearences DESC
LIMIT 5;

-- Who were the top 3 directors that directed the most Movies/TV Series? 
SELECT DISTINCT DIRECTOR as DIRECTOR, 
COUNT(*) AS number_of_appearences 
FROM caste
GROUP BY DIRECTOR
ORDER BY number_of_appearences DESC
LIMIT 3;

-- Finding the titles and  directors of Movies released on or after 2010?
SELECT DISTINCT t.title, c.director AS director, year
FROM MOVIES_SHOWS AS t
JOIN caste AS c 
ON t.id = c.id
WHERE t.type = 'Movie' 
AND t.year >= 2010 
ORDER BY year DESC;

-- What were the total number of titles for each year? 
SELECT year AS RELEASE_YEAR, 
COUNT(*) AS title_count
FROM MOVIES_SHOWS
GROUP BY year
ORDER BY year DESC;

-- Titles and Directors of Movies with high IMDB scores (>7.5) ?
SELECT t.title, 
c.director AS director,
T.IMDB AS IMDB
FROM MOVIES_SHOWS AS t
JOIN caste AS c 
ON t.id = c.id
WHERE t.type = 'Movie' 
AND t.imdb > 7.5 ;

-- Actors who have starred in the most highly rated Movies or TV Series?
SELECT c.ACTOR AS actor, 
COUNT(*) AS num_highly_rated_titles
FROM MOVIES_SHOWS AS c
JOIN caste AS t 
ON c.id = t.id
WHERE 
(t.type = 'Movie' OR t.type = 'Show')
AND t.imdb_score > 8.0
GROUP BY c.ACTOR
ORDER BY num_highly_rated_titles DESC;

-- Which actors played the same character in multiple Movies or TV Series? 
SELECT t.actorS AS Actor, 
COUNT(DISTINCT C.title) AS num_titles
FROM MOVIES_SHOWS AS c
JOIN caste AS t 
ON c.id = t.id
GROUP BY T.actors
HAVING COUNT(DISTINCT C.title) > 1;

-- Average IMDB score for leading actors/actresses in Movies or TV Series? 
SELECT T.Actors AS Actor, 
ROUND(AVG(C.imdb),2) AS average_imdb_score
FROM MOVIES_SHOWS AS c
JOIN caste AS t 
ON c.id = t.id
where C.IMDB>9
GROUP BY  T.Actors
ORDER BY average_imdb_score DESC;

-- Average IMDB score for leading Actresses in Movies or TV Series? 
SELECT T.Actresses AS Actresses, 
ROUND(AVG(C.imdb),2) AS average_imdb_score
FROM MOVIES_SHOWS AS c
JOIN caste AS t 
ON c.id = t.id
where C.IMDB>9
GROUP BY  T.Actresses
ORDER BY average_imdb_score DESC;

-- WWhat were the leading Production Country in Movies AND TV Series?
SELECT T.Production_Country AS Production_Country, 
COUNT(T.Production_Country) AS num_Production_Country
FROM caste AS t
GROUP BY  T.Production_Country
having  num_Production_Country>=2
ORDER BY T.Production_Country DESC;

-- What Were the production country of Top Movies and Tv Seies according to imdb Scores?
 SELECT C.title AS TITTLE, 
T.Production_Country AS Production_Country,
c.imdb as IMDB
FROM MOVIES_SHOWS AS c
JOIN caste AS t 
ON c.id = t.id
where C.IMDB>8 and c.TYPE = 'Movie'
ORDER BY C.IMDB DESC;

-- What Were the production country of Tv Seies according to imdb Scores?
 SELECT C.title AS TITTLE, 
T.Production_Country AS Production_Country,
c.imdb as IMDB
FROM MOVIES_SHOWS AS c
JOIN caste AS t 
ON c.id = t.id
where c.TYPE = 'TV Series'
ORDER BY C.IMDB DESC;