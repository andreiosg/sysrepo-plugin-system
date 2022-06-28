*** Settings ***
Library		BuiltIn
Library         SysrepoLibrary
Library         RPA.JSON
Library         OperatingSystem
Library         String
Library         Utils.py
Variables       SystemVariables.py
Resource        SystemKeywords.resource
Resource        SystemInit.resource


*** Test Cases ***
Test Authentication Import
    [Documentation]    Check contact info
    Edit Datastore Config By File    ${Connection Default}    ${Session Running}    data/system_local_user_initial.xml   xml
    ${Authentication}=    Sysrepo Get Datastore Str    /ietf-system:system/authentication/user[name='test_user']    xml
    Should Be Equal As Strings    ${Expected Authentication}    ${Authentication}   msg="authentication data is wrong"
    ${User}=   Get Password Database Name    test_user 
    Should Be Equal As Strings    "${User.pw_name}"    "test_user"    msg="username in /etc/passwd is wrong"
    Should Be Equal As Strings    "${User.pw_dir}"    "/home/test_user"    msg="homedir in /etc/passwd is wrong"
    Should Be Equal As Integers    ${User.pw_uid}    1001    msg="uid in /etc/passwd is wrong"
    Should Be Equal As Integers    ${User.pw_gid}    1001    msg="gid in /etc/passwd is wrong"
    Should Be Equal As Strings    "${User.pw_shell}"    "/bin/bash"    msg="shell in /etc/passwd is wrong"
    ${Shadow}=   Get Shadow Password Database Name    test_user 
    Should Be Equal As Strings    "${Shadow.sp_namp}"    "test_user"    msg="username in /etc/passwd is wrong"
    Should Be Equal As Strings    "${Shadow.sp_pwdp}"    "$6$S05zV2Np5LQzaOpM$qqUxvFsEVg7iwaqnEHhF4ZJv8dwXdtgFpLTHyr78Rr8cz/ml2riPyBlPol.3V8qVXFohR0XSTJXMHO4XLjrXd1"    msg="passwod in /etc/passwd is wrong"
    Directory Should Exist    /home/test_user    msg="/home/test_user doesn't exist"
    Directory Should Exist    /home/test_user/.ssh    msg="/home/test_user/.ssh doesn't exist"
    File Should Exist    /home/test_user/.ssh/test_rsa.pub    msg="/home/test_user/.ssh/test_rsa.pub doesn't exist"
    ${Test RSA}=    Get File    /home/test_user/.ssh/test_rsa.pub
    @{Test RSA}=    Split To Lines    ${Test RSA}
    Should Be Equal As Strings    "${Test RSA}[0]"    "ssh-rsa"    msg="key algorithm differs"
    Should Be Equal As Strings    "${Test RSA}[1]"    "AAAAB3NzaC1yc2EAAAADAQABAAABAQCiIf32L0B77f//ldk1QpUyfaJQUgI4mXSPtkmaokxUUlj8j9pxlwpFDSmsrZn2H0DJhZZ3ktAGsbFJabZJhV73l7HhQggC/6uzrNPSe+R3lOMGYIAhHaWbGSnT/uvpPMBVA/nWulDkBphiXv606WQHDxqGkngF1kzvvpd5FPpc/jy2vv+66HaP6XA9MgzHLYTOTb3ct3dVoz7HDAQ8tC5l3/3YYLyMhc3LxOBQLZ9PklWvQeSyO6neKi3Au0T13SpUGjtuqKpiCvE/X0ZuFtZSZzPo5UDASD65Er8jOqqYDcfHR1hsfJJjJA/nP+VKoGeBzUBxhxNetqswnEcPDEBv"    msg="key data differs"
