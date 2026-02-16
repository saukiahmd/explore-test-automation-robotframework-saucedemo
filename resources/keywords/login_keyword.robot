*** Settings ***
Library    SeleniumLibrary
Resource   ../pages/login_page.robot

*** Keywords ***
Open Saucedemo
    Open Browser    https://www.saucedemo.com    chrome
    Maximize Browser Window

Login As User
    [Arguments]    ${username}    ${password}

    Input Username    ${username}
    Input Password    ${password}
    Click Login Button

Verify User Is On Products Page
    Verify Products Page Is Displayed

Verify Login Error Is Displayed
    [Arguments]    ${error_text}

    Verify Login Error Displayed    ${error_text}