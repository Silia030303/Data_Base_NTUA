
--Αν το ερώτημα εκτελείται αργά, μπορείτε να εξετάσετε την ανάλυση του σχεδίου εκτέλεσης του query 
--(query execution plan) με την εντολή EXPLAIN, ώστε να δείτε αν τα ευρετήρια χρησιμοποιούνται όπως 
--αναμένεται:
-----------------------------------------------------------------------------------------------------------
-- 1. ΠΙΝΑΚΑΣ recipe

--natcuis_id: Χρησιμοποιείται συχνά σε συνδέσεις (joins) και φιλτράρισμα.
--prim_ingredient_id: Χρησιμοποιείται για συνδέσεις με τον πίνακα ingredient.
--recipe_category: Χρησιμοποιείται σε ερωτήματα που φιλτράρουν ανά κατηγορία.
--difficulty_level: Χρησιμοποιείται σε ερωτήματα που φιλτράρουν ή υπολογίζουν μέσες δυσκολίες.
-- QUERY 1 :recipe_id,natcuis_id
-- QUERY 10 :recipe_id, natcuis_id
-- QUERY 12 :recipe_id


CREATE INDEX idx_recipe_category ON recipe(recipe_category);
CREATE INDEX idx_difficulty_level ON recipe(difficulty_level);


-----------------------------------------------------------------------------------------------------------
--2. ΠΙΝΑΚΑΣ cook
--last_name: Χρησιμοποιείται για φιλτράρισμα και ομαδοποίηση.
-- QUERY 1 :cook_id,last_name
-- QUERY 2 :cook_id,
-- QUERY 3 : WHERE  c.age < 60 , GROUP BY c.cook_id
-- QUERY 4 : cook_id,SELECT c.first_name, c.last_name
-- QUERY 5 : SELECT c.first_name, c.last_name   
-- QUERY 7 : SELECT c.cook_id, c.first_name, c.last_name,

CREATE INDEX idx_cook_last_name ON cook(first_name);

CREATE INDEX idx_cook_first_name ON cook(last_name);
CREATE INDEX idx_cook_age ON cook(age);


-----------------------------------------------------------------------------------------------------------

--3. Πίνακας national_cuisine
--natcuis_name: Χρησιμοποιείται για φιλτράρισμα και ομαδοποίηση.
--QUERY 1 :natcuis_name, 
--QUERY 2 :natcuis_name , where nc.natcuis_name 

CREATE INDEX idx_natcuis_name ON national_cuisine(natcuis_name);
-----------------------------------------------------------------------------------------------------------

--4. Πίνακας tags
--tag_name: Χρησιμοποιείται για φιλτράρισμα και συνδέσεις με τον πίνακα recipe_tag.
--QUERY 6:SELECT t1.tag_name...,tag_id

CREATE INDEX idx_tag_name ON tags(tag_name);




-----------------------------------------------------------------------------------------------------------
--5. Πίνακας episode 
--season:Χρησιμοποιείται σε συνδέσεις και για φιλτράρισμα.
--QUERY 2 :season, where e.season = 2
--QUERY 5 :episode_id 
--QUERY 8 :SELECT episode_name
--QUERY 10 : SELECT .. e2.season ,episode_id
--QUERY 12 :episode_id ,SELECT episode_name

CREATE INDEX idx_episode_season ON episode(season);
CREATE INDEX idx_episode_episode_name ON episode(episode_name);
-----------------------------------------------------------------------------------------------------------

--6. Πίνακας foodgroups
--foodgroups_name:Χρησιμοποιείται σε συνδέσεις και για φιλτράρισμα.
--QUERΥ 15 : foodgroups_id, SELECT fg.foodgroups_name ,WHERE fg.foodgroups_id  IS NULL


CREATE INDEX idx_judge_foodgroups_name ON foodgroups(foodgroups_name);


