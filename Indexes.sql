
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

/*CREATE INDEX idx_natcuis_id ON recipe(natcuis_id);
CREATE INDEX idx_prim_ingredient_id ON recipe(prim_ingredient_id);*/
CREATE INDEX idx_recipe_category ON recipe(recipe_category);
CREATE INDEX idx_difficulty_level ON recipe(difficulty_level);

/*CREATE INDEX idx_natcuis_id ON recipe(recipe_id);*/

-----------------------------------------------------------------------------------------------------------
/*
--2. ΠΙΝΑΚΑΣ episode_cook_recipe

--cook_id: Χρησιμοποιείται σε πολλές συνδέσεις.
--episode_id: Χρησιμοποιείται σε συνδέσεις και για φιλτράρισμα.
--recipe_id: Χρησιμοποιείται για συνδέσεις με τον πίνακα recipe.
-- QUERY 7 : cook_id
-- QUERY 10 :episode_id
-- QUERY 12 :recipe_id, episode_id
-- QUERY 15 :recipe_id

CREATE INDEX idx_cook_id ON episode_cook_recipe(cook_id);
CREATE INDEX idx_episode_id ON episode_cook_recipe(episode_id);
CREATE INDEX idx_recipe_id ON episode_cook_recipe(recipe_id);
*/
-----------------------------------------------------------------------------------------------------------
--3. ΠΙΝΑΚΑΣ evaluation
--cook_id: Χρησιμοποιείται σε συνδέσεις και για φιλτράρισμα.
--judge_id: Χρησιμοποιείται για συνδέσεις.
--episode_id: Χρησιμοποιείται για συνδέσεις και φιλτράρισμα.
-- QUERY 1 :cook_id,episode_id


/*CREATE INDEX idx_eval_cook_id ON evaluation(cook_id);
CREATE INDEX idx_eval_judge_id ON evaluation(judge_id);
CREATE INDEX idx_eval_episode_id ON evaluation(episode_id);*/
-----------------------------------------------------------------------------------------------------------
--4.  ΠΙΝΑΚΑΣ ingredient_VS_recipe
--recipe_id: Χρησιμοποιείται σε συνδέσεις και για φιλτράρισμα.
--ingredient_id: Χρησιμοποιείται σε συνδέσεις.
-- QUERY 15 :recipe_id, ingredient_id 

/*CREATE INDEX idx_ing_vs_rec_recipe_id ON ingredient_VS_recipe(recipe_id);
CREATE INDEX idx_ing_vs_rec_ingredient_id ON ingredient_VS_recipe(ingredient_id);*/
-----------------------------------------------------------------------------------------------------------
--5. ΠΙΝΑΚΑΣ cook
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

/*CREATE INDEX idx_cook_id ON cook(cook_id);*/

-----------------------------------------------------------------------------------------------------------

--6. Πίνακας national_cuisine
--natcuis_name: Χρησιμοποιείται για φιλτράρισμα και ομαδοποίηση.
--QUERY 1 :natcuis_id,natcuis_name, 
--QUERY 2 :natcuis_name , where nc.natcuis_name 

CREATE INDEX idx_natcuis_name ON national_cuisine(natcuis_name);
-----------------------------------------------------------------------------------------------------------

--7. Πίνακας tags
--tag_name: Χρησιμοποιείται για φιλτράρισμα και συνδέσεις με τον πίνακα recipe_tag.
--QUERY 6:SELECT t1.tag_name...,tag_id

CREATE INDEX idx_tag_name ON tags(tag_name);

/*CREATE INDEX idx_tag_id ON tags(tag_id);*/

-----------------------------------------------------------------------------------------------------------
--8. Πίνακας recipe_tag
--recipe_id: Χρησιμοποιείται σε συνδέσεις και για φιλτράρισμα.
--tag_id: Χρησιμοποιείται σε συνδέσεις.
/*
CREATE INDEX idx_recipe_tag_recipe_id ON recipe_tag(recipe_id);
CREATE INDEX idx_recipe_tag_tag_id ON recipe_tag(tag_id);*/
-----------------------------------------------------------------------------------------------------------
--9. Πίνακας recipe_equipment
--recipe_id: Χρησιμοποιείται σε συνδέσεις και για φιλτράρισμα.
--equipment_id: Χρησιμοποιείται σε συνδέσεις.
--QUERY 8 :DISTINCT re.equipment_id
/*
CREATE INDEX idx_recipe_equipment_recipe_id ON recipe_equipment(recipe_id);
CREATE INDEX idx_recipe_equipment_equipment_id ON recipe_equipment(equipment_id);*/
-----------------------------------------------------------------------------------------------------------
--10. Πίνακας cook_nat_cuis
--cook_id: Χρησιμοποιείται σε συνδέσεις και για φιλτράρισμα.
--natcuis_id: Χρησιμοποιείται σε συνδέσεις.
--QUERY 2 :cook_id,
/*
CREATE INDEX idx_cook_nat_cuis_cook_id ON cook_nat_cuis(cook_id);
CREATE INDEX idx_cook_nat_cuis_natcuis_id ON cook_nat_cuis(natcuis_id);*/

-----------------------------------------------------------------------------------------------------------
--11. Πίνακας episode 
--season:Χρησιμοποιείται σε συνδέσεις και για φιλτράρισμα.
--QUERY 2 :season, where e.season = 2
--QUERY 5 :episode_id 
--QUERY 8 :SELECT episode_name
--QUERY 10 : SELECT .. e2.season ,episode_id
--QUERY 12 :episode_id ,SELECT episode_name

CREATE INDEX idx_episode_season ON episode(season);
CREATE INDEX idx_episode_episode_name ON episode(episode_name);
-----------------------------------------------------------------------------------------------------------

--12. Πίνακας judge
--judge_id:Χρησιμοποιείται σε συνδέσεις και για φιλτράρισμα.
--episode_id:Χρησιμοποιείται σε συνδέσεις και για φιλτράρισμα.
--QUERΥ 4 : WHERE j.judge_id IS NUL
--QUERΥ 5 : episode_id
/*
CREATE INDEX idx_judge_judge_id ON judge(judge_id);
CREATE INDEX idx_judge_episode_id ON judge(episode_id);*/
-----------------------------------------------------------------------------------------------------------
--13. Πίνακας foodgroups
--foodgroups_id:Χρησιμοποιείται σε συνδέσεις και για φιλτράρισμα.
--foodgroups_name:Χρησιμοποιείται σε συνδέσεις και για φιλτράρισμα.
--QUERΥ 15 : foodgroups_id, SELECT fg.foodgroups_name ,WHERE fg.foodgroups_id  IS NULL


/*CREATE INDEX idx_judge_foodgroups_id ON foodgroups(foodgroups_id);*/
CREATE INDEX idx_judge_foodgroups_name ON foodgroups(foodgroups_name);


