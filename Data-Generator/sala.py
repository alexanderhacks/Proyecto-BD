import pandas as pd
from faker import Faker
from IPython.display import display
from collections import defaultdict
import random
import numpy as np

fake = Faker()
select_data = defaultdict(list)

sede = list(pd.read_csv("sede.csv")["id"])
tuples = len(sede)

for i in range(tuples):
    select_data['id'].append("SL" + "0"*(7 - len(str(i+1))) + str(i+1))
    select_data['sede_id'].append(sede[i])
    select_data['numero_salas'].append(random.randint(1, 4))
    select_data['n_butacas'].append(random.choice([20, 30, 35, 50, 45]))


for i in range(tuples):
    select_data['id'].append("SL" + "0"*(7 - len(str(i+1+tuples))) + str(i+1+tuples))
    select_data['sede_id'].append(sede[random.randint(0, len(sede)-1)])
    select_data['numero_salas'].append(random.randint(1, 4))
    select_data['n_butacas'].append(random.choice([20, 30, 35, 50, 45]))


df_select_data = pd.DataFrame(select_data)
df_select_data.to_csv('sala.csv', index=False)
display(df_select_data)
