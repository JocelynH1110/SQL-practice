----------LESSON 12 聯結表-------------
--1.連結（join)
--SQL最強大的功能之一就是能在數據查詢的執行中連結表

--關係表
--將信息分解成多個表，一類數據一個表，各表通過某些共同的值相互關聯（關係數據庫）

--為什麼使用連結
--若數據存在多個表中，能用聯結的方式用一條 SELECT 語句就檢索出數據。


--2.創建聯結
--指定要聯結的所有表及關聯他們的方式即可
SELECT vend_name, prod_name, prod_price
FROM vendors, products
WHERE vendors.vend_id = products.vend_id;

--2.1 WHERE 子句的重要性
--在聯結兩個表時，實際要做的是將表一的每一行與表二的每一行配對。 
--WHERE 子句作為過濾條件，指包含那些匹配給定條件（這裡是聯結條件）行。
--沒有WHERE 子句，表一的每一行將與表二的每一行配對，不管邏輯上是否能配在一起

--Note 要保證所有連結都有 WHERE 子句，否則 DBMS 將返回比想要的數據還要更多的數據

--2.2 內聯結（inner join）
--目前為止使用的聯結稱為等值聯結（equijoin），也稱為內聯結
--它基於兩個表之間的相等測試

--以下返回跟上面例子一樣數據
--用inner join 連結兩個表時，連結條件用特定的 on 給出而不是 where
SELECT vend_name, prod_name, prod_price
FROM vendors INNER JOIN products
ON vendors.vend_id = products.vend_id;

--2.3 聯結多個表
-- SQL 不限制一條 SELECT 語句中可以聯結的表的數目。

SELECT prod_name, vend_name, prod_price, quantity
FROM orderItems, products, vendors
WHERE products.vend_id = vendors.vend_id
AND orderItems.prod_id = products.prod_id
AND order_num = 20007;

--Note 性能考慮：
--不要聯結不必要的表，聯結的表越多，性能下降越厲害

--Note 聯結中表的最大數目：
--雖然SQL本身不限制每個聯結約束中表的數目，但實際上許多 DBMS 都有限制。

--改寫 Lesson 11 的例子：
SELECT cust_name,cust_contact
FROM customers
WHERE cust_id IN (SELECT cust_id
                  FROM orders
                  WHERE order_num IN (SELECT order_num
                                      FROM orderItems
                                      WHERE prod_id = 'RGAN01'));

SELECT cust_name, cust_contact
FROM customers, orders, orderItems
WHERE customers.cust_id = orders.cust_id
AND orderItems.order_num = orders.order_num
AND prod_id = 'RGAN01';
