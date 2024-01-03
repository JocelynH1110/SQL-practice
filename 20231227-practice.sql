
----------LESSON 4 過濾數據-------------
--單值檢查
SELECT prod_name,prod_price
FROM Products
WHERE prod_price=3.49;

--不匹配檢查
--<>等同於!=
--值為字串要用單引號,數值則不用
SELECT vend_id,prod_name
FROM Products
WHERE vend_id <> 'DLL01';

--範圍值檢查
--需要兩個值，開始值及結束值
SELECT prod_name,prod_price
FROM Products
WHERE prod_price BETWEEN 5 AND 10;

--空值檢查
SELECT prod_name
FROM Products
WHERE prod_price IS NULL;

SELECT cust_name
FROM CUSTOMERS
WHERE cust_email IS NULL;


----------LESSON 5 高級過濾數據-------------
--AND 操作符（operator）
--可以有不只一個and 在同一個where裡
--以下為搜尋由DLL01供應商製造且價格小於等於4的資料
SELECT prod_id,prod_price,prod_name
FROM Products
WHERE vend_id = 'DLL01' AND prod_price <= 4;

--OR 操作符
--當第一個條件符合就會印出，不會在計算第二個條件
SELECT prod_name,prod_price
FROM Products
WHERE vend_id = 'DLL01' OR vend_id = 'BRS01';

--求值順序
--and/or可以混合使用
--AND會優先於OR處理
--以下為印出BRS01大於等於10的產品名和DLL01所有產品名
SELECT prod_name,prod_price
FROM Products
WHERE vend_id = 'DLL01' OR vend_id = 'BRS01' AND prod_price >= 10;

--印出DLL01或BRS01製造且價格在10元以上的產品名
SELECT prod_name,prod_price
FROM Products
WHERE (vend_id = 'DLL01' OR vend_id = 'BRS01') AND prod_price >= 10;

--IN 操作符
--用來指定條件範圍，範圍中每個條件都可以匹配
--功能與OR相當
SELECT prod_name,prod_price
FROM products
WHERE vend_id IN ('DLL01','BRS01')
ORDER BY prod_name;

--NOT 操作符
--用來否where子句後的條件
--放在過濾的列前
--印出除了DLL01的產品名
SELECT prod_name
FROM products
WHERE NOT vend_id = 'DLL01'
ORDER BY prod_name;
