# ================================================================================================
# Objetivo:    Descompactacao do Arquivos CAGED
# Aluno:       Rodrigo Vicentini
# Orientador:  Joao Comba
# Motivo:      TCC (2019)
# Curso:       UFRGS - Big Data & Data Science
# ================================================================================================


# 01) ler os dados em formato *.7z 
for (ano in c(2019:2019)) {
  url <- paste0("D://Usuários//Rodrigo//GoogleDrive//Compartilhado//UFRGS_TCC//CAGED//microdados//compactado//", ano, "/", sep = "")
  h = new_handle(dirlistonly=TRUE)
  con = curl(url, "r", h)
  tbl = read.table(con, stringsAsFactors=TRUE, fill=TRUE)
  close(con)
  head(tbl)
  
  if (ano == 2019) {
    urls <- paste0(url, tbl[1:3,1])
  }else{urls <- paste0(url, tbl[1:12,1])}
  
  fls = basename(urls)
  
  
  # path para salvar os arquivos
  path_export <- paste0("D://Usuários//Rodrigo//GoogleDrive//Compartilhado//UFRGS_TCC//CAGED//microdados//formato_texto//", ano, "/", sep = "")
  
  # verifica se diretorio existe, senão cria
  if (dir.exists(path_export) == FALSE) {
    dir.create(path_export)
    setwd(path_export)
  }
  
  # faz a leitura de todos arquivos do ano
  for(i in 1:length(urls)){
    #curl_fetch_disk(urls[i], fls[i])}  
    unzip(fls[i])
        
    }
  
}

zipF<- "D://Usuários//Rodrigo//GoogleDrive//Compartilhado//UFRGS_TCC//CAGED//microdados//compactado//2019//CAGEDEST_012019.zip"
#outDir<-"D://Usuários//Rodrigo//GoogleDrive//Compartilhado//UFRGS_TCC//CAGED//microdados//formato_texto//2019/"
outDir<- "c://temp/"

df <- zipF
unzip(zipF, tempdir())
download.file(zipF, exdir = "file_name")


url = "D://Usuários//Rodrigo//GoogleDrive//Compartilhado//UFRGS_TCC//CAGED//microdados//compactado//2019//CAGEDEST_012019.zip"
download.file(url, "CAGEDEST_012019.zip") # download file
unzip("CAGEDEST_012019.zip", exdir = "data") # unzip files






# 02) tratar os dados para selecação de atributos de interesse

# 03) converter os dados em formato csv particonadados mes/ano




