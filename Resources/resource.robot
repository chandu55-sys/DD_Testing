*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}    https://opensource-demo.orangehrmlive.com/

*** Keywords ***
Open Browser To Login Page
    Open Browser    ${URL}    chrome
    Maximize Browser Window
    Wait Until Element Is Visible    name=username    10s

Input Username
    [Arguments]    ${username}
    Input Text    name=username    ${username}

Input Password
    [Arguments]    ${password}
    Input Text    name=password    ${password}

Click Login Button
    Click Button    xpath=//button[@type='submit']
