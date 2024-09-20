SELECT * FROM booking;

INSERT INTO booking (guest_id, property_id, booking_status_id, invoice_id, rating_id, host_reviews_guest_id, number_of_children, number_of_adults, number_of_seniors, from_date, to_date, created_on, last_updated)
    VALUES
        (7, 4, 4, NULL, NULL, NULL, 2, 2, 0, '2024-11-01', '2024-11-10', current_timestamp(), NULL);

SELECT * FROM booking;

SET @booking_id = 21; -- enter the number of the booking for which the invoice will be created

-- Run transaction to make sure data is consistn after insertion
SET AUTOCOMMIT = 0;
START TRANSACTION;

-- Generate the invoice for the booking in question
INSERT INTO invoice (rent_fee, service_fee, cleaning_fee, status)
SELECT
	-- the rent fee is simply the number of days of the booking times the price per night
    ROUND(property.price_per_night * (DATEDIFF(booking.to_date, booking.from_date)), 2) AS rent_fee,
    -- the service fee, what the platform kaes is 10% of the price per night times the number of days
    ROUND((property.price_per_night * 0.1) * (DATEDIFF(booking.to_date, booking.from_date)), 2) AS service_fee,
    -- the cleaning fee is 6% of the price per night times the number of days
    ROUND((property.price_per_night * .06) * (DATEDIFF(booking.to_date, booking.from_date)), 2) cleaning_fee,
    CASE -- Depending on the status of the booking, set the status of the invoice
        WHEN booking.booking_status_id IN (1,6,7) THEN 'confirmed'
        WHEN booking.booking_status_id IN (2,3,5) THEN 'canceled'
        WHEN booking.booking_status_id = 4 THEN 'pending'
    END
FROM -- Data necessary for the calculation is the booking in question (contains the number of days) and the property (contains the price per night)
    booking
        INNER JOIN
    property ON booking.property_id = property.property_id
WHERE booking.booking_id = @booking_id;

-- Get the ID of the new invoice
SET @invoice_id = last_insert_id();

-- update the booking information with the new invoice
UPDATE booking
SET booking.invoice_id = @invoice_id
WHERE booking.booking_id = @booking_id;
-- commit the changes
COMMIT;
-- Turn autocommit settings back to 1
SET AUTOCOMMIT = 1;
-- display the booking table to see the updated invoice info
SELECT * FROM booking;
