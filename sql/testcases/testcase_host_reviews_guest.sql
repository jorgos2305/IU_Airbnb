SELECT 
    CONCAT(host.first_name, ' ', host.last_name) AS 'Host',
    CONCAT(guest.first_name, ' ', guest.last_name) AS 'Guest',
    property.title AS 'Property',
    CONCAT(city.name, ', ', country.name) AS 'Location',
    host_reviews_guest.review AS 'Review'
FROM
    host
        INNER JOIN
    host_reviews_guest ON host.host_id = host_reviews_guest.host_id
        INNER JOIN
    guest ON host_reviews_guest.guest_id = guest.guest_id
        INNER JOIN
    booking ON host_reviews_guest.host_reviews_guest_id = booking.host_reviews_guest_id
        INNER JOIN
    property ON property.property_id = booking.property_id
        INNER JOIN
    address ON property.address_id = address.address_id
        INNER JOIN
    city ON address.city_id = city.city_id
        INNER JOIN
    country ON city.country_id = country.country_id;