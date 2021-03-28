/*
  Script:      010_IFLOWatCAS_ACCT-159_DDL_RO
  Schema:      IFLOW
  Author:      Cristhian Caro
  Proj/WO:     ACCT-159
  Date:        11/30/2020
  Purpose:     Rollout For Nacha Rules Update
*/

ALTER SESSION SET EDITION = ORA$BASE;

SET TERMOUT ON
SET ECHO OFF
SET LINESIZE 80

SET SERVEROUTPUT ON SIZE 1000000
WHENEVER SQLERROR EXIT ROLLBACK
column filename new_val filename1 

SELECT SYS_CONTEXT('USERENV', 'INSTANCE_NAME') filename FROM dual; 

spool 010_IFLOWatCAS_ACCT-159_DDL_RO_&filename1..log;

ALTER SESSION SET CURRENT_SCHEMA = IFLOW;
 
SELECT 'current user is ' || USER || ' at ' FROM dual;
 
SELECT TO_CHAR(SYSDATE,'DD-Mon-YYYY HH24:MI:SS') date_ FROM dual;

@INS_T_UC_TYPE.sql;

SELECT TO_CHAR(SYSDATE,'DD-Mon-YYYY HH24:MI:SS') date_ FROM dual;

sho ERRORS

SHOW ERRORS;
spo OFF;
