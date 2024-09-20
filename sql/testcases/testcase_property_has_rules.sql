-- Check the rules of a specific property
SET @property_of_choice = 3; -- Enter property_id here
SELECT 
    property.property_id AS 'PropertyID',
    property.title AS 'Property',
    property_rule.description AS 'Rule'
FROM
    property
        INNER JOIN
    property_has_property_rule ON property.property_id = property_has_property_rule.property_id
        INNER JOIN
    property_rule ON property_has_property_rule.property_rule_id = property_rule.property_rule_id
WHERE property.property_id = @property_of_choice;