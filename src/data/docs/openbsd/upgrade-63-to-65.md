# Upgrade OpenBSD 6.3 to 6.5

### OpenBSD/amd64 6.3 to 6.5 Upgrade Instructions

*20th of June, 2019*

As clearly stated in the OpenBSD FAQ regarding upgrading one release to another, *upgrades are only supported from one release to the release immediately following it*. So what to do if it needs to upgrade the 6.3 release of OpenBSD to the 6.5 release, is to upgrade sequentially, first to the 6.4 release, and then to the 6.5 release.

**Upgrade OpenBSD 6.3 release to 6.4 release**

**(a)** Having installed and running the OpenBSD/amd64 6.3 release, first of all it needs to download the new (6.4) ramdisk kernel `bsd.rd` and the checksum file `SHA256.sig` for the appropriate architecture, in this case `amd64`:

```
$ curl -sO https://cdn.openbsd.org/pub/OpenBSD/6.4/amd64/bsd.rd     \
       -sO https://cdn.openbsd.org/pub/OpenBSD/6.4/amd64/SHA256.sig
```

**(b)** Verify checksum of the new ramdisk kernel:

```
$ signify -C -p /etc/signify/openbsd-64-base.pub -x SHA256.sig bsd.rd
Signature Verified
bsd.rd: OK
```

**(c)** Permanently set the new CDN URL (it was changed in the 6.4 release) which will be using during system upgrade and later on during upgrading packages:

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

**(d)** Remove unneeded (unused) files:

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

**(e)** Remove unneeded (unused) user and group:

```
$ sudo userdel _rtadvd && sudo groupdel _rtadvd
```

**(f)** Disable starting up the `buildslave` (obsolete) daemon:

```
$ sudo rcctl disable buildslave
```

**(g)** Copy the new ramdisk kernel to the root filesystem:

```
$ sudo cp -vf bsd.rd /
bsd.rd -> /bsd.rd
```

**== IT'S THE TIME TO BOOT INTO THE NEW KERNEL ==**

**(h)** Reboot:

```
$ sudo shutdown -r now
```

**(i)** At the boot loader prompt type `bsd.rd` and hit `<Enter>`:

```
boot> bsd.rd
```

**(j)** After the kernel is booted, hit `s` (that means `(S)hell`) to enter the shell to configure network if not already autoconfigured. In the shell make necessary network configurations, then hit `<Ctrl-D>` to return to the installation/upgrading program. (This step is very important if, for example, OpenBSD is installed and running inside a virtual machine, like [this one](https://github.com/rgolubtsov/dotfiles/blob/master/openbsd/README.md "OpenBSD VM-boxes using QEMU")):

```
# ifconfig vio0 10.0.2.101/24
# route add default 10.0.2.1
add net default: gateway 10.0.2.1
# ^D
```

**(k)** Hit `u` (that means `(U)pgrade`) and follow sequential prompts. In most cases for most questions just hit `<Enter>` for default choices.

After rebooting into the upgraded system...

```
OpenBSD 6.4 (GENERIC.MP) #364: Thu Oct 11 13:30:23 MDT 2018

Welcome to OpenBSD: The proactively secure Unix-like operating system.

Please use the sendbug(1) utility to report bugs in the system.
Before reporting a bug, please try to reproduce it with the latest
version of the code.  With bug reports, please try to ensure that
enough information to reproduce the problem is enclosed, and if a
known fix for it exists, include that as well.
```

...and making initial network configurations...

```
$ sudo ifconfig vio0 10.0.2.101/24
$ sudo route add default 10.0.2.1
add net default: gateway 10.0.2.1
```

...upgrade packages:

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

**(l)** Make all the necessary removals and updates which were reported by the `pkg_add` command:

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

**(m)** Remove previously downloaded and already unneeded ramdisk kernel and its checksum file which reside in the user home directory:

```
$ rm -vf bsd.rd SHA256.sig
bsd.rd
SHA256.sig
```

**== OPENBSD HAS BEEN UPGRADED TO THE 6.4 RELEASE ==**

:smiley:

**Upgrade OpenBSD 6.4 release to 6.5 release**

Now having installed and running the OpenBSD/amd64 6.4 release, there is a need to download the new (6.5) ramdisk kernel `bsd.rd` and the checksum file `SHA256.sig` for the appropriate architecture, in this case `amd64`, just like as it is stated in the beginning of the previous section &ndash; subsection **(a)**:

```
$ curl -sO https://cdn.openbsd.org/pub/OpenBSD/6.5/amd64/bsd.rd     \
       -sO https://cdn.openbsd.org/pub/OpenBSD/6.5/amd64/SHA256.sig
```

Verify checksum of the new ramdisk kernel:

```
$ signify -C -p /etc/signify/openbsd-65-base.pub -x SHA256.sig bsd.rd
Signature Verified
bsd.rd: OK
```

Remove unneeded (unused) files:

```
$ sudo rm -vf /usr/include/openssl/asn1_mac.h
/usr/include/openssl/asn1_mac.h
$
$ sudo rm -vf /usr/bin/c2ph                                      \
              /usr/bin/pstruct                                   \
              /usr/libdata/perl5/Locale/Codes/API.pod            \
              /usr/libdata/perl5/Module/CoreList/TieHashDelta.pm \
              /usr/libdata/perl5/Unicode/Collate/Locale/bg.pl    \
              /usr/libdata/perl5/Unicode/Collate/Locale/fr.pl    \
              /usr/libdata/perl5/Unicode/Collate/Locale/ru.pl    \
              /usr/libdata/perl5/unicore/lib/Sc/Cham.pl          \
              /usr/libdata/perl5/unicore/lib/Sc/Ethi.pl          \
              /usr/libdata/perl5/unicore/lib/Sc/Hebr.pl          \
              /usr/libdata/perl5/unicore/lib/Sc/Hmng.pl          \
              /usr/libdata/perl5/unicore/lib/Sc/Khar.pl          \
              /usr/libdata/perl5/unicore/lib/Sc/Khmr.pl          \
              /usr/libdata/perl5/unicore/lib/Sc/Lana.pl          \
              /usr/libdata/perl5/unicore/lib/Sc/Lao.pl           \
              /usr/libdata/perl5/unicore/lib/Sc/Talu.pl          \
              /usr/libdata/perl5/unicore/lib/Sc/Tibt.pl          \
              /usr/libdata/perl5/unicore/lib/Sc/Xsux.pl          \
              /usr/libdata/perl5/unicore/lib/Sc/Zzzz.pl          \
              /usr/share/man/man1/c2ph.1                         \
              /usr/share/man/man1/pstruct.1                      \
              /usr/share/man/man3p/Locale::Codes::API.3p
/usr/bin/c2ph
/usr/bin/pstruct
/usr/libdata/perl5/Locale/Codes/API.pod
/usr/libdata/perl5/Module/CoreList/TieHashDelta.pm
/usr/libdata/perl5/Unicode/Collate/Locale/bg.pl
/usr/libdata/perl5/Unicode/Collate/Locale/fr.pl
/usr/libdata/perl5/Unicode/Collate/Locale/ru.pl
/usr/libdata/perl5/unicore/lib/Sc/Cham.pl
/usr/libdata/perl5/unicore/lib/Sc/Ethi.pl
/usr/libdata/perl5/unicore/lib/Sc/Hebr.pl
/usr/libdata/perl5/unicore/lib/Sc/Hmng.pl
/usr/libdata/perl5/unicore/lib/Sc/Khar.pl
/usr/libdata/perl5/unicore/lib/Sc/Khmr.pl
/usr/libdata/perl5/unicore/lib/Sc/Lana.pl
/usr/libdata/perl5/unicore/lib/Sc/Lao.pl
/usr/libdata/perl5/unicore/lib/Sc/Talu.pl
/usr/libdata/perl5/unicore/lib/Sc/Tibt.pl
/usr/libdata/perl5/unicore/lib/Sc/Xsux.pl
/usr/libdata/perl5/unicore/lib/Sc/Zzzz.pl
/usr/share/man/man1/c2ph.1
/usr/share/man/man1/pstruct.1
/usr/share/man/man3p/Locale::Codes::API.3p
```

Perform actions from the previous section &ndash; subsections **(g)** to **(k)**, then:

After rebooting into the upgraded system...

```
OpenBSD 6.5 (GENERIC.MP) #3: Sat Apr 13 14:48:43 MDT 2019

Welcome to OpenBSD: The proactively secure Unix-like operating system.

Please use the sendbug(1) utility to report bugs in the system.
Before reporting a bug, please try to reproduce it with the latest
version of the code.  With bug reports, please try to ensure that
enough information to reproduce the problem is enclosed, and if a
known fix for it exists, include that as well.
```

...and making initial network configurations...

```
$ sudo ifconfig vio0 10.0.2.101/24
$ sudo route add default 10.0.2.1
add net default: gateway 10.0.2.1
```

...it's the time to upgrade packages: `$ sudo pkg_add -uv`; but first check the package database:

```
$ pkg_info
perl:/usr/local/libdata/perl5/site_perl/amd64-openbsd/auto/Cwd/Cwd.so: undefined symbol 'PL_sv_undef'
Can't load '/usr/local/libdata/perl5/site_perl/amd64-openbsd/auto/Cwd/Cwd.so' for module Cwd: Cannot load specified object at /usr/local/libdata/perl5/site_perl/amd64-openbsd/XSLoader.pm line 96.
 at /usr/local/libdata/perl5/site_perl/amd64-openbsd/Cwd.pm line 82.
Compilation failed in require at /usr/local/libdata/perl5/site_perl/amd64-openbsd/File/Spec/Unix.pm line 4.
BEGIN failed--compilation aborted at /usr/local/libdata/perl5/site_perl/amd64-openbsd/File/Spec/Unix.pm line 4.
Compilation failed in require at /usr/local/libdata/perl5/site_perl/amd64-openbsd/File/Spec.pm line 21.
Compilation failed in require at /usr/libdata/perl5/OpenBSD/PackageInfo.pm line 168.
```

The command above doesn't work, and as it is clearly seeing in the output, something gets wrong with the Perl module `Cwd`. But further investigations show out that this module (as being an XS-module) was compiled to use with the previous version of Perl, hence it is incompatible with the currently installed Perl release.

Obviously, the easiest solution to repair this crucial Perl module is to replace the whole Perl base module set with that one freshly downloaded from the OpenBSD CDN. It is contained in the `base65.tgz` tarball. The following compound one-liner command will replace the old Perl base module set with the new one, with minimal effort from the user side:

```
$ mkdir        xyz                                                                                  && \
  cd           xyz/                                                                                 && \
  curl    -sO  https://cdn.openbsd.org/pub/OpenBSD/6.5/amd64/base65.tgz                             && \
  tar     -xzf base65.tgz                                                                           && \
  sudo rm -Rf  /usr/local/libdata/perl5/site_perl/amd64-openbsd/*                                   && \
  sudo cp -Rf ./usr/libdata/perl5/amd64-openbsd/* /usr/local/libdata/perl5/site_perl/amd64-openbsd/ && \
  cd -                                                                                              && \
  sudo rm -Rf  xyz/
```

Now package manipulation commands (`pkg_info`, `pkg_add`, `pkg_delete`, etc.) should be working fine:

```
$ pkg_info
adwaita-icon-theme-3.28.0p1 base icon theme for GNOME
at-spi2-atk-2.26.2  atk-bridge for at-spi2
at-spi2-core-2.28.0p0 service interface for assistive technologies
...
xz-5.2.4            LZMA compression and decompression tools
zip-3.0p0           create/update ZIP files compatible with PKZip(tm)
zstd-1.3.5p0        zstandard fast real-time compression algorithm
```

Upgrade packages:

```
$ sudo pkg_add -uv
Update candidates: quirks-3.16 -> quirks-3.124
quirks-3.124 signed on 2019-04-15T12:10:16Z
quirks-3.16->3.124: ok
Update candidates: adwaita-icon-theme-3.28.0p1 -> adwaita-icon-theme-3.30.1
Update candidates: gtk-update-icon-cache-3.22.30p1 -> gtk-update-icon-cache-3.24.7
Update candidates: gdk-pixbuf-2.36.12 -> gdk-pixbuf-2.38.1
...
Running tags: ok
Read shared items: ok
...
Couldn't find updates for rebar19-2.6.2p0
Extracted 2530483626 from 2530564521
```

Make all the necessary removals and updates which were reported by the `pkg_add` command:

```
$ sudo rm -f /var/db/colord/mapping.db \
             /var/db/colord/storage.db
$
$ sudo rm -rf /etc/dconf/db/*      \
              /etc/dconf/profile/*
$
$ sudo xmlcatalog /var/db/xmlcatalog
$
$ sudo update-desktop-database
$
$ sudo update-mime-database /usr/local/share/mime/
```

Perform the action from the previous section, subsection **(m)**.

**== OPENBSD HAS BEEN UPGRADED TO THE 6.5 RELEASE ==**

Freshly **OpenBSD**-ing your beings ! :+1:
