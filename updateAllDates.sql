-- set this to the number of days between day 1 of the module and 2021-06-21
-- select the minimum class date that is > the current date
-- set daysToAdd = classdate minus 2021-06-21
select 'This script will work as long as you are running it *after* the start of the previous module and *before* the start of the next module. The database currently contains class dates until Christmas 2022. After that new dates will need to be added!';

set @classdate = if(@classdate is null, (select min(classdate) from classdates where classdate >= CURRENT_DATE()), @classdate);
select concat('Next class date = ', @classdate);
set @daysToAdd = if(@daysToAdd is null, (select datediff(@classdate,'2021-06-21')), @daysToAdd);

select 'It will also adjust for daylight savings time through Christmas 2022, although the times will not be adjusted in mid-module. You can also do this manually using the commands: \nset @hoursToAdd = 1; \nsource /tmp/updateAllTimes.sql;';
-- Adjust for Daylight Saving EU: last Sunday in March at 1:00 UTC 	last Sunday in October at 1:00 UTC
set @hoursToAdd = 0;

set @hoursToAdd = 
CASE WHEN (@classdate >= '2021-10-31' AND @classdate <= '2022-03-29') or (@classdate >= '2022-10-30' AND @classdate <= '2023-03-28')
THEN 1
ELSE 0
END;

source /tmp/updateAllTimes.sql;

update allergy set date_created = DATE_ADD(date_created, INTERVAL @daysToAdd DAY);
update conditions set date_created = DATE_ADD(date_created, INTERVAL @daysToAdd DAY);
update encounter set encounter_datetime = DATE_ADD(encounter_datetime, INTERVAL @daysToAdd DAY), date_created = DATE_ADD(date_created, INTERVAL @daysToAdd DAY);
update encounter_provider set date_created = DATE_ADD(date_created, INTERVAL @daysToAdd DAY);
update encounter_diagnosis set date_created = DATE_ADD(date_created, INTERVAL @daysToAdd DAY);
update obs set obs_datetime = DATE_ADD(obs_datetime, INTERVAL @daysToAdd DAY), date_created = DATE_ADD(date_created, INTERVAL @daysToAdd DAY);
update orders set date_activated = DATE_ADD(date_activated, INTERVAL @daysToAdd DAY), date_created = DATE_ADD(date_created, INTERVAL @daysToAdd DAY), date_voided = DATE_ADD(date_voided, INTERVAL @daysToAdd DAY);
update visit set date_started = DATE_ADD(date_started, INTERVAL @daysToAdd DAY), date_created = DATE_ADD(date_created, INTERVAL @daysToAdd DAY);

select CONCAT('All dates updated by ', @daysToAdd, ' days.');
