***Keywords***
Click Wallet Deposit Tab
    WEB Click Element    ${WAP_deposit_tab}

Click QR Transfer Deposit Tab
    WEB Click Element    ${WAP_QR_tab}

Click Bank Transfer Deposit Tab
    WEB Click Element    ${WAP_bank_tab}

Click True wallet Transfer Deposit Tab
    WEB Click Element    ${WAP_true_wallet_tab}

Input QR Deposit amount
    [Arguments]    ${deposit_amount}
    WEB Input Text    ${WAP_QR_deposit_amount_inp}    ${deposit_amount}

Click Generate QR Button
    ${current_time}    WEB Get DateTime    plus_hour=+0
    WEB Click Element    ${WAP_QR_gen_btn}    is_scroll_asist=${true}
    [Return]    ${current_time}

Verify QR Generated Information on Client
    ${qr_transfer_amount}    WEB Get Element Text    ${WAP_QR_transfer_amount}
    ${qr_bank_name}    WEB Get Element Text    ${WAP_QR_bank_name}
    ${qr_transfer_amount}    Split String    ${qr_transfer_amount}
    ${qr_bank_name}    Split String    ${qr_bank_name}
    [Return]    ${qr_transfer_amount}[1]    ${qr_bank_name}[1] ${qr_bank_name}[2]

Verify QR Generateed Information From DB
    [Arguments]    ${customer_code}    ${qr_transfer_amount}    ${generate_time}    
    ...    ${request_amount}    ${bank_name}
    ${qr_infor_dict}    QUERY QR Transfer Information From User Code    ${customer_code}    ${qr_transfer_amount}    ${generate_time}
    Should Be Equal As Numbers    ${request_amount}    ${qr_infor_dict}[request_amount]
    Should Be Equal As Strings    ${bank_name}    ${qr_infor_dict}[bank_name]

Click Copy SCB Account Number
    WEB Click Element    ${WAP_SCB_copy_btn}

Click Copy KBANK Account Number
    WEB Click Element    ${WAP_KBANK_copy_btn}

Verify Copied Account number is correct
    [Arguments]    ${bank}
    ${bank}   Convert To Upper Case    ${bank}
    ${fe_acc_number}    WEB Get Element Text    ${WAP_${bank}_bank_account}
    ${fe_acc_number}    Remove String    ${fe_acc_number}    -
    ${clipboard_text}    WEB Paste text from clipboard
    Should Be Equal As Strings    ${fe_acc_number}    ${clipboard_text}

Click Copy True Wallet Number
    WEB Click Element    ${WAP_true_wallet_copy_btn}

Click Withdraw tab
    WEB Click Element    ${WAP_withdraw_tab}

Input Withdraw amount
    [Arguments]    ${withdraw_amount}
    WEB Input Text    ${WAP_withdraw_amount}    ${withdraw_amount}

Check If User Have Bonus Wallet
    [Arguments]    ${user_code}
    ${bonus_balance}    Get user bonus wallet balance amount    ${user_code}
    ${is_have_bonus_wallet}   Run Keyword And Return Status    Should Be True   '${bonus_balance}'>'0'
    [Return]    ${is_have_bonus_wallet}

Click Request Withdraw
    [Arguments]    ${is_have_bonus_wallet}
    ${current_time}    WEB Get DateTime    plus_hour=+0
    WEB Click Element    ${WAP_withdraw_btn}
    IF    ${is_have_bonus_wallet}
        WEB Click Element     ${WAP_Witdraw_deactive_bonus_ok_btn}
    END
    [Return]    ${current_time}

Verify wallet page successfully withdraw
    [Arguments]    ${user_code}
    ${API_current_user_balance}    Get user balance wallet    ${user_code}
    ${client_current_user_balance}    WEB Get Element Text    ${WAP_cash_balance}
    ${client_current_user_balance}    Remove String    ${client_current_user_balance}    ,
    Should Be Equal As Numbers    ${API_current_user_balance}    ${client_current_user_balance}

Verify withdraw request has been created at Backoffice Database
    [Arguments]    ${customer_code}    ${request_time}    ${withdraw_amount}
    ${BO_request_amount}    Query User Withdraw Request    ${customer_code}    ${request_time}    ${withdraw_amount}
    Should Not Be Empty    ${BO_request_amount}

Verify Not Enough Modal Display And Click Ok
    WEB Verify Element Visible    ${WAP_withdraw_not_enough_title}
    WEB Click Element    ${WAP_withdraw_not_enough_btn}

Verify More than Maximum per Times Text Display
    WEB Verify Element Visible    ${WAP_withdraw_limit_txt}