-- Add some properties to a wish list
INSERT INTO wishlist (guest_id, property_id, name, created_on, last_updated)
	VALUES
		(2,1,'Budget-Friendly Finds', current_timestamp(), NULL),
        (2,2,'Budget-Friendly Finds', current_timestamp(), NULL),
        (2,9,'Budget-Friendly Finds', current_timestamp(), NULL),
        (20,19, 'Weekend Getaways', current_timestamp(), NULL);

SELECT * FROM wishlist ORDER BY 2;
