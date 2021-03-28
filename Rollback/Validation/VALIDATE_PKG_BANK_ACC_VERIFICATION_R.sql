DECLARE
  v_pkg_name  VARCHAR2(100);
  v_owner     VARCHAR2(100);
  v_synonym   VARCHAR2(100);
  v_Count     NUMBER;
  
BEGIN

  v_Count := 0; 
  v_pkg_name := 'pkg_bank_acc_verification_r';
  v_owner := 'ACCOUNT';
  
  DBMS_OUTPUT.PUT_LINE('Validating ' || v_pkg_name || '!');

  -- Get Actual count.
  SELECT COUNT(*)
    INTO v_Count
    FROM all_objects
   WHERE UPPER(object_name) =  UPPER(v_pkg_name)
     AND owner = v_owner
     AND (object_type = 'PACKAGE BODY' OR object_type = 'PACKAGE')
     AND status = 'VALID';

  IF (v_Count = 2) THEN
	DBMS_OUTPUT.PUT_LINE('ROLLBACK VALIDATION SUCCEEDED!');
  ELSE
	RAISE_APPLICATION_ERROR(-20001, 'ROLLBACK Validation failed! Did not find package or body in compiled state! ');
  END IF; 
  
  v_synonym := 'pkg_bank_acc_verification';
  
  -- Select synonym   
  SELECT count(*)
    INTO v_Count
    FROM dba_SYNONYMS
   WHERE UPPER(SYNONYM_name) =  UPPER(v_synonym)
     AND owner = 'PUBLIC'
     AND table_owner = v_owner;

  IF (v_Count = 0) THEN
    RAISE_APPLICATION_ERROR(-20001, 'ROLLBACK Validation failed! Did not find synonym ' || v_synonym || ' to table/pkg ' || v_pkg_name || ' owner ' || v_owner || '! ');
  ELSE
    DBMS_OUTPUT.PUT_LINE('ROLLBACK VALIDATION SUCCEEDED! Synonym ' || v_synonym || ' to table/pkg ' || v_pkg_name || ' owner ' || v_owner || ' found! ' );
  END IF;
    
END;
/
