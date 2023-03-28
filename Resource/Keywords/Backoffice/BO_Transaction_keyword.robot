*** Settings ***
Resource          ${CURDIR}/../../import.robot


*** Keywords ***
Get system current balance amount on transaction page 
    ${balance}    WEB Get Element Text    ${automated_account_balance}
    [Return]    ${balance} 

Verify the money is added into system saving account correctly
    [Arguments]    ${previous_balance}    ${current_balance}    ${transfer_amount}

    ${previous_balance}=   Remove String    ${previous_balance}    ,
    ${previous_balance} =    Convert To Number    ${previous_balance}

    ${current_balance}=   Remove String    ${current_balance}    ,
    ${current_balance} =    Convert To Number    ${current_balance}

    ${expect_balance}=    Evaluate    ${previous_balance} + ${transfer_amount}
    Should Be Equal As Numbers    ${expect_balance}    ${current_balance}
