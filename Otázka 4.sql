# 4. Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?

WITH
prumerne_ceny AS (
    SELECT 
        rok_potraviny AS rok,
        AVG(hodnota_potravin) AS prumerna_cena
    FROM 
        t_petr_novotny_project_sql_primary_final
    WHERE 
        typ_hodnoty = 'potraviny'
    GROUP BY 
        rok_potraviny
),
vyvoj_potravin AS (
    SELECT 
        pc.rok,
        ((pc.prumerna_cena - pc1.prumerna_cena) / pc1.prumerna_cena) * 100 AS vyvoj_potravin
    FROM 
        prumerne_ceny pc
    LEFT JOIN 
        prumerne_ceny pc1 ON pc1.rok + 1 = pc.rok
    WHERE 
        pc1.prumerna_cena IS NOT NULL
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
vyvoj_mezd AS (
    SELECT 
        pm.rok,
        ((pm.prumerna_mzda - pm1.prumerna_mzda) / pm1.prumerna_mzda) * 100 AS vyvoj_mezd
    FROM 
        prumerne_mzdy pm
    LEFT JOIN 
        prumerne_mzdy pm1 ON pm1.rok + 1 = pm.rok
    WHERE 
        pm1.prumerna_mzda IS NOT NULL
)
SELECT 
    vp.rok,
    vp.vyvoj_potravin,
    vm.vyvoj_mezd,
    (vp.vyvoj_potravin - vm.vyvoj_mezd) AS rozdil,
    CASE 
        WHEN (vp.vyvoj_potravin - vm.vyvoj_mezd) > 10 THEN 'ANO'
        ELSE 'NE'
    END AS splnuje_podminku
FROM 
    vyvoj_potravin vp
LEFT JOIN 
    vyvoj_mezd vm ON vp.rok = vm.rok
ORDER BY 
    vp.rok;
