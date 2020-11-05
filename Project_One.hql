-- Database used: link_db
-- Tables used: 09_pageviews, 10_20_pageviews, au_activity, clickstream, link_count, mobile_count, uk_activity, us_activity, wiki_edits
-- 09_pageviews contains all pageviews for September 2020 as 2 columns: aritcle(typo during table set up) and views
-- 10_20_pageviews contains all pageviews for October 20, 2020 as two columns: article and views
-- au_activity contains pageview data for daytime hours of Australia 10/20/2020 (9:00 - 21:00 AEDT) as 2 columns: article, views
-- clickstream contains the wiki clickstream data from September 2020 as 4 columns: previous article, current article, link_type, clicks
-- link_count contains the number of internal links followed from a given page for September 2020 as 2 columns: article, links
-- mobile_count contians pageviews for mobile user in September 2020 as 2 columns: article, views
-- uk_activity contains pageview data for daytime hours of the UK on 10/20/2020 (8:00 - 20:00 GMT) as 2 columns: article, views
-- us_activity contains pageview data for daytime hours of the US on 10/20/2020 (10:00 - 22:00 EST) as 2 columns: article, views
-- wiki_edits contains edit data from September 2020 stored as 70 columns, though the only column of interest for these queries is: revision_seconds_to_identity_revert


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


