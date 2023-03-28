*** Settings ***
Resource          ../Global/WEB_Common.robot
Resource          ../Global/GEN_Common.robot
Resource          ../Global/DB_Common.robot
Resource          ../Global/API_Common.robot
Resource          CL_LandingPage.robot
Resource          ../../Locators/CL/CL_Common.robot
Resource          ../../Locators/CL/CL_Modal.robot
Variables         ../../Config/Devices.yaml
Variables         ../../Config/Environment.yaml
Variables         ../../Config/Timeout.yaml
Variables         ../../TestData/CL/${ar_ENVIRONMENT}/UserData.yaml
Resource          CL_Login.robot
Variables         ../../Config/Common.yaml

*** Keywords ***
CL Login
    [Arguments]    ${phone_number}=${TEST_USER.phone.uncensor}    ${pin}=${TEST_USER.pin.original}
    Go to    ${ENVIRONMENT.DOMAIN.${ar_DOMAIN}.ARES.URL}/login
    CL Input Phone No    ${phone_number}
    CL Click Check Phone No
    CL Input Pin    ${pin}

CL Login From Landing page
    [Arguments]    ${phone_number}=${TEST_USER.phone.uncensor}    ${pin}=${TEST_USER.pin.original}
    CL Click Login Button
    CL Input Phone No    ${phone_number}
    CL Click Check Phone No
    CL Input Pin    ${pin}

CL Input pin
    [Arguments]    ${pin}=${TEST_USER.pin.original}
    ${pin_length}    Get Length    ${pin}
    FOR    ${ROUND}    IN RANGE    0    ${pin_length}
        ${index}    Convert To String    ${ROUND}
        ${pin_location}    Replace String    ${LGP_pin_inp}    <index>    ${index}
        WEB Input Text    ${pin_location}    ${pin}[${INDEX}]
    END

CL Click Hamburger Button From Lobby
    [Documentation]    \#Hamburger animation handling using sleep 1s
    BuiltIn.Sleep    5s       #We need to put sleep here for 5sec to wait animation finished rendering
    Web Verify Element Visible    ${LBP_header_credit_lbl}
    Web Click Element    ${LBP_hamburger_btn}
    BuiltIn.Sleep    5s       #It needs to wait elements inside the hamburger container are displayed

CL Click Hamburger Button Small Header
    [Documentation]    \#Hamburger animation handling using sleep 1s
    Web Click Element    ${LBP_hamburger_btn}
    BuiltIn.Sleep    5s       #It needs to wait elements inside the hamburger container are displayed

CL Click Daily Quest At Hamburger Menu
    CL Click Hamburger Button From Lobby
    Web Click Element    ${LBP_hamburger_quest_btn}

CL Click PigShop At Hamburger Menu
    CL Click Hamburger Button From Lobby
    Web Click Element    ${LBP_hamburger_loyaltyshop_btn}

Verify Daily Quest Menu Visible On Hamburger Menu
    Web Verify Element Visible    ${LBP_hamburger_quest_btn}

Verify Loyalty Shop Menu Visible On Hamburger Menu
    Web Verify Element Visible    ${LBP_hamburger_loyaltyshop_btn}

CL Setup Test User
    [Arguments]    ${user_type}    ${common_type}
    IF    '${user_type}'=='common'
        Set Test Variable    ${TEST_USER}    ${cl_user.common.${common_type}}
    ELSE IF    '${user_type}'=='agent'
        Set Test Variable    ${TEST_USER}    ${cl_user.${ar_USER_SET}}
    ELSE
        Fail    msg=PLease set user type to common or agent
    END

CL Open Pigspin Website
    Web Open Browser    ${ENVIRONMENT.DOMAIN.${ar_DOMAIN}.ARES.URL}

CL Click All Game At Nav Bar
    WEB Click Element    ${LBP_navbar_allgame_btn}

CL Click Promotion At Nav Bar
    WEB Click Element    ${LBP_navbar_promotion_btn}

CL Click Referral At Nav Bar
    WEB Click Element    ${LBP_navbar_referal_btn}

CL Click Wallet At Nav Bar
    WEB Click Element    ${LBP_navbar_deposit_btn}

CL Click Pofile At Nav Bar
    WEB Click Element    ${LBP_navbar_profile_btn}

CL Click Lobby At Hamburger Menu
    [Arguments]    ${locator}=${LBP_hamburger_lobby_btn}
    CL Click Hamburger Button From Lobby
    WEB Click Element    ${locator}

CL Click Withdraw At Hamburger Menu
    [Arguments]    ${locator}=${LBP_hamburger_withdraw_btn}
    CL Click Hamburger Button From Lobby
    WEB Click Element    ${locator}

CL Click Wallet At Hamburger Menu
    [Arguments]    ${locator}=${LBP_hamburger_wallet_btn}
    CL Click Hamburger Button From Lobby
    WEB Click Element    ${locator}

CL Click Bonus Wallet At Hamburger Menu
    [Arguments]    ${locator}=${LBP_hamburger_wallet_btn}
    CL Click Hamburger Button From Lobby
    WEB Click Element    ${locator}

CL Click Contact Us At Hamburger Menu
    [Arguments]    ${locator}=${LBP_hamburger_contactus_btn}
    CL Click Hamburger Button From Lobby
    WEB Click Element    ${locator}

CL Click Faq At Hamburger Menu
    [Arguments]    ${locator}=${LBP_hamburger_faq_btn}
    CL Click Hamburger Button From Lobby
    WEB Click Element    ${locator}

CL Click Article At Hamburger Menu
    [Arguments]    ${locator}=${LBP_hamburger_article_btn}
    CL Click Hamburger Button From Lobby
    WEB Click Element    ${locator}

CL Click Profile At Hamburger Menu
    [Arguments]    ${locator}=${LBP_hamburger_profile_btn}
    CL Click Hamburger Button From Lobby
    WEB Click Element    ${locator}

CL Click Logout At Hamburger Menu
    [Arguments]    ${locator}=${LBP_hamburger_logout_btn}    ${is_lobby}=${true}
    IF    ${is_lobby}
        CL Click Hamburger Button From Lobby
    ELSE
        CL Click Hamburger Button Small Header
    END
    WEB Click Element    ${locator}

CL Verify Hamburger Menu For Mobile
    WEB Verify Element Visible    ${LBP_hamburger_quest_btn}
    WEB Verify Element Visible    ${LBP_hamburger_loyaltyshop_btn}
    WEB Verify Element Visible    ${LBP_hamburger_lobby_btn}
    WEB Verify Element Visible    ${LBP_hamburger_promotion_btn}
    WEB Verify Element Visible    ${LBP_hamburger_referal_btn}
    WEB Verify Element Visible    ${LBP_hamburger_allgame_btn}
    WEB Verify Element Visible    ${LBP_hamburger_deposit_btn}
    WEB Verify Element Visible    ${LBP_hamburger_withdraw_btn}
    WEB Verify Element Visible    ${LBP_hamburger_wallet_btn}
    WEB Verify Element Visible    ${LBP_hamburger_contactus_btn}
    WEB Verify Element Visible    ${LBP_hamburger_faq_btn}
    WEB Verify Element Visible    ${LBP_hamburger_article_btn}
    WEB Verify Element Visible    ${LBP_hamburger_profile_btn}
    WEB Verify Element Visible    ${LBP_hamburger_logout_btn}

CL Verify Hamburger Menu For Desktop
    WEB Verify Element Visible    ${LBP_hamburger_quest_btn}
    WEB Verify Element Visible    ${LBP_hamburger_loyaltyshop_btn}
    WEB Verify Element Visible    ${LBP_hamburger_lobby_btn}
    WEB Verify Element Visible    ${LBP_hamburger_withdraw_btn}
    WEB Verify Element Visible    ${LBP_hamburger_wallet_btn}
    WEB Verify Element Visible    ${LBP_hamburger_contactus_btn}
    WEB Verify Element Visible    ${LBP_hamburger_faq_btn}
    WEB Verify Element Visible    ${LBP_hamburger_article_btn}
    WEB Verify Element Visible    ${LBP_hamburger_profile_btn}
    WEB Verify Element Visible    ${LBP_hamburger_logout_btn}

CL Verify Hamburger Menu
    IF    "${ar_DEVICE}"=="DESKTOP" or "${ar_DEVICE}"=="TABLET"
    CL Verify Hamburger Menu For Desktop
    ELSE
    CL Verify Hamburger Menu For Mobile
    END

CL Verify Redirect To Quest Page Page
    WEB Verify Current Location    ${ENVIRONMENT.DOMAIN.${ar_DOMAIN}.ARES.URL}${ENVIRONMENT.PAGE.QUEST}

CL Verify Redirect To Item Shop Page
    WEB Verify Current Location    ${ENVIRONMENT.DOMAIN.${ar_DOMAIN}.ARES.URL}${ENVIRONMENT.PAGE.SHOP}

CL Verify Redirect To Lobby Page Page
    WEB Verify Current Location    ${ENVIRONMENT.DOMAIN.${ar_DOMAIN}.ARES.URL}${ENVIRONMENT.PAGE.LOBBY}

CL Verify Redirect To Withdraw Page
    WEB Verify Current Location    ${ENVIRONMENT.DOMAIN.${ar_DOMAIN}.ARES.URL}${ENVIRONMENT.PAGE.WALLET}

CL Verify Redirect To Cash Wallet Page
    WEB Verify Current Location    ${ENVIRONMENT.DOMAIN.${ar_DOMAIN}.ARES.URL}${ENVIRONMENT.PAGE.WALLET}

CL Verify Redirect To Bonus Wallet Page
    WEB Verify Current Location    ${ENVIRONMENT.DOMAIN.${ar_DOMAIN}.ARES.URL}${ENVIRONMENT.PAGE.WALLET}

CL Verify Redirect To Contact Us Page
    WEB Verify Current Location    ${ENVIRONMENT.DOMAIN.${ar_DOMAIN}.ARES.URL}${ENVIRONMENT.PAGE.CONTACT_US}

CL Verify Redirect To Faq Page
    WEB Verify Current Location    ${ENVIRONMENT.DOMAIN.${ar_DOMAIN}.ARES.URL}${ENVIRONMENT.PAGE.FAQ}

CL Verify Redirect To Article
    WEB Verify Current Location    ${ENVIRONMENT.DOMAIN.${ar_DOMAIN}.PIGSPIN_ARTICLE.URL}

CL Verify Redirect To Profile Page
    WEB Verify Current Location    ${ENVIRONMENT.DOMAIN.${ar_DOMAIN}.ARES.URL}${ENVIRONMENT.PAGE.PROFILE}

CL Verify Redirect To Logout
    WEB Verify Current Location    ${ENVIRONMENT.DOMAIN.${ar_DOMAIN}.ARES.URL}

Verify Redirect To Promotion Page
    WEB Verify Current Location    ${ENVIRONMENT.DOMAIN.${ar_DOMAIN}.ARES.URL}${ENVIRONMENT.PAGE.PROMOTION}

Verify Redirect To Referral Page
    ${localize}=    Replace String    ${cl_referral_localize.referral.header.title}    <new_line>    \n
    Web Verify Until Element Text Contain    ${RFP_title_header_txt}    ${localize}
    WEB Verify Current Location    ${ENVIRONMENT.DOMAIN.${ar_DOMAIN}.ARES.URL}${ENVIRONMENT.PAGE.REFERAL}

CL Click Promotion At Hamburger Menu
    [Arguments]    ${locator}=${LBP_hamburger_promotion_btn}
    CL Click Hamburger Button From Lobby
    WEB Click Element    ${locator}

CL Click Referral At Hamburger Menu
    [Arguments]    ${locator}=${LBP_hamburger_referal_btn}
    CL Click Hamburger Button From Lobby
    WEB Click Element    ${locator}

CL Click All Game At Hamburger Menu
    [Arguments]    ${locator}=${LBP_hamburger_allgame_btn}
    CL Click Hamburger Button From Lobby
    WEB Set Focus To Element    ${LBP_hamburger_container}
    # WEB Click Element   ${LBP_hamburger_allgame_btn}

CL Click Deposit At Hamburger Menu
    [Arguments]    ${locator}=${LBP_hamburger_deposit_btn}
    CL Click Hamburger Button From Lobby
    WEB Click Element    ${locator}

CL Scroll To Footer
    [Documentation]    Use this keyword when the bottom navigation bar is over the target element
    WEB Verify Element Visible    ${COM_footer}
    Scroll Element In To View    ${COM_footer}

