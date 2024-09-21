# IU International University of Applied Sciences

## Course: Build a Data Mart in SQL (DLBDSPBDM01)
The task for this project is to build a database for storing and processing information for a use case similar to Airbnb. The database should provide the ability to manage the booking of apartment and bedrooms together with information about the users.

### Objective
To understand how a database for an application should be setup, this includes the definition of requirements, creating an Entity Relationship Diagram and implementing the database in a RDBMS.

### Selected RDBMS
This project was implemented using:

1. MySQL
2. MySQL Workbench

## Entity Relationship Diagram
![Entity Relationship Diagram](./images/ERD.png)

## Data Dictionary
![Data Dictionary Page 1](./images/data_dict_1.png)
![Data Dictionary Page 2](./images/data_dict_2.png)
![Data Dictionary Page 3](./images/data_dict_3.png)
![Data Dictionary Page 4](./images/data_dict_4.png)
![Data Dictionary Page 5](./images/data_dict_5.png)
![Data Dictionary Page 6](./images/data_dict_6.png)
![Data Dictionary Page 7](./images/data_dict_7.png)

## Tables overview

1. __Address__: Stores the postal address of each of the properties.
2. __City__: A list of different city where the properties are located.
3. __Country__: A list of countries.
4. __Host__: Contains the list of hosts registered in the platform.
5. __Guest__: Contains the list of guests regustered in the platform.
6. __Message__: Contains the the messages exchanged between guests and hosts.
7. __Host reviews guest__:  This table stores the reviews that **guests** write about host after a stay at at specific property.
8. __Wishlist__: This table stores the wish lists that guest have created.
9. __Booking__: This is one of the two most important tables in this implementation. It shows all reservations that guest have made. When a new record is added, invoice_id, rating_id, host_reviews_guest_id and last_updated should be set to NULL. These information cannot exist until the booking status hast be defined.
10. __Booking status__: Contains the status a specific booing might have.
11. __Rating__: Ratings that guests have written about their stay at a cerain property. Ratings go from 1 to 5.
12. __Invoice__: Stores the information of the invoice generated for each booking.
13. __Property__: This is the other most important table of this database. It contains all the information about the properties that are available for rent on the platform.
14. __Cancellation policy__: This table stores the cancellation policies that must be observed when a guest wishes to cancel a booking.
15. __Property type__: This table contains the information about what kind of property is available in the platform.
16. __Property category__: This table contains the categories to which a property can belong. It is possible that a property belongs to more than one category.
17. __property has property category__: This table show to which categories does a property belong.
18. __Amenity type__: This table contains a list of the groups in which a property’s amenities can be classified.
19. __Property amenity__: This table stores a list of all possible amenities a particular property can have. Each property can have several amenities.
20. __Property has property amenity__: This table track the amenities each property in the platform has.
21. __Property availability__: This table tracks the dates in which a property is available or not.
22. __Property rule__: This table show a list of rules which guests must observe while staying at the properties. A property can have several rules.
23. __Property has property rule__: This table show the spefic rules each property has.
24. __Property picture__: A collection of the pictures available of each property.