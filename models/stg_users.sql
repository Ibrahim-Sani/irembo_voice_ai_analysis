drop table if exists analytics.stg_users;

create table analytics.stg_users as
select
    user_id,
    region,
    
    case 
        when lower(disability_flag) = 'yes' then true
        else false
    end as disability_flag,
    
    case 
        when lower(first_time_digital_user) = 'yes' then true
        else false
    end as first_time_digital_user

from raw.users;
