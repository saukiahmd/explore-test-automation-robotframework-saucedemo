*** Settings ***
Library    SeleniumLibrary
Library    Collections

*** Variables ***
#header
${BURGER_MENU_SELECTOR}    css:#react-burger-menu-btn
${APP_LOGO_SELECTOR}    css:.app_logo
${SHOPPING_CART_SELECTOR}    css:.shopping_cart_link
${TITLE_PAGE_SELECTOR}    css:.title
${SORT_BUTTON_SELECTOR}     css=.product_sort_container

#product list
${IMAGE_SELECTOR}    css:.inventory_container .inventory_list .inventory_item .inventory_item_img a img
${NAME_SELECTOR}    css:.inventory_container .inventory_list .inventory_item .inventory_item_description .inventory_item_label a .inventory_item_name
${DESC_SELECTOR}    css:.inventory_container .inventory_list .inventory_item .inventory_item_description .inventory_item_label .inventory_item_desc
${PRICE_SELECTOR}    css:.inventory_container .inventory_list .inventory_item .inventory_item_description .pricebar .inventory_item_price
${ADD_TO_CART_BUTTON_SELECTOR}    css:.inventory_container .inventory_list .inventory_item .inventory_item_description .pricebar button

#product detail
${BACK_TO_PRODUCT_LIST_SELECTOR}    css:.inventory_details_back_button
${IMAGE_DETAIL_SELECTOR}    css:.inventory_details_img_container img
${NAME_DETAIL_SELECTOR}    css:.inventory_details_name.large_size
${DESC_DETAIL_SELECTOR}    css:.inventory_details_desc.large_size
${PRICE_DETAIL_SELECTOR}    css:.inventory_details_price
${ADD_TO_CART_DETAIL_BUTTON_SELECTOR}    css:.btn.btn_primary.btn_small.btn_inventory

#footer
${SOCIAL_FOOTER_SELECTOR}    css:.social
${COPYRIGHT_FOOTER_SELECTOR}    css:.footer_copy

*** Keywords ***
Verify Product List Displayed
    ${IMAGE_PRODUCT}    Get WebElements    ${IMAGE_SELECTOR}
    ${NAME_PRODUCT}    Get WebElements    ${NAME_SELECTOR}
    ${DESC_PRODUCT}    Get WebElements    ${DESC_SELECTOR}
    ${PRICE_PRODUCT}    Get WebElements    ${PRICE_SELECTOR}
    ${BUTTON_PRODUCT}    Get WebElements    ${ADD_TO_CART_BUTTON_SELECTOR}

    ${TOTAL_PRODUCT}=    GET LENGTH    ${NAME_PRODUCT}
    Log To Console       Total Product: ${TOTAL_PRODUCT}

    #verify element header
    Page Should Contain Element    ${APP_LOGO_SELECTOR}
    Page Should Contain Element    ${SHOPPING_CART_SELECTOR}
    Page Should Contain Element    ${TITLE_PAGE_SELECTOR}
    Page Should Contain Element    ${SORT_BUTTON_SELECTOR}

    FOR    ${i}    IN RANGE    ${TOTAL_PRODUCT}
        ${text_nama}=    Get Text    ${NAME_PRODUCT}[${i}]
        ${text_desc}=    Get Text    ${DESC_PRODUCT}[${i}]
        ${text_price}=   Get Text    ${PRICE_PRODUCT}[${i}]

        Page Should Contain Element    ${IMAGE_PRODUCT}[${i}]
        Page Should Contain Element    ${NAME_PRODUCT}[${i}]
        Should Not Be Empty            ${text_nama}
        Page Should Contain Element    ${DESC_PRODUCT}[${i}]
        Should Not Be Empty            ${text_desc}
        Page Should Contain Element    ${PRICE_PRODUCT}[${i}]
        Should Not Be Empty            ${text_price}
        Page Should Contain Element    ${BUTTON_PRODUCT}[${i}]
    END

    #Verify Footer
    Page Should Contain Element    ${SOCIAL_FOOTER_SELECTOR}
    Page Should Contain Element    ${COPYRIGHT_FOOTER_SELECTOR}

Click Sort Button
    [Arguments]    ${sort_option}
    Select From List By Label    ${SORT_BUTTON_SELECTOR}    ${sort_option}

Verify Product List Displayed After Sorting
    [Arguments]    ${sort_option}
    ${IMAGE_PRODUCT}    Get WebElements    ${IMAGE_SELECTOR}
    ${NAME_PRODUCT}    Get WebElements    ${NAME_SELECTOR}
    ${DESC_PRODUCT}    Get WebElements    ${DESC_SELECTOR}
    ${PRICE_PRODUCT}    Get WebElements    ${PRICE_SELECTOR}
    ${BUTTON_PRODUCT}    Get WebElements    ${ADD_TO_CART_BUTTON_SELECTOR}
    
    ${product_list_system_sort}=    Create List
    ${product_list_web_sort}=    Create List

    ${sorted_list}=    Create List

    ${TOTAL_PRODUCT}=    GET LENGTH    ${NAME_PRODUCT}
    Log To Console       Total Product: ${TOTAL_PRODUCT}

    #verify element header
    Page Should Contain Element    ${APP_LOGO_SELECTOR}
    Page Should Contain Element    ${SHOPPING_CART_SELECTOR}
    Page Should Contain Element    ${TITLE_PAGE_SELECTOR}
    Page Should Contain Element    ${SORT_BUTTON_SELECTOR}

    FOR    ${i}    IN RANGE    ${TOTAL_PRODUCT}
        ${text_nama}=    Get Text    ${NAME_PRODUCT}[${i}]
        ${text_desc}=    Get Text    ${DESC_PRODUCT}[${i}]
        ${text_price}=   Get Text    ${PRICE_PRODUCT}[${i}]
        
        Page Should Contain Element    ${IMAGE_PRODUCT}[${i}]
        Page Should Contain Element    ${NAME_PRODUCT}[${i}]
        Should Not Be Empty            ${text_nama}
        Page Should Contain Element    ${DESC_PRODUCT}[${i}]
        Should Not Be Empty            ${text_desc}
        Page Should Contain Element    ${PRICE_PRODUCT}[${i}]
        Should Not Be Empty            ${text_price}
        Page Should Contain Element    ${BUTTON_PRODUCT}[${i}]

        ${product}=    Create List    ${text_nama}    ${text_desc}    ${text_price}
        Append To List    ${product_list_system_sort}     ${product}
    END

    #Verify Footer
    Page Should Contain Element    ${SOCIAL_FOOTER_SELECTOR}
    Page Should Contain Element    ${COPYRIGHT_FOOTER_SELECTOR}

    IF    '${sort_option}' == 'Name (A to Z)'
        ${sorted_list}=    Evaluate    sorted(${product_list_system_sort}, key=lambda x: x[0], reverse=False)
    ELSE IF    '${sort_option}' == 'Name (Z to A)'
        ${sorted_list}=    Evaluate    sorted(${product_list_system_sort}, key=lambda x: x[0], reverse=True)
    ELSE IF    '${sort_option}' == 'Price (low to high)'
        ${sorted_list}=    Evaluate    sorted(${product_list_system_sort}, key=lambda x: float(x[2].replace('$','')), reverse=False)
    ELSE IF    '${sort_option}' == 'Price (high to low)'
        ${sorted_list}=    Evaluate    sorted(${product_list_system_sort}, key=lambda x: float(x[2].replace('$','')), reverse=True)
        
    END
    

    # ${sorted_list}=    Evaluate    sorted(${product_list_system_sort}, reverse=False)

    # klik sort sesuai option
    Click Sort Button    ${sort_option}

    ${IMAGE_PRODUCT2}    Get WebElements    ${IMAGE_SELECTOR}
    ${NAME_PRODUCT2}    Get WebElements    ${NAME_SELECTOR}
    ${DESC_PRODUCT2}    Get WebElements    ${DESC_SELECTOR}
    ${PRICE_PRODUCT2}    Get WebElements    ${PRICE_SELECTOR}
    ${BUTTON_PRODUCT2}    Get WebElements    ${ADD_TO_CART_BUTTON_SELECTOR}

    #verify element header after sort
    Page Should Contain Element    ${APP_LOGO_SELECTOR}
    Page Should Contain Element    ${SHOPPING_CART_SELECTOR}
    Page Should Contain Element    ${TITLE_PAGE_SELECTOR}
    Page Should Contain Element    ${SORT_BUTTON_SELECTOR}

    FOR    ${i}    IN RANGE    ${TOTAL_PRODUCT}
        ${text_nama}=    Get Text    ${NAME_PRODUCT2}[${i}]
        ${text_desc}=    Get Text    ${DESC_PRODUCT2}[${i}]
        ${text_price}=   Get Text    ${PRICE_PRODUCT2}[${i}]
        
        Page Should Contain Element    ${IMAGE_PRODUCT}[${i}]
        Page Should Contain Element    ${NAME_PRODUCT2}[${i}]
        Should Not Be Empty            ${text_nama}
        page Should Contain Element    ${DESC_PRODUCT2}[${i}]
        Should Not Be Empty            ${text_desc}
        page Should Contain Element    ${PRICE_PRODUCT2}[${i}]
        Should Not Be Empty            ${text_price}
        Page Should Contain Element    ${BUTTON_PRODUCT2}[${i}]

        ${product}=    Create List    ${text_nama}    ${text_desc}    ${text_price}
        Append To List    ${product_list_web_sort}     ${product}
    END

    #Verify Footer
    Page Should Contain Element    ${SOCIAL_FOOTER_SELECTOR}
    Page Should Contain Element    ${COPYRIGHT_FOOTER_SELECTOR}

    Log To Console       data list system sort: ${sorted_list}
    Log To Console       data list web sort: ${product_list_web_sort}

    #compare list sort sendiri dengan list setelah klik sort
    Lists Should Be Equal    ${sorted_list}     ${product_list_web_sort}

Verify Product Detail Page Displayed
    [Arguments]    ${product_name}

    ${NAME_PRODUCT}=    Get WebElements    ${NAME_SELECTOR}
    ${TOTAL_PRODUCT}=    Get Length    ${NAME_PRODUCT}

    FOR    ${i}    IN RANGE    ${TOTAL_PRODUCT}
        ${text_nama}=    Get Text    ${NAME_PRODUCT}[${i}]
        IF    '${text_nama}' == '${product_name}'
            Click Element    ${NAME_PRODUCT}[${i}]
            # verify element header
            Page Should Contain Element    ${APP_LOGO_SELECTOR}
            Page Should Contain Element    ${SHOPPING_CART_SELECTOR}
            Page Should Contain Element    ${BACK_TO_PRODUCT_LIST_SELECTOR}

            #verify element product detail
            ${text_nama}=    Get Text    ${NAME_DETAIL_SELECTOR}
            ${text_desc}=    Get Text    ${DESC_DETAIL_SELECTOR}
            ${text_price}=   Get Text    ${PRICE_DETAIL_SELECTOR}

            Page Should Contain Element    ${IMAGE_DETAIL_SELECTOR}
            Page Should Contain Element    ${NAME_DETAIL_SELECTOR}
            Should Not Be Empty           ${text_nama}
            Page Should Contain Element    ${DESC_DETAIL_SELECTOR}
            Should Not Be Empty           ${text_desc}
            Page Should Contain Element    ${PRICE_DETAIL_SELECTOR}
            Should Not Be Empty           ${text_price}
            Page Should Contain Element    ${ADD_TO_CART_DETAIL_BUTTON_SELECTOR}
            
            #Verify Footer
            Page Should Contain Element    ${SOCIAL_FOOTER_SELECTOR}
            Page Should Contain Element    ${COPYRIGHT_FOOTER_SELECTOR}
            Exit For Loop
        END
        
    END