/*
  Script:      010_IFLOWatCAS_ACCT-159_DDL_RB.sql
  Schema:      IFLOW
  Author:      Cristhian Caro
  Project:     ACCT-159
  Date:        12/02/2020
  Purpose:     Rollback DDL scripts - Delete Nacha updates modifications
*/

ALTER SESSION SET EDITION = ORA$BASE;

SET TERMOUT ON
SET ECHO OFF
SET LINESIZE 80
--SET ESCAPE ^

SET SERVEROUTPUT ON SIZE 1000000
WHENEVER SQLERROR EXIT ROLLBACK
column filename new_val filename1 

SELECT SYS_CONTEXT('USERENV', 'INSTANCE_NAME') filename FROM dual; 

spool 010_IFLOWatCAS_ACCT-159_DDL_RB_&filename1..log;

ALTER SESSION SET CURRENT_SCHEMA = IFLOW;
 
SELECT 'current user is ' || USER || ' at ' FROM dual;
 
SELECT TO_CHAR(SYSDATE,'DD-Mon-YYYY HH24:MI:SS') date_ FROM dual;

@DEL_T_UC_TYPE.sql;
sho ERRORS

SELECT TO_CHAR(SYSDATE,'DD-Mon-YYYY HH24:MI:SS') date_ FROM dual;
spo OFF;