# Little Lemon CapStone Project

## data modeling
    using draw.io / mysql workbench (modeling tool)
    see the model folder

## implementing the model (DDL physical schema)
    using data grip / mysql workbench (forward engineer)
    see the sql folder

## data population
    a bunch of batch insert sql statements
    see the sql folder as well, anything related to sql code is there

## SQL Queries
    includes stored procedures and prepared statements regarding the:
    - requirements of the table booking system:
    1- checking whether or not a table is booked on a given booking slot
    2- adding a valid booking
    3- checking whether or not a booking can be moved to a different slot
    4- updates a booking slot on the condition of it being movable
    5- cancels a booking in case it's not too late to cancel

    - requirements of the sales report:
    views:
    1- orders view exluding insignificant orders
        insignificant orders are orders with a total item quantity amounting to 2 or less

    2- high sales view
        high sales are orders of more than 30$ in subtotal
        the view is ordered by that subtotal ascendingly
        all relevant entities are joined within this view, this includes the customer who placed the order, the order itself including its subtotal, 
        the order items regarding what items have been placed and by how many,
        and finally the menu item details along with the cuisine they belong to.

    3- high demand menu items view
        high demand menu items are those items contained in more than 2 orders
    
    procedures and prepared statements:
    1- max quantity ordered procedure

    2- customer orders details prepared statement
        takes in a customer id as a placeholder to get their corresponding placed orders

    3- cancelling an order procedure
        by deleting an order, and beside having the order record itself deleted, the following related records might be affected:
        1- the corresponding delivery record if any, is deleted
        2- if this order is the last of a booking, the booking is deleted (optional)
        3- the order items of this order are deleted (cascade)


## using python as a data client
    a targeted marketing campaign is based on getitng the information of high paying customers
    a query on getting the information of customers who has placed an order with a subtotal greater than 35$

## using tableau for data analysis and visualization
    worksheets:
    1- a line graph showing the profit trends over the past few years
        (group by the selected years timeframe and sum the profit of all sale records of that year)
    2- a vertical bar chart showing the total sales made by each customer
    3- a bubble chart showing the proportional differences in sales and profits made by each customer
    4- a vertical bar chart with 2 dimensions, the first of which is cuisine, the latter is chronological. this worksheet aims to analyze the most profitable cuisine over the past few years
    5- an interactive dashboard combining some of the previous worksheets

## database dump
    mysqldump -u user -p --routines --triggers --events --databases little_lemon_capstone > little_lemon_capstone_dump.sql

    schema only
    mysqldump -u user -p --no-data --routines --triggers --events --databases little_lemon_capstone > little_lemon_capstone_schema_dump.sql 

    the --databases means that you don't have to manually create a database, so this is what you will write to import the database:
    mysql -u user -p < little_lemon_capstone_dump.sql
    mysql -u user -p < little_lemon_capstone_schema_dump.sql (for scehma only dump)

    this will automatically create a database named little_lemon_capstone

## a commit to this repository is made each time a diagram or sql / python code is modified
    this note was for me actually to remember committing, though i still forgot to commit at some point