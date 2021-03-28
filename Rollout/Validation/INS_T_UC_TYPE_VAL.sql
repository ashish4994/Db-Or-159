/*
  Script:      INS_T_UC_TYPE_VAL
  Schema:      IFLOW
  Author:      Cristhian Caro	
  Project:     ACCT-159
  Date:        12/02/2020
  Purpose:     Validates work case types 
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
    dbms_output.put_line('WORK CASE TYPE ' || C_UC_NAME||
                         ' EXISTS. VALIDATED SUCCESSFULLY.');
  ELSE
    RAISE_APPLICATION_ERROR(-20003,
                            'WORK CASE ' || C_UC_NAME ||
                            ' WAS NOT INSERTED. VALIDATION FAILED');
  END IF;
  
  SELECT COUNT(*)
    INTO v_count
  FROM T_UC_TYPE ut
  WHERE ut.UC_NAME = C_UC_NAME_EWS;

  IF V_COUNT = 1 THEN
    dbms_output.put_line('WORK CASE TYPE ' || C_UC_NAME_EWS||
                         ' EXISTS. VALIDATED SUCCESSFULLY.');
  ELSE
    RAISE_APPLICATION_ERROR(-20003,
                            'WORK CASE ' || C_UC_NAME_EWS ||
                            ' WAS NOT INSERTED. VALIDATION FAILED');
  END IF;

  COMMIT;
END;
/
