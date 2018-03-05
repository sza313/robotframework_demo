*** Settings ***
Resource          uiKeywords.robot

*** Keywords ***
Add A Post On My Profle Page
    Generate Timestamp
    Input Text    //div[@id="ngPostControl"]//textarea    TestPost_${test user 1 name}_${current timestamp}
    Click Button With Text    Post    //div[@id="ngPostControl"]
    Wait Until Page Contains    TestPost_${test user 1 name}_${current timestamp}

Add Suggested Tag
    [Arguments]    ${keyword}    ${container}
    ${results} =    Set Variable    ${container}//div[@id='myNewsTagsResults']
    ${tagsinput} =    Set Variable    ${container}//input[@type='text' and @id='myNewsTags']
    Clear Element Text    ${tagsinput}
    Input Text    ${tagsinput}    ${keyword}
    Wait Until Element Is Visible    ${results}    2 secs
    Click Element    ${results}//div[text()='${keyword}']
    Check Tag By Name    ${keyword}    ${container}

Add Tag
    [Arguments]    ${tag name}    ${container}=
    Input Text    ${container}//input[contains(@class,"pillbox-add-item")]    ${tag name}
    Press Key    ${container}//input[contains(@class,"pillbox-add-item")]    \\13
    Wait Until Page Contains Element    ${container}//li[contains(@class,"pill") and ./span[text()="${tag name}"]]

Log In
    [Arguments]    ${username}    ${password}
    [Documentation]    Check if Login page works correctly.
    ...    Expected - Users should be able to log in with given user name and password.
    Go To    ${index page url}
    Set Text Box Form Value    User name:    ${username}
    Set Text Box Form Value    Password:    ${password}
    Click Input Button With Value    Log On
    Wait Until Page Contains Element    //img[@id='insideLogo']    10

Check Community Page Sidebar
    ${sidebar}=    Set Variable    //div[contains(@class,"secondaryInfo")]
    Wait Until Element Contains    ${sidebar}    COMMUNITY OWNERS
    Wait Until Element Contains    ${sidebar}    COMMUNITY FOLLOWERS
    Wait Until Element Contains    ${sidebar}    RECOMMENDED COMMUNITIES
    Wait Until Element Contains    ${sidebar}    AVAILABLE COMMUNITY BADGES

Check External Links
    [Arguments]    ${container}=
    Wait Until Page Contains Element    ${container}
    Click Link    ${container}//a[2]
    Check If New Tab Is Opened

Check Resources Page
    [Arguments]    ${name}
    Click Sidebar Nav Link    ${name}
    Wait Until Element Contains    //div[@class="wrapMain"]    ${name}
    Wait Until Page Contains Element    //div[@class="library-content"]//div[@class="item"]
    Check Resources Page Left Sidebar
    Filter Favorites Library By Tags
    Clear Filters    //div[@class="wrapMain"]
    Filter Favorites Library By Filters    //div[@class="wrapMain"]
    Clear Filters    //div[@class="wrapMain"]
    Check Resources Page Pagination    //div[@class="wrapMain"]
    Check External Links    //h3[text()="Recommended"]/..

Check Resources Page Left Sidebar
    Wait Until Page Contains Link With Text    My favorites
    Wait Until Page Contains Link With Text    Recommended
    Wait Until Page Contains Link With Text    Applications & sites
    Wait Until Page Contains Link With Text    Guidelines & toolkits
    Wait Until Page Contains Link With Text    Policies & procedures
    Wait Until Page Contains Link With Text    Reports & case studies
    Wait Until Page Contains Link With Text    Templates
    Wait Until Page Contains Link With Text    Training

Check Resources Page Pagination
    [Arguments]    ${container}=
    Wait Until Page Contains Pagination    ${container}
    Paginate To    2    ${container}

Check If Articles Loaded
    [Documentation]    Returns true if additional articles are loaded. (more than 10 articles are present).
    Scroll To Bottom
    ${count} =    Get Element Count    ${article item}
    Should Be True    ${count} > 10

Check If Community Is Opened
    [Arguments]    ${name}
    Wait Until Page Contains Element    //h1[text()="${name}"]
    Wait Until Page Contains Element    //div[@id="MyActivityStream"]//a[text()="${name}" and @class="active"]

Check If Community Is Created
    [Arguments]    ${name}
    Go To    ${sp communities list url}
    Log To Console    Community created process is running
    Input Text    id:inplaceSearchDiv_WPQ4_lsinput    Com_${test user 1 name}_${current timestamp}
    Press Key    id:inplaceSearchDiv_WPQ4_lsinput    \\13
    Wait Until Page Contains    Com_${test user 1 name}_${current timestamp}

Check If Global Menu Is Loaded
    Wait Until Page Contains Element    ${main menu}
    Wait Until Page Contains Element    //nav[contains(@class,'top-navigation-header')]
    Wait Until Page Contains Element    //li[@id="jtiMyProfile"]//img
    Check If Menu Item Exists    My pages
    Check If Menu Item Exists    Engage
    Check If Menu Item Exists    News
    Check If Menu Item Exists    Resources

Check If New Tab Is Opened
    [Arguments]    ${title}=""
    ${tabs}=    Get Window Handles
    ${original tab}=    Get From List    ${tabs}    0
    ${new tab}=    Get From List    ${tabs}    1
    Select Window    ${new tab}
    Run Keyword If    ${title} != ""    Wait Until Page Contains    ${title}
    Close Window
    Select Window    ${original tab}

Check If Results Page Tab Loaded
    [Arguments]    ${tab name}    ${item locator}
    Wait Until Page Contains Element    ${item locator}
    Wait Until Search Tab Exists And Highlighted    ${tab name}
    Wait Until Keyword Succeeds    15 secs    0.5 secs    Page Should Contain Element    ${item locator}    None    NONE
    ...    10

Check My News Popup
    ${cogButton} =    Set Variable    //h1[@class='sectionTitle']//a[@class='edit']
    ${modal} =    Set Variable    //div[@id="modal_editmyNews"]
    Click Element    ${cogButton}
    Wait Until Page Contains Element    ${modal}
    Wait Until Page Contains Element    //ul[@id="myNewsFilter"]
    Wait Until Page Contains Element    ${modal}//ul[@class="nav nav-tabs"]
    Sleep    5 secs
    Check Tab    Markets    ${modal}
    Check Tab    Departments    ${modal}
    Check Tab    Brands    ${modal}
    Check Tab    Regions    ${modal}
    Page Should Contain Input Button With Text    Close    ${modal}
    Page Should Contain Input Button With Text    Save changes    ${modal}

Check Pagination
    [Arguments]    ${container}
    Paginate To    2    ${container}
    Page Should Contain Element    ${container}//div[@name="Item"]

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

Clear Filters
    [Arguments]    ${container}
    ${unfiltered elements}=    Get WebElements    ${container}//div[@name="Item"]
    Click Link Which Contains    Clear filters
    Wait Until Keyword Succeeds    5 secs    0.5 secs    Check If WebElements Are Not Equal    ${unfiltered elements}    ${container}//div[@name="Item"]

Click Communities Tab
    [Arguments]    ${text}
    Scroll To Top
    Click Link Which Contains    ${text}    ${community tabs}

Click Edit Profile Page Nav Link
    [Arguments]    ${link text}    ${panel title}    # link text - link we want to click in sidebar navigation | panel title - activated panel's name should match this.
    ${nav link}=    Set Variable    //div[contains(@class,"navParam")]/a[contains(text(),"${link text}")]
    Wait Until Page Contains Element    ${nav link}
    Click Element    ${nav link}
    Wait Until Element Is Visible    //h3[contains(text(),"${panel title}")]/ancestor::div[@class="panel panel-default"]    # panel who's name is ${panel title} should be visible in viewport
    Wait Until Page Contains Element    //div[contains(@class,"navParam")]/a[contains(text(),"${link text}") and contains(@class,"active")]    # nav link class should be active

Click On Post Quick Menu Item
    [Arguments]    ${post}    ${menu item}    # post element locator | menu item text
    Mouse Over    ${post}
    Wait Until Element Is Visible    ${post}//div[@class="ngHiddenActions"]/a
    Scroll Element Into View    ${post}
    Click Element    ${post}//div[@class="ngHiddenActions"]/a
    Wait Until Element Is Visible    ${post}//div[@class="ngHiddenActions"]//li[text()="${menu item}"]
    Click Element    ${post}//div[@class="ngHiddenActions"]//li[text()="${menu item}"]

Click On Recommended Link
    Click Element    //div[@class="quick-links" and ./h3[text()="Recommended"]]//a
    Check If New Tab Is Opened

Click Profile Menu Item
    [Arguments]    ${name}
    Click Link Which Contains    ${name}    //li[@id="jtiMyProfile"]

Filter By Filters
    [Arguments]    ${container}
    Set Filter    Brand    \    ${container}
    Set Filter    Department    \    ${container}
    Set Filter    Market    \    ${container}
    Set Filter    Language    \    ${container}

Filter Favorites Library By Tags
    Scroll To Top
    ${tag}=    Set Variable    //div[@refinername="RefinerTaRTags"]//*[@name="Item"]/a
    ${tag name}=    Get Text    ${tag}
    Click Element    ${tag}
    Wait Until Page Does Not Contain Element    //div[contains(@class,"doc-item") and not(.//div[@class="tags"]/ul/li[contains(text(),"${tag name}")])]

Filter Favorites Library By Filters
    [Arguments]    ${container}=
    Click Button With Text    Department
    ${unfiltered documents}=    Get WebElements    ${container}//div[@class="item"]
    Click Link Which Contains    Anti-Illicit Trade
    Wait Until Keyword Succeeds    5 secs    0.5 secs    Check If WebElements Are Not Equal    ${unfiltered documents}    ${container}//div[@class="item"]

Filter News By Tags
    Scroll To Top
    ${tag}=    Set Variable    //label[text()="Filter by tags:"]/parent::div[@class="tags"]//*[@name="Item"]/a
    ${tag name}=    Get Text    ${tag}
    Click Element    ${tag}
    Wait Until Page Does Not Contain Element    //ul[@id="ms-srch-result-groups-VisibleOutput"]//div[contains(@class,"tags") and not(a[text()="${tag name}"])]/ancestor::div[contains(@class,"articleListItem")]

Filter Search Results By Any Sidebar Filter
    [Arguments]    ${result item locator}
    ${unfiltered elements}=    Get WebElements    ${result item locator}
    Click Link    //a[@id="FilterLink"]
    Wait Until Keyword Succeeds    5 secs    0.5 secs    Check If WebElements Are Not Equal    ${unfiltered elements}    ${result item locator}
    Page Should Not Contain    Sorry, something went wrong.

Generate Timestamp
    ${time}=    Get Time    epoch
    Set Global Variable    ${current timestamp}    ${time}

Go To Fixed Community Access Request Page
    Go To    ${fixed community pending requests url}
    Wait Until Page Contains    Access Requests

Join A Community
    [Arguments]    ${container}
    ${button}=    Set Variable    ${container}//button[text()="Join"]
    Wait Until Page Contains Element    ${button}
    ${button}=    Get WebElement    ${button}
    Scroll Element Into View    ${container}//button[text()="Join"]
    Click Element    ${button}
    Mouse Over    ${main menu}
    Wait Until Element Contains    ${button}    Following

Join Community
    [Arguments]    ${name}
    Search For Community    ${name}
    ${button}=    Set Variable    //div[@id="allCommunitiesWebPart"]//a/h4[text()="${name}"]//ancestor::div[@name="Item"]//button[text()="Join"]
    Wait Until Page Contains Element    ${button}
    ${button}=    Get WebElement    ${button}
    Click Element    ${button}
    Mouse Out    ${button}
    Wait Until Element Contains    ${button}    Following

Leave A Community
    [Arguments]    ${container}=
    ${button}=    Set Variable    ${container}//button/descendant-or-self::*[contains(text(),"Following")]/ancestor-or-self::button
    Wait Until Page Contains Element    ${button}
    Scroll Element Into View    ${button}
    ${button}=    Get WebElement    ${button}
    Click Element    ${button}
    Wait Until Element Contains    ${button}    Join

Leave A Community And Fail If More Left
    [Arguments]    ${container}
    ${button}=    Set Variable    ${container}//button/descendant-or-self::*[contains(text(),"Following")]/ancestor-or-self::button
    ${button count}=    Get Element Count    ${button}
    Run Keyword If    ${button count} > 0    Leave A Community    ${container}
    Page Should Contain Element    ${button}    None    INFO    0

Load Articles With Infinite Scroll
    Wait Until Keyword Succeeds    1 min    0.5 sec    Check If Articles Loaded
    Scroll To Top

Log Out
    Go To    ${index page url}
    Open Profile Menu
    Click Profile Menu Item    Log out
    Click Log Out Button
    Delete All Cookies

Paginate To
    [Arguments]    ${page number}    ${container}
    ${unfiltered elements}=    Get WebElements    ${container}//div[@name="Item"]
    Wait Until Page Contains Element    ${container}//a[@title="Move to page ${page number}"]
    Scroll Element Into View    ${container}//a[@title="Move to page ${page number}"]
    Wait Until Keyword Succeeds    15 sec    0.5 sec    Click Element    ${container}//a[@title="Move to page ${page number}"]
    Wait Until Keyword Succeeds    5 secs    0.5 secs    Check If WebElements Are Not Equal    ${unfiltered elements}    ${container}//div[@name="Item"]

Request To Join A Community
    Search For Community    ${fixed community}
    Click Button With Text    Request to join    ${all communities tab}
    Wait Until Page Contains    You’ve just tried to access a private community
    Click Link Which Contains    I’d like access to this private community.
    Wait Until Page Contains    Request Access
    Wait Until Page Contains Element    tag:textarea
    Input Text    tag:textarea    ${test user 1 name}_${current timestamp}
    Click Element    //input[@type="submit"]
    Wait Until Page Contains    Your access request has been sent.

Remove Tag
    [Arguments]    ${tag name}    ${container}=
    Click Element    ${container}//li[contains(@class,"pill") and ./span[text()="${tag name}"]]/span[@class="glyphicon glyphicon-close"]
    Wait Until Page Does Not Contain Element    ${container}//li[contains(@class,"pill") and ./span[text()="${tag name}"]]

Save Profile Page
    [Documentation]    Clicks on the "Save" button on the profile page and reloads page.
    Click Button With Text    Save changes
    Wait Until Element Contains    //div[@class="innersaveBar"]    User profile updated    20
    Sleep    3 secs
    Reload Page
    Wait Until Page Contains    ${test user 1 name}
    Sleep    10 secs

Search For Community
    [Arguments]    ${name}
    ${search filed}=    Set Variable    ${all communities tab}//input[@type="text"]
    Input Text    ${search filed}    ${name}
    Press Key    ${search filed}    \\13
    Wait Until Page Contains Element    ${all communities tab}//a/h4[text()="${name}"]/..

Search For Keyword
    [Arguments]    ${keyword}
    ${index page input}=    Set Variable    //nav[not(@id="mobileNav")]//div[@id="SearchBox"]//input
    Set Text Box Element Value    ${index page input}    ${keyword}
    Press Key    ${index page input}    \\13

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

Setup Test Environment
    Open Browser    ${index page url}    ${browser}
    Set Window Size    1920    1080
    ${time}=    Get Time    epoch
    Set Global Variable    ${current timestamp}    ${time}
    Set Selenium Timeout    15

Unfollow All Communities
    Click Communities Tab    My communities
    Wait Until Keyword Succeeds    1 min    0 secs    Leave A Community And Fail If More Left    ${my communities tab}
    Reload Page
    Wait Until Keyword Succeeds    1 min    0 secs    Leave A Community And Fail If More Left    ${my communities tab}

Unset Tags
    ${modal} =    Set Variable    //div[@id="modal_editmyNews"]
    Unselect Check Box By Label    Andorra    ${modal}
    Unselect Check Box By Label    Canary Island    ${modal}
    Unselect Check Box By Label    Spain    ${modal}
