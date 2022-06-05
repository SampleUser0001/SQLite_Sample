# Sample01

- [Sample01](#sample01)
  - [テーブル一覧](#テーブル一覧)
  - [テーブル定義](#テーブル定義)
    - [table1](#table1)
    - [table2](#table2)
    - [username](#username)
  - [データ](#データ)
  - [複数inner join](#複数inner-join)
    - [旧](#旧)
  - [left join](#left-join)
    - [テーブルが複数ある場合](#テーブルが複数ある場合)
  - [joinせずに複数テーブルの値を並べる](#joinせずに複数テーブルの値を並べる)

## テーブル一覧

``` sqlite
sqlite> .tables
table1    table2    username
```

## テーブル定義

### table1

``` sql
create table table1 (id integer primary key autoincrement, value text);
```

### table2 

``` sql
create table table2 (id integer primary key autoincrement, value text);
```

### username

``` sql
create table username(id integer primary key autoincrement, name text);
```

## データ

``` sql
sqlite> select * from table1;
1|foo
2|bar
sqlite> select * from table2;
1|bar
sqlite> select * from username;
1|hoge
```

## 複数inner join 

``` sql
sqlite> select username.id , username.name, table1.value, table2.value
   ...> from username
   ...> inner join table1 
   ...> on username.id = table1.id
   ...> inner join table2
   ...> on username.id = table2.id;
1|hoge|foo|bar
```

### 旧

``` sql
sqlite> select username.id , username.name, table1.value, table2.value
   ...> from username, table1, table2
   ...> where 
   ...>   username.id = table1.id and username.id = table2.id;
1|hoge|foo|bar
```

## left join

``` sql
sqlite> select username.id , username.name, table1.value
   ...> from username
   ...> left join table1 
   ...> on username.id = table1.id
   ...> ;
1|hoge|foo
```

### テーブルが複数ある場合

``` sql
sqlite> select 
   ...>     user.id , user.name , t1.value, t2.value
   ...> FROM 
   ...>     (select user.id, user.name from username as user where user.id = 1) as user ,
   ...>     (select t1.value from table1 as t1 where t1.id = 1) as t1
   ...> LEFT JOIN table2 as t2 ON user.id = t2.id
   ...> ;
1|hoge|foo|bar
```

## joinせずに複数テーブルの値を並べる

``` sql
sqlite> select 
   ...>     user.id , user.name , t1.value, t2.value
   ...> FROM 
   ...>     (select user.id, user.name from username as user where user.id = 1) as user ,
   ...>     (select t1.value from table1 as t1 where t1.id = 1) as t1 ,
   ...>     (select t2.value from table2 as t2 where t2.id = 1) as t2 
   ...> ;
1|hoge|foo|bar
```