ALTER SESSION SET NLS_DATE_FORMAT = 'DD/MM/YYYY';
SET LINESIZE 150
SET PAGESIZE 120
SET VERIFY OFF

ACCEPT v_centreID CHAR FORMAT 'A6' PROMPT 'Enter the centreID(CXXXXXX):'

TTITLE COL 17 _DATE  CENTER 'DETAILED REPORT OF WORKLOAD MANAGEMENT ON CENTRE &v_centreID'-
COL 131 'Page:' FORMAT 9 SQL.PNO SKIP 1- 
CENTER ======================================================= SKIP 3

COLUMN DUMMY                HEADING ''               FORMAT 'A15'
COLUMN centreID             HEADING 'Centre ID'      FORMAT 'A10'
COLUMN name                 HEADING "Centre Name"    FORMAT 'A40'
COLUMN position             HEADING "Staff Position" FORMAT 'A20'
COLUMN workingHour          HEADING "Working Hour"   FORMAT 'A30'
COLUMN qty                  HEADING "Assigned Quantity"

BREAK ON centreID SKIP 2 ON name ON position SKIP 2
COMPUTE SUM LABEL 'TOTAL:' OF qty ON position
COMPUTE SUM LABEL 'TOTAL:' OF qty ON name

cl scr

SELECT '' DUMMY, W.centreID, C.name, position, workingHour, COUNT(W.staffID) AS Qty
FROM WorkloadManageMent W, Staff S, Centre C
WHERE W.staffID = S.staffID AND W.centreID = C.centreID AND W.centreID = '&v_centreID'
GROUP BY W.centreID, C.name, position, workingHour
ORDER BY centreID, position;

CLEAR COLUMNS;
CLEAR BREAKS;
CLEAR COMPUTES;
TTITLE OFF;
CLEAR COL;