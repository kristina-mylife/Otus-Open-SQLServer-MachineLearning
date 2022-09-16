

EXECUTE sp_execute_external_script @language = N'Python'
    , @script = N'OutputDataSet = InputDataSet'
    , @input_data_1 = N'SELECT 1 AS hello'
WITH RESULT SETS(([hello] INT));
GO

--alter table dbo.train alter column Survived BIT;

EXECUTE sp_execute_external_script @language = N'Python'
    , @script = N'OutputDataSet = InputDataSet'
    , @input_data_1 = N'SELECT 1 AS hello'
WITH RESULT SETS(([hello] INT));
GO


EXECUTE sp_execute_external_script @language = N'Python'
    , @script = N'
a = 1
b = 2
c = a/b
d = a*b
print(c, d)
';


EXEC sp_execute_external_script  @language =N'Python'
    , @script=N'
data = [2,5]
print(data)' 
    , @input_data_1 =N'SELECT PassengerId from dbo.train'
	, @input_data_1_name = N'train_data';
GO


--alter table dbo.train alter column age nvarchar(50);
--ALTER table dbo.train alter column Survived nvarchar(50);


EXEC sp_execute_external_script  @language =N'Python'
    , @script=N'
tt = train_data.groupby(["Sex","Pclass"])
print(tt)
tt.head()'
    , @input_data_1 =N'SELECT * from dbo.train'
	, @input_data_1_name = N'train_data';                          
GO


DECLARE @pscript NVARCHAR(MAX);
SET @pscript = N'
# assign SQL Server dataset to df
df = train_data
 
# return df dataset
res_data = df';
 
DECLARE @sqlscript NVARCHAR(MAX);
SET @sqlscript = N'
  SELECT Sex, Pclass, Name
  FROM dbo.train;';
 
EXEC sp_execute_external_script
  @language = N'Python',
  @script = @pscript,
  @input_data_1 = @sqlscript,
  @input_data_1_name = N'train_data', --input variable name 
  @output_data_1_name = N'res_data' --output variable name
  WITH RESULT SETS(
    (Sex NVARCHAR(50), Pclass  NVARCHAR(50), [Name]  NVARCHAR(100))); --output column names 
GO

DECLARE @pscript NVARCHAR(MAX);
SET @pscript = N'
# assign SQL Server dataset to df
df = train_data
print(df.groupby("Sex").count())
OutputDataSet = df.groupby("Sex").count()';
 
DECLARE @sqlscript NVARCHAR(MAX);
SET @sqlscript = N'
  SELECT Sex, Pclass, Name  --no name no query
  FROM dbo.train
  WHERE Survived = 0;';
 
EXEC sp_execute_external_script
  @language = N'Python',
  @script = @pscript,
  @input_data_1 = @sqlscript,
  @input_data_1_name = N'train_data'
  WITH RESULT SETS(
    (Sex NVARCHAR(50), Total INT)); --output column names 
;



DECLARE @pscript NVARCHAR(MAX);
SET @pscript = N'
# assign SQL Server dataset to df
df = train_data
print(df.groupby(["Sex","Pclass"]).count())
OutputDataSet = df.groupby(["Sex","Pclass"]).count()';
 
DECLARE @sqlscript NVARCHAR(MAX);
SET @sqlscript = N'
  SELECT Sex, Pclass, Name  --no name no query
  FROM dbo.train
  WHERE Survived = 0;';
 
EXEC sp_execute_external_script
  @language = N'Python',
  @script = @pscript,
  @input_data_1 = @sqlscript,
  @input_data_1_name = N'train_data'
  WITH RESULT SETS(
    ( Total INT)); --output column names 
;

--print(df.groupby(["Sex", "Survived"]).count())

DECLARE @pscript NVARCHAR(MAX);
SET @pscript = N'
# assign SQL Server dataset to df
df = train_data

print(df.groupby(["Sex", "Pclass"]).count())

print(df.groupby(["Sex"]).count())

print(df.groupby("Sex", as_index=False).count())
';
 
DECLARE @sqlscript NVARCHAR(MAX);
SET @sqlscript = N'
  SELECT Sex, Pclass, Name  --no name no query
  FROM dbo.train;';
 
EXEC sp_execute_external_script
  @language = N'Python',
  @script = @pscript,
  @input_data_1 = @sqlscript,
  @input_data_1_name = N'train_data'; --output column names 


  
DECLARE @pscript NVARCHAR(MAX);
SET @pscript = N'
import pandas as pd
data = ["one", 2, "three", 4.3456]
ds = pd.Series(data).to_frame()
print(type(ds))
print(ds)


for col in ds.columns:
    print(col)
';
--OutputDataSet = ds
 
DECLARE @sqlscript NVARCHAR(MAX);
SET @sqlscript = N'
  SELECT Sex, Pclass, Name  --no name no query
  FROM dbo.train;';
 
EXEC sp_execute_external_script
  @language = N'Python',
  @script = @pscript,
  @input_data_1 = @sqlscript,
  @input_data_1_name = N'train_data'
--   WITH RESULT SETS(
--    (data NVARCHAR(50))); --output column names 


  
DECLARE @pscript NVARCHAR(MAX);
SET @pscript = N'
import pandas as pd
data = ["one", 2, "three", 4.3456]
ds = pd.Series(data)
print(type(ds))
print(ds)

OutputDataSet = ds.to_frame()
';
 
DECLARE @sqlscript NVARCHAR(MAX);
SET @sqlscript = N'
  SELECT Sex, Pclass, Name  --no name no query
  FROM dbo.train;';
 
EXEC sp_execute_external_script
  @language = N'Python',
  @script = @pscript,
  @input_data_1 = @sqlscript,
  @input_data_1_name = N'train_data'
   WITH RESULT SETS(
    (data NVARCHAR(50))); --output column names 

DECLARE @pscript NVARCHAR(MAX);
SET @pscript = N'
import pandas as pd
data = ["one", 2, "three", 4.3456]
ds = pd.Series(data)
print(type(ds))
print(ds)

ds.describe(include=[''O''])

OutputDataSet = ds.to_frame()
';
 
DECLARE @sqlscript NVARCHAR(MAX);
SET @sqlscript = N'
  SELECT Sex, Pclass, Name  --no name no query
  FROM dbo.train;';
 
EXEC sp_execute_external_script
  @language = N'Python',
  @script = @pscript,
  @input_data_1 = @sqlscript,
  @input_data_1_name = N'train_data'
   WITH RESULT SETS(
    (data NVARCHAR(50))); --output column names 