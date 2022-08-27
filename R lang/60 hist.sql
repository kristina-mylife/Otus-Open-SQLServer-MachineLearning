--alter table dbo.train alter column Age DECIMAL(19,2)

EXEC sp_execute_external_script  
      @language = N'R'  
     , @script = N'  
 jpeg(''E://Test//hist_nonsurvive_age.jpg'')
 hist(train_data$"Age")
 # Save the file.
 dev.off()
' 
	, @input_data_1 =N'SELECT Age from dbo.train WHERE Survived = 0'
	, @input_data_1_name = N'train_data'; 



EXEC sp_execute_external_script  
      @language = N'R'  
     , @script = N'  
 jpeg(''E://Test//hist_survive_age.jpg'')

hist(train_data$"Age",  main = ''Survivors by Age'')

# Save the file.
dev.off()

' 
	, @input_data_1 =N'SELECT * from dbo.train 
	    WHERE Survived = 1 
		  AND Age IS NOT NULL'
	, @input_data_1_name = N'train_data'; 





SELECT COUNT(CAST(Age AS DECIMAL(19,2))) 
FROM dbo.train 
WHERE Survived = 'True' 
  and Age < 20;