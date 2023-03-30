-- Job Application based on different source
ALTER SESSION SET NLS_DATE_FORMAT='DD/MM/YYYY';

ACCEPT v_start_date date  FORMAT 'DD/MM/YYYY'- 
PROMPT 'Enter the starting date (DD/MM/YYYY):'
ACCEPT v_endt_date date  FORMAT 'DD/MM/YYYY'-
PROMPT 'Enter the appointment date (DD/MM/YYYY):'

cl scr
TTITLE _DATE LEFT col 30 -
'Application based on different source from '-
'&v_start_date to &v_endt_date'-
COL 99 'Page:' FORMAT 9 SQL.PNO SKIP 1-
LEFT LEFT col 30 ========================================== -
                 ================================== SKIP 2 -

COLUMN TYPE              HEADING "Job Type"          FORMAT A10
COLUMN POSITION_ID       HEADING "Job ID"            FORMAT A15
COLUMN TITLE             HEADING "Job Title"         FORMAT A30
COLUMN DEMAND            HEADING "Job Demand"        FORMAT 99
COLUMN METHOD            HEADING "Source"            FORMAT A30
COLUMN TOTAL_APPLICATION HEADING "Total Application" FORMAT 9990

BREAK ON TYPE SKIP 2 ON POSITION_ID SKIP 1 ON TITLE SKIP ON DEMAND SKIP 1
COMPUTE SUM LABEL 'Total: ' OF TOTAL_APPLICATION ON TYPE
COMPUTE SUM LABEL 'Total: ' OF TOTAL_APPLICATION ON POSITION_ID


SELECT
   pos.type,
   pos.position_id,
   pos.title,
   pos.demand,
   app.METHOD,
   COUNT(pos.title) AS total_application 
FROM
   POSITION pos,
   application app 
WHERE
   pos.position_id = app.position_id 
GROUP BY
   pos.type,
   pos.position_id,
   pos.title,
   pos.demand,
   app.METHOD 
ORDER BY
   pos.type,
   pos.title;


CLEAR COLUMNS;
CLEAR BREAKS;
CLEAR COMPUTES;
TTITLE OFF;
CLEAR COL;