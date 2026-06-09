-- Creating Database 
Create Database Ola_Rides;
-- Selecting Database
Use Ola_Rides;

-- 1. Retrieve all successful bookings:
Select *
from Ola_Ride_Cleaned_File
where Booking_Status = 'Success';

-- 2. Find the average ride distance for each vehicle type:
Select Vehicle_Type,
	Avg(Ride_Distance) as Avg_Ride_Distance
from Ola_Ride_Cleaned_File
group by Vehicle_Type;

-- 3. Get the total number of cancelled rides by customers:
Select count(*) as Total_Customer_Cancellations
from ola_ride_cleaned_file
where Booking_Status = 'Canceled by Customer';

-- 4. List the top 5 customers who booked the highest number of rides:
Select Customer_ID,
	count(*) as Total_Rides
from ola_ride_cleaned_file
group by Customer_ID
Order By Total_Rides Desc
Limit 5;

-- 5. Get the number of rides cancelled by drivers due to personal and car-related issues:
Select count(*) as Number_of_Rides_Cancelled
from ola_ride_cleaned_file
where Canceled_Rides_by_Driver = 'Personal & Car related issue';

-- 6. Find the maximum and minimum driver ratings for Prime Sedan bookings:
--  Replace blanks with NULL in Driver_Ratings
UPDATE ola_ride_cleaned_file
SET Driver_Ratings = NULL
WHERE Driver_Ratings = ''
	OR Driver_Ratings IS NULL;
    
-- Altering Driver_Ratings  to numeric
ALTER TABLE ola_ride_cleaned_file
MODIFY COLUMN Driver_Ratings DECIMAL(3, 1) NULL;
-- Min/Max Driver Ratings for Prime Sedan

Select max(Driver_Ratings) as Max_Driver_Ratings,
	Min(Driver_Ratings) as Min_Driver_Ratings
from ola_ride_cleaned_file
where Vehicle_Type = 'Prime Sedan'
	and Driver_Ratings is not null;
    
-- 7. Retrieve all rides where payment was made using UPI:
Select *
from ola_ride_cleaned_file
where Payment_Method = 'UPI';

-- 8. Find the average customer rating per vehicle type:
Select Vehicle_Type,
	avg(Customer_Rating) as Avg_Customer_Rating
from ola_ride_cleaned_file
group by Vehicle_Type;

-- 9. Calculate the total booking value of rides completed successfully:
Select sum(Booking_Value) as Total_Rides_Booking_Value
from ola_ride_cleaned_file
where Booking_Status = 'Success';

-- 10. List all incomplete rides along with the reason
Select Booking_ID,
	Incomplete_Rides,
	Incomplete_Rides_Reason
from ola_ride_cleaned_file
where Incomplete_Rides = 'Yes';