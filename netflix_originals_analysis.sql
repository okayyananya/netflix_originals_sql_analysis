CREATE DATABASE Netflix_Originals;
USE Netflix_Originals;
SELECT * FROM originals_details;

-- 1. What are the average IMDb scores for each genre of Netflix Originals?
SELECT gd.Genre, AVG(od.IMDBScore) AS AverageIMDBScore 
FROM originals_details od
JOIN genre_details gd ON od.GenreID = gd.GenreID
GROUP BY gd.Genre;

-- 2. Which genres have an average IMDb score higher than 7.5?
SELECT gd.Genre, AVG(od.IMDBScore) AS AverageIMDBScore 
FROM originals_details od
JOIN genre_details gd ON od.GenreID = gd.GenreID
GROUP BY gd.Genre
HAVING AverageIMDBScore>7.5;

-- 3. List Netflix Original titles in descending order of their IMDb scores.
SELECT Title, IMDBScore FROM originals_details
ORDER BY IMDBScore DESC;

-- 4. Retrieve the top 10 longest Netflix Originals by runtime.
SELECT Title, Runtime FROM originals_details
ORDER BY Runtime DESC
LIMIT 10;

-- 5. Retrieve the titles of Netflix Originals along with their respective genres.
SELECT od.Title, gd.Genre 
FROM originals_details od
JOIN genre_details gd ON od.GenreID = gd.GenreID;

-- 6. Rank Netflix Originals based on their IMDb scores within each genre.
SELECT gd.Genre, od.Title, od.IMDBScore,
RANK() OVER (PARTITION BY gd.Genre ORDER BY od.IMDBScore DESC) AS RankWithinGenre
FROM originals_details od
JOIN genre_details gd ON od.GenreID = gd.GenreID;

-- 7. Which Netflix Originals have IMDb scores higher than the average IMDb score of all titles?
SELECT AVG(IMDBScore) FROM originals_details;
-- The average score is 6.27
SELECT Title, IMDBScore FROM originals_details
WHERE IMDBScore > (SELECT AVG(IMDBScore) FROM originals_details)
ORDER BY IMDBScore DESC; 

-- 8. How many Netflix Originals are there in each genre?
SELECT gd.Genre, Count(od.Title) AS NetflixOriginals 
FROM originals_details od
JOIN genre_details gd ON od.GenreID = gd.GenreID
GROUP BY gd.Genre
ORDER BY NetflixOriginals DESC;

-- 9. Which genres have more than 5 Netflix Originals with an IMDB score higher than 8?
SELECT gd.Genre, COUNT(od.Title) AS NetflixOriginals
FROM originals_details od
JOIN genre_details gd ON od.GenreID = gd.GenreID
WHERE od.IMDBScore > 8
GROUP BY gd.Genre
HAVING COUNT(od.Title) > 5
ORDER BY NetflixOriginals DESC;

-- 10. What are the top 3 genres with the highest average IMDB scores, and how many Netflix Originals do they have?
SELECT gd.Genre, AVG(od.IMDBScore) AS AverageIMDBScore, COUNT(od.Title) AS NetflixOriginals
FROM originals_details od
JOIN genre_details gd ON od.GenreID = gd.GenreID
GROUP BY gd.Genre
ORDER BY AverageIMDBScore DESC
LIMIT 3;