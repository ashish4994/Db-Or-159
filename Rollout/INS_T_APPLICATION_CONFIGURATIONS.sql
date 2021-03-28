/*
  Script:      INS_T_APPLICATION_CONFIGURATIONS
  Schema:     IFLOW
  Author:      Jyoti Jerath
  Date:        11/19/2020
  Purpose:     insert the EWS SOAP Service configuration and switch value
*****************************************************************************/

DECLARE
  V_COUNT NUMBER;
  V_ENV   VARCHAR2(50);

BEGIN

  SELECT SYS_CONTEXT('USERENV', 'DB_NAME') INTO V_ENV FROM DUAL;

  SELECT COUNT(1)
    INTO V_COUNT
    FROM T_APPLICATION_CONFIGURATIONS
   WHERE CONFIG_TYPE IN ('EWS_PAYMENT_VALIDATION')
     AND CONFIG_KEY IN ('EWS_SWITCH');

  IF V_COUNT = 0 THEN
  
    INSERT INTO T_APPLICATION_CONFIGURATIONS
      (APP_CONFIG_ID,
       REVISION_ID,
       CONFIG_TYPE,
       CONFIG_KEY,
       CONFIG_VALUE,
       ACTIVE,
       LOAD_DATE)
    VALUES
      (SEQ_APP_CONFIG_ID.Nextval,
       1,
       'EWS_PAYMENT_VALIDATION',
       'EWS_SWITCH',
       'true',
       1,
       sysdate);
  
  END IF;

  SELECT COUNT(1)
    INTO V_COUNT
    FROM T_APPLICATION_CONFIGURATIONS
   WHERE CONFIG_TYPE IN ('EWS_PAYMENT_VALIDATION')
     AND CONFIG_KEY IN ('EWS_OverallMatchScore_Threshold');

  IF V_COUNT = 0 THEN
  
    INSERT INTO T_APPLICATION_CONFIGURATIONS
      (APP_CONFIG_ID,
       REVISION_ID,
       CONFIG_TYPE,
       CONFIG_KEY,
       CONFIG_VALUE,
       ACTIVE,
       LOAD_DATE)
    VALUES
      (SEQ_APP_CONFIG_ID.Nextval,
       1,
       'EWS_PAYMENT_VALIDATION',
       'EWS_OverallMatchScore_Threshold',
       74,
       1,
       sysdate);
  
  END IF;



SELECT COUNT(1)
    INTO V_COUNT
    FROM T_APPLICATION_CONFIGURATIONS
   WHERE CONFIG_TYPE IN ('EWS_PAYMENT_VALIDATION')
     AND CONFIG_KEY IN ('EWS_Valid_Status');

  IF V_COUNT = 0 THEN
  
    INSERT INTO T_APPLICATION_CONFIGURATIONS
      (APP_CONFIG_ID,
       REVISION_ID,
       CONFIG_TYPE,
       CONFIG_KEY,
       CONFIG_VALUE,
       ACTIVE,
       LOAD_DATE)
    VALUES
      (SEQ_APP_CONFIG_ID.Nextval,
       1,
       'EWS_PAYMENT_VALIDATION',
       'EWS_Valid_Status',
       '099,199',
       1,
       sysdate);
  
  END IF;


  SELECT COUNT(1)
    INTO V_COUNT
    FROM T_APPLICATION_CONFIGURATIONS
   WHERE CONFIG_TYPE IN ('EWS_PAYMENT_VALIDATION')
     AND CONFIG_KEY IN ('AOA_ONLY');

  IF V_COUNT = 0 THEN
    IF UPPER(V_ENV) = 'CAS' THEN
      --- PRODUCTION
      INSERT INTO T_APPLICATION_CONFIGURATIONS
        (APP_CONFIG_ID,
         REVISION_ID,
         CONFIG_TYPE,
         CONFIG_KEY,
         CONFIG_VALUE,
         ACTIVE,
         LOAD_DATE)
      VALUES
        (SEQ_APP_CONFIG_ID.NEXTVAL,
         1,
         'EWS_PAYMENT_VALIDATION',
         'AOA_ONLY',
         '{"ClientAPI":"AOPA4P","PrimID":"PROM112002","UserID":"CREDITONEV4001","Mode":"Failover"}',
         1,
         SYSDATE);
    ELSE
      -- TEST
      INSERT INTO T_APPLICATION_CONFIGURATIONS
        (APP_CONFIG_ID,
         REVISION_ID,
         CONFIG_TYPE,
         CONFIG_KEY,
         CONFIG_VALUE,
         ACTIVE,
         LOAD_DATE)
      VALUES
        (SEQ_APP_CONFIG_ID.NEXTVAL,
         1,
         'EWS_PAYMENT_VALIDATION',
         'AOA_ONLY',
         '{"ClientAPI":"AOPA4P","PrimID":"TROM112002","UserID":"CREDITONEV4001","Mode":"Failover"}',
         1,
         SYSDATE);
    END IF;
  END IF;

  SELECT COUNT(1)
    INTO V_COUNT
    FROM T_APPLICATION_CONFIGURATIONS
   WHERE CONFIG_TYPE IN ('EWS_PAYMENT_VALIDATION')
     AND CONFIG_KEY IN ('STATUS_ONLY');

  IF V_COUNT = 0 THEN
    IF UPPER(V_ENV) = 'CAS' THEN
      -- PRODUCTION
      INSERT INTO T_APPLICATION_CONFIGURATIONS
        (APP_CONFIG_ID,
         REVISION_ID,
         CONFIG_TYPE,
         CONFIG_KEY,
         CONFIG_VALUE,
         ACTIVE,
         LOAD_DATE)
      VALUES
        (SEQ_APP_CONFIG_ID.NEXTVAL,
         1,
         'EWS_PAYMENT_VALIDATION',
         'STATUS_ONLY',
         '{"ClientAPI":"AOPA4P","PrimID":"PROM112002","UserID":"CREDITONEV4001","Mode":"Failover"}',
         1,
         SYSDATE);
    ELSE
      -- TEST
      INSERT INTO T_APPLICATION_CONFIGURATIONS
        (APP_CONFIG_ID,
         REVISION_ID,
         CONFIG_TYPE,
         CONFIG_KEY,
         CONFIG_VALUE,
         ACTIVE,
         LOAD_DATE)
      VALUES
        (SEQ_APP_CONFIG_ID.NEXTVAL,
         1,
         'EWS_PAYMENT_VALIDATION',
         'STATUS_ONLY',
         '{"ClientAPI":"AOPA4P","PrimID":"TROM112002","UserID":"CREDITONEV4001","Mode":"Failover"}',
         1,
         SYSDATE);
    END IF;
  END IF;

  SELECT COUNT(1)
    INTO V_COUNT
    FROM T_APPLICATION_CONFIGURATIONS
   WHERE CONFIG_TYPE IN ('EWS_PAYMENT_VALIDATION')
     AND CONFIG_KEY IN ('COMBINED_AOA_AND_STATUS');

  IF V_COUNT = 0 THEN
    IF UPPER(V_ENV) = 'CAS' THEN
      --- PROUCTION
      INSERT INTO T_APPLICATION_CONFIGURATIONS
        (APP_CONFIG_ID,
         REVISION_ID,
         CONFIG_TYPE,
         CONFIG_KEY,
         CONFIG_VALUE,
         ACTIVE,
         LOAD_DATE)
      VALUES
        (SEQ_APP_CONFIG_ID.NEXTVAL,
         1,
         'EWS_PAYMENT_VALIDATION',
         'COMBINED_AOA_AND_STATUS',
         '{"ClientAPI":"AOPA4P","PrimID":"TROM112002","UserID":"CREDITONEV4001","Mode":"Failover"}',
         1,
         SYSDATE);
    ELSE
      -- TEST
      INSERT INTO T_APPLICATION_CONFIGURATIONS
        (APP_CONFIG_ID,
         REVISION_ID,
         CONFIG_TYPE,
         CONFIG_KEY,
         CONFIG_VALUE,
         ACTIVE,
         LOAD_DATE)
      VALUES
        (SEQ_APP_CONFIG_ID.NEXTVAL,
         1,
         'EWS_PAYMENT_VALIDATION',
         'COMBINED_AOA_AND_STATUS',
         '{"ClientAPI":"AOPA4P","PrimID":"TROM112002","UserID":"CREDITONEV4001","Mode":"Failover"}',
         1,
         SYSDATE);
    END IF;
  END IF;
  COMMIT;
END;
/
