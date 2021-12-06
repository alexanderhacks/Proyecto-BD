import glob
import pandas as pd
for file in glob.glob("*.csv"):
    print(file, end=" \t-> ")
    df = pd.read_csv(file)
    print(df.columns.to_list())
