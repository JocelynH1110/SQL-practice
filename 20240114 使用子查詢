----------LESSON 11 使用子查詢-------------
--1.子查詢
--SELECT 語句是 SQL 的查詢
--目前所學到的都是簡單查詢，從單個數據庫表中檢索數據的單條語句
--能嵌套的子查詢數目沒有限制，不過在實際使用時由於性能的限制，不能嵌套太多的子查詢


--2.利用子查詢（subquery）進行過濾
--子查詢總是由內而外處理

--檢索包含物品RGAN01的所有訂單編號
SELECT order_num
FROM orderItems
WHERE prod_id = 'RGAN01';

--檢索具有前一步驟列出的訂單編號之所有顧客的ID
SELECT cust_id
FROM orders
WHERE order_num IN (20007,20008);

--將以上兩個寫成子查詢：
SELECT cust_id
FROM orders
WHERE order_num IN (SELECT order_num
                    FROM orderItems
                    WHERE prod_id = 'RGAN01');

--檢索前一步驟返回的所有顧客ID的顧客訊息
SELECT cust_name,cust_contact
FROM customers
WHERE cust_id IN (SELECT cust_id
                  FROM orders
                  WHERE order_num IN (SELECT order_num
                                      FROM orderItems
                                      WHERE prod_id = 'RGAN01'));

--Note
--作為子查詢的 SELECT 語句只能查詢單個列，若檢索多個列將返回錯誤


--3.作為計算字段使用子查詢
--以下使用了完全限定列名，若不採用則DBMS會認為要對 orders 表中的cust_id 自身進行比較
SELECT cust_name,cust_state,(SELECT COUNT(*)
                             FROM orders
                             WHERE orders.cust_id = customers.cust_id) AS orders
FROM customers
ORDER BY cust_name; 

--Note
--完全限定列名：如果在SELECT 語句中操作多個表，就應該使用完全限定列表來避免歧義
