# good luck ;)

import concurrent.futures as concurrency
import mysql.connector as connector
import mysql.connector.pooling as pooling
import mysql.connector.errors as connector_errors
import mysql.connector.errorcode as connector_error_codes

db_env_config = {
    'host': 'localhost',
    'port': 3306,
    'user': 'root',
    'password': 'root12345',
}
db_name = 'little_lemon_db'

receptionist_employee_id = 6

initialization_success: bool
try:
    initial_connection = connector.connect(**db_env_config)
    initial_cursor = initial_connection.cursor()
    initial_cursor.execute(f'create database if not exists {db_name}')
    initial_cursor.execute(f'use {db_name}')
    create_menuitem_table = ''' 
        create table if not exists MenuItems (
        ItemID INT AUTO_INCREMENT,
        Name VARCHAR(200),
        Type VARCHAR(100),
        Price INT,
        PRIMARY KEY (ItemID)
        );
        '''
    create_menu_table = '''create table if not exists Menus (
        MenuID INT,
        ItemID INT,
        Cuisine VARCHAR(100),
        PRIMARY KEY (MenuID,ItemID)
        );
        '''
    create_booking_table = '''create table if not exists Bookings (
        BookingID INT AUTO_INCREMENT,
        TableNo INT,
        GuestFirstName VARCHAR(100) NOT NULL,
        GuestLastName VARCHAR(100) NOT NULL,
        BookingSlot TIME NOT NULL,
        EmployeeID INT,
        PRIMARY KEY (BookingID)
        );
        '''
    create_orders_table = '''create table if not exists Orders (
        OrderID INT,
        TableNo INT,
        MenuID INT,
        BookingID INT,
        BillAmount INT,
        Quantity INT,
        PRIMARY KEY (OrderID,TableNo)
    );
    '''
    create_employees_table = '''create table if not exists Employees (
        EmployeeID INT AUTO_INCREMENT PRIMARY KEY,
        Name VARCHAR (255),
        Role VARCHAR (100),
        Address VARCHAR (255),
        Contact_Number INT,
        Email VARCHAR (255),
        Annual_Salary VARCHAR (100)
    );
    '''
    db_structure = [
        create_menuitem_table,
        create_menu_table,
        create_booking_table,
        create_orders_table,
        create_employees_table,
    ]
    for table_creation in db_structure:
        initial_cursor.execute(table_creation)

    insert_menuitems = '''
    replace into MenuItems (ItemID, Name, Type, Price)
    values
    (1, 'Olives','Starters',5),
    (2, 'Flatbread','Starters', 5),
    (3, 'Minestrone', 'Starters', 8),
    (4, 'Tomato bread','Starters', 8),
    (5, 'Falafel', 'Starters', 7),
    (6, 'Hummus', 'Starters', 5),
    (7, 'Greek salad', 'Main Courses', 15),
    (8, 'Bean soup', 'Main Courses', 12),
    (9, 'Pizza', 'Main Courses', 15),
    (10, 'Greek yoghurt','Desserts', 7),
    (11, 'Ice cream', 'Desserts', 6),
    (12, 'Cheesecake', 'Desserts', 4),
    (13, 'Athens White wine', 'Drinks', 25),
    (14, 'Corfu Red Wine', 'Drinks', 30),
    (15, 'Turkish Coffee', 'Drinks', 10),
    (16, 'Turkish Coffee', 'Drinks', 10),
    (17, 'Kabasa', 'Main Courses', 17);'''

    insert_menu = '''
    replace into Menus (MenuID,ItemID,Cuisine)
    values
    (1, 1, 'Greek'),
    (1, 7, 'Greek'),
    (1, 10, 'Greek'),
    (1, 13, 'Greek'),
    (2, 3, 'Italian'),
    (2, 9, 'Italian'),
    (2, 12, 'Italian'),
    (2, 15, 'Italian'),
    (3, 5, 'Turkish'),
    (3, 17, 'Turkish'),
    (3, 11, 'Turkish'),
    (3, 16, 'Turkish');'''

    insert_bookings = '''
    replace into Bookings (BookingID, TableNo, GuestFirstName, 
    GuestLastName, BookingSlot, EmployeeID)
    values
    (1, 12, 'Anna','Iversen','19:00:00',1),
    (2, 12, 'Joakim', 'Iversen', '19:00:00', 1),
    (3, 19, 'Vanessa', 'McCarthy', '15:00:00', 3),
    (4, 15, 'Marcos', 'Romero', '17:30:00', 4),
    (5, 5, 'Hiroki', 'Yamane', '18:30:00', 2),
    (6, 8, 'Diana', 'Pinto', '20:00:00', 5);'''

    insert_orders = '''
    replace into Orders (OrderID, TableNo, MenuID, BookingID, Quantity, BillAmount)
    values
    (1, 12, 1, 1, 2, 86),
    (2, 19, 2, 2, 1, 37),
    (3, 15, 2, 3, 1, 37),
    (4, 5, 3, 4, 1, 40),
    (5, 8, 1, 5, 1, 43);'''

    insert_employees = '''
    replace into employees (EmployeeID, Name, Role, Address, Contact_Number, Email, Annual_Salary)
    values
    (01,'Mario Gollini','Manager','724, Parsley Lane, Old Town, Chicago, IL',351258074,'Mario.g@littlelemon.com','$70,000'),
    (02,'Adrian Gollini','Assistant Manager','334, Dill Square, Lincoln Park, Chicago, IL',351474048,'Adrian.g@littlelemon.com','$65,000'),
    (03,'Giorgos Dioudis','Head Chef','879 Sage Street, West Loop, Chicago, IL',351970582,'Giorgos.d@littlelemon.com','$50,000'),
    (04,'Fatma Kaya','Assistant Chef','132  Bay Lane, Chicago, IL',351963569,'Fatma.k@littlelemon.com','$45,000'),
    (05,'Elena Salvai','Head Waiter','989 Thyme Square, EdgeWater, Chicago, IL',351074198,'Elena.s@littlelemon.com','$40,000'),
    (06,'John Millar','Receptionist','245 Dill Square, Lincoln Park, Chicago, IL',351584508,'John.m@littlelemon.com','$35,000');'''

    populate_db = [
        insert_menuitems,
        insert_menu,
        insert_orders,
        insert_bookings,
        insert_employees,
    ]
    for populate_table in populate_db:
        initial_cursor.execute(populate_table)

    initial_connection.commit()
    initial_cursor.close()
    initial_connection.close()
    initialization_success = True
except connector.Error as connector_error:
    error_code = connector_error.errno
    match (error_code):
        case connector_error_codes.ER_ACCESS_DENIED_ERROR:
            print('wrong username or password')
        case connector_error_codes.CR_CONN_HOST_ERROR:
            print('host machine not found')
        case connector_error_codes.CR_CONNECTION_ERROR:
            print('invalid port number')
        case _:
            print(connector_error)
    initialization_success = False


if not initialization_success:
    exit()

db_env_config['database'] = db_name

pool_env_config = {'pool_size': 2, 'pool_name': 'pool_b', 'pool_reset_session': True}

pool = pooling.MySQLConnectionPool(**db_env_config, **pool_env_config)

create_peak_hours_procedure = '''
    create procedure if not exists peak_hours()
    begin
        with booking_count_at_hour_cte as
                (
                    select hour(bookingslot) as booking_hour, count(bookingid) as booking_count_at_hour
                    from bookings
                    group by booking_hour
                    order by booking_count_at_hour desc
                )
        select booking_hour as peak_hours
        from booking_count_at_hour_table
        where booking_count_at_hour = (select max(booking_count_at_hour) from booking_count_at_hour_cte);
    end
'''
create_guest_status_procedure = '''
    create procedure if not exists guest_status()
    begin
        select 
            concat(guestfirstname, ' ', guestlastname) as guest_name,
            case
                when role is null then 'in queue'
                when role = 'Assistant Chef' then 'preparing order'
                when role = 'Head Chef' then 'ready to serve'
                when role = 'Head Waiter' then 'order served'
                when role in ('Manager', 'Assistant Manager') then 'ready to pay'
            end as order_status
        from bookings
        left join employees
        on bookings.employeeid = employees.employeeid;
    end
'''
procedures = [
    {'name': 'peak_hours', 'ddl': create_peak_hours_procedure},
    {'name': 'guest_status', 'ddl': create_guest_status_procedure},
]


def process_procedure(procedure_index: int):
    procedure = procedures[procedure_index]
    connection = pool.get_connection()
    cursor = connection.cursor()
    cursor.execute(procedure['ddl'])
    cursor.callproc(procedure['name'])
    results = list(cursor.stored_results())
    assert len(results) == 1
    result_set = results[0]
    columns = result_set.column_names
    rows = result_set.fetchall()
    cursor.close()
    connection.close()
    return {'columns': columns, 'rows': rows}


def book(booking: tuple[int, str, str, str, int]):
    connection: pooling.PooledMySQLConnection
    try:
        connection = pool.get_connection()
    except connector_errors.PoolError as exhausted_pool:  # noqa: F841
        pool.add_connection()
        connection = pool.get_connection()
    cursor = connection.cursor()
    cursor.execute(
        '''
            replace into bookings(bookingid, tableno, guestfirstname, guestlastname, bookingslot, employeeid)
            values (%s, %s, %s, %s, %s, %s)
        ''',
        booking,
    )
    connection.commit()
    cursor.close()
    try:
        connection.close()
    except connector_errors.PoolError as full_pool:  # noqa: F841
        del connection


def report_task_3():
    get_little_lemon_manager = '''
        select employeeid, name
        from employees
        where role = 'Manager';
    '''
    get_employees_with_the_highest_salary = '''
        with max_salary_cte as (
                select max(annual_salary) as max_salary
                from employees
            )
        select name, role
        from employees
        where annual_salary = (select max_salary from max_salary_cte);
    '''
    get_number_of_guests_between_18_and_20 = '''
        select 
            count(bookingid) as guest_count_between_6pm_8pm
        from 
            bookings
        where 
            bookingslot between '18:00' and '20:00';
    '''
    get_guests_waiting_to_be_seated_with_receptionist = '''
        select 
            bookingid, 
            concat(guestfirstname, ' ', guestlastname) as full_name
        from bookings
        natural join employees
        where employees.role = 'Receptionist'
        order by bookingslot asc;
    '''
    connection = pool.get_connection()
    queries = [
        get_little_lemon_manager,
        get_employees_with_the_highest_salary,
        get_number_of_guests_between_18_and_20,
        get_guests_waiting_to_be_seated_with_receptionist,
    ]
    with connection.cursor() as cursor:
        columns_per_set: list[tuple] = []
        rows_per_set: list[list[tuple]] = []
        for query in queries:
            cursor.execute(query)
            columns_per_set.append(cursor.column_names)
            rows = []
            for row in cursor.fetchall():
                rows.append(row)
            rows_per_set.append(rows)
    connection.close()
    return {
        'queries': [
            'get_little_lemon_manager',
            'get_employees_with_the_highest_salary',
            'get_number_of_guests_between_18_and_20',
            'get_guests_waiting_to_be_seated_with_receptionist',
        ],
        'columns_per_set': columns_per_set,
        'rows_per_set': rows_per_set,
    }


def basic_sales_report():
    connection = pool.get_connection()
    with connection.cursor() as cursor:
        cursor.execute(
            '''
            create procedure if not exists basic_sales_report()
                begin
                    select 
                       sum(billamount) as total_sales,
                       avg(billamount) as average_sale,
                       min(billamount) as minimum_bill_paid,
                       max(billamount) as maximum_bill_paid
                    from orders;
                end
        '''
        )
        cursor.callproc('basic_sales_report')
        result_set = next(cursor.stored_results())
        columns = result_set.column_names
        rows = result_set.fetchone()
    connection.close()
    return {'columns': columns, 'rows': rows}


def upcoming_3_bookings():
    connection = pool.get_connection()
    with connection.cursor(buffered=True) as cursor:
        cursor.execute(
            '''
                select 
                    bookingslot,
                    concat(guestfirstname, ' ', guestlastname) as guest_name,
                    concat('assigned to: ', employees.name) as employee_name
                from bookings
                natural join employees
                where timediff(bookingslot, current_time) >= 0
                order by timediff(bookingslot, current_time) asc
                limit 3;
            '''
        )
        columns = cursor.column_names
        rows = [row for row in cursor]
    connection.close()
    return {'columns': columns, 'rows': rows}


with concurrency.ThreadPoolExecutor(max_workers=pool.pool_size) as executor:
    procedures_result_sets = list(
        executor.map(process_procedure, range(len(procedures)))
    )

    for result_set in procedures_result_sets:
        print(result_set['columns'])
        for row in result_set['rows']:
            print(row)
        print('\n')

    executor.map(
        book,
        [
            (10, 8, 'Anees', 'Java', '18:00', receptionist_employee_id),
            (11, 5, 'Bald', 'Vin', '19:00', receptionist_employee_id),
            (12, 12, 'Jay', 'Kon', '19:30', receptionist_employee_id),
        ],
    )

results = report_task_3()
queries = results['queries']
columns_per_set = results['columns_per_set']
rows_per_set = results['rows_per_set']
for i in range(len(queries)):
    print(queries[i])
    print(columns_per_set[i])
    print(*rows_per_set[i], sep='\n')

print('basic sales report')
report = basic_sales_report()
print(report['columns'])
print(report['rows'])

print('upcoming three bookings')
result = upcoming_3_bookings()
print(result['columns'])
print(*result['rows'], sep='\n')