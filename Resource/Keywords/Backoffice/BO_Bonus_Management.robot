*** Settings ***
Resource          ${CURDIR}/../../import.robot

*** Keywords ***

Add bonus to user wallet
    [Arguments]   ${bonus_baht}   ${turn_over}
    BO Login
    Topup bonus to user wallet    ${bonus_baht}    ${turn_over}

Topup bonus to user wallet
    [Arguments]   ${username}   ${bonus_baht}    ${turn_over}
    Go to user bonus menu
    Search for user wallet      ${username}
    Add bonus to user    ${bonus_baht}    ${turn_over}
    WEB Sleep   

Topup bonus to user wallet 2 times
    [Arguments]   ${username}   ${bonus_baht}    ${turn_over}
    Go to user bonus menu
    Search for user wallet      ${username}
    #Add 1st bonus wallet
    Add bonus to user    ${bonus_baht}    ${turn_over}
    WEB Sleep
    #Add 2nd bonus wallet
    Add bonus to user    ${bonus_baht}    ${turn_over}

Deposit to user wallet
    [Arguments]   ${username}   ${deposit}
    Go to user bonus menu
    Search for user wallet      ${username}

Go to user bonus menu
    WEB Click Element    ${BO_user_bonus_menu}
    Sleep   5s

Search for user wallet
    [Arguments]    ${username}
    Web Input Text    ${BO_phone_txt}    ${username}
    Press Keys    ${BO_phone_txt}    ENTER
    Sleep   5s

Add bonus to user
    [Arguments]     ${bonus_baht}    ${turn_over}
    WEB Click Element    ${BO_add_bonus_btn}
    WEB Set Focus To Element    ${BO_initail_bonus_txt}
    Web Input Text   ${BO_initail_bonus_txt}    ${bonus_baht}
    Web Input Text   ${BO_turnover_txt}    ${turn_over}
    WEB Click Element    ${BO_modal_add_bonus_btn}
    WEB Set Focus To Element    ${BO_comfirm_modal_ok_btn}
    WEB Click Element    ${BO_comfirm_modal_ok_btn}
    

Verify user's bonus wallet should be received bonus correctly
    [Arguments]    ${bonus_baht}    
    ${bonus}    WEB Get Element Text    ${BO_table_bonus_topup} 
    ${bonus}    Convert To Number    ${bonus}
    Should Be Equal As Numbers    ${bonus}    ${bonus_baht}
    
# Affiliate Overview Page
Verify and get total active balance on Affiliate Over Page
    [Arguments]    ${username}
    Web Input Text   ${BO_user_search_txt}    ${username}
    WEB Press Keys    ${BO_user_search_txt}    ENTER    
    Sleep    5s
    ${total_income}=    WEB Get Element Text    ${BO_total_income_upline}
    [Return]    ${total_income}

Go To Transfer Menu And Click On Tab Friend Suggestion
    WEB Click Element    ${BO_transfer_menu}
    Click on tab friend suggestion

Get current bonus balance
    [Arguments]   ${username}
    Go to user bonus menu
    Search for user wallet      ${username}
    ${bonus}    WEB Get Element Text    ${BO_Dashboard_bonus} 
    [Return]    ${bonus}

Cancel bonus should be completed
    WEB Click Element    ${BO_edit_bonus_btn}
    WEB Set Focus To Element    ${BO_edit_dropdown}
    WEB Click Element    ${BO_cancel_bonus_btn}
    WEB Click Element    ${BO_comfirm_modal_ok_btn}
    WEB Sleep
    Verify the status should be "โดนยกเลิก"
    Reload Page 
    ${current_bonus}    Get current bonus balance    ${TEST_USER.username}
    Should Be Equal As Numbers    ${current_bonus}    ${0}

Verify the status should be "โดนยกเลิก"
    SeleniumLibrary.Element Text Should Be    ${BO_bonus_status}    โดนยกเลิก




