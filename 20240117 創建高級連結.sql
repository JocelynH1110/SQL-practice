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

--2.2 自然聯結（natural join）
--無論何時對表進行聯結，應該至少有一列不只出現在一個表中（被聯結的列）
--標準的聯結（lesson 12 的內聯結）返回所有數據,相同的列甚至多次出現
--自然聯結排除多次出現，使每一列只返回一次
--要求只能選擇那些唯一的列，一般通過對一個表使用通配符（SELECT *），而對其他表的列使用明確的子集來完成。以下為例子：
SELECT C.*, O.order_num, O.order_date,
       OI.prod_id, OI.quantity, OI.item_price
FROM customers AS C, orders AS O, orderItems AS OI
WHERE C.cust_id = O.cust_id
AND   OI.order_num = O.order_num
AND   prod_id = 'RGAN01';

--至今為止建立的每個內聯結都是自然聯結，很可能永遠都不會用到不是自然聯結的內聯結

--2.3 外聯結（outer join）
--許多聯結將一個表中的行和另一個表中的行相關聯，但有時會包含沒有關聯行的那些行，這種聯結稱為外聯結

--Note 語法差別：
--用來創建外聯結的語法在不同 SQL 實現中可能稍有不同。

--以下為一個簡單的內聯結。檢索所有顧客及其訂單：
SELECT customers.cust_id, orders.order_num
FROM   customers INNER JOIN orders
ON     customers.cust_id = orders.cust_id;

--外聯結語法類似。要檢索包括沒有訂單顧客在內的所有顧客，例子為下
SELECT customers.cust_id, orders.order_num
FROM   customers LEFT OUTER JOIN orders
ON     customers.cust_id = orders.cust_id;

--在使用 OUTER JOIN 語法時，必須使用 RIGHT 或 LEFT 關鍵字指定包括其所有行的表。
--以上例子 LEFT 指從 FROM 子句左邊的表（customers表）中選擇所有行

--以下為從右邊表中選擇所有行： 
SELECT customers.cust_id, orders.order_num
FROM   customers RIGHT OUTER JOIN orders
ON     orders.cust_id = customers.cust_id;
