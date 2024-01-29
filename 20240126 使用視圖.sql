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

--創建視圖後可以用與表基本相同的方式使用它們。
--可對視圖執行SELECT 操作、過濾、排序數據，將視圖連結到其他視圖或表，甚至增加或更新數據（但有限制）。

--Note 性能問題
--因為視圖不包含數據，故每次使用時都必須處理查詢執行時需要的所有檢索。
--若你使用多個聯結和過濾創見了複雜的視圖或嵌套了視圖，性能可能會下降得很厲害。因此在部署大量的視圖應用前，應進行測試。

--1.2 視圖的規則和限制
--不同的 DBMS 有不同的限制。

--以下是創建視圖和使用上最常見的規則和限制：
--1.視圖須有單獨名稱。（不能給視圖取和別的視圖或和表相同的名字）
--2.對可創建的視圖數目沒有限制。
--3.創建視圖須有足夠的訪問權限。（權限通常由數據庫管理人授予）
--4.視圖可以嵌套，可以利用從其他視圖中檢索數據的查詢來構造視圖。所允許的嵌套層數在不同的 DBMS 中有所不同（嵌套視圖可能會嚴重降低查詢的性能，故在正式使用前應對其進行全面測試）
--5.許多 DBMS 禁止在視圖查詢中使用 ORDER BY 子句。
--6.有些 DBMS 要求對返回的所有列進行命名，若列是計算字段，則需使用別名（Lesson 7）
--7.視圖不能索引，也不能有關聯的觸發器或預設值。
--8.有些 DBMS 把視圖作為只讀的查詢。表示可以從視圖檢索數據，但不能將數據寫回底層表。
--9.有些 DBMS 允許創建這樣的視圖，它不能進行導致行不再屬於視圖的插入或更新。（例如、有個視圖只檢索有信箱的顧客。如果更新某個客戶，刪除他的信箱，將使該客戶不再屬於視圖）這是默認行為，且是允許的，但有的 DBMS 可能會防止這種情況發生。


--2. 創建視圖
--視圖用 CREATE VIEW 語句來創建。與 CREATE TABLE 一樣，只能用於創建不存在的視圖。

--說明：視圖重命名
--刪除視圖可以用 DROP 語句，語法為 DROP VIEW viewname;。
--覆蓋或更新視圖，必須先刪掉它再重建。

--2.1 利用視圖簡化複雜的聯結
--最常見的視圖應用是：隱藏複雜的 SQL ，這通常涉及聯結。

--例子
DROP VIEW productCustomers;

CREATE VIEW productCustomers AS
SELECT cust_name, cust_contact, prod_id
FROM customers, orders, orderItems
WHERE customers.cust_id = orders.cust_id
AND orderItems.order_num = orders.order_num;

--分析
--上面語句創建了一個名為 productCustomers 的視圖，它聯結三個表，返回已訂購了任意商品的所有顧客列表。
--如果執行 SELECT * FROM productCustomers，將會列出訂購任意產品的顧客。

--例子、檢索訂購產品 RGAN01 的 顧客：
SELECT cust_name, cust_contact
FROM productCustomers
WHERE prod_id = 'RGAN01';

--分析
--由上面例子可看出視圖極大的簡化了複雜 SQL 語句的使用。
--利用視圖，可一次行編寫基礎的 SQL ，再根據需要多次使用。

--Tip 創建可重用的視圖
--創建不綁定特定數據的視圖，增加其可重複使用度。
--擴展視圖的範圍不僅能使它被重用，而且可能更有用。這樣做不需要創建和維護多個類似視圖。

--2.2 用視圖重新格式化檢索出的數據
--視圖另一常見用途是重新格式化檢索出的數據。

--例子、在單個組合計算列中返回供應商名和位置：（Lesson 7 的例子）
SELECT RTRIM(vend_name) || '(' || RTRIM(vend_country)||')'
       AS vend_title
FROM vendors
ORDER BY vend_name;

--例子、把以上例子轉成視圖
DROP VIEW vendorLocations;
CREATE VIEW vendorLocations AS
SELECT RTRIM(vend_name) || '(' || RTRIM(vend_country)||')'
       AS vend_title
FROM vendors
ORDER BY vend_name;

--例子、把上面的視圖列出來
SELECT *
FROM vendorLocations;
