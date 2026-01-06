*** Settings ***
Library    BuiltIn
Library     SeleniumLibrary
*** Variables ***
@{FRUITS}    1    2    3    4    5    6

*** Test Cases ***
Loop Through List
    FOR    ${i}    IN    1    2    3    4    5    6    8
        Log To Console    ${i}
        EXIT FOR LOOP IF    ${i} == 4
    END


Loop Through Fruits Variable
    FOR    ${i}    IN    @{FRUITS}
        Log To Console    ${i}
        EXIT FOR LOOP IF    ${i} == 4
    END
