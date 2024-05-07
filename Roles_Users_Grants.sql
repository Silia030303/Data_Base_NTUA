CREATE ROLE cook_role;
GRANT INSERT on recipe to cook;
CREATE USER 'gordon_ramsey'@'localhost' IDENTIFIED by 'password1';
GRANT cook_role to 'gordon_ramsey'@'localhost';
GRANT SELECT, INSERT ON masterchef.recipe TO cook;
-- GRANT SELECT, INSERT ON masterchef.recipe TO 'gordon_ramsey'@'localhost';
