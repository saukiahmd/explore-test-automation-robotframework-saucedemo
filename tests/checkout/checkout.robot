*** Settings ***
Resource    ../../resources/keywords/login_keyword.robot
Resource    ../../resources/keywords/addToCart_keyword.robot
Resource    ../../resources/keywords/checkout_keyword.robot
Resource    ../../resources/browser_config.robot

Test Setup    Run Keywords    Open Chrome With Config    AND    Login As User    standard_user    secret_sauce  
Test Teardown  Close Browser

*** Variables ***
@{INFORMATION}
...    Ahmad
...    Sauqi
...    12345

@{PRODUCTS}
...    Sauce Labs Backpack
...    Sauce Labs Bolt T-Shirt
...    Sauce Labs Onesie

*** Test Cases ***
User can checkout successfully
    Add Product To Cart via Product List    Sauce Labs Backpack
    Verify Product in Cart via Product List    Sauce Labs Backpack
    Click checkout Button in Cart Page
    Input Checkout Information    @{INFORMATION}
    Click Continue Button
    Verify Checkout Overview Page is Displayed
    Click Finish Button
    Verify Checkout Complete Page is Displayed

User can checkout multiple product successfully
    Add Multiple Product To Cart    @{PRODUCTS}
    Verify Multiple Product in Cart    @{PRODUCTS}
    Click checkout Button in Cart Page
    Input Checkout Information    @{INFORMATION}
    Click Continue Button
    Verify Checkout Overview Page is Displayed
    Click Finish Button
    Verify Checkout Complete Page is Displayed

User can't checkout with empty information
    Add Product To Cart via Product List    Sauce Labs Backpack
    Verify Product in Cart via Product List    Sauce Labs Backpack
    Click checkout Button in Cart Page
    Click Continue Button
    Verify Error Message Displayed    Error: First Name is required
