*** Settings ***
Resource          Keywords/functionalKeywords.robot

*** Test Cases ***
Login on https://insedetest.jti.com
    Log In    ${testUser1LoginName}    ${testUser1PWD}

Check if are loaded all webparts
    Wait Until Page Contains Element    //ul[@id='jtiGlobalNavigation']
    Wait Until Page Contains Element    //a[text()='Corporate news ']
    Wait Until Page Contains    //a[text()='My news']
    Wait Until Page Contains Element    //ul[@id='jtiGlobalNavigation']/li[2]

Click to cog button near My news title of webpart
    Click Button    //a[@class='edit']

Click to text field "+add" and type any tag e.g. L&M -> Select tag from dropdown
    Input Text    //input[@id="myNewsTags"]    L&M
    Click Element    //div[id='ui-id-3430']

In Markets tab tick checkboxes for Andorra, Canary Island and Spain to shown more that 10 articles and click Save
    Click Element    //span[text()='A']
    Click Element    //span[text()='Canary']
    Click Element    //span[text()='Sp']
    Click Element    //button[@id="saveMyNews"]

Press F5 to reload site content
    Reload Page

Scroll down to count number of articles
