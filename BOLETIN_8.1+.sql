--Boletin 8.1 +
--Escribe el código SQL necesario para realizar las siguientes operaciones sobre la base de datos "NorthWind”
USE Northwind
--Consultas sobre una sola Tabla a las que hemos añadido datos de otra


--2. ID de producto y número de unidades vendidas de cada producto.  Añade el nombre del producto
SELECT * FROM Products
SELECT * FROM [Order Details]
SELECT P.ProductName, OD.ProductID, ISNULL(SUM(OD.Quantity),0) AS [Nº DE UNIDADES VENDIDAS] FROM Products AS P LEFT JOIN [Order Details] AS OD ON P.ProductID = OD.ProductID GROUP BY P.ProductName, OD.ProductID, OD.Quantity
--3. ID del cliente y número de pedidos que nos ha hecho. Añade nombre (CompanyName) y ciudad del cliente
SELECT * FROM Orders
SELECT C.CompanyName, C.City, O.CustomerID, ISNULL(COUNT(O.OrderID),0) AS [Nº PEDIDOS] FROM Orders AS O RIGHT JOIN Customers AS C ON O.CustomerID = C.CustomerID GROUP BY C.CompanyName, C.City, O.CustomerID
--4. ID del cliente, año y número de pedidos que nos ha hecho cada año. Añade nombre (CompanyName) y ciudad del cliente,
--así como la fecha del primer pedido que nos hizo.
SELECT C.CustomerID, YEAR(O.OrderDate) AS YEAR, COUNT(O.OrderID) AS [Nº DE PEDIDOS], C.CompanyName, C.City FROM Customers AS C INNER JOIN Orders AS O ON C.CustomerID = O.CustomerID GROUP BY C.CustomerID, YEAR(O.OrderDate), C.CompanyName, C.City ORDER BY C.CustomerID, YEAR(O.Orderdate)
--5. ID del producto, precio unitario y total facturado de ese producto, ordenado por cantidad facturada de mayor a menor.
--Si hay varios precios unitarios para el mismo producto tomaremos el mayor. Añade el nombre del producto
SELECT * FROM Products
SELECT * FROM [Order Details]
SELECT P.ProductName, P.ProductID, MAX(OD.UnitPrice) AS UNITPRICE, SUM(OD.UnitPrice * OD.Quantity) AS [TOTAL FACTURADO] FROM Products AS P INNER JOIN [Order Details] AS OD ON P.ProductID = OD.ProductID GROUP BY P.ProductName, P.ProductID, OD.UnitPrice ORDER BY [TOTAL FACTURADO] DESC
--6. ID del proveedor e importe total del stock acumulado de productos correspondientes a ese proveedor. Añade el nombre del proveedor
SELECT * FROM Suppliers
SELECT * FROM Products
SELECT S.SupplierID, S.ContactName, SUM(UnitPrice * UnitsInStock) AS [IMPORTE TOTAL DEL STOCK]  FROM Suppliers AS S INNER JOIN Products AS P ON S.SupplierID = P.SupplierID GROUP BY S.SupplierID, S.ContactName
--9. ID del distribuidor y número de pedidos enviados a través de ese distribuidor. Añade el nombre del distribuidor
SELECT S.CompanyName, O.ShipVia, COUNT(O.OrderID) AS [Nº DE PEDIDOS] FROM Shippers AS S INNER JOIN Orders AS O ON S.ShipperID = O.ShipVia GROUP BY S.CompanyName, O.ShipVia
--10. ID de cada proveedor y número de productos distintos que nos suministra. Añade el nombre del proveedor.
SELECT S.SupplierID, S.ContactName, COUNT(P.ProductID) AS [Nº DE PRODUCTOS]  FROM Suppliers AS S INNER JOIN Products AS P ON S.SupplierID = P.SupplierID GROUP BY S.SupplierID, S.ContactName
