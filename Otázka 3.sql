# 3. Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?

with lonske_ceny as (
select 
	potraviny_value, 
	potraviny_name,
	potraviny_year+1 as potraviny_year
from t_petr_novotny_project_sql_primary_final
where 
	values_type like 'potraviny'
)
select
	#p.potraviny_value, 
	p.potraviny_name,
	#p.potraviny_year, 
	p2.potraviny_value as lonske_ceny,
	AVG(ROUND(((p.potraviny_value - p2.potraviny_value) / p2.potraviny_value) * 100, 2)) AS prumerna_zmena_ceny
from t_petr_novotny_project_sql_primary_final as p
left join lonske_ceny as p2 on p2.potraviny_year = p.potraviny_year and p2.potraviny_name = p.potraviny_name 
where 
	p.values_type like 'potraviny'
	and p2.potraviny_value is not null
group by 
	p.potraviny_name 
order by 
	prumerna_zmena_ceny asc
#limit 1;
