import mysql.connector
from db_config import connect_to_database

# Function to display the student menu
def student_menu(userid):
    connection = connect_to_database()
    cursor = connection.cursor()

    while True:
        print("\nStudent Menu:")
        print("1. View My Classes")
        print("2. Drop a Class")
        print("3. Exit")

        choice = input("Enter your choice: ")

        if choice == '1':
            # Call stored procedure to view classes
            try:
                cursor.callproc('GetStudentClasses', [userid])
                for result in cursor.stored_results():
                    classes = result.fetchall()
                    if not classes:
                        print("You are not enrolled in any classes.")
                    else:
                        print("\nYour Classes:")
                        for clss in classes:
                            print(f"Class ID: {clss[0]} | Name: {clss[1]} ({clss[2]})")
            except mysql.connector.Error as err:
                print(f"Error retrieving classes: {err}")
        elif choice == '2':
            # Call stored procedure to drop a class
            class_id = input("Enter the ID of the class you want to drop: ")
            try:
                cursor.callproc('DropClass', [userid, int(class_id)])
                connection.commit()
                print("Class dropped successfully.")
            except mysql.connector.Error as err:
                print(f"Error dropping class: {err}")
        elif choice == '3':
            print("Exiting student menu.")
            break

        else:
            print("Invalid choice. Please choose a valid option (1-3).")
    cursor.close()
    connection.close()

# Function to display the manager menu
def manager_menu():
    connection = connect_to_database()
    cursor = connection.cursor()

    while True:
        print("\nManager Menu:")
        print("1. View Student Schedule")
        print("2. View Class Roster")
        print("3. Add Student to Roster")
        print("4. Drop Student from Roster")
        print("5. Add New Student")
        print("6. Exit")
        choice = input("\nEnter your choice: ")

        try:
            if choice == '1':
                # Call stored procedure to view Student Schedule
                student_id = int(input("Enter Student ID: "))
                print()
                cursor.callproc('GetStudentSchedule', [student_id])

                for result in cursor.stored_results():
                    for clss in result.fetchall():
                        print(f"Class: {clss[0]}, Code: {clss[1]}")
            elif choice == '2':
                # Call stored procedure to view Class Roster
                roster_id = int(input("Enter Roster ID: "))
                print()
                cursor.callproc('GetClassRoster', [roster_id])

                for result in cursor.stored_results():
                    for student in result.fetchall():
                        print(f"Student: {student[0]} {student[1]}")
            elif choice == '3':
                user_id = int(input("Enter Student ID: "))
                roster_id = int(input("Enter Roster ID: "))

                cursor.callproc('AddStudentToRoster', [user_id, roster_id])
                connection.commit()
                print("Student added to roster successfully.")
            elif choice == '4':
                user_id = int(input("Enter Student ID: "))
                roster_id = int(input("Enter Roster ID: "))

                cursor.callproc('DropStudentFromRoster', [user_id, roster_id])
                connection.commit()
                print("Student dropped from roster successfully.")
            elif choice == '5':
                # Call stored procedure to add a new student
                uname = input("Enter New Student's Username: ")
                pword = input("Enter New Student's Password: ")
                fname = input("Enter New Student's First Name: ")
                lname = input("Enter New Student's Last Name: ")
                major_id = int(input("Enter New Student's Major ID: "))

                cursor.callproc('AddNewStudent', [uname, pword, fname, lname, major_id, 0])
                connection.commit()
                print("New student added successfully.")
            elif choice == '6':
                print("Exiting Manager Menu.")
                break
            else:
                print("Invalid choice. Please choose a valid option (1-6).")
        except mysql.connector.Error as err:
            print(f"Error: {err}")
    cursor.close()
    connection.close()
    
              
