WITH CTE AS (
    SELECT u.user_id AS 'seller_id', u.favorite_brand, o.order_date, i.item_brand, RANK() OVER(PARTITION BY u.user_id ORDER BY o.order_date) AS 'rnk' FROM Users u JOIN Orders o ON u.user_id = o.seller_id JOIN Items i ON o.item_id = i.item_id
),
ACTE AS (
    SELECT c.seller_id, c.favorite_brand, c.item_brand AS 'second_item_brand' FROM CTE c WHERE c.rnk = 2
)
SELECT u.user_id AS 'seller_id', (
    CASE
        WHEN a.seller_id IS NULL THEN 'no'
        WHEN a.second_item_brand = a.favorite_brand THEN 'yes'
        ELSE 'no'
    END 
) AS '2nd_item_fav_brand' FROM Users u LEFT JOIN ACTE a ON u.user_id = a.seller_id