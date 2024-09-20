SELECT 
    booking.property_id,
    property.title,
    COUNT(invoice.invoice_id) AS 'No of Invoices per property',
    SUM(invoice.rent_fee) AS 'Total rent fee',
    SUM(invoice.service_fee) AS 'Total service fee',
    SUM(invoice.cleaning_fee) AS 'Total cleaning fee'
FROM
    booking
        INNER JOIN
    invoice ON booking.invoice_id = invoice.invoice_id
        INNER JOIN
    booking_status ON booking_status.booking_status_id = booking.booking_status_id
        INNER JOIN
    property ON booking.property_id = property.property_id
GROUP BY booking.property_id
ORDER BY booking.property_id;