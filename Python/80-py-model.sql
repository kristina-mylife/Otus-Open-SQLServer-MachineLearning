
DECLARE @pscript NVARCHAR(MAX);
SET @pscript = N'
import pandas as pd
import numpy as np
import random as rnd

from sklearn.linear_model import LogisticRegression
from sklearn.svm import SVC, LinearSVC
from sklearn.ensemble import RandomForestClassifier
from sklearn.neighbors import KNeighborsClassifier
from sklearn.naive_bayes import GaussianNB
from sklearn.linear_model import Perceptron
from sklearn.linear_model import SGDClassifier
from sklearn.tree import DecisionTreeClassifier
import pickle

# assign SQL Server dataset to df
df = train_data

X_train = df.drop("Survived", axis=1)
Y_train = df["Survived"]
X_train.shape, Y_train.shape

GNB = GaussianNB()
trained_model = pickle.dumps(GNB.fit(X_train, Y_train))';
 
DECLARE @sqlscript NVARCHAR(MAX),
        @trained_model VARBINARY(max);
SET @sqlscript = N'
SELECT CAST([PassengerId] AS  INT) AS  [PassengerId]
      ,[Survived]
      ,[Pclass]
     -- ,[Name]
      ,IIF([Sex] = ''female'',1,0) AS Sex
      ,CAST([Age] AS FLOAT) AS [Age]
      ,CAST([SibSp] AS INT) AS [SibSp]
      ,CAST([Parch] AS INT) AS [Parch]
     -- ,[Ticket]
      ,CAST([Fare] AS FLOAT) AS [Fare]
     -- ,[Cabin]
      --,CAST([Embarked] AS BIT) AS Embarked
  FROM [titanic].[dbo].[train]
  WHERE Age IS NOT NULL;';
 
EXEC sp_execute_external_script
  @language = N'Python',
  @script = @pscript,
  @input_data_1 = @sqlscript,
  @input_data_1_name = N'train_data', 
  @params = N'@trained_model varbinary(max) OUTPUT', 
  @trained_model = @trained_model OUTPUT;

  SELECT @trained_model


