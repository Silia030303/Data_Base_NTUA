#random tuple selection

import mysql.connector
import random

# Connect to your MySQL database
conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="",
    database="project84_DB_2024"
)
cursor = conn.cursor()

# Execute your SQL query
cursor.execute("SELECT * FROM cook limit 10")

# Fetch all the results
results = cursor.fetchall()

# Choose a random tuple from the fetched results
random_tuple = random.choice(results)

# Do something with the random tuple
print("Random Tuple:", random_tuple)

# Close the database connection
conn.close()


#insert the data to a table

# Reopen cursor
cursor = conn.cursor()

# Insert fetched data into the second table
for row in results:
    # Assuming your second table has columns named col1, col2, col3
    cursor.execute("INSERT INTO second_table (col1, col2, col3) VALUES (%s, %s, %s)", row)

# Commit the changes to the database
conn.commit()

# Close the cursor and database connection
cursor.close()
conn.close()