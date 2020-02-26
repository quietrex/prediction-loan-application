/* Name of Data Scientist: Chan Kuok Hong */
/* Name of Program: tp034717_complex_dap_logisticReg.sas */
/* Description: repeat the procedure on training set to testing set */
/* Objective: To ensure no missing values in the testing set*/
/* Date First Written: Thursday 22-Nov-2019 */
/* Date Last Modified: Wednesday 27-Nov-2019 */

/* Building the logistic regression model on training set */
PROC LOGISTIC DATA = TP034717.DAPSEP2019_LOAN_TRAININGSET OUTMODEL = TP034717.DAPSEP2019_LOAN_TRAINING_MODEL;
CLASS GENDER
	  MARITAL_STATUS
	  FAMILY_MEMBERS
	  QUALIFICATION
	  EMPLOYMENT
	  LOAN_DURATION
	  LOAN_HISTORY
	  LOAN_LOCATION;
	  
MODEL LOAN_APPROVAL_STATUS
     = GENDER
       MARITAL_STATUS
       FAMILY_MEMBERS
       QUALIFICATION
       EMPLOYMENT
       LOAN_DURATION
       LOAN_HISTORY
       CANDIDATE_INCOME
       GUARANTEE_INCOME
       LOAN_AMOUNT;
       
OUTPUT OUT = TP034717.DAPSEP2019_LOAN_TRAININGSET P = PRED_PROB;

RUN;

PROC PRINT DATA = TP034717.DAPSEP2019_LOAN_TRAINING_MODEL;
TITLE 'Logistic Model on training set';
RUN;

/* Predicted probability is updated into training set */
PROC PRINT DATA = TP034717.DAPSEP2019_LOAN_TRAININGSET;
TITLE 'Predicted probability is updated into training set';
RUN;

/* Predicting the outcome on testing set*/
PROC LOGISTIC INMODEL = TP034717.DAPSEP2019_LOAN_TRAINING_MODEL;
SCORE DATA = TP034717.DAPSEP2019_LOAN_TESTSET /* Fitting model into testing set*/
OUT = TP034717.DAPSEP2019_LOAN_PREDICTORS;
QUIT;

PROC SQL;
TITLE 'Viewing observations from the predictors';
	SELECT SME_LOAN_ID_NO LABEL 'SME LOAN ID',
		   P_Y LABEL 'Probability predicting Yes',
		   P_N LABEL 'Probability predicting No',
		   I_LOAN_APPROVAL_STATUS LABEL 'Predicted loan approval status'
		   FROM TP034717.DAPSEP2019_LOAN_PREDICTORS;
		   
QUIT;

PROC SQL;

CREATE TABLE TP034717.SME_LOAN_PREDICTORS AS

( SELECT SME_LOAN_ID_NO LABEL 'SME LOAN ID',
		   P_Y LABEL 'Probability predicting Yes',
		   P_N LABEL 'Probability predicting No',
		   I_LOAN_APPROVAL_STATUS LABEL 'Predicted loan approval status'
		   FROM TP034717.DAPSEP2019_LOAN_PREDICTORS);

QUIT;