*** Settings ***
Library		    BuiltIn
Library         SysrepoLibrary
Library         RPA.JSON
Library         Utils.py
Variables       SystemVariables.py
Resource        SystemKeywords.resource
Resource        SystemInit.resource


*** Test Cases ***
Test Platform
    [Documentation]    Check OS name, release, version
    ${Plugin Str}=    Sysrepo Get Datastore Str     /ietf-system:system-state/platform    json
    Log To Console    ${Plugin Str}
    &{Plugin JSON}=    Convert String To Json    ${Plugin Str}
    Log To Console     ${Plugin JSON}
