# 5. Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo násdujícím roce výraznějším růstem?

WITH potraviny AS (
    SELECT 
        AVG(potraviny_value) AS prumerna_cena, 
        potraviny_year AS rok
    FROM 
        t_petr_novotny_project_sql_primary_final
    WHERE 
        values_type = 'potraviny'
    GROUP BY
        potraviny_year
),
rust_potravin AS (
    SELECT 
        p.rok,
        ((p.prumerna_cena - LAG(p.prumerna_cena) OVER (ORDER BY p.rok)) / LAG(p.prumerna_cena) OVER (ORDER BY p.rok)) * 100 AS rust_cen_potravin
    FROM 
        potraviny AS p
),
hdp_rust AS (
    SELECT 
        year AS rok,
        gdp AS hdp_hodnota,
        ((gdp - LAG(gdp) OVER (ORDER BY year)) / LAG(gdp) OVER (ORDER BY year)) * 100 AS hdp_rust
    FROM 
        economies
    WHERE 
        country = 'Czech Republic'
),
prumerne_mzdy AS (
    SELECT 
        mzdy_year AS rok,
        AVG(mzdy_value) AS prumerna_mzda
    FROM 
        t_petr_novotny_project_sql_primary_final
    WHERE 
        values_type = 'mzdy'
        AND mzdy_industry_name = 'republikový průměr'
    GROUP BY 
        mzdy_year
),
rust_mezd AS (
    SELECT 
        pm.rok,
        ((pm.prumerna_mzda - LAG(pm.prumerna_mzda) OVER (ORDER BY pm.rok)) / LAG(pm.prumerna_mzda) OVER (ORDER BY pm.rok)) * 100 AS rust_mezd
    FROM 
        prumerne_mzdy AS pm
)
SELECT 
    h.rok AS rok,
    h.hdp_rust AS hdp_rust,
    rp.rust_cen_potravin AS rust_cen_potravin,
    rm.rust_mezd AS rust_mezd
FROM 
    hdp_rust AS h
LEFT JOIN 
    rust_potravin AS rp ON rp.rok = h.rok
LEFT JOIN 
    rust_mezd AS rm ON rm.rok = h.rok
WHERE 
    rp.rust_cen_potravin IS NOT NULL 
    AND rm.rust_mezd IS NOT NULL
ORDER BY 
    rok;

