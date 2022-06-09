
def getVariables():
    # Variables get imported into robot from the dict as Key = Value pairs
    variables = {
            "Expected Contact": '<system xmlns="urn:ietf:params:xml:ns:yang:ietf-system"><contact>test_contact</contact></system>',
            "Expected Hostname": '<system xmlns="urn:ietf:params:xml:ns:yang:ietf-system"><hostname>test_hostname</hostname></system>',
            "Expected Location": '<system xmlns="urn:ietf:params:xml:ns:yang:ietf-system"><location>test_location</location></system>',
            "Expected NTP Enabled": '<system xmlns="urn:ietf:params:xml:ns:yang:ietf-system"><ntp><enabled>true</enabled></ntp></system>',
            "Expected NTP Disabled": '<system xmlns="urn:ietf:params:xml:ns:yang:ietf-system"><ntp><enabled>false</enabled></ntp></system>',
    }

    return variables
