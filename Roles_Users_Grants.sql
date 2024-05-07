CREATE ROLE cook_role;
GRANT INSERT on recipe to cook_role;
CREATE USER 'gordon_ramsey'@'localhost' IDENTIFIED by 'password1';
GRANT cook_role to 'gordon_ramsey'@'localhost';
GRANT SELECT, INSERT ON masterchef.recipe TO cook_role;
-- GRANT SELECT, INSERT ON masterchef.recipe TO 'gordon_ramsey'@'localhost';

-- Creating a back up containing all the sql code for the recreation of the database------------
mysqldump -u username -p masterchef > masterchef_backup.sql
--restoration 
    source /path/to/backup_file.sql;



--Some sql pseudocode for row-level authorization
-- Step 1: Create a role for cooks
CREATE ROLE cook_role;

-- Step 2: Create a stored procedure or trigger
CREATE PROCEDURE update_cook_info(
    IN p_cook_id INT,
    IN p_first_name VARCHAR(50),
    IN p_last_name VARCHAR(50),
    IN p_birth_date DATE,
    IN p_years_of_experience INT,
    IN p_phone_number CHAR(10),
    IN p_position_level VARCHAR(30)
)
BEGIN
    DECLARE v_user_cook_id INT;

    -- Get the cook_id of the current user
    SELECT cook_id INTO v_user_cook_id FROM users WHERE username = CURRENT_USER();

    -- Check if the current user is authorized to modify the cook_id
    IF v_user_cook_id = p_cook_id THEN
        -- Update the cook's information
        UPDATE cook
        SET first_name = p_first_name,
            last_name = p_last_name,
            birth_date = p_birth_date,
            years_of_experience = p_years_of_experience,
            phone_number = p_phone_number,
            position_level = p_position_level
        WHERE cook_id = p_cook_id;
    ELSE
        -- Raise an error or handle unauthorized access
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'You are not authorized to modify this cook''s information';
    END IF;
END;

-- Step 3: Grant permissions to the cook role
GRANT EXECUTE ON PROCEDURE update_cook_info TO cook_role;
