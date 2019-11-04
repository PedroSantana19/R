#importando dados
data <- read.csv('processed.cleveland.data', header=FALSE)
dim(data)

#importanto random forest e split
install.packages("randomForest")
library(randomForest)
install.packages("caTools")
library(caTools)
#dando nomes as colunas do dataset
names(data) <- c("age", "sex", "cp", "trestbps", "choi", "fbs", "restecg",
                 "thalach", "exang", "oldpeak", "slope", "ca", "thai", "num")

#exibir primeiras linhas do dataset 
head(data)

#a coluna "num" representa presença de problemas cardíacos com números de 1 a 4
#vamos simplificar trocando presente apenas para 1 e e ausente apenas para 0

data$num[data$num > 1] <- 1

#apresentar um resumo estatístico do nosso dataset
summary(data)

#apresenta os tipos de dados 
sapply(data, class)

#tranformação de algumas colunas numéricas em categóricas

data <- transform(
  data,
  age=as.integer(age),
  sex=as.factor(sex),
  cp=as.factor(cp),
  trestbps=as.integer(trestbps),
  choi=as.integer(choi),
  fbs=as.factor(fbs),
  restecg=as.factor(restecg),
  thalach=as.integer(thalach),
  exang=as.factor(exang),
  oldpeak=as.numeric(oldpeak),
  slope=as.factor(slope),
  ca=as.factor(ca),
  thai=as.factor(thai),
  num=as.factor(num)
)

summary(data)

data[data == "?"] <- NA
colSums(is.na(data))

data$thai[which(is.na(data$thai))] <- as.factor("3.0")
data <- data[!(data$ca %in% c(NA)),]
colSums(is.na(data))

data$ca <- factor(data$ca)
data$thai <- factor(data$thai)
summary(data)

sample = sample.split(data$num, SplitRatio = .75)

train = subset(data, sample == TRUE)
test  = subset(data, sample == FALSE)

dim(train)
dim(test)

#iniciando o randomForest
rf <- randomForest(num ~ .,data=train)

pred = predict(rf, newdata=test[-14])
cm = table(test[,14], pred)
