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

--UNION 的限制
--使用 UNION 組合 SELECT 語句的數目，SQL 沒有標準限制。但還是可以參考一下 DBMS 文檔，看看否有所限制。

--性能問題
--理論上，使用多條 WHERE 子句條件和 UNION 是沒有實際上的差別。因為多數 DBMS 使用內部查詢優化程序，在處理各條 SELECT 語句前組合他們。但實踐中多數查詢優化程序並不能達到理想狀態，所以最好測試這兩種方法，看哪種適合

--2.2 UNION 規則
--進行組合時的規則：
--必須由兩條或兩條以上的 SELECT 語句組成，語句之間用關鍵字 UNION 分隔。
--UNION 中每個查詢必須包含相同的列、表達式或聚集函數（各列不需要以相同次序列出）。
--列數據類型必須兼容：類型不必完全相同，但必須是 DBMS 可以隱含轉換的類型（例、不同的數值類型或不同的日期類型）。
--遵守以上規則和限制，則可將 UNION 用於任何數據檢索操作。

-- 2.3 包含或取消重複的行
--UNION 會自動在返回的結果中去除重複的行，與在一個SELECT 語句中使用多個 WHERE 子句條件一樣。
--若想返回所有匹配的行，可使用 UNION ALL 而不是 UNION 。

--以下為 UNION ALL 例句，DBMS 不取消重複的行
SELECT cust_name, cust_contact, cust_email
FROM customers
WHERE cust_state IN ('IL','IN','MI')
UNION ALL
SELECT cust_name, cust_contact, cust_email
FROM customers
WHERE cust_name = 'Fun4All';

--UNION 與 WHERE
--UNION 幾乎總是完成與多個 WHERE 條件相同的工作。
--UNION ALL 為 UNION 的一種形式，它完成 WHERE 子句完成不了的工作。
--每個條件匹配行全部出現（包含重複行），就必須使用 UNION ALL。

--2.4 組合查詢的結果排序
--用 UNION 組合查詢時，只能使用一個 ORDER BY 子句，它必須位於最後一個 SELECT語句之後。
--因為結果集不存在用一種方式排序一部分，又用另一種方式排序另一部份。

SELECT cust_name, cust_contact, cust_email
FROM customers
WHERE cust_state IN ('IL','IN','MI')
UNION ALL
SELECT cust_name, cust_contact, cust_email
FROM customers
WHERE cust_name = 'Fun4All'
ORDER BY cust_name, cust_contact;

--其他類型的 UNION
--某些DBMS 還支持另外兩種 UNION：
--EXCEPT（有時稱 MINUS ）：用來檢索只在地一個表中存在而第二個表中不存在的行。
--INTERSECT ：用來檢索兩個表中都存在的行。
--實際上，這些 UNION 很少使用，因為相同結果可以用聯結得到。

--操作多個表
--本課例子都是用 UNION 來組合針對同一表的多個查詢。實際上 UNION 在需要組合多個表的數據時也很有用，即使有不匹配列名的表，也可將 UNION 與別名組合，檢索一個結果集。
