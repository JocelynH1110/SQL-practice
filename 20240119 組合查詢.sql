----------LESSON 14 組合查詢-------------
--1. 組合查詢
--多數 SQL 查詢只包含從一個或多個表中返回數據的單條SELECT 語句。
--但 SQL 也允許執行多個查詢（多條SELECT 語句），並將結果作為一個查詢結果集返回。
--這些組合查詢通常稱為 union 或複合查詢（compound query）

--主要有兩個情況需要使用組合查詢：
--1.在一個查詢中從不同的表返回結構數據
--2.對一個表執行多個查詢，按一個查詢返回數據

--組合查詢和多個where 條件：
--多數情況下，組合相同表的兩個查詢所完成的工作與具有多個 where 子句條件的一個查詢所完成的工作相同
--任何具有多個 where 子句的 select 語句都可以作為一個組合查詢


--2. 創建組合查詢
--可用 union 操作符來組合數條 SQL 查詢
--利用 union 可給出多條 SELECT 語句，將他們的結果組合成一個結果集

--2.1 使用 union
--在各條 SELECT 語句之間放上關鍵字UNION

--例子，需要Illinois、Indiana、Michigan 等幾個州的所有顧客報表，再包括不管位於哪個州的所有Fun4All 
--單條語句：
SELECT cust_name, cust_contact, cust_email
FROM customers
WHERE cust_state IN ('IL','IN','MI');

SELECT cust_name, cust_contact, cust_email
FROM customers
WHERE cust_name = 'Fun4All';

--組合查詢：
SELECT cust_name, cust_contact, cust_email
FROM customers
WHERE cust_state IN ('IL','IN','MI')
UNION
SELECT cust_name, cust_contact, cust_email
FROM customers
WHERE cust_name = 'Fun4All';

--多條 WHERE 子句：
SELECT cust_name, cust_contact, cust_email
FROM customers
WHERE cust_state IN ('IL','IN','MI')
OR    cust_name = 'Fun4All';
