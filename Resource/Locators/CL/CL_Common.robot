*** Settings ***
Documentation     *Page*
...
...               LDP = Landing Page
...
...               LGP = Login Page
...
...               LBP = Lobby Page

*** Variables ***
${LDP_header_login_btn}    id=register-or-login-button
${LGP_body_phone_inp}    xpath=//input[@data-testid="login-checkphone-input"]
${LGP_body_check_phone_btn}    xpath=//button[contains(@data-testid,'checkphone-next-button')]
${LGP_pin_inp}    xpath=//input[@data-testid="login__pin-input-<index>"]
${LBP_mainmenu_allgame_btn}    xpath=//*[@data-testid="lobby-menu__item-allgame"]
${LBP_mainmenu_champion_btn}    xpath=//*[@data-testid="lobby-menu__item-champion"]
${LBP_mainmenu_quest_btn}    xpath=//*[@data-testid="lobby-menu__item-quest"]
${LBP_mainmenu_loyaltyshop_btn}    xpath=//*[@data-testid="lobby-menu__item-pigshop"]
${LBP_hamburger_btn}    xpath=//*[@data-testid="header__navbar--hamberger"]
${LBP_hamburger_quest_btn}    xpath=//*[@data-testid="hamburger__item-dailyQuest-link"]
${LBP_hamburger_loyaltyshop_btn}    xpath=//*[@data-testid="hamburger__item-pigShop-link"]
${LBP_header_credit_lbl}    xpath=//*[@data-testid="header__navbar--total-amount"]
${LBP_header_chat_lbl}      xpath=//*[@data-testid="header__navbar--chat"]
${LGP_body_check_phone_disabled_btn}    id=checkphone-next-button--disabled
${LGP_body_phone_txt}    xpath=//div[@class="ps-input-title"]
${LGP_body_login_header_lbl}    xpath=//h3[text()="สมัคร / เข้าสู่ระบบ"]
${LGP_pin_input_error_txt}    xpath=//span[@data-testid="login__pin-input-error-msg-label"]
${LGP_phone_input_error_txt}    xpath=//span[@data-testid="login-checkphone-input-error-msg"]
${LBP_balance_amount_txt}    xpath=//div[@data-testid="header__navbar--total-amount"]
${OTP_header_txt}    xpath=//h3[text()="สมัครสมาชิก"]
${LGP_lock_user_lbl}    xpath=//div[@data-testid="pin-locked__modal"]
${LGP_lock_user_header_txt}    xpath=//strong[@data-testid="pin-locked__modal-header"]
${LGP_lock_user_subheader_txt}    xpath=//div[@data-testid="pin-locked__modal-body"]
${LGP_lock_user_btn}    xpath=//div[@data-testid="pin-locked__modal-footer"]//button
${LGP_verify_otp_subheader}    xpath=//*[@data-testid="otp__title"]
${LGP_ban_user_lbl}    xpath=
${LGP_ban_user_header_txt}    xpath=//strong[@data-testid="alert-contact-modal-header"]
${LGP_ban_user_subheader_txt}    xpath=
${LBP_mainmenu_champion_btn}    xpath=//div[@data-testid="lobby-menu__item-champion"]
${LBP_hamburger_lobby_btn}    xpath=//li[@data-testid="hamburger__item-home"]
${LBP_hamburger_withdraw_btn}    xpath=//*[@data-testid="hamburger__item-withdraw" or @data-testid="hamburger__item-withdraw-link"]
${LBP_hamburger_wallet_btn}    xpath=//*[@data-testid="hamburger__item-wallet.cash_bonus"]
${LBP_hamburger_contactus_btn}    xpath=//li[@data-testid="hamburger__item-contactUs"]
${LBP_hamburger_faq_btn}    xpath=//li[@data-testid="hamburger__item-faq"]
${LBP_hamburger_article_btn}    xpath=//li[@data-testid="hamburger__item-article"]
${LBP_hamburger_logout_btn}    xpath=//li[@data-testid="hamburger__item-logout"]
${LBP_hamburger_promotion_btn}    xpath=//li[@data-testid="hamburger__item-promotion"]
${LBP_hamburger_allgame_btn}    xpath=//li[@data-testid="hamburger__item-allGames"]
${LBP_hamburger_deposit_btn}    xpath=//a[@data-testid="hamburger__item-deposit-link"]
${LBP_hamburger_profile_btn}    xpath=//li[@data-testid="hamburger__item-profile"]
${LBP_hamburger_referal_btn}    xpath=//li[@data-testid="hamburger__item-referral"]
${LBP_hamburger_deposit_btn}    xpath=//a[@data-testid="hamburger__item-deposit-link"]
${LBP_navbar_allgame_btn}    xpath=//span[@data-testid="header__navbar--all-games"]
${LBP_navbar_promotion_btn}    xpath=//span[@data-testid="header__navbar--promotion"]
${LBP_navbar_referal_btn}    xpath=//span[@data-testid="header__navbar--referral"]
${LBP_navbar_deposit_btn}    xpath=//span[@data-testid="header__navbar--deposit"]
${LBP_navbar_profile_btn}    xpath=//span[@data-testid="header__navbar--avatar"]
${LBP_hamburger_container}      xpath=//*[@id="hamburger-menu"]
${COM_footer}    xpath=//div[@class='ps-footer ']
${Close_toastify}    xpath=//*[@class="Toastify"]//button