--DDL


DROP DATABASE IF EXISTS project84_DB_2024;

CREATE database project84_DB_2024;
use project84_DB_2024;

--DROP TABLE IF EXISTS recipe;
-- DELETE FROM table_name;


CREATE TABLE equipment(
    equipment_id INT(10) unsigned AUTO_INCREMENT NOT NULL, 
    equipment_name VARCHAR(50) NOT NULL ,
    instructions text DEFAULT NULL ,
    image_url text DEFAULT NULL,
    image_description text DEFAULT NULL,
    PRIMARY KEY(equipment_id)
);  

CREATE TABLE foodgroups(
 foodgroups_id INT(10) unsigned AUTO_INCREMENT NOT NULL,
 foodgroups_name VARCHAR(50) NOT NULL,
 description text DEFAULT NULL,
 image_url text DEFAULT NULL,
 image_description text DEFAULT NULL,
 PRIMARY KEY(foodgroups_id)
 
    );


CREATE TABLE national_cuisine(
    natcuis_id INT(10) unsigned AUTO_INCREMENT  NOT NULL,
    natcuis_name VARCHAR(50) NOT NULL,
    image_url text DEFAULT NULL,
    image_description text DEFAULT NULL,
    PRIMARY KEY(natcuis_id)
);  


CREATE TABLE meal_type(
    meal_type_id INT(10) unsigned AUTO_INCREMENT NOT NULL,
    meal_type_name VARCHAR(50) NOT NULL,
    last_update timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
    PRIMARY KEY(meal_type_id)
);


CREATE TABLE ingredient(
    ingredient_id INT(10) unsigned AUTO_INCREMENT NOT NULL,
    foodgroups_id INT(10) unsigned  NOT NULL, 
    ingredient_name VARCHAR(50) NOT NULL,
    image_url text DEFAULT NULL,
    image_description text DEFAULT NULL,
    PRIMARY KEY(ingredient_id),  
    FOREIGN KEY(foodgroups_id) REFERENCES foodgroups(foodgroups_id)
);

CREATE TABLE recipe(
    recipe_id INT(10) unsigned AUTO_INCREMENT NOT NULL,
    recipe_name VARCHAR(50) NOT NULL,
    recipe_category VARCHAR(20) NOT NULL,
    CONSTRAINT Check_YourCategory CHECK (recipe_category IN ('main course', 'dessert')) ,
    natcuis_id  INT(10) unsigned NOT NULL ,
    prim_ingredient_id INT(10) unsigned NOT NULL, 
    recipe_description text DEFAULT NULL ,
    quantity_of_servings INT NOT NULL,
    difficulty_level INT NOT NULL,
    CONSTRAINT difficulty_level_check CHECK (difficulty_level IN (1,2,3,4,5)),
    tip_1 text DEFAULT NULL,
    tip_2 text DEFAULT NULL,
    tip_3 text DEFAULT NULL,
    image_url text DEFAULT NULL,
    image_description text DEFAULT NULL,
    prep_time INT unsigned NOT NULL,  
    classification VARCHAR(50),
    cooking_time INT unsigned NOT NULL,
    total_time INT unsigned AS (prep_time + cooking_time) STORED,
    fat_per_portion INT NOT NULL,
    protein_per_portion INT NOT NULL,
    carbohydrate_per_portion INT NOT NULL,
    KEY idx_total_time (total_time),
    FOREIGN KEY(natcuis_id) REFERENCES national_cuisine(natcuis_id),
    FOREIGN KEY(prim_ingredient_id) REFERENCES ingredient(ingredient_id),
    PRIMARY KEY(recipe_id)
);

CREATE TABLE recipe_equipment(
 recipe_id INT unsigned NOT NULL,
 equipment_id INT unsigned NOT NULL,
 last_update timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
 FOREIGN KEY(recipe_id) REFERENCES recipe(recipe_id),
 FOREIGN KEY(equipment_id) REFERENCES equipment(equipment_id),
 PRIMARY KEY(recipe_id,equipment_id)
    );


CREATE TABLE ingredient_VS_recipe(
    recipe_id INT(10) unsigned NOT NULL,
    ingredient_id INT(10) unsigned NOT NULL,
    PRIMARY KEY (recipe_id, ingredient_id),
    FOREIGN KEY (recipe_id) REFERENCES recipe(recipe_id),
    FOREIGN KEY (ingredient_id) REFERENCES ingredient(ingredient_id),
    quantity INT NOT NULL CHECK (quantity >= 0),
    unit_of_measurement VARCHAR(50) DEFAULT NULL ,
    calories INT NOT NULL CHECK (calories >= 0) 
);

CREATE TABLE tags(
    tag_id INT(10) unsigned AUTO_INCREMENT NOT NULL,
    tag_name VARCHAR(50) NOT NULL,
    last_update timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
    image_url text DEFAULT NULL,
    image_description text DEFAULT NULL,
    PRIMARY KEY(tag_id)
);


CREATE TABLE recipe_tag(
 recipe_id INT unsigned NOT NULL,
 tag_id INT unsigned NOT NULL,
 last_update timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
 FOREIGN KEY(recipe_id) REFERENCES recipe(recipe_id),
 FOREIGN KEY(tag_id) REFERENCES tags(tag_id),
 PRIMARY KEY(recipe_id,tag_id)
    );
    
CREATE TABLE recipe_meal_type (
    recipe_id INT unsigned NOT NULL,
    meal_type_id INT unsigned NOT NULL,
    FOREIGN KEY(recipe_id) REFERENCES recipe(recipe_id),
    FOREIGN KEY(meal_type_id) REFERENCES meal_type(meal_type_id),
    last_update timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
    PRIMARY KEY(recipe_id,meal_type_id)
);


CREATE TABLE episode(
   episode_id INT(10) unsigned AUTO_INCREMENT NOT NULL,
    -- add episode serial number
   episode_name VARCHAR(50) NOT NULL,
   episode_date date NOT NULL,
   season INT NOT NULL CHECK (season >= 0),
   image_url text DEFAULT NULL,
   image_description text DEFAULT NULL,
   primary key(episode_id)
);

CREATE TABLE cook(
 cook_id INT(10) unsigned NOT NULL AUTO_INCREMENT,
 first_name VARCHAR(50) NOT NULL,
 last_name VARCHAR(50) NOT NULL,
 birth_date DATE NOT NULL,
 years_of_experience INT NOT NULL,
 age INT AS (YEAR(CURDATE()) - YEAR(birth_date) - (DATE_FORMAT(CURDATE(), '%m%d') < DATE_FORMAT(birth_date, '%m%d'))),
 phone_number CHAR(10) NOT NULL,
 position_level VARCHAR(30) CHECK (position_level IN ('cook A','cook B','cook C','chef assistant','chef')), 
 last_update TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(),
 image_url text DEFAULT NULL,
 image_description text DEFAULT NULL,
 PRIMARY KEY(cook_id)
);

CREATE TABLE judge(
   judge_id INT(10) unsigned NOT NULL AUTO_INCREMENT,
   cook_id INT(10) unsigned NOT NULL,
   partitipation_number INT(10) unsigned,
   episode_id INT(10) unsigned NOT NULL,
   PRIMARY KEY(judge_id),
   FOREIGN KEY (cook_id) REFERENCES cook(cook_id),
   FOREIGN KEY(episode_id) REFERENCES episode(episode_id)
);

CREATE TABLE recipe_step (
    step_id INT unsigned NOT NULL AUTO_INCREMENT,
    step_description text DEFAULT NULL ,
    serial_number INT unsigned NOT NULL,
    /*add trigger (?)*/
    recipe_id INT(10) unsigned NOT NULL,
    FOREIGN KEY(recipe_id) REFERENCES recipe(recipe_id),
    PRIMARY KEY(step_id)
);

CREATE TABLE thematic_section(
    them_sec_id INT(10) unsigned AUTO_INCREMENT NOT NULL,
    name VARCHAR(50) NOT NULL,
    description text DEFAULT NULL,
    last_update timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
    image_url text DEFAULT NULL,
    image_description text DEFAULT NULL,
    PRIMARY KEY(them_sec_id)
);


CREATE TABLE recipe_thematic_section(
  recipe_id INT(10) unsigned NOT NULL,
  them_sec_id INT(10) unsigned NOT NULL,
  last_update timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY(recipe_id,them_sec_id),
  FOREIGN KEY(them_sec_id) REFERENCES thematic_section(them_sec_id),
  FOREIGN KEY(recipe_id) REFERENCES recipe(recipe_id)  
    );


    
CREATE TABLE evaluation (
    cook_id INT unsigned NOT NULL,
    judge_id INT unsigned NOT NULL,
    grade INT NOT NULL,
    CONSTRAINT grade_check CHECK (grade IN (1,2,3,4,5)),
    FOREIGN KEY(cook_id) REFERENCES cook(cook_id),
    FOREIGN KEY(judge_id) REFERENCES judge(judge_id),
    PRIMARY KEY(cook_id,judge_id)
);

CREATE TABLE episode_cook_recipe(
    cook_id INT(10) unsigned NOT NULL,
    episode_id INT(10) unsigned NOT NULL,
    recipe_id INT(10) unsigned NOT NULL,
    FOREIGN KEY(cook_id) REFERENCES cook(cook_id),
    FOREIGN KEY(episode_id) REFERENCES episode(episode_id),
    FOREIGN KEY(recipe_id) REFERENCES recipe(recipe_id),
    PRIMARY KEY(cook_id,episode_id)
    );

CREATE TABLE cook_nat_cuis(
 cook_id INT unsigned NOT NULL,
 natcuis_id INT unsigned NOT NULL,
 last_update timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
 FOREIGN KEY(cook_id) REFERENCES cook(cook_id),
 FOREIGN KEY(natcuis_id) REFERENCES national_cuisine(natcuis_id),
 PRIMARY KEY(cook_id,natcuis_id)
    );
 
    
-- recipe_nutritional_info view ΔΕΝ ΤΡΕΧΕΙ

CREATE VIEW recipe_nutritional_info_vw AS
SELECT 
    recipe_id,
    recipe_name,
    quantity_of_servings,
    fat_per_portion,
    protein_per_portion,
    carbohydrate_per_portion,
    CASE
        WHEN quantity_of_servings = 0 THEN NULL
        ELSE total_calories / quantity_of_servings
    END AS calories_per_portion
FROM 
    (SELECT 
        r.recipe_name,
        r.quantity_of_servings,
        r.fat_per_portion,
        r.protein_per_portion,
        r.carbohydrate_per_portion,
        SUM(ir.calories) AS total_calories
    FROM 
        recipe r
    JOIN 
        ingredient_VS_recipe ir 
    ON 
        r.recipe_id = ir.recipe_id
    GROUP BY 
        r.recipe_id) AS table1;

-- recipe_nutritional_info view ΠΟΥ ΤΡΈΧΕΙ 

CREATE VIEW recipe_nutritional_info_vw AS
SELECT
    table1.recipe_id,
    table1.recipe_name,
    table1.quantity_of_servings,
    table1.fat_per_portion,
    table1.protein_per_portion,
    table1.carbohydrate_per_portion,
    CASE
        WHEN table1.quantity_of_servings = 0 THEN NULL
        ELSE table1.total_calories / table1.quantity_of_servings
    END AS calories_per_portion
FROM
    (SELECT
        r.recipe_id,
        r.recipe_name,
        r.quantity_of_servings,
        r.fat_per_portion,
        r.protein_per_portion,
        r.carbohydrate_per_portion,
        SUM(ir.calories) AS total_calories
    FROM
        recipe r
    JOIN
        ingredient_VS_recipe ir
    ON
        r.recipe_id = ir.recipe_id
    GROUP BY
        r.recipe_id) AS table1;


-- winner view
CREATE VIEW winner_vw AS
WITH RankedCooks AS (
    SELECT 
        ep.episode_name, 
        c.last_name, 
        CASE c.position_level
            WHEN 'cook A' THEN 1
            WHEN 'cook B' THEN 2
            WHEN 'cook C' THEN 3
            WHEN 'chef assistant' THEN 4
            WHEN 'chef' THEN 5
        END as position_level, 
        SUM(e.grade) AS score,
        ROW_NUMBER() OVER (
            PARTITION BY ecr.episode_id 
            ORDER BY 
                SUM(e.grade) DESC, 
                CASE c.position_level
                    WHEN 'cook A' THEN 1
                    WHEN 'cook B' THEN 2
                    WHEN 'cook C' THEN 3
                    WHEN 'chef assistant' THEN 4
                    WHEN 'chef' THEN 5
                END DESC,
                RAND()
        ) AS rank
    FROM 
        episode_cook_recipe ecr
    JOIN 
        cook c ON c.cook_id = ecr.cook_id
    JOIN 
        evaluation e ON e.cook_id = c.cook_id
    JOIN
        episode ep ON ep.episode_id = ecr.episode_id
    GROUP BY 
        ecr.episode_id, 
        c.cook_id
)
SELECT 
    episode_name, 
    last_name, 
    position_level, 
    score
FROM 
    RankedCooks
WHERE 
    rank = 1;







--end














