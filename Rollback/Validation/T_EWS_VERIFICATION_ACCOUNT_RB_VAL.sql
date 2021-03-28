/*
  Script:      T_EWS_VERIFICATION_ACCOUNT_RB_VAL.sql
  Schema:      ACCOUNT
  Author:      Jyoti Jerath
  Date:        11/19/2020
  Purpose:     dropped table validation
*/

DECLARE
	v_table_name 	all_tables.TABLE_NAME%TYPE := 'T_EWS_VERIFICATION_ACCOUNT';
    v_sequence_name all_sequences.SEQUENCE_NAME%TYPE := 'SEQ_EWS_VERIFICATION_ACCOUNT_ID';
    v_exists 		NUMBER := 0;
    v_err			NUMBER := 0;
BEGIN
    SELECT COUNT(1)
    INTO v_exists
    FROM all_tables t
    WHERE t.table_name = v_table_name;
    
    v_err := v_exists;
    
    IF v_exists = 1 THEN
        dbms_output.put_line('[ERROR] - Table ' || v_table_name || ' exist!');
    END IF;
    
    SELECT COUNT(1)
    INTO v_exists
    FROM all_sequences s
    WHERE s.sequence_name = v_sequence_name;
    
    v_err := v_err + v_exists;
    
    IF v_exists = 1 THEN
        dbms_output.put_line('[ERROR] - Sequence ' || v_sequence_name || ' exist!');
    END IF;
    
    IF v_err = 0 THEN
        dbms_output.put_line('[SUCCESS] - ROLLBACK Successful.');
		
    ELSE
        raise_application_error(-20010, '[ROLLBACK FAILURE] - ' || v_table_name || ' or ' || v_sequence_name || ' exist in ACCOUNT schema.');
    END IF;
END;
/