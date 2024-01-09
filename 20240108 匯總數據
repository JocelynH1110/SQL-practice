----------LESSON 9 匯總數據-------------
--聚集函數（aggregate function）
--解釋：對某些行運行的函數，計算並返回一個值
--只是需要計算後的值，實際表提供的值不須返回，浪費時間與處理資源
--以下為五種聚集函數

--1. AVG() 函數
--只能用於單個列，列名也必須作為函數參數。
--要獲得多個列的平均值，須使用多個AVG()函數
--會忽略列值為null的行

--可用來返回所有列
SELECT AVG(prod_price) AS avg_price
FROM products;

--返回特定列或行的平均值
SELECT AVG(prod_price) AS avg_price
FROM products
WHERE vend_id = 'DLL01';

--2. COUNT() 函數
--用來計算表中行的數目或符合特定條件的行的數目

--有兩種使用方法：
--count(*):以下是用來對表中行的數目進行計數，不論是否為null都會計算
SELECT COUNT(*) AS num_cust
FROM customers;

--對cust_email列中有值的行進行計數，空值忽略
SELECT COUNT(cust_email) AS num_cust
FROM customers;

--3. MAX() 函數
--返回指定列中的最大值，MAX()要求指定列名
--會忽略列值為null的行
--除了返回數值和日期值，也可以返回文本列中的最大值，其返回文本數據按該排列後的最後一行
SELECT MAX(prod_price) AS max_price
FROM products;

--4. MIN() 函數
--功能與MAX()相反
SELECT MIN(prod_price) AS mi_price
FROM products;

--5. SUM() 函數
--會忽略值為null的行
--用來返回指定列值的和
SELECT SUM(quantity) AS items_ordered
FROM orderItems
WHERE order_num = 20005;

--在多個列上進行計算
SELECT SUM(item_price*quantity) AS total_price
FROM orderItems
WHERE order_num = 20005;


--聚集不同值
--以上五種聚集函數都可以：
--1.對所有行進行計算，指定all參數或不指定參數（all是默認行為）
--2.只包含不同的值，指定distinct參數
--以下distinct將同價格產品排除了，故提昇了他們的平均值
--distinct須使用列名，不能用於計算或表達式
SELECT AVG(DISTINCT prod_price) AS avg_price
FROM products
WHERE vend_id = 'DLL01';

--組合聚集函數
--select可以一次使用多個聚集函數
SELECT COUNT(*) AS num_items,
       MIN(prod_price) AS price_min,
       MAX(prod_price) AS price_max,
       AVG(prod_price) AS price_avg
FROM products;
