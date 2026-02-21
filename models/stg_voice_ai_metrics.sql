drop table if exists analytics.stg_voice_ai_metrics;

create table analytics.stg_voice_ai_metrics as
select
    session_id,
    avg_asr_confidence,
    avg_intent_confidence,
    misunderstanding_rate,
    silence_rate,

    case 
        when lower(recovery_success) = 'yes' then true
        else false
    end as recovery_success,

    case 
        when lower(escalation_flag) = 'yes' then true
        else false
    end as escalation_flag

from raw.voice_ai_metrics;
