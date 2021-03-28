/*
  Script:      INS_T_LU_EWS_VERIFICATION_CHANNEL
  Schema:	    ACCOUNT
  Author:      Jyoti Jerath
  Date:        11/19/2020
  Purpose:     insert the channel information
*****************************************************************************/

DECLARE
    V_COUNT NUMBER;
   
BEGIN

SELECT COUNT(1)
INTO V_COUNT
FROM T_LU_EWS_VERIFICATION_CHANNEL
WHERE CHANNEL IN ('Web');

IF V_COUNT = 0 THEN

INSERT INTO T_LU_EWS_VERIFICATION_CHANNEL
(CHANNEL_ID, CHANNEL)
VALUES
(SEQ_CHANNEL_ID.Nextval, 'Web');
END IF;

SELECT COUNT(1)
INTO V_COUNT
FROM T_LU_EWS_VERIFICATION_CHANNEL
WHERE CHANNEL IN ('Mobile');

IF V_COUNT = 0 THEN

INSERT INTO T_LU_EWS_VERIFICATION_CHANNEL
(CHANNEL_ID, CHANNEL)
VALUES
(SEQ_CHANNEL_ID.Nextval, 'Mobile');  
END IF;

SELECT COUNT(1)
INTO V_COUNT
FROM T_LU_EWS_VERIFICATION_CHANNEL
WHERE CHANNEL IN ('CAS');

IF V_COUNT = 0 THEN

INSERT INTO T_LU_EWS_VERIFICATION_CHANNEL
(CHANNEL_ID, CHANNEL)
VALUES
(SEQ_CHANNEL_ID.Nextval, 'CAS');
END IF;

SELECT COUNT(1)
INTO V_COUNT
FROM T_LU_EWS_VERIFICATION_CHANNEL
WHERE CHANNEL IN ('Application');

IF V_COUNT = 0 THEN

INSERT INTO T_LU_EWS_VERIFICATION_CHANNEL
(CHANNEL_ID, CHANNEL)
VALUES
(SEQ_CHANNEL_ID.Nextval, 'Application');
END IF;


SELECT COUNT(1)
INTO V_COUNT
FROM T_LU_EWS_VERIFICATION_CHANNEL
WHERE CHANNEL IN ('Unknown');

IF V_COUNT = 0 THEN

INSERT INTO T_LU_EWS_VERIFICATION_CHANNEL
(CHANNEL_ID, CHANNEL)
VALUES
(SEQ_CHANNEL_ID.Nextval, 'Unknown');
END IF;


  COMMIT;
END;
/