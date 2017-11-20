*** Settings ***
Library           Selenium2Library
Library           Dialogs
Library           Collections
Resource          ../TestData/testData.robot
Library           DateTime
Library           String
Library           ExcelLibrary
Library           openpyxl
Library           pyexcel_xls
Library           CSVLibrary
Library           DatabaseLibrary

*** Keywords ***
SetTextBoxValue
    [Arguments]    ${title}    ${value}
    Wait Until Page Contains Element    xpath=//td[text()='${title}']/..//input
    Selenium2Library.Input Text    xpath=//td[text()='${title}']/..//input    ${value}

ClickOnButtonText
    [Arguments]    ${title}    # Title of the Button to click
    Wait Until Page Contains Element    xpath=//input[@value='${title}']
    Click Element    xpath=//input[@value='${title}']

ClickOnElement
    [Arguments]    ${el}    # Element to click
    Wait Until Page Contains Element    ${el}
    Click Element    ${el}

CheckTab
    [Arguments]    ${title}    ${container}=""    # Title: tab title. Container: xpath of the ancestor that contains the tabslist (ul) element. can be parent or any ancestor.
    [Documentation]    Description - Checks If Tab is present on the page with given title text.
    Wait Until Page Contains Element    xpath=${container}//ul[@class="nav nav-tabs"]//a[@role="tab" and text()="${title}"]

CheckButtonText
    [Arguments]    ${title}    ${container}=""    # Title: button text. Container: xpath of the ancestor that contains the button element. can be parent or any ancestor
    [Documentation]    Description - Checks if button exists with the given text
    Wait Until Page Contains Element    xpath=${container}//*[@type="button" and text()="${title}"]
