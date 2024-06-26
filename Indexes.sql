
--Αν το ερώτημα εκτελείται αργά, μπορείτε να εξετάσετε την ανάλυση του σχεδίου εκτέλεσης του query 
--(query execution plan) με την εντολή EXPLAIN, ώστε να δείτε αν τα ευρετήρια χρησιμοποιούνται όπως 
--αναμένεται:
-----------------------------------------------------------------------------------------------------------
-- 1. ΠΙΝΑΚΑΣ recipe

-- QUERY 12 :difficulty_level

CREATE INDEX idx_recipe_category ON recipe(recipe_category);
CREATE INDEX idx_difficulty_level ON recipe(difficulty_level);


-----------------------------------------------------------------------------------------------------------
--2. ΠΙΝΑΚΑΣ cook
-- QUERY 1 : SELECT c.first_name, c.last_name
-- QUERY 2 : SELECT c.first_name, c.last_name
-- QUERY 3 : SELECT c.first_name, c.last_name, WHERE  c.age < 30 , 
-- QUERY 4 : SELECT c.first_name, c.last_name
-- QUERY 5 : SELECT c.first_name, c.last_name   
-- QUERY 7 : SELECT c.first_name, c.last_name,
--Query 11 : SELECT c.last_name

CREATE INDEX idx_cook_last_name ON cook(first_name);

CREATE INDEX idx_cook_first_name ON cook(last_name);
CREATE INDEX idx_cook_age ON cook(age);


-----------------------------------------------------------------------------------------------------------

--3. Πίνακας national_cuisine
--QUERY 1 :SELECT natcuis_name, 
--QUERY 2 :SELECT natcuis_name , where nc.natcuis_name 
--QUERY 10:SELECT natcuis_name

CREATE INDEX idx_natcuis_name ON national_cuisine(natcuis_name);
-----------------------------------------------------------------------------------------------------------

--4. Πίνακας tags
--QUERY 6:SELECT t1.tag_name

CREATE INDEX idx_tag_name ON tags(tag_name);




-----------------------------------------------------------------------------------------------------------
--5. Πίνακας episode 
--QUERY 2 :season, where e.season = 2
--QUERY 5 :season, 
--QUERY 8 :SELECT episode_name
--QUERY 9: season
--QUERY 10 : SELECT e2.season 
--QUERY 12 : season ,SELECT episode_name
--QUERY 13 :SELECT episode_name

CREATE INDEX idx_episode_season ON episode(season);
CREATE INDEX idx_episode_episode_name ON episode(episode_name);
-----------------------------------------------------------------------------------------------------------

--6. Πίνακας foodgroups
--QUERΥ 15 : SELECT fg.foodgroups_name ,WHERE fg.foodgroups_id  IS NULL


CREATE INDEX idx_judge_foodgroups_name ON foodgroups(foodgroups_name);


