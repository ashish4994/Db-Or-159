/*

  Script:      601_ACHatCas_ACCT159_PKG_RO
  Schema:      ACH
  Author:      Cristhian Caro
  Date:        02/03/2021
  Purpose:     Insert Source and Bank name in the ACH transactions audit table

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

ALTER SESSION SET CURRENT_SCHEMA = ACH;

ALTER SESSION SET EDITION = ORA$BASE;

SELECT 'current user is ' || USER || ' at ' FROM dual;

SELECT TO_CHAR(SYSDATE,'DD-Mon-YYYY HH24:MI:SS') date_ FROM dual;

@PKG_ACH_TRANSACTION_P.sql;
sho ERRORS

CREATE OR REPLACE EDITIONABLE PUBLIC SYNONYM "PKG_ACH_TRANSACTION" FOR "ACH"."PKG_ACH_TRANSACTION_P";
sho ERRORS

SELECT TO_CHAR(SYSDATE,'DD-Mon-YYYY HH24:MI:SS') date_ FROM dual;
sho ERRORS
spo OFF