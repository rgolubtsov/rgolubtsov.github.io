# Utilize sndio server on Arch Linux host in OpenBSD VM guest

### Play music on OpenBSD/amd64 (QEMU-KVM) through the `sndiod` server running on Arch Linux host

*15th of May, 2025*

In Arch Linux do:

```
$ sudo pacman -Syu sndio
...
$
$ sndiod -L-
$
$ sndioctl -d
001:output.level=0..127 (127)
002:server.device=0
003:server.device=1
004:server.device=2
005:server.device=3
$
$ sndioctl
output.level=1.000
server.device=0
```

or:

```
$ sndioctl -d
002:output.level=0..127 (127)
003:server.device=0
004:server.device=1
005:server.device=2
006:server.device=3
001:mpg0.level=0..127 (127)
$
$ sndioctl
output.level=1.000
server.device=0
app/mpg0.level=1.000
```

In OpenBSD do:

```
$ export AUDIODEVICE=snd@10.0.2.1/0
$
$ sndioctl -d
001:output.level=0..127 (127)
$
$ sndioctl
output.level=1.000
$
$ mpg123 -v <music_filename>.mp3
High Performance MPEG 1.0/2.0/2.5 Audio Player for Layers 1, 2 and 3
        version 1.32.10; written and copyright by Michael Hipp and others
        free software (LGPL) without any warranty but with best wishes
Decoder: x86-64 (AVX)
Trying output module: sndio, device: <nil>


Terminal control enabled, press 'h' for listing of keys and functions.

Playing MPEG stream 1 of 1: <music_filename>.mp3 ...

MPEG 1.0 L III vbr 48000 j-s


> 6133+0000  02:27.16+00:00.00 --- 100=100 320 kb/s  960 B acc    0 clip p+0.000
[2:27] Decoding of <music_filename>.mp3 finished.
```

or:

```
$ sndioctl -d
002:output.level=0..127 (127)
001:mpg0.level=0..127 (127)
$
$ sndioctl
output.level=1.000
app/mpg0.level=1.000
```

**TBD** &#128192;
