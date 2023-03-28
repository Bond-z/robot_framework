*** Settings ***
Resource          ../../import.robot
Resource          ../../Locators/CL/CL_GameSearch.robot
Variables         ../../Localize/CL/TH/CL_GameSearch.yaml

*** Keywords ***
CL Verify Game Search New Game Header
    WEB Verify Element Text    ${GSP_title_txt}    ${cl_gamesearch_localize.all_game.header.new}

CL Verify Game Search Popular Game Header
    WEB Verify Element Text    ${GSP_title_txt}    ${cl_gamesearch_localize.all_game.header.popular}

CL Verify Game Search Favorite Game Header
    WEB Verify Element Text    ${GSP_title_txt}    ${cl_gamesearch_localize.all_game.header.favorite}

CL Verify Game Search Recent Game Header
    WEB Verify Element Text    ${GSP_title_txt}    ${cl_gamesearch_localize.all_game.header.recent}

CL Verify Game Search All Game Header
    WEB Verify Element Text    ${GSP_title_txt}    ${cl_gamesearch_localize.all_game.header.all}

Go To All Game Page And Search For Game
    [Arguments]    ${keyword}
    Go To All Game Page
    WEB Verify Element Visible    ${search_game_txt}
    Web Input Text    ${search_game_txt}    ${keyword}
    Press Keys    ${search_game_txt}    ENTER
    WEB Sleep
    Verify search result should contains    ${keyword}


Go To All Game Page
    WEB Sleep
    WEB Click Element    ${LBP_all_game_page_btn}

Click To Play Game on All Game Page
    WEB Click Element    ${play_game_btn}

Verify Game Can Be Linked To 3rd Party By URL
    [Arguments]    ${game_title}
    Run Keyword And Ignore Error    SeleniumLibrary.Wait Until Element Is Visible    ${game_grid}
    ${url}=   Get Location
    ${title}=   Remove String    ${game_title}    '
    ${title}=   Convert To Lower Case    ${title}
    ${game_title}   Replace String   ${title}   ${SPACE}   ${EMPTY}
    ${status}   Run Keyword And Return Status    Location Should Contain    ${url}    ${game_title}
    [Return]    ${status}

Verify search result should be found by name
    [Arguments]    ${keyword}
    WEB Verify Element Visible    ${game_title}
    WEB Verify Element Text    ${game_title}    1 ${keyword}

Verify search result should contains
    [Arguments]    ${keyword}
    WEB Verify Element Visible    ${game_title}
    SeleniumLibrary.Element Should Contain    ${game_title}    ${keyword}

Verify first five game companies 
    [Arguments]    ${keyword}
    Go To All Game Page
    Filtering by game company
    FOR   ${index}   IN RANGE   5
        ${ele}    WEB_Common.Format Text    ${game_company_text}    $index=${index+1}
        SeleniumLibrary.Element Text Should Be    ${ele}    ${keyword}
    END

Verify search result when filter by slot game
    Go To All Game Page
    Click filter button
    WEB Set Focus To Element    ${filter_slot_game}
    Click Element     ${filter_slot_game}
    WEB Sleep
    SeleniumLibrary.Page Should Contain    Alice In Wonderland

Click filter button
    WEB Click Element    ${filter_btn}

Filtering by game company
    Click filter button
    Select filter by Joker game company
    Click submit button on filtering

Select favorite filter
    WEB Click Element    ${favorite_btn}

Verify the amount of favorite game is displayed correctly
    ${elements}    Get Element Count    ${game_favorited}
    ${count}    Convert To Integer    ${elements}
    [Return]    ${count}

Select filter by Joker game company
    WEB Set Focus To Element    ${filter_game_companies}
    Click Element    ${filter_game_companies}

Click submit button on filtering
    WEB Set Focus To Element    ${filter_submit_btn}
    # WEB Click Element   ${filter_submit_btn}
    Click Element    ${filter_submit_btn}

Verify filter by favorite game should be displayed correctly
    [Arguments]    ${total_game_favorite}
    Go To All Game Page
    Select favorite filter
    WEB Sleep
    ${count}   Verify the amount of favorite game is displayed correctly
    Should Be Equal As Integers    ${count}    ${total_game_favorite}

Select sorting by CL RTP max - min
    WEB Click Element    ${sorting_dropdown} 
    WEB Click Element    ${sorting_max_min}

Verify sorting can be recognized the latest sorting
    Run Keyword And Ignore Error     WEB Close Toastify    ${Close_toastify}
    SeleniumLibrary.Element Text Should Be    ${sorting_title}      RTP สูง - ต่ำ
