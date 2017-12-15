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
