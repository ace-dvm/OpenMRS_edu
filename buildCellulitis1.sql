select 'create Irma';

INSERT INTO `patient` 
(`patient_id`, `creator`, `date_created`, `changed_by`, `date_changed`, `voided`, `voided_by`, `date_voided`, `void_reason`, `allergy_status`)
VALUES
(@patient_id,8,'2021-07-02 08:16:26',NULL,NULL,0,NULL,NULL,NULL,'See list');

INSERT INTO `patient_identifier` 
(`patient_identifier_id`, `patient_id`, `identifier`, `identifier_type`, `preferred`, `location_id`, `creator`, `date_created`, `date_changed`, `changed_by`, `voided`, `voided_by`, `date_voided`, `void_reason`, `uuid`)
VALUES 
(NULL,@patient_id,@identifier,4,1,10,8,'2021-07-02 08:16:26',NULL,NULL,0,NULL,NULL,NULL,(select uuid()));

INSERT INTO `person` 
(`person_id`, `gender`, `birthdate`, `birthdate_estimated`, `dead`, `death_date`, `cause_of_death`, `creator`, `date_created`, `changed_by`, `date_changed`, `voided`, `voided_by`, `date_voided`, `void_reason`, `uuid`, `deathdate_estimated`, `birthtime`, `cause_of_death_non_coded`)
VALUES 
(@patient_id,'F','1970-03-07',0,0,NULL,NULL,8,'2021-07-02 08:16:26',NULL,NULL,0,NULL,NULL,NULL,(select uuid()),0,NULL,NULL);

INSERT INTO `person_address` 
(`person_address_id`, `person_id`, `preferred`, `address1`, `address2`, `city_village`, `state_province`, `postal_code`, `country`, `latitude`, `longitude`, `start_date`, `end_date`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `county_district`, `address3`, `address4`, `address5`, `address6`, `date_changed`, `changed_by`, `uuid`, `address7`, `address8`, `address9`, `address10`, `address11`, `address12`, `address13`, `address14`, `address15`)
VALUES 
(NULL,@patient_id,1,'Nieuwezijds Voorburgwal 147',NULL,'Amsterdam',NULL,'1012 RJ','NL',NULL,NULL,NULL,NULL,8,'2021-07-02 08:16:26',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,(select uuid()),NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);

INSERT INTO `person_attribute` 
(`person_attribute_id`, `person_id`, `value`, `person_attribute_type_id`, `creator`, `date_created`, `changed_by`, `date_changed`, `voided`, `voided_by`, `date_voided`, `void_reason`, `uuid`)
VALUES
(NULL,@patient_id,'020-1234567',8,8,'2021-07-02 08:16:26',NULL,NULL,0,NULL,NULL,NULL,(select uuid()));

INSERT INTO `person_name` 
(`person_name_id`, `preferred`, `person_id`, `prefix`, `given_name`, `middle_name`, `family_name_prefix`, `family_name`, `family_name2`, `family_name_suffix`, `degree`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `changed_by`, `date_changed`, `uuid`)
VALUES 
(NULL,1,@patient_id,NULL,'Irma',NULL,NULL,CONCAT(@first_suffix, 'Andriessen', @second_suffix),NULL,NULL,NULL,8,'2021-07-02 08:16:26',0,NULL,NULL,NULL,NULL,NULL,(select uuid()));

INSERT INTO `relationship`
(`relationship_id`, `person_a`, `relationship`, `person_b`, `start_date`, `end_date`, `creator`, `date_created`, `date_changed`, `changed_by`, `voided`, `voided_by`, `date_voided`, `void_reason`, `uuid`)
VALUES
(NULL,@patient_id,3,21,NULL,NULL,8,'2021-07-02 08:16:26',NULL,NULL,0,NULL,NULL,NULL,(select uuid()));
