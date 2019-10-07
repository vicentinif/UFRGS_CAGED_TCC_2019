# ================================================================================================
# Objetivo:    Plotagem dos dados CAGED
# Aluno:       Rodrigo Vicentini
# Orientador:  Joao Comba
# Motivo:      TCC (2019)
# Curso:       UFRGS - Big Data & Data Science
# ================================================================================================

library(tidyverse)
library(dplyr)
library(ggplot2)

# ================================================================================================
# 01: CARREGAMENTO E PRE-PROCESSAMENTO ARQUIVOS CAGED
# ================================================================================================

# diretóro pessoal
setwd("D://Usuários/Rodrigo/GoogleDrive/Compartilhado/UFRGS_TCC/CAGED/microdados/formato_csv/Full/")
path <- getwd()

# diretóro trabalho
#path <- setwd("C://Users//rodrigo.ferreira//Google Drive//Compartilhado//UFRGS_TCC//CAGED//microdados//formato_csv/2019/")

#caged <- read.csv(file = path, header = TRUE, encoding = "UTF08", sep = ";")

# percorre por todos arquivos no diretório principal
data_list = list()
file_list <- list.files(path=path, pattern="*.csv") 

for (i in 1:length(file_list)){
  assign(file_list[i], 
         data_list[[i]] <- read.table(paste0(path, "/", file_list[i]), sep=';', header = TRUE, check.names = TRUE)
  )}

# popula todos arquivos lidos para um único dataframe
caged = do.call(rbind, data_list)


# limpeza e preparaçao dos dados
caged$Admitidos.Desligados <- factor(caged$Admitidos.Desligados, levels = c(1,2), labels = c("Admissão", "Desligamentos"))
caged$Data.Declarada <- as.Date(paste0(caged$Competência.Declarada,"01"), "%Y%m%d")
#caged$Competência.Declarada <- format(caged$Data.Declarada, format="%m")
#caged$Competência.Declarada 
caged$Competência.Declarada.Abrv <- format(caged$Data.Declarada, format="%b")
caged$Competência.Ano.Declarado <- format(caged$Data.Declarada, format="%b/%Y")
caged$UF <- factor(caged$UF, levels = c(11,12,13,14,15,16,17,21,22,23,24,25,26,27,28,29,31,32,33,35,41,42,43,50,51,52,53)
                             , labels = c(  "Acre" ,"Amazonas" ,"Rondônia" ,"Roraima" ,"Para" ,"Amapa" ,"Tocantins" ,"Maranhão" ,"Piaui" ,"Ceará" ,"Rio Grande do Norte"
                                           ,"Paraíba" ,"Pernambuco" ,"Alagoas" ,"Sergipe" ,"Bahia" ,"Minas Gerais" ,"Espírito Santo" ,"Rio de Janeiro" ,"São Paulo"
                                           ,"Paraná" ,"Santa Catarina" ,"Rio Grande do Sul" ,"Mato Grosso do Sul" ,"Mato Grosso" ,"Goiás" ,"Distrito Federal"))
caged$Grau.Instrução <- factor(caged$Grau.Instrução, levels = c(1,2,3,4,5,6,7,8,9,10,11,-1)
                               , labels = c( "Analfabeto","Até 5ª Incompleto","5ª Completo Fundamental","6ª a 9ª Fundamental","Fundamental Completo"
                                            ,"Médio Incompleto","Médio Completo","Superior Incompleto","Superior Completo","Mestrado","Doutorado","Ignorado"))
labs <- c(paste(seq(0, 95, by = 5), seq(0 + 5 - 1, 100 - 1, by = 5), sep = "-"), paste(100, "+", sep = ""))
caged$Faixa.Etária <- cut(caged$Idade, breaks = c(seq(0, 100, by = 5), Inf), labels = labs, right = FALSE)
caged$Raça.Cor <- factor(caged$Raça.Cor, levels = c(1,2,4,6,8,9,-1), labels = c("Indigena","Branca","Preta","Amarela","Parda","Nao ident.","Ignorado"))
caged$Sexo <- factor(caged$Sexo, levels = c(1,2,-1), labels = c("Masculino", "Feminino", "Ignorado"))
caged$Salário.Mensal <- as.numeric(as.character(sub("," , ".", caged$Salário.Mensal)))
caged$Tipo.Mov.Desagregado <- factor(caged$Tipo.Mov.Desagregado, levels = c(1,2,3,4,5,6,7,8,9,10,11,25,43,90,-1)
                                         , labels = c("Admissão por Primeiro Emprego","Admissão por Reemprego","Admissão por Transferência","Desligamento por Demissão sem Justa Causa"
                                                     ,"Desligamento por Demissão com Justa Causa","Desligamento a Pedido","Desligamento por Aposentadoria","Desligamento por Morte"
                                                     ,"Desligamento por Transferência","Admissão por Reintegraçao","Desligamento por Término de Contrato","Contrato Trabalho Prazo Determinado"
                                                     ,"Término Contrato Trabalho Prazo Determinado","Desliamento por Acordo Empregado e Empregador","Ignorado"))

# anexa dataframe tratado
attach(caged)


# ================================================================================================
# 02:  ANÁLISES EXPLORATÓRIA
# ================================================================================================

# separação movimentacões
#caged_admitidos <- subset(caged, Admitidos.Desligados == 'Admissão')
#caged_desligados <- subset(caged, Admitidos.Desligados == 'Desligamentos')

#---------------------------------------------------------------------------------------
# Admitidos.Desligados
#---------------------------------------------------------------------------------------
caged_resumo <- caged %>%
  #filter(Admitidos.Desligados == 'Desligamentos') %>%
  select(Admitidos.Desligados) %>%
  group_by(Admitidos.Desligados) %>%
  summarise(Tot.Movimentacao = n()) %>%
  mutate(Per.Movimentacao = round((Tot.Movimentacao / sum(Tot.Movimentacao)) * 100, digits = 1))
  #summarise(Per.Movimentacao = (Admitidos.Desligados / ))
  #arrange(-Tot.Movimentacao) 

#---------------------------------------------------------------------------------------
# Competência.Declarada
#---------------------------------------------------------------------------------------
caged_competencia <- caged %>%
  #filter(Admitidos.Desligados == "Desligamentos") %>%
  select(Competência.Ano.Declarado, Admitidos.Desligados, Data.Declarada) %>%
  group_by(Competência.Ano.Declarado) %>%
  summarise(Tot.Movimentacao = n()) %>%
  arrange(-Tot.Movimentacao)

# admissao
caged_competencia_admissão <- caged %>%
  filter(Admitidos.Desligados == "Admissão") %>%
  select(Ano.Declarado,Competência.Declarada, Competência.Ano.Declarado) %>%
  group_by(Ano.Declarado,Competência.Declarada, Competência.Ano.Declarado) %>%
  summarise(Tot.Admitidos = n()) %>%
  arrange(Competência.Declarada)

# desligamento
caged_competencia_desligamento <- caged %>%
  filter(Admitidos.Desligados == "Desligamentos") %>%
  select(Ano.Declarado, Competência.Declarada, Competência.Ano.Declarado) %>%
  group_by(Ano.Declarado, Competência.Declarada, Competência.Ano.Declarado) %>%
  summarise(Tot.Desligados = n()) %>%
  arrange(Competência.Declarada)

#head(caged_competencia_admissao)
#head(caged_competencia_desligamento)

#---------------------------------------------------------------------------------------
# resumo faixa etaria
#---------------------------------------------------------------------------------------
# caged_resumo_faixa_etaria_saldo <- inner_join(caged_resumo_adm, caged_resumo_des, 
#                                  by = c("Competência.Declarada" = "Competência.Declarada"
#                                         , "Faixa.Etária" = "Faixa.Etária"))

#---------------------------------------------------------------------------------------
# UF
#---------------------------------------------------------------------------------------
caged %>%
  filter(Admitidos.Desligados == "Desligamentos") %>%
  select(UF) %>%
  group_by(UF) %>%
  summarise(count = n()) %>%
  arrange(-count)

#---------------------------------------------------------------------------------------
# Grau.Instrução
#---------------------------------------------------------------------------------------
caged %>%
  filter(Admitidos.Desligados == "Desligamentos") %>%
  select(Grau.Instrução) %>%
  group_by(Grau.Instrução) %>%
  summarise(count = n()) %>%
  arrange(-count)

#---------------------------------------------------------------------------------------
# Faixa.Etária
#---------------------------------------------------------------------------------------
caged %>%
  filter(Admitidos.Desligados == "Desligamentos") %>%
  select(Faixa.Etária) %>%
  group_by(Faixa.Etária) %>%
  summarise(count = n()) %>%
  arrange(-count)


#---------------------------------------------------------------------------------------
# Raça.Cor
#---------------------------------------------------------------------------------------
caged %>%
  filter(Admitidos.Desligados == "Desligamentos") %>%
  select(Raça.Cor) %>%
  group_by(Raça.Cor) %>%
  summarise(count = n()) %>%
  arrange(-count)

#---------------------------------------------------------------------------------------
# Sexo
#---------------------------------------------------------------------------------------
caged %>%
  #filter(Admitidos.Desligados == "Desligamentos") %>%
  select(Sexo) %>%
  group_by(Sexo) %>%
  summarise(count = n()) %>%
  arrange(-count)

#---------------------------------------------------------------------------------------
# Salário.Mensal.Médio
#---------------------------------------------------------------------------------------
caged %>%
  filter(Admitidos.Desligados == "Desligamentos") %>%
  select(Competência.Declarada, Salário.Mensal, Faixa.Etária) %>%
  group_by(Faixa.Etária) %>%
  summarise(Salário.Médio = mean(Salário.Mensal)) %>%
  arrange(-Salário.Médio)

#---------------------------------------------------------------------------------------
# Qtd.Hora.Contrat
#---------------------------------------------------------------------------------------
caged %>%
  filter(Admitidos.Desligados == "Desligamentos") %>%
  select(Qtd.Hora.Contrat) %>%
  group_by(Qtd.Hora.Contrat) %>%
  summarise(count = n()) %>%
  arrange(-count)

#---------------------------------------------------------------------------------------
# Tipo.Mov.Desagregado
#---------------------------------------------------------------------------------------
caged %>%
  filter(Admitidos.Desligados == "Desligamentos") %>%
  select(Tipo.Mov.Desagregado) %>%
  group_by(Tipo.Mov.Desagregado) %>%
  summarise(count = n()) %>%
  arrange(-count)


  
# ================================================================================================
# 03: ANÁLISES COM GRÁFICOS
# ================================================================================================

#---------------------------------------------------------------------------------------
# Visualização: Saldo por Competência
#---------------------------------------------------------------------------------------
caged_competencia_saldo <- inner_join(caged_competencia_admissão, caged_competencia_desligamento
                                      , by = c("Competência.Declarada" = "Competência.Declarada", 
                                               "Ano.Declarado" = "Ano.Declarado", 
                                               "Competência.Ano.Declarado" = "Competência.Ano.Declarado"))
caged_competencia_saldo$Saldo <- caged_competencia_saldo$Tot.Admitidos - caged_competencia_saldo$Tot.Desligados
caged_competencia_saldo$Competência.Ano.Declarado <- factor(caged_competencia_saldo$Competência.Ano.Declarado, 
                                                            levels = caged_competencia_saldo$Competência.Ano.Declarado
                                                            [order(caged_competencia_saldo$Competência.Declarada)])


# Análise Admissões Vs Desligamentos ao longo do Período (barra ou linha lado-lado)
# TODO


# Análise do Saldo (Admissões - Desligamentos) ao longo do período [gráfico coluna]
g <- ggplot(caged_competencia_saldo, 
            aes(x = caged_competencia_saldo$Competência.Ano.Declarado, 
                y = caged_competencia_saldo$Saldo))
g+ geom_col() +
  ggtitle("Saldo Mensal (Admissão - Desligamento)") +
  xlab("Competência") + 
  ylab("Saldo (Qtd)") 



#---------------------------------------------------------------------------------------
# Visualização: UF
#---------------------------------------------------------------------------------------

# ADMISSÃO
caged_uf <- caged %>%
  filter(Admitidos.Desligados == "Admissão") %>%
  select(UF) %>%
  group_by(UF) %>%
  summarise(Tot.Movimentacao = n()) %>%
  mutate(Per.Movimentacao = round(Tot.Movimentacao/sum(Tot.Movimentacao) * 100, digits = 2)) %>%
  arrange(-Per.Movimentacao)

# Análise Percentual de Admissões por UF (gráfico de coluna)
caged_uf %>% 
  ggplot(aes(reorder(UF, Per.Movimentacao)
             , Per.Movimentacao)) + 
  geom_col(aes(fill = Per.Movimentacao), color="black") + 
  scale_fill_gradient2(low = "white", 
                       high = "darkred") + 
  coord_flip() + 
  #ylim(0, 30)+
  labs(x = "UF") +
  ggtitle("Percentual de Admissões por UF") +
  xlab("UF") + 
  ylab("Admissões (%)") 

# DESLIGAMENTO
caged_uf <- caged %>%
  filter(Admitidos.Desligados == "Desligamentos") %>%
  select(UF) %>%
  group_by(UF) %>%
  summarise(Tot.Movimentacao = n()) %>%
  mutate(Per.Movimentacao = round(Tot.Movimentacao/sum(Tot.Movimentacao) * 100, digits = 2)) %>%
  arrange(-Per.Movimentacao)

# Análise Percentual de Desligamentos por UF (gráfico de coluna)
caged_uf %>% 
  ggplot(aes(reorder(UF, Per.Movimentacao)
             , Per.Movimentacao)) + 
  geom_col(aes(fill = Per.Movimentacao), color="black") + 
  scale_fill_gradient2(low = "white", 
                       high = "darkred") + 
  coord_flip() + 
  #ylim(0, 30)+
  labs(x = "UF") +
  ggtitle("Percentual de Desligamentos por UF") +
  xlab("UF") + 
  ylab("Desligamentos (%)") 


#---------------------------------------------------------------------------------------
# Visualização: Faixa Etária
# TODO: Ideal ter os dois histogramas lado a lado
#---------------------------------------------------------------------------------------
# ADMISSÃO
caged_faixa_etaria <- caged %>%
  filter(Admitidos.Desligados == "Admissão") %>%
  select(Faixa.Etária) %>%
  group_by(Faixa.Etária) %>%
  summarise(Tot.Movimentacao = n()) %>%
  mutate(Per.Movimentacao = round(Tot.Movimentacao/sum(Tot.Movimentacao) * 100, digits = 2)) 

g <- ggplot(caged_faixa_etaria,
            aes(x = caged_faixa_etaria$Faixa.Etária, 
                y = caged_faixa_etaria$Per.Movimentacao),
            binwidth = 0.5)
g+ geom_histogram(stat = "identity") + 
  ggtitle("Percentual de Admissões por Faixa Etária") +
  xlab("Faixa Etária") + 
  ylab("Admissões (%)") 


# DESLIGAMENTO
caged_faixa_etaria <- caged %>%
  filter(Admitidos.Desligados == "Desligamentos") %>%
  select(Faixa.Etária) %>%
  group_by(Faixa.Etária) %>%
  summarise(Tot.Movimentacao = n()) %>%
  mutate(Per.Movimentacao = round(Tot.Movimentacao/sum(Tot.Movimentacao) * 100, digits = 2)) 

g <- ggplot(caged_faixa_etaria,
            aes(x = caged_faixa_etaria$Faixa.Etária, 
                y = caged_faixa_etaria$Per.Movimentacao),
            binwidth = 0.5)
g+ geom_histogram(stat = "identity") + 
  ggtitle("Percentual de Desligamentos por Faixa Etária") +
  xlab("Faixa Etária") + 
  ylab("Desligamentos (%)") 



#---------------------------------------------------------------------------------------
# Visualização: Raça.Cor
#---------------------------------------------------------------------------------------
# ADMISSÃO
caged_raca_cor <- caged %>%
  filter(Admitidos.Desligados == "Admissão") %>%
  select(Raça.Cor) %>%
  group_by(Raça.Cor) %>%
  summarise(Tot.Movimentacao = n()) %>%
  mutate(Per.Movimentacao = round(Tot.Movimentacao/sum(Tot.Movimentacao) * 100, digits = 2)) 
#arrange(-Tot.Movimentacao)

caged_raca_cor %>%
  ggplot(aes(x=Raça.Cor, 
             y=Per.Movimentacao, 
             fill=Raça.Cor)) +
  geom_bar(width = 1, stat = "identity") +
  ggtitle("Percentual de Admissões por Raça Cor") +
  xlab("Raça/Cor") + 
  ylab("Desligamentos (%)") 

# DESLIGAMENTO
caged_raca_cor <- caged %>%
  filter(Admitidos.Desligados == "Desligamentos") %>%
  select(Raça.Cor) %>%
  group_by(Raça.Cor) %>%
  summarise(Tot.Movimentacao = n()) %>%
  mutate(Per.Movimentacao = round(Tot.Movimentacao/sum(Tot.Movimentacao) * 100, digits = 2)) 
  #arrange(-Tot.Movimentacao)

caged_raca_cor %>%
  ggplot(aes(x=Raça.Cor, 
             y=Per.Movimentacao, 
             fill=Raça.Cor)) +
  geom_bar(width = 1, stat = "identity") +
  ggtitle("Percentual de Desligamentos por Raça Cor") +
  xlab("Raça/Cor") + 
  ylab("Desligamentos (%)") 


#---------------------------------------------------------------------------------------
# Visualização: Sexo x Idade
#---------------------------------------------------------------------------------------
# ADMISSÃO
caged_sexo_idade <- caged %>%
  filter(Admitidos.Desligados == "Admissão" 
         #& Ano.Declarado == 2019 
         #& Competência.Declarada == "201901"
  ) %>%
  select(Sexo, Idade) 
#group_by(Sexo, Idade) 

caged_sexo_idade %>%
  ggplot(aes(x=Idade, fill=Sexo, color=Sexo)) +
  geom_histogram(position="identity", alpha=0.5) + 
  ggtitle("Total de Admissões por Idade e Sexo") 
  

  #xlim(c(15, 70)) 
  
  
# DESLIGAMENTO
caged_sexo_idade <- caged %>%
  filter(Admitidos.Desligados == "Desligamentos" 
         #& Ano.Declarado == 2019 
         #& Competência.Declarada == "201901"
  ) %>%
  select(Sexo, Idade) 
  
caged_sexo_idade %>%
  ggplot(aes(x=Idade, fill=Sexo, color=Sexo)) +
  geom_histogram(position="identity", alpha=0.5) + 
  ggtitle("Total de Desligamentos por Idade e Sexo")


#---------------------------------------------------------------------------------------
# Visualização: Salário Médio Mensal
#---------------------------------------------------------------------------------------
# ADMISSÃO
caged_salario_mensal <- caged %>%
  filter(Admitidos.Desligados == "Admissão"
         & Ano.Declarado == 2019 
         & Competência.Declarada == "201901"
  ) %>%
  select(Competência.Declarada, Salário.Mensal, Faixa.Etária) %>%
  group_by(Faixa.Etária) %>%
  summarise(Salário.Médio = round(mean(Salário.Mensal), digits = 2)) 
#arrange(-Salário.Médio)  

caged_salario_mensal %>%
  ggplot(aes(x=Faixa.Etária, 
             y=Salário.Médio, 
             fill=Faixa.Etária)) +
  geom_bar(width = 1, stat = "identity") +
  ggtitle("Salário Médio de Admissões por Faixa Etária") +
  xlab("Faixa Etária") + 
  ylab("Salário Médio (R$)") 



# DESLIGAMENTO
caged_salario_mensal <- caged %>%
  filter(Admitidos.Desligados == "Desligamentos"
         & Ano.Declarado == 2019 
         & Competência.Declarada == "201901"
  ) %>%
  select(Competência.Declarada, Salário.Mensal, Faixa.Etária) %>%
  group_by(Faixa.Etária) %>%
  summarise(Salário.Médio = round(mean(Salário.Mensal), digits = 2)) 
  #arrange(-Salário.Médio)  

caged_salario_mensal %>%
  ggplot(aes(x=Faixa.Etária, 
             y=Salário.Médio, 
             fill=Faixa.Etária)) +
  geom_bar(width = 1, stat = "identity") +
  ggtitle("Salário Médio de Desligamentos por Faixa Etária") +
  xlab("Faixa Etária") + 
  ylab("Salário Médio (R$)") 


# caged_salario_mensal <- caged %>%
#    filter(Admitidos.Desligados == "Desligamentos"
#           & Ano.Declarado == 2019 
#           & Competência.Declarada == "201901"
#           & Idade == c(10:20)
#           ) %>%
#    select(Salário.Mensal, Faixa.Etária) %>%
#   group_by(Faixa.Etária) 

# caged_salario_mensal %>%
#   ggplot(aes(x = Faixa.Etária
#              , y = Salário.Mensal)) +
#   geom_boxplot(color = "blue", fill = "seagreen4", stat = "identity")
# 

# ggplot(caged_salario_mensal, 
#        aes(x = reorder(caged_salio_mensal$Faixa.Etária, 
#                        caged_salio_mensal$Salário.Médio),
#            y = caged_salio_mensal$Salário.Médio)) +
#   geom_boxplot(fill = "grey", 
#                colour = "black", 
#                alpha = 0.7,
#                outlier.colour = "blue",
#                outlier.fill = "blue",
#                outlier.shape = 1)   +
#   scale_y_continuous(name = "Salário Mediano (R$)"
#                      #breaks = seq(0, 6000, 1000),
#                      #limits=c(0, 6000)
#                      ) +
#   scale_x_discrete(name = "Faita Etária") +
#   ggtitle("Distribuição Mediano do Salário por Faita Etária") 


#---------------------------------------------------------------------------------------
# Visualização: Qtd.Hora.Contrat
#---------------------------------------------------------------------------------------
caged_horas_contrato <- caged %>%
  filter(Admitidos.Desligados == "Desligamentos") %>%
  select(Qtd.Hora.Contrat) %>%
  group_by(Qtd.Hora.Contrat) %>%
  summarise(Tot.Movimentacao = n()) %>%
  mutate(Per.Movimentacao = round(Tot.Movimentacao/sum(Tot.Movimentacao) * 100, digits = 2)) %>%
  arrange(-Tot.Movimentacao) 

#TODO
# Agrupar 4 principais categorias e demais somar em outros
# Criar um gráfico de pizza


#---------------------------------------------------------------------------------------
# Visualização: Tipo.Mov.Desagregado
#---------------------------------------------------------------------------------------
caged_tipo_movimentacao <- caged %>%
  filter(Admitidos.Desligados == "Desligamentos") %>%
  select(Tipo.Mov.Desagregado) %>%
  group_by(Tipo.Mov.Desagregado) %>%
  summarise(Tot.Movimentacao = n()) %>%
  mutate(Per.Movimentacao = round(Tot.Movimentacao/sum(Tot.Movimentacao) * 100, digits = 2)) %>%
  arrange(-Tot.Movimentacao)

caged_tipo_movimentacao <- caged %>%
  filter(Admitidos.Desligados == "Admissão") %>%
  select(Tipo.Mov.Desagregado) %>%
  group_by(Tipo.Mov.Desagregado) %>%
  summarise(Tot.Movimentacao = n()) %>%
  mutate(Per.Movimentacao = round(Tot.Movimentacao/sum(Tot.Movimentacao) * 100, digits = 2)) %>%
  arrange(-Tot.Movimentacao)

head(caged_tipo_movimentacao)

# ================================================================================================

caged_explor <- caged %>%
  filter(
        #UF == "Goías"
          
          Ano.Declarado == 2019 
         & Competência.Declarada == "201901") %>%
  select(UF, Município) %>%
  group_by(UF, Município) 
  #summarise(Tot.Movimentacao = n()) %>%
  #mutate(Per.Movimentacao = round(Tot.Movimentacao/sum(Tot.Movimentacao) * 100, digits = 2)) %>%
  #arrange(-Tot.Movimentacao)
  

