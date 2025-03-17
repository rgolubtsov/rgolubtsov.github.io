# Install OpenBSD 7.6 (QEMU-KVM) on Arch Linux

### OpenBSD/amd64 7.6 (QEMU-KVM) on Arch Linux Brief Installation Instructions

*18th of March, 2025*

These installation instructions aim at showing how to simply install and initially set up a VM server running the latest stable OpenBSD release as the guest OS. Arch Linux was chosen as the host OS, and QEMU-KVM &ndash; as a hypervisor that manages and runs the VM. (Prerequisite: QEMU is already installed and configured properly on an Arch Linux host.)

**(1) Download the ISO image of the OpenBSD operating system (amd64) along with SHA-256 checksums**

```
$ curl -sOk https://cdn.openbsd.org/pub/OpenBSD/7.6/amd64/install76.iso \
        -Ok https://cdn.openbsd.org/pub/OpenBSD/7.6/amd64/SHA256        \
        -Ok https://cdn.openbsd.org/pub/OpenBSD/7.6/amd64/SHA256.sig
$
$ ls -al install76.iso SHA256 SHA256.sig
-rw-r--r-- 1 <username> <usergroup> 702595072 Mar 11 19:40 install76.iso
-rw-r--r-- 1 <username> <usergroup>      2172 Mar 11 19:40 SHA256
-rw-r--r-- 1 <username> <usergroup>      2324 Mar 11 19:40 SHA256.sig
```

**(2) Check the integrity of the ISO image against checksums downloaded**

```
$ file install76.iso
install76.iso: ISO 9660 CD-ROM filesystem data 'OpenBSD/amd64   7.6 Install CD' (bootable)
$
$ sha256sum -c --ignore-missing SHA256
install76.iso: OK
install76.iso: OK
```

**(3) Create a RAW virtual HDD image for the VM**

```
$ qemu-img create -f raw <hdd-image-for-openbsd76> 20G
Formatting '<hdd-image-for-openbsd76>', fmt=raw size=21474836480
$
$ ls -al <hdd-image-for-openbsd76>
-rw-r--r-- 1 <username> <usergroup> 21474836480 Mar 11 20:10 <hdd-image-for-openbsd76>
$
$ file <hdd-image-for-openbsd76>
<hdd-image-for-openbsd76>: data
$
$ chmod -v 600 <hdd-image-for-openbsd76>
mode of '<hdd-image-for-openbsd76>' changed from 0644 (rw-r--r--) to 0600 (rw-------)
$
$ ls -al <hdd-image-for-openbsd76>
-rw------- 1 <username> <usergroup> 21474836480 Mar 11 20:10 <hdd-image-for-openbsd76>
```

**(4) Run QEMU using the OpenBSD ISO image in bootable mode**

```
$ qemu-system-x86_64 -m 1G -enable-kvm -cpu host  -smp 2   \
  -net nic,macaddr=52:54:00:12:34:57,model=virtio -net vde \
  -cdrom install76.iso -boot order=d                       \
  -drive file=<hdd-image-for-openbsd76>,format=raw,if=virtio
```

OpenBSD will boot up in a separate window: after booting the kernel, an interactive CLI installer launches and presents a user with its first prompt (asks for a selection).

From now on all the initial system installation configurations will be managed by the OpenBSD installer through a dialog with a user. The following selective settings were chosen and applied during the current (described) install:

* **Disk layout:** 20G: root (`/`) partition 18G, swap partition 2G
* **Network settings:** NIC `vio0`: IP address: `10.0.2.101`, default gateway address: `10.0.2.1`, DNS address: `8.8.8.8`
* **File sets to install:** all, i.e. `bsd`, `bsd.mp`, `bsd.rd`, `base76.tgz`, `comp76.tgz`, `man76.tgz`, `game76.tgz`, `xbase76.tgz`, `xfont76.tgz`, `xserv76.tgz`, `xshare76.tgz`
* **Run OpenSSH daemon on boot:** yes

Other configuration settings are omitted here for brevity.

**(5) Inspect the new OpenBSD virtual HDD image after completing the installation process (optional)**

```
$ ls -al <hdd-image-for-openbsd76>
-rw------- 1 <username> <usergroup> 21474836480 Mar 11 21:00 <hdd-image-for-openbsd76>
$
$ file <hdd-image-for-openbsd76>
<hdd-image-for-openbsd76>: DOS/MBR boot sector; partition 4 : ID=0xa6, active, start-CHS (0x0,1,2), end-CHS (0x3ff,254,63), startsector 64, 41942976 sectors
```

**(6) Boot up the newly installed OpenBSD/amd64 operating system by means of QEMU-KVM in the background, redirecting all the console output to `/dev/null`**

```
$ qemu-system-x86_64 -m 1.8G -enable-kvm -cpu host -smp 2      \
  -net nic,macaddr=52:54:00:12:34:57,model=virtio  -net vde    \
  -drive file=<hdd-image-for-openbsd76>,format=raw,if=virtio > \
  /dev/null 2>&1 &
...
```

OpenBSD will boot up in a separate window.

**(7) Log in as `root` (superuser)**

Install Bash (GNU Bourne Again Shell): `# pkg_add -r bash`. Change the login shell: `# chpass`, and set the `Shell` entry to `/usr/local/bin/bash`. Do relogin after that. Now the active shell should be Bash.

Also it should be worth to change the login shell to Bash for a regular user account if it was created during the installation process: `-bash-5.2# chpass <username>` &ndash; do the same as in the previous step.

Install a small set of supplementary packages for day-to-day administrative purposes (they may vary in choice but for now the next three are quite sufficient):

```
-bash-5.2# pkg_add -r sudo vim lynx
...
```

Add a regular user account to *sudoers* to give it superuser privileges: `-bash-5.2# visudo`, and insert the following line somewhere at the end of the file:

```
<username> ALL=(ALL) SETENV: ALL
```

Finally, run the system update process to install binary updates: `-bash-5.2# syspatch`.

**(8) Log in as a regular user (`<username>`)**

```
...
Mon Mar 17 16:50:00 +03 2025

OpenBSD/amd64 (<hostname>.my.domain) (ttyC0)

login: <username>
Password:
OpenBSD 7.6 (GENERIC.MP) #1: Mon Feb 10 00:14:14 MST 2025

Welcome to OpenBSD: The proactively secure Unix-like operating system.

Please use the sendbug(1) utility to report bugs in the system.
Before reporting a bug, please try to reproduce it with the latest
version of the code.  With bug reports, please try to ensure that
enough information to reproduce the problem is enclosed, and if a
known fix for it exists, include that as well.

-bash-5.2$
```

Now the new operating system is quite ready for daily use in general, but to be really useful and productive, it needs to be fine tuned (adjust system properties and variables like various limits and thresholds, manage to start up some vital daemons on boot) and equipped with a series of essential (and simply handy) packages installed which are responsible for getting things done. Although all these preparation tasks can be performed in this QEMU window and the current login session, they are generally considered more suitable to do over the remote session(s) via SSH.

Let's log in to the new OpenBSD box via SSH and install some additional packages that are already prebuilt by OpenBSD developers and released along with the OS:

```
$ ssh -C <hostname>
Last login: Mon Mar 17 22:20:00 2025
OpenBSD 7.6 (GENERIC.MP) #1: Mon Feb 10 00:14:14 MST 2025

Welcome to OpenBSD: The proactively secure Unix-like operating system.

Please use the sendbug(1) utility to report bugs in the system.
Before reporting a bug, please try to reproduce it with the latest
version of the code.  With bug reports, please try to ensure that
enough information to reproduce the problem is enclosed, and if a
known fix for it exists, include that as well.

-bash-5.2$ uname -a
OpenBSD <hostname>.my.domain 7.6 GENERIC.MP#1 amd64
-bash-5.2$
-bash-5.2$ # These packages were installed previously. Some of them - as dependencies:
-bash-5.2$
-bash-5.2$ pkg_info
bash-5.2.32         GNU Bourne Again Shell
gettext-runtime-0.22.5 GNU gettext runtime libraries and programs
intel-firmware-20250211v0 microcode update binaries for Intel CPUs
libiconv-1.17       character set conversion library
libsodium-1.0.20    library for network communications and cryptography
lynx-2.9.2          text web browser
quirks-7.50         exceptions to pkg_add rules
sudo-1.9.15.5p0     execute a command as another user
updatedb-0p0        pkg_add speed up cache
vim-9.1.1006-no_x11 vi clone, many additional features
vmm-firmware-1.16.3p0 firmware binary images for vmm(4) driver
-bash-5.2$
```

So install Tiny C Compiler, bzip2/bzip3, XZ Utils, Zstandard, Zip/UnZip, and 7-Zip archivers. Then install `tree`, `colordiff`, `dos2unix`, and `curl` utilities. And finally (at least for now), install bash-completion and Git:

```
-bash-5.2$ sudo pkg_add -vr tcc bzip2 bzip3 xz zstd zip unzip p7zip
...
-bash-5.2$ sudo pkg_add -vr tree colordiff dos2unix curl
...
-bash-5.2$ sudo pkg_add -vr bash-completion git
...
```

After that the package database can be checked again &ndash; to inspect the list of newly installed packages along with their dependencies:

```
-bash-5.2$ pkg_info
bash-5.2.32         GNU Bourne Again Shell
bash-completion-2.14.0 programmable completion functions for bash
bzip2-1.0.8p0       block-sorting file compressor, unencumbered
bzip3-1.4.0         compress and decompress bzip3 files
colordiff-1.0.21    colorized diff tool
curl-8.12.0         transfer files with FTP, HTTP, HTTPS, etc.
cvsps-2.1p3         generate patchsets from CVS repositories
dos2unix-7.5.2      convert DOS/MAC files to UNIX (line-endings/charset)
gettext-runtime-0.22.5 GNU gettext runtime libraries and programs
git-2.46.1          distributed version control system
gitwrapper-0.105    invoke an appropriate Git repository server
intel-firmware-20250211v0 microcode update binaries for Intel CPUs
libiconv-1.17       character set conversion library
libsodium-1.0.20    library for network communications and cryptography
lynx-2.9.2          text web browser
lz4-1.10.0          fast BSD-licensed data compression
nghttp2-1.63.0      library for HTTP/2
nghttp3-1.5.0       implementation of HTTP/3
ngtcp2-1.7.0        implementation of the RFC 9000 QUIC protocol
p5-Error-0.17029    error/exception handling in an OO-ish way
p5-Mail-Tools-2.21p0 modules for handling mail with perl
p5-Time-TimeDate-2.33 library for parsing and formatting dates and times
p7zip-16.02p7       file archiver with high compression ratio
quirks-7.50         exceptions to pkg_add rules
sudo-1.9.15.5p0     execute a command as another user
tcc-0.9.27.20230705 tiny C compiler
tree-0.62           print ascii formatted tree of a directory structure
unzip-6.0p17        extract, list & test files in a ZIP archive
updatedb-0p0        pkg_add speed up cache
vim-9.1.1006-no_x11 vi clone, many additional features
vmm-firmware-1.16.3p0 firmware binary images for vmm(4) driver
xz-5.6.2            library and tools for XZ and LZMA compressed files
zip-3.0p2           create/update ZIP files compatible with PKZip(tm)
zstd-1.5.6          zstandard fast real-time compression algorithm
```

Happy OpenBSD-ing over Linux ! :+1:
