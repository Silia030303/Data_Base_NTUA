# judges

import mysql.connector # type: ignore
import random

def pick_judge(conn, episode_id):

    cursor1 = conn.cursor() # for cooks in episodes
    cursor2 = conn.cursor() # for all cooks

    cursor1.execute("SELECT cook_id FROM episode_cook_recipe WHERE episode_id = %s", (episode_id,))
    existing_cook_ids = {row[0] for row in cursor1.fetchall()}


    cursor2.execute("SELECT cook_id FROM cook")
    results2 = cursor2.fetchall() 

    available_cook_ids = [result[0] for result in results2 if result[0] not in existing_cook_ids]

    judge_ids = random.sample(available_cook_ids, 3)

    
    cursor1.close()
    cursor2.close()

    return judge_ids


conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="",
    database="project84_DB_2024"
)

max_retries = 15  # Maximum number of retries
insert_counts = {}  # Dictionary to store the number of successful inserts for each episode_id

for episode_id in range(1, 31):
    insert_counts[episode_id] = 0  # Initialize insert count for each episode_id
    retries = 0
    while retries < max_retries and insert_counts[episode_id] < 3:
        try:
            judge_ids = pick_judge(conn , episode_id)
            cursor = conn.cursor()
            success = False  # Flag to indicate a successful insert

            for judge_id in judge_ids :
                insert_query = "INSERT INTO judge (cook_id, episode_id) VALUES (%s, %s)"
                try: 
                    cursor.execute(insert_query, (judge_id, episode_id))
                    conn.commit()
                    print(f"Inserted: Episode ID: {episode_id}, Cook ID: {judge_id}")
                    insert_counts[episode_id] += 1  # Update insert count for the episode_id
                    success = True  # Mark the insert as successful
                    if insert_counts[episode_id] >= 3:
                        break  # Exit the inner for-loop if reached 10 inserts

                except mysql.connector.IntegrityError as e:
                    if e.sqlstate == '45000':  # Custom error code for SIGNAL SQLSTATE
                        print(f"Insert failed for Episode ID {episode_id}: {e.msg}. Retrying...")
                        # Retry by calling pick_episode_data again
                        judge_ids = pick_judge(conn ,episode_id)
                        break  # Exit the inner for-loop to retry with new data
                    else:
                        print(f"Insert failed for Episode ID {episode_id}: {e.msg}. Retrying...")
                        # If there's a duplicate entry, pick new random national cuisine, cook, and recipe
                        judge_ids = pick_judge(conn ,episode_id)
                        break  # Exit the inner for-loop to retry with new data
                else:
                    print(f"No judge found for episode id : {episode_id}")

            cursor.close()
            if success:
                break  # Exit the while-loop if an insert was successful

        except mysql.connector.Error as err:
            print(f"Error: {err}")
            conn.rollback()
        finally:
            retries += 1

conn.close()
