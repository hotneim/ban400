
#
# CASE: NEWSPAPER SALES
# 

# Script for processing the raw data files into a manageble data frame. The raw
# seller reports are located in the folder "../raw", and consist of one small
# csv-file per seller, per week. The filename contains the seller id and the
# week number, while the csv files themselves contains the number of newspapers
# that were delivered to the seller, the number of newspapers sold, as well as
# the number of newspapers that the seller ordered for next week.
 
# We would like to collect all of these observations in one single data frame.
# This data frame will have the following variables:
#
# - seller, week, n_delivered, n_sold, n_ordered

# In this case we have many many tiny csv-files. We can set up a for-loop and
# read them in one by one, but let us instead try the "vroom"-package, which can
# do this with maximum speed (which in this case is still quite slow because
# there are so many). We first make a vector of the file paths, which we then
# pass on to vroom(). We keep the file paths in a separate column (called "file"
# in the id-argument) in order to extract the seller id and week number.
sales <- 
  paste("raw/", dir("raw"), sep = "") %>% 
  vroom(id = "file") %>% 
  # Split the file name by the underscore using the separate-function
  separate(file, 
           into = c("seller_id", "week"),
           sep = "_") %>%
  # Clean away the folder part and the file extension from the seller_id and
  # week-variables. Also, transform the week to numeric values
  mutate(week = gsub(".csv", "", .$week) %>% as.numeric) %>% 
  mutate(seller_id = gsub("raw/", "", .$seller_id))
  
# Save data into the data folder
write_csv(sales, "data/sales.csv")


