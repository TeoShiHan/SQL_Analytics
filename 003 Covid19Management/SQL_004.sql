ALTER SESSION SET NLS_DATE_FORMAT = 'DD/MM/YYYY';
SET LINESIZE 150
SET PAGESIZE 120
SET SPACE 2
SET VERIFY OFF

ACCEPT v_startDate  date FORMAT 'DD/MM/YYYY' PROMPT 'Enter starting date (dd/mm/yyyy) : '
ACCEPT v_endDate    date FORMAT 'DD/MM/YYYY' PROMPT 'Enter ending date   (dd/mm/yyyy) : '

CREATE OR REPLACE VIEW EstimateInfectionDate AS
SELECT patientID, admissionDate, name,
	CASE 
		WHEN condition LIKE 'no symptom'     THEN admissionDate - 7
		WHEN condition LIKE 'mild symptom'   THEN admissionDate - 14
		WHEN condition LIKE 'dyspnea' 		 THEN admissionDate - 21
		WHEN condition LIKE 'pneumonia'      THEN admissionDate - 23
		ELSE admissionDate - 33
	END estimatedInfectionDate
FROM Admission A, Centre C
WHERE A.centreID = C.centreID AND
	  condition NOT IN('dead','discharged');

CREATE OR REPLACE VIEW finalAdmission AS
SELECT patientID, admissionDate, condition
FROM(
	SELECT admissionDate,patientID,condition,ROW_NUMBER() OVER(PARTITION BY patientID ORDER By admissionDate)  rn
	FROM Admission 
	WHERE condition LIKE 'dead' OR condition LIKE 'discharged'
)a
WHERE rn = 1
UNION 
--dealing with missing data
SELECT patientID, admissionDate + 28, condition
FROM(
	SELECT admissionDate, patientID,condition,ROW_NUMBER() OVER(PARTITION BY patientID ORDER By admissionDate DESC)  rn2
	FROM Admission
	WHERE patientID NOT IN (SELECT patientID
				FROM(
    				SELECT admissionDate,patientID,condition,ROW_NUMBER() OVER(PARTITION BY patientID ORDER By admissionDate)  rn
				FROM Admission 
				WHERE condition LIKE 'dead' OR condition LIKE 'discharged'
				)a
				WHERE rn = 1)
)b
WHERE rn2 = 1
ORDER BY patientID;

CREATE OR REPLACE VIEW EstInfectionAndFinal AS
	SELECT E.patientID, E.admissionDate, E.name,E.estimatedInfectionDate, F.admissionDate AS finalAdmission
	FROM EstimateInfectionDate E, finalAdmission F
	WHERE E.patientID = F.patientID;


TTITLE COL 12 _DATE CENTER 'REPORT OF HIGH RISK CLINICS AND VACCINATION CENTER FROM &v_startDate to &v_endDate'-
RIGHT 'Page:' FORMAT 9 SQL.PNO SKIP 1-
CENTER ============================================================================ SKIP 2-

COLUMN c1 HEADING "Centre ID"       FORMAT A9
COLUMN c2 HEADING "Centre Name"     FORMAT A30 TRUNC
COLUMN c3 HEADING "PatientID"       FORMAT A9
COLUMN c4 HEADING "Patient Name"    FORMAT A20 TRUNC
COLUMN c5 HEADING "Vaccination"     FORMAT A11
COLUMN c6 HEADING "EstInfection"    FORMAT A12
COLUMN c7 HEADING "Final Admission" FORMAT A15
COLUMN c8 HEADING "Hospital Name" FORMAT A30 TRUNC

BREAK ON c1 ON c2 SKIP 2 ON c3 ON c4 ON c5
COMPUTE NUMBER LABEL 'Admission derived Threat:' OF c7 ON c2

cl scr

SELECT
  V.centreID c1,
  C.name c2, 
  V.patientID c3, 
  P.name c4, 
  vaccinationDate c5, 
  estimatedInfectionDate c6, 
  finalAdmission c7,
  E.name c8
FROM 
   Vaccination V,
   Centre C,
   EstInfectionAndFinal E,
   Patient P
WHERE V.centreID = C.centreID   AND
   E.patientID = V.patientID 	AND
   V.patientID = P.patientID    AND
   V.patientID IN (SELECT DISTINCT patientID FROM Admission) AND
   vaccinationDate BETWEEN to_date(estimatedInfectionDate) AND to_date(finalAdmission) AND
   vaccinationDate BETWEEN '&v_startDate' AND '&v_endDate' AND
   type != 'hospital'
ORDER BY V.centreID, vaccinationDate, estimatedInfectionDate, finalAdmission;


CLEAR COLUMNS;
CLEAR BREAKS;
CLEAR COMPUTES;
TTITLE OFF;