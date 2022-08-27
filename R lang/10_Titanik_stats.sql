EXEC sp_execute_external_script  @language =N'R'
    , @script=N'total_women <- sum(train_data$Sex == ''female''); print(total_women);' 
    , @input_data_1 =N'SELECT * from dbo.train'
	, @input_data_1_name = N'train_data';
GO

EXEC sp_execute_external_script  @language =N'R'
    , @script=N'total_women <- sum(train_data$Sex == ''female''); 
				OutputDataSet <- data.frame(total_women)' 
    , @input_data_1 =N'SELECT * from dbo.train'
	, @input_data_1_name = N'train_data'
	 WITH RESULT SETS ((total_women INT));
GO

EXEC sp_execute_external_script  @language =N'R'
    , @script=N'total_women <- sum(train_data$Sex == ''female''); 
				tt <- data.frame(total_women)' 
    , @input_data_1 =N'SELECT * from dbo.train'
	, @input_data_1_name = N'train_data'
	, @output_data_1_name = N'tt'
	 WITH RESULT SETS ((total_women INT));
GO

EXEC sp_execute_external_script  @language =N'R'
    , @script=N'survived_women <- sum(train_data[which(train_data$Sex == ''female''), "Survived"])' 
    , @input_data_1 =N'SELECT * from dbo.train'
	, @input_data_1_name = N'train_data';
GO

EXEC sp_execute_external_script  @language =N'R'
    , @script=N'total_women <- sum(train_data$Sex == ''female'')
     # Get the total number of women who survived
     survived_women <- sum(train_data[which(train_data$Sex == ''female''), "Survived"])
     rate_women = survived_women/total_women
	 print(total_women)
	 print(survived_women)
	 print(rate_women)' 
    , @input_data_1 =N'SELECT * from dbo.train'
	, @input_data_1_name = N'train_data';
GO

EXEC sp_execute_external_script  @language =N'R'
    , @script=N'# Get the total number of men on the titanic
      total_men <- sum(train_data$Sex == ''male'')
      # Get the total number of women who survived
      survived_men <- sum(train_data[which(train_data$Sex == ''male''), "Survived"])
      rate_men = survived_men/total_men

      paste("% of men who survived:", rate_men * 100)
	  print(total_men)
	  print(survived_men)
	  print(rate_men)' 
    , @input_data_1 =N'SELECT * from dbo.train'
	, @input_data_1_name = N'train_data';
GO

	
	EXEC sp_execute_external_script @language = N'R', @script = N'OutputDataSet <- data.frame(installed.packages())'
    
	EXEC sp_execute_external_script @language = N'R', @script = N'OutputDataSet <- data.frame(packageVersion("e1071"))'


EXEC sp_execute_external_script  
      @language = N'R'  
     , @script = N'  
          library(e1071);  
          fit <-naiveBayes(as.factor(Survived) ~ Pclass + Sex + SibSp + Parch,  data=train_data);  
          trained_model <- data.frame(payload = as.raw(serialize(fit, connection=NULL)));  
'  
     , @input_data_1 = N'SELECT * from dbo.train'  
     , @input_data_1_name = N'train_data'  
     , @output_data_1_name = N'trained_model'  
    WITH RESULT SETS ((model varbinary(max)));
