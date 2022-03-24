/* Templates */
-- replace all uuids, @patient_id, @visit_id
/* Template new patient */
INSERT INTO `patient` 
(`patient_id`, `creator`, `date_created`, `changed_by`, `date_changed`, `voided`, `voided_by`, `date_voided`, `void_reason`, `allergy_status`)
VALUES
-- replace @patient_id

INSERT INTO `patient_identifier` 
(`patient_identifier_id`, `patient_id`, `identifier`, `identifier_type`, `preferred`, `location_id`, `creator`, `date_created`, `date_changed`, `changed_by`, `voided`, `voided_by`, `date_voided`, `void_reason`, `uuid`)
VALUES 
-- replace @patient_id, @identifier, NULL patient_identifier_id

INSERT INTO `person` 
(`person_id`, `gender`, `birthdate`, `birthdate_estimated`, `dead`, `death_date`, `cause_of_death`, `creator`, `date_created`, `changed_by`, `date_changed`, `voided`, `voided_by`, `date_voided`, `void_reason`, `uuid`, `deathdate_estimated`, `birthtime`, `cause_of_death_non_coded`)
VALUES 
-- replace @patient_id

INSERT INTO `person_address` 
(`person_address_id`, `person_id`, `preferred`, `address1`, `address2`, `city_village`, `state_province`, `postal_code`, `country`, `latitude`, `longitude`, `start_date`, `end_date`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `county_district`, `address3`, `address4`, `address5`, `address6`, `date_changed`, `changed_by`, `uuid`, `address7`, `address8`, `address9`, `address10`, `address11`, `address12`, `address13`, `address14`, `address15`)
VALUES 
-- replace @patient_id, NULL person_address_id

INSERT INTO `person_attribute` 
(`person_attribute_id`, `person_id`, `value`, `person_attribute_type_id`, `creator`, `date_created`, `changed_by`, `date_changed`, `voided`, `voided_by`, `date_voided`, `void_reason`, `uuid`)
VALUES
-- replace @patient_id, NULL person_attribute_id

INSERT INTO `person_name` 
(`person_name_id`, `preferred`, `person_id`, `prefix`, `given_name`, `middle_name`, `family_name_prefix`, `family_name`, `family_name2`, `family_name_suffix`, `degree`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `changed_by`, `date_changed`, `uuid`)
VALUES 
-- replace @patient_id, CONCAT(@first_suffix,family_name,@second_suffix), NULL person_name_id

INSERT INTO `relationship`
(`relationship_id`, `person_a`, `relationship`, `person_b`, `start_date`, `end_date`, `creator`, `date_created`, `date_changed`, `changed_by`, `voided`, `voided_by`, `date_voided`, `void_reason`, `uuid`)
VALUES
-- replace @patient_id (person_a) and replace person_b if needed, NULL relationship_id