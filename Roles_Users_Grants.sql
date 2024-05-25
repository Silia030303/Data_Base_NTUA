---------------Role Creation -> Cook -----------------------
CREATE ROLE cook_role;
------------- Give a grant to a role--------------
GRANT SELECT, INSERT ON project84_DB_2024.recipe TO cook_role;
---Για να προσθέσει κάποιος μία συνταγή πρέπει να προσθέσει τον εξοπλισμό της και επισης να μπορεί να προσθέσει κάποιον νέο εξοπλισμό αν χρειάζεται
GRANT SELECT, INSERT ON project84_DB_2024.equipment TO cook_role;
GRANT SELECT, INSERT ON project84_DB_2024.recipe_equipment TO cook_role;
--- Αντίστοιχα πρέπει να προσθέσει την εθνική κουζίνα της συνταγής,τα υλικά που απαιτούνται και τα διάφορα tags ή meal_types 
GRANT SELECT, INSERT ON project84_DB_2024.national_cuisine TO cook_role;
GRANT SELECT, INSERT ON project84_DB_2024.ingredient TO cook_role;
GRANT SELECT, INSERT ON project84_DB_2024.ingredient_VS_recipe TO cook_role;

GRANT SELECT, INSERT ON project84_DB_2024.tags TO cook_role;
GRANT SELECT, INSERT ON project84_DB_2024.recipe_tag TO cook_role;

GRANT SELECT, INSERT ON project84_DB_2024.recipe_meal_type TO cook_role;
GRANT SELECT, INSERT ON project84_DB_2024.meal_type TO cook_role;

GRANT SELECT, INSERT ON project84_DB_2024.recipe_step TO cook_role;

GRANT SELECT, INSERT ON project84_DB_2024.thematic_section TO cook_role;
GRANT SELECT, INSERT ON project84_DB_2024.recipe_thematic_section TO cook_role;

--Θα μπορούν επισης να δουν αλλα όχι να προσθέσουμε κατι που αφορά τα επεισόδια 
GRANT SELECT ON project84_DB_2024.episode TO cook_role;


-------------Users----------------------
CREATE USER 'gordon_ramsey'@'localhost' IDENTIFIED by 'password1';
GRANT cook_role to 'gordon_ramsey'@'localhost';

---How to give grants to individual user ( meaning not though roles)
GRANT SELECT, INSERT ON project84_DB_2024.recipe TO 'gordon_ramsey'@'localhost';

---mysql -u gordon_ramsey2 -p

-------- Role Creation -> Administrator -----------------
CREATE ROLE administrator;
GRANT ALL PRIVILEGES ON *.* TO administrator WITH GRANT OPTION;


-- Creating a BACKUP containing all the sql code for the recreation of the database------------
mysqldump -u username -p masterchef > masterchef_backup.sql
--restoration 
    source /path/to/backup_file.sql;

