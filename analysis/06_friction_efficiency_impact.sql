-- Time Penalty from Misunderstanding (Completed Sessions Only)

WITH misunderstanding_bucket AS (
    SELECT
        *,
        CASE
            WHEN misunderstanding_rate >= 0.33 THEN 'High'
            ELSE 'Low'
        END AS misunderstanding_bucket
    FROM analytics.fact_voice_ai_sessions
    WHERE session_completed_flag = TRUE
      AND application_channel IS NOT NULL
)

SELECT
    application_channel,
    misunderstanding_bucket,
    COUNT(*) AS completed_sessions,
    ROUND(AVG(time_to_submit_sec), 2) AS avg_time_sec,
    ROUND(AVG(time_to_submit_sec) / 60.0, 2) AS avg_time_min
FROM misunderstanding_bucket
GROUP BY application_channel, misunderstanding_bucket
ORDER BY application_channel, misunderstanding_bucket;
