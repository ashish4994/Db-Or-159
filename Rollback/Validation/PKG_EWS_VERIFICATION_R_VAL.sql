 /*
  SCRIPT:      PKG_EWS_VERIFICATION_R_VAL.SQL
  SCHEMA:      ACCOUNT
  AUTHOR:      JJERATH
  DATE:        11/19/2020
  PURPOSE:     PKG_EWS_VERIFICATION_R PACKAGE VALIDATION
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
    str_syn             := 'PKG_EWS_VERIFICATION';
    str_schema          := 'ACCOUNT';
    str_validation_type := 'ROLLBACK'; -- Should be either 'ROLLOUT' or 'ROLLBACK'
	 v_ext := '_P';
    str_err   := NULL;
    str_audit := NULL;

    -- Validate Synonym
    BEGIN
        BEGIN
            -- Select synonym   
            SELECT COUNT(1)
              INTO V_varchar
              FROM dba_SYNONYMS
             WHERE SYNONYM_name =  str_syn
               AND owner = 'PUBLIC'
               AND table_owner = str_schema;
        
            -- Validate synonym created and pointing to correct package
            IF v_varchar = 1 THEN
				str_err := str_err || str_syn || 
                           ' Public synonym exists in the database Error!!' || chr(13);
            ELSE
                str_audit := str_syn || ' Public synonym does not exist in the database' || chr(13);
            END IF;
        END;
    
        -- Validate Production Package
        SELECT COUNT(*)
          INTO v_count
          FROM dba_objects
         WHERE object_name = str_syn  || v_ext
           AND owner = str_schema
           AND status = 'VALID';
    
        IF v_count = 2 THEN
			 str_err := str_err || '- ' || str_schema || '.' || str_syn  || v_ext ||
                       ' package is in the database!' ||
                       chr(13);
        ELSE
            str_audit := str_audit || str_schema || '.' || str_syn || v_ext ||
                         ' package is not present in the database' || chr(13);
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