*** Settings ***
Test Teardown     WEB Teardown common keyword  
Metadata          name    Setting
Resource          ${CURDIR}/../../../Resource/import.robot

*** Test Cases ***
PRO-015 Verify user reset pin successfully
    [Documentation]    Implementer: Fluke
    ....    need fix, set up new user test data for PIN change
    [Tags]    PRO-015    active    MOBILE
    [Setup]    Set Up New PIN
    CL Login
    CL Click Profile At Hamburger Menu
    CL Reset User PIN    original_pin=${TEST_USER.pin.original}    new_pin=${TEST_USER.pin.new}
    CL Click Logout At Hamburger Menu    is_lobby=${False}
    CL Login    pin=${TEST_USER.pin.new}
    CL Verify Redirect Lobby Page
    [Teardown]    Set Up Original PIN

*** Keywords ***
Set Up Common Keyword For Setting Page
    [Arguments]    ${user_type}=common    ${common_type}=normal
    CL Setup Test User    ${user_type}    ${common_type}
    CL Open Pigspin Website

Set Up New PIN
    [Arguments]    ${user_type}=agent    ${common_type}=normal
    CL Setup Test User    ${user_type}    ${common_type}
    API Reset pin by usercode    ${TEST_USER.user_code}    ${TEST_USER.pin.new}
    CL Open Pigspin Website

Set Up Original PIN
    [Arguments]    ${user_type}=agent    ${common_type}=normal
    API Reset pin by usercode    ${TEST_USER.user_code}    ${TEST_USER.pin.original}