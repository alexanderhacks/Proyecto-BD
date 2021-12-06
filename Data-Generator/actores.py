
import pandas as pd
from faker import Faker
from IPython.display import display
from collections import defaultdict

fake = Faker()
select_data = defaultdict(list)

actor_list = open("actores.txt", "r").readlines()
n = 100
tuples = min(n, len(actor_list))

for i in range(tuples):
    select_data['id'].append("ACT" + "0" * (6 - len(str(i + 1))) + str(i + 1))
    select_data['nombre'].append(actor_list[i][:-1])


df_select_data = pd.DataFrame(select_data)
df_select_data.to_csv('actores.csv', index = False)
display(df_select_data)
