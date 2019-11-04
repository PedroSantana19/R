#importando dados 
base <- read.csv('risco-credito.csv')
head(base)
#instalar pacotes do OneR
install.packages('OneR')
library(OneR)

#criar classificador
classificador = OneR(x = base)
print(classificador)

#criar dados para serem classificados pelo algoritmo
#em seguida os uniremos em um DF

historia = c('boa','ruim')
divida = c('alta', 'alta')
garantias = c('nenhum', 'adequada')
renda = c('acima_35', '0_15')

df = data.frame(historia, divida, garantias, renda)

#hora de prever
previsoes = predict(classificador, newdata=df)
print(previsoes)
print(df)