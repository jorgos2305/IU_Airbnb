-- Show a list of the bookings and their locations with their average rating. Show the booking with the highest rating on the top.
SELECT 
    booking.booking_id AS 'BookingID',
    CONCAT(guest.first_name, ' ', guest.last_name) AS 'Guest name',
    property.title AS 'Property',
    CONCAT(city.name, ', ',  country.name) AS 'Location',
    ROUND((rating.cleanness + rating.exactitude + rating.checkin + rating.communication + rating.location + rating.price) / 6.0,
            1) AS 'Average rating'
FROM
    booking
        INNER JOIN
    rating ON booking.rating_id = rating.rating_id
        INNER JOIN
    guest ON booking.guest_id = guest.guest_id
        INNER JOIN
    property ON booking.property_id = property.property_id
        INNER JOIN
    address ON property.address_id = address.address_id
        INNER JOIN
    city ON address.city_id = city.city_id
        INNER JOIN
    country ON city.country_id = country.country_id
ORDER BY 'Average rating' DESC;
