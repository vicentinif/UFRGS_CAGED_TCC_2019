# ================================================================================================
# Objetivo:    Extração e Limpeza de dados do CAGED para exportação para CSV
# Aluno:       Rodrigo Vicentini
# Orientador:  Joao Comba
# Motivo:      TCC (2019)
# Curso:       UFRGS - Big Data & Data Science
# ================================================================================================

# pacotes necessários 
#install.packages("tidyverse")
#install.packages("dplyr")
library(tidyverse)
library(dplyr)
library(curl)

for (ano in c(2018:2019)) {
  
  # path para salvar os arquivos
  #path_export <- paste0("D://Usuários//Rodrigo//GoogleDrive//Compartilhado//UFRGS_TCC//CAGED//microdados//compactado//", ano, "/", sep = "")

  # diretóro pessoal
  path <- setwd(paste0("D://Usuários//Rodrigo//GoogleDrive//Compartilhado//UFRGS_TCC//CAGED//microdados//compactado//", ano, "/", sep = ""))
  path <- getwd()
  
  # percorre por todos arquivos no diretório principal
  data.list = list()
  file.list <- list.files(path=path, pattern="*.txt") 
  
  for (i in 1:length(file.list)){
    
    # 1. ler todos arquivos txt
    assign(file.list[i], 
           data.list[[i]] <- read.table(paste0(path, "/", file.list[i])
                                        , sep=';', header = TRUE, check.names = TRUE)
    )
    
    
    # 2. tratar dataset 
    df <- data.frame(Reduce(rbind, data.list[i]))
    #df <- df[df$Município == 431490,] 
    
    df.tratado <- df[c("Admitidos.Desligados", "Ano.Declarado", "Competência.Declarada"
                       , "UF", "Município", "Grau.Instrução", "Idade", "Raça.Cor"
                       , "Sexo", "Salário.Mensal", "Qtd.Hora.Contrat", "Tipo.Mov.Desagregado", "IBGE.Subsetor")]
    
    
    # 3. exportar para csv
    file.list.name <- gsub(pattern = "\\.txt$", ".csv", file.list[i])
    file.csv = paste0(path, sep = "", "/", file.list.name)
    write.table(df.tratado, file = file.csv, sep=";", row.names = FALSE)
    
  }
  
    
}





