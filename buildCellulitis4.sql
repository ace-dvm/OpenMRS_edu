select 'script 4 Zaaloverdracht woensdagochtend';

INSERT INTO `encounter` 
(`encounter_id`, `encounter_type`, `patient_id`, `location_id`, `form_id`, `encounter_datetime`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `changed_by`, `date_changed`, `visit_id`, `uuid`)
VALUES 
(@encounter_id,3,@patient_id,10,2,CONCAT(@W1_TUE,' 10:10:05'),12,CONCAT(@W1_TUE,' 10:10:05'),0,NULL,NULL,NULL,NULL,NULL,@visit_id,(select uuid())),
(@encounter_id+1,8,@patient_id,10,NULL,CONCAT(@W1_TUE,' 14:12:05'),12,CONCAT(@W1_TUE,' 14:12:05'),0,NULL,NULL,NULL,NULL,NULL,@visit_id,(select uuid())),
(@encounter_id+2,8,@patient_id,11,NULL,CONCAT(@W1_TUE,' 14:13:05'),14,CONCAT(@W1_TUE,' 14:13:05'),0,NULL,NULL,NULL,NULL,NULL,@visit_id,(select uuid())),
(@encounter_id+3,3,@patient_id,11,2,CONCAT(@W1_TUE,' 14:21:05'),14,CONCAT(@W1_TUE,' 14:21:05'),0,NULL,NULL,NULL,NULL,NULL,@visit_id,(select uuid())),
(@encounter_id+4,7,@patient_id,10,1,CONCAT(@W1_WED,' 07:23:05'),11,CONCAT(@W1_WED,' 07:23:05'),0,NULL,NULL,NULL,NULL,NULL,@visit_id,(select uuid())),
(@encounter_id+5,3,@patient_id,10,2,CONCAT(@W1_WED,' 08:18:05'),11,CONCAT(@W1_WED,' 08:18:05'),0,NULL,NULL,NULL,NULL,NULL,@visit_id,(select uuid())),
(@encounter_id+6,9,@patient_id,10,NULL,CONCAT(@W1_TUE,' 10:10:10'),12,CONCAT(@W1_TUE,' 10:10:10'),0,NULL,NULL,NULL,NULL,NULL,NULL,(select uuid()));

INSERT INTO `encounter_diagnosis` 
(`diagnosis_id`, `diagnosis_coded`, `diagnosis_non_coded`, `diagnosis_coded_name`, `encounter_id`, `patient_id`, `condition_id`, `certainty`, `rank`, `uuid`, `creator`, `date_created`, `changed_by`, `date_changed`, `voided`, `voided_by`, `date_voided`, `void_reason`)
VALUES 
(NULL,366105,NULL,NULL,@encounter_id,@patient_id,NULL,'PROVISIONAL',1,(select uuid()),12,CONCAT(@W1_TUE,' 10:10:05'),NULL,NULL,0,NULL,NULL,NULL),
(NULL,366105,NULL,NULL,@encounter_id+3,@patient_id,NULL,'PROVISIONAL',1,(select uuid()),14,CONCAT(@W1_TUE,' 14:21:05'),NULL,NULL,0,NULL,NULL,NULL),
(NULL,366105,NULL,NULL,@encounter_id+5,@patient_id,NULL,'PROVISIONAL',1,(select uuid()),11,CONCAT(@W1_WED,' 08:18:05'),NULL,NULL,0,NULL,NULL,NULL);

SET @repeatDx = (select max(diagnosis_id) from encounter_diagnosis);
UPDATE encounter_diagnosis set voided = 1, voided_by = 8, date_voided = CONCAT(@W1_WED,' 08:18:05') where diagnosis_coded = 366105 and patient_id = @patient_id and diagnosis_id != @repeatDx;

INSERT INTO `encounter_provider` 
(`encounter_provider_id`, `encounter_id`, `provider_id`, `encounter_role_id`, `creator`, `date_created`, `changed_by`, `date_changed`, `voided`, `date_voided`, `voided_by`, `void_reason`, `uuid`)
VALUES 
(NULL,@encounter_id,9,1,12,CONCAT(@W1_TUE,' 10:10:05'),NULL,NULL,0,NULL,NULL,NULL,(select uuid())),
(NULL,@encounter_id+1,9,1,12,CONCAT(@W1_TUE,' 14:12:05'),NULL,NULL,0,NULL,NULL,NULL,(select uuid())),
(NULL,@encounter_id+2,11,1,14,CONCAT(@W1_TUE,' 14:13:05'),NULL,NULL,0,NULL,NULL,NULL,(select uuid())),
(NULL,@encounter_id+3,11,1,14,CONCAT(@W1_TUE,' 14:21:05'),NULL,NULL,0,NULL,NULL,NULL,(select uuid())),
(NULL,@encounter_id+4,8,2,11,CONCAT(@W1_WED,' 07:23:05'),NULL,NULL,0,NULL,NULL,NULL,(select uuid())),
(NULL,@encounter_id+5,8,1,11,CONCAT(@W1_WED,' 08:18:05'),NULL,NULL,0,NULL,NULL,NULL,(select uuid())),
(NULL,@encounter_id+6,9,2,12,CONCAT(@W1_TUE,' 10:10:10'),NULL,NULL,0,NULL,NULL,NULL,(select uuid()));

INSERT INTO `obs` (`obs_id`, `person_id`, `concept_id`, `encounter_id`, `order_id`, `obs_datetime`, `location_id`, `obs_group_id`, `accession_number`, `value_group_id`, `value_coded`, `value_coded_name_id`, `value_drug`, `value_datetime`, `value_numeric`, `value_modifier`, `value_text`, `value_complex`, `comments`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `uuid`, `previous_version`, `form_namespace_and_path`, `status`, `interpretation`)
VALUES 
(NULL,@patient_id,162169,@encounter_id,NULL,CONCAT(@W1_TUE,' 10:10:05'),10,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'RvO/ Cellulitis \r\n \r\nVPK/ Hoog glucose, koorts en braken verdwenen. \r\n \r\nA/ Patiënt meldde dat been misschien wel iets minder pijnlijk wordt. Voelt zich een stuk beter \r\n \r\nLO/ T 37,5°C, P 82/min, RR 138/88mmHg, AH 10/min, sat 98%. Linker onderbeen nog duidelijk rood en warm, nu verder binnen afgetekende gebied dan eerder, dus afname. \r\n \r\nAO/ Inflammatieparameters dalen, kreatinine iets gestegen bij status na braken. \r\n \r\nC/ Herstellende cellulitis, regulatie diabetes verbetert. \r\n \r\nB/ Nog een dag i.v.-antibiotica, staken anti-emetica, herstarten thuismedicatie, bijspuitschema handhaven en dan inplannen ontslag. - Bea Arts',NULL,NULL,12,CONCAT(@W1_TUE,' 10:10:05'),0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(NULL,@patient_id,165172,@encounter_id+1,NULL,CONCAT(@W1_TUE,' 14:12:05'),10,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'m3ks | instructions.default | application/pdf | cellulitis_lab3_20210702_133919_95519123-3e9f-4203-968c-c231d94d4dd8.pdf','Lab dinsdag',12,CONCAT(@W1_TUE,' 14:12:05'),0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(NULL,@patient_id,165173,@encounter_id+2,NULL,CONCAT(@W1_TUE,' 14:13:05'),11,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'m3ks | instructions.default | image/png | cellulitis_ICCDermatologie_20210702_133729_f39253bd-1bda-433e-b1d4-0cb2a8627b9b.png','Cellulitis benen',14,CONCAT(@W1_TUE,' 14:13:05'),0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(NULL,@patient_id,162169,@encounter_id+3,NULL,CONCAT(@W1_TUE,' 14:21:05'),11,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'RvO/ Cellulitis \r\nRvC/ Gezien traag herstel antibiotica, graag uw medeboordeling bij werkdiagnose cellulitis \r\n \r\nA/ Zondag via SEH opgenomen in verband met toenemende roodheid en zwelling van het linker onderbeen. Tevens koorts. Via huisarts voorafgaand aan opname onbekend antibioticum gehad, waarschijnlijk flucoxacilline. Startdatum niet vermeld. Bij opname omgezet in flucloxacilline. Linker onderbeen is pijnlijk. Merkt nog geen duidelijke verbetering sinds opname. Vandaag ook nog koorts. \r\n \r\nLO/ Pitting oedeem linker onderbeen. Ter plaatse van het linker onderbeen doorlopend over voetrug onscherp begrensde erythemateuze macula van meerdere handpalmgrootten. Linker onderbeen warm aanvoelend.  \r\n \r\nC/ Cellulitis, gezien onscherpe begrenzing erytheem klinisch voorkeur boven klassieke erysipelas (DD indien geen verbetering denk ook aan hypostatisch eczeem, hypodermitis ikv veneuze insufficiëntie) \r\n \r\nB/ \r\nVoortzetten antibiotisch beleid. \r\nBij klinische verbetering start ambulante compressietherapie tot been weer slank is \r\n\r\n- J. Jeuken',NULL,NULL,14,CONCAT(@W1_TUE,' 14:21:05'),0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(NULL,@patient_id,5088,@encounter_id+4,NULL,CONCAT(@W1_WED,' 07:23:05'),10,NULL,NULL,NULL,NULL,NULL,NULL,NULL,37.7,NULL,NULL,NULL,NULL,11,CONCAT(@W1_WED,' 07:23:05'),0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(NULL,@patient_id,5087,@encounter_id+4,NULL,CONCAT(@W1_WED,' 07:23:05'),10,NULL,NULL,NULL,NULL,NULL,NULL,NULL,80,NULL,NULL,NULL,NULL,11,CONCAT(@W1_WED,' 07:23:05'),0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(NULL,@patient_id,5242,@encounter_id+4,NULL,CONCAT(@W1_WED,' 07:23:05'),10,NULL,NULL,NULL,NULL,NULL,NULL,NULL,10,NULL,NULL,NULL,NULL,11,CONCAT(@W1_WED,' 07:23:05'),0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(NULL,@patient_id,5085,@encounter_id+4,NULL,CONCAT(@W1_WED,' 07:23:05'),10,NULL,NULL,NULL,NULL,NULL,NULL,NULL,130,NULL,NULL,NULL,NULL,11,CONCAT(@W1_WED,' 07:23:05'),0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(NULL,@patient_id,5086,@encounter_id+4,NULL,CONCAT(@W1_WED,' 07:23:05'),10,NULL,NULL,NULL,NULL,NULL,NULL,NULL,89,NULL,NULL,NULL,NULL,11,CONCAT(@W1_WED,' 07:23:05'),0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(NULL,@patient_id,5092,@encounter_id+4,NULL,CONCAT(@W1_WED,' 07:23:05'),10,NULL,NULL,NULL,NULL,NULL,NULL,NULL,98,NULL,NULL,NULL,NULL,11,CONCAT(@W1_WED,' 07:23:05'),0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(NULL,@patient_id,162169,@encounter_id+5,NULL,CONCAT(@W1_WED,' 08:18:05'),10,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Geen bijzonderheden.  \r\nGlucosewaarden tot zover bekend  \r\nZondag opname: 11,6 mmol/l \r\nMaandag nuchter: 16,0 mmol/l waarop 4 EH bijgespoten \r\nMaandag voor lunch: 9,4 mmol/l \r\nMaandag voor diner: 8,7 mmol/l \r\nMaandag voor slapen: 9,9 mmol/l \r\nDinsdag nuchter: 12,0 mmol/l waarop 2 EH bijgespoten \r\nDinsdag voor lunch: 8,6 mmol/l \r\nDinsdag voor diner: 7,3 mmol/l \r\nDinsdag voor slapen: 7,9 mmol/l \r\nWoensdag nuchter: 8,1 mmol/l  \r\n\r\n- Alice V.',NULL,NULL,11,CONCAT(@W1_WED,' 08:18:05'),0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL);

INSERT INTO `orders` (`order_id`, `order_type_id`, `concept_id`, `orderer`, `encounter_id`, `instructions`, `date_activated`, `auto_expire_date`, `date_stopped`, `order_reason`, `order_reason_non_coded`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `patient_id`, `accession_number`, `uuid`, `urgency`, `order_number`, `previous_order_id`, `order_action`, `comment_to_fulfiller`, `care_setting`, `scheduled_date`, `order_group_id`, `sort_weight`, `fulfiller_comment`, `fulfiller_status`) 
VALUES 
(@order_id,2,427506,9,@encounter_id+6,NULL,CONCAT(@W1_TUE,' 10:10:10'),NULL,NULL,NULL,NULL,12,CONCAT(@W1_TUE,' 10:10:10'),0,NULL,NULL,NULL,@patient_id,NULL,(select uuid()),'ROUTINE',CONCAT('ORD-',@order_id),NULL,'NEW',NULL,1,NULL,NULL,NULL,NULL,NULL);

update orders set voided = 1, voided_by = 8, date_voided = CONCAT(@W1_THR,' 07:36:05') where order_id = @Metoclopramide;

INSERT INTO `drug_order` (`order_id`, `drug_inventory_id`, `dose`, `as_needed`, `dosing_type`, `quantity`, `as_needed_condition`, `num_refills`, `dosing_instructions`, `duration`, `duration_units`, `quantity_units`, `route`, `dose_units`, `frequency`, `brand_name`, `dispense_as_written`, `drug_non_coded`) 
VALUES 
(@order_id,80,5,0,'org.openmrs.SimpleDosingInstructions',5,NULL,0,'1dd 1/2 T',NULL,NULL,1513,160240,161553,16,NULL,0,NULL);