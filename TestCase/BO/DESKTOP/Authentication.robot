*** Settings ***
# Test Setup    Open Pigspin Back Office Website
# Test Teardown     WEB Teardown common keyword   
Resource          ${CURDIR}/../../../Resource/import.robot

*** Test Cases ***
#รอพี่อะชิ investigate เรื่ิอง bypass sign in with google
LBP-000 Verify Section In Lobby Page
    [Tags]    DESKTOP    1    inactive
    # Set Test Variable    ${Test_User_01}    ${Test_password}    ${Backoffice.user01.email}    ${Backoffice.user01.password}
    Open Browser    https://bofe-staging.pigspin.xyz/    gc
    BO Login    ${Backoffice.user01.email}    ${Backoffice.user01.password}
   