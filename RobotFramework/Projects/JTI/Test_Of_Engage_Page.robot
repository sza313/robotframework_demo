*** Settings ***
Suite Teardown    Close Browser
Resource          Keywords/functionalKeywords.robot

*** Test Cases ***
Navigate To Engage Page
    [Documentation]    Click to Engage button from Top menu
    ...    Expected - Engage site loaded
    Click Main Menu Item    Engage
    Location Should Be    ${engage page url}

Check Global Menu Is Loaded
    [Documentation]    Check if main navigation is loaded by checking the container, profile pic and level 0 menu items.
    Check If Global Menu Is Loaded

Check If Communities Navigation Panel Is Loaded
    [Documentation]    Check if left side navigation panel element exists. Check basic links and buttons in the list.
    Wait Until Page Contains Element    id:MyActivityStream
    Check Communities Nav Link    My activity stream
    Check Communities Nav Link    All communities
    Wait Until Page Contains Element    //a[@class="btn btn-default" and contains(text(), "Follow more #Tags")]

Check If Engage Post My Strem Is Loaded
    [Documentation]    Check if engage part is loaded. Check if Add post and Ask a question butons are present. check if comment section is loaded.
    ${engage part}=    Set Variable    //div[contains(@class,"engage")]
    Page Should Contain Element    ${engage part}
    Page Should Contain Element    ${engage part}//a[text()="Add Post"]
    Page Should Contain Element    ${engage part}//a[text()="Ask a Question"]
    Page Should Contain Element    ${engage part}//div[@class="ngNewsFeedContent ngWrapper"]

Check If Recognition Widget Is Loaded
    [Documentation]    Check if sidebar widget with title "GIVE CUDOS BADGES" present.
    Wait Until Element Contains    css:h3.kudosBadgeEntryHeader    GIVE KUDOS BADGES
    Element Should Contain    (//div[@class="kudosBadgeChooseText"])[1]    Choose a recipient
    Element Should Contain    (//div[@class="kudosBadgeChooseText"])[2]    Choose an icon to display with your Kudos badge:
    Element Should Contain    (//div[@class="kudosBadgeChooseText"])[3]    What would you like to say to the recipient? You should not enter information you wish to keep private.
    Page Should Contain Element    //input[@value="Give Kudos badges"]

Check If Trending Tags Widget Is Loaded
    [Documentation]    Check if Treding tags widget displays title "TRENDING #TAGS".
    Wait Until Element Contains    (//h2[@class="ms-webpart-titleText"])[1]    TRENDING #TAGS

Check If Recommended Colleagues Widget Is Loaded
    [Documentation]    Check if Recommended Colleagues Wisget container is loaded, also check for title.
    Wait Until Page Contains Element    id:ngRecommendedColleagues
    Element Should Contain    (//h2[@class="ms-webpart-titleText"])[2]    RECOMMENDED COLLEAGUES

Check If Recommended Communities Widget Is Loaded
    [Documentation]    Check If Communities widget contains title "RECOMMENDED COMMUNITIES"
    Wait Until Element Contains    (//h2[@class="ms-webpart-titleText"])[3]    RECOMMENDED COMMUNITIES

Post A Comment
    [Documentation]    Input TestCom_[surname]_[timestamp] to the post textarea and see if the comment was added to posts below.
    ${comment}=    Set Variable    TestCom_${surname}_${current timestamp}
    Input Text    css:.ngPostInput.ac_input    ${comment}
    Click Button With Text    Post
    Wait Until Page Contains    ${comment}    15
    Wait Until Element Contains    css:.ngActivityRow:first-child    ${comment}

Preview A Question
    [Documentation]    Click on Ask a Question, add a question and click Preview.
    ...    Expected - Preview should show up under the textfield.
    ${question}=    Set Variable    TestCom_${surname}_${current timestamp} #Hastag_${surname}_${current timestamp} @Fernbach, Aron
    ${time}=    Get Time    epoch
    Click Element    css:#ngAskQuestion a
    Input Text    css:.ngPostInput.ac_input    ${question}
    Click Button With Text    Preview
    Wait Until Page Contains Element    css:.ngPreviewMask    15
    Element Should Contain    css:.ngPreviewDiv .ngSummary    ${question}

Post A Question
    [Documentation]    Click on Ask a Question, add a question and click Post.
    ...    Expected - Question added to the comments below.
    ${question}=    Set Variable    TestCom_${surname}_${current timestamp} #Hastag_${surname}_${current timestamp} @Fernbach, Aron
    ${time}=    Get Time    epoch
    Click Element    css:#ngAskQuestion a
    Clear Element Text    css:.ngPostInput.ac_input
    Input Text    css:.ngPostInput.ac_input    ${question}
    Click Button With Text    Post
    Wait Until Page Contains    ${question}    15
    Wait Until Element Contains    css:.ngActivityRow:first-child    ${question}
    Element Should Contain    css:.ngActivityRow:first-child .ngActivityRowHeader    question

Click On Hashtag
    [Documentation]    Click On the created Hashtag in the last added comment.
    ...    Expected - Hastag tab show up, posts filterd to those that contain the same hashtag.
    ${hashtag}=    Set Variable    (//*[contains(@class,"ngActivityRow")])[1]//*[@class="hashtag"]
    Element Should Contain    ${hashtag}    \#Hastag_${surname}_${current timestamp}
    ${question with current hastag} =    Set Variable    //*[@class="ngSummary" and descendant-or-self::*[contains(text(),"Hastag_${surname}_${current timestamp}")]]
    ${question without current hastag} =    Set Variable    //*[@class="ngSummary" and not(descendant-or-self::*[contains(text(),"Hastag_${surname}_${current timestamp}")])]
    Page Should Contain Element    ${question with current hastag}
    Page Should Contain Element    ${question without current hastag}
    Click Element    ${hashtag}
    Wait Until Page Does Not Contain Element    ${question without current hastag}
    Wait Until Page Contains Element    ${question with current hastag}

Click All Communities In Sidebar
    [Documentation]    Click on All Communities in sidebar. All communities tab should be active with filters.
    Click Communities Nav Link    All communities
    Wait Until Element Contains    ${community tabs}    All communities
    Wait Until Element Contains    ${community tabs}    My communities
    Wait Until Element Contains    ${community tabs}    Create a community
    Link Should Have Class    All communities    active

Check All Communities Tab
    [Documentation]    Check If Comminities Tab is loaded. Filters and search field should be visible, All communities tab should be active.
    Click Communities Tab    All communities
    Wait Until Page Contains Element    ${all communities tab content}
    Link Should Have Class    All communities    active    ${community tabs}
    Element Should Be Visible    ${all communities tab content}//div[@id="SearchBox"]
    Page Should Contain Button With Text    Market    ${all communities tab content}
    Page Should Contain Button With Text    Department    ${all communities tab content}
    Page Should Contain Button With Text    Brand    ${all communities tab content}
    Page Should Contain Button With Text    Language    ${all communities tab content}
    Page Should Contain Button With Text    Subject    ${all communities tab content}
    Page Should Contain Button With Text    Access    ${all communities tab content}

Set All Communities Filters
    [Documentation]    Choose on from each community filter. Check if communities are filtered.
    Click Communities Tab    All communities
    Wait Until Element Contains    ${all communities tab content}    Ukraine IT BA
    Click Button With Text    Market    ${all communities tab content}
    Click Link    Adriatica    ${all communities tab content}
    Click Button With Text    Department    ${all communities tab content}
    Click Link    Anti-Illicit Trade    ${all communities tab content}
    Click Button With Text    Brand    ${all communities tab content}
    Click Link    Amber Leaf    ${all communities tab content}
    Click Button With Text    Language    ${all communities tab content}
    Click Link    English    ${all communities tab content}
    Click Button With Text    Subject    ${all communities tab content}
    Click Link    JTI Business    ${all communities tab content}
    Click Button With Text    Access    ${all communities tab content}
    Click Link    Public    ${all communities tab content}
    Wait Until Element Does Not Contain    ${all communities tab content}    Ukraine IT BA

Clear All Communities Filters
    [Documentation]    Click on Clear Filters to clear All filters. Check if filtered community is visible again.
    Click Link    Clear filters    ${community tabs}
    Wait Until Element Contains    ${all communities tab content}    Ukraine IT BA

Check All Communities Count
    [Documentation]    Check if there are 10 communuties listed in the active tab.
    Xpath Should Match X Times    ${all communities tab content}//div[@name="Item"]    10

Check All Communities Pagiantion
    ${first item in list}=    Set Variable    ${all communities tab content}//div[@name="Item"]
    Wait Until Page Contains Element    ${first item in list}
    Click Element    //a[@title="Move to page 2"]
    Wait Until Page Does Not Contain Element    ${first item in list}

Join 12 Pubilc Communities

Unfollow 1 Community

Check My Communities Tab
    [Documentation]    Click My communities tab. My communities tab should be active. Filters and search bar should NOT be visible.
    Click Communities Tab    My communities
    ${my communities tab content}=    Set Variable    //div[@id="myCommunitiesWebPart"]
    Wait Until Page Contains Element    ${my communities tab content}
    Link Should Have Class    My communities    active    ${community tabs}
    Element Should Not Be Visible    css:#allCommunitiesWebPart #SearchBox
    Page Should Not Contain Button With Text    Market    ${my communities tab content}
    Page Should Not Contain Button With Text    Department    ${my communities tab content}
    Page Should Not Contain Button With Text    Brand    ${my communities tab content}
    Page Should Not Contain Button With Text    Language    ${my communities tab content}
    Page Should Not Contain Button With Text    Subject    ${my communities tab content}
    Page Should Not Contain Button With Text    Access    ${my communities tab content}

Check My Communities Count

Check My Communities Pagiantion
