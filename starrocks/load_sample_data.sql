-- Sample data loading for dimension tables
-- This creates realistic reference data for JOIN testing

-- Insert sample users data (extracted from main hits table)
INSERT INTO users 
SELECT DISTINCT 
    UserID,
    CASE 
        WHEN UserID % 5 = 0 THEN 'Premium'
        WHEN UserID % 5 = 1 THEN 'Standard'
        WHEN UserID % 5 = 2 THEN 'Basic'
        WHEN UserID % 5 = 3 THEN 'Trial'
        ELSE 'Guest'
    END AS UserSegment,
    CASE 
        WHEN RegionID IN (1,2,3) THEN 'Russia'
        WHEN RegionID IN (4,5,6) THEN 'Ukraine' 
        WHEN RegionID IN (7,8,9) THEN 'Belarus'
        WHEN RegionID IN (10,11,12) THEN 'Kazakhstan'
        ELSE 'Other'
    END AS UserCountry,
    DATE_SUB('2013-07-01', INTERVAL (UserID % 365) DAY) AS RegistrationDate,
    18 + (UserID % 50) AS UserAge,
    CASE WHEN UserID % 2 = 0 THEN 'M' ELSE 'F' END AS UserGender
FROM hits 
WHERE UserID > 0 
LIMIT 1000000;

-- Insert regions reference data
INSERT INTO regions VALUES
(1, 'Moscow', 'Russia', 'Europe', 'UTC+3'),
(2, 'Saint Petersburg', 'Russia', 'Europe', 'UTC+3'),
(3, 'Novosibirsk', 'Russia', 'Asia', 'UTC+7'),
(4, 'Kiev', 'Ukraine', 'Europe', 'UTC+2'),
(5, 'Kharkiv', 'Ukraine', 'Europe', 'UTC+2'),
(6, 'Odessa', 'Ukraine', 'Europe', 'UTC+2'),
(7, 'Minsk', 'Belarus', 'Europe', 'UTC+3'),
(8, 'Gomel', 'Belarus', 'Europe', 'UTC+3'),
(9, 'Vitebsk', 'Belarus', 'Europe', 'UTC+3'),
(10, 'Almaty', 'Kazakhstan', 'Asia', 'UTC+6'),
(11, 'Nur-Sultan', 'Kazakhstan', 'Asia', 'UTC+6'),
(12, 'Shymkent', 'Kazakhstan', 'Asia', 'UTC+6'),
(100, 'Unknown', 'Unknown', 'Unknown', 'UTC+0');

-- Insert search engines reference data  
INSERT INTO search_engines VALUES
(0, 'Direct', '', 0.00),
(1, 'Yandex', 'https://yandex.ru', 45.50),
(2, 'Google', 'https://google.com', 35.20),
(3, 'Mail.ru', 'https://mail.ru', 8.30),
(4, 'Bing', 'https://bing.com', 4.10),
(5, 'Rambler', 'https://rambler.ru', 2.80),
(6, 'Yahoo', 'https://yahoo.com', 1.90),
(7, 'Baidu', 'https://baidu.com', 1.50),
(8, 'DuckDuckGo', 'https://duckduckgo.com', 0.70);

-- Insert advertising engines reference data
INSERT INTO adv_engines VALUES
(0, 'None', 0.0000, 'Organic'),
(1, 'Yandex.Direct', 0.1500, 'Search'),
(2, 'Google Ads', 0.1800, 'Search'),
(3, 'Facebook Ads', 0.1200, 'Social'),
(4, 'VKontakte Ads', 0.0800, 'Social'),
(5, 'MyTarget', 0.0900, 'Display'),
(6, 'Criteo', 0.1100, 'Retargeting'),
(7, 'Begun', 0.0700, 'Contextual'),
(8, 'AdRiver', 0.0600, 'Display');
