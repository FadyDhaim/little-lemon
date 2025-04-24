import mysql.connector as connector
import mysql.connector.errorcode as connector_error_codes

db_server = {
    'host': 'localhost',
    'port': 3306,
}
db_user_auth = {
    'user': 'root',
    'password': 'root12345',
}
db_name = 'little_lemon_capstone'

db_env = {**db_server, **db_user_auth, 'database': db_name}
try:
    connection = connector.connect(**db_env)
    cursor = connection.cursor()

    target_customers_for_promotional_campaign_query = '''
    select customer.customer_id, customer_name, max(subtotal) as max_order_value
    from customer
    natural join orders
    group by customer.customer_id, customer_name
    having max_order_value > 35;
    '''
    cursor.execute(target_customers_for_promotional_campaign_query)
    attributes = cursor.column_names
    print(attributes)
    targeted_customers_for_promotional_campaign = cursor.fetchall()
    print(*targeted_customers_for_promotional_campaign, sep='\n')
    cursor.close()
    connection.close()
    
except connector.Error as connection_error:
    error_code = connection_error.errno
    match (error_code):
        case connector_error_codes.ER_ACCESS_DENIED_ERROR:
            print("wrong username or password")
        case connector_error_codes.CR_CONN_HOST_ERROR:
            print("host machine not found")
        case connector_error_codes.CR_CONNECTION_ERROR:
            print("invalid port number")
        case _:
            print(connection_error)