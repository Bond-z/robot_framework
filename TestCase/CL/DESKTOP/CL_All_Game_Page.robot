*** Settings ***
Test Setup     Open web pigspin browser and go to lobby page
Test Teardown     WEB Teardown common keyword
Metadata          name    AllGamePage
Resource          ../../../Resource/Keywords/CL/CL_Lobby.robot
Resource          ../../../Resource/Keywords/CL/CL_GameSearch.robot
Resource          ../../../Resource/Keywords/CL/CL_Promotion.robot
Resource          ../../../Resource/Keywords/CL/CL_Referral.robot
Resource          ../../../Resource/import.robot

*** Test Cases ***
AGP-001 Verify search result when search by full game name
    [Tags]   DAGP-1    active    DESKTOP
    Set Selenium Speed    0.5s
    CL Login
    Set Test Variable   ${game_name}    Big Win Cat
    Go To All Game Page And Search For Game     ${game_name}
    Verify search result should be found by name    ${game_name}

AGP-002 Verify search result when search by some part of game name
    [Tags]   DAGP-2    active    DESKTOP
    CL Login
    Set Test Variable   ${game_name}    Santa
    Go To All Game Page And Search For Game     ${game_name}
    Verify search result should contains    ${game_name}

AGP-003 Verify search result when filtering by game company
    [Tags]   DAGP-3    active    DESKTOP
    Set Selenium Speed    0.5s
    CL Login
    Set Test Variable   ${company_name}    Joker
    Verify first five game companies    ${company_name}

AGP-004 Verify search result when filtering by game category is slot
    [Tags]   DAGP-4    active    DESKTOP
    CL Login
    Verify search result when filter by slot game

AGP-005 Verify search result when filtering by wishlist
    [Tags]   DAGP-5    active    DESKTOP
    CL Login   
    CL Click Favorite In Popular Game Section    3
    WEB Sleep
    ${total_favorite}   Get total of favorite game in Lobby page
    Verify filter by favorite game should be displayed correctly     ${total_favorite}

AGP-006 Verify sorting can be recognized the latest sorting
    [Tags]   DAGP-6    active    DESKTOP
    CL Login
    Go To All Game Page
    Select sorting by CL RTP max - min
    Go to Lobby page
    Go To All Game Page
    Verify sorting can be recognized the latest sorting

AGP-007 Verify All Joker Game can be played properly
    [Tags]    DAGP-7   active    DESKTOP
    ${not_available}    Create List
    CL Login
    ${count}    Get Length    ${joker_game_list}
    FOR    ${i}   IN RANGE   ${count}
        Set Test Variable    ${title}    ${joker_game_list}[${i}]
        Go To All Game Page And Search For Game     ${title} 
        Click To Play Game on All Game Page  
        ${status}    CL_GameSearch.Verify Game Can Be Linked To 3rd Party By URL    ${title}
        IF   ${status} == ${False}
            Append To List    ${not_available}    ${title}
        END
        Go To   ${ENVIRONMENT.DOMAIN.STAGING.ARES.URL}lobby
    END
    ${game_failed}    Get Length    ${not_available}
    Should Be Equal    ${game_failed}    ${0}
    Log    ${not_available}

AGP-008 Verify All EVO Game can be played properly
    [Tags]    DAGP-8   active    DESKTOP
    ${not_available}    Create List
    CL Login
    ${count}    Get Length    ${evo_game_list}
    FOR    ${i}   IN RANGE   ${count}
        Set Test Variable    ${title}    ${evo_game_list}[${i}]
        Go To All Game Page And Search For Game     ${title}   
        Click To Play Game on All Game Page
        ${status}    CL_GameSearch.Verify Game Can Be Linked To 3rd Party By URL    ${title}
        IF   ${status} == ${False}
            Append To List    ${not_available}    ${title}
        END
        Go To   ${ENVIRONMENT.DOMAIN.STAGING.ARES.URL}lobby
    END
    ${game_failed}    Get Length    ${not_available}
    Should Be Equal    ${game_failed}    ${0}
    Log    ${not_available}

AGP-009 Verify All PNG Game can be played properly
    [Tags]    DAGP-9   active    DESKTOP
    CL Login
    ${not_available}    Create List
    ${count}    Get Length    ${png_game_list}
    FOR    ${i}   IN RANGE   ${count}
        Set Test Variable    ${title}    ${png_game_list}[${i}]
        Go To All Game Page And Search For Game     ${title} 
        Click To Play Game on All Game Page  
        ${status}    CL_GameSearch.Verify Game Can Be Linked To 3rd Party By URL    ${title}
        IF   ${status} == ${False}
            Append To List    ${not_available}    ${title}
        END
        Go To   ${ENVIRONMENT.DOMAIN.STAGING.ARES.URL}lobby
    END
    ${game_failed}    Get Length    ${not_available}
    Should Be Equal    ${game_failed}    ${0}
    Log    ${not_available}

AGP-010 Verify All PG Game can be played properly
    [Tags]    DAGP-10   inactive    DESKTOP
    CL Login
    ${not_available}    Create List
    ${count}    Get Length    ${pg_game_list}
    FOR    ${i}   IN RANGE   ${count}
        Set Test Variable    ${title}    ${pg_game_list}[${i}]
        Go To All Game Page And Search For Game     ${title}   
        Click To Play Game on All Game Page
        ${status}    CL_GameSearch.Verify Game Can Be Linked To 3rd Party By URL    ${title}
        IF   ${status} == ${False}
            Append To List    ${not_available}    ${title}
        END
        Go To   ${ENVIRONMENT.DOMAIN.STAGING.ARES.URL}lobby
    END
    ${game_failed}    Get Length    ${not_available}
    Should Be Equal    ${game_failed}    ${0}
    Log    ${not_available}

