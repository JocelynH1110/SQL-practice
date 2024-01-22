----------LESSON 16 更新和刪除數據-------------
--1.更新數據
--有兩種使用 UPDATE 的方式：
--更新表中的特定行
--更新表中的所有行

--Note 不要省略 WHERE 子句：要小心使用 UPDATE ，稍有不慎就會更新表中的所有行。
--Tip UPDATE 與安全：
--在客戶端/伺服器的 DBMS 中，使用 UPDATE 語句可能需要特殊的安全權限。使用前應確保有足夠的權限。

--基本的 UPDATE 語句由三個部份組成：
--1.要更新的表
--2.列名和新值
--3.確定要更新哪些行的過濾條件

--例子，客戶1000000005 現在有了電子郵件，故需要更新紀錄：
UPDATE customer
SET cust_email = 'kim@thetoystore.com'
WHERE cust_id = '1000000005';

--分析
--UPDATE 後接要更新的表名
--SET 將新值賦給被更新的列
--WHERE 指定那一行被更新
--若沒有 WHERE ，DBMS 將會用這個郵件更新 customers 表中所有的行

--更新多個列：
UPDATE customer
SET cust_email = 'sam@toyland.com',
    cust_contact = 'Sam Roberts' 
WHERE cust_id = '1000000006';

--分析
--只須使用一個 SET，之間用逗號分隔（最後一列之後不用）

--Tip 在 UPDATE 語句中使用子查詢：
--可以使用子查詢，能用 SELECT 語句檢索出的數據更新列數據。

--Tip FROM 關鍵字：
--有些 SQL 支持在 DBMS 語句中使用 FROM 子句，用一個表的數據更新另一個表的行。要看是否支持，請參閱文檔。

--要刪除某個列的值，可以設置它為 NULL （假如表定義允許 NULL 值）
--例子：
UPDATE customer
SET cust_email = NULL 
WHERE cust_id = '1000000005';

--空字符串用''表示是一個值，而 NULL 表示沒有值。


--2.刪除數據
--有兩種使用 DELETE 的方式：
--1.從表中刪除特定的行
--2.從表中刪除所有的行

--Note 不要省略 WHERE 子句：要小心使用 DELETE ，稍有不慎就會刪除表中的所有行。
--Tip DELETE 與安全：
--在客戶端/伺服器的 DBMS 中，使用 DELETE 語句可能需要特殊的安全權限。使用前應確保有足夠的權限。

--例子，從 customers 表中刪除一行：
DELETE FROM customer
WHERE cust_id = '1000000006';

--若是省略 WHERE 子句，它將刪除表中每個顧客。

--Tip FROM 關鍵字：
--在某些 SQL 實現中，DELETE 後的關鍵字 FROM 是可選的。即使不需要，最好也提供，以保證 SQL 代碼在 DBMS 之間的可移植。

--DELETE 不需要列名或通配符。他是刪除整行而不是整列。
--要刪除指定的列，要用 UPDATE。（指定為 null）

--說明：刪除表的內容不是表
--它刪除表中的行，或是所有行。但是不刪除表本身。

--Tio 更快的刪除：
--若想從表中刪除所有行，可以使用 TRUNCATE TABLE 語句，它完成相同工作，且速度更快（因為不紀錄數據的變動）。
