*** Settings ***
Resource          ${CURDIR}/../../import.robot


*** Keywords ***

Create new ticket for a user
    [Arguments]    ${username}    ${campaign_code}    ${campaign_name}    ${ticket_amount}
    WEB Click Element    ${BO_create_ticket_btn}
    Web Input Text   ${BO_pscode_txt}    ${username}
    Web Input Text   ${BO_campaign_code_txt}    ${campaign_code}
    Web Input Text   ${BO_campaign_name_txt}    ${campaign_name}
    Web Input Text   ${BO_ticket_amount_txt}    ${ticket_amount}
    WEB Click Element    ${BO_confirm_add_btn}
    WEB Sleep
    WEB Set Focus To Element    ${BO_modal_component}
    WEB Click Element    ${BO_confirm_add_btn}
    WEB Sleep
    Reload Page

Verify the ticket is completly created
    [Arguments]    ${username}    ${previous_balance}    ${ticket_amount}
    ${current_ticket}    Get total current tickets    ${username}
    ${expect_balance_ticet}    Evaluate    ${previous_balance} + ${ticket_amount}
    Should Be Equal As Numbers    ${expect_balance_ticet}    ${current_ticket}

Get total current tickets
    [Arguments]    ${username}
    Search for customer name    ${username}
    ${current_ticket}    WEB Get Element Text    ${BO_total_balance_ticket}
    ${current_ticket}    Convert To Number    ${current_ticket}
    [Return]    ${current_ticket}

Search for customer name
    [Arguments]    ${username}
    Web Input Text   ${BO_search_customer}    ${username}
    WEB Press Keys    ${BO_search_customer}    ENTER
    