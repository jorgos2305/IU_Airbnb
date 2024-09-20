-- if the database does not exist, create it
CREATE DATABASE IF NOT EXISTS airbnb;
USE airbnb;

-- cancellation policy
CREATE TABLE IF NOT EXISTS cancellation_policy (
    cancellation_policy_id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    description TEXT NOT NULL,
    PRIMARY KEY (cancellation_policy_id)
);

-- property_type
CREATE TABLE IF NOT EXISTS property_type (
    property_type_id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    PRIMARY KEY (property_type_id)
);

-- host
CREATE TABLE IF NOT EXISTS host (
    host_id INT NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE NOT NULL,
    email VARCHAR(80) NOT NULL,
    phone_number VARCHAR(30) NOT NULL,
    social_media_profile VARCHAR(150) NULL,
    profile_pic_url VARCHAR(150) NOT NULL,
    is_verified TINYINT NOT NULL DEFAULT 0,
    is_superhost TINYINT NOT NULL DEFAULT 0,
    gender ENUM('m', 'f') NOT NULL,
    created_on DATETIME NOT NULL,
    last_updated DATETIME NULL,
    PRIMARY KEY (host_id)
);

-- country
CREATE TABLE IF NOT EXISTS country (
    country_id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    PRIMARY KEY (country_id)
);

-- city
CREATE TABLE IF NOT EXISTS city (
    city_id INT NOT NULL AUTO_INCREMENT,
    country_id INT NOT NULL,
    name VARCHAR(50) NOT NULL,
    PRIMARY KEY (city_id),
    CONSTRAINT fk_city_country1 FOREIGN KEY (country_id)
        REFERENCES airbnb.country (country_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- address
CREATE TABLE IF NOT EXISTS address (
    address_id INT NOT NULL AUTO_INCREMENT,
    city_id INT NOT NULL,
    street_address VARCHAR(50) NOT NULL,
    postal_code VARCHAR(10) NOT NULL,
    PRIMARY KEY (address_id),
    CONSTRAINT fk_address_city1 FOREIGN KEY (city_id)
        REFERENCES airbnb.city (city_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- property
CREATE TABLE IF NOT EXISTS property (
    property_id INT NOT NULL AUTO_INCREMENT,
    cancellation_policy_id INT NOT NULL,
    property_type_id INT NOT NULL,
    host_id INT NOT NULL,
    address_id INT NOT NULL,
    title VARCHAR(50) NOT NULL,
    description TEXT NOT NULL,
    number_of_rooms INT NOT NULL,
    number_of_restrooms INT NOT NULL,
    guest_capacity INT NOT NULL,
    price_per_night DECIMAL(10 , 2) NOT NULL,
    created_on DATETIME NOT NULL,
    last_updated DATETIME NULL,
    PRIMARY KEY (property_id),
    CONSTRAINT fk_property_cancellation_policy1 FOREIGN KEY (cancellation_policy_id)
        REFERENCES airbnb.cancellation_policy (cancellation_policy_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_property_property_type1 FOREIGN KEY (property_type_id)
        REFERENCES airbnb.property_type (property_type_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_property_host1 FOREIGN KEY (host_id)
        REFERENCES airbnb.host (host_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_property_address1 FOREIGN KEY (address_id)
        REFERENCES airbnb.address (address_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- rating
CREATE TABLE IF NOT EXISTS rating (
    rating_id INT NOT NULL AUTO_INCREMENT,
    cleanness INT NOT NULL CHECK (cleanness >=1 AND cleanness <=5),
    exactitude INT NOT NULL CHECK (exactitude >=1 AND exactitude <=5),
    checkin INT NOT NULL CHECK (checkin >=1 AND checkin <=5),
    communication INT NOT NULL CHECK (communication >=1 AND communication <=5),
    location INT NOT NULL CHECK (location >=1 AND location <=5),
    price INT NOT NULL CHECK (price >=1 AND price <=5),
    review TEXT NULL,
    PRIMARY KEY (rating_id)
);

-- property_category
CREATE TABLE IF NOT EXISTS property_category (
    property_category_id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    PRIMARY KEY (property_category_id)
);

-- amenity_type
CREATE TABLE IF NOT EXISTS amenity_type (
    amenity_type_id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    PRIMARY KEY (amenity_type_id)
);

-- property_amenity
CREATE TABLE IF NOT EXISTS property_amenity (
    property_amenity_id INT NOT NULL AUTO_INCREMENT,
    amenity_type_id INT NOT NULL,
    name VARCHAR(50) NOT NULL,
    PRIMARY KEY (property_amenity_id),
    CONSTRAINT fk_property_amenity_amenity_type1 FOREIGN KEY (amenity_type_id)
        REFERENCES airbnb.amenity_type (amenity_type_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- property_rule
CREATE TABLE IF NOT EXISTS property_rule (
    property_rule_id INT NOT NULL AUTO_INCREMENT,
    description TEXT NOT NULL,
    PRIMARY KEY (property_rule_id)
);

-- property_picture
CREATE TABLE IF NOT EXISTS property_picture (
    property_picture_id INT NOT NULL AUTO_INCREMENT,
    property_id INT NOT NULL,
    title VARCHAR(50) NOT NULL,
    description TEXT NOT NULL,
    url VARCHAR(150) NOT NULL,
    created_on DATETIME NOT NULL,
    PRIMARY KEY (property_picture_id),
    CONSTRAINT fk_property_picture_property FOREIGN KEY (property_id)
        REFERENCES airbnb.property (property_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- guest
CREATE TABLE IF NOT EXISTS guest (
    guest_id INT NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE NOT NULL,
    email VARCHAR(80) NOT NULL,
    phone_number VARCHAR(30) NOT NULL,
    social_media_profile VARCHAR(150) NULL,
    profile_pic_url VARCHAR(150) NOT NULL,
    is_verified TINYINT NOT NULL DEFAULT 0,
    gender ENUM('m', 'f') NOT NULL,
    created_on DATETIME NOT NULL,
    last_updated DATETIME NULL,
    PRIMARY KEY (guest_id)
);

-- wish list
CREATE TABLE IF NOT EXISTS wishlist (
    whishlist_id INT NOT NULL AUTO_INCREMENT,
    guest_id INT NOT NULL,
    property_id INT NOT NULL,
    name VARCHAR(50) NOT NULL DEFAULT 'Favorite',
    created_on DATETIME NOT NULL,
    last_updated DATETIME NULL,
    PRIMARY KEY (whishlist_id),
    CONSTRAINT fk_wishlist_guest1 FOREIGN KEY (guest_id)
        REFERENCES airbnb.guest (guest_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_wishlist_property1 FOREIGN KEY (property_id)
        REFERENCES airbnb.property (property_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- message
CREATE TABLE IF NOT EXISTS message (
    message_id INT NOT NULL AUTO_INCREMENT,
    guest_id INT NOT NULL,
    host_id INT NOT NULL,
    sender_type ENUM('guest', 'host') NOT NULL,
    message TEXT NOT NULL,
    sent_on_date DATETIME NOT NULL,
    PRIMARY KEY (message_id),
    CONSTRAINT fk_message_guest1 FOREIGN KEY (guest_id)
        REFERENCES airbnb.guest (guest_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_message_host1 FOREIGN KEY (host_id)
        REFERENCES airbnb.host (host_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- booking_status
CREATE TABLE IF NOT EXISTS booking_status (
    booking_status_id INT NOT NULL AUTO_INCREMENT,
    status VARCHAR(50) NOT NULL,
    PRIMARY KEY (booking_status_id)
);

-- invoice
CREATE TABLE IF NOT EXISTS invoice (
    invoice_id INT NOT NULL AUTO_INCREMENT,
    rent_fee DECIMAL(10 , 2 ) NOT NULL,
    service_fee DECIMAL(10 , 2 ) NOT NULL,
    cleaning_fee DECIMAL(10 , 2 ) NOT NULL,
    status ENUM('confirmed', 'pending', 'canceled') NOT NULL,
    PRIMARY KEY (invoice_id)
);

-- host_reviews_guest
CREATE TABLE IF NOT EXISTS host_reviews_guest (
    host_reviews_guest_id INT NOT NULL AUTO_INCREMENT,
    host_id INT NOT NULL,
    guest_id INT NOT NULL,
    review TEXT NOT NULL,
    created_on DATETIME NOT NULL,
    PRIMARY KEY (host_reviews_guest_id),
    CONSTRAINT fk_host_reviews_guest_host1 FOREIGN KEY (host_id)
        REFERENCES airbnb.host (host_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_host_reviews_guest_guest1 FOREIGN KEY (guest_id)
        REFERENCES airbnb.guest (guest_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- booking
CREATE TABLE IF NOT EXISTS booking (
    booking_id INT NOT NULL AUTO_INCREMENT,
    guest_id INT NOT NULL,
    property_id INT NOT NULL,
    booking_status_id INT NOT NULL,
    invoice_id INT NULL UNIQUE,
    rating_id INT NULL UNIQUE,
    host_reviews_guest_id INT NULL UNIQUE,
    number_of_children INT NOT NULL,
    number_of_adults INT NOT NULL,
    number_of_seniors INT NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
    created_on DATETIME NOT NULL,
    last_updated DATETIME NULL,
    PRIMARY KEY (booking_id),
    CONSTRAINT fk_booking_guest1 FOREIGN KEY (guest_id)
        REFERENCES airbnb.guest (guest_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_booking_property1 FOREIGN KEY (property_id)
        REFERENCES airbnb.property (property_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_booking_booking_status1 FOREIGN KEY (booking_status_id)
        REFERENCES airbnb.booking_status (booking_status_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_booking_invoice1 FOREIGN KEY (invoice_id)
        REFERENCES airbnb.invoice (invoice_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_booking_rating1 FOREIGN KEY (rating_id)
        REFERENCES airbnb.rating (rating_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_booking_host_reviews_guest1 FOREIGN KEY (host_reviews_guest_id)
        REFERENCES airbnb.host_reviews_guest (host_reviews_guest_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- property_availability
CREATE TABLE IF NOT EXISTS property_availability (
    peroperty_availability_id INT NOT NULL AUTO_INCREMENT,
    property_id INT NOT NULL,
    is_available TINYINT NOT NULL,
    booked_from DATE NOT NULL,
    booked_until DATE NOT NULL,
    PRIMARY KEY (peroperty_availability_id),
    CONSTRAINT fk_property_availability_property1 FOREIGN KEY (property_id)
        REFERENCES airbnb.property (property_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- property_has_property_rule
CREATE TABLE IF NOT EXISTS property_has_property_rule (
    property_id INT NOT NULL,
    property_rule_id INT NOT NULL,
    PRIMARY KEY (property_id , property_rule_id),
    CONSTRAINT fk_property_has_property_rule_property1 FOREIGN KEY (property_id)
        REFERENCES airbnb.property (property_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_property_has_property_rule_property_rule1 FOREIGN KEY (property_rule_id)
        REFERENCES airbnb.property_rule (property_rule_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- property_has_property_amenity
CREATE TABLE IF NOT EXISTS property_has_property_amenity (
    property_id INT NOT NULL,
    property_amenity_id INT NOT NULL,
    PRIMARY KEY (property_id , property_amenity_id),
    CONSTRAINT fk_property_has_property_amenity_property1 FOREIGN KEY (property_id)
        REFERENCES airbnb.property (property_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_property_has_property_amenity_property_amenity1 FOREIGN KEY (property_amenity_id)
        REFERENCES airbnb.property_amenity (property_amenity_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- property_has_property_category
CREATE TABLE IF NOT EXISTS property_has_property_category (
    property_id INT NOT NULL,
    property_category_id INT NOT NULL,
    PRIMARY KEY (property_id , property_category_id),
    CONSTRAINT fk_property_has_property_category_property1 FOREIGN KEY (property_id)
        REFERENCES airbnb.property (property_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_property_has_property_category_property_category1 FOREIGN KEY (property_category_id)
        REFERENCES airbnb.property_category (property_category_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- Fictional data
INSERT INTO country (name)
    VALUES
		('France'),
		('Italy'),
		('Spain'),
		('Germany'),
		('United kingdom'),
		('Japan'),
		('China'),
		('Thailand'),
		('United states'),
		('Canada'),
		('Mexico'),
		('Brazil'),
		('Argentina'),
		('Australia'),
		('New zealand'),
		('Fiji'),
		('Greece'),
		('Turkey'),
		('Egypt'),
		('South africa');

INSERT INTO city (country_id, name)
    VALUES
		('1','Paris'), ('1','Nice'), ('1','Marseille'),
        ('2','Rome'), ('2','Venice'), ('2','Florence'), ('2','Milan'),
		('3','Barcelona'), ('3','Madrid'), ('3','Seville'),
        ('4','Berlin'),	('4','Munich'), ('4','Hamburg'),
		('5','London'),	('5','Edinburgh'),	('5','Manchester'),	('5','Liverpool'),
		('6','Tokyo'), ('6','Kyoto'), ('6','Osaka'), ('6','Hiroshima'),
		('7','Beijing'), ('7','Shanghai'), ('8','Bangkok'),	('8','Phuket'),	('8','Pattaya'),
		('9','New York City'), ('9','Los Angeles'),	('9','Miami'),
        ('10','Toronto'), ('10','Montreal'),
        ('11','Mexico City'), ('11','Cancun'), ('11','Playa del Carmen'),
        ('12','Rio de Janeiro'), ('12','São Paulo'),
        ('13','Buenos Aires'), ('13','Bariloche'),
		('14','Sydney'), ('14','Melbourne'),
		('15','Auckland'),
        ('16','Suva'),
		('17','Athens'), ('17','Santorini'), ('17','Mykonos'),
		('18','Istanbul'), ('18','Izmir'),
		('19','Cairo'),
		('20','Cape Town'), ('20','Johannesburg');

INSERT INTO address (city_id, street_address, postal_code)
    VALUES
		(1, "45 Boulevard Montmartre", 75002),
		(2, "8 Avenue Jean Médecin", 06000),
		(2, "15 Rue de France", 06100),
		(3, "23 Quai du Port", 13001),
		(5, "15 Calle della Bissa", 30122),
		(6, "10 Piazza della Signoria", 50122),
		(5, "34 Via de Tornabuoni", 50123),
		(6, "5 Via Montenapoleone", 20121),
		(48, "18 Av. Buenos Aires", 20122),
		(8, "22 Passeig de Gracia", 08002),
		(10, "8 Avenida de la Constitución", 41003),
		(31, "12 Deansgate", "M1 1AA"),
		(17, "20 Bold Street", "L1 1AB"),
		(29, "456 Sunset Blvd", 90002),
		(39, "1 George Street", 2000),
		(39, "25 Pitt Street", 2001),
		(45, "5 Mykonos Town", "846 00"),
		(45, "20 Platis Gialos", "846 01"),
		(48, "5 Av. Juan de Garay", 2000),
		(8, "30 Passeig de Gracia", 08002);

INSERT INTO amenity_type (name)
    VALUES
		('Basic Amenities'),
		('Kitchen and Dining'),
		('Entertainment and Electronics'),
		('Outdoor and Leisure'),
		('Family and Accessibility'),
		('Additional Conveniences');

INSERT INTO property_amenity (amenity_type_id, name)
    VALUES
		(1,'Wi-Fi'), (1,'Air conditioning'), (1,'Heating'), (1,'Towels and linens'), (1,'Toilet paper'), (1,'Hairdryer'), (1,'Iron'),(1,'Hangers'), (1,'Extra pillows and blankets'), (1,'Essentials (soap,shampoo,etc.)'),
		(2,'Kitchen'), (2,'Refrigerator'), (2,'Microwave'), (2,'Stove'), (2,'Oven'), (2,'Dishwasher'), (2,'Coffee maker'), (2,'Toaster'), (2,'Dishes and silverware'), (2,'Pots and pans'),
        (3,'TV'), (3,'Cable or satellite TV'), (3,'Streaming services (Netflix,Hulu,etc.)'), (3,'Sound system'), (3,'DVD player'), (3,'Board games'), (3,'Books'), (3,'Gaming console'), (3,'High-speed internet'),
        (4,'Pool'), (4,'Hot tub'), (4,'BBQ grill'), (4,'Balcony or patio'), (4,'Outdoor furniture'), (4,'Fire pit'), (4,'Beach essentials (towels,umbrella,etc.)'), (4,'Garden or backyard'), (4,'Bicycles'), (4,'Hammock'),
		(5,'Crib'), (5,'High chair'), (5,'Children´s books and toys'), (5,'Baby safety gates'), (5,'Outlet covers'), (5,'Room-darkening shades'), (5,'Step-free access'), (5,'Accessible bathroom'), (5,'Elevator'), (5,'Wide hallways'),
		(6,'Washer'), (6,'Dryer'), (6,'Free parking on premises'), (6,'Luggage drop-off allowed'), (6,'Long-term stays allowed'), (6,'Self-check-in (with keypad)'), (6,'Security cameras on property'), (6,'Smoke alarm'), (6,'Carbon monoxide alarm'),(6,'First aid kit');

INSERT INTO property_category (name)
    VALUES
		('Icons'),
		('National parks'),
		('Lake front'),
		('Amazing pools'),
		('Chef´s kitchen'),
		('Play'),
		('Beach front'),
		('Amazing views'),
		('Tiny homes'),
		('Cabins'),
		('Country side'),
		('Trending'),
		('Farms'),
		('Houseboats'),
		('Castles'),
		('Treehouses'),
		('Designer'),
		('Mansions'),
		('Ryokans'),
		('Caves');
        
INSERT INTO property_rule (description)
	VALUES
			('No pets allowed'),
			('No parties or events'),
			('No smoking'),
			('Quiet hours'),
			('No unauthorized guests'),
			('No illegal activities'),
			('Check-in/check-out times'),
			('Leave property clean'),
			('No shoes indoors');

INSERT INTO property_type (name)
    VALUES
		('House'),
		('Apartment'),
		('Private room'),
		('Shared room'),
		('Hotel'),
		('Guesthouse');

INSERT INTO host (first_name,last_name,date_of_birth,email,phone_number,social_media_profile,profile_pic_url,is_verified,is_superhost,gender,created_on,last_updated)
	VALUES
	  ('Veda','Lester','1982-01-19','ornare.egestas@protonmail.com','+36-460-108-849','https://instagram.com/settings?str=se','https://airbnb.com/user?q=0','1','1','m','2018-10-26 07:51:46','2022-02-07 18:07:02'),
	  ('Marshall','Roberson','1999-04-28','suspendisse.eleifend@yahoo.couk','+53-638-761-720','https://snapchat.com/en-ca?q=0','https://airbnb.com/user?ab=441&aad=2','0','0','f','2023-01-14 14:03:55','2015-12-14 04:42:28'),
	  ('James','Sherman','2000-01-25','quis.lectus@hotmail.edu','+83-029-287-357','https://tiktok.com/sub?client=g','https://airbnb.com/user?p=8','1','1','m','2012-07-17 22:51:25','2020-09-02 03:46:08'),
	  ('Isaac','Harper','1990-07-25','ac.sem.ut@icloud.edu','+81-494-968-562','https://facebook.com/group/9?str=se','https://airbnb.com/user?ad=115','0','0','m','2016-01-28 11:55:59','2015-12-06 14:47:58'),
	  ('Clinton','Shannon','1987-07-25','mauris.erat@aol.ca','+45-269-446-275','https://instagram.com/sub?search=1&q=de','https://airbnb.com/user?gi=100','0','1','m','2009-12-01 03:51:55','2018-12-21 20:29:06'),
	  ('Porter','Lester','1986-11-22','imperdiet.erat@outlook.couk','+81-242-886-413','https://instagram.com/user/110?ad=115','https://airbnb.com/user?str=se','0','0','m','2012-11-14 11:08:19','2024-01-10 04:13:10'),
	  ('Ariana','Wilder','2000-02-23','ante.ipsum.primis@protonmail.net','+61-921-563-123','https://snapchat.com/group/9?q=test','https://airbnb.com/user?str=se','1','0','f','2021-09-28 13:04:00','2012-03-12 15:26:42'),
	  ('Evangeline','Whitehead','1982-05-31','magna.duis@aol.org','+36-739-574-636','https://instagram.com/fr?str=se','https://airbnb.com/user?ad=115','0','0','m','2018-06-23 13:15:29','2020-08-14 12:26:30'),
	  ('Fredericka','Bennett','1991-04-09','nostra.per@aol.org','+42-973-544-447','https://facebook.com/user/110?q=4','https://airbnb.com/user?g=1','1','1','m','2022-07-20 19:07:15','2009-12-17 20:29:32'),
	  ('Macy','Rodgers','1984-05-03','at.arcu@outlook.couk','+30-442-186-471','https://snapchat.com/user/110?q=0','https://airbnb.com/user?q=11','1','0','m','2022-05-04 22:13:22','2018-01-01 22:02:37'),
	  ('Brandon','Beard','1995-10-05','venenatis@aol.net','+55-544-865-033','https://tiktok.com/en-ca?q=4','https://airbnb.com/user?g=1','1','1','m','2010-02-10 22:10:49','2021-09-12 21:00:41'),
	  ('Baker','Dillon','1986-11-19','at.velit.cras@outlook.net','+51-310-999-685','https://tiktok.com/group/9?q=11','https://airbnb.com/user?search=1','1','1','m','2022-01-05 05:06:11','2013-09-23 08:23:25'),
	  ('Clio','Francis','1984-04-10','consectetuer.adipiscing@icloud.net','+25-860-371-792','https://tiktok.com/en-ca?page=1&offset=1','https://airbnb.com/user?q=4','1','0','m','2018-05-28 16:35:03','2013-03-27 07:08:09'),
	  ('Desirae','Brooks','1985-08-16','malesuada.ut.sem@hotmail.couk','+26-516-306-661','https://tiktok.com/en-us?gi=100','https://airbnb.com/user?ad=115','1','1','f','2013-06-08 16:27:03','2012-10-13 23:27:20'),
	  ('Tiger','Hess','1982-02-19','ornare.lectus@yahoo.ca','+48-824-980-537','https://tiktok.com/en-ca?gi=100','https://airbnb.com/user?ad=115','0','0','f','2010-08-09 01:17:43','2023-10-18 06:26:13'),
	  ('Walker','French','1998-07-16','neque@outlook.net','+36-562-720-695','https://instagram.com/user/110?k=0','https://airbnb.com/user?ab=441&aad=2','0','1','f','2010-02-13 13:29:36','2020-03-13 19:33:18'),
	  ('Raven','Acevedo','1984-11-28','sed.dolor@outlook.edu','+14-317-655-620','https://instagram.com/sub?gi=100','https://airbnb.com/user?search=1','0','0','f','2024-03-18 16:46:24','2017-07-17 14:56:13'),
	  ('Keaton','Barnett','1997-04-01','enim.condimentum.eget@outlook.ca','+28-844-101-014','https://tiktok.com/en-ca?gi=100','https://airbnb.com/user?k=0','1','1','f','2022-03-18 18:30:02','2016-01-01 16:19:14'),
	  ('Demetrius','Pittman','1990-08-26','nec.tellus@icloud.ca','+67-670-427-624','https://tiktok.com/settings?q=test','https://airbnb.com/user?q=4','0','1','m','2018-10-14 03:37:29','2010-10-23 16:06:14'),
	  ('Ann','Strickland','1995-06-19','laoreet.libero@google.org','+87-823-872-488','https://tiktok.com/sub/cars?ab=441&aad=2','https://airbnb.com/user?k=0','1','0','f','2021-05-19 07:14:04','2011-06-22 07:04:25');
  
  INSERT INTO guest (first_name,last_name,date_of_birth,email,phone_number,social_media_profile,profile_pic_url,is_verified,gender,created_on,last_updated)
    VALUES
        ('Talon','Gallagher','1988-03-06','placerat.velit@google.net','+86-429-018-568','https://tiktok.com/user/110?search=1&q=de','https://airbnb.com/user?gi=100',0,'f','2013-04-21 17:57:34','2021-03-03 15:55:56'),
        ('Jade','Mccall','1983-12-31','sem.eget@yahoo.couk','+74-738-138-722','https://tiktok.com/site?page=1&offset=1','https://airbnb.com/user?search=1&q=de',0,'f','2017-08-11 18:59:41','2023-10-23 05:11:20'),
        ('Clayton','Delacruz','1981-10-28','ac.libero@hotmail.com','+63-506-771-187','https://snapchat.com/site?search=1','https://airbnb.com/user?ad=115',1,'f','2022-11-08 16:06:04','2014-04-29 13:17:58'),
        ('Melyssa','Perez','1996-09-24','erat.eget@yahoo.net','+92-174-742-258','https://tiktok.com/sub/cars?client=g','https://airbnb.com/user?search=1&q=de',0,'f','2020-10-23 10:10:16','2017-04-26 15:22:15'),
        ('Callie','Mcintyre','1991-03-04','luctus.vulputate@icloud.org','+35-802-893-247','https://snapchat.com/sub?k=0','https://airbnb.com/user?client=g',1,'m','2022-03-07 04:46:22','2012-02-16 19:33:20'),
        ('Kerry','Mathews','1983-05-14','semper.rutrum@outlook.com','+91-818-308-765','https://tiktok.com/en-ca?g=1','https://airbnb.com/user?p=8',0,'f','2012-08-16 07:19:11','2017-06-03 20:19:31'),
        ('Miranda','Morris','1985-08-31','ut.nulla@icloud.com','+82-928-579-832','https://snapchat.com/sub/cars?str=se','https://airbnb.com/user?k=0',0,'m','2023-12-10 07:33:13','2012-03-20 18:09:16'),
        ('Zachery','Mason','1997-08-20','aliquam.adipiscing@outlook.edu','+15-032-661-074','https://snapchat.com/one?client=g','https://airbnb.com/user?str=se',1,'f','2009-05-10 20:57:38','2019-11-22 17:10:16'),
        ('Sebastian','Ayala','1989-08-12','et.malesuada@aol.ca','+86-505-798-877','https://snapchat.com/en-us?q=0','https://airbnb.com/user?ad=115',0,'m','2024-03-29 21:53:25','2022-09-13 20:40:17'),
        ('Quinn','Hansen','1980-05-20','auctor.nunc@protonmail.couk','+72-713-828-343','https://instagram.com/en-ca?ad=115','https://airbnb.com/user?search=1&q=de',1,'m','2022-05-21 17:47:05','2021-02-16 13:45:46'),
        ('Aladdin','Webster','1998-12-03','in.mi@protonmail.org','+66-044-997-517','https://snapchat.com/en-ca?g=1','https://airbnb.com/user?client=g',1,'m','2020-08-05 03:23:24','2010-01-05 00:32:40'),
        ('Oleg','Kim','1983-09-19','accumsan@google.edu','+27-826-225-291','https://facebook.com/one?p=8','https://airbnb.com/user?q=4',1,'m','2018-09-03 16:42:54','2013-03-31 17:39:09'),
        ('Hedley','Whitfield','1986-08-06','in.condimentum@hotmail.com','+19-604-883-310','https://facebook.com/user/110?ab=441&aad=2','https://airbnb.com/user?q=4',0,'m','2020-01-28 09:34:31','2014-02-14 20:48:03'),
        ('Zena','Bowers','1998-03-23','dis@yahoo.ca','+52-553-433-128','https://instagram.com/sub/cars?q=11','https://airbnb.com/user?ab=441&aad=2',0,'f','2016-09-14 15:25:09','2013-09-19 02:25:02'),
        ('Asher','Houston','1998-05-27','amet.consectetuer@outlook.couk','+51-825-423-631','https://snapchat.com/user/110?search=1','https://airbnb.com/user?str=se',1,'f','2021-05-14 07:44:37','2025-02-17 16:31:02'),
        ('Azalia','Hayden','1992-05-06','mattis.ornare@yahoo.com','+84-662-546-399','https://facebook.com/group/9?gi=100','https://airbnb.com/user?gi=100',0,'f','2022-08-23 16:55:40','2017-02-04 07:03:15'),
        ('Akeem','Cervantes','1996-02-06','ipsum.suspendisse.sagittis@hotmail.ca','+91-031-565-872','https://instagram.com/en-us?ad=115','https://airbnb.com/user?search=1&q=de',0,'m','2013-03-18 03:22:44','2024-03-24 14:47:50'),
        ('Clio','Short','1995-08-20','consequat.dolor.vitae@google.net','+45-610-257-695','https://snapchat.com/site?g=1','https://airbnb.com/user?search=1&q=de',1,'f','2015-11-05 00:41:34','2011-01-23 17:45:38'),
        ('Xena','Nelson','1981-09-30','eu@aol.org','+85-926-494-728','https://snapchat.com/fr?client=g','https://airbnb.com/user?client=g',0,'m','2014-07-20 03:12:31','2013-04-21 10:43:57'),
        ('Jada','Blankenship','1989-09-19','luctus.et@yahoo.couk','+78-135-347-599','https://tiktok.com/sub?ad=115','https://airbnb.com/user?search=1',1,'m','2013-08-21 19:12:46','2021-12-12 13:18:52');
	
INSERT INTO message (guest_id,host_id,sender_type,message,sent_on_date)
	VALUES
		(4,10,"guest","Please confirm my reservation request.","2022-08-27 19:45:59"),
		(7,17,"guest","Is early check-in possible?","2025-08-17 20:26:57"),
		(10,5,"guest","Will parking be available?","2023-07-03 09:02:21"),
		(2,2,"host","Your reservation has been confirmed.","2018-03-09 12:40:18"),
		(14,18,"host","Check-in is at 3 PM.","2017-10-15 19:46:30"),
		(6,7,"host","Please provide your arrival time.","2014-08-16 20:56:20"),
		(18,15,"host","The keys will be in the lockbox.","2023-10-18 18:18:06"),
		(6,5,"guest","Can you recommend local restaurants?","2020-11-13 11:58:03"),
		(3,10,"guest","Looking forward to our stay!","2013-08-09 02:17:25"),
		(3,17,"guest","Is there a grocery store nearby?","2011-06-07 19:48:34"),
		(17,13,"guest","Do you offer airport pickup?","2023-04-24 20:15:07"),
		(6,10,"host","Please review the house rules.","2020-02-16 22:21:50"),
		(20,7,"host","Your check-out is at 11 AM.","2017-08-15 05:26:40"),
		(13,20,"host","The wifi password is on the table.","2022-03-08 09:32:35"),
		(2,1,"host","The property is ready for your stay.","2024-12-19 20:14:09"),
		(2,1,"host","Let me know if you need anything.","2015-05-12 23:06:03"),
		(10,4,"host","The heater is in the closet.","2021-06-28 23:31:21"),
		(6,14,"host","Please respect the quiet hours.","2018-01-23 09:37:55"),
		(13,1,"guest","Thank you for your hospitality.","2011-07-16 15:15:13"),
		(18,16,"guest","What time is check-out?","2025-02-02 08:20:24");

INSERT INTO cancellation_policy (name, description)
    VALUES
		('Flexible','Free cancellation until 24 hours before check-in'),
		('Moderate','Free cancellation until 5 days before check-in'),
		('Strict','Free cancellation until 7 days before check-in. After that, the first night is non-refundable'),
		('Non-Refundable', 'No cancellation or modification. All payments are non-refundable'),
		('Last Minute','Free cancellation until 1 day before check-in'),
		('Long-Term Stay','Free cancellation until 14 days before check-in. After that, 50% of the total booking is non-refundable'),
		('Custom Policy','Cancellation terms set by the host. Refunds and cancellation conditions vary');
        
INSERT INTO property (cancellation_policy_id, property_type_id, host_id, address_id, title, description, number_of_rooms, number_of_restrooms, guest_capacity, price_per_night, created_on, last_updated)
    VALUES
        (1, 1, 3, 2, 'Chalet in Combloux', '50 m2 The Entrance is on the first floor of the Chalet. An amazing view of the Mont Blanc and direct access right from the chalet to the ski hill in winter as in summer. Hiking trails right in the back. The Apartment is open with an American type kitchen. The Bathroom has an Italian style shower. It sleeps 4 comfortably but can sleep 5 with a fold out chair bed (with additional cost for an extra person). The Kitchen is fully equipped.', 1, 1, 4, 67, '2010-03-15 08:45:00', '2011-06-20 12:30:00'),
        (5, 3, 4, 3, 'Aparment in Canet-en-Roussillon', 'Located on the seafront between the hypercenter and the harbour, my 30 m2 apartment can accommodate up to 4 people in a secure residence. Refurbished, it has been designed to give you a warm and soothing atmosphere with stunning views of the sea. A large terrace will allow you to have your meals outside. A parking space is reserved for you at the Mediterranean car park. Various shops await you at the foot of the residence...', 2, 1, 4, 147, '2012-11-22 14:10:00', '2013-03-15 18:25:00'),
        (4, 4, 12, 9, 'Condo in Buenos Aires', 'This perfect apartment has an unbeatable location, meters from the most important attractions such as Casa Rosada, the obelisk and Calle Florida, in the heart of Buenos Aires. Due to its strategic location, you have access to a wide variety of transports (metro, subway, bus).', 1, 1, 2, 41, '2014-05-08 07:35:00', '2015-02-19 22:50:00'),
        (6, 6, 16, 4, 'Cave in Noyers-sur-Cher', 'Welcome to the Grotte du Moulin! This natural loft is recessed in a limestone mound and will surprise you with its transparency. It consists of a large kitchen open to the living room and a bedroom with bathroom separated by a sliding garage door. In the bedroom, you have a double bed (160 cm) and in the living room a single bed (90 cm) with a non-convertible sofa that can be used as a small single bed.', 2, 1, 4, 156, '2016-01-01 00:00:00', '2016-10-07 13:15:00'),
        (2, 2, 15, 1, 'Loft in Saint-Arnoult', 'In the heart of Rambouillet, you will be staying in a charming t2 with terrace and garden, in a quiet and pedestrian neighborhood. Tastefully decorated, quiet, bright, functional. Ideal for work, tourist or event stays for two, with friends, or with children. Meals can be enjoyed on the terrace and enjoy large openings to the outside. Free underground parking space. Secure residence, easily accessible by car.', 2, 2, 4, 95, '2017-09-11 16:20:00', NULL),
        (1, 4, 17, 14, 'Barn in Vero Beach', 'Enjoy a bit of paradise at Pura Vida Florida Farm — an ACTIVE working farm — in Vero Beach, FL. Offering an amazing place to relax, unwind and connect with nature. Walking around the farm, you can meet our beloved animals like “Sweetheart,” the donkey and share some time with the horses, Daisy, Sundance and Jazzy (and more!) — who are our guests, too. This beautiful space is located on the second floor of our barn with private access.', 4, 3, 6, 230, '2018-04-19 10:45:00', '2019-08-24 17:40:00'),
        (3, 5, 20, 16, 'Apartment in North Sydney', 'A large luxury, modern & private 2 bedroom apartment. On the border of North Sydney & Crows Nest, it is perfect for businesses, travelers, hospital visitors. North facing, located in a quiet leafy street just an easy stroll from The Mater Hospital, North Sydney Oval, cafes, restaurants, Crows Nest shopping strip & supermarket. The bus stop is just around the corner with direct buses into Sydney City centre. The Royal North Shore Hospital is a 10-minute bus trip away.', 2, 2, 4, 115, '2020-06-03 06:25:00', '2021-05-10 21:55:00'),
        (4, 1, 12, 17, 'Cycladic home in Mykonos', 'Perfectly located at the heart of traditional old town of Mykonos - Little Venice few steps away from the world-famous Windmills! This bright and spacious 40 sq.m. Myconian holiday suite is a genuine traditional architect jewel. It has been fully renovated in 2024, keeping much of its original character. It is situated in the heart of Mykonos town next to Paraportiani Church featuring amazing Aegean Sea & sunset views!', 2, 1, 3, 83, '2013-07-25 11:50:00', NULL),
        (6, 2, 13, 18, 'Apartment in Tourlos', 'Namaste Sea View Maisonette is a two-level renovated cozy and spacious apartment. Located in the area of Tourlos just 4 minutes driving distance of the center of Mykonos Town where all the restaurants and bars are. Able to offer you a luxury and comfortable accommodation, ideal for families, couples or groups of friends.', 4, 4, 6, 280, '2015-12-31 23:59:00', '2016-12-25 09:30:00'),
        (2, 3, 15, 6, 'Townhouse in Florence', 'Apartment completely renovated, equipped (espresso machine for Lavazza capsules, electric kettle, toaster, electric juicer, microwave etc.), complete with linen (sterilized sheets and towels from hotel laundry service), programmable heating, washing machine, air conditioning, Smart TV 50", Wi-Fi, video intercom, is suitable for couples with a child, ideal living room workers (basic office set).', 2, 2, 3, 114, '2022-03-15 14:20:00', '2023-07-18 19:05:00'),
        (1, 6, 16, 12, 'Loft in Longueuil', 'A loft with balcony, bathroom, kitchen, private entrance and parking in a single-family house near Montreal. It is equipped with a wall-mounted heat pump, mobile induction cooktop, small stainless steel oven, heated floor, humidity detector, etc. The bed is queen size. Washer and dryer are shared. Renovation completed in January 2023. The furniture is from 2023. Several shops within walking distance.', 1, 1, 2, 42, '2010-08-07 04:30:00', '2010-12-31 20:00:00'),
        (6, 1, 19, 5, 'Apartment in Tremezzo', 'Welcome to "I Portici di Palazzo Brentano," a wonderful apartment located in a historic 18th-century palace in Tremezzo. This three-room apartment reflects the classic Italian style of the 1900s with some baroque touches and offers an unforgettable stay with a spectacular view of the lake. You can enjoy the historical charm and elegance of this unique residence.', 2, 1, 4, 112, '2021-02-10 13:40:00', '2022-09-23 08:15:00'),
        (1, 4, 20, 7, 'Room in Venice', 'Casa Betta, bright, carefully renovated, independent entrance, spacious double bedroom, a living room with dining area and sofa bed, a kitchen equipped with all the comforts, and a bathroom with shower cabin. The apartment comfortably accommodates three people, having a sofa-bed. Equipped with Wi-Fi, 2 TVs, hair dryer, washing machine, toaster, kettle, oven, iron... Upon your arrival you will find towels, sheets and blankets.', 1, 1, 2, 120, '2019-11-20 09:55:00', '2020-01-30 23:45:00'),
        (2, 2, 1, 13, 'Guesthouse in Merseyside', 'Enjoy a luxurious experience at this brand new centrally-located apartment in the heart of Liverpool. This large but cozy flat with amazing floor-to-ceiling windows across the length of the apartment will wow you as soon as you step foot into the apartment. You will just be a stones throw away from the hustle and bustle of Liverpool with everything you need on your doorstep. However, as the apartment is set back off a main road, it has the luxury of being very quiet with the best of both worlds.', 2, 1, 2, 125, '2011-04-29 22:10:00', NULL),
        (6, 5, 3, 15, 'Villa in Bondi Beach', 'Experience the ultimate Bondi lifestyle in this spectacular apartment nestled on the oceanfront of world-renowned Bondi Beach. Wake up to the warm glow of the sun and savor a freshly brewed coffee on your very own private balcony as you gaze out to spot pods of dolphins in the surf. Relax with a sundowner in hand as you soak in the stunning ocean views and watch the waves crash against the shore at North Bondi Fish that is only a stones throw away. Fall head over heels for this idyllic haven.', 3, 2, 5, 128, '2017-06-18 05:00:00', '2018-02-27 13:55:00'),
        (3, 1, 4, 10, 'Guesthouse in Parktown North', 'Beautiful ivy-covered double-storey cottage set in a charming, romantic garden. Very bright, well-appointed, stylish and peaceful. The bedroom and work area are accessed by one flight of stairs to a comfortable and light-filled loft-like space, while below is a spacious seating area and modern bathroom with a pebble mosaic rain shower. Both mezzanine and ground floor look out onto a tranquil, bird-filled garden. Only 1 block from bustling 4th avenue Parkhurst, yet extremely quiet.', 1, 1, 2, 38, '2015-03-09 18:35:00', NULL),
        (4, 6, 6, 8, 'Room in Florence', 'Single room in an elegant penthouse with terrace and stunning views of the historic center. Just steps from Piazza Beccaria, a 15-minute walk to the Duomo. Well connected to public transportation, near Campo di Marte station, well-stocked supermarket just across the street, post office, charming shops, delightful restaurants, and welcoming cafes along the parallel Via Gioberti.', 1, 1, 2, 65, '2024-07-12 07:15:00', NULL),
        (1, 2, 7, 19, 'Room in Buenos Aires', 'Welcome to our modern apartment in the heart of Buenos Aires. Privileged location, located just a block away from the iconic Obelisk and on the main avenue of the citys main theatres. With a unique view that will allow you to enjoy the beautiful City of Buenos Aires. We have a garage in the same building if you need to hire the additional service.', 1, 1, 2, 24, '2009-10-14 03:55:00', '2010-02-02 11:30:00'),
        (2, 4, 8, 20, 'Loft in Barcelona', 'A renovated Loft (25 m2) in the heart of Barcelona, just next to Passeig de Gracia and Plaza Catalunya. It is warm and cozy with all you need for having an unforgettable season in Barcelona. Hardwood floors, an elegant kitchen and a terrace to enjoy.', 1, 1, 2, 115, '2013-01-20 15:05:00', '2013-08-14 22:50:00'),
        (6, 1, 1, 11, 'Apartment in Casco Antiguo', 'Can you imagine finding a bright apartment, with an elevator and a garage in the heart of Seville? You already have it! Beautiful apartment very central a few minutes from the Cathedral. It has a living room with fully equipped kitchen, bathroom, a bedroom with a large 180 cm bed and 2 balconies that make it especially bright. The floor is parquet and you have air conditioning to avoid the heat. You will have high speed WIFI. You can walk through the historic center, you are already in it.', 1, 1, 2, 150, '2020-10-01 21:25:00', '2021-04-09 06:35:00');

INSERT INTO property_picture (property_id, title, description, url, created_on)
    VALUES
        (1, 'Mont Blanc View', 'Stunning view of Mont Blanc from the chalet’s balcony.', 'https://airbnb.com/picture??q=0', '2010-03-16 09:00:00'),
        (1, 'Cozy Living Room', 'The open-concept living room with an American-style kitchen.', 'https://airbnb.com/picture??str=se', '2010-03-16 09:15:00'),
        (1, 'Italian Style Shower', 'Modern bathroom featuring an Italian-style shower.', 'https://airbnb.com/picture??q=4', '2010-03-16 09:30:00'),
        (2, 'Seafront View', 'Beautiful seafront view from the apartment’s terrace.', 'https://airbnb.com/picture??q=4', '2017-07-22 16:10:00'),
        (2, 'Modern Kitchen', 'Fully equipped kitchen with modern appliances.', 'https://airbnb.com/picture??search=1&q=de', '2017-07-22 16:25:00'),
        (2, 'Bright Living Room', 'Bright and warm living room with stunning sea views.', 'https://airbnb.com/picture??q=test', '2017-07-22 16:40:00'),
        (3, 'City Skyline', 'View of the Buenos Aires city skyline from the condo.', 'https://airbnb.com/picture??client=g', '2014-05-09 08:00:00'),
        (3, 'Comfortable Bedroom', 'Cozy bedroom with a comfortable double bed.', 'https://airbnb.com/picture??gi=100d=2', '2014-05-09 08:20:00'),
        (3, 'Central Location', 'Located in the heart of Buenos Aires, close to major attractions.', 'https://airbnb.com/picture??str=se', '2014-05-09 08:40:00'),
        (4, 'Unique Cave Interior', 'Rustic interior carved into a limestone mound.', 'https://airbnb.com/picture??g=1', '2016-01-02 10:00:00'),
        (4, 'Spacious Living Area', 'Open living space with natural light.', 'https://airbnb.com/picture??search=1', '2016-01-02 10:15:00'),
        (4, 'Cozy Bedroom', 'Comfortable bedroom with natural stone walls.', 'https://airbnb.com/picture??q=0', '2016-01-02 10:30:00'),
        (5, 'Charming Terrace', 'Private terrace overlooking a quiet garden.', 'https://airbnb.com/picture??gi=100d=2', '2017-09-12 16:30:00'),
        (5, 'Modern Interior', 'Stylish and modern interior with bright lighting.', 'https://airbnb.com/picture??q=4', '2017-09-12 16:45:00'),
        (5, 'Cozy Bedroom', 'A peaceful bedroom with large windows.', 'https://airbnb.com/picture??gi=100d=2', '2017-09-12 17:00:00'),
        (6, 'Rustic Barn', 'Exterior view of the charming rustic barn.', 'https://airbnb.com/picture??str=se', '2018-04-20 11:00:00'),
        (6, 'Farm Animals', 'Friendly farm animals near the barn.', 'https://airbnb.com/picture??q=0', '2018-04-20 11:15:00'),
        (6, 'Cozy Interior', 'Comfortable interior space within the barn.', 'https://airbnb.com/picture??g=1', '2018-04-20 11:30:00'),
        (7, 'Luxury Living Room', 'Spacious and luxurious living room with modern furnishings.', 'https://airbnb.com/picture??gi=100d=2', '2020-06-04 07:00:00'),
        (7, 'Balcony View', 'View from the balcony overlooking North Sydney.', 'https://airbnb.com/picture??k=0', '2020-06-04 07:15:00'),
        (7, 'Modern Kitchen', 'Fully equipped kitchen with modern appliances.', 'https://airbnb.com/picture??q=0', '2020-06-04 07:30:00'),
        (8, 'Aegean Sea View', 'Stunning view of the Aegean Sea from the balcony.', 'https://airbnb.com/picture??client=g', '2013-07-26 12:00:00'),
        (8, 'Traditional Mykonian Design', 'Authentic Mykonian architecture with modern touches.', 'https://airbnb.com/picture??str=se', '2013-07-26 12:15:00'),
        (8, 'Bright Living Area', 'Spacious and bright living area with sea views.', 'https://airbnb.com/picture??g=1', '2013-07-26 12:30:00'),
        (9, 'Modern Duplex', 'Contemporary duplex apartment in Tourlos.', 'https://airbnb.com/picture??q=11', '2016-01-01 00:30:00'),
        (9, 'Spacious Living Room', 'Large living room with open kitchen.', 'https://airbnb.com/picture??g=1', '2016-01-01 00:45:00'),
        (9, 'Balcony with Sea View', 'Balcony offering a scenic view of the sea.', 'https://airbnb.com/picture??ad=115', '2016-01-01 01:00:00'),
        (10, 'Renovated Kitchen', 'Modern kitchen with high-end appliances.', 'https://airbnb.com/picture??q=0', '2022-03-16 14:30:00'),
        (10, 'Living Room Decor', 'Stylish living room with a cozy atmosphere.', 'https://airbnb.com/picture??q=test', '2022-03-16 14:45:00'),
        (10, 'Bedroom with a View', 'Bedroom offering a beautiful view of Florence.', 'https://airbnb.com/picture??q=0', '2022-03-16 15:00:00');

INSERT INTO property_has_property_amenity (property_id, property_amenity_id)
    VALUES
        (1, 1), (1, 4), (1, 25),
        (2, 14), (2, 35), (2, 58),
        (3, 2), (3, 17), (3, 40),
        (4, 9), (4, 29), (4, 42),
        (5, 7), (5, 11), (5, 33),
        (6, 12), (6, 36), (6, 51),
        (7, 3), (7, 18), (7, 43),
        (8, 13), (8, 34), (8, 46),
        (9, 6), (9, 31), (9, 47),
        (10, 10), (10, 28), (10, 39),
        (11, 5), (11, 22), (11, 41),
        (12, 20), (12, 44), (12, 49),
        (13, 8), (13, 23), (13, 48),
        (14, 15), (14, 38), (14, 56),
        (15, 16), (15, 32), (15, 55),
        (16, 21), (16, 24), (16, 50),
        (17, 26), (17, 30), (17, 54),
        (18, 19), (18, 27), (18, 37),
        (19, 45), (19, 52), (19, 53),
        (20, 57), (20, 59), (20, 53);

INSERT INTO property_has_property_category (property_id, property_category_id)
    VALUES
        (1, 1), (1, 8),
        (2, 3), (2, 7),
        (3, 4), (3, 10),
        (4, 9), (4, 16),
        (5, 5), (5, 8),
        (6, 10), (6, 13),
        (7, 11), (7, 12),
        (8, 14), (8, 7),
        (9, 17), (9, 1),
        (10, 2), (10, 15),
        (11, 18), (11, 6),
        (12, 19), (12, 3),
        (13, 4), (13, 9),
        (14, 10), (14, 16),
        (15, 11), (15, 8),
        (16, 14), (16, 13),
        (17, 7), (17, 5),
        (18, 2), (18, 15),
        (19, 12), (19, 6),
        (20, 17), (20, 19);

INSERT INTO property_has_property_rule (property_id, property_rule_id)
    VALUES
        (1, 1), (1, 3), (1, 7),
        (2, 2), (2, 5), (2, 8),
        (3, 1), (3, 4), (3, 6),
        (4, 3), (4, 5), (4, 9),
        (5, 2), (5, 4), (5, 7),
        (6, 1), (6, 3), (6, 8),
        (7, 2), (7, 6), (7, 9),
        (8, 1), (8, 4), (8, 5),
        (9, 3), (9, 6), (9, 8),
        (10, 2), (10, 5), (10, 9),
        (11, 1), (11, 4), (11, 7),
        (12, 3), (12, 6), (12, 8),
        (13, 2), (13, 4), (13, 5),
        (14, 1), (14, 6), (14, 9),
        (15, 3), (15, 5), (15, 8),
        (16, 2), (16, 4), (16, 7),
        (17, 1), (17, 6), (17, 8),
        (18, 3), (18, 5), (18, 9),
        (19, 2), (19, 4), (19, 7),
        (20, 1), (20, 6), (20, 8);

INSERT INTO wishlist (guest_id, property_id, name, created_on, last_updated)
    VALUES
        (12, 7, 'Dream Getaways', '2014-05-10 14:23:00', '2020-11-18 09:45:00'),
        (12, 16, 'Beachfront Escapes', '2018-01-15 10:10:00', '2023-05-10 17:20:00'),
        (5, 16, 'Beachfront Escapes', '2017-07-21 16:05:00', NULL),
        (5, 9, 'Budget-Friendly Finds', '2020-11-10 14:15:00', '2021-07-22 12:00:00'),
        (8, 3, 'City Adventures', '2019-03-12 11:30:00', '2023-08-05 14:20:00'),
        (8, 10, 'Weekend Getaways', '2021-04-18 09:35:00', '2022-03-10 11:45:00'),
        (14, 4, 'Romantic Retreats', '2013-02-17 08:50:00', '2015-09-29 17:45:00'),
        (14, 12, 'Island Hopping', '2013-11-19 22:30:00', '2018-06-14 13:20:00'),
        (7, 2, 'Family Vacations', '2020-12-29 19:10:00', '2021-07-19 12:35:00'),
        (19, 2, 'Countryside Cottages', '2015-10-02 13:45:00', NULL),
        (19, 11, 'Countryside Cottages', '2015-10-02 13:45:00', NULL),
        (11, 6, 'Luxury Stays', '2018-04-18 10:00:00', '2022-02-26 16:55:00'),
        (13, 9, 'Budget-Friendly Finds', '2016-11-25 21:15:00', '2017-12-03 09:00:00'),
        (13, 1, 'Adventure Awaits', '2020-10-10 09:05:00', '2022-05-28 18:15:00'),
        (16, 10, 'Weekend Getaways', '2012-01-14 18:40:00', NULL),
        (2, 13, 'Mountain Retreats', '2021-08-05 15:25:00', '2024-07-10 08:50:00'),
        (10, 19, 'Urban Oasis', '2010-07-22 07:55:00', '2011-04-29 19:35:00'),
        (18, 19, 'Historic Homes', '2012-05-03 06:10:00', NULL),
        (6, 8, 'Pet-Friendly Stays', '2022-09-10 14:45:00', '2023-03-15 20:25:00'),
        (10, 17, 'Winter Wonderlands', '2014-02-08 05:20:00', '2019-10-22 16:10:00'),
        (9, 15, 'Unique Experiences', '2010-09-15 11:35:00', '2015-08-30 09:40:00'),
        (15, 18, 'Lakefront Lodges', '2016-12-07 17:50:00', NULL),
        (15, 5, 'Hidden Gems', '2023-02-25 20:40:00', '2024-01-18 07:30:00'),
        (20, 20, 'Summer Escapes', '2011-06-29 13:15:00', '2020-03-05 10:55:00');
        
INSERT INTO booking_status (status)
    VALUES
        ('Confirmed'),
        ('Canceled by guest'),
        ('Canceled by host'),
        ('Pending confirmation'),
        ('Rejected by host'),
        ('Checked-In'),
        ('Checked-Out');

INSERT INTO rating (cleanness, exactitude, checkin, communication, location, price, review)
VALUES
    (5, 5, 5, 4, 5, 5, "Super nice place to stay, with a great host. The location is great to be quickly in twon on the one hand and on the other hand to have your peace and quiet before the tourist hustle and bustle."),
    (5, 4, 4, 4, 4, 4, "Very very very worth the experience, the room is brand new, the bathroom is clean, we ate breakfast in the garden in the morning.The host was so thoughtful, welcoming, kind and we all loved him."),
    (5, 4, 5, 4, 4, 4, "Great place: central but private. Has everything we needed. The host responds messages within minutes!"),
    (4, 4, 3, 3, 5, 4, "We loved the location. The apartment was lovely but quite small and best for travellers with small suitcases. We have two 23 kg cases so we had very little space to move around. There were more steps up from the elevator than we expected. The outside patio would be such a plus when the weather is warm."),
    (4, 5, 4, 4, 4, 4, "Amazing hosts, very responsive, very welcoming! Amazing location as well. Lots of eateries, galleries, etc. And very accessible to other parts of town"),
    (4, 4, 3, 4, 4, 3, "Good balance between being available and not being in your face. Wifi signal a little weak during loadshedding but thanks to a gas stove and inverter it hardly affects you otherwise.");

INSERT INTO property_availability (property_id, is_available, booked_from, booked_until)
    VALUES
		(1,0,"2024-08-01","2024-08-05"),
		(1,0,"2024-09-18","2024-09-22"),
		(2,0,"2024-08-03","2024-08-07"),
		(2,1,"2024-09-05","2024-09-09"),
		(3,1,"2024-09-12","2024-09-16"),
		(3,0,"2024-09-15","2024-09-18"),
		(4,0,"2024-07-20","2024-07-25"),
		(4,0,"2024-09-03","2024-09-08"),
		(5,0,"2024-08-10","2024-08-14"),
		(5,0,"2024-09-15","2024-09-18"),
		(6,0,"2024-08-18","2024-08-22"),
		(6,0,"2024-09-05","2024-09-10"),
		(7,1,"2024-08-22","2024-08-24"),
		(7,0,"2024-09-12","2024-09-16"),
		(8,0,"2024-07-29","2024-08-02"),
		(8,1,"2024-09-20","2024-09-24"),
		(9,0,"2024-08-07","2024-08-12"),
		(9,0,"2024-09-10","2024-09-14"),
		(10,0,"2024-08-28","2024-09-01"),
		(10,0,"2024-09-01","2024-09-06");


INSERT INTO host_reviews_guest (host_id, guest_id, review, created_on)
    VALUES
        (1, 15, "Great guest! Left the place spotless and was super respectful.", '2024-08-10 19:06:47'),
        (6, 12, "Awesome experience hosting them. Very polite and easy to communicate with.", '2024-12-16 11:08:01'),
        (18, 6, "Guest was okay, but left some trash behind and didn’t follow house rules.", '2013-05-01 12:35:13'),
        (5, 5, "Highly recommended! They treated the home as if it were their own.", '2021-02-27 17:04:47'),
        (5, 5, "Super friendly and left the house in great condition. Would host again!", '2018-10-23 05:27:07'),
        (18, 4, "This guest didn’t respect check-out times and was quite messy.", '2025-04-21 10:52:51'),
        (5, 1, "Fantastic guest! Very communicative and took care of the space.", '2019-11-22 03:23:06'),
        (13, 8, "They were a pleasure to host! Followed all the rules and were very courteous.", '2023-06-27 09:05:04'),
        (19, 14, "Great experience hosting! They were very respectful and tidy.", '2015-09-03 19:06:35'),
        (7, 10, "Superb guest! Easy to deal with and left the place clean.", '2016-06-14 20:08:32'),
        (7, 15, "Very friendly and left everything neat. Would definitely host again!", '2023-08-05 16:55:52'),
        (13, 10, "Guest was decent but could improve on cleanliness next time.", '2020-07-20 22:34:25'),
        (2, 2, "Great guest, very tidy and communicated well throughout the stay.", '2011-06-30 19:12:42'),
        (2, 13, "Very respectful and easy to host. Left the house in perfect condition.", '2018-02-27 01:23:39'),
        (3, 5, "Wonderful guest! Kept the house clean and was very pleasant to communicate with.", '2010-12-29 02:14:28'),
        (13, 8, "Super easy to host and left the place in great shape.", '2019-05-30 05:36:19'),
        (16, 19, "Very polite and followed all the house rules. Would host again!", '2010-12-18 11:30:13'),
        (11, 18, "Fantastic guest! No issues at all, and left the place tidy.", '2011-06-01 17:54:33'),
        (17, 4, "Had a great experience hosting. Everything was left clean and tidy.", '2016-12-14 00:04:04'),
        (1, 11, "Great communication and left the house in perfect condition. A pleasure to host!", '2016-11-24 09:09:43');

INSERT INTO invoice (invoice_id,rent_fee,service_fee,cleaning_fee,status)
    VALUES
        (1,268.00,26.80,16.08,"confirmed"),
        (2,123.00,12.30,7.38,"confirmed"),
        (3,380.00,38.00,22.80,"confirmed"),
        (4,588.00,58.80,35.28,"confirmed"),
        (5,780.00,78.00,46.80,"confirmed"),
        (6,1150.00,115.00,69.00,"confirmed"),
        (7,230.00,23.00,13.80,"canceled"),
        (8,332.00,33.20,19.92,"confirmed"),
        (9,1400.00,140.00,84.00,"confirmed"),
        (10,570.00,57.00,34.20,"confirmed"),
        (11,164.00,16.40,9.84,"canceled"),
        (12,780.00,78.00,46.80,"confirmed"),
        (13,920.00,92.00,55.20,"confirmed"),
        (14,332.00,33.20,19.92,"canceled"),
        (15,1120.00,112.00,67.20,"confirmed"),
        (16,456.00,45.60,27.36,"confirmed"),
        (17,588.00,58.80,35.28,"canceled"),
        (18,285.00,28.50,17.10,"confirmed"),
        (19,460.00,46.00,27.60,"pending"),
        (20,268.00,26.80,16.08,"confirmed");

INSERT INTO booking (guest_id, property_id, booking_status_id, invoice_id, rating_id, host_reviews_guest_id, number_of_children, number_of_adults, number_of_seniors, from_date, to_date, created_on, last_updated)
    VALUES
        (12, 1, 7, 1, 1, 1, 2, 2, 0, '2024-08-01', '2024-08-05', '2024-07-10 10:30:00', '2024-08-05 09:45:00'),
        (5, 3, 1, 2, NULL, NULL, 0, 2, 0, '2024-09-15', '2024-09-18', '2024-08-20 11:50:00', NULL),
        (8, 5, 7, 3, 2, 2, 1, 3, 0, '2024-08-10', '2024-08-14', '2024-07-25 14:05:00', NULL),
        (14, 2, 6, 4, NULL, NULL, 1, 2, 1, '2024-08-03', '2024-08-07', '2024-06-15 09:10:00', '2024-08-07 10:00:00'),
        (7, 4, 7, 5, 3, 3, 0, 2, 0, '2024-07-20', '2024-07-25', '2024-07-01 12:45:00', '2024-07-25 11:55:00'),
        (19, 6, 1, 6, NULL, NULL, 2, 2, 0, '2024-09-05', '2024-09-10', '2024-08-01 15:00:00', NULL),
        (11, 7, 3, 7, NULL, NULL, 0, 1, 0, '2024-08-22', '2024-08-24', '2024-07-28 13:20:00', NULL),
        (13, 8, 1, 8, NULL, NULL, 1, 3, 0, '2024-07-29', '2024-08-02', '2024-06-18 08:40:00', NULL),
        (16, 9, 7, 9, 4, 4, 3, 2, 0, '2024-08-07', '2024-08-12', '2024-07-12 14:15:00', '2024-08-12 16:05:00'),
        (2, 10, 1, 10, NULL, NULL, 2, 2, 1, '2024-09-01', '2024-09-06', '2024-07-22 09:30:00', NULL),
        (10, 3, 5, 11, NULL, NULL, 0, 2, 0, '2024-09-12', '2024-09-16', '2024-08-05 07:55:00', NULL),
        (14, 4, 1, 12, NULL, NULL, 1, 1, 0, '2024-09-03', '2024-09-08', '2024-08-08 18:20:00', NULL),
        (18, 6, 7, 13, 5, 5, 2, 3, 0, '2024-08-18', '2024-08-22', '2024-07-29 21:30:00', NULL),
        (6, 8, 2, 14, NULL, NULL, 0, 2, 0, '2024-09-20', '2024-09-24', '2024-07-31 10:50:00', NULL),
        (15, 9, 1, 15, NULL, NULL, 3, 2, 1, '2024-09-10', '2024-09-14', '2024-07-20 11:40:00', NULL),
        (20, 10, 7, 16, 6, 6, 0, 4, 0, '2024-08-28', '2024-09-01', '2024-07-25 06:25:00', '2024-09-01 13:30:00'),
        (17, 2, 3, 17, NULL, NULL, 2, 1, 1, '2024-09-05', '2024-09-09', '2024-07-18 14:50:00', NULL),
        (8, 5, 1, 18, NULL, NULL, 1, 3, 0, '2024-09-15', '2024-09-18', '2024-08-20 16:30:00', NULL),
        (13, 7, 4, 19, NULL, NULL, 0, 2, 0, '2024-09-12', '2024-09-16', '2024-08-23 15:45:00', NULL),
        (12, 1, 6, 20, NULL, NULL, 2, 2, 0, '2024-09-18', '2024-09-22', '2024-08-29 17:10:00', NULL);