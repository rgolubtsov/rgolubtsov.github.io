# [![A Cup of Radicchio](http://rgolubtsov.github.io/favicon.ico)](http://rgolubtsov.github.io) A Cup of Radicchio :coffee:

**[A Cup of Radicchio](http://rgolubtsov.github.io "A Cup of Radicchio: A personal website of a power looper, a skateboarder, and a coder"):** A personal website of a power looper, a skateboarder, and a coder.

---

The website might be rebuilt using **GNU Make** and **[Harp](http://harpjs.com "Harp, the static web server with built-in preprocessing")**: `$ make clean && make all`.

Install **Harp** on **OpenBSD/amd64**:

```
$ sudo CXX=c++ LIBSASS_EXT="no" npm i harp -g --unsafe-perm
...
/usr/local/bin/harp -> /usr/local/lib/node_modules/harp/bin/harp
...
+ harp@0.32.0
```

Install **Harp** on **Ubuntu Server LTS x86-64**:

```
$ sudo npm i harp -g --unsafe-perm
...
/usr/local/bin/harp -> /usr/local/lib/node_modules/harp/bin/harp
...
+ harp@0.46.0
$
$ ls -al /usr/local/bin/harp /usr/local/lib/node_modules/harp/bin/harp
lrwxrwxrwx 1 root root   33 Nov 14 00:50 /usr/local/bin/harp -> ../lib/node_modules/harp/bin/harp
-rwxr-xr-x 1 root root 4070 Nov 14 00:50 /usr/local/lib/node_modules/harp/bin/harp
$
$ harp -v
v0.46.0
```

Install **Harp** on **Arch Linux** / **Arch Linux 32**:

```
$ sudo LIBSASS_EXT="no" npm i harp -g --unsafe-perm
...
/usr/bin/harp -> /usr/lib/node_modules/harp/bin/harp
...
+ harp@0.46.0
$
$ ls -al /usr/bin/harp /usr/lib/node_modules/harp/bin/harp
lrwxrwxrwx 1 root root   33 Nov 13 00:10 /usr/bin/harp -> ../lib/node_modules/harp/bin/harp
-rwxr-xr-x 1 root root 4070 Nov 13 00:10 /usr/lib/node_modules/harp/bin/harp
$
$ harp -v
v0.46.0
```
