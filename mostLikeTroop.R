library(tm)
setwd("/Users/hujie/Documents/NLP/fbMining/databases/")
fav <- read.csv("favorate.csv", sep = ";",row.names = NULL, stringsAsFactors = F)
fav_corpus <- VCorpus(VectorSource(fav$message))
fav_corpus_clean <- tm_map(fav_corpus, content_transformer(tolower))

fav_corpus_clean <- tm_map(fav_corpus_clean, removeNumbers) # remove numbers
fav_corpus_clean <- tm_map(fav_corpus_clean, removeWords, stopwords()) # remove stop words
fav_corpus_clean <- tm_map(fav_corpus_clean, removeWords, c("coc","update")) # remove stop words
fav_corpus_clean <- tm_map(fav_corpus_clean, removePunctuation) # remove punctuation




library(wordcloud)

wordcloud(fav_corpus_clean,min.freq = 10)
replacePunctuation <- function(x) { gsub("[[:punct:]]+", " ", x) }


library(SnowballC)
fav_corpus_clean <- tm_map(fav_corpus_clean, stemDocument)

fav_corpus_clean <- tm_map(fav_corpus_clean, stripWhitespace)
wordcloud(fav_corpus_clean,min.freq = 5,max.words = 30,random.color = T)


write.table(file = "msg.csv",fav$message, sep = ",")


