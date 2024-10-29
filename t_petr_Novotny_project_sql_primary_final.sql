create or replace table t_petr_Novotny_project_sql_primary_final as 

select
'mzdy' as values_type,
round(avg(cp.value),2) as mzdy_value,
cpvt.name as mzdy_type_code_name,
cpu.name as mzdy_unit_name,
cpc.name as mzdy_calc_name,
case
	when cpib.name is null then 'republikový průměr'
	else cpib.name
	end as mzdy_industry_name,
cp.payroll_year as mzdy_year,
null as potraviny_value,
null as potraviny_name,
null as potraviny_price_value,
null as potraviny_unit,
null as potraviny_year
from czechia_payroll cp 
left join czechia_payroll_calculation cpc on cpc.code = cp.calculation_code 
left join czechia_payroll_industry_branch cpib on cpib.code = cp.industry_branch_code 
left join czechia_payroll_unit cpu on cpu.code = cp.unit_code 
left join czechia_payroll_value_type cpvt on cpvt.code = cp.value_type_code
where 
	cp.value_type_code = 5958 
	and cp.calculation_code = 200 
	and cp.payroll_year between (select year(min(cpri.date_to)) from czechia_price cpri) and (select year(max(cpri2.date_to)) from czechia_price cpri2)
group by
	cp.payroll_year,
	cp.industry_branch_code
union all
select 
'potraviny' as values_type,
null as mzdy_value,
null as mzdy_type_code_name,
null as mzdy_unit_name,
null as mzdy_calc_name,
null as mzdy_year,
null as mzdy_year,
round(avg(cppr.value),2) as 'potraviny_value',
cpc.name 'potraviny_name',
cpc.price_value 'potraviny_price_value',
cpc.price_unit 'potraviny_unit',
year(cppr.date_to) as 'potraviny_year'
from czechia_price cppr
left join czechia_price_category cpc on cpc.code = cppr.category_code 
left join czechia_region cr on cr.code = cppr.region_code
where 
	cppr.region_code is null
group by
	potraviny_year,
	cppr.category_code