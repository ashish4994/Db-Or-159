/*
  Script:      INS_T_LU_EWS_VERIFICATION_CHANNEL_VAL.sql
  Schema:	    ACCOUNT
  Author:      Jyoti Jerath
  Date:        11/19/2020
  Purpose:     Validation script
*****************************************************************************/

DECLARE
  V_COUNT NUMBER;
  STR_ERR VARCHAR2(10000);

BEGIN

  SELECT COUNT(1)
    INTO V_COUNT
    FROM T_LU_EWS_VERIFICATION_CHANNEL
   WHERE CHANNEL IN ('Web', 'Mobile', 'CAS', 'Application','Unknown');

  IF V_COUNT <> 5 THEN
    STR_ERR := STR_ERR || 'COUNT IS NOT EQUAL TO 5 KEYS' || CHR(13);
  END IF;

  IF (NVL(LENGTH(STR_ERR), 0) = 0) THEN
    DBMS_OUTPUT.PUT_LINE('ROLLOUT SUCCESSFUL! CURRENT COUNT: ' || V_COUNT ||
                         CHR(13));
  ELSE
    DBMS_OUTPUT.PUT_LINE('ROLLOUT FAILED! CURRENT COUNT: ' || V_COUNT ||
                         CHR(13));
  END IF;

  COMMIT;
END;
/
