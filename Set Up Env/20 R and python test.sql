EXEC sp_execute_external_script  @language =N'R'
    , @script=N'OutputDataSet <- InputDataSet;' 
    , @input_data_1 =N'SELECT 1 AS hello'
WITH RESULT SETS (([hello] int not null));
GO

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