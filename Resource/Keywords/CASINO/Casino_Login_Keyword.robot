*** Settings ***
Resource          ${CURDIR}/../../import.robot

*** Keywords ***
CASINO Verify Login Success
    IF   "${ar_DEVICE}"=="MOBILE"
        WEB Verify Element Visible    ${LBP_hamburger_btn}
        Web Verify Element Visible    ${LBP_header_credit_lbl}
    ELSE
        Web Verify Element Visible    ${LBP_header_credit_lbl}
    END

CASINO Verify Login Fail Wrong Pin
    WEB Verify Element Text    ${LGP_pin_input_error_txt}    ${cl_login_localize.pin_page.input_pin.wrong_pin}

Click Login Button On Pigbet website
    Web Click Element    ${CN_LDP_header_login_btn}

Input Phone No On Pigbet Website
    [Arguments]    ${phone_no}=${TEST_USER.phone.uncensor}
    Web Input Text    ${LGP_body_phone_inp}    ${phone_no}

Click Check Phone No On Pigbet Website
    Web Click Element    ${LGP_body_check_phone_btn}

CASINO Verify Login Fail Account Doesn't Exist
    WEB Verify Element Visible    ${OTP_header_txt}

CASINO Verify Element Login Page
    WEB Verify Element Visible    ${CN_LDP_header_login_btn}
    WEB Verify Element Text    ${LGP_body_phone_txt}    ${cl_login_localize.phone_page.input_phone.title}
    WEB Verify Element Visible    ${LGP_body_phone_inp}
    WEB Verify Element Visible    ${LGP_body_check_phone_disabled_btn}

CASINO Verify Lock User Modal Appear
    WEB Verify Element Text    ${LGP_lock_user_header_txt}    ${cl_login_localize.phone_page.modal.invalid_pin}
    WEB Click Element    ${LGP_lock_user_btn}
    WEB Verify Element Text    ${LGP_verify_otp_subheader}    ${cl_login_localize.otp_page.sub_header}

CASINO Input Wrong Pin 10 Times
    FOR    ${index}    IN RANGE    0    9    1
        Input pin On Pigbet Website    999999
        # CASINO Verify Login Fail Wrong Pin
        WEB Sleep
    END
    # Input pin On Pigbet Website    999999

CASINO Verify login fail input phone wrong format
    WEB Verify Element Text    ${LGP_phone_input_error_txt}    ${cl_login_localize.phone_page.input_phone.wrong_format}

CASINO Verify login fail input pin wrong format
    WEB Verify Element Text    ${LGP_pin_input_error_txt}    ${cl_login_localize.pin_page.input_pin.wrong_format}

CASINO Verify Ban User Modal Appear
    WEB Verify Element Text    ${LGP_ban_user_header_txt}    ${cl_login_localize.phone_page.modal.ban_header}
