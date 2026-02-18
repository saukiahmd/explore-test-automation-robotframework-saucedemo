*** Settings ***
Library    SeleniumLibrary
Resource    ../pages/productListPage_page.robot

*** Variables ***
${BADGE_CART_SELECTOR}    css:.shopping_cart_badge

${CART_ITEM_NAME_SELECTOR}    css:.cart_item .inventory_item_name
${CART_ITEM_PRICE_SELECTOR}    css:.cart_item .inventory_item_price
${CART_ITEM_DESC_SELECTOR}    css:.cart_item .inventory_item_desc
${CART_ITEM_REMOVE_BUTTON_SELECTOR}    css:.cart_item .cart_button
${CHECKOUT_BUTTON_SELECTOR}    css:.checkout_button
${CONTINUE_SHOPPING_BUTTON_SELECTOR}    id=continue-shopping
${CART_EMPTY_MESSAGE_SELECTOR}    css:.cart_empty
${CART_LIST_SELECTOR}    css:.cart_list
${CART_ITEM_SELECTOR}    css:.cart_item

*** Keywords ***
Verify Product in Cart via Product List
    [Arguments]    ${product_name}
    ${NAME_PRODUCT}=    Get WebElements    ${NAME_SELECTOR}
    ${TOTAL_PRODUCT}=    Get Length    ${NAME_PRODUCT}
    FOR    ${i}    IN RANGE    ${TOTAL_PRODUCT}
        ${text_nama}=    Get Text    ${NAME_PRODUCT}[${i}]
        IF    '${text_nama}' == '${product_name}'
            Log To Console    Produk ${product_name} ditemukan di product list!
            Page Should Contain Element    ${ADD_TO_CART_BUTTON_SELECTOR}
            ${button_text}=    Get Text    ${ADD_TO_CART_BUTTON_SELECTOR}
            Should Be Equal    ${button_text}    Add to cart

            Click Element    ${ADD_TO_CART_BUTTON_SELECTOR}
            Page Should Contain Element    ${REMOVE_BUTTON_SELECTOR}
            ${button_text_after}=    Get Text    ${REMOVE_BUTTON_SELECTOR}
            Should Be Equal    ${button_text_after}    Remove
            Exit For Loop
        END
    END

    Page Should Contain Element    ${BADGE_CART_SELECTOR}
    ${text_badge}=    Get Text    ${BADGE_CART_SELECTOR}
    Should Not Be Empty            ${text_badge}

    Click Element    ${SHOPPING_CART_SELECTOR}

    Verify Product in Cart    ${product_name}
    Sleep    10s

Verify Product in Cart via Product Detail
    [Arguments]    ${product_name}
    Page Should Contain Element    ${ADD_TO_CART_DETAIL_BUTTON_SELECTOR}
    ${button_text}=    Get Text    ${ADD_TO_CART_DETAIL_BUTTON_SELECTOR}
    Should Be Equal    ${button_text}    Add to cart
    
    Click Element    ${ADD_TO_CART_DETAIL_BUTTON_SELECTOR}
    Page Should Contain Element    ${REMOVE_DETAIL_BUTTON_SELECTOR}
    ${button_text_after}=    Get Text    ${REMOVE_DETAIL_BUTTON_SELECTOR}
    Should Be Equal    ${button_text_after}    Remove

    Page Should Contain Element    ${BADGE_CART_SELECTOR}
    ${text_badge}=    Get Text    ${BADGE_CART_SELECTOR}
    Should Not Be Empty            ${text_badge}
    
    Click Element    ${SHOPPING_CART_SELECTOR}

    Verify Product in Cart    ${product_name}

Verify Product in Cart
    [Arguments]    ${product_name}
    # Pastikan sudah di halaman cart
    Page Should Contain Element    ${CART_LIST_SELECTOR}
    ${CART_ITEM_NAMES}=    Get WebElements    ${CART_ITEM_NAME_SELECTOR}
    ${DESC_ELEMS}=    Get WebElements    ${CART_ITEM_DESC_SELECTOR}
    ${PRICE_ELEMS}=    Get WebElements    ${CART_ITEM_PRICE_SELECTOR}
    ${found}=    Set Variable    False
    ${TOTAL_PRODUCT_IN_CART}=    Get Length    ${CART_ITEM_NAMES}
    Log To Console   Total produk di cart: ${TOTAL_PRODUCT_IN_CART}
    FOR    ${i}    IN RANGE    ${TOTAL_PRODUCT_IN_CART}
        ${item_name}=    Get Text    ${CART_ITEM_NAMES}[${i}]
        IF    '${item_name}' == '${product_name}'
            Log To Console    Produk ${product_name} ditemukan di cart!
            ${desc_text}=    Get Text    ${DESC_ELEMS}[${i}]
            Should Not Be Empty    ${desc_text}    Deskripsi produk tidak ditemukan di cart!
            ${price_text}=    Get Text    ${PRICE_ELEMS}[${i}]
            Should Not Be Empty    ${price_text}    Harga produk tidak ditemukan di cart!
            Exit For Loop
        END
    END

    # Verifikasi button Continue Shopping
    Page Should Contain Element    ${CONTINUE_SHOPPING_BUTTON_SELECTOR}
    # Verifikasi button Remove
    Page Should Contain Element    ${CART_ITEM_REMOVE_BUTTON_SELECTOR}
    # Verifikasi button Checkout
    Page Should Contain Element    ${CHECKOUT_BUTTON_SELECTOR}
    # Verifikasi teks 'Your Cart'
    Page Should Contain    Your Cart

Verify Product deleted from Cart via Product List
    [Arguments]    ${product_name}
    ${NAME_PRODUCT}=    Get WebElements    ${NAME_SELECTOR}
    ${TOTAL_PRODUCT}=    Get Length    ${NAME_PRODUCT}
    FOR    ${i}    IN RANGE    ${TOTAL_PRODUCT}
        ${text_nama}=    Get Text    ${NAME_PRODUCT}[${i}]
        IF    '${text_nama}' == '${product_name}'
            Log To Console    Produk ${product_name} ditemukan di product list!
            Page Should Contain Element    ${ADD_TO_CART_BUTTON_SELECTOR}
            ${button_text}=    Get Text    ${ADD_TO_CART_BUTTON_SELECTOR}
            Should Be Equal    ${button_text}    Add to cart

            Click Element    ${ADD_TO_CART_BUTTON_SELECTOR}
            Page Should Contain Element    ${REMOVE_BUTTON_SELECTOR}
            ${button_text_after}=    Get Text    ${REMOVE_BUTTON_SELECTOR}
            Should Be Equal    ${button_text_after}    Remove

            Click Element    ${REMOVE_BUTTON_SELECTOR}
            Page Should Contain Element    ${ADD_TO_CART_BUTTON_SELECTOR}
            ${button_text_after_remove}=    Get Text    ${ADD_TO_CART_BUTTON_SELECTOR}
            Should Be Equal    ${button_text_after_remove}    Add to cart
            Exit For Loop
        END
    END

    Page Should Not Contain Element    ${BADGE_CART_SELECTOR}
    Click Element    ${SHOPPING_CART_SELECTOR}

    Verify Product not in Cart    ${product_name}

Verify Product not in Cart
    [Arguments]    ${product_name}
    # Pastikan sudah di halaman cart
    Page Should Contain Element    ${CART_LIST_SELECTOR}
    Page Should Not Contain Element    ${CART_ITEM_NAME_SELECTOR}
    Page Should Not Contain Element    ${CART_ITEM_DESC_SELECTOR}
    Page Should Not Contain Element    ${CART_ITEM_PRICE_SELECTOR}

    # Verifikasi button Continue Shopping
    Page Should Contain Element    ${CONTINUE_SHOPPING_BUTTON_SELECTOR}
    # Verifikasi button Remove
    Page Should Not Contain Element    ${CART_ITEM_REMOVE_BUTTON_SELECTOR}
    # Verifikasi button Checkout
    Page Should Contain Element    ${CHECKOUT_BUTTON_SELECTOR}
    # Verifikasi teks 'Your Cart'
    Page Should Contain    Your Cart

Verify Product deleted from Cart via Product Detail
    [Arguments]    ${product_name}
    Page Should Contain Element    ${ADD_TO_CART_DETAIL_BUTTON_SELECTOR}
    ${button_text}=    Get Text    ${ADD_TO_CART_DETAIL_BUTTON_SELECTOR}
    Should Be Equal    ${button_text}    Add to cart
    
    Click Element    ${ADD_TO_CART_DETAIL_BUTTON_SELECTOR}
    Page Should Contain Element    ${REMOVE_DETAIL_BUTTON_SELECTOR}
    ${button_text_after}=    Get Text    ${REMOVE_DETAIL_BUTTON_SELECTOR}
    Should Be Equal    ${button_text_after}    Remove

    Click Element    ${REMOVE_DETAIL_BUTTON_SELECTOR}
    Page Should Contain Element    ${ADD_TO_CART_DETAIL_BUTTON_SELECTOR}
    ${button_text_after_remove}=    Get Text    ${ADD_TO_CART_DETAIL_BUTTON_SELECTOR}
    Should Be Equal    ${button_text_after_remove}    Add to cart

    Page Should Not Contain Element    ${BADGE_CART_SELECTOR}
    Click Element    ${SHOPPING_CART_SELECTOR}

    Verify Product not in Cart    ${product_name}

Added Product To Cart via Product List
    [Arguments]    @{product_names}
    
    # # Ambil daftar produk dari halaman
    ${NAME_PRODUCT}=    Get WebElements    ${NAME_SELECTOR}
    ${ADD_TO_CART_BUTTON}=    Get WebElements    ${ADD_TO_CART_BUTTON_SELECTOR}
    ${TOTAL_PRODUCT}=    Get Length    ${NAME_PRODUCT}

    # Log To Console    Total produk yang ingin ditambahkan: @{product_names}
    # ${TOTAL_PRODUCT_NAME}=    Get Length    @{product_names}

    FOR    ${product_name}    IN    @{product_names}
        FOR    ${i}    IN RANGE    ${TOTAL_PRODUCT}
            ${text_nama}=    Get Text    ${NAME_PRODUCT}[${i}]
            IF    '${text_nama}' == '${product_name}'
                Log To Console    Produk ${product_name} ditemukan di product list!
                Page Should Contain Element    ${ADD_TO_CART_BUTTON}[${i}]
                ${button_text}=    Get Text    ${ADD_TO_CART_BUTTON}[${i}]
                Should Be Equal    ${button_text}    Add to cart

                Click Element    ${ADD_TO_CART_BUTTON}[${i}]
                Exit For Loop
            END
        END
    END

Verified Multiple Product in Cart
    [Arguments]    @{product_names}
    Page Should Contain Element    ${BADGE_CART_SELECTOR}
    ${text_badge}=    Get Text    ${BADGE_CART_SELECTOR}
    Should Not Be Empty            ${text_badge}

    Click Element    ${SHOPPING_CART_SELECTOR}

    # Pastikan sudah di halaman cart
    Page Should Contain Element    ${CART_LIST_SELECTOR}
    
    FOR    ${product_name}    IN    @{product_names}
        ${CART_ITEM_NAMES}=    Get WebElements    ${CART_ITEM_NAME_SELECTOR}
        ${DESC_ELEMS}=    Get WebElements    ${CART_ITEM_DESC_SELECTOR}
        ${PRICE_ELEMS}=    Get WebElements    ${CART_ITEM_PRICE_SELECTOR}
        ${found}=    Set Variable    False
        ${TOTAL_PRODUCT_IN_CART}=    Get Length    ${CART_ITEM_NAMES}
        Log To Console   Total produk di cart: ${TOTAL_PRODUCT_IN_CART}
        FOR    ${i}    IN RANGE    ${TOTAL_PRODUCT_IN_CART}
            ${item_name}=    Get Text    ${CART_ITEM_NAMES}[${i}]
            IF    '${item_name}' == '${product_name}'
                Log To Console    Produk ${product_name} ditemukan di cart!
                ${desc_text}=    Get Text    ${DESC_ELEMS}[${i}]
                Should Not Be Empty    ${desc_text}    Deskripsi produk tidak ditemukan di cart!
                ${price_text}=    Get Text    ${PRICE_ELEMS}[${i}]
                Should Not Be Empty    ${price_text}    Harga produk tidak ditemukan di cart!
                Exit For Loop
            END
        END
    END