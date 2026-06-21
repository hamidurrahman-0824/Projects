-- ================================================
-- WORLD DATABASE ANALYSIS
-- Author: Hamidur Rahman Majed
-- Database: MySQL World Sample Database
-- ================================================

USE world;
-- Content of the table
DESCRIBE city;

-- How many countries involved in this table
SELECT COUNT(DISTINCT CountryCode)
FROM city;


-- Top five MOST populated country

SELECT 
	CountryCode,
    SUM(Population) AS TotalPopulation
FROM
	city
GROUP BY CountryCode
ORDER BY SUM(Population) DESC
LIMIT 5;

SELECT
	country.Name,
    sum(city.Population) AS "Total Population"
FROM
	city
JOIN country
ON city.CountryCode = country.Code
GROUP BY country.Name
ORDER BY SUM(city.Population) DESC
LIMIT 5;

-- Top 5 MOST populated city
SELECT
	Name,
    Population
FROM 
	city
ORDER BY 
	Population DESC
LIMIT 5;

-- TOP 5 MOST POPULATED DISTRICT
SELECT
	DISTRICT,
    SUM(Population) as "Total Population"
FROM
	city
GROUP BY District
ORDER BY SUM(Population) DESC
LIMIT 5;

-- 5 Largest countries by surface area with popultaion rank
SELECT
	Name,
    SurfaceArea,
    Population,
    RANK() OVER (ORDER BY SurfaceArea DESC) AS "Area Rank",
    RANK() OVER (ORDER BY Population DESC) AS "Population Rank"
FROM
	country
ORDER BY SurfaceArea DESC
LIMIT 5;

-- Independent year and life expectancy
SELECT
	 Name,
     IndepYear,
     LifeExpectancy
FROM country
ORDER BY LifeExpectancy DESC
LIMIT 10;

-- Suppression and Life Expectancy
SELECT
	 Name,
     IndepYear,
     LifeExpectancy
FROM country
WHERE LifeExpectancy IS NOT NULL
ORDER BY LifeExpectancy ASC
LIMIT 10;

-- GNP and government form

SELECT
	GovernmentForm,
	AVG(GNPOld) AS "Averagae Old GNP",
    AVG(GNP) AS "Average GNP"
FROM country
GROUP BY GovernmentForm
ORDER BY AVG(GNP) DESC
LIMIT 20;


-- Capital city population
SELECT
	country.Name,
    city.Name,
    city.Population
FROM country
JOIN city
ON city.ID = country.Capital
ORDER BY city.Population DESC
LIMIT 10;


-- Number of official language

SELECT
	CountryCode,
	COUNT(*) as "Number of official Language"
FROM
	countrylanguage
WHERE IsOfficial = 'T'

GROUP BY CountryCode;

-- no. of official language and gnp relation
SELECT
	country.Name,
    COUNT(*) AS num_of_official_lang,
    AVG(country.GNP ) as "Average GNP"
FROM country

JOIN countrylanguage
ON countrylanguage.CountryCode = country.Code
WHERE countrylanguage.IsOfficial = 'T'
GROUP BY country.Name
ORDER BY AVG(country.GNP ) DESC;

-- Which continent has the highest average life expectancy

SELECT
	Continent,
    AVG(LifeExpectancy) AS "Average Life Expectancy Rate"
FROM
	country
GROUP BY
	continent
ORDER BY AVG(LifeExpectancy) DESC;

-- Which government form is most common
SELECT 
	GovernmentForm,
    COUNT(*) AS "Frequency"
FROM
	country
GROUP BY
	GovernmentForm
ORDER BY
	COUNT(*) DESC ;

-- Countries with high GNP but low life expectancy

SELECT
    Name,
    GNP,
    LifeExpectancy
FROM country
WHERE GNP > (SELECT AVG(GNP) FROM country)
AND LifeExpectancy < (SELECT AVG(LifeExpectancy) FROM country)
ORDER BY GNP, LifeExpectancy;