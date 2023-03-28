*** Settings ***
Resource          ../../Locators/CL/CL_Lobby.robot
Resource          CL_Common.robot
Variables         ../../Localize/CL/TH/CL_Lobby.yaml
Resource          ../../import.robot

*** Keywords ***
CL Click All Game Lobby Menu
    [Arguments]    ${locator}=${LBP_all_game_page_btn}
    WEB Click Element    ${locator}

CL Click Quest Lobby Menu
    [Arguments]    ${locator}=${LBP_quest_page_btn}
    WEB Click Element    ${locator}

CL Click Champion Lobby Menu
    [Arguments]    ${locator}=${LBP_champion_page_btn}
    WEB Click Element    ${locator}

CL Click Item Shop Lobby Menu
    [Arguments]    ${locator}=${LBP_item_shop_page_btn}
    WEB Click Element    ${locator}

CL Verify Redirect All Game Page
    [Arguments]    ${location}=${ENVIRONMENT.DOMAIN.${ar_DOMAIN}.ARES.URL}${ENVIRONMENT.PAGE.ALL_GAMES}
    WEB Verify Current Location    ${location}

CL Verify Redirect Quest Page
    [Arguments]    ${location}=${ENVIRONMENT.DOMAIN.${ar_DOMAIN}.ARES.URL}${ENVIRONMENT.PAGE.QUEST}
    WEB Verify Current Location    ${location}

CL Verify Redirect Champion Page
    [Arguments]    ${location}=${ENVIRONMENT.DOMAIN.${ar_DOMAIN}.ARES.URL}${ENVIRONMENT.PAGE.CHAMPION}
    WEB Verify Current Location    ${location}

CL Verify Redirect Item Shop Page
    [Arguments]    ${location}=${ENVIRONMENT.DOMAIN.${ar_DOMAIN}.ARES.URL}${ENVIRONMENT.PAGE.SHOP}
    WEB Verify Current Location    ${location}

CL Verify Redirect Lobby Page
    [Arguments]    ${location}=${ENVIRONMENT.DOMAIN.${ar_DOMAIN}.ARES.URL}${ENVIRONMENT.PAGE.LOBBY}
    WEB Verify Current Location    ${location}


CL Click All Promotion Button
    [Arguments]    ${locator}=${LBP_all_promotion_games_btn}
    WEB Click Element    ${locator}

CL Click All Recent Games Button
    [Arguments]    ${locator}=${LBP_all_recent_games_btn}
    WEB Click Element    ${locator}

CL Click All Favorite Games Button
    [Arguments]    ${locator}=${LBP_all_favorite_games_btn}
    WEB Click Element    ${locator}

CL Click All New Games Button
    [Arguments]    ${locator}=${LBP_all_new_games_btn}
    WEB Click Element    ${locator}

CL Click All Popular Games Button
    [Arguments]    ${locator}=${LBP_all_popular_games_btn}
    WEB Click Element    ${locator}

CL Click All Games Button
    [Arguments]    ${locator}=${LBP_all_game_page_btn}
    [Documentation]    At bottom area in lobby body
    WEB Click Element    ${locator}

Query Favorite Game x Latest Record
    [Arguments]    ${order_by}=desc    ${total_games}=${CL_COMMON_CONFIG.LIMIT_DISPLAY.LOBBY.FAVORITE_GAME}
    [Documentation]    order by = การเรียงลำดับของ Query โดยมีให้เลือกคือ desc | asc
    ...
    ...    total_games = จำนวนเกมทั้งหมดที่จะดึงมาจาก Query ส่งค่าเป็น Int
    ...
    ...
    ...    Hint: desc = หลัง -> หน้า , มาก -> น้อย
    ${game_codes}=    DatabaseLibrary.Query    SELECT game_code \ FROM public.user_game_favorite WHERE user_code ='${TEST_USER.user_code}' AND is_favorite=${True} order by updated_at ${order_by} limit ${total_games}
    Set Test Variable    ${game_codes}
    DatabaseLibrary.Disconnect From Database

CL Verify Total Recent Game Display On Lobby
    [Arguments]    ${total_games}=${CL_COMMON_CONFIG.LIMIT_DISPLAY.LOBBY.RECENT_GAME}
    WEB Verify Element Count    ${LBP_all_recent_lbl}    ${total_games}

CL Verify Total Favorite Game Display On Lobby
    [Arguments]    ${total_games}=${CL_COMMON_CONFIG.LIMIT_DISPLAY.LOBBY.FAVORITE_GAME}
    WEB Verify Element Count    ${LBP_all_favorite_lbl}    ${total_games}

CL Verify Latest Favorite Game Display On Lobby
    ${length}=    Get Length    ${game_codes}
    DB Connect To Database Pigspin Game
    FOR    ${index}    IN RANGE    0    ${length}    1
        ${index_element}    Convert To String    ${index+1}
        ${name_lobby}    Replace String    ${LBP_favorite_name_txt}    <index>    ${index_element}
        Web Mouse Over    ${name_lobby}
        ${game_name_lobby}=    WEB Get Element Text    ${name_lobby}
        ${game_name_db}    Query Game Name Using Game Code    ${game_codes}[${index}][0]
        Should Be Equal As Strings    ${game_name_lobby}    ${index+1} ${game_name_db}
    END

Query Game Name Using Game Code
    [Arguments]    ${game_code}
    ${game_name_db}=    DatabaseLibrary.Query    select game_name from public.game where game_code ='${game_code}'
    ${game_name}    Set Variable    ${game_name_db}[0][0]
    [Return]    ${game_name}

CL Get Recent Game Ids
    [Arguments]    ${username}=${TEST_USER.username}    ${order_by}=desc    ${total_games}=${CL_COMMON_CONFIG.LIMIT_DISPLAY.LOBBY.RECENT_GAME}
    DB Connect To Database Pigspin Wallet
    Query Game Ids From Recent Game    ${username}    ${order_by}    ${total_games}
    Set Test Variable    ${game_ids}
    DatabaseLibrary.Disconnect From Database

Query Game Name Using Game Id
    [Arguments]    ${game_id}
    ${game_name_db}=    DatabaseLibrary.Query    select game_name from public.game where game_id ='${game_id}'
    ${game_name}=    Set Variable    ${game_name_db}[0][0]
    [Return]    ${game_name}

CL Verify Header Promotion Section
    WEB Verify Element Text    ${LBP_promotion_header_txt}    ${cl_lobby_localize.lobby.promotion.header}
    WEB Verify Element Count    ${LBP_banner_lbl}    ${CL_COMMON_CONFIG.LIMIT_DISPLAY.LOBBY.BANNER}

CL Verify Header Recent Game Section
    WEB Verify Element Text    ${LBP_Recent_game_header_txt}    ${cl_lobby_localize.lobby.recent_game.header}

CL Verify Header Favorite Game Section
    WEB Verify Element Text    ${LBP_favorite_game_header_txt}    ${cl_lobby_localize.lobby.favorite_game.header}

CL Verify Header New Game Section
    WEB Verify Element Text    ${LBP_new_game_header_txt}    ${cl_lobby_localize.lobby.new_game.header}

CL Verify Header Popular Game Section
    WEB Verify Element Text    ${LBP_popular_game_header_txt}    ${cl_lobby_localize.lobby.popular_game.header}

CL Verify Recent Game Display On Lobby
    [Arguments]    ${total_games}=${CL_COMMON_CONFIG.LIMIT_DISPLAY.LOBBY.RECENT_GAME}
    DB Connect To Database Pigspin Game
    WEB Verify Element Count    ${LBP_all_recent_lbl}    ${total_games}
    ${length}    BuiltIn.Get Length    ${game_ids}
    FOR    ${index}    IN RANGE    0    ${total_games}    1
        ${index_element}    BuiltIn.Convert To String    ${index+1}
        ${name_lobby}    String.Replace String    ${LBP_recent_game_txt}    <index>    ${index_element}
        Web Mouse Over    ${name_lobby}
        ${game_name_lobby}    WEB Get Element Text    ${name_lobby}
        ${game_name_db}    Query Game Name Using Game Id    ${game_ids}[${index}][0]
        Should Be Equal As Strings    ${game_name_lobby}    ${game_name_db}
    END

Query New Game Name Display On Lobby
    [Arguments]    ${order_by}=desc    ${total_games}=${CL_COMMON_CONFIG.LIMIT_DISPLAY.LOBBY.NEW_GAME}
    ${game_names}=    DatabaseLibrary.Query    SELECT game_name FROM public.game WHERE is_new=${True} order by game_id ${order_by} limit ${total_games}
    [Return]    ${game_names}

CL Verify Latest New Game Display On Lobby
    [Arguments]    ${db_game_name}    ${total_games}=${CL_COMMON_CONFIG.LIMIT_DISPLAY.LOBBY.NEW_GAME}
    WEB Verify Element Count    ${LBP_all_new_lbl}    ${total_games}
    FOR    ${index}    IN RANGE    0    ${total_games}    1
        ${index_element}=    Convert To String    ${index+1}
        ${name_lobby}    Replace String    ${LBP_new_name_txt}    <index>    ${index_element}
        Web Mouse Over    ${name_lobby}
        ${game_name_lobby}    WEB Get Element Text    ${name_lobby}
        ${game_name_db}    Set Variable    ${db_game_name}[${index}][0]
        Should Be Equal As Strings    ${game_name_lobby}    ${game_name_db}
    END

CL Verify Main Menu Lobby Page
    WEB Verify Element Visible    ${LBP_mainmenu_allgame_btn}
    WEB Verify Element Visible    ${LBP_mainmenu_quest_btn}
    WEB Verify Element Visible    ${LBP_mainmenu_champion_btn}
    WEB Verify Element Visible    ${LBP_mainmenu_loyaltyshop_btn}

Query Popular Game Name Display On Lobby
    [Arguments]    ${order_by}=asc    ${total_games}=${CL_COMMON_CONFIG.LIMIT_DISPLAY.LOBBY.POPULAR_GAME}
    ${game_names}=    DatabaseLibrary.Query    SELECT game_name FROM public.game WHERE status='ACTIVE' and is_popular=${true} order by "order" ${order_by} limit ${total_games}
    Set Test Variable    ${game_names}

CL Set Game Favorite Status
    [Arguments]    ${status}=${false}    ${ids}=${game_ids}
    ${length}    Get Length    ${ids}
    DB Connect To Database Pigspin User
    FOR    ${index}    IN RANGE    0    ${length}    1
        DatabaseLibrary.Execute Sql String    UPDATE public.user_game_favorite SET is_favorite=${status} \ WHERE user_code ='${TEST_USER.user_code}' and game_id ='${ids}[${index}][0]'
    END
    Disconnect From Database

Query Popular Game Ids Display On Lobby
    [Arguments]    ${order_by}=asc    ${total_games}=${CL_COMMON_CONFIG.LIMIT_DISPLAY.LOBBY.POPULAR_GAME}
    ${game_ids}=    DatabaseLibrary.Query    SELECT game_id FROM public.game WHERE is_popular=${true} order by "order" ${order_by} limit ${total_games}
    Set Test Variable    ${game_ids}

Query New Game Ids Display On Lobby
    [Arguments]    ${order_by}=desc    ${total_games}=${CL_COMMON_CONFIG.LIMIT_DISPLAY.LOBBY.NEW_GAME}
    ${game_ids}=    DatabaseLibrary.Query    SELECT game_id FROM public.game WHERE is_new=${True} order by game_id ${order_by} limit ${total_games}
    BuiltIn.Set Test Variable    ${game_ids}

CL Click Favorite In New Game Section
    [Arguments]    ${index}
    [Documentation]    ${is_favorite} = ${True} | ${False}
    ${index_element}=    BuiltIn.Convert To String    ${index}
    ${favorite_btn}=    String.Replace String    ${LBP_newgame_favorite_btn}    <index>    ${index_element}
    Web Mouse Over    ${favorite_btn}
    WEB Click Element    ${favorite_btn}

CL Click Favorite All Game In New Game Section
    [Arguments]    ${total_games}=${CL_COMMON_CONFIG.LIMIT_DISPLAY.LOBBY.NEW_GAME+1}
    Set Selenium Speed    0.1s
    FOR    ${index}    IN RANGE    1    ${total_games}    1
        CL Click Favorite In New Game Section    ${index}
    END
    Set Selenium Speed    0s

CL Verify Favorite Game In New Game Section
    [Arguments]    ${index}
    ${index_element}=    BuiltIn.Convert To String    ${index}
    ${is_favorite_btn}    String.Replace String    ${LBP_newgame_is_favorite_btn}    <index>    ${index_element}
    Web Mouse Over    ${is_favorite_btn}
    WEB Verify Element Visible    ${is_favorite_btn}

CL Verify Favorite All Game In New Game Section
    [Arguments]    ${total_games}=${CL_COMMON_CONFIG.LIMIT_DISPLAY.LOBBY.NEW_GAME}
    FOR    ${index}    IN RANGE    1    ${total_games+1}    1
        CL Verify Favorite Game In New Game Section    ${index}
    END
    [Teardown]

CL Click Unfavorite In New Game Section
    [Arguments]    ${index}
    ${index_element}=    BuiltIn.Convert To String    ${index}
    ${favorite_btn}=    String.Replace String    ${LBP_newgame_favorite_btn}    <index>    ${index_element}
    Web Mouse Over    ${favorite_btn}
    WEB Click Element    ${favorite_btn}

CL Click Unfavorite All Game In New Game Section
    [Arguments]    ${total_games}=${CL_COMMON_CONFIG.LIMIT_DISPLAY.LOBBY.NEW_GAME}
    Set Selenium Speed    0.1s
    FOR    ${index}    IN RANGE    1    ${total_games+1}    1
        CL Click Unfavorite In New Game Section    ${index}
    END
    Set Selenium Speed    0s

CL Verify Unfavorite Game In New Game Section
    [Arguments]    ${index}
    ${index_element}=    BuiltIn.Convert To String    ${index}
    ${is_favorite_btn}    String.Replace String    ${LBP_newgame_is_unfavorite_btn}    <index>    ${index_element}
    Web Mouse Over    ${is_favorite_btn}
    WEB Verify Element Visible    ${is_favorite_btn}

CL Verify Unfavorite All Game In New Game Section
    [Arguments]    ${total_games}=${CL_COMMON_CONFIG.LIMIT_DISPLAY.LOBBY.NEW_GAME}
    FOR    ${index}    IN RANGE    1    ${total_games+1}    1
        CL Verify Unfavorite Game In New Game Section    ${index}
    END

CL Click Favorite In Popular Game Section
    [Arguments]    ${index}
    ${index_element}=    BuiltIn.Convert To String    ${index}
    ${favorite_btn}=    String.Replace String    ${LBP_popular_favorite_btn}    <index>    ${index_element}
    Web Mouse Over    ${favorite_btn}
    WEB Click Element    ${favorite_btn}

CL Click Favorite All Game In Popular Game Section
    [Arguments]    ${total_games}=${CL_COMMON_CONFIG.LIMIT_DISPLAY.LOBBY.POPULAR_GAME}
    Set Selenium Speed    0.1s
    FOR    ${index}    IN RANGE    1    ${total_games+1}    1
        CL Click Favorite In Popular Game Section    ${index}
    END
    Set Selenium Speed    0s

CL Verify Favorite Game In Popular Game Section
    [Arguments]    ${index}
    ${index_element}=    BuiltIn.Convert To String    ${index}
    ${is_favorite_btn}    String.Replace String    ${LBP_popular_is_favorite_btn}    <index>    ${index_element}
    WEB Verify Element Visible    ${is_favorite_btn}

CL Verify Favorite All Game In Popular Game Section
    [Arguments]    ${total_games}=${CL_COMMON_CONFIG.LIMIT_DISPLAY.LOBBY.POPULAR_GAME}
    FOR    ${index}    IN RANGE    1    ${total_games+1}    1
        CL Verify Favorite Game In Popular Game Section    ${index}
    END
    [Teardown]

CL Click Unfavorite In Popular Game Section
    [Arguments]    ${index}
    ${index_element}=    BuiltIn.Convert To String    ${index}
    ${favorite_btn}=    String.Replace String    ${LBP_popular_favorite_btn}    <index>    ${index_element}
    Web Mouse Over    ${favorite_btn}
    WEB Click Element    ${favorite_btn}

CL Click Unfavorite All Game In Popular Game Section
    [Arguments]    ${total_games}=${CL_COMMON_CONFIG.LIMIT_DISPLAY.LOBBY.POPULAR_GAME}
    Set Selenium Speed    0.1s
    FOR    ${index}    IN RANGE    1    ${total_games+1}    1
        CL Click Unfavorite In Popular Game Section    ${index}
    END
    Set Selenium Speed    0s

CL Verify Unfavorite Game In Popular Game Section
    [Arguments]    ${index}
    ${index_element}=    BuiltIn.Convert To String    ${index}
    ${is_favorite_btn}    String.Replace String    ${LBP_popular_is_unfavorite_btn}    <index>    ${index_element}
    Web Mouse Over    ${is_favorite_btn}
    WEB Verify Element Visible    ${is_favorite_btn}

CL Verify Unfavorite All Game In Popular Game Section
    [Arguments]    ${total_games}=${CL_COMMON_CONFIG.LIMIT_DISPLAY.LOBBY.POPULAR_GAME}
    FOR    ${index}    IN RANGE    1    ${total_games+1}    1
        CL Verify Unfavorite Game In Popular Game Section    ${index}
    END

CL Click Favorite In Recent Game Section
    [Arguments]    ${index}
    ${index_element}=    BuiltIn.Convert To String    ${index}
    ${favorite_btn}=    String.Replace String    ${LBP_recent_favorite_btn}    <index>    ${index_element}
    Web Mouse Over    ${favorite_btn}
    WEB Click Element    ${favorite_btn}

CL Click Favorite All Game In Recent Game Section
    [Arguments]    ${total_games}=${CL_COMMON_CONFIG.LIMIT_DISPLAY.LOBBY.RECENT_GAME}
    Set Selenium Speed    0.1s
    FOR    ${index}    IN RANGE    1    ${total_games+1}    1
        CL Click Favorite In Recent Game Section    ${index}
    END
    Set Selenium Speed    0s

CL Verify Favorite Game In Recent Game Section
    [Arguments]    ${index}
    ${index_element}=    BuiltIn.Convert To String    ${index}
    ${is_favorite_btn}    String.Replace String    ${LBP_recent_is_favorite_btn}    <index>    ${index_element}
    Web Mouse Over    ${is_favorite_btn}
    WEB Verify Element Visible    ${is_favorite_btn}

CL Verify Favorite All Game In Recent Game Section
    [Arguments]    ${total_games}=${CL_COMMON_CONFIG.LIMIT_DISPLAY.LOBBY.RECENT_GAME}
    FOR    ${index}    IN RANGE    1    ${total_games+1}    1
        CL Verify Favorite Game In Recent Game Section    ${index}
    END

CL Click Unfavorite In Recent Game Section
    [Arguments]    ${index}
    ${index_element}=    BuiltIn.Convert To String    ${index}
    ${favorite_btn}=    String.Replace String    ${LBP_recent_favorite_btn}    <index>    ${index_element}
    Web Mouse Over    ${favorite_btn}
    WEB Click Element    ${favorite_btn}

CL Click Unfavorite All Game In Recent Game Section
    [Arguments]    ${total_games}=${CL_COMMON_CONFIG.LIMIT_DISPLAY.LOBBY.RECENT_GAME}
    Set Selenium Speed    0.1s
    FOR    ${index}    IN RANGE    1    ${total_games+1}    1
        CL Click Unfavorite In Recent Game Section    ${index}
    END
    Set Selenium Speed    0s

CL Verify Unfavorite Game In Recent Game Section
    [Arguments]    ${index}
    ${index_element}=    BuiltIn.Convert To String    ${index}
    ${is_favorite_btn}    String.Replace String    ${LBP_recent_is_unfavorite_btn}    <index>    ${index_element}
    Web Mouse Over    ${is_favorite_btn}
    WEB Verify Element Visible    ${is_favorite_btn}

CL Verify Unfavorite All Game In Recent Game Section
    [Arguments]    ${total_games}=${CL_COMMON_CONFIG.LIMIT_DISPLAY.LOBBY.RECENT_GAME}
    FOR    ${index}    IN RANGE    1    ${total_games+1}    1
        CL Verify Unfavorite Game In Recent Game Section    ${index}
    END

CL Verify Latest Popular Game Display On Lobby
    [Arguments]    ${total_games}=${CL_COMMON_CONFIG.LIMIT_DISPLAY.LOBBY.POPULAR_GAME}
    WEB Verify Element Count    ${LBP_all_popular_lbl}    ${total_games}
    FOR    ${index}    IN RANGE    1    ${total_games}    1
        ${index_str}    BuiltIn.Convert To String    ${index}
        ${name_locator}    Replace String    ${LBP_popular_name_txt}    <index>    ${index_str}
        Web Mouse Over    ${name_locator}
        ${game_name_lobby}    WEB Get Element Text    ${name_locator}
        Should Be Equal As Strings    ${game_name_lobby}    ${index} ${game_names}[${index-1}][0]
    END

CL Verify RTP Win Bonus Header
    Wait Until Element Is Visible     ${LBP_promotion_header_txt}
    Scroll Element Into View    ${LBP_max_rtp_header}
    WEB Verify Element Text    ${LBP_max_rtp_header}    ${cl_lobby_localize.lobby.rtp_win_bonus.header}

CL Verify RTP Nearly Win Bonus Header
    Wait Until Element Is Visible     ${LBP_promotion_header_txt}
    Scroll Element Into View    ${LBP_min_rtp_header}
    WEB Verify Element Text    ${LBP_min_rtp_header}    ${cl_lobby_localize.lobby.rtp_nearly_win.header}

CL Verify there should be 10 cards are displayed
    [Arguments]    ${rtp_card}
    ${ele_count}    WEB_Common.WEB Get Element Count    ${rtp_card}
    Should Be True    ${ele_count} == ${CL_COMMON_CONFIG.LIMIT_DISPLAY.LOBBY.RTP_WIN_BONUS}

CL Verify RTP should not be equal to zero
    [Arguments]    ${rtp_card}    ${rtp_ratio}
    ${elements}   WEB_Common.WEB Get Element Count    ${rtp_card}
    FOR    ${i}   IN RANGE    ${elements}
        Set Test Variable    ${index}    ${i+1}
        ${elem}=    WEB_Common.Format Text    ${rtp_ratio}    $index=${index}
        Scroll Element Into View    ${elem}
        ${str}    Get Text    ${elem}
        ${str}    Remove String    ${str}   %
        ${number}    Convert To Number    ${str}   2
        Should Be True    ${number} != 0.0
    END

Get Top Max RTP Titile
    ${elem}=    WEB_Common.Format Text    ${LBP_games_max_rtp_title}    $index=1
    ${title}    WEB get Element Text    ${elem}
    [Return]    ${title}

Get Top Max RTP rtp
    ${elem}=    WEB_Common.Format Text    ${LBP_games_max_rtp_ratio}    $index=1
    ${rtp}    WEB get Element Text    ${elem}
    [Return]    ${rtp}

Get Top Min RTP Titile
    ${elem}=    WEB_Common.Format Text    ${LBP_games_min_rtp_title}    $index=1
    ${title}    WEB get Element Text    ${elem}
    [Return]    ${title}

Get Top Min RTP rtp
    ${elem}=    WEB_Common.Format Text    ${LBP_games_min_rtp_ratio}    $index=1
    ${rtp}    WEB get Element Text    ${elem}
    [Return]    ${rtp}


Get total of favorite game in Lobby page
    ${count}    WEB_Common.WEB Get Element Text    ${LBP_all_favirite_link}
    ${total}=   Remove String    ${count}    (   ทั้งหมด   )
    ${total}=   Convert To Integer   ${total} 
    [Return]    ${total}

Go to Lobby page
    WEB Click Element    ${LBP_pigspin_logo}

CL Go to PG game company page
    WEB Verify Element Visible     ${LBP_promotion_header_txt}
    WEB Click Element     ${company_game_pg} 
    WEB Verify Element Visible    ${game_company_title}
    Web Verify Until Element Text Contain      ${game_company_title}    เกมค่าย PG SOFT

CL Go to EVO game company page
    WEB Verify Element Visible     ${LBP_promotion_header_txt}
    WEB Click Element     ${company_game_evo} 
    WEB Verify Element Visible    ${game_company_title}
    Web Verify Until Element Text Contain      ${game_company_title}    เกมค่าย Evoplay

CL Go to Joker game company page
    WEB Verify Element Visible     ${LBP_promotion_header_txt}
    WEB Click Element     ${company_game_joker} 
    WEB Verify Element Visible    ${game_company_title}
    Web Verify Until Element Text Contain      ${game_company_title}    เกมค่าย Joker

CL Go to PNG game company page
    WEB Verify Element Visible     ${LBP_promotion_header_txt}
    WEB Click Element     ${company_game_png} 
    WEB Verify Element Visible    ${game_company_title}
    Web Verify Until Element Text Contain      ${game_company_title}    เกมค่าย Play N Go

Verify element sorting dropdown should be displayed properly
    WEB Click Element    ${sorting_dropdown}
    ${index}   Get Length   ${sorting_by}
    FOR   ${i}   IN RANGE   ${index}
        ${ele}   Format Text   ${sorting}    $index=${i+1}
        Element Should Contain   ${ele}     ${sorting_by}[${i}]
    END

Select sorting by RTP max to min
    WEB Click Element     ${sorting_max_min} 

Select sorting by RTP min to max
    WEB Click Element     ${sorting_min_max}

Select sorting by old to new game
    WEB Click Element     ${sorting_dropdown}
    sleep   3s
    WEB Click Element     ${sorting_old_new}

Verify sorting by RTP min to max should work correctly
    Select sorting by RTP min to max
    ${game_name}=   WEB Get Element Text    ${game_title}
    SeleniumLibrary.Click element    ${sorting_dropdown}
    Select sorting by RTP max to min
    Element Text Should Not Be    ${game_title}    ${game_name}

Verify sorting by RTP max to min should work correctly
    Select sorting by RTP max to min
    ${game_name}=   WEB Get Element Text    ${game_title}
    SeleniumLibrary.Click element    ${sorting_dropdown}
    Select sorting by RTP min to max
    Element Text Should Not Be    ${game_title}    ${game_name}

Verify sorting by game old to new should work correctly
    WEB Click Element     ${sorting_dropdown}
    ${game_name}=   WEB Get Element Text    ${game_title}
    Select sorting by old to new game
    Element Text Should Not Be    ${game_title}    ${game_name}

Verify Max RTP is auto refresh
    [Arguments]    ${expect_rtp}    ${index}=1
    Wait until Keyword Succeeds    ${TIMEOUT.${ar_DOMAIN}.RETRY}    ${TIMEOUT.${ar_DOMAIN}.RETRY_INTERVAL}    Verify Display expected Max RTP    ${expect_rtp}    ${index}=1

Verify Display expected MAX RTP
    [Arguments]    ${expect_rtp}    ${index}
    ${elem}=    WEB_Common.Format Text    ${LBP_games_max_rtp_ratio}    $index=${index}
    ${rtp}    WEB get Element Text    ${elem}
    ${rtp}    Remove String    ${rtp}    ,
    ${rtp}    Remove String    ${rtp}    %
    Should Be Equal As Numbers    ${expect_rtp}    ${rtp}

Verify Min RTP is auto refresh
    [Arguments]    ${expect_rtp}    ${index}=1
    Wait until Keyword Succeeds    ${TIMEOUT.${ar_DOMAIN}.RETRY}    ${TIMEOUT.${ar_DOMAIN}.RETRY_INTERVAL}    Verify Display expected Min RTP    ${expect_rtp}    ${index}=1

Verify Display expected Min RTP
    [Arguments]    ${expect_rtp}    ${index}
    ${elem}=    WEB_Common.Format Text    ${LBP_games_min_rtp_ratio}    $index=${index}
    ${rtp}    WEB get Element Text    ${elem}
    ${rtp}    Remove String    ${rtp}    ,
    ${rtp}    Remove String    ${rtp}    %
    Should Be Equal As Numbers    ${expect_rtp}    ${rtp}