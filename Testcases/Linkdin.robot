*** Settings ***
Library    SeleniumLibrary
Library    Collections
Library    OperatingSystem
Library    ../Libraries/csv_utilities.py

Suite Setup       Open Browser And Login
Suite Teardown    Close Browser

*** Variables ***
${LOGIN_URL}      https://www.linkedin.com/login
${POST_URL}       https://shorturl.at/6SZ46
${BROWSER}        Chrome

${USERNAME}       chanduyandra1430@gmail.com
${PASSWORD}       C8L2B@Siri

${CSV_INPUT}      C:/Users/AIFA USER 77/PycharmProjects/DDTTESTING/TestData/Input_names.csv
${CSV_OUTPUT}     C:/Users/AIFA USER 77/Desktop/latest.csv

*** Test Cases ***
End To End Like Comment Validation
    ${input_names}=    Read Names    ${CSV_INPUT}

    ${likes}=          Get Like Names
    ${comments}=       Get Comment Names

    ${results}=        Create List

    FOR    ${name}    IN    @{input_names}
        ${liked}=       Run Keyword And Return Status    List Should Contain Value    ${likes}    ${name}
        ${commented}=   Run Keyword And Return Status    List Should Contain Value    ${comments}    ${name}

        ${row}=    Create Dictionary
        ...    Name=${name}
        ...    Liked=${'YES' if ${liked} else 'NO'}
        ...    Commented=${'YES' if ${commented} else 'NO'}

        Append To List    ${results}    ${row}
    END

    Save Results    ${results}    ${CSV_OUTPUT}
    Log To Console    ✅ Output CSV generated successfully

*** Keywords ***
Open Browser And Login
    Open Browser    ${LOGIN_URL}    ${BROWSER}
    Maximize Browser Window
    Wait Until Element Is Visible    id=username    20s
    Input Text       id=username    ${USERNAME}
    Input Password   id=password    ${PASSWORD}
    Click Button     xpath=//button[normalize-space()='Sign in']
    Sleep    6s
    Go To    ${POST_URL}
    Sleep    6s

Get Like Names
    ${names}=    Create List

    Click Element    xpath=//*[@class='social-details-social-counts__social-proof-text']
    Sleep    4s

    WHILE    True
        ${elements}=    Get WebElements    xpath=//div[contains(@class,'artdeco-entity-lockup__title')]
        FOR    ${el}    IN    @{elements}
            ${text}=    Get Text    ${el}
            ${text}=    Convert To Lower Case    ${text}
            Run Keyword If    '${text}' and '${text}' not in ${names}    Append To List    ${names}    ${text}
        END

        ${more}=    Run Keyword And Return Status
        ...    Page Should Contain Element    xpath=//span[text()='Show more results']

        IF    ${more}
            Click Element    xpath=//span[text()='Show more results']
            Sleep    2s
        ELSE
            Exit For Loop
        END
    END

    Click Element    xpath=//button[@aria-label='Dismiss']
    RETURN    ${names}

Get Comment Names
    ${names}=    Create List

    Execute Javascript    window.scrollTo(0, document.body.scrollHeight)
    Sleep    3s

    WHILE    True
        ${load_more}=    Run Keyword And Return Status
        ...    Page Should Contain Element
        ...    xpath=//button[.//span[contains(text(),'Load more comments')]]

        IF    ${load_more}
            Click Element    xpath=//button[.//span[contains(text(),'Load more comments')]]
            Sleep    2s
        ELSE
            Exit For Loop
        END
    END

    ${elements}=    Get WebElements
    ...    xpath=//span[contains(@class,'comments-comment-meta__description-title')]

    FOR    ${el}    IN    @{elements}
        ${text}=    Get Text    ${el}
        ${text}=    Convert To Lower Case    ${text}
        Run Keyword If    '${text}' and '${text}' not in ${names}    Append To List    ${names}    ${text}
    END

    RETURN    ${names}
