-- Most demanded treatment for pet category
ALTER SESSION SET NLS_DATE_FORMAT = 'DD/MM/YYYY';
SET LINESIZE 150
SET PAGESIZE 200


--view for data summarization
CREATE OR replace view petRevenueSummary AS WITH RevenueByPet AS
(
   SELECT
      p.pet_type,
      tsk.type,
      tsk.description,
      tsk.price,
      COUNT(tsk.type)*tsk.price AS RevenueByTreatment 
   FROM
      pet p,
      treatment TREAT,
      task tsk 
   WHERE
      p.pet_id = TREAT.pet_id 
      AND tsk.task_id = TREAT.task_id 
      AND tsk.type IN
      (
         'counselling',
         'diagnosis',
         'surgery' 
      )
   GROUP BY
      p.pet_type,
      tsk.type,
      tsk.description,
      tsk.price 
)
,
TotalRevenueByPet AS
(
   SELECT
      pet_type,
      SUM(RevenueByTreatment) AS Total_Revenue 
   FROM
      RevenueByPet 
   GROUP BY
      pet_type 
)
SELECT
   revByPet.pet_type,
   revByPet.type,
   revByPet.description,
   revByPet.price,
   revByPet.RevenueByTreatment,
   tRev.Total_Revenue 
FROM
   TotalRevenueByPet tRev,
   RevenueByPet revByPet 
WHERE
   tRev.pet_type = revByPet.pet_type;
CREATE OR replace view top5DemandedPetTreatment AS WITH Treatment_Qty AS
(
   SELECT
      p.pet_type,
      tsk.type,
      tsk.description,
      tsk.price,
      COUNT(tsk.description) AS TotalTreatmentQty,
      ROW_NUMBER () OVER ( PARTITION BY p.pet_type 
   ORDER BY
      COUNT(tsk.description) DESC, tsk.price DESC ) RANK 
   FROM
      pet p,
      treatment TREAT,
      task tsk 
   WHERE
      p.pet_id = TREAT.pet_id 
      AND tsk.task_id = TREAT.task_id 
      AND tsk.type IN
      (
         'counselling',
         'diagnosis',
         'surgery' 
      )
   GROUP BY
      p.pet_type,
      tsk.type,
      tsk.description,
      tsk.price 
)
SELECT
   tq.* 
FROM
   Treatment_Qty tq 
WHERE
   RANK <= 5;

cl scr
TTITLE _DATE LEFT col 30 'Most demanded treatment for pet category'-
COL 99 'Page:' FORMAT 9 SQL.PNO SKIP 1-
LEFT LEFT col 30 ======================================== SKIP 2 -

COLUMN PET_TYPE           HEADING "Pet Category"      FORMAT A13
COLUMN TYPE               HEADING "Treatment Type"    FORMAT A15
COLUMN DESCRIPTION        HEADING "Treatment"         FORMAT A18
COLUMN TOTALTREATMENTQTY  HEADING "Applied Qty"       FORMAT 999
COLUMN RANK               HEADING "Rank"              FORMAT 9
COLUMN CHARGE             HEADING "Charge(RM)"        FORMAT 9990.99
COLUMN REVENUEBYTREATMENT HEADING "Revenue(RM)"       FORMAT 99990.99
COLUMN REVNUE_SHARE       HEADING "Revenue Share(%)"  FORMAT 99990.99 TRUNC

BREAK ON PET_TYPE SKIP 2;
COMPUTE SUM LABEL 'TOTAL: ' of REVENUEBYTREATMENT ON PET_TYPE;
COMPUTE SUM LABEL 'TOTAL: ' of REVNUE_SHARE ON PET_TYPE;

cl scr;

SELECT
   top5.pet_type,
   top5.type,
   top5.description,
   top5.TotalTreatmentQty,
   top5.RANK,
   rev.price,
   rev.RevenueByTreatment,
   ((rev.RevenueByTreatment / rev.Total_Revenue)*100)
   AS revnue_share 
FROM
   top5DemandedPetTreatment top5,
   petRevenueSummary rev 
WHERE
   top5.pet_type = rev.pet_type 
   AND top5.type = rev.type 
   AND top5.description = rev.description 
ORDER BY
   pet_type,
   RANK;


CLEAR COLUMNS;
CLEAR BREAKS;
CLEAR COMPUTES;
TTITLE OFF;
CLEAR COL;