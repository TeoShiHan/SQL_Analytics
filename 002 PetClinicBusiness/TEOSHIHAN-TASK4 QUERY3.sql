-- Check for available appointment based on doctor's working hour and appointment slot
ALTER SESSION SET NLS_DATE_FORMAT='DD/MM/YYYY';

ACCEPT v_appointment_date date  FORMAT 'DD/MM/YYYY'- 
PROMPT 'Enter the appointment date (DD/MM/YYYY):'
ACCEPT v_appointment_time date  FORMAT 'HH24:MI'-
PROMPT 'Enter the appointment time (hh:MM):'

cl scr
TTITLE _DATE LEFT col 40 'Available appointment- 
in &v_appointment_date &v_appointment_time'-
COL 115 'Page:' FORMAT 9 SQL.PNO SKIP 1-
LEFT LEFT col 40 ========================================= SKIP 2 -

COLUMN NAME               HEADING "Doctor Name"             FORMAT A20
COLUMN TITLE              HEADING "Medical Specialists"     FORMAT A27
COLUMN MOBILE             HEADING "Mobile No."              FORMAT A16
COLUMN EMAIL              HEADING "Email Address"           FORMAT A35
COLUMN SHIFT              HEADING "Working Hour"            FORMAT A13
COLUMN SCHEDULE           HEADING "Others appointed slot"   FORMAT 9990.99


CREATE 
OR replace view have_shift_on_day AS 
SELECT
   emp.employee_id,
   mobile,
   email,
   gender,
   name,
   title,
   starting_weekday,
   ending_weekday,
   to_char(starting_time, 'hh24:mi') AS starting_time,
   to_char(ending_time, 'hh24:mi') AS ending_time 
FROM
   employee emp,
   POSITION pos,
   workloadManagement wm 
WHERE
   emp.position_id = pos.position_id 
   AND emp.employee_id = wm.employee_id 
   AND UPPER(type) = 'DOCTOR' 
   AND to_char(CAST('&v_appointment_date' AS DATE), 'D') 
   BETWEEN starting_weekday AND ending_weekday 
   AND to_char(to_date('&v_appointment_time', 'hh24:mi'), 'sssss')
   BETWEEN to_char(starting_time, 'sssss') 
   AND to_char(ending_time, 'sssss') - 5400 WITH read ONLY;
WITH appointed_doctor_on_day AS
(
   SELECT
      employee_id,
      appointment_date,
      appointment_time,
      to_char((to_date(appointment_time, 'HH24:MI') + 1.5 / 24), 'hh24:mi') 
      AS expected_end 
   FROM
      appointment 
   WHERE
      (
         to_char(to_date('&v_appointment_time', 'hh24:mi'), 'sssss') 
         BETWEEN to_char( to_date(appointment_time, 'hh24:mi'), 'sssss') 
         AND to_char(to_date(appointment_time, 'hh24:mi'), 'sssss') + 5400 
         OR to_char(to_date(appointment_time, 'hh24:mi'), 'sssss') 
         BETWEEN to_char( to_date('&v_appointment_time', 'hh24:mi'), 'sssss') 
         AND to_char(to_date('&v_appointment_time', 'hh24:mi'), 'sssss') + 5400 
      )
      AND appointment_date = '&v_appointment_date' 
)
,
appointable AS
(
   SELECT
      employee_id,
      name,
      title,
      mobile,
      email,
      starting_time || '-' || ending_time AS shift 
   FROM
      have_shift_on_day w 
   WHERE
      w.employee_id NOT IN 
      (
         SELECT
            employee_id 
         FROM
            appointed_doctor_on_day
      )
)
SELECT
   name,
   title,
   mobile,
   email,
   shift,
   COALESCE(app.appointment_time, '-') AS scheduled 
FROM
   appointable a,
   appointment app 
WHERE
   a.employee_id = app.employee_id( + ) 
   AND app.appointment_date( + ) = '&v_appointment_date';

CLEAR COLUMNS;
CLEAR BREAKS;
CLEAR COMPUTES;
TTITLE OFF;