*** Settings ***
Library    SeleniumLibrary
Resource    ../pages/productListPage_page.robot

*** Variables ***
# Infomartion for checkout
${INPUT_FIRST_NAME}    id=first-name
${INPUT_LAST_NAME}     id=last-name
${INPUT_POSTAL_CODE}   id=postal-code
${CONTINUE_BUTTON}    css:.cart_button
${ERROR_MESSAGE_SELECTOR}    css:.error-message-container.error

#checkout overview
${CHECKOUT_OVERVIEW_TITLE}    css:.title
${CHECKOUT_OVERVIEW_ITEM}     css:.cart_item
${CHECKOUT_OVERVIEW_ITEM_NAME}    css:.cart_item .inventory_item_name
${CHECKOUT_OVERVIEW_ITEM_DESC}    css:.cart_item .inventory_item_desc
${CHECKOUT_OVERVIEW_ITEM_PRICE}   css:.cart_item .inventory_item_price
${CHECKOUT_OVERVIEW_SUBTOTAL}     css:.summary_subtotal_label
${CHECKOUT_OVERVIEW_TAX}          css:.summary_tax_label
${CHECKOUT_OVERVIEW_TOTAL}        css:.summary_total_label
${CHECKOUT_OVERVIEW_FINISH_BUTTON}    id=finish
${CHECKOUT_OVERVIEW_CANCEL_BUTTON}    id=cancel

#checkout complete
${CHECKOUT_COMPLETE_TITLE}    css:.complete-header
${CHECKOUT_COMPLETE_MESSAGE}  css:.complete-text

*** Keywords ***
Input data checkout information
    [Arguments]    @{INFORMATION}
    Input Text    ${INPUT_FIRST_NAME}    ${INFORMATION}[0]
    Input Text    ${INPUT_LAST_NAME}     ${INFORMATION}[1]
    Input Text    ${INPUT_POSTAL_CODE}   ${INFORMATION}[2]

Verify Checkout Overview Page Displayed
    Element Should Be Visible    ${CHECKOUT_OVERVIEW_TITLE}
    Element Should Be Visible    ${CHECKOUT_OVERVIEW_ITEM}
    Element Should Be Visible    ${CHECKOUT_OVERVIEW_ITEM_NAME}
    Element Should Be Visible    ${CHECKOUT_OVERVIEW_ITEM_DESC}
    Element Should Be Visible    ${CHECKOUT_OVERVIEW_ITEM_PRICE}
    Element Should Be Visible    ${CHECKOUT_OVERVIEW_SUBTOTAL}
    Element Should Be Visible    ${CHECKOUT_OVERVIEW_TAX}
    Element Should Be Visible    ${CHECKOUT_OVERVIEW_TOTAL}
    Element Should Be Visible    ${CHECKOUT_OVERVIEW_FINISH_BUTTON}
    Element Should Be Visible    ${CHECKOUT_OVERVIEW_CANCEL_BUTTON}

Verify Checkout Complete Page Displayed
    Element Should Be Visible    ${CHECKOUT_COMPLETE_TITLE}
    Element Should Be Visible    ${CHECKOUT_COMPLETE_MESSAGE}
    