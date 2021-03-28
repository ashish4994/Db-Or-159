/*

  Script:      101_IFLOWatCas_ACCT159_DML_RO
  Schema:      IFLOW
  Author:      Jyoti Jerath
  Date:        11/19/2020
  Purpose:     @INS_T_APPLICATION_CONFIGURATIONS: to insert the EWS SOAP Service configuration and its switch value
				@INS_T_RT_LOOKUP. To insert the amount of business days to show due date close

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

ALTER SESSION SET CURRENT_SCHEMA = IFLOW;

ALTER SESSION SET EDITION = ORA$BASE;

SELECT 'current user is ' || USER || ' at ' FROM dual;

SELECT TO_CHAR(SYSDATE,'DD-Mon-YYYY HH24:MI:SS') date_ FROM dual;

@INS_T_APPLICATION_CONFIGURATIONS.sql;
sho ERRORS

@INS_T_RT_LOOKUP.sql;
sho ERRORS

SELECT TO_CHAR(SYSDATE,'DD-Mon-YYYY HH24:MI:SS') date_ FROM dual;
sho ERRORS 
spo OFF
