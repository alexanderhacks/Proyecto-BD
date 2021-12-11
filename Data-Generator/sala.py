import pandas as pd
from faker import Faker
from IPython.display import display
from collections import defaultdict
import random
import numpy as np

fake = Faker()
select_data = defaultdict(list)

SEDE_ = pd.read_csv("sede.csv")

sede = list(SEDE_["id"])
i = 0
j = 0
for num in list(SEDE_["n_salas"]):
    for _ in range(num):
        select_data['id'].append("SL" + "0" * (7 - len(str(i + 1))) + str(i + 1))
        select_data['sede_id'].append(sede[j])
        select_data['n_butacas'].append(random.choice([20, 30, 35, 50, 45]))
        i += 1
    j += 1

df_select_data = pd.DataFrame(select_data)
df_select_data.drop_duplicates(keep='first', inplace=True)
df_select_data.to_csv('sala.csv', index=False)
display(df_select_data)

"""
    TRIGGER / CHECK POSIBLE 
    -> VERIFICAR que el numero de tuplas en salas de una sede
    -> concuerde con el at. n_salas de Sede
"""

"""
for idd in sede:
    print(idd, end=" ")
print()
for n in list(SEDE_["n_salas"]):
    print(n, end=" ")
"""
