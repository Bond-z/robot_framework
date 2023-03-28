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
CAGP-001 Verify search result when search by full game name
    [Tags]   MCAGP-1    active    MOBILE
    Set Selenium Speed    0.5s
    Set Test Variable   ${game_name}    Double Ball Roulette
    Login CASINO website
    Go To Pigbet All Game Page And Search For Game     ${game_name}
    Verify search result should be found by name    ${game_name}

CAGP-002 Verify search result when search by some part of game name
    [Tags]   MCAGP-2    active    MOBILE
    Login CASINO website
    Set Test Variable   ${game_name}    jack
    Go To Pigbet All Game Page And Search For Game     ${game_name}
    Verify search result should contains    ${game_name}

CAGP-003 Verify search result when filtering by dealer
    [Tags]   MCAGP-3    active    MOBILE
    Set Selenium Speed    0.5s
    Login CASINO website
    Set Test Variable   ${dealer}    ต่างชาติ
    # Verify first five game companies    ${company_name}

CAGP-004 Verify search result when filtering by game type baccarat
    [Tags]   MCAGP-4    active    MOBILE
    Login CASINO website
    Verify search result when filter by slot game

CAGP-005 Verify search result when filtering by rulet
    [Tags]   MCAGP-5    active    MOBILE
    Login CASINO website   
    CL Click Favorite In Popular Game Section    3
    WEB Sleep
    ${total_favorite}   Get total of favorite game in Lobby page
    Verify filter by favorite game should be displayed correctly     ${total_favorite}

CAGP-006 Verify sorting can be recognized the latest sorting
    [Tags]   MCAGP-6    active    MOBILE
    Login CASINO website
    Go To All Game Page
    Select sorting by CL RTP max - min
    Go to Lobby page
    Go To All Game Page
    Verify sorting can be recognized the latest sorting

CAGP-007 Verify All Joker Game can be played properly
    [Tags]    MCAGP-7   active    MOBILE
    ${not_available}    Create List
    Login CASINO website
    ${count}    Get Length    ${joker_game_list}
    FOR    ${i}   IN RANGE   ${count}
        Set Test Variable    ${title}    ${joker_game_list}[${i}]
        Go To Pigbet All Game Page And Search For Game     ${title} 
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

CAGP-008 Verify All EVO Game can be played properly
    [Tags]    MCAGP-8   active    MOBILE
    ${not_available}    Create List
    Login CASINO website
    ${count}    Get Length    ${evo_game_list}
    FOR    ${i}   IN RANGE   ${count}
        Set Test Variable    ${title}    ${evo_game_list}[${i}]
        Go To Pigbet All Game Page And Search For Game     ${title}   
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

CAGP-009 Verify All PNG Game can be played properly
    [Tags]    MCAGP-9   active    MOBILE
    Login CASINO website
    ${not_available}    Create List
    ${count}    Get Length    ${png_game_list}
    FOR    ${i}   IN RANGE   ${count}
        Set Test Variable    ${title}    ${png_game_list}[${i}]
        Go To Pigbet All Game Page And Search For Game     ${title} 
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

CAGP-010 Verify All PG Game can be played properly
    [Tags]    MCAGP-10   inactive    MOBILE
    Login CASINO website
    ${not_available}    Create List
    ${count}    Get Length    ${pg_game_list}
    FOR    ${i}   IN RANGE   ${count}
        Set Test Variable    ${title}    ${pg_game_list}[${i}]
        Go To Pigbet All Game Page And Search For Game     ${title}   
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

