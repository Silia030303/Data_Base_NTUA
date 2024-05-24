DELIMITER //

CREATE TRIGGER check_unit_of_measurement_insert
BEFORE INSERT ON ingredient_VS_recipe
FOR EACH ROW
BEGIN
    IF NEW.unit_of_measurement NOT IN (
        'g',
        'kg',
        'mg',
        'oz',
        'lb',
        'cup',
        'half cup',
        'quarter cup',
        'three-quarters cup',
        'tbsp',
        'tsp',
        'ml',
        'L',
        'pint',
        'gallon',
        'fl. oz',
        'piece',
        'half piece',
        'slice',
        'wedge',
        'clove',
        'head',
        'shot',
        'pack'
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Invalid value for unit_of_measurement. Allowed values are: g, kg, mg, oz, lb, cup, half cup, quarter cup, three-quarters cup, tbsp, tsp, ml, L, pint, gallon, fl. oz, piece, half piece, slice, wedge, clove, head, shot, pack';
    END IF;
END //



-- Trigger για την ενημέρωση δεδομένων στο unit_of_measurement
CREATE TRIGGER check_unit_of_measurement_update
BEFORE UPDATE ON ingredient_VS_recipe
FOR EACH ROW
BEGIN
    IF NEW.unit_of_measurement NOT IN (
        'g',
        'kg',
        'mg',
        'oz',
        'lb',
        'cup',
        'half cup',
        'quarter cup',
        'three-quarters cup',
        'tbsp',
        'tsp',
        'ml',
        'L',
        'pint',
        'gallon',
        'fl. oz',
        'piece',
        'half piece',
        'slice',
        'wedge',
        'clove',
        'head',
        'shot',
        'pack'
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Invalid value for unit_of_measurement. Allowed values are: g, kg, mg, oz, lb, cup, half cup, quarter cup, three-quarters cup, tbsp, tsp, ml, L, pint, gallon, fl. oz, piece, half piece, slice, wedge, clove, head, shot, pack';
    END IF;
END //


-- Trigger για την ενημέρωση δεδομένων στο foodgroups
CREATE TRIGGER check_foodgroups_update
BEFORE UPDATE ON  foodgroups
FOR EACH ROW
BEGIN
    IF NEW.foodgroups_name  IN (
    'Aromatic Herbs and Essential Oils',
    'Coffee, Tea, and Their Products',
    'Preserved Foods',
    'Sweeteners',
    'Fats and Oils',
    'Milk, Eggs, and Their Products',
    'Meat and Meat Products',
    'Fish and Fish Products' ,
    'Cereals and Their Products',
    'Various Plant-based Foods',
    'Products with Sweeteners', 
    'Various Beverages') THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Invalid value for unit_of_measurement_quantity. Allowed values are
    Aromatic Herbs and Essential Oils, 
    Coffee, Tea, and Their Products,
    Preserved Foods,
    Sweeteners,
    Fats and Oils,
    Milk, Eggs, and Their Products,
    Meat and Meat Products, 
    Fish and Fish Products ,
    Cereals and Their Products,
    Various Plant-based Foods,
    Products with Sweeteners, 
    Various Beverages' ;
    END IF;
END; //

-- Trigger για την ενημέρωση δεδομένων στο foodgroups
CREATE TRIGGER check_foodgroups_update
BEFORE UPDATE ON  ingredient
FOR EACH ROW
BEGIN
    IF NEW.foodgroups_id IN (1,2,3,4,5,6,7,8,9,10,11,12) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Invalid value for unit_of_measurement_quantity. Allowed values are:
    1 = Aromatic Herbs and Essential Oils,
    2 = Coffee, Tea, and Their Products, 
    3 = Preserved Foods,
    4 = Sweeteners, 
    5 = Fats and Oils,
    6 = Milk, Eggs, and Their Products, 
    7 = Meat and Meat Products, 
    8= Fish and Fish Products ,
    9 = Cereals and Their Products, 
    10 = Various Plant-based Foods, 
    11 = Products with Sweeteners, 
    12 = Various Beverages' ;
    END IF;
END; //

DELIMITER ;


--trigger for ensuring primary ingredient is in the ingredientVSrecipe table 
DELIMITER //

CREATE TRIGGER before_recipe_insert
BEFORE INSERT ON recipe
FOR EACH ROW
BEGIN
    -- Insert the primary ingredient into the ingredient_VS_recipe table
    INSERT INTO ingredient_VS_recipe (recipe_id, ingredient_id, quantity, unit_of_measurement, calories)
    VALUES (NEW.recipe_id, NEW.prim_ingredient_id, 0, NULL, 0);
END; //

DELIMITER ;


-- trigger for updating primary ingredient 
DELIMITER //

CREATE TRIGGER before_recipe_update
BEFORE UPDATE ON recipe
FOR EACH ROW
BEGIN
    -- If the primary ingredient is updated, update the ingredient_VS_recipe table
    IF NEW.prim_ingredient_id != OLD.prim_ingredient_id THEN
        -- Delete the old primary ingredient entry
        DELETE FROM ingredient_VS_recipe 
        WHERE recipe_id = OLD.recipe_id AND ingredient_id = OLD.prim_ingredient_id;

        -- Insert the new primary ingredient entry
        INSERT INTO ingredient_VS_recipe (recipe_id, ingredient_id, quantity, unit_of_measurement, calories)
        VALUES (NEW.recipe_id, NEW.prim_ingredient_id, 0, NULL, 0);
    END IF;
END; //

DELIMITER ;


-- trigger for only 10 cooks and recipes in each episode
DELIMITER //

CREATE TRIGGER before_episode_cook_recipe_insert
BEFORE INSERT ON episode_cook_recipe
FOR EACH ROW
BEGIN
    DECLARE count_episodes INT;
    -- Count the number of tuples with the same episode_id
    SELECT COUNT(*) INTO count_episodes
    FROM episode_cook_recipe
    WHERE episode_id = NEW.episode_id;

    -- If the count is already 10, prevent insertion
    IF count_episodes >= 10 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cannot insert more than 10 tuples with the same episode_id';
    END IF;
END; //

DELIMITER ;




--end






