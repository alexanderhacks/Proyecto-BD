import pandas as pd
from IPython.display import display
from collections import defaultdict
from faker import Faker

select_data = defaultdict(list)

col = pd.read_csv("colaboradores.csv")
cli = pd.read_csv("clientes.csv")
adm = pd.read_csv("administradores.csv")

clID = list(col["id"]) + list(cli["id"]) + list(adm["id"])

fake = Faker()
tuples = len(clID)
i = 0

nom = list(col["nombres"])
ap = list(col["apellidos"])
j = 0
for _ in range(len(col["id"])):
    select_data["id"].append("US" + "0" * (7 - len(str(i+1))) + str(i+1))
    select_data["usuario"].append(nom[j] + "." + ap[j])
    select_data["password"].append(fake.password())
    i += 1
    j += 1

nom = list(cli["nombres"])
ap = list(cli["apellidos"])
j = 0
for _ in range(len(cli["id"])):
    select_data["id"].append("US" + "0" * (7 - len(str(i+1))) + str(i+1))
    select_data["usuario"].append(nom[j] + "_" + ap[j])
    select_data["password"].append(fake.password())
    i += 1
    j += 1

j = 0
for _ in range(len(adm["id"])):
    select_data["id"].append("US" + "0" * (7 - len(str(i+1))) + str(i+1))
    select_data["usuario"].append("ADMIN_" + str(j + 1))
    select_data["password"].append(fake.password())
    i += 1
    j += 1

df_select_data = pd.DataFrame(select_data)
df_select_data.to_csv('usuario.csv', index=False)
df_select_data.drop_duplicates(keep='first', inplace=True)
display(df_select_data)

