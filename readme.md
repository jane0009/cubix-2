# fuck you, baltimore

this is a rewrite of [luna's](https://github.com/lun-4) (private repo) computercraft linux thing
hopefully it'll be better maybe

## installation
theres gonna be a pastebin or something idk

## goals

* unix-like
* abstractions for syscalls
  * support for both computercraft and opencomputers

## fs layout

### /bin

all-user commands, required before fs mount and in single user mode
no subdirs

taken from [linux refspec](http://refspecs.linuxbase.org/FHS_3.0/fhs/ch03s04.html)

* cat  Utility to concatenate files to standard output
* chgrp Utility to change file group ownership
* chmod Utility to change file access permissions
* chown Utility to change file owner and group
* cp  Utility to copy files and directories
* date  Utility to print or set the system data and time
* dd  Utility to convert and copy a file
* df  Utility to report filesystem disk space usage
* dmesg Utility to print or control the kernel message buffer
* echo  Utility to display a line of text
* false Utility to do nothing, unsuccessfully
* hostname  Utility to show or set the system's host name
* kill  Utility to send signals to processes
* ln  Utility to make links between files
* login Utility to begin a session on the system
* ls  Utility to list directory contents
* mkdir Utility to make directories
* mknod Utility to make block or character special files
* more  Utility to page through text
* mount Utility to mount a filesystem
* mv  Utility to move/rename files
* ps  Utility to report process status
* pwd Utility to print name of current working directory
* rm  Utility to remove files or directories
* rmdir Utility to remove empty directories
* sed The 'sed' stream editor
* sh  POSIX compatible command shell
* stty  Utility to change and print terminal line settings
* su  Utility to change user ID
* sync  Utility to flush filesystem buffers
* true  Utility to do nothing, successfully
* umount  Utility to unmount file systems
* uname Utility to print system information`

### /boot

kernel. main entry point

### /dev

mapped devices (peripherals, opencomputer drives)
system abstractions e.g. /dev/null /dev/random

`
If it is possible that devices in /dev will need to be manually created, /dev must contain a command named MAKEDEV, which can create devices as needed. It may also contain a MAKEDEV.local for any local devices.

If required, MAKEDEV must have provisions for creating any device that may be found on the system, not just those that a particular distribution installs.` 

[refspec](http://refspecs.linuxbase.org/FHS_3.0/fhs/ch03s06.html)

### /etc

host config
[Configuration files for boot loaders that are not required at boot time must be placed in /etc.](http://refspecs.linuxbase.org/FHS_3.0/fhs/ch03s05.html)

include: x11? xml? sgml?

* csh.login  Systemwide initialization file for C shell logins (optional)
* exports  NFS filesystem access control list (optional)
* fstab  Static information about filesystems (optional)
* ftpusers  FTP daemon user access control list (optional)
* gateways  File which lists gateways for routed (optional)
* gettydefs  Speed and terminal settings used by getty (optional)
* group  User group file (optional)
* host.conf  Resolver configuration file (optional)
* hosts  Static information about host names (optional)
* hosts.allow  Host access file for TCP wrappers (optional)
* hosts.deny  Host access file for TCP wrappers (optional)
* hosts.equiv  List of trusted hosts for rlogin, rsh, rcp (optional)
* hosts.lpd  List of trusted hosts for lpd (optional)
* inetd.conf  Configuration file for inetd (optional)
* inittab  Configuration file for init (optional)
* issue  Pre-login message and identification file (optional)
* ld.so.conf  List of extra directories to search for shared libraries (optional)
* motd  Post-login message of the day file (optional)
* mtab  Dynamic information about filesystems (optional)
* mtools.conf  Configuration file for mtools (optional)
* networks  Static information about network names (optional)
* passwd  The password file (optional)
* printcap  The lpd printer capability database (optional)
* profile  Systemwide initialization file for sh shell logins (optional)
* protocols  IP protocol listing (optional)
* resolv.conf  Resolver configuration file (optional)
* rpc  RPC protocol listing (optional)
* securetty  TTY access control for root login (optional)
* services  Port names for network services (optional)
* shells  Pathnames of valid login shells (optional)
* syslog.conf  Configuration file for syslogd (optional)
mtab does not fit the static nature of /etc: it is excepted for historical reasons.

[refspec](http://refspecs.linuxbase.org/FHS_3.0/fhs/ch03s07.html)

### /home

user homedirs. low priority, requires multi-user

### /lib

[The /lib directory contains those shared library images needed to boot the system and run the commands in the root filesystem, ie. by binaries in /bin and /sbin.](http://refspecs.linuxbase.org/FHS_3.0/fhs/ch03s09.html)

directories:
`modules Loadable kernel modules (optional)`

[refspec](http://refspecs.linuxbase.org/FHS_3.0/fhs/ch03s09.html)

### /media

low priority
[refspec](http://refspecs.linuxbase.org/FHS_3.0/fhs/ch03s11.html)

### /mnt

external mountpoints. low priority
[refspec](http://refspecs.linuxbase.org/FHS_3.0/fhs/ch03s12.html)

### /opt

[/opt is reserved for the installation of add-on application software packages.](http://refspecs.linuxbase.org/FHS_3.0/fhs/ch03s13.html)

part of package installation. low priority

`The directories /opt/bin, /opt/doc, /opt/include, /opt/info, /opt/lib, and /opt/man are reserved for local system administrator use. Packages may provide "front-end" files intended to be placed in (by linking or copying) these reserved directories by the local system administrator, but must function normally in the absence of these reserved directories.`

`Generally, all data required to support a package on a system must be present within /opt/<package>, including files intended to be copied into /etc/opt/<package> and /var/opt/<package> as well as reserved directories in /opt.`

[refspec](http://refspecs.linuxbase.org/FHS_3.0/fhs/ch03s13.html)

### /root

root homedir. see [/home](https://github.com/janeptrv) (dead link)

[refspec](http://refspecs.linuxbase.org/FHS_3.0/fhs/ch03s14.html)

### /run

[This directory contains system information data describing the system since it was booted. Files under this directory must be cleared (removed or truncated as appropriate) at the beginning of the boot process.](http://refspecs.linuxbase.org/FHS_3.0/fhs/ch03s15.html)

`The purposes of this directory were once served by /var/run. In general, programs may continue to use /var/run to fulfill the requirements set out for /run for the purposes of backwards compatibility. Programs which have migrated to use /run should cease their usage of /var/run, except as noted in the section on /var/run.`

`Programs may have a subdirectory of /run; this is encouraged for programs that use more than one run-time file. Users may also have a subdirectory of /run, although care must be taken to appropriately limit access rights to prevent unauthorized use of /run itself and other subdirectories.`

`Process identifier (PID) files, which were originally placed in /etc, must be placed in /run. The naming convention for PID files is <program-name>.pid. For example, the crond PID file is named /run/crond.pid.`

`The internal format of PID files remains unchanged. The file must consist of the process identifier in ASCII-encoded decimal, followed by a newline character. For example, if crond was process number 25, /run/crond.pid would contain three characters: two, five, and newline.`

`Programs that read PID files should be somewhat flexible in what they accept; i.e., they should ignore extra whitespace, leading zeroes, absence of the trailing newline, or additional lines in the PID file. Programs that create PID files should use the simple specification located in the above paragraph.`

`System programs that maintain transient UNIX-domain sockets must place them in this directory or an appropriate subdirectory as outlined above.`

[refspec](http://refspecs.linuxbase.org/FHS_3.0/fhs/ch03s15.html)

### /sbin

[Programs necessary to arrange for the boot loader to be able to boot a file must be placed in /sbin](http://refspecs.linuxbase.org/FHS_3.0/fhs/ch03s05.html)

`Utilities used for system administration (and other root-only commands) are stored in /sbin, /usr/sbin, and /usr/local/sbin. /sbin contains binaries essential for booting, restoring, recovering, and/or repairing the system in addition to the binaries in /bin. [18] Programs executed after /usr is known to be mounted (when there are no problems) are generally placed into /usr/sbin. Locally-installed system administration programs should be placed into /usr/local/sbin. [19]`

* shutdown  Command to bring the system down.

* fastboot  Reboot the system without checking the disks (optional)
* fasthalt  Stop the system without checking the disks (optional)
* fdisk  Partition table manipulator (optional)
* fsck  File system check and repair utility (optional)
* fsck.*  File system check and repair utility for a specific filesystem (optional)
* getty  The getty program (optional)
* halt  Command to stop the system (optional)
* ifconfig  Configure a network interface (optional)
* init  Initial process (optional)
* mkfs  Command to build a filesystem (optional)
* mkfs.*  Command to build a specific filesystem (optional)
* mkswap  Command to set up a swap area (optional)
* reboot  Command to reboot the system (optional)
* route  IP routing table utility (optional)
* swapon  Enable paging and swapping (optional)
* swapoff  Disable paging and swapping (optional)
* update  Daemon to periodically flush filesystem buffers (optional)

[refspec](http://refspecs.linuxbase.org/FHS_3.0/fhs/ch03s16.html)

### /srv

99% unnecessary. do not implement

[refspec](http://refspecs.linuxbase.org/FHS_3.0/fhs/ch03s17.html)

### /tmp

temporary files. medium priority. wipe on boot

[refspec](http://refspecs.linuxbase.org/FHS_3.0/fhs/ch03s18.html)