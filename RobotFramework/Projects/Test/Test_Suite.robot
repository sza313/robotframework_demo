*** Settings ***
Suite Setup       Open Browser    https://www.google.hu    chrome
Suite Teardown    Close Browser
Resource          keywords.robot

*** Test Cases ***
Test Google
    Wait Until Page Contains Element    //input[@id="lst-ib"]
    Input Text    //input[@id="lst-ib"]    jti inside
    Press Key    //input[@id="lst-ib"]    \\13
    Wait Until Page Contains    Japan Tobacco International
