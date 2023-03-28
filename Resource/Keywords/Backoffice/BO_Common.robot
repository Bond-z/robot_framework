*** Settings ***
Resource          ${CURDIR}/../../import.robot


*** Keywords ***

CL Open Backoffice Website
    Web Open Browser    ${ENVIRONMENT.DOMAIN.${ar_DOMAIN}.PIGSPIN_BO.URL}

BO Login
    [Arguments]    ${email}=${Backoffice.user02.email}     ${password}=${Backoffice.user02.password}
    CL Open Backoffice Website
    BO Click Login Via Google Account Button
    BO Input Google Email Account    ${email}    ${password}
    WEB Verify Element Visible    ${BO_deposit_menu}

BO Click Login Via Google Account Button
    WEB Click Element    ${BO_gg_login_btn}

BO Input Google Email Account
    [Arguments]     ${email}    ${password}
    WEB Sleep
    ${handles}=  Get Window Handles
    Switch Window   ${handles}[1]
    WEB Input Text    ${BO_email_txt}    ${email} 
    WEB Press Keys    ${BO_email_txt}    ENTER
    WEB Sleep
    WEB Input Text    ${BO_password_txt}    ${password}
    WEB Press Keys    ${BO_password_txt}    ENTER
    WEB Sleep
    Switch Window   ${handles}[0]
    

Verify Login should be success
    WEB Verify Element Visible    ${BO_deposit_menu}

Go To Affiliate Overview Page
    WEB Set Focus To Element    ${BO_deposit_menu}
    # Scroll Element Into View    ${BO_affi_overview}
    Execute JavaScript   window.scrollTo(9,800);
    WEB Click Element    ${BO_affi_overview}

Go To Transaction Menu
    WEB Click Element    ${BO_transaction_menu}

Go To User Ticket Page
    WEB Click Element    ${BO_user_ticket_menu}

Go To Customer Page
    WEB Click Element    ${BO_user_list_menu}