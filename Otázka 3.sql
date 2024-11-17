# 3. Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?

WITH lonske_ceny AS (
    SELECT 
        hodnota_potravin AS lonska_cena, 
        nazev_potraviny AS potravina,
        rok_potraviny + 1 AS rok
    FROM 
        t_petr_novotny_project_sql_primary_final
    WHERE 
        typ_hodnoty LIKE 'potraviny'
)
SELECT
    p.nazev_potraviny AS potravina,
    AVG(ROUND(((p.hodnota_potravin - p2.lonska_cena) / p2.lonska_cena) * 100, 2)) AS prumerna_zmena_ceny
FROM 
    t_petr_novotny_project_sql_primary_final AS p
LEFT JOIN 
    lonske_ceny AS p2 
    ON p2.rok = p.rok_potraviny AND p2.potravina = p.nazev_potraviny
WHERE 
    p.typ_hodnoty LIKE 'potraviny'
    AND p2.lonska_cena IS NOT NULL
GROUP BY 
    p.nazev_potraviny
ORDER BY 
    prumerna_zmena_ceny ASC;
