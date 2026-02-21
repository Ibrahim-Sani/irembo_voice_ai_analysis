drop table if exists analytics.fact_voice_ai_sessions;

create table analytics.fact_voice_ai_sessions as
select
    s.session_id,
    s.user_id,

    -- user attributes
    u.region,
    u.disability_flag,
    u.first_time_digital_user,

    -- session attributes
    s.channel,
    s.language,
    s.total_duration_sec,
    s.total_turns,
    s.final_outcome,
    s.session_completed_flag,
    s.created_at,

    -- turn-level aggregates
    t.total_turns_recorded,
    t.total_user_turns,
    t.total_system_turns,
    t.avg_asr_conf_turn_level,
    t.avg_intent_conf_turn_level,
    t.total_error_turns,
    t.avg_turn_duration_sec,

    -- AI metrics
    m.avg_asr_confidence,
    m.avg_intent_confidence,
    m.misunderstanding_rate,
    m.silence_rate,
    m.recovery_success,
    m.escalation_flag,

    -- application (deduplicated)
    a.application_id,
    a.service_code,
    a.channel as application_channel,
    a.status as application_status,
    a.time_to_submit_sec,
    a.submitted_at,

    -- derived flags
    case when a.application_id is not null then true else false end as application_submitted_flag,

    case when a.status = 'approved' then true else false end as application_success_flag

from analytics.stg_voice_sessions s
left join analytics.stg_users u
    on s.user_id = u.user_id
left join analytics.stg_turn_agg t
    on s.session_id = t.session_id
left join analytics.stg_voice_ai_metrics m
    on s.session_id = m.session_id
left join analytics.stg_applications_dedup a
    on s.session_id = a.session_id;


select count(*) from analytics.fact_voice_ai_sessions;
