-- Average Time to Submit (Completed Sessions Only)

SELECT
    application_channel,
    COUNT(*) AS completed_sessions,
    ROUND(AVG(time_to_submit_sec), 2) AS avg_time_to_submit_sec,
    ROUND(AVG(time_to_submit_sec) / 60.0, 2) AS avg_time_to_submit_min
FROM analytics.fact_voice_ai_sessions
WHERE session_completed_flag = TRUE
  AND application_channel IS NOT NULL
GROUP BY application_channel
ORDER BY avg_time_to_submit_sec;
