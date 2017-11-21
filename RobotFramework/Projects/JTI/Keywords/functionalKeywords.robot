*** Settings ***
Resource          uiKeywords.robot
Resource          ../TestData/testData.robot

*** Keywords ***
Login
    [Arguments]    ${username}    ${password}
    [Documentation]    Description - Check if Login page works correctly.
    ...    Expected - Users should be able to log in with given user name and password.
    Open Browser    ${url}    ${browser}
    SetTextBoxValueForm    User name:    ${username}
    SetTextBoxValueForm    Password:    ${password}
    ClickOnButtonText    Log On
    Wait Until Page Contains Element    //img[@id='insideLogo']    10

Open My News Popup And Set Tags
    [Documentation]    Description - Click to cog button near My news title of webpart
    ...    Expected - Content of Manage my news is loaded in popup
    ${cogButton} =    Set Variable    //section[contains(@class,'mynews')]//h1[@class='sectionTitle']//a[@class='edit']
    ${modal} =    Set Variable    //div[@id="modal_editmyNews"]
    ClickOnElement    ${cogButton}
    Wait Until Page Contains Element    ${modal}
    CheckButtonText    Close    ${modal}
    CheckButtonText    Save changes    ${modal}
    Check My News Popup Tabs And Add Tags
    Add New Tag To My News Modal

Check Engage Part
    [Documentation]    Descrtiption - Check if right panel with title "ENGAGE" exists.
    ${container}    Set Variable    //section[contains(@class,'engagepart')]
    Wait Until Page Contains Element    ${container}//span[contains(@title, "ENGAGE")]
    Wait Until Page Contains Element    ${container}
    Check Sticky Engage

Check My News Popup Tabs And Add Tags
    [Documentation]    Description - Checks if all tabs are present in the modal window. Clicks on a fev checkoxes.
    ...    Expected - Tabs should be visible when the modal window opens. Clicked checkboxes should appear as new tags in the tags list.
    ${modal} =    Set Variable    //div[@id="modal_editmyNews"]
    ${tablist} =    Set Variable    ${modal}//ul[@class="nav nav-tabs"]
    Wait Until Page Contains Element    ${tablist}
    CheckTab    Markets    ${modal}
    CheckTab    Departments    ${modal}
    CheckTab    Brands    ${modal}
    CheckTab    Regions    ${modal}
    UncheckCheckBox    Andorra    ${modal}
    UncheckCheckBox    Canary Island    ${modal}
    UncheckCheckBox    Spain    ${modal}
    ClickCheckBox    Andorra    ${modal}
    ClickCheckBox    Canary Island    ${modal}
    ClickCheckBox    Spain    ${modal}
    CheckTag    Andorra    ${modal}
    CheckTag    Canary Island    ${modal}
    CheckTag    Spain    ${modal}

Add New Tag To My News Modal
    [Documentation]    Description - Writes a keyword to the tags input, then clicks on the element in the resulted list
    ...    Expected - Added tag should be appened to the tags list
    ${container} =    Set Variable    //div[@id="modal_editmyNews"]
    ${results} =    Set Variable    ${container}//div[@id='myNewsTagsResults']
    ${tagsinput} =    Set Variable    ${container}//input[@type='text' and @id='myNewsTags']
    ${keyword} =    Set Variable    L&M
    Wait Until Page Contains Element    ${container}
    Click On Element    ${tagsinput}
    SetTextBoxValueElement    ${tagsinput}    ${keyword}
    Wait Until Element Is Visible    ${results}
    Click On Element    ${results}//div[text()='${keyword}']
    CheckTag    ${keyword}    ${container}
    [Teardown]    Click On Element    ${results}//div[contains(@class,'pill')]//span[text()='${keyword}']/../span[@class='glyphicon glyphicon-close']

Check My News Part
    [Documentation]    Description - Check if My news section exists with title "My news". Check if the gear icon works, and modal functions in the popup working properly.
    Wait Until Page Contains Element    //section[contains(@class,'mynews')]
    Open My News Popup And Set Tags
    Reload Page
    Check If There Are 10 Articles In My News
    Check Infinite Scroll

Check Corporate News Part
    [Documentation]    Check If Corporate News section exists. Check if there's 3 news in the corporate news section.
    ${container} =    Set Variable    //section[@class='featured']
    Wait Until Page Contains Element    ${container}//a[contains(text(),'Corporate news')]
    XPath Should Match X Times    ${container}//div[@class="caption captionNews"]    3

Check Main Navigation
    [Documentation]    Check if main navigation is loaded by checking the container, profile pic and level 0 menu items.
    Wait Until Page Contains Element    //nav[contains(@class,'top-navigation-header')]
    Wait Until Page Contains Element    //li[@id="jtiMyProfile"]//img
    Check If Menu Item Exists    My pages
    Check If Menu Item Exists     Engage
    Check If Menu Item Exists     News
    Check If Menu Item Exists     Resources

Check If There Are 10 Articles In My News
    Xpath Should Match X Times    //ul[@id="ms-srch-result-groups-VisibleOutput"]//div[@class="articleListItem"]    10

Check Infinite Scroll
    [Documentation]    Description - Check if articles are loaded if we scroll to the bottom of the page.
    ...    Expected - More articles are present than originally. (more than 10).
    Scroll To Bottom
    Wait Until Keyword Succeeds    1 min    0.5 sec    Check If Articles Loaded

Check If Articles Loaded
    [Documentation]    Returns true if additional articles are loaded. (more than 10 articles are present).
    ${count} =    Get Matching Xpath Count    //ul[@id="ms-srch-result-groups-VisibleOutput"]//div[@class="articleListItem"]
    Should Be True    ${count} > 10

Check Sticky Engage
    [Documentation]    Description - Check if engage secation sticks to the top when we scroll down (only on desktop)
    ...    Expected - Element should be fixed and visible in viewport when scrolled down. Element should not be fixed when scrolled to the top.
    ${container}=    Set Variable    //section[contains(@class,'engagepart')]
    Maximize Browser Window
    Scroll To Bottom
    ${elementIsInViewport} =    IsElementInViewport    ${container}
    Should Be True    ${elementIsInViewport}
    ${elementIsFixed}    IsElementFixed    ${container}
    Should Be True    ${elementIsFixed}
    Scroll To Top
    ${elementIsFixed}    IsElementFixed    ${container}
    Should Not Be True    ${elementIsFixed}
