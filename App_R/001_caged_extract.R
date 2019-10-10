# ================================================================================================
# Objetivo:    Aquisição dos Dados
# Aluno:       Rodrigo Vicentini
# Orientador:  Joao Comba
# Motivo:      TCC (2019)
# Curso:       UFRGS - Big Data & Data Science
# ================================================================================================

# ref:
# https://stackoverflow.com/questions/36645445/downloading-files-from-ftp-with-r
# http://theautomatic.net/2018/07/11/manipulate-files-r/

# bibliotecas
library(curl)


# serie historica 10 anos
# ano <- c(2010:2019)

# monta urls para download dos arquivos
for (ano in c(2019:2019)) {
  url <- paste0("ftp://ftp.mtps.gov.br/pdet/microdados/CAGED/", ano, "/", sep = "")
  h = new_handle(dirlistonly=TRUE)
  con = curl(url, "r", h)
  tbl = read.table(con, stringsAsFactors=TRUE, fill=TRUE)
  close(con)
  head(tbl)
  
  if (ano == 2019) {
    urls <- paste0(url, tbl[1:8,1])
  }else{urls <- paste0(url, tbl[1:12,1])}
  
  fls = basename(urls)
  
  # path para salvar os arquivos
  path_export <- paste0("D://Usuários//Rodrigo//GoogleDrive//Compartilhado//UFRGS_TCC//CAGED//microdados//compactado//", ano, "/", sep = "")
  
  # verifica se diretorio existe, senão cria
  if (dir.exists(path_export) == FALSE) {
     dir.create(path_export)
     setwd(path_export)
  }
  
  # faz a leitura de todos arquivos do ano
  # salva no diretorio padrão do R (C:\Users\Rodrigo\Documents)
  for(i in 1:length(urls)){
    curl_fetch_disk(urls[i], fls[i])}
}



