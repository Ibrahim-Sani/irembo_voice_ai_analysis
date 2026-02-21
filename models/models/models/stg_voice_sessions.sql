drop table if exists analytics.stg_voice_sessions;

create table analytics.stg_voice_sessions as
select
    session_id,
    user_id,
    lower(channel) as channel,
    lower(language) as language,
    total_duration_sec,
    total_turns,
    lower(final_outcome) as final_outcome,
    transfer_reason,
    created_at,

    case 
        when lower(final_outcome) = 'completed' then true
        else false
    end as session_completed_flag

from raw.voice_sessions;
