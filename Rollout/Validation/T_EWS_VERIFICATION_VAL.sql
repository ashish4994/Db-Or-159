/*
  Script:      T_EWS_VERIFICATION_VAL.sql
  Schema:      ACCOUNT
  Author:      Jyoti Jerath
  Date:        11/19/2020
  Purpose:     Two new tables validation- T_EWS_VERIFICATION & T_EWS_VERIFICATION_EXCEPTION
*/

DECLARE
  v_table_name    all_tables.TABLE_NAME%TYPE := 'T_EWS_VERIFICATION';
  v_sequence_name all_sequences.SEQUENCE_NAME%TYPE := 'SEQ_EWS_VERIFICATION_ID';
  v_exists        NUMBER := 0;
  v_err           NUMBER := 0;
BEGIN
  SELECT COUNT(1)
    INTO v_exists
    FROM all_tables t
   WHERE t.table_name = v_table_name
     and OWNER = 'ACCOUNT';

  v_err := v_exists;

  IF v_exists = 0 THEN
  
    dbms_output.put_line('[ERROR] - Table ' || v_table_name ||
                         ' does not exist!');
  END IF;

  SELECT COUNT(1)
    INTO v_exists
    FROM all_sequences s
   WHERE s.sequence_name = v_sequence_name
     and sequence_owner = 'ACCOUNT';

  v_err := v_err + v_exists;
  IF v_exists = 0 THEN
  
    dbms_output.put_line('[ERROR] - Sequence ' || v_sequence_name ||
                         ' does not exist!');
  END IF;

  IF v_err <> 2 THEN
    raise_application_error(-20010,
                            '[ROLLOUT FAILURE] - ' || v_table_name ||
                            ' or ' || v_sequence_name ||
                            ' missing from ACCOUNT schema.');
  ELSE
    dbms_output.put_line('[SUCCESS] - DDL Validation Successful.');
  END IF;
END;
/
