----------LESSON 13 創建高級聯結-------------
--1.使用表別名
--可以用在where 子句、select 列表、order by 子句等等

--給列起別名的例子如下：
SELECT RTRIM(vend_name) || '(' || RTRIM(vend_country) || ')'
       AS vend_title
FROM vendors
ORDER BY vend_name;

--SQL 除了可以對列名和計算字段使用別名，還可以給表名起別名。
--這樣做主要有兩個原因：
--縮短 SQL 語句
--允許在一條SELECT 語句中多次使用相同的表

--以下將上一課改成了使用別名：
SELECT cust_name, cust_contact
FROM customers AS C ,orders AS O, orderItems AS OI
WHERE C.cust_id = O.cust_id
AND   OI.order_num = o.order_num
AND   prod_id = 'RGAN01';

--Note 列表名只在查詢執行中使用，不反回到客戶端，與列名不同。


--2.使用不同類型的聯結
--自聯結（self-join）、自然聯結（natural join）、外聯結（outer join）

--2.1 自聯結（self-join）
--題目：要給Jim Jones同一公司的所有顧客發一封信。
--首先找出 Jim Jones 工作的公司，然後找出該公司工作的顧客
--第一種解法：子查詢（lesson 11）
SELECT cust_id, cust_name, cust_contact
FROM customers
WHERE cust_name = (SELECT cust_name
                   FROM customers
                   WHERE cust_contact = 'Jim Jones');

--第二種解法：自聯結
--由於使用的是兩個相同的表，雖然合法但對customers 的引用具有歧義性，因為 DBMS 不知道引用的是哪個 customers
--故為解決此問題需要使用表列名。select 語句明確給出所需列的全名,不然 DBMS 將返回錯誤
--WHERE 聯結兩個表，然後按第二個表的cust_contact 過濾數據，返回所需數據
SELECT c1.cust_id, c1.cust_name, c1.cust_contact
FROM customers AS c1, customers AS c2
WHERE c1.cust_name = c2.cust_name
AND c2.cust_contact = 'Jim Jones';

--Tip 用自聯結而不用子查詢：
--自聯結通常作為外部語句，用來替代從相同表中檢索數據使用子查詢語句。
--雖然最終結果相同，但許多DBMS 處理聯結比處理子查詢快。
