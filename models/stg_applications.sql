drop table if exists analytics.stg_applications;

create table analytics.stg_applications as
select
    application_id,
    session_id,
    user_id,
    lower(service_code) as service_code,
    lower(channel) as channel,
    lower(status) as status,
    time_to_submit_sec,
    submitted_at

from raw.applications;
