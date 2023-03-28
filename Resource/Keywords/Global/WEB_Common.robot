*** Settings ***
Library           SeleniumLibrary    run_on_failure=No operation
Resource          GEN_Common.robot

*** Keywords ***
WEB Open Browser
    [Arguments]    ${url}=${ENVIRONMENT.DOMAIN.${ar_DOMAIN}.ARES.URL}
    Set Test Variable    ${FILE_DOWNLOAD_DIR}    ../../FilePages
    ${chrome_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    IF    "${ar_HEADLESS}"=="${TRUE}"
    Call Method    ${chrome_options}    add_argument    --disable-extensions
    Call Method    ${chrome_options}    add_argument    --headless
    Call Method    ${chrome_options}    add_argument    --disable-gpu
    Call Method    ${chrome_options}    add_argument    --no-sandbox
    END
    ${prefs} =    Create Dictionary    download.default_directory=${FILE_DOWNLOAD_DIR}
    Call Method    ${chrome_options}    add_experimental_option    prefs    ${prefs}
    Call Method    ${chrome_options}    add_argument    --disable-dev-shm-usage
    Call Method    ${chrome_options}    add_argument    test-type
    Create Webdriver    Chrome    chrome_options=${chrome_options}
    Goto    ${url}
    Set Window Size    ${DEVICES_CONFIG.PLATFORM.${ar_DEVICE}.WIDTH}    ${DEVICES_CONFIG.PLATFORM.${ar_DEVICE}.HEIGHT}

WEB Capture screen when case fail
    [Documentation]    Allow QA to manully take screenshot and locate them to specific directory from config.json
    ...    This allow us to check the screenshot saperate from the auto scrrenshot of the Robotframework
    ...    Need first 8 letter of the test cases anme to be Test ID in format TC_00001
    ${test_name}=    String.Split String    ${TEST_NAME}
    Capture Page Screenshot    ${ar_ENVIRONMENT}-${ar_PRODUCT}-${SUITE METADATA}[name]-${test_name}[0]-fail.png
    # Capture Page Screenshot

WEB Teardown common keyword
    Run Keyword If Test Failed    WEB Capture screen when case fail
    Close all Browsers

WEB Click Element
    [Arguments]    ${locator}    ${modifier}=False    ${action_chain}=False    ${timeout}=${TIMEOUT.${ar_DOMAIN}.GLOBAL}
    ...    ${is_scroll_asist}=${false}
    WEB Verify Element Visible    locator=${locator}    timeout=${timeout}
    # Scroll Element Into View     ${locator}
    IF     ${is_scroll_asist}
        ${yoffset}    Get vertical Position    ${locator}
        ${xoffset}    Get Horizontal Position    ${locator}
        execute javascript    window.scrollTo(${xoffset}-120,${yoffset}-120) 
    END
    SeleniumLibrary.Click Element    locator=${locator}    modifier=${modifier}    action_chain=${action_chain}

WEB Get Element Count
    [Arguments]    ${locator}    ${timeout}=${TIMEOUT.${ar_DOMAIN}.GLOBAL}
    WEB Verify Element Visible    locator=${locator}    timeout=${timeout}
    ${count_result}    SeleniumLibrary.Get Element Count    locator=${locator}
    [Return]    ${count_result}

WEB Get Element Attribute
    [Arguments]    ${locator}    ${attribute}    ${timeout}=${TIMEOUT.${ar_DOMAIN}.GLOBAL}
    WEB Verify Element Visible    locator=${locator}    timeout=${timeout}
    ${result_attribute}=    SeleniumLibrary.Get Element Attribute    locator=${locator}    attribute=${attribute}
    [Return]    ${result_attribute}

WEB Get Element Style
    [Arguments]    ${locator}    ${style}    ${timeout}=${TIMEOUT.${ar_DOMAIN}.GLOBAL}
    WEB Verify Element Visible    locator=${locator}    timeout=${timeout}
    ${css}=    Get WebElement    ${locator}
    ${style_value}=    Call Method    ${css}    value_of_css_property    ${style}
    [Return]    ${style_value}

WEB Get Element Text
    [Arguments]    ${locator}    ${timeout}=${TIMEOUT.${ar_DOMAIN}.GLOBAL}
    [Documentation]    สำหรับรับค่า text หรือ value ของ element นั้นๆ
    ...
    ...    *สิ่งที่ต้องการ*
    ...
    ...    ${locator} = ตำแหน่งของ Element นั้้นๆ
    WEB Verify Element Visible    locator=${locator}    timeout=${timeout}
    ${text}=    SeleniumLibrary.Get Text    locator=${locator}
    [Return]    ${text}

WEB Get Element Text Using RegEx
    [Arguments]    ${locator}    ${pattern}    ${timeout}=${TIMEOUT.${ar_DOMAIN}.GLOBAL}
    WEB Verify Element Visible    locator=${locator}    timeout=${timeout}
    ${text}=    SeleniumLibrary.Get Text    locator=${locator}
    ${value}=    BuiltIn.Should Match Regexp    string=${text}    pattern=${pattern}
    [Return]    ${value}

WEB Get Current Location
    ${location}=    SeleniumLibrary.Get Location
    [Return]    ${location}

WEB Get Current Page Title
    ${title}=    SeleniumLibrary.Get Title
    [Return]    ${title}

WEB Input Passwor
    [Arguments]    ${locator}    ${text}    ${clear}=${True}    ${timeout}=${TIMEOUT.${ar_DOMAIN}.GLOBAL}
    WEB Verify Element Visible    locator=${locator}    timeout=${timeout}
    SeleniumLibrary.Input Password    locator=${locator}    password=${text}    clear=${clear}

WEB Input Text
    [Arguments]    ${locator}    ${text}    ${clear}=${True}    ${timeout}=${TIMEOUT.${ar_DOMAIN}.GLOBAL}
    WEB Verify Element Visible    locator=${locator}    timeout=${timeout}
    SeleniumLibrary.Input Text    locator=${locator}    text=${text}    clear=${clear}

WEB Press Keys
    [Arguments]    ${locator}    ${key}
    WEB Verify Element Visible    ${locator}
    SeleniumLibrary.Press Keys    ${locator}    ${key}

WEB Refresh
    [Documentation]    *วัตถุประสงค์*
    ...
    ...    สำหรับ Refresh หน้าเวบ
    ...
    ...    *สิ่งที่ต้องการ*
    ...
    ...
    ...    *หมายเหตุ*
    SeleniumLibrary.Reload Page

WEB Take Screenshot Element
    [Arguments]    ${locator}    ${file_name}    ${timeout}=${TIMEOUT.${ar_DOMAIN}.GLOBAL}
    WEB Verify Element Visible    locator=${locator}    timeout=${timeout}
    SeleniumLibrary.Capture Element Screenshot    locator=${locator}    filename=${file_name}

WEB Take Screenshot Full Page
    [Arguments]    ${file_name}
    SeleniumLibrary.Capture Page Screenshot    filename=${file_name}

WEB Verify Current Location
    [Arguments]    ${expected_result}    ${timeout}=${TIMEOUT.${ar_DOMAIN}.GLOBAL}
    ${current_url}=    SeleniumLibrary.Wait Until Location Is    expected=${expected_result}    timeout=${timeout}

WEB Verify Current Page Title
    [Arguments]    ${expected_result}
    ${title}=    SeleniumLibrary.Get Title
    BuiltIn.Should Be Equal    first=${expected_result}    second=${title}

WEB Verify Element Attribute
    [Arguments]    ${locator}    ${attribute}    ${expected_result}    ${timeout}=${TIMEOUT.${ar_DOMAIN}.GLOBAL}
    [Documentation]    *วัตถุประสงค์*
    ...
    ...    สำหรับตรวจสอบ Text หรือ Value ของ Element
    ...
    ...    *สิ่งที่ต้องการ*
    ...
    ...    - ${locator} = ตำแหน่งของ Element นั้นๆ
    ...    - ${attribute} = attribute property ของ Element นั้นๆ
    ...    - ${assertion} = วิธีการตรวจสอบ
    ...    - ${expected_result} = ผลลัพธ์ที่ควรจะเป็น
    ...
    ...    *หมายเหตุ*
    ...
    ...    สามารถดูตัวอย่าง Assertion ได้ที่นี่
    ...    https://marketsquare.github.io/robotframework-browser/Browser.html?tag=Wait#Assertions
    WEB Verify Element Visible    locator=${locator}    timeout=${timeout}
    ${result_attribute}=    SeleniumLibrary.Get Element Attribute    locator=${locator}    attribute=${attribute}
    BuiltIn.Should Be Equal    first=${result_attribute}    second=${expected_result}
    [Return]    ${attribute}

WEB Verify Element Count
    [Arguments]    ${locator}    ${expected_value}    ${timeout}=${TIMEOUT.${ar_DOMAIN}.GLOBAL}
    WEB Verify Element Visible    locator=${locator}    timeout=${timeout}
    ${result_count}=    SeleniumLibrary.Get Element Count    locator=${locator}
    Should Be True    ${result_count}==${expected_value}    #Don't need to verify here, expected value should be retrived from DB
    [Return]    ${result_count}

WEB Verify Element Style
    [Arguments]    ${locator}    ${expected}    ${style}    ${timeout}=${TIMEOUT.${ar_DOMAIN}.GLOBAL}
    WEB Verify Element Visible    locator=${locator}    timeout=${timeout}
    ${css}=    Get WebElement    ${locator}
    ${style_value}=    Call Method    ${css}    value_of_css_property    ${style}
    Should Be Equal    ${expected}    ${style_value}

WEB Verify Element Text
    [Arguments]    ${locator}    ${expected_result}    ${ignore_case}=${False}    ${timeout}=${TIMEOUT.${ar_DOMAIN}.GLOBAL}
    [Documentation]    *คำอธิบาย*
    ...
    ...    ${locator} = ตำแหน่งของ Element นั้นๆ
    ...
    ...    ${expected_result} = ข้อความของ Element ที่ต้องการตรวจสอบ
    ...
    ...    ${ignore_case} = กรณีไม่อยากสนใจว่าเป็น case-sensitive ให้ใส่ True
    WEB Verify Element Visible    locator=${locator}    timeout=${timeout}
    SeleniumLibrary.Element Text Should Be    ${locator}    ${expected_result}    ignore_case=${ignore_case}

WEB Verify Element Text Using RegEx
    [Arguments]    ${locator}    ${pattern}    ${timeout}=${TIMEOUT.${ar_DOMAIN}.GLOBAL}
    WEB Verify Element Visible    locator=${locator}    timeout=${timeout}
    ${text}=    SeleniumLibrary.Get Text    locator=${locator}
    ${value}=    BuiltIn.Should Match Regexp    string=${text}    pattern=${pattern}

WEB Verify Element Visible
    [Arguments]    ${locator}    ${timeout}=${TIMEOUT.${ar_DOMAIN}.GLOBAL}
    [Documentation]    *วัตถุประสงค์*
    ...
    ...    สำหรับตรวจสอบว่า Element นั้นแสดงอยู่บนหน้าจอหรือไม่
    ...
    ...    *สิ่งที่ต้องการ*
    ...
    ...    - ${locator} = ตำแหน่งของ Element นั้นๆ
    ...
    ...    *หมายเหตุ*
    SeleniumLibrary.Wait Until Element Is Visible    locator=${locator}    timeout=${timeout}

WEB Verify Element Not Visible
    [Arguments]    ${locator}    ${timeout}=${TIMEOUT.${ar_DOMAIN}.GLOBAL}
    [Documentation]    *วัตถุประสงค์*
    ...
    ...    สำหรับตรวจสอบว่า Element นั้นแสดงอยู่บนหน้าจอหรือไม่
    ...
    ...    *สิ่งที่ต้องการ*
    ...
    ...    - ${locator} = ตำแหน่งของ Element นั้นๆ
    ...
    ...    *หมายเหตุ*
    SeleniumLibrary.Wait Until Element Is Not Visible    locator=${locator}    timeout=${timeout}

WEB Capture Verify Point
    [Arguments]    ${verify_point_name}
    ${name}=    String.Split String    ${TEST_NAME}
    WEB Take Screenshot Full Page    ${SUITE_NAME}-${ar_ENVIRONMENT}-${ar_USER_SET}-${name}[0]-${verify_point_name}.png

WEB Capture Fail Point
    ${name}=    String.Split String    ${TEST_NAME}
    WEB Take Screenshot Full Page    ${SUITE_NAME}-${ar_ENVIRONMENT}-${ar_USER_SET}-${name}[0]-fail.png

WEB Get DateTime
    [Arguments]    ${plus_hour}=+7
    ${cur_time}    Get Current Date    UTC    ${plus_hour}
    [Return]    ${cur_time}

WEB Get Current Date Only Date
    ${cur_date}    WEB Get DateTime
    ${cur_date}    Get Substring    ${cur_date}    0    10
    [Return]    ${cur_date}

Web Verify Until Element Text Contain
    [Arguments]    ${locator}    ${expected_result}    ${ignore_case}=${False}    ${retry}=${TIMEOUT.${ar_DOMAIN}.RETRY}    ${retry_interval}=${TIMEOUT.${ar_DOMAIN}.RETRY_INTERVAL}
    BuiltIn.Wait Until Keyword Succeeds    ${retry}    ${retry_interval}    SeleniumLibrary.Element Text Should Be    ${locator}    ${expected_result}    ignore_case=${ignore_case}

WEB Verify Element Contain
    [Arguments]    ${locator}    ${timeout}=${TIMEOUT.${ar_DOMAIN}.GLOBAL}
    [Documentation]    *วัตถุประสงค์*
    ...
    ...    สำหรับตรวจสอบว่า Element นั้นแสดงอยู่บนหน้าจอหรือไม่
    ...
    ...    *สิ่งที่ต้องการ*
    ...
    ...    - ${locator} = ตำแหน่งของ Element นั้นๆ
    ...
    ...    *หมายเหตุ*
    SeleniumLibrary.Wait Until Page Contains Element    locator=${locator}    timeout=${timeout}

Web Mouse Over
    [Arguments]    ${locator}    ${timeout}=${TIMEOUT.${ar_DOMAIN}.GLOBAL}
    WEB Verify Element Contain    locator=${locator}    timeout=${timeout}
    SeleniumLibrary.Mouse Over    ${locator}

Format Text
    [Arguments]    ${format_string}    &{key_value_pairs}
    ${key_value_pairs}=     Collections.Convert To Dictionary    ${key_value_pairs}
    ${result_text}    Evaluate    unicode($format_string).format(**$key_value_pairs) if sys.version_info.major==2 else str($format_string).format(**$key_value_pairs)    modules=sys
    [Return]    ${result_text}

Open web pigspin browser and go to lobby page
    [Arguments]    ${user_type}=common    ${common_type}=normal
    CL Setup Test User    ${user_type}    ${common_type}
    CL Open Pigspin Website

WEB Set Focus To Element
    [Arguments]    ${locator}
    SeleniumLibrary.Set Focus To Element    ${locator}
    # WEB Verify Element Visible    ${locator}

WEB Sleep
    [Arguments]    ${duration}=${TIMEOUT.${ar_ENVIRONMENT}.SLEEP}
    Sleep    ${duration}

WEB Choose File
    [Arguments]    ${locator}    ${file_directory}    ${timeout}=${TIMEOUT.${ar_DOMAIN}.GLOBAL}
    WEB Verify Element Visible    locator=${locator}    timeout=${timeout}
    Scroll Element Into View     ${locator}
    SeleniumLibrary.Choose File    ${locator}    ${file_directory}

WEB Close Toastify
    [Arguments]    ${locator}
    WEB Set Focus To Element    ${locator}
    WEB Click Element    ${locator}

WEB Paste text from clipboard
    Import Library    ${CURDIR}/Clipboard.py
    ${text}=    Clipboard.pasteText
    [Return]    ${text}
