
----------LESSON 6 用通配符過濾數據-------------
--通配符（wildcard），用來匹配部份值的特殊字符，只能用來找字串''，是where子句中有特殊含意的字符。
--通配符使用技巧：
--通配符搜索比其他搜索耗費更長時間處理
--把通配符放在開始處，搜索起來是最慢的

--LIKE 操作符
--使用在未知值時。
--要在搜索子句中用通配符時，必須使用like。

-- % 百分比通配符
--最常使用。表示任何字符出現任意次數
--無法匹配null的行
--like前加i表示不分大小寫
--以下表示以 fish 開頭的句子
SELECT prod_id,prod_name
FROM products
WHERE prod_name iLIKE 'fish%';

--表前後出現任意字符
SELECT prod_id,prod_name
FROM products
WHERE prod_name iLIKE '%bean bag%';

--F開頭y結尾的所有商品
--用在搜尋信箱蠻有用的 ex.'b%@gmail.com'
SELECT prod_id,prod_name
FROM products
WHERE prod_name iLIKE 'F%y';

-- % 能匹配0字符
--以下在y後加％為匹配y後面的空字符
SELECT prod_id,prod_name
FROM products
WHERE prod_name iLIKE 'F%y%';


-- _ 下劃線通配符
--用途跟 % 一樣，但只匹配單個字符
--後面加了％因為文檔用的是char所以後面有空格會導致搜尋不到
SELECT prod_id,prod_name
FROM products
WHERE prod_name LIKE '__ inch teddy bear%';

-- % 可以匹配零個字符，_ 只能一個不能多不能少
SELECT prod_id,prod_name
FROM products
WHERE prod_name LIKE '% inch teddy bear%';


-- [] 方括號通配符
--找出名字開頭J或M開頭的聯絡人
SELECT cust_contact
FROM customers
WHERE cust_contact similar to '[JM]%'
ORDER BY cust_contact;

--加上前綴符（脫字號）來否定
--優點：在使用多個where子句可以簡化語法
--顯示名字開頭非J或M的
SELECT cust_contact
FROM customers
WHERE cust_contact similar to '[^JM]%'
ORDER BY cust_contact;
