/*
  Script:      002_ACCOUNTatCAS_ACCT159_DDL_RB.sql
  Author:      Cristian Gomez
  Date:        12/15/2020
*****************************************************************************/

SET TERMOUT ON
SET ECHO OFF
SET LINESIZE 80
SET SERVEROUTPUT ON SIZE 1000000
WHENEVER SQLERROR EXIT ROLLBACK
column filename new_val filename1 

SELECT SYS_CONTEXT('USERENV', 'INSTANCE_NAME')  filename FROM dual;
  
spo 002_ACCOUNTatCAS_ACCT159_DDL_RB_&filename1..log; 

ALTER SESSION SET CURRENT_SCHEMA = ACCOUNT;

ALTER SESSION SET EDITION = ORA$BASE;
 
SELECT 'current user is ' || USER || ' at ' FROM dual;

SELECT SYS_CONTEXT('USERENV','INSTANCE_NAME') FROM dual;
 
SELECT TO_CHAR(SYSDATE,'DD-Mon-YYYY HH24:MI:SS') FROM dual;

@pkg_bank_acc_verification_r.sql

CREATE OR REPLACE EDITIONABLE PUBLIC SYNONYM pkg_bank_acc_verification FOR ACCOUNT.pkg_bank_acc_verification_r;

SELECT TO_CHAR(SYSDATE, 'DD-Mon-YYYY HH24:MI:SS') FROM dual;

sho ERRORS 
spo OFF
