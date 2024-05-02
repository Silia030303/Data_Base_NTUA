select r.recipe_name,n.natcuis_name 
from recipe r join national_cuisine n
on r.natcuis_id = n.natcuis_id; 

select c.cook_id,c.first_name, c.last_name, e.grade
from cook c join evaluation e
on c.cook_id = e.cook_id;

SELECT c.first_name, c.last_name, e.grade, e.episode_id, ecr.recipe_id,r.natcuis_id
FROM cook c
JOIN evaluation e ON c.cook_id = e.cook_id
JOIN episode_cook_recipe ecr ON e.cook_id = ecr.cook_id AND e.episode_id = ecr.episode_id
JOIN recipe r on r.recipe_id = ecr.recipe_id
JOIN national_cuisine n on r.natcuis_id = n.natcuis_id;
-------------------------------------------------------------------------QUERY 1--------------------------------------------------------------------- 
SELECT c.cook_id,c.first_name, c.last_name, e.grade, e.episode_id, ecr.recipe_id,r.natcuis_id,n.natcuis_name, avg(*)
FROM cook c
JOIN evaluation e ON c.cook_id = e.cook_id
JOIN episode_cook_recipe ecr ON e.cook_id = ecr.cook_id AND e.episode_id = ecr.episode_id
JOIN recipe r on r.recipe_id = ecr.recipe_id
JOIN national_cuisine n on r.natcuis_id = n.natcuis_id
GROUP BY cook_id,natcuis_id;
---------------------------------------------------------Query 2------------------------------------------------------
SELECT c.first_name,c.last_name
from cook c 
JOIN cook_nat_cuis cn on c.cook_id = cn.cook_id
JOIN national_cuisine nc on cn.natcuis_id = nc.natcuis_id
where nc.natcuis_name = 'Afghan cuisine';

SELECT c.first_name,c.last_name
from cook c 
JOIN episode_cook_recipe cer on c.cook_id = cer.cook_id
JOIN episode e on e.episode_id = cer.episode_id
where year(episode_date)=2024 ;
-------------------------------------------Query 3--------------------------------------------
SELECT 
    c.first_name,
    c.last_name,
    c.age,
    COUNT(ecr.recipe_id) AS total_recipes
FROM 
    cook c
JOIN 
    episode_cook_recipe ecr ON c.cook_id = ecr.cook_id
WHERE 
    c.age < 60
GROUP BY 
    c.cook_id
ORDER BY 
    total_recipes DESC;
--------------------------------------------Query 4 ---------------------------------------
SELECT 
    c.first_name,
    c.last_name
FROM 
    cook c
LEFT JOIN 
    judge j ON c.cook_id = j.cook_id
WHERE 
    j.judge_id IS NULL;
------------------------------------Query 5-----------------------------------


--------------------------------------------Query 6---------------------------------
SELECT t1.tag_name AS tag_name1, t2.tag_name AS tag_name2, COUNT(*) AS pair_count
FROM recipe_tag rt1 
JOIN episode_cook_recipe ecr ON rt1.recipe_id = ecr.recipe_id
JOIN recipe_tag rt2 ON rt1.recipe_id = rt2.recipe_id AND rt1.tag_id < rt2.tag_id
JOIN tags t1 ON rt1.tag_id = t1.tag_id
JOIN tags t2 ON rt2.tag_id = t2.tag_id
GROUP BY rt1.tag_id, rt2.tag_id
ORDER BY pair_count DESC
LIMIT 3;
----------------------------------------Query 7------------------------------------
----------------------------------------Query 8-----------------------------------
SELECT episode_name, COUNT(DISTINCT re.equipment_id) AS equip_count
FROM episode_cook_recipe ecr
JOIN recipe_equipment re ON re.recipe_id = ecr.recipe_id
JOIN episode ep ON ep.episode_id = ecr.episode_id
GROUP BY ecr.episode_id
ORDER BY equip_count DESC
LIMIT 10;
----------------------------------------Query 12-----------------------------------
SELECT episode_name, AVG(difficult_level)
FROM episode_cook_recipe ecr
JOIN episode ep ON ep.episode_id = ecr.episode_id
JOIN recipe re ON re.recipe_id = ecr.recipe_id
GROUP BY ecr.episode_id
ORDER BY difficult_level

