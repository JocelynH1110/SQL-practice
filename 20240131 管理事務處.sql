----------LESSON 20 控制事務處理-------------
--本課介紹如何用 COMMIT 和 ROLLBACK 語句管理事務處理。

--1. 事務處理（transaction processing）
--使用事務處理，通過確保成批的 SQL 操作要麼完全執行，要麼完全不執行，來維護數據庫的完整性。
--如果沒有錯誤發生，整組語句寫到數據庫表：如果發生錯誤，則進行撤銷，將數據庫恢復到某個已知且安全的狀態。

--以下是幾個事務處理的術語：
--事務（transaction）：指一組 SQL 語句。
--回退（rollback）：指撤銷指定 SQL 語句的過程。
--提交（commit）：指將未存儲的 SQL 語句結果寫入數據庫表。
--保留點（savepoint)：指事務處理中設置的臨時佔位符（placeholder），可對它發布回退（與回退整個事務處理不同）。

--Tip、可以回退哪些語句？
--事務處理用來管理 INSERT、UPDATE、DELETE 語句。
--不能回退 SELECT 不能回退語句，也不能回退 CREATE 或 DROP 操作。
--事務處理中可以使用這語句，但進行回退時，這些操作也不撤銷。


--2. 控制事務處理
--管理事務的關鍵在於將 SQL 語句組分解為邏輯塊，並明確規定數據何時應該回退，何時不該回退。

--有的 DBMS 要求明確標示事務處理塊的開始和結束。以下為 PSQL 的代碼：
--BEGIN
--...

--多數實現沒有明確標識是在何時結束。事務一直存在，直到被中斷。通常 COMMIT 用於保存更改，ROLLBACK 用於撤銷。 

--2.1 使用 ROLLBACK
--用來撤銷 SQL 語句。
DELETE FROM orders;
ROLLBACK;

--2.2 使用 COMMIT
--一般 SQL 語句都是針對數據庫直接執行和編寫。這就是所謂的隱式提交（implicit commit），即提交（寫或保存）操作都是自動進行的。
--在事務處理塊中，提交不會隱式進行。但不同的 DBMS 有不同的作法。
BEGIN;
DELETE orderItems WHERE order_num = 12345
DELETE orders WHERE order_num = 12345
COMMIT;

--分析、
--這例子要刪除的訂單涉及兩個表，所以使用事務處理來保證不被部份刪除。
--最後的 COMMIT 僅在前兩句不出錯下寫出更改，若出錯則 DELETE 不會提交。

--2.3 使用保留點（savepoint）
--簡單的事務可以用 ROLLBACK 和 COMMIT 處理。複雜的事務要部分提交或回退，可能要使用到 占位符（保留點 SAVEPOINT）。
--要使用回退部份事務，必須在事務處理塊中的合適位置放置占位符。

--語句為：每個保留點都要取能夠識別他的唯一名字
SAVEPOINT delete1;

--退到保留點的語句為：
ROLLBACK TO SAVEPOINT delete1;

--Tip、保留點越多越好
--可以在 SQL 代碼中設置任意多的保留點，越多越好。保留點越多，越能靈活的進行回退。
