*** Settings ***
Resource          ${CURDIR}/../../import.robot

*** Keywords ***
Click on tab friend suggestion
    WEB Click Element    ${BO_affi_radio_tab}

#Verify total amount of affiliate program
Create New Withdraw And Get Balance Amount
    [Arguments]    ${username}
    WEB Click Element    ${BO_add_withdraw_item_btn}
    WEB Set Focus To Element     ${BO_search_user_withdraw_txt}
    WEB Input Text    ${BO_search_user_withdraw_txt}    ${username}
    WEB Press Keys    ${BO_search_user_withdraw_txt}    ENTER
    ${current_balance}    WEB Get Element Text    ${BO_total_affi_balance}   
    Click Element    ${BO_modal_cancel_btn}
    [Return]    ${current_balance}

Go To Transfer Menu
    WEB Click Element    ${BO_transfer_menu}

Transfer money from the system to user bank account should be success
    [Arguments]    ${username}    ${withdraw}
    Set Selenium Speed    0.5s
    Go To Transfer Menu
    WEB Click Element    ${BO_add_withdraw_item_btn}
    WEB Set Focus To Element     ${BO_search_user_withdraw_txt}
    WEB Input Text    ${BO_search_user_withdraw_txt}    ${username}
    WEB Press Keys    ${BO_search_user_withdraw_txt}    ENTER
    WEB Input Text    ${BO_modal_withdraw_amt_txt}     ${withdraw}
    WEB Press Keys    ${BO_modal_withdraw_amt_txt}    ENTER
    WEB Click Element    ${BO_modal_confirm_btn}
    WEB Set Focus To Element     ${BO_final_comfirm_modal}
    WEB Click Element     ${BO_modal_final_confirm_transfer_btn}
    WEB Sleep
    Admin confirm transfer money to user bank account should be success    ${username}
    Verify withdraw is completly success on History tab    ${username}    ${withdraw}

Admin confirm transfer money to user bank account should be success
    [Arguments]    ${username}
    ${button}=    Format Text    ${BO_transfer_btn}    row_index=${username}
    ${transfer_btn}=   Set Variable    ${button}
    Scroll Element Into View    ${transfer_btn}
    Web Mouse Over    ${transfer_btn}
    WEB Set Focus To Element     ${BO_transfer_select_bank_dp}
    WEB Click Element    ${BO_transfer_select_bank_dp}
    WEB Verify Element Visible    ${BO_modal_confirm_transfer}
    WEB Click Element    ${BO_modal_select_bank_txt}
    WEB Sleep
    WEB Set Focus To Element    ${BO_modal_select_bank_component}
    Press Keys    ${BO_madal_select_bank}    ENTER
    WEB Click Element    ${BO_modal_confirm_transfer_via_bank}
    WEB Set Focus To Element    ${BO_modal_confirm_transfer}
    WEB Click Element    ${BO_alert_modal_final_confirm_btn}
    WEB Sleep

Verify withdraw is completly success on History tab
    [Arguments]    ${username}    ${withdraw_amount}    ${status}=ถอนเงินสำเร็จ
    Scroll Element Into View    ${BO_transfer_history_tab}
    WEB Click Element    ${BO_transfer_history_tab}
    

    ${ele_name}=    Format Text    ${BO_verify_transfer_to_username}    username=${username}
    ${user_name}=   Set Variable    ${ele_name}

    ${ele_amount}=    Format Text    ${BO_verify_transfer_amount}    amount=${withdraw_amount}
    ${amount}=   Set Variable    ${ele_amount}
    
    ${ele_status}=    Format Text    ${BO_verify_transfer_status}    status=${status}
    ${status}=   Set Variable    ${ele_status}

    WEB Verify Element Visible    ${user_name}

    Page Should Contain Element    ${user_name}
    Page Should Contain Element    ${amount}
    Page Should Contain Element    ${status}

Create withdraw request
    [Arguments]    ${username}    ${withdraw}
    Set Selenium Speed    0.5s
    Go To Transfer Menu
    WEB Click Element    ${BO_add_withdraw_item_btn}
    WEB Set Focus To Element     ${BO_search_user_withdraw_txt}
    WEB Input Text    ${BO_search_user_withdraw_txt}    ${username}
    WEB Press Keys    ${BO_search_user_withdraw_txt}    ENTER
    WEB Input Text    ${BO_modal_withdraw_amt_txt}     ${withdraw}
    WEB Press Keys    ${BO_modal_withdraw_amt_txt}    ENTER
    WEB Click Element    ${BO_modal_confirm_btn}
    WEB Set Focus To Element     ${BO_final_comfirm_modal}
    WEB Click Element     ${BO_modal_final_confirm_transfer_btn}
    WEB Sleep

Reject withdraw should be success
    [Arguments]    ${username}
    Go To Transfer Menu
    Admin reject withdraw    ${username}

Admin reject withdraw
    [Arguments]    ${username}
    ${button}=    Format Text    ${BO_transfer_btn}    row_index=${username}
    ${transfer_btn}=   Set Variable    ${button}
    Scroll Element Into View    ${transfer_btn}
    Web Mouse Over    ${transfer_btn}
    Press Keys    ${transfer_btn}    ARROW_UP
    Web Mouse Over    ${BO_dropdown_bank_transfer}
    WEB Set Focus To Element     ${BO_dropdown_bank_transfer}
    WEB Click Element    ${BO_dropdown_bank_transfer}
    WEB Set Focus To Element     ${BO_modal_confirm_transfer}
    WEB Sleep
    WEB Click Element    ${BO_modal_reject_transfer_btn}
    WEB Set Focus To Element    ${BO_modal_confirm_transfer}
    WEB Click Element    ${BO_alert_modal_final_confirm_btn}
    WEB Sleep

Verify the status should be "ปฏิเสธถอนเงิน"
    [Arguments]    ${username}    ${withdraw_amount}    ${status}=ปฏิเสธถอนเงิน
    Scroll Element Into View    ${BO_transfer_history_tab}
    WEB Click Element    ${BO_transfer_history_tab}

    ${ele_name}=    Format Text    ${BO_verify_transfer_to_username}    username=${username}
    ${user_name}=   Set Variable    ${ele_name}

    ${ele_amount}=    Format Text    ${BO_verify_transfer_amount}    amount=${withdraw_amount}
    ${amount}=   Set Variable    ${ele_amount}
    
    ${ele_status}=    Format Text    ${BO_verify_transfer_status}    status=${status}
    ${status}=   Set Variable    ${ele_status}

    Page Should Contain Element    ${user_name}
    Page Should Contain Element    ${amount}
    Page Should Contain Element    ${status}

Create withdraw affiliate request
    [Arguments]    ${username}    ${withdraw}
    Set Selenium Speed    0.5s
    Go To Transfer Menu
    WEB Click Element    ${BO_affi_radio_tab}
    WEB Click Element    ${BO_add_withdraw_item_btn}
    WEB Set Focus To Element     ${BO_search_user_withdraw_txt}
    WEB Input Text    ${BO_search_user_withdraw_txt}    ${username}
    WEB Press Keys    ${BO_search_user_withdraw_txt}    ENTER
    WEB Input Text    ${BO_modal_withdraw_amt_txt}     ${withdraw}
    WEB Press Keys    ${BO_modal_withdraw_amt_txt}    ENTER
    WEB Click Element    ${BO_modal_confirm_btn}
    WEB Set Focus To Element     ${BO_final_comfirm_modal}
    WEB Click Element     ${BO_modal_final_confirm_transfer_btn}
    WEB Sleep
    


