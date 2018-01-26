*** Settings ***
Library           SeleniumLibrary
Library           Dialogs
Library           Collections
Library           DateTime
Library           String
Library           ExcelLibrary
Library           openpyxl
Library           pyexcel_xls
Library           CSVLibrary
Resource          ../TestData/testData.robot
Resource          ../TestData/elements.robot
Library           AutoItLibrary

*** Keywords ***
Button With Text Should Be Visible
    [Arguments]    ${button text}    ${container}=
    Wait Until Element Is Visible    ${container}//button/descendant-or-self::*[contains(text(),"${button text}")]

Button With Text Should Have Class
    [Arguments]    ${text}    ${class}
    Page Should Contain Element    //button[contains(text(),"${text}") and contains(@class,"${class}")]

Button With Text Should Not Be Visible
    [Arguments]    ${button text}    ${container}=
    Wait Until Element Is Not Visible    ${container}//button/descendant-or-self::*[contains(text(),"${button text}")]

Check Communities Nav Link
    [Arguments]    ${link text}
    Wait Until Page Contains Element    //div[@id="MyActivityStream"]//a[text()="${link text}"]

Check If Menu Item Exists
    [Arguments]    ${title}
    Wait Until Page Contains Element    ${main menu}//a/descendant-or-self::*[contains(text(),"${title}")]

Check If WebElements Are Not Equal
    [Arguments]    ${given elements}    ${locator}
    ${found elements}=    Get WebElements    ${locator}
    Should Not Be Equal    ${given elements}    ${found elements}

Check Tab
    [Arguments]    ${title}    ${container}=    # Title: tab title. Container: xpath of the ancestor that contains the tabslist (ul) element. can be parent or any ancestor.
    [Documentation]    Checks If Tab is present on the page with given title text.
    Wait Until Page Contains Element    ${container}//ul[@class="nav nav-tabs"]//a[@role="tab" and text()="${title}"]

Check Tag By Name
    [Arguments]    ${tagname}    ${container}=
    Wait Until Page Contains Element    ${container}//div[contains(@class,'pill')]//span[text()='${tagname}']

Click Button With Text
    [Arguments]    ${button text}    ${container}=
    Wait Until Page Contains Element    ${container}//button/descendant-or-self::*[contains(text(),"${button text}")]
    Scroll Element Into View    ${container}//button/descendant-or-self::*[contains(text(),"${button text}")]
    Click Element    ${container}//button/descendant-or-self::*[contains(text(),"${button text}")]

Click Check Box By Label
    [Arguments]    ${label}    ${container}=
    ${checkbox} =    Set Variable    ${container}//span[text()[contains(.,'${label}')]]/../input[@type='checkbox']
    Wait Until Page Contains Element    ${checkbox}    15
    Click Element    ${checkbox}

Click Input Button With Value
    [Arguments]    ${button text}
    Click Element    //input[@value='${button text}']

Click Log Out Button
    ${button}=    Set Variable    //h4[text()="Log out"]/ancestor::div[@role="dialog"]//a[text()="Log out"]
    Wait Until Page Contains Element    ${button}
    Wait Until Element Is Visible    ${button}
    Click Element    ${button}

Click Link Which Contains
    [Arguments]    ${link text}    ${container}=
    Wait Until Page Contains Element    ${container}//a[descendant-or-self::*[contains(text(),"${link text}")]]
    Click Element    ${container}//a[descendant-or-self::*[contains(text(),"${link text}")]]

Click Main Menu Item
    [Arguments]    ${title}
    ${menu item}=    Set Variable    ${main menu}//a[descendant-or-self::*[contains(text(),"${title}")]]
    Wait Until Page Contains Element    ${menu item}
    Click Element    ${menu item}

Click Search Tab
    [Arguments]    ${tab name}
    Click Element    //li[contains(@class,"ms-srchnav-item")]//a[text()="${tab name}"]

Click Sidebar Nav Link
    [Arguments]    ${link text}    # Link text
    Scroll Element Into View    //div[contains(@class,"sidebar")]//a[text()="${link text}"]
    Click Element    //div[contains(@class,"sidebar")]//a[text()="${link text}"]

Click Tab
    [Arguments]    ${name}    ${container}=
    Click Element    ${container}//a[@role="tab" and text()="${name}"]
    Wait Until Page Contains Element    ${container}//a[@role="tab" and text()="${name}"]/ancestor::li[contains(@class,"active")]

Click Tab Which Contains
    [Arguments]    ${name}    ${container}=
    Click Element    ${container}//a[@role="tab" and contains(text(),"${name}")]
    Wait Until Page Contains Element    ${container}//a[@role="tab" and contains(text(),"${name}")]/ancestor::li[contains(@class,"active")]

Close Dialog
    [Arguments]    ${title}
    Click Element    //h1[text()="${title}"]/ancestor::div[@role="dialog"]//a[@title="Close dialog"]/span
    Wait Until Page Does Not Contain Element    //div[@role="dialog"]//h1[text()="${title}"]

Close SharePoint Menu
    Click Element    //a[@class="toolsButton"]
    Wait Until Element Is Not Visible    //div[contains(@class, "sharepointRibbon")]
    Wait Until Element Is Not Visible    //div[@id="suiteBarRight"]
    Wait Until Element Is Not Visible    //div[@id="DeltaSPRibbon"]

Execute Javascript File
    [Arguments]    ${file name}
    Execute Javascript    ${CURDIR}${/}..${/}Scripts${/}${file name}

Get Is Element Fixed
    [Arguments]    ${element}
    ${argList}=    Create List    ${element}
    ${sl}=    Get Library Instance    SeleniumLibrary
    ${elementInViewport} =    Call Method    ${sl._current_browser()}    execute_script    return (function(xpath)\{ var el \= document.evaluate(xpath, document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue; console.log(el); return window.getComputedStyle(el).position \=\=\= 'fixed';\})(arguments[0]);    @{argList}
    [Return]    ${elementInViewport}

Get Is Element In Viewport
    [Arguments]    ${element}
    [Documentation]    Check if element is visible in current viewport.
    ${argList}=    Create List    ${element}
    ${sl}=    Get Library Instance    SeleniumLibrary
    ${elementInViewport} =    Call Method    ${sl._current_browser()}    execute_script    return (function(xpath){ var el \= document.evaluate(xpath, document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue; console.log(el); var rect \= el.getBoundingClientRect(); return (rect.top <\= (window.innerHeight || document.documentElement.clientHeight) && rect.bottom >\= 0 && rect.left <\= (window.innerWidth || document.documentElement.clientWidth) && rect.right >\= 0)})(arguments[0]);    @{argList}
    [Return]    ${elementInViewport}

Input Community Field Textarea
    [Arguments]    ${title}    ${value}
    Wait Until Page Contains Element    //span[text()='${title}']/../..//input
    Input Text    //span[text()='${title}']/../..//textarea    ${value}

Link Should Have Class
    [Arguments]    ${link text}    ${class}    ${container}=
    Page Should Contain Element    ${container}//a[contains(text(),"${link text}") and contains(@class,"${class}")]

Open Profile Menu
    Wait Until Page Contains Element    //li[@id="jtiMyProfile"]
    Click Element    //li[@id="jtiMyProfile"]/a
    Wait Until Element Is Visible    //li[@id="jtiMyProfile"]//ul[@class="dropdown-menu"]

Open SharePoint Menu
    Click Element    //a[@class="toolsButton"]
    Wait Until Element Is Visible    //div[contains(@class, "sharepointRibbon")]
    Wait Until Element Is Visible    //div[@id="suiteBarRight"]
    Wait Until Element Is Visible    //div[@id="DeltaSPRibbon"]

Open SharePoint Settings Dropdown
    Click Element    //div[@id="suiteBarButtons"]//a[@title="Settings"]

Page Should Contain Button With Text
    [Arguments]    ${button text}    ${container}=    # Button Text: button text. Container: xpath of the ancestor that contains the button element. can be parent or any ancestor
    [Documentation]    Checks if button exists with the given text
    Wait Until Page Contains Element    ${container}//button/descendant-or-self::*[contains(text(),"${button text}")]

Page Should Contain Input Button With Text
    [Arguments]    ${title}    ${container}=    # Title: button text. Container: xpath of the ancestor that contains the button element. can be parent or any ancestor
    [Documentation]    Checks if input tpye button exists with the given text
    Wait Until Page Contains Element    ${container}//*[@type="button" and text()="${title}"]

Page Should Not Contain Button With Text
    [Arguments]    ${button text}    ${container}=    # Title: button text. Container: xpath of the ancestor that contains the button element. can be parent or any ancestor
    [Documentation]    Checks if button does not exist with the given text
    Wait Until Page Does Not Contain Element    ${container}//button/descendant-or-self::*[text()='${button text}']

Select Check Box By Label
    [Arguments]    ${label}    ${container}=
    ${checkbox} =    Set Variable    ${container}//span[text()="${label}"]/../input[@type="checkbox"]
    Wait Until Element Is Visible    ${checkbox}
    Select Checkbox    ${checkbox}

Scroll Element Into View
    [Arguments]    ${element}
    Execute Javascript    document.evaluate('${element}', document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.scrollIntoView({block: "center"});

Scroll To Bottom
    Execute Javascript    window.scrollTo(0,99999); console.log("scrolled to bottom");

Scroll To Top
    Execute Javascript    window.scrollTo(0,0)

Set Text Box Element Value
    [Arguments]    ${el}    ${value}
    Wait Until Page Contains Element    ${el}
    Input Text    ${el}    ${value}

Set Text Box Form Value
    [Arguments]    ${title}    ${value}
    Wait Until Page Contains Element    //td[text()='${title}']/..//input
    Input Text    //td[text()='${title}']/..//input    ${value}

Unselect Check Box By Label
    [Arguments]    ${label}    ${container}=
    ${checkbox} =    Set Variable    ${container}//span[text()[contains(.,'${label}')]]/../input[@type='checkbox']
    Wait Until Page Contains Element    ${checkbox}    15
    Unselect Check Box    ${checkbox}

Wait For Community Invitation Outlook Window
    [Arguments]    ${title}
    Wait For Active Window    Invitation to the ${title} Community - Message (HTML)
    Win Close    Invitation to the ${title} Community - Message (HTML)
    Wait For Active Window    Microsoft Outlook
    Control Click    Microsoft Outlook    \    [CLASS:Button; INSTANCE:2]

Wait For Email Share Outlook Window
    Wait For Active Window    Sharing post - Message (HTML)
    Win Close    Sharing post - Message (HTML)
    Wait For Active Window    Microsoft Outlook
    Control Click    Microsoft Outlook    \    [CLASS:Button; INSTANCE:2]

Wait Until Dialog Is Open
    [Arguments]    ${title}
    Wait Until Element Is Visible    //div[@role="dialog"]//h1[text()="${title}"]
    Wait Until Page Contains Element    //div[@role="dialog"]//h1[text()="${title}"]

Wait Until Page Contains Link With Text
    [Arguments]    ${text}
    Wait Until Page Contains Element    //a/descendant-or-self::*[contains(text(),"${text}")]

Wait Until Page Contains Pagination
    [Arguments]    ${container}=
    Wait Until Page Contains Element    ${container}//ul[contains(@class,"pagination")]

Wait Until Page Contains Span With Text
    [Arguments]    ${text}
    Wait Until Page Contains Element    //span[contains(text(),"${text}")]

Wait Until Search Tab Exists And Highlighted
    [Arguments]    ${tab name}
    Wait Until Page Contains Element    //a[@class="ms-srchnav-link-selected" and text()="${tab name}"]

Click On A Newly Created Community
    Go To    ${engage page url}
    Wait Until Page Contains Element    //ul[@class='nav nav-sidebar']
    Wait Until Page Contains Element    //ul[@id='MyActivityStream-MyCommunitiesList']/li/a[text()='Com_${test user 1 name}_${current timestamp}']
    Click Element    //ul[@id='MyActivityStream-MyCommunitiesList']/li/a[text()='Com_${test user 1 name}_${current timestamp}']
    Wait Until Page Contains Element    //div[@class='col-sm-8']/h1[text()='Com_${test user 1 name}_${current timestamp}']
