install.packages("dplyr")
install.packages("tidytext")

library(dplyr)
library(tidytext)

# import the csv into a tidy data frame
text <- read_csv("test.csv")

# create one work per line
# punctuation is removed, all lowercased
# other cols preserved
tidy_reviews <- text %>%
  unnest_tokens(word, Review)

# find the count of each word within the dataset
tidy_reviews_counts <- tidy_reviews %>%
  count(word, sort = TRUE)

# remove common "stop words" like "the" etc...

# create the data frame with the stop words
data(stop_words)
# do an anti-join to remove the words
tidy_reviews_stop <- tidy_reviews %>%
  anti_join(stop_words)


tidy_reviews
tidy_reviews_stop

tidy_reviews_counts
