# NCAT Role-Based Class Roster Application

This is currently a terminal-based class management system built using **Python** and **MySQL**. It supports **role-based access** for **Managers** and **Students**, allowing them to interact with class rosters through a secure login system.
Future Addition: **WEB Application Interface**
---

## 📁 Project Structure

```
.
├── create_tables.sql         # SQL script to create the database schema
├── insert_data.sql           # Sample data to populate the database
├── stored_procedures.sql     # All required stored procedures
├── db_config.py              # Database connection setup
├── main.py                   # Entry point with login and role routing
├── role_menus.py             # Menu logic for Manager and Student roles
└── README.md                 # Project documentation
```

---

## 🚀 Features

### 🔒 Login System
- Validates username and password.
- Displays a personalized welcome message with username and role.

### 👨‍🎓 Student Role
- View enrolled classes.
- Drop a class from the current schedule.

### 🧑‍💼 Manager Role
- View a student's class schedule.
- View a class roster.
- Add a student to a class.
- Drop a student from a class.
- Add a new student to the system.

---

## 🛠️ Setup Instructions

### 1. Install Dependencies
Ensure Python and MySQL are installed. Then install the Python MySQL connector:

```bash
pip install mysql-connector-python
```

### 2. Configure MySQL Database
- Open your MySQL client and execute the SQL files in this order:
  1. `create_tables.sql`
  2. `insert_data.sql`
  3. `stored_procedures.sql`

### 3. Update `db_config.py` (if needed)

```python
connection = mysql.connector.connect(
    host="localhost",
    user="root",         
    password="AggiePride",     # <-- Update your password
    database="NCAT"
)
```

### 4. Run the Application

```bash
python main.py
```

---

## 🧪 Sample Credentials

### Manager:
- **Username:** Manager1
- **Password:** AggiePride1

### Student:
- **Username:** Student1
- **Password:** AggiePride2

---

## 📌 Notes
- All interactions are done through the terminal.
- Ensure the MySQL server is running before launching the app.
- New stored procedures added in the `manager_menu` must exist in the database to avoid runtime errors.

---

## 📃 License

This project is provided for educational purposes only and does not carry an open-source license.

---
