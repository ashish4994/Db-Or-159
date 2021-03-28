CREATE OR REPLACE PACKAGE pkg_batch_bank_acc_verify_p AS

    /******************************************************************************
    *
    *  TITLE:        fn_ach_file_date
    *  SCHEMA OWNER:  Process
    *  CREATED:      07/29/2014
    *  AUTHOR:       IHOWLADER
    *
    *  DESCRIPTION: This function will  return most  recent ach file creation date for the  bank account verification transaction.
    *  MODIFICATIONS:
    * DATE         VERSION        WHO              DESCRIPTION
    * 07/29/2014    Risk-158    IHOWLADER            INITIAL RELEASE
    *
    ******************************************************************************/
    FUNCTION fn_ach_file_date(p_bank_acc_verification_id NUMBER) RETURN DATE;
    
    /******************************************************************************
    *
    *  TITLE:        pr_get_all_in_progress_by_age
    *  SCHEMA OWNER:  Process
    *  CREATED:      07/29/2014
    *  AUTHOR:       IHOWLADER
    *
    *  DESCRIPTION:This procedure will return all the bank account verification information which
    *  status is in progress,created date is older then p_day_old and email reminder is not sent.
    * MODIFICATIONS:
    * DATE         VERSION        WHO              DESCRIPTION
    * 07/29/2014    Risk-158    IHOWLADER          INITIAL RELEASE
    * 01/26/2015    WO65835     LPETITJEAN         Modified to return bank accounts verifications
    *                                              that have primary credit account emails with status 'P'
    ******************************************************************************/
    PROCEDURE pr_get_all_in_progress_by_age(p_day_old  IN NUMBER,
                                            ref_cursor OUT SYS_REFCURSOR);

END pkg_batch_bank_acc_verify_p;
/

CREATE OR REPLACE PACKAGE BODY pkg_batch_bank_acc_verify_p AS
    
    /******************************************************************************
    *
    *  TITLE:        fn_ach_file_date
    *  SCHEMA OWNER:  Process
    *  CREATED:      10/06/2014
    *  AUTHOR:       IHOWLADER
    *
    *  DESCRIPTION:This function will  return most  recent ach file creation date for the  bank account verification transaction.
    *  MODIFICATIONS:
    * DATE         VERSION        WHO              DESCRIPTION
    * 10/06/2014    Risk-158    IHOWLADER            INITIAL RELEASE
    *
    ******************************************************************************/
    FUNCTION fn_ach_file_date(p_bank_acc_verification_id NUMBER) RETURN DATE IS
        v_created_date DATE;
    BEGIN

        SELECT MAX(fh.creation_date)
          INTO v_created_date
          FROM t_bank_account_verify_trans bat,
               t_bank_account_verification bav,
               ach_file_history            fh,
               batch_header                bh,
               entry_detail                ed,
               ach_request_interface       ari
         WHERE bat.bank_acc_verification_id = bav.bank_acc_verification_id
           AND bat.request_id = ari.request_id
           AND ari.detail_id = ed.detail_id
           AND ed.batch_id = bh.batch_id
           AND fh.file_id = bh.file_id
           AND bav.bank_acc_verification_id = p_bank_acc_verification_id
           AND bat.is_invalid = 0;

        RETURN v_created_date;
    END;
    
    /******************************************************************************
    *
    *  TITLE:        pr_get_all_in_progress_by_age
    *  SCHEMA OWNER:  Process
    *  CREATED:      07/29/2014
    *  AUTHOR:       IHOWLADER
    *
    *  DESCRIPTION:This procedure will return all the bank account verification information which
    *  status is in progress,created date is older then p_day_old and email reminder is not sent.
    * MODIFICATIONS:
    * DATE         VERSION        WHO              DESCRIPTION
    * 07/29/2014    Risk-158    IHOWLADER          INITIAL RELEASE
    * 01/26/2015    WO65835     LPETITJEAN         Modified to return bank accounts verifications
    *                                              that have primary credit account emails with status 'P'
    ******************************************************************************/
    PROCEDURE pr_get_all_in_progress_by_age(p_day_old  IN NUMBER,
                                            ref_cursor OUT SYS_REFCURSOR) IS
        v_notification_tmpl_type_code  VARCHAR2(20);
        v_status_type_code             VARCHAR2(20);
        c_primary_email_code           VARCHAR2(30);
        c_pass_status_code             VARCHAR2(1);

    BEGIN
        v_notification_tmpl_type_code  := 'BAVREM';
        v_status_type_code             := 'SENT';
  c_primary_email_code           := 'PRM';
  c_pass_status_code             := 'P';


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
                   '' MicrodepositStatus,
                   fn_ach_file_date(bav.bank_acc_verification_id) AS ach_file_created_date
              FROM t_bank_account_verification bav,
                   t_account_email ae,
                   t_email_address e
             WHERE bav.canceled_date IS NULL
               AND bav.verified_date IS NULL
               AND trunc(SYSDATE - bav.created_date) >= p_day_old
               AND NVL(SYSDATE -
                       fn_ach_file_date(bav.bank_acc_verification_id), 0) <=
                   bav.expire_days_after_ach_sent
               AND bav.is_invalid = 0
               and ae.credit_account_id = bav.credit_account_id
               and e.email_address_id = ae.email_address_id
               and e.status_code = c_pass_status_code
         and ae.email_type_code =  c_primary_email_code
               AND NOT EXISTS
             (SELECT 1
                      FROM t_notification               n,
                           t_credit_acc_notification    can,
                           t_bank_acc_veri_notification ban,
                           t_lu_notification_template   nt
                     WHERE nt.notification_tmpl_type_code =
                           v_notification_tmpl_type_code
                       AND nt.notification_tmpl_code =
                           n.notification_tmpl_code
                       AND n.status_type_code = v_status_type_code
                       AND n.notification_id = can.notification_id
                       AND can.notification_id = ban.notification_id
                       AND ban.bank_acc_verification_id =
                           bav.bank_acc_verification_id);

    END pr_get_all_in_progress_by_age;

END pkg_batch_bank_acc_verify_p;
/
