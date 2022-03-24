/* template patient-days */
INSERT INTO `visit` 
(`visit_id`, `patient_id`, `visit_type_id`, `date_started`, `date_stopped`, `indication_concept_id`, `location_id`, `creator`, `date_created`, `changed_by`, `date_changed`, `voided`, `voided_by`, `date_voided`, `void_reason`, `uuid`)
VALUES 
-- replace @visit_id, @patient_id, date_started/date_created, creator, +/- location_id

INSERT INTO `allergy` (`allergy_id`, `patient_id`, `severity_concept_id`, `coded_allergen`, `non_coded_allergen`, `allergen_type`, `comments`, `creator`, `date_created`, `changed_by`, `date_changed`, `voided`, `voided_by`, `date_voided`, `void_reason`, `uuid`) 
VALUES
-- replace @patient_id, creator, @allergy_id (if reaction recorded) or NULL allergy_id

INSERT INTO `allergy_reaction` (`allergy_reaction_id`, `allergy_id`, `reaction_concept_id`, `reaction_non_coded`, `uuid`)
VALUES
-- replace @allergy_id, NULL allergy_reaction_id

INSERT INTO `conditions` (condition_id,additional_detail,previous_version,condition_coded,condition_non_coded,condition_coded_name,clinical_status,verification_status,onset_date,date_created,voided,date_voided,void_reason,uuid,creator,voided_by,changed_by,patient_id,end_date,date_changed,encounter_id,form_namespace_and_path) 
VALUES 
-- date_created, creator, @patient_id, NULL condition_id (encounter_id is null)

INSERT INTO `encounter` 
(`encounter_id`, `encounter_type`, `patient_id`, `location_id`, `form_id`, `encounter_datetime`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `changed_by`, `date_changed`, `visit_id`, `uuid`)
VALUES 
-- @encounter_id, @patient_id, (check location_id); encounter_datetime, creator, date_created, @visit_id

INSERT INTO `encounter_diagnosis` 
(`diagnosis_id`, `diagnosis_coded`, `diagnosis_non_coded`, `diagnosis_coded_name`, `encounter_id`, `patient_id`, `condition_id`, `certainty`, `rank`, `uuid`, `creator`, `date_created`, `changed_by`, `date_changed`, `voided`, `voided_by`, `date_voided`, `void_reason`)
VALUES 
-- @encounter_id, @patient_id, creator, date_created, diagnosis_id = NULL

-- SET @repeatDx = (select max(diagnosis_id) from encounter_diagnosis);
-- UPDATE encounter_diagnosis set voided = 1, voided_by = 8, date_voided = CONCAT(@W1_THR,' 11:27:05') where diagnosis_coded = 121629 and patient_id = @patient_id and diagnosis_id != @repeatDx;

INSERT INTO `encounter_provider` 
(`encounter_provider_id`, `encounter_id`, `provider_id`, `encounter_role_id`, `creator`, `date_created`, `changed_by`, `date_changed`, `voided`, `date_voided`, `voided_by`, `void_reason`, `uuid`)
VALUES 
-- @encounter_id, provider_id, creator, date_created, encounter_provider_id = NULL

INSERT INTO `obs` (`obs_id`, `person_id`, `concept_id`, `encounter_id`, `order_id`, `obs_datetime`, `location_id`, `obs_group_id`, `accession_number`, `value_group_id`, `value_coded`, `value_coded_name_id`, `value_drug`, `value_datetime`, `value_numeric`, `value_modifier`, `value_text`, `value_complex`, `comments`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `uuid`, `previous_version`, `form_namespace_and_path`, `status`, `interpretation`)
VALUES 
-- replace @person_id, @encounter_id, obs_datetime,creator, date_created, obs_id = NULL, (check location_id)

INSERT INTO `orders` (`order_id`, `order_type_id`, `concept_id`, `orderer`, `encounter_id`, `instructions`, `date_activated`, `auto_expire_date`, `date_stopped`, `order_reason`, `order_reason_non_coded`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `patient_id`, `accession_number`, `uuid`, `urgency`, `order_number`, `previous_order_id`, `order_action`, `comment_to_fulfiller`, `care_setting`, `scheduled_date`, `order_group_id`, `sort_weight`, `fulfiller_comment`, `fulfiller_status`) 
VALUES 
-- replace @order_id, orderer (provider_id); @encounter_id, date_activated, creator, date_created, @patient_id, order_number = CONCAT('ORD-',@order_id); +/- auto_expire_date = NULL

-- update orders set voided = 1, voided_by = 8, date_voided = CONCAT(@W1_THR,' 07:36:05') where order_id = @Gentamicine;

INSERT INTO `drug_order` (`order_id`, `drug_inventory_id`, `dose`, `as_needed`, `dosing_type`, `quantity`, `as_needed_condition`, `num_refills`, `dosing_instructions`, `duration`, `duration_units`, `quantity_units`, `route`, `dose_units`, `frequency`, `brand_name`, `dispense_as_written`, `drug_non_coded`) 
VALUES 
-- replace @order_id


