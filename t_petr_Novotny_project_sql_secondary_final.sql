CREATE TABLE t_petr_novotny_project_sql_secondary_final AS
SELECT
    e.country AS country_name, 
    e.year AS year, 
    e.GDP AS gdp
FROM 
    economies e
LEFT JOIN 
    countries c ON c.country = e.country
WHERE 
    c.continent LIKE 'europe';
