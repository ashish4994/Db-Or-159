/*

  SCRIPT:      INS_T_APPLICATION_CONFIGURATIONS_VAL.SQL
  SCHEMA:      IFLOW
  AUTHOR:      JYOTI JERATH
  DATE:        11/19/2020
  PURPOSE:     VALIDATE INS_T_APPLICATION_CONFIGURATIONS FOR EWS SOAP SERVICE CONFIGURATION AND ITS SWITCH VALUE

*/

DECLARE
  V_COUNT NUMBER;
  STR_ERR VARCHAR2(10000);
BEGIN
  STR_ERR := NULL;

  SELECT COUNT(1)
    INTO V_COUNT
    FROM T_APPLICATION_CONFIGURATIONS
   WHERE CONFIG_TYPE IN ('EWS_PAYMENT_VALIDATION');

  IF V_COUNT <> 6 THEN
    STR_ERR := STR_ERR || 'COUNT IS NOT EQUAL TO 6 KEYS' || CHR(13);
  END IF;

  IF (NVL(LENGTH(STR_ERR), 0) = 0) THEN
    DBMS_OUTPUT.PUT_LINE('ROLLOUT SUCCESSFUL! CURRENT COUNT: ' || V_COUNT ||
                         CHR(13));
  ELSE
    DBMS_OUTPUT.PUT_LINE('ROLLOUT FAILED! CURRENT COUNT: ' || V_COUNT ||
                         CHR(13));
  END IF;

END;
/
