select 
    T1.table_a_key, T1.arg , T2.cnt , T3.cnt
from 
    Table_A T1
    left join (
        select
            table_a_key,
            count(0) as cnt
        from Table_B 
        group by table_a_key
    ) AS T2 ON T1.table_a_key = T2.table_a_key
    left join (
        select
            table_a_key ,
            count(0) as cnt
        from Table_B
        where code in (3)
        group by table_a_key
    ) AS T3 ON T1.table_a_key = T3.table_a_key
where
    T1.arg = 'A'
    
