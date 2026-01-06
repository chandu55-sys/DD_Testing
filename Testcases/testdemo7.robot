*** Settings ***
Library    Collections
Library    RequestsLibrary
Library    SeleniumLibrary

*** Variables ***
${baseurl}    https://webservice.toscacloud.com
${headers}    None

*** Test Cases ***
Post Test case
    ${headers}=    Create Dictionary    accept=text/plain    Content-Type=application/json
    Create Session    mysession    ${baseurl}   # headers=${headers}
    ${req}=    Create Dictionary    description=viajy like coffe    id=1    name=cappuccino
    ${response}=    POST Request    mysession    /api/v1/Coffees    json=${req}    headers=${headers}
    Log    ${response.status_code}
    Log    ${response.text}
    Log    ${response.json()}
    Dictionary Should Contain Key    ${response.json()}    id
    ${id}=    Get From Dictionary    ${response.json()}    id
    Set Suite Variable    ${id}        # <-- makes ${id} available to other tests
    Should Be Equal As Strings    viajy like coffe    ${response.json()}[description]
    Status Should Be    200    ${response}

Get Test Case
    ${headers}=    Create Dictionary    accept=text/plain    Content-Type=application/json
    ${response_get}=    GET    ${baseurl}/api/v1/Coffees    params=id=${id}    headers=${headers}
    Log    ${response_get.json()}
    Status Should Be    200    ${response_get}
    Log To Console    GET test case passed

Delete Test case
    ${headers}=    Create Dictionary    accept=text/plain    Content-Type=application/json
    ${delete_response}=    DELETE    ${baseurl}/api/v1/Coffees    params=id=${id}    headers=${headers}
    Status Should Be    200    ${delete_response}
    Log To Console    Delete test case passed
