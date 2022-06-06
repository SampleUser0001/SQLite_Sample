# LEFT JOIN を別の表現で書き換える

- [LEFT JOIN を別の表現で書き換える](#left-join-を別の表現で書き換える)
  - [元データ](#元データ)
  - [実行結果](#実行結果)
    - [Select01](#select01)
    - [Select02](#select02)
    - [Select03](#select03)
  - [応用](#応用)

## 元データ

``` sql 
select * from Table_A;
```

|name|flg|
|:---|:--|
|Sato|01|
|Sato|02|
|Sato|03|
|Sato|04|
|Suzuki|02|
|Suzuki|03|
|Takahashi|01|
|Takahashi|04|

## 実行結果

|name|01|02|03|04|
|:---|:--|:--|:--|:--|
|Sato|〇|〇|〇|〇|
|Suzuki||〇|〇||
|Takahashi|〇|||〇|

### Select01

- 理解が難しくない
- 列数が増えるとソースが長くなる
- 列数が増えるとパフォーマンスが悪くなる

``` sql
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
  
```

### Select02

- 列が増えたときの修正が容易
- 読みやすい
- パフォーマンスが良くない

``` sql
SELECT
  T0.name ,
  (SELECT '〇' FROM Table_A T1 WHERE flg = "01" AND T1.name = T0.name) AS "01",
  (SELECT '〇' FROM Table_A T2 WHERE flg = "02" AND T2.name = T0.name) AS "02",
  (SELECT '〇' FROM Table_A T3 WHERE flg = "03" AND T3.name = T0.name) AS "03",
  (SELECT '〇' FROM Table_A T4 WHERE flg = "04" AND T4.name = T0.name) AS "04"
FROM 
  (SELECT DISTINCT name FROM Table_A) T0

```

### Select03


- flgを1かnullのどちらかに変換する。

``` sql
SELECT
  name,
  CASE WHEN SUM(CASE WHEN flg = "01" THEN 1 ELSE NULL END) = 1 THEN "〇" ELSE NULL END AS "01",
  CASE WHEN SUM(CASE WHEN flg = "02" THEN 1 ELSE NULL END) = 1 THEN "〇" ELSE NULL END AS "02",
  CASE WHEN SUM(CASE WHEN flg = "03" THEN 1 ELSE NULL END) = 1 THEN "〇" ELSE NULL END AS "03",
  CASE WHEN SUM(CASE WHEN flg = "04" THEN 1 ELSE NULL END) = 1 THEN "〇" ELSE NULL END AS "04"
FROM 
  Table_A
GROUP BY
  name

```

## 応用

これを作りたい。

|name|01から04|01から03|01から02|
|:---|:--|:--|:--|
|Sato|4|3|2|
|Suzuki|2|2|1|
|Takahashi|2|1|1|
