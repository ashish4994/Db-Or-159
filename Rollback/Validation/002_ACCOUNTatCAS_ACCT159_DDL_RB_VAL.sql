/*
  Script:      002_ACCOUNTatCAS_ACCT159_DDL_RB_VAL.sql
  Author:      Cristian Gomez
  Date:        12/15/2020
*****************************************************************************/

SET TERMOUT ON
SET ECHO OFF
SET LINESIZE 80
SET SERVEROUTPUT ON SIZE 1040040
WHENEVER SQLERROR EXIT ROLLBACK
column filename new_val filename1 

SELECT SYS_CONTEXT('USERENV', 'INSTANCE_NAME')  filename FROM dual;
  
spo 002_ACCOUNTatCAS_ACCT159_DDL_RB_VAL_&filename1..log; 

ALTER SESSION SET CURRENT_SCHEMA = ACCOUNT;

ALTER SESSION SET EDITION = ORA$BASE;
 
SELECT 'current user is ' || USER || ' at ' FROM dual;

SELECT SYS_CONTEXT('USERENV','INSTANCE_NAME') FROM dual;
 
SELECT TO_CHAR(SYSDATE,'DD-Mon-YYYY HH24:MI:SS') FROM dual;

@VALIDATE_PKG_BANK_ACC_VERIFICATION_R.sql;

SELECT TO_CHAR(SYSDATE, 'DD-Mon-YYYY HH24:MI:SS') FROM dual;

sho ERRORS 
spo OFF
