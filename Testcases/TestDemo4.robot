*** Settings ***
Library    SeleniumLibrary
Documentation    verify error message
Test Teardown    Close Browser
Test Template    Verify the incorrect logins

*** Variables ***
${URL}    https://opensource-demo.orangehrmlive.com/

${eror_Message}=    css:.oxd-alert-content-text



*** Test Cases ***    username    password
invalid username     Admin1    admin123
Invalid passowrd     Admin    admin12
Special characters    @33    leaning

*** Keywords ***
Verify the incorrect logins
    Set Selenium Speed    2seconds
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
    Wait Until Element Is Visible    ${eror_Message}    10s

Verify The Error Message
    ${result}=    Get Text    ${eror_Message}
    Should Be Equal As Strings    ${result}    Invalid credentials

