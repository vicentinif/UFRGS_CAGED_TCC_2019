# ================================================================================================
# Objetivo:    Análises dos Dados CAGED
# Aluno:       Rodrigo Vicentini
# Orientador:  Joao Comba
# Motivo:      TCC (2019)
# Curso:       UFRGS - Big Data & Data Science
# ================================================================================================
library(tidyverse)
library(dplyr)
library(ggplot2)

# diretóro pessoal
setwd("D://Usuários/Rodrigo/GoogleDrive/Compartilhado/UFRGS_TCC/CAGED/sumarizado/")
path <- getwd()

#----------------------------------------------------------------------------------------
# caged_compet_admdes_salario_idade
#----------------------------------------------------------------------------------------
file <- paste0(path, "/","caged_compet_admdes_salario_idade.csv")
caged <- read.table(file, sep='|', header = TRUE, check.names = TRUE)
caged$admitidos_desligados <- factor(caged$admitidos_desligados, levels = c(1,2), labels = c("Admissão", "Desligamentos"))
#caged$data_declarada <- as.Date(paste0(caged$competencia_declarada,"01"), "%Y%m%d")
#caged$competencia_declarada_abrv <- format(caged$data_declarada, format="%b")
#caged$competencia_ano <- format(caged$data_declarada, format="%b/%Y")
labs <- c(paste(seq(0, 95, by = 5), seq(0 + 5 - 1, 100 - 1, by = 5), sep = "-"), paste(100, "+", sep = ""))
caged$faixa_etaria <- cut(caged$idade, breaks = c(seq(0, 100, by = 5), Inf), labels = labs, right = FALSE)


caged_sal_medio_faixa_etaria <- caged
rm(caged)


# ADMISSAO
#=============================
caged_sal_medio_fx_etaria_adm_final <- caged_sal_medio_faixa_etaria %>%
  filter(admitidos_desligados == "Admissão", idade > 0) %>%
  select(ano_declarado, faixa_etaria, tot_sal_mes, qtd_mov) %>%
  group_by(faixa_etaria) %>%
  summarise(sal_medio = sum(as.numeric(tot_sal_mes)) / sum(qtd_mov), tot_mov = sum(qtd_mov)) %>%
  mutate(tot_mov_milhoes = round(tot_mov / 1000000)) %>%
  arrange(-sal_medio)

# movimnetacao por faixa etaria
caged_sal_medio_fx_etaria_adm_final %>%
  ggplot(aes(x=faixa_etaria, 
             y=tot_mov_milhoes, 
             fill=faixa_etaria)) +
  geom_bar(width = 1, stat = "identity") +
  ggtitle("Admissões: Total de Movimentaçao por Faixa Etária") +
  xlab("Faixa Etária") + 
  ylab("Total Movimentação (Milhões)") +
  theme_update(text = element_text(size=20))


# salario médio
caged_sal_medio_fx_etaria_adm_final %>%
  ggplot(aes(x=faixa_etaria, 
             y=sal_medio, 
             fill=sal_medio)) +
  geom_bar(width = 1, stat = "identity") +
  #geom_text(aes(label=tot_mov_milhoes), position=position_dodge(width=2), vjust=0.2) +
  ggtitle("Admissões: Salário Médio por Faixa Etária") +
  xlab("Faixa Etária") + 
  ylab("Salário Médio (R$)") +
  theme_update(text = element_text(size=10))


# DESLIGAMENTO
#=============================
caged_sal_medio_fx_etaria_des_final <- caged_sal_medio_faixa_etaria %>%
  filter(admitidos_desligados == "Desligamentos", idade > 0) %>%
  select(ano_declarado, faixa_etaria, tot_sal_mes, qtd_mov) %>%
  group_by(faixa_etaria) %>%
  summarise(sal_medio = sum(as.numeric(tot_sal_mes)) / sum(qtd_mov),
            tot_mov = sum(qtd_mov)) %>%
  mutate(tot_mov_milhoes = round(tot_mov / 1000000)) %>%
  arrange(-sal_medio)

# total de mov por faixa etaria
caged_sal_medio_fx_etaria_des_final %>%
  ggplot(aes(x=faixa_etaria, 
             y=tot_mov_milhoes, 
             fill=faixa_etaria)) +
  geom_bar(width = 1, stat = "identity") +
  ggtitle("Desligamentos: Total de Movimentaçao por Faixa Etária") +
  xlab("Faixa Etária") + 
  ylab("Total Movimentação (Milhões)") 
  

# salario médio
caged_sal_medio_fx_etaria_des_final %>%
  ggplot(aes(x=faixa_etaria, 
             y=sal_medio, 
             fill=sal_medio)) +
  geom_bar(width = 1, stat = "identity") +
  ggtitle("Desligamentos: Salário Médio por Faixa Etária") +
  xlab("Faixa Etária") + 
  ylab("Salário Médio (R$)") +
  theme_update(text = element_text(size=50))


# diretorio para export/import de arquivos
setwd("D://Usuários/Rodrigo/GoogleDrive/Compartilhado/UFRGS_TCC/CAGED/sumarizado/")
path <- getwd()

path <- paste0(path, "/caged_sal_medio_fx_etaria_adm_final_teste.csv")
write.table(caged_sal_medio_fx_etaria_adm_final, path, sep="|", row.names = FALSE)



# SALDO
#=============================

caged_sal_medio_fx_etaria_saldo_final <- inner_join(caged_sal_medio_fx_etaria_adm_final, 
                                                    caged_sal_medio_fx_etaria_des_final,
                                                    by = c("faixa_etaria" = "faixa_etaria"))

caged_sal_medio_fx_etaria_saldo_final$saldo <- 
  caged_sal_medio_fx_etaria_saldo_final$tot_mov_milhoes.x - caged_sal_medio_fx_etaria_saldo_final$tot_mov_milhoes.y

# total de mov por faixa etaria
caged_sal_medio_fx_etaria_saldo_final %>%
  ggplot(aes(x=faixa_etaria, 
             y=saldo, 
             fill=faixa_etaria)) +
  geom_bar(width = 1, stat = "identity") +
  ggtitle("Saldo: Total de Movimentaçao por Faixa Etária") +
  xlab("Faixa Etária") + 
  ylab("Total Movimentação (Milhões)") +
  #axis(2,cex.axis=1.2)
  theme_update(text = element_text(size=20))





#----------------------------------------------------------------------------------------
# caged_compet_admdes_salario_racacor
#----------------------------------------------------------------------------------------
file <- paste0(path, "/","caged_compet_admdes_salario_racacor.csv")
caged <- read.table(file, sep='|', header = TRUE, check.names = TRUE)
caged$admitidos_desligados <- factor(caged$admitidos_desligados, levels = c(1,2), labels = c("Admissão", "Desligamentos"))
caged$raca_cor <- factor(caged$raca_cor, levels = c(1,2,4,6,8,9,-1), labels = c("Indigena","Branca","Preta","Amarela","Parda","Nao ident.","Ignorado"))

caged_sal_medio_raca_cor <- caged
rm(caged)


# ADMISSAO
#=============================
caged_sal_medio_raca_cor_adm_final <- caged_sal_medio_raca_cor %>%
  filter(admitidos_desligados == "Admissão") %>%
  select(ano_declarado, raca_cor, tot_sal_mes, qtd_mov) %>%
  group_by(raca_cor) %>%
  summarise(sal_medio = sum(as.numeric(tot_sal_mes)) / sum(qtd_mov),
            tot_mov = sum(qtd_mov)) %>%
  mutate(tot_mov_milhoes = round(tot_mov / 1000000)) %>%
  arrange(-sal_medio)

# movimnetacao por raca_cor
caged_sal_medio_raca_cor_adm_final %>%
  ggplot(aes(x=raca_cor, 
             y=tot_mov_milhoes, 
             fill=raca_cor)) +
  geom_bar(width = 1, stat = "identity") +
  ggtitle("Admissões: Total de Movimentaçao por Raça Cor") +
  xlab("Raça Cor") + 
  ylab("Total Movimentação (Milhões)")


# salario médio
caged_sal_medio_raca_cor_adm_final %>%
  ggplot(aes(x=raca_cor, 
             y=sal_medio, 
             fill=raca_cor)) +
  geom_bar(width = 1, stat = "identity") +
  ggtitle("Admissões: Salário Médio por Raça Cor") +
  xlab("Raça Cor") + 
  ylab("Salário Médio (R$)") 


# DESLIGAMENTOS
#=============================
caged_sal_medio_raca_cor_des_final <- caged_sal_medio_raca_cor %>%
  filter(admitidos_desligados == "Desligamentos") %>%
  select(ano_declarado, raca_cor, tot_sal_mes, qtd_mov) %>%
  group_by(raca_cor) %>%
  summarise(sal_medio = sum(as.numeric(tot_sal_mes)) / sum(qtd_mov),
            tot_mov = sum(qtd_mov)) %>%
  mutate(tot_mov_milhoes = round(tot_mov / 1000000)) %>%
  arrange(-sal_medio)

# movimnetacao por raca_cor
caged_sal_medio_raca_cor_des_final %>%
  ggplot(aes(x=raca_cor, 
             y=tot_mov_milhoes, 
             fill=raca_cor)) +
  geom_bar(width = 1, stat = "identity") +
  ggtitle("Desligamentos: Total de Movimentaçao por Raça Cor") +
  xlab("Raça Cor") + 
  ylab("Total Movimentação (Milhões)")


# salario médio
caged_sal_medio_raca_cor_des_final %>%
  ggplot(aes(x=raca_cor, 
             y=sal_medio, 
             fill=raca_cor)) +
  geom_bar(width = 1, stat = "identity") +
  ggtitle("Desligamentos: Salário Médio por Raça Cor") +
  xlab("Raça Cor") + 
  ylab("Salário Médio (R$)") 



#----------------------------------------------------------------------------------------
# caged_compet_admdes_salario_sexo
#----------------------------------------------------------------------------------------
file <- paste0(path, "/","caged_compet_admdes_salario_sexo.csv")
caged <- read.table(file, sep='|', header = TRUE, check.names = TRUE)
caged$admitidos_desligados <- factor(caged$admitidos_desligados, levels = c(1,2), labels = c("Admissão", "Desligamentos"))
caged$sexo <- factor(caged$sexo, levels = c(1,2,-1), labels = c("Masculino", "Feminino", "Ignorado"))


caged_sal_medio_sexo <- caged
rm(caged)


# ADMISSAO
#=============================
caged_sal_medio_sexo_adm_final <- caged_sal_medio_sexo %>%
  filter(admitidos_desligados == "Admissão") %>%
  select(ano_declarado, sexo, tot_sal_mes, qtd_mov) %>%
  group_by(sexo) %>%
  summarise(sal_medio = sum(as.numeric(tot_sal_mes)) / sum(qtd_mov),
            tot_mov = sum(qtd_mov)) %>%
  mutate(tot_mov_milhoes = round(tot_mov / 1000000)) %>%
  mutate(sal_medio = round(sal_medio)) %>%
  arrange(-sal_medio)

# movimnetacao por sexo
caged_sal_medio_sexo_adm_final %>%
  ggplot(aes(x=sexo, 
             y=tot_mov_milhoes, 
             fill=sexo)) +
  geom_bar(width = 1, stat = "identity") +
  geom_text(aes(label=tot_mov_milhoes), position=position_dodge(width=2), vjust=0.2) +
  ggtitle("Admissões: Total de Movimentaçao por Sexo") +
  xlab("Sexo") + 
  ylab("Total Movimentação (Milhões)")

# salario médio
caged_sal_medio_sexo_adm_final %>%
  ggplot(aes(x=sexo, 
             y=sal_medio, 
             fill=sexo)) +
  geom_bar(width = 1, stat = "identity") +
  geom_text(aes(label=sal_medio), position=position_dodge(width=2), vjust=0.2) +
  ggtitle("Admissões: Salário Médio por Sexo") +
  xlab("Sexo") + 
  ylab("Salário Médio (R$)") 


# DESLIGAMENTOS
#=============================
caged_sal_medio_sexo_des_final <- caged_sal_medio_sexo %>%
  filter(admitidos_desligados == "Desligamentos") %>%
  select(ano_declarado, sexo, tot_sal_mes, qtd_mov) %>%
  group_by(sexo) %>%
  summarise(sal_medio = sum(as.numeric(tot_sal_mes)) / sum(qtd_mov),
            tot_mov = sum(qtd_mov)) %>%
  mutate(tot_mov_milhoes = round(tot_mov / 1000000)) %>%
  mutate(sal_medio = round(sal_medio)) %>%
  arrange(-sal_medio)

# movimnetacao por sexo
caged_sal_medio_sexo_des_final %>%
  ggplot(aes(x=sexo, 
             y=tot_mov_milhoes, 
             fill=sexo)) +
  geom_bar(width = 1, stat = "identity") +
  geom_text(aes(label=tot_mov_milhoes), position=position_dodge(width=2), vjust=0.2) +
  ggtitle("Desligamentos: Total de Movimentaçao por Sexo") +
  xlab("Sexo") + 
  ylab("Total Movimentação (Milhões)")

# salario médio
caged_sal_medio_sexo_des_final %>%
  ggplot(aes(x=sexo, 
             y=sal_medio, 
             fill=sexo)) +
  geom_bar(width = 1, stat = "identity") +
  geom_text(aes(label=sal_medio), position=position_dodge(width=2), vjust=0.2) +
  ggtitle("Desligamentos: Salário Médio por Sexo") +
  xlab("Sexo") + 
  ylab("Salário Médio (R$)") 


#----------------------------------------------------------------------------------------
# saldo
#----------------------------------------------------------------------------------------
file <- paste0(path, "/","caged_compet_admdes.csv")
caged <- read.table(file, sep='|', header = TRUE, check.names = TRUE)
caged$admitidos_desligados <- factor(caged$admitidos_desligados, levels = c(1,2), labels = c("Admissão", "Desligamentos"))
caged$data_declarada <- as.Date(paste0(caged$competencia_declarada,"01"), "%Y%m%d")
caged$mes <- format(caged$data_declarada, format="%m")
caged$competencia_abrv <- format(caged$data_declarada, format="%b")
caged$competencia_ano <- format(caged$data_declarada, format="%b/%Y")




caged_saldo <- caged
rm(caged)

# admissao
caged_competencia_admissao <- caged_saldo %>%
  filter(admitidos_desligados == "Admissão") %>%
  select(mes, count) %>%
  group_by(mes) %>%
  summarise(tot_admitidos = sum(count) / 1000000) %>%
  mutate(tot_admitidos = round(tot_admitidos, digits = 2)) %>%
  arrange(mes)

#sum(caged_competencia_admissao$tot_admitidos)

# desligamento
caged_competencia_desligamento <- caged_saldo %>%
  filter(admitidos_desligados == "Desligamentos") %>%
  select(mes, count) %>%
  group_by(mes) %>%
  summarise(tot_desligamentos = sum(count) / 1000000) %>%
  mutate(tot_desligamentos = round(tot_desligamentos, digits = 2)) %>%
  arrange(mes)

#sum(caged_competencia_desligamento$tot_desligamentos)

caged_competencia_saldo <- inner_join(caged_competencia_admissao, caged_competencia_desligamento
                                      , by = c("mes" = "mes"))
caged_competencia_saldo$saldo <- caged_competencia_saldo$tot_admitidos - caged_competencia_saldo$tot_desligamentos


# exporta data.frame para csv
# diretóro pessoal
setwd("D://Usuários/Rodrigo/GoogleDrive/Compartilhado/UFRGS_TCC/CAGED/sumarizado/")
path <- getwd()
path <- paste0(path, "/caged_competencia_saldo.csv")
write.table(caged_competencia_saldo, path, sep="|", row.names = FALSE)



caged_competencia_saldo %>%
  ggplot(aes(x=mes, 
             y=saldo, 
             fill=saldo)) +
  geom_bar(width = 1, stat = "identity") +
  #geom_text(aes(label=saldo), position=position_dodge(width=2), vjust=0.2) +
  ggtitle("Saldo por Mês") +
  xlab("Mes") + 
  ylab("Saldo (Milhões)")



