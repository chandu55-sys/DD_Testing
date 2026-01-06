*** Settings ***
Resource    ../Resources/resource.robot
Library     SeleniumLibrary
Library     DataDriver    C:/Users/AIFA USER 77/PycharmProjects/DDTTESTING/TestData/Lo.xlsx  sheet_name=LoginData



Suite Setup    Open Browser To Login Page
Suite Teardown    Close All Browsers
Test Template    LoginTest

*** Test Cases ***
Login Test With Excel Data  ${username}    ${password}

*** Keywords ***
LoginTest
    [Arguments]    ${username}    ${password}
    Input username    ${username}
    Input password    ${password}
    Click login Button
