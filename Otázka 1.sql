# 1. Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?

SELECT 
	mzdy_industry_name AS odvetvi,    
	mzdy_year AS rok, 
    mzdy_value AS 'Průměrná výplata'
FROM 
t_petr_novotny_project_sql_primary_final
WHERE 
    mzdy_industry_name is not null
ORDER BY 
	odvetvi,
	rok;
