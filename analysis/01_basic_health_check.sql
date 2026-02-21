
--- Do sessions link to users?
select count(*) as unmatched_sessions
from raw.voice_sessions vs
left join raw.users u
  on vs.user_id = u.user_id
where u.user_id is null;

---- Do AI metrics link to sessions?
select count(*) as unmatched_ai_metrics
from raw.voice_ai_metrics m
left join raw.voice_sessions s
  on m.session_id = s.session_id
where s.session_id is null;

------ Do applications link to sessions?
select count(*) as unmatched_applications
from raw.applications a
left join raw.voice_sessions s
  on a.session_id = s.session_id
where s.session_id is null;

----- Inspect application status values
select distinct application_status
from analytics.fact_voice_ai_sessions
where application_status is not null;

--------Fact table row count sanity check
select
    count(*) as total_sessions,
    sum(case when session_completed_flag then 1 else 0 end) as completed_sessions,
    sum(case when application_submitted_flag then 1 else 0 end) as sessions_with_application,
    sum(case when application_success_flag then 1 else 0 end) as successful_applications
from analytics.fact_voice_ai_sessions;


select
    count(*) as total_sessions,
    sum(case when application_success_flag then 1 else 0 end) as successful_applications
from analytics.fact_voice_ai_sessions;
