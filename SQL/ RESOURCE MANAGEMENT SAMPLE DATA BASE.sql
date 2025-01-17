-- CREATE DATABASE ResourceManagement;

USE ResourceManagement;
CREATE TABLE DBO_ResourceGroup (
ResourceGroupID INT PRIMARY KEY,
ResourceGroup VARCHAR(50) NOT NULL,
CreatedDate DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE DBO_Resource (
ResourceID INT PRIMARY KEY,
ResourceGroupID INT,
ResourceName VARCHAR(50),
ResourceSurname VARCHAR(50),
CreatedDate DATETIME DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY (ResourceGroupID) REFERENCES DBO_ResourceGroup(ResourceGroupID)
);

CREATE TABLE DBO_Customer (
CustomerID INT PRIMARY KEY,
Customer VARCHAR(50),
CreatedDate DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE DBO_Manager (
ManagerID INT PRIMARY KEY,
ManagerName VARCHAR(50),
ManagerSurname VARCHAR(50),
CreatedDate DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE DBO_DepartmentManager(
DepartmentManagerID INT PRIMARY KEY,
DepartmentManagerName VARCHAR(50),
DepartmentManagerSurname VARCHAR(50),
CreatedDate DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE DBO_TeamInfo (
TeamID INT PRIMARY KEY,
ManagerID INT,
DepartmentManagerID INT,
Team VARCHAR(50),
CreatedDate DATETIME DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY (ManagerID) REFERENCES DBO_Manager(ManagerID),
FOREIGN KEY (DepartmentManagerID) REFERENCES DBO_DepartmentManager(DepartmentManagerID)
);

CREATE TABLE DBO_Category(
CategoryID INT PRIMARY KEY,
Catergory VARCHAR(50),
CreatedDate DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE DBO_Availability(
AvailabilityID INT PRIMARY KEY,
Availability VARCHAR(50),
CreatedDate DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE DBO_ProdCodes(
BookingTypeID INT PRIMARY KEY,
CategoryID INT,
AvailabilityID INT,
BookingType VARCHAR(50),
CreatedDate DATETIME DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY (CategoryID) REFERENCES DBO_Category(CategoryID),
FOREIGN KEY (AvailabilityID) REFERENCES DBO_Availability(AvailabilityID)
);


CREATE TABLE DBO_DateTable (
    DateID INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for each date
    FullDate DATE NOT NULL,                -- The actual date
    Year INT NOT NULL,                     -- Year component (e.g., 2024)
    Month INT NOT NULL,                    -- Month component (1-12)
    MonthName VARCHAR(20) NOT NULL,        -- Full name of the month (e.g., January)
    Week INT NOT NULL,                     -- Week number in the year (1-53)
    DayOfWeek VARCHAR(20) NOT NULL,        -- Name of the day (e.g., Monday)
    IsWeekend BOOLEAN NOT NULL             -- Indicates if the date is a weekend (TRUE/FALSE)
);

CREATE TABLE DBO_CostTable(
ID INT AUTO_INCREMENT PRIMARY KEY,
DateID INT, 
ResourceID INT,
CustomerID INT,
BookingTypeID INT,
TeamID INT,
Hours DECIMAL(5,2),
CostToSales DECIMAL (10,2),
CostToClient DECIMAL (10,2),
FOREIGN KEY (DateID) REFERENCES DBO_DateTable(DateID),
FOREIGN KEY (ResourceID) REFERENCES DBO_Employee(EmployeeID),
FOREIGN KEY (CustomerID) REFERENCES DBO_Customer(CustomerID),
FOREIGN KEY (BookingTypeID) REFERENCES DBO_ProdCodes(BookingTypeID)
);
Select * from DBO_CostTable
Drop Table DBO_CostTable
CREATE TEMPORARY TABLE TempCustomer (
    ID INT AUTO_INCREMENT PRIMARY KEY,  -- Auto-increment ID
    Customer VARCHAR(50),
    CreatedDate DATETIME DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO TempCustomer(Customer)
VALUES
('Sanit'), ('Cloudtronics'), ('Hogbridge'), ('Wizardmaster'), ('Accentgate'), ('Timberhouse'), ('Herbbit'), ('Hammernite'), ('Kantouch'), ('Streettom'), ('Pinnaclecast'), ('Driftcast'), ('Lionman'), ('Heartex'), ('Spirit Star'), ('Volfase'), ('Joytechno'), ('Dynamic Space'), ('Haycode'), ('Mountaincast'), ('howware'), ('Zonis'), ('Bridgelight'), ('Ocean Dew'), ('Zamstrip'), ('Ridgesearch'), ('Cliffpaw'), ('Petaltronics'), ('Zaptriptech'), ('Primehead'), ('Oakking'), ('Pinkhouse'), ('Kaylex'), ('Shadespace'), ('Alphaworks'), ('Gogoice'), ('Voltnamfan'), ('Heartmaster'), ('Yewware'), ('Alligatorman'), ('Conecare'), ('Ocean Hut'), ('Zamzoway'), ('Hammerbar'), ('Loft Water'), ('Green Media'), ('Owlbeat'), ('Stimin'), ('Diamondway'), ('Microstones'), ('dondexon'), ('damcom'), ('K-lax'), ('Spider Shack'), ('Streetzap'), ('Yewking'), ('BluTrover'), ('Blueflex'), ('Smartbit'), ('Signal Shack'), ('zonhex'), ('Goldgreen'), ('Berryforce'), ('Rosetime'), ('Technodax'), ('Alpineaid'), ('Twilight Electronics'), ('Vivacom'), ('Boardream'), ('Sologreen'), ('Mermaid Mobile'), ('Flip-technology'), ('Dynamic Phones'), ('Lagoonshade'), ('silverlam'), ('Rhinoworks'), ('Chiefbridge'), ('Nimblebank'), ('Griffindale'), ('Highstreet'), ('Superdox'), ('Signalcloud'), ('Masonbit'), ('Farsdream'), ('Beakland'), ('Zaptech'), ('base-drill'), ('Caveplaster'), ('Glam Corporation'), ('Lucky Bank'), ('Sailhow'), ('Granite Books'), ('Gemmobile'), ('Flexzone'), ('Oaktales'), ('Mapleair'), ('Sailbar');


INSERT INTO DBO_Customer (CustomerID, Customer)
SELECT ID, Customer
FROM TempCustomer;

CREATE TABLE DBO_Employee (
    EmployeeID INT PRIMARY KEY,
    TeamID INT,
    EmployeeName VARCHAR(50),
    EmployeeSurname VARCHAR(50)
)

ALTER TABLE DBO_Employee
ADD CreatedDate DATETIME DEFAULT CURRENT_TIMESTAMP;


INSERT INTO DBO_CostTable(
    DateID, ResourceID, CustomerID, BookingTypeID, TeamID, Hours, CostToSales, CostToClient
)
SELECT
	d.DateID,                       
     e.EmployeeID,                    
     c.CustomerID,                   
     b.BookingTypeID,                  
     t.TeamID,                          
     tb.Hours,                           
     tb.CosttoSales,                     
     tb.CosttoClient

FROM TempBookings tb
 INNER JOIN DBO_DateTable d ON d.FullDate = tb.Date
    INNER JOIN DBO_Employee e ON CONCAT(e.EmployeeName,' ',e.EmployeeSurname) = tb.Resource
    INNER JOIN DBO_Customer c ON c.Customer = tb.Customer
    INNER JOIN DBO_ProdCodes b ON b.BookingType = tb.BookingType
    LEFT JOIN DBO_TeamInfo t ON t.Team = tb.ResourceGroup;



















