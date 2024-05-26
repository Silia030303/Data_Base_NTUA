import mysql.connector  # type: ignore
import random

def pick_episode_data(conn):
    cursor1 = conn.cursor()
    cursor2 = conn.cursor()
    cursor3 = conn.cursor()

    cursor1.execute("SELECT natcuis_id FROM national_cuisine")
    results1 = cursor1.fetchall()
    random_national_cuisines_ids = random.sample(results1, 10)

    picked_cooks = set()
    cuisine_cook_map = {}
    cuisine_recipe_map = {}
    natcuis_cook_ids_map = {}

    for national_cuisine_id in random_national_cuisines_ids:
        natcuis_id = national_cuisine_id[0]

        cursor2.execute("SELECT cook_id FROM cook_nat_cuis WHERE natcuis_id = %s", (natcuis_id,))
        results2 = cursor2.fetchall()

        cook_ids = [result[0] for result in results2 if result[0] not in picked_cooks]
        natcuis_cook_ids_map[natcuis_id] = cook_ids

        if cook_ids:
            random_cook_id = random.choice(cook_ids)
            picked_cooks.add(random_cook_id)
            cuisine_cook_map[natcuis_id] = random_cook_id
        else:
            print(f"National Cuisine ID: {natcuis_id} has no available unique cooks")

        cursor3.execute("SELECT recipe_id, recipe_name FROM recipe WHERE natcuis_id = %s", (natcuis_id,))
        results3 = cursor3.fetchall()

        if results3:
            random_recipe_id = random.choice(results3)
            cuisine_recipe_map[natcuis_id] = random_recipe_id
        else:
            print(f"National Cuisine ID: {natcuis_id} has no available recipes")

    cursor1.close()
    cursor2.close()
    cursor3.close()

    return cuisine_cook_map, cuisine_recipe_map

conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="",
    database="project84_DB_2024"
)

max_retries = 1500  # Maximum number of retries
insert_counts = {}  # Dictionary to store the number of successful inserts for each episode_id

for episode_id in range(1, 31):
    insert_counts[episode_id] = 0  # Initialize insert count for each episode_id
    retries = 0
    picked_national_cuisines = set()  # Track picked national cuisines for each episode
    while retries < max_retries and insert_counts[episode_id] < 10:
        try:
            # Pick new data until we have enough unique entries
            cuisine_cook_map, cuisine_recipe_map = pick_episode_data(conn)
            cursor = conn.cursor()
            success = False  # Flag to indicate a successful insert

            for natcuis_id, cook_id in cuisine_cook_map.items():
                if natcuis_id in picked_national_cuisines:
                    continue  # Skip already picked national cuisines

                recipe = cuisine_recipe_map.get(natcuis_id)
                if recipe:
                    recipe_id = recipe[0]

                    insert_query = "INSERT INTO episode_cook_recipe (cook_id, episode_id, recipe_id) VALUES (%s, %s, %s)"
                    try:
                        cursor.execute(insert_query, (cook_id, episode_id, recipe_id))
                        conn.commit()
                        print(f"Inserted: Episode ID: {episode_id}, National Cuisine ID: {natcuis_id}, Cook ID: {cook_id}, Recipe ID: {recipe_id}")
                        insert_counts[episode_id] += 1  # Update insert count for the episode_id
                        picked_national_cuisines.add(natcuis_id)  # Add to picked national cuisines
                        success = True  # Mark the insert as successful
                        if insert_counts[episode_id] >= 10:
                            break  # Exit the inner for-loop if reached 10 inserts
                    except mysql.connector.IntegrityError as e:
                        if e.sqlstate == '45000':  # Custom error code for SIGNAL SQLSTATE
                            print(f"Insert failed for Episode ID {episode_id}: {e.msg}. Retrying...")
                        else:
                            print(f"Insert failed for Episode ID {episode_id}: {e.msg}. Retrying...")
                else:
                    print(f"No recipe found for National Cuisine ID {natcuis_id}")

            cursor.close()
            if success:
                retries = 0  # Reset retries after a successful insert
            else:
                retries += 1  # Only increment retries if no successful insert

        except mysql.connector.Error as err:
            print(f"Error: {err}")
            conn.rollback()
            retries += 1  # Increment retries on error

conn.close()
