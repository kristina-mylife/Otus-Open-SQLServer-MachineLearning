
	EXEC sp_execute_external_script  
      @language = N'R'  
     , @script = N'  
 jpeg(''E://Test//barplot_survival_by_sex.jpg'')
 counts <- table(train_data$"Sex", train_data$"Survived")
 barplot(counts, main="Survival by sex",
  xlab="Sex", col=c("darkblue","red"),
  legend = rownames(counts))

dev.off()' 
	, @input_data_1 =N'SELECT * from dbo.train'
	, @input_data_1_name = N'train_data'; 


	

	
	EXEC sp_execute_external_script  
      @language = N'R'  
     , @script = N'  
 jpeg(''E://Test//barplot_survival_by_pclass.jpg'')
 counts <- table(train_data$"Pclass", train_data$"Survived")
 barplot(counts, main="Survival by passenger class",
  xlab="Pclass", col=c("red","darkblue","darkgreen"),
  legend = rownames(counts))

dev.off()' 
	, @input_data_1 =N'SELECT * from dbo.train'
	, @input_data_1_name = N'train_data'; 


	

	EXEC sp_execute_external_script  
      @language = N'R'  
     , @script = N'  
 jpeg(''E://Test//barplot_survival_by_age.jpg'')
 counts <- table(train_data$"Age")
 barplot(counts, main="Survival by age",
  xlab="Survived", col=c("darkblue"),
  legend = rownames(counts))

dev.off()' 
	, @input_data_1 =N'SELECT * from dbo.train WHERE Survived = 1'
	, @input_data_1_name = N'train_data'; 