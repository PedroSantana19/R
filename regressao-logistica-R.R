base = read.csv('credit-data.csv')

base$clientid = NULL

base$age = ifelse(base$age < 0,  40.92, base$age)
base$age = ifelse(is.na(base$age), mean(base$age, na.rm = TRUE), base$age)
base[, 1:3] = scale(base[, 1:3])

library(caTools)
set.seed(1)
divisao = sample.split(base$income, SplitRatio = 0.75)
base_treinamento = subset(base, divisao == TRUE)
base_teste = subset(base, divisao == FALSE)

classificador = glm(formula = default~., family = binomial, data = base_treinamento)
probabilidades = predict(classificador, type = 'response', newdata = base_teste[-4])
previsoes = ifelse(probabilidades > 0.5, 1, 0)

matriz_confusao = table(base_teste[, 4], previsoes)

