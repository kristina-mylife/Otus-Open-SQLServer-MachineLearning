




     
DECLARE @pscript NVARCHAR(MAX);
SET @pscript = N'
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt

# assign SQL Server dataset to df
df = train_data
df["Age"] = pd.to_numeric(df["Age"])

g = sns.FacetGrid(df, col="Survived")
g.map(plt.hist, "Age", bins=20)
plt.savefig("E://Test//map.png")'
;

--g.map(plt.hist, "Age", bins=20)

--plt.savefig("E://Test//map.png")
 
DECLARE @sqlscript NVARCHAR(MAX);
SET @sqlscript = N'
  SELECT *  --no name no query
  FROM dbo.train;';
 
EXEC sp_execute_external_script
  @language = N'Python',
  @script = @pscript,
  @input_data_1 = @sqlscript,
  @input_data_1_name = N'train_data'; --output column names 