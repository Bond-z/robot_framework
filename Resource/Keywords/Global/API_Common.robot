*** Keyword ***
API Reset pin by usercode
    [Arguments]     ${user_code}    ${expect_pin}
    &{header}=    Create Dictionary
    ...    Content-Type=application/json
    ...    accept=application/json
    Set Test Variable    ${uri}    v1/user/reset-forgot-pin

    ${json}=    JSONLibrary.Load Json From File     ${CURDIR}/../../TestData/${ar_PRODUCT}/${ar_ENVIRONMENT}/Reset_forget_pin.json
    ${json}=    JSONLibrary.Update Value To Json    ${json}    $..user_code     ${user_code}
    ${json}=    JSONLibrary.Update Value To Json    ${json}    $..user_new_pin    ${expect_pin}
    ${body}     json.Dumps    ${json}
    
    ${end_point}=   Set Variable    ${ENVIRONMENT.DOMAIN.STAGING.PIGSPIN_SERVICE.URL}${uri}

    ${response}=     PUT    ${end_point}     headers=${header}    data=${body}
    Should Be Equal As Strings    SUCCESS    ${response.json()}[data][status]