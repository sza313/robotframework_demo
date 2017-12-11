*** Settings ***
Suite Setup       Setup Test Environment
Suite Teardown    Close Browser
Resource          Keywords/functionalKeywords.robot

*** Test Cases ***
Log In
    [Documentation]    Log into the application with given credentials.
    ...    Expected - user logged in and redirected to index page.
    Log In    ${test user 1 name}    ${test user 1 pwd}

Navigate To My Profile Page
    [Documentation]    Click on profile picture in global menu and select My profile.
    ...    Expected - My profile site is opened in Activity stream tab.
    Click Element    //li[@id="jtiMyProfile"]/a
    Wait Until Element Is Visible    //li[@id="jtiMyProfile"]//a[text()="My profile"]
    Click Element    //li[@id="jtiMyProfile"]//a[text()="My profile"]
    Wait Until Page Contains Element    //h1[contains(text(),"${test user 1 full name}")]

Check If Left Side Webparts Are Loaded
    [Documentation]    Check if Left side - Areas of expertise, My communities, Following, Followers are loaded.
    Wait Until Page Contains Element    //div[contains(@class,"secondaryInfo t-leftpane")]
    Wait Until element Contains    //div[contains(@class,"secondaryInfo t-leftpane")]    MY COMMUNITIES
    Wait Until element Contains    //div[contains(@class,"secondaryInfo t-leftpane")]    FOLLOWERS
    Wait Until element Contains    //div[contains(@class,"secondaryInfo t-leftpane")]    AREAS OF EXPERTISE
    Wait Until element Contains    //div[contains(@class,"secondaryInfo t-leftpane")]    FOLLOWERS

Check If Right Side Webparts Are Loaded
    [Documentation]    Check if Right side - Recommended communities, Recommended Colleagues are loaded.
    Wait Until Page Contains Element    //div[contains(@class,"secondaryInfo t-rightpane")]
    Wait Until element Contains    //div[contains(@class,"secondaryInfo t-rightpane")]    RECOMMENDED COMMUNITIES
    Wait Until element Contains    //div[contains(@class,"secondaryInfo t-rightpane")]    RECOMMENDED COLLEAGUES

Add A Post
    [Documentation]    Click to Add post and add any post and click Post.
    ...    Expected - Post was added.
    Add A Post On My Profle Page

Add A Question
    [Documentation]    Click to Add a question and add any question and click Post,
    ...    Expected - Question was added
    Generate Timestamp
    Click Element    //li[@id="ngAskQuestion"]//a
    Input Text    //div[@id="ngPostControl"]//textarea    TestQuestion_${test user 1 name}_${current timestamp}
    Click Button With Text    Post    //div[@id="ngPostControl"]
    Wait Until Page Contains    TestQuestion_${test user 1 name}_${current timestamp}

Add A Private Message
    [Documentation]    Click to Add private message and add any private message and click Send.
    ...    Expected - Private message was posted.
    Generate Timestamp
    Click Element    //li[@id="ngDirectMessage"]//a
    Input Text    //div[@id="ngPostControl"]//textarea    TestPM_${test user 1 name}_${current timestamp}
    Click Button With Text    Send    //div[@id="ngPostControl"]
    Wait Until Page Contains    TestPM_${test user 1 name}_${current timestamp}

Like A Post
    [Documentation]    Click to "Like to" to like a post. Link should change to "Unlike". Text "You like this" should be displayed at the bottom of the post.
    ${post}=    Set Variable    //div[contains(@class,"ngActivityRow") and .//a[text()="Like"]]
    Scroll To Top
    Click Element    ${post}//a[text()="Like"]
    Wait Until Page Contains    You like this.

Comment A Post
    [Documentation]    Click to "Comment" on a post. Textarea should appear. After entering Text, and sending, comment should display below the post.
    Go To    ${profile page url}
    Add A Post On My Profle Page
    ${post}=    Set Variable    //div[contains(@class,"ngActivityRow") and .//a[text()="Comment"]]
    Scroll Element Into View    ${post}
    Click Element    ${post}//a[text()="Comment"]
    Wait Until Page Contains Element    ${post}//textarea
    Scroll Element Into View    ${post}//textarea
    Input Text    ${post}//textarea    TestComment_${test user 1 name}_${current timestamp}
    Click Button With Text    \Comment    ${post}
    Wait Until Page Contains    TestComment_${test user 1 name}_${current timestamp}

Follow A Post
    [Documentation]    Click to "Folllow-up" to follow-up the post. Eye icon should change to a striked through eye icon.
    Go To    ${profile page url}
    ${post}=    Set Variable    //div[contains(@class,"ngActivityRow") and .//a[text()="Follow-up"]]
    Wait Until Page Contains Element    ${post}
    Scroll Element Into View    ${post}
    Click Element    ${post}//a[text()="Follow-up"]
    Wait Until Page Contains Element    ${post}//a[contains(@class,"ngUnFollowUpLink")]

Share A Post Via Engage
    [Documentation]    Click to "Share" to share the post. Share Popup should appear. Share via Engage user name.
    Go To    ${profile page url}
    Add A Post On My Profle Page
    ${post}=    Set Variable    //div[contains(@class,"ngActivityRow") and .//a[text()="Share"]]
    Scroll Element Into View    ${post}
    Click Element    ${post}//a[text()="Share"]
    ${dialog}=    Set Variable    //div[@role="dialog" and .//h4[contains(text(),"Share")]]
    Wait Until Page Contains Element    ${dialog}
    Sleep    5 secs
    Select Radio Button    shareModalOptions    engage
    Wait Until Keyword Succeeds    5 secs    0.5 secs    Input Text    id:shareModalEntity    \@${test user 1 full name}
    Sleep    1 secs
    Wait Until Element Is Visible    ${dialog}//li[.//small[text()="${test user 1 name}"]]
    Click Element    ${dialog}//li[.//small[text()="${test user 1 name}"]]
    Input Text    id:shareModalMessage    TestShareMsg_${test user 1 name}_${current timestamp}
    Click Button With Text    Share    ${dialog}
    Wait Until Element Is Not Visible    ${dialog}

Share A Post Via Email
    [Documentation]    Click to "Share" to share the post. Share Popup should appear. Share via email.
    Go To    ${profile page url}
    Add A Post On My Profle Page
    ${post}=    Set Variable    //div[contains(@class,"ngActivityRow") and .//a[text()="Share"]]
    Scroll Element Into View    ${post}
    Click Element    ${post}//a[text()="Share"]
    ${dialog}=    Set Variable    //div[@role="dialog" and .//h4[contains(text(),"Share")]]
    Wait Until Page Contains Element    ${dialog}
    Sleep    5 secs
    Select Radio Button    shareModalOptions    option2
    Wait Until Keyword Succeeds    5 secs    0.5 secs    Input Text    id:shareModalEmail    aron.fernbach@jti.com
    Input Text    id:shareModalMessage    TestShareMsg_${test user 1 name}_${current timestamp}
    Click Button With Text    Share    ${dialog}
    Wait Until Element Is Not Visible    ${dialog}
    Wait For Email Share Outlook Window

Get Post Link
    [Documentation]    Click to "More" button, then select "Get Link". Popup with link to the post shoudl appear.
    Go To    ${profile page url}
    ${post}=    Set Variable    //div[contains(@class,"ngActivityRow") and .//a[text()="More"]]
    Scroll Element Into View    ${post}
    Click Element    ${post}//a[text()="More"]
    Wait Until Page Contains Element    ${post}//a[text()="More"]/..//li[text()="Get Link"]
    Scroll Element Into View    ${post}
    Click Element    ${post}//a[text()="More"]/..//li[text()="Get Link"]
    Handle Alert    ACCEPT

Edit A Post
    [Documentation]    Click the arrow on top right of the post, then click edit. Edit the post.
    ...    Expected - post should be edited accordingly.
    Go To    ${profile page url}
    Add A Post On My Profle Page
    ${post}=    Set Variable    (//div[contains(@class,"ngActivityProfileIcon")]/ancestor::div[contains(@class,"ngActivityRow")])[not(.//div[contains(@class,"ngActivityMetaDiv")])]    # first post that does NOT contain any previous comments (meaning it's editable)
    Click On Post Quick Menu Item    ${post}    Edit
    Wait Until Page Contains Element    //div[contains(@class,"ngEditDiv")]//textarea
    Input Text    //div[contains(@class,"ngEditDiv")]//textarea    TestEditPost_${test user 1 name}_${current timestamp}
    Click Button With Text    Save
    Wait Until Element Contains    //div[contains(@class,"ngActivityRow")]    TestEditPost_${test user 1 name}_${current timestamp}

Delete A Post
    [Documentation]    Click the arrow on top right of the post, then click Delete.
    ...    Expected - Post should be removed.
    Go To    ${profile page url}
    Add A Post On My Profle Page
    ${post}=    Set Variable    (//div[contains(@class,"ngActivityProfileIcon")]/ancestor::div[contains(@class,"ngActivityRow")])[1]
    Click On Post Quick Menu Item    ${post}    Delete
    Handle Alert    ACCEPT
    Wait Until Page Does Not Contain    TestPost_${test user 1 name}_${current timestamp}
