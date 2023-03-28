*** Settings ***
Resource          CL_Common.robot
Resource          CL_LandingPage.robot
Resource          ../../Locators/CL/CL_Pigshop.robot
Variables         ../../Localize/CL/TH/CL_Pigshop.yaml


***Keywords***
Get current ticket amount
    Wait until Loading screen finished loading
    ${current_ticket}   WEB Get Element Text    ${LYS_ticket_amount}
    ${current_ticket}    Split String    ${current_ticket}
    ${current_ticket}    Remove String    ${current_ticket}[0]    ,
    ${current_ticket}    Convert To Number    ${current_ticket}
    [Return]    ${current_ticket}

Click Freecredit claim button
    [Arguments]    ${index}=1
    ${freecredit_btn}    Replace String    ${LYS_free_credit_redeem_btn}    <index>    ${index}
    WEB Click Element    ${freecredit_btn}

Click Freespin claim button
    [Arguments]    ${index}=1
    ${freespin_btn}    Replace String    ${LYS_free_spin_redeem_btn}    <index>    ${index}
    WEB Click Element    ${freespin_btn}    is_scroll_asist=${true}

Get Freecredit Title
    [Arguments]    ${index}=1
    ${freecredit_title}    Replace String    ${LYS_free_credit_title}    <index>    ${index}
    ${text}    WEB Get Element Text    ${freecredit_title}
    ${text_list}    Split String    ${text}
    [Return]    ${text}    ${text_list}

Get Freespin Amount
    [Arguments]    ${index}=1
    ${freespin_amount}    Replace String    ${LYS_free_spin_amount_txt}    <index>    ${index}
    ${text}    WEB Get Element Text    ${freespin_amount}
    ${text_list}    Split String    ${text}
    [Return]    ${text}    ${text_list}

Click Redeem ok Button
    WEB Click Element     ${LYS_redeem_ok_btn}

Wait until Loading screen finished loading
    Wait until Keyword Succeeds    ${TIMEOUT.${ar_DOMAIN}.RETRY}    ${TIMEOUT.${ar_DOMAIN}.RETRY_INTERVAL}    Verify Loading Screen Finished

Verify Loading Screen Finished
    ${class}=    SeleniumLibrary.Get Element Attribute    locator=${LYS_loading_screen}    attribute=class
    log to console    ${\n}Checking ${class}
    Should Not Contain    ${class}    active