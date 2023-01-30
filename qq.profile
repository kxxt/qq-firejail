# Firejail profile for qq
# Description: Firejail profile for qq nt

##quiet
# Persistent local customizations
include linuxqq.local
# Persistent global definitions
include globals.local

##ignore noexec ${HOME}
##ignore noexec /tmp

# It is common practice to add files/dirs containing program-specific configuration
# (often ${HOME}/PROGRAMNAME or ${HOME}/.config/PROGRAMNAME) into disable-programs.inc
# (keep list sorted) and then disable blacklisting below.
# One way to retrieve the files a program uses is:
#  - launch binary with --private naming a sandbox
#      `firejail --name=test --ignore=private-bin [--profile=PROFILE] --private BINARY`
#  - work with the program, make some configuration changes and save them, open new documents,
#    install plugins if they exists, etc.
#  - join the sandbox with bash:
#      `firejail --join=test bash`
#  - look what has changed and use that information to populate blacklist and whitelist sections
#      `ls -aR`
#blacklist ${HOME}/
# Allow /bin/sh (blacklisted by disable-shell.inc)
#include allow-bin-sh.inc

# Allows files commonly used by IDEs
#include allow-common-devel.inc

# Allow gjs (blacklisted by disable-interpreters.inc)
#include allow-gjs.inc

# Allow java (blacklisted by disable-devel.inc)
#include allow-java.inc

# Allow lua (blacklisted by disable-interpreters.inc)
#include allow-lua.inc

# Allow perl (blacklisted by disable-interpreters.inc)
#include allow-perl.inc

# Allow python (blacklisted by disable-interpreters.inc)
#include allow-python2.inc
#include allow-python3.inc

# Allow ruby (blacklisted by disable-interpreters.inc)
#include allow-ruby.inc

# Allow ssh (blacklisted by disable-common.inc)
#include allow-ssh.inc

##blacklist PATH
# Disable Wayland
#blacklist ${RUNUSER}/wayland-*
# Disable RUNUSER (cli only; supersedes Disable Wayland)
#blacklist ${RUNUSER}
# Remove the next blacklist if your system has no /usr/libexec dir,
# otherwise try to add it.
#blacklist /usr/libexec

# disable-*.inc includes
# remove disable-write-mnt.inc if you set disable-mnt
include disable-common.inc
include disable-devel.inc
#include disable-exec.inc
include disable-interpreters.inc
#include disable-proc.inc
include disable-programs.inc
#include disable-shell.inc
include disable-write-mnt.inc
#include disable-X11.inc
#include disable-xdg.inc

# This section often mirrors noblacklist section above. The idea is
# that if a user feels too restricted (e.g. unable to save files into
# home directory) they may disable whitelist (nowhitelist)
# in PROFILE.local but still be protected by BLACKLISTS section
# (explanation at https://github.com/netblue30/firejail/issues/1569)
#mkdir PATH
##mkfile PATH
#whitelist PATH
#include whitelist-common.inc
#include whitelist-run-common.inc
#include whitelist-runuser-common.inc
#include whitelist-usr-share-common.inc
#include whitelist-var-common.inc

##allusers
#apparmor
caps.drop all
ignore apparmor
nonewprivs
noprinters
noroot
notv
nou2f
protocol unix,inet,inet6,netlink
seccomp !chroot

disable-mnt

private-opt QQ
private-tmp
private-etc alsa,alternatives,ca-certificates,crypto-policies,fonts,group,host.conf,hostname,hosts,ld.so.cache,ld.so.preload,localtime,login.defs,machine-id,nsswitch.conf,os-release,passwd,pki,pulse,resolv.conf,ssl,xdg


noblacklist ${HOME}/.config/QQ
mkdir ${HOME}/.config/QQ
whitelist ${HOME}/.config/QQ

whitelist ${HOME}/Pictures
whitelist ${HOME}/Downloads

whitelist ${HOME}/.config/pulse

whitelist ${HOME}/.config/fontconfig
read-only  ${HOME}/.config/fontconfig

whitelist ${HOME}/.fonts.conf.d
read-only ${HOME}/.fonts.conf.d

whitelist ${HOME}/.fonts.conf
read-only ${HOME}/.fonts.conf

whitelist ${HOME}/.cache/fontconfig

whitelist ${HOME}/.local/share/fonts
read-only ${HOME}/.local/share/fonts

whitelist ${HOME}/.fonts
read-only ${HOME}/.fonts

whitelist ${HOME}/.config/QX

dbus-user filter
dbus-user.talk org.freedesktop.Notifications
dbus-user.talk org.freedesktop.portal.Desktop
dbus-user.talk org.freedesktop.portal.Fcitx
dbus-user.talk org.freedesktop.portal.IBus
dbus-user.talk org.freedesktop.ScreenSaver
dbus-user.talk org.gnome.Mutter.IdleMonitor
?ALLOW_TRAY: dbus-user.talk org.kde.StatusNotifierWatcher
dbus-user.talk org.mozilla.*
ignore dbus-user none


##deterministic-shutdown
##env VAR=VALUE
##join-or-start NAME
#memory-deny-write-execute
##noexec PATH
##read-only ${HOME}
##read-write ${HOME}



include electron.profile