DELIMITER //

-- Trigger για την εισαγωγή δεδομένων στο unit_of_measurement
CREATE TRIGGER check_unit_of_measurement_quantity_insert
BEFORE INSERT ON ingredient_VS_recipe
FOR EACH ROW
BEGIN
    IF NEW.unit_of_measurement_quantity NOT IN ('Γραμμάριο (g)', 'Κιλό (kg)', 'Μιλιγκράμ (mg)','Ουγγιά (oz)','Λίβρα (lb)','Κούπα (cup)','Μισή κούπα (½ cup)','Τέταρτο κούπας (¼ cup)','Τρια τέταρτα κούπας (¾ cup)','Κουτάλι της σούπας (tbsp ή T)','Κουταλάκι του γλυκού (tsp ή t)','Μιλιλίτρο (ml)','Λίτρο (L)','Πίντα (pint)','Γαλόνι (gallon)','Φλιτζάνι (fl. oz)','Ένα κομμάτι (piece)','Μισό κομμάτι (half piece)','Φέτα (slice)','Σφήνα (wedge)','Σκελίδα (clove, για το σκόρδο)','Κεφάλι (head, για το μαρούλι ή το σκόρδο)','Σταγόνα (drop)','Σφηνάκι (shot, για τα υγρά)','Συσκευασία (pack ή package)' ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Invalid value for unit_of_measurement_quantity. Allowed values are: Γραμμάριο (g), Κιλό (kg), Μιλιγκράμ (mg),Ουγγιά (oz),Λίβρα (lb),Κούπα (cup),Μισή κούπα (½ cup),Τέταρτο κούπας (¼ cup),Τρια τέταρτα κούπας (¾ cup),Κουτάλι της σούπας (tbsp ή T),Κουταλάκι του γλυκού (tsp ή t),Μιλιλίτρο (ml),Λίτρο (L),Πίντα (pint),Γαλόνι (gallon),Φλιτζάνι (fl. oz),Ένα κομμάτι (piece),Μισό κομμάτι (half piece),Φέτα (slice),Σφήνα (wedge),Σκελίδα (clove, για το σκόρδο),Κεφάλι (head, για το μαρούλι ή το σκόρδο),Σταγόνα (drop),Σφηνάκι (shot, για τα υγρά),Συσκευασία (pack ή package)';
    END IF;
END; //

-- Trigger για την ενημέρωση δεδομένων στο unit_of_measurement
CREATE TRIGGER check_unit_of_measurement_quantity_update
BEFORE UPDATE ON ingredient_VS_recipe
FOR EACH ROW
BEGIN
    IF NEW.unit_of_measurement_quantity NOT IN ('Γραμμάριο (g)', 'Κιλό (kg)', 'Μιλιγκράμ (mg)','Ουγγιά (oz)','Λίβρα (lb)','Κούπα (cup)','Μισή κούπα (½ cup)','Τέταρτο κούπας (¼ cup)','Τρια τέταρτα κούπας (¾ cup)','Κουτάλι της σούπας (tbsp ή T)','Κουταλάκι του γλυκού (tsp ή t)','Μιλιλίτρο (ml)','Λίτρο (L)','Πίντα (pint)','Γαλόνι (gallon)','Φλιτζάνι (fl. oz)','Ένα κομμάτι (piece)','Μισό κομμάτι (half piece)','Φέτα (slice)','Σφήνα (wedge)','Σκελίδα (clove, για το σκόρδο)','Κεφάλι (head, για το μαρούλι ή το σκόρδο)','Σταγόνα (drop)','Σφηνάκι (shot, για τα υγρά)','Συσκευασία (pack ή package)') THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Invalid value for unit_of_measurement_quantity. Allowed values are: Γραμμάριο (g), Κιλό (kg), Μιλιγκράμ (mg),Ουγγιά (oz),Λίβρα (lb),Κούπα (cup),Μισή κούπα (½ cup),Τέταρτο κούπας (¼ cup),Τρια τέταρτα κούπας (¾ cup),Κουτάλι της σούπας (tbsp ή T),Κουταλάκι του γλυκού (tsp ή t),Μιλιλίτρο (ml),Λίτρο (L),Πίντα (pint),Γαλόνι (gallon),Φλιτζάνι (fl. oz),Ένα κομμάτι (piece),Μισό κομμάτι (half piece),Φέτα (slice),Σφήνα (wedge),Σκελίδα (clove, για το σκόρδο),Κεφάλι (head, για το μαρούλι ή το σκόρδο),Σταγόνα (drop),Σφηνάκι (shot, για τα υγρά),Συσκευασία (pack ή package)';
    END IF;
END; //



-- Trigger για την ενημέρωση δεδομένων στο foodgroups
CREATE TRIGGER check_foodgroups_update
BEFORE UPDATE ON  foodgroups
FOR EACH ROW
BEGIN
    IF NEW.foodgroups_name  IN ('Aromatic Herbs and Essential Oils', 'Coffee, Tea, and Their Products','Preserved Foods','Sweeteners','Fats and Oils','Milk, Eggs, and Their Products','Meat and Meat Products', 'Fish and Fish Products' ,'Cereals and Their Products','Various Plant-based Foods','Products with Sweeteners', 'Various Beverages') THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Invalid value for unit_of_measurement_quantity. Allowed values are:Aromatic Herbs and Essential Oils, Coffee, Tea, and Their Products,Preserved Foods,Sweeteners,Fats and Oils,Milk, Eggs, and Their Products,Meat and Meat Products, Fish and Fish Products ,Cereals and Their Products,Various Plant-based Foods,Products with Sweeteners, Various Beverages' ;
    END IF;
END; //

-- Trigger για την ενημέρωση δεδομένων στο foodgroups
CREATE TRIGGER check_foodgroups_update
BEFORE UPDATE ON  ingredient
FOR EACH ROW
BEGIN
    IF NEW.foodgroups_id IN (1,2,3,4,5,6,7,8,9,10,11,12) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Invalid value for unit_of_measurement_quantity. Allowed values are: 1 = Aromatic Herbs and Essential Oils, 2 = Coffee, Tea, and Their Products, 3 = Preserved Foods,4 = Sweeteners, 5 = Fats and Oils,6 = Milk, Eggs, and Their Products, 7 = Meat and Meat Products, 8= Fish and Fish Products , 9 = Cereals and Their Products, 10 = Various Plant-based Foods, 11 = Products with Sweeteners, 12 = Various Beverages' ;
    END IF;
END; //

DELIMITER ;


'1 = Aromatic Herbs and Essential Oils, 2 = Coffee, Tea, and Their Products, 3 = Preserved Foods,4 = Sweeteners, 5 = Fats and Oils,6 = Milk, Eggs, and Their Products, 7 = Meat and Meat Products, 8= Fish and Fish Products , 9 = Cereals and Their Products, 10 = Various Plant-based Foods, 11 = Products with Sweeteners, 12 = Various Beverages'
