-- Enhanced queries including JOIN operations
-- Original 43 ClickBench queries PLUS additional JOIN queries

-- ====== ORIGINAL CLICKBENCH QUERIES (1-43) ======
SELECT COUNT(*) FROM hits;
SELECT COUNT(*) FROM hits WHERE AdvEngineID <> 0;
SELECT SUM(AdvEngineID), COUNT(*), AVG(ResolutionWidth) FROM hits;
SELECT AVG(UserID) FROM hits;
SELECT COUNT(DISTINCT UserID) FROM hits;
SELECT COUNT(DISTINCT SearchPhrase) FROM hits;
SELECT MIN(EventDate), MAX(EventDate) FROM hits;
SELECT AdvEngineID, COUNT(*) FROM hits WHERE AdvEngineID <> 0 GROUP BY AdvEngineID ORDER BY COUNT(*) DESC;
SELECT RegionID, COUNT(DISTINCT UserID) AS u FROM hits GROUP BY RegionID ORDER BY u DESC LIMIT 10;
SELECT RegionID, SUM(AdvEngineID), COUNT(*) AS c, AVG(ResolutionWidth), COUNT(DISTINCT UserID) FROM hits GROUP BY RegionID ORDER BY c DESC LIMIT 10;
SELECT MobilePhoneModel, COUNT(DISTINCT UserID) AS u FROM hits WHERE MobilePhoneModel <> '' GROUP BY MobilePhoneModel ORDER BY u DESC LIMIT 10;
SELECT MobilePhone, MobilePhoneModel, COUNT(DISTINCT UserID) AS u FROM hits WHERE MobilePhoneModel <> '' GROUP BY MobilePhone, MobilePhoneModel ORDER BY u DESC LIMIT 10;
SELECT SearchPhrase, COUNT(*) AS c FROM hits WHERE SearchPhrase <> '' GROUP BY SearchPhrase ORDER BY c DESC LIMIT 10;
SELECT SearchPhrase, COUNT(DISTINCT UserID) AS u FROM hits WHERE SearchPhrase <> '' GROUP BY SearchPhrase ORDER BY u DESC LIMIT 10;
SELECT SearchEngineID, SearchPhrase, COUNT(*) AS c FROM hits WHERE SearchPhrase <> '' GROUP BY SearchEngineID, SearchPhrase ORDER BY c DESC LIMIT 10;
SELECT UserID, COUNT(*) FROM hits GROUP BY UserID ORDER BY COUNT(*) DESC LIMIT 10;
SELECT UserID, SearchPhrase, COUNT(*) FROM hits GROUP BY UserID, SearchPhrase ORDER BY COUNT(*) DESC LIMIT 10;
SELECT UserID, SearchPhrase, COUNT(*) FROM hits GROUP BY UserID, SearchPhrase LIMIT 10;
SELECT UserID, extract(minute FROM EventTime) AS m, SearchPhrase, COUNT(*) FROM hits GROUP BY UserID, m, SearchPhrase ORDER BY COUNT(*) DESC LIMIT 10;
SELECT UserID FROM hits WHERE UserID = 435090932899640449;
SELECT COUNT(*) FROM hits WHERE URL LIKE '%google%';
SELECT SearchPhrase, MIN(URL), COUNT(*) AS c FROM hits WHERE URL LIKE '%google%' AND SearchPhrase <> '' GROUP BY SearchPhrase ORDER BY c DESC LIMIT 10;
SELECT SearchPhrase, MIN(URL), MIN(Title), COUNT(*) AS c, COUNT(DISTINCT UserID) FROM hits WHERE Title LIKE '%Google%' AND URL NOT LIKE '%.google.%' AND SearchPhrase <> '' GROUP BY SearchPhrase ORDER BY c DESC LIMIT 10;
SELECT * FROM hits WHERE URL LIKE '%google%' ORDER BY EventTime LIMIT 10;
SELECT SearchPhrase FROM hits WHERE SearchPhrase <> '' ORDER BY EventTime LIMIT 10;
SELECT SearchPhrase FROM hits WHERE SearchPhrase <> '' ORDER BY SearchPhrase LIMIT 10;
SELECT SearchPhrase FROM hits WHERE SearchPhrase <> '' ORDER BY EventTime, SearchPhrase LIMIT 10;
SELECT CounterID, AVG(length(URL)) AS l, COUNT(*) AS c FROM hits WHERE URL <> '' GROUP BY CounterID HAVING COUNT(*) > 100000 ORDER BY l DESC LIMIT 25;
SELECT REGEXP_REPLACE(Referer, '^https?://(?:www\.)?([^/]+)/.*$', '\\1') AS k, AVG(length(Referer)) AS l, COUNT(*) AS c, MIN(Referer) FROM hits WHERE Referer <> '' GROUP BY k HAVING COUNT(*) > 100000 ORDER BY l DESC LIMIT 25;
SELECT SUM(ResolutionWidth), SUM(ResolutionWidth + 1), SUM(ResolutionWidth + 2), SUM(ResolutionWidth + 3), SUM(ResolutionWidth + 4), SUM(ResolutionWidth + 5), SUM(ResolutionWidth + 6), SUM(ResolutionWidth + 7), SUM(ResolutionWidth + 8), SUM(ResolutionWidth + 9), SUM(ResolutionWidth + 10), SUM(ResolutionWidth + 11), SUM(ResolutionWidth + 12), SUM(ResolutionWidth + 13), SUM(ResolutionWidth + 14), SUM(ResolutionWidth + 15), SUM(ResolutionWidth + 16), SUM(ResolutionWidth + 17), SUM(ResolutionWidth + 18), SUM(ResolutionWidth + 19), SUM(ResolutionWidth + 20), SUM(ResolutionWidth + 21), SUM(ResolutionWidth + 22), SUM(ResolutionWidth + 23), SUM(ResolutionWidth + 24), SUM(ResolutionWidth + 25), SUM(ResolutionWidth + 26), SUM(ResolutionWidth + 27), SUM(ResolutionWidth + 28), SUM(ResolutionWidth + 29), SUM(ResolutionWidth + 30), SUM(ResolutionWidth + 31), SUM(ResolutionWidth + 32), SUM(ResolutionWidth + 33), SUM(ResolutionWidth + 34), SUM(ResolutionWidth + 35), SUM(ResolutionWidth + 36), SUM(ResolutionWidth + 37), SUM(ResolutionWidth + 38), SUM(ResolutionWidth + 39), SUM(ResolutionWidth + 40), SUM(ResolutionWidth + 41), SUM(ResolutionWidth + 42), SUM(ResolutionWidth + 43), SUM(ResolutionWidth + 44), SUM(ResolutionWidth + 45), SUM(ResolutionWidth + 46), SUM(ResolutionWidth + 47), SUM(ResolutionWidth + 48), SUM(ResolutionWidth + 49), SUM(ResolutionWidth + 50), SUM(ResolutionWidth + 51), SUM(ResolutionWidth + 52), SUM(ResolutionWidth + 53), SUM(ResolutionWidth + 54), SUM(ResolutionWidth + 55), SUM(ResolutionWidth + 56), SUM(ResolutionWidth + 57), SUM(ResolutionWidth + 58), SUM(ResolutionWidth + 59), SUM(ResolutionWidth + 60), SUM(ResolutionWidth + 61), SUM(ResolutionWidth + 62), SUM(ResolutionWidth + 63), SUM(ResolutionWidth + 64), SUM(ResolutionWidth + 65), SUM(ResolutionWidth + 66), SUM(ResolutionWidth + 67), SUM(ResolutionWidth + 68), SUM(ResolutionWidth + 69), SUM(ResolutionWidth + 70), SUM(ResolutionWidth + 71), SUM(ResolutionWidth + 72), SUM(ResolutionWidth + 73), SUM(ResolutionWidth + 74), SUM(ResolutionWidth + 75), SUM(ResolutionWidth + 76), SUM(ResolutionWidth + 77), SUM(ResolutionWidth + 78), SUM(ResolutionWidth + 79), SUM(ResolutionWidth + 80), SUM(ResolutionWidth + 81), SUM(ResolutionWidth + 82), SUM(ResolutionWidth + 83), SUM(ResolutionWidth + 84), SUM(ResolutionWidth + 85), SUM(ResolutionWidth + 86), SUM(ResolutionWidth + 87), SUM(ResolutionWidth + 88), SUM(ResolutionWidth + 89) FROM hits;
SELECT SearchEngineID, ClientIP, COUNT(*) AS c, SUM(IsRefresh), AVG(ResolutionWidth) FROM hits WHERE SearchPhrase <> '' GROUP BY SearchEngineID, ClientIP ORDER BY c DESC LIMIT 10;
SELECT WatchID, ClientIP, COUNT(*) AS c, SUM(IsRefresh), AVG(ResolutionWidth) FROM hits WHERE SearchPhrase <> '' GROUP BY WatchID, ClientIP ORDER BY c DESC LIMIT 10;
SELECT WatchID, ClientIP, COUNT(*) AS c, SUM(IsRefresh), AVG(ResolutionWidth) FROM hits GROUP BY WatchID, ClientIP ORDER BY c DESC LIMIT 10;
SELECT URL, COUNT(*) AS c FROM hits GROUP BY URL ORDER BY c DESC LIMIT 10;
SELECT 1, URL, COUNT(*) AS c FROM hits GROUP BY 1, URL ORDER BY c DESC LIMIT 10;
SELECT ClientIP, ClientIP - 1, ClientIP - 2, ClientIP - 3, COUNT(*) AS c FROM hits GROUP BY ClientIP, ClientIP - 1, ClientIP - 2, ClientIP - 3 ORDER BY c DESC LIMIT 10;
SELECT URL, COUNT(*) AS PageViews FROM hits WHERE CounterID = 62 AND EventDate >= '2013-07-01' AND EventDate <= '2013-07-31' AND DontCountHits = 0 AND IsRefresh = 0 AND URL <> '' GROUP BY URL ORDER BY PageViews DESC LIMIT 10;
SELECT Title, COUNT(*) AS PageViews FROM hits WHERE CounterID = 62 AND EventDate >= '2013-07-01' AND EventDate <= '2013-07-31' AND DontCountHits = 0 AND IsRefresh = 0 AND Title <> '' GROUP BY Title ORDER BY PageViews DESC LIMIT 10;
SELECT URL, COUNT(*) AS PageViews FROM hits WHERE CounterID = 62 AND EventDate >= '2013-07-01' AND EventDate <= '2013-07-31' AND IsRefresh = 0 AND IsLink <> 0 AND IsDownload = 0 GROUP BY URL ORDER BY PageViews DESC LIMIT 10 OFFSET 1000;
SELECT TraficSourceID, SearchEngineID, AdvEngineID, CASE WHEN (SearchEngineID = 0 AND AdvEngineID = 0) THEN Referer ELSE '' END AS Src, URL AS Dst, COUNT(*) AS PageViews FROM hits WHERE CounterID = 62 AND EventDate >= '2013-07-01' AND EventDate <= '2013-07-31' AND IsRefresh = 0 GROUP BY TraficSourceID, SearchEngineID, AdvEngineID, Src, Dst ORDER BY PageViews DESC LIMIT 10 OFFSET 1000;
SELECT URLHash, EventDate, COUNT(*) AS PageViews FROM hits WHERE CounterID = 62 AND EventDate >= '2013-07-01' AND EventDate <= '2013-07-31' AND IsRefresh = 0 AND TraficSourceID IN (-1, 6) AND RefererHash = 3594120000172545465 GROUP BY URLHash, EventDate ORDER BY PageViews DESC LIMIT 10 OFFSET 100;
SELECT WindowClientWidth, WindowClientHeight, COUNT(*) AS PageViews FROM hits WHERE CounterID = 62 AND EventDate >= '2013-07-01' AND EventDate <= '2013-07-31' AND IsRefresh = 0 AND DontCountHits = 0 AND URLHash = 2868770270353813622 GROUP BY WindowClientWidth, WindowClientHeight ORDER BY PageViews DESC LIMIT 10 OFFSET 10000;
SELECT DATE_TRUNC('minute', EventTime) AS M, COUNT(*) AS PageViews FROM hits WHERE CounterID = 62 AND EventDate >= '2013-07-14' AND EventDate <= '2013-07-15' AND IsRefresh = 0 AND DontCountHits = 0 GROUP BY DATE_TRUNC('minute', EventTime) ORDER BY DATE_TRUNC('minute', EventTime) LIMIT 10 OFFSET 1000;

-- ====== ADDITIONAL JOIN QUERIES (44-60) ======

-- Query 44: Basic INNER JOIN with search engines
SELECT se.SearchEngineName, COUNT(*) AS hits_count, COUNT(DISTINCT h.UserID) AS unique_users
FROM hits h 
INNER JOIN search_engines se ON h.SearchEngineID = se.SearchEngineID
WHERE h.SearchPhrase <> ''
GROUP BY se.SearchEngineName
ORDER BY hits_count DESC
LIMIT 10;

-- Query 45: JOIN with regions dimension
SELECT r.RegionName, r.Country, COUNT(*) AS total_hits, AVG(h.ResolutionWidth) AS avg_resolution
FROM hits h
INNER JOIN regions r ON h.RegionID = r.RegionID
GROUP BY r.RegionName, r.Country
ORDER BY total_hits DESC
LIMIT 15;

-- Query 46: Multiple JOINs with user segmentation
SELECT u.UserSegment, r.Continent, COUNT(*) AS hits, 
       COUNT(DISTINCT h.UserID) AS users,
       AVG(CASE WHEN h.AdvEngineID > 0 THEN 1 ELSE 0 END) AS ad_rate
FROM hits h
LEFT JOIN users u ON h.UserID = u.UserID
LEFT JOIN regions r ON h.RegionID = r.RegionID
WHERE h.EventDate >= '2013-07-01' AND h.EventDate <= '2013-07-31'
GROUP BY u.UserSegment, r.Continent
ORDER BY hits DESC
LIMIT 20;

-- Query 47: JOIN with advertising cost analysis
SELECT ae.AdvEngineName, ae.Category, 
       COUNT(*) AS impressions,
       COUNT(DISTINCT h.UserID) AS reach,
       SUM(ae.CostPerClick) AS total_cost
FROM hits h
INNER JOIN adv_engines ae ON h.AdvEngineID = ae.AdvEngineID
WHERE h.AdvEngineID > 0
GROUP BY ae.AdvEngineName, ae.Category
ORDER BY total_cost DESC
LIMIT 10;

-- Query 48: Time-based JOIN analysis
SELECT DATE_TRUNC('hour', h.EventTime) AS hour,
       se.SearchEngineName,
       COUNT(*) AS searches,
       COUNT(DISTINCT h.UserID) AS users
FROM hits h
INNER JOIN search_engines se ON h.SearchEngineID = se.SearchEngineID
WHERE h.SearchPhrase <> '' 
  AND h.EventDate = '2013-07-15'
GROUP BY hour, se.SearchEngineName
ORDER BY hour, searches DESC
LIMIT 50;

-- Query 49: Complex JOIN with user demographics
SELECT u.UserAge / 10 * 10 AS age_group,
       u.UserGender,
       r.Country,
       COUNT(*) AS page_views,
       COUNT(DISTINCT h.URL) AS unique_pages
FROM hits h
INNER JOIN users u ON h.UserID = u.UserID
INNER JOIN regions r ON h.RegionID = r.RegionID
WHERE u.UserAge BETWEEN 18 AND 65
GROUP BY age_group, u.UserGender, r.Country
HAVING page_views > 1000
ORDER BY page_views DESC
LIMIT 25;

-- Query 50: LEFT JOIN to find missing dimension data
SELECT h.SearchEngineID,
       COALESCE(se.SearchEngineName, 'Unknown') AS engine_name,
       COUNT(*) AS hits_count
FROM hits h
LEFT JOIN search_engines se ON h.SearchEngineID = se.SearchEngineID
WHERE h.SearchPhrase <> ''
GROUP BY h.SearchEngineID, se.SearchEngineName
ORDER BY hits_count DESC
LIMIT 20;

-- Query 51: JOIN with window functions
SELECT r.RegionName,
       COUNT(*) AS hits,
       RANK() OVER (ORDER BY COUNT(*) DESC) AS region_rank,
       COUNT(*) * 100.0 / SUM(COUNT(*)) OVER () AS percentage
FROM hits h
INNER JOIN regions r ON h.RegionID = r.RegionID
GROUP BY r.RegionName
ORDER BY hits DESC
LIMIT 15;

-- Query 52: Subquery with JOIN for top performing combinations
SELECT se.SearchEngineName, h.SearchPhrase, COUNT(*) AS frequency
FROM hits h
INNER JOIN search_engines se ON h.SearchEngineID = se.SearchEngineID
WHERE (h.SearchEngineID, h.SearchPhrase) IN (
    SELECT SearchEngineID, SearchPhrase
    FROM hits 
    WHERE SearchPhrase <> ''
    GROUP BY SearchEngineID, SearchPhrase
    HAVING COUNT(*) > 10000
)
GROUP BY se.SearchEngineName, h.SearchPhrase
ORDER BY frequency DESC
LIMIT 30;

-- Query 53: JOIN with date range and aggregations
SELECT r.Country,
       EXTRACT(MONTH FROM h.EventDate) AS month,
       COUNT(*) AS monthly_hits,
       COUNT(DISTINCT h.UserID) AS unique_users,
       AVG(h.ResolutionWidth) AS avg_screen_width
FROM hits h
INNER JOIN regions r ON h.RegionID = r.RegionID
WHERE h.EventDate BETWEEN '2013-07-01' AND '2013-07-31'
GROUP BY r.Country, month
ORDER BY monthly_hits DESC
LIMIT 40;

-- Query 54: Performance comparison across engines
SELECT COALESCE(se.SearchEngineName, 'Direct') AS traffic_source,
       COALESCE(ae.AdvEngineName, 'Organic') AS ad_source,
       COUNT(*) AS total_visits,
       COUNT(DISTINCT h.UserID) AS unique_visitors,
       AVG(CASE WHEN h.IsRefresh = 0 THEN 1 ELSE 0 END) AS fresh_visit_rate
FROM hits h
LEFT JOIN search_engines se ON h.SearchEngineID = se.SearchEngineID
LEFT JOIN adv_engines ae ON h.AdvEngineID = ae.AdvEngineID
GROUP BY traffic_source, ad_source
ORDER BY total_visits DESC
LIMIT 25;

-- Query 55: User journey analysis with JOINs
SELECT u.UserSegment,
       COUNT(DISTINCT h.URL) AS pages_visited,
       COUNT(*) AS total_pageviews,
       AVG(DATE_DIFF('second', MIN(h.EventTime), MAX(h.EventTime))) AS session_duration_sec
FROM hits h
INNER JOIN users u ON h.UserID = u.UserID
WHERE h.EventDate = '2013-07-15'
GROUP BY u.UserSegment, h.UserID
HAVING total_pageviews > 5
ORDER BY session_duration_sec DESC
LIMIT 20;

-- Query 56: Geographic and demographic cross-analysis
SELECT r.Continent,
       u.UserGender,
       CASE 
         WHEN u.UserAge < 25 THEN 'Young'
         WHEN u.UserAge < 45 THEN 'Adult' 
         ELSE 'Senior'
       END AS age_category,
       COUNT(*) AS hits,
       COUNT(DISTINCT h.UserID) AS users
FROM hits h
INNER JOIN users u ON h.UserID = u.UserID
INNER JOIN regions r ON h.RegionID = r.RegionID
WHERE h.EventDate >= '2013-07-01'
GROUP BY r.Continent, u.UserGender, age_category
ORDER BY hits DESC
LIMIT 30;

-- Query 57: Revenue analysis with multiple JOINs
SELECT ae.Category AS ad_category,
       se.SearchEngineName,
       COUNT(*) AS ad_impressions,
       SUM(ae.CostPerClick) AS total_spend,
       COUNT(DISTINCT h.UserID) AS reach,
       SUM(ae.CostPerClick) / COUNT(DISTINCT h.UserID) AS cost_per_user
FROM hits h
INNER JOIN adv_engines ae ON h.AdvEngineID = ae.AdvEngineID
INNER JOIN search_engines se ON h.SearchEngineID = se.SearchEngineID
WHERE h.AdvEngineID > 0 AND h.SearchEngineID > 0
GROUP BY ae.Category, se.SearchEngineName
ORDER BY total_spend DESC
LIMIT 20;

-- Query 58: Time zone analysis with region JOIN
SELECT r.TimeZone,
       EXTRACT(HOUR FROM h.EventTime) AS hour_of_day,
       COUNT(*) AS page_views,
       COUNT(DISTINCT h.UserID) AS active_users
FROM hits h
INNER JOIN regions r ON h.RegionID = r.RegionID
WHERE h.EventDate = '2013-07-15'
GROUP BY r.TimeZone, hour_of_day
ORDER BY r.TimeZone, hour_of_day
LIMIT 100;

-- Query 59: Market share analysis
SELECT se.SearchEngineName,
       se.MarketShare,
       COUNT(*) AS actual_hits,
       COUNT(*) * 100.0 / SUM(COUNT(*)) OVER () AS actual_share,
       se.MarketShare - (COUNT(*) * 100.0 / SUM(COUNT(*)) OVER ()) AS share_difference
FROM hits h
INNER JOIN search_engines se ON h.SearchEngineID = se.SearchEngineID
WHERE h.SearchPhrase <> ''
GROUP BY se.SearchEngineName, se.MarketShare
ORDER BY actual_hits DESC;

-- Query 60: Complex aggregation with multiple JOINs and window functions
SELECT r.Country,
       u.UserSegment,
       COUNT(*) AS total_hits,
       COUNT(DISTINCT h.UserID) AS unique_users,
       COUNT(DISTINCT h.URL) AS unique_pages,
       ROW_NUMBER() OVER (PARTITION BY r.Country ORDER BY COUNT(*) DESC) AS country_rank,
       PERCENT_RANK() OVER (ORDER BY COUNT(*)) AS percentile_rank
FROM hits h
INNER JOIN users u ON h.UserID = u.UserID
INNER JOIN regions r ON h.RegionID = r.RegionID
WHERE h.EventDate >= '2013-07-01' AND h.EventDate <= '2013-07-31'
GROUP BY r.Country, u.UserSegment
HAVING total_hits > 5000
ORDER BY total_hits DESC
LIMIT 50;
