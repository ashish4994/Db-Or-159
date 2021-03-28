/*
  Script:      INS_T_RT_LOOKUP
  Schema:      IFLOW
  Author:      Miguel Rodriguez Cimino
  Date:        01/05/2021
  Purpose:     insert configuration for due date close warning message
*****************************************************************************/

DECLARE
  V_COUNT NUMBER;
  V_ENV   VARCHAR2(50);

BEGIN

  SELECT SYS_CONTEXT('USERENV', 'DB_NAME') INTO V_ENV FROM DUAL;

  SELECT COUNT(1)
    INTO V_COUNT
    FROM T_RT_LOOKUP
   WHERE LOOKUP_DESC = 'DueDateWarningDays';

  IF V_COUNT = 0 THEN
  
	insert into t_rt_lookup values(lookup_id.nextval,
                      (select lookup_type_id from T_RT_LOOKUP_TYPE where UPPER(LOOKUP_TYPE_DESC) = UPPER('CreditOneBankCurrentSettings')),
                      '5',
                      'DueDateWarningDays',
                      1,
                      0);
  
  END IF;
  COMMIT;
END;
/
