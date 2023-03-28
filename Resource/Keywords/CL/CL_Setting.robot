***Keywords***
CL Reset User PIN
    [Arguments]    ${original_pin}    ${new_pin}
    CL Click Reset Pin Button
    CL Input Reset PIN    ${new_pin}
    Verify successfully check pin    ${cl_setting_localize.reset_pin.input_new_pin_title_modal}
    CL Input Reset PIN    ${original_pin}
    Verify successfully check pin    ${cl_setting_localize.reset_pin.confirm_new_pin_title_modal}
    CL Input Reset PIN    ${original_pin}
    CL Click Success Reset PIN Ok Button

CL Click Reset Pin Button
    WEB Click Element     ${SET_reset_pin_btn}    is_scroll_asist=${True}

CL Input Reset PIN
    [Arguments]    ${pin}
    ${pin_length}    Get Length    ${pin}
    FOR    ${ROUND}    IN RANGE    0    ${pin_length}
        ${index}    Convert To String    ${ROUND}
        ${pin_location}    Replace String    ${SET_input_pin}    <index>    ${index}
        WEB Input Text    ${pin_location}    ${pin}[${INDEX}]
    END

CL Click Success Reset PIN Ok Button
    WEB Click Element     ${SET_reset_ok_btn}

Verify successfully check pin
    [Arguments]    ${text}
    Web Verify Until Element Text Contain     ${SET_reset_modal_title}    ${text}