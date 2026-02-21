with baseline as (
    select
        count(*) as total_sessions,
        sum(
            case 
                when misunderstanding_rate > 0.333333333333333 then 1 
                else 0 
            end
        ) as error_sessions
    from analytics.fact_voice_ai_sessions
    where misunderstanding_rate is not null
)

select
    total_sessions,
    error_sessions as current_error_sessions,
    round(error_sessions::numeric / total_sessions, 3) as current_error_rate,
    round(error_sessions * 0.6) as projected_error_sessions,
    round((error_sessions * 0.6)::numeric / total_sessions, 3) as projected_error_rate
from baseline;
