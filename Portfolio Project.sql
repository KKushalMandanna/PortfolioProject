select * 
from [portfolio projects]..[covid deaths]
order by 3,4
-- select the cases that we are going to be using
select location, date, total_cases,new_cases,total_deaths, population
from [portfolio projects]..[covid deaths]
order by 2,3

--now we are calculation the totalcases vs total deaths

select location,date,total_cases,new_cases,total_deaths,
(total_deaths/total_cases)*100 as deathpercentage
from [portfolio projects]..[covid deaths]
where location like '%states%'
order by 2,3
  
  --looking at totalcases vs population
  --It shows the that how many people are inflected by covid
  select location, date, population, total_cases,
(total_cases/population)*100 as infectedcovid
  from [portfolio projects]..[covid deaths]
  where location like '%states%'
   order by 3,4
  
  --Lookig at the countries with infetion rate with population
  select  location,date, population, max(total_cases)as highestinfectedrate , round(max((total_cases/population)*100),4)
  as percentinfected 
  from [portfolio projects]..[covid deaths]
 --- where location like '%united%'
   group by location, date,population
   order by percentinfected desc

   --showing the countries with   the highest death count rate

   select location,continent,date, population, 
   max(cast(total_deaths as int))as highestdeath 
  from [portfolio projects]..[covid deaths] 
   where continent is not null
   group by location,date, population,continent
   order by  highestdeath desc


  
  --showing the results through continent with highest deatcount
 
   select  continent, 
   max(cast(total_deaths as int))as highestdeath
   from [portfolio projects]..[covid deaths]
   where continent is not null
   group by continent
   order by highestdeath desc

 -- global numbers
  select  date, sum(new_cases) as total_cases , sum(cast(new_deaths as int))  as total_deaths,
  sum(cast(new_deaths as int)) / sum(new_cases)*100 as deathpercent
  from [portfolio projects]..[covid deaths]
  where continent is not null
  group by date
  order by deathpercent desc

 --looking at the totalpopulation vs vaccination

 select  dea. continent, dea.location, dea.date, dea.population , vac.new_vaccinations
 from [portfolio projects]..[covid deaths] as dea 
 join [portfolio projects]..[covid vaccinations] as vac on
  dea.location = vac.location and
  dea.date = vac.date
  where dea.continent is not null
  order by 1,2 