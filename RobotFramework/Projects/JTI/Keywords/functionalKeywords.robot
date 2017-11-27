*** Settings ***
Resource          uiKeywords.robot

*** Keywords ***
Login
    [Arguments]    ${username}    ${password}
    [Documentation]    Check if Login page works correctly.
    ...    Expected - Users should be able to log in with given user name and password.
    Set Text Box Form Value    User name:    ${username}
    Set Text Box Form Value    Password:    ${password}
    Click Input Button With Value    Log On
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

Setup Test Environment
    Open Browser    ${index page url}    ${browser}
    Maximize Browser Window
    ${time}=    Get Time    epoch
    Set Global Variable    ${current timestamp}    ${time}

Search For Keyword
    [Arguments]    ${keyword}
    ${index page input}=    Set Variable    //nav[not(@id="mobileNav")]//div[@id="SearchBox"]//input
    Set Text Box Element Value    ${index page input}    ${keyword}
    Press Key    ${index page input}    \\13

Check Search Page Elements
    [Arguments]    ${keyword}
    ${search navigation bar}=    Set Variable    //section[@class="secondaryTopNav"]
    ${search page input}=    Set Variable    ${search navigation bar}//input
    Wait Until Page Contains Element    ${search page input}
    Textfield Value Should Be    ${search page input}    ${keyword}
    Wait Until Page Contains Element    //div[@class="searchResultsLists"]
    Wait Until Element Contains    ${search navigation bar}    All content
    Element Should Contain    ${search navigation bar}    News
    Element Should Contain    ${search navigation bar}    Resources
    Element Should Contain    ${search navigation bar}    People
    Element Should Contain    ${search navigation bar}    Communities

Check If Global Menu Is Loaded
    Wait Until Page Contains Element    ${main menu}
    Wait Until Page Contains Element    //nav[contains(@class,'top-navigation-header')]
    Wait Until Page Contains Element    //li[@id="jtiMyProfile"]//img
    Check If Menu Item Exists    My pages
    Check If Menu Item Exists    Engage
    Check If Menu Item Exists    News
    Check If Menu Item Exists    Resources

Join 12 Communities
