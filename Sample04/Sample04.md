# Sample04

外部キー制約を使う。

## 準備

### 外部キー制約

sqliteの場合、デフォルトだと外部キー制約が有効になっていない。  
下記を設定しておく。

``` bash
$ grep 'foreign_keys' ~/.sqliterc
PRAGMA foreign_keys = ON;
```

### テーブル作成

``` bash
sqlite3 sample.db < ./sql/create_tables.sql 
```

### データ登録

``` bash
sqlite3 sample.db
```

``` sqlite
.mode csv
.import ./csv/layout_master.csv layout_master
.import ./csv/user_layout.csv user_layout
```

## Table

``` sqlite
sqlite> .tables
layout_master  user_layout  
```

## Datas

