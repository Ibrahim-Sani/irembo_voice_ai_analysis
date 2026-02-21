
-- High vs Low misunderstanding (threshold = 0.33)

WITH misunderstanding_bucket AS (
    SELECT
        *,
        CASE
            WHEN misunderstanding_rate >= 0.33 THEN 'High'
            ELSE 'Low'
        END AS misunderstanding_bucket
    FROM analytics.fact_voice_ai_sessions
)

SELECT
    application_channel,
    misunderstanding_bucket,
    COUNT(*) AS total_sessions,
    SUM(CASE WHEN session_completed_flag = TRUE THEN 1 ELSE 0 END) AS completed_sessions,
    ROUND(
        SUM(CASE WHEN session_completed_flag = TRUE THEN 1 ELSE 0 END)::decimal
        / COUNT(*),
        4
    ) AS completion_rate
FROM misunderstanding_bucket
GROUP BY application_channel, misunderstanding_bucket
ORDER BY application_channel, misunderstanding_bucket;
