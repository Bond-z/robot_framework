*** Settings ***
Resource          ${CURDIR}/../../import.robot

*** Keywords ***
Deposit cash to user wallet
    [Arguments]     ${user_code}    ${transaction_amount}
    &{header}=    Create Dictionary
    ...    Content-Type=application/json
    ...    secret-key=${secret_key}
    Set Test Variable    ${uri}    v1/wallet/deposit

    ${json}=    JSONLibrary.Load Json From File     ${CURDIR}/../../TestData/CL/STAGING/Deposit.json
    ${json}=    JSONLibrary.Update Value To Json    ${json}    $..user_code    ${user_code}
    ${json}=    JSONLibrary.Update Value To Json    ${json}    $..transaction_amount    ${transaction_amount}
    ${body}     json.Dumps    ${json}

    ${end_point}=   Set Variable    ${ENVIRONMENT.DOMAIN.STAGING.PIGSPIN_SERVICE.URL}${uri}
    ${response}=     POST     ${end_point}     headers=&{header}    data=${body}

Topup user bonus wallet
    [Arguments]     ${customer_code}    ${initial_balance}    ${turn_over_ratio}    ${convert_limit_amount}=${0}
    &{header}=    Create Dictionary
    ...    Content-Type=application/json
    ...    token=${bonus_token}
    Set Test Variable    ${uri}    v1/payment/coin-wallets

    ${json}=    JSONLibrary.Load Json From File     ${CURDIR}/../../TestData/CL/STAGING/Topup_coin.json
    ${json}=    JSONLibrary.Update Value To Json    ${json}    $..customer_code     ${customer_code}
    ${json}=    JSONLibrary.Update Value To Json    ${json}    $..initial_balance    ${initial_balance}
    ${json}=    JSONLibrary.Update Value To Json    ${json}    $..turn_over_ratio    ${turn_over_ratio}
    ${body}     json.Dumps    ${json}

    ${end_point}=   Set Variable    ${ENVIRONMENT.DOMAIN.STAGING.PIGSPIN_BO_SERVICE.URL}${uri}
    ${response}=     POST    ${end_point}     headers=&{header}    data=${body}
    

Get user cash wallet balance amount
    [Arguments]     ${user_code}
    &{header}=    Create Dictionary
    ...    Content-Type=application/json
    ...    secret-key=${secret_key}
    Set Test Variable    ${uri}    v1/wallet/{user_code}/balance
    ${uri}=    Format Text    ${uri}    user_code=${user_code}
    ${end_point}=   Set Variable    ${ENVIRONMENT.DOMAIN.STAGING.PIGSPIN_SERVICE.URL}${uri}
    ${response}=     GET     ${end_point}     headers=&{header}
    Set Test Variable    ${cash_balance}     ${response.json()}[data][balance_amount]
    ${cash_balance}=    Builtin.Convert To Number    ${cash_balance}
    [Return]   ${cash_balance}

Get user bonus wallet balance amount
    [Arguments]     ${user_code}
    &{header}=    Create Dictionary
    ...    Content-Type=application/json
    ...    secret-key=${secret_key}
    Set Test Variable    ${uri}    v1/wallet/{user_code}/balance
    ${uri}=    Format Text    ${uri}    user_code=${user_code}
    ${end_point}=   Set Variable    ${ENVIRONMENT.DOMAIN.STAGING.PIGSPIN_SERVICE.URL}${uri}
    ${response}=     GET     ${end_point}     headers=&{header}
    Set Test Variable    ${bonus_balance}     ${response.json()}[data][coin_amount]
    ${bonus_balance}=    Builtin.Convert To Number    ${bonus_balance}
    [Return]   ${bonus_balance}  

Get user balance wallet
    [Arguments]     ${user_code}
    ${cash_balance}     Get user cash wallet balance amount    ${user_code}
    ${bonus_balance}    Get user bonus wallet balance amount   ${user_code}
    ${balance}    Evaluate    ${cash_balance} + ${bonus_balance}
    [Return]    ${balance}

Clear bonus wallet and cash wallet
    [Arguments]   ${player_name}     ${user_code}    ${game_provider}=JOKER
    ${balance}    Get user balance wallet    ${user_code}
    ${balance}    Convert To Number     ${balance}

    &{header}=    Create Dictionary
    ...    Content-Type=application/json
    ...    secret-key=${secret_key}
    Set Test Variable    ${uri}    v1/wallet/test/transfer-in-out?game_provider=${game_provider}

    ${end_point}=   Set Variable    ${ENVIRONMENT.DOMAIN.STAGING.PIGSPIN_SERVICE.URL}${uri}
    ${json}=    JSONLibrary.Load Json From File     ${CURDIR}/../../TestData/CL/STAGING/Clear_wallet.json
    ${json}=    JSONLibrary.Update Value To Json    ${json}    $..player_name   ${player_name}
    ${json}=    JSONLibrary.Update Value To Json    ${json}    $..bet_amount   ${balance}
    ${body}     json.Dumps    ${json}

    ${response}=    POST    ${end_point}    headers=&{header}    data=${body}
    Should Be Equal As Strings      ${response.status_code}     200
    Sleep   5s

Spin game without winning the game
    [Arguments]    ${player_name}    ${bet_amount}    ${game_provider}    ${game_id}
    &{header}=    Create Dictionary
    ...    Content-Type=application/json
    ...    secret-key=${secret_key}
    Set Test Variable    ${uri}    v1/wallet/test/transfer-in-out?game_provider=${game_provider}
    ${end_point}=   Set Variable    ${ENVIRONMENT.DOMAIN.STAGING.PIGSPIN_SERVICE.URL}${uri}
    
    ${json}=    Load Json From File     ${CURDIR}/../../TestData/CL/STAGING/Bet.json
    ${json}=    JSONLibrary.Update Value To Json    ${json}    $..player_name   ${player_name}
    ${json}=    JSONLibrary.Update Value To Json    ${json}    $..game_id       ${game_id}
    ${json}=    JSONLibrary.Update Value To Json    ${json}    $..bet_amount   ${bet_amount}
    ${body}     json.Dumps    ${json}

    ${response}=    POST    ${end_point}    headers=&{header}    data=${body}
    Should Be Equal As Strings      ${response.status_code}     200

Spin and win the game
    [Arguments]     ${player_name}    ${bet_amount}    ${win_amount}    ${game_provider}    ${game_id}
    &{header}=    Create Dictionary
    ...    Content-Type=application/json
    ...    secret-key=${secret_key}
    Set Test Variable    ${uri}    v1/wallet/test/transfer-in-out?game_provider=${game_provider}
    ${end_point}=   Set Variable    ${ENVIRONMENT.DOMAIN.STAGING.PIGSPIN_SERVICE.URL}${uri}

    ${json}=    Load Json From File     ${CURDIR}/../../TestData/CL/STAGING/Bet.json
    ${json}=    JSONLibrary.Update Value To Json    ${json}    $..player_name   ${player_name}
    ${json}=    JSONLibrary.Update Value To Json    ${json}    $..game_id       ${game_id}
    ${json}=    JSONLibrary.Update Value To Json    ${json}    $..bet_amount   ${bet_amount}
    ${json}=    JSONLibrary.Update Value To Json    ${json}    $..win_amount   ${win_amount}
    ${body}     json.Dumps    ${json}
   
    ${response}=    POST    ${end_point}    headers=&{header}    data=${body}
    Should Be Equal As Strings      ${response.status_code}     200
    Sleep    5s

Spin game and got combo
    [Arguments]     ${player_name}    ${bet_amount}    ${combo_round}    ${game_provider}=EVO
    &{header}=    Create Dictionary
    ...    Content-Type=application/json
    ...    secret-key=${secret_key}
    Set Test Variable    ${uri}    v1/wallet/test/transfer-in-out?game_provider=${game_provider}
    ${end_point}=   Set Variable    ${ENVIRONMENT.DOMAIN.STAGING.PIGSPIN_SERVICE.URL}${uri}

    ${json}=    Load Json From File     ${CURDIR}/../../TestData/CL/STAGING/Bet.json
    ${json}=    JSONLibrary.Update Value To Json    ${json}    $..player_name   ${player_name}
    ${json}=    JSONLibrary.Update Value To Json    ${json}    $..bet_amount   ${bet_amount}
    ${json}=    JSONLibrary.Update Value To Json    ${json}    $..win_amount   ${combo_round}
    ${body}     json.Dumps    ${json}
   
    ${response}=    POST    ${end_point}    headers=&{header}    data=${body}
    log to console  ${response.status_code}

Calculate split payout amount to the wallets
    [Arguments]     ${player_name}    ${deposit}    ${bet_amount}    ${win_amount}    ${bonus_wallet_remaining}    ${deducted_bonus_wallet}
    
    #Calculate ratio when win a game
    ${win_bonus_ratio}=    Evaluate    ${win_amount} / ${bet_amount}

    #Return to each wallets
    ${return_to_cash_wallet}=    Evaluate    ${deposit} * ${win_bonus_ratio}
    ${return_to_bonus_wallet}=    Evaluate    ${deducted_bonus_wallet} * ${win_bonus_ratio}

    ${expect_cash_wallet_balance}    Evaluate    ${0} + ${return_to_cash_wallet}
    ${expect_cash_wallet_balance}    Evaluate   math.floor(${expect_cash_wallet_balance})
    ${expect_bonus_wallet_balance}    Evaluate    ${bonus_wallet_remaining} + ${return_to_bonus_wallet}
    ${expect_bonus_wallet_balance}    Evaluate   math.floor(${expect_bonus_wallet_balance})

    [Return]    ${expect_cash_wallet_balance}    ${expect_bonus_wallet_balance}

Verify both wallets should receive payout bonus correctly
    [Arguments]    ${player_name}    ${expect_cash_wallet_balance}    ${expect_bonus_wallet_balance}

    ${cash_after_bet}=    Get user cash wallet balance amount      ${player_name}
    ${cash_after_bet}    Evaluate   math.floor(${cash_after_bet})
    ${bonus_wallet_after_bet}=       Get user bonus wallet balance amount     ${player_name}
    ${bonus_wallet_after_bet}    Evaluate   math.floor(${bonus_wallet_after_bet})

    Should Be Equal As Numbers    ${cash_after_bet}    ${expect_cash_wallet_balance}
    Should Be Equal As Numbers    ${bonus_wallet_after_bet}    ${expect_bonus_wallet_balance}

Verify both wallets got payout and convert correctly
    [Arguments]     ${player_name}    ${balance_before_bet}    ${bet_amount}    ${win_amount}

    ${expect_cash_balance}=     Evaluate    ${balance_before_bet} - ${bet_amount} + ${win_amount}

    ${cash_after_bet}=    Get user cash wallet balance amount      ${player_name}
    ${bonus_wallet_after_bet}=       Get user bonus wallet balance amount     ${player_name}

    Should Be Equal As Numbers    ${cash_after_bet}    ${expect_cash_balance}
    Should Be Equal As Numbers    ${bonus_wallet_after_bet}    ${0}