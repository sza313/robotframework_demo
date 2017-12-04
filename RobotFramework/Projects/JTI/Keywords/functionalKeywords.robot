*** Settings ***
Resource          uiKeywords.robot

*** Keywords ***
Log In
    [Arguments]    ${username}    ${password}
    [Documentation]    Check if Login page works correctly.
    ...    Expected - Users should be able to log in with given user name and password.
    Go To    ${index page url}
    Set Text Box Form Value    User name:    ${username}
    Set Text Box Form Value    Password:    ${password}
    Click Input Button With Value    Log On
    Wait Until Page Contains Element    //img[@id='insideLogo']    10

Log Out
    Go To    ${index page url}
    Open Profile Menu
    Click Profile Menu Item    Log out
    Click Log Out Button
    Delete All Cookies

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
    Set Selenium Timeout    15

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

Join A Community
    [Arguments]    ${container}
    ${button}=    Set Variable    ${container}//button[text()="Join"]
    Wait Until Page Contains Element    ${button}
    ${button}=    Get WebElement    ${button}
    Click Element    ${button}
    Mouse Out    ${button}
    Wait Until Element Contains    ${button}    Following

Set Community Filter
    [Arguments]    ${filter}    ${option}    ${container}
    ${unfiltered elements}=    Get WebElements    ${container}//div[@name="Item"]
    Click Button With Text    ${filter}    ${container}
    Click Link Which Contains    ${option}    ${container}
    Wait Until Keyword Succeeds    5 secs    0.5 secs    Check If WebElements Are Not Equal    ${unfiltered elements}    ${container}//div[@name="Item"]

Clear Community Filters
    [Arguments]    ${container}
    ${unfiltered elements}=    Get WebElements    ${container}//div[@name="Item"]
    Click Link Which Contains    Clear filters    ${community tabs}
    Wait Until Keyword Succeeds    5 secs    0.5 secs    Check If WebElements Are Not Equal    ${unfiltered elements}    ${container}//div[@name="Item"]

Leave A Community
    [Arguments]    ${container}=
    ${button}=    Set Variable    ${container}//button/descendant-or-self::*[contains(text(),"Following")]/ancestor-or-self::button
    Wait Until Page Contains Element    ${button}
    ${button}=    Get WebElement    ${button}
    Click Element    ${button}
    Wait Until Element Contains    ${button}    Join

Check Pagination
    [Arguments]    ${container}
    Paginate To    2    ${container}
    Page Should Contain Element    ${container}//div[@name="Item"]

Navigate To All Communities Page
    Scroll To Top
    Click Communities Nav Link    All communities
    Wait Until Element Contains    ${community tabs}    All communities
    Wait Until Element Contains    ${community tabs}    My communities
    Wait Until Element Contains    ${community tabs}    Create a community
    Link Should Have Class    All communities    active

Paginate To
    [Arguments]    ${page number}    ${container}
    Scroll To Bottom
    ${unfiltered elements}=    Get WebElements    ${container}//div[@name="Item"]
    Wait Until Page Contains Element    //a[@title="Move to page ${page number}"]
    Wait Until Keyword Succeeds    15 sec    0.5 sec    Click Element    //a[@title="Move to page ${page number}"]
    Wait Until Keyword Succeeds    5 secs    0.5 secs    Check If WebElements Are Not Equal    ${unfiltered elements}    ${container}//div[@name="Item"]

Click Communities Tab
    [Arguments]    ${text}
    Scroll To Top
    Click Link Which Contains    ${text}    ${community tabs}

Search For Community
    [Arguments]    ${name}
    ${search filed}=    Set Variable    ${all communities tab}//input[@type="text"]
    Input Text    ${search filed}    ${name}
    Press Key    ${search filed}    \\13
    Wait Until Page Contains Element    ${all communities tab}//a/h4[text()="${name}"]/..

Join Community
    [Arguments]    ${name}
    Search For Community    ${name}
    ${button}=    Set Variable    //div[@id="allCommunitiesWebPart"]//a/h4[text()="${name}"]//ancestor::div[@name="Item"]//button[text()="Join"]
    Wait Until Page Contains Element    ${button}
    ${button}=    Get WebElement    ${button}
    Click Element    ${button}
    Mouse Out    ${button}
    Wait Until Element Contains    ${button}    Following

Check If Community Is Opened
    [Arguments]    ${name}
    Wait Until Page Contains Element    //h1[text()="${name}"]
    Wait Until Page Contains Element    //div[@id="MyActivityStream"]//a[text()="${name}" and @class="active"]

Check Community Page Sidebar
    ${sidebar}=    Set Variable    //div[contains(@class,"secondaryInfo")]
    Wait Until Element Contains    ${sidebar}    COMMUNITY OWNERS
    Wait Until Element Contains    ${sidebar}    COMMUNITY FOLLOWERS
    Wait Until Element Contains    ${sidebar}    RECOMMENDED COMMUNITIES
    Wait Until Element Contains    ${sidebar}    AVAILABLE COMMUNITY BADGES

Check If New Tab Is Opened With Title
    [Arguments]    ${title}
    ${tabs}=    Get Window Handles
    ${original tab}=    Get From List    ${tabs}    0
    ${new tab}=    Get From List    ${tabs}    1
    Select Window    ${new tab}
    Wait Until Page Contains    ${title}
    Close Window
    Select Window    ${original tab}

Request To Join A Community
    Search For Community    ${fixed community}
    Click Button With Text    Request to join    ${all communities tab}
    Wait Until Page Contains Element    tag:textarea
    Input Text    tag:textarea    ${surname}_${current timestamp}
    Click Element    //input[@type="submit"]
    Wait Until Page Contains Element    //div[@class="ms-accessRequestsControl-message" and contains(text(),"${surname}_${current timestamp}")]

Click Profile Menu Item
    [Arguments]    ${name}
    Click Link Which Contains    ${name}    //li[@id="jtiMyProfile"]

Go To Fixed Community Access Request Page
    Go To    ${fixed community pending requests url}
    Wait Until Page Contains    Access Requests
