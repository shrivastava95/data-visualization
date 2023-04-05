import pandas as pd
import numpy as np
import seaborn as sns
import matplotlib.pyplot as plt

url = "UCIAdult_dataset/adult.data"
names = ["age", "workclass", "fnlwgt", "education", "education-num", "marital-status",
         "occupation", "relationship", "race", "sex", "capital-gain", "capital-loss",
         "hours-per-week", "native-country", "income"]
df = pd.read_csv(url, header=None, names=names)
df.drop_duplicates(inplace=True)
print(df.head())

# sns.pairplot(data=df, vars=["age", "fnlwgt", "education-num", "capital-gain", "capital-loss", "hours-per-week"], hue="income")
# plt.show()


categorical_cols = ["workclass", "education", "marital-status", "occupation", "relationship", "race", "sex", "native-country"]
for col in categorical_cols:
    plt.figure(figsize=(12, 6))
    sns.countplot(x=col, data=df, hue="income")
    plt.xticks(rotation=90)
    plt.show()