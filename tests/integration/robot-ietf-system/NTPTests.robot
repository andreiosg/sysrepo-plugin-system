*** Settings ***
Library		    BuiltIn
Library         SysrepoLibrary
Library         RPA.JSON
Library         Utils.py
Library         String
Variables       SystemVariables.py
Resource        SystemKeywords.resource
Resource        SystemInit.resource


*** Test Cases ***
Test NTP Enabled
    [Documentation]    Check NTP enabled/disabled datastore data and system status
    Edit Datastore Config By File    ${Connection Default}    ${Session Running}    data/system_ntp_disabled.xml   xml
    ${NTP}=    Sysrepo Get Datastore Str    /ietf-system:system/ntp/enabled    xml
    Should Be Equal As Strings    ${Expected NTP Disabled}    ${NTP}
    ${NTP Status}=    Get NTP Status
    Should Be Equal As Strings    ${NTP Status}    inactive    msg="ntp service is running"
    Edit Datastore Config By File    ${Connection Default}    ${Session Running}    data/system_ntp_enabled.xml   xml
    ${NTP}=    Sysrepo Get Datastore Str    /ietf-system:system/ntp/enabled    xml
    Should Be Equal As Strings    ${Expected NTP Enabled}    ${NTP}
    ${NTP Status}=    Get NTP Status
    Should Be Equal As Strings    ${NTP Status}    active    msg="ntp service isn't running"

Test NTP Server
    [Documentation]    Check NTP server datastore addition and system status
    ${NTP Server Init}=    Sysrepo Get Datastore Str    /ietf-system:system/ntp/server    xml
    ${Expected NTP Server}=    Replace String   
    ...    ${NTP Server Init}
    ...    </ntp></system>
    ...    <server><name>hr.pool.ntp.org</name><udp><address>162.159.200.123</address></udp></server></ntp></system>
    Edit Datastore Config By File    ${Connection Default}    ${Session Running}    data/system_ntp_server_initial.xml   xml
    ${NTP Server}=    Sysrepo Get Datastore Str    /ietf-system:system/ntp/server    xml
    Should Be Equal As Strings    ${Expected NTP Server}    ${NTP Server}    msg="ntp datastore data is wrong"
    ${NTP Status}=    Get NTP Status
    Should Be Equal As Strings    ${NTP Status}    active    msg="ntp service isn't running"

