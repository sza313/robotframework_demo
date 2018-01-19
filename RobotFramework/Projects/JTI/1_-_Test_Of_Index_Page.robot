*** Settings ***
Suite Setup       Setup Test Environment
Suite Teardown    Close Browser
Resource          Keywords/functionalKeywords.robot

*** Test Cases ***
Log In
    [Documentation]    Log into the application with given credentials.
    ...    Expected - user logged in and redirected to index page.
    Log In    ${test user 1 name}    ${test user 1 pwd}

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
    Check My News Popup

Add Tag Via Text Field In My News Popup
    [Documentation]    Click to text field "+add" and type any tag e.g. L&M -> Select tag from dropdown
    ...    Expocted - Tag was found and added
    Wait Until Keyword Succeeds    30 secs    0.5 secs    Add Suggested Tag    Lucky Strike    //div[@id="modal_editmyNews"]
    Remove Tag    Lucky Strike

Add Tags Via Tabs In My News Popup
    [Documentation]    Click on checkboxes in the tabs in My News popup.
    ...    Expected - Tags are added with same name to the tags list.
    [Setup]    Unset Tags
    ${modal} =    Set Variable    //div[@id="modal_editmyNews"]
    Click Check Box By Label    Andorra    ${modal}
    Click Check Box By Label    Canary Island    ${modal}
    Click Check Box By Label    Spain    ${modal}
    Check Tag By Name    Andorra    ${modal}
    Check Tag By Name    Canary Island    ${modal}
    Check Tag By Name    Spain    ${modal}
    Remove Tag    Andorra
    Remove Tag    Canary Island
    Remove Tag    Spain

Reload Page
    [Documentation]    Reload page
    ...    Expected - Site should be reloaded
    Reload Page

Count Number Of Articles
    [Documentation]    Check If there are 10 articles in news list in my news section.
    Page Should Contain Element    ${article item}    \    \    10

Load Articles With Infinite Scroll
    [Documentation]    Scroll down and wait for infinite scroll to load articles
    ...    Expected - Articles should be loaded (articles count is more than 10 now)
    Load Articles With Infinite Scroll

Check Engage Part Sticky Behaviour
    [Documentation]    Engage part should be sticky when scrolled down.
    ...    Expected - Engage part is visible and has fixed position.
    ${container}=    Set Variable    //section[contains(@class,'engagepart')]
    Go To    https://insidetest.jti.com
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
    Open SharePoint Menu

Hide SharePoint Menu
    [Documentation]    Click to Edit button again
    ...    Expected - SP menu disappears
    Close SharePoint Menu

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
    Wait Until Page Contains Element    //nav[not(@id="mobileNav")]//div[@id="SearchBox"]//input
    Input Text    //nav[not(@id="mobileNav")]//div[@id="SearchBox"]//input    test
    Press Key    //nav[not(@id="mobileNav")]//div[@id="SearchBox"]//input    \\13
    Check Search Page Elements    test
    ${results count}    Set Variable    //div[@id="ResultCount"]
    Element Should Contain    ${results count}    ABOUT
    Element Should Contain    ${results count}    RESULTS

Test Search With No Results
    [Documentation]    Click to Seachbox in Top menu and type e.g."asdfg" and press Enter.
    ...    Expected - Redirected to results page with NO results.
    Go To    ${index page url}
    Wait Until Page Contains Element    //nav[not(@id="mobileNav")]//div[@id="SearchBox"]//input
    Input Text    //nav[not(@id="mobileNav")]//div[@id="SearchBox"]//input    asdfg
    Press Key    //nav[not(@id="mobileNav")]//div[@id="SearchBox"]//input    \\13
    Check Search Page Elements    asdfg
    Wait Until Element Contains    //div[@id="NoResult"]    Sorry, no results matching your search query
