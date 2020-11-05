-- Database used: link_db
-- Tables used: 09_pageviews, 10_20_pageviews, au_activity, clickstream, country_activity, link_count, mobile_count, uk_activity, us_activity, wiki_edits


-- Q1
SELECT * FROM 10_20_pageviews 
ORDER BY views DESC 
LIMIT 10;


--Q2
SELECT 09_pageviews.aritcle AS Article,
09_pageviews.views AS Total_Views,
link_count.links AS Links_Followed,
ROUND(link_count.links/09_pageviews.views*100, 2) AS Clickthrough_Percentage
FROM 09_pageviews
INNER JOIN link_count ON 09_pageviews.aritcle=link_count.article
WHERE 09_pageviews.views > 1000000
ORDER BY Clickthrough_Percentage DESC
LIMIT 10;

--Q3
SELECT * FROM clickstream 
WHERE previous_article='Hotel_California' 
ORDER BY clicks DESC 
LIMIT 10;


--Q4
SELECT us_activity.article AS article_name,
us_activity.views AS united_states_views,
uk_activity.views AS united_kingdom_views,
au_activity.views AS australia_views 
FROM us_activity
INNER JOIN uk_activity ON uk_activity.article=us_activity.article
INNER JOIN au_activity ON au_activity.article=us_activity.article
ORDER BY us_activity.views DESC
LIMIT 25;


--Q5
SELECT
FORMAT_NUMBER(AVG(revision_seconds_to_identity_revert/3600), 0) AS HOURS, 
FORMAT_NUMBER(AVG((revision_seconds_to_identity_revert%3600)/60), 0) AS MINUTES, 
FORMAT_NUMBER(AVG((revision_seconds_to_identity_revert%3600)%60), 0) AS SECONDS
FROM wiki_edits 
WHERE revision_seconds_to_identity_revert > 0;

SELECT 
FORMAT_NUMBER(AVG(views)/30, 0) AS average_views_per_day, 
COUNT(aritcle) AS  total_pages
FROM 09_pageviews;

SELECT 
(AVG(revision_seconds_to_identity_revert)/86400) AS average_days_to_revert
FROM wiki_edits
WHERE revision_seconds_to_identity_revert > 0;

SELECT 
FORMAT_NUMBER(14*(AVG(revision_seconds_to_identity_revert)/86400), 2) 
AS average_page_views_before_revision 
FROM wiki_edits
WHERE revision_seconds_to_identity_revert > 0;


--Q6
SELECT 09_pageviews.aritcle AS Article,
09_pageviews.views AS Total_Views,
ROUND(mobile_views.views/09_pageviews.views*100, 2) AS Mobile_Percentage
FROM 09_pageviews
INNER JOIN mobile_views ON mobile_views.article=09_pageviews.aritcle
WHERE 09_pageviews.views > 1000000
ORDER BY Mobile_Percentage DESC
LIMIT 10;

SELECT 09_pageviews.aritcle AS Article,
09_pageviews.views AS Total_Views,
ROUND(mobile_views.views/09_pageviews.views*100, 2) AS Mobile_Percentage
FROM 09_pageviews
INNER JOIN mobile_views ON mobile_views.article=09_pageviews.aritcle
WHERE 09_pageviews.views > 1000000
ORDER BY Mobile_Percentage ASC
LIMIT 10;


