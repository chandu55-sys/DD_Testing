*** Settings ***
Library    SeleniumLibrary
DataDriver    ../TestData/Data.csv
Test Template    Verify the incorrect logins
Test Teardown    Close Browser

*** Variables ***
${URL}    https://opensource-demo.orangehrmlive.com/
${error_Message}    css:.oxd-alert-content-text

*** Test Cases ***
Login Test

*** Keywords ***
Verify the incorrect logins
    [Arguments]    ${username}    ${password}
    Open Browser To Login Page
    Login Details    ${username}    ${password}
    Wait Until Error Message Is Visible
    Verify The Error Message

Open Browser To Login Page
    Open Browser    ${URL}    chrome
    Maximize Browser Window
    Wait Until Element Is Visible    name=username    10s

Login Details
    [Arguments]    ${username}    ${password}
    Input Text    name=username   ${username}
    Input Text    name=password   ${password}
    Click Button    xpath=//button[@type='submit']

Wait Until Error Message Is Visible
    Wait Until Element Is Visible    ${error_Message}    10s

Verify The Error Message
    ${result}=    Get Text    ${error_Message}
    Should Be Equal As Strings    ${result}    Invalid credentials
