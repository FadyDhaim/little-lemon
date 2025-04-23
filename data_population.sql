-- inserting 8 customers
insert into customer (customer_name, contact_number, email)
values ('Alice Wonderland', '+49 176 12345678', 'alice.wonderland@email.com'),
       ('Bob The Builder', '+49 152 87654321', 'bob.thebuilder@email.com'),
       ('Charlie Chaplin', '+49 163 11223344', 'charlie.chaplin@email.com'),
       ('Dorothy Gale', '+49 177 99887766', 'dorothy.gale@email.com'),
       ('Eve Harrington', '+49 151 22334455', 'eve.harrington@email.com'),
       ('Frankenstein Monster', '+49 178 33445566', 'frankenstein@email.com'),
       ('Greta Garbo', '+49 162 44556677', 'greta.garbo@email.com'),
       ('Hans Solo', '+49 155 55667788', 'hans.solo@email.com');

-- inserting 16 delivery addresses (2 for each customer)
insert into delivery_address (customer_id, postal_code, street)
values (1, '60311', 'Main Street 1'),
       (1, '60528', 'Elm Avenue 22'),
       (2, '60322', 'Oak Road 15'),
       (2, '60599', 'Pine Lane 7'),
       (3, '60439', 'Parkway 3'),
       (3, '60313', 'River Side 101'),
       (4, '60596', 'Hill Top 5'),
       (4, '60308', 'Valley View 8'),
       (5, '60488', 'Church Street 12'),
       (5, '60529', 'Market Square 4'),
       (6, '60385', 'Forest Trail 9'),
       (6, '60594', 'Lake Drive 16'),
       (7, '60325', 'Castle Road 2'),
       (7, '60591', 'Bridge Street 11'),
       (8, '60437', 'Garden Lane 6'),
       (8, '60598', 'Field Way 14');

-- inserting deliveries for the remote orders (one per customer)
insert into delivery (delivery_address_id, delivery_cost)
values (1, 5.99),
       (3, 7.50),
       (5, 4.50),
       (7, 6.25),
       (9, 5.50),
       (11, 8.00),
       (13, 4.99),
       (15, 7.00);

-- inserting staff members with different roles
insert into staff (employee_name, employee_role, salary, contact_number, email)
values ('Alfred Manager', 'Manager', 5000.00, '+49 171 11122233', 'alfred.manager@email.com'),
       ('Betty Assistant', 'Assistant Manager', 4000.00, '+49 152 44455566', 'betty.assistant@email.com'),
       ('Carl Chef', 'Chef', 6000.00, '+49 163 77788899', 'carl.chef@email.com'),
       ('Diana Assistant', 'Assistant Chef', 4500.00, '+49 177 99900011', 'diana.assistant@email.com'),
       ('Eric Headwaiter', 'Head Waiter', 3500.00, '+49 151 22233344', 'eric.headwaiter@email.com'),
       ('Fiona Receptionist', 'Receptionist', 3000.00, '+49 178 55566677', 'fiona.receptionist@email.com');

-- inserting 4 cuisines
insert into menu (cuisine)
values ('Mediterranean'),
       ('Mexican'),
       ('American'),
       ('Japanese');

-- inserting menu items for each cuisine
insert into menuitem (item_name, item_description, price, category, menu_id)
values
-- mediterranean (menu_id = 1)
('Hummus with Pita Bread', 'Creamy chickpea dip served with warm pita bread', 7.99, 'Starters', 1),
('Falafel', 'Deep-fried chickpea patties, served with tahini sauce', 8.50, 'Starters', 1),
('Greek Salad', 'Fresh tomatoes, cucumbers, onions, olives, and feta cheese with a vinaigrette', 9.50, 'Starters', 1),
('Moussaka', 'Layered eggplant, minced lamb, and béchamel sauce', 16.99, 'Main Course', 1),
('Souvlaki (Chicken)', 'Grilled chicken skewers marinated in herbs and lemon', 15.50, 'Main Course', 1),
('Baklava', 'Sweet pastry made of layers of filo dough filled with chopped nuts and sweetened with syrup', 6.50,
 'Desserts', 1),
('Greek Yogurt with Honey and Walnuts', 'Thick Greek yogurt drizzled with honey and sprinkled with walnuts', 5.99,
 'Desserts', 1),
('Greek White Wine (Glass)', 'Dry and refreshing white wine from Greece', 6.00, 'Drinks', 1),
('Ouzo', 'Traditional anise-flavored aperitif', 4.50, 'Drinks', 1),
-- mexican (menu_id = 2)
('Guacamole with Tortilla Chips',
 'Fresh avocado dip with lime, cilantro, and onions, served with crispy tortilla chips', 8.99, 'Starters', 2),
('Quesadillas (Cheese)', 'Folded tortillas filled with melted cheese', 7.50, 'Starters', 2),
('Chicken Enchiladas', 'Rolled tortillas filled with shredded chicken and topped with sauce and cheese', 14.99,
 'Main Course', 2),
('Beef Tacos (3)', 'Corn tortillas filled with seasoned ground beef, lettuce, and cheese', 12.50, 'Main Course', 2),
('Churros with Chocolate Sauce', 'Fried dough pastries dusted with cinnamon sugar, served with rich chocolate sauce',
 6.99, 'Desserts', 2),
('Flan', 'Creamy custard dessert with a caramel topping', 5.50, 'Desserts', 2),
('Mexican Lager', 'Light and refreshing beer from Mexico', 5.00, 'Drinks', 2),
('Margarita', 'Classic cocktail with tequila, lime juice, and orange liqueur', 8.00, 'Drinks', 2),
-- american (menu_id = 3)
('Classic Caesar Salad', 'Romaine lettuce, croutons, Parmesan cheese, and Caesar dressing', 9.50, 'Starters', 3),
('Buffalo Wings (6)', 'Crispy chicken wings tossed in spicy Buffalo sauce, served with blue cheese dip', 10.99,
 'Starters', 3),
('Classic Cheeseburger', 'Beef patty with melted cheese, lettuce, tomato, onion, and pickles on a bun', 13.50,
 'Main Course', 3),
('BBQ Ribs (Half Rack)', 'Slow-cooked pork ribs glazed with smoky BBQ sauce', 17.99, 'Main Course', 3),
('Apple Pie', 'Traditional double-crust apple pie served warm', 7.50, 'Desserts', 3),
('Chocolate Brownie Sundae', 'Warm chocolate brownie topped with vanilla ice cream, chocolate sauce, and whipped cream',
 8.99, 'Desserts', 3),
('Cola', 'Classic carbonated soft drink', 3.50, 'Drinks', 3),
('Iced Tea', 'Brewed black tea served chilled', 3.00, 'Drinks', 3),
-- japanese (menu_id = 4)
('Edamame', 'Steamed soybeans lightly salted', 6.50, 'Starters', 4),
('Gyoza (6)', 'Pan-fried Japanese dumplings filled with pork and vegetables', 8.00, 'Starters', 4),
('Salmon Nigiri (2 pieces)', 'Sushi rice topped with fresh salmon', 7.99, 'Main Course', 4),
('Chicken Teriyaki with Rice', 'Grilled chicken glazed with teriyaki sauce', 15.99, 'Main Course', 4),
('Matcha Ice Cream', 'Green tea flavored ice cream', 6.50, 'Desserts', 4),
('Mochi (2 pieces)', 'Sweet rice cakes with various fillings', 5.99, 'Desserts', 4),
('Green Tea', 'Traditional Japanese green tea', 4.00, 'Drinks', 4),
('Sake (Small)', 'Japanese rice wine', 7.00, 'Drinks', 4);

-- corrected bookings and orders
--  2 bookings per customer, 2 orders per booking, 1 delivery order per customer.
--  this means 16 bookings (8 customers * 2 bookings) and 40 orders (8 customers * (2 bookings * 2 orders + 1 delivery order)).


-- inserting bookings (2 per customer)
insert into booking (booking_slot, table_number, customer_id, employee_id, diners_count)
values
-- customer 1
('2025-05-01 18:00:00', 1, 1, null, 2), -- booking 1
('2025-05-01 20:00:00', 2, 1, 6, 4),    -- booking 2
-- customer 2
('2025-05-02 18:00:00', 3, 2, null, 3), -- booking 3
('2025-05-02 20:00:00', 4, 2, 1, 2),    -- booking 4
-- customer 3
('2025-05-03 18:00:00', 5, 3, null, 2), -- booking 5
('2025-05-03 20:00:00', 6, 3, 3, 4),    -- booking 6
-- customer 4
('2025-05-04 18:00:00', 7, 4, null, 1), -- booking 7
('2025-05-04 20:00:00', 8, 4, 4, 2),    -- booking 8
-- customer 5
('2025-05-05 18:00:00', 1, 5, null, 2), -- booking 9
('2025-05-05 20:00:00', 2, 5, 5, 3),    -- booking 10
-- customer 6
('2025-05-06 18:00:00', 3, 6, null, 4), -- booking 11
('2025-05-06 20:0:00', 4, 6, 2, 2),     -- booking 12
-- customer 7
('2025-05-07 18:00:00', 5, 7, null, 2), -- booking 13
('2025-05-07 20:00:00', 6, 7, 6, 1),    -- booking 14
-- customer 8
('2025-05-08 18:00:00', 7, 8, null, 3), -- booking 15
('2025-05-08 20:00:00', 8, 8, 1, 2);
-- booking 16

-- inserting orders (5 per customer: 2 bookings * 2 orders + 1 delivery)
insert into orders (customer_id, booking_id, delivery_id, subtotal)
values
-- customer 1
(1, 1, null, 25.00),  -- order 1, booking 1
(1, 1, null, 30.00),  -- order 2, booking 1
(1, 2, null, 18.00),  -- order 3, booking 2
(1, 2, null, 22.00),  -- order 4, booking 2
(1, null, 1, 15.00),  -- order 5, delivery
-- customer 2
(2, 3, null, 28.00),  -- order 6, booking 3
(2, 3, null, 33.00),  -- order 7, booking 3
(2, 4, null, 20.00),  -- order 8, booking 4
(2, 4, null, 24.00),  -- order 9, booking 4
(2, null, 2, 17.00),  -- order 10, delivery
-- customer 3
(3, 5, null, 31.00),  -- order 11, booking 5
(3, 5, null, 36.00),  -- order 12, booking 5
(3, 6, null, 23.00),  -- order 13, booking 6
(3, 6, null, 27.00),  -- order 14, booking 6
(3, null, 3, 19.00),  -- order 15, delivery
-- customer 4
(4, 7, null, 34.00),  -- order 16, booking 7
(4, 7, null, 39.00),  -- order 17, booking 7
(4, 8, null, 26.00),  -- order 18, booking 8
(4, 8, null, 30.00),  -- order 19, booking 8
(4, null, 4, 21.00),  -- order 20, delivery
-- customer 5
(5, 9, null, 27.00),  -- order 21, booking 9
(5, 9, null, 32.00),  -- order 22, booking 9
(5, 10, null, 19.00), -- order 23, booking 10
(5, 10, null, 23.00), -- order 24, booking 10
(5, null, 5, 16.00),  -- order 25, delivery
-- customer 6
(6, 11, null, 30.00), -- order 26, booking 11
(6, 11, null, 35.00), -- order 27, booking 11
(6, 12, null, 22.00), -- order 28, booking 12
(6, 12, null, 26.00), -- order 29, booking 12
(6, null, 6, 18.00),  -- order 30, delivery
-- customer 7
(7, 13, null, 33.00), -- order 31, booking 13
(7, 13, null, 38.00), -- order 32, booking 13
(7, 14, null, 25.00), -- order 33, booking 14
(7, 14, null, 29.00), -- order 34, booking 14
(7, null, 7, 20.00),  -- order 35, delivery
-- customer 8
(8, 15, null, 29.00), -- order 36, booking 15
(8, 15, null, 34.00), -- order 37, booking 15
(8, 16, null, 21.00), -- order 38, booking 16
(8, 16, null, 25.00), -- order 39, booking 16
(8, null, 8, 17.00);
-- order 40, delivery


-- inserting order items (example - you'd populate this based on the orders and menu items)
--  i've added a few examples, you'll need to expand this to cover a good portion of the 40 orders.
insert into order_item (order_id, menuitem_id, quantity, total_item_price)
values (1, 1, 2, 15.98),   -- order 1: hummus x 2
       (1, 4, 1, 16.99),   -- order 1: moussaka
       (2, 2, 1, 8.50),    -- order 2: falafel
       (2, 5, 2, 31.00),   -- order 2: souvlaki x 2
       (3, 12, 1, 14.99),  -- order 3: chicken enchiladas
       (3, 15, 2, 13.98),  -- order 3: churros x 2
       (4, 11, 2, 15.00),  -- order 4: quesadillas x 2
       (4, 14, 1, 12.50),  -- order 4: beef tacos
       (5, 21, 1, 13.50),  -- order 5: cheeseburger
       (6, 24, 1, 17.99),  -- order 6: bbq ribs
       (7, 25, 2, 15.00),  -- order 7: apple pie x 2
       (8, 28, 1, 3.50),   -- order 8: cola
       (9, 29, 2, 7.00),   -- order 9: iced tea x 2
       (10, 31, 1, 6.50),  -- order 10: edamame
       (11, 32, 2, 16.00), -- order 11: gyoza x 2
       (12, 33, 1, 7.99),  -- order 12: salmon nigiri
       (13, 32, 4, 16.00), -- order 13: chicken teriyaki
       (14, 33, 3, 21.00), -- order 14: matcha ice cream x 2
       (15, 1, 1, 7.99),   -- order 15: hummus with pita bread
       (16, 4, 1, 16.99),  -- order 16: moussaka
       (17, 2, 2, 17.00),  -- order 17: falafel
       (18, 7, 1, 5.99),   -- order 18: greek yogurt with honey and walnuts
       (19, 9, 1, 4.50),   -- order 19: ouzo
       (20, 11, 1, 8.99),  -- order 20: guacamole with tortilla chips
       (21, 14, 1, 12.50), -- order 21: beef tacos (3)
       (22, 16, 1, 5.50),  -- order 22: flan
       (23, 18, 2, 16.00), -- order 23: margarita
       (24, 21, 1, 13.50), -- order 24: classic cheeseburger
       (25, 24, 1, 17.99), -- order 25: bbq ribs (half rack)
       (26, 26, 1, 8.99),  -- order 26: chocolate brownie sundae
       (27, 29, 1, 3.00),  -- order 27: iced tea
       (28, 31, 2, 13.00), -- order 28: edamame
       (29, 33, 2, 14),    -- order 29: chicken teriyaki with rice
       (30, 1, 1, 7.99),   -- order 30: hummus with pita bread
       (31, 5, 1, 15.50),  -- order 31: souvlaki (chicken)
       (32, 12, 1, 14.99), -- order 32: chicken enchiladas
       (33, 15, 2, 13.98), -- order 33: churros with chocolate sauce
       (34, 17, 1, 5.00),  -- order 34: mexican lager
       (35, 21, 2, 27.00), -- order 35: classic cheeseburger
       (36, 24, 1, 17.99), -- order 36: bbq ribs (half rack)
       (37, 27, 1, 8.99),  -- order 37: chocolate brownie sundae
       (38, 30, 1, 7.00),  -- order 38: sake (small)
       (39, 33, 2, 15.98), -- order 39: salmon nigiri
       (40, 1, 1, 7.99); -- order 40: hummus
