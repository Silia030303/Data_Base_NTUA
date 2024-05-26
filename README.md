
# ΒΑΣΕΙΣ ΔΕΔΟΜΕΝΩΝ 2024 :  ΑΝΑΦΟΡΑ ΕΞΑΜΗΝΙΑΙΑΣ ΕΡΓΑΣΙΑΣ 
 



**ΦΟΙΤΗΤΕΣ:**

*Κοντοθανάση Σωτηρία*

*Σκάγκου Ευγενία*

*Ρουσσέας Παναγιώτης*

# ER Μοντέλο


![image](https://github.com/Silia030303/Data_Base_NTUA/assets/160490846/1a9d80f8-0ad3-4c40-8219-0e00d755ca88)

# Λίγα Λόγια για τον κώδικα :

Σημείωση: Στην βάση όλες οι σημαντικές οντότητες περιλαμβάνουν δύο attributes 

- image_url
- image_description
  
Αυτές δεν περιλαμβάνονται στο ER, γιατί θεωρήσαμε ότι θα απομάκρυναν από την σημαντική πληροφορία που έχει να δώσει και θα μεγάλωναν χωρίς λόγο τους πίνακες.
Ξεκινάμε από τον πίνακα recipes που είναι βασικός και περιέχει όλες τις μοναδικές για την συνταγή πληροφορίες όπως ο χρόνος προετοιμασίας ή οι μερίδες. Μερικά ενδιαφέροντα attributes είναι το total_time που είναι derived για αυτό εμφανίζεται με παρένθεση δίπλα και το classification (‘Κάθε συνταγή, χαρακτηρίζεται με βάση το βασικό υλικό της’) η οποία στην βάση θα εισάγεται αφού έχει μπει η συνταγή πέρνοντας υπόψιν το foodgroup στο οποίο ανήκει το primary ingredient. Επίσης ενδιαφέρον είναι και το tips , όπου επιλέξαμε να είναι attribute και όχι πίνακας καθώς υπήρχε το όριο των 3 tips. Από την άλλη τα tags που θα μπορούσαν να είναι άπειρα είναι πίνακας με πολλά προς πολλά σχέση με το recipes. Αντίστοιχοι είναι οι πίνακες για το equipment, meal_type (μορφές γεύματος), thematic_section(θεματικές ενότητες) και ingredient . Ταυτόχρονα υπάρχουν και σχέσεις πολλά προς ένα όπως η recipe_vs_national_cuisine καθώς κάθε συνταγή θα έχει μόνο μία εθνική κουζίνα και ένα κύριο συστατικό (primary ingredient).

Να σημειωθεί πως αυτές οι σχέσεις στο σχεσιακό μοντέλο εξαφανίζονται και προσθέτονται τα primary keys των ‘προς ένα’ πινάκων στα attributes των ‘προς πολλά’ πινάκων (πχ natcuis_id). Στο recipe έχουμε ακόμα ένα weak πίνακα τον recipe_steps ο οποίος δεν έχει λόγο ύπαρξης χωρίς τις συνταγές σε αντίθεση με τις εθνικές κουζίνες πχ που προσδιορίζουν και τους μάγειρες.

Οι μάγειρες τώρα έχουν μια πολλά προς πολλά σχέση με τις εθνικές κουζίνες καθώς μπορούν να είναι ειδικοί σε πολλές και συμμετέχουν σε τρεις ακόμα σχέσεις καθώς μπορούν 

- **Να συμμετέχουν σε κάποιο επεισόδιο ως διαγωνιζόμενος (episode_cook_recipe)**
- **Να συμμετέχουν σε κάποιο επεισόδιο ως κριτής (identity_of_judge)**
- **Να βαθμολογήσουν και να βαθμολογηθούν (evaluation)**
  
Τα επεισόδια έχουν και ημερομηνία και σχεζόν αλλά θεωρούμε ότι ένας χρόνος ταυτίζεται με μία σεζόν (πχ 2024 = σεζον 1). Παρατηρούμε επίσης ότι ένα επεισόδιο μπορεί να έχει πολλούς judges αλλά ένας judge μόνο ένα επεισόδιο καθώς ο judge έχει ως primary key (cook_id, episode_id). Επιλέον, η σχέση episode_cook_recipe είναι η μόνη σχέση ανάμεσα σε τρεις πίνακες αλλά ήταν απολύτως απαραίτητη καθώς σε κάθε επεισόδιο ένας μάγειρας μαγειρεύει μία συνταγή και δεν συνδέονται οι πληροφορίες αυτές με άλλο τρόπο. 

Τέλος, τα foodgroups συνδέονται με διπλή γραμμή με τα ingredients καθώς ένα ingredient πρέπει να ανήκει σε ένα και μόνο foodgroup .


# Σχεσιακό διάγραμμα της ΒΔ


![image](https://github.com/Silia030303/Data_Base_NTUA/assets/160490846/8c6f0331-9f2a-450f-8583-2c0f7e957b34)


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

Τρέξε στο terminal σου τον κώδικα του φακέλου : dml_link.sql
Ύστερα για να περάσεις τα random δεδομένα θα πρέπει να ακολουθήσεις τα εξής βήματα :
-	Κατέβασε VisualStudio (ή κάποιο άλλο εργαλείο ώστε να τρέχεις python ): Download Visual Studio Code - Mac, Linux, Windows
-	Κατέβασε την python: Download Python | Python.org
-	Κατέβασε τις παρακάτω βιβλιοθήκες πληκτρολογώντας στον terminal σου τις ακόλουθες εντολές:
pip install mysql-connector-python

-	Κατέβασε τα παρακάτω 3 αρχεία από το github repository και τρέξε τους με την σειρά που δίνετε :
 -	1.	episode_cook_recipe inserts.py
   2.		judge inserts.py
      3.		evaluation inserts.py
Τώρα έχουμε γεμίσει την βάση μας με δεδομένα.


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

**Ο κώδικας στο αρχείο **mastercef.sql** δημιουργεί μια βάση δεδομένων **project84_DB_2024** με αρκετούς πίνακες, σχέσεις και προβολές (views) που σχετίζονται με μια εφαρμογή που διαχειρίζεται συνταγές, μάγειρες, αξιολογήσεις, εξοπλισμό και άλλα στοιχεία μαγειρικής. Ακολουθεί μια περιγραφή των κύριων στοιχείων του κώδικα:**

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


--------------------------------------------------------------------------------------------------------------------

**Ο κώδικας στο αρχείο **Triggers.sql** περιλαμβάνει τη δημιουργία triggers (ενεργοποιητών) στη βάση δεδομένων **project84_DB_2024**. Αυτοί οι triggers εκτελούν συγκεκριμένες ενέργειες πριν την εισαγωγή ή την ενημέρωση δεδομένων σε ορισμένους πίνακες, ώστε να εξασφαλιστεί η ακεραιότητα των δεδομένων και να εφαρμοστούν επιχειρηματικοί κανόνες. Ακολουθεί μια περιγραφή των triggers που δημιουργήθηκαν:**

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
  - 
--------------------------------------------------------------------------------------------------------------------
**Ο κώδικας στο αρχείο dml_final.sql περιέχει εντολές που χρησιμοποιούνται για την εισαγωγή, δεδομένων στους πίνακες της βάσης δεδομένων. Αυτές οι εντολές εκτελούνται για να προσαρμοστεί το περιεχόμενο της βάσης δεδομένων σύμφωνα με τις ανάγκες της εφαρμογής.**

Οι βασικές εντολές DML είναι:
- **INSERT:** Εισάγει νέες εγγραφές σε έναν πίνακα της βάσης δεδομένων.
- **UPDATE:** Ενημερώνει τιμές σε υπάρχουσες εγγραφές ενός πίνακα.
- **DELETE:** Διαγράφει εγγραφές από έναν πίνακα.

**Εξήγηση τυχαίων insert σε πίνακες episode_cook_recipe , judge , evalution  με
χρήση python:**

**episode_cook_recipe inserts:**

Αρχικα η python συνδεεται στην βαση. Ορίζουμε την συναρτηση pick_episode_data
η οποια διαλεγει 10 διαφορετικά natcuis_id και με βάση αυτά 10 διαφορετικά
cook_id (με χρήση set αφου κάθε μάγειρας μπορεί να ανήκει σε πολλές κουζίνες και να ξαναεμφανιστεί) και recipe_id , το καθένα από τα οποία αντιστοιχεί σε 1 εθνική κουζίνα (μέσω dictionaries). Στη συνέχεια για κάθε episode_id απο
1 ως 30 κάνουμε 10 insert στον πίνακα episode_cook_recipe. Με χρήση if και
except  , εαν η κουζίνα που επιλέχθηκε υπάρχει ήδη στο επισόδιο ή ενεργοποιείται κάποιο trigger  λόγω του περιορισμού μη 3 συνεχόμενων cooks,
recipes, nat_cuis , δεν γίνεται το insert και ξανακαλείται η συνάρτηση pick_episode_data για νέα δεδομένα. 

**judge inserts:**

Αφού έχει γεμίσει ο πίνακας episode_cook_recipe , βρίσκουμε τους μάγειρες 
που θα συμμετάσχουν σε ένα συγκεκριμένο επισόδιο και διαλέγουμε 3 διαφορετικές με την συνάρτηση pick_judge. Στη συνέχεια με όμοιο τρόπο γεμίζουμε τον πίνακα judge , λαμβάνοντας υπόψιν περιορισμούς και triggers και δημιουργώντας νέα δεδομένα εαν ένα insert αποτύχει.

**evaluation inserts:**

Με ένα Join βρίσκουμε όλους τους συνδιασμούς κριτών - μαγείρων που υπάρχουν στα επισόδια , επιλέγουμε τυχαία μια βαθμολογία από το 1 στο 5 και γεμίζουμε τον πίνακα evaluation.

--------------------------------------------------------------------------------------------------------------------

**Ο κώδικας στο αρχείο Indexes.sql περιέχει εντολές που χρησιμοποιούνται βελτιστοποιούν τις επιδόσεις των ερωτημάτων, επιτρέποντας γρηγορότερη ανάκτηση δεδομένων μειώνοντας τον χρόνο αναζήτησης και τον αριθμό των απαιτούμενων δίσκων για πρόσβαση στα δεδομένα.**

Ας αναλύσουμε τη χρησιμότητα κάθε ευρετηρίου :

**1.	Πίνακας recipe:**
   	Τα ευρετηρία σε αυτόν τον πίνακα βελτιστοποιούν το: QUERY 12

  -	**idx_recipe_category:** Αυτό το ευρετήριο δημιουργείται πάνω στο πεδίο recipe_category. Είναι χρήσιμο για ερωτήματα που φιλτράρουν συνταγές ανά κατηγορία.
  -	**idx_difficulty_level:** Δημιουργείται πάνω στο πεδίο difficulty_level. Χρησιμοποιείται για ερωτήματα που φιλτράρουν ή υπολογίζουν τις μέσες δυσκολίες των συνταγών.
  
**2.	Πίνακας cook:**
   	Τα ευρετηρία σε αυτόν τον πίνακα βελτιστοποιούν τα: QUERIES 1,2,3,4,5,7,11
    
  -	**idx_cook_last_name:** Αυτό το ευρετήριο δημιουργείται πάνω στο πεδίο last_name. Χρησιμοποιείται για την επιτάχυνση ερωτημάτων που περιέχουν φίλτρα ή ομαδοποιήσεις βάσει του επωνύμου του μάγειρα.
  
  - **idx_cook_first_name:** Δημιουργείται πάνω στο πεδίο first_name. Παρέχει επιπλέον επιτάχυνση σε ερωτήματα που χρησιμοποιούν το πρώτο όνομα του μάγειρα.
  
  -	**idx_cook_age:** Ευρετήριο πάνω στο πεδίο age. Χρησιμοποιείται για ερωτήματα που εστιάζουν σε ηλικιακά κριτήρια.
  
**3.	Πίνακας national_cuisine:**
    Το ευρετηρίο σε αυτόν τον πίνακα βελτιστοποιεί τα: QUERIES 1,2,10
    
  -	**idx_natcuis_name:** Ευρετήριο πάνω στο πεδίο natcuis_name. Χρησιμοποιείται για ερωτήματα που φιλτράρουν ή ομαδοποιούν κατά την εθνική κουζίνα.
    
**4.	Πίνακας tags:**
   	Το ευρετηρίο σε αυτόν τον πίνακα βελτιστοποιεί το: QUERY 6
    
  -	**idx_tag_name:** Ευρετήριο πάνω στο πεδίο tag_name. Χρησιμοποιείται για ερωτήματα που φιλτράρουν ή συνδέουν συνταγές με ετικέτες.
  	
**5.	Πίνακας episode:**
   	Τα ευρετηρία σε αυτόν τον πίνακα βελτιστοποιούν τα : QUERIES 2,5,8,9,10,12,13

  -	**idx_episode_season:** Ευρετήριο πάνω στο πεδίο season. Χρησιμοποιείται για ερωτήματα που φιλτράρουν συνταγές ανά εποχή.
  -	**idx_episode_episode_name:** Χρησιμοποιείται για ερωτήματα που επιστρέφουν τα ονόματα των επεισοδίων.
    
**6.	Πίνακας foodgroups:**
     Το ευρετηρίο σε αυτόν τον πίνακα βελτιστοποιεί το: QUERY 15

  -	**idx_judge_foodgroups_name:** Ευρετήριο πάνω στο πεδίο foodgroups_name. Χρησιμοποιείται για ερωτήματα που φιλτράρουν ή συνδέουν συνταγές με ομάδες τροφίμων.
--------------------------------------------------------------------------------------------------------------------
**Έχουμε δημιουργήσει δύο ρόλους** 

 - **Διαχειριστής** -> administrator ο οποίος έχει δυνατότητα να επεξεργάζεται όλους τους πίνακες, views, triggers κτλ
 - **Μάγειρας** -> cook_role , ο οποίος έχει την δυνατότητα να δει και να προσθέσει πράγματα που αφορούν τις συνταγές αλλά όχι να επεξεργαστεί κάτι που υπάρχει ήδη καθώς θα μπορούσε να ανήκει σε κάποιον άλλο μάγειρα. Δεν έχει επίσης πρόσβαση σε πίνακες όπως το cook, καθώς δεν θέλουμε να ξέρει τις προσωπικές πληροφορίες των άλλων μαγείρων.

