SELECT
  T0.name ,
  (SELECT '〇' FROM Table_A T1 WHERE flg = "01" AND T1.name = T0.name) AS "01",
  (SELECT '〇' FROM Table_A T2 WHERE flg = "02" AND T2.name = T0.name) AS "02",
  (SELECT '〇' FROM Table_A T3 WHERE flg = "03" AND T3.name = T0.name) AS "03",
  (SELECT '〇' FROM Table_A T4 WHERE flg = "04" AND T4.name = T0.name) AS "04"
FROM 
  (SELECT DISTINCT name FROM Table_A) T0
