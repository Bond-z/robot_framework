*** Settings ***
Test Teardown     WEB Teardown common keyword
Metadata          name    Login
Resource          ../../../Resource/Keywords/CL/CL_Login.robot

*** Test Cases ***
LGN-001 Verify login page
    [Tags]    TLGN-1    active    TABLET     PRODUCTION
    [Setup]    Set Up Common Keyword For Login
    CL Click Login Button
    CL Verify Element Login Page

LGN-002 Verify login success
    [Tags]    TLGN-2    active    TABLET     PRODUCTION
    [Setup]    Set Up Common Keyword For Login
    CL Login
    CL Verify Login Success

LGN-003 Verify login fail wrong pin
    [Tags]    TLGN-3    active    TABLET     PRODUCTION
    [Setup]    Set Up Common Keyword For Login
    CL Login    pin=${TEST_USER.pin.wrong}
    CL Verify Login Fail Wrong Pin

LGN-004 Verify login fail phone no doesn't exist in system
    [Tags]    TLGN-4    active     TABLET     PRODUCTION
    [Setup]    Set Up Common Keyword For Login
    CL Click Login Button
    ${random_phone_number}    GEN Generate Random Phone Number
    CL Input Phone No    ${random_phone_number}
    CL Click Check Phone No
    CL Verify Login Fail Account Doesn't Exist

LGN-005 Verify login fail input wrong format phone number
    [Tags]    TLGN-5    active    TABLET     PRODUCTION
    [Setup]    Set Up Common Keyword For Login
    CL Click Login Button
    CL Input Phone No    ทศสอบ
    CL Verify login fail input phone wrong format

LGN-006 Verify login fail input wrong format pin
    [Tags]    TLGN-6    active    TABLET     PRODUCTION
    [Setup]    Set Up Common Keyword For Login
    CL Login    pin=aaaaaa
    CL Verify login fail input pin wrong format

LGN-007 Verify login fail wrong pin 10 times
    [Tags]    TLGN-7    active    TABLET     PRODUCTION
    [Setup]    Set Up Keyword For Login With Clear Login Log
    CL Click Login Button
    CL Input Phone No
    CL Click Check Phone No
    CL Input Wrong Pin 10 Times
    CL Verify Lock User Modal Appear

LGN-008 Verify lock user cannot login
    [Tags]    TLGN-8    active    TABLET     PRODUCTION
    [Setup]    Set Up Common Keyword For Login    ${cl_user.common.lock}
    CL Click Login Button
    CL Input Phone No
    CL Click Check Phone No
    CL Verify Lock User Modal Appear

LGN-009 Verify ban user cannot login
    [Tags]    TLGN-9    active    TABLET     PRODUCTION
    [Setup]    Set Up Common Keyword For Login    ${cl_user.common.ban}
    CL Click Login Button
    CL Input Phone No
    CL Click Check Phone No

*** Keywords ***
Set Up Common Keyword For Login
    [Arguments]    ${user}=common
    CL Setup Test User    ${user}
    CL Open Pigspin Website

Set Up Keyword For Login With Clear Login Log
    [Arguments]    ${user}=agent
    [Documentation]    อย่าลืมหา User สำหรับเทสเคสนี้
    CL Setup Test User    ${user}
    CL Open Pigspin Website
    DB Connect To Database Pigspin Php
    DELETE User Login Log

Teardown Keyword For Login With Clear Login Log
    WEB Teardown common keyword
    [Teardown]    Teardown Keyword For Login With Clear Login Log
