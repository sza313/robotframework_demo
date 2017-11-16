*** Settings ***
Suite Setup
Suite Teardown    Close Browser
Test Setup
Test Teardown
Test Template
Resource          Keywords/functionalKeywords.txt

*** Test Cases ***
TS_Click_On_Register
    [Documentation]    TS_Click_On_Register
    ...
    ...    Name - click on register
    ...    Description - dialogue requesting user data shown
    ...    Expected Result - main page of webshop loaded
    ...    Checkpoint - wait till page is loaded (email address shown)
    [Tags]
    [Setup]    OpenApplication    ${url}    ${BROWSER}
    [Template]    CheckRegistrationForm
    First name:    Last name:    Email:    Password:    Confirm password:    Gender    Register
    ...    Your Personal Details    Your Password

TS_Register_User
    [Documentation]    TS_Click_On_Register
    ...
    ...    Name - click on register
    ...    Description - dialogue requesting user data shown
    ...    Expected Result - main page of webshop loaded
    ...    Checkpoint - wait till page is loaded (email address shown)
    [Tags]
    [Template]    FillRegistrationForm
    Szabolcs    Hudak    Robot1234!    Robot1234!    male
    [Teardown]    Logout

TS_Check_Address
    [Documentation]    TS_Click_On_Register
    ...
    ...    Name - click on register
    ...    Description - dialogue requesting user data shown
    ...    Expected Result - main page of webshop loaded
    ...    Checkpoint - wait till page is loaded (email address shown)
    [Setup]    Login    ${CURRENT_TEST_USER}    Robot1234!
    [Template]    CheckAddress
    Szabolcs    Hudak    ${CURRENT_TEST_USER}    No addresses
    [Teardown]

TS_Add_Address
    [Documentation]    TS_Click_On_Register
    ...
    ...    Name - click on register
    ...    Description - dialogue requesting user data shown
    ...    Expected Result - main page of webshop loaded
    ...    Checkpoint - wait till page is loaded (email address shown)
    [Setup]
    [Template]    AddAndCheckAddress
    Szabolcs    Hudak    ${CURRENT_TEST_USER}    My Company    Vienna    Vienna Street    Vienna 2 \ Street
    ...    1234    00 11 22 33 44 55    00 11 22 33 44 88    Austria    Other (Non US)
    [Teardown]    Logout

TS_Login
    [Documentation]    TS_Login
    ...
    ...    Name - open web shop
    ...    Description - Navigate to http://demowebshop.tricentis.com/
    ...    Expected Result - main page of webshop loaded
    ...    Checkpoint - wait till page is loaded (login dialogue shown)
    [Setup]
    [Template]    Login
    ${CURRENT_TEST_USER}    Robot1234!
    [Teardown]

TS_Order_An_Item
    [Template]    AddItemToCart
    Books    Computing and Internet

TS_Order_An_Item_Data_Base
    [Tags]
    [Template]
    AddItemToCartDataBase

TS_Open_Shopping_Cart
    [Template]    OPenShoppingCart
    Computing and Internet    10.00    1    10.00

TS_Handling_Billing_Address
    [Template]    HandleBillingAddress
    Billing address    Szabolcs Hudak, Vienna Street, Vienna 1234, Austria

TS_Handling_Shipping_Address
    [Template]    HandlingShippingAddress
    Shipping address    In-Store Pickup    Pick up your items at the store (put your store address here)

TS_Handling_Shipping_Method
    [Template]    HandlingShippingMethod
    Shipping method    Ground (0.00)    Compared to other shipping methods, like by flight or over seas, ground shipping is carried out closer to the earth    Next Day Air (0.00)    The one day air shipping    2nd Day Air (0.00)    The two day air shipping
    ...    Ground (0.00)

TS_Handling_Shipping_Method_Independent_Datasource
    [Tags]
    [Template]
    @{list}=    CSVLibrary.Read Csv File To List    ${CURDIR}\\TestData.csv
    Log    @{list}
    HandlingShippingMethodFromList    @{list}

TS_Handling_Payment_Method
    [Template]    HandlingPaymentMethod
    Payment method    Cash On Delivery (COD) (7.00)    http://demowebshop.tricentis.com/plugins/Payments.CashOnDelivery/logo.jpg    Check / Money Order (5.00)    http://demowebshop.tricentis.com/plugins/Payments.CheckMoneyOrder/logo.jpg    Credit Card    http://demowebshop.tricentis.com/plugins/Payments.Manual/logo.jpg
    ...    Purchase Order    http://demowebshop.tricentis.com/plugins/Payments.PurchaseOrder/logo.jpg    Credit Card

TS_Handling_Payment_Information_Pay_With_Card
    [Template]    HandlingPaymentInformationPaywithCreditCard
    Payment information    Visa    Barbara Gordon    4485564059489345    123    2020    04

TS_Make_Confirmation
    [Template]    ConfirmOrderedItem
    Szabolcs Hudak    ${CURRENT_TEST_USER}    00 11 22 33 44 55    00 11 22 33 44 88    My Company    Vienna Street    Vienna 2 \ Street
    ...    Vienna    1234    Austria    Credit Card    Ground    Computing and Internet
    ...    10.00    1    10.00

TS_Save_Order_Number
    [Template]    SaveOrderNumber
    Thank you    Your order has been successfully processed!

TS_Check_Order
    [Template]    CheckOrder
    My account - Customer info    Your Personal Details    Szabolcs    Hudak    ${CURRENT_TEST_USER}    male    My account - Orders
    ...    ${ORDER_NUMBER}    Order status: Pending    Order Total: 10.00
    [Teardown]    Logout
