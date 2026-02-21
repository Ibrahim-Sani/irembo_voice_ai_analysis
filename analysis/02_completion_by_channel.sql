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
