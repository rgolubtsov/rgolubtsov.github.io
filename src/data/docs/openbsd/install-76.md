# Install OpenBSD 7.6 (QEMU-KVM) on Arch Linux

### OpenBSD/amd64 7.6 (QEMU-KVM) on Arch Linux Brief Installation Instructions

*12th of March, 2025*

```
$ curl -sOk https://cdn.openbsd.org/pub/OpenBSD/7.6/amd64/install76.iso \
        -Ok https://cdn.openbsd.org/pub/OpenBSD/7.6/amd64/SHA256        \
        -Ok https://cdn.openbsd.org/pub/OpenBSD/7.6/amd64/SHA256.sig
$
$ ls -al install76.iso SHA256 SHA256.sig
-rw-r--r-- 1 <username> <usergroup> 702595072 Mar 11 19:40 install76.iso
-rw-r--r-- 1 <username> <usergroup>      2172 Mar 11 19:40 SHA256
-rw-r--r-- 1 <username> <usergroup>      2324 Mar 11 19:40 SHA256.sig
$
$ file install76.iso
install76.iso: ISO 9660 CD-ROM filesystem data 'OpenBSD/amd64   7.6 Install CD' (bootable)
$
$ sha256sum -c --ignore-missing SHA256
install76.iso: OK
install76.iso: OK
$
$ qemu-img create -f raw radicv760openbsd76amd6400 20G
Formatting 'radicv760openbsd76amd6400', fmt=raw size=21474836480
$
$ ls -al radicv760openbsd76amd6400
-rw-r--r-- 1 <username> <usergroup> 21474836480 Mar 11 20:10 radicv760openbsd76amd6400
$
$ file radicv760openbsd76amd6400
radicv760openbsd76amd6400: data
$
$ chmod -v 600 radicv760openbsd76amd6400
mode of 'radicv760openbsd76amd6400' changed from 0644 (rw-r--r--) to 0600 (rw-------)
$
$ ls -al radicv760openbsd76amd6400
-rw------- 1 <username> <usergroup> 21474836480 Mar 11 20:10 radicv760openbsd76amd6400
$
$ qemu-system-x86_64 -m 1G -enable-kvm -cpu host  -smp 2   \
  -net nic,macaddr=52:54:00:12:34:57,model=virtio -net vde \
  -cdrom install76.iso -boot order=d                       \
  -drive file=radicv760openbsd76amd6400,format=raw,if=virtio
$
$ ls -al radicv760openbsd76amd6400
-rw------- 1 <username> <usergroup> 21474836480 Mar 11 21:00 radicv760openbsd76amd6400
$
$ file radicv760openbsd76amd6400
radicv760openbsd76amd6400: DOS/MBR boot sector; partition 4 : ID=0xa6, active, start-CHS (0x0,1,2), end-CHS (0x3ff,254,63), startsector 64, 41942976 sectors
$
$ qemu-system-x86_64 -m 1.2G -enable-kvm -cpu host -smp 2 -net nic,macaddr=52:54:00:12:34:57,model=virtio -net vde -drive file=/opt/radicv760/radicv760openbsd76amd6400,format=raw,if=virtio > /dev/null 2>&1 &
...
```

**TBD** &#1f4c0;
