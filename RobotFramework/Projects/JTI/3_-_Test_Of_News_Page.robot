*** Settings ***
Suite Setup       Setup Test Environment
Suite Teardown    Close Browser
Resource          Keywords/functionalKeywords.robot

*** Test Cases ***
Log In
    [Documentation]    Log into the application with given credentials.
    ...    Expected - user logged in and redirected to index page.
    Log In    ${test user 1 name}    ${test user 1 pwd}

Navigate To News Page
    [Documentation]    Click News button from Top menu
    ...    Expected - Engage site loaded
    Click Main Menu Item    News
    Location Should Be    ${news page url}

Go To News Page
    Go To    ${news page url}

Check My News Popup
    [Documentation]    Click on cog button next to My News title. Popup with filters and tags should open.
    Check My News Popup
    Click Button With Text    Close
    Wait Until Element Is Not Visible    //div[@id="modal_editmyNews"]

Count Number Of Articles
    [Documentation]    Check if there are 10 articles visible on the page.
    Page Should Contain Element    ${article item}    None    INFO    10

Load Articles With Infinite Scroll
    [Documentation]    Scroll To the bottom of the page. Wait for infinite scroll to load more articles.
    Load Articles With Infinite Scroll

Test My News
    [Documentation]    Click My news in sidebar and check filters.
    Click Sidebar Nav Link TestNews    My news
    Wait Until Page Contains Element    ${main content}//*[contains(text(),"My news")]
    Filter News By Tags
    Filter By Filters    ${main content}
    Clear Filters    ${main content}

Test All News
    [Documentation]    Click On All News in sidebar and check filters.
    Click Sidebar Nav Link TestNews    All news
    Comment    Wait Until Page Contains Element    ${main content}//*[contains(text(),"All news")]
    Filter News By Tags
    Filter By Filters    ${main content}
    Clear Filters    ${main content}

Test Corporate News
    [Documentation]    Click on Corporate news and check filters.
    Click Sidebar Nav Link TestNews    Corporate news
    Comment    Wait Until Page Contains Element    ${main content}//*[contains(text(),"My news")]
    Filter News By Tags
    Filter By Filters    ${main content}
    Clear Filters    ${main content}

Test Announcements
    [Documentation]    Click on Announcements in sidebar and check filters.
    Click Sidebar Nav Link TestNews    Announcements
    Comment    Wait Until Page Contains Element    ${main content}//*[contains(text(),"My news")]
    Filter News By Tags
    Filter By Filters    ${main content}
    Clear Filters    ${main content}

Test Jobs
    [Documentation]    Click on Jobs in sidebar and check if there are 3 empty tabs on the page.
    Click Sidebar Nav Link TestNews    Jobs
    Wait Until Page Contains Element    //a[@role="tab" and text()="Job search"]
    Wait Until Page Contains Element    //a[@role="tab" and text()="Candidate"]
    Click Element    //a[@role="tab" and text()="Candidate"]
    Wait Until Page Contains Element    //a[@role="tab" and text()="Job alert"]
    Click Element    //a[@role="tab" and text()="Job alert"]
