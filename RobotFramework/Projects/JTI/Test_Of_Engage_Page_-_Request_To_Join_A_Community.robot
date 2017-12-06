*** Settings ***
Suite Setup       Setup Test Environment
Suite Teardown    Close Browser
Resource          Keywords/functionalKeywords.robot

*** Test Cases ***
Request To Join A Community
    [Documentation]    Click on Request to join button and fill in some text to the message box. Click send and wait for the message to appear.
    Log In    ${test user 2 name}    ${test user 2 pwd}
    Go To    ${all communities url}
    Request To Join A Community
    Log Out
    Log In    ${test user 1 name}    ${test user 1 pwd}
    Wait Until Keyword Succeeds    5 times    1 secs    Go To Fixed Community Access Request Page
    Wait Until Page Contains    ${test user 2 full name}
    Click Element    //div[not(contains(@class,"ms-accReq-hide")) and contains(@class,"ms-webpartzone-cell")]//*[text()="${test user 2 full name}"]/ancestor::table[@summary="Access Requests"]//div[contains(@onclick, "ShowMenuForTrOuter")]/a[@title="Open Menu"]
    Wait Until Page Contains Link With Text    Decline
    Click Link Which Contains    Decline    //*[text()="${test user 2 full name}"]/ancestor::div[@class="js-callout-content"]
    Wait Until Page Does Not Contain    //div[not(contains(@class,"ms-accReq-hide")) and contains(@class,"ms-webpartzone-cell")]//*[text()="${test user 2 full name}"]/ancestor::table[@summary="Access Requests"]
