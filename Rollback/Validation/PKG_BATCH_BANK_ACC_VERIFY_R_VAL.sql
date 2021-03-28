/*
  Script:      PKG_BATCH_BANK_ACC_VERIFY_R_VAL.sql
  Schema:      PROCESS
  Author:      Cristian Gomez
  Date:        03/12/2021
  Purpose:     PKG_BATCH_BANK_ACC_VERIFY_R Validation
*/



DECLARE
    v_count             PLS_INTEGER;
    str_audit           VARCHAR2(10000);
    str_err             VARCHAR2(10000);
    v_varchar           VARCHAR2(50);
    v_ext               VARCHAR(10);
    str_syn             VARCHAR2(100);
    str_schema          VARCHAR2(100);
    str_validation_type VARCHAR2(100);
BEGIN
    -- Set these 3 variables for your package.
    str_syn             := 'PKG_BATCH_BANK_ACC_VERIFY';
    str_schema          := 'PROCESS';
    str_validation_type := 'ROLLBACK'; -- Should be either 'ROLLOUT' or 'ROLLBACK'

    str_err   := NULL;
    str_audit := NULL;

    IF (str_validation_type = 'ROLLOUT') THEN
        v_ext := '_P';
    ELSE
        v_ext := '_R';
    END IF;

    -- Validate Synonym
    BEGIN
        BEGIN
            -- Select synonym   
            SELECT TABLE_NAME
              INTO V_varchar
              FROM dba_SYNONYMS
             WHERE UPPER(SYNONYM_name) =  UPPER(str_syn)
               AND owner = 'PUBLIC'
               AND table_owner = str_schema;
        
            -- Validate synonym created and pointing to correct package
            IF v_varchar = str_syn || v_ext THEN
                str_audit := str_audit || 'Public synonym ' || str_syn ||
                             ' is created for ' || v_varchar ||
                             ' in the database' || chr(13);
            ELSE
                str_err := str_err ||
                           '- Public synonym is NOT created for ' ||
                           V_varchar || ' in the database' || chr(13);
            END IF;
        
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                str_err := str_err ||
                           '- Public synonym is NOT created!' ||
                           chr(13);
        END;
    
        -- Validate Production Package
        SELECT COUNT(*)
          INTO v_count
          FROM dba_objects
         WHERE UPPER(object_name) = UPPER(str_syn  || v_ext)
           AND owner = str_schema
           AND status = 'VALID';
    
        IF v_count = 2 THEN
            str_audit := str_audit || str_schema || '.' || str_syn || v_ext ||
                         ' package is created in the database' || chr(13);
        ELSE
            str_err := str_err || '- ' || str_schema || '.' || str_syn  || v_ext ||
                       ' package IS NOT in the database or invalid!' ||
                       chr(13);
        END IF;
    
    END;

    IF (nvl(length(str_err),
            0) = 0) THEN
        dbms_output.put_line(str_validation_type || ' is successful!' || chr(13));
    ELSE
        dbms_output.put_line(str_validation_type || ' FAILED!' || chr(13));
        dbms_output.put_line('Audit Data:');
        dbms_output.put_line(str_audit);
        dbms_output.put_line('Error Data:');
        dbms_output.put_line(str_err);       

    END IF;

END;
/
