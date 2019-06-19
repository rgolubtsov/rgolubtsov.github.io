# Upgrade OpenBSD 6.3 to 6.5

### OpenBSD/amd64 6.3 to 6.5 Upgrade Instructions

As clearly stated in the OpenBSD FAQ regarding upgrading one release to another, *upgrades are only supported from one release to the release immediately following it*. So what to do if it needs to upgrade the 6.3 release of OpenBSD to the 6.5 release is to upgrade sequentially, first to the 6.4 release, and then to the 6.5 release.

**Upgrade OpenBSD 6.3 release to 6.4 release**

Having installed and running the OpenBSD/amd64 6.3 release first of all it needs to download the new (6.4) ramdisk kernel `bsd.rd` and the checksum file `SHA256.sig` for the appropriate architecture, in this case `amd64`:

```
$ curl -sO https://cdn.openbsd.org/pub/OpenBSD/6.4/amd64/bsd.rd     \
       -sO https://cdn.openbsd.org/pub/OpenBSD/6.4/amd64/SHA256.sig
```

Verify checksum of the new ramdisk kernel:

```
$ signify -C -p /etc/signify/openbsd-64-base.pub -x SHA256.sig bsd.rd
Signature Verified
bsd.rd: OK
```

Permanently set the new CDN URL (it was changed in the 6.4 release) which will be used during system upgrade and later on during upgrading the packages:

```
$ cat /etc/installurl
https://ftp.openbsd.org/pub/OpenBSD    <== The old one.
$
$ sudo su -
# echo "https://cdn.openbsd.org/pub/OpenBSD" > /etc/installurl
$
$ cat /etc/installurl
https://cdn.openbsd.org/pub/OpenBSD    <== The new one.
```

Remove unneeded (unused) files:

```
$ sudo rm -vf /dev/audio /dev/audioctl
/dev/audio
/dev/audioctl
$
$ sudo rm -vf /etc/rc.d/rtadvd /usr/sbin/rtadvd \
              /usr/share/man/man5/rtadvd.conf.5 \
              /usr/share/man/man8/rtadvd.8
/etc/rc.d/rtadvd
/usr/sbin/rtadvd
/usr/share/man/man5/rtadvd.conf.5
/usr/share/man/man8/rtadvd.8
$
$ sudo rm -vf /usr/X11R6/lib/libxcb-xevie.*          \
              /usr/X11R6/lib/libxcb-xprint.*         \
              /usr/X11R6/lib/pkgconfig/xcb-xevie.pc  \
              /usr/X11R6/lib/pkgconfig/xcb-xprint.pc
/usr/X11R6/lib/libxcb-xevie.a
/usr/X11R6/lib/libxcb-xevie.so.1.0
/usr/X11R6/lib/libxcb-xprint.a
/usr/X11R6/lib/libxcb-xprint.so.3.0
/usr/X11R6/lib/pkgconfig/xcb-xevie.pc
/usr/X11R6/lib/pkgconfig/xcb-xprint.pc
```

Remove unneeded (unused) user and group:

```
$ sudo userdel _rtadvd && sudo groupdel _rtadvd
```

Disable starting up the `buildslave` (obsolete) daemon:

```
$ sudo rcctl disable buildslave
```

Copy the new ramdisk kernel to the root filesystem:

```
$ sudo cp -vf bsd.rd /
bsd.rd -> /bsd.rd
```

**== IT'S THE TIME TO BOOT INTO THE NEW KERNEL ==**

Reboot:

```
$ sudo shutdown -r now
```

At the boot loader prompt type `bsd.rd` and hit `<Enter>`:

```
boot> bsd.rd
```

After the kernel is booted, hit `s` (that means `(S)hell`) to enter the shell to configure network if not already autoconfigured. In the shell make necessary network configuration, then hit `<Ctrl-D>` to return to the installation/upgrading program. (This step is very important if, for example, the OpenBSD box is installed and running as a virtual machine, like [this one](https://github.com/rgolubtsov/dotfiles/blob/master/openbsd/README.md "OpenBSD VM-boxes using QEMU")):

```
# ifconfig vio0 10.0.2.101/24
# route add default 10.0.2.1
add net default: gateway 10.0.2.1
# ^D
```

Hit `u` (that means `(U)pgrade`) and follow sequential prompts. In most cases for most questions just hit `<Enter>` for default choices.

After reboot into the upgraded system...

```
OpenBSD 6.4 (GENERIC.MP) #364: Thu Oct 11 13:30:23 MDT 2018

Welcome to OpenBSD: The proactively secure Unix-like operating system.

Please use the sendbug(1) utility to report bugs in the system.
Before reporting a bug, please try to reproduce it with the latest
version of the code.  With bug reports, please try to ensure that
enough information to reproduce the problem is enclosed, and if a
known fix for it exists, include that as well.
```

...and making initial network configuration...

```
$ sudo ifconfig vio0 10.0.2.101/24
$ sudo route add default 10.0.2.1
add net default: gateway 10.0.2.1
```

...upgrade the packages:

```
$ sudo pkg_add -uv
Update candidates: quirks-2.414 -> quirks-3.16
quirks-3.16 signed on 2018-10-12T15:26:25Z
quirks-2.414->3.16: ok
Update candidates: adwaita-icon-theme-3.26.1 -> adwaita-icon-theme-3.28.0p1
Update candidates: gtk-update-icon-cache-3.22.29 -> gtk-update-icon-cache-3.22.30p1
Update candidates: hicolor-icon-theme-0.17 -> hicolor-icon-theme-0.17
...
Running tags: ok
Read shared items: ok
...
Obsolete package: mozjs17-17.0p4 (no longer maintained and full of security holes)
Couldn't find updates for mozjs17-17.0p4
Extracted 2124668768 from 2265411565
```

Make all the necessary removals and updates which were reported by the `pkg_add` command:

```
$ sudo rm -f /var/db/colord/mapping.db \
             /var/db/colord/storage.db
$
$ sudo rm -rf /etc/dconf/db/*      \
              /etc/dconf/profile/*
$
$ sudo rm -Rf /usr/local/lib/gcc/x86_64-unknown-openbsd6.3/
$
$ sudo rm -Rf /usr/local/share/mime/x-epoc/      \
              /usr/local/share/mime/x-content/   \
              /usr/local/share/mime/video/       \
              /usr/local/share/mime/text/        \
              /usr/local/share/mime/multipart/   \
              /usr/local/share/mime/model/       \
              /usr/local/share/mime/message/     \
              /usr/local/share/mime/inode/       \
              /usr/local/share/mime/image/       \
              /usr/local/share/mime/font/        \
              /usr/local/share/mime/audio/       \
              /usr/local/share/mime/application/
$
$ sudo xmlcatalog /var/db/xmlcatalog
$
$ sudo update-desktop-database
$
$ sudo update-mime-database /usr/local/share/mime/
$
$ sudo pkg_delete -v mozjs17
mozjs17-17.0p4: ok
Read shared items: ok
```

Remove previously downloaded and already unneeded ramdisk kernel and its checksum file which reside in the user home directory:

```
$ rm -vf bsd.rd SHA256.sig 
bsd.rd
SHA256.sig
```

**== OPENBSD HAS BEEN UPGRADED TO THE 6.4 RELEASE ==**

:smiley:

**Upgrade OpenBSD 6.4 release to 6.5 release**

TBD.

Freshly **OpenBSD**-ing your beings ! :+1:
