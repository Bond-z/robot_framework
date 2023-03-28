*** Settings ***
Test Teardown     WEB Teardown common keyword
Metadata          name    Lobby_Casino
Resource          ${CURDIR}/../../../Resource/import.robot

*** Test Cases ***
CLB-001 Verify Section In Landing Page
    [Tags]    MCLB-1    MOBILE    active
    [Setup]   Set Up Common Keyword For Lobby Page
    Set Selenium Speed    0.5
    Verify All Section On Landing Page Should Be Displayed Properly

CLB-002 Verify Element Recent Game
    [Tags]    MCLB-1    MOBILE    active
    [Documentation]     NEEDFIX by add recent game to account
    [Setup]    Setup Common Keyword For Lobby Page
    CL Login
    CL Verify Total Recent Game Display On Lobby
    CL Get Recent Game Ids
    CL Verify Recent Game Display On Lobby

CLB-003 Verify Element Favorite Game
    [Tags]    inactive    MOBILE
    [Documentation]     NEEDFIX by add fav game to account
    [Setup]    Setup Common Keyword For Lobby Page
    CL Login
    DB Connect To Database Pigspin User
    Query Favorite Game x Latest Record
    CL Verify Total Favorite Game Display On Lobby
    CL Verify Latest Favorite Game Display On Lobby

CLB-004 Verify Element New Game
    [Tags]    inactive    MOBILE
    [Documentation]     NEEDFIX check requirement because the first is not showing
    ...                 Move DB keyword and check global vartiable
    [Setup]    Setup Common Keyword For Lobby Page
    CL Login
    DB Connect To Database Pigspin Game
    ${db_game_name}    Query New Game Name Display On Lobby
    CL Verify Latest New Game Display On Lobby    ${db_game_name}

CLB-005 Verify Element Popular Game
    [Tags]    MCLB-5   active    MOBILE
    [Setup]    Setup Common Keyword For Lobby Page
    CL Login
    DB Connect To Database Pigspin Game
    Query Popular Game Name Display On Lobby
    CL Verify Latest Popular Game Display On Lobby

CLB-006 Verify user goto all game page from menu page
    [Tags]    MCLB-6   active    MOBILE     PRODUCTION
    [Setup]    Setup Common Keyword For Lobby Page
    CL Login
    CL Click All Game Lobby Menu
    CL Verify Redirect All Game Page

CLB-007 Verify user goto quest page from menu page
    [Tags]     MCLB-7   active    MOBILE    PRODUCTION
    [Setup]    Setup Common Keyword For Lobby Page
    CL Login
    CL Click Quest Lobby Menu
    CL Verify Redirect Quest Page

CLB-008 Verify user goto champion page from menu page
    [Tags]    MCLB-8   active    MOBILE    PRODUCTION
    [Setup]    Setup Common Keyword For Lobby Page
    CL Login
    CL Click Champion Lobby Menu
    CL Verify Redirect Champion Page

CLB-009 Verify user goto item shop page from menu
    [Tags]     MCLB-9   active    MOBILE    PRODUCTION
    [Setup]    Setup Common Keyword For Lobby Page
    CL Login
    CL Click Item Shop Lobby Menu
    CL Verify Redirect Item Shop Page

CLB-010 Verify user goto recent game page
    [Tags]    inactive    DESKTOP    MOBILE    TABLET
    [Documentation]     NEEDFIX by add recent game to account
    [Setup]    Setup Common Keyword For Lobby Page
    CL Login
    CL Click All Recent Games Button
    CL Verify Game Search Recent Game Header

CLB-011 Verify user goto favorite game page
    [Tags]    inactive    MOBILE    TABLET
    [Documentation]     NEEDFIX by add recent game to account
    [Setup]    Setup Common Keyword For Lobby Page
    CL Login
    CL Click All Favorite Games Button
    CL Verify Game Search Favorite Game Header

CLB-012 Verify user goto new game page
    [Tags]    MCLB-12   active    MOBILE    PRODUCTION
    [Setup]    Setup Common Keyword For Lobby Page
    CL Login
    CL Click All New Games Button
    CL Verify Game Search New Game Header

CLB-013 Verify user goto popular game page
    [Tags]    MCLB-13   active    MOBILE    PRODUCTION
    [Setup]    Setup Common Keyword For Lobby Page
    CL Login
    CL Click All Popular Games Button
    CL Verify Game Search Popular Game Header

CLB-014 Verify user goto all game page from below page
    [Tags]    MCLB-14   active    MOBILE    PRODUCTION
    [Setup]    Setup Common Keyword For Lobby Page
    CL Login
    CL Click All Games Button
    CL Verify Game Search All Game Header

CLB-015 Verify user can favorite in recent game section
    [Tags]    inactive    MOBILE
    [Documentation]     NEEDFIX by add recent game to account
    [Setup]    Setup Keyword For Set Recent Game Favorite To    ${False}    agent
    CL Login
    CL Click Favorite All Game In Recent Game Section
    CL Verify Favorite All Game In Recent Game Section

CLB-016 Verify user can unfavorite in recent game section
    [Tags]    inactive    MOBILE
    [Documentation]     NEEDFIX by add recent game to account
    [Setup]    Setup Keyword For Set Recent Game Favorite To    ${True}    agent
    CL Login
    CL Click Unfavorite All Game In Recent Game Section
    CL Verify Unfavorite All Game In Recent Game Section

CLB-017 Verify user can favorite in new game section
    [Tags]    MCLB-17   active    MOBILE   
    [Setup]    Setup Keyword For Set New Game Favorite To    ${False}    agent
    CL Login
    CL Click Favorite All Game In New Game Section
    CL Verify Favorite All Game In New Game Section

CLB-018 Verify user can unfavorite in new game section
    [Tags]    MCLB-18   active    MOBILE
    [Setup]    Setup Keyword For Set New Game Favorite To    ${True}    agent
    CL Login
    CL Click Unfavorite All Game In New Game Section
    CL Verify Unfavorite All Game In New Game Section

CLB-019 Verify user can favorite in popular game section
    [Tags]    MCLB-19   active    MOBILE    
    [Setup]    Setup Keyword For Set Popular Game Favorite To    ${False}    agent
    CL Login
    CL Click Favorite All Game In Popular Game Section
    CL Verify Favorite All Game In Popular Game Section

CLB-020 Verify user can unfavorite in popular game section
    [Tags]    MCLB-20   active    MOBILE
    [Setup]    Setup Keyword For Set Popular Game Favorite To    ${True}    agent
    CL Login
    CL Click Unfavorite All Game In Popular Game Section
    CL Verify Unfavorite All Game In Popular Game Section

CLB-021 Verify user can go all game page from navbar menu
    [Tags]    MCLB-21   active    MOBILE    PRODUCTION
    [Setup]    Setup Common Keyword For Lobby Page
    CL Login
    CL Click All Game At Nav Bar
    CL Verify Redirect All Game Page

CLB-022 Verify user can go promotion page from navbar menu
    [Tags]    MCLB-22   active     PRODUCTION
    [Setup]    Setup Common Keyword For Lobby Page
    CL Login
    CL Click Promotion At Nav Bar
    Verify Redirect To Promotion Page

CLB-023 Verify user can go referral page from navbar menu
    [Tags]    MCLB-23   inactive    TABLET     PRODUCTION
    [Setup]    Setup Common Keyword For Lobby Page
    CL Login
    CL Click Referral At Nav Bar
    Verify Redirect To Referral Page

CLB-024 Verify user can go wallet page from navbar menu
    [Tags]    MCLB-24   inactive    TABLET    PRODUCTION
    [Setup]    Setup Common Keyword For Lobby Page
    CL Login
    CL Click Wallet At Nav Bar
    CL Verify Redirect To Cash Wallet Page

CLB-025 Verify user can go account page from navbar menu
    [Tags]    MCLB-25   inactive    PRODUCTION
    [Setup]    Setup Common Keyword For Lobby Page
    CL Login
    CL Click Pofile At Nav Bar
    CL Verify Redirect To Profile Page

CLB-026 Verify hamburger menu
    [Tags]    MCLB-26   active    MOBILE    PRODUCTION
    [Setup]    Setup Common Keyword For Lobby Page
    CL Login
    CL Click Hamburger Button From Lobby
    CL Verify Hamburger Menu

CLB-027 Verify user can go quest page from hamburger
    [Tags]    MCLB-27   active    MOBILE     PRODUCTION
    [Setup]    Setup Common Keyword For Lobby Page
    CL Login
    CL Click Daily Quest At Hamburger Menu
    CL Verify Redirect To Quest Page Page

CLB-028 Verify user can go item shop page from hamburger
    [Tags]    MCLB-28   active    MOBILE     PRODUCTION
    [Setup]    Setup Common Keyword For Lobby Page
    CL Login
    CL Click PigShop At Hamburger Menu
    CL Verify Redirect To Item Shop Page

CLB-029 Verify user can go lobby page from hamburger
    [Tags]    MCLB-29   active    MOBILE     PRODUCTION
    [Setup]    Setup Common Keyword For Lobby Page
    CL Login
    CL Click Lobby At Hamburger Menu
    CL Verify Redirect To Lobby Page Page

CLB-030 Verify user can go withdraw from hamburger
    [Tags]    MCLB-30   active    MOBILE     PRODUCTION
    [Setup]    Setup Common Keyword For Lobby Page
    CL Login
    CL Click Withdraw At Hamburger Menu
    CL Verify Redirect To Withdraw Page

CLB-031 Verify user can go to wallet page from hamburger
    [Tags]    MCLB-31   active    MOBILE     PRODUCTION
    [Setup]    Setup Common Keyword For Lobby Page
    CL Login
    CL Click Wallet At Hamburger Menu
    CL Verify Redirect To Cash Wallet Page

LOB-032 Verify user can go contact us page from hamburger
    [Tags]    MCLB-32   active    MOBILE     PRODUCTION
    [Setup]    Setup Common Keyword For Lobby Page
    CL Login
    CL Click Contact Us At Hamburger Menu
    CL Verify Redirect To Contact Us Page

CLB-033 Verify user can go faq page from hamburger
    [Tags]    MCLB-33   active    MOBILE     PRODUCTION
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

CLB-035 Verify user can go account setting page from hamburger
    [Tags]    MCLB-35   active    MOBILE     PRODUCTION
    [Setup]    Setup Common Keyword For Lobby Page
    CL Login
    CL Click Profile At Hamburger Menu
    CL Verify Redirect To Profile Page

CLB-036 Verify user can logout from hamburger
    [Tags]    MCLB-36   active    MOBILE     PRODUCTION
    [Setup]    Setup Common Keyword For Lobby Page
    CL Login
    CL Click Logout At Hamburger Menu
    CL Verify Redirect To Logout

CLB-037 Verify user can go promotion page from hamburger mobile
    [Tags]    MCLB-37   active    MOBILE     PRODUCTION
    [Setup]    Setup Common Keyword For Lobby Page
    CL Login
    CL Click Promotion At Hamburger Menu
    Verify Redirect To Promotion Page

CLB-038 Verify user can go referral page from hamburger mobile
    [Tags]    MCLB-038   active    MOBILE     PRODUCTION
    [Setup]    Setup Common Keyword For Lobby Page
    CL Login
    CL Click Referral At Hamburger Menu
    Verify Redirect To Referral Page

CLB-039 Verify user can go all game page from hamburger mobile
    [Tags]    MCLB-39   active    MOBILE     PRODUCTION
    [Setup]    Setup Common Keyword For Lobby Page
    CL Login
    CL Click All Game At Hamburger Menu
    CL Verify Redirect All Game Page

CLB-040 Verify user can go deposit page from hamburger mobile
    [Tags]    MCLB-40   active    MOBILE     PRODUCTION
    [Setup]    Setup Common Keyword For Lobby Page
    CL Login
    CL Click Deposit At Hamburger Menu
    CL Verify Redirect To Cash Wallet Page

CLB-041 Verify amount of cards displayed under "เกมกำลังแจก" should be equal to 10
    [Documentation]   The cards are displaying top 10 rank of Max RTP ratio from high to low
    [Tags]    MCLB-41   active    MOBILE
    [Setup]    Setup Common Keyword For Lobby Page
    CL Login
    CL Verify RTP Win Bonus Header
    CL Verify there should be 10 cards are displayed    ${CLB_max_rtp_card}
    CL Verify RTP should not be equal to zero    ${CLB_max_rtp_card}    ${CLB_games_max_rtp_ratio}

CLB-042 Verify amount of cards displayed under "เกมใกล้แจก" should be equal to 10
    [Documentation]   The cards are displaying top 10 rank of Min RTP ratio from low to high
    [Tags]    MCLB-42   active    MOBILE
    [Setup]    Setup Common Keyword For Lobby Page
    CL Login
    CL Verify RTP Nearly Win Bonus Header
    CL Verify there should be 10 cards are displayed    ${CLB_min_rtp_card}
    CL Verify RTP should not be equal to zero    ${CLB_min_rtp_card}    ${CLB_games_min_rtp_ratio}

CLB-043 Verify PG game company page should be displayed properly
    [Tags]   MCLB-43   active    MOBILE
    [Setup]    Setup Common Keyword For Lobby Page
    CL Login
    CL Go to PG game company page
    Verify element sorting dropdown should be displayed properly
    Verify sorting by RTP min to max should work correctly

CLB-044 Verify EVO game company page should be displayed properly
    [Tags]   MCLB-44   active    MOBILE
    [Setup]    Setup Common Keyword For Lobby Page
    CL Login
    CL Go to EVO game company page
    Verify element sorting dropdown should be displayed properly
    Verify sorting by RTP max to min should work correctly

CLB-045 Verify Joker game company page should be displayed properly
    [Tags]   MCLB-45   active    MOBILE
    [Setup]    Setup Common Keyword For Lobby Page
    CL Login
    CL Go to Joker game company page
    Verify element sorting dropdown should be displayed properly
    Verify sorting by game old to new should work correctly

CLB-046 Verify PNG game company page should be displayed properly
    [Tags]   MCLB-46   active    MOBILE
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
    Casino Setup Test User    ${user_type}    ${common_type}
    Open Casino Website

Setup Keyword For Set Recent Game Favorite To
    [Arguments]    ${favorite_status}    ${user_type}=common    ${common_type}=normal
    Casino Setup Test User    ${user_type}
    CL Get Recent Game Ids
    CL Set Game Favorite Status    ${favorite_status}
    Open Casino Website

Setup Keyword For Set New Game Favorite To
    [Arguments]    ${favorite_status}    ${user_type}=common    ${common_type}=normal
    Casino Setup Test User    ${user_type}
    CL Get Recent Game Ids
    CL Set Game Favorite Status    ${favorite_status}
    Open Casino Website

Setup Keyword For Set Popular Game Favorite To
    [Arguments]    ${favorite_status}    ${user_type}=common    ${common_type}=normal
    Casino Setup Test User    ${user_type}
    DB Connect To Database Pigspin Game
    Query Popular Game Ids Display On Lobby
    CL Set Game Favorite Status    ${favorite_status}    ${game_ids}
    Open Casino Website
