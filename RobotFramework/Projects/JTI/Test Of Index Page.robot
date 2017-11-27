*** Settings ***
Suite Setup       Setup Test Environment
Resource          Keywords/functionalKeywords.robot

*** Test Cases ***
Login
    [Documentation]    Log into the application with given credentials.
    ...    Expected - user logged in and redirected to index page.
    [Template]    Login
    ${CURRENT_TEST_USER}    ${PWD}

Check Global Menu Is Loaded
    [Documentation]    Check if main navigation is loaded by checking the container, profile pic and level 0 menu items.
    Check If Global Menu Is Loaded

Check if Corporate News Is Loaded
    [Documentation]    Check If Corporate News section exists.
    ...    Expected - Check if there's 3 news in the corporate news section.
    ${container} =    Set Variable    //section[@class='featured']
    Wait Until Page Contains Element    ${container}//a[contains(text(),'Corporate news')]
    XPath Should Match X Times    ${container}//div[@class="caption captionNews"]    3

Check If My News Is Loaded
    [Documentation]    Check if My news section exists with title "My news".
    Wait Until Page Contains Element    //section[contains(@class,'mynews')]//a[text()="My news"]

Check if Engage Is Loaded
    [Documentation]    Check if Engage section is loaed.
    Wait Until Page Contains Element    //section[contains(@class,'engagepart')]//span[contains(@title, "ENGAGE")]

Open My News Popup With Cog Button
    [Documentation]    Click on cog button in my news section.
    ...    Expected - My news modal window should pop up with contents loaded.
    ${cogButton} =    Set Variable    //section[contains(@class,'mynews')]//h1[@class='sectionTitle']//a[@class='edit']
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

Add Tag Via Text Field In My News Popup
    [Documentation]    Click to text field "+add" and type any tag e.g. L&M -> Select tag from dropdown
    ...    Expocted - Tag was found and added
    ${container} =    Set Variable    //div[@id="modal_editmyNews"]
    ${results} =    Set Variable    ${container}//div[@id='myNewsTagsResults']
    ${tagsinput} =    Set Variable    ${container}//input[@type='text' and @id='myNewsTags']
    ${keyword} =    Set Variable    L&M
    Click Element    ${tagsinput}
    Set Text Box Element Value    ${tagsinput}    ${keyword}
    Wait Until Element Is Visible    ${results}
    Click Element    ${results}//div[text()='${keyword}']
    Check Tag By Name    ${keyword}    ${container}

Add Tags Via Tabs In My News Popup
    [Documentation]    Click on checkboxes in the tabs in My News popup.
    ...    Expected - Tags are added with same name to the tags list.
    [Setup]    Unset Tags
    ${modal} =    Set Variable    //div[@id="modal_editmyNews"]
    Click Check Box    Andorra    ${modal}
    Click Check Box    Canary Island    ${modal}
    Click Check Box    Spain    ${modal}
    Check Tag By Name    Andorra    ${modal}
    Check Tag By Name    Canary Island    ${modal}
    Check Tag By Name    Spain    ${modal}

Reload Page
    [Documentation]    Reload page
    ...    Expected - Site should be reloaded
    Reload Page

Check Number Of Articles
    [Documentation]    Check If there are 10 articles in news list in my news section.
    Xpath Should Match X Times    //ul[@id="ms-srch-result-groups-VisibleOutput"]//div[@class="articleListItem"]    10

Load Articles With Infinite Scroll
    [Documentation]    Scroll down and wait for infinite scroll to load articles
    ...    Expected - Articles should be loaded (articles count is more than 10 now)
    Scroll To Bottom
    Wait Until Keyword Succeeds    1 min    0.5 sec    Check If Articles Loaded
    ${count} =    Get Matching Xpath Count    //ul[@id="ms-srch-result-groups-VisibleOutput"]//div[@class="articleListItem"]
    Should Be True    ${count} > 10

Check Engage Part Sticky Behaviour
    [Documentation]    Engage part should be sticky when scrolled down.
    ...    Expected - Engage part is visible and has fixed position.
    ${container}=    Set Variable    //section[contains(@class,'engagepart')]
    Scroll To Bottom
    ${elementIsInViewport} =    Get Is Element In Viewport    ${container}
    Should Be True    ${elementIsInViewport}
    ${elementIsFixed}    Get Is Element Fixed    ${container}
    Should Be True    ${elementIsFixed}

Check Engage Part Normal Behaviour
    [Documentation]    Engage part should not be sticky when scrolled tot the top.
    ...    Expected - Engage part should NOT be fixed, and maybe visible.
    ${container}=    Set Variable    //section[contains(@class,'engagepart')]
    Scroll To Top
    ${elementIsFixed}    Get Is Element Fixed    ${container}
    Should Not Be True    ${elementIsFixed}

Show SharePoint Menu
    [Documentation]    Click to Edit button on the right site of top menu
    ...    Expected - SharePoint menu appears above top menu
    Click Element    //a[@class="toolsButton"]
    Wait Until Element Is Visible    //div[contains(@class, "sharepointRibbon")]
    Wait Until Element Is Visible    //div[@id="suiteBarRight"]
    Wait Until Element Is Visible    //div[@id="DeltaSPRibbon"]

Hide SharePoint Menu
    [Documentation]    Click to Edit button again
    ...    Expected - SP menu disappears
    Click Element    //a[@class="toolsButton"]
    Wait Until Element Is Not Visible    //div[contains(@class, "sharepointRibbon")]
    Wait Until Element Is Not Visible    //div[@id="suiteBarRight"]
    Wait Until Element Is Not Visible    //div[@id="DeltaSPRibbon"]

Show Notifications
    [Documentation]    Click on Bell icon to shown notices
    ...    Expected - Notices are shown in dropdown menu
    Click Element    //a[@id="notifications-toogle"]
    Wait Until Element Is Visible    //ul[@class="dropdown-menu notifications"]
    Wait Until Page Contains    Notifications

Hide Notofications
    [Documentation]    Click again on Bell icon to hide notices
    ...    Expected - notices are hidden
    Click Element    //a[@id="notifications-toogle"]
    Wait Until Element Is Not Visible    //ul[@class="dropdown-menu notifications"]

Test Search With Results
    [Documentation]    Click to Seachbox in Top menu and type e.g."test" and press Enter.
    ...    Expected - Redirected to results page with correct results.
    Go To    ${index page url}
    Search For Keyword    test
    Check Search Page Elements    test
    ${results count}    Set Variable    //div[@id="ResultCount"]
    Element Should Contain    ${results count}    ABOUT
    Element Should Contain    ${results count}    RESULTS

Test Search With No Results
    [Documentation]    Click to Seachbox in Top menu and type e.g."asdfg" and press Enter.
    ...    Expected - Redirected to results page with NO results.
    Go To    ${index page url}
    Search For Keyword    asdfg
    Check Search Page Elements    asdfg
    Wait Until Element Contains    //div[@id="NoResult"]    Sorry, no results matching your search query
