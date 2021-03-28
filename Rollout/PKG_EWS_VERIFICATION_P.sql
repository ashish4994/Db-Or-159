CREATE OR REPLACE PACKAGE PKG_EWS_VERIFICATION_P AS

  /*****************************************************************************************
  * Procedure: PR_INSERT
  * Created  : 11/19/2020
  * Author   : JJERATH
  * Purpose  : Stored procedure responsible for inserting EWS request, response and other details
  *
  *****************************************CHANGE LOG**************************************
  *   DATE          WHO          DESCRIPTION
  * 11/19/2020      JJERATH      ACCT-159: Initial implementation
  *
  *****************************************************************************************/
  PROCEDURE PR_INSERT(P_CLIENT_REC_ID       IN T_EWS_VERIFICATION.CLIENT_REC_ID%TYPE,
                      P_EWS_REQUEST         IN T_EWS_VERIFICATION.EWS_REQUEST%TYPE,
                      P_EWS_RESPONSE        IN T_EWS_VERIFICATION.EWS_RESPONSE%TYPE,
                      P_CHANNEL             IN T_LU_EWS_VERIFICATION_CHANNEL.CHANNEL%TYPE,
                      P_CREDIT_ACCOUNT_ID   IN T_EWS_VERIFICATION_ACCOUNT.CREDIT_ACCOUNT_ID%TYPE,
                      P_TRANSACTION_ID      IN T_EWS_VERIFICATION.TRANSACTION_ID%TYPE,
                      P_IS_SUCCESS          IN T_EWS_VERIFICATION.IS_SUCCESS%TYPE,
                      P_ERROR_CD            IN T_EWS_VERIFICATION_EXCEPTION.ERROR_CD%TYPE,
                      P_IS_EWS_SYSTEM_ERROR IN T_EWS_VERIFICATION_EXCEPTION.IS_EWS_SYSTEM_ERROR%TYPE,
                      P_EXCEPTION_MESSAGE   IN T_EWS_VERIFICATION_EXCEPTION.EXCEPTION_MESSAGE%TYPE,
                      P_ACCOUNT_NUMBER      IN VARCHAR2,
                      P_ROUTING_NUMBER      IN VARCHAR2,
                      P_EWS_VERIFICATION_ID OUT T_EWS_VERIFICATION.EWS_VERIFICATION_ID%TYPE);

  /*****************************************************************************************
  * Procedure: PR_GET_EWS_STATE_BY_CREDIT_ACCOUNT_ID
  * Created  : 01/05/2021
  * Author   : CGOMEZ
  * Purpose  : Stored procedure responsible for check if ews verification is success for a specific bank account.
  *
  *****************************************CHANGE LOG**************************************
  *   DATE          WHO          DESCRIPTION
  * 01/05/2021     CGOMEZ      INITIAL RELEASE
  *
  *****************************************************************************************/
  PROCEDURE PR_GET_EWS_STATE_BY_CREDIT_ACCOUNT_ID(P_CREDIT_ACCOUNT_ID IN T_EWS_VERIFICATION_ACCOUNT.CREDIT_ACCOUNT_ID%TYPE,
                                                  P_ACCOUNT_NUMBER    IN VARCHAR2,
                                                  P_ROUTING_NUMBER    IN VARCHAR2,
                                                  REF_CURSOR          OUT SYS_REFCURSOR);

END PKG_EWS_VERIFICATION_P;
/

CREATE OR REPLACE PACKAGE BODY PKG_EWS_VERIFICATION_P AS

  /*****************************************************************************************
  * Procedure: PR_INSERT
  * Created  : 11/19/2020
  * Author   : JJERATH
  * Purpose  : Stored procedure responsible for inserting EWS request, response and other details
  *
  *****************************************CHANGE LOG**************************************
  *   DATE          WHO          DESCRIPTION
  * 11/19/2020      JJERATH      ACCT-159: Initial implementation
  *
  *****************************************************************************************/
  PROCEDURE PR_INSERT(P_CLIENT_REC_ID       IN T_EWS_VERIFICATION.CLIENT_REC_ID%TYPE,
                      P_EWS_REQUEST         IN T_EWS_VERIFICATION.EWS_REQUEST%TYPE,
                      P_EWS_RESPONSE        IN T_EWS_VERIFICATION.EWS_RESPONSE%TYPE,
                      P_CHANNEL             IN T_LU_EWS_VERIFICATION_CHANNEL.CHANNEL%TYPE,
                      P_CREDIT_ACCOUNT_ID   IN T_EWS_VERIFICATION_ACCOUNT.CREDIT_ACCOUNT_ID%TYPE,
                      P_TRANSACTION_ID      IN T_EWS_VERIFICATION.TRANSACTION_ID%TYPE,
                      P_IS_SUCCESS          IN T_EWS_VERIFICATION.IS_SUCCESS%TYPE,
                      P_ERROR_CD            IN T_EWS_VERIFICATION_EXCEPTION.ERROR_CD%TYPE,
                      P_IS_EWS_SYSTEM_ERROR IN T_EWS_VERIFICATION_EXCEPTION.IS_EWS_SYSTEM_ERROR%TYPE,
                      P_EXCEPTION_MESSAGE   IN T_EWS_VERIFICATION_EXCEPTION.EXCEPTION_MESSAGE%TYPE,
                      P_ACCOUNT_NUMBER      IN  VARCHAR2,
                      P_ROUTING_NUMBER      IN  VARCHAR2,
                      P_EWS_VERIFICATION_ID OUT T_EWS_VERIFICATION.EWS_VERIFICATION_ID%TYPE) IS

    V_SEQ_EWS_VERIFICATION_ID NUMBER := SEQ_EWS_VERIFICATION_ID.NEXTVAL;
    V_CHANNEL_ID              NUMBER;
    ALT_EXCEPTION_MESSAGE T_EWS_VERIFICATION_EXCEPTION.EXCEPTION_MESSAGE%TYPE :=P_EXCEPTION_MESSAGE;
	
  BEGIN

     SELECT CHANNEL_ID
      INTO V_CHANNEL_ID
      FROM T_LU_EWS_VERIFICATION_CHANNEL
     WHERE CHANNEL IN (P_CHANNEL);

    INSERT INTO T_EWS_VERIFICATION
      (EWS_VERIFICATION_ID,
       CLIENT_REC_ID,
       CHANNEL_ID,
       POST_DATE,
       TRANSACTION_ID,
       IS_SUCCESS,
       EWS_RESPONSE,
       EWS_REQUEST,
       ACCOUNT_NUMBER,
       ROUTING_NUMBER)
    VALUES
      (V_SEQ_EWS_VERIFICATION_ID,
       P_CLIENT_REC_ID,
       V_CHANNEL_ID,
       sysdate,
       P_TRANSACTION_ID,
       P_IS_SUCCESS,
       P_EWS_RESPONSE,
       P_EWS_REQUEST,
       PKG_CRYPTO.EncryptIt(TO_CLOB(P_ACCOUNT_NUMBER)),
       PKG_CRYPTO.EncryptIt(TO_CLOB(P_ROUTING_NUMBER)));



    IF P_CHANNEL <> 'Application' THEN

      INSERT INTO T_EWS_VERIFICATION_ACCOUNT
        (EWS_VERIFICATION_ACCOUNT_ID,
         EWS_VERIFICATION_ID,
         CREDIT_ACCOUNT_ID)
      VALUES
        (SEQ_EWS_VERIFICATION_ACCOUNT_ID.NEXTVAL,
         V_SEQ_EWS_VERIFICATION_ID,
         P_CREDIT_ACCOUNT_ID);
    ELSE
      INSERT INTO T_EWS_VERIFICATION_APPLICATION
        (EWS_VERIFICATION_APPLICATION_ID, EWS_VERIFICATION_ID)
      VALUES
        (SEQ_EWS_VERIFICATION_ACCOUNT_ID.NEXTVAL,
         V_SEQ_EWS_VERIFICATION_ID);
    END IF;

    IF P_IS_SUCCESS = '0' THEN
      INSERT INTO T_EWS_VERIFICATION_EXCEPTION
        (EWS_VERIFICATION_EXCEPTION_ID,
         ERROR_CD,
         EXCEPTION_MESSAGE,
         EWS_VERIFICATION_ID,
         IS_EWS_SYSTEM_ERROR)
      VALUES
        (SEQ_EWS_VERIFICATION_EXCEPTION_ID.NEXTVAL,
         P_ERROR_CD,
         ALT_EXCEPTION_MESSAGE,
         V_SEQ_EWS_VERIFICATION_ID,
         P_IS_EWS_SYSTEM_ERROR);
    END IF;
  P_EWS_VERIFICATION_ID := V_SEQ_EWS_VERIFICATION_ID;
	COMMIT;
  END;

  /*****************************************************************************************
  * Procedure: PR_GET_EWS_STATE_BY_CREDIT_ACCOUNT_ID
  * Created  : 01/05/2021
  * Author   : CGOMEZ
  * Purpose  : Stored procedure responsible for check if ews verification is success for a specific bank account.
  *
  *****************************************CHANGE LOG**************************************
  *   DATE          WHO          DESCRIPTION
  * 01/05/2021     CGOMEZ      INITIAL RELEASE
  *
  *****************************************************************************************/
  PROCEDURE PR_GET_EWS_STATE_BY_CREDIT_ACCOUNT_ID
            (P_CREDIT_ACCOUNT_ID IN T_EWS_VERIFICATION_ACCOUNT.CREDIT_ACCOUNT_ID%TYPE,
             P_ACCOUNT_NUMBER    IN  VARCHAR2,
             P_ROUTING_NUMBER    IN  VARCHAR2,
             REF_CURSOR OUT SYS_REFCURSOR) IS
             
  BEGIN
    OPEN REF_CURSOR FOR
    
      SELECT ews.EWS_VERIFICATION_ID,
             ews.CLIENT_REC_ID,
             ews.CHANNEL_ID,
             ews.POST_DATE,
             ews.TRANSACTION_ID,
             ews.IS_SUCCESS,
             ews.EWS_RESPONSE,
             ews.EWS_REQUEST,
             dbms_lob.substr( PKG_CRYPTO.UnEncryptIt(ACCOUNT_NUMBER), 50, 1) ACCOUNT_NUMBER,
             dbms_lob.substr( PKG_CRYPTO.UnEncryptIt(ROUTING_NUMBER), 50, 1) ROUTING_NUMBER
        FROM T_EWS_VERIFICATION_ACCOUNT acc
       INNER JOIN T_EWS_VERIFICATION ews
          ON ews.EWS_VERIFICATION_ID = acc.EWS_VERIFICATION_ID
       WHERE acc.CREDIT_ACCOUNT_ID = P_CREDIT_ACCOUNT_ID
         AND dbms_lob.compare(ews.ACCOUNT_NUMBER,PKG_CRYPTO.EncryptIt(TO_CLOB(P_ACCOUNT_NUMBER))) = 0
          AND dbms_lob.compare(ews.ROUTING_NUMBER, PKG_CRYPTO.EncryptIt(TO_CLOB(P_ROUTING_NUMBER))) = 0
          AND ews.IS_SUCCESS = '1';
        
  END PR_GET_EWS_STATE_BY_CREDIT_ACCOUNT_ID;

END PKG_EWS_VERIFICATION_P;
/
