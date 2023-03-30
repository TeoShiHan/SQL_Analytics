ALTER SESSION SET NLS_DATE_FORMAT = 'DD/MM/YYYY';
SET LINESIZE 150
SET PAGESIZE 200

ACCEPT v_startDate  date FORMAT 'DD/MM/YYYY' PROMPT 'Enter starting date (dd/mm/yyyy) : '
ACCEPT v_endDate    date FORMAT 'DD/MM/YYYY' PROMPT 'Enter ending date   (dd/mm/yyyy) : '

--VIEW FOR PATIENT AGE AND AGE GROUP
CREATE OR REPLACE VIEW PatientAgeGroup AS
SELECT patientID,age,
	CASE 
		WHEN age BETWEEN 0 AND 4     THEN 'baby        (00 - 04)'
		WHEN age >= 5  AND age <= 8  THEN 'children    (05 - 18)'
		WHEN age BETWEEN 9 AND 17    THEN 'teenages    (09 - 17)'
		WHEN age BETWEEN 18 AND 30   THEN 'young adult (18 - 30)'
		WHEN age BETWEEN 31 AND 60   THEN 'middle age  (31 - 60)'
		ELSE 'senior      (>60)' 
	END ageGroup
FROM (SELECT patientID, TRUNC((SYSDATE - dateOfBirth) / 365.25) AS age 
      FROM Patient) PatientAge;

--VIEW FOR DEATH AGE GROUP
CREATE OR REPLACE VIEW DeathAgeGroup AS
SELECT AgeGroup, COUNT(AgeGroup) AS reportedDeath
FROM PatientAgeGroup P, Admission A
WHERE P.patientID = A.patientID AND condition = 'dead' AND admissionDate BETWEEN '&v_startDate' AND '&v_endDate'
GROUP BY AgeGroup;

--VIEW FOR POSITIVE AGE GROUP
CREATE OR REPLACE VIEW PositiveAgeGroup AS
SELECT AgeGroup, COUNT(AgeGroup) AS reportedPositive
FROM PatientAgeGroup P, MedicalExam M
WHERE P.patientID = M.patientID AND testResult = 'P' AND examDate BETWEEN '&v_startDate' AND '&v_endDate'
GROUP BY AgeGroup;

cl scr
TTITLE COL 12 _DATE  CENTER 'REPORT OF COVID-19 POSITIVE CASE AND DEATH BASED ON 6 AGE GROUP FROM &v_startDate to &v_endDate'-
RIGHT 'Page:' FORMAT 9 SQL.PNO SKIP 1- 
CENTER ========================================================================================== SKIP 2 -


COLUMN DUMMY                HEADING ''
COLUMN ageGroup             HEADING "Age Group"     FORMAT A35 JUSTIFY RIGHT
COLUMN reportedPositive     HEADING "Positive"
COLUMN percentageOfPositive HEADING "Percentage(%)" FORMAT 990.99
COLUMN reportedDeath        HEADING "Death"         FORMAT 9999
COLUMN percentageOfDeath    HEADING "Percentage(%)" FORMAT 990.99
COLUMN DUMMY2 HEADING ''

BREAK ON REPORT;
COMPUTE SUM LABEL '               TOTAL:' OF reportedPositive reportedDeath ON REPORT;

SELECT '                     ' DUMMY, 
       LPAD(PAG.AgeGroup,35,' ') AS ageGroup,
       reportedPositive, 
	   ((reportedPositive / (SELECT SUM(reportedPositive) FROM PositiveAgeGroup)) * 100) AS percentageOfPositive,
	   reportedDeath, 
	   ((reportedDeath / (SELECT SUM(reportedDeath) FROM DeathAgeGroup)) * 100) AS percentageOfDeath,
	   '                                        ' DUMMY2
FROM PositiveAgeGroup PAG, DeathAgeGroup DAG
WHERE PAG.AgeGroup = DAG.AgeGroup
ORDER BY reportedPositive DESC ,reportedDeath DESC;

CLEAR COLUMNS;
CLEAR BREAKS;
CLEAR COMPUTES;
TTITLE OFF;
CLEAR COL;