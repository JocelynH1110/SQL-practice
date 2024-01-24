----------LESSON 17 創建和操作表-------------
--1.創建表：
--一般有兩種創建表的方式：
--1.多數DBMS 多數都具有交互式創建和管理數據庫表的工具
--2.表也可以直接用 SQL 語句操作

--1.1.表創建基礎：
--利用 CREATE TABLE 創建表，必須給出下列信息：
--1.新表名字（放在關鍵字 CREATE TABLE 後）
--2.表列的名字和定義，用逗號分開
--3.有的 DBMS 還要求指定表的位置

--例子，創建本書中所用的 products 表：
CREATE TABLE products
(
  prod_id     VARCHAR(10)       NOT NULL,
  vend_id     VARCHAR(10)       NOT NULL,
  prod_name   VARCHAR(254)      NOT NULL,
  prod_price  DECIMAL(8,2)   NOT NULL,
  prod_desc   VARCHAR(1000)  NULL
);

--2.更新表：
--3.刪除表：
--4.重新命名表：
