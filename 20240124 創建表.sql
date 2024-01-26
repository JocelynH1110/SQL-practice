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
--更新表定義可以使用 ALTER TABLE 語句。
--雖然所有 DBMS 都支持 ALTER TABLE ，但他們所允許更新的內容差別很大。

--以下是使用 ALTER TABLE 時需考慮的事情：
--理想情況下，不要在表中包含數據時對其進行更新。應在表的設計過程中充分考慮未來可能的需求，避免之後對表的結構做大改動。
--所有的 DBMS 都允許給現有的表增加列，不過對增加的列的數據類型（及NULL 不過對增加的列的數據類型（及 NULL 和 DEFAULT 的使用）有所限制。
--許多 DBMS 不允許重新命名表中的列。
--許多 DBMS 限制對已填有數據的列進行更改，對未填有數據的列幾乎沒有限制。

--以上可看出對已有表做更改既複雜又不統一。具體能做哪些更改還是要參閱 DBMS 文檔。

--使用 ALTER TABLE 更改表結構，須給出下面訊息：
--1.在 ALTER TABLE 後要給出要更改的表名（該表須存在，不然會出錯）。
--2.列出要做哪些更改。

--例子、因為給已有表增加列可能是所有 DBMS 都支持的唯一操作，故做下列例子。
ALTER TABLE vendors
ADD vend_phone VARCHAR(20);

--例子、更改或刪除列、增加約束或增加鍵，這些操作也使用類似語法（下面例子非對所有 DBMS 都有效）
ALTER TABLE vendors
DROP COLUMN vend_phone;

--複雜的表結構更改一般需要手動刪除過程，涉及以下步驟
--1.用新的列布局建立一個新表。
--2.使用 INSERT SELECT 語句（Lesson 15）從舊表複製數據到新表。必要的話，可使用轉換函數和計算字段。
--3.檢驗包含所需數據的新表。
--4.重命名舊表（如果確定，可以刪除它）。
--5.用舊表原來的名字重命名新表。
--6.根據需要，重新創建觸發器、存儲過程、索引和外鍵。

--Note 小心使用 ALTER TABLE
--應在進行改動前作完整備份（表結構和數據的備份）。
--數據庫表的更改不能撤銷，如增加了不需要的列，也許無法刪除他們。若刪除不應該刪除的列，可能會丟失該列中的所有數據。
--3.刪除表：
--4.重新命名表：
