----------LESSON 17 創建和操作表-------------
--1.創建表：
--一般有兩種創建表的方式：
--1.多數DBMS 多數都具有交互式創建和管理數據庫表的工具
--2.表也可以直接用 SQL 語句操作

--1.1 表創建基礎：
--利用 CREATE TABLE 創建表，必須給出下列信息：
--1.新表名字（放在關鍵字 CREATE TABLE 後）
--2.表列的名字和定義，用逗號分開
--3.有的 DBMS 還要求指定表的位置

--例子，創建本書中所用的 products 表：
DROP TABLE products;
CREATE TABLE products
(
  prod_id     VARCHAR(10)       NOT NULL,
  vend_id     VARCHAR(10)       NOT NULL,
  prod_name   VARCHAR(254)      NOT NULL,
  prod_price  DECIMAL(8,2)      NOT NULL,
  prod_desc   VARCHAR(1000)     NULL
);

--Tip ：替換現有的表
--在創建新表時，指定的表名必須不存在，否則會出錯。
--為防止意外覆蓋已有的表，SQL 要求先手動刪除該表，再重建它，而不是簡單的用創建表語句覆蓋它。

--1.2 使用 NULL 值：
--NULL 值就是沒有值或缺值（Lesson 4）。
--允許 NULL 值的列，也允許再插入行時不給出該列的值。
--不允許 NULL 值的列，不接受沒有列值的行。換句話說，在插入或更新行時，該列必須有值。

--例子、在創建表時就會在表中定義是否為 NULL
Drop TABLE orders;
CREATE TABLE orders
(
  order_num   INTEGER     NOT NULL,
  order_date  TIMESTAMP   NOT NULL,
  cust_id     VARCHAR(10) NOT NULL
);

--分析：
--以上例子因為三列都需要有值，故每列都有關鍵字 NOT NULL，這會阻止插入沒有值的列
--如果插入沒有值的列，將會返回錯誤且插入失敗。

--例子、混合 NULL 和 NOT NULL 列的表
DROP TABLE vendors;
CREATE TABLE vendors
(
  vend_id       VARCHAR(10)     NOT NULL,
  vend_name     VARCHAR(50)     NOT NULL,
  vend_address  VARCHAR(50)     ,
  vend_city     VARCHAR(50)     ,
  vend_state    VARCHAR(5)      ,
  vend_zip      VARCHAR(10)     ,
  vend_country  VARCHAR(50)     
);

--分析：
--NULL 為默認設置（預設值），故若不指定 NOT NULL 就認定是 NULL。

--Note 指定 NULL
--多數DBMS 預設值為 NULL，但不是所有都是。某些 DBMS 要求指定關鍵字 NULL，不然會出錯。

--Tip 主鍵和 NULL 值
--主鍵是其值唯一標示表中每一行的列。
--只有 NOT NULL 值的列可作為主鍵。

--Note 理解 NULL
--不要把 NULL 值和空字符串混淆。
--NULL 值是沒有值，不是空字符串。
--如果指定''(兩個單引號，期間沒字符）)，這在 NOT NULL 列中是允許的。
--空字符串是一個有效的值，不是無值。

--1.3 指定預設值
--SQL 允許指定預設值，在插入行時如果不給出值，DBMS 將自動採用預設值。
--預設值在 CREATE TABLE 語句的列定義中用關鍵字 DEFAULT 指定。
--例子、
DROP TABLE orderItems;
CREATE TABLE orderItems
(
  order_num   INTEGER       NOT NULL,
  order_item  INTEGER       NOT NULL,
  prod_id     VARCHAR(10)   NOT NULL,
  quantity    INTEGER       NOT NULL   DEFAULT 1,
  item_price  DECIMAL(8,2)  NOT NULL
);

--分析：
--在例子中 DEFAULT 1，指示 DBMS 如果不給數量則使用數量 1 。
--預設值經常用於日期或時間戳列。例如，通過指定引用系統日期的函數或變量，將系統日期用作默認日期。
--獲得系統日期的命令在不同 DBMS 中幾乎是不同的。
--postfreSQL 是用 CURRENT_DATE。

--Tip 使用 DEFAULT 而不是 NULL 值
--許多數據庫開發人員喜歡使用 DEFAULT 值而不是 NULL 列。對於用於計算或數據分組的列更是如此。

--2.更新表：
--3.刪除表：
--4.重新命名表：
