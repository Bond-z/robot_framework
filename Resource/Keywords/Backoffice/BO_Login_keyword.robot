*** Settings ***
Resource          ${CURDIR}/../../import.robot

#TO BE CONTINUE
*** Keywords ***
Open Pigspin Back Office Website
    Open Browser    ${ENVIRONMENT.DOMAIN.${ar_DOMAIN}.PIGSPIN_BO.URL}    gc


Click Login with google button
    WEB Click Element    ${gg_login_btn}

Input Backoffice email 
    [Arguments]    ${email}
    Web Input Text    ${LGP_body_phone_inp}    ${email}