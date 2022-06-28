
def getVariables():
    # Variables get imported into robot from the dict as Key = Value pairs
    variables = {
            "Expected Contact": '<system xmlns="urn:ietf:params:xml:ns:yang:ietf-system"><contact>test_contact</contact></system>',
            "Expected Hostname": '<system xmlns="urn:ietf:params:xml:ns:yang:ietf-system"><hostname>test_hostname</hostname></system>',
            "Expected Location": '<system xmlns="urn:ietf:params:xml:ns:yang:ietf-system"><location>test_location</location></system>',
            "Expected NTP Enabled": '<system xmlns="urn:ietf:params:xml:ns:yang:ietf-system"><ntp><enabled>true</enabled></ntp></system>',
            "Expected NTP Disabled": '<system xmlns="urn:ietf:params:xml:ns:yang:ietf-system"><ntp><enabled>false</enabled></ntp></system>',
            "Expected Authentication": '<system xmlns="urn:ietf:params:xml:ns:yang:ietf-system"><authentication><user><name>test_user</name>'
                                       '<password>$6$S05zV2Np5LQzaOpM$qqUxvFsEVg7iwaqnEHhF4ZJv8dwXdtgFpLTHyr78Rr8cz/ml2riPyBlPol.3V8qVXFohR0XSTJXMHO4XLjrXd1</password>'
                                       '<authorized-key><name>test_rsa.pub</name><algorithm>ssh-rsa</algorithm><key-data>AAAAB3NzaC1yc2EAAAADAQABAAABAQCiIf32L0B77f//ldk1QpUyfaJQUgI4mXSPtkmaokxUUlj8j9pxlwpFDSmsrZn2H0DJhZZ3ktAGsbFJabZJhV73l7HhQggC/6uzrNPSe+R3lOMGYIAhHaWbGSnT/uvpPMBVA/nWulDkBphiXv606WQHDxqGkngF1kzvvpd5FPpc/jy2vv+66HaP6XA9MgzHLYTOTb3ct3dVoz7HDAQ8tC5l3/3YYLyMhc3LxOBQLZ9PklWvQeSyO6neKi3Au0T13SpUGjtuqKpiCvE/X0ZuFtZSZzPo5UDASD65Er8jOqqYDcfHR1hsfJJjJA/nP+VKoGeBzUBxhxNetqswnEcPDEBv</key-data></authorized-key></user></authentication></system>',
            "Expected Timezone Name": '<system xmlns="urn:ietf:params:xml:ns:yang:ietf-system"><clock><timezone-name>Europe/Stockholm</timezone-name></clock></system>',
    }

    return variables
