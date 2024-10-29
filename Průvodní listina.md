## Popis tabulky `t_petr_Novotny_project_sql_primary_final`

Tato tabulka kombinuje data o mzdách a cenách potravin z různých zdrojových tabulek, což umožňuje provádět analýzu nad těmito údaji společně.

### Sloupce tabulky:

- **values_type**: Typ hodnoty, může být `mzdy` nebo `potraviny`.
- **mzdy_value**: Průměrná hodnota mezd pro daný rok.
- **mzdy_type_code_name**: Název typu mezd (např. hrubé mzdy).
- **mzdy_unit_name**: Jednotka mezd.
- **mzdy_calc_name**: Kalkulace mezd.
- **mzdy_industry_name**: Odvětví, nebo "republikový průměr" pro celkové hodnoty.
- **mzdy_year**: Rok, pro který jsou hodnoty mezd vypočteny.
- **potraviny_value**: Průměrná cena potravin pro daný rok.
- **potraviny_name**: Název kategorie potravin.
- **potraviny_price_value**: Hodnota jednotky ceny potravin.
- **potraviny_unit**: Jednotka ceny potravin (např. kg, litr).
- **potraviny_year**: Rok, pro který jsou hodnoty cen potravin vypočteny.
