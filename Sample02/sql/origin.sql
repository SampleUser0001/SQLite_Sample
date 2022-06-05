select 
    T1.id, T1.name , T2.cnt , T3.cnt
from 
    M_USER T1
    left join (
        select
            user_id,
            count(0) as cnt
        from T_Tmp_Code 
        group by user_id
    ) AS T2 ON T1.id = T2.user_id 
    left join (
        select
            user_id,
            count(0) as cnt
        from T_Tmp_Code 
        where code in (1,2,3)
        group by user_id
    ) AS T3 ON T1.id = T3.user_id

