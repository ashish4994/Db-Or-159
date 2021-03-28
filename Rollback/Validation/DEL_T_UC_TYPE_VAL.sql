/*
  Script:      DEL_T_UC_TYPE_VAL
  Schema:      IFLOW
  Author:      Cristhian Caro
  Project:     ACCT-159
  Date:        12/02/2020
  Purpose:     Validates the work case Type Rollback script
*/

DECLARE
  V_COUNT NUMBER;
  C_UC_NAME        		CONSTANT T_UC_TYPE.UC_NAME%TYPE := 'Bank Account Verification Successful';

BEGIN
  SELECT COUNT(*)
    INTO v_count
  FROM T_UC_TYPE ut
  WHERE ut.UC_NAME = C_UC_NAME;

  IF V_COUNT = 0 THEN
    dbms_output.put_line('WORK CASE TYPE ' || C_UC_NAME ||
                         ' DELETED. VALIDATED SUCCESSFULLY.');
  ELSE
    RAISE_APPLICATION_ERROR(-20003,
                            'WORK CASE TYPE ' || C_UC_NAME ||
                            ' STILL EXISTS. VALIDATION FAILED');
  END IF;
  COMMIT;
END;
/
