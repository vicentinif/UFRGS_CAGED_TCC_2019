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


#----------------------------------------------------------------
# dimSubsetor
#----------------------------------------------------------------

Id.Subsetor <- c(  1,2,3,4,5,6,7,8
                   ,9,10,11,12,13,14
                   ,15,16,17,18,19
                   ,20,21,22,23,24,25
                   ,-1)

Subsetor <- c(   'Extrativa mineral'
               ,'Indústria de produtos minerais nao metálicos'
               ,'Indústria metalúrgica'
               ,'Indústria mecânica'
               ,'Indústria do material elétrico e de comunicaçoes'
               ,'Indústria do material de transporte'
               ,'Indústria da madeira e do mobiliário'
               ,'Indústria do papel, papelao, editorial e gráfica'
               ,'Ind. da borracha, fumo, couros, peles, similares, ind. diversas'
               ,'Ind. química de produtos farmacêuticos, veterinários, perfumaria'
               ,'Indústria têxtil do vestuário e artefatos de tecidos'
               ,'Indústria de calçados'
               ,'Indústria de produtos alimentícios, bebidas e álcool etílico'
               ,'Serviços industriais de utilidade pública'
               ,'Construçao civil'
               ,'Comércio varejista'
               ,'Comércio atacadista'
               ,'Instituiçoes de crédito, seguros e capitalizaçao'
               ,'Com. e administraçao de imóveis, valores mobiliários, serv. Técnico'
               ,'Transportes e comunicaçoes'
               ,'Serv. de alojamento, alimentaçao, reparaçao, manutençao, redaçao'
               ,'Serviços médicos, odontológicos e veterinários'
               ,'Ensino'
               ,'Administraçao pública direta e autárquica'
               ,'Agricultura, silvicultura, criaçao de animais, extrativismo vegetal'
               ,'Ignorado')


dimSubsetor <- data.frame(Id.Subsetor, Subsetor)

# gerar arquivo csv das DIMs
path <- setwd("D://Usuários//Rodrigo//GoogleDrive//Compartilhado//UFRGS_TCC//CAGED//microdados//formato_csv")
write.csv(dimGrauInstrucao, file = "dimGrauInstrucao.csv" ,row.names=FALSE)
write.csv(dimRacaCor, file = "dimRacaCor.csv" ,row.names=FALSE)
write.csv(dimSexo, file = "dimSexo.csv" ,row.names=FALSE)
write.csv(dimTipoMovDesagregado, file = "dimTipoMovDesagregado.csv" ,row.names=FALSE)
write.csv(dimSubsetor, file = "dimSubsetor.csv" ,row.names=FALSE)

#list.file.names <- c(dimGrauInstrucao, dimRacaCor, dimSexo, dimRacaCor, dimTipoMovDesagregado)

# for (i in 1:length(list.file.names)) {
#   print(list.file.names[i])
#   
#   write.csv(list.file.names[i], file = paste0(list.file.names[i],".csv") ,row.names=FALSE)
#   
# }



