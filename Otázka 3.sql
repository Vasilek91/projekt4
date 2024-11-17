# 3. Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?

with lonske_ceny as (
select 
	potraviny_hodnota, 
	potraviny_jmeno,
	potraviny_rok+1 as potraviny_rok
from t_petr_novotny_project_sql_primary_final
where 
	hodnoty_typ like 'potraviny'
)
select
	#p.potraviny_hodnota, 
	p.potraviny_jmeno,
	#p.potraviny_rok, 
	p2.potraviny_hodnota as lonske_ceny,
	AVG(ROUND(((p.potraviny_hodnota - p2.potraviny_hodnota) / p2.potraviny_hodnota) * 100, 2)) AS prumerna_zmena_ceny
from t_petr_novotny_project_sql_primary_final as p
left join lonske_ceny as p2 on p2.potraviny_rok = p.potraviny_rok and p2.potraviny_jmeno = p.potraviny_jmeno 
where 
	p.hodnoty_typ like 'potraviny'
	and p2.potraviny_hodnota is not null
group by 
	p.potraviny_jmeno 
order by 
	prumerna_zmena_ceny asc
#limit 1;
