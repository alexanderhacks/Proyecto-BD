import pandas as pd
from IPython.display import display
from collections import defaultdict
import random
select_data = defaultdict(list)


tuples = len(list(pd.read_csv("sede.csv")["id"]))//2
cID = list(pd.read_csv("colaboradores.csv")["id"])

nPermiso = ["superusuario", "megausuario"]
for _ in range(tuples):
    select_data["id"].append(cID[_])
    select_data["nivel_permiso"].append(random.sample(nPermiso, 1)[0])

df_select_data = pd.DataFrame(select_data)
df_select_data.to_csv('administradores.csv', index=False)
display(df_select_data)
