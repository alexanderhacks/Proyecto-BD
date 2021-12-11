import pandas as pd
from faker import Faker
from IPython.display import display
from collections import defaultdict
import random
import numpy as np

fake = Faker()
select_data = defaultdict(list)

peliculas = list(pd.read_csv("peliculas.csv")["id"])
tuples = len(peliculas)
actor = list(pd.read_csv("actores.csv")["id"])

for i in range(tuples):
    select_data['pelicula_id'].append(peliculas[random.randint(0, len(peliculas)-1)])
    select_data['actor_id'].append(actor[random.randint(0, len(actor)-1)])


df_select_data = pd.DataFrame(select_data)
df_select_data.drop_duplicates(keep='first', inplace=True)
df_select_data.to_csv('actua.csv', index=False)
display(df_select_data)

