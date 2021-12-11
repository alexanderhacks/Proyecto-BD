import pandas as pd
from IPython.display import display
from collections import defaultdict
import numpy as np
import random

select_data = defaultdict(list)
funcionCSV = list(pd.read_csv("funcion.csv")["funcion_id"])
tuples = 100
for _ in range(tuples):
    select_data["funcion_id"].append(funcionCSV[random.randint(0, len(funcionCSV)-1)])


df_select_data = pd.DataFrame(select_data)
df_select_data.drop_duplicates(keep='first', inplace=True)
df_select_data.to_csv('funcionVacuna.csv', index=False)
display(df_select_data)
