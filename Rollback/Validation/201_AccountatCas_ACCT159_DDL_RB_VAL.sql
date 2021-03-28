/*
  Script:      201_AccountatCas_ACCT159_DDL_RB_VAL.sql
  Schema:      ACCOUNT
  Author:      Jyoti Jerath
  Date:        11/19/2020
  Purpose:     dropped tables validation script
*/

SET TERMOUT ON
SET LINESIZE 80
--SET ESCAPE ^
SET SERVEROUTPUT ON SIZE 10000
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

ALTER SESSION SET CURRENT_SCHEMA = ACCOUNT;

ALTER SESSION SET EDITION = ORA$BASE;

SELECT 'current user is ' || USER || ' at ' FROM dual;

SELECT TO_CHAR(SYSDATE,'DD-Mon-YYYY HH24:MI:SS') date_ FROM dual;

@T_EWS_VERIFICATION_ACCOUNT_RB_VAL.sql;
sho ERRORS

@T_EWS_VERIFICATION_RB_VAL.sql;
SHO ERRORS;

@T_EWS_VERIFICATION_EXCEPTION_RB_VAL.sql;
SHO ERRORS;

SELECT TO_CHAR(SYSDATE, 'DD-Mon-YYYY HH24:MI:SS') date_ FROM dual;
sho ERRORS 
spo OFF 