#how the coverage of real estate has evolved over the years with toronto publications

library(dplyr)
library(twitteR)
library(purrr)
library(tidyr)
library(lubridate)
library(scales)
library(ggplot2)
library(tidytext)
library(stringr)
library(wordcloud)

consumerKey <- "b35qDXN6VvNpsxnqoFTDDll6U"
consumerSecret <- "uux9vLwKAXhaJuNJRajcu8DOCvn0LhdxRwHE0m62y3eUZTJpLv"
accessToken <- "14701057-9LHglQUPDoOJ55qaMhHTBfA91IhBuZkCloPl4iMHE"
accessTokenSecret <- "a7qoTjOGe4OqwB9mg01bwmkqw7yvR5BCXohEYqxh2hTv7"

setup_twitter_oauth(consumerKey, consumerSecret, accessToken, accessTokenSecret)

blogto_tweets <- userTimeline("blogTO", n=3200)
blogto_tweets_df <- tbl_df(map_df(blogto_tweets, as.data.frame))

torontolife_tweets <- userTimeline("torontolife", n=3200)
torontolife_tweets_df <- tbl_df(map_df(torontolife_tweets, as.data.frame))

globeandmail_tweets <- userTimeline("globeandmail", n=3200)
globeandmail_tweets_df <- tbl_df(map_df(globeandmail_tweets, as.data.frame))

torontostar_tweets <- userTimeline("TorontoStar", n=3200)
torontostar_tweets_df <- tbl_df(map_df(torontostar_tweets, as.data.frame))

nationalpost_tweets <- userTimeline("nationalpost", n=3200)
nationalpost_tweets_df <- tbl_df(map_df(nationalpost_tweets, as.data.frame))

thewalrus_tweets <- userTimeline("walrusmagazine", n=3200)
thewalrus_tweets_df <- tbl_df(map_df(thewalrus_tweets, as.data.frame))

torontosun_tweets <- userTimeline("TheTorontoSun", n=3200)
torontosun_tweets_df <- tbl_df(map_df(torontosun_tweets, as.data.frame))


#time
blogto_tweets_df %>% count(hour = hour(with_tz(created, "EST"))) %>%
  mutate(percent = n / sum(n)) %>%
  ggplot(aes(hour, percent)) + geom_line() + scale_y_continuous(labels=percent_format()) +
  labs(x = "Hour of Day (EST)",
       y = "% of tweets")

blogto_tweet_picture <- blogto_tweets_df %>% filter(!str_detect(text, '^"')) %>%
  count(picture = ifelse(str_detect(text, "t.co"), "Picture/link", "No picture/link"))

ggplot(blogto_tweet_picture, aes(picture, n)) +
  geom_bar(stat="identity", position="dodge") + labs(x= "", y="Number of tweets", fill= "")

torontolife_tweets_df %>% count(hour = hour(with_tz(created, "EST"))) %>%
  mutate(percent = n / sum(n)) %>%
  ggplot(aes(hour, percent)) + geom_line() + scale_y_continuous(labels=percent_format()) +
  labs(x = "Hour of Day (EST)",
       y = "% of tweets")

torontolife_tweet_picture <- torontolife_tweets_df %>% filter(!str_detect(text, '^"')) %>%
  count(picture = ifelse(str_detect(text, "t.co"), "Picture/link", "No picture/link"))

ggplot(torontolife_tweet_picture, aes(picture, n)) +
  geom_bar(stat="identity", position="dodge") + labs(x="", y="Number of tweets", fill="")

globeandmail_tweets_df %>% count(hour = hour(with_tz(created, "EST"))) %>%
  mutate(percent = n / sum(n)) %>%
  ggplot(aes(hour, percent)) + geom_line() + scale_y_continuous(labels=percent_format()) +
  labs(x = "Hour of Day (EST)",
       y = "% of tweets")

globeandmail_tweet_picture <- globeandmail_tweets_df %>% filter(!str_detect(text, '^"')) %>%
  count(picture = ifelse(str_detect(text, "t.co"), "Picture/link", "No picture/link"))

ggplot(globeandmail_tweet_picture, aes(picture, n)) +
  geom_bar(stat="identity", position="dodge") + labs(x="", y="Number of tweets", fill="")

torontostar_tweets_df %>% count(hour = hour(with_tz(created, "EST"))) %>%
  mutate(percent = n / sum(n)) %>%
  ggplot(aes(hour, percent)) + geom_line() + scale_y_continuous(labels=percent_format()) +
  labs(x = "Hour of Day (EST)",
       y = "% of tweets")

torontostar_tweet_picture <- torontostar_tweets_df %>% filter(!str_detect(text, '^"')) %>%
  count(picture = ifelse(str_detect(text, "t.co"), "Picture/link", "No picture/link"))

ggplot(torontostar_tweet_picture, aes(picture, n)) +
  geom_bar(stat="identity", position="dodge") + labs(x="", y="Number of tweets", fill="")

nationalpost_tweets_df %>% count(hour = hour(with_tz(created, "EST"))) %>%
  mutate(percent = n / sum(n)) %>%
  ggplot(aes(hour, percent)) + geom_line() + scale_y_continuous(labels=percent_format()) +
  labs(x = "Hour of Day (EST)",
       y = "% of tweets")

nationalpost_tweet_picture <- nationalpost_tweets_df %>% filter(!str_detect(text, '^"')) %>%
  count(picture = ifelse(str_detect(text, "t.co"), "Picture/link", "No picture/link"))

ggplot(nationalpost_tweet_picture, aes(picture, n)) +
  geom_bar(stat="identity", position="dodge") + labs(x="", y="Number of tweets", fill="")

thewalrus_tweets_df %>% count(hour = hour(with_tz(created, "EST"))) %>%
  mutate(percent = n / sum(n)) %>%
  ggplot(aes(hour, percent)) + geom_line() + scale_y_continuous(labels=percent_format()) +
  labs(x = "Hour of Day (EST)",
       y = "% of tweets")

thewalrus_tweet_picture <- thewalrus_tweets_df %>% filter(!str_detect(text, '^"')) %>%
  count(picture = ifelse(str_detect(text, "t.co"), "Picture/link", "No picture/link"))

ggplot(thewalrus_tweet_picture, aes(picture, n)) +
  geom_bar(stat="identity", position="dodge") + labs(x="", y="Number of tweets", fill="")

torontosun_tweets_df %>% count(hour = hour(with_tz(created, "EST"))) %>%
  mutate(percent = n / sum(n)) %>%
  ggplot(aes(hour, percent)) + geom_line() + scale_y_continuous(labels=percent_format()) +
  labs(x = "Hour of Day (EST)",
       y = "% of tweets")

torontosun_tweet_picture <- torontosun_tweets_df %>% filter(!str_detect(text, '^"')) %>%
  count(picture = ifelse(str_detect(text, "t.co"), "Picture/link", "No picture/link"))

ggplot(torontosun_tweet_picture, aes(picture, n)) + 
  geom_bar(stat="identity", position="dodge") + labs(x="", y="Number of tweets", fill="")

#most frequently used words in tweet

reg <- "([^A-Za-z\\d#@']|'(?![A-Za-z\\d#@]))"
blogto_tweet_words <- blogto_tweets_df %>% filter(!str_detect(text, '^"')) %>%
  mutate(text = str_replace_all(text, "https://t.co[A-Za-z\\d]+|&amp;", "")) %>%
  unnest_tokens(word, text, token = "regex", pattern = reg) %>%
  filter(!word %in% stop_words$word, str_detect(word, "[a-z]")) %>%
  select(id, word, created) %>%
  mutate(total_words = n())

blogto_tweet_words

blogto_tweet_words %>% count(word) %>% filter(n > 100)

blogto_source_sentiment <- blogto_tweet_words %>%
  inner_join(nrc, by = "word") %>%
  count(sentiment, id) %>%
  ungroup() %>% 
  complete(sentiment, id, fill = list(n = 0)) %>%
  summarize(words = sum(n)) 

head(blogto_source_sentiment)

blogto_tweet_words %>% count(word) %>% with(wordcloud(word, n, max.words=100))

blogto_tweet_words %>%
  filter(n > 100) %>%
  mutate(n = ifelse(sentiment == "negative", -n, n)) %>%
  mutate(word = reorder(word, n)) %>%
  ggplot(aes(word, n, fill = sentiment)) +
  geom_bar(stat = "identity") +
  theme(axis.text.x = element_text(angle=90, hjust=1)) +
  ylab("Contribution to sentiment")


globe_tweet_words <- globeandmail_tweets_df %>% filter(!str_detect(text, '^"')) %>%
  mutate(text = str_replace_all(text, "https://t.co[A-Za-z\\d]+|&amp;", "")) %>%
  unnest_tokens(word, text, token = "regex", pattern = reg) %>%
  filter(!word %in% stop_words$word, str_detect(word, "[a-z]")) %>%
  select(id, word, created)

globe_tweet_words

globe_tweet_words %>% count(word) %>% filter(n > 5)

globe_tweet_words %>% count(word) %>% with(wordcloud(word, n, max.words=100))

torontolife_tweet_words <- torontolife_tweets_df %>% filter(!str_detect(text, '^"')) %>%
  mutate(text = str_replace_all(text, "https://t.co[A-Za-z\\d]+|&amp;", "")) %>%
  unnest_tokens(word, text, token = "regex", pattern = reg) %>%
  filter(!word %in% stop_words$word, str_detect(word, "[a-z]")) %>%
  select(id, word, created)

torontolife_tweet_words

torontolife_tweet_words %>% count(word) %>% filter(n > 5)

torontolife_tweet_words %>% count(word) %>% with(wordcloud(word, n, max.words=100))

nationalpost_tweet_words <- nationalpost_tweets_df %>% filter(!str_detect(text, '^"')) %>%
  mutate(text = str_replace_all(text, "https://t.co[A-Za-z\\d]+|&amp;", "")) %>%
  unnest_tokens(word, text, token = "regex", pattern = reg) %>%
  filter(!word %in% stop_words$word, str_detect(word, "[a-z]")) %>%
  select(id, word, created)

nationalpost_tweet_words

nationalpost_tweet_words %>% count(word) %>% filter(n > 5)

nationalpost_tweet_words %>% count(word) %>% with(wordcloud(word, n, max.words=100))

torontostar_tweet_words <- torontostar_tweets_df %>% filter(!str_detect(text, '^"')) %>%
  mutate(text = str_replace_all(text, "https://t.co[A-Za-z\\d]+|&amp;", "")) %>%
  unnest_tokens(word, text, token = "regex", pattern = reg) %>%
  filter(!word %in% stop_words$word, str_detect(word, "[a-z]")) %>%
  select(id, word, created)

torontostar_tweet_words 

torontostar_tweet_words %>% count(word) %>% filter(n > 5)

torontostar_tweet_words %>% count(word) %>% with(wordcloud(word, n, max.words=100))

torontosun_tweet_words <- torontosun_tweets_df %>% filter(!str_detect(text, '^"')) %>%
  mutate(text = str_replace_all(text, "https://t.co[A-Za-z\\d]+|&amp;", "")) %>%
  unnest_tokens(word, text, token = "regex", pattern = reg) %>%
  filter(!word %in% stop_words$word, str_detect(word, "[a-z]")) %>%
  select(id, word, created)

torontosun_tweet_words

torontosun_tweet_words %>% count(word) %>% filter(n > 5)

torontosun_tweet_words %>% count(word) %>% with(wordcloud(word, n, max.words=100))


thewalrus_tweet_words <- thewalrus_tweets_df %>% filter(!str_detect(text, '^"')) %>%
  mutate(text = str_replace_all(text, "https://t.co[A-Za-z\\d]+|&amp;", "")) %>%
  unnest_tokens(word, text, token = "regex", pattern = reg) %>%
  filter(!word %in% stop_words$word, str_detect(word, "[a-z]")) %>%
  select(id, word, created)

thewalrus_tweet_words

thewalrus_tweet_words %>% count(word) %>% filter(n > 5)

thewalrus_tweet_words %>% count(word) %>% with(wordcloud(word, n, max.words=100))

#retweets and favorites



#sentiment analysis
nrc <- sentiments %>% filter(lexicon == "nrc") %>% dplyr::select(word, sentiment)
nrc


by_sentiment <- tweet_words %>% inner_join(nrc, by = "word") %>%
  group_by(sentiment) %>%
  count(sentiment) %>% summarize(tot = sum(n))

head(by_sentiment)
