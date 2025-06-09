WITH CTE AS(
    SELECT first_player AS 'player', first_score AS 'score' FROM Matches
    UNION ALL
    SELECT second_player AS 'player', second_score AS 'score' FROM Matches
),
ACTE AS(
    SELECT p.player_id, p.group_id, SUM(c.score) AS 'total_score' FROM Players p JOIN CTE c ON p.player_id = c.player GROUP BY p.player_id, p.group_id
),
ANCTE AS (
    SELECT group_id, player_id, ROW_NUMBER() OVER (PARTITION BY group_id ORDER BY total_score DESC, player_id ASC) AS 'group_rank' FROM ACTE
)

SELECT group_id, player_id FROM ANCTE WHERE group_rank = 1