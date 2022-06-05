        select
            3 as user_id,
            count(0) as cnt
        from T_Tmp_Code 
        where code in (1)
          and user_id = 3
