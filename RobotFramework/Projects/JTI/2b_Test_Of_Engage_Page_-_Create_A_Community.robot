*** Settings ***
Suite Setup       Setup Test Environment
Suite Teardown    Close Browser
Resource          Keywords/functionalKeywords.robot

*** Test Cases ***
Log In
    [Documentation]    Log into the application with given credentials.
    ...    Expected - user logged in and redirected to index page.
    Log In    ${test user 1 name}    ${test user 1 pwd}

Open Create A Community Popup And Create One
    Go To    ${all communities url}
    Wait Until Page Contains Link With Text    Create a community
    Click Link Which Contains    Create a community
    Wait Until Dialog Is Open    Create community
    Select Frame    //h1[contains(text(),"Create community")]/ancestor::div[@role="dialog"]//iframe
    Input Text    (//input[@class="form-control"])[1]    Com_${test user 1 name}_${current timestamp}
    Input Text    //span[contains(@class,"community-title") and contains(text(),"Description")]/../..//textarea    Com_${test user 1 name}_${current timestamp}
    Select From List By Label    (//select[@multiple="multiple"])[1]    Adriatica
    Select From List By Label    (//select[@multiple="multiple"])[2]    Amber Leaf
    Select From List By Label    (//select[@multiple="multiple"])[3]    Anti-Illicit Trade
    Select From List By Label    (//select[@multiple="multiple"])[4]    Chinese
    Click Input Button With Value    Create community
    Unselect Frame

Check If Community Is Created
    Wait Until Keyword Succeeds    15 mins    15 secs    Check If Community Is Created    Com_${test user 1 name}_${current timestamp}

Check If Community Can Be Opened
    Click On A Sidebar Community
