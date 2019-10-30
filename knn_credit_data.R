base = read.csv("credit-data.csv")
base$clientid = NULL

base$age = ifelse(base$age < 0, 40.92, base$age)
base$age = ifelse(is.na(base$age), mean(base$age, na.rm= TRUE), base$age)

base[,1:3] = scale(base[, 1:3])

library("caTools")
set.seed(1)
divisao = sample.split(base$income, SplitRatio = 0.75)
base_treinamento = subset(base, divisao == TRUE)
base_teste = subset(base, divisao == FALSE)

install.packages("class")
library(class)

previsoes = knn(base_treinamento[, -4], base_teste[, -4],
                cl = base_treinamento[, 4], k = 5)

matriz_confusao = table(base_teste[, 4], previsoes)
print(matriz_confusao)
library(caret)
install.packages("e1071")
library(e1071)
confusionMatrix(matriz_confusao)

