---------------Role Creation -> Cook -----------------------
CREATE ROLE cook_role;
------------- Give a grant to a role--------------
GRANT SELECT, INSERT ON masterchef.recipe TO cook_role;
-------------Users----------------------
CREATE USER 'gordon_ramsey'@'localhost' IDENTIFIED by 'password1';
GRANT cook_role to 'gordon_ramsey'@'localhost';

---How to give grants to individual user ( meaning not though roles)
GRANT SELECT, INSERT ON masterchef.recipe TO 'gordon_ramsey'@'localhost';

-------- Role Creation -> Administrator -----------------
CREATE ROLE administrator;
GRANT ALL PRIVILEGES ON *.* TO administrator WITH GRANT OPTION;


-- Creating a BACKUP containing all the sql code for the recreation of the database------------
mysqldump -u username -p masterchef > masterchef_backup.sql
--restoration 
    source /path/to/backup_file.sql;

