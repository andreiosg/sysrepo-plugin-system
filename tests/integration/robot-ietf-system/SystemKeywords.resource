*** Settings ***
Library     SysrepoLibrary
Library     BuiltIn
Library     OperatingSystem

*** Keywords ***
Sysrepo Get Datastore Str
    [Arguments]    ${Path}    ${Format}
    ${Data}=    Get Datastore Data
    ...    ${Connection Default}
    ...    ${Session Running}
    ...    ${Path}
    ...    ${Format}
    [Return]    ${Data}
