import mysql.connector
import random

# Connect to your MySQL database
conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="",
    database="project84_DB_2024"
)

cursor1 = conn.cursor() #Επιλογη Εθνικης Κουζίνας
cursor2 = conn.cursor() #Επιλογη Μάγειρα


cursor1.execute("SELECT natcuis_id FROM  national_cuisine") 
results1 = cursor1.fetchall()
random_national_cuisines_ids = random.sample(results1,10)

for national_cuisine_id in random_national_cuisines_ids:
    cursor2.execute("SELECT c.cook_id , c.first_name FROM cook c JOIN cook_nat_cuis cnc ON c.cook_id = cnc.cook_id WHERE cnc.natcuis_id= %s",( national_cuisine_id[0],))
    results2 = cursor2.fetchall()

    #Πρώτη ιδέα 
    for i in results2:
        print("CookID and Cook Name, thats in a random National Cuisine:", results2)
        print()

    #Δευτερη Ιδεα
    # Εάν υπάρχουν αποτελέσματα στο results2
    if results2:
        # Επιλέξτε ένα τυχαίο tuple από τα αποτελέσματα
        random_result = random.choice(results2)
        print("Random Cook ID and Cook Name, that's in a random National Cuisine:", random_result)
        print()








conn.close()