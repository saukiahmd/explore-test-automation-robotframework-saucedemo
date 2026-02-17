*** Settings ***
Resource    ../../resources/keywords/login_keyword.robot
Resource    ../../resources/keywords/addToCart_keyword.robot

Test Setup    Run Keywords    Open Saucedemo    AND    Login As User    standard_user    secret_sauce  
Test Teardown  Close Browser

*** Test Cases ***
User Can View Product List
    Verify Product List Is Displayed