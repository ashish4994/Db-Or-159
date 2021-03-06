/*
  Script:      201_ACCOUNTatCas_ACCT159_DDL_RB.sql
  Schema:      ACCOUNT
  Author:      Jyoti Jerath
  Date:        11/19/2020
  Purpose:     Drop new tables 
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

ALTER SESSION SET EDITION = ORA$BASE;

SELECT 'current user is ' || USER || ' at ' FROM dual;

SELECT TO_CHAR(SYSDATE,'DD-Mon-YYYY HH24:MI:SS') date_ FROM dual;

DROP TABLE ACCOUNT.T_EWS_VERIFICATION_ACCOUNT;
sho ERRORS

DROP TABLE ACCOUNT.T_EWS_VERIFICATION_APPLICATION;
sho ERRORS

DROP TABLE ACCOUNT.T_EWS_VERIFICATION_EXCEPTION;
sho ERRORS

DROP TABLE ACCOUNT.T_EWS_VERIFICATION;
sho ERRORS

DROP TABLE ACCOUNT.T_LU_EWS_VERIFICATION_CHANNEL;
sho ERRORS

DROP SEQUENCE ACCOUNT.SEQ_EWS_VERIFICATION_ACCOUNT_ID;
sho ERRORS

DROP SEQUENCE ACCOUNT.SEQ_EWS_VERIFICATION_APPLICATION_ID;
sho ERRORS

DROP SEQUENCE ACCOUNT.SEQ_EWS_VERIFICATION_ID;
sho ERRORS

DROP SEQUENCE ACCOUNT.SEQ_EWS_VERIFICATION_EXCEPTION_ID;
sho ERRORS

DROP SEQUENCE ACCOUNT.SEQ_CHANNEL_ID;
sho ERRORS

SELECT TO_CHAR(SYSDATE, 'DD-Mon-YYYY HH24:MI:SS') date_ FROM dual;
sho ERRORS 
spo OFF 