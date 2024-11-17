# 2. Kolik je možné si koupit *litrů mléka* a *kilogramů chleba* za první a poslední srovnatelné období v dostupných datech cen a mezd?
# ceny potravin od roku 2006 do roku 2018 | mzdy jsou od roku 2000 do 2021
# 4 čísla, kolik se dá koupit litrů mléka v roce 2006 za průměrnou mzdu v roce 2006 a v roce 2018 a to samé pro chleba

select
potr.potraviny_rok,
potr.potraviny_hodnota,
potr.potraviny_jmeno,
mzdy.potraviny_hodnota,
round((mzdy.potraviny_hodnota/potr.potraviny_hodnota),2) as kupni_sila
from t_petr_novotny_project_sql_primary_final as potr
left join t_petr_novotny_project_sql_primary_final as mzdy on mzdy.mzdy_rok = potr.potraviny_rok 
where (potr.potraviny_jmeno in ('mléko polotučné pasterované', 'Chléb konzumní kmínový'))
and (potr.potraviny_rok = (
        SELECT MIN(potraviny_rok) 
        FROM t_petr_novotny_project_sql_primary_final 
        )
        or
        potr.potraviny_rok = (
        select max(potraviny_rok)
        from t_petr_novotny_project_sql_primary_final
        ))
and mzdy.mzdy_industry_jmeno like 'republikový průměr';
