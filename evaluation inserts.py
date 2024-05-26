# evaluation inserts

import mysql.connector # type: ignore
import random

conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="",
    database="project84_DB_2024"
)

cursor1 = conn.cursor() # for cook and judge ids
cursor2 = conn.cursor() # for inserts in evaluation

cursor1.execute("SELECT j.judge_id, ecr.cook_id FROM judge j JOIN episode_cook_recipe ecr ON j.episode_id = ecr.episode_id")
results1 = cursor1.fetchall()

# Insert into evaluation table
for judge_id, cook_id in results1:
    grade = random.randint(1, 5)
    cursor2.execute("INSERT INTO evaluation (cook_id, judge_id, grade) VALUES (%s, %s, %s)", (cook_id, judge_id, grade))

# Commit the transaction
conn.commit()

cursor1.close()
cursor2.close()
conn.close()
