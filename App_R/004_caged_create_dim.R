# ================================================================================================
# Objetivo:    Construção das Dimensões para o formato CSV
# Aluno:       Rodrigo Vicentini
# Orientador:  Joao Comba
# Motivo:      TCC (2019)
# Curso:       UFRGS - Big Data & Data Science
# ================================================================================================
# monta DIMs

#----------------------------------------------------------------
# dimGrauInstrucao
#----------------------------------------------------------------

Id.Grau.Instrucao <- c(1,
                       2,
                       3,
                       4,
                       5,
                       6,
                       7,
                       8,
                       9,
                       10,
                       11,
                       -1)

Grau.Instrucao <- c('Analfabeto',
                    'Até 5ª Incompleto',
                    '5ª Completo Fundamental',
                    '6ª a 9ª Fundamental',
                    'Fundamental Completo',
                    'Médio Incompleto',
                    'Médio Completo',
                    'Superior Incompleto',
                    'Superior Completo',
                    'Mestrado',
                    'Doutorado',
                    'Ignorado'
)



dimGrauInstrucao <- data.frame(Id.Grau.Instrucao, Grau.Instrucao)

#----------------------------------------------------------------
# dimMunicipio - IBGE
#----------------------------------------------------------------


#----------------------------------------------------------------
# dimRaçaCor
#----------------------------------------------------------------

Id.Raca.Cor <- c(  1
                   ,2
                   ,4
                   ,6
                   ,8
                   ,9
                   ,-1)

Raca.Cor <- c(  'Indigena'
                ,'Branca'
                ,'Preta'
                ,'Amarela'
                ,'Parda'
                ,'Nao ident'
                ,'Ignorado')


dimRacaCor <- data.frame(Id.Raca.Cor, Raca.Cor)
#----------------------------------------------------------------
# dimSexo
#----------------------------------------------------------------

IdSexo <- c( 1
             ,2
             ,-1)

Sexo <- c( 'Masculino'
           ,'Feminino'
           ,'Ignorado')

dimSexo <- data.frame(IdSexo, Sexo)

#----------------------------------------------------------------
# dimTipoMovDesagregado
#----------------------------------------------------------------

Id.Tipo.Mov.Desagregado <- c( 1
                              ,2
                              ,3
                              ,4
                              ,5
                              ,6
                              ,7
                              ,8
                              ,9
                              ,10
                              ,11
                              ,25
                              ,43
                              ,90)


Tipo.Mov.Desagregado <- c( 'Admissão por Primeiro Emprego'
                           ,'Admissão por Reemprego'
                           ,'Admissão por Transferência'
                           ,'Desligamento por Demissão sem Justa Causa'
                           ,'Desligamento por Demissão com Justa Causa'
                           ,'Desligamento a Pedido'
                           ,'Desligamento por Aposentadoria'
                           ,'Desligamento por Morte'
                           ,'Desligamento por Transferência'
                           ,'Admissão por Reintegraçao'
                           ,'Desligamento por Término de Contrato'
                           ,'Contrato Trabalho Prazo Determinado'
                           ,'Término Contrato Trabalho Prazo Determinado'
                           ,'Desliamento por Acordo Empregado e Empregador')

dimTipoMovDesagregado <- data.frame(Id.Tipo.Mov.Desagregado, Tipo.Mov.Desagregado)


# gerar arquivo csv das DIMs
path <- setwd("C://Users//rodrigo.ferreira//Google Drive//Compartilhado//UFRGS_TCC//CAGED//microdados//formato_csv")
write.csv(dimGrauInstrucao, file = "dimGrauInstrucao.csv" ,row.names=FALSE)
write.csv(dimRacaCor, file = "dimRacaCor.csv" ,row.names=FALSE)
write.csv(dimSexo, file = "dimSexo.csv" ,row.names=FALSE)
write.csv(dimTipoMovDesagregado, file = "dimTipoMovDesagregado.csv" ,row.names=FALSE)

#list.file.names <- c(dimGrauInstrucao, dimRacaCor, dimSexo, dimRacaCor, dimTipoMovDesagregado)

# for (i in 1:length(list.file.names)) {
#   print(list.file.names[i])
#   
#   write.csv(list.file.names[i], file = paste0(list.file.names[i],".csv") ,row.names=FALSE)
#   
# }



