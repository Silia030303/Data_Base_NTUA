DELIMITER //
--PETE : Ξαναλεω το TRIGGER του. 
--TRIGGER : Cook cannot participate in three consecutive episodes.

--Cook cannot participate in three consecutive episodes.
CREATE TRIGGER before_episode_cook_recipe_insert_cook
BEFORE INSERT ON episode_cook_recipe
FOR EACH ROW
BEGIN
    DECLARE episode_serial_number INT;

    -- Get the serial number of the episode being inserted
    SELECT serial_number INTO episode_serial_number
    FROM episode
    WHERE episode_id = NEW.episode_id;

    -- Only perform the check if the episode serial number is greater than 2
    IF episode_serial_number > 2 THEN
        --Δηλώνει μια μεταβλητή episode_serial_number τύπου INT για να αποθηκεύσει τον σειριακό αριθμό του επεισοδίου.
        DECLARE prev_episode_count INT;

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
--Silia : Αυτα που πρόσθεσα
--TRIGGER : Recipe cannot appear in three consecutive episodes.

CREATE TRIGGER before_episode_cook_recipe_insert_recipe
BEFORE INSERT ON episode_cook_recipe
FOR EACH ROW
BEGIN
    DECLARE episode_serial_number INT;

    -- Get the serial number of the episode being inserted
    SELECT serial_number INTO episode_serial_number
    FROM episode
    WHERE episode_id = NEW.episode_id;

    -- Only perform the check if the episode serial number is greater than 2
    IF episode_serial_number > 2 THEN
        DECLARE prev_episode_count INT;

        -- Check if the recipe was in the previous two episodes
        SELECT COUNT(*)
        INTO prev_episode_count
        FROM episode_cook_recipe ecr
        JOIN episode e ON ecr.episode_id = e.episode_id
        WHERE ecr.recipe_id = NEW.recipe_id
          AND e.serial_number IN (episode_serial_number - 1, episode_serial_number - 2);

        -- If the recipe was in both previous episodes, prevent the insert
        IF prev_episode_count = 2 THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Recipe cannot appear in three consecutive episodes.';
        END IF;
    END IF;
END;
//

--TRIGGER : judge participated in 3 different episodes
CREATE TRIGGER before_judge_insert
BEFORE INSERT ON judge
FOR EACH ROW
BEGIN
    DECLARE max_episode_id INT;
    DECLARE min_episode_id INT;

    -- Find the maximum and minimum episode_id for the given judge_id
    SELECT MAX(episode_id), MIN(episode_id) INTO max_episode_id, min_episode_id
    FROM judge
    WHERE judge_id = NEW.judge_id;

    -- If the judge has participated in 3 consecutive episodes, prevent the insert
    IF max_episode_id IS NOT NULL AND
       (max_episode_id - min_episode_id >= 2) AND
       (NEW.episode_id BETWEEN min_episode_id AND max_episode_id) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'The judge cannot participate in more than 3 consecutive episodes.';
    END IF;
END;

//
DELIMITER ;
