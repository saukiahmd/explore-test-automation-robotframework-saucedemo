*** Settings ***
Library    SeleniumLibrary
Resource   ../pages/productListPage_page.robot
Resource   ../pages/addToCart_page.robot

*** Keywords ***
Add Product To Cart via Product List
    [Arguments]    ${product_name}
    Verify Product in Cart via Product List    ${product_name}

Add Product To Cart via Product Detail
    [Arguments]    ${product_name}
    Click Product Name    ${product_name}
    Verify Product in Cart via Product Detail    ${product_name}

Remove Product From Cart via Product List
    [Arguments]    ${product_name}
    Verify Product deleted from Cart via Product List    ${product_name}

Remove Product From Cart via Product Detail
    [Arguments]    ${product_name}
    Verify Product deleted from Cart via Product Detail    ${product_name}

Add Multiple Product To Cart
    [Arguments]    @{product_name}
    Added Product To Cart via Product List    @{product_name}

Verify Multiple Product in Cart
    [Arguments]    @{product_name}
    Verified Multiple Product in Cart    @{product_name}