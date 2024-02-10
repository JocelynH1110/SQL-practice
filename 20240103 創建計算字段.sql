----------LESSON 7 創建計算字段（field）-------------
--將存儲在表中的數據直接在資料庫中做計算後轉換成應用程式所需的數據
--計算字段是在select內創建的
--只有資料庫知道哪些是實際列表哪些是計算字段
--轉換和格式化都可以在客戶端的應用程序內完成，但一般來說在資料庫伺服器上完成比在客戶端完成要快的多

--1.拼接字段(concatenate field)
--將兩個值連接到一起構成單個值
SELECT vend_name ||'(' || vend_country ||')'
FROM vendors
ORDER BY vend_name;

--去掉列寬的空格
--TRIM()去掉字串左右兩邊空格
--RTRIM()去掉字串右邊空格
--LTRIM()去掉字串左邊空格
SELECT RTRIM(vend_name) ||'(' || RTRIM(vend_country) ||')'
FROM vendors
ORDER BY vend_name;

--為新的拼接的列取名
--未命名的列不能於客戶端應用，因為客戶端無法引用它
SELECT RTRIM(vend_name) ||'(' || RTRIM(vend_country) ||')' AS vend_title
FROM vendors
ORDER BY vend_name;


--2.算術計算
--列出訂單號為20008中的所有物品
SELECT prod_id,quantity,item_price
FROM orderItems
WHERE order_num = 20008;

--計算物品總價並取名
SELECT prod_id,quantity,item_price,quantity*item_price AS expended_price
FROM orderItems
WHERE order_num = 20008;
