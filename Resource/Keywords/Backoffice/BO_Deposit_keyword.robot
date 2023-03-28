*** Settings ***
Resource          ${CURDIR}/../../import.robot

*** Keywords ***
Go To Deposit Page And Create New Deposit
    [Arguments]    ${bank_account}    ${amount}
    Set Selenium Speed    0.5
    Go to deposit menu
    Click on deposit button
    Input deposit user information and comfirm    ${bank_account}    ${amount}

Click on deposit button
    WEB Click Element     ${BO_deposit_btn}
    Sleep   ${TIMEOUT.STAGING.SLEEP}

Input deposit user information and comfirm
    [Arguments]    ${bank_account}    ${amount}
    WEB Set Focus To Element    ${BO_deposit_modal}
    Click Element    ${BO_select_bank_account}
    Click Element    ${BO_select_bank_dropdown}
    Click Element    ${BO_kbank}
    WEB Input Text      ${BO_user_bank_account}     ${bank_account}
    WEB Input Text      ${BO_deposit_amount}     ${amount}
    Click Element    ${BO_comfirm_deposit_btn}
    WEB Set Focus To Element    ${BO_modal_comfirm_btn}
    Click Element    ${BO_modal_comfirm_btn}

Deposit through BBL bank account and comfirm
    [Arguments]    ${bank_account}    ${amount}
    Go to deposit menu
    Click on deposit button
    WEB Set Focus To Element    ${BO_deposit_modal}
    Click Element    ${BO_select_bank_account}
    Click Element    ${BO_select_bank_dropdown}
    WEB Click Element    ${BO_dropdown_bbl}
    WEB Input Text      ${BO_user_bank_account}     ${bank_account}
    WEB Input Text      ${BO_deposit_amount}     ${amount}
    WEB Sleep
    Click Element    ${BO_comfirm_deposit_btn}
    WEB Set Focus To Element    ${BO_modal_comfirm_btn}
    WEB Click Element    ${BO_modal_comfirm_btn}

Deposit through SCB bank account and comfirm
    [Arguments]    ${bank_account}    ${amount}
    Go to deposit menu
    Click on deposit button
    WEB Set Focus To Element    ${BO_deposit_modal}
    Click Element    ${BO_select_bank_account}
    Click Element    ${BO_select_bank_dropdown}
    Click Element    ${BO_dropdown_scb}
    WEB Input Text      ${BO_user_bank_account}     ${bank_account}
    WEB Input Text      ${BO_deposit_amount}     ${amount}
    WEB Click Element    ${BO_comfirm_deposit_btn}
    WEB Sleep
    WEB Set Focus To Element    ${BO_modal_comfirm_btn}
    Click Element    ${BO_modal_comfirm_btn}

Go To ToDo List Tab And Confirm Deposit
    [Arguments]    ${phone_no}
    Set Selenium Speed    0.5
    Go to deposit menu
    Click on todo list tab
    Confirm deposit to user wallet    ${phone_no}

Go to deposit menu      
    WEB Click Element     ${BO_deposit_menu}

Click on todo list tab
    WEB Click Element     ${BO_todo_list_tab}

Confirm deposit to user wallet
    [Arguments]    ${phone_no}
    WEB Click Element         ${BO_todo_deposit_btn}
    Sleep   ${TIMEOUT.STAGING.SLEEP}
    WEB Set Focus To Element    ${BO_modal_input_phone_txt}
    WEB Input Text      ${BO_modal_input_phone_txt}     ${phone_no}
    WEB Press Keys    ${BO_modal_input_phone_txt}    ENTER
    WEB Click Element         ${BO_modal_confirm_deposit_btn}
    WEB Click Element     ${BO_modal_final_confirm_btn} 
    WEB Sleep
    Click Element     ${BO_modal_after_confirm_btn}

Reject deposit
    [Arguments]    ${phone_no}
    WEB Click Element         ${BO_todo_deposit_btn}
    WEB Sleep
    WEB Set Focus To Element    ${BO_modal_input_phone_txt}
    WEB Input Text      ${BO_modal_input_phone_txt}     ${phone_no}
    WEB Press Keys    ${BO_modal_input_phone_txt}    ENTER
    WEB Sleep
    WEB Click Element         ${BO_modal_reject_deposit_btn}
    WEB Sleep
    WEB Set Focus To Element    ${BO_alert_modal}
    WEB Click Element     ${BO_modal_comfirm_btn}
    WEB Sleep
    WEB Set Focus To Element    ${BO_alert_modal}
    WEB Click Element     ${BO_modal_comfirm_btn}
    WEB Sleep

Transfer money to user after reject request deposit
    [Arguments]    ${username}
    Set Selenium Speed    0.5
    WEB Set Focus To Element     ${BO_modal_content}
    WEB Input Text     ${BO_modal_account_name_txt}    ${username}
    WEB Sleep
    Click Element    ${BO_confirm_transfer_modal}
    WEB Sleep

Verify the status should be "รอเติมเงิน"
    [Arguments]    ${status}=รอเติมเงิน
    WEB Verify Element Visible    ${BO_todo_deposit_status_table}
    Element Text Should Be    ${BO_todo_deposit_status_table}    ${status}


Verify deposit history status should be "Wait for transfer back"
    [Arguments]    ${status}=รอแจ้งคืนเงิน
    Go to deposit history tab
    WEB Verify Element Visible    ${Deposit_history_status}
    Element Text Should Be    ${Deposit_history_status}    ${status}

Click on wait to transfer tab
    WEB Click Element    ${BO_todo_wait_transfer_back_tab}

Go to deposit history tab
    WEB Click Element    ${BO_deposit_menu}
    WEB Click Element    ${BO_history_tab}

Go to the last page
    WEB Input Text     ${BO_todo_goto_page}     5
    WEB Press Keys     ${BO_todo_goto_page}    ENTER

Verify Deposit Should Be Successful
    [Arguments]    ${phone_no}    ${deposit_amount}
    Go To User Wallet
    Search For User On Wallet Page    ${phone_no}
    ${expect_amount}=    WEB Get Element Text    ${BO_user_wallet_table_log}
    ${expect_amount}=    Convert To Number    ${expect_amount}
    Should Be Equal As Numbers    ${expect_amount}    ${deposit_amount}
    WEB Sleep

Verify the customer should gain 10 percent bonus when deposit
    [Arguments]    ${deposit}
    ${expect_amount}=    Evaluate    ${deposit} * 0.1

    ${bonus_amount}=    WEB Get Element Text    ${BO_user_bonus_table_log}
    ${bonus_amount}=    Convert To Number    ${bonus_amount}
    Should Be Equal As Numbers    ${expect_amount}    ${bonus_amount}

Go To User Wallet
    WEB Click Element     ${BO_user_wallet_menu}

Search For User On Wallet Page
    [Arguments]     ${phone_no}
    WEB Input Text      ${BO_search_customer_code_txt}     ${phone_no}
    WEB Press Keys      ${BO_search_customer_code_txt}    ENTER

Add bonus to user wallet
    [Arguments]   ${bonus_baht}   ${turn_over}
    BO Login
    Topup bonus to user wallet    ${bonus_baht}    ${turn_over}

Deposit to user wallet
    [Arguments]   ${username}   ${deposit}
    Go to user bonus menu
    Search for user wallet      ${username}

Get deposit amount from table on deposit page
    ${deposit_amount}    WEB Get Element Text    ${BO_todo_deposit_amt_table}
    [Return]    ${deposit_amount}

Edit deposit amount
    [Arguments]    ${new_amount}
    Go to deposit menu
    ${amount}=    Get deposit amount from table on deposit page
    ${count}    Convert To String    ${amount}
    @{count}    Split String    ${count}    ,
    ${len}    Get Length    @{count}
    ${round}=    Convert To Integer    ${len}
    Click Edit Deposit Button
    WEB Set Focus To Element    ${BO_modal_content}
    Delete All Text    ${round} 
    WEB Input Text      ${BO_deposit_amount}     ${new_amount}
    WEB Click Element     ${BO_confirm_edit_modal}
    WEB Sleep 

Click Edit Deposit Button
    WEB Click Element    ${BO_todo_edit_btn}
    WEB Sleep
    WEB Set Focus To Element     ${BO_todo_edit_dropdown}
    Click Element     ${BO_todo_edit_dropdown_btn}
    WEB Sleep

Click Delete Deposit Button
    WEB Click Element    ${BO_todo_edit_btn}
    WEB Sleep
    WEB Set Focus To Element     ${BO_todo_edit_dropdown}
    Click Element     ${BO_todo_delete_dropdown_btn}
    WEB Sleep

Verify the user should have new deposit amount
    [Arguments]     ${username}    ${new_amount}
    Verify Deposit Should Be Successful    ${username}    ${new_amount}
    
Delete deposit request on todo list tab
    Go to deposit menu
    Click Delete Deposit Button
    WEB Set Focus To Element     ${BO_alert_modal}
    WEB Click Element     ${BO_modal_comfirm_btn}
    WEB Sleep

Delete All Text
    [Arguments]    ${round}
    BuiltIn.Repeat Keyword    ${round} times    Press Keys    ${BO_deposit_amount}    DELETE   

Verify the user should not have bonus after deposit
    ${bonus_amount}=    WEB Get Element Text    ${BO_user_bonus_table_log}
    ${bonus_amount}=    Convert To Number    ${bonus_amount}
    Should Be Equal As Numbers    ${bonus_amount}    ${0}

Deposit affiliate income to user via DB
    [Arguments]    ${upline_user}    ${downline_user}    ${amount}
    ${uuid}=    INSERT Affiliate Transaction    ${upline_user}    ${downline_user}    ${amount}
    INSERT Affiliate Income To Upline    ${upline_user}    ${amount}
    INSERT Transaction Log    ${uuid} 


