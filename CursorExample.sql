--CREATE PROCEDURE spCounter
--AS

--DECLARE @Counter INT = 1;

--WHILE @Counter <=10 
--BEGIN 
--PRINT @Counter;
--SET @Counter = @Counter�+�1;
--END;

--Orders tablosundan 1997 y�l�na ait 1 numaral� �al��an�m�n sorumlu oldu�u ve sadece UK �lkesindedki sadece London'a g�nderilen �r�nlerin sipari� numaras�, hangi m��teriye gitti�i ve hangi ta��mac� �irketi ile yap�ld���n� listeleyen bir sp yaz�n�z.(Cursor yap�s�n� kullan�n�z)

--ALTER PROCEDURE csOrderReport --YEN� �S�M VERD�K
--AS
--BEGIN

--DECLARE @vs_OrderID int --de�i�ken tan�mlad�k
--DECLARE @vs_CustomerID nchar(5)
--DECLARE @vs_ShipCompany nvarchar(50)

--DECLARE CurOrders Cursor --Cursor tan�mlad�k
--FOR 
--	SELECT OrderID,CustomerID,CompanyName FROM Orders
--	INNER JOIN Shippers on Orders.ShipVia=Shippers.ShipperID
--	WHERE YEAR(OrderDate)=1997 and EmployeeID=1 and ShipCountry='UK'and ShipCity='London'

--OPEN CurOrders --cursor a��ld�
--FETCH NEXT FROM CurOrders INTO @vs_OrderID, @vs_CustomerID, @vs_ShipCompany --ilk kayd� oku

--WHILE @@FETCH_STATUS =0 --Kay�t okumas� ba�ar�l� ve bir kay�t geldi.
--BEGIN 

--	PRINT 'Sipari� Numaras�: ' + Convert(nvarchar(20),@vs_OrderID )+ 'M��teri Kodu: ' + @vs_CustomerID + 'Ta��mac� �irket: ' + @vs_ShipCompany
--	FETCH NEXT FROM CurOrders INTO @vs_OrderID, @vs_CustomerID, @vs_ShipCompany --Bir sonraki kayd� oku

--END --Kay�tlar bitti
--CLOSE CurOrders -- Cursoru'� kapat
--DEALLOCATE CurOrders
--END

alter procedure BackupAll
as
begin --Bu prosed�r sql server �zerinde o an tan�ml� olan t�m verileri bir anda yedekler

DECLARE @name VARCHAR(50) -- database name 
DECLARE @path VARCHAR(256) -- path for backup files 
DECLARE @fileName VARCHAR(256) -- filename for backup 
DECLARE @fileDate VARCHAR(20) -- used for file name 

SET @path = 'C:\PY100KY\' 

SELECT @fileDate = CONVERT(VARCHAR(20),GETDATE(),112) 

DECLARE db_cursor CURSOR FOR 
SELECT name 
FROM MASTER.dbo.sysdatabases 
WHERE name NOT IN ('master','model','msdb','tempdb') 

OPEN db_cursor  
FETCH NEXT FROM db_cursor INTO @name  

WHILE @@FETCH_STATUS = 0  
BEGIN  
      SET @fileName = @path + @name + '-' + @fileDate + '.BAK' 
      BACKUP DATABASE @name TO DISK = @fileName 

      FETCH NEXT FROM db_cursor INTO @name 
END 

CLOSE db_cursor  
DEALLOCATE�db_cursor�

end