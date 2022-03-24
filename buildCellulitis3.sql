select 'script 3 Zaaloverdracht Dinsdagochtend';

INSERT INTO `encounter` 
(`encounter_id`, `encounter_type`, `patient_id`, `location_id`, `form_id`, `encounter_datetime`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `changed_by`, `date_changed`, `visit_id`, `uuid`)
VALUES 
(@encounter_id,3,@patient_id,10,2,CONCAT(@W1_MON,' 09:55:05'),12,CONCAT(@W1_MON,' 09:55:05'),0,NULL,NULL,NULL,NULL,NULL,@visit_id,(select uuid())),
-- (@encounter_id+1,8,@patient_id,10,NULL,CONCAT(@W1_MON,' 10:13:05'),14,CONCAT(@W1_MON,' 10:13:05'),0,NULL,NULL,NULL,NULL,NULL,@visit_id,(select uuid())),
(@encounter_id+1,7,@patient_id,10,1,CONCAT(@W1_TUE,' 07:50:05'),11,CONCAT(@W1_TUE,' 07:50:05'),0,NULL,NULL,NULL,NULL,NULL,@visit_id,(select uuid())),
(@encounter_id+2,3,@patient_id,10,2,CONCAT(@W1_TUE,' 07:55:05'),11,CONCAT(@W1_TUE,' 07:55:05'),0,NULL,NULL,NULL,NULL,NULL,@visit_id,(select uuid()));

INSERT INTO `encounter_diagnosis` 
(`diagnosis_id`, `diagnosis_coded`, `diagnosis_non_coded`, `diagnosis_coded_name`, `encounter_id`, `patient_id`, `condition_id`, `certainty`, `rank`, `uuid`, `creator`, `date_created`, `changed_by`, `date_changed`, `voided`, `voided_by`, `date_voided`, `void_reason`)
VALUES 
(NULL,366105,NULL,NULL,@encounter_id,@patient_id,NULL,'PROVISIONAL',1,(select uuid()),12,CONCAT(@W1_MON,' 09:55:05'),NULL,NULL,0,NULL,NULL,NULL),
(NULL,366105,NULL,NULL,@encounter_id+2,@patient_id,NULL,'PROVISIONAL',1,(select uuid()),11,CONCAT(@W1_TUE,' 07:55:05'),NULL,NULL,0,NULL,NULL,NULL);

SET @repeatDx = (select max(diagnosis_id) from encounter_diagnosis);
UPDATE encounter_diagnosis set voided = 1, voided_by = 8, date_voided = CONCAT(@W1_TUE,' 07:55:05') where diagnosis_coded = 366105 and patient_id = @patient_id and diagnosis_id != @repeatDx;

INSERT INTO `encounter_provider` 
(`encounter_provider_id`, `encounter_id`, `provider_id`, `encounter_role_id`, `creator`, `date_created`, `changed_by`, `date_changed`, `voided`, `date_voided`, `voided_by`, `void_reason`, `uuid`)
VALUES 
(NULL,@encounter_id,9,1,12,CONCAT(@W1_MON,' 09:55:05'),NULL,NULL,0,NULL,NULL,NULL,(select uuid())),
-- (NULL,@encounter_id+1,11,1,14,CONCAT(@W1_MON,' 10:13:05'),NULL,NULL,0,NULL,NULL,NULL,(select uuid())),
(NULL,@encounter_id+1,8,2,11,CONCAT(@W1_TUE,' 07:50:05'),NULL,NULL,0,NULL,NULL,NULL,(select uuid())),
(NULL,@encounter_id+2,8,1,11,CONCAT(@W1_TUE,' 07:55:05'),NULL,NULL,0,NULL,NULL,NULL,(select uuid()));


INSERT INTO `obs` (`obs_id`, `person_id`, `concept_id`, `encounter_id`, `order_id`, `obs_datetime`, `location_id`, `obs_group_id`, `accession_number`, `value_group_id`, `value_coded`, `value_coded_name_id`, `value_drug`, `value_datetime`, `value_numeric`, `value_modifier`, `value_text`, `value_complex`, `comments`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `uuid`, `previous_version`, `form_namespace_and_path`, `status`, `interpretation`)
VALUES 
(NULL,@patient_id,162169,@encounter_id,NULL,CONCAT(@W1_MON,' 09:55:05'),10,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'RvO/ Cellulitis \r\n \r\nVPK/ Hoog glucose, infuus gesneuveld, nog koorts, verder geen bijzonderheden. \r\n \r\nA/ Patiënt meldde dat been nog wel rood en pijnlijk is; toe- of afname is onduidelijk. Nog steeds misselijkheid en tevens gebraakt. Diabetes thuis waarschijnlijk slecht gereguleerd. \r\n \r\nLO/ T 38,4°C, P 88/min, RR 134/86mmHg, AH 8/min, sat 98%. Linker onderbeen nog duidelijk rood en warm, binnen afgetekende gebied (maar net afgetekend). \r\n \r\nAO/ Niet verricht. \r\n \r\nC/ Cellulitis, ontregelde diabetes en braken \r\n \r\nB/ Infuus herplaatsen (vanwege misselijkheid en braken), verder zo door. Morgen lab. \r\n\r\n- Bea Arts',NULL,NULL,12,CONCAT(@W1_MON,' 09:55:05'),0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
-- (NULL,@patient_id,165173,@encounter_id+1,NULL,CONCAT(@W1_MON,' 10:13:05'),10,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'m3ks | instructions.default | image/png | cellulitis_ecg_20210904_190700_bf4a904f-0da2-11ec-92ee-005056bc1569.png','ECG',12,CONCAT(@W1_MON,' 10:13:05'),0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(NULL,@patient_id,5088,@encounter_id+1,NULL,CONCAT(@W1_TUE,' 07:50:05'),10,NULL,NULL,NULL,NULL,NULL,NULL,NULL,37.5,NULL,NULL,NULL,NULL,11,CONCAT(@W1_TUE,' 07:50:05'),0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(NULL,@patient_id,5087,@encounter_id+1,NULL,CONCAT(@W1_TUE,' 07:50:05'),10,NULL,NULL,NULL,NULL,NULL,NULL,NULL,82,NULL,NULL,NULL,NULL,11,CONCAT(@W1_TUE,' 07:50:05'),0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(NULL,@patient_id,5242,@encounter_id+1,NULL,CONCAT(@W1_TUE,' 07:50:05'),10,NULL,NULL,NULL,NULL,NULL,NULL,NULL,10,NULL,NULL,NULL,NULL,11,CONCAT(@W1_TUE,' 07:50:05'),0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(NULL,@patient_id,5085,@encounter_id+1,NULL,CONCAT(@W1_TUE,' 07:50:05'),10,NULL,NULL,NULL,NULL,NULL,NULL,NULL,138,NULL,NULL,NULL,NULL,11,CONCAT(@W1_TUE,' 07:50:05'),0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(NULL,@patient_id,5086,@encounter_id+1,NULL,CONCAT(@W1_TUE,' 07:50:05'),10,NULL,NULL,NULL,NULL,NULL,NULL,NULL,88,NULL,NULL,NULL,NULL,11,CONCAT(@W1_TUE,' 07:50:05'),0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(NULL,@patient_id,5092,@encounter_id+1,NULL,CONCAT(@W1_TUE,' 07:50:05'),10,NULL,NULL,NULL,NULL,NULL,NULL,NULL,98,NULL,NULL,NULL,NULL,11,CONCAT(@W1_TUE,' 07:50:05'),0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(NULL,@patient_id,162169,@encounter_id+2,NULL,CONCAT(@W1_TUE,' 07:55:05'),10,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Geen koorts meer, glucose vanochtend 12 mmol/l was --> 1x bijgespoten. Goed gegeten, patiënte braakt niet meer. Geen metoclopramide meer nodig gehad.\r\n\ Glucosewaarden tot zover bekend:\r\n\ Zondag opname: 11,6 mmol/l\r\n\ Maandag nuchter: 16,0 mmol/l waarop 4 EH bijgespoten\r\n\ Maandag voor lunch: 9,4 mmol/l\r\n\ Maandag voor diner: 8,7 mmol/l\r\n\ Maandag voor slapen: 9,9 mmol/l\r\n\ Dinsdag nuchter: 12,0 mmol/l waarop 2 EH bijgespoten \r\n\r\n- Alice V.',NULL,NULL,11,CONCAT(@W1_TUE,' 07:55:05'),0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL);