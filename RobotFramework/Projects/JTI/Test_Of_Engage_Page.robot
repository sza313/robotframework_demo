*** Settings ***
Suite Teardown    # Close Browser
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
    Navigate To All Communities Page

Check All Communities Tab
    [Documentation]    Check If Comminities Tab is loaded. Filters and search field should be visible, All communities tab should be active.
    Click Communities Tab    All communities
    Wait Until Page Contains Element    ${all communities tab}
    Link Should Have Class    All communities    active    ${community tabs}
    Element Should Be Visible    ${all communities tab}//div[@id="SearchBox"]
    Page Should Contain Button With Text    Market    ${all communities tab}
    Page Should Contain Button With Text    Department    ${all communities tab}
    Page Should Contain Button With Text    Brand    ${all communities tab}
    Page Should Contain Button With Text    Language    ${all communities tab}
    Page Should Contain Button With Text    Subject    ${all communities tab}
    Page Should Contain Button With Text    Access    ${all communities tab}

Set All Communities Filters
    [Documentation]    Choose on from each community filter. Check if communities are filtered.
    Click Communities Tab    All communities
    Set Community Filter    Market    Adriatica    ${all communities tab}
    Set Community Filter    Department    Anti-Illicit Trade    ${all communities tab}
    Set Community Filter    Brand    Amber Leaf    ${all communities tab}
    Set Community Filter    Language    English    ${all communities tab}
    Set Community Filter    Subject    JTI Business    ${all communities tab}
    Set Community Filter    Access    Public    ${all communities tab}

Clear All Communities Filters
    [Documentation]    Click on Clear Filters to clear All filters. Check if filtered community is visible again.
    Clear Community Filters    ${all communities tab}

Check All Communities Count
    [Documentation]    Check if there are 10 communuties listed in the active tab.
    Wait Until Keyword Succeeds    10 secs    0.5 secs    Page Should Contain Element    ${all communities tab}//div[@name="Item"]    None    NONE
    ...    10

Check All Communities Pagiantion
    [Documentation]    Check if clicking on second page in the paginator will load the next couple of communities
    Check Pagination    ${all communities tab}

Join 12 Pubilc Communities
    [Documentation]    Join communities to test My Communities pagination and count items
    Navigate To All Communities Page
    Set Community Filter    Access    Public    ${all communities tab}
    Repeat Keyword    10 times    Join A Community    ${all communities tab}
    Paginate To    2    ${all communities tab}
    Repeat Keyword    2 times    Join A Community    ${all communities tab}

Check My Communities Tab
    [Documentation]    Click My communities tab. My communities tab should be active. Filters and search bar should NOT be visible.
    Navigate To All Communities Page
    Click Communities Tab    My communities
    ${my communities tab}=    Set Variable    //div[@id="myCommunitiesWebPart"]
    Wait Until Page Contains Element    ${my communities tab}
    Link Should Have Class    My communities    active    ${community tabs}
    Element Should Not Be Visible    css:#allCommunitiesWebPart #SearchBox
    Page Should Not Contain Button With Text    Market    ${my communities tab}
    Page Should Not Contain Button With Text    Department    ${my communities tab}
    Page Should Not Contain Button With Text    Brand    ${my communities tab}
    Page Should Not Contain Button With Text    Language    ${my communities tab}
    Page Should Not Contain Button With Text    Subject    ${my communities tab}
    Page Should Not Contain Button With Text    Access    ${my communities tab}

Check My Communities Count
    [Documentation]    Check if there are 10 communuties listed in the active tab.
    Wait Until Keyword Succeeds    10 secs    0.5 secs    Page Should Contain Element    ${my communities tab}//div[@name="Item"]    None    NONE
    ...    10

Check My Communities Pagiantion
    [Documentation]    Check if clicking on second page in the paginator will load the next couple of communities
    Check Pagination    ${my communities tab}

Unfollow All Communities
    [Documentation]    Unfollow all communities for future testing
    Navigate To All Communities Page
    Click Communities Tab    My communities
    Wait Until Keyword Succeeds    10 secs    0.5 secs    Page Should Contain Element    ${my communities tab}//div[@name="Item"]    None    NONE
    ...    10
    Repeat Keyword    10 times    Leave A Community    ${my communities tab}
    Paginate To    2    ${my communities tab}
    Repeat Keyword    2 times    Leave A Community    ${my communities tab}

Hover Over A Followed Community
    [Documentation]    Follow a community, then hover over the buttton to see "Leave" text. Unfollow community.
    Set Community Filter    Access    Public    ${all communities tab}
    Join A Community    ${all communities tab}
    Mouse Over    //div[@id="allCommunitiesWebPart"]//button/descendant-or-self::*[contains(text(),"Following")]/ancestor::button
    Wait Until Element Contains    //div[@id="allCommunitiesWebPart"]//button/descendant-or-self::*[contains(text(),"Following")]/ancestor::button    Leave

Test Search For Community
    [Documentation]    Type in the newly created community name to search bar in all communities tab, then press enter. Results should contain the named community.
    Go To    ${all communities url}
    Search For Community    ${fixed community}

Open Created Community
    Go To    ${all communities url}
    Search For Community    ${fixed community}
    Click Element    ${all communities tab}//a/h4[text()="${fixed community}"]/..
    Wait Until Page Contains Element    //a[@id="joinLeaveAction"]    15
    Wait Until Page Contains Element    //a[text()="Invite others to follow"]
    Wait Until Page Contains Element    //span[text()="Manage community owners"]/..
    Wait Until Page Contains Element    //a[@role="tab" and text()="Activity stream"]/parent::li[contains(@class,"active")]

Follow Or Unfollow Opened Community
    Go To    ${fixed community url}
    ${button}=    Set Variable    //a[@id="joinLeaveAction"]
    Wait Until Page Contains Element    ${button}
    ${text before}=    Get Text    ${button}
    Click Element    ${button}
    Wait Until Element Does Not Contain    ${button}    ${text before}
    Run Keyword If    "${text before}" == "follow community"    Element Should Contain    ${button}    stop following community
    Run Keyword If    "${text before}" == "stop following community "    Element Should Contain    ${button}    follow community

Click Invite Others Button
    [Documentation]    Click Invite Others button. Email client should be opened.
    Go To    ${fixed community url}
    Click Link    Invite others to follow
    Wait For Outlook Window    ${fixed community}
    Wait For Active Window    Microsoft Outlook
    Control Click    Microsoft Outlook    \    [CLASS:Button; INSTANCE:2]

Check Manage Owners Dialog
    Go To    ${fixed community url}
    Click Link    Manage community owners    ${community page}
    Wait Until Dialog Is Open    Manage Owners
    Close Dialog    Manage Owners

Check Files Tab In Opened Community
    Go To    ${fixed community url}
    Activate Community Tab    Files
    Check Community Page Sidebar

Check Pictures Tab In Opened Community
    Go To    ${fixed community url}
    Activate Community Tab    Pictures
    Check Community Page Sidebar
