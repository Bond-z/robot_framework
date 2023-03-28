*** Settings ***
# Test Setup    Open Pigspin Back Office Website
Test Teardown     WEB Teardown common keyword  
Metadata          name    Backoffice usermanagement
Resource          ${CURDIR}/../../../Resource/import.robot

*** Test Cases ***

UMT-001 Verify Admin can be able to deposit to user cash wallet correctly
    [Tags]    BO-001    BO   inactive    DESKTOP
    Set Selenium Speed    0.5s
    Set Test Variable    ${deposit}    ${10}
    BO Login
    Go To Deposit Page And Create New Deposit     ${cl_user.common.normal.bank.account.uncensor}    ${deposit}
    Go To ToDo List Tab And Confirm Deposit     ${cl_user.common.normal.phone.uncensor}
    Verify Deposit Should Be Successful     ${cl_user.common.normal.phone.uncensor}

UMT-002 Verify add bonus to user's wallet should be success
    [Tags]    BO-002    BO   inactive    DESKTOP
    Set Test Variable    ${topup}    ${5}
    Set Test Variable    ${turn_over}    ${1}
    BO Login
    Topup bonus to user wallet     ${cl_user.common.normal.username}    ${topup}    ${turn_over}
    Verify user's bonus wallet should be received bonus correctly    ${topup}

UMT-003 Verify upline total income should be calculated correctly
    [Tags]    BO-003    BO   inactive    DESKTOP
    Set Selenium Speed    0.5s
    BO Login
    Go To Affiliate Overview Page
    ${total_income}=    Verify and get total active balance on Affiliate Over Page     ${cl_user.common.normal.username}
    Go To Transfer Menu And Click On Tab Friend Suggestion
    ${balance_amount}=    Create New Withdraw And Get Balance Amount    ${cl_user.common.normal.username}
    Should Be Equal As Numbers    ${total_income}    ${balance_amount}