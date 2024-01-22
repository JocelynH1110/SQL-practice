----------LESSON 15 插入數據-------------
--1.數據插入
--SELECT 是最常用的 SQL 語句（前14課都在說它）。
--還有其他三個常用的 SQL 語句，這課就是其一，INSERT。
 
 --插入有幾種方式：
 --1.插入完整的行
 --2.插入行的一部分
 --3.插入某些查詢結果

 --Hint 插入及系統安全
 --使用INSERT 語句可能需要客戶端/服務器 DBMS 中的特定安全權限。故在使用前，應確保自己有足夠的安全權限。

 --1.1 插入完整的行
 --需要指定表名和要插入的值
 --每一列都必須提供一個值，若沒有值則應使用 NULL 值（假定表允許對該列指定空值）
 --值要按順序排列
INSERT INTO customers
VALUES ('1000000006',
        'Toy Land',
        '123 Any Street',
        'New York',
        'NY',
        '11111',
        'USA',
        NULL,
        NULL);

--Hint
--在某些 SQL 實現中，INTO 關鍵字是可選的。但還是提供比較好，以確保SQL 代碼在 DBMS 之間可移植。

--分析上面例子：
--語法簡單但不安全，應盡量避免使用。
--其 SQL 語句高度依賴表中列的定義次序，和次序信息。但在表結構變動後很容易出問題。

-- INSERT 語句更安全的寫法（但更繁瑣）：
INSERT INTO customers(cust_id,
                      cust_name,
                      cust_address,
                      cust_city,
                      cust_state,
                      cust_zip,
                      cust_country,
                      cust_contact,
                      cust_email)
VALUES ('1000000006',
        'Toy Land',
        '123 Any Street',
        'New York',
        'NY',
        '11111',
        'USA',
        NULL,
        NULL);

--分析：
--表名後括號裡明確給出列名。值會帶進相對應的列名。
--列名換順序而值跟著換就不會有順序上的問題了。

--Note 小心使用 VALUES：
--不管使用哪種 INSERT 語句，VALUES 的數目都必須正確。
--若不提供列名，則必須給每個表列提供一個值
--若提供列名，則必須給列出的每個列一個值。否則會產生錯誤訊息，相應的行不能成功插入。

--1.2 插入部份行
INSERT INTO customers(cust_id,
                      cust_name,
                      cust_address,
                      cust_city,
                      cust_state,
                      cust_zip,
                      cust_country)
VALUES ('1000000006',
        'Toy Land',
        '123 Any Street',
        'New York',
        'NY',
        '11111',
        'USA');
 
--分析：
--由於有兩個值是空值，故沒有 INSERT 必要，可以直接省略。

--Note 省略列
--省略的列必須滿足以下某個條件:
--該列定義允許 NULL 值（無值或空值）。
--在表定義中給出預設值。這表示如果不給出值，將使用預設值。

--Note 省略所需的值
--如果表中不允許有 NULL 值或預設值，這時卻忽略了表中的值，DBMS 將會產生錯誤消息，無法成功插入。

--1.3 插入檢索出的數據
--INSERT 一般用來給表插入具有指定列值的行。
--另一個型式可以用它將 SELECT 語句的結果插入表中，所謂的 INSERT SELECT。
--顧名思義，它是由一條 INSERT 語句和一條 SELECT 語句組成的。

--例子，想把另一個表中的顧客列合併到 customers 表中：
INSERT INTO customers(cust_id,
                      cust_contact,
                      cust_email,
                      cust_name,
                      cust_address,
                      cust_city,
                      cust_state,
                      cust_zip,
                      cust_country)
SELECT cust_id,
       cust_contact,
       cust_email,
       cust_name,
       cust_address,
       cust_city,
       cust_state,
       cust_zip,
       cust_country
FROM custNew;

--新例子說明：
--從 custNew 表中讀取數據並插入到 customers 表。要驗證是否能成功必須先創建 custNew 表並輸入值。在輸入值時，不應該使用已在 customers 中用過的 cust_id 值（主鍵值重複，後續的 INSERT 將會失敗）。


