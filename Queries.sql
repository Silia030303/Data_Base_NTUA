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



--Panos
SELECT c.last_name, AVG(e.grade) as aver_grade
FROM cook c
JOIN evaluation e ON c.cook_id = e.cook_id
JOIN episode_cook_recipe ecr ON e.cook_id = ecr.cook_id AND e.episode_id = ecr.episode_id
JOIN recipe r ON r.recipe_id = ecr.recipe_id
JOIN national_cuisine n ON r.natcuis_id = n.natcuis_id 
GROUP BY c.cook_id
ORDER BY aver_grade;


SELECT n.natcuis_name,  AVG(e.grade) as aver_grade
FROM cook c
JOIN evaluation e ON c.cook_id = e.cook_id
JOIN episode_cook_recipe ecr ON e.cook_id = ecr.cook_id AND e.episode_id = ecr.episode_id
JOIN recipe r ON r.recipe_id = ecr.recipe_id
JOIN national_cuisine n ON r.natcuis_id = n.natcuis_id
GROUP BY n.natcuis_id   
ORDER BY aver_grade;
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
SELECT  c.first_name, c.last_name, e.season, count(e.episode_id) as part_count
FROM cook c
JOIN judge j on j.cook_id = c.cook_id
JOIN episode e on e.episode_id = j.episode_id
GROUP BY j.cook_id,e.season
HAVING part_count>3
ORDER BY part_count;

SELECT  c.first_name, c.last_name, e.season, count(e.episode_id) as part_count
FROM cook c
JOIN judge j on j.cook_id = c.cook_id
JOIN episode e on e.episode_id = j.episode_id
GROUP BY j.cook_id,e.season
ORDER BY part_count;

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
SELECT c.cook_id, c.first_name, c.last_name, COUNT(ecr.episode_id) AS participation
FROM cook c
JOIN episode_cook_recipe ecr ON c.cook_id = ecr.cook_id
GROUP BY c.cook_id, c.first_name, c.last_name
HAVING COUNT(ecr.episode_id) <= (
    SELECT MAX(participation_count) - 5
    FROM (
        SELECT c.cook_id, COUNT(ecr.episode_id) AS participation_count
        FROM cook c
        JOIN episode_cook_recipe ecr ON c.cook_id = ecr.cook_id
        GROUP BY c.cook_id
    ) AS table1
);
----------------------------------------Query 8-----------------------------------
SELECT episode_name, COUNT(DISTINCT re.equipment_id) AS equip_count
FROM episode_cook_recipe ecr
JOIN recipe_equipment re ON re.recipe_id = ecr.recipe_id
JOIN episode ep ON ep.episode_id = ecr.episode_id
GROUP BY ecr.episode_id
ORDER BY equip_count DESC
LIMIT 10;

----------------------------------------Query 10-----------------------------------
SELECT table1.natcuis_name, table1.season as name_of_season_of_participation_table1, table2.season as name_of_season_of_participation_table2, 
table1.cuis_count1, table2.cuis_count2,(table1.cuis_count1 + table2.cuis_count2) AS total_count
FROM 
    (SELECT nc.natcuis_name, e.season, r.natcuis_id, count(ecr.episode_id) as cuis_count1
     FROM national_cuisine nc
     JOIN recipe r ON r.natcuis_id = nc.natcuis_id
     JOIN episode_cook_recipe ecr ON r.recipe_id = ecr.recipe_id
     JOIN episode e ON e.episode_id = ecr.episode_id
     GROUP BY nc.natcuis_id,e.season
     HAVING cuis_count1 >= 3) AS table1
JOIN 
    (SELECT nc2.natcuis_name, e2.season, r2.natcuis_id, count(ecr2.episode_id) as cuis_count2
     FROM national_cuisine nc2
     JOIN recipe r2 ON r2.natcuis_id = nc2.natcuis_id
     JOIN episode_cook_recipe ecr2 ON r2.recipe_id = ecr2.recipe_id
     JOIN episode e2 ON e2.episode_id = ecr2.episode_id
     GROUP BY nc2.natcuis_id,e2.season
     HAVING cuis_count2 >= 3) AS table2
ON table1.natcuis_id = table2.natcuis_id
WHERE ABS(table1.season - table2.season) =1  and table1.season< table2.season
ORDER BY total_count DESC ;
----------------------------------------Query 12-----------------------------------
SELECT season, AVG(avg_dif) AS avg_difficulty
FROM (
    SELECT season, episode_name, AVG(difficulty_level) AS avg_dif
    FROM episode_cook_recipe ecr
    JOIN episode ep ON ep.episode_id = ecr.episode_id
    JOIN recipe re ON re.recipe_id = ecr.recipe_id
    GROUP BY ecr.episode_id
) AS avg_diff_per_episode
GROUP BY season;
-------------------------------------Query 14-------------------------------------
select ts.name as thematic_section_name ,COUNT(ts.them_sec_id) as appearance_count
from episode_cook_recipe ecr
join recipe r on ecr.recipe_id = r.recipe_id
join recipe_thematic_section rts on r.recipe_id = rts.recipe_id
join thematic_section ts on rts.them_sec_id = ts.them_sec_id
group by ts.them_sec_id
order by appearance_count DESC
LIMIT 1;
-------------------------------------Query 15-------------------------------------
SELECT fg.foodgroups_name 
FROM ingedient_VS_recipe ir
JOIN ingredient i ON i.ingredient_id = ir.ingredient_id
JOIN episode_cook_recipe ecr ON ecr.ingredient_id= ir.ingredient_id
LEFT JOIN foodgroups fg ON fg.foodgroups_id = i.foodgroups_id
WHERE 
   fg.foodgroups_id  IS NULL;

