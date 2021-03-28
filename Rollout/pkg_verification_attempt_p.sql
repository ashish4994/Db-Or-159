CREATE OR REPLACE PACKAGE pkg_verification_attempt_p AS
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
    PROCEDURE pr_insert(p_bank_acc_verification_id IN t_bank_acc_verify_attempts.bank_acc_verification_id%TYPE,
                        p_created_date             IN t_bank_acc_verify_attempts.created_date%TYPE);
    /******************************************************************************
    *
    *  TITLE:        pr_get_for_bank_acc_verifi
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
    PROCEDURE pr_get_for_bank_acc_verify(p_bank_acc_verification_id IN t_bank_acc_verify_attempts.bank_acc_verification_id%TYPE,
                                         p_created_date             IN t_bank_acc_verify_attempts.created_date%TYPE,
                                         ref_cursor                 OUT SYS_REFCURSOR);
END pkg_verification_attempt_p;
/
CREATE OR REPLACE PACKAGE BODY pkg_verification_attempt_p AS

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
    PROCEDURE pr_insert(p_bank_acc_verification_id IN t_bank_acc_verify_attempts.bank_acc_verification_id%TYPE,
                        p_created_date             IN t_bank_acc_verify_attempts.created_date%TYPE) IS
    BEGIN
        INSERT INTO t_bank_acc_verify_attempts
            (bank_acc_verify_attempt_id,
             bank_acc_verification_id,
             created_date)
        VALUES
            (seq_bank_acc_verify_attempt_id.nextval,
             p_bank_acc_verification_id,
             p_created_date);
        COMMIT;
    END pr_insert;
    /******************************************************************************
    *
    *  TITLE:        pr_get_for_bank_acc_verifi
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
    PROCEDURE pr_get_for_bank_acc_verify(p_bank_acc_verification_id IN t_bank_acc_verify_attempts.bank_acc_verification_id%TYPE,
                                         p_created_date             IN t_bank_acc_verify_attempts.created_date%TYPE,
                                         ref_cursor                 OUT SYS_REFCURSOR) IS
    BEGIN
        OPEN ref_cursor FOR
          SELECT bank_acc_verify_attempt_id,
                 bava.bank_acc_verification_id,
                 bava.created_date,
                 ari.ach_source AS system_verified,
                 ari.bank_name
            FROM t_bank_acc_verify_attempts bava
            LEFT JOIN t_bank_account_verification bav
              ON bava.bank_acc_verification_id = bav.bank_acc_verification_id
            LEFT JOIN t_bank_account_verify_trans bavt
              ON bav.bank_acc_verification_id = bavt.bank_acc_verification_id
            LEFT JOIN ACH_REQUEST_INTERFACE ari
              ON bavt.request_id = ari.request_id
           WHERE bava.bank_acc_verification_id = p_bank_acc_verification_id
             AND bava.created_date > p_created_date
           GROUP BY bank_acc_verify_attempt_id,
                    bava.bank_acc_verification_id,
                    bava.created_date,
                    ari.ach_source,
                    ari.bank_name
           ORDER BY bava.created_date DESC;
    
    END pr_get_for_bank_acc_verify;
END pkg_verification_attempt_p;
/
