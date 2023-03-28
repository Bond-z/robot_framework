*** Settings ***
Documentation     LYS = Loyaltyshop Page(old word)

*** Variables ***
${LYS_ticket_amount}    xpath=//div[@class='ps-shop-banner__tickets']
${LYS_free_credit_redeem_btn}    xpath=(//button[contains(@data-testid,'free-credit-section__card')])[<index>]
${LYS_free_credit_title}    xpath=(//div[@class='ps-redemption-card__title'])[<index>]
${LYS_redeem_ok_btn}    xpath=//button[@class='ant-btn ant-btn-primary']
${LYS_loading_screen}    xpath=//div[@data-testid='loading-filter']
${LYS_free_spin_redeem_btn}    xpath=(//button[contains(@data-testid,'free-spin-section__card')])[<index>]
${LYS_free_spin_amount_txt}    xpath=//div[contains(@id,'free-spin-section__card-') and contains(@id,'-button-text')][<index>]