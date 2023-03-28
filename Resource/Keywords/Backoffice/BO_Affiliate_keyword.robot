*** Settings ***
Resource          ${CURDIR}/../../import.robot

*** Keywords ***

Search for upline user
    [Arguments]    ${username}
    Web Input Text   ${BO_user_search_txt}    ${username}
    WEB Press Keys    ${BO_user_search_txt}    ENTER    
    Sleep    5s

Add income to upline by affiliate type 'ยืนยันตัวตน'
    [Arguments]    ${username}    ${amount}
    WEB Click Element    ${BO_add_affi_income_btn}
    WEB Set Focus To Element    ${BO_modal_content}
    Web Input Text   ${BO_input_usercode}    ${username}
    Click Element    ${BO_input_affi_type} 
    WEB Sleep
    Click Element    ${BO_income_type_kyc}
    Web Input Text   ${BO_affi_amount}    ${amount}
    Click Element    ${BO_affi_remark}
    WEB Sleep
    Click Element    ${BO_remark_type_mistaken}
    WEB Sleep
    Click Element    ${BO_modal_confirm_btn}
    WEB Set Focus To Element    ${BO_modal_content}
    WEB Click Element    ${BO_final_confirm_btn}
    WEB Sleep 

Add income to upline by affiliate type 'เติมเงินครั้งแรก'
    [Arguments]    ${username}    ${amount}
    WEB Click Element    ${BO_add_affi_income_btn}
    WEB Set Focus To Element    ${BO_modal_content}
    Web Input Text   ${BO_input_usercode}    ${username}
    Click Element    ${BO_input_affi_type} 
    WEB Sleep
    Click Element    ${BO_income_type_first_deposit}
    Web Input Text   ${BO_affi_amount}    ${amount}
    Click Element    ${BO_affi_remark}
    WEB Sleep
    Click Element    ${BO_remark_type_mistaken}
    WEB Sleep
    Click Element    ${BO_modal_confirm_btn}
    WEB Set Focus To Element    ${BO_modal_content}
    WEB Click Element    ${BO_final_confirm_btn}
    WEB Sleep 

Add income to upline by affiliate type 'ยอดเสีย'
    [Arguments]    ${username}    ${amount}
    WEB Click Element    ${BO_add_affi_income_btn}
    WEB Set Focus To Element    ${BO_modal_content}
    Web Input Text   ${BO_input_usercode}    ${username}
    Click Element    ${BO_input_affi_type} 
    WEB Sleep
    Click Element    ${BO_income_type_lost}
    Web Input Text   ${BO_affi_amount}    ${amount}
    Click Element    ${BO_affi_remark}
    WEB Sleep
    Click Element    ${BO_remark_type_mistaken}
    WEB Sleep
    Click Element    ${BO_modal_confirm_btn}
    WEB Set Focus To Element    ${BO_modal_content}
    WEB Click Element    ${BO_final_confirm_btn}
    WEB Sleep 

Verify added income by type 'ยืนยันตัวตน' should be successful
    [Arguments]    ${previous_total_kyc}    ${amount}
    ${total_kyc_after_added}    WEB Get Element Text    ${BO_total_income_kyc}
    ${total_kyc_after_added}    Convert To Number    ${total_kyc_after_added}

    ${expect_amount}    Evaluate    ${previous_total_kyc} + ${amount}
    Should Be Equal As Numbers    ${total_kyc_after_added}    ${expect_amount}

Verify added income by type 'เติมเงินครั้งแรก' should be successful
    [Arguments]    ${previous_total}    ${amount}
    ${total_income_after_added}    WEB Get Element Text    ${BO_total_income_1st_deposit}
    ${total_income_after_added}    Convert To Number    ${total_income_after_added}

    ${expect_amount}    Evaluate    ${previous_total} + ${amount}
    Should Be Equal As Numbers    ${total_income_after_added}    ${expect_amount}

Verify added income by type 'ยอดเสีย' should be successful
    [Arguments]    ${previous_total}    ${amount}
    ${total_income_after_added}    WEB Get Element Text    ${BO_total_income_from_lost}
    ${total_income_after_added}    Convert To Number    ${total_income_after_added}

    ${expect_amount}    Evaluate    ${previous_total} + ${amount}
    Should Be Equal As Numbers    ${total_income_after_added}    ${expect_amount}

Cancel affiliate 'แบบกำหนดเอง'
    [Arguments]    ${username}    ${amount}    ${affi_type}
    ${edit_btn}=    Format Text    ${BO_edit_affi_btn}    affi_type=${affi_type}
    ${edit_btn}=   Set Variable    ${edit_btn}

    Set Selenium Speed    0.5
    WEB Click Element    ${edit_btn}
    Click Element    ${BO_cancel_affi_btn}
    WEB Set Focus To Element    ${BO_modal_content}
    WEB Click Element    ${BO_final_confirm_btn}
    WEB Sleep 

Verify affiliate KYC balance amount should be corrected
    [Arguments]    ${previous_total_kyc}    ${amount}
    ${total_kyc_after_added}    WEB Get Element Text    ${BO_total_income_kyc}
    ${total_kyc_after_added}    Convert To Number    ${total_kyc_after_added}

    ${expect_amount}    Evaluate    ${previous_total_kyc} - ${amount}
    Should Be Equal As Numbers    ${total_kyc_after_added}    ${expect_amount}

Verify affiliate first deposit balance amount should be corrected
    [Arguments]    ${previous_total}    ${amount}
    ${total_after_added}    WEB Get Element Text    ${BO_total_income_1st_deposit}
    ${total_after_added}    Convert To Number    ${total_after_added}

    ${expect_amount}    Evaluate    ${previous_total} - ${amount}
    Should Be Equal As Numbers    ${total_after_added}    ${expect_amount}

Verify affiliate from lost spent balance amount should be corrected
    [Arguments]    ${previous_total}    ${amount}
    ${total_after_added}    WEB Get Element Text    ${BO_total_income_from_lost}
    ${total_after_added}    Convert To Number    ${total_after_added}

    ${expect_amount}    Evaluate    ${previous_total} - ${amount}
    Should Be Equal As Numbers    ${total_after_added}    ${expect_amount}

Verify the status should be corrected
    [Arguments]   ${downline_user}      ${status}
    ${ele_status}=    Format Text    ${BO_affiliate_status}    user=${downline_user}
    ${affi_status}=   Set Variable    ${ele_status}

    Element Should Contain    ${affi_status}    ${status}

 

