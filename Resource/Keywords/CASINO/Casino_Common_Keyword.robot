*** Settings ***
Resource          ../../Global/WEB_Common.robot
Resource          ../../Global/GEN_Common.robot
Resource          ../../Global/DB_Common.robot
Resource          ../../Global/API_Common.robot
Resource          CL_LandingPage.robot
Resource          ../../Locators/CL/CL_Common.robot
Resource          ../../Locators/CL/CL_Modal.robot
Variables         ../../Config/Devices.yaml
Variables         ../../Config/Environment.yaml
Variables         ../../Config/Timeout.yaml
Variables         ../../TestData/CL/${ar_ENVIRONMENT}/UserData.yaml
Resource          CL_Login.robot
Variables         ../../Config/Common.yaml
Resource          ${CURDIR}/../../import.robot

*** Keywords ***
Open Casino Website
    Web Open Browser    ${ENVIRONMENT.DOMAIN.${ar_DOMAIN}.PIGBET.URL}

Login CASINO website
    [Arguments]    ${phone_number}=${TEST_USER.phone.uncensor}    ${pin}=${TEST_USER.pin.original}
    Go to    ${ENVIRONMENT.DOMAIN.${ar_DOMAIN}.PIGBET.URL}/login
    Input Phone No On Pigbet Website    ${phone_number}
    Click Check Phone No On Pigbet Website
    Input pin On Pigbet Website    ${pin}

Login CASINO website From Landing page
    [Arguments]    ${phone_number}=${TEST_USER.phone.uncensor}    ${pin}=${TEST_USER.pin.original}
    CN Click Login Button
    CL Input Phone No    ${phone_number}
    CN Click Check Phone No
    Input pin On Pigbet Website    ${pin}

Input pin On Pigbet Website
    [Arguments]    ${pin}=${TEST_USER.pin.original}
    ${pin_length}    Get Length    ${pin}
    FOR    ${ROUND}    IN RANGE    0    ${pin_length}
        ${index}    Convert To String    ${ROUND}
        ${pin_location}    Replace String    ${LGP_pin_inp}    <index>    ${index}
        WEB Input Text    ${pin_location}    ${pin}[${INDEX}]
    END

CN Click Hamburger Button From Lobby
    [Documentation]    \#Hamburger animation handling using sleep 1s
    BuiltIn.Sleep    5s       #We need to put sleep here for 5sec to wait animation finished rendering
    Web Verify Element Visible    ${LBP_header_credit_lbl}
    Web Click Element    ${LBP_hamburger_btn}
    BuiltIn.Sleep    5s       #It needs to wait elements inside the hamburger container are displayed

CN Click Hamburger Button Small Header
    [Documentation]    \#Hamburger animation handling using sleep 1s
    Web Click Element    ${LBP_hamburger_btn}
    BuiltIn.Sleep    5s       #It needs to wait elements inside the hamburger container are displayed

CN Click Daily Quest At Hamburger Menu
    CN Click Hamburger Button From Lobby
    Web Click Element    ${LBP_hamburger_quest_btn}

CN Click PigShop At Hamburger Menu
    CN Click Hamburger Button From Lobby
    Web Click Element    ${LBP_hamburger_loyaltyshop_btn}

Verify Daily Quest Menu Visible On Hamburger Menu
    Web Verify Element Visible    ${LBP_hamburger_quest_btn}

Verify Loyalty Shop Menu Visible On Hamburger Menu
    Web Verify Element Visible    ${LBP_hamburger_loyaltyshop_btn}

Casino Setup Test User
    [Arguments]    ${user_type}    ${common_type}
    IF    '${user_type}'=='common'
        Set Test Variable    ${TEST_USER}    ${cl_user.common.${common_type}}
    ELSE IF    '${user_type}'=='agent'
        Set Test Variable    ${TEST_USER}    ${cl_user.${ar_USER_SET}}
    ELSE
        Fail    msg=PLease set user type to common or agent
    END

CN Click All Game At Nav Bar
    WEB Click Element    ${LBP_navbar_allgame_btn}

CN Click Promotion At Nav Bar
    WEB Click Element    ${LBP_navbar_promotion_btn}

CN Click Referral At Nav Bar
    WEB Click Element    ${LBP_navbar_referal_btn}

CN Click Wallet At Nav Bar
    WEB Click Element    ${LBP_navbar_deposit_btn}

CN Click Pofile At Nav Bar
    WEB Click Element    ${LBP_navbar_profile_btn}

CN Click Lobby At Hamburger Menu
    [Arguments]    ${locator}=${LBP_hamburger_lobby_btn}
    CN Click Hamburger Button From Lobby
    WEB Click Element    ${locator}

CN Click Withdraw At Hamburger Menu
    [Arguments]    ${locator}=${LBP_hamburger_withdraw_btn}
    CN Click Hamburger Button From Lobby
    WEB Click Element    ${locator}

CN Click Wallet At Hamburger Menu
    [Arguments]    ${locator}=${LBP_hamburger_wallet_btn}
    CN Click Hamburger Button From Lobby
    WEB Click Element    ${locator}

CN Click Bonus Wallet At Hamburger Menu
    [Arguments]    ${locator}=${LBP_hamburger_wallet_btn}
    CN Click Hamburger Button From Lobby
    WEB Click Element    ${locator}

CN Click Contact Us At Hamburger Menu
    [Arguments]    ${locator}=${LBP_hamburger_contactus_btn}
    CN Click Hamburger Button From Lobby
    WEB Click Element    ${locator}

CN Click Faq At Hamburger Menu
    [Arguments]    ${locator}=${LBP_hamburger_faq_btn}
    CN Click Hamburger Button From Lobby
    WEB Click Element    ${locator}

CN Click Article At Hamburger Menu
    [Arguments]    ${locator}=${LBP_hamburger_article_btn}
    CN Click Hamburger Button From Lobby
    WEB Click Element    ${locator}

CN Click Profile At Hamburger Menu
    [Arguments]    ${locator}=${LBP_hamburger_profile_btn}
    CN Click Hamburger Button From Lobby
    WEB Click Element    ${locator}

CN Click Logout At Hamburger Menu
    [Arguments]    ${locator}=${LBP_hamburger_logout_btn}    ${is_lobby}=${true}
    IF    ${is_lobby}
        CN Click Hamburger Button From Lobby
    ELSE
        CN Click Hamburger Button Small Header
    END
    WEB Click Element    ${locator}

Verify CASINO Hamburger Menu For Mobile
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

Verify CASINO Hamburger Menu For Desktop
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

Verify Hamburger Menu
    IF    "${ar_DEVICE}"=="DESKTOP" or "${ar_DEVICE}"=="TABLET"
    Verify CASINO Hamburger Menu For Desktop
    ELSE
    Verify CASINO Hamburger Menu For Mobile
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

CN Click Promotion At Hamburger Menu
    [Arguments]    ${locator}=${LBP_hamburger_promotion_btn}
    CN Click Hamburger Button From Lobby
    WEB Click Element    ${locator}

CN Click Referral At Hamburger Menu
    [Arguments]    ${locator}=${LBP_hamburger_referal_btn}
    CN Click Hamburger Button From Lobby
    WEB Click Element    ${locator}

CN Click All Game At Hamburger Menu
    [Arguments]    ${locator}=${LBP_hamburger_allgame_btn}
    CN Click Hamburger Button From Lobby
    WEB Set Focus To Element    ${LBP_hamburger_container}
    # WEB Click Element   ${LBP_hamburger_allgame_btn}

CN Click Deposit At Hamburger Menu
    [Arguments]    ${locator}=${LBP_hamburger_deposit_btn}
    CN Click Hamburger Button From Lobby
    WEB Click Element    ${locator}

CL Scroll To Footer
    [Documentation]    Use this keyword when the bottom navigation bar is over the target element
    WEB Verify Element Visible    ${COM_footer}
    Scroll Element In To View    ${COM_footer}

Verify All Section On Landing Page Should Be Displayed Properly
    Verify Section Game Type List Should Be Displayed As a Navigate List Bar Properly
    Verify Section Promotion Should Be Displayed Properly
    Verify Section Payment Should Be Displayed Properly
    Verify Section Partner Should Be Displayed Properly
    Verify Section Reward Should Be Displayed Properly
    Verify Section Contact Us Should Be Displayed Properly

Verify Section Game Type List Should Be Displayed As a Navigate List Bar Properly
    WEB Verify Element Text    ${CN_LDP_tablist_nav_baccarat}    บาคาร่า
    WEB Verify Element Text    ${CN_LDP_tablist_nav_hilo}    ไฮโล
    WEB Verify Element Text    ${CN_LDP_tablist_nav_rulet}    รูเล็ต
    WEB Verify Element Text    ${CN_LDP_tablist_nav_other}    อื่นๆ

Verify Section Promotion Should Be Displayed Properly
    WEB Verify Element Text    ${CN_LDP_section_promotion}    โปรโมชั่น

Verify Section Payment Should Be Displayed Properly
    WEB Verify Element Text    ${CN_LDP_section_payment}    Payment

Verify Section Partner Should Be Displayed Properly
    WEB Verify Element Text    ${CN_LDP_section_partner}    พาร์ทเนอร์

Verify Section Reward Should Be Displayed Properly
    WEB Verify Element Text    ${CN_LDP_section_reward}    รางวัล

Verify Section Contact Us Should Be Displayed Properly
    WEB Verify Element Text    ${CN_LDP_section_contactus}    ติดต่อเรา
