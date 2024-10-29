# 4. Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?

with
lonske_ceny as (
select 
	avg(potraviny_value) as prumerna_cena, 
	potraviny_year
from t_petr_novotny_project_sql_primary_final
where 
	values_type like 'potraviny'
group by
potraviny_year
),
rust_potravin as(
select
lc.potraviny_year,
((lc.prumerna_cena - lc1.prumerna_cena) / lc1.prumerna_cena) * 100 AS vyvoj_potravin
from lonske_ceny as lc
left join lonske_ceny as lc1 on lc1.potraviny_year+1 = lc.potraviny_year
where
lc1.prumerna_cena is not null
),
lonske_mzdy as (
select 
	mzdy_value, 
	mzdy_year
from t_petr_novotny_project_sql_primary_final
where 
	values_type like 'mzdy'
	and mzdy_industry_name like 'republikový průměr'
),
rust_mezd as (
select
lm.mzdy_year,
((lm.mzdy_value - lm1.mzdy_value) / lm1.mzdy_value) * 100 AS vyvoj_mezd
from lonske_mzdy as lm
left join lonske_mzdy as lm1 on lm1.mzdy_year+1 = lm.mzdy_year
where lm1.mzdy_value is not null
)
select 
rp.potraviny_year as rok, 
rp.vyvoj_potravin, 
rm.vyvoj_mezd,
(rp.vyvoj_potravin - rm.vyvoj_mezd) AS rozdil 
from rust_potravin as rp
left join rust_mezd AS rm ON rp.potraviny_year = rm.mzdy_year
order by rp.potraviny_year







with rust_potravin as (
SELECT YEAR(cp.date_to) as rok_potravin ,cast(avg(cp.value) as decimal(15,2)) as avg_cena_v_roce from czechia_price cp 
left join czechia_price_category cpc on cpc.code = cp.category_code 
group by YEAR(cp.date_to)
order by rok_potravin
),
 potraviny as (
select 'potraviny',rp.rok_potravin, ((rp.avg_cena_v_roce/rp1.avg_cena_v_roce)-1)*100 as procentualni_vyvoj_potravin from rust_potravin as rp
join rust_potravin as rp1 on rp1.rok_potravin = rp.rok_potravin-1
),
 rust_mezd as(
SELECT    
cp.payroll_year as rok_mezd, 
avg(cp.value) AS Prumerna_vyplata
FROM czechia_payroll cp
group by cp.payroll_year
    ),   
 mzdy as(
select 'mzdy', rm.rok_mezd, ((rm.Prumerna_vyplata / rm1.Prumerna_vyplata) - 1) * 100 as procentualni_vyvoj_mezd from rust_mezd as rm
join rust_mezd as rm1 on rm1.rok_mezd = rm.rok_mezd-1
)
select m.rok_mezd, m.mzdy, m.procentualni_vyvoj_mezd, p.procentualni_vyvoj_potravin from mzdy as m
inner join potraviny as p on p.rok_potravin = m.rok_mezd