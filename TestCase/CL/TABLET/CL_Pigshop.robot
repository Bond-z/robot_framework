*** Settings ***
Metadata          name    Pigshop
Test Teardown     WEB Teardown common keyword
Resource          ${CURDIR}/../../../Resource/import.robot
Resource          ../../../Resource/Keywords/CL/CL_Pigshop.robot

*** Test Cases ***
LYS-014 Verify user wallet and ticket amount when user successfully redeem free credit
    [Documentation]    Implementer: Fluke
    [Tags]    TLYS-14    active    TABLET
    [Setup]   Set Up To Open Browser And Prepare User Ticket    agent    user_ticket=10000
    CL Login
    CL Click PigShop At Hamburger Menu
    ${before_balance}    Get user balance wallet    ${TEST_USER.user_code}
    ${title}    ${title_str_list}    Get Freecredit Title    index=1
    ${reward_amount}    Remove String    ${title_str_list}[1]    ,
    ${reward_amount}    Convert To Number    ${reward_amount}
    Click Freecredit claim button    index=1
    Click Redeem ok Button
    Click Reward Modal Ok Button
    ${expected_balance}    Evaluate    ${before_balance}+${reward_amount}
    ${after_balance}    Get user balance wallet    ${TEST_USER.user_code}
    Should Be Equal As Numbers    ${after_balance}    ${expected_balance}

LYS-022 Verify user ticket amount when user successfully redeem free spin
    [Documentation]    Implementer: Fluke
    [Tags]    TLYS-22    active    TABLET
    [Setup]   Set Up To Open Browser And Prepare User Ticket    agent    user_ticket=10000
    CL Login
    CL Click PigShop At Hamburger Menu
    ${before_ticket}    Get current ticket amount
    ${title}    ${title_str_list}    Get Freespin Amount    index=1
    ${reward_amount}    Remove String    ${title_str_list}[1]    ,
    ${reward_amount}    Convert To Number    ${reward_amount}
    Click Freespin claim button    index=1
    Click Redeem ok Button
    Click Reward Modal Ok Button
    ${expected_ticket}    Evaluate    ${before_ticket}-${reward_amount}
    ${after_ticket}    Get current ticket amount
    Should Be Equal As Numbers    ${after_ticket}    ${expected_ticket}

*** Keywords ***
Set Up To Open Browser And Prepare User Ticket
    [Arguments]    ${user_type}    ${common_type}=normal    ${user_ticket}=10000
    CL Setup Test User    ${user_type}    ${common_type}
    IF    '${user_type}'=='agent'
        INSERT or UPDATE user Ticket    ${TEST_USER.username}    ${user_ticket}
    END
    CL Open Pigspin Website