import pandas as pd
from faker import Faker
from IPython.display import display
from collections import defaultdict
import random
import numpy as np
import datetime


def rndmDate(start, end):
    time_between_dates = end - start
    days_between_dates = time_between_dates.days
    random_number_of_days = random.randrange(days_between_dates)
    random_date = start + datetime.timedelta(days=random_number_of_days)
    return random_date


fake = Faker()
select_data = defaultdict(list)
vID = list(pd.read_csv("venta.csv")["id"])
tuples = 100

for _ in range(tuples):
    select_data["id"].append("EN" + "0" * (7 - len(str(_ + 1))) + str(_ + 1))
    select_data["venta_id"].append(vID[random.randint(0, len(vID)-1)])


df_select_data = pd.DataFrame(select_data)
df_select_data.to_csv('ventaEntrada.csv', index=False)
df_select_data.drop_duplicates(keep='first', inplace=True)
display(df_select_data)

