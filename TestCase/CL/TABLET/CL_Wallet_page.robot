*** Settings ***
Test Teardown     WEB Teardown common keyword  
Metadata          name    Wallet Page
Resource          ${CURDIR}/../../../Resource/import.robot

*** Test Cases ***
DEP-032 Verify user be able to generate QR code for deposit
    [Documentation]    Implementer: Fluke
    [Tags]    TDEP-32    active    TABLET    PRODUCTION
    [Setup]    Set Up Common Keyword For Wallet Page    user_type=agent
    ${rad_deposit_amount}    Generate random string    3    123456789
    Set Test Variable    ${QR_DEPOSIT_AMOUNT}    ${rad_deposit_amount}
    CL Login
    CL Click Wallet At Hamburger Menu
    Click Wallet Deposit Tab
    Click QR Transfer Deposit Tab
    Input QR Deposit amount    ${QR_DEPOSIT_AMOUNT}
    ${generate_time}    Click Generate QR Button
    ${qr_transfer_amount}    ${bank_name}    Verify QR Generated Information on Client
    Verify QR Generateed Information From DB    customer_code=${TEST_USER.username}    qr_transfer_amount=${qr_transfer_amount}    generate_time=${generate_time}    request_amount=${QR_DEPOSIT_AMOUNT}    bank_name=${bank_name}

DEP-029 Verify user be able to copy SCB banking to clipboard
    [Documentation]    Implementer: Fluke
    [Tags]    TDEP-29    active    TABLET    PRODUCTION
    [Setup]    Set Up Common Keyword For Wallet Page    user_type=agent
    CL Login
    CL Click Wallet At Hamburger Menu
    Click Wallet Deposit Tab
    Click Bank Transfer Deposit Tab
    Click Copy SCB Account Number
    Verify Copied Account number is correct    bank=SCB


DEP-030 Verify user be able to copy Kbank banking to clipboard
    [Documentation]    Implementer: Fluke
    [Tags]    TDEP-30    active    TABLET    PRODUCTION
    [Setup]    Set Up Common Keyword For Wallet Page    user_type=agent
    CL Login
    CL Click Wallet At Hamburger Menu
    Click Wallet Deposit Tab
    Click True wallet Transfer Deposit Tab
    Click Copy True Wallet Number
    Verify Copied Account number is correct    bank=KBANK


DEP-031 Verify user be able to copy True wallet banking to clipboard
    [Documentation]    Implementer: Fluke
    [Tags]    TDEP-31    active    TABLET    PRODUCTION
    [Setup]    Set Up Common Keyword For Wallet Page    user_type=agent
    CL Login
    CL Click Wallet At Hamburger Menu
    Click Wallet Deposit Tab
    Click True wallet Transfer Deposit Tab
    Click Copy True Wallet Number
    Verify Copied Account number is correct    bank=TRUE


WIT-021 Verify when user successfully request withdraw
    [Documentation]    Implementer: Fluke
    [Tags]    WIT-21    active    
    [Setup]    Set Up user Wallet and Bonus Balance    wallet_balance=25000    user_type=agent
    ${rad_withdraw_amount}    Generate random string    3    123456789
    CL Login
    CL Click Withdraw At Hamburger Menu
    Click Withdraw tab
    Input Withdraw amount    ${rad_withdraw_amount}
    ${is_have_bonus_wallet}    Check If User Have Bonus Wallet    ${TEST_USER.user_code}
    ${request_time}    Click Request Withdraw    ${is_have_bonus_wallet}
    Verify withdraw request has been created at Backoffice Database    customer_code=${TEST_USER.username}    request_time=${request_time}    withdraw_amount=${rad_withdraw_amount}
    Verify wallet page successfully withdraw    user_code=${TEST_USER.user_code}

WIT-022 Verify when user request withdraw more than current balance
    [Documentation]    Implementer: Fluke
    [Tags]    WIT-22    active    PRODUCTION
    [Setup]    Set Up user Wallet and Bonus Balance    wallet_balance=25000    user_type=agent
    CL Login
    CL Click Withdraw At Hamburger Menu
    Click Withdraw tab
    ${more_than_balance}    Evaluate    ${WALLET_BALANCE}+100
    Input Withdraw amount    ${more_than_balance}
    ${is_have_bonus_wallet}    Check If User Have Bonus Wallet    ${TEST_USER.user_code}
    ${request_time}    Click Request Withdraw    ${is_have_bonus_wallet}
    Verify Not Enough Modal Display And Click Ok

WIT-023 Verify when user request withdraw more than maximum limit
    [Documentation]    Implementer: Fluke
    [Tags]    WIT-23    active    PRODUCTION
    [Setup]    Set Up user Wallet and Bonus Balance    wallet_balance=25000    user_type=agent
    Set Test Variable    ${MAXIMUM_WITHDRAW_PER_TIMES}    100000
    CL Login
    CL Click Withdraw At Hamburger Menu
    Click Withdraw tab
    ${more_than_max}    Evaluate    ${MAXIMUM_WITHDRAW_PER_TIMES}+100
    Input Withdraw amount    ${more_than_max}
    Verify More than Maximum per Times Text Display

*** Keywords ***
Set Up Common Keyword For Wallet Page
    [Arguments]    ${user_type}=common    ${common_type}=normal
    CL Setup Test User    ${user_type}    ${common_type}
    CL Open Pigspin Website


Set Up user Wallet and Bonus Balance
    [Arguments]    ${wallet_balance}    ${cash_balance}=${False}    ${user_type}=common    ${common_type}=normal
    CL Setup Test User    ${user_type}    ${common_type}
    Set Test Variable    ${WALLET_BALANCE}    ${wallet_balance}
    Clear bonus wallet and cash wallet    player_name=${TEST_USER.username}    user_code=${TEST_USER.user_code}
    Deposit cash to user wallet    user_code=${TEST_USER.user_code}    transaction_amount=${wallet_balance}
    CL Open Pigspin Website