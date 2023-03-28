*** Settings ***
Resource          ${CURDIR}/../../import.robot


*** Keywords ***
Search for customer
    [Arguments]    ${username}
    Web Input Text   ${BO_search_customer_txt}    ${username}
    WEB Press Keys    ${BO_search_customer_txt}    ENTER

Edit customer status by disable account
    WEB Click Element    ${BO_edit_btn}
    WEB Click Element    ${BO_disable_account}
    WEB Click Element    ${BO_confirm_edit_btn}
    WEB Sleep
    WEB Click Element    ${BO_final_confirm_ok_btn}
    WEB Sleep

Verify edit customer account status should be successful
    [Arguments]     ${status}
    WEB Verify Element Visible    ${BO_user_status} 
    Element Text Should Be    ${BO_user_status}     ${status}

Edit customer status by enable account
    WEB Click Element    ${BO_edit_btn}
    WEB Click Element    ${BO_enable_account}
    WEB Click Element    ${BO_confirm_edit_btn}
    WEB Sleep
    WEB Click Element    ${BO_final_confirm_ok_btn}