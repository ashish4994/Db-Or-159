/*
  Script:      DEL_T_RT_LOOKUP
  Schema:	    IFLOW
  Author:      Pablo Gomez
  Date:        1/5/2021
  Purpose:     delete the configuration value to get the day amount of due date close
*****************************************************************************/

DECLARE
    v_count NUMBER;
   
BEGIN

SELECT COUNT(1)
INTO V_COUNT
FROM T_RT_LOOKUP
WHERE LOOKUP_DESC = 'DueDateWarningDays';

IF V_COUNT > 0 THEN
DELETE FROM T_RT_LOOKUP
WHERE LOOKUP_DESC = 'DueDateWarningDays';
END IF;   

COMMIT;
END;
/