SELECT nspname || '.' || relname AS "relation",
    pg_size_pretty(pg_total_relation_size(C.oid)) AS "total_size"
  FROM pg_class C
  LEFT JOIN pg_namespace N ON (N.oid = C.relnamespace)
  WHERE nspname NOT IN ('pg_catalog', 'information_schema')
    AND C.relkind <> 'i'
    AND nspname !~ '^pg_toast'
  ORDER BY pg_total_relation_size(C.oid) DESC
  LIMIT 20;



--drop table caged.caged;
--truncate table caged.caged;

select * from caged.caged;

select substring(cast(competencia_declarada as varchar),5,2) dt from caged.caged;

-- full
select ano_declarado, competencia_declarada, count(*) 
from caged.caged
group by ano_declarado, competencia_declarada
order by ano_declarado, competencia_declarada;


-- 01
select ano_declarado, competencia_declarada, count(*) 
from caged.caged_01
group by ano_declarado, competencia_declarada
order by ano_declarado, competencia_declarada;

-- 02
select ano_declarado, competencia_declarada, count(*) 
from caged.caged_02
group by ano_declarado, competencia_declarada
order by ano_declarado, competencia_declarada;

-- 03
select ano_declarado, competencia_declarada, count(*) 
from caged.caged_03
group by ano_declarado, competencia_declarada
order by ano_declarado, competencia_declarada;

-- 04
select ano_declarado, competencia_declarada, count(*) 
from caged.caged_04
group by ano_declarado, competencia_declarada
order by ano_declarado, competencia_declarada;

-- 05
select ano_declarado, competencia_declarada, count(*) 
from caged.caged_05
group by ano_declarado, competencia_declarada
order by ano_declarado, competencia_declarada;

-- 06
select ano_declarado, competencia_declarada, count(*) 
from caged.caged_06
group by ano_declarado, competencia_declarada
order by ano_declarado, competencia_declarada;

-- 07
select ano_declarado, competencia_declarada, count(*) 
from caged.caged_07
group by ano_declarado, competencia_declarada
order by ano_declarado, competencia_declarada;

-- 08
select ano_declarado, competencia_declarada, count(*) 
from caged.caged_08
group by ano_declarado, competencia_declarada
order by ano_declarado, competencia_declarada;

-- 09
select ano_declarado, competencia_declarada, count(*) 
from caged.caged_09
group by ano_declarado, competencia_declarada
order by ano_declarado, competencia_declarada;

-- 10
select ano_declarado, competencia_declarada, count(1) 
from caged.caged_10
group by ano_declarado, competencia_declarada
order by ano_declarado, competencia_declarada;


-- 11
select ano_declarado, competencia_declarada, count(1) 
from caged.caged_11
group by ano_declarado, competencia_declarada
order by ano_declarado, competencia_declarada;

-- 12
select ano_declarado, competencia_declarada, count(1) 
from caged.caged_12
group by ano_declarado, competencia_declarada
order by ano_declarado, competencia_declarada;


--truncate table caged.caged_05;

/*
select * from caged.caged
where substring(cast(competencia_declarada as varchar),5,2) = '02';
create table caged.caged_02 as
*/



--delete from caged.caged 
--where ano_declarado = 2010
--and competencia_declarada = 201003;

--commit;



/*
CREATE TABLE caged.caged_12 (
	admitidos_desligados int8 NULL,
	ano_declarado int8 NULL,
	competencia_declarada int8 NULL,
	uf text NULL,
	municipio int8 NULL,
	grau_instrucao varchar NULL,
	idade int8 NULL,
	raca_cor int8 NULL,
	sexo int8 NULL,
	salario_mensal numeric(11,2) NULL,
	qtd_hora_contrat int8 NULL,
	tipo_mov_desagregado int8 NULL
);
*/

-- index
CREATE INDEX caged_05_ano_declarado_idx ON caged.caged_05 (ano_declarado);
CREATE INDEX caged_05_competencia_declarada_idx ON caged.caged_05 (competencia_declarada);


-- Queries caged

--caged_compet
   select ano_declarado
		, competencia_declarada
		, count(1) qtd_mov
	 from caged.caged_01
	group by
		  ano_declarado
	    , competencia_declarada                      


-- caged_compet_admdes
  select ano_declarado
	   , competencia_declarada
	   , admitidos_desligados
	   , count(1) qtd_mov
	from caged.caged_01
   group by
		 ano_declarado
	   , competencia_declarada
	   , admitidos_desligados
	   
	   
-- caged_compet_uf_admdes
  select ano_declarado
	   , competencia_declarada
	   , uf
	   , admitidos_desligados
	   , count(1) qtd_mov
	from caged.caged_01
   group by
		 ano_declarado
	   , competencia_declarada
	   , uf	   
	   , admitidos_desligados;
	   
-- caged_compet_admdes_grinstrucao
  select ano_declarado
	   , competencia_declarada
	   , grau_instrucao
	   , admitidos_desligados
	   , count(1) qtd_mov
	from caged.caged_01
   group by
		 ano_declarado
	   , competencia_declarada
	   , grau_instrucao	   
	   , admitidos_desligados	   
	   
	   
-- caged_compet_admdes_idade
  select ano_declarado
	   , competencia_declarada
	   , idade
	   , admitidos_desligados
	   , count(1) qtd_mov
	from caged.caged_01
   group by
		 ano_declarado
	   , competencia_declarada
	   , idade	   
	   , admitidos_desligados	 

	   
-- caged_compet_admdes_racacor
  select ano_declarado
	   , competencia_declarada
	   , raca_cor
	   , admitidos_desligados
	   , count(1) qtd_mov
	from caged.caged_01
   group by
		 ano_declarado
	   , competencia_declarada
	   , raca_cor	   
	   , admitidos_desligados		   
	   
	   
-- caged_compet_admdes_sexo
  select ano_declarado
	   , competencia_declarada
	   , sexo
	   , admitidos_desligados
	   , count(1) qtd_mov
	from caged.caged_01
   group by
		 ano_declarado
	   , competencia_declarada
	   , sexo	   
	   , admitidos_desligados		
	   
	   
-- caged_compet_admdes_desagregado
  select ano_declarado
	   , competencia_declarada
	   , tipo_mov_desagregado
	   , admitidos_desligados
	   , count(1) qtd_mov
	from caged.caged_01
   group by
		 ano_declarado
	   , competencia_declarada
	   , tipo_mov_desagregado	   
	   , admitidos_desligados		   
	   
-- caged_compet_admdes_municipio
  select ano_declarado
	   , municipio
	   , admitidos_desligados
	   , count(1) qtd_mov
	from caged.caged_01
   group by
		 ano_declarado
	   , municipio	   
	   , admitidos_desligados	


-- SALARIO --------------------------------------	

-- caged_compet_admdes_salario_compet
  select ano_declarado
	   , competencia_declarada
	   , admitidos_desligados
	   , count(1) qtd_mov
	   , sum(salario_mensal) tot_sal_mes
	from caged.caged_01
   group by
		 ano_declarado
	   , competencia_declarada	   	   
	   , admitidos_desligados;	


-- caged_compet_admdes_salario_idade
  select ano_declarado
	   , idade
	   , admitidos_desligados
	   , count(1) qtd_mov
	   , sum(salario_mensal) tot_sal_mes
	from caged.caged_01
   group by
		 ano_declarado
	   , idade	   	   
	   , admitidos_desligados;	


-- caged_compet_admdes_salario_sexo
  select ano_declarado
	   , sexo
	   , admitidos_desligados
	   , count(1) qtd_mov
	   , sum(salario_mensal) tot_sal_mes
	from caged.caged_01
   group by
		 ano_declarado
	   , sexo	   	   
	   , admitidos_desligados;	
	  
	  
-- caged_compet_admdes_salario_racacor
  select ano_declarado
	   , racacor
	   , admitidos_desligados
	   , count(1) qtd_mov
	   , sum(salario_mensal) tot_sal_mes
	from caged.caged_01
   group by
		 ano_declarado
	   , racacor	   	   
	   , admitidos_desligados;	
	   
---------------------------------------------------