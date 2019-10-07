# ================================================================================================
# Objetivo:    Exportação dos Dados Tratados para o PostgreSQL
# Aluno:       Rodrigo Vicentini
# Orientadora: Joao Comba
# Motivo:      TCC (2019)
# Curso:       UFRGS - Big Data & Data Science
# ================================================================================================

# documentação base
#https://nuitrcs.github.io/databases_workshop/r/r_databases.html#connection
#https://stackoverflow.com/questions/45775399/r-connecting-postgres
#https://db.rstudio.com/best-practices/drivers/#microsoft-windows
#https://db.rstudio.com/databases/postgresql/
#https://www.compose.com/articles/connecting-r-and-compose-postgresql/
#https://michaeltoth.me/how-to-write-an-r-data-frame-to-an-sql-table.html
# install.packages("odbc")
# install.packages("DBI")
# install.packages("RPostgreSQL")
# install.packages("blob")
# install.packages('devtools')

# pacotes necessários
library(RPostgreSQL)
library(odbc)
library(DBI)
library(tidyverse)
library(dplyr)
library(stringr)

# diretorio para export/import de arquivos
setwd("D://Usuários/Rodrigo/GoogleDrive/Compartilhado/UFRGS_TCC/CAGED/sumarizado/")
path <- getwd()


#=====================================================================================================================
#  Leitura de Mutiplos DataSets do Banco
#=====================================================================================================================

#------------------------------------------------------------------------------------------------------------------
# caged_compet
#------------------------------------------------------------------------------------------------------------------

# lista para armazenamento dos resultados das consultas
data_list = list()

# loop para leitura de todas tabelas (caged_01 ... caged_12)
for (tab_alias in c(1:12)) {
  
  # conexao postgreSQL na AWS
  m <- dbDriver("PostgreSQL")
  con <- dbConnect(m, user="postgres", password="dbpostgre2019",                   
                   dbname="dw", host="dbpostgresql.czhgm5vrfvge.sa-east-1.rds.amazonaws.com")
  
  # monta nome da tabela
  tab_name <- paste0("caged_", str_pad(tab_alias, 2, pad = "0"))
  
  # query SQL
  query <- paste0("select ano_declarado",
                       ", competencia_declarada",
                       ", count(1) qtd_mov",
                   " from caged.",tab_name,
                  " group by",
                        " ano_declarado",
                       ", competencia_declarada"

  )
  
  # carrega as consultas para um data_list
  assign(tab_name[tab_alias],
         data_list[[tab_alias]] <- dbGetQuery(con, query))

  # fecha conexao com o banco de dados
  dbDisconnect(con)
  
}

# preenche o data frame com todo o resulta do data_list  
caged_compet = do.call(rbind, data_list)

# exporta data.frame para csv
path <- paste0(path, "/caged_compete.csv")
write.table(caged_compet, path, sep="|", row.names = FALSE)




#------------------------------------------------------------------------------------------------------------------
# caged_compet_admdes
#------------------------------------------------------------------------------------------------------------------

# lista para armazenamento dos resultados das consultas
data_list = list()

# loop para leitura de todas tabelas (caged_01 ... caged_12)
for (tab_alias in c(1:12)) {
  
  # conexao postgreSQL na AWS
  m <- dbDriver("PostgreSQL")
  con <- dbConnect(m, user="postgres", password="dbpostgre2019",                   
                   dbname="dw", host="dbpostgresql.czhgm5vrfvge.sa-east-1.rds.amazonaws.com")
  
  # monta nome da tabela
  tab_name <- paste0("caged_", str_pad(tab_alias, 2, pad = "0"))
  
  # query SQL
  query <- paste0("select ano_declarado",
                       ", competencia_declarada",
                       ", admitidos_desligados",
                       ", count(1) qtd_mov",
                   " from caged.",tab_name,
                  " group by",
                        " ano_declarado",
                       ", competencia_declarada",
                       ", admitidos_desligados"

  )
  
  # carrega as consultas para um data_list
  assign(tab_name[tab_alias],
         data_list[[tab_alias]] <- dbGetQuery(con, query))

  # fecha conexao com o banco de dados
  dbDisconnect(con)
  
}

# preenche o data frame com todo o resulta do data_list  
caged_compet_admdes = do.call(rbind, data_list)

# exporta data.frame para csv
path <- paste0(path, "/caged_compet_admdes.csv")
write.table(caged_compet_admdes, path, sep="|", row.names = FALSE)



#------------------------------------------------------------------------------------------------------------------
# caged_compet_admdes_uf
#------------------------------------------------------------------------------------------------------------------

# lista para armazenamento dos resultados das consultas
data_list = list()

# loop para leitura de todas tabelas (caged_01 ... caged_12)
for (tab_alias in c(1:12)) {
  
  # conexao postgreSQL na AWS
  m <- dbDriver("PostgreSQL")
  con <- dbConnect(m, user="postgres", password="dbpostgre2019",                   
                   dbname="dw", host="dbpostgresql.czhgm5vrfvge.sa-east-1.rds.amazonaws.com")
  
  # monta nome da tabela
  tab_name <- paste0("caged_", str_pad(tab_alias, 2, pad = "0"))
  
  # query SQL
  query <- paste0("select ano_declarado",
                       ", competencia_declarada",
                       ", uf",
                       ", admitidos_desligados",
                       ", count(1) qtd_mov",
                   " from caged.",tab_name,
                  " group by",
                        " ano_declarado",
                       ", competencia_declarada",
                       ", uf",
                       ", admitidos_desligados"

  )
  
  # carrega as consultas para um data_list
  assign(tab_name[tab_alias],
         data_list[[tab_alias]] <- dbGetQuery(con, query))

  # fecha conexao com o banco de dados
  dbDisconnect(con)
  
}

# preenche o data frame com todo o resulta do data_list  
caged_compet_admdes_uf = do.call(rbind, data_list)

# exporta data.frame para csv
path <- paste0(path, "/caged_compet_admdes_uf.csv")
write.table(caged_compet_admdes_uf, path, sep="|", row.names = FALSE)


#------------------------------------------------------------------------------------------------------------------
# caged_compet_admdes_grinstrucao
#------------------------------------------------------------------------------------------------------------------

# lista para armazenamento dos resultados das consultas
data_list = list()

# loop para leitura de todas tabelas (caged_01 ... caged_12)
for (tab_alias in c(1:12)) {
  
  # conexao postgreSQL na AWS
  m <- dbDriver("PostgreSQL")
  con <- dbConnect(m, user="postgres", password="dbpostgre2019",                   
                   dbname="dw", host="dbpostgresql.czhgm5vrfvge.sa-east-1.rds.amazonaws.com")
  
  # monta nome da tabela
  tab_name <- paste0("caged_", str_pad(tab_alias, 2, pad = "0"))
  
  # query SQL
  query <- paste0("select ano_declarado",
                       ", competencia_declarada",
                       ", grau_instrucao",
                       ", admitidos_desligados",
                       ", count(1) qtd_mov",
                   " from caged.",tab_name,
                  " group by",
                        " ano_declarado",
                       ", competencia_declarada",
                       ", grau_instrucao",
                       ", admitidos_desligados"

  )
  
  # carrega as consultas para um data_list
  assign(tab_name[tab_alias],
         data_list[[tab_alias]] <- dbGetQuery(con, query))

  # fecha conexao com o banco de dados
  dbDisconnect(con)
  
}

# preenche o data frame com todo o resulta do data_list  
caged_compet_admdes_grinstrucao = do.call(rbind, data_list)

# exporta data.frame para csv
path <- paste0(path, "/caged_compet_admdes_grinstrucao.csv")
write.table(caged_compet_admdes_grinstrucao, path, sep="|", row.names = FALSE)



#------------------------------------------------------------------------------------------------------------------
# caged_compet_admdes_idade
#------------------------------------------------------------------------------------------------------------------

# lista para armazenamento dos resultados das consultas
data_list = list()

# loop para leitura de todas tabelas (caged_01 ... caged_12)
for (tab_alias in c(1:12)) {
  
  # conexao postgreSQL na AWS
  m <- dbDriver("PostgreSQL")
  con <- dbConnect(m, user="postgres", password="dbpostgre2019",                   
                   dbname="dw", host="dbpostgresql.czhgm5vrfvge.sa-east-1.rds.amazonaws.com")
  
  # monta nome da tabela
  tab_name <- paste0("caged_", str_pad(tab_alias, 2, pad = "0"))
  
  # query SQL
  query <- paste0("select ano_declarado",
                       ", competencia_declarada",
                       ", idade",
                       ", admitidos_desligados",
                       ", count(1) qtd_mov",
                   " from caged.",tab_name,
                  " group by",
                        " ano_declarado",
                       ", competencia_declarada",
                       ", idade",
                       ", admitidos_desligados"

  )
  
  # carrega as consultas para um data_list
  assign(tab_name[tab_alias],
         data_list[[tab_alias]] <- dbGetQuery(con, query))

  # fecha conexao com o banco de dados
  dbDisconnect(con)
  
}

# preenche o data frame com todo o resulta do data_list  
caged_compet_admdes_idade = do.call(rbind, data_list)

# exporta data.frame para csv
path <- paste0(path, "/caged_compet_admdes_idade.csv")
write.table(caged_compet_admdes_idade, path, sep="|", row.names = FALSE)


#------------------------------------------------------------------------------------------------------------------
# caged_compet_admdes_racacor
#------------------------------------------------------------------------------------------------------------------

# lista para armazenamento dos resultados das consultas
data_list = list()

# loop para leitura de todas tabelas (caged_01 ... caged_12)
for (tab_alias in c(1:12)) {
  
  # conexao postgreSQL na AWS
  m <- dbDriver("PostgreSQL")
  con <- dbConnect(m, user="postgres", password="dbpostgre2019",                   
                   dbname="dw", host="dbpostgresql.czhgm5vrfvge.sa-east-1.rds.amazonaws.com")
  
  # monta nome da tabela
  tab_name <- paste0("caged_", str_pad(tab_alias, 2, pad = "0"))
  
  # query SQL
  query <- paste0("select ano_declarado",
                       ", competencia_declarada",
                       ", raca_cor",
                       ", admitidos_desligados",
                       ", count(1) qtd_mov",
                   " from caged.",tab_name,
                  " group by",
                        " ano_declarado",
                       ", competencia_declarada",
                       ", raca_cor",
                       ", admitidos_desligados"

  )
  
  # carrega as consultas para um data_list
  assign(tab_name[tab_alias],
         data_list[[tab_alias]] <- dbGetQuery(con, query))

  # fecha conexao com o banco de dados
  dbDisconnect(con)
  
}

# preenche o data frame com todo o resulta do data_list  
caged_compet_admdes_racacor = do.call(rbind, data_list)

# exporta data.frame para csv
path <- paste0(path, "/caged_compet_admdes_racacor.csv")
write.table(caged_compet_admdes_racacor, path, sep="|", row.names = FALSE)


#------------------------------------------------------------------------------------------------------------------
# caged_compet_admdes_sexo
#------------------------------------------------------------------------------------------------------------------

# lista para armazenamento dos resultados das consultas
data_list = list()

# loop para leitura de todas tabelas (caged_01 ... caged_12)
for (tab_alias in c(1:12)) {
  
  # conexao postgreSQL na AWS
  m <- dbDriver("PostgreSQL")
  con <- dbConnect(m, user="postgres", password="dbpostgre2019",                   
                   dbname="dw", host="dbpostgresql.czhgm5vrfvge.sa-east-1.rds.amazonaws.com")
  
  # monta nome da tabela
  tab_name <- paste0("caged_", str_pad(tab_alias, 2, pad = "0"))
  
  # query SQL
  query <- paste0("select ano_declarado",
                       ", competencia_declarada",
                       ", sexo",
                       ", admitidos_desligados",
                       ", count(1) qtd_mov",
                   " from caged.",tab_name,
                  " group by",
                        " ano_declarado",
                       ", competencia_declarada",
                       ", sexo",
                       ", admitidos_desligados"

  )
  
  # carrega as consultas para um data_list
  assign(tab_name[tab_alias],
         data_list[[tab_alias]] <- dbGetQuery(con, query))

  # fecha conexao com o banco de dados
  dbDisconnect(con)
  
}

# preenche o data frame com todo o resulta do data_list  
caged_compet_admdes_sexo = do.call(rbind, data_list)

# exporta data.frame para csv
path <- paste0(path, "/caged_compet_admdes_sexo.csv")
write.table(caged_compet_admdes_sexo, path, sep="|", row.names = FALSE)


#------------------------------------------------------------------------------------------------------------------
# caged_compet_admdes_desagregado
#------------------------------------------------------------------------------------------------------------------

# lista para armazenamento dos resultados das consultas
data_list = list()

# loop para leitura de todas tabelas (caged_01 ... caged_12)
for (tab_alias in c(1:12)) {
  
  # conexao postgreSQL na AWS
  m <- dbDriver("PostgreSQL")
  con <- dbConnect(m, user="postgres", password="dbpostgre2019",                   
                   dbname="dw", host="dbpostgresql.czhgm5vrfvge.sa-east-1.rds.amazonaws.com")
  
  # monta nome da tabela
  tab_name <- paste0("caged_", str_pad(tab_alias, 2, pad = "0"))
  
  # query SQL
  query <- paste0("select ano_declarado",
                       ", competencia_declarada",
                       ", tipo_mov_desagregado",
                       ", admitidos_desligados",
                       ", count(1) qtd_mov",
                   " from caged.",tab_name,
                  " group by",
                        " ano_declarado",
                       ", competencia_declarada",
                       ", tipo_mov_desagregado",
                       ", admitidos_desligados"

  )
  
  # carrega as consultas para um data_list
  assign(tab_name[tab_alias],
         data_list[[tab_alias]] <- dbGetQuery(con, query))

  # fecha conexao com o banco de dados
  dbDisconnect(con)
  
}

# preenche o data frame com todo o resulta do data_list  
caged_compet_admdes_desagregado = do.call(rbind, data_list)

# exporta data.frame para csv
path <- paste0(path, "/caged_compet_admdes_desagregado.csv")
write.table(caged_compet_admdes_desagregado, path, sep="|", row.names = FALSE)



#------------------------------------------------------------------------------------------------------------------
# caged_ano_admdes_municipio
#------------------------------------------------------------------------------------------------------------------

# lista para armazenamento dos resultados das consultas
data_list = list()

# loop para leitura de todas tabelas (caged_01 ... caged_12)
for (tab_alias in c(1:12)) {
  
  # conexao postgreSQL na AWS
  m <- dbDriver("PostgreSQL")
  con <- dbConnect(m, user="postgres", password="dbpostgre2019",                   
                   dbname="dw", host="dbpostgresql.czhgm5vrfvge.sa-east-1.rds.amazonaws.com")
  
  # monta nome da tabela
  tab_name <- paste0("caged_", str_pad(tab_alias, 2, pad = "0"))
  
  # query SQL
  query <- paste0("select ano_declarado",
                       ", municipio",
                       ", admitidos_desligados",
                       ", count(1) qtd_mov",
                   " from caged.",tab_name,
                  " group by",
                        " ano_declarado",
                       ", municipio",
                       ", admitidos_desligados"

  )
  
  # carrega as consultas para um data_list
  assign(tab_name[tab_alias],
         data_list[[tab_alias]] <- dbGetQuery(con, query))

  # fecha conexao com o banco de dados
  dbDisconnect(con)
  
}

# preenche o data frame com todo o resulta do data_list  
caged_ano_admdes_municipio = do.call(rbind, data_list)

# exporta data.frame para csv
path <- paste0(path, "/caged_ano_admdes_municipio.csv")
write.table(caged_ano_admdes_municipio, path, sep="|", row.names = FALSE)




################################################# SALARIO ###########################################################

#------------------------------------------------------------------------------------------------------------------
# caged_compet_admdes_salario_compet
#------------------------------------------------------------------------------------------------------------------

# lista para armazenamento dos resultados das consultas
data_list = list()

# loop para leitura de todas tabelas (caged_01 ... caged_12)
for (tab_alias in c(1:12)) {
  
  # conexao postgreSQL na AWS
  m <- dbDriver("PostgreSQL")
  con <- dbConnect(m, user="postgres", password="dbpostgre2019",                   
                   dbname="dw", host="dbpostgresql.czhgm5vrfvge.sa-east-1.rds.amazonaws.com")
  
  # monta nome da tabela
  tab_name <- paste0("caged_", str_pad(tab_alias, 2, pad = "0"))
  
  # query SQL
  query <- paste0("select ano_declarado",
                  ", competencia_declarada",
                  ", admitidos_desligados",
                  ", count(1) qtd_mov",
                  ", sum(salario_mensal) tot_sal_mes",
                  " from caged.",tab_name,
                  " group by",
                  " ano_declarado",
                  ", competencia_declarada",
                  ", admitidos_desligados"
                  
  )
  
  # carrega as consultas para um data_list
  assign(tab_name[tab_alias],
         data_list[[tab_alias]] <- dbGetQuery(con, query))
  
  # fecha conexao com o banco de dados
  dbDisconnect(con)
  
}

# preenche o data frame com todo o resulta do data_list  
caged_compet_admdes_salario_compet = do.call(rbind, data_list)

# exporta data.frame para csv
path <- paste0(path, "/caged_compet_admdes_salario_compet.csv")
write.table(caged_compet_admdes_salario_compet, path, sep="|", row.names = FALSE)



#------------------------------------------------------------------------------------------------------------------
# caged_compet_admdes_salario_idade
#------------------------------------------------------------------------------------------------------------------

# lista para armazenamento dos resultados das consultas
data_list = list()

# loop para leitura de todas tabelas (caged_01 ... caged_12)
for (tab_alias in c(1:12)) {
  
  # conexao postgreSQL na AWS
  m <- dbDriver("PostgreSQL")
  con <- dbConnect(m, user="postgres", password="dbpostgre2019",                   
                   dbname="dw", host="dbpostgresql.czhgm5vrfvge.sa-east-1.rds.amazonaws.com")
  
  # monta nome da tabela
  tab_name <- paste0("caged_", str_pad(tab_alias, 2, pad = "0"))
  
  # query SQL
  query <- paste0("select ano_declarado",
                  ", idade",
                  ", admitidos_desligados",
                  ", count(1) qtd_mov",
                  ", sum(salario_mensal) tot_sal_mes",
                  " from caged.",tab_name,
                  " group by",
                  " ano_declarado",
                  ", idade",
                  ", admitidos_desligados"
                  
  )
  
  # carrega as consultas para um data_list
  assign(tab_name[tab_alias],
         data_list[[tab_alias]] <- dbGetQuery(con, query))
  
  # fecha conexao com o banco de dados
  dbDisconnect(con)
  
}

# preenche o data frame com todo o resulta do data_list  
caged_compet_admdes_salario_idade = do.call(rbind, data_list)

# exporta data.frame para csv
path <- paste0(path, "/caged_compet_admdes_salario_idade.csv")
write.table(caged_compet_admdes_salario_idade, path, sep="|", row.names = FALSE)




#------------------------------------------------------------------------------------------------------------------
# caged_compet_admdes_salario_sexo
#------------------------------------------------------------------------------------------------------------------

# lista para armazenamento dos resultados das consultas
data_list = list()

# loop para leitura de todas tabelas (caged_01 ... caged_12)
for (tab_alias in c(1:12)) {
  
  # conexao postgreSQL na AWS
  m <- dbDriver("PostgreSQL")
  con <- dbConnect(m, user="postgres", password="dbpostgre2019",                   
                   dbname="dw", host="dbpostgresql.czhgm5vrfvge.sa-east-1.rds.amazonaws.com")
  
  # monta nome da tabela
  tab_name <- paste0("caged_", str_pad(tab_alias, 2, pad = "0"))
  
  # query SQL
  query <- paste0("select ano_declarado",
                  ", sexo",
                  ", admitidos_desligados",
                  ", count(1) qtd_mov",
                  ", sum(salario_mensal) tot_sal_mes",
                  " from caged.",tab_name,
                  " group by",
                  " ano_declarado",
                  ", sexo",
                  ", admitidos_desligados"
                  
  )
  
  # carrega as consultas para um data_list
  assign(tab_name[tab_alias],
         data_list[[tab_alias]] <- dbGetQuery(con, query))
  
  # fecha conexao com o banco de dados
  dbDisconnect(con)
  
}

# preenche o data frame com todo o resulta do data_list  
caged_compet_admdes_salario_sexo = do.call(rbind, data_list)

# exporta data.frame para csv
path <- paste0(path, "/caged_compet_admdes_salario_sexo.csv")
write.table(caged_compet_admdes_salario_sexo, path, sep="|", row.names = FALSE)



#------------------------------------------------------------------------------------------------------------------
# caged_compet_admdes_salario_racacor
#------------------------------------------------------------------------------------------------------------------

# lista para armazenamento dos resultados das consultas
data_list = list()

# loop para leitura de todas tabelas (caged_01 ... caged_12)
for (tab_alias in c(1:12)) {
  
  # conexao postgreSQL na AWS
  m <- dbDriver("PostgreSQL")
  con <- dbConnect(m, user="postgres", password="dbpostgre2019",                   
                   dbname="dw", host="dbpostgresql.czhgm5vrfvge.sa-east-1.rds.amazonaws.com")
  
  # monta nome da tabela
  tab_name <- paste0("caged_", str_pad(tab_alias, 2, pad = "0"))
  
  # query SQL
  query <- paste0("select ano_declarado",
                  ", raca_cor",
                  ", admitidos_desligados",
                  ", count(1) qtd_mov",
                  ", sum(salario_mensal) tot_sal_mes",
                  " from caged.",tab_name,
                  " group by",
                  " ano_declarado",
                  ", raca_cor",
                  ", admitidos_desligados"
                  
  )
  
  # carrega as consultas para um data_list
  assign(tab_name[tab_alias],
         data_list[[tab_alias]] <- dbGetQuery(con, query))
  
  # fecha conexao com o banco de dados
  dbDisconnect(con)
  
}

# preenche o data frame com todo o resulta do data_list  
caged_compet_admdes_salario_racacor = do.call(rbind, data_list)

# exporta data.frame para csv
path <- paste0(path, "/caged_compet_admdes_salario_racacor.csv")
write.table(caged_compet_admdes_salario_racacor, path, sep="|", row.names = FALSE)




#------------------------------------------------------------------------------------------------------------------
# caged_compet_admdes_salario_grau_instru
#------------------------------------------------------------------------------------------------------------------

# lista para armazenamento dos resultados das consultas
data_list = list()

# loop para leitura de todas tabelas (caged_01 ... caged_12)
for (tab_alias in c(1:12)) {
  
  # conexao postgreSQL na AWS
  m <- dbDriver("PostgreSQL")
  con <- dbConnect(m, user="postgres", password="dbpostgre2019",                   
                   dbname="dw", host="dbpostgresql.czhgm5vrfvge.sa-east-1.rds.amazonaws.com")
  
  # monta nome da tabela
  tab_name <- paste0("caged_", str_pad(tab_alias, 2, pad = "0"))
  
  # query SQL
  query <- paste0("select ano_declarado",
                  ", grau_instrucao",
                  ", admitidos_desligados",
                  ", count(1) qtd_mov",
                  ", sum(salario_mensal) tot_sal_mes",
                  " from caged.",tab_name,
                  " group by",
                  " ano_declarado",
                  ", grau_instrucao",
                  ", admitidos_desligados"
                  
  )
  
  # carrega as consultas para um data_list
  assign(tab_name[tab_alias],
         data_list[[tab_alias]] <- dbGetQuery(con, query))
  
  # fecha conexao com o banco de dados
  dbDisconnect(con)
  
}

# preenche o data frame com todo o resulta do data_list  
caged_compet_admdes_salario_grau_instru = do.call(rbind, data_list)

# exporta data.frame para csv
path <- paste0(path, "/caged_compet_admdes_salario_grau_instru.csv")
write.table(caged_compet_admdes_salario_grau_instru, path, sep="|", row.names = FALSE)


