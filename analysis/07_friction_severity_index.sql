-- Friction Severity Index (FSI)
-- Combines completion drop and time penalty from misunderstanding

WITH base AS (
    SELECT
        application_channel,
        CASE
            WHEN misunderstanding_rate >= 0.33 THEN 'High'
            ELSE 'Low'
        END AS misunderstanding_bucket,
        session_completed_flag,
        time_to_submit_sec
    FROM analytics.fact_voice_ai_sessions
    WHERE application_channel IS NOT NULL
),

completion_rates AS (
    SELECT
        application_channel,
        misunderstanding_bucket,
        ROUND(
            SUM(CASE WHEN session_completed_flag = TRUE THEN 1 ELSE 0 END)::decimal
            / COUNT(*),
            4
        ) AS completion_rate
    FROM base
    GROUP BY application_channel, misunderstanding_bucket
),

time_rates AS (
    SELECT
        application_channel,
        misunderstanding_bucket,
        ROUND(AVG(time_to_submit_sec) / 60.0, 2) AS avg_time_min
    FROM base
    WHERE session_completed_flag = TRUE
    GROUP BY application_channel, misunderstanding_bucket
),

combined AS (
    SELECT
        c.application_channel,
        MAX(CASE WHEN misunderstanding_bucket = 'Low' THEN completion_rate END) AS completion_low,
        MAX(CASE WHEN misunderstanding_bucket = 'High' THEN completion_rate END) AS completion_high,
        MAX(CASE WHEN misunderstanding_bucket = 'Low' THEN avg_time_min END) AS time_low,
        MAX(CASE WHEN misunderstanding_bucket = 'High' THEN avg_time_min END) AS time_high
    FROM completion_rates c
    JOIN time_rates t
        ON c.application_channel = t.application_channel
       AND c.misunderstanding_bucket = t.misunderstanding_bucket
    GROUP BY c.application_channel
)

SELECT
    application_channel,
    ROUND((completion_low - completion_high) * 100, 2) AS completion_drop_pts,
    ROUND((time_high - time_low), 2) AS time_penalty_min,
    ROUND(((completion_low - completion_high) * 100) + (time_high - time_low), 2) AS friction_severity_index
FROM combined
ORDER BY friction_severity_index DESC;
