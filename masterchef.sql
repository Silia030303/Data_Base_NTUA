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


CREATE TABLE recipe(
    recipe_id INT(10) unsigned AUTO_INCREMENT NOT NULL,
    recipe_name VARCHAR(50) NOT NULL,
    recipe_category VARCHAR(20) NOT NULL,
    CONSTRAINT Check_YourColumn CHECK (recipe_category IN ('main course', 'dessert')) ,
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
    


CREATE TABLE ingredient(
    ingredient_id INT(10) unsigned AUTO_INCREMENT NOT NULL,
    foodgroups_id INT(10) unsigned  NOT NULL, 
    ingredient_name VARCHAR(50) NOT NULL,
    image_url text DEFAULT NULL,
    image_description text DEFAULT NULL,
    PRIMARY KEY(ingredient_id),  
    FOREIGN KEY(foodgroups_id) REFERENCES foodgroups(foodgroups_id)
);



CREATE TABLE ingredient_VS_recipe(
    recipe_id INT(10) unsigned NOT NULL,
    ingredient_id INT(10) unsigned NOT NULL,
    PRIMARY KEY (recipe_id, ingredient_id),
    FOREIGN KEY (recipe_id) REFERENCES recipe(recipe_id),
    FOREIGN KEY (ingredient_id) REFERENCES ingredient(ingredient_id),
    quantity INT NULL CHECK (quantity >= 0),
    unit_of_measurement VARCHAR() unsigned NOT NULL ,
    calories INT(20) NOT NULL CHECK (calories >= 0) 

);


CREATE TABLE recipe_meal_type (
    recipe_id INT unsigned NOT NULL,
    meal_type_id INT unsigned NOT NULL,
    FOREIGN KEY(recipe_id) REFERENCES recipe(recipe_id),
    FOREIGN KEY(meal_type_id) REFERENCES meal_type(meal_type_id),
    last_update timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
    PRIMARY KEY(recipe_id,meal_type_id)
);

-- normalization 100 ml 
-- for example 1 egg

CREATE TABLE episode(
   episode_id INT(10) unsigned AUTO_INCREMENT NOT NULL,
   episode_name VARCHAR(50) NOT NULL,
   episode_date date NOT NULL,
   season INT NOT NULL CHECK (season >= 0),
   image_url text DEFAULT NULL,
   image_description text DEFAULT NULL,
   primary key(episode_id)
);

   --winner VARCHAR(50)

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


    
CREATE TABLE nutritional_info_ingredient(
    nutinf_ingredient_id INT(10) unsigned NOT NULL,
    ingredient_id INT(10) unsigned NOT NULL,
    fat_per_portion INT NOT NULL,
    protein_per_portion INT NOT NULL,
    carbohydrate_per_portion INT NOT NULL,
    FOREIGN KEY(ingredient_id) REFERENCES ingredient(ingredient_id),
    PRIMARY KEY(nutinf_ingredient_id, ingredient_id)
);
/* είτε 100 gρ , είτε μία σκελιδα, είτε μία κουπα, μια κουταλια του γλυκου */
/*αναγωγή μοναδων μετρησης σε 100 gρ*/


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


--unfinished
CREATE TABLE nutritional_info_recipe(
 nutinf_id INT(10) unsigned NOT NULL,
PRIMARY KEY(nutinf_id)
 
    );
    




















