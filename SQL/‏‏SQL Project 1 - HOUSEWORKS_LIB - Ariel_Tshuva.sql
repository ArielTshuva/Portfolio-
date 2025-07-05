--Project 1 - Table Design & Creation--
--I chose to develop a database that deals with buying and selling real-estate--
 --**Creating a db and giving it a proper name**
create database HouseWorks_Lib;
go
use HouseWorks_Lib;
go

--Creating the first table - "city" - meant to hold an important part of the location of each asset (wether an owned property or something demanded by the buyers). 
--On the values here all the other 'INSERTS' were based on.
create table City (
Cityid int primary key identity(1,1),
CityName nvarchar(20) not null,
)
go

--Creating the second table - "Region" - meant to hold an important part of the location of each asset (wether an owned property or something demanded by the buyers). 
--On the values here all the other 'INSERTS' were based on.
create table Region (
Regionid int primary key identity(1,1),
RegionName nvarchar(20) not null,
)
go


--Creating the third table - "Owners" - meant to hold a list of all the property Owners in the db. 
--It holds general information on every Owner and is the base for the 'Properties' table.
create table Owners (
Ownerid int primary key identity(1,1),
OwnerFirstName nvarchar(20) not null,
OwnerLastName nvarchar(20) not null,
address nvarchar(20) not null,
City nvarchar(20) not null,
Region nvarchar(20) not null,
Phone nvarchar(20) not null
)
go

--Creating the forth table - "Buyers" - meant to hold a list of all the property Buyers in the db. 
--It has general information on every Owner and is the base for the 'Buyer_Demands' table.
create table Buyers (
Buyerid int primary key identity(1,1),
BuyerFirstName nvarchar(20) not null,
BuyerLastName nvarchar(20) not null,
address nvarchar(20) not null,
City nvarchar(20) not null,
Region nvarchar(20) not null,
Phone nvarchar(20) not null
)
go


---—Creating the fifth table, "Buyer_Demands," meant to hold a list of all the property characteristics that the buyers are looking for in the DB. 
--It has general information on every request including the price range the buyer is willing to pay.  
--Buyer_Demands correlates in its design to the Properties table.
create table Buyer_Demands (
Buyerid int primary key identity(1,1),
Property_Type nvarchar(20) not null,
Floor_MIN int not null,
Bedrooms int not null,
Bathrooms int not null,
Size_Square_Meter int not null, 
City nvarchar(20) not null,
Region nvarchar(20) not null,
Price_MIN money DEFAULT 500000,
Price_MAX money DEFAULT 1500000
)
go

--Creating the fifth table, "Properties," is meant to hold a list of all the information on the properties that the Owners own and are looking to sell.  
--It has general information on every request including the price the Owners is willing to receive.  
--The 'Properties' table correlates in its design to the Buyer_Demands table.
create table Properties (
Propertyid int primary key identity(1,1),
Ownerid int foreign key references Owners(Ownerid) not null,
Property_Type nvarchar(20) not null,
Floor_MIN int not null,
Bedrooms int not null,
Bathrooms int not null,
Size_Square_Meter int not null, 
address nvarchar(20) not null,
City nvarchar(20) not null,
Region nvarchar(20) not null,
PostalCode nvarchar(20) not null,
Price money DEFAULT 1000000,
)
go

--Inserting values to the City table:
INSERT INTO City VALUES ('Acre');
INSERT INTO City VALUES ('Afula');
INSERT INTO City VALUES ('Arad');
INSERT INTO City VALUES ('Ashkelon');
INSERT INTO City VALUES ('Baqa al-Gharbiyye');
INSERT INTO City VALUES ('Bat Yam');
INSERT INTO City VALUES ('Beersheba');
INSERT INTO City VALUES ('Beit Shean');
INSERT INTO City VALUES ('Beit Shemesh');
INSERT INTO City VALUES ('Bnei Brak');
INSERT INTO City VALUES ('Dimona');
INSERT INTO City VALUES ('Eilat');
INSERT INTO City VALUES ('Elad');
INSERT INTO City VALUES ('Givatayim');
INSERT INTO City VALUES ('Givat Shmuel');
INSERT INTO City VALUES ('Hadera');
INSERT INTO City VALUES ('Herzliya');
INSERT INTO City VALUES ('Hod HaSharon');
INSERT INTO City VALUES ('Holon');
INSERT INTO City VALUES ('Jerusalem');
INSERT INTO City VALUES ('Karmiel');
INSERT INTO City VALUES ('Kfar Saba');
INSERT INTO City VALUES ('Kiryat Ata');
INSERT INTO City VALUES ('Kiryat Bialik');
INSERT INTO City VALUES ('Kiryat Gat');
INSERT INTO City VALUES ('Kiryat Malakhi');
INSERT INTO City VALUES ('Kiryat Motzkin');
INSERT INTO City VALUES ('Kiryat Ono');
INSERT INTO City VALUES ('Kiryat Shmona');
INSERT INTO City VALUES ('Kiryat Yam');
INSERT INTO City VALUES ('Lod');
INSERT INTO City VALUES ('Maale Adumim');
INSERT INTO City VALUES ('Maalot-Tarshiha');
INSERT INTO City VALUES ('Migdal HaEmek');
INSERT INTO City VALUES ('Modiin Illit');
INSERT INTO City VALUES ('Modiin-Maccabim-Reut');
INSERT INTO City VALUES ('Nahariya');
INSERT INTO City VALUES ('Nazareth');
INSERT INTO City VALUES ('Nazareth Illit');


--Inserting values to the Region table:
INSERT INTO Region VALUES ('Haifa District');
INSERT INTO Region VALUES ('Jerusalem District');
INSERT INTO Region VALUES ('Tel Aviv District');
INSERT INTO Region VALUES ('Central District');
INSERT INTO Region VALUES ('Northern District');
INSERT INTO Region VALUES ('Southern District');
INSERT INTO Region VALUES ('Galilee');
INSERT INTO Region VALUES ('Golan Heights');
INSERT INTO Region VALUES ('Jezreel Valley');
INSERT INTO Region VALUES ('Sharon Plain');
INSERT INTO Region VALUES ('Negev');
INSERT INTO Region VALUES ('Arava');
INSERT INTO Region VALUES ('Shephelah');
INSERT INTO Region VALUES ('Judean Mountains');
INSERT INTO Region VALUES ('Jordan Valley');
INSERT INTO Region VALUES ('Hula Valley');
INSERT INTO Region VALUES ('Haifa Bay');
INSERT INTO Region VALUES ('Jerusalem Corridor');
INSERT INTO Region VALUES ('Gush Dan');
INSERT INTO Region VALUES ('Beersheba Metropolitan Area');
INSERT INTO Region VALUES ('Hevel Lakhish');
INSERT INTO Region VALUES ('Hevel Eshkol');
INSERT INTO Region VALUES ('Upper Galilee');
INSERT INTO Region VALUES ('Lower Galilee');
INSERT INTO Region VALUES ('Western Galilee');
INSERT INTO Region VALUES ('Samaria');
INSERT INTO Region VALUES ('Shfela');
INSERT INTO Region VALUES ('Arabah');

--Inserting values to the Owners table:
INSERT INTO Owners (OwnerFirstName, OwnerLastName, address, City, Region, Phone) VALUES ('John', 'Doe', '123 Main St', 'Jerusalem', 'Jerusalem District', '050-1234567');
INSERT INTO Owners (OwnerFirstName, OwnerLastName, address, City, Region, Phone) VALUES ('Jane', 'Smith', '456 Elm St', 'Tel Aviv', 'Tel Aviv District', '050-2345678');
INSERT INTO Owners (OwnerFirstName, OwnerLastName, address, City, Region, Phone) VALUES ('Michael', 'Johnson', '789 Oak St', 'Haifa', 'Haifa District', '050-3456789');
INSERT INTO Owners (OwnerFirstName, OwnerLastName, address, City, Region, Phone) VALUES ('Emily', 'Davis', '101 Pine St', 'Rishon LeZion', 'Central District', '050-4567890');
INSERT INTO Owners (OwnerFirstName, OwnerLastName, address, City, Region, Phone) VALUES ('David', 'Brown', '202 Cedar St', 'Ashdod', 'Southern District', '050-5678901');
INSERT INTO Owners (OwnerFirstName, OwnerLastName, address, City, Region, Phone) VALUES ('Sarah', 'Wilson', '303 Birch St', 'Beersheba', 'Southern District', '050-6789012');
INSERT INTO Owners (OwnerFirstName, OwnerLastName, address, City, Region, Phone) VALUES ('Daniel', 'Miller', '404 Maple St', 'Petah Tikva', 'Central District', '050-7890123');
INSERT INTO Owners (OwnerFirstName, OwnerLastName, address, City, Region, Phone) VALUES ('Laura', 'Taylor', '505 Walnut St', 'Netanya', 'Central District', '050-8901234');
INSERT INTO Owners (OwnerFirstName, OwnerLastName, address, City, Region, Phone) VALUES ('James', 'Anderson', '606 Cherry St', 'Holon', 'Central District', '050-9012345');
INSERT INTO Owners (OwnerFirstName, OwnerLastName, address, City, Region, Phone) VALUES ('Olivia', 'Thomas', '707 Spruce St', 'Bnei Brak', 'Central District', '050-0123456');
INSERT INTO Owners (OwnerFirstName, OwnerLastName, address, City, Region, Phone) VALUES ('Matthew', 'Jackson', '808 Willow St', 'Bat Yam', 'Central District', '050-1234567');
INSERT INTO Owners (OwnerFirstName, OwnerLastName, address, City, Region, Phone) VALUES ('Sophia', 'White', '909 Aspen St', 'Ramat Gan', 'Central District', '050-2345678');
INSERT INTO Owners (OwnerFirstName, OwnerLastName, address, City, Region, Phone) VALUES ('Andrew', 'Harris', '1010 Fir St', 'Ashkelon', 'Southern District', '050-3456789');
INSERT INTO Owners (OwnerFirstName, OwnerLastName, address, City, Region, Phone) VALUES ('Isabella', 'Martin', '1111 Redwood St', 'Rehovot', 'Central District', '050-4567890');
INSERT INTO Owners (OwnerFirstName, OwnerLastName, address, City, Region, Phone) VALUES ('Joshua', 'Thompson', '1212 Cypress St', 'Beit Shemesh', 'Jerusalem District', '050-5678901');
INSERT INTO Owners (OwnerFirstName, OwnerLastName, address, City, Region, Phone) VALUES ('Mia', 'Garcia', '1313 Palm St', 'Kfar Saba', 'Central District', '050-6789012');
INSERT INTO Owners (OwnerFirstName, OwnerLastName, address, City, Region, Phone) VALUES ('Ethan', 'Martinez', '1414 Poplar St', 'Herzliya', 'Central District', '050-7890123');
INSERT INTO Owners (OwnerFirstName, OwnerLastName, address, City, Region, Phone) VALUES ('Ava', 'Robinson', '1515 Magnolia St', 'Eilat', 'Southern District', '050-8901234');
INSERT INTO Owners (OwnerFirstName, OwnerLastName, address, City, Region, Phone) VALUES ('Alexander', 'Clark', '1616 Dogwood St', 'Nazareth', 'Northern District', '050-9012345');
INSERT INTO Owners (OwnerFirstName, OwnerLastName, address, City, Region, Phone) VALUES ('Charlotte', 'Rodriguez', '1717 Hickory St', 'Tiberias', 'Northern District', '050-0123456');
INSERT INTO Owners (OwnerFirstName, OwnerLastName, address, City, Region, Phone) VALUES ('Benjamin', 'Lewis', '1818 Sycamore St', 'Acre', 'Northern District', '050-1234567');
INSERT INTO Owners (OwnerFirstName, OwnerLastName, address, City, Region, Phone) VALUES ('Amelia', 'Walker', '1919 Maple St', 'Afula', 'Northern District', '050-2345678');
INSERT INTO Owners (OwnerFirstName, OwnerLastName, address, City, Region, Phone) VALUES ('Lucas', 'Hall', '2020 Cedar St', 'Arad', 'Southern District', '050-3456789');
INSERT INTO Owners (OwnerFirstName, OwnerLastName, address, City, Region, Phone) VALUES ('Grace', 'Allen', '2121 Birch St', 'Ashkelon', 'Southern District', '050-4567890');
INSERT INTO Owners (OwnerFirstName, OwnerLastName, address, City, Region, Phone) VALUES ('Henry', 'Young', '2222 Maple St', 'Baqa al-Gharbiyye', 'Haifa District', '050-5678901');
INSERT INTO Owners (OwnerFirstName, OwnerLastName, address, City, Region, Phone) VALUES ('Ella', 'King', '2323 Pine St', 'Bat Yam', 'Tel Aviv District', '050-6789012');
INSERT INTO Owners (OwnerFirstName, OwnerLastName, address, City, Region, Phone) VALUES ('Jack', 'Wright', '2424 Oak St', 'Beersheba', 'Southern District', '050-7890123');
INSERT INTO Owners (OwnerFirstName, OwnerLastName, address, City, Region, Phone) VALUES ('Lily', 'Scott', '2525 Elm St', 'Beit Shean', 'Northern District', '050-8901234');
INSERT INTO Owners (OwnerFirstName, OwnerLastName, address, City, Region, Phone) VALUES ('Samuel', 'Green', '2626 Cedar St', 'Dimona', 'Southern District', '050-9012345');
INSERT INTO Owners (OwnerFirstName, OwnerLastName, address, City, Region, Phone) VALUES ('Zoe', 'Baker', '2727 Birch St', 'Eilat', 'Southern District', '050-0123456');


--Inserting values to the Buyers table:
INSERT INTO Buyers (BuyerFirstName, BuyerLastName, address, City, Region, Phone) VALUES ('Liam', 'Adams', '123 Maple St', 'Jerusalem', 'Jerusalem District', '052-1112233');
INSERT INTO Buyers (BuyerFirstName, BuyerLastName, address, City, Region, Phone) VALUES ('Emma', 'Bennett', '456 Oak St', 'Tel Aviv', 'Tel Aviv District', '053-2223344');
INSERT INTO Buyers (BuyerFirstName, BuyerLastName, address, City, Region, Phone) VALUES ('Noah', 'Carter', '789 Pine St', 'Haifa', 'Haifa District', '054-3334455');
INSERT INTO Buyers (BuyerFirstName, BuyerLastName, address, City, Region, Phone) VALUES ('Ava', 'Evans', '101 Cedar St', 'Rishon LeZion', 'Central District', '055-4445566');
INSERT INTO Buyers (BuyerFirstName, BuyerLastName, address, City, Region, Phone) VALUES ('William', 'Foster', '202 Birch St', 'Ashdod', 'Southern District', '056-5556677');
INSERT INTO Buyers (BuyerFirstName, BuyerLastName, address, City, Region, Phone) VALUES ('Sophia', 'Gonzalez', '303 Elm St', 'Beersheba', 'Southern District', '057-6667788');
INSERT INTO Buyers (BuyerFirstName, BuyerLastName, address, City, Region, Phone) VALUES ('James', 'Harris', '404 Walnut St', 'Petah Tikva', 'Central District', '058-7778899');
INSERT INTO Buyers (BuyerFirstName, BuyerLastName, address, City, Region, Phone) VALUES ('Isabella', 'Johnson', '505 Cherry St', 'Netanya', 'Central District', '059-8889900');
INSERT INTO Buyers (BuyerFirstName, BuyerLastName, address, City, Region, Phone) VALUES ('Lucas', 'King', '606 Spruce St', 'Holon', 'Central District', '050-9990011');
INSERT INTO Buyers (BuyerFirstName, BuyerLastName, address, City, Region, Phone) VALUES ('Mia', 'Lee', '707 Willow St', 'Bnei Brak', 'Central District', '051-1111122');
INSERT INTO Buyers (BuyerFirstName, BuyerLastName, address, City, Region, Phone) VALUES ('Ethan', 'Martinez', '808 Aspen St', 'Bat Yam', 'Central District', '052-2222233');
INSERT INTO Buyers (BuyerFirstName, BuyerLastName, address, City, Region, Phone) VALUES ('Amelia', 'Nelson', '909 Fir St', 'Ramat Gan', 'Central District', '053-3333344');
INSERT INTO Buyers (BuyerFirstName, BuyerLastName, address, City, Region, Phone) VALUES ('Mason', 'Owens', '1010 Redwood St', 'Ashkelon', 'Southern District', '054-4444455');
INSERT INTO Buyers (BuyerFirstName, BuyerLastName, address, City, Region, Phone) VALUES ('Harper', 'Perez', '1111 Cypress St', 'Rehovot', 'Central District', '055-5555566');
INSERT INTO Buyers (BuyerFirstName, BuyerLastName, address, City, Region, Phone) VALUES ('Logan', 'Quinn', '1212 Palm St', 'Beit Shemesh', 'Jerusalem District', '056-6666677');
INSERT INTO Buyers (BuyerFirstName, BuyerLastName, address, City, Region, Phone) VALUES ('Ella', 'Roberts', '1313 Poplar St', 'Kfar Saba', 'Central District', '057-7777788');
INSERT INTO Buyers (BuyerFirstName, BuyerLastName, address, City, Region, Phone) VALUES ('Alexander', 'Scott', '1414 Magnolia St', 'Herzliya', 'Central District', '058-8888899');
INSERT INTO Buyers (BuyerFirstName, BuyerLastName, address, City, Region, Phone) VALUES ('Grace', 'Taylor', '1515 Dogwood St', 'Eilat', 'Southern District', '059-9999900');
INSERT INTO Buyers (BuyerFirstName, BuyerLastName, address, City, Region, Phone) VALUES ('Henry', 'Upton', '1616 Hickory St', 'Nazareth', 'Northern District', '050-1010101');
INSERT INTO Buyers (BuyerFirstName, BuyerLastName, address, City, Region, Phone) VALUES ('Zoe', 'Vargas', '1717 Sycamore St', 'Tiberias', 'Northern District', '051-2020202');
INSERT INTO Buyers (BuyerFirstName, BuyerLastName, address, City, Region, Phone) VALUES ('Daniel', 'Walker', '1818 Maple St', 'Acre', 'Northern District', '052-3030303');
INSERT INTO Buyers (BuyerFirstName, BuyerLastName, address, City, Region, Phone) VALUES ('Lily', 'Xavier', '1919 Cedar St', 'Afula', 'Northern District', '053-4040404');
INSERT INTO Buyers (BuyerFirstName, BuyerLastName, address, City, Region, Phone) VALUES ('Samuel', 'Young', '2020 Birch St', 'Arad', 'Southern District', '054-5050505');
INSERT INTO Buyers (BuyerFirstName, BuyerLastName, address, City, Region, Phone) VALUES ('Chloe', 'Zimmerman', '2121 Pine St', 'Ashkelon', 'Southern District', '055-6060606');
INSERT INTO Buyers (BuyerFirstName, BuyerLastName, address, City, Region, Phone) VALUES ('Jack', 'Anderson', '2222 Oak St', 'Baqa al-Gharbiyye', 'Haifa District', '056-7070707');
INSERT INTO Buyers (BuyerFirstName, BuyerLastName, address, City, Region, Phone) VALUES ('Avery', 'Brown', '2323 Elm St', 'Bat Yam', 'Tel Aviv District', '057-8080808');
INSERT INTO Buyers (BuyerFirstName, BuyerLastName, address, City, Region, Phone) VALUES ('Levi', 'Clark', '2424 Cedar St', 'Beersheba', 'Southern District', '058-9090909');
INSERT INTO Buyers (BuyerFirstName, BuyerLastName, address, City, Region, Phone) VALUES ('Scarlett', 'Davis', '2525 Birch St', 'Beit Shean', 'Northern District', '059-1010101');
INSERT INTO Buyers (BuyerFirstName, BuyerLastName, address, City, Region, Phone) VALUES ('Owen', 'Evans', '2626 Maple St', 'Dimona', 'Southern District', '050-2020202');
INSERT INTO Buyers (BuyerFirstName, BuyerLastName, address, City, Region, Phone) VALUES ('Hannah', 'Garcia', '2727 Pine St', 'Eilat', 'Southern District', '051-3030303');


--Inserting values to the Properties table:
INSERT INTO Properties VALUES (1, 'Apartment', 3, 2, 1, 85, '123 New St', 'Jerusalem', 'Jerusalem District', '91000', 1500000);
INSERT INTO Properties VALUES (2, 'Business', 1, 0, 1, 120, '456 New Ave', 'Tel Aviv', 'Tel Aviv District', '61000', 3000000);
INSERT INTO Properties VALUES (3, 'Private house', 0, 4, 3, 200, '789 New Blvd', 'Haifa', 'Haifa District', '32000', 2500000);
INSERT INTO Properties VALUES (4, 'Mixed-use', 2, 3, 2, 150, '101 New Rd', 'Rishon LeZion', 'Central District', '75000', 2200000);
INSERT INTO Properties VALUES (5, 'Apartment', 5, 2, 2, 90, '202 New Ln', 'Ashdod', 'Southern District', '77000', 1600000);
INSERT INTO Properties VALUES (6, 'Business', 0, 0, 1, 130, '303 New Pl', 'Beersheba', 'Southern District', '84000', 2800000);
INSERT INTO Properties VALUES (7, 'Private house', 0, 5, 4, 250, '404 New Ct', 'Petah Tikva', 'Central District', '49000', 2700000);
INSERT INTO Properties VALUES (8, 'Mixed-use', 1, 3, 2, 140, '505 New Dr', 'Netanya', 'Central District', '42000', 2300000);
INSERT INTO Properties VALUES (9, 'Apartment', 8, 1, 1, 75, '606 New St', 'Holon', 'Central District', '58000', 1400000);
INSERT INTO Properties VALUES (10, 'Business', 0, 0, 1, 110, '707 New Ave', 'Bnei Brak', 'Central District', '51000', 2600000);
INSERT INTO Properties VALUES (11, 'Private house', 0, 4, 3, 210, '808 New Blvd', 'Bat Yam', 'Central District', '59000', 2400000);
INSERT INTO Properties VALUES (12, 'Mixed-use', 3, 2, 2, 160, '909 New Rd', 'Ramat Gan', 'Central District', '52000', 2000000);
INSERT INTO Properties VALUES (13, 'Apartment', 6, 3, 2, 100, '1010 New Ln', 'Ashkelon', 'Southern District', '78000', 1700000);
INSERT INTO Properties VALUES (14, 'Business', 0, 0, 1, 140, '1111 New Pl', 'Rehovot', 'Central District', '76000', 2900000);
INSERT INTO Properties VALUES (15, 'Private house', 0, 5, 4, 260, '1212 New Ct', 'Beit Shemesh', 'Jerusalem District', '99000', 2800000);
INSERT INTO Properties VALUES (16, 'Mixed-use', 2, 3, 2, 170, '1313 New Dr', 'Kfar Saba', 'Central District', '44000', 2400000);
INSERT INTO Properties VALUES (17, 'Apartment', 10, 2, 1, 85, '1414 New St', 'Herzliya', 'Central District', '46000', 1500000);
INSERT INTO Properties VALUES (18, 'Business', 0, 0, 1, 120, '1515 New Ave', 'Eilat', 'Southern District', '88000', 3000000);
INSERT INTO Properties VALUES (19, 'Private house', 0, 4, 3, 200, '1616 New Blvd', 'Nazareth', 'Northern District', '16000', 2500000);
INSERT INTO Properties VALUES (20, 'Mixed-use', 1, 3, 2, 150, '1717 New Rd', 'Tiberias', 'Northern District', '14200', 2200000);
INSERT INTO Properties VALUES (21, 'Apartment', 4, 2, 2, 90, '1818 New Ln', 'Acre', 'Northern District', '24000', 1600000);
INSERT INTO Properties VALUES (22, 'Business', 0, 0, 1, 130, '1919 New Pl', 'Afula', 'Northern District', '18000', 2800000);
INSERT INTO Properties VALUES (23, 'Private house', 0, 5, 4, 250, '2020 New Ct', 'Arad', 'Southern District', '89000', 2700000);
INSERT INTO Properties VALUES (24, 'Mixed-use', 1, 3, 2, 140, '2121 New Dr', 'Ashkelon', 'Southern District', '78000', 2300000);
INSERT INTO Properties VALUES (25, 'Apartment', 7, 1, 1, 75, '2222 New St', 'Baqa al-Gharbiyye', 'Haifa District', '30000', 1400000);
INSERT INTO Properties VALUES (26, 'Business', 0, 0, 1, 110, '2323 New Ave', 'Bat Yam', 'Tel Aviv District', '59000', 2600000);
INSERT INTO Properties VALUES (27, 'Private house', 0, 4, 3, 210, '2424 New Blvd', 'Beersheba', 'Southern District', '84000', 2400000);
INSERT INTO Properties VALUES (28, 'Mixed-use', 3, 2, 2, 160, '2525 New Rd', 'Beit Shean', 'Northern District', '11700', 2000000);
INSERT INTO Properties VALUES (29, 'Apartment', 9, 3, 2, 100, '2626 New Ln', 'Dimona', 'Southern District', '86000', 1700000);
INSERT INTO Properties VALUES (30, 'Business', 0, 0, 1, 140, '2727 New Pl', 'Eilat', 'Southern District', '88000', 2900000);
INSERT INTO Properties VALUES (31, 'Private house', 0, 5, 4, 260, '2828 New Ct', 'Jerusalem', 'Jerusalem District', '91000', 2800000);
INSERT INTO Properties VALUES (32, 'Mixed-use', 2, 3, 2, 170, '2929 New Dr', 'Tel Aviv', 'Tel Aviv District', '61000', 2400000);
INSERT INTO Properties VALUES (33, 'Apartment', 11, 2, 1, 85, '3030 New St', 'Haifa', 'Haifa District', '32000', 1500000);
INSERT INTO Properties VALUES (34, 'Business', 0, 0, 1, 120, '3131 New Ave', 'Rishon LeZion', 'Central District', '75000', 3000000);
INSERT INTO Properties VALUES (35, 'Private house', 0, 4, 3, 200, '3232 New Blvd', 'Ashdod', 'Southern District', '77000', 2500000);


--Inserting values to the Buyer_Demands table:
INSERT INTO Buyer_Demands (Property_Type, Floor_MIN, Bedrooms, Bathrooms, Size_Square_Meter, City, Region, Price_MIN, Price_MAX) 
values ('Apartment', 2, 2, 2, 120, 'Rehovot', 'Shfela', '500000', '1000000')
INSERT INTO Buyer_Demands (Property_Type, Floor_MIN, Bedrooms, Bathrooms, Size_Square_Meter, City, Region, Price_MIN, Price_MAX) VALUES ('Apartment', 14, 5, 3, 91, 'Modiin Illit', 'Central District', 1948169, 3784058);
INSERT INTO Buyer_Demands (Property_Type, Floor_MIN, Bedrooms, Bathrooms, Size_Square_Meter, City, Region, Price_MIN, Price_MAX) VALUES ('Private house', 14, 5, 3, 184, 'Afula', 'Hevel Lakhish', 1621835, 2263869);
INSERT INTO Buyer_Demands (Property_Type, Floor_MIN, Bedrooms, Bathrooms, Size_Square_Meter, City, Region, Price_MIN, Price_MAX) VALUES ('Business', 9, 1, 3, 166, 'Modiin-Maccabim-Reut', 'Hula Valley', 1781103, 2754409);
INSERT INTO Buyer_Demands (Property_Type, Floor_MIN, Bedrooms, Bathrooms, Size_Square_Meter, City, Region, Price_MIN, Price_MAX) VALUES ('Mixed-use', 13, 2, 2, 74, 'Hod HaSharon', 'Golan Heights', 1004390, 2003920);
INSERT INTO Buyer_Demands (Property_Type, Floor_MIN, Bedrooms, Bathrooms, Size_Square_Meter, City, Region, Price_MIN, Price_MAX) VALUES ('Business', 12, 5, 4, 95, 'Modiin Illit', 'Arava', 1061080, 3861221);
INSERT INTO Buyer_Demands (Property_Type, Floor_MIN, Bedrooms, Bathrooms, Size_Square_Meter, City, Region, Price_MIN, Price_MAX) VALUES ('Apartment', 4, 3, 3, 150, 'Maale Adumim', 'Samaria', 1197906, 3173292);
INSERT INTO Buyer_Demands (Property_Type, Floor_MIN, Bedrooms, Bathrooms, Size_Square_Meter, City, Region, Price_MIN, Price_MAX) VALUES ('Private house', 10, 1, 2, 74, 'Beersheba', 'Sharon Plain', 1110615, 2460771);
INSERT INTO Buyer_Demands (Property_Type, Floor_MIN, Bedrooms, Bathrooms, Size_Square_Meter, City, Region, Price_MIN, Price_MAX) VALUES ('Mixed-use', 2, 4, 4, 97, 'Kiryat Shmona', 'Haifa District', 1392827, 2764164);
INSERT INTO Buyer_Demands (Property_Type, Floor_MIN, Bedrooms, Bathrooms, Size_Square_Meter, City, Region, Price_MIN, Price_MAX) VALUES ('Apartment', 1, 1, 2, 168, 'Kiryat Yam', 'Haifa District', 1270735, 2119789);
INSERT INTO Buyer_Demands (Property_Type, Floor_MIN, Bedrooms, Bathrooms, Size_Square_Meter, City, Region, Price_MIN, Price_MAX) VALUES ('Private house', 7, 4, 4, 144, 'Kiryat Ono', 'Haifa District', 1386792, 2211785);
INSERT INTO Buyer_Demands (Property_Type, Floor_MIN, Bedrooms, Bathrooms, Size_Square_Meter, City, Region, Price_MIN, Price_MAX) VALUES ('Business', 10, 5, 3, 106, 'Kiryat Ono', 'Haifa District', 1293070, 2706790);
INSERT INTO Buyer_Demands (Property_Type, Floor_MIN, Bedrooms, Bathrooms, Size_Square_Meter, City, Region, Price_MIN, Price_MAX) VALUES ('Mixed-use', 5, 2, 2, 140, 'Kiryat Ono', 'Haifa District', 1136498, 2764164);
INSERT INTO Buyer_Demands (Property_Type, Floor_MIN, Bedrooms, Bathrooms, Size_Square_Meter, City, Region, Price_MIN, Price_MAX) VALUES ('Apartment', 6, 4, 3, 66, 'Kiryat Ono', 'Haifa District', 1392827, 2764164);
INSERT INTO Buyer_Demands (Property_Type, Floor_MIN, Bedrooms, Bathrooms, Size_Square_Meter, City, Region, Price_MIN, Price_MAX) VALUES ('Private house', 8, 3, 2, 51, 'Kiryat Ono', 'Haifa District', 1017146, 2343496);
INSERT INTO Buyer_Demands (Property_Type, Floor_MIN, Bedrooms, Bathrooms, Size_Square_Meter, City, Region, Price_MIN, Price_MAX) VALUES ('Business', 3, 5, 4, 267, 'Kiryat Ono', 'Haifa District', 1081104, 2091737);
INSERT INTO Buyer_Demands (Property_Type, Floor_MIN, Bedrooms, Bathrooms, Size_Square_Meter, City, Region, Price_MIN, Price_MAX) VALUES ('Mixed-use', 4, 4, 3, 69, 'Kiryat Ono', 'Haifa District', 1081104, 2091737);
INSERT INTO Buyer_Demands (Property_Type, Floor_MIN, Bedrooms, Bathrooms, Size_Square_Meter, City, Region, Price_MIN, Price_MAX) VALUES ('Apartment', 8, 3, 2, 51, 'Kiryat Ono', 'Haifa District', 1081104, 2091737);
INSERT INTO Buyer_Demands (Property_Type, Floor_MIN, Bedrooms, Bathrooms, Size_Square_Meter, City, Region, Price_MIN, Price_MAX) VALUES ('Private house', 18, 5, 2, 235, 'Bat Yam', 'Tel Aviv District', 1424395, 2892570);
INSERT INTO Buyer_Demands (Property_Type, Floor_MIN, Bedrooms, Bathrooms, Size_Square_Meter, City, Region, Price_MIN, Price_MAX) VALUES ('Mixed-use', 1, 5, 4, 125, 'Modiin Illit', 'Arava', 1433536, 3388802);
INSERT INTO Buyer_Demands (Property_Type, Floor_MIN, Bedrooms, Bathrooms, Size_Square_Meter, City, Region, Price_MIN, Price_MAX) VALUES ('Apartment', 14, 3, 2, 201, 'Modiin Illit', 'Arava', 1433536, 3388802);
INSERT INTO Buyer_Demands (Property_Type, Floor_MIN, Bedrooms, Bathrooms, Size_Square_Meter, City, Region, Price_MIN, Price_MAX) VALUES ('Private house', 18, 3, 2, 51, 'Kiryat Ata', 'Sharon Plain', 1017146, 2343496);
INSERT INTO Buyer_Demands (Property_Type, Floor_MIN, Bedrooms, Bathrooms, Size_Square_Meter, City, Region, Price_MIN, Price_MAX) VALUES ('Business', 18, 5, 2, 235, 'Bat Yam', 'Tel Aviv District', 1424395, 2892570);
INSERT INTO Buyer_Demands (Property_Type, Floor_MIN, Bedrooms, Bathrooms, Size_Square_Meter, City, Region, Price_MIN, Price_MAX) VALUES ('Mixed-use', 1, 5, 4, 125, 'Modiin Illit', 'Arava', 1433536, 3388802);
INSERT INTO Buyer_Demands (Property_Type, Floor_MIN, Bedrooms, Bathrooms, Size_Square_Meter, City, Region, Price_MIN, Price_MAX) VALUES ('Apartment', 14, 3, 2, 201, 'Modiin Illit', 'Arava', 1433536, 3388802);
INSERT INTO Buyer_Demands (Property_Type, Floor_MIN, Bedrooms, Bathrooms, Size_Square_Meter, City, Region, Price_MIN, Price_MAX) VALUES ('Private house', 18, 3, 2, 51, 'Kiryat Ata', 'Sharon Plain', 1017146, 2343496);
INSERT INTO Buyer_Demands (Property_Type, Floor_MIN, Bedrooms, Bathrooms, Size_Square_Meter, City, Region, Price_MIN, Price_MAX) VALUES ('Business', 18, 5, 2, 235, 'Bat Yam', 'Tel Aviv District', 1424395, 2892570);
INSERT INTO Buyer_Demands (Property_Type, Floor_MIN, Bedrooms, Bathrooms, Size_Square_Meter, City, Region, Price_MIN, Price_MAX) VALUES ('Mixed-use', 1, 5, 4, 125, 'Modiin Illit', 'Arava', 1433536, 3388802);
INSERT INTO Buyer_Demands (Property_Type, Floor_MIN, Bedrooms, Bathrooms, Size_Square_Meter, City, Region, Price_MIN, Price_MAX) VALUES ('Apartment', 14, 3, 2, 201, 'Modiin Illit', 'Arava', 1433536, 3388802);

--IMPORTANT NOTE - there are some data similarities in different tables such as the general address of the owners and properties are close to one another. 
--However, it is never the same. They are in the same city/region but never the same exact address. 
--If this is not random enough to be considered proper data integrity please tell me. 