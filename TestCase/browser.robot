*** Settings ***
Documentation     Common Keywords.
Library           SeleniumLibrary
Library           RequestsLibrary
Library           JSONLibrary
Library           Collections

*** Variables ***
${BROWSER}  chrome
${URL}    https://landy510.github.io/Display_Vue_porfolio/#/lecture/LectureProduct
${GET_ENDPOINTURL}    https://vue-course-api.hexschool.io/api/mrchenrandy/products/all
${SEARCH_ELEMENT}    //input[contains(@placeholder, 'Search')]
*** Test Cases ***
Open Browser
    Open Browser  ${URL}    ${BROWSER}
    Maximize Browser Window
    Wait Until Page Contains Element    ${SEARCH_ELEMENT}
Proceed GET Method
    ${header}=  create dictionary  user-agent=Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/102.0.5005.63 Safari/537.36
    ${resp}=    GET    ${GET_ENDPOINTURL}    headers=${header}
    ${product_title_arr}=    Get Value From Json    ${resp.json()}[products]    $..title
    @{product_title_list}=    Convert To List    ${product_title_arr}
    Set Suite Variable    @{PRODUCT_TITLE_LIST}    @{product_title_list}
Iterate List and Check If Every Element Show On Page
    FOR    ${item}    IN    @{PRODUCT_TITLE_LIST}
        Input Text    ${SEARCH_ELEMENT}    ${item}
        Press Keys    ${SEARCH_ELEMENT}    ENTER
        Wait Until Page Contains Element    //span[contains(text(), '${item}')] 
    END 
Close Brower
    Close Browser    
