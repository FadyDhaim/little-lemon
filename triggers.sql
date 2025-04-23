create trigger if not exists after_delete_order_delivery_cleanup
    after delete
    on orders
    for each row
begin
    if old.delivery_id is not null then
        delete from delivery where delivery_id = old.delivery_id;
    end if;
end;


-- i believe this trigger is kinda not necessary, you might wanna delete orders of a booking and keep the booking itself
create trigger if not exists after_delete_order_optional_booking_cleanup
    after delete
    on orders
    for each row
begin
    declare order_count int;
    if old.booking_id is not null then
        select count(order_id) into order_count
        from orders
        where booking_id = old.booking_id;
        if order_count = 0 then
            delete from booking where booking_id = old.booking_id;
        end if;
    end if;
end;