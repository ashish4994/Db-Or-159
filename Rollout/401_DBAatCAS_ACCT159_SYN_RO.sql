/*

  Script:      401_DBAatCAS_ACCT159_SYN_RO
  Schema:      ACCOUNT
  Author:      Jyoti Jerath
  Date:        11/19/2020
  Purpose:     Synonym PKG_EWS_VERIFICATION point to PKG_EWS_VERIFICATION_P

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

CREATE OR REPLACE EDITIONABLE PUBLIC SYNONYM PKG_EWS_VERIFICATION FOR ACCOUNT.PKG_EWS_VERIFICATION_P;
sho ERRORS

SELECT TO_CHAR(SYSDATE,'DD-Mon-YYYY HH24:MI:SS') date_ FROM dual;
sho ERRORS 
spo OFF 

