*** Settings ***
Library		    BuiltIn
Library         SysrepoLibrary
Library         RPA.JSON
Library         Utils.py
Variables       SystemVariables.py
Resource        SystemKeywords.resource
Resource        SystemInit.resource


*** Test Cases ***
Test Hostname
    [Documentation]    Check hostname data
    Edit Datastore Config By File    ${Connection Default}    ${Session Running}    data/system_hostname.xml   xml
    ${Hostname}=    Sysrepo Get Datastore Str    /ietf-system:system/hostname    xml
    Should Be Equal As Strings    ${Expected Hostname}    ${Hostname}   msg="hostname data is wrong"
    ${Real Hostname}=    Get OS Hostname
    Should Be Equal As Strings    "${Real Hostname}"   "test_hostname"    msg="hostname on system doesn't match set hostname"

