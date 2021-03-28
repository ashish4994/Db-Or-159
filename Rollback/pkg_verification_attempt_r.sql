CREATE OR REPLACE PACKAGE pkg_verification_attempt_r AS
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
END pkg_verification_attempt_r;
/
CREATE OR REPLACE PACKAGE BODY pkg_verification_attempt_r AS

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
            SELECT bat.*
              FROM t_bank_acc_verify_attempts bat
             WHERE bat.bank_acc_verification_id =
                   p_bank_acc_verification_id
               AND bat.created_date > p_created_date
             ORDER BY bat.created_date DESC;
    
    END pr_get_for_bank_acc_verify;
END pkg_verification_attempt_r;
/
