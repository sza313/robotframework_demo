*** Settings ***
Resource          uiKeywords.txt

*** Keywords ***
Login
    [Arguments]    ${username}    ${password}
    ClickOnLink    Log in
    SetTextBoxValue    Email:    ${username}
    SetTextBoxValue    Password    ${password}
    Click Button    Log in
    CheckLink    ${username}

CheckRegistrationForm
    [Arguments]    ${firstNameTitle}    ${lastNameTitle}    ${emailTitle}    ${passwordTitle}    ${confPasswordtitle}    ${genderTitle}
    ...    ${registerTitle}    ${yourPersonalDetailsTitle}    ${yourPasswordTitle}
    Wait Until Page Contains    Register
    ClickOnLink    Register
    CheckTextBox    ${firstNameTitle}
    CheckTextBox    ${lastNameTitle}
    CheckTextBox    ${emailTitle}
    CheckTextBox    ${passwordTitle}
    CheckTextBox    ${confPasswordtitle}
    CheckRadioButton    ${genderTitle}    gender-male
    CheckRadioButton    ${genderTitle}    gender-female
    CheckButton    ${registerTitle}
    Wait Until Page Contains    ${registerTitle}
    Wait Until Page Contains    ${yourPersonalDetailsTitle}
    Wait Until Page Contains    ${yourPasswordTitle}

OpenApplication
    [Arguments]    ${url}    ${browser}
    openbrowser    ${url}    ${browser}
    Wait Until Page Contains    Log in

FillRegistrationForm
    [Arguments]    ${firstName}    ${lastName}    ${password}    ${confPassword}    ${gender}
    SetTextBoxValue    First name:    ${firstName}
    SetTextBoxValue    Last name:    ${lastName}
    ${timeStamp}=    DateTime.Get Current Date    result_format=%Y_%m_%d_%H_%M_%S
    Set Global Variable    ${CURRENT_TEST_USER}    ${timeStamp}@gmail.com
    SetTextBoxValue    Email:    ${timeStamp}@gmail.com
    SetTextBoxValue    Password:    ${password}
    SetTextBoxValue    Confirm password:    ${confPassword}
    Run Keyword If    "${gender}"=="female"    ClickRadioButton    Gender    gender-female
    Run Keyword If    "${gender}"=="male"    ClickRadioButton    Gender    gender-male
    ClickButton    Register
    ClickOnButton    Continue
    CheckLink    ${timeStamp}@gmail.com

Logout
    ClickOnLink    Log out
    CheckLink    Log in

AddItemToCart
    [Arguments]    ${category}    ${item}
    ClickLink    ${category}
    CheckSpanTitle    Shopping cart
    CheckSpanTitle    (0)
    ClickOnLink    ${item}
    CheckH1Title    ${item}
    CheckNumericStepperContent    Qty    1
    ClickOnButton    Add to cart
    CheckSpanTitle    Shopping cart
    CheckSpanTitle    (1)

OPenShoppingCart
    [Arguments]    ${itemTitle}    ${price}    ${amount}    ${sumPrice}
    ClickOnLink    Shopping cart
    CheckShoppingCart    ${itemTitle}    ${price}    ${amount}    ${sumPrice}

CheckAddress
    [Arguments]    ${firstName}    ${lastName}    ${email}    ${address}
    ClickOnLink    ${email}
    CheckH1Title    My account - Customer info
    Wait Until Page Contains    Your Personal Details
    CheckRadioButton    Gender:    gender-male
    CheckRadioButton    Gender:    gender-female
    CheckTextBoxValue    First name:    ${firstName}
    CheckTextBoxValue    Last name:    ${lastName}
    CheckTextBoxValue    Email:    ${email}
    ClickOnLink    Addresses
    CheckH1Title    My account - Addresses
    Wait Until Page Contains    ${address}

AddAddress
    [Arguments]    ${firstName}    ${lastName}    ${email}    ${company}    ${city}    ${address1}
    ...    ${address2}    ${zip}    ${phone}    ${fax}    ${country}    ${state}
    ClickOnButton    Add new
    CheckH1Title    My account - Add new address
    CheckTextBox    First name:
    CheckTextBox    Last name:
    CheckTextBox    Email:
    CheckTextBox    Company:
    CheckTextBox    City:
    CheckTextBox    Address 1:
    CheckTextBox    Address 2:
    CheckTextBox    Zip / postal code:
    CheckTextBox    Phone number:
    CheckTextBox    Fax number:
    CheckDropDown    Country:
    CheckDropDown    State / province:
    SetTextBoxValue    First name:    ${firstName}
    SetTextBoxValue    Last name:    ${lastName}
    SetTextBoxValue    Email:    ${email}
    SetTextBoxValue    Company:    ${company}
    SetTextBoxValue    City:    ${city}
    SetTextBoxValue    Address 1:    ${address1}
    SetTextBoxValue    Address 2:    ${address2}
    SetTextBoxValue    Zip / postal code:    ${zip}
    SetTextBoxValue    Phone number:    ${phone}
    SetTextBoxValue    Fax number:    ${fax}
    SetDropDownValue    Country:    ${country}
    Sleep    5
    SetDropDownValue    State / province:    ${state}
    ClickOnButton    Save

CheckNewAddress
    [Arguments]    ${firstName}    ${lastName}    ${email}    ${company}    ${city}    ${address1}
    ...    ${address2}    ${zip}    ${phone}    ${fax}    ${country}
    wait until page contains    My account - Addresses
    wait until page contains    ${firstName} ${lastName}
    wait until page contains    ${email}
    wait until page contains    ${phone}
    Wait Until Page Contains    ${fax}
    Wait Until Page Contains    ${company}
    Wait Until Page Contains    ${address1}
    Wait Until Page Contains    ${address2}
    Wait Until Page Contains    ${city}, \ ${zip}
    Wait Until Page Contains    ${country}

AddAndCheckAddress
    [Arguments]    ${firstName}    ${lastName}    ${email}    ${company}    ${city}    ${address1}
    ...    ${address2}    ${zip}    ${phone}    ${fax}    ${country}    ${state}
    AddAddress    ${firstName}    ${lastName}    ${email}    ${company}    ${city}    ${address1}
    ...    ${address2}    ${zip}    ${phone}    ${fax}    ${country}    ${state}
    CheckNewAddress    ${firstName}    ${lastName}    ${email}    ${company}    ${city}    ${address1}
    ...    ${address2}    ${zip}    ${phone}    ${fax}    ${country}

SetExpirationDate
    [Arguments]    ${year}    ${month}
    Wait Until Page Contains Element    xpath=//label[text()[contains(.,'Expiration date')]]/../..//select[@id='ExpireYear']
    Select From List By Label    xpath=//label[text()[contains(.,'Expiration date')]]/../..//select[@id='ExpireYear']    ${year}
    Wait Until Page Contains Element    xpath=//label[text()[contains(.,'Expiration date')]]/../..//select[@id='ExpireMonth']
    Select From List By Label    xpath=//label[text()[contains(.,'Expiration date')]]/../..//select[@id='ExpireMonth']    ${month}

CheckExpirationDate
    [Arguments]    ${year}    ${month}
    Wait Until Page Contains Element    xpath=//label[text()[contains(.,'Expiration date')]]/../..//select[@id='ExpireYear']
    List Selection Should Be    xpath=//label[text()[contains(.,'Expiration date')]]/../..//select[@id='ExpireYear']    ${year}
    Wait Until Page Contains Element    xpath=//label[text()[contains(.,'Expiration date')]]/../..//select[@id='ExpireMonth']
    List Selection Should Be    xpath=//label[text()[contains(.,'Expiration date')]]/../..//select[@id='ExpireMonth']    ${month}

HandleBillingAddress
    [Arguments]    ${title}    ${billingAddress}
    ClickOnRealButton    Checkout
    CheckH2Title    ${title}
    CheckDropDownValue2    Select a billing address from your address book or enter a new address.    ${billingAddress}
    ClickOnButton    Continue

HandlingShippingAddress
    [Arguments]    ${title}    ${inStoreTitle}    ${pageMessage}
    CheckH2Title    ${title}
    CheckCheckBox    ${inStoreTitle}
    Wait Until Page Contains    ${pageMessage}
    Click Element    xpath=//p[@class='back-link']/..//input

HandlingPaymentMethod
    [Arguments]    ${title}    ${cashTitle}    ${cashPic}    ${checkTitle}    ${checkPic}    ${cardTitle}
    ...    ${cardPic}    ${purchaseTitle}    ${purchasePic}    ${selectedMethod}
    CheckH2Title    ${title}
    CheckRadioButtonByLabel    ${cashTitle}
    CheckRadioButtonByLabel    ${checkTitle}
    CheckRadioButtonByLabel    ${cardTitle}
    CheckRadioButtonByLabel    ${purchaseTitle}
    CheckImageWithSource    ${cashPic}
    CheckImageWithSource    ${checkPic}
    CheckImageWithSource    ${cardPic}
    CheckImageWithSource    ${purchasePic}
    ClickRadioButtonByLabel    ${selectedMethod}
    ClickOnButtonWithClass    button-1 payment-method-next-step-button

HandlingShippingMethod
    [Arguments]    ${title}    ${groundMethodTitle}    ${groundMethodDesc}    ${nextDayAirTitle}    ${nextDayAirDesc}    ${secDayAirTitle}
    ...    ${secDayAirDesc}    ${selectedMethod}
    CheckH2Title    ${title}
    CheckRadioButtonByLabel    ${groundMethodTitle}
    Wait Until Page Contains    ${groundMethodDesc}
    CheckRadioButtonByLabel    ${nextDayAirTitle}
    Wait Until Page Contains    ${nextDayAirDesc}
    CheckRadioButtonByLabel    ${secDayAirTitle}
    Wait Until Page Contains    ${secDayAirDesc}
    ClickRadioButtonByLabel    ${selectedMethod}
    ClickOnButtonWithClass    button-1 shipping-method-next-step-button

HandlingPaymentInformationPaywithCreditCard
    [Arguments]    ${title}    ${cardType}    ${cardHolderName}    ${cardNumber}    ${cardCode}    ${expYear}
    ...    ${expMonth}
    CheckH2Title    ${title}
    SetDropDownValueInTable    Select credit card    ${cardType}
    SetTextBoxValueInTable    Cardholder name    ${cardHolderName}
    SetTextBoxValueInTable    Card number    ${cardNumber}
    SetTextBoxValueInTable    Card code    ${cardCode}
    SetExpirationDate    ${expYear}    ${expMonth}
    CheckDropDownValueInTable    Select credit card    ${cardType}
    Comment    CheckTextBoxValueInTable    Cardholder name    Barbara Gordon    this can not be checked due to technical reasons
    Comment    CheckTextBoxValueInTable    Card number    4485564059489345    this can not be checked due to technical reasons
    Comment    CheckTextBoxValueInTable    Card code    123    this can not be checked due to technical reasons
    CheckExpirationDate    ${expYear}    ${expMonth}
    ClickOnButtonWithClass    button-1 payment-info-next-step-button

CheckOrderSectionContent
    [Arguments]    ${sectionName}    ${content}
    Run Keyword If    "${sectionName}"=="Billing Address"    CheckListElement    billing-info    ${content}
    Run Keyword If    "${sectionName}"==" \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ Shipping Address"    CheckListElement    shipping-info    ${content}

CheckShoppingCart
    [Arguments]    ${itemTitle}    ${price}    ${amount}    ${sumPrice}    ${checkbox}=true
    Run Keyword If    "${checkbox}"=="true"    Wait Until Page Contains Element    xpath=//tr[@class='cart-item-row']/td[1]/input[@type='checkbox']
    Wait Until Page Contains Element    xpath=//tr[@class='cart-item-row']/td[2]/img[@src='http://demowebshop.tricentis.com/content/images/thumbs/0000130_computing-and-internet_80.jpeg']
    Wait Until Page Contains Element    xpath=//tr[@class='cart-item-row']/td[3]/a[.='${itemTitle}']
    Wait Until Page Contains Element    xpath=//tr[@class='cart-item-row']/td[4]/span[.='${price}']
    Wait Until Page Contains Element    xpath=//tr[@class='cart-item-row']/td[5]/input[@value='${amount}']
    Wait Until Page Contains Element    xpath=//tr[@class='cart-item-row']/td[6]/span[.='${sumPrice}']
    Click Element    //input[@name='termsofservice']

CheckShoppingCartConfirmation
    [Arguments]    ${itemTitle}    ${price}    ${amount}    ${sumPrice}
    Wait Until Page Contains Element    xpath=//tr[@class='cart-item-row']/td[1]/img[@src='http://demowebshop.tricentis.com/content/images/thumbs/0000130_computing-and-internet_80.jpeg']
    Wait Until Page Contains Element    xpath=//tr[@class='cart-item-row']/td[2]/a[.='${itemTitle}']
    Wait Until Page Contains Element    xpath=//tr[@class='cart-item-row']/td[3]/span[.='${price}']
    Wait Until Page Contains Element    xpath=//tr[@class='cart-item-row']/td[4]/span[.='${amount}']
    Wait Until Page Contains Element    xpath=//tr[@class='cart-item-row']/td[5]/span[.='${sumPrice}']

ConfirmOrderedItem
    [Arguments]    ${fullName}    ${email}    ${phone}    ${fax}    ${companyName}    ${address1}
    ...    ${address2}    ${city}    ${zip}    ${country}    ${payMode}    ${shippingMode}
    ...    ${itemName}    ${price}    ${amount}    ${sumPrice}
    CheckH2Title    Confirm order
    CheckOrderSectionContent    Billing Address    ${fullName}
    CheckOrderSectionContent    Billing Address    ${CURRENT_TEST_USER}
    CheckOrderSectionContent    Billing Address    ${phone}
    CheckOrderSectionContent    Billing Address    ${fax}
    CheckOrderSectionContent    Billing Address    ${companyName}
    CheckOrderSectionContent    Billing Address    ${address1}
    CheckOrderSectionContent    Billing Address    ${address2}
    CheckOrderSectionContent    Billing Address    ${city}
    CheckOrderSectionContent    Billing Address    ${zip}
    CheckOrderSectionContent    Billing Address    ${country}
    CheckOrderSectionContent    Billing Address    ${payMode}
    CheckOrderSectionContent    Shipping Address    ${fullName}
    CheckOrderSectionContent    Shipping Address    ${CURRENT_TEST_USER}
    CheckOrderSectionContent    Shipping Address    ${phone}
    CheckOrderSectionContent    Shipping Address    ${fax}
    CheckOrderSectionContent    Shipping Address    ${companyName}
    CheckOrderSectionContent    Shipping Address    ${address1}
    CheckOrderSectionContent    Shipping Address    ${address2}
    CheckOrderSectionContent    Shipping Address    ${city}
    CheckOrderSectionContent    Shipping Address    ${zip}
    CheckOrderSectionContent    Shipping Address    ${country}
    CheckOrderSectionContent    Shipping Address    ${shippingMode}
    Page Should Contain    Billing Address
    Page Should Contain    Payment Method
    Page Should Contain    Shipping Address
    Page Should Contain    Shipping Method
    CheckShoppingCartConfirmation    ${itemName}    ${price}    ${amount}    ${sumPrice}
    ClickOnButton    Confirm

GetOrderNumber
    ${orderNumber}=    GetListElement    details
    Set Global Variable    ${ORDER_NUMBER}    ${orderNumber}
    [Return]    ${orderNumber}

SaveOrderNumber
    [Arguments]    ${title}    ${systemMessage}
    CheckH1Title    ${title}
    Wait Until Page Contains    ${systemMessage}
    ${orderNumber}=    GetOrderNumber
    Log    ${orderNumber}
    Comment    Log    ${CURDIR}
    Comment    ExcelLibrary.Open Excel    ${CURDIR}\\IO.xls
    Comment    Comment    ExcelLibrary.Add New Sheet    ${CURRENT_TEST_USER}
    Comment    ExcelLibrary.Put String To Cell    Sheet1    1    1    AAA
    Comment    ExcelLibrary.Save Excel    ${CURDIR}\\IO.xls
    Comment    ${orderNumber}
    ClickOnButton    Continue
    Wait Until Page Contains    Categories

CheckRegisteredUser
    [Arguments]    ${firstNameTitle}    ${lastNameTitle}    ${emailTitle}    ${passwordTitle}    ${confPasswordtitle}    ${genderTitle}
    ...    ${registerTitle}    ${yourPersonalDetailsTitle}    ${yourPasswordTitle}
    Wait Until Page Contains    Register
    ClickOnLink    Register
    CheckTextBox    ${firstNameTitle}
    CheckTextBox    ${lastNameTitle}
    CheckTextBox    ${emailTitle}
    CheckTextBox    ${passwordTitle}
    CheckTextBox    ${confPasswordtitle}
    CheckRadioButton    ${genderTitle}    gender-male
    CheckRadioButton    ${genderTitle}    gender-female
    CheckButton    ${registerTitle}
    Wait Until Page Contains    ${registerTitle}
    Wait Until Page Contains    ${yourPersonalDetailsTitle}
    Wait Until Page Contains    ${yourPasswordTitle}

CheckOrderElements
    [Arguments]    ${orderStatus}    ${orderAmount}
    CheckListElement    info    ${orderStatus}
    CheckListElement    info    ${orderAmount}

CheckOrder
    [Arguments]    ${title}    ${titlePersonalDetails}    ${firstName}    ${lastName}    ${email}    ${gender}
    ...    ${ordersTitle}    ${orderNumber}    ${orderStatus}    ${orderAmount}
    ClickOnLink    My account
    CheckH1Title    ${title}
    Wait Until Page Contains    ${titlePersonalDetails}
    CheckTextBoxValue    First name:    ${firstName}
    CheckTextBoxValue    Last name:    ${lastName}
    CheckTextBoxValue    Email:    ${email}
    CheckRadioButtonIfChecked    Gender:    gender-male
    CheckRadioButtonIfNotChecked    Gender:    gender-female
    ClickOnLink    Orders
    CheckH1Title    ${ordersTitle}
    ${ORDER_NUMBER}    Replace String    ${ORDER_NUMBER}    n    N
    Wait Until Page Contains    ${orderNumber}
    CheckOrderElements    ${orderStatus}    ${orderAmount}

HandlingShippingMethodFromList
    [Arguments]    @{listOfParams}
    ${item}    Collections.Get From List    @{listOfParams}    0
    Run Keyword If    "${item}"!="TS_Hanling_Shipping_Method"    Fail    Wrong Test Data
    ${item}    Collections.Get From List    @{listOfParams}    1
    CheckH2Title    ${item}
    ${item}    Collections.Get From List    @{listOfParams}    2
    CheckRadioButtonByLabel    ${item}
    ${item}    Collections.Get From List    @{listOfParams}    3
    Wait Until Page Contains    ${item}
    ${item}    Collections.Get From List    @{listOfParams}    4
    CheckRadioButtonByLabel    ${item}
    ${item}    Collections.Get From List    @{listOfParams}    5
    Wait Until Page Contains    ${item}
    ${item}    Collections.Get From List    @{listOfParams}    6
    CheckRadioButtonByLabel    ${item}
    ${item}    Collections.Get From List    @{listOfParams}    7
    Wait Until Page Contains    ${item}
    ${item}    Collections.Get From List    @{listOfParams}    8
    ClickRadioButtonByLabel    ${item}
    ClickOnButtonWithClass    button-1 shipping-method-next-step-button

QueryField
    [Arguments]    ${fieldId}
    Connect to database    pymysql    testcases    admin    pwd123    127.0.0.1    3306
    @{category}=    Query    select \ ${fieldId} from items
    ${value}    Collections.Get From List    @{category}    0
    Disconnect From Database
    [Return]    ${value}

AddItemToCartDataBase
    ${category}    functionalKeywords.QueryField    category
    ClickLink    ${category}
    CheckSpanTitle    Shopping cart
    CheckSpanTitle    (0)
    ${item}    functionalKeywords.QueryField    subcategory
    ClickOnLink    ${item}
    CheckH1Title    ${item}
    CheckNumericStepperContent    Qty    1
    ClickOnButton    Add to cart
    CheckSpanTitle    Shopping cart
    CheckSpanTitle    (1)
