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
CREATE TRIGGER check_foodgroups_insert
BEFORE INSERT ON  foodgroups
FOR EACH ROW
BEGIN
    IF NEW.foodgroups_name NOT IN (
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
    'Various Beverages', 
    'other foodgroup') THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Invalid value for unit_of_foodgroups. Allowed values are
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
CREATE TRIGGER check_foodgroups_insert_in_ingridient
BEFORE INSERT ON  ingredient
FOR EACH ROW
BEGIN
    IF NEW.foodgroups_id NOT IN (1,2,3,4,5,6,7,8,9,10,11,12,13) THEN
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
    12 = Various Beverages,
    13 = other foodgroup';
    END IF;
END; //

-- trigger for only 10 cooks and recipes in each episode
    
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




--trigger for nonconsecutive cooks

DELIMITER //

CREATE TRIGGER before_episode_cook_insert
BEFORE INSERT ON episode_cook_recipe
FOR EACH ROW
BEGIN
    DECLARE episode_serial_number INT;
    DECLARE prev_episode_count INT;

    -- Get the serial number of the episode being inserted
    SELECT serial_number INTO episode_serial_number
    FROM episode
    WHERE episode_id = NEW.episode_id;

    -- Only perform the check if the episode serial number is greater than 2
    IF episode_serial_number > 2 THEN
        -- Check if the cook was in the previous two episodes
        SELECT COUNT(*)
        INTO prev_episode_count
        FROM episode_cook_recipe ecr
        JOIN episode e ON ecr.episode_id = e.episode_id
        WHERE ecr.cook_id = NEW.cook_id
          AND e.serial_number IN (episode_serial_number - 1, episode_serial_number - 2);

        -- If the cook was in both previous episodes, prevent the insert
        IF prev_episode_count = 2 THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Cook cannot participate in three consecutive episodes.';
        END IF;
    END IF;
END;

//
DELIMITER ;




--trigger for no 3 consecutive recipes 

DELIMITER //

CREATE TRIGGER before_episode_recipe_insert
BEFORE INSERT ON episode_cook_recipe
FOR EACH ROW
BEGIN
    DECLARE episode_serial_number INT;
    DECLARE prev_episode_count INT;

    -- Get the serial number of the episode being inserted
    SELECT serial_number INTO episode_serial_number
    FROM episode
    WHERE episode_id = NEW.episode_id;

    -- Only perform the check if the episode serial number is greater than 2
    IF episode_serial_number > 2 THEN
        -- Check if the cook was in the previous two episodes
        SELECT COUNT(*)
        INTO prev_episode_count
        FROM episode_cook_recipe ecr
        JOIN episode e ON ecr.episode_id = e.episode_id
        WHERE ecr.cook_id = NEW.cook_id
          AND e.serial_number IN (episode_serial_number - 1, episode_serial_number - 2);

        -- If the cook was in both previous episodes, prevent the insert
        IF prev_episode_count = 2 THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'recipe cannot participate in three consecutive episodes.';
        END IF;
    END IF;
END;

//
DELIMITER ;




--trigger for no consecutive natcuis 
DELIMITER //

CREATE TRIGGER before_episode_cook_insert_natcuis
BEFORE INSERT ON episode_cook_recipe
FOR EACH ROW
BEGIN
    DECLARE episode_serial_number INT;
    DECLARE prev_episode_count INT;

    -- Get the serial number of the episode being inserted
    SELECT serial_number INTO episode_serial_number
    FROM episode
    WHERE episode_id = NEW.episode_id;

    -- Only perform the check if the episode serial number is greater than 2
    IF episode_serial_number > 2 THEN
        -- Check if the natcuis was in the previous two episodes
        SELECT COUNT(*)
        INTO prev_episode_count
        FROM episode_cook_recipe ecr
        JOIN episode e ON ecr.episode_id = e.episode_id
        JOIN recipe r ON r.recipe_id = ecr.recipe_id
        JOIN national_cuisine nc ON nc.natcuis_id= r.natcuis_id
        WHERE ecr.recipe_id = NEW.recipe_id
          AND e.serial_number IN (episode_serial_number - 1, episode_serial_number - 2)
        GROUP BY nc.nat_cuis_id;

        -- If the natcuis was in both previous episodes, prevent the insert
        IF prev_episode_count = 2 THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'natcuis cannot participate in three consecutive episodes.';
        END IF;
    END IF;
END;
//

DELIMITER ;



--no consecutive 3 judges : 

DELIMITER //

CREATE TRIGGER before_judge
BEFORE INSERT ON judge
FOR EACH ROW
BEGIN
    DECLARE episode_serial_number INT;
    DECLARE prev_episode_count INT;

    -- Get the serial number of the episode being inserted
    SELECT serial_number INTO episode_serial_number
    FROM episode
    WHERE episode_id = NEW.episode_id;

    -- Only perform the check if the episode serial number is greater than 2
    IF episode_serial_number > 2 THEN
        -- Check if the judge was in the previous two episodes
        SELECT COUNT(*)
        INTO prev_episode_count
        FROM judge j 
        JOIN episode_cook_recipe ecr ON j.episode_id = ecr.episode_id
        JOIN episode e ON ecr.episode_id = e.episode_id
        WHERE j.judge_id = NEW.judge_id
          AND e.serial_number IN (episode_serial_number - 1, episode_serial_number - 2);

        -- If the judge was in both previous episodes, prevent the insert
        IF prev_episode_count = 2 THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'judge cannot participate in three consecutive episodes.';
        END IF;
    END IF;
END;

//

DELIMITER ;



--trigger for steps
DELIMITER $$

CREATE TRIGGER check_sequential_steps
BEFORE INSERT ON recipe_step
FOR EACH ROW
BEGIN
    DECLARE prev_step_count INT;
    IF NEW.serial_number > 1 THEN
        SELECT COUNT(*) INTO prev_step_count FROM recipe_step WHERE recipe_id = NEW.recipe_id AND serial_number = NEW.serial_number - 1;
        IF prev_step_count = 0 THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot insert step without previous step.';
        END IF;
    END IF;
END$$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER check_step_serial_number
BEFORE INSERT ON recipe_step
FOR EACH ROW
BEGIN
    DECLARE existing_serial_count INT;
    SELECT COUNT(*) INTO existing_serial_count FROM recipe_step WHERE recipe_id = NEW.recipe_id AND serial_number = NEW.serial_number;
    IF existing_serial_count > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'A step with the same serial number already exists for this recipe.';
    END IF;
END$$

DELIMITER ;



--end






