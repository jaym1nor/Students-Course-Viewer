import mysql.connector 

# Establish a connection to the MySQL database
def connect_to_database():
    connection = mysql.connector.connect(
        host="localhost",
        user='root',
        password='AggiePride', # Replace with your actual password
        database="NCAT"
    )
    return connection