-- 1
SELECT trip_no, plane, town_from, town_to from trip
WHERE plane != 'IL-86'
ORDER BY plane;
-- 2
SELECT name FROM Ships
WHERE name LIKE 'W%n';
-- 3
SELECT product.maker, product.type, laptop.speed, laptop.model FROM product, laptop
WHERE product.model=laptop.model AND speed > 600;
-- 4
SELECT COUNT(*) from pc, product
WHERE maker = 'A' and pc.model = product.model;
-- 5
SELECT DISTINCT maker FROM Product 
WHERE Product.type = 'Printer' and maker IN(
	SELECT Product.maker FROM PC
	INNER JOIN Product ON PC.model = Product.model
	WHERE PC.speed = (SELECT MAX(PC.speed) FROM PC);
-- 6
SELECT date_format(date, '%Y.%m.%d') as date
from Income;
-- 7
SELECT model, price FROM PC
WHERE price > (SELECT MIN(price) FROM Laptop);
-- 8
SELECT Outcomes.ship, Ships.country, Ships.numGuns FROM Outcomes
LEFT JOIN (
SELECT Ships.name, Classes.country, Classes.numGuns FROM Ships
INNER JOIN Classes ON Ships.class = Classes.class
) 
AS Ships ON Outcomes.ship=Ships.name
WHERE result ='damaged';
-- 9 
SELECT Ships.name, Cl.numGuns, Cl.bore, Cl.displacement, Cl.type, Cl.country, Ships.launched, Ships.class FROM Ships
INNER JOIN Classes AS Cl ON Ships.class = Cl.class
WHERE ((Cl.numGuns=9) + (Cl.bore=16) + (Cl.displacement=46000) + (Cl.type='bb') + 
(Cl.country='Japan') + (Ships.launched=1916) + (Ships.class='Revenge')) > 2;
-- 10
SELECT class FROM Ships
GROUP BY class
HAVING COUNT(class)=1
UNION
SELECT DISTINCT ship FROM Outcomes
WHERE ship NOT IN(SELECT name FROM Ships);
