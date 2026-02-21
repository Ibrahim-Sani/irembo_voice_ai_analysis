drop table if exists analytics.stg_turn_agg;

create table analytics.stg_turn_agg as
select
    session_id,

    count(*) as total_turns_recorded,

    sum(case when speaker = 'user' then 1 else 0 end) as total_user_turns,

    sum(case when speaker = 'system' then 1 else 0 end) as total_system_turns,

    avg(asr_confidence) as avg_asr_conf_turn_level,

    avg(intent_confidence) as avg_intent_conf_turn_level,

    sum(case when error_type is not null then 1 else 0 end) as total_error_turns,

    avg(turn_duration_sec) as avg_turn_duration_sec

from raw.voice_turns
group by session_id;
