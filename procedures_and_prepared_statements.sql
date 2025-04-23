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

drop procedure if exists is_table_booked;
create procedure if not exists is_table_booked(in on_date date, in table_number int, out is_booked boolean)
begin
    declare int_is_booked int;
    select count(booking_id)
    into int_is_booked
    from booking
    where booking_slot_date = on_date -- index-based filtering first
      and booking.table_number = table_number; -- then check if there's an existing booking with the same table as requested
    if int_is_booked = 0 then
        set is_booked = false;
    else
        set is_booked = true;
    end if;
end;

call is_table_booked('2025-05-02', 3, @is_table_3_booked);
call is_table_booked('2025-05-02', 4, @is_table_4_booked);
call is_table_booked('2025-05-05', 4, @is_table_5_booked);
select if(@is_table_3_booked, 'table 3 is already booked', 'table 3 is available');
select if(@is_table_4_booked, 'table 4 is already booked', 'table 4 is available');
select if(@is_table_5_booked, 'table 5 is already booked', 'table 5 is available');


drop procedure if exists add_valid_booking;
create procedure if not exists add_valid_booking(
    in by_customer_id int,
    in slot datetime,
    in table_no int,
    in number_of_diners int
)
begin
    start transaction;
    call is_table_booked(date(slot), table_no, @is_cooked);
    insert into booking(customer_id, booking_slot, table_number, diners_count)
    values (by_customer_id, slot, table_no, number_of_diners);
    if @is_cooked then
        rollback;
    else
        commit;
    end if;
end;

call add_valid_booking(1, '2025-05-08 20:00:00', 5, 1);

-- can move in either scenarios:
-- the new slot is on the same day
-- the new slot is on a day when it doesn't conflict with an existing booking (table is not booked on that new slot)
create procedure if not exists can_move_booking(in booking_identifier int, in to_slot datetime, out can_move bool)
begin
    declare old_slot_date date;
    declare table_no int;
    declare new_slot_date date default date(to_slot);
    select booking_slot_date, table_number
    into old_slot_date, table_no
    from booking
    where booking_id = booking_identifier;
    if old_slot_date = new_slot_date then
        set can_move = true;
    else
        call is_table_booked(new_slot_date, table_no, @is_booked);
        set can_move = not @is_booked;
    end if;
end;

create procedure if not exists update_booking_slot(in booking_identifier int, in to_slot datetime, out did_update bool)
begin
    call can_move_booking(booking_identifier, to_slot, @can_move);
    if @can_move then
        update booking
        set booking_slot = to_slot
        where booking_id = booking_identifier;
        set did_update = true;
    else
        set did_update = false;
    end if;
end;

-- deletes an existing booking record if it's not too late
create procedure if not exists cancel_booking(in booking_identifier int, out did_cancel bool)
begin
    declare existing_booking_slot datetime;
    select booking_slot
    into existing_booking_slot
    from booking
    where booking_id = booking_identifier;
    if existing_booking_slot is null then -- booking doesn't even exist
        set did_cancel = false;
    elseif now() >= existing_booking_slot then -- too late to cancel
        set did_cancel = false;
    else
        delete
        from booking
        where booking_id = booking_identifier;
        set did_cancel = true;
    end if;
end;