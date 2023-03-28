*** Settings ***
Metadata          name    Quest
Test Teardown     WEB Teardown common keyword
Resource          ../../../Resource/Keywords/CL/CL_Quest.robot

*** Test Cases ***
DQP-021 Verify all game quests element
    [Documentation]    Implementer: Fluke
    [Tags]    MDQP-21   active    MOBILE    PRODUCTION
    [Setup]    Set Up To Open Browser And Quest Progress    common    common_type=normal
    CL Login
    CL Click Daily Quest At Hamburger Menu
    Verify All Game Quest Contain Expected Element

DQP-022 Verify all game quest title is correct and match with expected(from document)
    [Documentation]    Implementer: Fluke
    [Tags]    MDQP-22    active    MOBILE     PRODUCTION
    [Setup]    Set Up To Open Browser And Quest Progress     common    common_type=normal
    CL Login
    CL Click Daily Quest At Hamburger Menu
    Verify All Game Quest Title Is Correct

DQP-23 Verify game quest subtitle should be game name
    [Documentation]    Implementer: Fluke
    [Tags]    MDQP-23    active    MOBILE     PRODUCTION
    [Setup]    Set Up To Open Browser And Quest Progress    common    common_type=normal
    CL Login
    CL Click Daily Quest At Hamburger Menu
    Verify All Sub Title Quest Is Correct

DQP-26 Verify game quest progress bar when user have 0 progress
    [Documentation]    Implementer: Fluke
    [Tags]    MDQP-26    active    MOBILE
    [Setup]    Set Up To Open Browser And Quest Progress    agent
    CL Login
    CL Click Daily Quest At Hamburger Menu
    Verify All Game Quest Progress Bar Is Not Finish

DQP-029 Verfiy game quest reward amount
    [Documentation]    Implementer: Fluke
    ...    Need fix to handle the bottom nav bar scrooling
    [Tags]    MDQP-29    inactive    MOBILE
    [Setup]    Set Up To Open Browser And Quest Progress    agent
    CL Login
    CL Click Daily Quest At Hamburger Menu
    Verify All Game Quest Ticket Reward Amount

DQP-035 Verify daily game quest ordering
    [Documentation]    Implementer: Fluke
    ...    Re-check quest ordering assertion keyword
    [Tags]    MDQP-35    inactive    MOBILE
    [Setup]    Set Up To Open Browser And Quest Progress    common    common_type=normal
    CL Login
    CL Click Daily Quest At Hamburger Menu
    Verify Game Quest Ordering    ##Need recheck

DQP-036 Verify daily quest page should have refresh button
    [Documentation]    Implementer: Fluke
    [Tags]    MDQP-36    active     MOBILE    PRODUCTION
    [Setup]    Set Up To Open Browser And Quest Progress    common    common_type=normal
    CL Login
    CL Click Daily Quest At Hamburger Menu
    Verify Page Contain Refresh Button

DQP-037 Verify page updated when user click refresh button
    [Documentation]    Implementer: Fluke
    [Tags]    MDQP-37    active    MOBILE
    [Setup]    Set Up To Open Browser And Quest Progress    agent
    CL Login
    CL Click Daily Quest At Hamburger Menu
    ${current_date}    WEB Get Current Date Only Date
    INSERT Quest Transaction And Set Up All Status    ${current_date}    status=1
    ${refresh_time}    Click Game Quest Refresh Button
    Verify All Game Quest Progress Bar Is Finish

DQP-041 Verify main menu list element
    [Documentation]    Implementer: Fluke
    [Tags]    MDQP-41    active    MOBILE     PRODUCTION
    [Setup]    Set Up To Open Browser And Quest Progress    common    common_type=normal
    CL Login
    Verify All Game Menu Visible On Main Menu
    Verify Champion Menu Visible On Main Menu
    Verify Daily Quest Menu Visible On Main Menu
    Verify Loyalty Shop Menu Visible On Main Menu

DQP-042 Verify when user click see all game button on main menu list
    [Documentation]    Implementer: Now
    [Tags]    MDQP-42    main_menu    active    MOBILE 
    [Setup]    Set Up To Open Browser And Quest Progress    common    common_type=normal
    CL Login
    Click All Game Menu On Main Menu
    Verify Redirect To All Game Page
    WEB Capture Verify Point    Verify effect after click see all game

DQP-043 Verify when user click champion button on main menu list
    [Documentation]    Implementer: Fluke
    [Tags]    MDQP-43    main_menu    active    MOBILE
    [Setup]    Set Up To Open Browser And Quest Progress    common    common_type=normal
    CL Login
    Verify Champion Menu Visible On Main Menu
    Click Champion Menu On Main Menu
    Verify Redirect To Champion Page

DQP-044 Verify when user click daily quest button on loyalty menu list
    [Documentation]    Implementer: Fluke
    [Tags]    MDQP-44    main_menu    active    MOBILE
    [Setup]    Set Up To Open Browser And Quest Progress    common    common_type=normal
    CL Login
    Verify Daily Quest Menu Visible On Main Menu
    Click Daily Quest Menu On Main Menu
    Verify Redirect To Daily Quest Page

DQP-045 Verify when user click loyalty shop button on loyalty menu list
    [Documentation]    Implementer: Fluke
    [Tags]    MDQP-45    main_menu    active    MOBILE
    [Setup]    Set Up To Open Browser And Quest Progress    common    common_type=normal
    CL Login
    Verify Loyalty Shop Menu Visible On Main Menu
    Click Loyalty Shop Menu On Main Menu
    Verify Redirect To Loyalty Shop Page

DQP-046 Verify hamburger bar should contain daily quest button
    [Documentation]    Implementer: Fluke
    [Tags]    MDQP-46    active    hamburger    MOBILE     PRODUCTION
    [Setup]    Set Up To Open Browser And Quest Progress    common    common_type=normal
    CL Login
    CL Click Hamburger Button From Lobby
    Verify Daily Quest Menu Visible On Hamburger Menu

DQP-047 Verify when user click daily quest button from hamburger bar
    [Documentation]    Implementer: Fluke
    [Tags]    MDQP-47    active    hamburger    MOBILE     PRODUCTION
    [Setup]    Set Up To Open Browser And Quest Progress    common    common_type=normal
    CL Login
    CL Click Daily Quest At Hamburger Menu
    Verify Redirect To Daily Quest Page

DQP-050 Verify game quest progress bar when user is finish progress but not receive reward yet
    [Documentation]    Implementer: Fluke
    [Tags]    MDQP-50   active    MOBILE
    [Setup]    Set Up To Open Browser And Quest Progress    agent    1
    CL Login
    CL Click Daily Quest At Hamburger Menu
    Verify All Game Quest Progress Bar Is Finish

DQP-053 Verify user click reward button when quest progress is finish
    [Documentation]    Implementer: Fluke
    ...    need data-testid  FE เซ็ท transaction-uid ของแต่ละ card ผิด
    [Tags]    MDQP-53    inactive    MOBILE
    [Setup]    Set Up To Open Browser And Quest Progress    agent    1
    CL Login
    CL Click Daily Quest At Hamburger Menu
    ${transaction_uid}    Verify Click Game Quest Reward Button Get Correct Ticket    0
    Verify Received Game Quest Display    ${transaction_uid}

DQP-055 Verify daily quest page contain main quest
    [Documentation]    Implementer: Fluke
    [Tags]    MDQP-55    active    MOBILE     PRODUCTION
    [Setup]    Set Up To Open Browser And Quest Progress    common    common_type=normal
    CL Login
    CL Click Daily Quest At Hamburger Menu
    Verify Page Contain Mainquest Title
    Verify Page Contain Mainquest Subtitle
    Verify Page Contain Mainquest Progress
    Verify Page Contain Mainquest Reward Button

DQP-058 Verify main quest progress bar when user finish all quest
    [Documentation]    Implementer: Fluke
    [Tags]    MDQP-58    active    MOBILE
    [Setup]    Set Up To Open Browser And Quest Reward Received    agent
    CL Login
    CL Click Daily Quest At Hamburger Menu
    Verify Mainquest Progress Bar Contain Complete Text
    Verify Mainquest Progress Bar Have Green Bar
    
DQP-059 Verify main quest reward button when user finish all quest
    [Documentation]    Implementer: Fluke
    [Tags]    MDQP-59   active    MOBILE
    [Setup]    Set Up To Open Browser And Quest Reward Received    agent
    CL Login
    CL Click Daily Quest At Hamburger Menu
    Verify Mainquest Reward Button Is Enabled
    
DQP-062 Verify when user click reward button after finish all quest
    [Documentation]    Implementer: Fluke
    ...    NEEFIX check current tickets something
    [Tags]    MDQP-62    inactive    MOBILE
    [Setup]    Set Up To Open Browser And Quest Reward Received    agent
    CL Login
    CL Click Daily Quest At Hamburger Menu
    ${current_ticket}    Get Current Ticket
    Click Main Quest Reward Button
    Click Reward Modal Ok Button
    Verify Reward Modal Is Closed
    ${mainquest_amount}    QUERY Mainquest Ticket Amount
    ${expected_ticket_amount}    Evaluate   ${current_ticket}+${mainquest_amount}
    Wait Until Keyword Succeeds    ${TIMEOUT.${ar_DOMAIN}.RETRY}    ${TIMEOUT.${ar_DOMAIN}.RETRY_INTERVAL}    Verify Current Ticket    ${expected_ticket_amount}
    Verify Mainquest Progress Bar Have White Bar

DQP-147 Verify hamburger bar should contain loyalty shop button
    [Documentation]    Implementer: Fluke
    [Tags]    MDQP-147    active    MOBILE    PRODUCTION
    [Setup]    Set Up To Open Browser And Quest Progress    common    common_type=normal
    CL Login
    CL Click Hamburger Button From Lobby
    Verify Loyalty Shop Menu Visible On Hamburger Menu

DQP-128 Verify when user do not have big win
    [Documentation]    Implementer: Fluke
    [Tags]    MDQP-128    active    MOBILE
    [Setup]   Set Up To Open Browser And Set up Complete Bigwin    agent    is_complete_1st_bigwin=${True}
    CL Login
    CL Click Daily Quest At Hamburger Menu
    Verify Chanpiompion Section Element List
    Verify Champion Section Display Bigwin Tutorial
    Click Bigwin Tutorial Start Button
    Verify Bigwin Tutorial Function Correctly

DQP-129 Verify when user have 1st bigwin
    [Documentation]    Implementer: Fluke
    [Tags]    MDQP-129    active    MOBILE
    [Setup]   Set Up To Open Browser And Set up Complete Bigwin    agent    is_complete_1st_bigwin=${False}
    INSERT Bigwin Transaction    ${TEST_USER.username}    ${TEST_USER.phone.uncensor}    is_upload=${False}    is_cliam=${False}
    CL Login
    CL Click Daily Quest At Hamburger Menu
    Verify 1st Claim Bigwin TuTorial is Visible

DQP-193 Verify bigwin section when user have multiple bigwin
    [Documentation]    Implementer: Fluke
    [Tags]    MDQP-193    active    MOBILE
    [Setup]   Set Up To Open Browser And Set up Complete Bigwin    agent    is_complete_1st_bigwin=${True}
    ${number_of_bigwin}    Set Variable    3
    ${bigwin_list}    Create List
    FOR    ${bigwin_index}    IN RANGE    ${number_of_bigwin}
        ${bigwin_uid}    INSERT Bigwin Transaction    ${TEST_USER.username}    ${TEST_USER.phone.uncensor}    is_upload=${False}    is_cliam=${False}
        Append to List    ${bigwin_list}    ${bigwin_uid}
    END
    CL Login
    CL Click Daily Quest At Hamburger Menu
    Verify Display All Bigwin Card    ${number_of_bigwin}


DQP-194 Verify when user click claim bigwin ticket
    [Documentation]    Implementer: Fluke
    [Tags]    MDQP-194    active    MOBILE
    [Setup]   Set Up To Open Browser And Set up Complete Bigwin    agent    is_complete_1st_bigwin=${True}
    INSERT Bigwin Transaction    ${TEST_USER.username}    ${TEST_USER.phone.uncensor}    is_upload=${True}    is_cliam=${False}
    CL Login
    CL Click Daily Quest At Hamburger Menu
    Click Bigwin Claim Button    0
    Click Reward Modal Ok Button

DQP-099 Verify Bigwin card when user is not uploaded image
    [Documentation]    Implementer: Fluke
    [Tags]    MDQP-99    active    MOBILE
    [Setup]   Set Up To Open Browser And Set up Complete Bigwin    agent    is_complete_1st_bigwin=${True}
    INSERT Bigwin Transaction    ${TEST_USER.username}    ${TEST_USER.phone.uncensor}    is_upload=${False}    is_cliam=${False}
    CL Login
    CL Click Daily Quest At Hamburger Menu
    Verify Bigwin Not Upload Element    0

DQP-098 Verify Bigwin card when user is uploaded image
    [Documentation]    Implementer: Fluke
    [Tags]    MDQP-98    active    MOBILE
    [Setup]   Set Up To Open Browser And Set up Complete Bigwin    agent    is_complete_1st_bigwin=${True}
    INSERT Bigwin Transaction    ${TEST_USER.username}    ${TEST_USER.phone.uncensor}    is_upload=${True}    is_cliam=${False}
    CL Login
    CL Click Daily Quest At Hamburger Menu
    Verify Bigwin Uploaded Element    0

DQP-158 Verify user click claim button when quest progress is finish
    [Documentation]    Implementer: Fluke
    [Tags]    MDQP-158    active    MOBILE
    [Setup]   Set Up To Open Browser And Prepare weekly quest transaction    agent
    INSERT Weekly quest Transaction    ${TEST_USER.username}    ${TEST_USER.phone.uncensor}    is_cliam=${false}
    CL Login
    CL Click Daily Quest At Hamburger Menu
    CL Scroll To Footer
    Click Weekly Quest Claim Button    0
    Click Reward Modal Ok Button

DQP-160 Verify the weekly quest ticket claim amount
    [Documentation]    Implementer: Fluke
    [Tags]    MDQP-160    active    MOBILE    PRODUCTION
    [Setup]   Set Up To Open Browser And Prepare weekly quest transaction    common
    ${weeklyquest_ticket_amount}    QUERY weekly quest ticket amount
    CL Login
    CL Click Daily Quest At Hamburger Menu
    Verify Weekly Quest Ticket Amount    ${weeklyquest_ticket_amount}[0]    0

DQP-163 Verify every user weekly quest
    [Documentation]    Implementer: Fluke
    [Tags]    MDQP-163    active    MOBILE    PRODUCTION
    [Setup]   Set Up To Open Browser And Prepare weekly quest transaction    common
    ${weeklyquest_random}    QUERY Weekly quest random    is_latest=${true}
    ${quest_info}    QUERY Weeklyquest Quest Information    ${weeklyquest_random}[1]
    CL Login
    CL Click Daily Quest At Hamburger Menu
    Verify Weeklyquest Title    ${quest_info}[quest_name]
    Verify Weeklyquest Sub Title    ${quest_info}[game_name]

*** Keywords ***
Set Up To Open Browser And Quest Progress
    [Arguments]    ${user_type}    ${status}=0    ${receive}=${False}    ${common_type}=normal
    [Documentation]    user_type is to set up test user whether editable or DB insert/update or not
    ...                [common] for not edit, not DB insert or update, and need to input [common_type] by normal, lock, ban, or etc
    ...                [agent] for edit, or DB insert or update. This argument is going to select user from ar_USER_SET
    CL Setup Test User    ${user_type}    ${common_type}
    ${current_date}    WEB Get Current Date Only Date
    ${is_login}     QUERY Any Login Quest From on_date     ${current_date}
    Set Test Variable    ${IS_HAVE_LOGIN}    ${is_login}
    IF    '${user_type}'=='agent'
        INSERT Quest Transaction And Set Up All Status    ${current_date}    receive=${receive}    status=${status}
    END
    IF    ${receive}
        DELETE Quest Complete Receive    ${current_date}
    END
    CL Open Pigspin Website

Set Up To Open Browser And Quest Reward Received
    [Arguments]    ${user_type}
    CL Setup Test User    ${user_type}
    ${current_date}    WEB Get Current Date Only Date
    INSERT Quest Transaction And Set Up All Status Include Login Quest    ${current_date}    receive=${True}    status=1  
    DELETE Quest Complete Receive    ${current_date}
    CL Open Pigspin Website

Set Up To Open Browser And Set up Complete Bigwin
    [Arguments]    ${user_type}    ${is_complete_1st_bigwin}=${True}
    CL Setup Test User    ${user_type}
    DELETE All Bigwin Transaction    ${TEST_USER.username}
    IF    ${is_complete_1st_bigwin}
        INSERT Bigwin Transaction    ${TEST_USER.username}    ${TEST_USER.phone.uncensor}    is_upload=${True}    is_cliam=${True}
    END
    CL Open Pigspin Website

Set Up To Open Browser And Prepare weekly quest transaction
    [Arguments]    ${user_type}    ${common_type}=normal
    CL Setup Test User    ${user_type}    ${common_type}
    IF    '${user_type}'=='agent'
        DELETE All Weeklky Transaction    ${TEST_USER.username}
    END
    CL Open Pigspin Website