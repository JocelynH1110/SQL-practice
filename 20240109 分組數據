----------LESSON 10 分組數據-------------
--匯總表內容的子集。
--涉及兩個新的SELECT語句子句：GROUP BY子句、HAVING子句
--使用分組可以將數據分為多個邏輯組，對每個組進行聚集計算

--數據分組
--所有計算都是在表的所有數據或批配特定 where 子句的數據上進行
--以下為返回供應商DLL01提供的產品數目
SELECT COUNT(*) AS num_prods
FROM products
WHERE vend_id = 'DLL01';


--創建分組
--分組是使用select語句的group by子句建立，其也能進行過濾分組
--DMBS按vend_id排序並分組數據，而不是整個表都計算一次
SELECT vend_id,COUNT(*) AS num_prods
FROM products
GROUP BY vend_id;

--使用 GROUP BY 子句的規定：
--1.可以包含任意數目的列，因此可以對分組進行嵌套，更細緻的進行數據分組
--2.如果在子句中嵌套了分組，數據將在最後指定的分組上進行匯總
--3.列出的每一個列都必須是索引列或有效的表達式（但不能是聚集函數）。若在SELECT中使用表達式，則須在 GROUP BY 中指定相同的表達式，不能使用別名
--4.SELECT 語句中的每一列都必須在 GROUP BY 子句中打出。（聚集計算語句例外）
--5.如果分組列中包含 null 值的行，則 null 將作為一個分組返回。如果列中有多行 null 值，他們將分為一組
--6. GROUP BY 子句必須出現在 WHERE 子句後，ORDER BY 子句前

--NOTE
--GROUP BY 可透過 SELECT 列表中的位置指定其列。例如、GROUP BY 2,1 可表示按選擇的第二個列分組，再按第一個列分組。雖然方便但非所有sql都支持，且很容易在編輯SQL語句時出錯


--過濾分組
--HAVING 非常類似於WHERE，目前所學過得 WHERE 子句都可以用 HAVING 替代 
--若不指定 GROUP BY，則大多數 DBMS 會等同對待。使用 HAVING 時應結合 GROUP BY 子句
--WHERE 過濾行，HAVING 過濾分組

SELECT cust_id,COUNT(*) AS orders
FROM orders
GROUP BY cust_id
HAVING COUNT(*)>= 2;


--分組和排序
--GROUP BY 和 ORDER BY 經常完成相同的工作，但他們非常不同
--ORDER BY 對產生的輸出排序，GROUP BY 對行分組但輸出不一定是分組順序
--故要確保數據正確排序的唯一方法就是同時也給予 ORDER BY

SELECT order_num, COUNT(*) AS items
FROM orderItems
GROUP BY order_num
HAVING COUNT(*) >= 3;

SELECT order_num, COUNT(*) AS items
FROM orderItems
GROUP BY order_num
HAVING COUNT(*) >= 3
ORDER BY items, order_num;


-- SELECT 子句順序
--SELECT    要返回的列或表達式
--FROM      從中檢索數據的表
--WHERE     行級過濾
--GROUP BY  分組說明
--HAVING    組級過濾
--ORDER BY  輸出排序順序
