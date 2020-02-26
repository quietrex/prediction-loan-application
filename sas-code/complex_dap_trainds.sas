/* Name of Data Scientist: Chan Kuok Hong */
/* Name of Program: tp034717_complex_dap_trainds.sas */
/* Description: To load dataset and perform data exploration */
/* Date First Written: Monday 7-Nov-2019 */
/* Date Last Modified: Monday 18-Nov-2019 */

/* Backup dataset to ensure dataset remained unchange/unmodify to the original dataset.*/
DATA TP034717.DAPSEP2019_LOAN_TRAININGSET;
SET TP034717.MYLOAN_TRAIN_ORIGINAL_DS;
RUN;

/* From the observations above, data has 13 variables and 614 observations*/

/* Loading dataset with Proc print*/
PROC PRINT DATA = TP034717.DAPSEP2019_LOAN_TRAININGSET;
TITLE 'Observations from the newly created dataset';
RUN;

/* From the observation above, data scientist has dig deep into the data structures, 
data scientist noticed, there are 10 categorical variables and 3 continuous variables*/
/* Viewing 20 observations from the Categorical Variables */
PROC SQL outobs= 20;

TITLE 'Viewing 20 observations from the Categorical Variables';
SELECT SME_LOAN_ID_NO LABEL 'SME Loan Id No',
	   GENDER LABEL 'Gender',
	   MARITAL_STATUS LABEL 'Marital Status',
	   FAMILY_MEMBERS LABEL 'Family Members',
	   QUALIFICATION LABEL 'Qualification',
	   EMPLOYMENT LABEL 'Employment',
	   LOAN_DURATION LABEL 'Loan Duration',
	   LOAN_HISTORY LABEL 'Loan History',
	   LOAN_LOCATION LABEL 'Loan Location',
	   LOAN_APPROVAL_STATUS LABEL 'Approval Status' 
FROM TP034717.DAPSEP2019_LOAN_TRAININGSET;

QUIT;

/* Viewing 20 observations from the Continuous Variables */
PROC SQL outobs= 20;

TITLE 'Viewing 20 observations from the Continuous Variables';
SELECT CANDIDATE_INCOME LABEL 'Candidate Income',
	   GUARANTEE_INCOME LABEL 'Guarantee Income',
	   LOAN_AMOUNT LABEL 'Loan Amount'
FROM TP034717.DAPSEP2019_LOAN_TRAININGSET;

QUIT;

/* To ensure data cleaned from doing analysis, 
first the data scientist decided to dig deep once again into each of the variables by checking the missing values to the data*/

/* Check missing values*/
/* Creating macro format for both missing and not missing groups */
%MACRO missing_value_categorical;

	PROC FORMAT;
	 VALUE $missfmt ' '='Missing' other='Not Missing';
	 VALUE  missfmt  . ='Missing' other='Not Missing';
	RUN;
	 
	/* Counting missing values for cateogorical variables */ 
	PROC FREQ DATA = TP034717.DAPSEP2019_LOAN_TRAININGSET;
	TITLE 'Counting missing values for categorical variables on training set';
	TABLE SME_LOAN_ID_NO GENDER MARITAL_STATUS FAMILY_MEMBERS QUALIFICATION 
		  EMPLOYMENT LOAN_DURATION LOAN_HISTORY LOAN_LOCATION LOAN_APPROVAL_STATUS;  
	FORMAT _CHAR_ $MISSFMT.; 
	TABLES _CHAR_ / MISSING MISSPRINT NOCUM NOPERCENT;
	FORMAT _NUMERIC_ MISSFMT.;
	TABLES _NUMERIC_ / MISSING MISSPRINT NOCUM NOPERCENT;
	RUN;

%MEND missing_value_categorical;
%missing_value_categorical /* Printing - missing values for categorical variables */ 

%MACRO missing_value_continuous;

	PROC FORMAT;
	 VALUE $missfmt ' '='Missing' other='Not Missing';
	 VALUE  missfmt  . ='Missing' other='Not Missing';
	RUN;
	 
	/* Counting missing values for continuous variables */ 
	PROC FREQ DATA = TP034717.DAPSEP2019_LOAN_TRAININGSET;
	TITLE 'Counting missing values for continuous variables on training set';
	TABLE CANDIDATE_INCOME GUARANTEE_INCOME LOAN_AMOUNT;  
	FORMAT _CHAR_ $MISSFMT.; 
	TABLES _CHAR_ / MISSING MISSPRINT NOCUM NOPERCENT;
	FORMAT _NUMERIC_ MISSFMT.;
	TABLES _NUMERIC_ / MISSING MISSPRINT NOCUM NOPERCENT;
RUN;

%MEND missing_value_continuous;
%missing_value_continuous /* Counting missing values for continuous variables */ 

/* Univariate Analysis of the categorical variables*/
/* 1. Gender*/
/* Viewing observations of gender frequency */
PROC FREQ DATA = TP034717.DAPSEP2019_LOAN_TRAININGSET;
TITLE 'Viewing observations of gender frequency';
TABLE GENDER;
RUN;

ODS GRAPHICS / RESET WIDTH=4.0 IN HEIGHT = 3.0 IN IMAGEMAP;
PROC SGPLOT DATA  = TP034717.DAPSEP2019_LOAN_TRAININGSET;
VBAR GENDER;
TITLE 'Univariate Analysis of the variable GENDER';
RUN;

/* 2. Marital Status */
/* Viewing observations of marital status frequency */
PROC FREQ DATA = TP034717.DAPSEP2019_LOAN_TRAININGSET;
TITLE 'Viewing observations of marital status frequency';
TABLE MARITAL_STATUS;
RUN;

ODS GRAPHICS / RESET WIDTH=4.0 IN HEIGHT = 3.0 IN IMAGEMAP;
PROC SGPLOT DATA  = TP034717.DAPSEP2019_LOAN_TRAININGSET;
VBAR MARITAL_STATUS;
TITLE 'Univariate Analysis of the variable Marital Status';
RUN;

/* 3. Family Members*/
PROC FREQ DATA = TP034717.DAPSEP2019_LOAN_TRAININGSET;
TITLE 'Viewing observations of family members frequency';
TABLE FAMILY_MEMBERS;
RUN;

ODS GRAPHICS / RESET WIDTH=4.0 IN HEIGHT = 3.0 IN IMAGEMAP;
PROC SGPLOT DATA  = TP034717.DAPSEP2019_LOAN_TRAININGSET;
VBAR FAMILY_MEMBERS;
TITLE 'Univariate Analysis of the variable Family Members';
RUN;

/* 4. Employment*/
PROC FREQ DATA = TP034717.DAPSEP2019_LOAN_TRAININGSET;
TITLE 'Viewing observations of Employment frequency';
TABLE EMPLOYMENT;
RUN;

ODS GRAPHICS / RESET WIDTH=4.0 IN HEIGHT = 3.0 IN IMAGEMAP;
PROC SGPLOT DATA  = TP034717.DAPSEP2019_LOAN_TRAININGSET;
VBAR EMPLOYMENT;
TITLE 'Univariate Analysis of the variable Employment';
RUN;

/* 5. Loan Duration*/
PROC FREQ DATA = TP034717.DAPSEP2019_LOAN_TRAININGSET;
TITLE 'Viewing observations of loan duration frequency';
TABLE LOAN_DURATION;
RUN;

ODS GRAPHICS / RESET WIDTH=4.0 IN HEIGHT = 3.0 IN IMAGEMAP;
PROC SGPLOT DATA  = TP034717.DAPSEP2019_LOAN_TRAININGSET;
VBAR LOAN_DURATION;
TITLE 'Univariate Analysis of the variable Loan Duration';
RUN;

/* 6. Loan History*/
PROC FREQ DATA = TP034717.DAPSEP2019_LOAN_TRAININGSET;
TITLE 'Viewing observations of loan history frequency';
TABLE LOAN_HISTORY;
RUN;

ODS GRAPHICS / RESET WIDTH=4.0 IN HEIGHT = 3.0 IN IMAGEMAP;
PROC SGPLOT DATA  = TP034717.DAPSEP2019_LOAN_TRAININGSET;
VBAR LOAN_HISTORY;
TITLE 'Univariate Analysis of the variable Loan History';
RUN;

/* 7. Loan Approval Status*/
PROC FREQ DATA = TP034717.DAPSEP2019_LOAN_TRAININGSET;
TITLE 'Viewing observations of loan approval status frequency';
TABLE LOAN_APPROVAL_STATUS;
RUN;

ODS GRAPHICS / RESET WIDTH=4.0 IN HEIGHT = 3.0 IN IMAGEMAP;
PROC SGPLOT DATA  = TP034717.DAPSEP2019_LOAN_TRAININGSET;
VBAR LOAN_APPROVAL_STATUS;
TITLE 'Univariate Analysis of the variable Loan Approval Status';
RUN;

/* Univariate Analysis of the continuous variables*/

/* 8. Candidate Income*/
TITLE 'Total number of missing values for candidate income';
PROC MEANS data=TP034717.DAPSEP2019_LOAN_TRAININGSET NMISS N;
VAR CANDIDATE_INCOME; 
RUN;

PROC FREQ DATA = TP034717.DAPSEP2019_LOAN_TRAININGSET;
TITLE 'Viewing observations of candidate income frequency';
TABLE CANDIDATE_INCOME;
RUN;

PROC SQL OUTOBS= 20;

TITLE 'Viewing first 20 observation on candidate income using group by';
SELECT CANDIDATE_INCOME LABEL 'Candidate Income',
	   COUNT(CANDIDATE_INCOME) LABEL 'Count'
	   FROM TP034717.DAPSEP2019_LOAN_TRAININGSET
	   GROUP BY CANDIDATE_INCOME;

QUIT;

/* 9. Loan Amount - Showing number of missing values for loan amount*/
TITLE 'Total number of missing values for loan amount';
PROC MEANS data=TP034717.DAPSEP2019_LOAN_TRAININGSET NMISS N;
VAR LOAN_AMOUNT; 
RUN;

/* Viewing observation from loan amount with missing value*/
PROC SQL;
TITLE 'Viewing missing value from variable loan amount that is not within minium and maximum value (missing values)';
SELECT SME_LOAN_ID_NO LABEL 'SME Loan Id No',
	   LOAN_AMOUNT LABEL 'Loan amount'
FROM  TP034717.DAPSEP2019_LOAN_TRAININGSET
HAVING NOT LOAN_AMOUNT BETWEEN MIN(LOAN_AMOUNT) and MAX(LOAN_AMOUNT);
QUIT;

/* Getting loan amount frequency*/
PROC FREQ DATA = TP034717.DAPSEP2019_LOAN_TRAININGSET;
TITLE 'Viewing observations of loan amount frequency';
TABLE LOAN_AMOUNT;
RUN;

/* Missing values imputation for (categorical and continuous)*/

/*1. Imputing Gender by candidate income group*/

PROC SQL;

TITLE 'Viewing observations for gender with missing values by candidate income';
/* DAPSEP2019_LOAN_TRAININGSET found 13 missing values */
SELECT SME_LOAN_ID_NO LABEL 'SME Loan Id',
	   GENDER LABEL 'Gender', 
	   CANDIDATE_INCOME LABEL 'Candidate Income' FROM TP034717.DAPSEP2019_LOAN_TRAININGSET 
	   WHERE GENDER IS MISSING OR GENDER EQ '';

QUIT;	

/* Proc univariate with Candidate income */
PROC UNIVARIATE DATA = TP034717.DAPSEP2019_LOAN_TRAININGSET ;

VAR CANDIDATE_INCOME;
OUTPUT OUT = TP034717.UNI_CANDIDATE_INCOME_GROUP PCTLPTS = 0, 25, 50, 75 95, 100 PCTLPRE = IncomeRange_;

RUN;

PROC SQL;
TITLE 'Viewing observations of interquartile range from income';
/* Viewing observations of interquartile range from income*/
SELECT * FROM TP034717.UNI_CANDIDATE_INCOME_GROUP;

QUIT;

/* Creating new column - named IncomeGroup to indicate which income group an income belongs to*/
DATA TP034717.DAPSEP2019_LOAN_TRAININGSET;
SET TP034717.DAPSEP2019_LOAN_TRAININGSET;
IncomeGroup = CANDIDATE_INCOME;
RUN;

PROC SQL;

/* Update into existing TP034717.UNI_CANDIDATE_INCOME_GROUP dataset */
UPDATE TP034717.DAPSEP2019_LOAN_TRAININGSET 
SET 
IncomeGroup = CASE

WHEN CANDIDATE_INCOME >= (SELECT IncomeRange_0 FROM TP034717.UNI_CANDIDATE_INCOME_GROUP) AND 
	 CANDIDATE_INCOME < (SELECT IncomeRange_25 FROM TP034717.UNI_CANDIDATE_INCOME_GROUP) THEN 1
	 
WHEN CANDIDATE_INCOME >= (SELECT IncomeRange_25 FROM TP034717.UNI_CANDIDATE_INCOME_GROUP) AND 
	 CANDIDATE_INCOME < (SELECT IncomeRange_50 FROM TP034717.UNI_CANDIDATE_INCOME_GROUP) THEN 2

WHEN CANDIDATE_INCOME >= (SELECT IncomeRange_50 FROM TP034717.UNI_CANDIDATE_INCOME_GROUP) AND 
	 CANDIDATE_INCOME < (SELECT IncomeRange_75 FROM TP034717.UNI_CANDIDATE_INCOME_GROUP) THEN 3

WHEN CANDIDATE_INCOME >= (SELECT IncomeRange_75 FROM TP034717.UNI_CANDIDATE_INCOME_GROUP) AND 
	 CANDIDATE_INCOME <= (SELECT IncomeRange_100 FROM TP034717.UNI_CANDIDATE_INCOME_GROUP) THEN 4

ELSE IncomeGroup = 5
END;
QUIT;

/* Verify if income is in proper grouping*/
PROC FREQ DATA = TP034717.DAPSEP2019_LOAN_TRAININGSET;
TITLE 'Verify if it has correct grouping';
TABLE IncomeGroup;
RUN;

PROC SQL;

TITLE 'Viewing observations for gender with missing values by candidate income group';
/* DAPSEP2019_LOAN_TRAININGSET found 13 missing values */
SELECT SME_LOAN_ID_NO LABEL 'SME Loan Id',
	   GENDER LABEL 'Gender', 
	   CANDIDATE_INCOME LABEL 'Candidate Income', 
	   INCOMEGROUP LABEL 'Income Group' FROM TP034717.DAPSEP2019_LOAN_TRAININGSET 
	   WHERE GENDER IS MISSING OR GENDER EQ '';

QUIT;	

/* Missing value imputation on gender by candidate income group*/

/* Creating temporary TP034717.DAPSEP2019_LOAN_TRAININGSET dataset for backup purposes*/
DATA TP034717.TEMP_DAPSEP2019_LOAN_TRAININGSET; /* temporary dataset*/
SET TP034717.DAPSEP2019_LOAN_TRAININGSET; /* dataset the data scientist will use for data imputation*/
RUN;

/* Retrieving gender by mode from each grouping (group 1 to group 4)*/
PROC SQL;

TITLE 'Retrieve gender by mode from group 1';
/* Replacing gender by mode when Income group is 1 */
SELECT GENDER as MODE FROM ( SELECT GENDER, COUNT(1) as count FROM TP034717.TEMP_DAPSEP2019_LOAN_TRAININGSET
  							 WHERE ( INCOMEGROUP EQ 1 ) GROUP BY GENDER ) 
HAVING COUNT = MAX( count );
  			
TITLE 'Retrieve gender by mode from group 2';  			
/* Replacing gender by mode when Income group is 2 */  							 
SELECT GENDER as MODE FROM ( SELECT GENDER, COUNT(1) as count FROM TP034717.TEMP_DAPSEP2019_LOAN_TRAININGSET
  							 WHERE ( INCOMEGROUP EQ 2 ) GROUP BY GENDER ) 
HAVING COUNT = MAX( count );

TITLE 'Retrieve gender by mode from group 3';
/* Replacing gender by mode when Income group is 3 */
SELECT GENDER as MODE FROM ( SELECT GENDER, COUNT(1) as count FROM TP034717.TEMP_DAPSEP2019_LOAN_TRAININGSET
  							 WHERE ( INCOMEGROUP EQ 3 ) GROUP BY GENDER ) 
HAVING COUNT = MAX( count );

TITLE 'Retrieve gender by mode from group 4';
/* Replacing gender by mode when Income group is 4 */
SELECT GENDER as MODE FROM ( SELECT GENDER, COUNT(1) as count FROM TP034717.TEMP_DAPSEP2019_LOAN_TRAININGSET
  							 WHERE ( INCOMEGROUP EQ 4 ) GROUP BY GENDER ) 
HAVING COUNT = MAX( count );

QUIT;

/* The data scientist will replace mode from each group as a baseline*/
PROC SQL;

/* Update into existing DAPSEP2019_LOAN_TRAINDS dataset */
UPDATE TP034717.DAPSEP2019_LOAN_TRAININGSET
SET 
Gender = CASE

/* Selecting from TEMP_DAPSEP2019_LOAN_TRAINDS which has been created for selecting mode */
WHEN Gender = '' and IncomeGroup = 1 THEN 
( SELECT GENDER as MODE FROM ( SELECT GENDER, COUNT(1) as count FROM TP034717.TEMP_DAPSEP2019_LOAN_TRAININGSET
  							 WHERE ( INCOMEGROUP EQ 1 ) GROUP BY GENDER ) 
  HAVING COUNT = MAX( count ) ) 
  
/* To replace with gender (mode) when income group is 2 */
WHEN Gender = '' and IncomeGroup = 2 THEN 
( SELECT GENDER as MODE FROM ( SELECT GENDER, COUNT(1) as count FROM TP034717.TEMP_DAPSEP2019_LOAN_TRAININGSET
  							 WHERE ( INCOMEGROUP EQ 2 ) GROUP BY GENDER ) 
  HAVING COUNT = MAX( count ) ) 
  
/* To replace with gender (mode) when income group is 3 */
WHEN Gender = '' and IncomeGroup = 3 THEN 
( SELECT GENDER as MODE FROM ( SELECT GENDER, COUNT(1) as count FROM TP034717.TEMP_DAPSEP2019_LOAN_TRAININGSET
  							 WHERE ( INCOMEGROUP EQ 3 ) GROUP BY GENDER ) 
  HAVING COUNT = MAX( count ) ) 
  
/* To replace with gender (mode) when income group is 4 */
WHEN Gender = '' and IncomeGroup = 4 THEN 
( SELECT GENDER as MODE FROM ( SELECT GENDER, COUNT(1) as count FROM TP034717.TEMP_DAPSEP2019_LOAN_TRAININGSET
  							 WHERE ( INCOMEGROUP EQ 4 ) GROUP BY GENDER ) 
  HAVING COUNT = MAX( count ) ) 
  
ELSE Gender	  
END;
QUIT;

/* To verify if gender from dataset a (DAPSEP2019_LOAN_TRAININGSET) has missing values */
PROC SQL;

TITLE 'Viewing frequency table from temporary dataset';
PROC FREQ DATA = TP034717.TEMP_DAPSEP2019_LOAN_TRAININGSET; /* Result should return missing values of 13*/
TABLE GENDER;

TITLE 'Viewing frequency table from updated dataset';
PROC FREQ DATA = TP034717.DAPSEP2019_LOAN_TRAININGSET; /* Result should return with no missing values*/
TABLE GENDER;
QUIT;

/*2. Imputing Marital status by gender*/

/* Re-creating temporary TP034717.DAPSEP2019_LOAN_TRAININGSET dataset for backup purposes and missing value imputation*/
DATA TP034717.TEMP_DAPSEP2019_LOAN_TRAININGSET; /* temporary dataset*/
SET TP034717.DAPSEP2019_LOAN_TRAININGSET; /* dataset the data scientist will use for data imputation*/
RUN;

PROC SQL;

Title 'Viewing observations for marital status with missing values';
/* TP034717.DAPSEP2019_LOAN_TRAININGSET found three missing values */
SELECT sme_loan_id_no LABEL 'SME Loan Id',
	   MARITAL_STATUS LABEL 'Marital Status' FROM TP034717.DAPSEP2019_LOAN_TRAININGSET 
	   WHERE MARITAL_STATUS IS NULL OR MARITAL_STATUS = '';

QUIT;

/* Viewing the frequency of marital status by gender (Male /Female)*/
PROC SQL;

TITLE 'Viewing marital status frequency by gender (Male)';
SELECT MARITAL_STATUS LABEL 'Marital Status by gender (Male)', 
	   COUNT(1) AS Count 
	   FROM TP034717.TEMP_DAPSEP2019_LOAN_TRAININGSET 
 	   WHERE gender EQ 'Male' GROUP BY MARITAL_STATUS;

TITLE 'Viewing marital status frequency by gender (Female)';
SELECT MARITAL_STATUS LABEL 'Marital Status by gender (Female)', 
	   COUNT(1) AS Count 
	   FROM TP034717.TEMP_DAPSEP2019_LOAN_TRAININGSET 
 	   WHERE gender EQ 'Female' GROUP BY MARITAL_STATUS;

QUIT;

/* Getting marital status frequency by gender (Male/Female) */
PROC SQL;

TITLE 'Getting marital status frequency by gender (Male)';
( SELECT MARITAL_STATUS LABEL 'Mode (Marital Status by Male gender)' FROM /* Replacing mode for marital status based on Female*/ 
	  ( SELECT MARITAL_STATUS, COUNT(1) As Count FROM TP034717.TEMP_DAPSEP2019_LOAN_TRAININGSET
 	    WHERE GENDER EQ 'Male' GROUP BY MARITAL_STATUS )
  HAVING COUNT = MAX( count ) );

TITLE 'Getting marital status frequency by gender (Female)';
( SELECT MARITAL_STATUS LABEL 'Mode (Marital Status by Female gender)' FROM /* Replacing mode for marital status based on Female*/ 
	  ( SELECT MARITAL_STATUS, COUNT(1) As Count FROM TP034717.TEMP_DAPSEP2019_LOAN_TRAININGSET
 	    WHERE GENDER EQ 'Female' GROUP BY MARITAL_STATUS )
  HAVING COUNT = MAX( count ) );
  
QUIT;

/* Missing values imputation for marital status*/
PROC SQL;

UPDATE TP034717.DAPSEP2019_LOAN_TRAININGSET 
SET
marital_status = CASE

/* Update marital status only if it is empty */
WHEN marital_status = '' and gender = 'Female' THEN
	( SELECT MARITAL_STATUS LABEL 'Mode (Marital Status by Female gender)' FROM /* Replacing mode for marital status based on Female*/ 
		  ( SELECT MARITAL_STATUS, COUNT(1) As Count FROM TP034717.TEMP_DAPSEP2019_LOAN_TRAININGSET
	 	    WHERE GENDER EQ 'Female' GROUP BY MARITAL_STATUS )
	  HAVING COUNT = MAX( count ) )

/* Update marital status only if it is empty */
WHEN marital_status = '' and gender = 'Male' THEN
	( SELECT MARITAL_STATUS LABEL 'Mode (Marital Status by Male gender)' FROM /* Replacing mode for marital status based on Female*/ 
			  ( SELECT MARITAL_STATUS, COUNT(1) As Count FROM TP034717.TEMP_DAPSEP2019_LOAN_TRAININGSET
		 	    WHERE GENDER EQ 'Male' GROUP BY MARITAL_STATUS )
		  HAVING COUNT = MAX( count ) )

ELSE marital_status
END;

QUIT;

/* To verify if marital status from dataset a (DAPSEP2019_LOAN_TRAININGSET) has missing values */
PROC SQL;

TITLE 'Viewing frequency table from temporary dataset';
PROC FREQ DATA = TP034717.TEMP_DAPSEP2019_LOAN_TRAININGSET; /* Result should return missing values of 3*/
TABLE MARITAL_STATUS;

TITLE 'Viewing frequency table from updated dataset';
PROC FREQ DATA = TP034717.DAPSEP2019_LOAN_TRAININGSET; /* Result should return with no missing values*/
TABLE MARITAL_STATUS;
QUIT;

/* 3. Imputing family members by mode*/
/* Re-creating temporary TP034717.DAPSEP2019_LOAN_TRAININGSET dataset for backup purposes and missing value imputation*/
DATA TP034717.TEMP_DAPSEP2019_LOAN_TRAININGSET; /* temporary dataset*/
SET TP034717.DAPSEP2019_LOAN_TRAININGSET; /* dataset the data scientist will use for data imputation*/
RUN;

/* Viewing family members frequency*/
PROC SQL;

Title 'Viewing family members frequency';
SELECT FAMILY_MEMBERS LABEL 'Family Members',
	   COUNT(FAMILY_MEMBERS) LABEL 'Count'
	   FROM TP034717.DAPSEP2019_LOAN_TRAININGSET
	   WHERE FAMILY_MEMBERS NE '' GROUP BY FAMILY_MEMBERS ;

QUIT;

/* replace inconsistent data*/
PROC SQL;

UPDATE TP034717.DAPSEP2019_LOAN_TRAININGSET

SET FAMILY_MEMBERS = SUBSTRING(FAMILY_MEMBERS from 0 for 2);

QUIT;

/* verify result*/
PROC SQL;

Title 'Viewing family members frequency';
SELECT FAMILY_MEMBERS LABEL 'Family Members',
	   COUNT(FAMILY_MEMBERS) LABEL 'Count'
	   FROM TP034717.DAPSEP2019_LOAN_TRAININGSET
	   WHERE FAMILY_MEMBERS NE '' GROUP BY FAMILY_MEMBERS ;

QUIT;

/* Creating family members missing dataset for missing value imputation*/
PROC SQL;

/* Creating family members missing dataset for missing value imputation*/
  CREATE TABLE TP034717.FAMILY_MEMBER_MS_DATASET AS

  (

   SELECT FAMILY_MEMBERS LABEL 'Family Members', 
   COUNT( FAMILY_MEMBERS ) AS Count
   FROM TP034717.DAPSEP2019_LOAN_TRAININGSET WHERE ( FAMILY_MEMBERS NE '' ) GROUP BY FAMILY_MEMBERS

  )

  ORDER BY FAMILY_MEMBERS DESC;

QUIT;

/* Getting family members by mode*/
PROC SQL;

TITLE 'Getting family members by mode';
SELECT FAMILY_MEMBERS, COUNT FROM TP034717.FAMILY_MEMBER_MS_DATASET
WHERE COUNT = 
				( SELECT MAX(COUNT) LABEL 'Family members by mode'
				  FROM TP034717.FAMILY_MEMBER_MS_DATASET) ; /* Getting family members by highest count */

QUIT;

/* Impute missing data with mode*/
PROC SQL;

UPDATE TP034717.DAPSEP2019_LOAN_TRAININGSET
SET FAMILY_MEMBERS = CASE

/* Update family members that has missing values */
WHEN FAMILY_MEMBERS = '' THEN
( SELECT FAMILY_MEMBERS FROM TP034717.FAMILY_MEMBER_MS_DATASET
  WHERE COUNT = 
				( SELECT MAX(COUNT) LABEL 'Family members by mode'
				  FROM TP034717.FAMILY_MEMBER_MS_DATASET) )

ELSE FAMILY_MEMBERS
END;

QUIT;

/* To verify if marital status from dataset a (DAPSEP2019_LOAN_TRAININGSET) has missing values */
PROC SQL;

TITLE 'Viewing frequency table from temporary dataset';
PROC FREQ DATA = TP034717.TEMP_DAPSEP2019_LOAN_TRAININGSET; /* Result should return missing values of 15*/
TABLE FAMILY_MEMBERS;

TITLE 'Viewing frequency table from updated dataset';
PROC FREQ DATA = TP034717.DAPSEP2019_LOAN_TRAININGSET; /* Result should return with no missing values*/
TABLE FAMILY_MEMBERS;
QUIT;

/* 4. Imputing employment by mode*/
/* Re-creating temporary TP034717.DAPSEP2019_LOAN_TRAININGSET dataset for backup purposes and missing value imputation*/
/* And to ensure temporary dataset has updated changes*/
DATA TP034717.TEMP_DAPSEP2019_LOAN_TRAININGSET; /* temporary dataset*/
SET TP034717.DAPSEP2019_LOAN_TRAININGSET; /* dataset the data scientist will use for data imputation*/
RUN;

/* Viewing employment frequency*/
PROC SQL;

Title 'Viewing employment frequency';
SELECT EMPLOYMENT LABEL 'Employment',
	   COUNT(EMPLOYMENT) LABEL 'Count'
	   FROM TP034717.DAPSEP2019_LOAN_TRAININGSET
	   WHERE EMPLOYMENT IS NOT NULL GROUP BY EMPLOYMENT ;

QUIT;

/* Creating employment missing dataset for missing value imputation*/
PROC SQL;

/* Creating employment missing dataset for missing value imputation*/
  CREATE TABLE TP034717.EMPLOYMENT_MS_DATASET AS

  (

   SELECT EMPLOYMENT LABEL 'Employment', 
   COUNT( EMPLOYMENT ) AS Count
   FROM TP034717.DAPSEP2019_LOAN_TRAININGSET WHERE ( EMPLOYMENT IS NOT NULL ) GROUP BY EMPLOYMENT

  )

  ORDER BY EMPLOYMENT DESC;

QUIT;

/* Getting employment by mode*/
PROC SQL;

TITLE 'Getting employment by mode';
SELECT EMPLOYMENT, COUNT FROM TP034717.EMPLOYMENT_MS_DATASET
WHERE COUNT = 
				( SELECT MAX(COUNT) LABEL 'Employment by mode'
				  FROM TP034717.EMPLOYMENT_MS_DATASET) ; /* Getting employment by highest count */

QUIT;

/* Impute missing data with mode*/
PROC SQL;

UPDATE TP034717.DAPSEP2019_LOAN_TRAININGSET
SET EMPLOYMENT = CASE

/* Update variable employment that has missing values */
WHEN EMPLOYMENT = '' THEN
( SELECT EMPLOYMENT FROM TP034717.EMPLOYMENT_MS_DATASET
  WHERE COUNT = 
				( SELECT MAX(COUNT) LABEL 'Employment by mode'
				  FROM TP034717.EMPLOYMENT_MS_DATASET) )

ELSE EMPLOYMENT
END;

QUIT;

/* To verify if employment from dataset a (DAPSEP2019_LOAN_TRAININGSET) has missing values */
PROC SQL;

TITLE 'Viewing frequency table from temporary dataset';
PROC FREQ DATA = TP034717.TEMP_DAPSEP2019_LOAN_TRAININGSET; /* Result should return missing values of 32*/
TABLE EMPLOYMENT;

TITLE 'Viewing frequency table from updated dataset';
PROC FREQ DATA = TP034717.DAPSEP2019_LOAN_TRAININGSET; /* Result should return with no missing values*/
TABLE EMPLOYMENT;
QUIT;

/* 5. Imputing loan duration by mode*/
/* Re-creating temporary TP034717.DAPSEP2019_LOAN_TRAININGSET dataset for backup purposes and missing value imputation*/
/* And to ensure temporary dataset has updated changes*/
DATA TP034717.TEMP_DAPSEP2019_LOAN_TRAININGSET; /* temporary dataset*/
SET TP034717.DAPSEP2019_LOAN_TRAININGSET; /* dataset the data scientist will use for missing value imputation*/
RUN;

/* Viewing loan duration frequency*/
PROC SQL;

Title 'Viewing loan duration frequency';
SELECT LOAN_DURATION LABEL 'Loan Duration',
	   COUNT(LOAN_DURATION) LABEL 'Count'
	   FROM TP034717.DAPSEP2019_LOAN_TRAININGSET
	   WHERE LOAN_DURATION IS NOT NULL 
	   GROUP BY LOAN_DURATION 
	   ORDER BY LOAN_DURATION DESC;

QUIT;

/* Creating loan_duration missing dataset for missing value imputation*/
PROC SQL;

/* Creating loan_duration missing dataset for missing value imputation*/
  CREATE TABLE TP034717.LOAN_DURATION_MS_DATASET AS

  (

   SELECT LOAN_DURATION LABEL 'Loan Duration', 
   COUNT( LOAN_DURATION ) AS Count
   FROM TP034717.DAPSEP2019_LOAN_TRAININGSET WHERE ( LOAN_DURATION IS NOT NULL ) GROUP BY LOAN_DURATION

  )

  ORDER BY LOAN_DURATION DESC;

QUIT;

/* Getting loan_duration by mode*/
PROC SQL;

TITLE 'Getting loan_duration by mode';
SELECT LOAN_DURATION, COUNT FROM TP034717.LOAN_DURATION_MS_DATASET
WHERE COUNT = 
				( SELECT MAX(COUNT) LABEL 'Loan duration by mode'
				  FROM TP034717.LOAN_DURATION_MS_DATASET) ; /* Getting loan_duration by highest count */

QUIT;

/* Impute missing data with mode*/
PROC SQL;

UPDATE TP034717.DAPSEP2019_LOAN_TRAININGSET
SET LOAN_DURATION = CASE

/* Update variable loan duration that has missing values */
WHEN LOAN_DURATION IS NULL THEN
( SELECT LOAN_DURATION FROM TP034717.LOAN_DURATION_MS_DATASET
  WHERE COUNT EQ 
				( SELECT MAX(COUNT) LABEL 'Loan duration by mode'
				  FROM TP034717.LOAN_DURATION_MS_DATASET) )

ELSE LOAN_DURATION
END;

QUIT;

/* To verify if loan duration from dataset a (DAPSEP2019_LOAN_TRAININGSET) has missing values */
PROC SQL;

TITLE 'Viewing frequency table from temporary dataset';
PROC FREQ DATA = TP034717.TEMP_DAPSEP2019_LOAN_TRAININGSET; /* Result should return missing values of 14*/
TABLE LOAN_DURATION;

TITLE 'Viewing frequency table from updated dataset';
PROC FREQ DATA = TP034717.DAPSEP2019_LOAN_TRAININGSET; /* Result should return with no missing values*/
TABLE LOAN_DURATION;
QUIT;

/* 6. Imputing loan history by mode*/
/* Re-creating temporary TP034717.DAPSEP2019_LOAN_TRAININGSET dataset for backup purposes and missing value imputation*/
/* And to ensure temporary dataset has updated changes*/
DATA TP034717.TEMP_DAPSEP2019_LOAN_TRAININGSET; /* temporary dataset*/
SET TP034717.DAPSEP2019_LOAN_TRAININGSET; /* dataset the data scientist will use for missing value imputation*/
RUN;

/* Viewing loan history frequency*/
PROC SQL;

Title 'Viewing loan history frequency';
SELECT LOAN_HISTORY LABEL 'Loan History',
	   COUNT(LOAN_HISTORY) LABEL 'Count'
	   FROM TP034717.DAPSEP2019_LOAN_TRAININGSET
	   WHERE LOAN_HISTORY IS NOT NULL 
	   GROUP BY LOAN_HISTORY 
	   ORDER BY LOAN_HISTORY DESC;

QUIT;

/* Creating loan history missing dataset for missing value imputation*/
PROC SQL;

/* Creating loan history missing dataset for missing value imputation*/
  CREATE TABLE TP034717.LOAN_HISTORY_MS_DATASET AS

  (

   SELECT LOAN_HISTORY LABEL 'Loan Duration', 
   COUNT( LOAN_HISTORY ) AS Count
   FROM TP034717.DAPSEP2019_LOAN_TRAININGSET WHERE ( LOAN_HISTORY IS NOT NULL ) GROUP BY LOAN_HISTORY

  )

  ORDER BY LOAN_HISTORY DESC;

QUIT;

/* Getting loan history by mode*/
PROC SQL;

TITLE 'Getting loan history by mode';
SELECT LOAN_HISTORY, COUNT FROM TP034717.LOAN_HISTORY_MS_DATASET
WHERE COUNT = 
				( SELECT MAX(COUNT) LABEL 'Loan duration by mode'
				  FROM TP034717.LOAN_HISTORY_MS_DATASET) ; /* Getting loan history by highest count */

QUIT;

/* Impute missing data with mode*/
PROC SQL;

UPDATE TP034717.DAPSEP2019_LOAN_TRAININGSET
SET LOAN_HISTORY = CASE

/* Update variable loan duration that has missing values */
WHEN LOAN_HISTORY IS NULL THEN
( SELECT LOAN_HISTORY FROM TP034717.LOAN_HISTORY_MS_DATASET
  WHERE COUNT EQ 
				( SELECT MAX(COUNT) LABEL 'Loan history by mode'
				  FROM TP034717.LOAN_HISTORY_MS_DATASET) )

ELSE LOAN_HISTORY
END;

QUIT;

/* To verify if loan history from dataset a (DAPSEP2019_LOAN_TRAININGSET) has missing values */
PROC SQL;

TITLE 'Viewing frequency table from temporary dataset';
PROC FREQ DATA = TP034717.TEMP_DAPSEP2019_LOAN_TRAININGSET; /* Result should return missing values of 50*/
TABLE LOAN_HISTORY;

TITLE 'Viewing frequency table from updated dataset';
PROC FREQ DATA = TP034717.DAPSEP2019_LOAN_TRAININGSET; /* Result should return with no missing values*/
TABLE LOAN_HISTORY;
QUIT;

/* Check missing values*/
/* Creating format for both missing and not missing groups */
%missing_value_categorical /* Printing - missing values for categorical variables */ 

/* Check missing values in continuous variable*/
%MACRO missing_value_continuous;

	PROC FORMAT;
	 VALUE $missfmt ' '='Missing' other='Not Missing';
	 VALUE  missfmt  . ='Missing' other='Not Missing';
	RUN;
	 
	/* Counting missing values for continuous variables */ 
	PROC FREQ DATA = TP034717.DAPSEP2019_LOAN_TRAININGSET;
	TITLE 'Counting missing values for continuous variables on training set';
	TABLE CANDIDATE_INCOME GUARANTEE_INCOME LOAN_AMOUNT;  
	FORMAT _CHAR_ $MISSFMT.; 
	TABLES _CHAR_ / MISSING MISSPRINT NOCUM NOPERCENT;
	FORMAT _NUMERIC_ MISSFMT.;
	TABLES _NUMERIC_ / MISSING MISSPRINT NOCUM NOPERCENT;
RUN;

%MEND missing_value_continuous;
%missing_value_continuous /* Counting missing values for continuous variables */ 

/*7. Impute loan amount by Mean*/

/* To ensure temporary dataset has the latest changes before imputing missing value*/
DATA TP034717.TEMP_DAPSEP2019_LOAN_TRAININGSET; /* temporary dataset*/
SET TP034717.DAPSEP2019_LOAN_TRAININGSET; /* dataset the data scientist will use for missing value imputation*/
RUN;

PROC SQL;

/* Getting Total Missing Values for Loan Amount */
Title 'Counting Total Missing Values for Loan Amount';
SELECT count(*) LABEL 'Loan Amount Missing Values' FROM TP034717.DAPSEP2019_LOAN_TRAININGSET
WHERE loan_amount IS NULL;

QUIT;

/* Viewing missing value from variable loan amount that is not within minium and maximum value (missing values) */
PROC SQL;
TITLE 'Viewing missing value from variable loan amount that is not within minium and maximum value (missing values)';
SELECT SME_LOAN_ID_NO LABEL 'SME Loan Id No',
	   LOAN_AMOUNT LABEL 'Loan amount'
FROM  TP034717.DAPSEP2019_LOAN_TRAININGSET
HAVING NOT LOAN_AMOUNT BETWEEN MIN(LOAN_AMOUNT) and MAX(LOAN_AMOUNT);
QUIT;

PROC SQL;

/* Getting loan amount median for missing value imputation*/
TITLE 'Median loan amount';
SELECT MEDIAN(LOAN_AMOUNT) LABEL 'Median' FROM TP034717.TEMP_DAPSEP2019_LOAN_TRAININGSET;

QUIT;

/* Imputing loan amount (missing values) with Median*/
PROC SQL;

UPDATE TP034717.DAPSEP2019_LOAN_TRAININGSET
SET LOAN_AMOUNT = CASE

WHEN ( LOAN_AMOUNT /* Will replace only if it is in range*/
				BETWEEN (SELECT MIN(LOAN_AMOUNT) FROM TP034717.TEMP_DAPSEP2019_LOAN_TRAININGSET) and 
						(SELECT MAX(LOAN_AMOUNT) FROM TP034717.TEMP_DAPSEP2019_LOAN_TRAININGSET) 
	 ) THEN
	 
LOAN_AMOUNT

ELSE ( SELECT MEDIAN(LOAN_AMOUNT) FROM TP034717.TEMP_DAPSEP2019_LOAN_TRAININGSET )
END;

QUIT;   

/* To verify if variable loan amount from dataset a (TP034717.DAPSEP2019_LOAN_TRAININGSET) has missing values */
PROC SQL;

TITLE ('Viewing observations from DAPSEP2019_LOAN_TRAININGSET - Expecting no rows missing');
/* To view observations if variable loan amount still have missing values */
SELECT a.* FROM TP034717.DAPSEP2019_LOAN_TRAININGSET a
		/* Result expected to return 'No rows are being selected' */
		 HAVING NOT a.LOAN_AMOUNT BETWEEN MIN( a.LOAN_AMOUNT ) and MAX( a.LOAN_AMOUNT ); 

TITLE ('Viewing observations from TEMP_DAPSEP2019_LOAN_TRAININGSET - Expecting 22 rows missing');
SELECT b.SME_LOAN_ID_NO LABEL 'SME Loan Id No',
	   b.LOAN_AMOUNT LABEL 'Loan Amount' FROM TP034717.TEMP_DAPSEP2019_LOAN_TRAININGSET b
		/* Result expected to return with column selected */
		 HAVING NOT b.LOAN_AMOUNT BETWEEN MIN( b.LOAN_AMOUNT ) and MAX( b.LOAN_AMOUNT ); 

QUIT;  

/* Check missing values*/
/* Creating format for both missing and not missing groups */
%missing_value_continuous /* Counting missing values for continuous variables */ 
%missing_value_categorical
