from robot.api.deco import keyword
from robot.api import FatalError
from pwd import getpwuid
from os import uname
from subprocess import run


ROBOT_AUTO_KEYWORDS = False


@keyword('Get Password Database Entry')
def get_password_database_entry(uid: int):
    return getpwuid(uid)


@keyword('Get OS Hostname')
def get_os_hostname():
    return uname()[1]


@keyword('Get NTP Status')
def get_ntp_status():
    p = run(['systemctl', 'show', 'ntp'],
            capture_output=True, encoding="ascii")
    bkey, key, akey = p.stdout.partition('ActiveState=')
    if not key and not akey:
        raise FatalError(
            'failed to find ActiveStatus keyword in systemctl show npt output')
    return akey.split()[0]

@keyword('Get NTP Server IPs')
def get_ntp_server_ips():
    with open('/etc/ntp.conf', 'r') as f:
        return [l.split()[1].split(":", 1)[0] for l in f if 'server' in l and l[0] != '#']
