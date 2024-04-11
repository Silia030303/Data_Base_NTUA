
create database masterchef;
use masterchef;


CREATE TABLE equipment(
    equipment_id INT(10) unsigned AUTO_INCREMENT NOT NULL, 
    equipment_name VARCHAR(50) NOT NULL ,
    instructions text DEFAULT NULL ,
    PRIMARY KEY(equipment_id)
);  

--INSERT INTO equipment (equipment_name, instructions) VALUES ('briki', 'boil le egg'); 


CREATE TABLE national_cuisine(
    natcuis_id INT(10) unsigned AUTO_INCREMENT  NOT NULL,
    natcuis_name VARCHAR(50) NOT NULL,
    PRIMARY KEY(natcuis_id)
);   --useless imo :)


CREATE TABLE meal(
    meal_id INT AUTO_INCREMENT  NOT NULL,
    meal_name VARCHAR(50) NOT NULL,
    meal_calories INT(10) UNSIGNED NOT NULL,
    meal_type VARCHAR(50) NOT NULL,
    PRIMARY KEY(meal_id)
);
CREATE TABLE time(
    time_id INT(10) unsigned NOT NULL AUTO_INCREMENT,
    prep_time INT unsigned NOT NULL,  -- in minutes
    cooking_time INT unsigned NOT NULL,
    last_update timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
    total_time INT unsigned AS (prep_time + cooking_time) STORED,
    KEY idx_total_time (total_time),
    PRIMARY KEY (time_id)
);
-- each recipe has only one time so we can add it directly to recipe

CREATE TABLE recipe(
    recipe_id INT AUTO_INCREMENT NOT NULL,
    recipe_name VARCHAR(50) NOT NULL,
    recipe_category VARCHAR(20) NOT NULL,
    CONSTRAINT Check_YourColumn CHECK (recipe_category IN ('main course', 'dessert')) ,
    national_cuisine VARCHAR (50) ,
    recipe_description text DEFAULT NULL ,
    primary_ingredient VARCHAR(50),
    difficulty_level INT NOT NULL,
    CONSTRAINT difficulty_level_check CHECK (difficulty_level IN (1,2,3,4,5)),
    time_id INT(10) unsigned NOT NULL,
    CONSTRAINT `fk_time_id` FOREIGN KEY (`time_id`) REFERENCES `time` (`time_id`) ON UPDATE CASCADE,
    PRIMARY KEY(recipe_id)
);

CREATE TABLE ingredient(
    ingredient_id INT AUTO_INCREMENT NOT NULL,
    ingredient_name VARCHAR(50) NOT NULL,
    unit_of_measurement INT(10) UNSIGNED NOT NULL ,
    PRIMARY KEY(ingredient_id)
);

/*
Θέλου,ε το recipe_id να πηγαινει στο πινακα ingredient με μία σχέση many to many 
αφου πολλα υλικα πάνε σε πολλες συνταγές
*/
/*
ΣΧΕΣΗ ΤΩΝ ΟΝΤΟΤΗΤΩΝ: 
ΠΟΙΑ ΚΑΙ ΠΟΣΑ ΥΛΙΚΑ ΠΕΡΙΕΧΟΝΤΑΙ ΣΕ ΠΟΙΕΣ ΣΥΝΤΑΓΕΣ
*/
CREATE TABLE ingedient_VS_recipe(
    recipe_id INT  NOT NULL,
    ingredient_id INT NOT NULL,
    PRIMARY KEY (recipe_id, ingredient_id),
    FOREIGN KEY (recipe_id) REFERENCES recipe(recipe_id),
    FOREIGN KEY (ingredient_id) REFERENCES ingredients(ingredient_id),

    quantity INT NULL CHECK (quantity >= 0),
    unit_of_measurement INT(20) NOT NULL CHECK (unit_of_measurement >= 0),
    calories_per_100ml INT(20) NOT NULL CHECK (calories_per_100ml >= 0), -- Κανονικοποιηση στα 100 ml 
    calories INT(20) NOT NULL CHECK (calories >= 0) ,-- Ανα ποσοτητα που δινεται πχ 1 αυγo

);

CREATE TABLE judges(
   judges_id INT AUTO_INCREMENT NOT NULL,
   first_name VARCHAR(50) NOT NULL,
   last_name VARCHAR(50) NOT NULL,
   PRIMARY KEY(judges_id)
   
);

CREATE TABLE episode(
   episode_id INT AUTO_INCREMENT NOT NULL,
   episode_name VARCHAR(50) NOT NULL,
   episode_date date NOT NULL,
   season INT NOT NULL CHECK (season >= 0),
   --winner VARCHAR(50),
   primary key(episode_id)
);

CREATE TABLE winner(
  episode_id INT NOT NULL,
  cook_id INT NOT NULL,
  evaluation INT NOT NULL CHECK (evaluation >= 0),
  FOREIGN KEY(episode_id) REFERENCES episodes(episode_id),
  FOREIGN KEY(cookID) REFERENCES cook(cook_id),
  PRIMARY KEY(episode_id,cook_id)
);


CREATE TABLE cook(
 cook_id INT(10) unsigned NOT NULL AUTO_INCREMENT,
 first_name VARCHAR(50) NOT NULL,
 last_name VARCHAR(50) NOT NULL,
 birth_date date NOT NULL,
 years_of_experience INT NOT NULL,
 age INT NOT NULL,
 phone_number INT(10) NOT NULL,
 position_level varchar(30) CHECK (position_level IN ('cook A','cook B','cook C','chef assistant','chef')), 
 last_update timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
 PRIMARY KEY(cook_id)
    );

CREATE TABLE cook_expert_in(
 cook_id INT unsigned NOT NULL,
 natcuis_id INT unsigned NOT NULL,
 last_update timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
 FOREIGN KEY(cook_id) REFERENCES cook(cook_id),
 FOREIGN KEY(natcuis_id) REFERENCES national_cuisine(natcuis_id),
 PRIMARY KEY(cook_id,natcuis_id)
    );

CREATE TABLE foodgroups(
 foodgroups_id INT(10) NOT NULL,
foodgroups_name VARCHAR(50) NOT NULL,
description text DEFAULT NULL,
PRIMARY KEY(foodgroups_id)
 
    );











