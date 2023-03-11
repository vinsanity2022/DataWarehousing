-- Creating grouping sets
SELECT 
	ft."StationId", 
	dt."TruckType", 
	SUM(ft."WasteCollected") as Total_Waste_Collected
FROM "FactTrips" as ft 
	LEFT JOIN "DimStation" as ds ON ft."StationId"= ds."StationId"
	LEFT JOIN "DimTruck" as  dt ON ft."TruckId"= dt."TruckId"
GROUP BY 
	GROUPING SETS (ft."StationId", dt."TruckType")
ORDER BY dt."TruckType", Total_Waste_Collected DESC;


-- Creating cube
SELECT
	dd."Year",
	ds."City",
	ft."StationId",
	AVG(ft."WasteCollected") as Avg_Waste_Collected
FROM "FactTrips" AS ft
	LEFT JOIN "DimDate" AS dd ON ft."DateId" = dd."DateId"
	LEFT JOIN "DimStation" AS ds ON ft."StationId" = ds."StationId"
GROUP BY
	CUBE (dd."Year", ds."City", ft."StationId")
ORDER BY dd."Year", ds."City", ft."StationId"


-- Creating MQT
CREATE MATERIALIZED VIEW maxwastestats (
	 City,
	 StationId,
	 TruckType,
	 Max_Waste_Collected) AS
(SELECT
	ds."City",
	ft."StationId",
	dt."TruckType",
	MAX("WasteCollected")
FROM "FactTrips" AS ft
	LEFT JOIN "DimStation" AS ds ON ft."StationId" = ds."StationId"
	LEFT JOIN "DimTruck" AS dt ON ft."TruckId" = dt."TruckId"
GROUP BY ds."City", ft."StationId", dt."TruckType");

REFRESH MATERIALIZED VIEW maxwastestats;
