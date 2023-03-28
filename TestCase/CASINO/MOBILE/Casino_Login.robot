*** Settings ***
Test Teardown     WEB Teardown common keyword
Metadata          name    CasinoLogin
Resource          ${CURDIR}/../../../Resource/import.robot

*** Test Cases ***
CLGN-001 Verify Element On Login page
    [Tags]    MCLGN-1    active    MOBILE     PRODUCTION
    [Setup]    Set Up Common Keyword For Login Pigbet
    Click Login Button On Pigbet website
    CASINO Verify Element Login Page

CLGN-002 Verify login success
    [Tags]    MCLGN-2    active    MOBILE     PRODUCTION
    [Setup]    Set Up Common Keyword For Login Pigbet
    Login CASINO website
    CASINO Verify Login Success

LGN-003 Verify login fail wrong pin
    [Tags]    MCLGN-3    active    MOBILE     PRODUCTION
    [Setup]    Set Up Common Keyword For Login Pigbet
    Click Login Button On Pigbet website
    Login CASINO website    pin=${TEST_USER.pin.wrong}
    CASINO Verify Login Fail Wrong Pin

LGN-004 Verify login fail phone no doesn't exist in system
    [Tags]    MCLGN-4    active     MOBILE     PRODUCTION
    [Setup]    Set Up Common Keyword For Login Pigbet
    Click Login Button On Pigbet website
    ${random_phone_number}    GEN Generate Random Phone Number
    Input Phone No On Pigbet Website    ${random_phone_number}
    Click Check Phone No On Pigbet Website
    CASINO Verify Login Fail Account Doesn't Exist

LGN-005 Verify login fail input wrong format phone number
    [Tags]    MCLGN-5    active    MOBILE     PRODUCTION
    [Setup]    Set Up Common Keyword For Login Pigbet
    Click Login Button On Pigbet website
    Input Phone No On Pigbet Website    ทศสอบ
    CASINO Verify login fail input phone wrong format

LGN-006 Verify login fail input wrong format pin
    [Tags]    MCLGN-6    active    MOBILE     PRODUCTION
    [Setup]    Set Up Common Keyword For Login Pigbet
    Click Login Button On Pigbet website
    Login CASINO website    pin=aaaaaa
    CASINO Verify login fail input pin wrong format

LGN-007 Verify login fail wrong pin 10 times
    [Tags]    MCLGN-7    active    MOBILE     PRODUCTION
    [Setup]    Set Up Keyword For Invalid Login User
    Click Login Button On Pigbet website
    Input Phone No On Pigbet Website     ${TEST_USER.phone.uncensor}
    Click Check Phone No On Pigbet Website
    CASINO Input Wrong Pin 10 Times
    CASINO Verify Lock User Modal Appear
    Update User Status To Active     ${TEST_USER.phone.uncensor}

LGN-008 Verify lock user cannot login
    [Tags]    MCLGN-8    active    MOBILE     PRODUCTION
    [Setup]    Set Up Keyword For Locked User Account
    Click Login Button On Pigbet website
    Input Phone No On Pigbet Website    ${TEST_USER.phone.uncensor}
    Click Check Phone No On Pigbet Website
    CASINO Verify Lock User Modal Appear
    
LGN-009 Verify ban user cannot login
    [Tags]    MCLGN-9    active    MOBILE     PRODUCTION
    [Setup]    Set Up Keyword For Ban User Account
    Click Login Button On Pigbet website
    Input Phone No On Pigbet Website    ${TEST_USER.phone.uncensor}
    Click Check Phone No On Pigbet Website
    CASINO Verify Ban User Modal Appear

*** Keywords ***
Set Up Common Keyword For Login Pigbet
    [Arguments]    ${user_type}=common    ${common_type}=normal
    Casino Setup Test User    ${user_type}    ${common_type}
    Open Casino Website

Set Up Keyword For Invalid Login User
    [Arguments]    ${user_type}=common    ${common_type}=downline1
    Casino Setup Test User    ${user_type}    ${common_type}
    Open Casino Website

Set Up Keyword For Locked User Account
    [Arguments]    ${user_type}=common    ${common_type}=lock
    Casino Setup Test User    ${user_type}    ${common_type}
    Open Casino Website

Set Up Keyword For Ban User Account
    [Arguments]    ${user_type}=common    ${common_type}=ban
    Casino Setup Test User    ${user_type}    ${common_type}
    Open Casino Website

