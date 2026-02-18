*** Settings ***
Resource    ../../resources/keywords/login_keyword.robot
Resource    ../../resources/keywords/addToCart_keyword.robot
Resource    ../../resources/browser_config.robot

Test Setup    Run Keywords    Open Chrome With Config    AND    Login As User    standard_user    secret_sauce  
Test Teardown  Close Browser

*** Variables ***
@{PRODUCTS}
...    Sauce Labs Backpack
...    Sauce Labs Bolt T-Shirt
...    Sauce Labs Onesie

*** Test Cases ***
User can add product to cart via Product List
    Add Product To Cart via Product List    Sauce Labs Backpack

User can add product to cart via Product Detail
    Add Product To Cart via Product Detail    Sauce Labs Backpack

User can remove product from cart via Product List
    Remove Product From Cart via Product List    Sauce Labs Backpack

User can remove product from cart via Product Detail
    Remove Product From Cart via Product Detail    Sauce Labs Backpack

User can add multiple product to cart
    Add Multiple Product To Cart    @{PRODUCTS}
    Verify Multiple Product in Cart    @{PRODUCTS}