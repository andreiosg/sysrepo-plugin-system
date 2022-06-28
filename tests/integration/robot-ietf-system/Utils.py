from robot.api.deco import keyword
from robot.api import FatalError
from pwd import getpwuid, getpwnam
from spwd import getspnam
from os import uname, readlink, symlink
from subprocess import run


ROBOT_AUTO_KEYWORDS = False


@keyword('Get Password Database Entry')
def get_password_database_entry(uid: int):
    return getpwuid(uid)

@keyword('Get Password Database Name')
def get_password_database_name(user: str):
    return getpwnam(user)

@keyword('Get Shadow Password Database Name')
def get_shadow_password_database_name(user: str):
    return getspnam(user)

@keyword('Get OS Hostname')
def get_os_hostname():
    return uname()[1]

@keyword('Resolve Symbolic Link')
def resolve_symbolic_link(path: str):
    return readlink(path)

@keyword('Create Symbolic Link')
def create_symbolic_link(src: str, dst: str):
    return symlink(src, dst)

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
