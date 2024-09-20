SELECT 
	country.name,
    COUNT(property.property_id) AS 'Number of properties in country'
FROM
    property
        INNER JOIN
    address ON property.address_id = address.address_id
        INNER JOIN
    city ON address.city_id = city.city_id
        INNER JOIN
    country ON city.country_id = country.country_id
GROUP BY country.name
ORDER BY 2 DESC;
