DECLARE @pscript NVARCHAR(MAX);
SET @pscript = N'
# import matplotlib modules
import matplotlib
matplotlib.use("PDF")
import matplotlib.pyplot as plt

print(InputDataSet)
InputDataSet.head()

# define df data frame
df = InputDataSet.groupby("Pclass").sum()
 
print(df)
df.head()

# create bar chart object
pt = df.plot.barh()
 
# save bar chart to PDF file
plt.savefig("E://PythonVisual//barchart.pdf", 
  bbox_inches="tight", pad_inches=.5)';
 
DECLARE @sqlscript NVARCHAR(MAX);
SET @sqlscript = N'
  SELECT Pclass, CAST(Fare AS Float) AS Fare
  FROM dbo.train;';
 
EXEC sp_execute_external_script
  @language = N'Python',
  @script = @pscript,
  @input_data_1 = @sqlscript;
GO

--с форматированием
DECLARE @pscript NVARCHAR(MAX);
SET @pscript = N'
# import matplotlib modules
import matplotlib
matplotlib.use("PDF")
import matplotlib.pyplot as plt

print(InputDataSet)
InputDataSet.head()

# define df data frame
df = InputDataSet.groupby("Pclass").sum()
 
print(df)
df.head()

# create bar chart object
pt = df.plot.barh()

# configure title, legend, and grid
pt.set_title(label="Fare by class", y=1.04, 
  family="fantasy", fontsize=14, weight=500, color="navy")
pt.legend().set_visible(False)
pt.grid(color="slategray", alpha=.5, linestyle="dotted", linewidth=.5)
 
# format Y axis
pt.invert_yaxis()
pt.set_ylabel("Passenger class", fontsize=12, color="navy")
pt.set_yticklabels(labels=df.index, fontsize=9, color="navy")
 
# format X axis
pt.set_xlabel("Total Fare", labelpad=10, fontsize=12, color="navy")
pt.set_xticklabels(labels=df["Fare"], fontsize=9, color="navy")
pt.get_xaxis().set_major_formatter(matplotlib.ticker.FuncFormatter
  (lambda x, p: format(int(x), ",")))
 
# save bar chart to PDF file
plt.savefig("E://PythonVisual//barchart_format.pdf", 
  bbox_inches="tight", pad_inches=.5)';
 
DECLARE @sqlscript NVARCHAR(MAX);
SET @sqlscript = N'
  SELECT Pclass, CAST(Fare AS Float) AS Fare
  FROM dbo.train;';
 
EXEC sp_execute_external_script
  @language = N'Python',
  @script = @pscript,
  @input_data_1 = @sqlscript;
GO