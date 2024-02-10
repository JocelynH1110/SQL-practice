
----------LESSON 2 索引數據-------------
--索引單列
--從Products裡列出prod_name
--關鍵字大寫(大小寫不分,但易於閱讀)
--結尾要打分號
SELECT prod_name
FROM Products;

--索引多列
--列名間要用逗號區隔,最後一個列不要加逗號會錯誤
SELECT prod_id,prod_name,prod_price
FROM Products;

--索引所有列
SELECT *
FROM Products;

--剔除重複的列值
--distinct要放在列名前面
SELECT DISTINCT vend_id
FROM Products;

--限制返回行數
--第一個數字從那開始，第二個數字探索的行數
--第一個被探索的是第零行
SELECT prod_name
FROM Products
LIMIT 5;

SELECT prod_name
FROM Products
LIMIT 5 OFFSET 5;


----------LESSON 3 排序數據-------------
--單列排序
--依照字母順序排序，數字在前
--order by要在所有句子最後面，不然會錯誤
--order by的列也可以是非在select上的列名
SELECT prod_name
FROM Products
ORDER BY prod_name;

--多列排序
--要先被排序的放前面
--若先被排序的值一樣，那後面的值才會排序
SELECT prod_id,prod_price,prod_name
FROM Products
ORDER BY prod_price,prod_name;

--多列排序簡寫
--好處：少打，壞處：select要給明確列名，未來更改select容易忘記改order by
SELECT prod_id,prod_price,prod_name
FROM Products
ORDER BY 2,3; 

--單列排序降冪
--DESC是descending縮寫，兩者皆可用。
--ASC是ascending縮寫，為預設值，升冪。
--以下為最貴價格排最前面
SELECT prod_id,prod_price,prod_name
FROM Products
ORDER BY prod_price DESC; 

--多列排序降冪
--若要對多個列做排序，要在每個列名後打DESC
SELECT prod_id,prod_price,prod_name
FROM Products
ORDER BY prod_price DESC,prod_name;
