*** Settings ***
Resource          uiKeywords.robot
Resource          ../TestData/testData.robot

*** Keywords ***
Login
    [Arguments]    ${username}    ${password}
    [Documentation]    Description - Check if Login page works correctly.
    ...    Expected - Users should be able to log in with given user name and password.
    Set Text Box Form Value    User name:    ${username}
    Set Text Box Form Value    Password:    ${password}
    Click On Button With Text    Log On
    Wait Until Page Contains Element    //img[@id='insideLogo']    10

Unset Tags
    ${modal} =    Set Variable    //div[@id="modal_editmyNews"]
    Uncheck Check Box    Andorra    ${modal}
    Uncheck Check Box    Canary Island    ${modal}
    Uncheck Check Box    Spain    ${modal}

Check If Articles Loaded
    [Documentation]    Returns true if additional articles are loaded. (more than 10 articles are present).
    ${count} =    Get Matching Xpath Count    //ul[@id="ms-srch-result-groups-VisibleOutput"]//div[@class="articleListItem"]
    Should Be True    ${count} \> 10

Setup Browser
    Open Browser    ${url}    ${browser}
    Maximize Browser Window

Search For Keyword
    [Arguments]    ${keyword}
    ${searchbox}=    Set Variable    //nav[not(@id="mobileNav")]//div[@id="SearchBox"]//input
    Set Text Box Element Value    ${searchbox}    ${keyword}
    Press Key    ${searchbox}    \\13
    Wait Until Page Contains Element    //div[@class="searchResultsLists"]
