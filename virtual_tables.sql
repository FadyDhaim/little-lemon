create or replace view orders_view as
select orders.order_id,
       sum(order_item.quantity)         as total_order_quantity,
       sum(order_item.total_item_price) as order_cost
from orders
         natural join order_item
group by orders.order_id
having total_order_quantity > 2;


select *
from orders_view;


create or replace view high_sales
as
select customer.customer_id,
       customer.customer_name,
       orders.order_id,
       orders.subtotal,
       order_item.menuitem_id,
       order_item.quantity,
       order_item.total_item_price,
       menuitem.item_name,
       menuitem.price,
       menu.cuisine
from customer
         natural join orders
         natural join order_item
         natural join menuitem
         natural join menu
where subtotal > 30 # short cicruit the join process upon joining against the order table, if the subtotal meets the criteria, continue joining the rest of the tables (order_item, menuitem, menu), otherwise skip to the next order of the same customer or to the next customer
order by subtotal;
# each full row (after joining all tables) is mapped against its order subtotal value, map<joined row, order.subtotal>
# we can further optimize the mapping based on the fact that the same order has multiple order items
# that is, multiple joined rows share the same order and thus the same subtotal value
# say an order has 3 order items where their sum of (quantity × item_id.price) meets the criteria (its subtotal exceeds 30)
# so we can have a pointer to these 3 pointers (3 full joined rows), call this pointer order_pointer
# map this order_pointer to its subtotal value, and based on which, we can sort in bulk (assume insertion sort as we traverse through the orders of the same customer, and then traversing through the rest of the customers)
# map<order-pointer, subtotal>

select *
from high_sales;


create or replace view high_demand_menu_items as
select menuitem.*, menu.cuisine
from menuitem
natural join menu
where menuitem.menuitem_id
          in (select order_item.menuitem_id
              from orders
                       natural join order_item
              group by order_item.menuitem_id
              having count(order_item.menuitem_id) > 2); # the menu items that exist in more than 2 orders, because in each order, the item is at max present once (the quantity field is what aggregates the item in the same order)
              # the max of the menu item occurrence (count) is equal to the orders count, in case of every order containing that item

select *
from high_demand_menu_items;