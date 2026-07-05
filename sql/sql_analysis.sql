-- Content per year: Movies vs TV Shows
SELECT
    release_year,
    SUM(CASE WHEN type = 'MOVIE' THEN 1 ELSE 0 END) AS movies,
    SUM(CASE WHEN type = 'SHOW' THEN 1 ELSE 0 END) AS shows
FROM titles_netflix
GROUP BY release_year
ORDER BY release_year;

-- Top 10 countries
WITH RECURSIVE numbers AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1
    FROM numbers
    WHERE n < 20
)
SELECT
    TRIM(BOTH ' ' FROM
        REPLACE(
            REPLACE(
                SUBSTRING_INDEX(
                    SUBSTRING_INDEX(production_countries, ',', n),
                    ',', -1
                ),
            '[',''),
        ']','')
    ) AS country,
    COUNT(*) AS total_titles
FROM titles_netflix
JOIN numbers
ON n <= 1 + LENGTH(production_countries)
        - LENGTH(REPLACE(production_countries, ',', ''))
WHERE production_countries IS NOT NULL
AND production_countries <> '[]'
GROUP BY country
ORDER BY total_titles DESC
LIMIT 10;

-- Movies vs TV Shows split
SELECT
    type,
    COUNT(*) AS total_titles,
    ROUND(
        100 * COUNT(*) / (SELECT COUNT(*) FROM titles_netflix),
        2
    ) AS percentage
FROM titles_netflix
GROUP BY type;

-- Top genres
WITH RECURSIVE numbers AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1
    FROM numbers
    WHERE n < 20
)
SELECT
    TRIM(BOTH ' ' FROM
        REPLACE(
            REPLACE(
                SUBSTRING_INDEX(
                    SUBSTRING_INDEX(genres, ',', n),
                    ',', -1
                ),
            '[',''),
        ']','')
    ) AS genre,
    COUNT(*) AS total_titles
FROM titles_netflix
JOIN numbers
ON n <= 1 + LENGTH(genres)
        - LENGTH(REPLACE(genres, ',', ''))
WHERE genres IS NOT NULL
AND genres <> '[]'
GROUP BY genre
ORDER BY total_titles DESC
LIMIT 10;

-- Movie runtime buckets
SELECT
    CASE
        WHEN runtime < 60 THEN 'Under 60 min'
        WHEN runtime BETWEEN 60 AND 90 THEN '60-90 min'
        WHEN runtime BETWEEN 91 AND 120 THEN '91-120 min'
        WHEN runtime BETWEEN 121 AND 150 THEN '121-150 min'
        ELSE 'Over 150 min'
    END AS runtime_bucket,
    COUNT(*) AS total_movies
FROM titles_netflix
WHERE type = 'MOVIE'
AND runtime > 0
GROUP BY runtime_bucket
ORDER BY total_movies DESC;

-- TV show seasons distribution
SELECT
    seasons,
    COUNT(*) AS total_shows
FROM titles_netflix
WHERE type = 'SHOW'
AND seasons > 0
GROUP BY seasons
ORDER BY seasons;

-- Content rating distribution
SELECT
    COALESCE(age_certification, 'Not Rated') AS age_certification,
    COUNT(*) AS total_titles
FROM titles_netflix
GROUP BY age_certification
ORDER BY total_titles DESC;

-- Top directors
SELECT
    name,
    COUNT(DISTINCT id) AS total_titles
FROM credits_netflix
WHERE UPPER(role) = 'DIRECTOR'
GROUP BY name
ORDER BY total_titles DESC
LIMIT 10;

-- Top actors
SELECT
    name,
    COUNT(DISTINCT id) AS total_appearances
FROM credits_netflix
WHERE UPPER(role) = 'ACTOR'
GROUP BY name
ORDER BY total_appearances DESC
LIMIT 10;

-- TV-MA share
SELECT
    ROUND(
        100 * SUM(CASE WHEN age_certification = 'TV-MA' THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS tv_ma_percentage
FROM titles_netflix;

-- Peak content addition year
SELECT
    release_year,
    COUNT(*) AS total_titles
FROM titles_netflix
GROUP BY release_year
ORDER BY total_titles DESC
LIMIT 5;