*** Settings ***
Library		BuiltIn
Library         SysrepoLibrary
Library         RPA.JSON
Library         Utils.py
Variables       SystemVariables.py
Resource        SystemKeywords.resource
Resource        SystemInit.resource


*** Test Cases ***
Test Timezone
    [Documentation]    Check if set timezone matches the expected timezone
    ${Timezone Data}=    Set Variable    /etc/localtime
    ${Store Timezone}=    Utils.Resolve Symbolic Link    ${Timezone Data}
    Edit Datastore Config By File    ${Connection Default}    ${Session Running}    data/system_set_timezone_name.xml    xml 
    ${Timezone Name}=    Sysrepo Get Datastore Str    /ietf-system:system/clock/timezone-name    xml
    Should Be Equal As Strings    ${Expected Timezone Name}    ${Timezone Name}    msg="timezone name data is wrong"
    ${Real Timezone}=    Utils.Resolve Symbolic Link    ${Timezone Data}
    Should Be Equal As Strings    ${Real Timezone}    /usr/share/zoneinfo/Europe/Stockholm    msg="timezone on system doesn't match set timezone"
