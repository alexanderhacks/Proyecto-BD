import pandas as pd
from IPython.display import display
from collections import defaultdict
import random

select_data = defaultdict(list)

col = pd.read_csv("colaboradores.csv")
tcID = list(pd.read_csv("tipoColaborador.csv")["id"])
usrID = list(pd.read_csv("usuario.csv")["id"])
colID = col["id"]

for _ in range(len(colID)):
    select_data["id"].append("UC" + "0" * (7 - len(str(_+1))) + str(_+1))
    select_data["colaborador_id"].append(colID[_])
    select_data["usuario_id"].append(usrID[_])
    select_data["tipocolaborador_id"].append(tcID[random.randint(0, len(tcID)-1)])

df_select_data = pd.DataFrame(select_data)
df_select_data.to_csv('usuarioColaborador.csv', index=False)
df_select_data.drop_duplicates(keep='first', inplace=True)
display(df_select_data)

