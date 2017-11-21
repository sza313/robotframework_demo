*** Settings ***
Suite Setup
Suite Teardown    Close Browser
Test Setup
Test Teardown
Test Template
Resource          Keywords/functionalKeywords.robot
Resource          TestData/testData.robot

*** Test Cases ***
TS_Login
    [Documentation]    TS_Login
    ...
    ...    Name - open web shop
    ...    Description - Navigate to https://insidetest.jti.com
    ...    Expected Result - main page of webshop loaded
    ...    Checkpoint - wait till page is loaded (login dialogue shown)
    [Template]    Login
    ${CURRENT_TEST_USER}    Szury4489

TS_Test_Of_Index_Page
    [Documentation]    TS_Test_Of_Index_Page
    ...
    ...    Name - Test of index page content and functionality
    ...    Description - Check if critical parts of the webpage are present. Check "manage my news" popup, search and notification functionality.
    ...    Expected Result - Main page loaded, all parts are present and functions work as expected.
    [Setup]
    Check Main Navigation
    Check Corporate News Part
    Check My News Part
    Check Engage Part
