/*
  Script:      INS_T_UC_TYPE
  Schema:      IFLOW
  Author:      Cristhian Caro
  Proj/WO:     ACCT-159
  Date:        11/30/2020
  Purpose:     Inserts Account verification successful type
*/

DECLARE
  V_COUNT NUMBER;
  C_UC_NAME           T_UC_TYPE.UC_NAME%TYPE := 'Bank Account Verification Successful';
  C_IFLOW             T_UC_TYPE.IFLOW%TYPE := 'Bank Account Verification Successful';
  C_ACTION_TYPE       CONSTANT T_UC_TYPE.ACTION_TYPE%TYPE := NULL;
  C_ACTION_PARAMETERS CONSTANT T_UC_TYPE.ACTION_PARAMETERS%TYPE := NULL;
  C_UC_CATEGORY_ID    CONSTANT T_UC_TYPE.UC_CATEGORY_ID%TYPE := 3;

BEGIN
  SELECT COUNT(*)
    INTO v_count
    FROM T_UC_TYPE ut
   WHERE ut.UC_NAME = C_UC_NAME;

  IF V_COUNT = 0 THEN
    INSERT INTO T_UC_TYPE
    (UC_TYPE_ID, UC_NAME, IFLOW, ACTION_TYPE, ACTION_PARAMETERS, UC_CATEGORY_ID)
  VALUES
    (T_UC_TYPE_SEQ.NEXTVAL,
     C_UC_NAME,
     C_IFLOW,
     C_ACTION_TYPE,
     C_ACTION_PARAMETERS,
     C_UC_CATEGORY_ID);
  
  ELSIF v_count = 1 THEN
    UPDATE T_UC_TYPE ut
       SET UC_NAME             = C_UC_NAME,
           IFLOW           = C_IFLOW,
           ACTION_TYPE       = C_ACTION_TYPE,
           ACTION_PARAMETERS   = C_ACTION_PARAMETERS,
           UC_CATEGORY_ID      = C_UC_CATEGORY_ID
    WHERE ut.UC_NAME = C_UC_NAME;
  
  ELSE
    DBMS_OUTPUT.PUT_LINE('Record ' || C_UC_NAME || ' exists more than once :' || v_count);
  END IF;


  C_UC_NAME := 'Bank Account Verification Failure EWS';
  C_IFLOW   := 'BankAccountVerificationFailure';

 SELECT COUNT(*)
    INTO v_count
    FROM T_UC_TYPE ut
   WHERE ut.UC_NAME = C_UC_NAME;

  IF V_COUNT = 0 THEN
    INSERT INTO T_UC_TYPE
    (UC_TYPE_ID, UC_NAME, IFLOW, ACTION_TYPE, ACTION_PARAMETERS, UC_CATEGORY_ID)
  VALUES
    (T_UC_TYPE_SEQ.NEXTVAL,
     C_UC_NAME,
     C_IFLOW,
     C_ACTION_TYPE,
     C_ACTION_PARAMETERS,
     C_UC_CATEGORY_ID);
  
  ELSIF v_count = 1 THEN
    UPDATE T_UC_TYPE ut
       SET UC_NAME             = C_UC_NAME,
           IFLOW           = C_IFLOW,
           ACTION_TYPE       = C_ACTION_TYPE,
           ACTION_PARAMETERS   = C_ACTION_PARAMETERS,
           UC_CATEGORY_ID      = C_UC_CATEGORY_ID
    WHERE ut.UC_NAME = C_UC_NAME;
  
  ELSE
    DBMS_OUTPUT.PUT_LINE('Record ' || C_UC_NAME || ' exists more than once :' || v_count);
  END IF;
  
  COMMIT;
END;
/
