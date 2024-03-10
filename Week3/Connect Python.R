#Import Python pandas data frame
installed.packages("reticulate")
library(reticulate)
# Load the python object containing pickled data frame
df <- py_load_object("dataframe_pickle.pkl") #無法使用
