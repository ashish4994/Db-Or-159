/*
  Script:      DEL_T_UC_TYPE
  Schema:      IFLOW
  Author:      Cristhian Caro	
  Project:     ACCT-159
  Date:        12/02/2020
  Purpose:     Rollback work case types 
*/

DECLARE
  V_COUNT NUMBER;
  C_UC_NAME        		CONSTANT T_UC_TYPE.UC_NAME%TYPE := 'Bank Account Verification Successful';
  C_UC_NAME_EWS      	CONSTANT T_UC_TYPE.UC_NAME%TYPE := 'Bank Account Verification Failure EWS';

BEGIN
  SELECT COUNT(*)
    INTO v_count
  FROM T_UC_TYPE ut
  WHERE ut.UC_NAME = C_UC_NAME;

  IF V_COUNT = 1 THEN
	DELETE T_UC_TYPE
	WHERE UC_NAME = C_UC_NAME;
  END IF;
  
  SELECT COUNT(*)
    INTO v_count
  FROM T_UC_TYPE ut
  WHERE ut.UC_NAME = C_UC_NAME_EWS;

  IF V_COUNT = 1 THEN
	DELETE T_UC_TYPE
	WHERE UC_NAME = C_UC_NAME_EWS;
  END IF;

  COMMIT;
END;
/
