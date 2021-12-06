
import pandas as pd
from IPython.display import display
from collections import defaultdict

genero = open("genero.txt", "r", encoding='utf8').readlines()
select_data = defaultdict(list)
i = 1
for a in genero:
    select_data['id'].append("GP" + "0"*(7 - len(str(i))) + str(i))
    select_data['nombre'].append(genero[i-1][:-1])
    i+=1


df_select_data = pd.DataFrame(select_data)
df_select_data.to_csv('genero.csv', index=False)
display(df_select_data)
