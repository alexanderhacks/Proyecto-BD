import pandas as pd
from IPython.display import display
from collections import defaultdict

select_data = defaultdict(list)
usr = pd.read_csv("usuario.csv")
adm = pd.read_csv("administradores.csv")

usrID = list(usr["id"])
usrUSR = list(usr["usuario"])
admID = list(adm["id"])

for _ in range(len(admID), 0, -1):
    select_data["usuario_id"].append(usrID[-_])
    select_data["administrador_id"].append(admID[-_])

df_select_data = pd.DataFrame(select_data)
df_select_data.to_csv('usuarioAdministrador.csv', index=False)
df_select_data.drop_duplicates(keep='first', inplace=True)
display(df_select_data)
