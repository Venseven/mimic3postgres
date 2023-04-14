DROP SCHEMA IF EXISTS mimic; CREATE SCHEMA mimic;

-- -------------------------------------------------------------------------------
--
-- Create the MIMIC-III tables
--
-- -------------------------------------------------------------------------------

--------------------------------------------------------
--  File created - Thursday-November-28-2015
--------------------------------------------------------

-- If running scripts individually, you can set the schema where all tables are created as follows:
-- SET search_path TO mimiciii;

-- Restoring the search path to its default value can be accomplished as follows:
--  SET search_path TO "$user",public;

/* Set the mimic_data_dir variable to point to directory containing
   all .csv files. If using Docker, this should not be changed here.
   Rather, when running the docker container, use the -v option
   to have Docker mount a host volume to the container path /mimic_data
   as explained in the README file
*/


--------------------------------------------------------
--  DDL for Table ADMISSIONS
--------------------------------------------------------

DROP TABLE IF EXISTS ADMISSIONS CASCADE;
CREATE TABLE ADMISSIONS
(
  ROW_ID INT NOT NULL,
  SUBJECT_ID INT NOT NULL,
  HADM_ID INT NOT NULL,
  ADMITTIME TIMESTAMP(0) NOT NULL,
  DISCHTIME TIMESTAMP(0) NOT NULL,
  DEATHTIME TIMESTAMP(0),
  ADMISSION_TYPE VARCHAR(50) NOT NULL,
  ADMISSION_LOCATION VARCHAR(50) NOT NULL,
  DISCHARGE_LOCATION VARCHAR(50) NOT NULL,
  INSURANCE VARCHAR(255) NOT NULL,
  LANGUAGE VARCHAR(10),
  RELIGION VARCHAR(50),
  MARITAL_STATUS VARCHAR(50),
  ETHNICITY VARCHAR(200) NOT NULL,
  EDREGTIME TIMESTAMP(0),
  EDOUTTIME TIMESTAMP(0),
  DIAGNOSIS VARCHAR(255),
  HOSPITAL_EXPIRE_FLAG SMALLINT,
  HAS_CHARTEVENTS_DATA SMALLINT NOT NULL,
  CONSTRAINT adm_rowid_pk PRIMARY KEY (ROW_ID),
  CONSTRAINT adm_hadm_unique UNIQUE (HADM_ID)
) ;

DROP TABLE IF EXISTS CALLOUT CASCADE;
CREATE TABLE CALLOUT
(
  ROW_ID INT NOT NULL,
  SUBJECT_ID INT NOT NULL,
  HADM_ID INT NOT NULL,
  SUBMIT_WARDID INT,
  SUBMIT_CAREUNIT VARCHAR(15),
  CURR_WARDID INT,
  CURR_CAREUNIT VARCHAR(15),
  CALLOUT_WARDID INT,
  CALLOUT_SERVICE VARCHAR(10) NOT NULL,
  REQUEST_TELE SMALLINT NOT NULL,
  REQUEST_RESP SMALLINT NOT NULL,
  REQUEST_CDIFF SMALLINT NOT NULL,
  REQUEST_MRSA SMALLINT NOT NULL,
  REQUEST_VRE SMALLINT NOT NULL,
  CALLOUT_STATUS VARCHAR(20) NOT NULL,
  CALLOUT_OUTCOME VARCHAR(20) NOT NULL,
  DISCHARGE_WARDID INT,
  ACKNOWLEDGE_STATUS VARCHAR(20) NOT NULL,
  CREATETIME TIMESTAMP(0) NOT NULL,
  UPDATETIME TIMESTAMP(0) NOT NULL,
  ACKNOWLEDGETIME TIMESTAMP(0),
  OUTCOMETIME TIMESTAMP(0) NOT NULL,
  FIRSTRESERVATIONTIME TIMESTAMP(0),
  CURRENTRESERVATIONTIME TIMESTAMP(0),
  CONSTRAINT callout_rowid_pk PRIMARY KEY (ROW_ID)
) ;

DROP TABLE IF EXISTS CAREGIVERS CASCADE;
CREATE TABLE CAREGIVERS
(
  ROW_ID INT NOT NULL,
	CGID INT NOT NULL,
	LABEL VARCHAR(15),
	DESCRIPTION VARCHAR(30),
	CONSTRAINT cg_rowid_pk  PRIMARY KEY (ROW_ID),
	CONSTRAINT cg_cgid_unique UNIQUE (CGID)
) ;

DROP TABLE IF EXISTS CHARTEVENTS CASCADE;
CREATE TABLE CHARTEVENTS
(
  ROW_ID INT NOT NULL,
	SUBJECT_ID INT NOT NULL,
	HADM_ID INT,
	ICUSTAY_ID INT,
	ITEMID INT,
	CHARTTIME TIMESTAMP(0),
	STORETIME TIMESTAMP(0),
	CGID INT,
	VALUE VARCHAR(255),
	VALUENUM DOUBLE PRECISION,
	VALUEUOM VARCHAR(50),
	WARNING INT,
	ERROR INT,
	RESULTSTATUS VARCHAR(50),
	STOPPED VARCHAR(50),
	CONSTRAINT chartevents_rowid_pk PRIMARY KEY (ROW_ID)
) ;


 CREATE TABLE chartevents_1 ( CHECK ( itemid >= 0 AND itemid < 127 )) INHERITS (chartevents);
 CREATE TABLE chartevents_2 ( CHECK ( itemid >= 127 AND itemid < 210 )) INHERITS (chartevents);
 CREATE TABLE chartevents_3 ( CHECK ( itemid >= 210 AND itemid < 425 )) INHERITS (chartevents);
 CREATE TABLE chartevents_4 ( CHECK ( itemid >= 425 AND itemid < 549 )) INHERITS (chartevents);
 CREATE TABLE chartevents_5 ( CHECK ( itemid >= 549 AND itemid < 643 )) INHERITS (chartevents);
 CREATE TABLE chartevents_6 ( CHECK ( itemid >= 643 AND itemid < 741 )) INHERITS (chartevents);
 CREATE TABLE chartevents_7 ( CHECK ( itemid >= 741 AND itemid < 1483 )) INHERITS (chartevents);
 CREATE TABLE chartevents_8 ( CHECK ( itemid >= 1483 AND itemid < 3458 )) INHERITS (chartevents);
 CREATE TABLE chartevents_9 ( CHECK ( itemid >= 3458 AND itemid < 3695 )) INHERITS (chartevents);
 CREATE TABLE chartevents_10 ( CHECK ( itemid >= 3695 AND itemid < 8440 )) INHERITS (chartevents);
 CREATE TABLE chartevents_11 ( CHECK ( itemid >= 8440 AND itemid < 8553 )) INHERITS (chartevents);
 CREATE TABLE chartevents_12 ( CHECK ( itemid >= 8553 AND itemid < 220274 )) INHERITS (chartevents);
 CREATE TABLE chartevents_13 ( CHECK ( itemid >= 220274 AND itemid < 223921 )) INHERITS (chartevents);
 CREATE TABLE chartevents_14 ( CHECK ( itemid >= 223921 AND itemid < 224085 )) INHERITS (chartevents);
 CREATE TABLE chartevents_15 ( CHECK ( itemid >= 224085 AND itemid < 224859 )) INHERITS (chartevents);
 CREATE TABLE chartevents_16 ( CHECK ( itemid >= 224859 AND itemid < 227629 )) INHERITS (chartevents);
 CREATE TABLE chartevents_17 ( CHECK ( itemid >= 227629 AND itemid < 999999999 )) INHERITS (chartevents);

CREATE OR REPLACE FUNCTION chartevents_insert_trigger()
RETURNS TRIGGER AS $$
BEGIN
IF ( NEW.itemid >= 0 AND NEW.itemid < 127 ) THEN INSERT INTO chartevents_1 VALUES (NEW.*);
ELSIF ( NEW.itemid >= 127 AND NEW.itemid < 210 ) THEN INSERT INTO chartevents_2 VALUES (NEW.*);
ELSIF ( NEW.itemid >= 210 AND NEW.itemid < 425 ) THEN INSERT INTO chartevents_3 VALUES (NEW.*);
ELSIF ( NEW.itemid >= 425 AND NEW.itemid < 549 ) THEN INSERT INTO chartevents_4 VALUES (NEW.*);
ELSIF ( NEW.itemid >= 549 AND NEW.itemid < 643 ) THEN INSERT INTO chartevents_5 VALUES (NEW.*);
ELSIF ( NEW.itemid >= 643 AND NEW.itemid < 741 ) THEN INSERT INTO chartevents_6 VALUES (NEW.*);
ELSIF ( NEW.itemid >= 741 AND NEW.itemid < 1483 ) THEN INSERT INTO chartevents_7 VALUES (NEW.*);
ELSIF ( NEW.itemid >= 1483 AND NEW.itemid < 3458 ) THEN INSERT INTO chartevents_8 VALUES (NEW.*);
ELSIF ( NEW.itemid >= 3458 AND NEW.itemid < 3695 ) THEN INSERT INTO chartevents_9 VALUES (NEW.*);
ELSIF ( NEW.itemid >= 3695 AND NEW.itemid < 8440 ) THEN INSERT INTO chartevents_10 VALUES (NEW.*);
ELSIF ( NEW.itemid >= 8440 AND NEW.itemid < 8553 ) THEN INSERT INTO chartevents_11 VALUES (NEW.*);
ELSIF ( NEW.itemid >= 8553 AND NEW.itemid < 220274 ) THEN INSERT INTO chartevents_12 VALUES (NEW.*);
ELSIF ( NEW.itemid >= 220274 AND NEW.itemid < 223921 ) THEN INSERT INTO chartevents_13 VALUES (NEW.*);
ELSIF ( NEW.itemid >= 223921 AND NEW.itemid < 224085 ) THEN INSERT INTO chartevents_14 VALUES (NEW.*);
ELSIF ( NEW.itemid >= 224085 AND NEW.itemid < 224859 ) THEN INSERT INTO chartevents_15 VALUES (NEW.*);
ELSIF ( NEW.itemid >= 224859 AND NEW.itemid < 227629 ) THEN INSERT INTO chartevents_16 VALUES (NEW.*);
ELSIF ( NEW.itemid >= 227629 AND NEW.itemid < 999999999 ) THEN INSERT INTO chartevents_17 VALUES (NEW.*);
ELSE
	INSERT INTO chartevents_null VALUES (NEW.*);
END IF;
RETURN NULL;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER insert_chartevents_trigger
    BEFORE INSERT ON chartevents
    FOR EACH ROW EXECUTE PROCEDURE chartevents_insert_trigger();


DROP TABLE IF EXISTS CPTEVENTS CASCADE;
CREATE TABLE CPTEVENTS
(
  ROW_ID INT NOT NULL,
	SUBJECT_ID INT NOT NULL,
	HADM_ID INT NOT NULL,
	COSTCENTER VARCHAR(10) NOT NULL,
	CHARTDATE TIMESTAMP(0),
	CPT_CD VARCHAR(10) NOT NULL,
	CPT_NUMBER INT,
	CPT_SUFFIX VARCHAR(5),
	TICKET_ID_SEQ INT,
	SECTIONHEADER VARCHAR(50),
	SUBSECTIONHEADER VARCHAR(255),
	DESCRIPTION VARCHAR(200),
	CONSTRAINT cpt_rowid_pk PRIMARY KEY (ROW_ID)
) ;

DROP TABLE IF EXISTS DATETIMEEVENTS CASCADE;
CREATE TABLE DATETIMEEVENTS
(
  ROW_ID INT NOT NULL,
	SUBJECT_ID INT NOT NULL,
	HADM_ID INT,
	ICUSTAY_ID INT,
	ITEMID INT NOT NULL,
	CHARTTIME TIMESTAMP(0) NOT NULL,
	STORETIME TIMESTAMP(0) NOT NULL,
	CGID INT NOT NULL,
	VALUE TIMESTAMP(0),
	VALUEUOM VARCHAR(50) NOT NULL,
	WARNING SMALLINT,
	ERROR SMALLINT,
	RESULTSTATUS VARCHAR(50),
	STOPPED VARCHAR(50),
	CONSTRAINT datetime_rowid_pk PRIMARY KEY (ROW_ID)
) ;

DROP TABLE IF EXISTS DIAGNOSES_ICD CASCADE;
CREATE TABLE DIAGNOSES_ICD
(
  ROW_ID INT NOT NULL,
	SUBJECT_ID INT NOT NULL,
	HADM_ID INT NOT NULL,
	SEQ_NUM INT,
	ICD9_CODE VARCHAR(10),
	CONSTRAINT diagnosesicd_rowid_pk PRIMARY KEY (ROW_ID)
) ;


DROP TABLE IF EXISTS DRGCODES CASCADE;
CREATE TABLE DRGCODES
(
  ROW_ID INT NOT NULL,
	SUBJECT_ID INT NOT NULL,
	HADM_ID INT NOT NULL,
	DRG_TYPE VARCHAR(20) NOT NULL,
	DRG_CODE VARCHAR(20) NOT NULL,
	DESCRIPTION VARCHAR(255),
	DRG_SEVERITY SMALLINT,
	DRG_MORTALITY SMALLINT,
	CONSTRAINT drg_rowid_pk PRIMARY KEY (ROW_ID)
) ;


DROP TABLE IF EXISTS D_CPT CASCADE;
CREATE TABLE D_CPT
(
  ROW_ID INT NOT NULL,
	CATEGORY SMALLINT NOT NULL,
	SECTIONRANGE VARCHAR(100) NOT NULL,
	SECTIONHEADER VARCHAR(50) NOT NULL,
	SUBSECTIONRANGE VARCHAR(100) NOT NULL,
	SUBSECTIONHEADER VARCHAR(255) NOT NULL,
	CODESUFFIX VARCHAR(5),
	MINCODEINSUBSECTION INT NOT NULL,
	MAXCODEINSUBSECTION INT NOT NULL,
	CONSTRAINT dcpt_ssrange_unique UNIQUE (SUBSECTIONRANGE),
	CONSTRAINT dcpt_rowid_pk PRIMARY KEY (ROW_ID)
) ;


DROP TABLE IF EXISTS D_ICD_DIAGNOSES CASCADE;
CREATE TABLE D_ICD_DIAGNOSES
(
  ROW_ID INT NOT NULL,
	ICD9_CODE VARCHAR(10) NOT NULL,
	SHORT_TITLE VARCHAR(50) NOT NULL,
	LONG_TITLE VARCHAR(255) NOT NULL,
	CONSTRAINT d_icd_diag_code_unique UNIQUE (ICD9_CODE),
	CONSTRAINT d_icd_diag_rowid_pk PRIMARY KEY (ROW_ID)
) ;

DROP TABLE IF EXISTS D_ICD_PROCEDURES CASCADE;
CREATE TABLE D_ICD_PROCEDURES
(
  ROW_ID INT NOT NULL,
	ICD9_CODE VARCHAR(10) NOT NULL,
	SHORT_TITLE VARCHAR(50) NOT NULL,
	LONG_TITLE VARCHAR(255) NOT NULL,
	CONSTRAINT d_icd_proc_code_unique UNIQUE (ICD9_CODE),
	CONSTRAINT d_icd_proc_rowid_pk PRIMARY KEY (ROW_ID)
) ;


DROP TABLE IF EXISTS D_ITEMS CASCADE;
CREATE TABLE D_ITEMS
(
  ROW_ID INT NOT NULL,
	ITEMID INT NOT NULL,
	LABEL VARCHAR(200),
	ABBREVIATION VARCHAR(100),
	DBSOURCE VARCHAR(20),
	LINKSTO VARCHAR(50),
	CATEGORY VARCHAR(100),
	UNITNAME VARCHAR(100),
	PARAM_TYPE VARCHAR(30),
	CONCEPTID INT,
	CONSTRAINT ditems_itemid_unique UNIQUE (ITEMID),
	CONSTRAINT ditems_rowid_pk PRIMARY KEY (ROW_ID)
) ;


DROP TABLE IF EXISTS D_LABITEMS CASCADE;
CREATE TABLE D_LABITEMS
(
  ROW_ID INT NOT NULL,
	ITEMID INT NOT NULL,
	LABEL VARCHAR(100) NOT NULL,
	FLUID VARCHAR(100) NOT NULL,
	CATEGORY VARCHAR(100) NOT NULL,
	LOINC_CODE VARCHAR(100),
	CONSTRAINT dlabitems_itemid_unique UNIQUE (ITEMID),
	CONSTRAINT dlabitems_rowid_pk PRIMARY KEY (ROW_ID)
) ;


DROP TABLE IF EXISTS ICUSTAYS CASCADE;
CREATE TABLE ICUSTAYS
(
  ROW_ID INT NOT NULL,
	SUBJECT_ID INT NOT NULL,
	HADM_ID INT NOT NULL,
	ICUSTAY_ID INT NOT NULL,
	DBSOURCE VARCHAR(20) NOT NULL,
	FIRST_CAREUNIT VARCHAR(20) NOT NULL,
	LAST_CAREUNIT VARCHAR(20) NOT NULL,
	FIRST_WARDID SMALLINT NOT NULL,
	LAST_WARDID SMALLINT NOT NULL,
	INTIME TIMESTAMP(0) NOT NULL,
	OUTTIME TIMESTAMP(0),
	LOS DOUBLE PRECISION,
	CONSTRAINT icustay_icustayid_unique UNIQUE (ICUSTAY_ID),
	CONSTRAINT icustay_rowid_pk PRIMARY KEY (ROW_ID)
) ;

DROP TABLE IF EXISTS INPUTEVENTS_CV CASCADE;
CREATE TABLE INPUTEVENTS_CV
(
  ROW_ID INT NOT NULL,
	SUBJECT_ID INT NOT NULL,
	HADM_ID INT,
	ICUSTAY_ID INT,
	CHARTTIME TIMESTAMP(0),
	ITEMID INT,
	AMOUNT DOUBLE PRECISION,
	AMOUNTUOM VARCHAR(30),
	RATE DOUBLE PRECISION,
	RATEUOM VARCHAR(30),
	STORETIME TIMESTAMP(0),
	CGID INT,
	ORDERID INT,
	LINKORDERID INT,
	STOPPED VARCHAR(30),
	NEWBOTTLE INT,
	ORIGINALAMOUNT DOUBLE PRECISION,
	ORIGINALAMOUNTUOM VARCHAR(30),
	ORIGINALROUTE VARCHAR(30),
	ORIGINALRATE DOUBLE PRECISION,
	ORIGINALRATEUOM VARCHAR(30),
	ORIGINALSITE VARCHAR(30),
	CONSTRAINT inputevents_cv_rowid_pk PRIMARY KEY (ROW_ID)
) ;


DROP TABLE IF EXISTS INPUTEVENTS_MV CASCADE;
CREATE TABLE INPUTEVENTS_MV
(
  ROW_ID INT NOT NULL,
	SUBJECT_ID INT NOT NULL,
	HADM_ID INT,
	ICUSTAY_ID INT,
	STARTTIME TIMESTAMP(0),
	ENDTIME TIMESTAMP(0),
	ITEMID INT,
	AMOUNT DOUBLE PRECISION,
	AMOUNTUOM VARCHAR(30),
	RATE DOUBLE PRECISION,
	RATEUOM VARCHAR(30),
	STORETIME TIMESTAMP(0),
	CGID INT,
	ORDERID INT,
	LINKORDERID INT,
	ORDERCATEGORYNAME VARCHAR(100),
	SECONDARYORDERCATEGORYNAME VARCHAR(100),
	ORDERCOMPONENTTYPEDESCRIPTION VARCHAR(200),
	ORDERCATEGORYDESCRIPTION VARCHAR(50),
	PATIENTWEIGHT DOUBLE PRECISION,
	TOTALAMOUNT DOUBLE PRECISION,
	TOTALAMOUNTUOM VARCHAR(50),
	ISOPENBAG SMALLINT,
	CONTINUEINNEXTDEPT SMALLINT,
	CANCELREASON SMALLINT,
	STATUSDESCRIPTION VARCHAR(30),
	COMMENTS_EDITEDBY VARCHAR(30),
	COMMENTS_CANCELEDBY VARCHAR(40),
	COMMENTS_DATE TIMESTAMP(0),
	ORIGINALAMOUNT DOUBLE PRECISION,
	ORIGINALRATE DOUBLE PRECISION,
	CONSTRAINT inputevents_mv_rowid_pk PRIMARY KEY (ROW_ID)
) ;

DROP TABLE IF EXISTS LABEVENTS CASCADE;
CREATE TABLE LABEVENTS
(
  ROW_ID INT NOT NULL,
	SUBJECT_ID INT NOT NULL,
	HADM_ID INT,
	ITEMID INT NOT NULL,
	CHARTTIME TIMESTAMP(0),
	VALUE VARCHAR(200),
	VALUENUM DOUBLE PRECISION,
	VALUEUOM VARCHAR(20),
	FLAG VARCHAR(20),
	CONSTRAINT labevents_rowid_pk PRIMARY KEY (ROW_ID)
) ;


DROP TABLE IF EXISTS MICROBIOLOGYEVENTS CASCADE;
CREATE TABLE MICROBIOLOGYEVENTS
(
  ROW_ID INT NOT NULL,
	SUBJECT_ID INT NOT NULL,
	HADM_ID INT,
	CHARTDATE TIMESTAMP(0),
	CHARTTIME TIMESTAMP(0),
	SPEC_ITEMID INT,
	SPEC_TYPE_DESC VARCHAR(100),
	ORG_ITEMID INT,
	ORG_NAME VARCHAR(100),
	ISOLATE_NUM SMALLINT,
	AB_ITEMID INT,
	AB_NAME VARCHAR(30),
	DILUTION_TEXT VARCHAR(10),
	DILUTION_COMPARISON VARCHAR(20),
	DILUTION_VALUE DOUBLE PRECISION,
	INTERPRETATION VARCHAR(5),
	CONSTRAINT micro_rowid_pk PRIMARY KEY (ROW_ID)
) ;


DROP TABLE IF EXISTS NOTEEVENTS CASCADE;
CREATE TABLE NOTEEVENTS
(
  ROW_ID INT NOT NULL,
	SUBJECT_ID INT NOT NULL,
	HADM_ID INT,
	CHARTDATE TIMESTAMP(0),
	CHARTTIME TIMESTAMP(0),
	STORETIME TIMESTAMP(0),
	CATEGORY VARCHAR(50),
	DESCRIPTION VARCHAR(255),
	CGID INT,
	ISERROR CHAR(1),
	TEXT TEXT,
	CONSTRAINT noteevents_rowid_pk PRIMARY KEY (ROW_ID)
) ;


DROP TABLE IF EXISTS OUTPUTEVENTS CASCADE;
CREATE TABLE OUTPUTEVENTS
(
  ROW_ID INT NOT NULL,
	SUBJECT_ID INT NOT NULL,
	HADM_ID INT,
	ICUSTAY_ID INT,
	CHARTTIME TIMESTAMP(0),
	ITEMID INT,
	VALUE DOUBLE PRECISION,
	VALUEUOM VARCHAR(30),
	STORETIME TIMESTAMP(0),
	CGID INT,
	STOPPED VARCHAR(30),
	NEWBOTTLE CHAR(1),
	ISERROR INT,
	CONSTRAINT outputevents_cv_rowid_pk PRIMARY KEY (ROW_ID)
) ;


DROP TABLE IF EXISTS PATIENTS CASCADE;
CREATE TABLE PATIENTS
(
  ROW_ID INT NOT NULL,
	SUBJECT_ID INT NOT NULL,
	GENDER VARCHAR(5) NOT NULL,
	DOB TIMESTAMP(0) NOT NULL,
	DOD TIMESTAMP(0),
	DOD_HOSP TIMESTAMP(0),
	DOD_SSN TIMESTAMP(0),
	EXPIRE_FLAG INT NOT NULL,
	CONSTRAINT pat_subid_unique UNIQUE (SUBJECT_ID),
	CONSTRAINT pat_rowid_pk PRIMARY KEY (ROW_ID)
) ;



DROP TABLE IF EXISTS PRESCRIPTIONS CASCADE;
CREATE TABLE PRESCRIPTIONS
(
  ROW_ID INT NOT NULL,
	SUBJECT_ID INT NOT NULL,
	HADM_ID INT NOT NULL,
	ICUSTAY_ID INT,
	STARTDATE TIMESTAMP(0),
	ENDDATE TIMESTAMP(0),
	DRUG_TYPE VARCHAR(100) NOT NULL,
	DRUG VARCHAR(100) NOT NULL,
	DRUG_NAME_POE VARCHAR(100),
	DRUG_NAME_GENERIC VARCHAR(100),
	FORMULARY_DRUG_CD VARCHAR(120),
	GSN VARCHAR(200),
	NDC VARCHAR(120),
	PROD_STRENGTH VARCHAR(120),
	DOSE_VAL_RX VARCHAR(120),
	DOSE_UNIT_RX VARCHAR(120),
	FORM_VAL_DISP VARCHAR(120),
	FORM_UNIT_DISP VARCHAR(120),
	ROUTE VARCHAR(120),
	CONSTRAINT prescription_rowid_pk PRIMARY KEY (ROW_ID)
) ;



DROP TABLE IF EXISTS PROCEDUREEVENTS_MV CASCADE;
CREATE TABLE PROCEDUREEVENTS_MV
(
  ROW_ID INT NOT NULL,
	SUBJECT_ID INT NOT NULL,
	HADM_ID INT NOT NULL,
	ICUSTAY_ID INT,
	STARTTIME TIMESTAMP(0),
	ENDTIME TIMESTAMP(0),
	ITEMID INT,
	VALUE DOUBLE PRECISION,
	VALUEUOM VARCHAR(30),
	LOCATION VARCHAR(30),
	LOCATIONCATEGORY VARCHAR(30),
	STORETIME TIMESTAMP(0),
	CGID INT,
	ORDERID INT,
	LINKORDERID INT,
	ORDERCATEGORYNAME VARCHAR(100),
	SECONDARYORDERCATEGORYNAME VARCHAR(100),
	ORDERCATEGORYDESCRIPTION VARCHAR(50),
	ISOPENBAG SMALLINT,
	CONTINUEINNEXTDEPT SMALLINT,
	CANCELREASON SMALLINT,
	STATUSDESCRIPTION VARCHAR(30),
	COMMENTS_EDITEDBY VARCHAR(30),
	COMMENTS_CANCELEDBY VARCHAR(30),
	COMMENTS_DATE TIMESTAMP(0),
	CONSTRAINT procedureevents_mv_rowid_pk PRIMARY KEY (ROW_ID)
) ;



DROP TABLE IF EXISTS PROCEDURES_ICD CASCADE;
CREATE TABLE PROCEDURES_ICD
(
  ROW_ID INT NOT NULL,
	SUBJECT_ID INT NOT NULL,
	HADM_ID INT NOT NULL,
	SEQ_NUM INT NOT NULL,
	ICD9_CODE VARCHAR(10) NOT NULL,
	CONSTRAINT proceduresicd_rowid_pk PRIMARY KEY (ROW_ID)
) ;



DROP TABLE IF EXISTS SERVICES CASCADE;
CREATE TABLE SERVICES
(
  ROW_ID INT NOT NULL,
	SUBJECT_ID INT NOT NULL,
	HADM_ID INT NOT NULL,
	TRANSFERTIME TIMESTAMP(0) NOT NULL,
	PREV_SERVICE VARCHAR(20),
	CURR_SERVICE VARCHAR(20),
	CONSTRAINT services_rowid_pk PRIMARY KEY (ROW_ID)
) ;



DROP TABLE IF EXISTS TRANSFERS CASCADE;
CREATE TABLE TRANSFERS
(
  ROW_ID INT NOT NULL,
	SUBJECT_ID INT NOT NULL,
	HADM_ID INT NOT NULL,
	ICUSTAY_ID INT,
	DBSOURCE VARCHAR(20),
	EVENTTYPE VARCHAR(20),
	PREV_CAREUNIT VARCHAR(20),
	CURR_CAREUNIT VARCHAR(20),
	PREV_WARDID SMALLINT,
	CURR_WARDID SMALLINT,
	INTIME TIMESTAMP(0),
	OUTTIME TIMESTAMP(0),
	LOS DOUBLE PRECISION,
	CONSTRAINT transfers_rowid_pk PRIMARY KEY (ROW_ID)
) ;

\copy ADMISSIONS FROM PROGRAM 'gzip -dc ADMISSIONS.csv.gz' DELIMITER ',' CSV HEADER NULL '';



\copy CALLOUT from PROGRAM 'gzip -dc CALLOUT.csv.gz' delimiter ',' csv header NULL '';



\copy CAREGIVERS from PROGRAM 'gzip -dc CAREGIVERS.csv.gz' delimiter ',' csv header NULL '';

\copy CHARTEVENTS from PROGRAM 'gzip -dc CHARTEVENTS.csv.gz' delimiter ',' csv header NULL '';


\copy CPTEVENTS from PROGRAM 'gzip -dc CPTEVENTS.csv.gz' delimiter ',' csv header NULL '';



\copy DATETIMEEVENTS from PROGRAM 'gzip -dc DATETIMEEVENTS.csv.gz' delimiter ',' csv header NULL '';



\copy DIAGNOSES_ICD from PROGRAM 'gzip -dc DIAGNOSES_ICD.csv.gz' delimiter ',' csv header NULL '';


\copy DRGCODES from PROGRAM 'gzip -dc DRGCODES.csv.gz' delimiter ',' csv header NULL '';



\copy D_CPT from PROGRAM 'gzip -dc D_CPT.csv.gz' delimiter ',' csv header NULL '';



\copy D_ICD_DIAGNOSES from PROGRAM 'gzip -dc D_ICD_DIAGNOSES.csv.gz' delimiter ',' csv header NULL '';



\copy D_ICD_PROCEDURES from PROGRAM 'gzip -dc D_ICD_PROCEDURES.csv.gz' delimiter ',' csv header NULL '';



\copy D_ITEMS from PROGRAM 'gzip -dc D_ITEMS.csv.gz' delimiter ',' csv header NULL '';



\copy D_LABITEMS from PROGRAM 'gzip -dc D_LABITEMS.csv.gz' delimiter ',' csv header NULL '';



\copy ICUSTAYS from PROGRAM 'gzip -dc ICUSTAYS.csv.gz' delimiter ',' csv header NULL '';


\copy INPUTEVENTS_CV from PROGRAM 'gzip -dc INPUTEVENTS_CV.csv.gz' delimiter ',' csv header NULL '';



\copy INPUTEVENTS_MV from PROGRAM 'gzip -dc INPUTEVENTS_MV.csv.gz' delimiter ',' csv header NULL '';



\copy LABEVENTS from PROGRAM 'gzip -dc LABEVENTS.csv.gz' delimiter ',' csv header NULL '';



\copy MICROBIOLOGYEVENTS from PROGRAM 'gzip -dc MICROBIOLOGYEVENTS.csv.gz' delimiter ',' csv header NULL '';


\copy NOTEEVENTS from PROGRAM 'gzip -dc NOTEEVENTS.csv.gz' delimiter ',' csv header NULL '';


\copy OUTPUTEVENTS from PROGRAM 'gzip -dc OUTPUTEVENTS.csv.gz' delimiter ',' csv header NULL '';


\copy PATIENTS from PROGRAM 'gzip -dc PATIENTS.csv.gz' delimiter ',' csv header NULL '';


\copy PRESCRIPTIONS from PROGRAM 'gzip -dc PRESCRIPTIONS.csv.gz' delimiter ',' csv header NULL '';



\copy PROCEDUREEVENTS_MV from PROGRAM 'gzip -dc PROCEDUREEVENTS_MV.csv.gz' delimiter ',' csv header NULL '';

\copy PROCEDURES_ICD from PROGRAM 'gzip -dc PROCEDURES_ICD.csv.gz' delimiter ',' csv header NULL '';


\copy SERVICES from PROGRAM 'gzip -dc SERVICES.csv.gz' delimiter ',' csv header NULL '';



\copy TRANSFERS from PROGRAM 'gzip -dc TRANSFERS.csv.gz' delimiter ',' csv header NULL '';



DROP INDEX IF EXISTS ADMISSIONS_idx01;
CREATE INDEX ADMISSIONS_IDX01
  ON ADMISSIONS (SUBJECT_ID);

DROP INDEX IF EXISTS ADMISSIONS_idx02;
CREATE INDEX ADMISSIONS_IDX02
  ON ADMISSIONS (HADM_ID);


DROP INDEX IF EXISTS CALLOUT_idx01;
CREATE INDEX CALLOUT_IDX01
  ON CALLOUT (SUBJECT_ID);

DROP INDEX IF EXISTS CALLOUT_idx02;
CREATE INDEX CALLOUT_IDX02
  ON CALLOUT (HADM_ID);


DROP INDEX IF EXISTS chartevents_1_idx01;
CREATE INDEX chartevents_1_idx01 ON chartevents_1 (itemid);
DROP INDEX IF EXISTS chartevents_2_idx01;
CREATE INDEX chartevents_2_idx01 ON chartevents_2 (itemid);
DROP INDEX IF EXISTS chartevents_3_idx01;
CREATE INDEX chartevents_3_idx01 ON chartevents_3 (itemid);
DROP INDEX IF EXISTS chartevents_4_idx01;
CREATE INDEX chartevents_4_idx01 ON chartevents_4 (itemid);
DROP INDEX IF EXISTS chartevents_5_idx01;
CREATE INDEX chartevents_5_idx01 ON chartevents_5 (itemid);
DROP INDEX IF EXISTS chartevents_6_idx01;
CREATE INDEX chartevents_6_idx01 ON chartevents_6 (itemid);
DROP INDEX IF EXISTS chartevents_7_idx01;
CREATE INDEX chartevents_7_idx01 ON chartevents_7 (itemid);
DROP INDEX IF EXISTS chartevents_8_idx01;
CREATE INDEX chartevents_8_idx01 ON chartevents_8 (itemid);
DROP INDEX IF EXISTS chartevents_9_idx01;
CREATE INDEX chartevents_9_idx01 ON chartevents_9 (itemid);
DROP INDEX IF EXISTS chartevents_10_idx01;
CREATE INDEX chartevents_10_idx01 ON chartevents_10 (itemid);
DROP INDEX IF EXISTS chartevents_11_idx01;
CREATE INDEX chartevents_11_idx01 ON chartevents_11 (itemid);
DROP INDEX IF EXISTS chartevents_12_idx01;
CREATE INDEX chartevents_12_idx01 ON chartevents_12 (itemid);
DROP INDEX IF EXISTS chartevents_13_idx01;
CREATE INDEX chartevents_13_idx01 ON chartevents_13 (itemid);
DROP INDEX IF EXISTS chartevents_14_idx01;
CREATE INDEX chartevents_14_idx01 ON chartevents_14 (itemid);
DROP INDEX IF EXISTS chartevents_15_idx01;
CREATE INDEX chartevents_15_idx01 ON chartevents_15 (itemid);
DROP INDEX IF EXISTS chartevents_16_idx01;
CREATE INDEX chartevents_16_idx01 ON chartevents_16 (itemid);
DROP INDEX IF EXISTS chartevents_17_idx01;
CREATE INDEX chartevents_17_idx01 ON chartevents_17 (itemid);


DO $$
BEGIN

IF EXISTS (
    SELECT 1
    FROM         pg_class c
    INNER JOIN   pg_namespace n
      ON n.oid = c.relnamespace
    WHERE  c.relname = 'chartevents_207'
  ) THEN

  DROP INDEX IF EXISTS chartevents_18_idx01;
  CREATE INDEX chartevents_18_idx01 ON chartevents_18 (itemid);
  DROP INDEX IF EXISTS chartevents_19_idx01;
  CREATE INDEX chartevents_19_idx01 ON chartevents_19 (itemid);
  DROP INDEX IF EXISTS chartevents_20_idx01;
  CREATE INDEX chartevents_20_idx01 ON chartevents_20 (itemid);
  DROP INDEX IF EXISTS chartevents_21_idx01;
  CREATE INDEX chartevents_21_idx01 ON chartevents_21 (itemid);
  DROP INDEX IF EXISTS chartevents_22_idx01;
  CREATE INDEX chartevents_22_idx01 ON chartevents_22 (itemid);
  DROP INDEX IF EXISTS chartevents_23_idx01;
  CREATE INDEX chartevents_23_idx01 ON chartevents_23 (itemid);
  DROP INDEX IF EXISTS chartevents_24_idx01;
  CREATE INDEX chartevents_24_idx01 ON chartevents_24 (itemid);
  DROP INDEX IF EXISTS chartevents_25_idx01;
  CREATE INDEX chartevents_25_idx01 ON chartevents_25 (itemid);
  DROP INDEX IF EXISTS chartevents_26_idx01;
  CREATE INDEX chartevents_26_idx01 ON chartevents_26 (itemid);
  DROP INDEX IF EXISTS chartevents_27_idx01;
  CREATE INDEX chartevents_27_idx01 ON chartevents_27 (itemid);
  DROP INDEX IF EXISTS chartevents_28_idx01;
  CREATE INDEX chartevents_28_idx01 ON chartevents_28 (itemid);
  DROP INDEX IF EXISTS chartevents_29_idx01;
  CREATE INDEX chartevents_29_idx01 ON chartevents_29 (itemid);
  DROP INDEX IF EXISTS chartevents_30_idx01;
  CREATE INDEX chartevents_30_idx01 ON chartevents_30 (itemid);
  DROP INDEX IF EXISTS chartevents_31_idx01;
  CREATE INDEX chartevents_31_idx01 ON chartevents_31 (itemid);
  DROP INDEX IF EXISTS chartevents_32_idx01;
  CREATE INDEX chartevents_32_idx01 ON chartevents_32 (itemid);
  DROP INDEX IF EXISTS chartevents_33_idx01;
  CREATE INDEX chartevents_33_idx01 ON chartevents_33 (itemid);
  DROP INDEX IF EXISTS chartevents_34_idx01;
  CREATE INDEX chartevents_34_idx01 ON chartevents_34 (itemid);
  DROP INDEX IF EXISTS chartevents_35_idx01;
  CREATE INDEX chartevents_35_idx01 ON chartevents_35 (itemid);
  DROP INDEX IF EXISTS chartevents_36_idx01;
  CREATE INDEX chartevents_36_idx01 ON chartevents_36 (itemid);
  DROP INDEX IF EXISTS chartevents_37_idx01;
  CREATE INDEX chartevents_37_idx01 ON chartevents_37 (itemid);
  DROP INDEX IF EXISTS chartevents_38_idx01;
  CREATE INDEX chartevents_38_idx01 ON chartevents_38 (itemid);
  DROP INDEX IF EXISTS chartevents_39_idx01;
  CREATE INDEX chartevents_39_idx01 ON chartevents_39 (itemid);
  DROP INDEX IF EXISTS chartevents_40_idx01;
  CREATE INDEX chartevents_40_idx01 ON chartevents_40 (itemid);
  DROP INDEX IF EXISTS chartevents_41_idx01;
  CREATE INDEX chartevents_41_idx01 ON chartevents_41 (itemid);
  DROP INDEX IF EXISTS chartevents_42_idx01;
  CREATE INDEX chartevents_42_idx01 ON chartevents_42 (itemid);
  DROP INDEX IF EXISTS chartevents_43_idx01;
  CREATE INDEX chartevents_43_idx01 ON chartevents_43 (itemid);
  DROP INDEX IF EXISTS chartevents_44_idx01;
  CREATE INDEX chartevents_44_idx01 ON chartevents_44 (itemid);
  DROP INDEX IF EXISTS chartevents_45_idx01;
  CREATE INDEX chartevents_45_idx01 ON chartevents_45 (itemid);
  DROP INDEX IF EXISTS chartevents_46_idx01;
  CREATE INDEX chartevents_46_idx01 ON chartevents_46 (itemid);
  DROP INDEX IF EXISTS chartevents_47_idx01;
  CREATE INDEX chartevents_47_idx01 ON chartevents_47 (itemid);
  DROP INDEX IF EXISTS chartevents_48_idx01;
  CREATE INDEX chartevents_48_idx01 ON chartevents_48 (itemid);
  DROP INDEX IF EXISTS chartevents_49_idx01;
  CREATE INDEX chartevents_49_idx01 ON chartevents_49 (itemid);
  DROP INDEX IF EXISTS chartevents_50_idx01;
  CREATE INDEX chartevents_50_idx01 ON chartevents_50 (itemid);
  DROP INDEX IF EXISTS chartevents_51_idx01;
  CREATE INDEX chartevents_51_idx01 ON chartevents_51 (itemid);
  DROP INDEX IF EXISTS chartevents_52_idx01;
  CREATE INDEX chartevents_52_idx01 ON chartevents_52 (itemid);
  DROP INDEX IF EXISTS chartevents_53_idx01;
  CREATE INDEX chartevents_53_idx01 ON chartevents_53 (itemid);
  DROP INDEX IF EXISTS chartevents_54_idx01;
  CREATE INDEX chartevents_54_idx01 ON chartevents_54 (itemid);
  DROP INDEX IF EXISTS chartevents_55_idx01;
  CREATE INDEX chartevents_55_idx01 ON chartevents_55 (itemid);
  DROP INDEX IF EXISTS chartevents_56_idx01;
  CREATE INDEX chartevents_56_idx01 ON chartevents_56 (itemid);
  DROP INDEX IF EXISTS chartevents_57_idx01;
  CREATE INDEX chartevents_57_idx01 ON chartevents_57 (itemid);
  DROP INDEX IF EXISTS chartevents_58_idx01;
  CREATE INDEX chartevents_58_idx01 ON chartevents_58 (itemid);
  DROP INDEX IF EXISTS chartevents_59_idx01;
  CREATE INDEX chartevents_59_idx01 ON chartevents_59 (itemid);
  DROP INDEX IF EXISTS chartevents_60_idx01;
  CREATE INDEX chartevents_60_idx01 ON chartevents_60 (itemid);
  DROP INDEX IF EXISTS chartevents_61_idx01;
  CREATE INDEX chartevents_61_idx01 ON chartevents_61 (itemid);
  DROP INDEX IF EXISTS chartevents_62_idx01;
  CREATE INDEX chartevents_62_idx01 ON chartevents_62 (itemid);
  DROP INDEX IF EXISTS chartevents_63_idx01;
  CREATE INDEX chartevents_63_idx01 ON chartevents_63 (itemid);
  DROP INDEX IF EXISTS chartevents_64_idx01;
  CREATE INDEX chartevents_64_idx01 ON chartevents_64 (itemid);
  DROP INDEX IF EXISTS chartevents_65_idx01;
  CREATE INDEX chartevents_65_idx01 ON chartevents_65 (itemid);
  DROP INDEX IF EXISTS chartevents_66_idx01;
  CREATE INDEX chartevents_66_idx01 ON chartevents_66 (itemid);
  DROP INDEX IF EXISTS chartevents_67_idx01;
  CREATE INDEX chartevents_67_idx01 ON chartevents_67 (itemid);
  DROP INDEX IF EXISTS chartevents_68_idx01;
  CREATE INDEX chartevents_68_idx01 ON chartevents_68 (itemid);
  DROP INDEX IF EXISTS chartevents_69_idx01;
  CREATE INDEX chartevents_69_idx01 ON chartevents_69 (itemid);
  DROP INDEX IF EXISTS chartevents_70_idx01;
  CREATE INDEX chartevents_70_idx01 ON chartevents_70 (itemid);
  DROP INDEX IF EXISTS chartevents_71_idx01;
  CREATE INDEX chartevents_71_idx01 ON chartevents_71 (itemid);
  DROP INDEX IF EXISTS chartevents_72_idx01;
  CREATE INDEX chartevents_72_idx01 ON chartevents_72 (itemid);
  DROP INDEX IF EXISTS chartevents_73_idx01;
  CREATE INDEX chartevents_73_idx01 ON chartevents_73 (itemid);
  DROP INDEX IF EXISTS chartevents_74_idx01;
  CREATE INDEX chartevents_74_idx01 ON chartevents_74 (itemid);
  DROP INDEX IF EXISTS chartevents_75_idx01;
  CREATE INDEX chartevents_75_idx01 ON chartevents_75 (itemid);
  DROP INDEX IF EXISTS chartevents_76_idx01;
  CREATE INDEX chartevents_76_idx01 ON chartevents_76 (itemid);
  DROP INDEX IF EXISTS chartevents_77_idx01;
  CREATE INDEX chartevents_77_idx01 ON chartevents_77 (itemid);
  DROP INDEX IF EXISTS chartevents_78_idx01;
  CREATE INDEX chartevents_78_idx01 ON chartevents_78 (itemid);
  DROP INDEX IF EXISTS chartevents_79_idx01;
  CREATE INDEX chartevents_79_idx01 ON chartevents_79 (itemid);
  DROP INDEX IF EXISTS chartevents_80_idx01;
  CREATE INDEX chartevents_80_idx01 ON chartevents_80 (itemid);
  DROP INDEX IF EXISTS chartevents_81_idx01;
  CREATE INDEX chartevents_81_idx01 ON chartevents_81 (itemid);
  DROP INDEX IF EXISTS chartevents_82_idx01;
  CREATE INDEX chartevents_82_idx01 ON chartevents_82 (itemid);
  DROP INDEX IF EXISTS chartevents_83_idx01;
  CREATE INDEX chartevents_83_idx01 ON chartevents_83 (itemid);
  DROP INDEX IF EXISTS chartevents_84_idx01;
  CREATE INDEX chartevents_84_idx01 ON chartevents_84 (itemid);
  DROP INDEX IF EXISTS chartevents_85_idx01;
  CREATE INDEX chartevents_85_idx01 ON chartevents_85 (itemid);
  DROP INDEX IF EXISTS chartevents_86_idx01;
  CREATE INDEX chartevents_86_idx01 ON chartevents_86 (itemid);
  DROP INDEX IF EXISTS chartevents_87_idx01;
  CREATE INDEX chartevents_87_idx01 ON chartevents_87 (itemid);
  DROP INDEX IF EXISTS chartevents_88_idx01;
  CREATE INDEX chartevents_88_idx01 ON chartevents_88 (itemid);
  DROP INDEX IF EXISTS chartevents_89_idx01;
  CREATE INDEX chartevents_89_idx01 ON chartevents_89 (itemid);
  DROP INDEX IF EXISTS chartevents_90_idx01;
  CREATE INDEX chartevents_90_idx01 ON chartevents_90 (itemid);
  DROP INDEX IF EXISTS chartevents_91_idx01;
  CREATE INDEX chartevents_91_idx01 ON chartevents_91 (itemid);
  DROP INDEX IF EXISTS chartevents_92_idx01;
  CREATE INDEX chartevents_92_idx01 ON chartevents_92 (itemid);
  DROP INDEX IF EXISTS chartevents_93_idx01;
  CREATE INDEX chartevents_93_idx01 ON chartevents_93 (itemid);
  DROP INDEX IF EXISTS chartevents_94_idx01;
  CREATE INDEX chartevents_94_idx01 ON chartevents_94 (itemid);
  DROP INDEX IF EXISTS chartevents_95_idx01;
  CREATE INDEX chartevents_95_idx01 ON chartevents_95 (itemid);
  DROP INDEX IF EXISTS chartevents_96_idx01;
  CREATE INDEX chartevents_96_idx01 ON chartevents_96 (itemid);
  DROP INDEX IF EXISTS chartevents_97_idx01;
  CREATE INDEX chartevents_97_idx01 ON chartevents_97 (itemid);
  DROP INDEX IF EXISTS chartevents_98_idx01;
  CREATE INDEX chartevents_98_idx01 ON chartevents_98 (itemid);
  DROP INDEX IF EXISTS chartevents_99_idx01;
  CREATE INDEX chartevents_99_idx01 ON chartevents_99 (itemid);
  DROP INDEX IF EXISTS chartevents_100_idx01;
  CREATE INDEX chartevents_100_idx01 ON chartevents_100 (itemid);
  DROP INDEX IF EXISTS chartevents_101_idx01;
  CREATE INDEX chartevents_101_idx01 ON chartevents_101 (itemid);
  DROP INDEX IF EXISTS chartevents_102_idx01;
  CREATE INDEX chartevents_102_idx01 ON chartevents_102 (itemid);
  DROP INDEX IF EXISTS chartevents_103_idx01;
  CREATE INDEX chartevents_103_idx01 ON chartevents_103 (itemid);
  DROP INDEX IF EXISTS chartevents_104_idx01;
  CREATE INDEX chartevents_104_idx01 ON chartevents_104 (itemid);
  DROP INDEX IF EXISTS chartevents_105_idx01;
  CREATE INDEX chartevents_105_idx01 ON chartevents_105 (itemid);
  DROP INDEX IF EXISTS chartevents_106_idx01;
  CREATE INDEX chartevents_106_idx01 ON chartevents_106 (itemid);
  DROP INDEX IF EXISTS chartevents_107_idx01;
  CREATE INDEX chartevents_107_idx01 ON chartevents_107 (itemid);
  DROP INDEX IF EXISTS chartevents_108_idx01;
  CREATE INDEX chartevents_108_idx01 ON chartevents_108 (itemid);
  DROP INDEX IF EXISTS chartevents_109_idx01;
  CREATE INDEX chartevents_109_idx01 ON chartevents_109 (itemid);
  DROP INDEX IF EXISTS chartevents_110_idx01;
  CREATE INDEX chartevents_110_idx01 ON chartevents_110 (itemid);
  DROP INDEX IF EXISTS chartevents_111_idx01;
  CREATE INDEX chartevents_111_idx01 ON chartevents_111 (itemid);
  DROP INDEX IF EXISTS chartevents_112_idx01;
  CREATE INDEX chartevents_112_idx01 ON chartevents_112 (itemid);
  DROP INDEX IF EXISTS chartevents_113_idx01;
  CREATE INDEX chartevents_113_idx01 ON chartevents_113 (itemid);
  DROP INDEX IF EXISTS chartevents_114_idx01;
  CREATE INDEX chartevents_114_idx01 ON chartevents_114 (itemid);
  DROP INDEX IF EXISTS chartevents_115_idx01;
  CREATE INDEX chartevents_115_idx01 ON chartevents_115 (itemid);
  DROP INDEX IF EXISTS chartevents_116_idx01;
  CREATE INDEX chartevents_116_idx01 ON chartevents_116 (itemid);
  DROP INDEX IF EXISTS chartevents_117_idx01;
  CREATE INDEX chartevents_117_idx01 ON chartevents_117 (itemid);
  DROP INDEX IF EXISTS chartevents_118_idx01;
  CREATE INDEX chartevents_118_idx01 ON chartevents_118 (itemid);
  DROP INDEX IF EXISTS chartevents_119_idx01;
  CREATE INDEX chartevents_119_idx01 ON chartevents_119 (itemid);
  DROP INDEX IF EXISTS chartevents_120_idx01;
  CREATE INDEX chartevents_120_idx01 ON chartevents_120 (itemid);
  DROP INDEX IF EXISTS chartevents_121_idx01;
  CREATE INDEX chartevents_121_idx01 ON chartevents_121 (itemid);
  DROP INDEX IF EXISTS chartevents_122_idx01;
  CREATE INDEX chartevents_122_idx01 ON chartevents_122 (itemid);
  DROP INDEX IF EXISTS chartevents_123_idx01;
  CREATE INDEX chartevents_123_idx01 ON chartevents_123 (itemid);
  DROP INDEX IF EXISTS chartevents_124_idx01;
  CREATE INDEX chartevents_124_idx01 ON chartevents_124 (itemid);
  DROP INDEX IF EXISTS chartevents_125_idx01;
  CREATE INDEX chartevents_125_idx01 ON chartevents_125 (itemid);
  DROP INDEX IF EXISTS chartevents_126_idx01;
  CREATE INDEX chartevents_126_idx01 ON chartevents_126 (itemid);
  DROP INDEX IF EXISTS chartevents_127_idx01;
  CREATE INDEX chartevents_127_idx01 ON chartevents_127 (itemid);
  DROP INDEX IF EXISTS chartevents_128_idx01;
  CREATE INDEX chartevents_128_idx01 ON chartevents_128 (itemid);
  DROP INDEX IF EXISTS chartevents_129_idx01;
  CREATE INDEX chartevents_129_idx01 ON chartevents_129 (itemid);
  DROP INDEX IF EXISTS chartevents_130_idx01;
  CREATE INDEX chartevents_130_idx01 ON chartevents_130 (itemid);
  DROP INDEX IF EXISTS chartevents_131_idx01;
  CREATE INDEX chartevents_131_idx01 ON chartevents_131 (itemid);
  DROP INDEX IF EXISTS chartevents_132_idx01;
  CREATE INDEX chartevents_132_idx01 ON chartevents_132 (itemid);
  DROP INDEX IF EXISTS chartevents_133_idx01;
  CREATE INDEX chartevents_133_idx01 ON chartevents_133 (itemid);
  DROP INDEX IF EXISTS chartevents_134_idx01;
  CREATE INDEX chartevents_134_idx01 ON chartevents_134 (itemid);
  DROP INDEX IF EXISTS chartevents_135_idx01;
  CREATE INDEX chartevents_135_idx01 ON chartevents_135 (itemid);
  DROP INDEX IF EXISTS chartevents_136_idx01;
  CREATE INDEX chartevents_136_idx01 ON chartevents_136 (itemid);
  DROP INDEX IF EXISTS chartevents_137_idx01;
  CREATE INDEX chartevents_137_idx01 ON chartevents_137 (itemid);
  DROP INDEX IF EXISTS chartevents_138_idx01;
  CREATE INDEX chartevents_138_idx01 ON chartevents_138 (itemid);
  DROP INDEX IF EXISTS chartevents_139_idx01;
  CREATE INDEX chartevents_139_idx01 ON chartevents_139 (itemid);
  DROP INDEX IF EXISTS chartevents_140_idx01;
  CREATE INDEX chartevents_140_idx01 ON chartevents_140 (itemid);
  DROP INDEX IF EXISTS chartevents_141_idx01;
  CREATE INDEX chartevents_141_idx01 ON chartevents_141 (itemid);
  DROP INDEX IF EXISTS chartevents_142_idx01;
  CREATE INDEX chartevents_142_idx01 ON chartevents_142 (itemid);
  DROP INDEX IF EXISTS chartevents_143_idx01;
  CREATE INDEX chartevents_143_idx01 ON chartevents_143 (itemid);
  DROP INDEX IF EXISTS chartevents_144_idx01;
  CREATE INDEX chartevents_144_idx01 ON chartevents_144 (itemid);
  DROP INDEX IF EXISTS chartevents_145_idx01;
  CREATE INDEX chartevents_145_idx01 ON chartevents_145 (itemid);
  DROP INDEX IF EXISTS chartevents_146_idx01;
  CREATE INDEX chartevents_146_idx01 ON chartevents_146 (itemid);
  DROP INDEX IF EXISTS chartevents_147_idx01;
  CREATE INDEX chartevents_147_idx01 ON chartevents_147 (itemid);
  DROP INDEX IF EXISTS chartevents_148_idx01;
  CREATE INDEX chartevents_148_idx01 ON chartevents_148 (itemid);
  DROP INDEX IF EXISTS chartevents_149_idx01;
  CREATE INDEX chartevents_149_idx01 ON chartevents_149 (itemid);
  DROP INDEX IF EXISTS chartevents_150_idx01;
  CREATE INDEX chartevents_150_idx01 ON chartevents_150 (itemid);
  DROP INDEX IF EXISTS chartevents_151_idx01;
  CREATE INDEX chartevents_151_idx01 ON chartevents_151 (itemid);
  DROP INDEX IF EXISTS chartevents_152_idx01;
  CREATE INDEX chartevents_152_idx01 ON chartevents_152 (itemid);
  DROP INDEX IF EXISTS chartevents_153_idx01;
  CREATE INDEX chartevents_153_idx01 ON chartevents_153 (itemid);
  DROP INDEX IF EXISTS chartevents_154_idx01;
  CREATE INDEX chartevents_154_idx01 ON chartevents_154 (itemid);
  DROP INDEX IF EXISTS chartevents_155_idx01;
  CREATE INDEX chartevents_155_idx01 ON chartevents_155 (itemid);
  DROP INDEX IF EXISTS chartevents_156_idx01;
  CREATE INDEX chartevents_156_idx01 ON chartevents_156 (itemid);
  DROP INDEX IF EXISTS chartevents_157_idx01;
  CREATE INDEX chartevents_157_idx01 ON chartevents_157 (itemid);
  DROP INDEX IF EXISTS chartevents_158_idx01;
  CREATE INDEX chartevents_158_idx01 ON chartevents_158 (itemid);
  DROP INDEX IF EXISTS chartevents_159_idx01;
  CREATE INDEX chartevents_159_idx01 ON chartevents_159 (itemid);
  DROP INDEX IF EXISTS chartevents_160_idx01;
  CREATE INDEX chartevents_160_idx01 ON chartevents_160 (itemid);
  DROP INDEX IF EXISTS chartevents_161_idx01;
  CREATE INDEX chartevents_161_idx01 ON chartevents_161 (itemid);
  DROP INDEX IF EXISTS chartevents_162_idx01;
  CREATE INDEX chartevents_162_idx01 ON chartevents_162 (itemid);
  DROP INDEX IF EXISTS chartevents_163_idx01;
  CREATE INDEX chartevents_163_idx01 ON chartevents_163 (itemid);
  DROP INDEX IF EXISTS chartevents_164_idx01;
  CREATE INDEX chartevents_164_idx01 ON chartevents_164 (itemid);
  DROP INDEX IF EXISTS chartevents_165_idx01;
  CREATE INDEX chartevents_165_idx01 ON chartevents_165 (itemid);
  DROP INDEX IF EXISTS chartevents_166_idx01;
  CREATE INDEX chartevents_166_idx01 ON chartevents_166 (itemid);
  DROP INDEX IF EXISTS chartevents_167_idx01;
  CREATE INDEX chartevents_167_idx01 ON chartevents_167 (itemid);
  DROP INDEX IF EXISTS chartevents_168_idx01;
  CREATE INDEX chartevents_168_idx01 ON chartevents_168 (itemid);
  DROP INDEX IF EXISTS chartevents_169_idx01;
  CREATE INDEX chartevents_169_idx01 ON chartevents_169 (itemid);
  DROP INDEX IF EXISTS chartevents_170_idx01;
  CREATE INDEX chartevents_170_idx01 ON chartevents_170 (itemid);
  DROP INDEX IF EXISTS chartevents_171_idx01;
  CREATE INDEX chartevents_171_idx01 ON chartevents_171 (itemid);
  DROP INDEX IF EXISTS chartevents_172_idx01;
  CREATE INDEX chartevents_172_idx01 ON chartevents_172 (itemid);
  DROP INDEX IF EXISTS chartevents_173_idx01;
  CREATE INDEX chartevents_173_idx01 ON chartevents_173 (itemid);
  DROP INDEX IF EXISTS chartevents_174_idx01;
  CREATE INDEX chartevents_174_idx01 ON chartevents_174 (itemid);
  DROP INDEX IF EXISTS chartevents_175_idx01;
  CREATE INDEX chartevents_175_idx01 ON chartevents_175 (itemid);
  DROP INDEX IF EXISTS chartevents_176_idx01;
  CREATE INDEX chartevents_176_idx01 ON chartevents_176 (itemid);
  DROP INDEX IF EXISTS chartevents_177_idx01;
  CREATE INDEX chartevents_177_idx01 ON chartevents_177 (itemid);
  DROP INDEX IF EXISTS chartevents_178_idx01;
  CREATE INDEX chartevents_178_idx01 ON chartevents_178 (itemid);
  DROP INDEX IF EXISTS chartevents_179_idx01;
  CREATE INDEX chartevents_179_idx01 ON chartevents_179 (itemid);
  DROP INDEX IF EXISTS chartevents_180_idx01;
  CREATE INDEX chartevents_180_idx01 ON chartevents_180 (itemid);
  DROP INDEX IF EXISTS chartevents_181_idx01;
  CREATE INDEX chartevents_181_idx01 ON chartevents_181 (itemid);
  DROP INDEX IF EXISTS chartevents_182_idx01;
  CREATE INDEX chartevents_182_idx01 ON chartevents_182 (itemid);
  DROP INDEX IF EXISTS chartevents_183_idx01;
  CREATE INDEX chartevents_183_idx01 ON chartevents_183 (itemid);
  DROP INDEX IF EXISTS chartevents_184_idx01;
  CREATE INDEX chartevents_184_idx01 ON chartevents_184 (itemid);
  DROP INDEX IF EXISTS chartevents_185_idx01;
  CREATE INDEX chartevents_185_idx01 ON chartevents_185 (itemid);
  DROP INDEX IF EXISTS chartevents_186_idx01;
  CREATE INDEX chartevents_186_idx01 ON chartevents_186 (itemid);
  DROP INDEX IF EXISTS chartevents_187_idx01;
  CREATE INDEX chartevents_187_idx01 ON chartevents_187 (itemid);
  DROP INDEX IF EXISTS chartevents_188_idx01;
  CREATE INDEX chartevents_188_idx01 ON chartevents_188 (itemid);
  DROP INDEX IF EXISTS chartevents_189_idx01;
  CREATE INDEX chartevents_189_idx01 ON chartevents_189 (itemid);
  DROP INDEX IF EXISTS chartevents_190_idx01;
  CREATE INDEX chartevents_190_idx01 ON chartevents_190 (itemid);
  DROP INDEX IF EXISTS chartevents_191_idx01;
  CREATE INDEX chartevents_191_idx01 ON chartevents_191 (itemid);
  DROP INDEX IF EXISTS chartevents_192_idx01;
  CREATE INDEX chartevents_192_idx01 ON chartevents_192 (itemid);
  DROP INDEX IF EXISTS chartevents_193_idx01;
  CREATE INDEX chartevents_193_idx01 ON chartevents_193 (itemid);
  DROP INDEX IF EXISTS chartevents_194_idx01;
  CREATE INDEX chartevents_194_idx01 ON chartevents_194 (itemid);
  DROP INDEX IF EXISTS chartevents_195_idx01;
  CREATE INDEX chartevents_195_idx01 ON chartevents_195 (itemid);
  DROP INDEX IF EXISTS chartevents_196_idx01;
  CREATE INDEX chartevents_196_idx01 ON chartevents_196 (itemid);
  DROP INDEX IF EXISTS chartevents_197_idx01;
  CREATE INDEX chartevents_197_idx01 ON chartevents_197 (itemid);
  DROP INDEX IF EXISTS chartevents_198_idx01;
  CREATE INDEX chartevents_198_idx01 ON chartevents_198 (itemid);
  DROP INDEX IF EXISTS chartevents_199_idx01;
  CREATE INDEX chartevents_199_idx01 ON chartevents_199 (itemid);
  DROP INDEX IF EXISTS chartevents_200_idx01;
  CREATE INDEX chartevents_200_idx01 ON chartevents_200 (itemid);
  DROP INDEX IF EXISTS chartevents_201_idx01;
  CREATE INDEX chartevents_201_idx01 ON chartevents_201 (itemid);
  DROP INDEX IF EXISTS chartevents_202_idx01;
  CREATE INDEX chartevents_202_idx01 ON chartevents_202 (itemid);
  DROP INDEX IF EXISTS chartevents_203_idx01;
  CREATE INDEX chartevents_203_idx01 ON chartevents_203 (itemid);
  DROP INDEX IF EXISTS chartevents_204_idx01;
  CREATE INDEX chartevents_204_idx01 ON chartevents_204 (itemid);
  DROP INDEX IF EXISTS chartevents_205_idx01;
  CREATE INDEX chartevents_205_idx01 ON chartevents_205 (itemid);
  DROP INDEX IF EXISTS chartevents_206_idx01;
  CREATE INDEX chartevents_206_idx01 ON chartevents_206 (itemid);
  DROP INDEX IF EXISTS chartevents_207_idx01;
  CREATE INDEX chartevents_207_idx01 ON chartevents_207 (itemid);
END IF;

END$$;


DROP INDEX IF EXISTS CPTEVENTS_idx01;
CREATE INDEX CPTEVENTS_idx01
  ON CPTEVENTS (SUBJECT_ID);

DROP INDEX IF EXISTS CPTEVENTS_idx02;
CREATE INDEX CPTEVENTS_idx02
  ON CPTEVENTS (CPT_CD);


DROP INDEX IF EXISTS D_ICD_DIAG_idx01;
CREATE INDEX D_ICD_DIAG_idx01
  ON D_ICD_DIAGNOSES (ICD9_CODE);

DROP INDEX IF EXISTS D_ICD_DIAG_idx02;
CREATE INDEX D_ICD_DIAG_idx02
  ON D_ICD_DIAGNOSES (LONG_TITLE);


DROP INDEX IF EXISTS D_ICD_PROC_idx01;
CREATE INDEX D_ICD_PROC_idx01
  ON D_ICD_PROCEDURES (ICD9_CODE);

DROP INDEX IF EXISTS D_ICD_PROC_idx02;
CREATE INDEX D_ICD_PROC_idx02
  ON D_ICD_PROCEDURES (LONG_TITLE);



DROP INDEX IF EXISTS D_ITEMS_idx01;
CREATE INDEX D_ITEMS_idx01
  ON D_ITEMS (ITEMID);

DROP INDEX IF EXISTS D_ITEMS_idx02;
CREATE INDEX D_ITEMS_idx02
  ON D_ITEMS (LABEL);



DROP INDEX IF EXISTS D_LABITEMS_idx01;
CREATE INDEX D_LABITEMS_idx01
  ON D_LABITEMS (ITEMID);

DROP INDEX IF EXISTS D_LABITEMS_idx02;
CREATE INDEX D_LABITEMS_idx02
  ON D_LABITEMS (LABEL);

DROP INDEX IF EXISTS D_LABITEMS_idx03;
CREATE INDEX D_LABITEMS_idx03
  ON D_LABITEMS (LOINC_CODE);



DROP INDEX IF EXISTS DATETIMEEVENTS_idx01;
CREATE INDEX DATETIMEEVENTS_idx01
  ON DATETIMEEVENTS (SUBJECT_ID);

DROP INDEX IF EXISTS DATETIMEEVENTS_idx02;
CREATE INDEX DATETIMEEVENTS_idx02
  ON DATETIMEEVENTS (ITEMID);

DROP INDEX IF EXISTS DATETIMEEVENTS_idx03;
CREATE INDEX DATETIMEEVENTS_idx03
  ON DATETIMEEVENTS (ICUSTAY_ID);

DROP INDEX IF EXISTS DATETIMEEVENTS_idx04;
CREATE INDEX DATETIMEEVENTS_idx04
  ON DATETIMEEVENTS (HADM_ID);



DROP INDEX IF EXISTS DIAGNOSES_ICD_idx01;
CREATE INDEX DIAGNOSES_ICD_idx01
  ON DIAGNOSES_ICD (SUBJECT_ID);

DROP INDEX IF EXISTS DIAGNOSES_ICD_idx02;
CREATE INDEX DIAGNOSES_ICD_idx02
  ON DIAGNOSES_ICD (ICD9_CODE);

DROP INDEX IF EXISTS DIAGNOSES_ICD_idx03;
CREATE INDEX DIAGNOSES_ICD_idx03
  ON DIAGNOSES_ICD (HADM_ID);



DROP INDEX IF EXISTS DRGCODES_idx01;
CREATE INDEX DRGCODES_idx01
  ON DRGCODES (SUBJECT_ID);

DROP INDEX IF EXISTS DRGCODES_idx02;
CREATE INDEX DRGCODES_idx02
  ON DRGCODES (DRG_CODE);

DROP INDEX IF EXISTS DRGCODES_idx03;
CREATE INDEX DRGCODES_idx03
  ON DRGCODES (DESCRIPTION);



DROP INDEX IF EXISTS ICUSTAYS_idx01;
CREATE INDEX ICUSTAYS_idx01
  ON ICUSTAYS (SUBJECT_ID);

DROP INDEX IF EXISTS ICUSTAYS_idx02;
CREATE INDEX ICUSTAYS_idx02
  ON ICUSTAYS (ICUSTAY_ID);



DROP INDEX IF EXISTS ICUSTAYS_idx06;
CREATE INDEX ICUSTAYS_IDX06
  ON ICUSTAYS (HADM_ID);


DROP INDEX IF EXISTS INPUTEVENTS_CV_idx01;
CREATE INDEX INPUTEVENTS_CV_idx01
  ON INPUTEVENTS_CV (SUBJECT_ID);

  DROP INDEX IF EXISTS INPUTEVENTS_CV_idx02;
  CREATE INDEX INPUTEVENTS_CV_idx02
    ON INPUTEVENTS_CV (HADM_ID);

DROP INDEX IF EXISTS INPUTEVENTS_CV_idx03;
CREATE INDEX INPUTEVENTS_CV_idx03
  ON INPUTEVENTS_CV (ICUSTAY_ID);

DROP INDEX IF EXISTS INPUTEVENTS_CV_idx04;
CREATE INDEX INPUTEVENTS_CV_idx04
  ON INPUTEVENTS_CV (CHARTTIME);

DROP INDEX IF EXISTS INPUTEVENTS_CV_idx05;
CREATE INDEX INPUTEVENTS_CV_idx05
  ON INPUTEVENTS_CV (ITEMID);



DROP INDEX IF EXISTS INPUTEVENTS_MV_idx01;
CREATE INDEX INPUTEVENTS_MV_idx01
  ON INPUTEVENTS_MV (SUBJECT_ID);

DROP INDEX IF EXISTS INPUTEVENTS_MV_idx02;
CREATE INDEX INPUTEVENTS_MV_idx02
  ON INPUTEVENTS_MV (HADM_ID);

DROP INDEX IF EXISTS INPUTEVENTS_MV_idx03;
CREATE INDEX INPUTEVENTS_MV_idx03
  ON INPUTEVENTS_MV (ICUSTAY_ID);



DROP INDEX IF EXISTS INPUTEVENTS_MV_idx05;
CREATE INDEX INPUTEVENTS_MV_idx05
  ON INPUTEVENTS_MV (ITEMID);



DROP INDEX IF EXISTS LABEVENTS_idx01;
CREATE INDEX LABEVENTS_idx01
  ON LABEVENTS (SUBJECT_ID);

DROP INDEX IF EXISTS LABEVENTS_idx02;
CREATE INDEX LABEVENTS_idx02
  ON LABEVENTS (HADM_ID);

DROP INDEX IF EXISTS LABEVENTS_idx03;
CREATE INDEX LABEVENTS_idx03
  ON LABEVENTS (ITEMID);


DROP INDEX IF EXISTS MICROBIOLOGYEVENTS_idx01;
CREATE INDEX MICROBIOLOGYEVENTS_idx01
  ON MICROBIOLOGYEVENTS (SUBJECT_ID);

DROP INDEX IF EXISTS MICROBIOLOGYEVENTS_idx02;
CREATE INDEX MICROBIOLOGYEVENTS_idx02
  ON MICROBIOLOGYEVENTS (HADM_ID);



DROP INDEX IF EXISTS NOTEEVENTS_idx01;
CREATE INDEX NOTEEVENTS_idx01
  ON NOTEEVENTS (SUBJECT_ID);

DROP INDEX IF EXISTS NOTEEVENTS_idx02;
CREATE INDEX NOTEEVENTS_idx02
  ON NOTEEVENTS (HADM_ID);


DROP INDEX IF EXISTS NOTEEVENTS_idx05;
CREATE INDEX NOTEEVENTS_idx05
  ON NOTEEVENTS (CATEGORY);


DROP INDEX IF EXISTS OUTPUTEVENTS_idx01;
CREATE INDEX OUTPUTEVENTS_idx01
  ON OUTPUTEVENTS (SUBJECT_ID);


DROP INDEX IF EXISTS OUTPUTEVENTS_idx02;
CREATE INDEX OUTPUTEVENTS_idx02
  ON OUTPUTEVENTS (ITEMID);


DROP INDEX IF EXISTS OUTPUTEVENTS_idx03;
CREATE INDEX OUTPUTEVENTS_idx03
  ON OUTPUTEVENTS (ICUSTAY_ID);


DROP INDEX IF EXISTS OUTPUTEVENTS_idx04;
CREATE INDEX OUTPUTEVENTS_idx04
  ON OUTPUTEVENTS (HADM_ID);


DROP INDEX IF EXISTS PRESCRIPTIONS_idx01;
CREATE INDEX PRESCRIPTIONS_idx01
  ON PRESCRIPTIONS (SUBJECT_ID);

DROP INDEX IF EXISTS PRESCRIPTIONS_idx02;
CREATE INDEX PRESCRIPTIONS_idx02
  ON PRESCRIPTIONS (ICUSTAY_ID);

DROP INDEX IF EXISTS PRESCRIPTIONS_idx03;
CREATE INDEX PRESCRIPTIONS_idx03
  ON PRESCRIPTIONS (DRUG_TYPE);

DROP INDEX IF EXISTS PRESCRIPTIONS_idx04;
CREATE INDEX PRESCRIPTIONS_idx04
  ON PRESCRIPTIONS (DRUG);

DROP INDEX IF EXISTS PRESCRIPTIONS_idx05;
CREATE INDEX PRESCRIPTIONS_idx05
  ON PRESCRIPTIONS (HADM_ID);


DROP INDEX IF EXISTS PROCEDUREEVENTS_MV_idx01;
CREATE INDEX PROCEDUREEVENTS_MV_idx01
  ON PROCEDUREEVENTS_MV (SUBJECT_ID);

DROP INDEX IF EXISTS PROCEDUREEVENTS_MV_idx02;
CREATE INDEX PROCEDUREEVENTS_MV_idx02
  ON PROCEDUREEVENTS_MV (HADM_ID);

DROP INDEX IF EXISTS PROCEDUREEVENTS_MV_idx03;
CREATE INDEX PROCEDUREEVENTS_MV_idx03
  ON PROCEDUREEVENTS_MV (ICUSTAY_ID);


DROP INDEX IF EXISTS PROCEDUREEVENTS_MV_idx05;
CREATE INDEX PROCEDUREEVENTS_MV_idx05
  ON PROCEDUREEVENTS_MV (ITEMID);


DROP INDEX IF EXISTS PROCEDURES_ICD_idx01;
CREATE INDEX PROCEDURES_ICD_idx01
  ON PROCEDURES_ICD (SUBJECT_ID);

DROP INDEX IF EXISTS PROCEDURES_ICD_idx02;
CREATE INDEX PROCEDURES_ICD_idx02
  ON PROCEDURES_ICD (ICD9_CODE);

DROP INDEX IF EXISTS PROCEDURES_ICD_idx03;
CREATE INDEX PROCEDURES_ICD_idx03
  ON PROCEDURES_ICD (HADM_ID);


-------------
-- SERVICES
-------------

DROP INDEX IF EXISTS SERVICES_idx01;
CREATE INDEX SERVICES_idx01
  ON SERVICES (SUBJECT_ID);

DROP INDEX IF EXISTS SERVICES_idx02;
CREATE INDEX SERVICES_idx02
  ON SERVICES (HADM_ID);

DROP INDEX IF EXISTS TRANSFERS_idx01;
CREATE INDEX TRANSFERS_idx01
  ON TRANSFERS (SUBJECT_ID);

DROP INDEX IF EXISTS TRANSFERS_idx02;
CREATE INDEX TRANSFERS_idx02
  ON TRANSFERS (ICUSTAY_ID);

DROP INDEX IF EXISTS TRANSFERS_idx03;
CREATE INDEX TRANSFERS_idx03
  ON TRANSFERS (HADM_ID);


-- Table
COMMENT ON TABLE ADMISSIONS IS
   'Hospital admissions associated with an ICU stay.';

-- Columns
COMMENT ON COLUMN ADMISSIONS.ROW_ID is
   'Unique row identifier.';
COMMENT ON COLUMN ADMISSIONS.SUBJECT_ID is
   'Foreign key. Identifies the patient.';
COMMENT ON COLUMN ADMISSIONS.HADM_ID is
   'Primary key. Identifies the hospital stay.';
COMMENT ON COLUMN ADMISSIONS.ADMITTIME is
   'Time of admission to the hospital.';
COMMENT ON COLUMN ADMISSIONS.DISCHTIME is
   'Time of discharge from the hospital.';
COMMENT ON COLUMN ADMISSIONS.DEATHTIME is
   'Time of death.';
COMMENT ON COLUMN ADMISSIONS.ADMISSION_TYPE is
   'Type of admission, for example emergency or elective.';
COMMENT ON COLUMN ADMISSIONS.ADMISSION_LOCATION is
   'Admission location.';
COMMENT ON COLUMN ADMISSIONS.DISCHARGE_LOCATION is
   'Discharge location';
COMMENT ON COLUMN ADMISSIONS.INSURANCE is
   'Insurance type.';
COMMENT ON COLUMN ADMISSIONS.LANGUAGE is
   'Language.';
COMMENT ON COLUMN ADMISSIONS.RELIGION is
   'Religon.';
COMMENT ON COLUMN ADMISSIONS.MARITAL_STATUS is
   'Marital status.';
COMMENT ON COLUMN ADMISSIONS.ETHNICITY is
   'Ethnicity.';
COMMENT ON COLUMN ADMISSIONS.DIAGNOSIS is
   'Diagnosis.';
COMMENT ON COLUMN ADMISSIONS.HAS_CHARTEVENTS_DATA is
   'Hospital admission has at least one observation in the CHARTEVENTS table.';

-----------
--CALLOUT--
-----------

-- Table
COMMENT ON TABLE CALLOUT IS
  'Record of when patients were ready for discharge (called out), and the actual time of their discharge (or more generally, their outcome).';

-- Columns
COMMENT ON COLUMN CALLOUT.ROW_ID is
   'Unique row identifier.';
COMMENT ON COLUMN CALLOUT.SUBJECT_ID is
   'Foreign key. Identifies the patient.';
COMMENT ON COLUMN CALLOUT.HADM_ID is
   'Foreign key. Identifies the hospital stay.';
COMMENT ON COLUMN CALLOUT.SUBMIT_WARDID is
   'Identifies the ward where the call out request was submitted.';
COMMENT ON COLUMN CALLOUT.SUBMIT_CAREUNIT is
   'If the ward where the call was submitted was an ICU, the ICU type is listed here.';
COMMENT ON COLUMN CALLOUT.CURR_WARDID is
   'Identifies the ward where the patient is currently residing.';
COMMENT ON COLUMN CALLOUT.CURR_CAREUNIT is
   'If the ward where the patient is currently residing is an ICU, the ICU type is listed here.';
COMMENT ON COLUMN CALLOUT.CALLOUT_WARDID is
   'Identifies the ward where the patient is to be discharged to. A value of 1 indicates the first available ward. A value of 0 indicates home.';
COMMENT ON COLUMN CALLOUT.CALLOUT_SERVICE is
   'Identifies the service that the patient is called out to.';
COMMENT ON COLUMN CALLOUT.REQUEST_TELE is
   'Indicates if special precautions are required.';
COMMENT ON COLUMN CALLOUT.REQUEST_RESP is
   'Indicates if special precautions are required.';
COMMENT ON COLUMN CALLOUT.REQUEST_CDIFF is
   'Indicates if special precautions are required.';
COMMENT ON COLUMN CALLOUT.REQUEST_MRSA is
   'Indicates if special precautions are required.';
COMMENT ON COLUMN CALLOUT.REQUEST_VRE is
   'Indicates if special precautions are required.';
COMMENT ON COLUMN CALLOUT.CALLOUT_STATUS is
   'Current status of the call out request.';
COMMENT ON COLUMN CALLOUT.CALLOUT_OUTCOME is
   'The result of the call out request; either a cancellation or a discharge.';
COMMENT ON COLUMN CALLOUT.DISCHARGE_WARDID is
   'The ward to which the patient was discharged.';
COMMENT ON COLUMN CALLOUT.ACKNOWLEDGE_STATUS is
   'The status of the response to the call out request.';
COMMENT ON COLUMN CALLOUT.CREATETIME is
   'Time at which the call out request was created.';
COMMENT ON COLUMN CALLOUT.UPDATETIME is
   'Last time at which the call out request was updated.';
COMMENT ON COLUMN CALLOUT.ACKNOWLEDGETIME is
   'Time at which the call out request was acknowledged.';
COMMENT ON COLUMN CALLOUT.OUTCOMETIME is
   'Time at which the outcome (cancelled or discharged) occurred.';
COMMENT ON COLUMN CALLOUT.FIRSTRESERVATIONTIME is
   'First time at which a ward was reserved for the call out request.';
COMMENT ON COLUMN CALLOUT.CURRENTRESERVATIONTIME is
   'Latest time at which a ward was reserved for the call out request.';

--------------
--CAREGIVERS--
--------------

-- Table
COMMENT ON TABLE CAREGIVERS IS
   'List of caregivers associated with an ICU stay.';

-- Columns
COMMENT ON COLUMN CAREGIVERS.ROW_ID is
   'Unique row identifier.';
COMMENT ON COLUMN CAREGIVERS.CGID is
   'Unique caregiver identifier.';
COMMENT ON COLUMN CAREGIVERS.LABEL is
   'Title of the caregiver, for example MD or RN.';
COMMENT ON COLUMN CAREGIVERS.DESCRIPTION is
   'More detailed description of the caregiver, if available.';

---------------
--CHARTEVENTS--
---------------

-- Table
COMMENT ON TABLE CHARTEVENTS IS
   'Events occuring on a patient chart.';

-- Columns
COMMENT ON COLUMN CHARTEVENTS.ROW_ID is
   'Unique row identifier.';
COMMENT ON COLUMN CHARTEVENTS.SUBJECT_ID is
   'Foreign key. Identifies the patient.';
COMMENT ON COLUMN CHARTEVENTS.HADM_ID is
   'Foreign key. Identifies the hospital stay.';
COMMENT ON COLUMN CHARTEVENTS.ICUSTAY_ID is
   'Foreign key. Identifies the ICU stay.';
COMMENT ON COLUMN CHARTEVENTS.ITEMID is
   'Foreign key. Identifies the charted item.';
COMMENT ON COLUMN CHARTEVENTS.CHARTTIME is
   'Time when the event occured.';
COMMENT ON COLUMN CHARTEVENTS.STORETIME is
   'Time when the event was recorded in the system.';
COMMENT ON COLUMN CHARTEVENTS.CGID is
   'Foreign key. Identifies the caregiver.';
COMMENT ON COLUMN CHARTEVENTS.VALUE is
   'Value of the event as a text string.';
COMMENT ON COLUMN CHARTEVENTS.VALUENUM is
   'Value of the event as a number.';
COMMENT ON COLUMN CHARTEVENTS.VALUEUOM is
   'Unit of measurement.';
COMMENT ON COLUMN CHARTEVENTS.WARNING is
   'Flag to highlight that the value has triggered a warning.';
COMMENT ON COLUMN CHARTEVENTS.ERROR is
   'Flag to highlight an error with the event.';
COMMENT ON COLUMN CHARTEVENTS.RESULTSTATUS is
   'Result status of lab data.';
COMMENT ON COLUMN CHARTEVENTS.STOPPED is
   'Text string indicating the stopped status of an event (i.e. stopped, not stopped).';

-------------
--CPTEVENTS--
-------------

-- Table
COMMENT ON TABLE CPTEVENTS IS
   'Events recorded in Current Procedural Terminology.';

-- Columns
COMMENT ON COLUMN CPTEVENTS.ROW_ID is
   'Unique row identifier.';
COMMENT ON COLUMN CPTEVENTS.SUBJECT_ID is
   'Foreign key. Identifies the patient.';
COMMENT ON COLUMN CPTEVENTS.HADM_ID is
   'Foreign key. Identifies the hospital stay.';
COMMENT ON COLUMN CPTEVENTS.COSTCENTER is
   'Center recording the code, for example the ICU or the respiratory unit.';
COMMENT ON COLUMN CPTEVENTS.CHARTDATE is
   'Date when the event occured, if available.';
COMMENT ON COLUMN CPTEVENTS.CPT_CD is
   'Current Procedural Terminology code.';
COMMENT ON COLUMN CPTEVENTS.CPT_NUMBER is
   'Numerical element of the Current Procedural Terminology code.';
COMMENT ON COLUMN CPTEVENTS.CPT_SUFFIX is
   'Text element of the Current Procedural Terminology, if any. Indicates code category.';
COMMENT ON COLUMN CPTEVENTS.TICKET_ID_SEQ is
   'Sequence number of the event, derived from the ticket ID.';
COMMENT ON COLUMN CPTEVENTS.SECTIONHEADER is
   'High-level section of the Current Procedural Terminology code.';
COMMENT ON COLUMN CPTEVENTS.SUBSECTIONHEADER is
   'Subsection of the Current Procedural Terminology code.';
COMMENT ON COLUMN CPTEVENTS.DESCRIPTION is
   'Description of the Current Procedural Terminology, if available.';

----------
--D_CPT---
----------

-- Table
COMMENT ON TABLE D_CPT IS
   'High-level dictionary of the Current Procedural Terminology.';

-- Columns
COMMENT ON COLUMN D_CPT.ROW_ID is
   'Unique row identifier.';
COMMENT ON COLUMN D_CPT.CATEGORY is
   'Code category.';
COMMENT ON COLUMN D_CPT.SECTIONRANGE is
   'Range of codes within the high-level section.';
COMMENT ON COLUMN D_CPT.SECTIONHEADER is
   'Section header.';
COMMENT ON COLUMN D_CPT.SUBSECTIONRANGE is
   'Range of codes within the subsection.';
COMMENT ON COLUMN D_CPT.SUBSECTIONHEADER is
   'Subsection header.';
COMMENT ON COLUMN D_CPT.CODESUFFIX is
   'Text element of the Current Procedural Terminology, if any.';
COMMENT ON COLUMN D_CPT.MINCODEINSUBSECTION is
   'Minimum code within the subsection.';
COMMENT ON COLUMN D_CPT.MAXCODEINSUBSECTION is
   'Maximum code within the subsection.';

----------
--D_ICD_DIAGNOSES--
----------

-- Table
COMMENT ON TABLE D_ICD_DIAGNOSES IS
   'Dictionary of the International Classification of Diseases, 9th Revision (Diagnoses).';

-- Columns
COMMENT ON COLUMN D_ICD_DIAGNOSES.ROW_ID is
   'Unique row identifier.';
COMMENT ON COLUMN D_ICD_DIAGNOSES.ICD9_CODE is
   'ICD9 code - note that this is a fixed length character field, as whitespaces are important in uniquely identifying ICD-9 codes.';
COMMENT ON COLUMN D_ICD_DIAGNOSES.SHORT_TITLE is
   'Short title associated with the code.';
COMMENT ON COLUMN D_ICD_DIAGNOSES.LONG_TITLE is
   'Long title associated with the code.';

----------
--D_ICD_PROCEDURES--
----------

-- Table
COMMENT ON TABLE D_ICD_PROCEDURES  IS
   'Dictionary of the International Classification of Diseases, 9th Revision (Procedures).';

-- Columns
COMMENT ON COLUMN D_ICD_PROCEDURES.ROW_ID is
   'Unique row identifier.';
COMMENT ON COLUMN D_ICD_PROCEDURES.ICD9_CODE is
   'ICD9 code - note that this is a fixed length character field, as whitespaces are important in uniquely identifying ICD-9 codes.';
COMMENT ON COLUMN D_ICD_PROCEDURES.SHORT_TITLE is
   'Short title associated with the code.';
COMMENT ON COLUMN D_ICD_PROCEDURES.LONG_TITLE is
   'Long title associated with the code.';

-----------
--D_ITEMS--
-----------

-- Table
COMMENT ON TABLE D_ITEMS IS
   'Dictionary of non-laboratory-related charted items.';

-- Columns
COMMENT ON COLUMN D_ITEMS.ROW_ID is
   'Unique row identifier.';
COMMENT ON COLUMN D_ITEMS.ITEMID is
   'Primary key. Identifies the charted item.';
COMMENT ON COLUMN D_ITEMS.LABEL is
   'Label identifying the item.';
COMMENT ON COLUMN D_ITEMS.ABBREVIATION is
   'Abbreviation associated with the item.';
COMMENT ON COLUMN D_ITEMS.DBSOURCE is
   'Source database of the item.';
COMMENT ON COLUMN D_ITEMS.LINKSTO is
   'Table which contains data for the given ITEMID.';
COMMENT ON COLUMN D_ITEMS.CATEGORY is
   'Category of data which the concept falls under.';
COMMENT ON COLUMN D_ITEMS.UNITNAME is
   'Unit associated with the item.';
COMMENT ON COLUMN D_ITEMS.PARAM_TYPE is
   'Type of item, for example solution or ingredient.';
COMMENT ON COLUMN D_ITEMS.CONCEPTID is
   'Identifier used to harmonize concepts identified by multiple ITEMIDs. CONCEPTIDs are planned but not yet implemented (all values are NULL).';

---------------
--D_LABITEMS--
---------------

-- Table
COMMENT ON TABLE D_LABITEMS  IS
   'Dictionary of laboratory-related items.';

-- Columns
COMMENT ON COLUMN D_LABITEMS.ROW_ID is
   'Unique row identifier.';
COMMENT ON COLUMN D_LABITEMS.ITEMID is
   'Foreign key. Identifies the charted item.';
COMMENT ON COLUMN D_LABITEMS.LABEL is
   'Label identifying the item.';
COMMENT ON COLUMN D_LABITEMS.FLUID is
   'Fluid associated with the item, for example blood or urine.';
COMMENT ON COLUMN D_LABITEMS.CATEGORY is
   'Category of item, for example chemistry or hematology.';
COMMENT ON COLUMN D_LABITEMS.LOINC_CODE is
   'Logical Observation Identifiers Names and Codes (LOINC) mapped to the item, if available.';

------------------
--DATETIMEEVENTS--
------------------

-- Table
COMMENT ON TABLE DATETIMEEVENTS IS
   'Events relating to a datetime.';

-- Columns
COMMENT ON COLUMN DATETIMEEVENTS.ROW_ID is
   'Unique row identifier.';
COMMENT ON COLUMN DATETIMEEVENTS.SUBJECT_ID is
   'Foreign key. Identifies the patient.';
COMMENT ON COLUMN DATETIMEEVENTS.HADM_ID is
   'Foreign key. Identifies the hospital stay.';
COMMENT ON COLUMN DATETIMEEVENTS.ICUSTAY_ID is
   'Foreign key. Identifies the ICU stay.';
COMMENT ON COLUMN DATETIMEEVENTS.ITEMID is
   'Foreign key. Identifies the charted item.';
COMMENT ON COLUMN DATETIMEEVENTS.CHARTTIME is
   'Time when the event occured.';
COMMENT ON COLUMN DATETIMEEVENTS.STORETIME is
   'Time when the event was recorded in the system.';
COMMENT ON COLUMN DATETIMEEVENTS.CGID is
   'Foreign key. Identifies the caregiver.';
COMMENT ON COLUMN DATETIMEEVENTS.VALUE is
   'Value of the event as a text string.';
COMMENT ON COLUMN DATETIMEEVENTS.VALUEUOM is
   'Unit of measurement.';
COMMENT ON COLUMN DATETIMEEVENTS.WARNING is
   'Flag to highlight that the value has triggered a warning.';
COMMENT ON COLUMN DATETIMEEVENTS.ERROR is
   'Flag to highlight an error with the event.';
COMMENT ON COLUMN DATETIMEEVENTS.RESULTSTATUS is
   'Result status of lab data.';
COMMENT ON COLUMN DATETIMEEVENTS.STOPPED is
   'Event was explicitly marked as stopped. Infrequently used by caregivers.';

-----------------
--DIAGNOSES_ICD--
-----------------

-- Table
COMMENT ON TABLE DIAGNOSES_ICD IS
   'Diagnoses relating to a hospital admission coded using the ICD9 system.';

-- Columns
COMMENT ON COLUMN DIAGNOSES_ICD.ROW_ID is
   'Unique row identifier.';
COMMENT ON COLUMN DIAGNOSES_ICD.SUBJECT_ID is
   'Foreign key. Identifies the patient.';
COMMENT ON COLUMN DIAGNOSES_ICD.HADM_ID is
   'Foreign key. Identifies the hospital stay.';
COMMENT ON COLUMN DIAGNOSES_ICD.SEQ_NUM is
   'Priority of the code. Sequence 1 is the primary code.';
COMMENT ON COLUMN DIAGNOSES_ICD.ICD9_CODE is
   'ICD9 code for the diagnosis.';

--------------
---DRGCODES---
--------------

-- Table
COMMENT ON TABLE DRGCODES IS
   'Hospital stays classified using the Diagnosis-Related Group system.';

-- Columns
COMMENT ON COLUMN DRGCODES.ROW_ID is
   'Unique row identifier.';
COMMENT ON COLUMN DRGCODES.SUBJECT_ID is
   'Foreign key. Identifies the patient.';
COMMENT ON COLUMN DRGCODES.HADM_ID is
   'Foreign key. Identifies the hospital stay.';
COMMENT ON COLUMN DRGCODES.DRG_TYPE is
   'Type of Diagnosis-Related Group, for example APR is All Patient Refined';
COMMENT ON COLUMN DRGCODES.DRG_CODE is
   'Diagnosis-Related Group code';
COMMENT ON COLUMN DRGCODES.DESCRIPTION is
   'Description of the Diagnosis-Related Group';
COMMENT ON COLUMN DRGCODES.DRG_SEVERITY is
   'Relative severity, available for type APR only.';
COMMENT ON COLUMN DRGCODES.DRG_MORTALITY is
   'Relative mortality, available for type APR only.';

-----------------
--ICUSTAYS--
-----------------

-- Table
COMMENT ON TABLE ICUSTAYS IS
   'List of ICU admissions.';

-- Columns
COMMENT ON COLUMN ICUSTAYS.ROW_ID is
   'Unique row identifier.';
COMMENT ON COLUMN ICUSTAYS.SUBJECT_ID is
   'Foreign key. Identifies the patient.';
COMMENT ON COLUMN ICUSTAYS.HADM_ID is
   'Foreign key. Identifies the hospital stay.';
COMMENT ON COLUMN ICUSTAYS.ICUSTAY_ID is
   'Primary key. Identifies the ICU stay.';
COMMENT ON COLUMN ICUSTAYS.DBSOURCE is
   'Source database of the item.';
COMMENT ON COLUMN ICUSTAYS.INTIME is
   'Time of admission to the ICU.';
COMMENT ON COLUMN ICUSTAYS.OUTTIME is
   'Time of discharge from the ICU.';
COMMENT ON COLUMN ICUSTAYS.LOS is
   'Length of stay in the ICU measured in fractional days.';
COMMENT ON COLUMN ICUSTAYS.FIRST_CAREUNIT is
   'First careunit associated with the ICU stay.';
COMMENT ON COLUMN ICUSTAYS.LAST_CAREUNIT is
   'Last careunit associated with the ICU stay.';
COMMENT ON COLUMN ICUSTAYS.FIRST_WARDID is
   'Identifier for the first ward the patient was located in.';
COMMENT ON COLUMN ICUSTAYS.LAST_WARDID is
   'Identifier for the last ward the patient is located in.';

-- -------------- --
-- INPUTEVENTS_CV --
-- -------------- --

-- Table
COMMENT ON TABLE INPUTEVENTS_CV IS
   'Events relating to fluid input for patients whose data was originally stored in the CareVue database.';

-- Columns
COMMENT ON COLUMN INPUTEVENTS_CV.ROW_ID is
   'Unique row identifier.';
COMMENT ON COLUMN INPUTEVENTS_CV.SUBJECT_ID is
   'Foreign key. Identifies the patient.';
COMMENT ON COLUMN INPUTEVENTS_CV.HADM_ID is
   'Foreign key. Identifies the hospital stay.';
COMMENT ON COLUMN INPUTEVENTS_CV.ICUSTAY_ID is
   'Foreign key. Identifies the ICU stay.';
COMMENT ON COLUMN INPUTEVENTS_CV.CHARTTIME is
   'Time that the input was started or received.';
COMMENT ON COLUMN INPUTEVENTS_CV.ITEMID is
   'Foreign key. Identifies the charted item.';
COMMENT ON COLUMN INPUTEVENTS_CV.AMOUNT is
   'Amount of the item administered to the patient.';
COMMENT ON COLUMN INPUTEVENTS_CV.AMOUNTUOM is
   'Unit of measurement for the amount.';
COMMENT ON COLUMN INPUTEVENTS_CV.RATE is
   'Rate at which the item is being administered to the patient.';
COMMENT ON COLUMN INPUTEVENTS_CV.RATEUOM is
   'Unit of measurement for the rate.';
COMMENT ON COLUMN INPUTEVENTS_CV.STORETIME is
   'Time when the event was recorded in the system.';
COMMENT ON COLUMN INPUTEVENTS_CV.CGID is
   'Foreign key. Identifies the caregiver.';
COMMENT ON COLUMN INPUTEVENTS_CV.ORDERID is
   'Identifier linking items which are grouped in a solution.';
COMMENT ON COLUMN INPUTEVENTS_CV.LINKORDERID is
   'Identifier linking orders across multiple administrations. LINKORDERID is always equal to the first occuring ORDERID of the series.';
COMMENT ON COLUMN INPUTEVENTS_CV.STOPPED is
   'Event was explicitly marked as stopped. Infrequently used by caregivers.';
COMMENT ON COLUMN INPUTEVENTS_CV.NEWBOTTLE is
   'Indicates when a new bottle of the solution was hung at the bedside.';
COMMENT ON COLUMN INPUTEVENTS_CV.ORIGINALAMOUNT is
   'Amount of the item which was originally charted.';
COMMENT ON COLUMN INPUTEVENTS_CV.ORIGINALAMOUNTUOM is
   'Unit of measurement for the original amount.';
COMMENT ON COLUMN INPUTEVENTS_CV.ORIGINALROUTE is
   'Route of administration originally chosen for the item.';
COMMENT ON COLUMN INPUTEVENTS_CV.ORIGINALRATE is
   'Rate of administration originally chosen for the item.';
COMMENT ON COLUMN INPUTEVENTS_CV.ORIGINALRATEUOM is
   'Unit of measurement for the rate originally chosen.';
COMMENT ON COLUMN INPUTEVENTS_CV.ORIGINALSITE is
   'Anatomical site for the original administration of the item.';

----------------- --
-- INPUTEVENTS_MV --
----------------- --

-- Table
COMMENT ON TABLE INPUTEVENTS_MV IS
   'Events relating to fluid input for patients whose data was originally stored in the MetaVision database.';

-- Columns
COMMENT ON COLUMN INPUTEVENTS_MV.ROW_ID is
  'Unique row identifier.';
COMMENT ON COLUMN INPUTEVENTS_MV.SUBJECT_ID is
  'Foreign key. Identifies the patient.';
COMMENT ON COLUMN INPUTEVENTS_MV.HADM_ID is
  'Foreign key. Identifies the hospital stay.';
COMMENT ON COLUMN INPUTEVENTS_MV.ICUSTAY_ID is
  'Foreign key. Identifies the ICU stay.';
COMMENT ON COLUMN INPUTEVENTS_MV.STARTTIME is
  'Time when the event started.';
COMMENT ON COLUMN INPUTEVENTS_MV.ENDTIME is
  'Time when the event ended.';
COMMENT ON COLUMN INPUTEVENTS_MV.ITEMID is
  'Foreign key. Identifies the charted item.';
COMMENT ON COLUMN INPUTEVENTS_MV.AMOUNT is
  'Amount of the item administered to the patient.';
COMMENT ON COLUMN INPUTEVENTS_MV.AMOUNTUOM is
  'Unit of measurement for the amount.';
COMMENT ON COLUMN INPUTEVENTS_MV.RATE is
  'Rate at which the item is being administered to the patient.';
COMMENT ON COLUMN INPUTEVENTS_MV.RATEUOM is
  'Unit of measurement for the rate.';
COMMENT ON COLUMN INPUTEVENTS_MV.STORETIME is
  'Time when the event was recorded in the system.';
COMMENT ON COLUMN INPUTEVENTS_MV.CGID is
  'Foreign key. Identifies the caregiver.';
COMMENT ON COLUMN INPUTEVENTS_MV.ORDERID is
  'Identifier linking items which are grouped in a solution.';
COMMENT ON COLUMN INPUTEVENTS_MV.LINKORDERID is
  'Identifier linking orders across multiple administrations. LINKORDERID is always equal to the first occuring ORDERID of the series.';
COMMENT ON COLUMN INPUTEVENTS_MV.ORDERCATEGORYNAME is
  'A group which the item corresponds to.';
COMMENT ON COLUMN INPUTEVENTS_MV.SECONDARYORDERCATEGORYNAME is
  'A secondary group for those items with more than one grouping possible.';
COMMENT ON COLUMN INPUTEVENTS_MV.ORDERCOMPONENTTYPEDESCRIPTION is
  'The role of the item administered in the order.';
COMMENT ON COLUMN INPUTEVENTS_MV.ORDERCATEGORYDESCRIPTION is
  'The type of item administered.';
COMMENT ON COLUMN INPUTEVENTS_MV.PATIENTWEIGHT is
  'For drugs dosed by weight, the value of the weight used in the calculation.';
COMMENT ON COLUMN INPUTEVENTS_MV.TOTALAMOUNT is
  'The total amount in the solution for the given item.';
COMMENT ON COLUMN INPUTEVENTS_MV.TOTALAMOUNTUOM is
  'Unit of measurement for the total amount in the solution.';
COMMENT ON COLUMN INPUTEVENTS_MV.ISOPENBAG is
  'Indicates whether the bag containing the solution is open.';
COMMENT ON COLUMN INPUTEVENTS_MV.CONTINUEINNEXTDEPT is
  'Indicates whether the item will be continued in the next department where the patient is transferred to.';
COMMENT ON COLUMN INPUTEVENTS_MV.CANCELREASON is
  'Reason for cancellation, if cancelled.';
COMMENT ON COLUMN INPUTEVENTS_MV.STATUSDESCRIPTION is
  'The current status of the order: stopped, rewritten, running or cancelled.';
COMMENT ON COLUMN INPUTEVENTS_MV.COMMENTS_EDITEDBY is
  'The title of the caregiver who edited the order.';
COMMENT ON COLUMN INPUTEVENTS_MV.COMMENTS_CANCELEDBY is
  'The title of the caregiver who canceled the order.';
COMMENT ON COLUMN INPUTEVENTS_MV.COMMENTS_DATE is
  'Time at which the caregiver edited or cancelled the order.';
COMMENT ON COLUMN INPUTEVENTS_MV.ORIGINALAMOUNT is
  'Amount of the item which was originally charted.';
COMMENT ON COLUMN INPUTEVENTS_MV.ORIGINALRATE is
  'Rate of administration originally chosen for the item.';

-------------
--LABEVENTS--
-------------

-- Table
COMMENT ON TABLE LABEVENTS IS
   'Events relating to laboratory tests.';

-- Columns
COMMENT ON COLUMN LABEVENTS.ROW_ID is
   'Unique row identifier.';
COMMENT ON COLUMN LABEVENTS.SUBJECT_ID is
   'Foreign key. Identifies the patient.';
COMMENT ON COLUMN LABEVENTS.HADM_ID is
   'Foreign key. Identifies the hospital stay.';
COMMENT ON COLUMN LABEVENTS.ITEMID is
   'Foreign key. Identifies the charted item.';
COMMENT ON COLUMN LABEVENTS.CHARTTIME is
   'Time when the event occured.';
COMMENT ON COLUMN LABEVENTS.VALUE is
   'Value of the event as a text string.';
COMMENT ON COLUMN LABEVENTS.VALUENUM is
   'Value of the event as a number.';
COMMENT ON COLUMN LABEVENTS.VALUEUOM is
   'Unit of measurement.';
COMMENT ON COLUMN LABEVENTS.FLAG is
   'Flag indicating whether the lab test value is considered abnormal (null if the test was normal).';

----------------------
--MICROBIOLOGYEVENTS--
----------------------

-- Table
COMMENT ON TABLE MICROBIOLOGYEVENTS IS
   'Events relating to microbiology tests.';

-- Columns
COMMENT ON COLUMN MICROBIOLOGYEVENTS.ROW_ID is
   'Unique row identifier.';
COMMENT ON COLUMN MICROBIOLOGYEVENTS.SUBJECT_ID is
   'Foreign key. Identifies the patient.';
COMMENT ON COLUMN MICROBIOLOGYEVENTS.HADM_ID is
   'Foreign key. Identifies the hospital stay.';
COMMENT ON COLUMN MICROBIOLOGYEVENTS.CHARTDATE is
   'Date when the event occured.';
COMMENT ON COLUMN MICROBIOLOGYEVENTS.CHARTTIME is
   'Time when the event occured, if available.';
COMMENT ON COLUMN MICROBIOLOGYEVENTS.SPEC_ITEMID is
   'Foreign key. Identifies the specimen.';
COMMENT ON COLUMN MICROBIOLOGYEVENTS.SPEC_TYPE_DESC is
   'Description of the specimen.';
COMMENT ON COLUMN MICROBIOLOGYEVENTS.ORG_ITEMID is
   'Foreign key. Identifies the organism.';
COMMENT ON COLUMN MICROBIOLOGYEVENTS.ORG_NAME is
   'Name of the organism.';
COMMENT ON COLUMN MICROBIOLOGYEVENTS.ISOLATE_NUM is
   'Isolate number associated with the test.';
COMMENT ON COLUMN MICROBIOLOGYEVENTS.AB_ITEMID is
   'Foreign key. Identifies the antibody.';
COMMENT ON COLUMN MICROBIOLOGYEVENTS.AB_NAME is
   'Name of the antibody used.';
COMMENT ON COLUMN MICROBIOLOGYEVENTS.DILUTION_TEXT is
   'The dilution amount tested for and the comparison which was made against it (e.g. <=4).';
COMMENT ON COLUMN MICROBIOLOGYEVENTS.DILUTION_COMPARISON is
   'The comparison component of DILUTION_TEXT: either <= (less than or equal), = (equal), or >= (greater than or equal), or null when not available.';
COMMENT ON COLUMN MICROBIOLOGYEVENTS.DILUTION_VALUE is
   'The value component of DILUTION_TEXT: must be a floating point number.';
COMMENT ON COLUMN MICROBIOLOGYEVENTS.INTERPRETATION is
   'Interpretation of the test.';

--------------
--NOTEEVENTS--
--------------

-- Table
COMMENT ON TABLE NOTEEVENTS IS
   'Notes associated with hospital stays.';

-- Columns
COMMENT ON COLUMN NOTEEVENTS.ROW_ID is
   'Unique row identifier.';
COMMENT ON COLUMN NOTEEVENTS.SUBJECT_ID is
   'Foreign key. Identifies the patient.';
COMMENT ON COLUMN NOTEEVENTS.HADM_ID is
   'Foreign key. Identifies the hospital stay.';
COMMENT ON COLUMN NOTEEVENTS.CHARTDATE is
   'Date when the note was charted.';
COMMENT ON COLUMN NOTEEVENTS.CHARTTIME is
   'Date and time when the note was charted. Note that some notes (e.g. discharge summaries) do not have a time associated with them: these notes have NULL in this column.';
COMMENT ON COLUMN NOTEEVENTS.CATEGORY is
   'Category of the note, e.g. Discharge summary.';
COMMENT ON COLUMN NOTEEVENTS.DESCRIPTION is
   'A more detailed categorization for the note, sometimes entered by free-text.';
COMMENT ON COLUMN NOTEEVENTS.CGID is
   'Foreign key. Identifies the caregiver.';
COMMENT ON COLUMN NOTEEVENTS.ISERROR is
   'Flag to highlight an error with the note.';
COMMENT ON COLUMN NOTEEVENTS.TEXT is
   'Content of the note.';

------------
--PATIENTS--
------------

-- Table
COMMENT ON TABLE OUTPUTEVENTS IS
   'Outputs recorded during the ICU stay.';

-- Columns
COMMENT ON COLUMN OUTPUTEVENTS.ROW_ID is
  'Unique row identifier.';
COMMENT ON COLUMN OUTPUTEVENTS.SUBJECT_ID is
  'Foreign key. Identifies the patient.';
COMMENT ON COLUMN OUTPUTEVENTS.HADM_ID is
  'Foreign key. Identifies the hospital stay.';
COMMENT ON COLUMN OUTPUTEVENTS.ICUSTAY_ID is
  'Foreign key. Identifies the ICU stay.';
COMMENT ON COLUMN OUTPUTEVENTS.CHARTTIME is
  'Time when the output was recorded/occurred.';
COMMENT ON COLUMN OUTPUTEVENTS.ITEMID is
  'Foreign key. Identifies the charted item.';
COMMENT ON COLUMN OUTPUTEVENTS.VALUE is
  'Value of the event as a float.';
COMMENT ON COLUMN OUTPUTEVENTS.VALUEUOM is
  'Unit of measurement.';
COMMENT ON COLUMN OUTPUTEVENTS.STORETIME is
  'Time when the event was recorded in the system.';
COMMENT ON COLUMN OUTPUTEVENTS.CGID is
  'Foreign key. Identifies the caregiver.';
COMMENT ON COLUMN OUTPUTEVENTS.STOPPED is
  'Event was explicitly marked as stopped. Infrequently used by caregivers.';
COMMENT ON COLUMN OUTPUTEVENTS.NEWBOTTLE is
  'Not applicable to outputs - column always null.';
COMMENT ON COLUMN OUTPUTEVENTS.ISERROR is
  'Flag to highlight an error with the measurement.';

------------
--PATIENTS--
------------

-- Table
COMMENT ON TABLE PATIENTS IS
   'Patients associated with an admission to the ICU.';

-- Columns
COMMENT ON COLUMN PATIENTS.ROW_ID is
   'Unique row identifier.';
COMMENT ON COLUMN PATIENTS.SUBJECT_ID is
   'Primary key. Identifies the patient.';
COMMENT ON COLUMN PATIENTS.GENDER is
   'Gender.';
COMMENT ON COLUMN PATIENTS.DOB is
   'Date of birth.';
COMMENT ON COLUMN PATIENTS.DOD is
   'Date of death. Null if the patient was alive at least 90 days post hospital discharge.';
COMMENT ON COLUMN PATIENTS.DOD_HOSP is
   'Date of death recorded in the hospital records.';
COMMENT ON COLUMN PATIENTS.DOD_SSN is
   'Date of death recorded in the social security records.';
COMMENT ON COLUMN PATIENTS.EXPIRE_FLAG is
   'Flag indicating that the patient has died.';

----------------------
--PROCEDUREEVENTS_MV--
----------------------


COMMENT ON TABLE PROCEDUREEVENTS_MV IS
   'Procedure start and stop times recorded for MetaVision patients.';

-----------------
--PRESCRIPTIONS--
-----------------

-- Table
COMMENT ON TABLE PRESCRIPTIONS IS
   'Medicines prescribed.';

-- Columns
COMMENT ON COLUMN PRESCRIPTIONS.ROW_ID is
   'Unique row identifier.';
COMMENT ON COLUMN PRESCRIPTIONS.SUBJECT_ID is
   'Foreign key. Identifies the patient.';
COMMENT ON COLUMN PRESCRIPTIONS.HADM_ID is
   'Foreign key. Identifies the hospital stay.';
COMMENT ON COLUMN PRESCRIPTIONS.ICUSTAY_ID is
   'Foreign key. Identifies the ICU stay.';
COMMENT ON COLUMN PRESCRIPTIONS.STARTDATE is
   'Date when the prescription started.';
COMMENT ON COLUMN PRESCRIPTIONS.ENDDATE is
   'Date when the prescription ended.';
COMMENT ON COLUMN PRESCRIPTIONS.DRUG_TYPE is
   'Type of drug.';
COMMENT ON COLUMN PRESCRIPTIONS.DRUG is
   'Name of the drug.';
COMMENT ON COLUMN PRESCRIPTIONS.DRUG_NAME_POE is
   'Name of the drug on the Provider Order Entry interface.';
COMMENT ON COLUMN PRESCRIPTIONS.DRUG_NAME_GENERIC is
   'Generic drug name.';
COMMENT ON COLUMN PRESCRIPTIONS.FORMULARY_DRUG_CD is
   'Formulary drug code.';
COMMENT ON COLUMN PRESCRIPTIONS.GSN is
   'Generic Sequence Number.';
COMMENT ON COLUMN PRESCRIPTIONS.NDC is
   'National Drug Code.';
COMMENT ON COLUMN PRESCRIPTIONS.PROD_STRENGTH is
   'Strength of the drug (product).';
COMMENT ON COLUMN PRESCRIPTIONS.DOSE_VAL_RX is
   'Dose of the drug prescribed.';
COMMENT ON COLUMN PRESCRIPTIONS.DOSE_UNIT_RX is
   'Unit of measurement associated with the dose.';
COMMENT ON COLUMN PRESCRIPTIONS.FORM_VAL_DISP is
   'Amount of the formulation dispensed.';
COMMENT ON COLUMN PRESCRIPTIONS.FORM_UNIT_DISP is
   'Unit of measurement associated with the formulation.';
COMMENT ON COLUMN PRESCRIPTIONS.ROUTE is
   'Route of administration, for example intravenous or oral.';

------------------
--PROCEDURES_ICD--
------------------

-- Table
COMMENT ON TABLE PROCEDURES_ICD IS
   'Procedures relating to a hospital admission coded using the ICD9 system.';

-- Columns
COMMENT ON COLUMN PROCEDURES_ICD.ROW_ID is
   'Unique row identifier.';
COMMENT ON COLUMN PROCEDURES_ICD.SUBJECT_ID is
   'Foreign key. Identifies the patient.';
COMMENT ON COLUMN PROCEDURES_ICD.HADM_ID is
   'Foreign key. Identifies the hospital stay.';
COMMENT ON COLUMN PROCEDURES_ICD.SEQ_NUM is
   'Lower procedure numbers occurred earlier.';
COMMENT ON COLUMN PROCEDURES_ICD.ICD9_CODE is
   'ICD9 code associated with the procedure.';

------------
--SERVICES--
------------

-- Table
COMMENT ON TABLE SERVICES IS
  'Hospital services that patients were under during their hospital stay.';

-- Columns
COMMENT ON COLUMN SERVICES.ROW_ID is
   'Unique row identifier.';
COMMENT ON COLUMN SERVICES.SUBJECT_ID is
   'Foreign key. Identifies the patient.';
COMMENT ON COLUMN SERVICES.HADM_ID is
   'Foreign key. Identifies the hospital stay.';
COMMENT ON COLUMN SERVICES.TRANSFERTIME is
   'Time when the transfer occured.';
COMMENT ON COLUMN SERVICES.PREV_SERVICE is
   'Previous service type.';
COMMENT ON COLUMN SERVICES.CURR_SERVICE is
   'Current service type.';

-------------
--TRANSFERS--
-------------

-- Table
COMMENT ON TABLE TRANSFERS IS
   'Location of patients during their hospital stay.';

-- Columns
COMMENT ON COLUMN TRANSFERS.ROW_ID is
   'Unique row identifier.';
COMMENT ON COLUMN TRANSFERS.SUBJECT_ID is
   'Foreign key. Identifies the patient.';
COMMENT ON COLUMN TRANSFERS.HADM_ID is
   'Foreign key. Identifies the hospital stay.';
COMMENT ON COLUMN TRANSFERS.ICUSTAY_ID is
   'Foreign key. Identifies the ICU stay.';
COMMENT ON COLUMN TRANSFERS.DBSOURCE is
   'Source database of the item.';
COMMENT ON COLUMN TRANSFERS.EVENTTYPE is
   'Type of event, for example admission or transfer.';
COMMENT ON COLUMN TRANSFERS.PREV_WARDID is
   'Identifier for the previous ward the patient was located in.';
COMMENT ON COLUMN TRANSFERS.CURR_WARDID is
   'Identifier for the current ward the patient is located in.';
COMMENT ON COLUMN TRANSFERS.PREV_CAREUNIT is
   'Previous careunit.';
COMMENT ON COLUMN TRANSFERS.CURR_CAREUNIT is
   'Current careunit.';
COMMENT ON COLUMN TRANSFERS.INTIME is
   'Time when the patient was transferred into the unit.';
COMMENT ON COLUMN TRANSFERS.OUTTIME is
   'Time when the patient was transferred out of the unit.';
COMMENT ON COLUMN TRANSFERS.LOS is
   'Length of stay in the unit in minutes.';
