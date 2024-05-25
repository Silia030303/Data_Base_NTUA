import mysql.connector
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

max_retries = 5  # Maximum number of retries

for episode_id in range(1, 31):
    retries = 0
    while retries < max_retries:
        try:
            cuisine_cook_map, cuisine_recipe_map = pick_episode_data(conn)

            cursor = conn.cursor()

            for natcuis_id, cook_id in cuisine_cook_map.items():
                recipe = cuisine_recipe_map.get(natcuis_id)
                if recipe:
                    recipe_id = recipe[0]

                    insert_query = "INSERT INTO episode_cook_recipe (cook_id, episode_id, recipe_id) VALUES (%s, %s, %s)"
                    try:
                        cursor.execute(insert_query, (cook_id, episode_id, recipe_id))
                        conn.commit()
                        print(f"Inserted: Episode ID: {episode_id}, National Cuisine ID: {natcuis_id}, Cook ID: {cook_id}, Recipe ID: {recipe_id}")
                    except mysql.connector.IntegrityError as e:
                        print(f"Insert failed for Episode ID {episode_id}: {e.msg}. Retrying...")
                        # If there's a duplicate entry, pick new random national cuisine, cook, and recipe
                        cuisine_cook_map, cuisine_recipe_map = pick_episode_data(conn)
                        break
                else:
                    print(f"No recipe found for National Cuisine ID {natcuis_id}")

            cursor.close()
            break  # Exit the while loop if insert is successful

        except mysql.connector.Error as err:
            print(f"Error: {err}")
            conn.rollback()
        finally:
            retries += 1

conn.close()
