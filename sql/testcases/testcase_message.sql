-- Show the messages when sender and receiver
SELECT 
    CASE -- Define whoe sent the message
		when sender_type = 'guest' then guest.last_name
        when sender_type = 'host' then host.last_name
	END 'FROM',
	CASE -- To define receiver define oposite case to previous statement
		when sender_type = 'guest' then host.last_name
        when sender_type = 'host' then guest.last_name
	END 'TO',
    message.message AS 'MESSAGE',
    message.sent_on_date AS 'DATE SENT'
FROM
    message
        INNER JOIN
    host ON message.host_id = host.host_id
        INNER JOIN
    guest ON message.guest_id = guest.guest_id
ORDER BY 1;
