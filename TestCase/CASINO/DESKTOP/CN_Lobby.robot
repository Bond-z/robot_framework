*** Settings ***
Test Teardown     WEB Teardown common keyword
Metadata          name    Lobby
Resource          ../../../Resource/Keywords/CL/CL_Lobby.robot
Resource          ../../../Resource/Keywords/CL/CL_GameSearch.robot
Resource          ../../../Resource/Keywords/CL/CL_Promotion.robot
Resource          ../../../Resource/Keywords/CL/CL_Referral.robot
Resource          ../../../Resource/import.robot

*** Test Cases ***
CLBP-001 Random test
    [Tags]    DESKTOP    active
    [Setup]    Setup Common Keyword For Lobby Page
    ${len}    WEB Get Element Count    //*[@class="section_header__CAs7L section_extra__03tas"]
    FOR   ${i}   IN RANGE   ${len}
        ${text}    WEB Get Element Text    (//*[@class="section_header__CAs7L section_extra__03tas"])[${i+1}]
        Log    ${text}
    END

Get data from web
    [Tags]   a
    Set Selenium speed    0.5
    @{symbol}=   Create List
    
    WEB Open Browser    https://www.settrade.com/en/equities/market-data/overview?category=Index&index=SET
    # Scroll Element Into View    //*[@class="mb-0 me-2 title-font-family fs-20px text-deep-gray"]
    # Execute JavaScript   window.scrollTo(9,900);
    Sleep   15s
    # WEB Click Element    //*[@class="multiselect multiselect--above"]
    # WEB Click Element    //*[@class="multiselect__element"]//*[contains(text(), 'ทั้งหมด')]   
    ${len}    WEB Get Element Count    //*[@class="table b-table table-custom-field table-custom-field--cnc table-hover-underline b-table-no-border-collapse"]/tbody/tr
    FOR   ${i}   IN RANGE   ${len}
        ${index}   BuiltIn.Convert To String   ${i+1}
        ${txt}    WEB Get Element Text    (//*[@class="table b-table table-custom-field table-custom-field--cnc table-hover-underline b-table-no-border-collapse"]/tbody/tr[${index}]/td)[1]//*[contains(@class,"symbol")]
        Append To List   ${symbol}   ${txt}
        log to console    ${txt}
    END
    Log   ${symbol}

    
*** Keywords ***
Set Up Common Keyword For Lobby Page
    [Arguments]    ${user_type}=common    ${common_type}=normal
    Casino Setup Test User    ${user_type}    ${common_type}
    Open Casino Website

Setup Keyword For Set Recent Game Favorite To
    [Arguments]    ${favorite_status}    ${user_type}=common    ${common_type}=normal
    CL Setup Test User    ${user_type}
    CL Get Recent Game Ids
    CL Set Game Favorite Status    ${favorite_status}
    CL Open Pigspin Website

Setup Keyword For Set New Game Favorite To
    [Arguments]    ${favorite_status}    ${user_type}=common    ${common_type}=normal
    CL Setup Test User    ${user_type}
    CL Get Recent Game Ids
    CL Set Game Favorite Status    ${favorite_status}
    CL Open Pigspin Website

Setup Keyword For Set Popular Game Favorite To
    [Arguments]    ${favorite_status}    ${user_type}=common    ${common_type}=normal
    CL Setup Test User    ${user_type}
    DB Connect To Database Pigspin Game
    Query Popular Game Ids Display On Lobby
    CL Set Game Favorite Status    ${favorite_status}    ${game_ids}
    CL Open Pigspin Website
