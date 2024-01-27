----------LESSON 18 使用視圖-------------
--視圖是虛擬的表，只包含使用時動態檢索數據的查詢，和包含數據的表不一樣。

--例子、從三個表中檢索數據
SELECT cust_name, cust_contact
FROM customers, orders, orderItems
WHERE customers.cust_id = orders.cust_id
AND   orderItems.order_num = orders.order_num
AND   prod_id = 'RGAN01';

--假如可以把上面例子整個查詢包裝成一個叫 productCustomers 的虛擬表，則可如下輕鬆的檢索出相同數據
-- SELECT cust_name, cust_contact
-- FROM productCustomers
-- WHERE prod_id = 'RGAN01';

--這就是視圖的作用。productCustomers 是一個視圖，作為視圖，它不包含任何列或數據，包含的是一個查詢（與上面用以正確連結表的相同查詢）。

--Tip DBMS 的一致支持
--所有的 DBMS 非常一致的支持視圖創建語法。

--1.1 為什麼使用視圖
--以下為視圖的常見應用：
--1.重用 SQL 語句
--2.簡化複雜的 SQL 操作。在編寫查詢後，可以方便的重用它而不必知道其基本查詢細節。
--3.使用表的一部分而不是整個表。
--4.保護數據。可授予用戶訪問表的特定部份權限，而不是整個表的訪問權限。
--5.更改數據格式和表示。視圖可返回與底層表的表示和格式不同的數據。

--Note 性能問題

