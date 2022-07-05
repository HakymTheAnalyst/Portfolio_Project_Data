select *
from PortfolioProject..CovidDeaths
order by 3,4

--select *
--from PortfolioProject..CovidVaccinations
--order by 3,4

--select data we are going to use

select Location, date, total_cases,new_cases, total_deaths, population 
from PortfolioProject..CovidDeaths
order by 3,4

--lets look at total cases vs total deaths

select Location, total_cases, total_deaths, (total_cases/total_deaths)*100 as DeathPercentage 
from PortfolioProject..CovidDeaths
where location like '%states%'
order by 1,2

--lets look at total cases ve loation

select Location, date, total_cases, population, (total_cases/population)*100 as DeathPercentage 
from PortfolioProject..CovidDeaths
where location like '%states%'
order by 1,2

--countries with highest infection rates

select Location, population, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/population))*100 as PercentPopulationInfected 
from PortfolioProject..CovidDeaths
--where location like '%states%'
Group by population, location
order by PercentPopulationInfected desc

--countries with highest death count

select Location, MAX(cast (total_deaths as int)) as TotalDeathCount 
from PortfolioProject..CovidDeaths
where continent is not null
Group by location
Order by TotalDeathCount

--continent breakdown


select location, MAX(cast (total_deaths as int)) as TotalDeathCount 
from PortfolioProject..CovidDeaths
where continent is null
Group by location
Order by TotalDeathCount desc

--GLOBAL NUMBERS

--select continent, MAX(cast (total_deaths as int)) as TotalDeathCount 
--from PortfolioProject..CovidDeaths
--where continent is null
--Group by continent
--Order by TotalDeathCount desc

select SUM(New_cases) as total_Cases, SUM(cast(New_deaths as int)) as total_Deaths, SUM(cast(new_deaths as int))
/SUM(New_Cases) * 100 as DeathPercentage 
from PortfolioProject..CovidDeaths
where continent is not null
--Group by date
Order by 1,2

--join deaths and vaccinations , total population vs vaccinations



with PopvsVac (continent, Location, Date, Population,New_Vaccinations, RollingPeopleVaccinated)
as

(
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.Location,
dea.date) as RollingPeopleVaccinated

from PortfolioProject..CovidDeaths dea
join PortfolioProject..CovidVaccinations vac
On dea.location=vac.location
and dea.date=vac.date
where dea.continent is not null
)
--order by 2,3

--Select * ,(RollingPeopleVaccinated/Population) * 100
--from PopvsVac


--TEMP TABLE


Create table #PercentPopulationVaccinated
(



--CREATE VIEW TO STORE DATA LATER

Create view TotalDeathCount as

select location, MAX(cast (total_deaths as int)) as TotalDeathCount 
from PortfolioProject..CovidDeaths
where continent is null
Group by location
--Order by TotalDeathCount desc

Select *
From PercentPopulationVaccinated