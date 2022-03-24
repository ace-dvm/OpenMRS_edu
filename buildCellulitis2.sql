select 'script 2 Zaaloverdracht Maandagochtend ';

INSERT INTO `visit` 
(`visit_id`, `patient_id`, `visit_type_id`, `date_started`, `date_stopped`, `indication_concept_id`, `location_id`, `creator`, `date_created`, `changed_by`, `date_changed`, `voided`, `voided_by`, `date_voided`, `void_reason`, `uuid`)
VALUES 
(@visit_id,@patient_id,1,CONCAT(@W0_SUN,' 15:21:05'),NULL,NULL,8,10,CONCAT(@W0_SUN,' 15:21:05'),NULL,NULL,0,NULL,NULL,NULL,(select uuid()));

INSERT INTO `allergy` (`allergy_id`, `patient_id`, `severity_concept_id`, `coded_allergen`, `non_coded_allergen`, `allergen_type`, `comments`, `creator`, `date_created`, `changed_by`, `date_changed`, `voided`, `voided_by`, `date_voided`, `void_reason`, `uuid`) 
VALUES
(@allergy_id,@patient_id,1498,162542,'','OTHER','Bruine pleister',12,CONCAT(@W0_SUN,' 17:47:05'),NULL,NULL,0,NULL,NULL,NULL,(select uuid()));

INSERT INTO `allergy_reaction` (`allergy_reaction_id`, `allergy_id`, `reaction_concept_id`, `reaction_non_coded`, `uuid`)
VALUES
(NULL,@allergy_id,512,NULL,(select uuid()));

INSERT INTO `conditions` (condition_id,additional_detail,previous_version,condition_coded,condition_non_coded,condition_coded_name,clinical_status,verification_status,onset_date,date_created,voided,date_voided,void_reason,uuid,creator,voided_by,changed_by,patient_id,end_date,date_changed,encounter_id,form_namespace_and_path) 
VALUES 
(NULL,NULL,NULL,363778,'',309953,'ACTIVE',NULL,'2009-01-01 00:00:00',CONCAT(@W0_SUN,' 17:47:05'),0,NULL,NULL,(select uuid()),12,NULL,NULL,@patient_id,NULL,NULL,NULL,NULL),
(NULL,NULL,NULL,367221,'',313459,'ACTIVE',NULL,'2009-01-01 00:00:00',CONCAT(@W0_SUN,' 17:47:05'),0,NULL,NULL,(select uuid()),12,NULL,NULL,@patient_id,NULL,NULL,NULL,NULL),
(NULL,NULL,NULL,374606,'',320853,'ACTIVE',NULL,'2011-12-02 00:00:00',CONCAT(@W0_SUN,' 17:47:05'),0,NULL,NULL,(select uuid()),12,NULL,NULL,@patient_id,NULL,NULL,NULL,NULL),
(NULL,NULL,NULL,117399,'',17788,'ACTIVE',NULL,'2011-12-02 00:00:00',CONCAT(@W0_SUN,' 17:47:05'),0,NULL,NULL,(select uuid()),12,NULL,NULL,@patient_id,NULL,NULL,NULL,NULL),
(NULL,NULL,NULL,365375,'',311582,'ACTIVE',NULL,'2019-12-16 00:00:00',CONCAT(@W0_SUN,' 17:47:05'),0,NULL,NULL,(select uuid()),12,NULL,NULL,@patient_id,NULL,NULL,NULL,NULL);

INSERT INTO `encounter` 
(`encounter_id`, `encounter_type`, `patient_id`, `location_id`, `form_id`, `encounter_datetime`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `changed_by`, `date_changed`, `visit_id`, `uuid`)
VALUES 
(@encounter_id,8,@patient_id,9,NULL,CONCAT(@W0_SUN,' 15:21:05'),10,CONCAT(@W0_SUN,' 15:21:05'),0,NULL,NULL,NULL,NULL,NULL,@visit_id,(select uuid())),
(@encounter_id+1,8,@patient_id,9,NULL,CONCAT(@W0_SUN,' 15:21:10'),10,CONCAT(@W0_SUN,' 15:21:10'),0,NULL,NULL,NULL,NULL,NULL,@visit_id,(select uuid())),
(@encounter_id+2,8,@patient_id,9,NULL,CONCAT(@W0_SUN,' 17:43:10'),10,CONCAT(@W0_SUN,' 17:43:10'),0,NULL,NULL,NULL,NULL,NULL,@visit_id,(select uuid())),
(@encounter_id+3,2,@patient_id,10,3,CONCAT(@W0_SUN,' 17:46:10'),12,CONCAT(@W0_SUN,' 17:46:10'),0,NULL,NULL,NULL,NULL,NULL,@visit_id,(select uuid())),
(@encounter_id+4,9,@patient_id,10,NULL,CONCAT(@W0_SUN,' 17:47:05'),12,CONCAT(@W0_SUN,' 17:47:05'),0,NULL,NULL,NULL,NULL,NULL,NULL,(select uuid())),
(@encounter_id+5,9,@patient_id,10,NULL,CONCAT(@W0_SUN,' 17:47:10'),12,CONCAT(@W0_SUN,' 17:47:10'),0,NULL,NULL,NULL,NULL,NULL,NULL,(select uuid())),
(@encounter_id+6,7,@patient_id,10,1,CONCAT(@W1_MON,' 07:41:05'),11,CONCAT(@W1_MON,' 07:41:05'),0,NULL,NULL,NULL,NULL,NULL,@visit_id,(select uuid())),
(@encounter_id+7,3,@patient_id,10,2,CONCAT(@W1_MON,' 07:43:05'),11,CONCAT(@W1_MON,' 07:43:05'),0,NULL,NULL,NULL,NULL,NULL,@visit_id,(select uuid())),
(@encounter_id+8,8,@patient_id,9,NULL,CONCAT(@W1_MON,' 07:41:05'),12,CONCAT(@W1_MON,' 07:41:05'),0,NULL,NULL,NULL,NULL,NULL,@visit_id,(select uuid()));

INSERT INTO `encounter_diagnosis` 
(`diagnosis_id`, `diagnosis_coded`, `diagnosis_non_coded`, `diagnosis_coded_name`, `encounter_id`, `patient_id`, `condition_id`, `certainty`, `rank`, `uuid`, `creator`, `date_created`, `changed_by`, `date_changed`, `voided`, `voided_by`, `date_voided`, `void_reason`)
VALUES 
(NULL,366105,NULL,NULL,@encounter_id+7,@patient_id,NULL,'PROVISIONAL',1,(select uuid()),12,CONCAT(@W1_MON,' 07:43:05'),NULL,NULL,0,NULL,NULL,NULL),
(NULL,363598,NULL,NULL,@encounter_id+7,@patient_id,NULL,'PROVISIONAL',2,(select uuid()),12,CONCAT(@W1_MON,' 07:43:05'),NULL,NULL,0,NULL,NULL,NULL),
(NULL,375899,NULL,NULL,@encounter_id+7,@patient_id,NULL,'PROVISIONAL',2,(select uuid()),12,CONCAT(@W1_MON,' 07:43:05'),NULL,NULL,0,NULL,NULL,NULL);

INSERT INTO `encounter_provider` 
(`encounter_provider_id`, `encounter_id`, `provider_id`, `encounter_role_id`, `creator`, `date_created`, `changed_by`, `date_changed`, `voided`, `date_voided`, `voided_by`, `void_reason`, `uuid`)
VALUES 
(NULL,@encounter_id,7,1,10,CONCAT(@W0_SUN,' 15:21:05'),NULL,NULL,0,NULL,NULL,NULL,(select uuid())),
(NULL,@encounter_id+1,7,1,10,CONCAT(@W0_SUN,' 15:21:10'),NULL,NULL,0,NULL,NULL,NULL,(select uuid())),
(NULL,@encounter_id+2,7,1,10,CONCAT(@W0_SUN,' 17:43:10'),NULL,NULL,0,NULL,NULL,NULL,(select uuid())),
(NULL,@encounter_id+3,9,1,12,CONCAT(@W0_SUN,' 17:46:10'),NULL,NULL,0,NULL,NULL,NULL,(select uuid())),
(NULL,@encounter_id+4,9,2,12,CONCAT(@W0_SUN,' 17:47:05'),NULL,NULL,0,NULL,NULL,NULL,(select uuid())),
(NULL,@encounter_id+5,9,2,5,CONCAT(@W0_SUN,' 17:47:10'),NULL,NULL,0,NULL,NULL,NULL,(select uuid())),
(NULL,@encounter_id+6,8,2,11,CONCAT(@W1_MON,' 07:41:05'),NULL,NULL,0,NULL,NULL,NULL,(select uuid())),
(NULL,@encounter_id+7,8,1,11,CONCAT(@W1_MON,' 07:43:05'),NULL,NULL,0,NULL,NULL,NULL,(select uuid())),
(NULL,@encounter_id+8,9,1,12,CONCAT(@W1_MON,' 07:41:05'),NULL,NULL,0,NULL,NULL,NULL,(select uuid()));

INSERT INTO `obs` (`obs_id`, `person_id`, `concept_id`, `encounter_id`, `order_id`, `obs_datetime`, `location_id`, `obs_group_id`, `accession_number`, `value_group_id`, `value_coded`, `value_coded_name_id`, `value_drug`, `value_datetime`, `value_numeric`, `value_modifier`, `value_text`, `value_complex`, `comments`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `uuid`, `previous_version`, `form_namespace_and_path`, `status`, `interpretation`)
VALUES 
(NULL,@patient_id,165172,@encounter_id,NULL,CONCAT(@W0_SUN,' 15:21:05'),9,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'m3ks | instructions.default | application/pdf | cellulitus_VerwijsbriefHA_20210702_101906_665bd741-e7d2-4a50-9ff4-4c2bb4cc828a.pdf','Verwijsbrief huisarts',10,CONCAT(@W0_SUN,' 15:21:05'),0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(NULL,@patient_id,165172,@encounter_id+1,NULL,CONCAT(@W0_SUN,' 15:21:10'),9,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'m3ks | instructions.default | application/pdf | cellulitis_lab1_20210702_102005_2bc0c6ae-31e1-4e24-90a6-e20bf6497c97.pdf','Lab zondag SEH',10,CONCAT(@W0_SUN,' 15:21:10'),0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(NULL,@patient_id,165172,@encounter_id+2,NULL,CONCAT(@W0_SUN,' 17:43:10'),9,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'m3ks | instructions.default | application/pdf | cellulitis_SEHOntslagbrief_20210702_102048_2b05fea5-af0f-4dda-a566-eabda2aff0b0.pdf','Ontslagbrief SEH',10,CONCAT(@W0_SUN,' 17:43:10'),0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(NULL,@patient_id,5088,@encounter_id+6,NULL,CONCAT(@W1_MON,' 07:41:05'),10,NULL,NULL,NULL,NULL,NULL,NULL,NULL,38.4,NULL,NULL,NULL,NULL,11,CONCAT(@W1_MON,' 07:41:05'),0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(NULL,@patient_id,5087,@encounter_id+6,NULL,CONCAT(@W1_MON,' 07:41:05'),10,NULL,NULL,NULL,NULL,NULL,NULL,NULL,88,NULL,NULL,NULL,NULL,11,CONCAT(@W1_MON,' 07:41:05'),0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(NULL,@patient_id,5242,@encounter_id+6,NULL,CONCAT(@W1_MON,' 07:41:05'),10,NULL,NULL,NULL,NULL,NULL,NULL,NULL,8,NULL,NULL,NULL,NULL,11,CONCAT(@W1_MON,' 07:41:05'),0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(NULL,@patient_id,5085,@encounter_id+6,NULL,CONCAT(@W1_MON,' 07:41:05'),10,NULL,NULL,NULL,NULL,NULL,NULL,NULL,134,NULL,NULL,NULL,NULL,11,CONCAT(@W1_MON,' 07:41:05'),0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(NULL,@patient_id,5086,@encounter_id+6,NULL,CONCAT(@W1_MON,' 07:41:05'),10,NULL,NULL,NULL,NULL,NULL,NULL,NULL,86,NULL,NULL,NULL,NULL,11,CONCAT(@W1_MON,' 07:41:05'),0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(NULL,@patient_id,5092,@encounter_id+6,NULL,CONCAT(@W1_MON,' 07:41:05'),10,NULL,NULL,NULL,NULL,NULL,NULL,NULL,98,NULL,NULL,NULL,NULL,11,CONCAT(@W1_MON,' 07:41:05'),0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(NULL,@patient_id,162169,@encounter_id+7,NULL,CONCAT(@W1_MON,' 07:43:05'),10,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Patiënte heeft rustig geslapen. Been doet nog pijn, toe- of afname van roodheid niet te beoordelen omdat roodheid niet afgetekend is. Controles vanochtend: T: 38.4 °C en glucose 16mmol/L. 1x bijgespoten en daarna heeft patiënte goed ontbeten. Infuus is gesneuveld. Arts vragen naar thuismedicatie te kijken want patiënte gebruikt thuis nog lisinopril en diclofenac en dit staat niet voorgeschreven.\r\nGlucosewaarden tot zover bekend:\r\nZondag opname: 11,6 mmol/l\r\nMaandag nuchter: 16,0 mmol/l waarop 4 EH bijgespoten \r\n\r\n- Alice V.',NULL,NULL,11,CONCAT(@W1_MON,' 07:43:05'),0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(NULL,@patient_id,165172,@encounter_id+8,NULL,CONCAT(@W1_MON,' 07:41:05'),9,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'m3ks | instructions.default | application/pdf | cellulitis_lab2_20210702_132701_51165df6-2ead-4a13-b940-f3283763b577.pdf','Lab maandagochtend',12,CONCAT(@W1_MON,' 07:41:05'),0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL);

INSERT INTO `orders` (`order_id`, `order_type_id`, `concept_id`, `orderer`, `encounter_id`, `instructions`, `date_activated`, `auto_expire_date`, `date_stopped`, `order_reason`, `order_reason_non_coded`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `patient_id`, `accession_number`, `uuid`, `urgency`, `order_number`, `previous_order_id`, `order_action`, `comment_to_fulfiller`, `care_setting`, `scheduled_date`, `order_group_id`, `sort_weight`, `fulfiller_comment`, `fulfiller_status`) 
VALUES 
(@order_id,2,431035,9,@encounter_id+4,NULL,CONCAT(@W0_SUN,' 17:47:05'),NULL,NULL,NULL,NULL,12,CONCAT(@W0_SUN,' 17:47:05'),0,NULL,NULL,NULL,@patient_id,NULL,(select uuid()),'ROUTINE',CONCAT('ORD-',@order_id),NULL,'NEW',NULL,1,NULL,NULL,NULL,NULL,NULL),
(@order_id+1,2,427457,9,@encounter_id+4,NULL,CONCAT(@W0_SUN,' 17:47:05'),NULL,NULL,NULL,NULL,12,CONCAT(@W0_SUN,' 17:47:05'),0,NULL,NULL,NULL,@patient_id,NULL,(select uuid()),'ROUTINE',CONCAT('ORD-',@order_id+1),NULL,'NEW',NULL,1,NULL,NULL,NULL,NULL,NULL),
(@order_id+2,2,427533,9,@encounter_id+4,NULL,CONCAT(@W0_SUN,' 17:47:05'),NULL,NULL,NULL,NULL,12,CONCAT(@W0_SUN,' 17:47:05'),0,NULL,NULL,NULL,@patient_id,NULL,(select uuid()),'ROUTINE',CONCAT('ORD-',@order_id+2),NULL,'NEW',NULL,1,NULL,NULL,NULL,NULL,NULL),
(@order_id+3,2,429551,9,@encounter_id+4,NULL,CONCAT(@W0_SUN,' 17:47:05'),NULL,NULL,NULL,NULL,12,CONCAT(@W0_SUN,' 17:47:05'),0,NULL,NULL,NULL,@patient_id,NULL,(select uuid()),'ROUTINE',CONCAT('ORD-',@order_id+3),NULL,'NEW',NULL,1,NULL,NULL,NULL,NULL,NULL),
(@order_id+4,2,427740,9,@encounter_id+4,NULL,CONCAT(@W0_SUN,' 17:47:10'),NULL,NULL,NULL,NULL,12,CONCAT(@W0_SUN,' 17:47:10'),0,NULL,NULL,NULL,@patient_id,NULL,(select uuid()),'ROUTINE',CONCAT('ORD-',@order_id+4),NULL,'NEW',NULL,1,NULL,NULL,NULL,NULL,NULL),
(@order_id+5,2,427867,9,@encounter_id+4,NULL,CONCAT(@W0_SUN,' 17:47:10'),NULL,NULL,NULL,NULL,12,CONCAT(@W0_SUN,' 17:47:10'),0,NULL,NULL,NULL,@patient_id,NULL,(select uuid()),'ROUTINE',CONCAT('ORD-',@order_id+5),NULL,'NEW',NULL,1,NULL,NULL,NULL,NULL,NULL),
(@order_id+6,2,427446,9,@encounter_id+4,NULL,CONCAT(@W0_SUN,' 17:47:10'),NULL,NULL,NULL,NULL,12,CONCAT(@W0_SUN,' 17:47:10'),0,NULL,NULL,NULL,@patient_id,NULL,(select uuid()),'ROUTINE',CONCAT('ORD-',@order_id+6),NULL,'NEW',NULL,1,NULL,NULL,NULL,NULL,NULL);
SET @Metoclopramide := @order_id;

INSERT INTO `drug_order` (`order_id`, `drug_inventory_id`, `dose`, `as_needed`, `dosing_type`, `quantity`, `as_needed_condition`, `num_refills`, `dosing_instructions`, `duration`, `duration_units`, `quantity_units`, `route`, `dose_units`, `frequency`, `brand_name`, `dispense_as_written`, `drug_non_coded`) 
VALUES 
(@order_id,3609,10,0,'org.openmrs.SimpleDosingInstructions',15,'misselijkheid',0,'10mg 3dd zn',NULL,NULL,162335,160242,161553,20,NULL,0,NULL),
(@order_id+1,31,1000,0,'org.openmrs.SimpleDosingInstructions',20,NULL,0,'2dd 2T',NULL,NULL,1513,160240,161553,11,NULL,0,NULL),
(@order_id+2,107,40,0,'org.openmrs.SimpleDosingInstructions',5,NULL,0,'1dd 1T',NULL,NULL,1513,160240,161553,16,NULL,0,NULL),
(@order_id+3,2125,60,0,'org.openmrs.SimpleDosingInstructions',10,NULL,0,'1dd 2T',NULL,NULL,1513,160240,161553,16,NULL,0,NULL),
(@order_id+4,314,1000,0,'org.openmrs.SimpleDosingInstructions',20,NULL,0,'1000mg 4dd',NULL,NULL,162395,160242,161553,24,NULL,0,NULL),
(@order_id+5,441,2,0,'org.openmrs.SimpleDosingInstructions',1,'volgens bijspuitschema',0,'volgens bijspuitschema (2-4-6) zo nodig o.b.v. POC',NULL,NULL,162376,160245,162381,4,NULL,0,NULL),
(@order_id+6,20,1.5,0,'org.openmrs.SimpleDosingInstructions',14,NULL,0,NULL,NULL,NULL,162262,160242,162262,15,NULL,0,NULL);