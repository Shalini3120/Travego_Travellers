# TASK 1 : 
	## SQL scripts for Table creation and data insertion in the table.
    
## Q1. 1.Creating the schema and required tables using sql script or using MySQL workbench UI
### a schema named Travego. 
create database Travego;

## Q1.b. b.	Create the tables mentioned above with the mentioned column names.
use Travego;

## Creating Passenger Table
create table Passenger(
	Passenger_id int primary key,
	Passenger_name varchar(30),
    Category varchar(20),
    Gender char(1),
    Boarding_City varchar(30),
    Destination_city varchar(30),
    Distance int,
    Bus_Type varchar(20)
);

## Creating Price Table
Create Table Price(
	id int Primary key,
    Bus_type varchar(20),
    Distance int,
    Price int
);

## 1.c. Insert the data in the newly created tables using sql script or using MySQL UI. 

# inserting values into Passenger Table
insert into Passenger values
(1,'Sejal','AC','F','Bengaluru','Chennai',350,'Sleeper'),
(2,'Anmol','Non-AC','M','Mumbai','Hyderabad',700,'Sitting'),
(3,'Pallavi','AC','F','Panaji','Bengaluru',600,'Sleeper'),
(4,'Khusboo','AC','F','Chennai','Mumbai',1500,'Sleeper'),
(5,'Udit','Non-AC','M','Trivandrum','Panaji',1000,'Sleeper'),
(6,'Ankur','AC','M','Nagpur','Hyderabad',500,'Sitting'),
(7,'Hemant','Non-AC','M','Panaji','Mumbai',700,'Sleeper'),
(8,'Manish','Non-AC','M','Hyderabad','Bengaluru',500,'Sitting'),
(9,'Piyush','AC','M','Pune','Nagpur',700,'Sitting') ;

# Inserting values into Price Table
insert into Price values
(1,'Sleeper',350,770),
(2,'Sleeper',500,1100),
(3,'Sleeper',600,1320),
(4,'Sleeper',700,1540),
(5,'Sleeper',1000,2200),
(6,'Sleeper',1200,2640),
(7,'Sleeper',1500,2700),
(8,'Sitting',500,620),
(9,'Sitting',600,744),
(10,'Sitting',700,868),
(11,'Sitting',1000,1240),
(12,'Sitting',1200,1488),
(13,'Sitting',1500,1860);

# TASK 2:
# SQL scripts for all the select queries

#Q2.Perform read operation on the designed table created in the above task using SQL script. 
# Q2.a) a.	How many females and how many male passengers traveled a minimum distance of 600 KMs?

Select Count(*) as No_of_Female_passengers_travelled_min_600kms 
from Passenger
where Distance >= 600 AND Gender = 'F';

Select Count(*) as No_of_Male_passengers_travelled_min_600kms 
from Passenger
where Distance >= 600 AND Gender = 'M';

## using group by clause to find no of male and female passengers travalled min 600kms.
select Gender, COUNT(*) AS No_Of_passengers_travelled_min_600kms
from Passenger
where Distance >= 600 
group by Gender;

#Q2.b) Find the minimum ticket price of a Sleeper Bus. 
Select Bus_type, min(Price) as Minimum_Ticket_price
from Price
where Bus_type ="Sleeper";

#Q2.c.Select passenger names whose names start with character 'S' 
Select Passenger_name from Passenger
where Passenger_name like 'S%';

#Q2.d.	Calculate price charged for each passenger 
# displaying Passenger name, Boarding City, Destination City, Bus_Type, Price in the output

select p.passenger_name,p.Boarding_city,p.Destination_city,p.Bus_type,pr.price
from Passenger p
join Price pr on p.Distance=pr.Distance and p.Bus_Type=pr.Bus_type;

#Q2.e.What are the passenger name(s) and the ticket price for those who traveled 1000 KMs Sitting in a bus?
select p.passenger_name,pr.price
from Passenger p
join Price pr on p.Distance=pr.Distance and p.Bus_Type=pr.Bus_type
where p.Distance=1000 and p.Bus_Type ="Sitting";

#Q2. f.	What will be the Sitting and Sleeper bus charge for Pallavi to travel from Bangalore to Panaji?

select bus_type,price from price 
where distance = (select distance from passenger where passenger_name = 'Pallavi');

#Q2,g.List the distances from the "Passenger" table which are unique (non-repeated distances) in descending order.
select distinct Distance from Passenger order by Distance desc; 

#Q2.h.Display the passenger name and percentage of distance traveled by that passenger from the total distance traveled by all passengers without using user variables
select Passenger_name, (Distance * 100 / SUM(Distance) OVER ()) AS Percentage
from Passenger ;
