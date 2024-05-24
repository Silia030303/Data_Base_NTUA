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

###################################################################################################
#Επιλογη Μάγειρα

# Δημιουργία ενός cursor αντικειμένου
#Ένα cursor αντικείμενο δημιουργείται για να εκτελεί SQL εντολές:
cursor = conn.cursor()

# Execute your SQL query
cursor.execute("SELECT * FROM cook")

# Ανάκτηση όλων των σειρών δεδομένων 
results = cursor.fetchall()

# Choose a random tuple from the fetched results

random_cooks = random.sample(results,10)

for random_cook in random_cooks:
    print("Random Tuple:", random_cook)
    print()


# Ένας απλός βρόχος for χρησιμοποιείται για να εμφανίσει τα δεδομένα:
#for random_cook in random_cooks:
    #print("Random Cooks:", random_cooks)

# Do something with the random tuple
#print("Random Tuple:", random_cooks)


# Close 
cursor.close()

###################################################################################################
#Επιλογη Εθνικης Κουζίνας

cursor1 = conn.cursor()
cursor2 = conn.cursor()


cursor1.execute("SELECT natcuis_id FROM  national_cuisine") 
results1 = cursor1.fetchall()
random_national_cuisines_ids = random.sample(results1,10)


for random_national_cuisine_id in random_national_cuisines_ids:
    print( random_national_cuisine_id)
    print()


for national_cuisine_id in random_national_cuisines_ids:
    cursor2.execute("SELECT cook_id FROM cook_nat_cuis WHERE natcuis_id= %s",( national_cuisine_id[0],))
    results = cursor2.fetchall()
    # Εκτύπωση των αποτελεσμάτων
    print(f"Results for National Cuisine ID {national_cuisine_id}:")
    for result in results:
        print("Cook ID:", result[0])
    print()
    
cursor1.close()
cursor2.close()

###################################################################################################

conn.close()


###################################################################################################
#insert the data to a table cooks
conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="",
    database="project84_DB_2024"
)

# Επανάνοιγμα του cursor
cursor = conn.cursor()
# Reopen cursor
#cursor = conn.cursor()

# Insert fetched data into the second table
for row in results:
    # Assuming your second table has columns named col1, col2, col3
    cursor.execute("INSERT INTO second_table (col1, col2, col3) VALUES (%s, %s, %s)", row)

# Commit the changes to the database
conn.commit()

# Close the cursor and database connection
cursor.close()
conn.close()




