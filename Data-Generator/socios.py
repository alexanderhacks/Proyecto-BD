import pandas as pd
from IPython.display import display
from collections import defaultdict
import random
select_data = defaultdict(list)

memID = list(pd.read_csv("membresia.csv")["id"])
clID = list(pd.read_csv("clientes.csv")["id"])

n = len(clID)
tuples = random.randint(int(n/10), n-1)         # n primeros clientes son socios

for _ in range(tuples):
    select_data["cliente_id"].append(clID[_])
    select_data["membresia_id"].append(memID[random.randint(0, len(memID)-1)])

df_select_data = pd.DataFrame(select_data)
df_select_data.to_csv('socios.csv', index=False)
display(df_select_data)
