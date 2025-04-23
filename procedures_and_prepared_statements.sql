create procedure if not exists get_max_quantity_ordered()
begin
    select max(quantity) as max_quantity_ordered
    from orders
             natural join order_item;
end;

call get_max_quantity_ordered();



prepare get_customer_orders_details
    from '
select order_id, sum(quantity), subtotal
from orders
    natural join order_item
where customer_id = ?
group by orders.order_id, subtotal
';

set @customer_id = 1;
execute get_customer_orders_details using @customer_id;

-- 1- deletes the specified order from the orders table
-- 2- if associated with a delivery, deletes the referenced (delivery_id) delivery record as well through an after-delete trigger
-- 3- otherwise associated with a booking, if this order was the last / only order of the corresponding booking, then delete the referenced (booking_id) booking record as well, through an after-delete trigger.
-- 4- all order items associated with the given order are deleted on cascade
create procedure if not exists cancel_order(in order_id int)
begin
    delete from orders where orders.order_id = order_id;
end;

call cancel_order(41);