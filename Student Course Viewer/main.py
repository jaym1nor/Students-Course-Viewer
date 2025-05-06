import mysql.connector 
from mysql.connector import errorcode
from db_config import connect_to_database
from role_menus import student_menu, manager_menu
import sys

# Function to login the system and determine role
def login():
    max_attempts = 4
    attempt = 0

    while attempt < max_attempts:
        uname = input("\nEnter your username: ")
        pword = input("Enter your password: ")
        
        connection = connect_to_database()
        cursor = connection.cursor()

        # Call the stored procedure to check login credentials
        try:
            cursor.callproc('CheckLogin', [uname, pword])
            userid = None
            role = None

            for result in cursor.stored_results():
                row = result.fetchone()
                if row:
                    userid, role = row
            
            cursor.close()
            connection.close

            if role:
                print(f"\n Welcome, {uname}! Role: {role.upper()}")
                if role == 'Student':
                    student_menu(userid)
                elif role == 'Manager':
                    manager_menu()
                return
            else:
                attempt += 1
                if attempt < max_attempts:
                    print("Invalid username or password. Please try again.")
        
        except mysql.connector.Error as err:
            print(f"Error: {err}")
            attempt += 1

    # If max attempts reached, terminate
    print("You've reached the max amount of login attempts. Try again later.")
    sys.exit()

login()