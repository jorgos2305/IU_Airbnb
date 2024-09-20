-- Look for a property has has a specific amenity
SET @amenity_search = 'B%';
SELECT 
	amenity_type.name AS 'AmenityType',
    property_amenity.name AS 'Amenity',
    property.title as 'Property'
FROM
    property
        INNER JOIN
    property_has_property_amenity ON property.property_id = property_has_property_amenity.property_id
        INNER JOIN
    property_amenity ON property_has_property_amenity.property_amenity_id = property_amenity.property_amenity_id
		inner join
	amenity_type on property_amenity.amenity_type_id = amenity_type.amenity_type_id
WHERE LOWER(property_amenity.name) LIKE @amenity_search
ORDER BY 1;
