Steps for building synthetic patients:
1. [Install OpenMRS](https://github.com/ace-dvm/OpenMRS_edu/blob/master/OpenMRSBuildInstructions.txt) and add the drugs, diagnoses, lab orders, and other configuration that you need.
2. Make a copy of the database using mysqldump:
```bash
mysqldump -u openmrs -p openmrs > /home/YOURHOME/Database_clean.sql
```
This should be a working database. All passwords have been reset to Password1. You will need to change the value of the owa.appFolderPath global property to your own app folder.
```sql
update global_property set property_value = '/path/to/.OpenMRS/owa' where property = 'owa.appFolderPath';
```

3. Using the OpenMRS user interface, enter all the data for the patient. If possible, enter events in the order that they occur in the scenario. It is important to start with a sufficiently-detailed scenario. You will need the specific diagnoses, drugs, dosages, as well as files to attach such as referral letters, radiographs, etc. In this example we have also used attachments for blood test results, because this made the case much simpler to build.
4. Make another copy of the database using mysqldump. Be sure to give it a different file name.
```bash
mysqldump -u openmrs -p openmrs > /home/YOURHOME/Database_initialIrma.sql
```
5. Create a diff of the two database files.
```bash
diff Database_clean.sql Database_initialIrma.sql > diffIrma.diff
```
6. Convert this diff file into scripts for building an arbitrary number of copies of the patient:

	a. Pull out the tables involved in creating a patient. 
      Use the "[Template new patient](https://github.com/ace-dvm/OpenMRS_edu/blob/master/templateNewPatient.sql)" to guide which tables need to be extracted from the diff.

	b. Add variables for fields that need to change with each copy of the patient. These fields are listed in the template. Some fields can be replaced with NULL - these are indicated by the phrase "NULL <field name>". Replace uuids with (select uuid()).
	  Save the resulting file as a script (in this scenario: [buildCellulitis1.sql](https://github.com/ace-dvm/OpenMRS_edu/blob/master/buildCellulitis1.sql)).
	
	c. Pull out the tables involved in creating events that occur in the patient file.
	   Use the "[Template Patient Day](https://github.com/ace-dvm/OpenMRS_edu/blob/master/templatePatientDay.sql)" to guide which tables need to be extracted.
	
	d. Add variables for fields that need to change with each copy of the patient. Replace the dates of events with the dates that they should occur in the scenario. These dates will later be incremented by the updateAllDates script. Take care that events happen in a logical order and will be visible (i.e. they are in the past) at the moment when students view the file. E.g., if class starts at 9:00 on Monday, 7 September, make sure that all events that students should view at this time occur before 9:00 Monday. In this example I've used variables for the dates, so they can easily be changed.
	
	e. Once you have one complete script with variables, split the events into one script for each patient-day. (A patient-day might be a calendar day, but is really the time between classes. Thus if students view the case at 9:00 on Monday and then view it again at 16:00 Monday, we will want a separate script for events that occur between 9:00 and 16:00.)
	
   In this scenario we have 4 patient-days plus a script to create the patient:
	
   [buildCellulitis2.sql](https://github.com/ace-dvm/OpenMRS_edu/blob/master/buildCellulitis2.sql) - Monday morning
	
   [buildCellulitis3.sql](https://github.com/ace-dvm/OpenMRS_edu/blob/master/buildCellulitis3.sql) - Tuesday morning
	
   [buildCellulitis4.sql](https://github.com/ace-dvm/OpenMRS_edu/blob/master/buildCellulitis4.sql) - Wednesday morning
	
   [buildCellulitis5.sql](https://github.com/ace-dvm/OpenMRS_edu/blob/master/buildCellulitis5.sql) - post-discharge (Wednesday afternoon)
	
	f. Tidy the scripts. You will note lines like these in the scripts:
	
	  ```sql
	SET @repeatDx = (select max(diagnosis_id) from encounter_diagnosis); -- a where statement can be added if this isn't the last diagnosis added
	UPDATE encounter_diagnosis set voided = 1, voided_by = 8, date_voided = CONCAT(@W1_TUE,' 07:55:05') where diagnosis_coded = 366105 and patient_id = @patient_id and diagnosis_id != @repeatDx;
	```
	
	This is because OpenMRS requires a diagnosis to be entered with each visit note, and does not allow previous diagnoses to be reused. This means the list of visit diagnoses stacks up with repeat copies of the same diagnosis. This can be tidied by setting old copies to "voided."
	   Likewise, drugs can be discontinued or the dose adjusted with UPDATE statements.
	
	g. Once you have a script for each patient-day, create the master build script. This script calls each of the others to build each patient-day. In this example that's [buildCellulitis.sql](https://github.com/ace-dvm/OpenMRS_edu/blob/master/buildCellulitis.sql). Each day starts with building a patient (script [buildCellulitis1.sql](https://github.com/ace-dvm/OpenMRS_edu/blob/master/buildCellulitis1.sql)) and then builds the case for each day. Each day should contain all the details from the previous days, so each day calls all the previous scripts and adds one. 
	
This script should set the values for the variables used in the scripts. In this scenario, that's:
* @first_suffix: A prefix added to the beginning of the patient's surname. Allows students to easily identify "their" copy of the patient.
* @second_suffix: A suffix added to the end of the patient's surname. Allows students to identify which case-day they should be viewing. (MaO is "maandag ochtend" or monday morning).
* @patient_id = the patient id in the database
* @idpad = creates a patient identifier related to the patient's database id - pads it with zeros so we will always have the same length
* @identifier = creates the patient identifier from the @idpad
	
This scenario also contains all the common variables required for each patient-day:
* @visit_id
* @allergy_id
* @encounter_id
* @order_id
	
These latter variables should be reset at each patient-day, as you see in the example script.
	
7. Build a copy of the case for each student. This requires a simple script to change the @first_suffix and call buildCellulitis.sql once for each student in the class. An example can be seen in [example_buildForStudents.sql](https://github.com/ace-dvm/OpenMRS_edu/blob/master/example_buildForStudents.sql).
Here you can also see that we decided to re-use this case in another course, "TKD". We simply created a new copy for each student in the additional course.
   If we want to add more patients, we can just add more "source" lines, or we can move all the "source" lines off to another script to keep this one tidy.
8. Upload the script to the tmp directory on the OpenMRS server. In the MariaDB command line, run the example_buildForStudents.sql script:
```sql
  source /tmp/example_buildForStudents.sql
  ```
9. Dump the database again so you have a nice clean copy with all the students and patients:
  ```bash
  mysqldump -u openmrs -p openmrs > /home/YOURHOME/Database_complete.sql
  ```
10. In our case, a new group of students starts the course every 3 weeks. We want the cases to unfold in "real time", therefore the dates of events in are updated every 3 weeks. I've added an extra table to the database, "classdates", that records the first day of class for each group. (It shifts a little due to holidays, thus it's easier to put it in a table than to do date math.) The [updateAllDates.sql](https://github.com/ace-dvm/OpenMRS_edu/blob/master/updateAllDates.sql) script updates the dates; [updateAllTimes](https://github.com/ace-dvm/OpenMRS_edu/blob/master/updateAllTimes.sql) accounts for daylight savings. Every 3 weeks the database should be refreshed:
  ```sql
  source /tmp/Database_complete.sql
  ```
and the dates updated:
```sql
  source /tmp/updateAllDates.sql
  ```
