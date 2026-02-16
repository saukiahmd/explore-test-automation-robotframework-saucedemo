*** Settings ***
Resource    ../../resources/keywords/login_keyword.robot

Test Setup     Open Saucedemo
Test Teardown  Close Browser

*** Test Cases ***
User Can Login With Valid Account
    Login As User    standard_user    secret_sauce
    Verify User Is On Products Page

User Cant Login with locked out user
    Login As User    locked_out_user    secret_sauce
    Verify Login Error Is Displayed    Epic sadface: Sorry, this user has been locked out.

User Cant Login with Invalid Password
    Login As User    standard_user    wrong_password
    Verify Login Error Is Displayed    Epic sadface: Username and password do not match any user in this service

User Cant login with Invalid Username
    Login As User    invalid_user    secret_sauce
    Verify Login Error Is Displayed    Epic sadface: Username and password do not match any user in this service

User Cant Login with Empty Username and Empty Password
    Login As User    ${EMPTY}    ${EMPTY}
    Verify Login Error Is Displayed    Epic sadface: Username is required

User Cant Login with Empty Password only
    Login As User    standard_user    ${EMPTY}
    Verify Login Error Is Displayed    Epic sadface: Password is required

User Cant Login with Empty Username only
    Login As User    ${EMPTY}    secret_sauce
    Verify Login Error Is Displayed    Epic sadface: Username is required