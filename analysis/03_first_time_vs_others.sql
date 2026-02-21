-- Completion Rate by First-Time Digital User

SELECT
    first_time_digital_user,
    COUNT(*) AS total_sessions,
    SUM(CASE WHEN session_completed_flag = TRUE THEN 1 ELSE 0 END) AS completed_sessions,
    ROUND(
        SUM(CASE WHEN session_completed_flag = TRUE THEN 1 ELSE 0 END)::decimal
        / COUNT(*),
        4
    ) AS completion_rate
FROM analytics.fact_voice_ai_sessions
GROUP BY first_time_digital_user
ORDER BY first_time_digital_user;
