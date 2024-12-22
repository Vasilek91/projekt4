# 5. Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo násdujícím roce výraznějším růstem?

WITH potraviny AS (
    SELECT 
        AVG(hodnota_potravin) AS prumerna_cena, 
        rok_potraviny AS rok
    FROM 
        t_petr_novotny_project_sql_primary_final
    WHERE 
        typ_hodnoty = 'potraviny'
    GROUP BY
        rok_potraviny
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
        rok,
        hdp AS hdp_hodnota,
        ((hdp - LAG(hdp) OVER (ORDER BY rok)) / LAG(hdp) OVER (ORDER BY rok)) * 100 AS hdp_rust
    FROM 
        t_petr_novotny_project_sql_secondary_final
    WHERE 
        nazev_zeme = 'Czech Republic'
),
prumerne_mzdy AS (
    SELECT 
        rok_mzdy AS rok,
        AVG(prumerna_mzda) AS prumerna_mzda
    FROM 
        t_petr_novotny_project_sql_primary_final
    WHERE 
        typ_hodnoty = 'mzdy'
        AND odvetvi_mzdy = 'republikovy_prumer'
    GROUP BY 
        rok_mzdy
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
