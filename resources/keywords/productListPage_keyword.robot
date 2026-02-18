*** Settings ***
Library    SeleniumLibrary
Resource   ../pages/productListPage_page.robot

*** Keywords ***
Verify Product List Is Displayed
    Verify Product List Displayed

Verify Product List Is Displayed After Sorting From
     [Arguments]    ${sort_option}
     Verify Product List Displayed After Sorting    ${sort_option}

Verify Product Detail Page Is Displayed
    [Arguments]    ${product_name}
    Click Product Name    ${product_name}
    Verify Product Detail Page Displayed