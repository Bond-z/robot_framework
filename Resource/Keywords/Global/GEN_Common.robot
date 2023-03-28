*** Settings ***
Library           String
Library           DateTime
Library           Collections
Library           OperatingSystem

*** Keywords ***
GEN Get Current UTC+7 Time
    ${current_date}    DateTime.Get Current Date    UTC    +7 hours
    [Return]    ${current_date}

GEN Get Current Local Time
    ${current_date}    DateTime.Get Current Date
    [Return]    ${current_date}

GEN Generate Random Phone Number
    ${phone_number}    Generate random string    9    0123456789
    [Return]    0${phone_number}

GEN Generate Random Campaign code
    ${campaign_code}    Generate random string    5    0123456789
    [Return]    ${campaign_code}

GEN Generate Random Campaign name
    ${campaign_name}    Generate random string    6    [UPPER]
    [Return]    ${campaign_name}