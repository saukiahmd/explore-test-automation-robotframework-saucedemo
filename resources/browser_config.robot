*** Settings ***
Library    SeleniumLibrary

*** Keywords ***
Open Chrome With Config
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys

    # Only Incognito (handling pop-up) and Start Maximized (handling element not interactable) are added as of now, you can add more configuration as needed
    Call Method    ${options}    add_argument    --incognito
    Call Method    ${options}    add_argument    --start-maximized

    Open Browser    https://www.saucedemo.com    chrome    options=${options}
