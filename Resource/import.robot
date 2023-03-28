*** Settings ***
Library    String
Library    SeleniumLibrary
Library    Collections
Library    JSONLibrary
Library    json
Library    RequestsLibrary

Variables        ${CURDIR}/Config/Environment.yaml

## Localize ##
Variables        ${CURDIR}/Localize/CL/TH/CL_Setting.yaml
Variables        ${CURDIR}/Localize/CASINO/TH/Lobby_Casino.yaml

## Testdata ###
Resource         ${CURDIR}/TestData/CL/${ar_ENVIRONMENT}/Game_Joker.robot
Resource         ${CURDIR}/TestData/CL/${ar_ENVIRONMENT}/Game_EVO.robot
Resource         ${CURDIR}/TestData/CL/${ar_ENVIRONMENT}/Game_PNG.robot
Resource         ${CURDIR}/TestData/CL/${ar_ENVIRONMENT}/Game_PG.robot

### Keyword ###
Resource         ${CURDIR}/Keywords/Global/WEB_Common.robot
Resource         ${CURDIR}/Keywords/CL/CL_Lobby.robot
Resource         ${CURDIR}/Keywords/CL/CL_Pigshop.robot
Resource         ${CURDIR}/Keywords/CL/CL_Quest.robot
Resource         ${CURDIR}/Keywords/CL/CL_Setting.robot
Resource         ${CURDIR}/Keywords/CL/CL_Wallet.robot
Resource         ${CURDIR}/TestData/CL/STAGING/Web_elements_data.robot
Resource         ${CURDIR}/Keywords/API/API_Wallet.robot
Resource         ${CURDIR}/Keywords/Backoffice/BO_Common.robot
Resource         ${CURDIR}/Keywords/Backoffice/BO_Bonus_Management.robot
Resource         ${CURDIR}/Keywords/Backoffice/BO_Deposit_keyword.robot
Resource         ${CURDIR}/Keywords/Backoffice/BO_Transfer_keyword.robot
Resource         ${CURDIR}/Keywords/Backoffice/BO_Transaction_keyword.robot
Resource         ${CURDIR}/Keywords/Backoffice/BO_Affiliate_keyword.robot
Resource         ${CURDIR}/Keywords/Backoffice/BO_Ticket_keyword.robot
Resource         ${CURDIR}/Keywords/Backoffice/BO_Customer_keyword.robot
Resource         ${CURDIR}/Keywords/CASINO/Casino_Common_Keyword.robot
Resource         ${CURDIR}/Keywords/CASINO/Casino_GameSearch_Keyword.robot
Resource         ${CURDIR}/Keywords/CASINO/Casino_Login_Keyword.robot

### Locator ###
Resource         ${CURDIR}/Locators/CL/CL_Lobby.robot
Resource         ${CURDIR}/Locators/CL/CL_Setting.robot
Resource         ${CURDIR}/Locators/CL/CL_Wallet.robot
Resource         ${CURDIR}/Locators/BO/BO_Common.robot
Resource         ${CURDIR}/Locators/BO/BO_UserBonusPage.robot
Resource         ${CURDIR}/Locators/BO/BO_Affiliate.robot
Resource         ${CURDIR}/Locators/BO/BO_DepositPage.robot
Resource         ${CURDIR}/Locators/BO/BO_WalletAndGamePage.robot
Resource         ${CURDIR}/Locators/BO/BO_Transfer.robot
Resource         ${CURDIR}/Locators/BO/BO_TransactionPage.robot
Resource         ${CURDIR}/Locators/BO/BO_TicketPage.robot
Resource         ${CURDIR}/Locators/BO/BO_CustomerListPage.robot
Resource         ${CURDIR}/Locators/CASINO/Casino_common.robot
Resource         ${CURDIR}/Locators/CASINO/Casino_GameSearch.robot



*** Variables ***
${secret_key}     %{WALLET_SECRET_KEY}
${bonus_token}    %{BONUS_WALLET_TOKEN}
