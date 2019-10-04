base = read.csv('credit-data.csv')
base$clientid = NULL
summary(base)
idade = base[base$age < 0 & !is.na(base$age), ]

#4 formas de tratar dados inconsistentes 

#1 Apagar coluna
#base$age = NULL

#2 apagar as colunas com inconsistência
#base = base[base$age >100, ]

#3 preencher os dados manualmente

#4 Calcular a média das idades
mean(base$age, na.rm = TRUE)
mean(base$age[base$age > 0], na.rm= TRUE)
base$age = ifelse(base$age < 0, 40.92, base$age )

#preencher dados faltantes
base[is.na(base$age), ]
base$age = ifelse(is.na(base$age), mean(base$age, na.rm =TRUE), base$age)

#Escalonar os atributos 

base[, 1:3] = scale(base[,1:3])