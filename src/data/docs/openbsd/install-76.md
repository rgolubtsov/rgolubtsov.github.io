# Install OpenBSD 7.6 (QEMU-KVM) on Arch Linux

### OpenBSD/amd64 7.6 (QEMU-KVM) on Arch Linux Brief Installation Instructions

*14th of March, 2025*

These installation instructions aim at showing up how to simply install and initially set up a VM server running the latest stable OpenBSD release as the guest OS. Arch Linux was chosen as the host OS, and QEMU-KVM &ndash; as a hypervisor that manages and runs the VM. (Prerequisite: QEMU is already installed and configured properly on an Arch Linux host.)

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

OpenBSD will boot up in a separate window: after booting the kernel, an interactive CLI installer launches and pesents a user with its first prompt (asks for a selection).

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

**TBD** &#128192;
