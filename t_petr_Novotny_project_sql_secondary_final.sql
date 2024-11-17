CREATE OR REPLACE TABLE t_petr_novotny_project_sql_secondary_final AS
SELECT
    e.country AS nazev_zeme, 
    e.year AS rok, 
    e.GDP AS hdp
FROM 
    economies e
LEFT JOIN 
    countries c ON c.country = e.country
WHERE 
    c.continent LIKE 'europe';
