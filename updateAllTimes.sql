-- Adjust all times in OpenMRS patient data by n hours

update allergy set date_created = DATE_ADD(date_created, INTERVAL @hoursToAdd HOUR);
update conditions set date_created = DATE_ADD(date_created, INTERVAL @hoursToAdd HOUR);
update encounter set encounter_datetime = DATE_ADD(encounter_datetime, INTERVAL @hoursToAdd HOUR), date_created = DATE_ADD(date_created, INTERVAL @hoursToAdd HOUR);
update encounter_provider set date_created = DATE_ADD(date_created, INTERVAL @hoursToAdd HOUR);
update encounter_diagnosis set date_created = DATE_ADD(date_created, INTERVAL @hoursToAdd HOUR);
update obs set obs_datetime = DATE_ADD(obs_datetime, INTERVAL @hoursToAdd HOUR), date_created = DATE_ADD(date_created, INTERVAL @hoursToAdd HOUR);
update orders set date_activated = DATE_ADD(date_activated, INTERVAL @hoursToAdd HOUR), date_created = DATE_ADD(date_created, INTERVAL @hoursToAdd HOUR), date_voided = DATE_ADD(date_voided, INTERVAL @hoursToAdd HOUR);
update visit set date_started = DATE_ADD(date_started, INTERVAL @hoursToAdd HOUR), date_created = DATE_ADD(date_created, INTERVAL @hoursToAdd HOUR);

select CONCAT('All times updated by ', @hoursToAdd, ' hours');

