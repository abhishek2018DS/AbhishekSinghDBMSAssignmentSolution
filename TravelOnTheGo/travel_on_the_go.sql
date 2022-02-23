drop database if exists TravelOnTheGo;
create database TravelOnTheGo;
use TravelOnTheGo;

-- Problem 1:
-- create Tables

CREATE TABLE Passenger (
  Passenger_name varchar(20), 
  Category varchar(20),
  Gender varchar(20),
  Boarding_City varchar(20),
  Destination_City varchar(20),
  Distance int,
  Bus_Type varchar(20)
);

CREATE TABLE PRICE( 
  Bus_Type varchar(20) ,
  Distance int,
  Price int
  -- foreign key (Distance) references PASSENGER(Distance)
 );
 
-- Problem 2
-- insert Values into respective Tables

INSERT INTO Passenger VALUES ('Sejal', 'AC', 'F', 'Bengaluru', 'Chennai', 350, 'Sleeper'),
	('Anmol', 'Non-AC', 'M', 'Mumbai', 'Hyderabad', 700, 'Sitting'),
    ('Pallavi', 'AC', 'F', 'Panaji', 'Bengaluru', 600, 'Sleeper'),
    ('Khusboo', 'AC', 'F', 'Chennai', 'Mumbai', 1500, 'Sleeper'),
    ('Udit', 'Non-AC', 'M', 'Trivandrum', 'panaji', 1000, 'Sleeper'),
    ('Ankur', 'AC', 'M', 'Nagpur', 'Hyderabad', 500, 'Sitting'),
    ('Hemant', 'Non-AC', 'M', 'panaji', 'Mumbai', 700, 'Sleeper'),
    ('Manish', 'Non-AC', 'M', 'Hyderabad', 'Bengaluru', 500, 'Sitting'),
    ('Piyush', 'AC', 'M', 'Pune', 'Nagpur', 700, 'Sitting');
select *from Passenger;
 
INSERT INTO PRICE VALUES 
	('Sleeper', 350, 770),
	('Sleeper', 500, 1100),
    ('Sleeper', 600, 1320),
    ('Sleeper', 700, 1540),
    ('Sleeper', 1000, 2200),
    ('Sleeper', 1200, 2640),
    ('Sleeper', 1500, 2700),
    ('Sitting', 500, 620),
    ('Sitting', 600, 744),
    ('Sitting', 700, 868),
    ('Sitting', 1000, 1240),
    ('Sitting', 1200, 1488),
    ('Sitting', 1500, 1860);

select *from PRICE;

/* problem 3
query1. How many female and how many male passengers travelled for a minimum distance
of 600 KM s? */

SELECT 
	COUNT(CASE WHEN (Gender) = 'F' THEN 1 END) as Female,
	COUNT(CASE WHEN (Gender) = 'M' THEN 2 END) as Male
FROM Passenger
WHERE Distance >=600;


/*problem 4
query 2:  Find the minimum ticket price for Sleeper Bus. */
SELECT MIN(Price) FROM PRICE WHERE Bus_Type = 'Sleeper';


/* problem 5
Query 3:  Select passenger names whose names start with character 'S' */

SELECT * FROM Passenger WHERE Passenger_name LIKE 's%';


/* Problem 6
Query 4: Calculate price charged for each passenger displaying Passenger name, Boarding City,
Destination City, Bus_Type, Price in the output */
SELECT Passenger_name , p1.Boarding_City, p1.Destination_City,
	p1.Bus_Type, p2.Price
FROM Passenger p1, PRICE p2
WHERE p1.Distance = p2.Distance and p1.Bus_type = p2.Bus_type;


/* Problem 7
Query 5: What are the passenger name/s and his/her ticket price
who travelled in the Sitting bus for a distance of 1000 KMs */
SELECT p1.Passenger_name, p1.Boarding_city, p1.Destination_city, p1.Bus_type, p2.Price
FROM Passenger p1, PRICE p2 
WHERE p1.Distance = 1000 and p1.Bus_type = 'Sitting' and p1.Distance = 1000
	  and p1.Bus_type = 'Sitting';
      
      
/* Problem 8
Query 6: What will be the Sitting and Sleeper bus charge for Pallavi to travel 
from Bangalore to Panaji? */

SELECT DISTINCT p1.Passenger_name, p1.Boarding_city,
				p1.Destination_city, p2.Bus_type, p2.Price 
FROM Passenger p1, PRICE p2
WHERE Passenger_name = 'Pallavi' and p1.Distance = p2.Distance;


/*Problem 9
Query 7: List the distances from the "Passenger" table which are unique (non-repeated
distances) in descending order. */

SELECT DISTINCT distance FROM Passenger ORDER BY Distance desc;


/*Problem 10
Query 8:  Display the passenger name and percentage of distance travelled 
by that passenger from the total distance travelled by all passengers 
without using user variables */

SELECT Passenger_Name, round(( Distance / TotalDistance ) * 100) AS PercentageOfDistance
FROM Passenger 
INNER JOIN (SELECT SUM(Distance) AS TotalDistance FROM Passenger) AS TOTAL;


/*Problem 11
Query 9: Display the distance, price in three categories in table Price */

-- a) Expensive if the cost is more than 1000
-- b) Average Cost if the cost is less than 1000 and greater than 500
-- c) Cheap otherwise*/
select DISTINCT P.Distance, P1.Bus_Type, P1.Price, 
	case 
		when P1.Price >1000 then 'Expensive'
        when P1.Price >500 and P1.Price <1000 then 'Average Cost'
        else 'Cheap' end as price_check
from PRICE P1, Passenger P
where P1.Bus_Type= P.Bus_Type; 
