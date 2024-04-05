create database masterchef;
use masterchef;


CREATE TABLE equipment(
    equipment_id INT(20) NOT NULL, 
    equipmentName VARCHAR(50) NOT NULL ,
    instructions VARCHAR(50) ,
    PRIMARY KEY(equipment_id)
);

CREATE TABLE meal(
    meal_id INT(20) NOT NULL,
    mealName VARCHAR(50) NOT NULL,
    mealCalories INT(10) NOT NULL,
    mealType VARCHAR(50) NOT NULL,
    PRIMARY KEY(meal_id)
);

CREATE TABLE recipe(
    recipe_id INT(20) NOT NULL,
    recipeName VARCHAR(50) NOT NULL,
    recipeCategory VARCHAR(20) NOT NULL,
    CONSTRAINT Check_YourColumn CHECK (recipeCategory IN ('Μαγειρικής', 'Ζαχαροπλαστικής')) ,
    nationalCuisine VARCHAR (50) ,
    recipeDescription VARCHAR(1000) ,
    primaryIngredient VARCHAR(50),
    PRIMARY KEY(recipe_id)
);

CREATE TABLE ingredient(
    ingredient_id INT(20) NOT NULL,
    ingredientName VARCHAR(50) NOT NULL,
    unitOfMeasurement INT(20) NOT NULL,
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
    recipe_id INT(20) NOT NULL,
    ingredient_id INT(20) NOT NULL,
    PRIMARY KEY (recipe_id, ingredient_id),
    FOREIGN KEY (recipe_id) REFERENCES recipe(recipe_id),
    FOREIGN KEY (ingredient_id) REFERENCES ingredients(ingredient_id),

    quantity INT(20) NULL,
    unitOfMeasurement INT(20) NOT NULL,
    caloriesPer100ml INT(20) NOT NULL, -- Κανονικοποιηση στα 100 ml 
    calories INT(20) NOT NULL ,-- Ανα ποσοτητα που δινεται πχ 1 αυγo

)









