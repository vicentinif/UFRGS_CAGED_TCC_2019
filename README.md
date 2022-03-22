# UFRGS TCC CAGED 2019
# Especialização em Big Data & Data Science
Código fontes desenvolvido como complemento da monografia Análise da Série Histórica dos Dados do Cadastro Geral de Empregados e Desempregados
Aluno: Rodrigo Vicentini. Orientador: Prof. Dr. João Comba

# App R

Aquisição dos Dados: 001_caged_extract.R

Descompactacao do Arquivos CAGED: 002_caged_unzip.R

Extração e Limpeza de dados do CAGED para exportação para CSV: 003_caged_to_csv.R

Construção das Dimensões para o formato CSV: 004_caged_create_dim.R

Plotagem dos dados CAGED: 005_caged_exploratorio.R

Exportação dos Dados Tratados para o PostgreSQL: 007_caged_postgresSQL.R

Análises dos Dados CAGED: 008_caged_analise.R

# kettle

load_caged_to_db.ktr

load_files_caged_to_db.ktr

# scripts_postrgresql

cage_scripts.sql

fim do readme
