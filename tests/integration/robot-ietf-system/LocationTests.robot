*** Settings ***
Library		    BuiltIn
Library         OperatingSystem
Library         SysrepoLibrary
Library         String
Library         RPA.JSON
Library         Utils.py
Variables       SystemVariables.py
Resource        SystemKeywords.resource
Resource        SystemInit.resource


*** Test Cases ***
Test Contact
    [Documentation]    Check system location data
    Edit Datastore Config By File    ${Connection Default}    ${Session Running}    data/system_location.xml   xml
    ${Location}=    Sysrepo Get Datastore Str    /ietf-system:system/location    xml
    Should Be Equal As Strings    ${Expected Location}    ${Location}   msg="location data is wrong"
    ${Plugin Dir}    ${Tail}=    Split Path    %{SYSREPO_GENERAL_PLUGIN_PATH}
    ${Location Path}=     Join Path    ${Plugin Dir}    location_info
    Log To Console    ${Location Path}
    File Should Exist    ${Location Path}
    ${Real Location}=    Get File    ${Location Path}
    Should Not Be Empty    ${Real Location}    msg="location_info is empty"
    Should Be Equal As Strings    ${Real Location.strip()}    test_location    msg="location on system doesn't match set location"
