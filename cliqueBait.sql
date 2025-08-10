-- 1. How many unique visitors accessed our website?
SELECT COUNT(DISTINCT cookie_id) AS unique_visitors
FROM clique_bait.users;

-- 2. How many cookies does each user have on average?
SELECT ROUND(AVG(cookie_id_count), 0) AS Average_cookie
FROM (
  SELECT user_id, COUNT(cookie_id) AS cookie_id_count
  FROM clique_bait.users
  GROUP BY user_id
) AS a;

-- 3. What is the unique number of visits by all users per month?
SELECT 
  MONTH(event_time) AS Month, 
  COUNT(DISTINCT visit_id) AS unique_visit_count
FROM clique_bait.events
GROUP BY MONTH(event_time);

-- 4. What is the number of events for each event type?
SELECT 
  ei.event_name, 
  COUNT(*) AS event_count
FROM clique_bait.events AS e
LEFT JOIN clique_bait.event_identifier AS ei 
  ON ei.event_type = e.event_type
GROUP BY ei.event_name
ORDER BY event_count DESC;

-- 5. What is the percentage of visits which have a purchase event?
SELECT 
  ROUND(
    SUM(CASE WHEN event_type = 3 THEN 1 ELSE 0 END) 
    / COUNT(DISTINCT visit_id), 3
  ) * 100 AS purchase_percentage
FROM clique_bait.events;

-- 6. What are the top 3 pages by number of views?
SELECT 
  ph.page_name, 
  COUNT(*) AS view_count
FROM clique_bait.events AS e
LEFT JOIN clique_bait.page_hierarchy AS ph 
  ON ph.page_id = e.page_id
WHERE e.event_type = 1 AND ph.product_id IS NOT NULL
GROUP BY ph.page_name
ORDER BY view_count DESC
LIMIT 3;

-- 7. What is the number of views and cart adds for each product category?
SELECT 
  ph.product_category,
  SUM(CASE WHEN e.event_type = 1 THEN 1 ELSE 0 END) AS page_views,
  SUM(CASE WHEN e.event_type = 2 THEN 1 ELSE 0 END) AS cart_adds
FROM clique_bait.events AS e
LEFT JOIN clique_bait.page_hierarchy AS ph 
  ON ph.page_id = e.page_id
WHERE ph.product_category IS NOT NULL
GROUP BY ph.product_category
ORDER BY ph.product_category DESC;

-- 8. Campaigns performance analysis - How many page views did each campaign generate?
SELECT 
  ci.campaign_name, 
  COUNT(*) AS page_views
FROM clique_bait.campaign_identifier AS ci
INNER JOIN clique_bait.events AS e 
  ON ci.products = e.page_id
WHERE e.event_type = 1
GROUP BY ci.campaign_name;

-- 9. Calculate the total number of unique visitors for each campaign.
SELECT 
  ci.campaign_name, 
  COUNT(DISTINCT e.cookie_id) AS unique_visitors
FROM clique_bait.events AS e
INNER JOIN clique_bait.campaign_identifier AS ci 
  ON e.page_id = ci.products
GROUP BY ci.campaign_name;

-- 10. User behaviour analysis - How many sessions did each user have on the website?
SELECT 
  u.user_id,
  COUNT(DISTINCT e.visit_id) AS session_count
FROM clique_bait.users AS u
LEFT JOIN clique_bait.events AS e 
  ON e.cookie_id = u.cookie_id
GROUP BY u.user_id;

-- 11. Find the number of users who have made a purchase, ordered by their order counts.
SELECT 
  u.user_id,
  COUNT(*) AS purchase_count
FROM clique_bait.users AS u
LEFT JOIN clique_bait.events AS e 
  ON e.cookie_id = u.cookie_id
WHERE e.event_type = 3
GROUP BY u.user_id
ORDER BY purchase_count DESC;

-- 12. Product Recommendation Analysis - Least viewed product.
SELECT 
  ph.page_name,
  ph.product_category,
  COUNT(*) AS views
FROM clique_bait.events AS e
LEFT JOIN clique_bait.page_hierarchy AS ph 
  ON ph.page_id = e.page_id
WHERE ph.product_category IS NOT NULL
GROUP BY ph.page_name, ph.product_category
ORDER BY views ASC
LIMIT 1;

-- 13. Product Recommendation Analysis - Most viewed product.
SELECT 
  ph.page_name,
  ph.product_category,
  COUNT(*) AS views
FROM clique_bait.events AS e
LEFT JOIN clique_bait.page_hierarchy AS ph 
  ON ph.page_id = e.page_id
WHERE ph.product_category IS NOT NULL
GROUP BY ph.page_name, ph.product_category
ORDER BY views DESC
LIMIT 1;
