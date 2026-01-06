*** Settings ***
Library    SeleniumLibrary
Resource   ../Resources/resource.robot    # <-- your resource file
Test Setup    Open Browser To Login Page
Test Teardown    Close Browser

*** Variables ***
${VALID_USER}        Admin
${VALID_PASSWORD}    admin123
${INVALID_USER}      WrongUser
${INVALID_PASSWORD}  wrongpass

*** Test Cases ***
Valid Login Test
    [Documentation]    Verify login with correct username and password.
    Input Username    ${VALID_USER}
    Input Password    ${VALID_PASSWORD}
    Click Login Button
    Wait Until Element Is Visible    xpath=//h6[text()='Dashboard']    10s
    Page Should Contain Element      xpath=//h6[text()='Dashboard']

Invalid Login Test
    [Documentation]    Verify login fails with wrong credentials.
    Input Username    ${INVALID_USER}
    Input Password    ${INVALID_PASSWORD}
    Click Login Button
    Wait Until Element Is Visible    xpath=//p[contains(@class,'oxd-alert-content-text')]    10s
    Element Should Contain           xpath=//p[contains(@class,'oxd-alert-content-text')]    Invalid credentials
