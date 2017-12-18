*** Settings ***
Suite Setup       Setup Test Environment
Suite Teardown    Close Browser
Resource          Keywords/functionalKeywords.robot

*** Test Cases ***
Log In
    [Documentation]    Log into the application with given credentials.
    ...    Expected - user logged in and redirected to index page.
    Log In    ${test user 1 name}    ${test user 1 pwd}

Go To Onboarding Page
    [Documentation]    Open link https://insidetest.jti.com/Pages/Onboarding.aspx.
    ...    Expected - Onboarding site is opened with menu
    Go To    ${onboarding page url}
    Wait Until Page Contains    Welcome to INSIDE

Change Language
    [Documentation]    Change language to Deautch then back to English. Site should reload with language changed.
    Select From List By Label    id:AccountLanguageVal    Deutsch
    Wait Until Page Contains    Willkommen bei INSIDE
    Select From List By Label    id:AccountLanguageVal    English
    Wait Until Page Contains    Welcome to INSIDE

Click Top Menu Steps
    [Documentation]    Try to click to top menu to move between the steps. Moving among the steps shuold not be possible.
    ${link x}=    Get Horizontal Position    //a[@href="#manage"]
    ${link y}=    Get Vertical Position    //a[@href="#manage"]
    ${menu x}=    Get Horizontal Position    //div[@class="steps-container"]
    ${menu y}=    Get Vertical Position    //div[@class="steps-container"]
    ${menu width}    ${menu height}=    Get Element Size    //div[@class="steps-container"]
    ${link width}    ${link height}=    Get Element Size    //a[@href="#manage"]
    ${x}=    Evaluate    ${link x}-${menu x}-(${menu width}-${link width})/2
    ${y}=    Evaluate    ${link y}-${menu y}-(${menu height}-${link height})/2
    Log    ${x}
    Log    ${y}
    Click Element At Coordinates    //div[@class="steps-container"]    ${x}    ${y}
    Element Should Not Be Visible    //h3[text()="Manage my news tags"]

Check Manage My News Tags
    [Documentation]    Check default tags. Check if tags tabs are loaded.
    ${market}=    Get Selected List Label    id:AccountDefaultMarketVal
    ${department}=    Get Selected List Label    id:AccountPrimaryDepartmentVal
    Click Button With Text    Next
    Wait Until Element Is Visible    //h3[text()="Manage my news tags"]
    Check Tag By Name    ${market}    //div[@class="newsFilters"]
    Check Tag By Name    ${department}    //div[@class="newsFilters"]
    Check Tab    Markets    //div[@id="param_news"]
    Check Tab    Departments    //div[@id="param_news"]
    Check Tab    Brands    //div[@id="param_news"]
    Check Tab    Regions    //div[@id="param_news"]

Check Connect With Colleagues Step
    [Documentation]    Click Next On Manage My News Tags Page. Check contents.
    Click Button With Text    Next
    Wait Until Element Is Visible    //h3[text()="Connect with colleagues"]
    Wait Until Page Contains    Keep up-to-date with what your colleagues are discussing on Engage right from your INSIDE homepage, by selecting people to follow.
    Comment    TODO: colleagues not listed

Check Join Communities Step
    [Documentation]    Click Next on Connect With Colleagues Step. Check communities if are listed.
    Click Button With Text    Next
    Wait Until Element Is Visible    //h3[text()="Join Engage communities"]
    Wait Until Page Contains Element    id:recommendedCommunity
    Wait Until Page Contains Element    //div[@id="recommendedCommunity"]//div[@name="Item"]

Check Personalize Step
    [Documentation]    Click Next on Join Communities step. Check if "Setup my profile" and "Manage my expertise tags" panels are loaded.
    Click Button With Text    Next
    Wait Until Element Is Visible    //h3[text()="Setup my profile"]
    Page Should Contain Element    id:AccountBirthDayDay
    Page Should Contain Element    id:AccountBirthDayMonth
    Page Should Contain Element    id:AccountInterestsVal
    Page Should Contain Element    id:AccountAboutMeVal
    Page Should Contain Element    id:LinkedinVal
    Wait Until Element Is Visible    //h3[text()="Manage my expertise tags"]
    Add Tag    tag-${current timestamp}    //ul[@id="manageMyResponsibilities-responsibilityWrapper"]
    Remove Tag    tag-${current timestamp}    //ul[@id="manageMyResponsibilities-responsibilityWrapper"]

Check Notifications Step
    [Documentation]    Click the "Next" button and check if Notifications step is loaded. Check if "Manage my email digests" panel is loaded.
    Click Button With Text    Next
    Wait Until Element Is Visible    //h3[text()="Manage my email digests"]
    Wait Until Page Contains    Engage activity
    Wait Until Page Contains    Engage email digest
    Wait Until Page Contains    Engage instant notifications
    Wait Until Page Contains Element    id:engageEmailDigestSwitch
    Wait Until Page Contains Element    id:engageEmailDigestCommunitiesSwitch
    Wait Until Page Contains Element    id:engageEmailDigestColleaguesSwitch
    Wait Until Page Contains Element    id:engageEmailDigestMyActivitiesSwitch
    Wait Until Page Contains Element    id:newsEmailDigestSwitch
    Wait Until Page Contains Element    id:newsEmailDigestDayPicker

Finish Onboarding
    Click Button With Text    Complete
    Wait Until Page Contains    Congratulations, you are now set for the full intranet experience
    Location Should Be    ${welcome page url}
