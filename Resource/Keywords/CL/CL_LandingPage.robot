*** Settings ***
Resource          CL_Common.robot

*** Keywords ***
Click All Game Menu On Main Menu
    Web Click Element    ${LBP_mainmenu_allgame_btn}

Click Champion Menu On Main Menu
    Web Click Element    ${LBP_mainmenu_champion_btn}

Click Daily Quest Menu On Main Menu
    Web Click Element    ${LBP_mainmenu_quest_btn}

Click Loyalty Shop Menu On Main Menu
    Web Click Element    ${LBP_mainmenu_loyaltyshop_btn}

Verify All Game Menu Visible On Main Menu
    Web Verify Element Visible    ${LBP_mainmenu_allgame_btn}

Verify Champion Menu Visible On Main Menu
    Web Verify Element Visible    ${LBP_mainmenu_champion_btn}

Verify Daily Quest Menu Visible On Main Menu
    Web Verify Element Visible    ${LBP_mainmenu_quest_btn}

Verify Loyalty Shop Menu Visible On Main Menu
    Web Verify Element Visible    ${LBP_mainmenu_loyaltyshop_btn}

Verify Redirect To All Game Page
    Web Verify Current Location    ${ENVIRONMENT.DOMAIN.${ar_DOMAIN}.ARES.URL}games/search

Verify Redirect To Champion Page
    Web Verify Current Location    ${ENVIRONMENT.DOMAIN.${ar_DOMAIN}.ARES.URL}daily-quests/champion
