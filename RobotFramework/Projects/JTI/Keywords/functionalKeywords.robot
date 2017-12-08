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
    Scroll To Bottom
    ${count} =    Get Element Count    ${article item}
    Should Be True    ${count} > 10

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

Set Filter
    [Arguments]    ${filter}    ${option}=    ${container}=
    ${unfiltered elements}=    Get WebElements    ${container}//div[@name="Item"]
    ${filter button}=    Set Variable    ${container}//button/descendant-or-self::*[contains(text(),"${filter}")]
    ${suggestions}=    Set Variable    ${filter button}/../ul[@class="dropdown-menu"]
    Click Element    ${filter button}
    Wait Until Page Contains Element    ${suggestions}
    Run Keyword If    "${option}"=="${EMPTY}"    Click Element    (${suggestions}//a)[1]
    Run Keyword If    "${option}"!="${EMPTY}"    Click Element    ${suggestions}//a[text()="${option}"]
    Wait Until Keyword Succeeds    5 secs    0.5 secs    Check If WebElements Are Not Equal    ${unfiltered elements}    ${container}//div[@name="Item"]

Clear Filters
    [Arguments]    ${container}
    ${unfiltered elements}=    Get WebElements    ${container}//div[@name="Item"]
    Click Link Which Contains    Clear filters
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
    Input Text    tag:textarea    ${test user 1 name}_${current timestamp}
    Click Element    //input[@type="submit"]
    Wait Until Page Contains Element    //div[@class="ms-accessRequestsControl-message" and contains(text(),"${test user 1 name}_${current timestamp}")]

Click Profile Menu Item
    [Arguments]    ${name}
    Click Link Which Contains    ${name}    //li[@id="jtiMyProfile"]

Go To Fixed Community Access Request Page
    Go To    ${fixed community pending requests url}
    Wait Until Page Contains    Access Requests

Check If Community Is Created
    [Arguments]    ${name}
    Go To    ${sp communities list url}
    Input Text    id:inplaceSearchDiv_WPQ4_lsinput    Com_${test user 1 name}_${current timestamp}
    Press Key    id:inplaceSearchDiv_WPQ4_lsinput    \\13
    Wait Until Page Contains    Com_${test user 1 name}_${current timestamp}

Leave A Community And Fail If More Left
    [Arguments]    ${container}
    ${button}=    Set Variable    ${container}//button/descendant-or-self::*[contains(text(),"Following")]/ancestor-or-self::button
    ${button count}=    Get Element Count    ${button}
    Run Keyword If    ${button count} > 0    Leave A Community    ${container}
    Page Should Contain Element    ${button}    None    INFO    0

Unfollow All Communities
    Click Communities Tab    My communities
    Wait Until Keyword Succeeds    1 min    0 secs    Leave A Community And Fail If More Left    ${my communities tab}
    Reload Page
    Wait Until Keyword Succeeds    1 min    0 secs    Leave A Community And Fail If More Left    ${my communities tab}

Check My News Popup
    ${cogButton} =    Set Variable    //h1[@class='sectionTitle']//a[@class='edit']
    ${modal} =    Set Variable    //div[@id="modal_editmyNews"]
    Click Element    ${cogButton}
    Wait Until Page Contains Element    ${modal}
    Wait Until Page Contains Element    //ul[@id="myNewsFilter"]
    Wait Until Page Contains Element    ${modal}//ul[@class="nav nav-tabs"]
    Check Tab    Markets    ${modal}
    Check Tab    Departments    ${modal}
    Check Tab    Brands    ${modal}
    Check Tab    Regions    ${modal}
    Page Should Contain Input Button With Text    Close    ${modal}
    Page Should Contain Input Button With Text    Save changes    ${modal}

Load Articles With Infinite Scroll
    Wait Until Keyword Succeeds    1 min    0.5 sec    Check If Articles Loaded
    Scroll To Top

Filter By Tags
    Scroll To Top
    ${tag}=    Set Variable    //label[text()="Filter by tags:"]/parent::div[@class="tags"]//*[@name="Item"]/a
    ${tag name}=    Get Text    ${tag}
    Click Element    ${tag}
    Wait Until Page Does Not Contain Element    //ul[@id="ms-srch-result-groups-VisibleOutput"]//div[contains(@class,"tags") and not(a[text()="${tag name}"])]/ancestor::div[contains(@class,"articleListItem")]

Filter By Filters
    [Arguments]    ${container}
    Set Filter    Brand    \    ${container}
    Set Filter    Department    \    ${container}
    Set Filter    Market    \    ${container}
    Set Filter    Language    \    ${container}

Check If Results Page Tab Loaded
    [Arguments]    ${tab name}    ${item locator}
    Wait Until Page Contains Element    ${item locator}
    Wait Until Search Tab Exists And Highlighted    ${tab name}
    Wait Until Keyword Succeeds    15 secs    0.5 secs    Page Should Contain Element    ${item locator}    None    NONE
    ...    10

Filter Search Results By Any Sidebar Filter
    [Arguments]    ${result item locator}
    ${unfiltered elements}=    Get WebElements    ${result item locator}
    Click Link    //a[@id="FilterLink"]
    Wait Until Keyword Succeeds    5 secs    0.5 secs    Check If WebElements Are Not Equal    ${unfiltered elements}    ${result item locator}
    Page Should Not Contain    Sorry, something went wrong.
