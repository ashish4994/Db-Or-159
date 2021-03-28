CREATE OR REPLACE PACKAGE pkg_bank_acc_verification_p AS

    /******************************************************************************
    *
    *  TITLE:        pr_get_for_credit_account
    *  SCHEMA OWNER:  account
    *  CREATED:      07/29/2014
    *  AUTHOR:       IHOWLADER
    *
    *  DESCRIPTION: This procedure will retrive the  bank account verification information.
    *
    * MODIFICATIONS:
    * DATE         VERSION        WHO              DESCRIPTION
    * 07/29/2014    Risk-158    IHOWLADER            INITIAL RELEASE
    *
    ******************************************************************************/
    PROCEDURE pr_get_for_credit_account(p_credit_account_id t_credit_account_bank_account.credit_account_id%TYPE,
                                        ref_cursor          OUT SYS_REFCURSOR);
    
    /******************************************************************************
    *
    *  TITLE:        pr_get_verification_by_credit_account_id_and_routing_number
    *  SCHEMA OWNER:  account
    *  CREATED:      12/04/2020
    *  AUTHOR:       CGOMEZ
    *
    *  DESCRIPTION: Review the history of BankAccount/RoutingNumber combination to identify if an R1,R2,R3 return has been received.
    *
    * MODIFICATIONS:
    * DATE         VERSION        WHO              DESCRIPTION
    * 12/04/2020    ACCT-159    CGOMEZ            INITIAL RELEASE
    *
    ******************************************************************************/
    PROCEDURE pr_get_verification_by_account_number_and_routing_number(p_account_number    IN ach_request_interface.checking_account%TYPE,
                                                                       p_routing_number    IN ach_request_interface.aba_num%TYPE,
                                                                       ref_cursor          OUT SYS_REFCURSOR);
    
     /******************************************************************************
    *
    *  TITLE:        pr_get_nacha_authentication_by_credit_account_id_and_routing_number
    *  SCHEMA OWNER:  account
    *  CREATED:      12/04/2020
    *  AUTHOR:       CGOMEZ
    *
    *  DESCRIPTION: Review the history of BankAccount/RoutingNumber combination to identify if an R1,R2,R3 return has been received.
    *
    * MODIFICATIONS:
    * DATE         VERSION        WHO              DESCRIPTION
    * 12/04/2020    ACCT-159    CGOMEZ            INITIAL RELEASE
    *
    ******************************************************************************/
    PROCEDURE pr_get_nacha_authentication_by_account_number_and_routing_number(p_credit_account_id IN v_credit_account.credit_account_id%TYPE,
                                                                               p_account_number    IN ach_request_interface.checking_account%TYPE,
                                                                               p_routing_number    IN ach_request_interface.aba_num%TYPE,
                                                                               ref_cursor          OUT SYS_REFCURSOR);
    
    /***********************************************************a*******************
    *
    *  TITLE:        pr_insert
    *  SCHEMA OWNER:  account
    *  CREATED:      07/29/2014
    *  AUTHOR:       IHOWLADER
    *
    *  DESCRIPTION: This procedure will insert the bank account verification information..
    *
    * MODIFICATIONS:
    * DATE         VERSION        WHO              DESCRIPTION
    * 07/29/2014    Risk-158    IHOWLADER            INITIAL RELEASE
    *
    ******************************************************************************/
    PROCEDURE pr_insert(p_bank_account_id            IN t_bank_account_verification.bank_account_id%TYPE,
                        p_credit_account_id          IN t_bank_account_verification.credit_account_id%TYPE,
                        p_created_dt                 IN t_bank_account_verification.created_date%TYPE,
                        p_expire_days_after_ach_sent IN t_bank_account_verification.expire_days_after_ach_sent%TYPE,
                        p_verified_dt                IN t_bank_account_verification.verified_date%TYPE,
                        p_canceled_dt                IN t_bank_account_verification.canceled_date%TYPE,
                        p_is_layover_page_shown      IN t_bank_account_verification.is_layover_page_shown%TYPE,
                        p_is_message_reminder_shown  IN t_bank_account_verification.is_message_reminder_shown%TYPE,
                        p_website_start              IN t_bank_account_verification.website_start%TYPE,
                        p_website_end                IN t_bank_account_verification.website_end%TYPE,
                        p_is_invalid                 IN t_bank_account_verification.is_invalid%TYPE,
                        p_bank_acc_verification_id   OUT t_bank_account_verification.bank_acc_verification_id%TYPE);
    
    /******************************************************************************
    *
    *  TITLE:        pr_update
    *  SCHEMA OWNER:  account
    *  CREATED:      07/29/2014
    *  AUTHOR:       IHOWLADER
    *
    *  DESCRIPTION: This procedure will retrive the  bank account verification information.
    *
    * MODIFICATIONS:
    * DATE         VERSION        WHO              DESCRIPTION
    * 07/29/2014    Risk-158    IHOWLADER            INITIAL RELEASE
    *
    ******************************************************************************/
    PROCEDURE pr_update(p_bank_acc_verification_id   IN t_bank_account_verification.bank_acc_verification_id%TYPE,
                        p_expire_days_after_ach_sent IN t_bank_account_verification.expire_days_after_ach_sent%TYPE,
                        p_verified_dt                IN t_bank_account_verification.verified_date%TYPE,
                        p_canceled_dt                IN t_bank_account_verification.canceled_date%TYPE,
                        p_is_layover_page_shown      IN t_bank_account_verification.is_layover_page_shown%TYPE,
                        p_is_message_reminder_shown  IN t_bank_account_verification.is_message_reminder_shown%TYPE,
                        p_website_start              IN t_bank_account_verification.website_start%TYPE,
                        p_website_end                IN t_bank_account_verification.website_end%TYPE,
                        p_is_invalid                 IN t_bank_account_verification.is_invalid%TYPE);
						
    /******************************************************************************
    *
    *  TITLE:        pr_get_bank_acc_history
    *  SCHEMA OWNER:  account
    *  CREATED:      01/06/2021
    *  AUTHOR:       LBOF
    *
    *  DESCRIPTION: This procedure will retrive the  bank account verification information.
    *
    * MODIFICATIONS:
    * DATE         VERSION        WHO              DESCRIPTION
    * 01/06/2021    ACCT-159     LBOF              INITIAL RELEASE
    *
    ******************************************************************************/
    PROCEDURE pr_get_bank_acc_history(p_credit_account_id IN  t_credit_account_bank_account.credit_account_id%TYPE,
                                      ref_cursor          OUT SYS_REFCURSOR);

END pkg_bank_acc_verification_p;
/

CREATE OR REPLACE PACKAGE BODY pkg_bank_acc_verification_p AS

    /******************************************************************************
    *
    *  TITLE:        pr_get_for_credit_account
    *  SCHEMA OWNER:  account
    *  CREATED:      07/29/2014
    *  AUTHOR:       IHOWLADER
    *
    *  DESCRIPTION: This procedure will retrive the bank account verification information.
    *
    * MODIFICATIONS:
    * DATE         VERSION        WHO              DESCRIPTION
    * 07/29/2014    Risk-158    IHOWLADER            INITIAL RELEASE
    *
    ******************************************************************************/
    PROCEDURE pr_get_for_credit_account(p_credit_account_id t_credit_account_bank_account.credit_account_id%TYPE,
                                        ref_cursor          OUT SYS_REFCURSOR) IS
    BEGIN
        OPEN ref_cursor FOR
            SELECT bav.bank_acc_verification_id,
                   bav.bank_account_id,
                   bav.credit_account_id,
                   bav.created_date,
                   bav.expire_days_after_ach_sent,
                   bav.verified_date,
                   bav.canceled_date,
                   bav.is_layover_page_shown,
                   bav.is_message_reminder_shown,
                   bav.website_start,
                   bav.website_end,
                   bav.is_invalid,
				   nvl((
                   select status from ach.ach_request_interface_01 ari join t_bank_account_verify_trans bavt on ari.request_id = bavt.request_id
                   where bavt.bank_acc_verification_id = bav.bank_acc_verification_id and rownum <= 1),'Unknown') microdepositstatus
              FROM t_bank_account_verification bav
             WHERE bav.credit_account_id = p_credit_account_id
               AND nvl(bav.is_invalid, 0) = 0;
               
    END pr_get_for_credit_account;
    
    /******************************************************************************
    *
    *  TITLE:        pr_get_verification_by_credit_account_id_and_routing_number
    *  SCHEMA OWNER:  account
    *  CREATED:      12/04/2020
    *  AUTHOR:       CGOMEZ
    *
    *  DESCRIPTION: Review the history of BankAccount/RoutingNumber combination to identify if an R1,R2,R3 return has been received.
    *
    * MODIFICATIONS:
    * DATE         VERSION        WHO              DESCRIPTION
    * 12/04/2020    ACCT-159    CGOMEZ            INITIAL RELEASE
    *
    ******************************************************************************/
    PROCEDURE pr_get_verification_by_account_number_and_routing_number
        (p_account_number    IN ach_request_interface.checking_account%TYPE,
         p_routing_number    IN ach_request_interface.aba_num%TYPE,
         ref_cursor          OUT SYS_REFCURSOR) IS

    BEGIN
      OPEN ref_cursor FOR
      
        SELECT 0 AS bank_acc_verification_id,
               0 AS bank_account_id,
               0 AS credit_account_id,
               CURRENT_DATE AS created_date,
               0 AS expire_days_after_ach_sent,
               NULL AS verified_date,
               NULL AS canceled_date,
               0 AS is_layover_page_shown,
               0 AS is_message_reminder_shown,
               'CCWEB' AS website_start,
               NULL AS website_end,
               0 AS is_invalid,
               '' as microdepositstatus
          FROM ach_request_interface
         WHERE checking_account = p_account_number
           AND aba_num = p_routing_number
           AND misc_3_data IN ('R02', 'R03', 'R04');
    
    END pr_get_verification_by_account_number_and_routing_number;
     
     /******************************************************************************
    *
    *  TITLE:        pr_get_nacha_authentication_by_credit_account_id_and_routing_number
    *  SCHEMA OWNER:  account
    *  CREATED:      12/04/2020
    *  AUTHOR:       CGOMEZ
    *
    *  DESCRIPTION: Review the history of BankAccount/RoutingNumber combination to identify if an R1,R2,R3 return has been received.
    *
    * MODIFICATIONS:
    * DATE         VERSION        WHO              DESCRIPTION
    * 12/04/2020    ACCT-159    CGOMEZ            INITIAL RELEASE
    *
    ******************************************************************************/
    PROCEDURE pr_get_nacha_authentication_by_account_number_and_routing_number
        (p_credit_account_id IN v_credit_account.credit_account_id%TYPE,
         p_account_number    IN ach_request_interface.checking_account%TYPE,
         p_routing_number    IN ach_request_interface.aba_num%TYPE,
         ref_cursor          OUT SYS_REFCURSOR) IS

    BEGIN
      OPEN ref_cursor FOR
      
        WITH V_FIRST_VERIFICATION AS --NACHA AUTHENTICATION CRITERIA POINT 1.
         (SELECT ari.requestor_id
            FROM v_credit_account vca
           INNER JOIN t_customer_bank_account cba
              ON vca.customer_id = cba.customer_id
           INNER JOIN ach_request_interface ari
              ON ari.checking_account = cba.account_number
             AND ari.aba_num = cba.routing_number
           WHERE vca.credit_account_id = p_credit_account_id
             AND ari.checking_account = p_account_number
             AND ari.aba_num = p_routing_number
             AND (sysdate - ari.fdr_payment_verified_date) > 11
             AND ari.ach_source IN ('IVR', 'Agency')),
        
        V_SECOND_VERIFICATION AS --NACHA AUTHENTICATION CRITERIA POINTS 2 AND 3.
         (SELECT ari.requestor_id
            FROM v_credit_account vca
           INNER JOIN t_customer_bank_account cba
              ON vca.customer_id = cba.customer_id
           INNER JOIN ach_request_interface ari
              ON ari.checking_account = cba.account_number
             AND ari.aba_num = cba.routing_number
           WHERE vca.credit_account_id = p_credit_account_id
             AND ari.checking_account = p_account_number
             AND ari.aba_num = p_routing_number
             AND ari.sec_code = 'WEB'
             AND ari.fdr_payment_verified_date IS NULL),
        
        V_THIRD_VERIFICATION AS --VERIFY IF THIS COMBINATION ALREADY EXISTS FOR THIS CUSTOMER.
         (SELECT ari.requestor_id
            FROM v_credit_account vca
           INNER JOIN t_customer_bank_account cba
              ON vca.customer_id = cba.customer_id
           INNER JOIN ach_request_interface ari
              ON ari.checking_account = cba.account_number
             AND ari.aba_num = cba.routing_number
           WHERE vca.credit_account_id = p_credit_account_id
             AND ari.checking_account = p_account_number
             AND ari.aba_num = p_routing_number)
        
        SELECT bank_acc_verification_id,
               bank_account_id,
               credit_account_id,
               created_date,
               expire_days_after_ach_sent,
               verified_date,
               canceled_date,
               is_layover_page_shown,
               is_message_reminder_shown,
               website_start,
               website_end,
               is_invalid,
               '' MicrodepositStatus
          FROM t_bank_account_verification
         WHERE NOT EXISTS (SELECT * FROM V_FIRST_VERIFICATION)
            OR EXISTS (SELECT * FROM V_SECOND_VERIFICATION)
            OR NOT EXISTS (SELECT * FROM V_THIRD_VERIFICATION)
         ORDER BY BANK_ACC_VERIFICATION_ID DESC
         FETCH FIRST 1 ROW ONLY;
    
    END pr_get_nacha_authentication_by_account_number_and_routing_number;

    /******************************************************************************
    *
    *  TITLE:        pr_insert
    *  SCHEMA OWNER:  account
    *  CREATED:      07/29/2014
    *  AUTHOR:       IHOWLADER
    *
    *  DESCRIPTION: This procedure will insert the bank account verification information..
    *
    * MODIFICATIONS:
    * DATE         VERSION        WHO              DESCRIPTION
    * 07/29/2014    Risk-158    IHOWLADER            INITIAL RELEASE
    *
    ******************************************************************************/
    PROCEDURE pr_insert(p_bank_account_id            IN t_bank_account_verification.bank_account_id%TYPE,
                        p_credit_account_id          IN t_bank_account_verification.credit_account_id%TYPE,
                        p_created_dt                 IN t_bank_account_verification.created_date%TYPE,
                        p_expire_days_after_ach_sent IN t_bank_account_verification.expire_days_after_ach_sent%TYPE,
                        p_verified_dt                IN t_bank_account_verification.verified_date%TYPE,
                        p_canceled_dt                IN t_bank_account_verification.canceled_date%TYPE,
                        p_is_layover_page_shown      IN t_bank_account_verification.is_layover_page_shown%TYPE,
                        p_is_message_reminder_shown  IN t_bank_account_verification.is_message_reminder_shown%TYPE,
                        p_website_start              IN t_bank_account_verification.website_start%TYPE,
                        p_website_end                IN t_bank_account_verification.website_end%TYPE,
                        p_is_invalid                 IN t_bank_account_verification.is_invalid%TYPE,
                        p_bank_acc_verification_id   OUT t_bank_account_verification.bank_acc_verification_id%TYPE) IS


    BEGIN
        INSERT INTO t_bank_account_verification
            (bank_acc_verification_id,
             bank_account_id,
             credit_account_id,
             created_date,
             expire_days_after_ach_sent,
             verified_date,
             canceled_date,
             is_layover_page_shown,
             is_message_reminder_shown,
             website_start,
             website_end,
             is_invalid)
        VALUES
            (seq_bank_acc_verification_id.nextval,
             p_bank_account_id,
             p_credit_account_id,
             p_created_dt,
             p_expire_days_after_ach_sent,
             p_verified_dt,
             p_canceled_dt,
             p_is_layover_page_shown,
             p_is_message_reminder_shown,
             p_website_start,
             p_website_end,
             p_is_invalid)
        RETURNING bank_acc_verification_id INTO p_bank_acc_verification_id;

        COMMIT;
    END pr_insert;
    /******************************************************************************
    *
    *  TITLE:        pr_update
    *  SCHEMA OWNER:  account
    *  CREATED:      07/29/2014
    *  AUTHOR:       IHOWLADER
    *
    *  DESCRIPTION: This procedure will retrive the  bank account verification information.
    *
    * MODIFICATIONS:
    * DATE         VERSION        WHO              DESCRIPTION
    * 07/29/2014    Risk-158    IHOWLADER            INITIAL RELEASE
    *
    ******************************************************************************/
    PROCEDURE pr_update(p_bank_acc_verification_id   IN t_bank_account_verification.bank_acc_verification_id%TYPE,
                        p_expire_days_after_ach_sent IN t_bank_account_verification.expire_days_after_ach_sent%TYPE,
                        p_verified_dt                IN t_bank_account_verification.verified_date%TYPE,
                        p_canceled_dt                IN t_bank_account_verification.canceled_date%TYPE,
                        p_is_layover_page_shown      IN t_bank_account_verification.is_layover_page_shown%TYPE,
                        p_is_message_reminder_shown  IN t_bank_account_verification.is_message_reminder_shown%TYPE,
                        p_website_start              IN t_bank_account_verification.website_start%TYPE,
                        p_website_end                IN t_bank_account_verification.website_end%TYPE,
                        p_is_invalid                 IN t_bank_account_verification.is_invalid%TYPE) IS
    BEGIN
        UPDATE t_bank_account_verification bav
           SET expire_days_after_ach_sent = p_expire_days_after_ach_sent,
               verified_date              = p_verified_dt,
               canceled_date              = p_canceled_dt,
               is_layover_page_shown      = p_is_layover_page_shown,
               is_message_reminder_shown  = p_is_message_reminder_shown,
               website_start              = p_website_start,
               website_end                = p_website_end,
               is_invalid                 = p_is_invalid
         WHERE bav.bank_acc_verification_id = p_bank_acc_verification_id;

        COMMIT;
    END pr_update;
	
	/******************************************************************************
    *
    *  TITLE:        pr_get_bank_acc_history
    *  SCHEMA OWNER:  account
    *  CREATED:      01/06/2021
    *  AUTHOR:       LBOF
    *
    *  DESCRIPTION: This procedure will retrive the  bank account verification information.
    *
    * MODIFICATIONS:
    * DATE         VERSION        WHO              DESCRIPTION
    * 01/06/2021    ACCT-159     LBOF              INITIAL RELEASE
    *
    ******************************************************************************/
	PROCEDURE pr_get_bank_acc_history(p_credit_account_id t_credit_account_bank_account.credit_account_id%TYPE,
                                        ref_cursor          OUT SYS_REFCURSOR) IS
    BEGIN
        OPEN ref_cursor FOR
		
            SELECT bav.credit_account_id,
               bav.bank_acc_verification_id,
               (SELECT trt.rt_instit
                  FROM t_rt_thompson trt
                 WHERE trt.rt_micr = cba.aba_num
                   AND ROWNUM = 1) AS bank_name,
               (SELECT aat.account_type_desc
                  FROM ach_account_type aat
                 WHERE aat.account_type_code = cba.account_type_code) as account_type,
               cba.account_number,
               bav.created_date as date_triggered,
               bav.verified_date as date_verified,
               bav.website_end as system_verified,
               CASE bav.website_end
                 WHEN 'CAS' THEN
                  (select to_char(tuca.agent_id) || '|' || emp.first_name || ' ' ||
                          emp.last_name
                     from employee emp
                    INNER JOIN t_uc_audit tuca
                       ON tuca.agent_id = emp.employee_id
                    INNER JOIN t_uc tuc
                       ON tuc.uc_id = tuca.uc_id
                    WHERE tuc.credit_account_id = bav.credit_account_id
                         AND to_char(bav.verified_date, 'yyyy-mm-dd hh:mi')=to_char(tuca.audit_date, 'yyyy-mm-dd hh:mi')
                      AND tuca.data like '%Bank Account Verification Result: %')
                 WHEN 'FullWeb' THEN
                  'CUSTOMER'
                 WHEN 'MobileWebSite' THEN
                  'CUSTOMER'
                 WHEN 'Mobile_App' THEN
                  'CUSTOMER'
                 ELSE
                  ''
               END AS agent_info,
               (SELECT count(*)
                  FROM t_bank_acc_verify_attempts
                 WHERE bank_acc_verification_id = bav.bank_acc_verification_id) as verification_attempts,
               bav.expire_days_after_ach_sent,
               bav.created_date
          FROM t_bank_account_verification bav
          JOIN t_bank_account cba
            ON bav.bank_account_id = cba.bank_account_id
         WHERE bav.credit_account_id = p_credit_account_id
           AND nvl(bav.is_invalid, 0) = 0;
               
    END pr_get_bank_acc_history;

END pkg_bank_acc_verification_p;
/
