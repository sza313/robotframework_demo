*** Settings ***
Library           Selenium2Library
Library           Dialogs
Library           Collections
Library           DateTime
Library           String
Library           ExcelLibrary
Library           openpyxl
Library           pyexcel_xls
Library           CSVLibrary
Library           DatabaseLibrary

*** Keywords ***
Set Text Box Form Value
    [Arguments]    ${title}    ${value}
    Wait Until Page Contains Element    //td[text()='${title}']/..//input
    Selenium2Library.Input Text    //td[text()='${title}']/..//input    ${value}

Click On Button With Text
    [Arguments]    ${title}    # Title of the Button to click
    Wait Until Page Contains Element    //input[@value='${title}']
    Click Element    //input[@value='${title}']

Click On Element
    [Arguments]    ${el}    # Element to click
    Wait Until Page Contains Element    ${el}
    Click Element    ${el}

Check Tab
    [Arguments]    ${title}    ${container}=""    # Title: tab title. Container: xpath of the ancestor that contains the tabslist (ul) element. can be parent or any ancestor.
    [Documentation]    Description - Checks If Tab is present on the page with given title text.
    Wait Until Page Contains Element    ${container}//ul[@class="nav nav-tabs"]//a[@role="tab" and text()="${title}"]

Check Button With Text
    [Arguments]    ${title}    ${container}=""    # Title: button text. Container: xpath of the ancestor that contains the button element. can be parent or any ancestor
    [Documentation]    Description - Checks if button exists with the given text
    Wait Until Page Contains Element    ${container}//*[@type="button" and text()="${title}"]

Set Text Box Element Value
    [Arguments]    ${el}    ${value}
    Wait Until Page Contains Element    ${el}
    Selenium2Library.Input Text    ${el}    ${value}

Click Check Box
    [Arguments]    ${label}    ${container}=""
    ${checkbox} =    Set Variable    ${container}//span[text()[contains(.,'${label}')]]/../input[@type='checkbox']
    Wait Until Page Contains Element    ${checkbox}    15
    Click Element    ${checkbox}

Check Tag By Name
    [Arguments]    ${tagname}    ${container}=""
    Wait Until Page Contains Element    ${container}//div[contains(@class,'pill')]//span[text()='${tagname}']

Uncheck Check Box
    [Arguments]    ${label}    ${container}=""
    ${checkbox} =    Set Variable    ${container}//span[text()[contains(.,'${label}')]]/../input[@type='checkbox']
    Wait Until Page Contains Element    ${checkbox}    15
    Unselect Check Box    ${checkbox}

Check If Menu Item Exists
    [Arguments]    ${title}
    Wait Until Page Contains Element    //ul[@id="jtiGlobalNavigation"]//a/descendant-or-self::*[contains(text(),"${title}")]

Scroll To Bottom
    Execute Javascript    window.scrollTo(0,document.body.scrollHeight)

Get Is Element In Viewport
    [Arguments]    ${element}
    [Documentation]    Check if element is visible in current viewport.
    ${argList}=    Create List    ${element}
    ${s2l}=    Get Library Instance    Selenium2Library
    ${elementInViewport} =    Call Method    ${s2l._current_browser()}    execute_script    return (function(xpath)\{ var el \= document.evaluate(xpath, document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue; console.log(el); var rect \= el.getBoundingClientRect(); return (rect.top \>\= 0 && rect.top \<\= (window.innerHeight || document.documentElement.clientHeight) && rect.left \>\= 0 && rect.left \<\= (window.innerWidth || document.documentElement.clientWidth) && rect.right \>\= 0 && rect.right \<\= (window.innerWidth || document.documentElement.clientWidth));\})(arguments[0]);    @{argList}
    [Return]    ${elementInViewport}

Get Is Element Fixed
    [Arguments]    ${element}
    ${argList}=    Create List    ${element}
    ${s2l}=    Get Library Instance    Selenium2Library
    ${elementInViewport} =    Call Method    ${s2l._current_browser()}    execute_script    return (function(xpath)\{ var el \= document.evaluate(xpath, document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue; console.log(el); return window.getComputedStyle(el).position \=\=\= 'fixed';\})(arguments[0]);    @{argList}
    [Return]    ${elementInViewport}

Scroll To Top
    Execute Javascript    window.scrollTo(0,0)
