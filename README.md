# Data_Base_NTUA

**ΒΑΣΕΙΣ ΔΕΔΟΜΕΝΩΝ**

**ΑΝΑΦΟΡΑ**


*Κοντοθανάση Σωτηρία*

*Σκάγκου Ευγενία*

*Ρουσσέας Παναγιώτης*

# ER Μοντέλο


**

# Σχεσιακό διάγραμμα της ΒΔ

# Εγκατάστασή Εφαρμογής – Ως Root

**Βήμα 1 :**

Κατέβασε ένα δεν έχεις κάποιο RDBMS , εμείς συστήνουμε τον XAMPP

**Βήμα 2 :**

Πήγαινε στο link στο github :

[**https://github.com/Silia030303/Data_Base_NTUA**](https://github.com/Silia030303/Data_Base_NTUA)

**Βήμα 3 :**

Τρέξε στο terminal σου τον κώδικα του φακέλου : **masterchef.sql**

**Βήμα 4:**

Τρέξε στο terminal σου τον κώδικα του φακέλου : **Triggers.sql**

**Βήμα 5 : Εισαγωγή Δεδομένων στην Βάση**

Τρέξε στο terminal σου τον κώδικα του φακέλου : **dml.sql**

**Βήμα 6 :**

Τρέξε στο terminal σου τον κώδικα του φακέλου : **Indexes.sql**

# Ως User

Αφού έχουμε φτιάξει την Βάση Δεδομένων θέλουμε να συνδεθούμε στην ως απλοί χρήστες και όχι ως διαχειριστές .

Γράφουμε στον terminal μας τις εξης εντολές :

1. **cd C:\\xampp\\mysql\\bin**
2. **mysql -u (το username που σας έχει δοθεί ) -p ( ο κωδικός που σας έχει δοθεί )**

Τώρα έχουμε συνδεθεί στο RDBMS ως Users:

Έπειτα για να συνδεθούμε στην Βάση πληκτρολογούμε : **USE project84_DB_2024;**

# Λίγα Λογία για τον κώδικα :

Ο κώδικας στο αρχείο **mastercef.sql** δημιουργεί μια βάση δεδομένων **project84_DB_2024** με αρκετούς πίνακες, σχέσεις και προβολές (views) που σχετίζονται με μια εφαρμογή που διαχειρίζεται συνταγές, μάγειρες, αξιολογήσεις, εξοπλισμό και άλλα στοιχεία μαγειρικής. Ακολουθεί μια περιγραφή των κύριων στοιχείων του κώδικα:

**1. Δημιουργία της βάσης δεδομένων**

*DROP DATABASE IF EXISTS project84_DB_2024;*

*CREATE database project84_DB_2024;*

*USE project84_DB_2024;*

Αρχικά, η βάση δεδομένων **project84_DB_2024** διαγράφεται εάν υπάρχει, και στη συνέχεια δημιουργείται εκ νέου και επιλέγεται για χρήση.

**2. Δημιουργία πινάκων**

- **Πίνακες βασικών δεδομένων**
  - **equipment:** Αποθηκεύει πληροφορίες για τον εξοπλισμό που χρησιμοποιείται στις συνταγές.
  - **foodgroups**: Περιέχει τις κατηγορίες τροφίμων.
  - **national_cuisine**: Αποθηκεύει πληροφορίες για τις εθνικές κουζίνες.
  - **meal_type**: Κατηγοριοποιεί τις συνταγές με βάση τον τύπο γεύματος (π.χ., πρωινό, μεσημεριανό).
  - **ingredient**: Περιέχει τα συστατικά των συνταγών, με αναφορές στις κατηγορίες τροφίμων (foodgroups).
  - **recipe**: Περιέχει τις συνταγές, συμπεριλαμβανομένων λεπτομερειών όπως η κατηγορία, η κουζίνα, τα κύρια συστατικά, οι χρόνοι προετοιμασίας και μαγειρέματος, και οι διατροφικές πληροφορίες.
  - **tags:** Περιέχει ετικέτες για τις συνταγές.
  - **episode**: Αποθηκεύει τα επεισόδια ενός μαγειρικού διαγωνισμού.
  - **cook:** Περιέχει πληροφορίες για τους μάγειρες.
  - **judge**: Αποθηκεύει τους κριτές, οι οποίοι είναι επίσης μάγειρες, και τα επεισόδια στα οποία συμμετέχουν ως κριτές.
  - **recipe_step:** Περιέχει τα βήματα των συνταγών.
  - **thematic_section**: Περιέχει θεματικές ενότητες στις οποίες μπορεί να ανήκουν οι συνταγές.
- **Πίνακες σχέσεων**
  - **recipe_equipment:** Συνδέει συνταγές με τον εξοπλισμό που χρησιμοποιείται.
  - **ingredient_VS_recipe:** Συνδέει συνταγές με τα συστατικά τους, μαζί με τις ποσότητες και τις θερμίδες.
  - **recipe_tag:** Συνδέει συνταγές με ετικέτες.
  - **recipe_meal_type:** Συνδέει συνταγές με τύπους γεύματος.
  - **episode_cook_recipe:** Συνδέει μάγειρες, επεισόδια και συνταγές.
  - **cook_natcuis:** Συνδέει μάγειρες με εθνικές κουζίνες.
  - **recipe_thematic_section:** Συνδέει συνταγές με θεματικές ενότητες.
- **Πίνακας αξιολογήσεων**
  - **evaluation: Αποθηκεύει τις αξιολογήσεις που δίνουν οι κριτές στις συνταγές των μαγείρων.**

**3. Δημιουργία προβολών (Views)**

- **recipe_nutritional_info_vw :** Αυτή η προβολή παρέχει πληροφορίες για τις θερμίδες ανά μερίδα των συνταγών.
- **winner_vw :** Αυτή η προβολή υπολογίζει τον νικητή κάθε επεισοδίου βασιζόμενη στη βαθμολογία των μαγείρων.

Ο κώδικας στο αρχείο **Triggers.sql** περιλαμβάνει τη δημιουργία triggers (ενεργοποιητών) στη βάση δεδομένων **project84_DB_2024**. Αυτοί οι triggers εκτελούν συγκεκριμένες ενέργειες πριν την εισαγωγή ή την ενημέρωση δεδομένων σε ορισμένους πίνακες, ώστε να εξασφαλιστεί η ακεραιότητα των δεδομένων και να εφαρμοστούν επιχειρηματικοί κανόνες. Ακολουθεί μια περιγραφή των triggers που δημιουργήθηκαν:

**1. Triggers για τον πίνακα : ingredient_vs_recipe**
   
- **check_unit_of_measurement_insert:** Αυτός ο trigger ελέγχει αν η τιμή της στήλης unit_of_measurement είναι μία από τις επιτρεπόμενες τιμές πριν την εισαγωγή δεδομένων στον πίνακα ingredient_vs_recipe. Εάν δεν είναι, απορρίπτει την εισαγωγή και εμφανίζει μήνυμα σφάλματος.

- **check_unit_of_measurement_update:** Παρόμοιος με τον προηγούμενο, αυτός ο trigger ελέγχει τις επιτρεπόμενες τιμές της unit_of_measurement πριν την ενημέρωση δεδομένων στον πίνακα ingredient_vs_recipe.

**2. Triggers για τον πίνακα : foodgroups**

  - **check_foodgroups_update:** Αυτός ο trigger ελέγχει αν το foodgroups_name είναι μία από τις καθορισμένες επιτρεπόμενες τιμές πριν την εισαγωγή δεδομένων στον πίνακα foodgroups.

**3. Triggers για τον πίνακα: ingredient:**

- **check_foodgroups_update_in_ingridient:** Αυτός ο trigger ελέγχει αν το foodgroups_id είναι ένα από τα καθορισμένα επιτρεπόμενα IDs πριν την εισαγωγή δεδομένων στον πίνακα ingredient.

**4. Triggers για τον πίνακα: episode_cook_recipe**

  - **before_episode_cook_recipe_insert** Αυτός ο trigger ελέγχει αν ο αριθμός των συνταγών και μαγείρων ανά επεισόδιο δεν υπερβαίνει τις 10 πριν την εισαγωγή στον πίνακα episode_cook_recipe.

- **before_episode_cook_insert** Αυτός ο trigger ελέγχει αν ένας μάγειρας δεν συμμετέχει σε τρία συνεχόμενα επεισόδια πριν την εισαγωγή στον πίνακα episode_cook_recipe**.**

**5. Triggers για τον πίνακα recipe_step**

  - **check_sequential_steps:** Αυτός ο trigger ελέγχει αν κάθε βήμα μιας συνταγής έχει το αμέσως προηγούμενο βήμα πριν την εισαγωγή του στον πίνακα recipe_step**.**

  - **check_step_serial_number:** Αυτός ο trigger ελέγχει αν υπάρχει ήδη βήμα με τον ίδιο σειριακό αριθμό για μια συγκεκριμένη συνταγή πριν την εισαγωγή του στον πίνακα recipe_step.


