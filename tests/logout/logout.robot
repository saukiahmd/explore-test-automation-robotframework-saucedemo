*** Settings ***
Resource    ../../resources/keywords/login_keyword.robot
Resource    ../../resources/browser_config.robot

Test Setup    Run Keywords    Open Chrome With Config    AND    Login As User    standard_user    secret_sauce  
Test Teardown  Close Browser

*** Test Cases ***
User Can Logout Successfully
    Click Element    ${MENU_BUTTON_SELECTOR}
    Wait Until Element Is Visible    ${LOGOUT_BUTTON_SELECTOR}    timeout=10s
    Click Element    ${LOGOUT_BUTTON_SELECTOR}
    Verify User Is On Login Page