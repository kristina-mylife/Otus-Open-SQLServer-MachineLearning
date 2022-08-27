EXEC sp_execute_external_script  
      @language = N'R'  
     , @script = N'  
 par(mfrow=c(1,2))
slices<-table(train_data$Pclass)
labels <- c("1st class", "2nd class", "3rd class")

# Give the chart file a name.
png(file = "E://Test//pie_class_died.png")

# Plot the chart.
pie(slices,labels,main = "Pie Chart of Deathsh")

# Save the file.
dev.off()

' 
	, @input_data_1 =N'SELECT * from dbo.train WHERE Survived = 0
	   and Pclass is not null
	   and Pclass != '''''
	, @input_data_1_name = N'train_data'; 


EXEC sp_execute_external_script  
      @language = N'R'  
     , @script = N'  
 par(mfrow=c(1,2))
slices<-table(train_data$Pclass)
labels <- c("1st class", "2nd class", "3rd class")

# Give the chart file a name.
png(file = "E://Test//pie_class_survivor.png")

# Plot the chart.
pie(slices,labels,main = "Pie Chart of Survivors")

# Save the file.
dev.off()

' 
	, @input_data_1 =N'SELECT * from dbo.train WHERE Survived = 1
	   and Pclass is not null
	   and Pclass != '''''
	, @input_data_1_name = N'train_data'; 




EXEC sp_execute_external_script  
      @language = N'R'  
     , @script = N'  
 par(mfrow=c(1,2))
slices<-table(train_data$Pclass)
labels <- c("1st class", "2nd class", "3rd class")

# Give the chart file a name.
png(file = "E://Test//pie_class_all.png")

# Plot the chart.
pie(slices,labels,main = "Pie Chart of All")

# Save the file.
dev.off()

' 
	, @input_data_1 =N'SELECT * from dbo.train WHERE Pclass is not null
	   and Pclass != '''''
	, @input_data_1_name = N'train_data'; 

