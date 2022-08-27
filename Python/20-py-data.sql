
DECLARE @pscript NVARCHAR(MAX);
SET @pscript = N'
# assign SQL Server dataset to df
df = train_data

print(df[["Pclass", "Survived"]].groupby(["Pclass"], as_index=False).mean().sort_values(by="Survived", ascending=False))

print(df[["Sex", "Survived"]].groupby(["Sex"], as_index=False).mean().sort_values(by="Survived", ascending=False))

print(df[["SibSp", "Survived"]].groupby(["SibSp"], as_index=False).mean().sort_values(by="Survived", ascending=False))
';
 
DECLARE @sqlscript NVARCHAR(MAX);
SET @sqlscript = N'
  SELECT *  --no name no query
  FROM dbo.train;';
 
EXEC sp_execute_external_script
  @language = N'Python',
  @script = @pscript,
  @input_data_1 = @sqlscript,
  @input_data_1_name = N'train_data'; --output column names 


  
DECLARE @pscript NVARCHAR(MAX);
SET @pscript = N'
# assign SQL Server dataset to df
df = train_data

OutputDataSet = df[["Pclass", "Survived"]].groupby(["Pclass"], as_index=False).mean().sort_values(by="Survived", ascending=False)
';
 
DECLARE @sqlscript NVARCHAR(MAX);
SET @sqlscript = N'
  SELECT *  --no name no query
  FROM dbo.train;';
 
EXEC sp_execute_external_script
  @language = N'Python',
  @script = @pscript,
  @input_data_1 = @sqlscript,
  @input_data_1_name = N'train_data'
  WITH RESULT SETS(
   (Pclass INT, Survived Float)); --output column names 


  
DECLARE @pscript NVARCHAR(MAX);
SET @pscript = N'
# assign SQL Server dataset to df
df = train_data

OutputDataSet = df[["Sex", "Survived"]].groupby(["Sex"], as_index=False).mean().sort_values(by="Survived", ascending=False)
';
 
DECLARE @sqlscript NVARCHAR(MAX);
SET @sqlscript = N'
  SELECT *  --no name no query
  FROM dbo.train;';
 
EXEC sp_execute_external_script
  @language = N'Python',
  @script = @pscript,
  @input_data_1 = @sqlscript,
  @input_data_1_name = N'train_data'
  WITH RESULT SETS(
   (Sex Nvarchar(50), Survived Float)); --output column names 


  
DECLARE @pscript NVARCHAR(MAX);
SET @pscript = N'
# assign SQL Server dataset to df
df = train_data

OutputDataSet = df[["SibSp", "Survived"]].groupby(["SibSp"], as_index=False).mean().sort_values(by="Survived", ascending=False)
';
 
DECLARE @sqlscript NVARCHAR(MAX);
SET @sqlscript = N'
  SELECT *  --no name no query
  FROM dbo.train;';
 
EXEC sp_execute_external_script
  @language = N'Python',
  @script = @pscript,
  @input_data_1 = @sqlscript,
  @input_data_1_name = N'train_data'
  WITH RESULT SETS(
   (SibSp Int, Survived Float)); --output column names 


   


     
DECLARE @pscript NVARCHAR(MAX);
SET @pscript = N'
# assign SQL Server dataset to df
df = train_data

OutputDataSet = df[["Parch", "Survived"]].groupby(["Parch"], as_index=False).mean().sort_values(by="Survived", ascending=False)
';
 
DECLARE @sqlscript NVARCHAR(MAX);
SET @sqlscript = N'
  SELECT *  --no name no query
  FROM dbo.train;';
 
EXEC sp_execute_external_script
  @language = N'Python',
  @script = @pscript,
  @input_data_1 = @sqlscript,
  @input_data_1_name = N'train_data'
  WITH RESULT SETS(
   (Parch Int, Survived Float)); --output column names 
