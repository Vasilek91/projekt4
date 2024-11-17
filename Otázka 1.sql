# 1. Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?
   
SELECT 
    odvetvi_mzdy AS odvetvi,    
    rok_mzdy AS rok, 
    prumerna_mzda AS 'Průměrná výplata',
    prumerna_mzda - LAG(prumerna_mzda) OVER (PARTITION BY odvetvi_mzdy ORDER BY rok_mzdy) AS 'Meziroční změna'
FROM 
    t_petr_novotny_project_sql_primary_final
WHERE 
    odvetvi_mzdy IS NOT NULL
ORDER BY 
    odvetvi,
    rok;
