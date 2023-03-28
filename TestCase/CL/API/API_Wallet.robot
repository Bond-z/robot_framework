*** Settings ***
Resource          ${CURDIR}/../../../Resource/import.robot
Metadata          name    Wallet API
Test Teardown     WEB Teardown common keyword

*** Test Case ***

WAL-009 Verify when bet with only cash wallet should deduct amount of money on wallet correctly
    [Documentation]   User has 2 wallets
    ...     After bet, the money will be deducted from cash wallet only  
    ...     Bet = 10 Baht
    [Tags]   WAL-9    active    wallet1    API
    [Setup]    Set Up Common Keyword For User Wallet
    Set Test Variable    ${game_provider}    JOKER
    Set Test Variable    ${game_id}    3erm9p7wssiks
    # Clear bonus wallet and cash wallet    ${TEST_USER.username}    user_code=${TEST_USER.user_code}
    # Deposit cash to user wallet    ${TEST_USER.user_code}    ${15}

    ${cash_balance}=    Get user cash wallet balance amount      ${TEST_USER.user_code}
    Set Test Variable    ${bet_amount}    ${100}
    Set Test Variable    ${cash_before_bet}    ${cash_balance}
    ${bonus_wallet}=       Get user bonus wallet balance amount     ${TEST_USER.user_code}
   
    # Spin game without winning the game    ${TEST_USER.username}    ${bet_amount}    ${game_provider}    ${game_id}
    # ${expect_cash_balance}=    Evaluate    ${cash_before_bet} - ${bet_amount}
    # ${cash_after_bet}=    Get user cash wallet balance amount       ${TEST_USER.user_code}
    # ${bonus_wallet_after_bet}=       Get user bonus wallet balance amount     ${TEST_USER.user_code}
    # Should Be Equal As Numbers    ${expect_cash_balance}    ${cash_after_bet}
    # Should Be Equal As Numbers    ${bonus_wallet}    ${bonus_wallet_after_bet}

WAL-010 Verify when bet with only cash wallet and get payout correctly
    [Documentation]   Bet using only cash wallet and win the game
    ...     The money should add into cash wallet only
    [Tags]   WAL-10    active    wallet    API
    [Setup]    Set Up Common Keyword For User Wallet
    Set Test Variable    ${bet_amount}    ${1}
    Set Test Variable    ${win_amount}    ${5}
    Set Test Variable    ${game_provider}    JOKER
    Set Test Variable    ${game_id}    3erm9p7wssiks
    Clear bonus wallet and cash wallet    ${TEST_USER.username}    user_code=${TEST_USER.user_code}
    Deposit cash to user wallet    ${TEST_USER.user_code}    ${5}

    ${cash_balance}=    Get user cash wallet balance amount      ${TEST_USER.user_code}
    Set Test Variable    ${cash_before_bet}    ${cash_balance}

    ${expect_bonus_balance}=       Get user bonus wallet balance amount     ${TEST_USER.user_code}

    Spin and win the game     ${TEST_USER.username}    ${bet_amount}    ${win_amount}     ${game_provider}    ${game_id}    
    ${cash_after_bet}=    Get user cash wallet balance amount      ${TEST_USER.user_code}
    ${bonus_wallet_after_bet}=       Get user bonus wallet balance amount     ${TEST_USER.user_code}
    ${expect_cash_balance}=    Evaluate    ${cash_before_bet} - ${bet_amount} + ${win_amount}
    Should Be Equal As Numbers    ${expect_cash_balance}    ${cash_after_bet}
    Should Be Equal As Numbers    ${expect_bonus_balance}    ${bonus_wallet_after_bet}


WAL-11 Verify when bet with cash + bonus wallet should be deducted money from 2 wallets correctly
    [Documentation]   Bet using both wallets
    ...     To verify the wallets were deducted correctly
    [Tags]   WAL-011    active    wallet    API
    [Setup]    Set Up Common Keyword For User Wallet
    Set Test Variable    ${game_provider}    JOKER
    Set Test Variable    ${game_id}    3erm9p7wssiks
    Clear bonus wallet and cash wallet    ${TEST_USER.username}    user_code=${TEST_USER.user_code}
    WEB Sleep
    Deposit cash to user wallet    ${TEST_USER.user_code}    ${10}

    #Get both wallets and use money from both wallets
    ${balance}    Get user balance wallet    ${TEST_USER.user_code}

    Spin game without winning the game    ${TEST_USER.username}    ${balance}    ${game_provider}    ${game_id} 
    WEB Sleep
    ${balance_after_bet}=    Get user balance wallet    ${TEST_USER.user_code}

    Should Be Equal As Numbers    ${balance_after_bet}    ${0}

WAL-12 Verify when bet with cash + bonus wallet and get payout
    [Documentation]   Bet using both wallets
    ...     and verify that the payout was added into both wallets correctly
    ...     | ---- *Formular* ---- |
    ...     Bet = 8 baht
    ...     Win = 3.2 baht
    ...     Split bonus to 2 wallets = Win/Bet => 3.2/8 > ratio = 0.4
    ...     To Cash wallet => Bet 4.8 baht >> 4.8*0.4 = 1.92
    ...     To Bonus wallet => Bet 3.2 baht >> 3.2*0.4 = 1.28
    [Tags]   WAL-012    active    wallet    API
    [Setup]    Set Up Common Keyword For User Wallet
    Set Test Variable    ${deposit}    ${10}
    Set Test Variable    ${win_amount}    ${20}
    Set Test Variable    ${game_provider}    JOKER
    Set Test Variable    ${game_id}    3erm9p7wssiks

    Clear bonus wallet and cash wallet    ${TEST_USER.username}    user_code=${TEST_USER.user_code}
 
    Deposit cash to user wallet    ${TEST_USER.user_code}    ${deposit}

    ${cash_balance}=    Get user cash wallet balance amount      ${TEST_USER.user_code}

    ${balance}    Get user balance wallet    ${TEST_USER.user_code}
    Set Test Variable    ${bet_amount}    ${balance}

    #Get amount of bunus wallet will be deducted
    ${deducted_bonus_wallet}=    Evaluate    ${bet_amount} - ${cash_balance}

    #Get bonus wallet balance after bet
    ${bonus_balance}=    Get user bonus wallet balance amount     ${TEST_USER.user_code}
    ${bonus_wallet_remaining}=    Evaluate    ${bonus_balance} - ${deducted_bonus_wallet}
   
    Spin and win the game     ${TEST_USER.username}    ${bet_amount}    ${win_amount}    ${game_provider}    ${game_id} 
    ${expect_cash_wallet_balance}    ${expect_bonus_wallet_balance}     Calculate split payout amount to the wallets    ${TEST_USER.username}    ${deposit}    ${bet_amount}    ${win_amount}   ${bonus_wallet_remaining}    ${deducted_bonus_wallet}
   
    Verify both wallets should receive payout bonus correctly    ${TEST_USER.user_code}    ${expect_cash_wallet_balance}    ${expect_bonus_wallet_balance}

WAL-13 Verify when bet with 3 wallets in the same time, all wallet should be deducted correctly
    [Documentation]   Bet using 3 wallets
    ...     To verify all wallets were deducted correctly
    [Tags]   WAL-013    inactive    wallet    API
    [Setup]    Set Up Common Keyword For User Wallet
    Set Test Variable    ${bonus}    ${10}
    Set Test Variable    ${turn_over}    ${100}
    Set Test Variable    ${game_provider}    JOKER
    Set Test Variable    ${game_id}    3erm9p7wssiks

    Clear bonus wallet and cash wallet    ${TEST_USER.username}    user_code=${TEST_USER.user_code}
    WEB Sleep
    #Deposit cash
    Deposit cash to user wallet    ${TEST_USER.user_code}    ${10}
    
    ############### Currently topup via api it doesn't work, wait Dev to help to provide the new one ##############
    #Topup bonus wallet 1
    # Topup user bonus wallet   ${TEST_USER.username}    25    0.1
    #Topup bonus wallet 2
    # Topup user bonus wallet   ${TEST_USER.username}    10    0.1

    #----------- Topup bonus wallet via Backoffice ------------#
    BO Login
    Topup bonus to user wallet 2 times     ${TEST_USER.username}    ${bonus}    ${turn_over}

    ${bet}    Get user balance wallet    ${TEST_USER.user_code}
    # ${balance}    Convert To Number    ${balance}
    # Set Test Variable    ${wallet_before_bet}    ${balance}

    Spin game without winning the game    ${TEST_USER.username}    ${bet}    ${game_provider}    ${game_id} 
    WEB Sleep
    ${balance_after_bet}=    Get user balance wallet    ${TEST_USER.user_code}

    Should Be Equal As Numbers    ${balance_after_bet}    ${0}

WAL-16 Verify user should get convert bonus to cash when turnover is completed
    [Documentation]   Verify bonus is converting correctly when reach turnover
    [Tags]   WAL-016    inactive    wallet    API
    [Setup]    Set Up Common Keyword For User Wallet
    Set Test Variable    ${topup}    ${20}
    Set Test Variable    ${turn_over}   ${5}
    Set Test Variable    ${bet}    ${10}
    Set Test Variable    ${game_provider}    JOKER
    Set Test Variable    ${game_id}    3erm9p7wssiks
    Clear bonus wallet and cash wallet    ${TEST_USER.username}    user_code=${TEST_USER.user_code}
    WEB Sleep
    
    #----------- Topup bonus wallet via Backoffice ------------#
    BO Login
    Topup bonus to user wallet    ${TEST_USER.username}    ${topup}    ${turn_over}

    ${balance}    Get user balance wallet    ${TEST_USER.user_code}
    ${expect_convert}    Evaluate    ${topup} - ${bet}
    Spin game without winning the game    ${TEST_USER.username}    ${bet}    ${game_provider}    ${game_id} 
    WEB Sleep
    ${cash_balance}=    Get user cash wallet balance amount      ${TEST_USER.user_code}

    Should Be Equal As Numbers    ${cash_balance}    ${expect_convert}

WAL-18 Verify user should not get convert bonus when turnover is incomplete
    [Documentation]   Verify bonus is not converting if the user doesn't reach a turnover
    [Tags]   WAL-018    inactive    wallet    API
    [Setup]    Set Up Common Keyword For User Wallet
    Set Test Variable    ${topup}    ${20}
    Set Test Variable    ${turn_over}   ${100}
    Set Test Variable    ${bet}    ${10}
    Set Test Variable    ${game_provider}    JOKER
    Set Test Variable    ${game_id}    3erm9p7wssiks
    
    Clear bonus wallet and cash wallet    ${TEST_USER.username}    user_code=${TEST_USER.user_code}
    WEB Sleep
    
    #----------- Topup bonus wallet via Backoffice ------------#
    BO Login
    Topup bonus to user wallet    ${TEST_USER.username}    ${topup}    ${turn_over}

    ${balance}    Get user balance wallet    ${TEST_USER.user_code}
    ${expect_bonus_after_bet}    Evaluate    ${topup} - ${bet}
    Spin game without winning the game    ${TEST_USER.username}    ${bet}    ${game_provider}    ${game_id}
    WEB Sleep
    ${cash_balance}=    Get user cash wallet balance amount      ${TEST_USER.user_code}
    ${bonus_balance}=    Get user bonus wallet balance amount     ${TEST_USER.user_code}
    
    Should Be Equal As Numbers    ${cash_balance}    ${0}
    Should Be Equal As Numbers    ${bonus_balance}    ${expect_bonus_after_bet}

WAL-19 Verify when get convert bonus at the same time as got payout 
    [Documentation]   
    [Tags]   WAL-019    inactive    wallet    API
    [Setup]    Set Up Common Keyword For User Wallet
    Set Test Variable    ${topup}    ${50}
    Set Test Variable    ${turn_over}   ${5}
    Set Test Variable    ${bet_amount}    ${10}
    Set Test Variable    ${win_amount}    ${20}
    Set Test Variable    ${game_provider}    JOKER
    Set Test Variable    ${game_id}    3erm9p7wssiks
    Clear bonus wallet and cash wallet    ${TEST_USER.username}    user_code=${TEST_USER.user_code}
    #----------- Topup bonus wallet api ------------#
    # Topup user bonus wallet   ${TEST_USER.username}    ${topup}    ${convert_ratio}=${0.1}

    #----------- Topup bonus wallet via Backoffice ------------#
    BO Login
    Topup bonus to user wallet    ${TEST_USER.username}    ${topup}    ${turn_over}

    ${bonus_wallet}=       Get user bonus wallet balance amount     ${TEST_USER.user_code}

    Spin and win the game     ${TEST_USER.username}    ${bet_amount}    ${win_amount}    ${game_provider}    ${game_id}
    
    ${expect_cash_after_convert}=    Evaluate    ${topup} - ${bet_amount} + ${win_amount}
    ${cash_after_bet}=    Get user cash wallet balance amount      ${TEST_USER.user_code}

    ${bonus_wallet_after_bet}=       Get user bonus wallet balance amount     ${TEST_USER.user_code}
    
    Should Be Equal As Numbers    ${cash_after_bet}    ${expect_cash_after_convert}
    Should Be Equal As Numbers    ${bonus_wallet_after_bet}    ${0}    #It should be converted all amount to cash wallet correctly

WAL-20 Verify when convert 2 wallets at the same time as got payout
    [Documentation]   Bet using 2 bonus wallets
    ...     To verify all wallets were deducted correctly
    [Tags]   WAL-020    inactive    wallet    API
    [Setup]    Set Up Common Keyword For User Wallet
    Set Test Variable    ${topup}    ${25}
    Set Test Variable    ${turn_over}   ${5}
    Set Test Variable    ${bet_amount}    ${40}
    Set Test Variable    ${win_amount}    ${50}
    Set Test Variable    ${game_provider}    JOKER
    Set Test Variable    ${game_id}    3erm9p7wssiks
    Clear bonus wallet and cash wallet    ${TEST_USER.username}    user_code=${TEST_USER.user_code}
    WEB Sleep
    #Topup bonus wallet 1
    # Topup user bonus wallet   ${TEST_USER.username}    ${topup}    0.1
    #Topup bonus wallet 2
    # Topup user bonus wallet   ${TEST_USER.username}    ${topup}    0.1

    #----------- Topup bonus wallet via Backoffice ------------#
    BO Login
    Topup bonus to user wallet 2 times    ${TEST_USER.username}    ${topup}    ${turn_over}

    ${bonus_wallet}=       Get user bonus wallet balance amount     ${TEST_USER.user_code}
    Set Test Variable    ${balance_before_bet}    ${bonus_wallet}

    Spin and win the game     ${TEST_USER.username}    ${bet_amount}    ${win_amount}    ${game_provider}    ${game_id}

    Verify both wallets got payout and convert correctly    ${TEST_USER.user_code}    ${balance_before_bet}    ${bet_amount}    ${win_amount}


*** Keywords ***
Set Up Common Keyword For User Wallet
    [Arguments]    ${user_type}=common    ${common_type}=downline1
    CL Setup Test User    ${user_type}    ${common_type}