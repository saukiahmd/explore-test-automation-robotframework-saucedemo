*** Settings ***
Resource    ../../resources/keywords/login_keyword.robot
Resource    ../../resources/keywords/productListPage_keyword.robot

Test Setup    Run Keywords    Open Saucedemo    AND    Login As User    standard_user    secret_sauce  
Test Teardown  Close Browser

*** Test Cases ***
# User Can View Product List
#     Verify Product List Is Displayed

# User Can Sort Products From A To Z
#     Verify Product List Is Displayed After Sorting From    Name (A to Z)

# User Can Sort Products From Z To A
#     Verify Product List Is Displayed After Sorting From    Name (Z to A)

# User Can Sort Products From Price Low To High
#     Verify Product List Is Displayed After Sorting From    Price (low to high)

# User Can Sort Products From Price High To Low
#     Verify Product List Is Displayed After Sorting From    Price (high to low)

User can open product detail page
    Verify Product Detail Page Is Displayed    Sauce Labs Bike Light