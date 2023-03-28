*** Settings ***
Resource          CL_Common.robot
Variables         ../../Localize/CL/TH/CL_Login.yaml

*** Keywords ***
CL Verify Login Success
    WEB Verify Element Visible    ${LBP_balance_amount_txt}

CL Verify Login Fail Wrong Pin
    WEB Verify Element Text    ${LGP_pin_input_error_txt}    ${cl_login_localize.pin_page.input_pin.wrong_pin}

CL Click Login Button
    Web Click Element    ${LDP_header_login_btn}

CL Input Phone No
    [Arguments]    ${phone_no}=${TEST_USER.phone.uncensor}
    Web Input Text    ${LGP_body_phone_inp}    ${phone_no}

CL Click Check Phone No
    Web Click Element    ${LGP_body_check_phone_btn}

CL Verify Login Fail Account Doesn't Exist
    WEB Verify Element Visible    ${OTP_header_txt}

CL Verify Element Login Page
    WEB Verify Element Visible    ${LDP_header_login_btn}
    WEB Verify Element Text    ${LGP_body_phone_txt}    ${cl_login_localize.phone_page.input_phone.title}
    WEB Verify Element Visible    ${LGP_body_phone_inp}
    WEB Verify Element Visible    ${LGP_body_check_phone_disabled_btn}

CL Verify Lock User Modal Appear
    WEB Verify Element Text    ${LGP_lock_user_header_txt}    ${cl_login_localize.phone_page.modal.lock_header}

CL Input Wrong Pin 10 Times
    FOR    ${index}    IN RANGE    0    9    1
        CL Input pin    999999
        CL Verify Login Fail Wrong Pin
    END
    CL Input pin    999999

CL Verify login fail input phone wrong format
    WEB Verify Element Text    ${LGP_phone_input_error_txt}    ${cl_login_localize.phone_page.input_phone.wrong_format}

CL Verify login fail input pin wrong format
    WEB Verify Element Text    ${LGP_pin_input_error_txt}    ${cl_login_localize.pin_page.input_pin.wrong_format}

CL Verify Ban User Modal Appear
    WEB Verify Element Text    ${LGP_ban_user_header_txt}    ${cl_login_localize.phone_page.modal.ban_header}
