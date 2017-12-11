*** Settings ***
Suite Setup       Setup Test Environment
Suite Teardown    Close Browser
Resource          Keywords/functionalKeywords.robot

*** Test Cases ***
Log In And Go To Resources Results Page
    [Documentation]    Log into the application with given credentials.
    ...    Expected - user logged in and redirected to index page.
    Log In    ${test user 1 name}    ${test user 1 pwd}
    Go To    ${resources results page url}

Check All Content Tab
    [Documentation]    Check All contents tab. Check Sidebars, Filters and check if tab is highlighted.
    Check If Results Page Tab Loaded    All content    //div[@class="searchResultsLists"]//div[@name="Item" or @class="srch-header newsResult"]
    Wait Until Page Contains Element    id:news_filters
    Wait Until Element Contains    class:peopleMatches    iKnow RESULTS
    Wait Until Element Contains    class:peopleMatches    PEOPLE MATCHES
    Filter Search Results By Any Sidebar Filter    //div[@class="searchResultsLists"]//div[@name="Item" or @class="srch-header newsResult"]

Check News Tab
    [Documentation]    Check News tab. Check Sidebars, Filters and check if tab is highlighted.
    Click Search Tab    News
    Check If Results Page Tab Loaded    News    //div[@class="searchResultsLists"]//div[@name="Item" or @class="srch-header newsResult"]
    Wait Until Page Contains Element    id:news_filters
    Filter Search Results By Any Sidebar Filter    //div[@class="searchResultsLists"]//div[@name="Item" or @class="srch-header newsResult"]

Check Resources Tab
    [Documentation]    Check Resources tab. Check Sidebars, Filters and check if tab is highlighted.
    Click Search Tab    Resources
    Check If Results Page Tab Loaded    Resources    //div[@class="searchResultsLists"]//div[@name="Item" or @class="srch-header newsResult"]
    Wait Until Page Contains Element    id:news_filters
    Filter Search Results By Any Sidebar Filter    //div[@class="searchResultsLists"]//div[@name="Item" or @class="srch-header newsResult"]

Check People Tab
    [Documentation]    Check People tab. Check Sidebars, Filters and check if tab is highlighted.
    Click Search Tab    People
    Check If Results Page Tab Loaded    People    //div[@class="searchResultsLists"]//div[@class="userMeta commentMeta"]
    Wait Until Page Contains Element    id:news_filters
    Filter Search Results By Any Sidebar Filter    //div[@class="searchResultsLists"]//div[@class="userMeta commentMeta"]

Check Communities Tab
    [Documentation]    Check Communities tab. Check Sidebars, Filters and check if tab is highlighted.
    Click Search Tab    Communities
    Check If Results Page Tab Loaded    Communities    //div[@class="searchResultsLists"]//div[@class="srch-header communityResult"]
    Wait Until Page Contains Element    id:news_filters
    Wait Until Element Contains    class:peopleMatches    Trending Tags
    Filter Search Results By Any Sidebar Filter    //div[@class="searchResultsLists"]//div[@class="srch-header communityResult"]
