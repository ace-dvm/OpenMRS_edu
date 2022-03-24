select 'script 5 Ontslag';

INSERT INTO `encounter` 
(`encounter_id`, `encounter_type`, `patient_id`, `location_id`, `form_id`, `encounter_datetime`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `changed_by`, `date_changed`, `visit_id`, `uuid`)
VALUES 
(@encounter_id,8,@patient_id,10,NULL,CONCAT(@W1_WED,' 11:44:05'),12,CONCAT(@W1_WED,' 11:44:05'),0,NULL,NULL,NULL,NULL,NULL,@visit_id,(select uuid()));

INSERT INTO `encounter_provider` 
(`encounter_provider_id`, `encounter_id`, `provider_id`, `encounter_role_id`, `creator`, `date_created`, `changed_by`, `date_changed`, `voided`, `date_voided`, `voided_by`, `void_reason`, `uuid`)
VALUES 
(NULL,@encounter_id,9,1,12,CONCAT(@W1_WED,' 11:44:05'),NULL,NULL,0,NULL,NULL,NULL,(select uuid()));

INSERT INTO `obs` (`obs_id`, `person_id`, `concept_id`, `encounter_id`, `order_id`, `obs_datetime`, `location_id`, `obs_group_id`, `accession_number`, `value_group_id`, `value_coded`, `value_coded_name_id`, `value_drug`, `value_datetime`, `value_numeric`, `value_modifier`, `value_text`, `value_complex`, `comments`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `uuid`, `previous_version`, `form_namespace_and_path`, `status`, `interpretation`)
VALUES 
(NULL,@patient_id,165172,@encounter_id,NULL,CONCAT(@W1_WED,' 11:44:05'),10,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'m3ks | instructions.default | application/pdf | cellulitis_OntslagbriefInterneGeneeskunde_20210702_134436_4ca1c250-d9b3-4838-a6e0-93734f4970ee.pdf','Ontslagbrief',12,CONCAT(@W1_WED,' 11:44:05'),0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL);