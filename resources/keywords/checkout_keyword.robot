*** Settings ***
Library    SeleniumLibrary
Resource   ../pages/productListPage_page.robot
Resource   ../pages/addToCart_page.robot
Resource   ../pages/checkout_page.robot

*** Keywords ***
Click checkout Button in Cart Page
    Click Button    ${CHECKOUT_BUTTON_SELECTOR}

Input Checkout Information
    [Arguments]    @{INFORMATION}
    Input data checkout information    @{INFORMATION}

Click Continue Button
    Click Button    ${CONTINUE_BUTTON}

Verify Checkout Overview Page is Displayed
    Verify Checkout Overview Page Displayed

Click Finish Button
    Click Button    ${CHECKOUT_OVERVIEW_FINISH_BUTTON}

Verify Checkout Complete Page is Displayed
    Verify Checkout Complete Page Displayed

Click Cart Icon
    Click Element    ${SHOPPING_CART_SELECTOR}

Verify Error Message Displayed
    [Arguments]    ${error_message}
    Element Should Be Visible    ${ERROR_MESSAGE_SELECTOR}
    Element Text Should Be    ${ERROR_MESSAGE_SELECTOR}    ${error_message}