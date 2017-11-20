*** Settings ***
Resource          uiKeywords.robot
Resource          ../TestData/elements.robot

*** Keywords ***
Login
    [Arguments]    ${username}    ${password}
    [Documentation]    Description - Check if Login page works correctly.
    ...    Expected - Users should be able to log in with given user name and password.
    Open Browser    ${url}    ${browser}
    SetTextBoxValue    User name:    ${username}
    SetTextBoxValue    Password:    ${password}
    ClickOnButtonText    Log On
    Wait Until Page Contains Element    xpath=//img[@id='insideLogo']    10

TestIndexPage
    [Documentation]    Description - Check if required elements are loaded on the index page. Check if basic functionality works on these elements.
    Wait Until Page Contains    ${el.mainNavigation}
    Wait Until Page Contains    ${el.corporateNews}
    Wait Until Page Contains    ${el.myNews}
    Wait Until Page Contains    ${el.engage}
    CheckMyNewsModal

CheckMyNewsModal
    [Documentation]    Description - Click to cog button near My news title of webpart
    ...    Expected - Content of Manage my news is loaded in popup
    ClickOnButtonText    ${el.myNewsCogButton}
    Wait Until Page Contains Element    ${el.myNewsModal}
    Wait Until Page Contains Element    ${el.myNewsModalFilters}
    Wait Until Page Contains Element    ${el.myNewsModalTabs}
    CheckTab    Markets    ${el.myNewsModal}
    CheckTab    Departments    ${el.myNewsModal}
    CheckTab    Brands    ${el.myNewsModal}
    CheckTab    Regions    ${el.myNewsModal}
    CheckButtonText    Close    ${el.myNewsModal}
