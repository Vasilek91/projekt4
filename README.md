# Analýza vlivu HDP na ceny potravin a mzdy

## Úvod
Tento projekt analyzuje vztah mezi HDP, změnami cen základních potravin a růstem průměrné mzdy v České republice. 
Cílem je odpovědět na pět výzkumných otázek týkajících se ekonomických a sociálních aspektů.

## Struktura dat
### Primární tabulka
Název: `t_petr_novotny_project_sql_primary_final`

| Sloupec             | Popis                                          |
|---------------------|-----------------------------------------------|
| typ_hodnoty         | Typ hodnoty: 'mzdy' nebo 'potraviny'.         |
| prumerna_mzda       | Průměrná mzda v daném roce.                   |
| odvetvi_mzdy        | Odvětví mzdy.                                 |
| rok_mzdy            | Rok, ke kterému mzda patří.                   |
| hodnota_potravin    | Průměrná cena dané potraviny.                 |
| nazev_potraviny     | Název potraviny.                              |
| rok_potraviny       | Rok, ke kterému cena potraviny patří.         |

### Sekundární tabulka
Název: `t_petr_novotny_project_sql_secondary_final`

| Sloupec       | Popis                          |
|---------------|--------------------------------|
| nazev_zeme    | Název země.                   |
| rok           | Rok.                          |
| hdp           | Hrubý domácí produkt (HDP).   |

## Výzkumné otázky a odpovědi
### 1. Rostou mzdy ve všech odvětvích?
Pomocí SQL dotazu byla analyzována meziroční změna průměrné mzdy. Výsledek ukázal ...

### 2. Kolik lze koupit litrů mléka a chleba?
Pomocí SQL dotazu byla porovnána kupní síla pro roky 2006 a 2018. Výsledek ...

### 3. Která kategorie potravin zdražuje nejpomaleji?
Výpočet meziroční změny cen ukázal, že ...

### 4. Existuje rok s výrazně vyšším růstem cen než mezd?
Analýzou růstu cen a mezd bylo zjištěno ...

### 5. Má HDP vliv na změny mezd a cen potravin?
Korelace mezi růstem HDP, cen potravin a mezd ukázala ...

## Návod na spuštění
1. Naimportujte tabulky do databáze.
2. Spusťte SQL skripty ve správném pořadí.
3. Výsledky analyzujte podle požadovaných výzkumných otázek.
