import pandas as pd
from IPython.display import display
from collections import defaultdict

select_data = defaultdict(list)

col = pd.read_csv("colaboradores.csv")
cli = pd.read_csv("clientes.csv")
bank = pd.read_csv("cuentaBancaria.csv")
usr = pd.read_csv("usuario.csv")

i = len(list(col["id"]))
print(i)

nCuenta = list(bank["numero_cuenta"])
cliID = list(bank["cliente_id"])
usrID = list(usr["id"])
clTel = list(cli["celular"])

j = 0
while j < len(nCuenta):
    select_data["usuario_id"].append(usrID[i])
    select_data["cliente_id"].append(cliID[j])
    select_data["telefono"].append(clTel[j])
    select_data["numero_cuenta"].append(nCuenta[j])
    j += 1
    i += 1

df_select_data = pd.DataFrame(select_data)
df_select_data.to_csv('usuarioCliente.csv', index=False)
df_select_data.drop_duplicates(keep='first', inplace=True)
display(df_select_data)

