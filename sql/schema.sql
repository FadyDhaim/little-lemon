# drop database if exists little_lemon_capstone;
# create database if not exists little_lemon_capstone;
# use little_lemon_capstone;

create table customer
(
    customer_id    int auto_increment primary key,
    customer_name  varchar(255) not null,
    contact_number varchar(20)  not null,
    email          varchar(100) not null
);

create table delivery_address
(
    delivery_address_id int auto_increment primary key,
    customer_id         int          not null,
    postal_code         varchar(20)  not null,
    street              varchar(255) not null,
    constraint delivery_address_belongs_to_customer foreign key (customer_id) references customer (customer_id)
);

create table delivery
(
    delivery_id         int auto_increment primary key,
    delivery_address_id int  not null,
    delivery_cost       real not null,
    constraint deliver_to foreign key (delivery_address_id) references delivery_address (delivery_address_id)
);

create table staff
(
    employee_id    int auto_increment primary key,
    employee_name  varchar(255) not null,
    employee_role  enum ('Manager', 'Assistant Manager', 'Chef', 'Assistant Chef', 'Head Waiter', 'Receptionist'),
    salary         real         not null,
    contact_number varchar(20)  not null,
    email          varchar(100) not null
);

create table booking
(
    booking_id   int auto_increment primary key,
    booking_slot datetime not null,
    table_number int      not null,
    customer_id  int      not null,
    employee_id  int      null,
    diners_count int      not null default 1,
    constraint booked_by foreign key (customer_id) references customer (customer_id),
    constraint assigned_to foreign key (employee_id) references staff (employee_id)
);

create table menu
(
    menu_id int auto_increment primary key,
    cuisine varchar(50) not null
);

create table menuitem
(
    menuitem_id      int auto_increment primary key,
    item_name        varchar(255) not null,
    item_description tinytext,
    price            real,
    category         enum ('Starters', 'Main Course', 'Drinks', 'Desserts'),
    menu_id          int          not null,
    constraint belongs_to_cuisine foreign key (menu_id) references menu (menu_id)
);

create table orders
(
    order_id    int auto_increment primary key,
    placed_at   datetime default current_timestamp,
    customer_id int  not null,
    delivery_id int  null,
    booking_id  int  null,
    subtotal    real not null,
    constraint placed_by foreign key (customer_id) references customer (customer_id),
    constraint optional_delivery foreign key (delivery_id) references delivery (delivery_id),
    constraint placed_during_booking foreign key (booking_id) references booking (booking_id)
);


create table order_item
(
    order_id         int  not null,
    menuitem_id      int  not null,
    quantity         int  not null,
    total_item_price real not null,
    primary key (order_id, menuitem_id),
    constraint belongs_to_order foreign key (order_id) references orders (order_id) on delete cascade on update cascade,
    constraint specifies_item foreign key (menuitem_id) references menuitem (menuitem_id) on delete cascade on update cascade
);


-- i commented these out because only after i'd already executed the ddl above did i add the inline on delete on update cascade statements to the order_item 2 foreign keys (order_id, menuitem_id)
-- explanation below is for you to know some internals, optional though

-- describe order_item;


-- the first index, which is on order_id as the records themselves are sorted by order_id first, is a non-clustered index
-- each order_id value points to an entire B tree namely the second index which is implicitly created on menuitem_id column, 
-- this latter index is clustered, what i mean by this is that the entire row cells are within each node keyed by the menuitem_id, this includes the total_item_price and quantity ordered of that item.
-- as a result, regarding querying performance, queries having either just the order id or both the order id and menu item id, are quite fast.
-- on the other hand, queries only involing the menu item id won't be efficient as we don't know which B tree of menu items we should traverse (we don't know the order id to which these ordered items belong)
-- show indexes from order_item;


-- dropping these foreign keys don't actually drop the corresponding indices, i've only had to drop the keys to add them back with on delete / update cascade 

-- alter table order_item drop foreign key belongs_to_order;
-- alter table order_item drop foreign key specifies_item;

--
-- alter table order_item
--     add constraint belongs_to_order
--         foreign key (order_id) references orders (order_id)
--             on delete cascade on update cascade,
--     add constraint specifies_item
--         foreign key (menuitem_id) references menuitem (menuitem_id)
--             on delete cascade on update cascade;