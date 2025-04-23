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

# describe order_item;
# show indexes from order_item;

# alter table order_item drop foreign key belongs_to_order;
# alter table order_item drop foreign key specifies_item;
#
# alter table order_item
#     add constraint belongs_to_order
#         foreign key (order_id) references orders (order_id)
#             on delete cascade on update cascade,
#     add constraint specifies_item
#         foreign key (menuitem_id) references menuitem (menuitem_id)
#             on delete cascade on update cascade;