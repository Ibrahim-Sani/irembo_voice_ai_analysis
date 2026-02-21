---- Voice vs Non-Voice Completion Rate
select
    channel,
    count(*) as total_sessions,
    sum(case when application_submitted_flag then 1 else 0 end) as sessions_with_application,
    sum(case when application_success_flag then 1 else 0 end) as successful_applications,
    round(
        sum(case when application_success_flag then 1 else 0 end)::numeric 
        / nullif(count(*), 0),
        3
    ) as overall_success_rate,
    round(
        sum(case when application_success_flag then 1 else 0 end)::numeric 
        / nullif(sum(case when application_submitted_flag then 1 else 0 end), 0),
        3
    ) as success_rate_given_submitted
from analytics.fact_voice_ai_sessions
group by channel
order by channel;

------ Application Channel Distribution

select
    application_channel,
    count(*) as applications,
    sum(case when application_success_flag then 1 else 0 end) as successful,
    round(
        sum(case when application_success_flag then 1 else 0 end)::numeric
        / nullif(count(*), 0),
        3
    ) as success_rate
from analytics.fact_voice_ai_sessions
where application_submitted_flag = true
group by application_channel
order by application_channel;


---------- Completion grouped by application_channel
-- Completion Rate by Application Channel
-- Measures effectiveness across Voice, Web, and USSD

SELECT
    application_channel,
    COUNT(*) AS total_sessions,
    SUM(CASE WHEN session_completed_flag = TRUE THEN 1 ELSE 0 END) AS completed_sessions,
    ROUND(
        SUM(CASE WHEN session_completed_flag = TRUE THEN 1 ELSE 0 END)::decimal
        / COUNT(*),
        4
    ) AS completion_rate
FROM analytics.fact_voice_ai_sessions
WHERE application_channel IS NOT NULL
GROUP BY application_channel
ORDER BY completion_rate DESC;


