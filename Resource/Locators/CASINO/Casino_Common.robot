*** Settings ***
Documentation     *Page*
...
...               LDP = Landing Page
...
...               CNLGP = Login Page
...
...               CNLBP = Lobby Page

*** Variables ***
${CN_LDP_header_login_btn}            xpath=//*[@data-testid="uikit-login-button"]
${CN_LDP_tablist_nav_baccarat}        xpath=//*[@class="ant-tabs-nav-list"]/div[1]
${CN_LDP_tablist_nav_hilo}        xpath=//*[@class="ant-tabs-nav-list"]/div[2]
${CN_LDP_tablist_nav_rulet}        xpath=//*[@class="ant-tabs-nav-list"]/div[3]
${CN_LDP_tablist_nav_other}        xpath=//*[@class="ant-tabs-nav-list"]/div[4]
${CN_LDP_section_promotion}        xpath=(//*[@class="section_title__ZsVjD"])[1]
${CN_LDP_section_payment}        xpath=(//*[@class="section_title__ZsVjD"])[2]
${CN_LDP_section_partner}        xpath=(//*[@class="section_title__ZsVjD"])[3]
${CN_LDP_section_reward}        xpath=(//*[@class="section_title__ZsVjD"])[4]
${CN_LDP_section_contactus}        xpath=(//*[@class="section_title__ZsVjD"])[5]

# ${CNLGP_body_phone_inp}    xpath=//input[@data-testid="login-checkphone-input"]
${CNLGP_body_check_phone_btn}    xpath=//button[contains(@data-testid,'checkphone-next-button')]
${CNLGP_pin_inp}    xpath=//input[@data-testid="login__pin-input-<index>"]
# ${CNLBP_mainmenu_allgame_btn}    xpath=//*[@data-testid="lobby-menu__item-game"]
${CNLBP_mainmenu_champion_btn}    xpath=//*[@data-testid="lobby-menu__item-champion"]
${CNLBP_mainmenu_quest_btn}    xpath=//*[@data-testid="lobby-menu__item-daily-quest"]
${CNLBP_mainmenu_loyaltyshop_btn}    xpath=//*[@data-testid="lobby-menu__item-shop"]
${CNLBP_hamburger_btn}    xpath=//*[@data-testid="header__navbar--hamberger"]
${CNLBP_hamburger_quest_btn}    xpath=//*[@data-testid="hamburger__item-dailyQuest-link"]
${CNLBP_hamburger_loyaltyshop_btn}    xpath=//*[@data-testid="hamburger__item-pigShop-link"]
# ${CNLBP_header_credit_lbl}    xpath=//*[@data-testid="header__navbar--total-amount"]
${CNLBP_header_chat_lbl}      xpath=//*[@data-testid="header__navbar--chat"]
# ${CNLGP_body_check_phone_disabled_btn}    id=checkphone-next-button--disabled
# ${CNLGP_body_phone_txt}    xpath=//div[@class="ps-input-title"]  reuse
${CNLGP_body_login_header_lbl}    xpath=//h3[text()="สมัคร / เข้าสู่ระบบ"]
# ${CNLGP_pin_input_error_txt}    xpath=//span[@data-testid="login-checkphone-input-error-msg"] 
# ${CNLGP_phone_input_error_txt}    xpath=//span[@data-testid="login__phone-input-error-msg"]
# ${CNLBP_balance_amount_txt}    xpath=//div[@data-testid="header__navbar--total-amount"]
${OTP_header_txt}    xpath=//h3[text()="สมัครสมาชิก"]
${CNLGP_lock_user_lbl}    xpath=//div[@data-testid="pin-locked__modal"]
# ${CNLGP_lock_user_header_txt}    xpath=//strong[@data-testid="pin-locked__modal-header"]
${CNLGP_lock_user_subheader_txt}    xpath=//div[@data-testid="pin-locked__modal-body"]
# ${CNLGP_lock_user_btn}    xpath=//div[@data-testid="pin-locked__modal-footer"]//button
${CNLGP_ban_user_lbl}    xpath=
# ${CNLGP_ban_user_header_txt}    xpath=//strong[@data-testid="alert-contact-modal-header"]
${CNLGP_ban_user_subheader_txt}    xpath=
${CNLBP_mainmenu_champion_btn}    xpath=//div[@data-testid="lobby-menu__item-champion"]
${CNLBP_hamburger_lobby_btn}    xpath=//li[@data-testid="hamburger__item-home"]
${CNLBP_hamburger_withdraw_btn}    xpath=//*[@data-testid="hamburger__item-withdraw" or @data-testid="hamburger__item-withdraw-link"]
${CNLBP_hamburger_wallet_btn}    xpath=//*[@data-testid="hamburger__item-wallet.cash_bonus"]
${CNLBP_hamburger_contactus_btn}    xpath=//li[@data-testid="hamburger__item-contactUs"]
${CNLBP_hamburger_faq_btn}    xpath=//li[@data-testid="hamburger__item-faq"]
${CNLBP_hamburger_article_btn}    xpath=//li[@data-testid="hamburger__item-article"]
${CNLBP_hamburger_logout_btn}    xpath=//li[@data-testid="hamburger__item-logout"]
${CNLBP_hamburger_promotion_btn}    xpath=//li[@data-testid="hamburger__item-promotion"]
${CNLBP_hamburger_allgame_btn}    xpath=//li[@data-testid="hamburger__item-allGames"]
${CNLBP_hamburger_deposit_btn}    xpath=//a[@data-testid="hamburger__item-deposit-link"]
${CNLBP_hamburger_profile_btn}    xpath=//li[@data-testid="hamburger__item-profile"]
${CNLBP_hamburger_referal_btn}    xpath=//li[@data-testid="hamburger__item-referral"]
${CNLBP_hamburger_deposit_btn}    xpath=//a[@data-testid="hamburger__item-deposit-link"]
${CNLBP_navbar_allgame_btn}    xpath=//span[@data-testid="header__navbar--all-games"]
${CNLBP_navbar_promotion_btn}    xpath=//span[@data-testid="header__navbar--promotion"]
${CNLBP_navbar_referal_btn}    xpath=//span[@data-testid="header__navbar--referral"]
${CNLBP_navbar_deposit_btn}    xpath=//span[@data-testid="header__navbar--deposit"]
${CNLBP_navbar_profile_btn}    xpath=//span[@data-testid="header__navbar--avatar"]
${CNLBP_hamburger_container}      xpath=//*[@id="hamburger-menu"]
${CNCOM_footer}    xpath=//div[@class='ps-footer ']
${CNClose_toastify}    xpath=//*[@class="Toastify"]//button