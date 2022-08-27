USE titanic;
  
  DECLARE @rscript NVARCHAR(MAX),
          @sqlscript NVARCHAR(MAX);

  SET @rscript = N'
    library(e1071);
    # train data from InputDataSet
    train_data <- InputDataSet
    # test from table
    conn <- "Driver={SQL Server};Server=VKS\\MSSQL2019;Database=titanic;Uid=usrdemo;Pwd=usrdemo"
    query <- "SELECT * FROM dbo.test;"
    test_data <- RxSqlServerData(connectionString = conn, sqlQuery = query)
    test_data <- rxDataStep(test_data)

	fit <-naiveBayes(as.factor(Survived) ~ Pclass + Sex + SibSp + Parch,  data=train_data);  
    trained_model <- data.frame(payload = as.raw(serialize(fit, connection=NULL))); 

    pred <- predict(fit, test_data, writeModelVars = TRUE)

	submission <- data.frame(PassengerId = test_data$PassengerId, Survived = pred)
 ';
  
  SET @sqlscript = N'SELECT * FROM dbo.train;';
  
  EXEC sp_execute_external_script
    @language = N'R',
    @script = @rscript,
    @input_data_1 = @sqlscript, 
	@output_data_1_name = N'submission'  
    WITH RESULT SETS ((PassengerId int, Survived BIT));
  GO

