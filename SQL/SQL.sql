/*
dateid
date
year
quarter
quarter_name
month
month_name
weekday
weekday_name
is_weekday
is_weekend                
*/

CREATE TABLE MyDimDate (
			dateid INTEGER NOT NULL PRIMARY KEY,
			date DATE NOT NULL,				   -- YYYY
			year INTEGER NOT NULL,     		   -- YYYY-MM-DD
			quarter INTEGER NOT NULL,		   -- 1, 2, ... 4
			quarter_name CHAR(2),              -- Q1, Q2, ... Q4
			month INTEGER NOT NULL,			   -- 1 (January), 2 (February) ... 12 (December)
			month_name VARCHAR(10),			   -- January, February, ... December
			weekday INTEGER NOT NULL, 		   -- 1 (Mon), 2 (Tues) ... 0 (Sunday)
			weekday_name VARCHAR(10) NOT NULL, -- Monday, Tuesday, ... Sunday
			is_weekday BOOLEAN NOT NULL, 	   --  True/False (if date is weekday)
  			is_weekend BOOLEAN NOT NULL 	   --  True/False (if date is weekend)
);


/*
waste_type_id
type_of_waste
amount_of_waste_tons
*/
	
CREATE TABLE MyDimWaste (
			waste_type_id INTEGER NOT NULL PRIMARY KEY,
			type_of_waste VARCHAR(10) NOT NULL,
			amount_of_waste_tons FLOAT NOT NULL
);


/*
zoneid
collection_zone
city
*/


CREATE TABLE MyDimZone (
			zoneid INTEGER NOT NULL PRIMARY KEY,
			collection_zone VARCHAR(10) NOT NULL,
			city VARCHAR(15) NOT NULL	
)


/*
tripid
dateid
waste_type_id
zone_id
station
*/


CREATE TABLE MyFactTrips (
		  tripid INTEGER NOT NULL PRIMARY KEY,
		  dateid INTEGER NOT NULL REFERENCES MyDimDate(dateid),
		  waste_type_id INTEGER NOT NULL REFERENCES MyDimWaste(waste_type_id),
		  zoneid INTEGER NOT NULL REFERENCES MyDimZone(zoneid),
		  station VARCHAR(15) NOT NULL
);





