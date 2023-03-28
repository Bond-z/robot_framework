*** Settings ***
Test Teardown     WEB Teardown common keyword  
Metadata          name    Backoffice 
Resource          ${CURDIR}/../../../Resource/import.robot


*** Test Case ***
BOE2E-1 Verify the system can be able to deposit and withdraw Successful
    [Tags]    BOE2E-1    active    DESKTOP    e2e
    Set Selenium Speed    0.5s
    Set Test Variable    ${deposit}    ${50}
    Set Test Variable    ${transfer}    ${50}
    Set Test Variable    ${withdraw}    ${50}
    BO Login
    Go To Transaction Menu
    ${previous_balance}=    Get system current balance amount on transaction page
    Go To Deposit Page And Create New Deposit     ${cl_user.common.normal.bank.account.uncensor}    ${deposit}
    Go To ToDo List Tab And Confirm Deposit     ${cl_user.common.normal.phone.uncensor}
    Verify Deposit Should Be Successful        ${cl_user.common.normal.phone.uncensor}    ${deposit}
    Verify the customer should gain 10 percent bonus when deposit     ${deposit}
    Go To Transaction Menu
    ${current_balance}=    Get system current balance amount on transaction page
    Verify the money is added into system saving account correctly    ${previous_balance}    ${current_balance}    ${transfer}
    Transfer money from the system to user bank account should be success     ${cl_user.common.normal.username}    ${withdraw}
    
BOE2E-2 Verify the deposit request item should be editable 
    [Tags]    BOE2E-2    inactive    DESKTOP    e2e
    Set Selenium Speed    0.5s
    Set Test Variable    ${deposit}    ${50}
    Set Test Variable    ${edit_amount}    ${100}
    BO Login
    #Get existing balance on transaction page before deposit
    Go To Transaction Menu
    ${previous_balance}=    Get system current balance amount on transaction page
    ${previous_balance}=   Remove String    ${previous_balance}    ,
    ${previous_balance} =    Convert To Number    ${previous_balance}

    #Deposit money 50 baht
    Go To Deposit Page And Create New Deposit     ${cl_user.common.normal.bank.account.uncensor}    ${deposit}
    Verify the status should be "รอเติมเงิน"
    ${amount}=    Get deposit amount from table on deposit page
    ${previous_amount}    Set Variable    ${amount}

    #Get new balance after created request deposit and it should be increased 50 baht
    Go To Transaction Menu
    ${new_balance}=    Get system current balance amount on transaction page
    ${new_balance}=   Remove String    ${new_balance}    ,
    ${new_balance} =    Convert To Number    ${new_balance}

    ${expect_balance}=    Evaluate    ${previous_balance} + ${deposit}
    Should Be Equal As Numbers    ${expect_balance}    ${new_balance}
    
    #Edit Deposit from 50 baht to 100 baht
    Edit deposit amount    ${edit_amount}
    ${amount_after_edit}=    Get deposit amount from table on deposit page

    #Get final balance after edit
    Go To Transaction Menu
    ${final_balance}=    Get system current balance amount on transaction page
    ${final_balance}=   Remove String    ${final_balance}    ,
    ${final_balance} =    Convert To Number    ${final_balance}
    ${expect_final_balance}=    Evaluate    ${previous_balance} + ${edit_amount}

    #Verify the deposit amount on deposit page should be edited correctly
    Should Not Be Equal As Numbers    ${amount_after_edit}    ${previous_amount}
    Should Be Equal As Numbers    ${amount_after_edit}    ${edit_amount}

    #Verify the transaction page should be changed the balancing correctly
    Should Be Equal As Numbers    ${expect_final_balance}    ${final_balance}

    Delete deposit request on todo list tab

BOE2E-3 Verify delete deposit request item should be success
    [Tags]    BOE2E-3    inactive    DESKTOP    e2e
    Set Selenium Speed    0.5s
    Set Test Variable    ${deposit}    ${50}
    BO Login
    Go To Deposit Page And Create New Deposit     ${cl_user.common.normal.bank.account.uncensor}    ${deposit}
    ${amount}=    Get deposit amount from table on deposit page
    Delete deposit request on todo list tab
    Element Should Not Be Visible    ${BO_todo_deposit_amt_table}

BOE2E-4 Verify users should not receive bonus if they disable bonus wallet on their profile
    [Tags]    BOE2E-4    inactive    DESKTOP    e2e
    [Setup]    Set Up Common Keyword For User For Backoffice
    Set Selenium Speed    0.5
    Set Test Variable    ${deposit}    ${50}
    BO Login
    Deposit through SCB bank account and comfirm     ${cl_user.common.downline1.bank.account.uncensor}    ${deposit}
    Go To ToDo List Tab And Confirm Deposit     ${cl_user.common.downline1.phone.uncensor}
    Verify Deposit Should Be Successful        ${cl_user.common.downline1.phone.uncensor}    ${deposit}
    Verify the user should not have bonus after deposit

BOE2E-5 Verify deposit rejection should be successful
    [Tags]    BOE2E-5    inactive    DESKTOP    e2e
    Set Selenium Speed    0.5
    Set Test Variable    ${deposit}    ${100}
    BO Login
    Deposit through BBL bank account and comfirm     ${cl_user.common.reject_deposit.bank.account.uncensor}    ${deposit}
    Reject deposit         ${cl_user.common.reject_deposit.phone.uncensor}
    Transfer money to user after reject request deposit     ${cl_user.common.reject_deposit.customer_name.th}
    Verify deposit history status should be "Wait for transfer back"

BOE2E-6 Verify deposit rejection should be successful
    [Tags]    BOE2E-6    inactive    DESKTOP    e2e
    [Setup]    Set Up Common Keyword For User For Backoffice
    Set Test Variable    ${deposit}    ${100}
    Set Test Variable    ${withdraw}    ${50}
    BO Login
    Go To Deposit Page And Create New Deposit     ${TEST_USER.bank.account.uncensor}    ${deposit}
    Go To ToDo List Tab And Confirm Deposit     ${TEST_USER.phone.uncensor}
    Create withdraw request     ${TEST_USER.username}    ${withdraw}
    Reject withdraw should be success    ${TEST_USER.username}
    Verify the status should be "ปฏิเสธถอนเงิน"    ${TEST_USER.username}    ${withdraw}

BOE2E-7 Verify withdraw affiliate should be successful
    [Tags]    BOE2E-7    inactive    DESKTOP    e2e
    [Setup]    Set Up Common Keyword For User For Backoffice
    Set Selenium Speed    0.5
    Set Test Variable    ${topup}    ${50}
    Set Test Variable    ${withdraw}    ${50}
    BO Login
    Go To Affiliate Overview Page
    Search for upline user    ${TEST_USER.username}
    Add income to upline by affiliate type 'ยอดเสีย'     ${cl_user.common.downline1.username}    ${topup}
    Create withdraw affiliate request    ${TEST_USER.username}    ${withdraw}
    Admin confirm transfer money to user bank account should be success    ${TEST_USER.username}
    Verify withdraw is completly success on History tab    ${TEST_USER.username}    ${withdraw}

BOE2E-8 Verify topup bonus and cancel bonus should be success
    [Tags]    BOE2E-8    inactive    DESKTOP    e2e
    [Setup]   Set Up Common Keyword For User For Backoffice
    Set Test Variable    ${topup}    ${50}
    Set Test Variable    ${turn_over}    ${10}
    BO Login
    ${bonus_balance}    Get current bonus balance    ${TEST_USER.username}
    Add bonus to user    ${topup}    ${turn_over}
    Reload Page    
    ${new_bonus}    Get current bonus balance    ${TEST_USER.username}

    ${expect_new_bonus}    Evaluate    ${bonus_balance} + ${topup}
    Should Be Equal As Numbers    ${expect_new_bonus}    ${new_bonus}
    
    Cancel bonus should be completed

BOE2E-9 Verify admin can add income for upline by verify KYC should be success
    [Tags]    BOE2E-9    inactive    DESKTOP    e2e
    [Setup]    Set Up Common Keyword For User For Backoffice
    Set Test Variable    ${add_income}    ${50}
    BO Login
    Go To Affiliate Overview Page
    Search for upline user    ${TEST_USER.username}

    ${previous_total_kyc}    WEB Get Element Text    ${BO_total_income_kyc}
    ${previous_total_kyc}    Convert To Number    ${previous_total_kyc}

    Add income to upline by affiliate type 'ยืนยันตัวตน'     ${cl_user.common.downline1.username}    ${add_income}    
    Verify added income by type 'ยืนยันตัวตน' should be successful     ${previous_total_kyc}    ${add_income}

BOE2E-10 Verify admin can cancel added amount of verify KYC item successful
    [Tags]    BOE2E-10    inactive    DESKTOP    e2e
    [Setup]    Set Up Common Keyword For User For Backoffice
    Set Test Variable    ${add_income}    ${50}
    BO Login
    Go To Affiliate Overview Page
    Search for upline user    ${TEST_USER.username}

    ${previous_total_kyc}    WEB Get Element Text    ${BO_total_income_kyc}
    ${previous_total_kyc}    Convert To Number    ${previous_total_kyc}

    Cancel affiliate 'แบบกำหนดเอง'     ${cl_user.common.downline1.username}    ${add_income}    ยืนยันตัวตน(กำหนดเอง)
    Verify affiliate KYC balance amount should be corrected     ${previous_total_kyc}    ${add_income}
    Verify the status should be corrected     ${cl_user.common.downline1.username}    โดนยกเลิก

BOE2E-11 Verify admin can add income for upline by first deposit should be success
    [Tags]    BOE2E-11    inactive    DESKTOP    e2e
    [Setup]    Set Up Common Keyword For User For Backoffice
    Set Test Variable    ${add_income}    ${100}
    BO Login
    Go To Affiliate Overview Page
    Search for upline user    ${TEST_USER.username}

    ${previous_1st_deposit_income}    WEB Get Element Text    ${BO_total_income_1st_deposit}
    ${previous_1st_deposit_income}    Convert To Number    ${previous_1st_deposit_income}

    Add income to upline by affiliate type 'เติมเงินครั้งแรก'     ${cl_user.common.downline1.username}    ${add_income}    
    Verify added income by type 'เติมเงินครั้งแรก' should be successful     ${previous_1st_deposit_income}    ${add_income}

BOE2E-12 Verify admin can cancel added amount of first deposit item successful
    [Tags]    BOE2E-12    inactive    DESKTOP    e2e
    [Setup]    Set Up Common Keyword For User For Backoffice
    Set Test Variable    ${add_income}    ${100}
    BO Login
    Go To Affiliate Overview Page
    Search for upline user    ${TEST_USER.username}

    ${previous_total}    WEB Get Element Text    ${BO_total_income_1st_deposit}
    ${previous_total}    Convert To Number    ${previous_total}

    Cancel affiliate 'แบบกำหนดเอง'     ${cl_user.common.downline1.username}    ${add_income}    เติมเงินครั้งแรก(กำหนดเอง)
    Verify affiliate first deposit balance amount should be corrected     ${previous_total}    ${add_income}
    Verify the status should be corrected     ${cl_user.common.downline1.username}    โดนยกเลิก

BOE2E-13 Verify admin can add income for upline by total lost should be success
    [Tags]    BOE2E-13    inactive    DESKTOP    e2e
    [Setup]    Set Up Common Keyword For User For Backoffice
    Set Test Variable    ${add_income}    ${20}
    BO Login
    Go To Affiliate Overview Page
    Search for upline user    ${TEST_USER.username}

    ${previous_income}    WEB Get Element Text    ${BO_total_income_from_lost}
    ${previous_income}    Convert To Number    ${previous_income}

    Add income to upline by affiliate type 'ยอดเสีย'     ${cl_user.common.downline1.username}    ${add_income}    
    Verify added income by type 'ยอดเสีย' should be successful     ${previous_income}    ${add_income}

BOE2E-14 Verify admin can cancel added amount of total lost item successful
    [Tags]    BOE2E-14    inactive    DESKTOP    e2e
    [Setup]    Set Up Common Keyword For User For Backoffice
    Set Test Variable    ${add_income}    ${20}
    BO Login
    Go To Affiliate Overview Page
    Search for upline user    ${TEST_USER.username}

    ${previous_total}    WEB Get Element Text    ${BO_total_income_from_lost}
    ${previous_total}    Convert To Number    ${previous_total}

    Cancel affiliate 'แบบกำหนดเอง'     ${cl_user.common.downline1.username}    ${add_income}    ยอดเสีย(กำหนดเอง)
    Verify affiliate from lost spent balance amount should be corrected     ${previous_total}    ${add_income}
    Verify the status should be corrected     ${cl_user.common.downline1.username}    โดนยกเลิก

BOE2E-15 Verify 'ยอดเงินในกระเป๋ารายได้ปัจจุบัน' on Affiliate page should be equal to withdraw affiliate page
    [Tags]    BOE2E-15    inactive    DESKTOP    e2e
    [Setup]    Set Up Common Keyword For User For Backoffice
    Set Selenium Speed    0.5s
    BO Login
    Go To Affiliate Overview Page
    ${total_income}=    Verify and get total active balance on Affiliate Over Page     ${TEST_USER.username}
    Go To Transfer Menu And Click On Tab Friend Suggestion
    ${balance_amount}=    Create New Withdraw And Get Balance Amount    ${TEST_USER.username}
    Should Be Equal As Numbers    ${total_income}    ${balance_amount}

BOE2E-16 Verify that the admin can create new ticket for a user successful
    [Tags]    BOE2E-16    inactive    DESKTOP    e2e
    [Setup]    Set Up Common Keyword For User For Backoffice
    Set Selenium Speed    0.5s
    Set Test Variable    ${ticket_amount}    ${10}
    ${campaign_code}    GEN Generate Random Campaign code 
    ${campaign_name}    GEN Generate Random Campaign name
    BO Login
    Go To User Ticket Page
    ${previous_ticket}    Get total current tickets    ${cl_user.common.downline1.username}
    Create new ticket for a user    ${cl_user.common.downline1.username}    ${campaign_code}    ${campaign_name}    ${ticket_amount}
    Verify the ticket is completly created    ${cl_user.common.downline1.username}    ${previous_ticket}    ${ticket_amount}

BOE2E-17 Verify that the customer information can be editable
    [Tags]    BOE2E-17    inactive    DESKTOP    e2e
    [Setup]    Set Up Common Keyword For User For Backoffice
    BO Login
    Go To Customer Page
    Search for customer    PS381660885     #${TEST_USER.username}
    Edit customer status by disable account
    Verify edit customer account status should be successful    ถูกระงับใช้งาน
    Edit customer status by enable account


*** Keywords ***
Set Up Common Keyword For User For Backoffice
    [Arguments]    ${user_type}=common    ${common_type}=normal
    CL Setup Test User    ${user_type}    ${common_type}