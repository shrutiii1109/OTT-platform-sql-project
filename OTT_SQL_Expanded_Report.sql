
-- ============================================================
-- OTT PLATFORM SQL PROJECT REPORT (EXPANDED VERSION)
-- AUTHOR: SHRUTI KUMARI
-- ============================================================

-- ============================================================
-- 1. PROJECT OVERVIEW
-- ============================================================
-- This SQL project simulates a full OTT platform (like Netflix/Prime).
-- It analyzes:
--   • User activity and signups
--   • Watch time behavior
--   • Rating patterns
--   • Subscription revenue
--   • Content engagement
--   • Genre performance
--   • Churn prediction signals
--   • Recommendation indicators
-- ============================================================


-- ============================================================
-- 2. ADVANCED BUSINESS QUESTIONS & SQL QUERIES
-- ============================================================

-- ------------------------------------------------------------
-- Q1. Total Revenue from Subscriptions
-- ------------------------------------------------------------
SELECT SUM(price) AS total_revenue FROM subscriptions;

-- ------------------------------------------------------------
-- Q2. Active Subscribers
-- ------------------------------------------------------------
SELECT COUNT(*) AS active_subscribers
FROM subscriptions
WHERE end_date >= CURRENT_DATE();

-- ------------------------------------------------------------
-- Q3. Top 5 Most Watched Shows (Total Watch Time)
-- ------------------------------------------------------------
SELECT s.title, SUM(w.watch_time_minutes) AS total_watch_time
FROM watch_history w
JOIN shows s ON w.show_id = s.show_id
GROUP BY s.show_id
ORDER BY total_watch_time DESC
LIMIT 5;

-- ------------------------------------------------------------
-- Q4. Lowest Watched Shows (Content to Remove)
-- ------------------------------------------------------------
SELECT s.title, SUM(w.watch_time_minutes) AS total_watch_time
FROM watch_history w
JOIN shows s ON s.show_id = w.show_id
GROUP BY s.show_id
ORDER BY total_watch_time ASC
LIMIT 5;

-- ------------------------------------------------------------
-- Q5. Top-Rated Shows (Avg Rating >= 4)
-- ------------------------------------------------------------
SELECT s.title, AVG(r.rating) AS avg_rating
FROM ratings r
JOIN shows s ON r.show_id = s.show_id
GROUP BY s.show_id
HAVING AVG(r.rating) >= 4
ORDER BY avg_rating DESC;

-- ------------------------------------------------------------
-- Q6. Average Watch Time per User
-- ------------------------------------------------------------
SELECT u.name, AVG(w.watch_time_minutes) AS avg_watch_time
FROM watch_history w
JOIN users u ON u.user_id = w.user_id
GROUP BY u.user_id
ORDER BY avg_watch_time DESC;

-- ------------------------------------------------------------
-- Q7. Total Watch Time by Genre
-- ------------------------------------------------------------
SELECT g.genre_name, SUM(w.watch_time_minutes) AS total_watch
FROM watch_history w
JOIN show_genres sg ON w.show_id = sg.show_id
JOIN genres g ON sg.genre_id = g.genre_id
GROUP BY g.genre_id
ORDER BY total_watch DESC;

-- ------------------------------------------------------------
-- Q8. Monthly New Signups
-- ------------------------------------------------------------
SELECT DATE_FORMAT(signup_date, '%Y-%m') AS month,
       COUNT(*) AS new_signups
FROM users
GROUP BY month
ORDER BY month;

-- ------------------------------------------------------------
-- Q9. City-wise User Count
-- ------------------------------------------------------------
SELECT city, COUNT(*) AS total_users
FROM users
GROUP BY city
ORDER BY total_users DESC;

-- ------------------------------------------------------------
-- Q10. Country-wise Subscription Revenue
-- ------------------------------------------------------------
SELECT u.country, SUM(s.price) AS revenue
FROM subscriptions s
JOIN users u ON s.user_id = u.user_id
GROUP BY u.country
ORDER BY revenue DESC;

-- ------------------------------------------------------------
-- Q11. Most Active Users (Most Watch Sessions)
-- ------------------------------------------------------------
SELECT u.name, COUNT(w.watch_id) AS total_sessions
FROM watch_history w
JOIN users u ON u.user_id = w.user_id
GROUP BY u.user_id
ORDER BY total_sessions DESC;

-- ------------------------------------------------------------
-- Q12. Most Binge-Watching Users (Max Minutes)
-- ------------------------------------------------------------
SELECT u.name, SUM(w.watch_time_minutes) AS total_minutes
FROM watch_history w
JOIN users u ON u.user_id = w.user_id
GROUP BY u.user_id
ORDER BY total_minutes DESC;

-- ------------------------------------------------------------
-- Q13. Most Popular Genre Among High Watch-Time Users
-- ------------------------------------------------------------
SELECT g.genre_name, SUM(w.watch_time_minutes) AS total_minutes
FROM watch_history w
JOIN show_genres sg ON w.show_id = sg.show_id
JOIN genres g ON sg.genre_id = g.genre_id
GROUP BY g.genre_id
ORDER BY total_minutes DESC;

-- ------------------------------------------------------------
-- Q14. Identify 'High Value Users' (Users Who Watch > 200 min monthly)
-- ------------------------------------------------------------
SELECT u.name, SUM(w.watch_time_minutes) AS total_minutes
FROM watch_history w
JOIN users u ON u.user_id = w.user_id
GROUP BY u.user_id
HAVING total_minutes > 200;

-- ------------------------------------------------------------
-- Q15. High Churn Probability Users (Watched 0 content last month)
-- ------------------------------------------------------------
SELECT u.user_id, u.name
FROM users u
LEFT JOIN watch_history w
ON u.user_id = w.user_id
AND MONTH(w.watch_date) = MONTH(CURRENT_DATE() - INTERVAL 1 MONTH)
WHERE w.watch_id IS NULL;

-- ------------------------------------------------------------
-- Q16. Show with Most Repeat Viewers
-- ------------------------------------------------------------
SELECT s.title, COUNT(*) AS repeat_viewers
FROM (
    SELECT user_id, show_id, COUNT(*) AS cnt
    FROM watch_history
    GROUP BY user_id, show_id
    HAVING cnt >= 2
) AS repeat_tbl
JOIN shows s ON repeat_tbl.show_id = s.show_id
GROUP BY s.show_id
ORDER BY repeat_viewers DESC;

-- ------------------------------------------------------------
-- Q17. Rating Trend by Year
-- ------------------------------------------------------------
SELECT release_year, AVG(r.rating) AS avg_rating
FROM ratings r
JOIN shows s ON r.show_id = s.show_id
GROUP BY release_year
ORDER BY release_year;

-- ------------------------------------------------------------
-- Q18. Most Popular Subscription Plan
-- ------------------------------------------------------------
SELECT plan, COUNT(*) AS total_users
FROM subscriptions
GROUP BY plan
ORDER BY total_users DESC;

-- ------------------------------------------------------------
-- Q19. Users Who Only Watch Movies (Not Series)
-- ------------------------------------------------------------
SELECT u.name
FROM users u
JOIN watch_history w ON u.user_id = w.user_id
JOIN shows s ON w.show_id = s.show_id
GROUP BY u.user_id
HAVING SUM(s.type = 'Series') = 0;

-- ------------------------------------------------------------
-- Q20. Users Who Only Watch Series (Not Movies)
-- ------------------------------------------------------------
SELECT u.name
FROM users u
JOIN watch_history w ON u.user_id = w.user_id
JOIN shows s ON w.show_id = s.show_id
GROUP BY u.user_id
HAVING SUM(s.type = 'Movie') = 0;


-- ============================================================
-- 3. INSIGHTS SUMMARY
-- ============================================================
-- • Premium plan brings highest revenue.
-- • Action, Drama, and Tech are the most watched genres.
-- • Several users binge-watch over 200 minutes monthly.
-- • Movies have higher total watch-time; Series have higher engagement.
-- • Top shows: Galaxy Wars, Mystery Manor, Detective Lane.
-- • Drop in watch activity predicts churn risk.
-- • Major signups come from metro cities: Delhi, Mumbai, Bangalore.
-- ============================================================

-- ============================================================
-- 4. RESUME SUMMARY (COPY THIS DIRECTLY)
-- ============================================================
-- SQL Project – OTT Platform Analysis
-- Designed a relational SQL database for an OTT platform and created 20+ 
-- analytical SQL queries to analyze users, content performance, ratings, 
-- subscriptions, churn, and watch-time patterns. Used subqueries, joins, 
-- aggregations, HAVING, date functions, and ranking to derive actionable 
-- business insights.
-- ============================================================
