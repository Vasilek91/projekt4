create or replace table t_petr_Novotny_project_sql_secondary_final as 
select
e.country, e.year, e.GDP
from economies e 
left join countries c on c.country = e.country
where c.continent like 'europe';
