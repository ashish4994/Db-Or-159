/*

  Script:      301_ACCOUNTatCas_ACCT159_PKG_RO
  Schema:      ACCOUNT
  Author:      Jyoti Jerath
  Date:        11/19/2020
  Purpose:     Insert EWS request, response, error details in pkg

*/


SET TERMOUT ON
SET LINESIZE 80
--SET ESCAPE ^
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

ALTER SESSION SET CURRENT_SCHEMA = ACCOUNT;

ALTER SESSION SET EDITION = ORA$BASE;

SELECT 'current user is ' || USER || ' at ' FROM dual;

SELECT TO_CHAR(SYSDATE,'DD-Mon-YYYY HH24:MI:SS') date_ FROM dual;

@PKG_EWS_VERIFICATION_P.sql;
sho ERRORS

SELECT TO_CHAR(SYSDATE,'DD-Mon-YYYY HH24:MI:SS') date_ FROM dual;
sho ERRORS
spo OFF
