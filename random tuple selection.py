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

#################################################################################################
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
cursor3 = conn.cursor()
cursor4 = conn.cursor()


cursor1.execute("SELECT natcuis_id FROM  national_cuisine") 
results1 = cursor1.fetchall()
random_national_cuisines_ids = random.sample(results1,10)


for random_national_cuisine_id in random_national_cuisines_ids:
    print( random_national_cuisine_id)
    print()


for national_cuisine_id in random_national_cuisines_ids:
    cursor2.execute("SELECT cook_id FROM cook_nat_cuis WHERE natcuis_id= %s",( national_cuisine_id[0],))
    results2 = cursor2.fetchall()
    cursor3.execute("SELECT recipe_id, recipe_name FROM recipe WHERE natcuis_id = %s",( national_cuisine_id[0],))
    results3 = cursor3.fetchall()

    # Εκτύπωση των αποτελεσμάτων
    print(f"Results for National Cuisine ID {national_cuisine_id}:")
    for result2 in results2:
        print("Cook ID:", result2[0])
    print()
    for result3 in results3:
        print("Recipe ID:", result3[0])
        print("Recipe Name:", result3[1])
    print()
#######################################################################################################
#INSERT episode_cook_recipe

    #Δεν ξερω αν το for πρεπει να είναι εδω η πιο αριστερα??????????   
    for result2, result3 in zip(results2, results3):
        #cook_id = result2[0] if len(result2) > 0 else 0
        #recipe_id = result3[0] if len(result3) > 0 else 0
        query = "INSERT INTO episode_cook_recipe(cook_id,episode_id, recipe_id) VALUES (%s, %s, %s)"
        cursor4.execute(query, (result2[0], 1 , result3[0]))

query = "INSERT INTO episode_cook_recipe(cook_id, episode_id, recipe_id) VALUES (%s, %s, %s)"
cursor4.execute(query, (5, 1 , 7))   

conn.commit()
     
cursor1.close()
cursor2.close()
cursor3.close()
cursor4.close()

###################################################################################################

conn.close()


###################################################################################################
#Παναγιώτης 

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




