*** Settings ***
Resource          CL_Common.robot
Resource          CL_LandingPage.robot
Resource          ../../Locators/CL/CL_Quest.robot
Variables         ../../Localize/CL/TH/CL_Quest.yaml

*** Variables ***
${ticket_amount}    10

*** Keywords ***
Verify Redirect To Daily Quest Page
    Web Verify Current Location    ${ENVIRONMENT.DOMAIN.${ar_DOMAIN}.ARES.URL}daily-quests

Verify Redirect To Loyalty Shop Page
    Web Verify Current Location    ${ENVIRONMENT.DOMAIN.${ar_DOMAIN}.ARES.URL}pig-shop

Count Game Quest
    ${game_quest_count}    Web Get Element Count    ${DQP_gamequest_card_txt}
    [Return]    ${game_quest_count}

Verify All Game Quest Contain Expected Element
    [Documentation]    Please make sure you set TEST variable ${IS_HAVE_LOGIN}
    ${game_quest_count}    Count Game Quest
    FOR    ${index}    IN RANGE    ${game_quest_count}
        Verify Page Contain Gamequest Logo    ${index}
        Verify Page Contain Gamequest Title    ${index}
        IF  ${IS_HAVE_LOGIN}!=${True}
            Verify Page Contain Gamequest Sub Title    ${index}
        END
        Verify Page Contain Gamequest Progress    ${index}
        Verify Page Contain Gamequest Reward Button    ${index}
        Verify Page Contain Gamequest Ticket Icon    ${index}
    END

Verify all game quest title is correct
    ${on_date}    WEB Get Current Date Only Date
    ${quest_title_list}    QUERY Daily Game Quest Title By On Date   ${on_date}
    ${game_quest_count}    Count Game Quest
    FOR    ${index}    IN RANGE    ${game_quest_count}
        ${number}    Convert To String    ${index}
        ${ele}    Replace String    ${DQP_gamequest_title_txt}    <number>    ${number}
        ${title}    Web Get Element Text    ${ele}
        List Should Contain Value    ${quest_title_list}    ${title}
    END

Verify all sub title quest is correct
    [Arguments]    ${is_login}=${IS_HAVE_LOGIN}
    ${on_date}    WEB Get Current Date Only Date
    ${quest_title_list}    QUERY Daily Game Quest Subtitle By On Date   ${on_date}
    ${game_quest_count}    Count Game Quest
    ${start}    Set Variable If    ${is_login}    1     0
    FOR    ${index}    IN RANGE    ${start}    ${game_quest_count}
        ${number}    Convert To String    ${index}
        ${ele}    Replace String    ${DQP_gamequest_subtitle_txt}    <number>    ${number}
        ${title}    Web Get Element Text    ${ele}
        List Should Contain Value    ${quest_title_list}    ${title}
    END

Verify All Game Quest Progress Bar Is Not Finish
    [Arguments]    ${is_login}=${IS_HAVE_LOGIN}
    ${game_quest_count}    Count Game Quest
    ${start}    Set Variable If    ${is_login}    1     0
    FOR    ${index}    IN RANGE    ${start}    ${game_quest_count}
        ${round}    Convert To String    ${index}
        ${ele}    Replace String    ${DQP_gamequest_progress_lbl}    <number>    ${round}
        Web Verify Element Text    ${ele}    ${cl_quest_localize.quest_page.game_quest_card.unfinish_progress}
    END

Verify All Game Quest Progress Bar Is Finish
    ${game_quest_count}    Count Game Quest
    FOR    ${index}    IN RANGE    ${game_quest_count}
        ${round}    Convert To String    ${index}
        ${ele}    Replace String    ${DQP_gamequest_progress_lbl}    <number>    ${round}
        Web Verify Element Text    ${ele}    ${cl_quest_localize.quest_page.game_quest_card.finish_progress}
    END

Verify Game Quest Progress Bar Is Finish
    [Arguments]    ${transaction_uid}
    ${ele}    Replace String    ${DQP_gamequest_progress_uid_lbl}    <transaction_uid>    ${transaction_uid}
    Web Verify Element Text    ${ele}    ${cl_quest_localize.quest_page.game_quest_card.finish_progress}


Verify All Game Quest Ticket Reward Amount
    ${on_date}    WEB Get Current Date Only Date
    ${quest_dict}    QUERY List Of Quest Information By on_date    ${on_date}
    FOR    ${INDEX}    IN    @{quest_dict}
        ${ele}    Replace String    ${DQP_gamequest_ticket_by_title}    <title>    ${INDEX}[quest_name]
        ${ele}    Replace String    ${ele}    <sub_title>    ${INDEX}[game_name]
        ${expect_ticket_amount}    Convert To String    ${INDEX}[reward]
        ${expect_text}    Replace String    ${cl_quest_localize.quest_page.game_quest_card.ticket_amount}    
        ...    <amount>    ${expect_ticket_amount}
        Web Verify Element Text    ${ele}    ${expect_text}
    END

Verify Game Quest Ordering
    ${api_quest_info}    GET Daily Game Quest Information    ##TODO
    ${api_length}    Get Length    ${api_info}
    FOR    ${index}    IN RANGE    ${api_length}
        ${title}    Get From Dictionary    ${api_info}[${index}]    title
        ${quest_level}    QUERY Quest Level    ${title}
        Should Be Equal As String    ${quest_level}    ${quest_ordering}[${index}]
        ${round}    Convert To String    ${inde}
        ${ele}    Replace String    ${DQP_gamequest_title_txt}    <number>    ${round}
        Web Verify Element Text    ${ele}    ${title}
    END

Verify Page Contain Gamequest Logo
    [Arguments]    ${index}
    ${index}    Convert To String    ${index}
    ${ele}    Replace String    ${DQP_gamequest_questlogo_img}    <number>    ${index}
    Web Verify Element Visible    ${ele}

Verify Page Contain Gamequest Title
    [Arguments]    ${index}
    ${index}    Convert To String    ${index}
    ${ele}    Replace String    ${DQP_gamequest_title_txt}    <number>    ${index}
    Web Verify Element Visible    ${ele}

Verify Page Contain Gamequest Sub Title
    [Arguments]    ${index}
    ${index}    Convert To String    ${index}
    ${ele}    Replace String    ${DQP_gamequest_subtitle_txt}    <number>    ${index}
    Web Verify Element Visible    ${ele}

Verify Page Contain Gamequest Progress
    [Arguments]    ${index}
    ${index}    Convert To String    ${index}
    ${ele}    Replace String    ${DQP_gamequest_progress_lbl}    <number>    ${index}
    Web Verify Element Visible    ${ele}

Verify Page Contain Gamequest Reward Button
    [Arguments]    ${index}
    ${index}    Convert To String    ${index}
    ${ele}    Replace String    ${DQP_gamequest_quest_btn}    <number>    ${index}
    Web Verify Element Visible    ${ele}

Verify Page Contain Gamequest Ticket Icon
    [Arguments]    ${index}
    ${index}    Convert To String    ${index}
    ${ele}    Replace String    ${DQP_gamequest_ticket_txt}    <number>    ${index}
    Web Verify Element Visible    ${ele}

Verify Page Contain Refresh Button
    Web Verify Element Visible    ${DQP_dailyquest_refresh_btn}

Click Game Quest Reward Button
    [Arguments]    ${quest_number}
    ${reward_btn}    Replace String    ${DQP_gamequest_quest_btn}    <number>    ${quest_number}
    WEB Click Element    ${reward_btn}

Click Reward Modal Ok Button
    WEB Click Element    ${DQP_modal_reward_ok_btn}

Verify Reward Modal Is Closed
    WEB Verify Element Not Visible    ${DQP_modal_reward_ok_btn}

Verify Reward Modal Is Show
    WEB Verify Element Visible    ${DQP_modal_reward_ok_btn}

Click Game Quest Refresh Button
    ${current_time}    GEN Get Current Local Time
    Web Click Element    ${DQP_dailyquest_refresh_btn}
    Sleep    ${TIMEOUT.${ar_DOMAIN}.SLEEP}
    [Return]    ${current_time}

Verify Title At Timer Section On Daily Quest Page
    Web Verify Element Text    ${DQP_header_title_txt}    ${cl_quest_localize.quest_page.timer.title}

Verify Subtitle At Timer Section On Daily Quest Page
    Web Verify Element Text    ${DQP_header_subtitle_txt}    ${cl_quest_localize.quest_page.timer.subtitle}

Verify Timecount At Timer Section On Daily Quest Page
    WEB Verify Element Text Using RegEx    ${DQP_header_timecountdown_txt}   ${cl_quest_localize.quest_page.timer.countdown}

Verify Hint At Timer Section On Daily Quest Page
    WEB Verify Element Text Using RegEx    ${DQP_header_timerhint_txt}    ${cl_quest_localize.quest_page.timer.hint}

Verify Ticket Icon Visible On Daily Quest Page
    Web Verify Element Visible    ${DQP_ticket_icn_img}

Verify Ticket Accumulate Amount Visible On Daily Quest Page
    Web Verify Element Visible    ${DQP_ticket_amount_txt}

Verify Ticket Description Visible On Daily Quest Page
    Web Verify Element Text    ${DQP_ticket_hint_txt}    แลกของรางวัล

Get Current Ticket
    ${current_ticket}     WEB Get Element Text    ${DQP_ticket_amount_txt}
    ${current_ticket}    Split String    ${current_ticket} 
    [Return]    ${current_ticket}[0]

Verify Current Ticket
    [Arguments]    ${expected_ticket_amount}
    ${current_ticket}    Get Current Ticket
    Should Be Equal As Numbers    ${current_ticket}    ${expected_ticket_amount}
    ...    msg=Expected ${expected_ticket_amount} ticket, get ${current_ticket}.

Verify Click Game Quest Reward Button Get Correct Ticket
    [Arguments]    ${quest_number}
    ${current_ticket}    Get Current Ticket
    ${game_card}    Replace String    ${DQP_gamequest_card_each_txt}    <number>    ${quest_number}
    ${transaction_uid}    WEB Get Element Attribute    ${game_card}    data-transaction-uid
    ${quest_dict}    QUERY Quest Information From Transaction Uid  ${transaction_uid}
    Click Game Quest Reward Button    ${quest_number}
    Verify Reward Modal Is Show
    Click Reward Modal Ok Button    
    Verify Reward Modal Is Closed
    ${expected_ticket_amount}    Evaluate   ${current_ticket}+${quest_dict}[reward]
    Verify Current Ticket    ${expected_ticket_amount}
    [Return]    ${transaction_uid}

Verify Received Game Quest Display
    [Arguments]    ${transaction_uid}
    ${game_card}    Replace String    ${DQP_gamequest_card_uid_txt}    <transaction_uid>    ${transaction_uid}
    Wait Until Keyword Succeeds    ${TIMEOUT.${ar_DOMAIN}.RETRY}    ${TIMEOUT.${ar_DOMAIN}.RETRY_INTERVAL}    WEB Verify Element Style    ${game_card}    rgba(226, 237, 230, 1)    background-color
    Wait Until Keyword Succeeds    ${TIMEOUT.${ar_DOMAIN}.RETRY}    ${TIMEOUT.${ar_DOMAIN}.RETRY_INTERVAL}    WEB Verify Element Style    ${game_card}    0.5    opacity

Verify Page Contain Mainquest Title
    WEB Verify Element Visible    ${DQP_mainquest_title_txt}

Verify Page Contain Mainquest Subtitle
    WEB Verify Element Visible    ${DQP_mainquest_subtitle_txt}
    
Verify Page Contain Mainquest Progress
    WEB Verify Element Visible    ${DQP_mainquest_progress_lbl}
    
Verify Page Contain Mainquest Reward Button
    WEB Verify Element Visible    ${DQP_mainquest_getticket_btn}
    
Verify Mainquest Progress Bar Contain Complete Text
    WEB Verify Element Text    ${DQP_mainquest_progress_txt}    ${cl_quest_localize.quest_page.mainquest.finish_progress}

Verify Mainquest Progress Bar Have Green Bar
    WEB Verify Element Style      ${DQP_mainquest_progress_lbl}    rgba(0, 128, 0, 1)    background-color

Verify Mainquest Progress Bar Have White Bar
    WEB Verify Element Style      ${DQP_mainquest_progress_lbl}    rgba(0, 128, 0, 1)    background-color

Verify Mainquest Reward Button Have Green color
    WEB Verify Element Style      ${DQP_mainquest_getticket_btn}    rgba(64, 133, 88, 1)    background-color  

Verify Mainquest Reward Button Status is Enable
    ${value}    WEB Get Element Attribute    ${DQP_mainquest_getticket_btn}    data-testid
    Should not contain    ${value}    disabled

Verify Mainquest Reward Button Is Enabled
    Verify Mainquest Reward Button Have Green Color
    Verify Mainquest Reward Button Status is Enable

Click Main Quest Reward Button
    WEB Click Element    ${DQP_mainquest_getticket_btn}

Verify Chanpiompion Section Element List
    WEB Verify Element Visible    ${DQP_champion_header}
    WEB Verify Element Visible    ${DQP_champion_page_btn}

Verify Champion Section Display Bigwin Tutorial
    WEB Verify Element Visible    ${DQP_bigwin_tutorial_card}
    WEB Verify Element Visible    ${DQP_bigwin_tutorial_btn}

Click Bigwin Tutorial Next Button
    WEB Click Element    ${DQP_bigwin_tutorial_next_btn}

Click Bigwin Tutorial Start Button
    CL Scroll To Footer
    WEB Click Element    ${DQP_bigwin_tutorial_btn}

Verify Bigwin Tutorial Function Correctly
    ${tutorial_page}    Set Variable    4
    FOR    ${PAGE}    IN RANGE    ${tutorial_page}
        ${PAGE}    Convert To String    ${PAGE}
        ${tutorial_page_ele}    Replace String    ${DQP_bigwin_tutorial_page}    <index>    ${PAGE}
        ${is_active}    WEB Get Element Attribute    ${tutorial_page_ele}    class
        Should Contain    ${is_active}    item=slick-current    ignore_case=${true}
        WEB Sleep
        Click Bigwin Tutorial Next Button
    END
    Click Bigwin Tutorial Next Button
    ${tutorial_page_ele}    Replace String    ${DQP_bigwin_tutorial_page}    <index>    1
    WEB Verify Element Not Visible    ${tutorial_page_ele}

Verify 1st Claim Bigwin TuTorial is Visible
    WEB Verify Element Visible    ${DQP_bigwin_first_calim_tutorial_section}

Click and Upload Bigwin Image
    [Arguments]    ${upload_type}    ${file_type}=png    ${bigwin_uid}=${NONE}
    [Documentation]    There are 2 upload type 1. tutorial 1st claim 2. Normal upload on Quest page
    IF    '${upload_type}'=='tutorial'
        WEB Choose File    ${DQP_bigwin_first_claim_upload_btn}    ../../TestData/${ar_PRODUCT}/${ar_ENVIRONMENT}/image/bigwin_upload_image.${file_type}
    ELSE
        ${bigwin_upload_element}    Replace String    ${DQP_bigwin_first_claim_upload_btn}    <bigwin_uid>    ${bigwin_uid}
        WEB Choose File    ${bigwin_upload_element}    ../../TestData/${ar_PRODUCT}/${ar_ENVIRONMENT}/image/bigwin_upload_image.${file_type}
    END

Verify Display All Bigwin Card
    [Arguments]    ${expected_number_of_bigwin}
    FOR    ${INDEX}    IN RANGE    ${expected_number_of_bigwin}
        ${INDEX}    Convert To String    ${INDEX}
        ${bigwin_card}    Replace String    ${DQP_bigwin_card_index}    <index>    ${INDEX}
        WEB Verify Element Visible    ${bigwin_card}
    END

Click Bigwin Claim Button
    [Arguments]    ${bigwin_index}
    ${bigwin_card_claim_button}    Replace String    ${DQP_bigwin_card_claim_btn}    <index>    ${bigwin_index}
    CL Scroll To Footer
    WEB Click Element    ${bigwin_card_claim_button}

Verify Bigwin Not Upload Element
    [Arguments]    ${bigwin_index}
    ${bigwin_card}    Replace String    ${DQP_bigwin_card_index}    <index>    ${bigwin_index}
    ${bigwin_card_claim_button}    Replace String    ${DQP_bigwin_card_upload_btn}    <index>    ${bigwin_index}
    WEB Verify Element Style    ${bigwin_card}    rgba(222, 203, 251, 1)    background-color
    WEB Verify Element Text    ${bigwin_card_claim_button}    ${cl_quest_localize.quest_page.champion.claim_btn.not_upload}

Verify Bigwin Uploaded Element
    [Arguments]    ${bigwin_index}
    ${bigwin_card}    Replace String    ${DQP_bigwin_card_index}    <index>    ${bigwin_index}
    ${bigwin_card_claim_button}    Replace String    ${DQP_bigwin_card_claim_btn}    <index>    ${bigwin_index}
    WEB Verify Element Style    ${bigwin_card}    rgba(226, 237, 230, 1)    background-color
    ${bigwin_ticket_amount}    QUERY Bigwin Ticket Amount
    ${bigwin_ticket_amount}    Convert To String    ${bigwin_ticket_amount}
    ${upload_claim_btn_txt}    Replace String    ${cl_quest_localize.quest_page.champion.claim_btn.uploaded}    <bigwin_ticket_amount>    ${bigwin_ticket_amount}
    WEB Verify Element Text    ${bigwin_card_claim_button}    ${upload_claim_btn_txt}

Click Weekly Quest Claim Button
    [Arguments]    ${index}
    ${weekly_index_claim_btn}    Replace String    ${DQP_weekly_claim_btn}    <index>    ${index}
    WEB Click Element    ${weekly_index_claim_btn}

Verify Weekly Quest Ticket Amount
    [Arguments]    ${expected_amount}    ${index}=0
    ${weekly_index_amount_btn}    Replace String    ${DQP_weekly_ticket_amount_txt}    <index>    ${index}
    ${expected_text}    Replace String    ${cl_quest_localize.quest_page.weeklyquest.ticket_amount}    <amount>    ${expected_amount}
    WEB Verify Element Text     ${weekly_index_amount_btn}    ${expected_text}

Verify Weeklyquest Title
    [Arguments]    ${expected_text}    ${index}=0
    ${weekly_index_element}    Replace String    ${DQP_weekly_title_txt}    <index>    ${index}
    WEB Verify Element Text     ${weekly_index_element}    ${expected_text}

Verify Weeklyquest Sub Title
    [Arguments]    ${expected_text}    ${index}=0
    ${weekly_index_element}    Replace String    ${DQP_weekly_subtitle_txt}    <index>    ${index}
    WEB Verify Element Text     ${weekly_index_element}    ${expected_text}