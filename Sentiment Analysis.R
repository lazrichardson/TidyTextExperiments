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


# remove common "stop words" like "the" etc...
# create the data frame with the stop words
data(stop_words)

# do an anti-join to remove the words
tidy_reviews_stop <- tidy_reviews %>%
  anti_join(stop_words)

tidy_reviews_stop

# sentiments in bing dataset
# scores -5 (worst) to 5 (best)
sentiment <- get_sentiments("bing")

# join sentiments to dataset
tidy_reviews_stop %>%
  inner_join(sentiment) %>% # inner join with sentiments
  filter(sentiment == "positive") #only include positive sentiment

# same foundation but returns counts of words with positive sentiment
tidy_reviews_stop %>%
  inner_join(sentiment) %>% # inner join with sentiments
  filter(sentiment == "positive") %>% #only include positive sentiment
  count(word, sort = TRUE)
  