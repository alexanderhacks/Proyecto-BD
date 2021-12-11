import pandas as pd
from IPython.display import display
from collections import defaultdict
import random
import datetime


def rndmDate(start, end):
    time_between_dates = end - start
    days_between_dates = time_between_dates.days
    random_number_of_days = random.randrange(days_between_dates)
    random_date = start + datetime.timedelta(days=random_number_of_days)
    # print(random_date)
    return random_date


select_data = defaultdict(list)
col = pd.read_csv("colaboradores.csv")
colID = list(col["id"])

dL = datetime.date(2020, 1, 1)
dR = datetime.date(2020, 2, 1)

i = 1
for id_ in colID:
    start_date = rndmDate(dL, dR)
    sueldo = random.sample([1200, 1500, 1800, 2200, 2500, 3500, 4700, 600], 1)[0]
    for _ in range(12):  # 1 año de trabajo
        select_data["id"].append("SU" + "0" * (7 - len(str(i))) + str(i))
        select_data["colaborador_id"].append(id_)
        select_data["fecha_inicio"].append(start_date)
        end_date = start_date + datetime.timedelta(days=30)
        select_data["fecha_final"].append(end_date)
        select_data["sueldo"].append(sueldo)
        start_date = end_date + datetime.timedelta(days=1)
        i += 1

df_select_data = pd.DataFrame(select_data)
df_select_data.to_csv('sueldoColaborador.csv', index=False)
df_select_data.drop_duplicates(keep='first', inplace=True)
display(df_select_data)
