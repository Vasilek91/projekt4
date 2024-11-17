# 2. Kolik je možné si koupit *litrů mléka* a *kilogramů chleba* za první a poslední srovnatelné období v dostupných datech cen a mezd?
# ceny potravin od roku 2006 do roku 2018 | mzdy jsou od roku 2000 do 2021
# 4 čísla, kolik se dá koupit litrů mléka v roce 2006 za průměrnou mzdu v roce 2006 a v roce 2018 a to samé pro chleba

SELECT
    potr.rok_potraviny AS rok,
    potr.hodnota_potravin AS cena_potraviny,
    potr.nazev_potraviny AS potravina,
    mzdy.prumerna_mzda AS prumerna_mzda,
    ROUND((mzdy.prumerna_mzda / potr.hodnota_potravin), 2) AS kupni_sila
FROM 
    t_petr_novotny_project_sql_primary_final AS potr
LEFT JOIN 
    t_petr_novotny_project_sql_primary_final AS mzdy 
    ON mzdy.rok_mzdy = potr.rok_potraviny
WHERE 
    potr.nazev_potraviny IN ('mléko polotučné pasterované', 'Chléb konzumní kmínový')
    AND (potr.rok_potraviny = (
            SELECT MIN(rok_potraviny) 
            FROM t_petr_novotny_project_sql_primary_final 
        ) 
        OR 
        potr.rok_potraviny = (
            SELECT MAX(rok_potraviny)
            FROM t_petr_novotny_project_sql_primary_final
        ))
    AND mzdy.odvetvi_mzdy LIKE 'republikový průměr';
