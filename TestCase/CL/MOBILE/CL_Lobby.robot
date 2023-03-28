*** Settings ***
Test Teardown     WEB Teardown common keyword
Metadata          name    Lobby
Resource          ../../../Resource/Keywords/CL/CL_Lobby.robot
Resource          ../../../Resource/Keywords/CL/CL_GameSearch.robot
Resource          ../../../Resource/Keywords/CL/CL_Promotion.robot
Resource          ../../../Resource/Keywords/CL/CL_Referral.robot
Resource          ../../../Resource/import.robot

*** Test Cases ***
LBP-001 Verify Section In Lobby Page
    [Tags]    DESKTOP    MOBILE    inactive    TABLET
    [Setup]    Setup Common Keyword For Lobby Page
    CL Login
    CL Verify Main Menu Lobby Page
    ###3 Need to check from DB Game table
    CL Verify Header Promotion Section
    CL Verify Header Recent Game Section
    #CL Verify All game vender
    #CL Verify Max RTP
    #CL Verify Min RTP
    CL Verify Header Favorite Game Section
    CL Verify Header New Game Section
    CL Verify Header Popular Game Section

LBP-002 Verify Element Recent Game
    [Tags]    MOBILE    inactive
    [Documentation]     NEEDFIX by add recent game to account
    [Setup]    Setup Common Keyword For Lobby Page
    CL Login
    CL Verify Total Recent Game Display On Lobby
    CL Get Recent Game Ids
    CL Verify Recent Game Display On Lobby

LBP-003 Verify Element Favorite Game
    [Tags]    inactive    MOBILE
    [Documentation]     NEEDFIX by add fav game to account
    [Setup]    Setup Common Keyword For Lobby Page
    CL Login
    DB Connect To Database Pigspin User
    Query Favorite Game x Latest Record
    CL Verify Total Favorite Game Display On Lobby
    CL Verify Latest Favorite Game Display On Lobby

LBP-004 Verify Element New Game
    [Tags]    inactive    MOBILE
    [Documentation]     NEEDFIX check requirement because the first is not showing
    ...                 Move DB keyword and check global vartiable
    [Setup]    Setup Common Keyword For Lobby Page
    CL Login
    DB Connect To Database Pigspin Game
    ${db_game_name}    Query New Game Name Display On Lobby
    CL Verify Latest New Game Display On Lobby    ${db_game_name}

LBP-005 Verify Element Popular Game
    [Tags]    MLBP-5   active    MOBILE
    [Setup]    Setup Common Keyword For Lobby Page
    CL Login
    DB Connect To Database Pigspin Game
    Query Popular Game Name Display On Lobby
    CL Verify Latest Popular Game Display On Lobby

LBP-006 Verify user goto all game page from menu page
    [Tags]    MLBP-6   active    MOBILE     PRODUCTION
    [Setup]    Setup Common Keyword For Lobby Page
    CL Login
    CL Click All Game Lobby Menu
    CL Verify Redirect All Game Page

LBP-007 Verify user goto quest page from menu page
    [Tags]     MLBP-7   active    MOBILE    PRODUCTION
    [Setup]    Setup Common Keyword For Lobby Page
    CL Login
    CL Click Quest Lobby Menu
    CL Verify Redirect Quest Page

LBP-008 Verify user goto champion page from menu page
    [Tags]    MLBP-8   active    MOBILE    PRODUCTION
    [Setup]    Setup Common Keyword For Lobby Page
    CL Login
    CL Click Champion Lobby Menu
    CL Verify Redirect Champion Page

LBP-009 Verify user goto item shop page from menu
    [Tags]     MLBP-9   active    MOBILE    PRODUCTION
    [Setup]    Setup Common Keyword For Lobby Page
    CL Login
    CL Click Item Shop Lobby Menu
    CL Verify Redirect Item Shop Page

LBP-010 Verify user goto recent game page
    [Tags]    inactive    DESKTOP    MOBILE    TABLET
    [Documentation]     NEEDFIX by add recent game to account
    [Setup]    Setup Common Keyword For Lobby Page
    CL Login
    CL Click All Recent Games Button
    CL Verify Game Search Recent Game Header

LBP-011 Verify user goto favorite game page
    [Tags]    inactive    MOBILE    TABLET
    [Documentation]     NEEDFIX by add recent game to account
    [Setup]    Setup Common Keyword For Lobby Page
    CL Login
    CL Click All Favorite Games Button
    CL Verify Game Search Favorite Game Header

LBP-012 Verify user goto new game page
    [Tags]    MLBP-12   active    MOBILE    PRODUCTION
    [Setup]    Setup Common Keyword For Lobby Page
    CL Login
    CL Click All New Games Button
    CL Verify Game Search New Game Header

LBP-013 Verify user goto popular game page
    [Tags]    MLBP-13   active    MOBILE    PRODUCTION
    [Setup]    Setup Common Keyword For Lobby Page
    CL Login
    CL Click All Popular Games Button
    CL Verify Game Search Popular Game Header

LBP-014 Verify user goto all game page from below page
    [Tags]    MLBP-14   active    MOBILE    PRODUCTION
    [Setup]    Setup Common Keyword For Lobby Page
    CL Login
    CL Click All Games Button
    CL Verify Game Search All Game Header

LBP-015 Verify user can favorite in recent game section
    [Tags]    inactive    MOBILE
    [Documentation]     NEEDFIX by add recent game to account
    [Setup]    Setup Keyword For Set Recent Game Favorite To    ${False}    agent
    CL Login
    CL Click Favorite All Game In Recent Game Section
    CL Verify Favorite All Game In Recent Game Section

LBP-016 Verify user can unfavorite in recent game section
    [Tags]    inactive    MOBILE
    [Documentation]     NEEDFIX by add recent game to account
    [Setup]    Setup Keyword For Set Recent Game Favorite To    ${True}    agent
    CL Login
    CL Click Unfavorite All Game In Recent Game Section
    CL Verify Unfavorite All Game In Recent Game Section

LBP-017 Verify user can favorite in new game section
    [Tags]    MLBP-17   active    MOBILE   
    [Setup]    Setup Keyword For Set New Game Favorite To    ${False}    agent
    CL Login
    CL Click Favorite All Game In New Game Section
    CL Verify Favorite All Game In New Game Section

LBP-018 Verify user can unfavorite in new game section
    [Tags]    MLBP-18   active    MOBILE
    [Setup]    Setup Keyword For Set New Game Favorite To    ${True}    agent
    CL Login
    CL Click Unfavorite All Game In New Game Section
    CL Verify Unfavorite All Game In New Game Section

LBP-019 Verify user can favorite in popular game section
    [Tags]    MLBP-19   active    MOBILE    
    [Setup]    Setup Keyword For Set Popular Game Favorite To    ${False}    agent
    CL Login
    CL Click Favorite All Game In Popular Game Section
    CL Verify Favorite All Game In Popular Game Section

LBP-020 Verify user can unfavorite in popular game section
    [Tags]    MLBP-20   active    MOBILE
    [Setup]    Setup Keyword For Set Popular Game Favorite To    ${True}    agent
    CL Login
    CL Click Unfavorite All Game In Popular Game Section
    CL Verify Unfavorite All Game In Popular Game Section

LBP-021 Verify user can go all game page from navbar menu
    [Tags]    MLBP-21   active    MOBILE    PRODUCTION
    [Setup]    Setup Common Keyword For Lobby Page
    CL Login
    CL Click All Game At Nav Bar
    CL Verify Redirect All Game Page

LBP-022 Verify user can go promotion page from navbar menu
    [Tags]    MLBP-22   active     PRODUCTION
    [Setup]    Setup Common Keyword For Lobby Page
    CL Login
    CL Click Promotion At Nav Bar
    Verify Redirect To Promotion Page

LBP-023 Verify user can go referral page from navbar menu
    [Tags]    MLBP-23   inactive    TABLET     PRODUCTION
    [Setup]    Setup Common Keyword For Lobby Page
    CL Login
    CL Click Referral At Nav Bar
    Verify Redirect To Referral Page

LBP-024 Verify user can go wallet page from navbar menu
    [Tags]    MLBP-24   inactive    TABLET    PRODUCTION
    [Setup]    Setup Common Keyword For Lobby Page
    CL Login
    CL Click Wallet At Nav Bar
    CL Verify Redirect To Cash Wallet Page

LBP-025 Verify user can go account page from navbar menu
    [Tags]    MLBP-25   inactive    PRODUCTION
    [Setup]    Setup Common Keyword For Lobby Page
    CL Login
    CL Click Pofile At Nav Bar
    CL Verify Redirect To Profile Page

LBP-026 Verify hamburger menu
    [Tags]    MLBP-26   active    MOBILE    PRODUCTION
    [Setup]    Setup Common Keyword For Lobby Page
    CL Login
    CL Click Hamburger Button From Lobby
    CL Verify Hamburger Menu

LBP-027 Verify user can go quest page from hamburger
    [Tags]    MLBP-27   active    MOBILE     PRODUCTION
    [Setup]    Setup Common Keyword For Lobby Page
    CL Login
    CL Click Daily Quest At Hamburger Menu
    CL Verify Redirect To Quest Page Page

LBP-028 Verify user can go item shop page from hamburger
    [Tags]    MLBP-28   active    MOBILE     PRODUCTION
    [Setup]    Setup Common Keyword For Lobby Page
    CL Login
    CL Click PigShop At Hamburger Menu
    CL Verify Redirect To Item Shop Page

LBP-029 Verify user can go lobby page from hamburger
    [Tags]    MLBP-29   active    MOBILE     PRODUCTION
    [Setup]    Setup Common Keyword For Lobby Page
    CL Login
    CL Click Lobby At Hamburger Menu
    CL Verify Redirect To Lobby Page Page

LBP-030 Verify user can go withdraw from hamburger
    [Tags]    MLBP-30   active    MOBILE     PRODUCTION
    [Setup]    Setup Common Keyword For Lobby Page
    CL Login
    CL Click Withdraw At Hamburger Menu
    CL Verify Redirect To Withdraw Page

LBP-031 Verify user can go to wallet page from hamburger
    [Tags]    MLBP-31   active    MOBILE     PRODUCTION
    [Setup]    Setup Common Keyword For Lobby Page
    CL Login
    CL Click Wallet At Hamburger Menu
    CL Verify Redirect To Cash Wallet Page

LOB-032 Verify user can go contact us page from hamburger
    [Tags]    MLBP-32   active    MOBILE     PRODUCTION
    [Setup]    Setup Common Keyword For Lobby Page
    CL Login
    CL Click Contact Us At Hamburger Menu
    CL Verify Redirect To Contact Us Page

LBP-033 Verify user can go faq page from hamburger
    [Tags]    MLBP-33   active    MOBILE     PRODUCTION
    [Setup]    Setup Common Keyword For Lobby Page
    CL Login
    CL Click Faq At Hamburger Menu
    CL Verify Redirect To Faq Page

LOB-034 Verify user can go article page from hamburger
    [Tags]    inactive    MOBILE    PRODUCTION
    [Documentation]    PROD only
    [Setup]    Setup Common Keyword For Lobby Page
    CL Login
    CL Click Article At Hamburger Menu
    CL Verify Redirect To Article

LBP-035 Verify user can go account setting page from hamburger
    [Tags]    MLBP-35   active    MOBILE     PRODUCTION
    [Setup]    Setup Common Keyword For Lobby Page
    CL Login
    CL Click Profile At Hamburger Menu
    CL Verify Redirect To Profile Page

LBP-036 Verify user can logout from hamburger
    [Tags]    MLBP-36   active    MOBILE     PRODUCTION
    [Setup]    Setup Common Keyword For Lobby Page
    CL Login
    CL Click Logout At Hamburger Menu
    CL Verify Redirect To Logout

LBP-037 Verify user can go promotion page from hamburger mobile
    [Tags]    MLBP-37   active    MOBILE     PRODUCTION
    [Setup]    Setup Common Keyword For Lobby Page
    CL Login
    CL Click Promotion At Hamburger Menu
    Verify Redirect To Promotion Page

LBP-038 Verify user can go referral page from hamburger mobile
    [Tags]    MLBP-038   active    MOBILE     PRODUCTION
    [Setup]    Setup Common Keyword For Lobby Page
    CL Login
    CL Click Referral At Hamburger Menu
    Verify Redirect To Referral Page

LBP-039 Verify user can go all game page from hamburger mobile
    [Tags]    MLBP-39   active    MOBILE     PRODUCTION
    [Setup]    Setup Common Keyword For Lobby Page
    CL Login
    CL Click All Game At Hamburger Menu
    CL Verify Redirect All Game Page

LBP-040 Verify user can go deposit page from hamburger mobile
    [Tags]    MLBP-40   active    MOBILE     PRODUCTION
    [Setup]    Setup Common Keyword For Lobby Page
    CL Login
    CL Click Deposit At Hamburger Menu
    CL Verify Redirect To Cash Wallet Page

LBP-041 Verify amount of cards displayed under "เกมกำลังแจก" should be equal to 10
    [Documentation]   The cards are displaying top 10 rank of Max RTP ratio from high to low
    [Tags]    MLBP-41   active    MOBILE
    [Setup]    Setup Common Keyword For Lobby Page
    CL Login
    CL Verify RTP Win Bonus Header
    CL Verify there should be 10 cards are displayed    ${LBP_max_rtp_card}
    CL Verify RTP should not be equal to zero    ${LBP_max_rtp_card}    ${LBP_games_max_rtp_ratio}

LBP-042 Verify amount of cards displayed under "เกมใกล้แจก" should be equal to 10
    [Documentation]   The cards are displaying top 10 rank of Min RTP ratio from low to high
    [Tags]    MLBP-42   active    MOBILE
    [Setup]    Setup Common Keyword For Lobby Page
    CL Login
    CL Verify RTP Nearly Win Bonus Header
    CL Verify there should be 10 cards are displayed    ${LBP_min_rtp_card}
    CL Verify RTP should not be equal to zero    ${LBP_min_rtp_card}    ${LBP_games_min_rtp_ratio}

LBP-043 Verify PG game company page should be displayed properly
    [Tags]   MLBP-43   active    MOBILE
    [Setup]    Setup Common Keyword For Lobby Page
    CL Login
    CL Go to PG game company page
    Verify element sorting dropdown should be displayed properly
    Verify sorting by RTP min to max should work correctly

LBP-044 Verify EVO game company page should be displayed properly
    [Tags]   MLBP-44   active    MOBILE
    [Setup]    Setup Common Keyword For Lobby Page
    CL Login
    CL Go to EVO game company page
    Verify element sorting dropdown should be displayed properly
    Verify sorting by RTP max to min should work correctly

LBP-045 Verify Joker game company page should be displayed properly
    [Tags]   MLBP-45   active    MOBILE
    [Setup]    Setup Common Keyword For Lobby Page
    CL Login
    CL Go to Joker game company page
    Verify element sorting dropdown should be displayed properly
    Verify sorting by game old to new should work correctly

LBP-046 Verify PNG game company page should be displayed properly
    [Tags]   MLBP-46   active    MOBILE
    [Setup]    Setup Common Keyword For Lobby Page
    CL Login
    CL Go to PNG game company page
    Verify element sorting dropdown should be displayed properly
    Verify sorting by game old to new should work correctly

GAME-011 Verify "เกมกำลังแจก" section have auto-refresh
    [Tags]   MGAME-11   active    MOBILE
    [Setup]    Set Up Common Keyword For Lobby Page
    CL Login
    ${title}    Get Top Max RTP Titile
    ${before_rtp}   Get Top Max RTP rtp
    ${before_rtp}   remove String  ${before_rtp}   %
    ${expect_rtp}    Evaluate    ${before_rtp}+1000
    UPDATE Game Actual RTP by Game name    ${title}    ${expect_rtp}
    Verify Max RTP is auto refresh    ${expect_rtp}

GAME-012 Verify "เกมใกล้แจก" section have auto-refresh
    [Tags]   MGAME-12   active    MOBILE
    [Setup]    Set Up Common Keyword For Lobby Page
    CL Login
    ${title}    Get Top Min RTP Titile
    UPDATE Game Actual RTP by Game name    ${title}    1
    Verify Min RTP is auto refresh    1

*** Keywords ***
Set Up Common Keyword For Lobby Page
    [Arguments]    ${user_type}=common    ${common_type}=normal
    CL Setup Test User    ${user_type}    ${common_type}
    CL Open Pigspin Website

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
