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
