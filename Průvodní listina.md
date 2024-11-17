# Analýza vlivu HDP na mzdy a ceny potravin

## Úvod
Tento projekt se zaměřuje na přípravu dat České republiky ve kterých bude možné vidět porovnání dostupnosti potravin na základě průměrných příjmů za určité časové období.

Výstupem projektu jsou dvě tabulky v databázi, ze kterých se požadovaná data dají získat. 
Projekt je postaven na přípravě SQL dotazů pro vytvoření tabulek, ze kterých kolegové z analytického oddělení získají podklad k odpovědi na vytyčené výzkumné otázky.

#### Výzkumné otázky
1. Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?
2. Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?
3. Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?
4. Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?
5. Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo násdujícím roce výraznějším růstem?

## Vytvořené tabulky
**Název:** `t_petr_novotny_project_sql_primary_final`

| Sloupec             | Popis                          |
|---------------------|-------------------------------|
| `typ_hodnoty`       | Typ hodnoty: 'mzdy' nebo 'potraviny'. |
| `prumerna_mzda`     | Průměrná mzda.               |
| `odvetvi_mzdy`      | Odvětví mzdy.               |
| `rok_mzdy`          | Rok průměrné mzdy.          |
| `hodnota_potravin`  | Cena potraviny.             |
| `nazev_potraviny`   | Název potraviny.            |
| `rok_potraviny`     | Rok ceny potraviny.         |

### Sekundární tabulka
**Název:** `t_petr_novotny_project_sql_secondary_final`

| Sloupec       | Popis                     |
|---------------|---------------------------|
| `nazev_zeme`  | Název země.              |
| `rok`         | Rok.                     |
| `hdp`         | Hrubý domácí produkt.    |


## SQL dotazy
### Dotaz 1: Meziroční růst mezd
- Dotaz analyzuje meziroční změny mezd ve všech odvětvích a identifikuje, zda mzdy klesají v některých odvětvích.

### Dotaz 2: Kupní síla
- Dotaz vypočítává kupní sílu průměrné mzdy pro mléko a chleba v letech 2006 a 2018.

### Dotaz 3: Stabilita růstu cen potravin
- Dotaz identifikuje průměrný meziroční růst cen jednotlivých kategorií potravin.

### Dotaz 4: Růst cen vs mzdy
- Dotaz zkoumá, zda byl meziroční nárůst cen potravin vyšší než růst mezd, a identifikuje příslušné roky.

### Dotaz 5: Vliv HDP
- Dotaz analyzuje vliv růstu HDP na růst mezd a cen potravin.

## Výstupní data
Výstupní data byla očištěna o roky ve kterých nelze provést odpověď na výzkumné otázky z důvodu chybějícíh dat pro daná časová období. <br>
Datová sada výše mezd protíná období let 2000 - 2021, zatímco datová sada cen potravin protíná roky 2006 - 2018.
