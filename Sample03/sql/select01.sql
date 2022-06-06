SELECT
  T0.name ,
  CASE WHEN T1.name IS NOT NULL THEN '〇' ELSE NULL END AS "01", 
  CASE WHEN T2.name IS NOT NULL THEN '〇' ELSE NULL END AS "02", 
  CASE WHEN T3.name IS NOT NULL THEN '〇' ELSE NULL END AS "03", 
  CASE WHEN T4.name IS NOT NULL THEN '〇' ELSE NULL END AS "04"
FROM 
  (SELECT DISTINCT name FROM Table_A) T0
  LEFT JOIN
    (SELECT name FROM Table_A WHERE flg = "01") AS T1 ON T0.name = T1.name 
  LEFT JOIN
    (SELECT name FROM Table_A WHERE flg = "02") AS T2 ON T0.name = T2.name 
  LEFT JOIN
    (SELECT name FROM Table_A WHERE flg = "03") AS T3 ON T0.name = T3.name 
  LEFT JOIN
    (SELECT name FROM Table_A WHERE flg = "04") AS T4 ON T0.name = T4.name 
  