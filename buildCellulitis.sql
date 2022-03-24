/* Cellulitis case
*/

/* TODO add NaCl to this case (see Dakloze case for how to do it) */

SET foreign_key_checks = 0; -- prevents annoying errors while building
/* vars that stay the same throughout the build */
set @first_suffix = if(@first_suffix is null, '1-', @first_suffix); -- allows this to be set by a calling script, or not.
set @W0_SUN = if(@W0_SUN is null, '2021-06-20', @W0_SUN);
set @W1_MON = if(@W1_MON is null, '2021-06-21', @W1_MON);
set @W1_TUE = if(@W1_TUE is null, '2021-06-22', @W1_TUE);
set @W1_WED = if(@W1_WED is null, '2021-06-23', @W1_WED);


/* cellulitis 1: create patient */
SET @second_suffix := '-MaO'; -- this indicates when the student is expected to read the case
SET @patient_id = (select max(person_id) + 1 from person);
SET @idpad = (SELECT LPAD(@patient_id, 6, 0)); -- pads the patient_id with 0's to get to length 6
SET @identifier = CONCAT('777777',@idpad);
source /tmp/buildCellulitis1.sql;
/* Maandagochtend */
-- use Coalesce on the first run to ensure that we get a valid number
SET @visit_id = CAST(COALESCE((select max(visit_id) + 1 from visit),(SELECT `AUTO_INCREMENT` FROM  INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'openmrs' AND   TABLE_NAME   = 'visit'),1) as int);
SET @allergy_id = CAST(COALESCE((select max(allergy_id) + 1 from allergy),(SELECT `AUTO_INCREMENT` FROM  INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'openmrs' AND   TABLE_NAME   = 'allergy'),1) as int);
SET @encounter_id = CAST(COALESCE((select max(encounter_id) + 1 from encounter),(SELECT `AUTO_INCREMENT` FROM  INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'openmrs' AND   TABLE_NAME   = 'encounter'),1) as int);
SET @order_id = CAST(COALESCE((select max(order_id) + 1 from orders),(SELECT `AUTO_INCREMENT` FROM  INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'openmrs' AND   TABLE_NAME   = 'orders'),1) as int);
source /tmp/buildCellulitis2.sql;

/******** Dinsdag ***********/
SET @second_suffix := '-DiO'; -- this indicates when the student is expected to read the case
SET @patient_id = (select max(person_id) + 1 from person);
SET @idpad = (SELECT LPAD(@patient_id, 6, 0)); -- pads the patient_id with 0's to get to length 6
SET @identifier = CONCAT('777777',@idpad);
source /tmp/buildCellulitis1.sql;
/* Maandagochtend */
SET @visit_id = (select max(visit_id) + 1 from visit);
SET @allergy_id = (select max(allergy_id) + 1 from allergy);
SET @encounter_id = (select max(encounter_id) + 1 from encounter);
SET @order_id = (select max(order_id) + 1 from orders);
source /tmp/buildCellulitis2.sql;
/* Dinsdagochtend */
SET @encounter_id = (select max(encounter_id) + 1 from encounter);
source /tmp/buildCellulitis3.sql;

/*********** Woensdag *************/
SET @second_suffix := '-WoO'; -- this indicates when the student is expected to read the case
SET @patient_id = (select max(person_id) + 1 from person);
SET @idpad = (SELECT LPAD(@patient_id, 6, 0)); -- pads the patient_id with 0's to get to length 6
SET @identifier = CONCAT('777777',@idpad);
source /tmp/buildCellulitis1.sql;
/* Maandagochtend */
SET @visit_id = (select max(visit_id) + 1 from visit);
SET @allergy_id = (select max(allergy_id) + 1 from allergy);
SET @encounter_id = (select max(encounter_id) + 1 from encounter);
SET @order_id = (select max(order_id) + 1 from orders);
source /tmp/buildCellulitis2.sql;
/* Dinsdagochtend */
SET @encounter_id = (select max(encounter_id) + 1 from encounter);
source /tmp/buildCellulitis3.sql;
/* Woensdagochtend */
SET @encounter_id = (select max(encounter_id) + 1 from encounter);
SET @order_id = (select max(order_id) + 1 from orders);
source /tmp/buildCellulitis4.sql;

/************** Ontslag ***************/
SET @second_suffix := '-Ontslag'; -- this indicates when the student is expected to read the case
SET @patient_id = (select max(person_id) + 1 from person);
SET @idpad = (SELECT LPAD(@patient_id, 6, 0)); -- pads the patient_id with 0's to get to length 6
SET @identifier = CONCAT('777777',@idpad);
source /tmp/buildCellulitis1.sql;
/* Maandagochtend */
SET @visit_id = (select max(visit_id) + 1 from visit);
SET @allergy_id = (select max(allergy_id) + 1 from allergy);
SET @encounter_id = (select max(encounter_id) + 1 from encounter);
SET @order_id = (select max(order_id) + 1 from orders);
source /tmp/buildCellulitis2.sql;
/* Dinsdagochtend */
SET @encounter_id = (select max(encounter_id) + 1 from encounter);
source /tmp/buildCellulitis3.sql;
/* Woensdagochtend */
SET @encounter_id = (select max(encounter_id) + 1 from encounter);
SET @order_id = (select max(order_id) + 1 from orders);
source /tmp/buildCellulitis4.sql;
/* Ontslag */
SET @encounter_id = (select max(encounter_id) + 1 from encounter);
source /tmp/buildCellulitis5.sql;

/* cleanup */
SET @order_id = (select max(order_id) + 1 from orders);
update global_property set property_value = @order_id where property = 'order.nextOrderNumberSeed';
SET foreign_key_checks = 1;
update global_property set property_value = (select max(order_id) +1 from orders) where property = 'order.nextOrderNumberSeed';
