CREATE OR REPLACE PACKAGE pkg_ach_transaction_p AS

    FUNCTION fn_get_individual_identifier(P_requestor_Id          IN ach_request_interface.requestor_id%TYPE,
                                          p_individual_identifier IN ach_request_interface.individual_identifier%TYPE)
        RETURN VARCHAR2;

    /******************************************************************************
    *
    *  TITLE:        fn_get_individual_identifier
    *  SCHEMA OWNER: ach
    *  CREATED:      03/23/2017
    *  AUTHOR:       BJ  Perna
    *
    *  DESCRIPTION:
    *
    * MODIFICATIONS:
    * DATE         VERSION        WHO              DESCRIPTION
    * 03/23/2017   WO113096       BJ Perna         INITIAL RELEASE - Overload with name parameter.
    *
    ******************************************************************************/
    FUNCTION fn_get_individual_identifier(p_requestor_id          IN ach_request_interface.requestor_id%TYPE,
                                          p_individual_identifier IN ach_request_interface.individual_identifier%TYPE,
                                          p_individual_name       IN ach_request_interface.first_name%TYPE)
        RETURN VARCHAR2;

    /******************************************************************************
    *
    *  TITLE:        pr_insert
    *  SCHEMA OWNER:  ach
    *  CREATED:      07/29/2014
    *  AUTHOR:       IHOWLADER
    *
    *  DESCRIPTION:
    *
    * MODIFICATIONS:
    * DATE         VERSION        WHO              DESCRIPTION
    * 07/29/2014    Risk-158    IHOWLADER            INITIAL RELEASE
    *
    ******************************************************************************/
    PROCEDURE pr_insert(p_sec_code              IN ach_request_interface.sec_code%TYPE,
                        p_ach_amount            IN ach_request_interface.ach_amount%TYPE,
                        p_transaction_code      IN ach_request_interface.transaction_code%TYPE,
                        p_bank_account_number   IN ach_request_interface.checking_account%TYPE,
                        p_bank_aba              IN ach_request_interface.aba_num%TYPE,
                        p_individual_name       IN ach_request_interface.first_name%TYPE,
                        p_individual_identifier IN ach_request_interface.individual_identifier%TYPE DEFAULT NULL,
                        p_account_type_id       IN ach_request_interface.account_type_id%TYPE,
                        p_requestor_id          IN ach_request_interface.requestor_id%TYPE,
                        p_credit_account_id     IN t_card.credit_account_id%TYPE,
                        p_ach_entry_date        IN ach_request_interface.ach_entry_date%TYPE,
                        p_ach_post_date         IN ach_request_interface.Ach_Post_Date%TYPE,
                        p_ach_source         	IN ach_request_interface.ach_source%TYPE,
                        p_bank_name         	IN ach_request_interface.bank_name%TYPE,						
                        p_request_id            OUT ach_request_interface.request_id%TYPE);
    /******************************************************************************
    *
    *  TITLE:        pr_update
    *  SCHEMA OWNER:  ach
    *  CREATED:      09/26/2014
    *  AUTHOR:       IHOWLADER
    *
    *  DESCRIPTION:
    *
    * MODIFICATIONS:
    * DATE         VERSION        WHO              DESCRIPTION
    * 07/29/2014    Risk-158    IHOWLADER            INITIAL RELEASE
    *
    ******************************************************************************/
    PROCEDURE pr_update(p_sec_code            IN ach_request_interface.sec_code%TYPE,
                        p_ach_amount          IN ach_request_interface.ach_amount%TYPE,
                        p_transaction_code    IN ach_request_interface.transaction_code%TYPE,
                        p_bank_account_number IN ach_request_interface.checking_account%TYPE,
                        p_bank_aba            IN ach_request_interface.aba_num%TYPE,
                        p_individual_name     IN ach_request_interface.first_name%TYPE,
                        p_account_type_id     IN ach_request_interface.account_type_id%TYPE,
                        p_requestor_id        IN ach_request_interface.requestor_id%TYPE,
                        p_credit_account_id   IN t_card.credit_account_id%TYPE,
                        p_ach_entry_date      IN ach_request_interface.ach_entry_date%TYPE,
                        p_ach_post_date       IN ach_request_interface.Ach_Post_Date%TYPE,
                        p_status              IN ach_request_interface.status%TYPE,
                        p_request_id          IN ach_request_interface.request_id%TYPE);

    /******************************************************************************
    *
    *  TITLE:        pr_get
    *  SCHEMA OWNER:  ach
    *  CREATED:      07/29/2014
    *  AUTHOR:       IHOWLADER
    *
    *  DESCRIPTION:
    *
    * MODIFICATIONS:
    * DATE         VERSION        WHO              DESCRIPTION
    * 07/29/2014    Risk-158    IHOWLADER            INITIAL RELEASE
    *
    ******************************************************************************/
    PROCEDURE pr_get(p_request_id IN ach_request_interface.request_id%TYPE,
                     ref_cursor   OUT SYS_REFCURSOR);

    /******************************************************************************
    *
    *  TITLE:        pr_get_number_qualified_trans
    *  SCHEMA OWNER:  ach
    *  CREATED:      09/17/2014
    *  AUTHOR:       IHOWLADER
    *
    *  DESCRIPTION:
    *
    * MODIFICATIONS:
    * DATE         VERSION        WHO              DESCRIPTION
    * 07/29/2014    Risk-158    IHOWLADER            INITIAL RELEASE
    * 02/06/2015    WO67423     Ihowlader            Removed the hard coded values for 
                                                     saving and checking account ids.
                                                                             
    ******************************************************************************/
    PROCEDURE pr_get_number_qualified_trans(p_begin_date             IN ach_request_interface_01.ach_post_date%TYPE,
                                            p_credit_account_id      IN t_card.credit_account_id%TYPE,
                                            p_aba                    IN ach_request_interface_01.aba_num%TYPE,
                                            p_bank_account_number    IN ach_request_interface_01.checking_account%TYPE,
                                            p_bank_account_type_code IN ach_account_type.account_type_code%TYPE,
                                            p_number_qualified       OUT NUMBER);


    /******************************************************************************
    *
    *  TITLE:        pr_get_last_qualified_date
    *  SCHEMA OWNER:  ach
    *  CREATED:      09/17/2014
    *  AUTHOR:       IHOWLADER
    *
    *  DESCRIPTION:
    *
    * MODIFICATIONS:
    * DATE         VERSION        WHO              DESCRIPTION
    * 07/29/2014    Risk-158    IHOWLADER            INITIAL RELEASE
     * 02/06/2015    WO67423     Ihowlader            Removed the hard coded values for 
                                                     saving and checking account ids.
    ******************************************************************************/
    PROCEDURE pr_get_last_qualified_date(p_days_old               IN NUMBER,
                                         p_credit_account_id      IN t_card.credit_account_id%TYPE,
                                         p_aba                    IN ach_request_interface_01.aba_num%TYPE,
                                         p_bank_number            IN ach_request_interface_01.checking_account%TYPE,
                                         p_bank_account_type_code IN ach_account_type.account_type_code%TYPE,
                                         p_last_qualified_date    OUT DATE);


END pkg_ach_transaction_p;
/
CREATE OR REPLACE PACKAGE BODY pkg_ach_transaction_p AS

    FUNCTION fn_get_individual_identifier(P_requestor_Id          IN ach_request_interface.requestor_id%TYPE,
                                          p_individual_identifier IN ach_request_interface.individual_identifier%TYPE)
        RETURN VARCHAR2 IS
        v_indi_identy VARCHAR2(15);
    
    
    BEGIN
    
        IF p_individual_identifier IS NOT NULL THEN
            v_indi_identy := p_individual_identifier;
        
        ELSIF P_requestor_Id = '2' THEN
            SELECT LPAD(Digit_Code, 2, ' ') ||
                   LPAD(TO_CHAR(Ind_Id_Seq.NEXTVAL), 13, '0')
              INTO v_indi_identy
              FROM REQUESTOR R
             WHERE R.REQUESTOR_ID = P_requestor_Id;
        ELSE
            SELECT LPAD(TO_CHAR(Ind_Id_Seq.NEXTVAL), 15, '0')
              INTO v_indi_identy
              FROM DUAL;
        END IF;
        RETURN v_indi_identy;
    END;

    /******************************************************************************
    *
    *  TITLE:        fn_get_individual_identifier
    *  SCHEMA OWNER: ach
    *  CREATED:      03/23/2017
    *  AUTHOR:       BJ  Perna
    *
    *  DESCRIPTION:
    *
    * MODIFICATIONS:
    * DATE         VERSION        WHO              DESCRIPTION
    * 03/23/2017   WO113096       BJ Perna         INITIAL RELEASE - Overload with name parameter.
    *
    ******************************************************************************/
    FUNCTION fn_get_individual_identifier(p_requestor_id          IN ach_request_interface.requestor_id%TYPE,
                                          p_individual_identifier IN ach_request_interface.individual_identifier%TYPE,
                                          p_individual_name       IN ach_request_interface.first_name%TYPE)
        RETURN VARCHAR2 IS
        v_indi_identy VARCHAR2(15);
    
    
    BEGIN
    
        IF p_requestor_id = '7' THEN
            v_indi_identy := substr(p_individual_name, 1, 15);
        ELSIF p_individual_identifier IS NOT NULL THEN
            v_indi_identy := p_individual_identifier;
        ELSIF P_requestor_Id = '2' THEN
            SELECT LPAD(Digit_Code, 2, ' ') ||
                   LPAD(TO_CHAR(Ind_Id_Seq.NEXTVAL), 13, '0')
              INTO v_indi_identy
              FROM REQUESTOR R
             WHERE R.REQUESTOR_ID = P_requestor_Id;
        ELSE
            SELECT LPAD(TO_CHAR(Ind_Id_Seq.NEXTVAL), 15, '0')
              INTO v_indi_identy
              FROM DUAL;
        END IF;
        RETURN v_indi_identy;
    END;

    /******************************************************************************
    *
    *  TITLE:        pr_insert
    *  SCHEMA OWNER:  ach
    *  CREATED:      07/29/2014
    *  AUTHOR:       IHOWLADER
    *
    *  DESCRIPTION:
    *
    * MODIFICATIONS:
    * DATE         VERSION        WHO              DESCRIPTION
    * 07/29/2014    Risk-158    IHOWLADER            INITIAL RELEASE
    *
    ******************************************************************************/
    PROCEDURE pr_insert(p_sec_code              IN ach_request_interface.sec_code%TYPE,
                        p_ach_amount            IN ach_request_interface.ach_amount%TYPE,
                        p_transaction_code      IN ach_request_interface.transaction_code%TYPE,
                        p_bank_account_number   IN ach_request_interface.checking_account%TYPE,
                        p_bank_aba              IN ach_request_interface.aba_num%TYPE,
                        p_individual_name       IN ach_request_interface.first_name%TYPE,
                        p_individual_identifier IN ach_request_interface.individual_identifier%TYPE DEFAULT NULL,
                        p_account_type_id       IN ach_request_interface.account_type_id%TYPE,
                        p_requestor_id          IN ach_request_interface.requestor_id%TYPE,
                        p_credit_account_id     IN t_card.credit_account_id%TYPE,
                        p_ach_entry_date        IN ach_request_interface.ach_entry_date%TYPE,
                        p_ach_post_date         IN ach_request_interface.Ach_Post_Date%TYPE,
						p_ach_source         	IN ach_request_interface.ach_source%TYPE,
                        p_bank_name         	IN ach_request_interface.bank_name%TYPE,						
                        p_request_id            OUT ach_request_interface.request_id%TYPE) IS
        v_card_num              varchar2(19);
        v_flag_forward_dated    NUMBER;
        v_individual_identifier ach_request_interface.individual_identifier%TYPE;
    
    BEGIN
    
        SELECT c.card_num
          INTO v_card_num
          FROM t_card c
         WHERE c.credit_account_id = p_credit_account_id
           AND c.current_card = 1;
    
        IF p_ach_post_date > p_ach_entry_date THEN
            v_flag_forward_dated := 1;
        ELSE
            v_flag_forward_dated := 0;
        END IF;
    
    
        v_individual_identifier := fn_get_individual_identifier(p_requestor_id,
                                                                p_individual_identifier,
                                                                p_individual_name);
    
    
    
    
        INSERT INTO ach_request_interface
            (requestor_id,
             card_id,
             aba_num,
             checking_account,
             ach_amount,
             transaction_reference,
             sec_code,
             acc_type,
             first_name,
             last_name,
             ach_entry_date,
             ach_post_date,
             batch_number,
             status,
             status_update_date,
             message,
             processed_date,
             misc_1_data,
             misc_2_data,
             misc_3_data,
             misc_4_data,
             misc_5_data,
             misc_6_data,
             misc_7_data,
             misc_8_data,
             misc_9_data,
             misc_10_data,
             misc_11_data,
             misc_12_data,
             last_update_date,
             user_id,
             request_id,
             individual_identifier,
             entry_type,
             tran_id,
             detail_id,
             transaction_code,
             tran_id_ret,
             ach_source,
             ach_fee,
             suppressionoverride,
             exposureoverride,
             letterneeded,
             bank_name,
             cust_phone,
             agency_name,
             fdr_status,
             fdr_load_date,
             letter_sent_date,
             agency_upload_status,
             agency_upload_date,
             post_flag,
             account_type_id,
             sync_ach_pymt_dt,
             sync_ach_reg_dt,
             expr_fee_credit,
             flag_forward_dated,
             checking_acct_number,
             source_account_last4)
        VALUES
            (p_requestor_id,
             (SELECT c.card_id FROM t_card c WHERE c.card_num = v_card_num),
             p_bank_aba,
             p_bank_account_number,
             p_ach_amount,
             NULL,
             p_sec_code,
             NULL,
             p_individual_name,
             NULL,
             p_ach_entry_date,
             p_ach_post_date,
             NULL,
             'Pending',
             NULL,
             NULL,
             NULL,
             NULL,
             NULL,
             NULL,
             NULL,
             NULL,
             NULL,
             NULL,
             NULL,
             NULL,
             NULL,
             NULL,
             NULL,
             NULL,
             NULL,
             Request_Id_Seq.Nextval,
             v_individual_identifier,
             NULL,
             fnbm_seq.nextval,
             NULL,
             p_transaction_code,
             NULL,
             p_ach_source,
             NULL,
             NULL,
             NULL,
             NULL,
             p_bank_name,
             NULL,
             NULL,
             NULL,
             NULL,
             NULL,
             NULL,
             NULL,
             NULL,
             p_account_type_id,
             NULL,
             NULL,
             NULL,
             v_flag_forward_dated,
             Fn_Convert_Check_Acct_Num(p_bank_account_number),
             NULL)
        RETURNING request_id INTO p_request_id;
        COMMIT;
    END pr_insert;

    /******************************************************************************
    *
    *  TITLE:        pr_update
    *  SCHEMA OWNER:  ach
    *  CREATED:      09/26/2014
    *  AUTHOR:       IHOWLADER
    *
    *  DESCRIPTION:
    *
    * MODIFICATIONS:
    * DATE         VERSION        WHO              DESCRIPTION
    * 07/29/2014    Risk-158    IHOWLADER            INITIAL RELEASE
    *
    ******************************************************************************/
    PROCEDURE pr_update(p_sec_code            IN ach_request_interface.sec_code%TYPE,
                        p_ach_amount          IN ach_request_interface.ach_amount%TYPE,
                        p_transaction_code    IN ach_request_interface.transaction_code%TYPE,
                        p_bank_account_number IN ach_request_interface.checking_account%TYPE,
                        p_bank_aba            IN ach_request_interface.aba_num%TYPE,
                        p_individual_name     IN ach_request_interface.first_name%TYPE,
                        p_account_type_id     IN ach_request_interface.account_type_id%TYPE,
                        p_requestor_id        IN ach_request_interface.requestor_id%TYPE,
                        p_credit_account_id   IN t_card.credit_account_id%TYPE,
                        p_ach_entry_date      IN ach_request_interface.ach_entry_date%TYPE,
                        p_ach_post_date       IN ach_request_interface.Ach_Post_Date%TYPE,
                        p_status              IN ach_request_interface.status%TYPE,
                        p_request_id          IN ach_request_interface.request_id%TYPE) IS
        v_card_num NUMBER;
    BEGIN
    
        SELECT c.card_num
          INTO v_card_num
          FROM t_card c
         WHERE c.credit_account_id = p_credit_account_id
           AND c.current_card = 1;
    
        UPDATE ach_request_interface ari
           SET ari.sec_code             = p_sec_code,
               ari.ach_amount           = p_ach_amount,
               ari.transaction_code     = p_transaction_code,
               ari.checking_account     = p_bank_account_number,
               ari.aba_num              = p_bank_aba,
               ari.first_name           = p_individual_name,
               ari.account_type_id      = p_account_type_id,
               ari.requestor_id         = p_requestor_id,
               ari.card_id              = (SELECT c.card_id FROM t_card c WHERE c.card_num = v_card_num),
               ari.status               = p_status,
               ari.ach_entry_date       = p_ach_entry_date,
               ari.ach_post_date        = p_ach_post_date,
               ari.checking_acct_number = Fn_Convert_Check_Acct_Num(p_bank_account_number)
         WHERE ari.request_id = p_request_id;
        COMMIT;
    END pr_update;


    /******************************************************************************
    *
    *  TITLE:        pr_get
    *  SCHEMA OWNER:  ach
    *  CREATED:      07/29/2014
    *  AUTHOR:       IHOWLADER
    *
    *  DESCRIPTION:
    *
    * MODIFICATIONS:
    * DATE         VERSION        WHO              DESCRIPTION
    * 07/29/2014    Risk-158    IHOWLADER            INITIAL RELEASE
    *
    ******************************************************************************/
    PROCEDURE pr_get(p_request_id IN ach_request_interface.request_id%TYPE,
                     ref_cursor   OUT SYS_REFCURSOR) IS
    BEGIN
        OPEN ref_cursor FOR
            SELECT ari.*,
                   c.credit_account_id
              FROM ach_request_interface ari,
                   t_card                c,
                   ach_account_type      at
             WHERE ari.card_id = c.card_id
               AND ari.account_type_id = at.account_type_id
               AND ari.request_id = p_request_id;
    END pr_get;
    /******************************************************************************
    *
    *  TITLE:        pr_get_number_qualified_trans
    *  SCHEMA OWNER:  ach
    *  CREATED:      09/17/2014
    *  AUTHOR:       IHOWLADER
    *
    *  DESCRIPTION:
    *
    * MODIFICATIONS:
    * DATE         VERSION        WHO              DESCRIPTION
    * 07/29/2014    Risk-158    IHOWLADER            INITIAL RELEASE
     * 02/06/2015    WO67423     Ihowlader            Removed the hard coded values for 
                                                     saving and checking account ids.
    ******************************************************************************/
    PROCEDURE pr_get_number_qualified_trans(p_begin_date             IN ach_request_interface_01.ach_post_date%TYPE,
                                            p_credit_account_id      IN t_card.credit_account_id%TYPE,
                                            p_aba                    IN ach_request_interface_01.aba_num%TYPE,
                                            p_bank_account_number    IN ach_request_interface_01.checking_account%TYPE,
                                            p_bank_account_type_code IN ach_account_type.account_type_code%TYPE,
                                            p_number_qualified       OUT NUMBER) IS
    
        V_Processed          VARCHAR2(10) := 'Processed';
        V_Pending            VARCHAR2(10) := 'Pending';
        V_CCWEB_express      VARCHAR2(20) := 'CCWEB_express';
        V_CCWEB              VARCHAR2(20) := 'CCWEB';
        V_CCWEB_Mobile       VARCHAR2(20) := 'CCWEB_Mobile';
        V_Mobile_App         VARCHAR2(20) := 'Mobile_App';	
        V_TRANSACTION_CODE27 VARCHAR2(2) := '27';
        V_TRANSACTION_CODE37 VARCHAR2(2) := '37';
        V_ACCOUNT_TYPE_ID    NUMBER;
        V_CARD_ID            t_card.card_id%TYPE;
    BEGIN
        SELECT at.account_type_id
          INTO V_ACCOUNT_TYPE_ID
          FROM ach_account_type at
         WHERE at.account_type_code = p_bank_account_type_code;
    
        SELECT c.card_id
          INTO V_CARD_ID
          FROM t_card c
         WHERE c.credit_account_id = p_credit_account_id
           AND c.current_card = 1;
    
        SELECT nvl(COUNT(1), 0)
          INTO p_number_qualified
          FROM ach_request_interface_01 ari
         WHERE ari.card_id = V_CARD_ID
           AND ari.account_type_id = V_ACCOUNT_TYPE_ID
           AND ari.aba_num = p_aba
           AND ari.checking_account = p_bank_account_number
           AND ari.status IN (V_Processed, V_Pending)
           AND ari.ach_source IN (V_CCWEB_express, V_CCWEB, V_CCWEB_Mobile, V_Mobile_App)
           AND ari.ach_post_date >= p_begin_date
           AND ari.transaction_code IN
               (V_TRANSACTION_CODE27, V_TRANSACTION_CODE37);
    
    END pr_get_number_qualified_trans;


    /******************************************************************************
    *
    *  TITLE:        pr_get_last_qualified_date
    *  SCHEMA OWNER:  ach
    *  CREATED:      09/17/2014
    *  AUTHOR:       IHOWLADER
    *
    *  DESCRIPTION:
    *
    * MODIFICATIONS:
    * DATE         VERSION        WHO              DESCRIPTION
    * 07/29/2014    Risk-158    IHOWLADER            INITIAL RELEASE
     * 02/06/2015    WO67423     Ihowlader            Removed the hard coded values for 
                                                     saving and checking account ids.
    ******************************************************************************/
    PROCEDURE pr_get_last_qualified_date(p_days_old               IN NUMBER,
                                         p_credit_account_id      IN t_card.credit_account_id%TYPE,
                                         p_aba                    IN ach_request_interface_01.aba_num%TYPE,
                                         p_bank_number            IN ach_request_interface_01.checking_account%TYPE,
                                         p_bank_account_type_code IN ach_account_type.account_type_code%TYPE,
                                         p_last_qualified_date    OUT DATE) IS
        V_Processed          VARCHAR2(10) := 'Processed';
        V_CCWEB_express      VARCHAR2(20) := 'CCWEB_express';
        V_CCWEB              VARCHAR2(20) := 'CCWEB';
        V_CCWEB_Mobile       VARCHAR2(20) := 'CCWEB_Mobile';
        V_Mobile_App         VARCHAR2(20) := 'Mobile_App';
        V_TRANSACTION_CODE27 VARCHAR2(2) := '27';
        V_TRANSACTION_CODE37 VARCHAR2(2) := '37';
        V_ACCOUNT_TYPE_ID    NUMBER;
        V_CARD_NUM           VARCHAR2(19);
    BEGIN
        SELECT at.account_type_id
          INTO V_ACCOUNT_TYPE_ID
          FROM ach_account_type at
         WHERE at.account_type_code = p_bank_account_type_code;
        SELECT c.card_num
          INTO V_CARD_NUM
          FROM t_card c
         WHERE c.credit_account_id = p_credit_account_id
           AND c.current_card = 1;
    
        SELECT MAX(ari.ach_post_date)
          INTO p_last_qualified_date
          FROM ach_request_interface_01 ari,
               t_card                   c
         WHERE ari.card_id = c.card_id
           AND c.card_num = V_CARD_NUM
           AND ari.account_type_id = V_ACCOUNT_TYPE_ID
           AND ari.aba_num = p_aba
           AND ari.checking_account = p_bank_number
           AND ari.status = V_Processed
           AND ari.ach_source IN (V_CCWEB_express, V_CCWEB, V_CCWEB_Mobile, V_Mobile_App)
           AND ari.ach_post_date >= trunc(SYSDATE - p_days_old)
           AND ari.transaction_code IN
               (V_TRANSACTION_CODE27, V_TRANSACTION_CODE37);
    
    
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            p_last_qualified_date := NULL;
    END pr_get_last_qualified_date;

END pkg_ach_transaction_p;
/
GRANT EXECUTE ON ACH.pkg_ach_transaction_p TO DLSRVC;