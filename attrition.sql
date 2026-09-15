CREATE DATABASE AttritionDB;
use AttritionDB;

-- Total employees,employees_left,attrition_rate
SELECT
    COUNT(*) AS Total_Employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Employees_Left,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS Attrition_Rate
FROM Attrition;


-- Which department has the highest attrition rate?
SELECT
    Department,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS Attrition_Rate
FROM Attrition
GROUP BY Department
ORDER BY Attrition_Rate DESC;


-- Which job role has the highest attrition rate?
select Job_Role , sum(case when Attrition='Yes' then 1 else 0 end)*100.0/count(*) as Attrition_Rate 
from Attrition 
group by Job_Role
order by Attrition_Rate desc;


-- Is attrition higher among employees who work overtime?
select  Overtime , sum(case when Attrition='Yes' then 1 else 0 end)*100.0/count(*) as Attrition_Rate 
from Attrition 
group by Overtime
order by Attrition_Rate desc;


-- Which performance rating has the highest attrition rate?
select  Performance_Rating , sum(case when Attrition='Yes' then 1 else 0 end)*100.0/count(*) as Attrition_Rate 
from Attrition 
group by Performance_Rating
order by Attrition_Rate desc;


-- Which experience group has the highest attrition rate?
SELECT
    CASE
        WHEN Years_at_Company < 5 THEN '0-4 Years'
        WHEN Years_at_Company < 10 THEN '5-9 Years'
        WHEN Years_at_Company < 20 THEN '10-19 Years'
        ELSE '20+ Years'
    END AS Experience_Group,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS Attrition_Rate
FROM Attrition
GROUP BY
    CASE
        WHEN Years_at_Company < 5 THEN '0-4 Years'
        WHEN Years_at_Company < 10 THEN '5-9 Years'
        WHEN Years_at_Company < 20 THEN '10-19 Years'
        ELSE '20+ Years'
    END
ORDER BY Attrition_Rate DESC;


-- Which department has the highest number of employees who left?
select Department ,count(case when Attrition='Yes'THEN 1 END) as left_employees
from Attrition
group by Department
order by left_employees desc;


-- Which job roles have the highest number of employees who left?
SELECT
    Job_Role,
    count(CASE WHEN Attrition = 'Yes' THEN 1 END) AS left_employees
FROM Attrition
GROUP BY Job_Role
ORDER BY left_employees DESC;

-- How many high-performing employees who work overtime left the company?
select count(*) as Employees_Left 
from Attrition
where Attrition='Yes'
and Overtime='Yes'
and Performance_Rating>=3;

-- What is the average monthly income of employees who stayed vs those who left?
select Attrition , AVG(Monthly_Income) as Avg_Monthly_Income
from Attrition
group by Attrition
order by Avg_Monthly_Income desc;

-- Which department has the highest average monthly income among employees who left?
select Department , AVG(Monthly_Income) as Avg_Monthly_Income
from Attrition
where Attrition='Yes'
group by Department
order by Avg_Monthly_Income desc;

-- What is the average monthly income by experience group among employees who left?
select
    case
        when Years_at_Company < 5 then '0-4 Years'
        when Years_at_Company < 10 then '5-9 Years'
        when Years_at_Company < 20 then '10-19 Years'
        else '20+ Years'
    end as Experience_Group,
    avg(Monthly_Income) as Avg_Monthly_Income
from Attrition
where Attrition = 'Yes'
group by
    case
        when Years_at_Company < 5 then '0-4 Years'
        when Years_at_Company < 10 then '5-9 Years'
        when Years_at_Company < 20 then '10-19 Years'
        else '20+ Years'
    end
order by Avg_Monthly_Income desc;


