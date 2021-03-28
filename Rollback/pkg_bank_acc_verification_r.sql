CREATE OR REPLACE PACKAGE pkg_bank_acc_verification_r AS

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

END pkg_bank_acc_verification_r;
/

CREATE OR REPLACE PACKAGE BODY pkg_bank_acc_verification_r AS

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
                   bav.is_invalid
              FROM t_bank_account_verification bav
             WHERE bav.credit_account_id = p_credit_account_id
               AND nvl(bav.is_invalid, 0) = 0;
               
    END pr_get_for_credit_account;

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

END pkg_bank_acc_verification_r;
/
