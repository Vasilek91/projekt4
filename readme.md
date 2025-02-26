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

## Odpovědi na výzkumné otázky

### Otázka 1: Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?
Mzdy v České republice obecně dlouhodobě rostou. Například v odvětví "Administrativní a podpůrné činnosti" vzrostla průměrná mzda z **10 453,75 Kč v roce 2000** na **25 685,5 Kč v roce 2021**. V některých letech a odvětvích však došlo k poklesu, například v roce 2013 ve "Činnostech v oblasti nemovitostí" o **-401 Kč**.

### Otázka 2: Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období?
**Chléb konzumní kmínový**:
  - V roce 2006: **1 211,91 kg** (cena: 16,12 Kč/kg, mzda: 19 536 Kč).
  - V roce 2018: **1 321,91 kg** (cena: 24,24 Kč/kg, mzda: 32 043 Kč).

**Mléko polotučné pasterované**:
  - V roce 2006: **1 352,91 litrů** (cena: 14,44 Kč/litr).
  - V roce 2018: **1 616,7 litrů** (cena: 19,82 Kč/litr).

Kupní síla chleba i mléka mezi těmito lety vzrostla.

### Otázka 3: Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší procentuální meziroční nárůst)?
Cukr krystalový** má nejnižší průměrnou roční změnu ceny **-1,92 %**, což znamená, že jeho cena dlouhodobě klesala.

### Otázka 4: Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?
Žádný rok neukázal, že by nárůst cen potravin byl o více než 10 % vyšší než růst mezd. Největší rozdíl byl v roce 2012, kdy ceny potravin vzrostly o **6,73 %**, zatímco mzdy rostly o **2,50 %**.

### Otázka 5: Má výška HDP vliv na změny ve mzdách a cenách potravin?
Růst HDP má slabou korelaci s růstem mezd a cen potravin. Například v roce 2007 HDP rostlo o **5,57 %**, ceny potravin o **6,76 %** a mzdy o **7,22 %**. Naopak v roce 2009, kdy HDP kleslo o **-4,65 %**, ceny potravin klesly o **-6,41 %**, zatímco mzdy stále rostly o **3,37 %**.

## Vytvořené tabulky
**Název:** [`t_petr_novotny_project_sql_primary_final`](./t_petr_novotny_project_sql_primary_final.sql)

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
**Název:** [`t_petr_novotny_project_sql_secondary_final`](./t_petr_novotny_project_sql_secondary_final.sql)

| Sloupec       | Popis                     |
|---------------|---------------------------|
| `nazev_zeme`  | Název země.              |
| `rok`         | Rok.                     |
| `hdp`         | Hrubý domácí produkt.    |

## SQL dotazy
### [Dotaz 1: Meziroční růst mezd](./Otázka%201.sql)
- Dotaz vypočítává meziroční změny mezd ve všech odvětvích a identifikuje, zda mzdy klesají v některých odvětvích.

### [Dotaz 2: Kupní síla](./Otázka%202.sql)
- Dotaz vypočítává kupní sílu průměrné mzdy pro mléko a chleba za daná období.

### [Dotaz 3: Stabilita růstu cen potravin](./Otázka%203.sql)
- Dotaz vypočítává průměrný meziroční růst cen jednotlivých kategorií potravin.

### [Dotaz 4: Růst cen vs mzdy](./Otázka%204.sql)
- Dotaz vypočítává, zda byl meziroční nárůst cen potravin vyšší než růst průměrné republikové mzdy, a identifikuje příslušné roky.

### [Dotaz 5: Vliv HDP](./Otázka%205.sql)
- Dotaz vypočítává vliv růstu HDP na růst mezd a cen potravin.

## Výstupní data
- Data byla očištěna o roky, kdy nejsou dostupné informace pro mzdy nebo ceny potravin.
- **Dostupné období:**
  - Mzdy: 2000–2021.
  - Ceny potravin: 2006–2018. 
- Transformace dat probíhala pouze na úrovni výsledných tabulek.

## P.S.
### Ano, sql jsou česky, 7 let pracuju s německým ERP kde v databázi angličtina opravdu není primární jazyk a stejný počet let pracuji s jiným českým EPR kde v databázi angličtina taky není primární jazyk.
