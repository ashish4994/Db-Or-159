/*
  Script:      201_DBAatCas_ACCT159_DDL_RO
  Schema:      DBA
  Author:      Jyoti Jerath
  Date:        11/19/2020
  Purpose:     New tables script for EWS
*/

SET TERMOUT ON
SET LINESIZE 80

SET SERVEROUTPUT ON SIZE 1000000
WHENEVER SQLERROR EXIT ROLLBACK
  
COLUMN filename new_val filename1
COLUMN envname new_val envname1
COLUMN script_name new_val _script_name

SET APPINFO ON

SELECT TRIM(REPLACE(SUBSTR(SYS_CONTEXT('USERENV', 'MODULE'),
       INSTR(SYS_CONTEXT('USERENV', 'MODULE'), '@') + 1), '.sql')) filename,
       SYS_CONTEXT('USERENV', 'INSTANCE_NAME') envname
       FROM dual;


spool &filename1._&envname1..log

ALTER SESSION SET EDITION = ORA$BASE;

SELECT 'current user is ' || USER || ' at ' FROM dual;

SELECT TO_CHAR(SYSDATE,'DD-Mon-YYYY HH24:MI:SS') date_ FROM dual;

DEFINE target_table_name = "T_LU_EWS_VERIFICATION_CHANNEL"

SELECT CASE WHEN MAX(table_name) IS NULL THEN '&target_table_name' ELSE 'empty.sql' END AS script_name from all_tables where table_name = '&target_table_name';

DECLARE
  v_script_name VARCHAR2(256);
BEGIN

  v_script_name := '&&_script_name';
  
  IF v_script_name = 'empty.sql' THEN
    DBMS_OUTPUT.PUT_LINE('Table &&target_table_name already exists. Skipped.');
  END IF;
  
END;
/

@&_script_name

DEFINE target_table_name = "T_EWS_VERIFICATION"

SELECT CASE WHEN MAX(table_name) IS NULL THEN '&target_table_name' ELSE 'empty.sql' END AS script_name from all_tables where table_name = '&target_table_name';

DECLARE
  v_script_name VARCHAR2(256);
BEGIN

  v_script_name := '&&_script_name';
  
  IF v_script_name = 'empty.sql' THEN
    DBMS_OUTPUT.PUT_LINE('Table &&target_table_name already exists. Skipped.');
  END IF;
  
END;
/

@&_script_name

DEFINE target_table_name = "T_EWS_VERIFICATION_EXCEPTION"

SELECT CASE WHEN MAX(table_name) IS NULL THEN '&target_table_name' ELSE 'empty.sql' END AS script_name from all_tables where table_name = '&target_table_name';

DECLARE
  v_script_name VARCHAR2(256);
BEGIN

  v_script_name := '&&_script_name';
  
  IF v_script_name = 'empty.sql' THEN
    DBMS_OUTPUT.PUT_LINE('Table &&target_table_name already exists. Skipped.');
  END IF;
  
END;
/

@&_script_name

DEFINE target_table_name = "T_EWS_VERIFICATION_ACCOUNT"

SELECT CASE WHEN MAX(table_name) IS NULL THEN '&target_table_name' ELSE 'empty.sql' END AS script_name from all_tables where table_name = '&target_table_name';

DECLARE
  v_script_name VARCHAR2(256);
BEGIN

  v_script_name := '&&_script_name';
  
  IF v_script_name = 'empty.sql' THEN
    DBMS_OUTPUT.PUT_LINE('Table &&target_table_name already exists. Skipped.');
  END IF;
  
END;
/

@&_script_name

DEFINE target_table_name = "T_EWS_VERIFICATION_APPLICATION"

SELECT CASE WHEN MAX(table_name) IS NULL THEN '&target_table_name' ELSE 'empty.sql' END AS script_name from all_tables where table_name = '&target_table_name';

DECLARE
  v_script_name VARCHAR2(256);
BEGIN

  v_script_name := '&&_script_name';
  
  IF v_script_name = 'empty.sql' THEN
    DBMS_OUTPUT.PUT_LINE('Table &&target_table_name already exists. Skipped.');
  END IF;
  
END;
/

@&_script_name


SELECT TO_CHAR(SYSDATE,'DD-Mon-YYYY HH24:MI:SS') date_ FROM dual;
sho ERRORS 
spo OFF 
