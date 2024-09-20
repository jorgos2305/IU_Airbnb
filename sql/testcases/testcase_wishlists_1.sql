-- Test 1 Show the wish lists and propertey together with the own of the wish list
SELECT 
    CONCAT(guest.first_name, ' ', guest.last_name) AS 'Guest',
    wishlist.name AS 'Has wishlist',
    property.title AS 'Property',
    city.name AS 'Location'
FROM
    wishlist
        INNER JOIN
    guest ON wishlist.guest_id = guest.guest_id
        INNER JOIN
    property ON wishlist.property_id = property.property_id
        INNER JOIN
    address ON property.address_id = address.address_id
        INNER JOIN
    city ON address.city_id = city.city_id
ORDER BY 1 , 2;
