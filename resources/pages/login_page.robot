*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${USERNAME_INPUT}    id=user-name
${PASSWORD_INPUT}    id=password
${LOGIN_BUTTON}      id=login-button
${ERROR_MESSAGE}     css=.error-message-container
${PRODUCT_TITLE}     css=.title

${MENU_BUTTON_SELECTOR}    css:#react-burger-menu-btn
${LOGOUT_BUTTON_SELECTOR}    id=logout_sidebar_link

*** Keywords ***
Verify Login Page Is Displayed
    Page Should Contain Element    ${USERNAME_INPUT}
    Page Should Contain Element    ${PASSWORD_INPUT}
    Page Should Contain Element    ${LOGIN_BUTTON}

Input Username
    [Arguments]    ${username}
    Input Text    ${USERNAME_INPUT}    ${username}

Input Password
    [Arguments]    ${password}
    Input Text    ${PASSWORD_INPUT}    ${password}

Click Login Button
    Click Button    ${LOGIN_BUTTON}

Verify Products Page Is Displayed
    Page Should Contain Element    ${PRODUCT_TITLE}

Verify Login Error Displayed
    [Arguments]    ${error_text}
    Page Should Contain Element    ${ERROR_MESSAGE}
    Element Text Should Be    ${ERROR_MESSAGE}    ${error_text}
