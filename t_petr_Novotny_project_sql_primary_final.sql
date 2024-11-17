CREATE OR REPLACE TABLE t_petr_novotny_project_sql_primary_final AS
SELECT
    'mzdy' AS typ_hodnoty,
    ROUND(AVG(cp.value), 2) AS prumerna_mzda,
    cpvt.name AS typ_kodu_mzdy,
    cpu.name AS jednotka_mzdy,
    cpc.name AS kalkulace_mzdy,
    CASE
        WHEN cpib.name IS NULL THEN 'republikový průměr'
        ELSE cpib.name
    END AS odvetvi_mzdy,
    cp.payroll_year AS rok_mzdy,
    NULL AS hodnota_potravin,
    NULL AS nazev_potraviny,
    NULL AS cena_potraviny,
    NULL AS jednotka_potraviny,
    NULL AS rok_potraviny
FROM 
    czechia_payroll cp 
LEFT JOIN 
    czechia_payroll_calculation cpc ON cpc.code = cp.calculation_code 
LEFT JOIN 
    czechia_payroll_industry_branch cpib ON cpib.code = cp.industry_branch_code 
LEFT JOIN 
    czechia_payroll_unit cpu ON cpu.code = cp.unit_code 
LEFT JOIN 
    czechia_payroll_value_type cpvt ON cpvt.code = cp.value_type_code
WHERE 
    cp.value_type_code = 5958 
    AND cp.calculation_code = 200 
    AND cp.payroll_year BETWEEN 
        (SELECT YEAR(MIN(cpri.date_to)) FROM czechia_price cpri) AND 
        (SELECT YEAR(MAX(cpri2.date_to)) FROM czechia_price cpri2)
GROUP BY
    cp.payroll_year,
    cp.industry_branch_code
UNION ALL
SELECT 
    'potraviny' AS typ_hodnoty,
    NULL AS prumerna_mzda,
    NULL AS typ_kodu_mzdy,
    NULL AS jednotka_mzdy,
    NULL AS kalkulace_mzdy,
    NULL AS odvetvi_mzdy,
    NULL AS rok_mzdy,
    ROUND(AVG(cppr.value), 2) AS hodnota_potravin,
    cpc.name AS nazev_potraviny,
    cpc.price_value AS cena_potraviny,
    cpc.price_unit AS jednotka_potraviny,
    YEAR(cppr.date_to) AS rok_potraviny
FROM 
    czechia_price cppr
LEFT JOIN 
    czechia_price_category cpc ON cpc.code = cppr.category_code 
LEFT JOIN 
    czechia_region cr ON cr.code = cppr.region_code
WHERE 
    cppr.region_code IS NULL
GROUP BY
    rok_potraviny,
    cppr.category_code;
