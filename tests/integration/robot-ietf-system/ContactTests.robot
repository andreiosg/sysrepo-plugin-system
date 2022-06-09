*** Settings ***
Library		    BuiltIn
Library         SysrepoLibrary
Library         RPA.JSON
Library         Utils.py
Variables       SystemVariables.py
Resource        SystemKeywords.resource
Resource        SystemInit.resource


*** Test Cases ***
Test Contact
    [Documentation]    Check contact info
    Edit Datastore Config By File    ${Connection Default}    ${Session Running}    data/system_contact.xml   xml
    ${Contact}=    Sysrepo Get Datastore Str    /ietf-system:system/contact    xml
    Should Be Equal As Strings    ${Expected Contact}    ${Contact}   msg="contact data is wrong"
    ${Passwd}=    Utils.Get Password Database Entry    0
    Should Be Equal As Strings    "${Passwd.pw_name}"    "root"    msg="uid 0 is not named root"
    Should Be Equal As Strings    "${Passwd.pw_gecos}"   "test_contact"    msg="unexpected contact info in /etc/passwd"
    ${NTP Status}=    Get NTP Status
