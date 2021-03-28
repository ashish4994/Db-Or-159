/*
  Script:      INS_T_APPLICATION_CONFIGURATIONS
  Schema:	    IFLOW
  Author:      Jyoti Jerath
  Date:        11/19/2020
  Purpose:     delete the EWS SOAP Service configuration and its switch value
*****************************************************************************/

DECLARE
    v_count NUMBER;
   
BEGIN

SELECT COUNT(1)
INTO V_COUNT
FROM T_APPLICATION_CONFIGURATIONS
WHERE CONFIG_TYPE IN ('EWS_PAYMENT_VALIDATION');

IF V_COUNT > 0 THEN
DELETE FROM T_APPLICATION_CONFIGURATIONS
WHERE CONFIG_TYPE IN ('EWS_PAYMENT_VALIDATION');
END IF;   

COMMIT;
END;
/