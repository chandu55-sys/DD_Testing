*** Settings ***
Library    SeleniumLibrary
Documentation    verify error message
Test Teardown    Close Browser

*** Variables ***
${URL}    https://opensource-demo.orangehrmlive.com/

${eror_Message}=    css:.oxd-alert-content-text


*** Test Cases ***
Verify the incorrect logins
    Open Browser To Login Page
    Login Details
    Wait Until Error Message Is Visible
    Verify The Error Message

*** Keywords ***
Open Browser To Login Page
    Open Browser    ${URL}    chrome
    Maximize Browser Window
    Wait Until Element Is Visible    name=username    10s

Login Details
    Input Text    name=username   Admin
    Input Text    name=password   admin1231
    Click Button    xpath=//button[@type='submit']

Wait Until Error Message Is Visible
    Wait Until Element Is Visible    ${eror_Message}    10s

Verify The Error Message
    ${result}=    Get Text    ${eror_Message}
    Should Be Equal As Strings    ${result}    Invalid credentials
    Element Should Be Visible     ${result}
