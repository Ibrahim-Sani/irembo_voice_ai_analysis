drop table if exists analytics.stg_applications_dedup;

create table analytics.stg_applications_dedup as
select *
from (
    select
        application_id,
        session_id,
        user_id,
        service_code,
        channel,
        status,
        time_to_submit_sec,
        submitted_at,
        row_number() over (
            partition by session_id
            order by submitted_at asc
        ) as rn
    from analytics.stg_applications
) x
where rn = 1;

select count(*) from analytics.stg_applications_dedup;
