# [![A Cup of Radicchio](http://rgolubtsov.github.io/favicon.ico)](http://rgolubtsov.github.io) A Cup of Radicchio

**[A Cup of Radicchio](http://rgolubtsov.github.io "A Cup of Radicchio: A personal website of a power looper, a skateboarder, and a coder"):** A personal website of a power looper, a skateboarder, and a coder.

---

The website might be rebuilt using **GNU Make** and **[Harp](http://harpjs.com "Harp, the static web server with built-in preprocessing")**: `$ make clean && make all`.

Install **Harp** on **OpenBSD/amd64**:

```
$ sudo CXX=c++ LIBSASS_EXT="no" npm i harp -g --unsafe-perm
...
/usr/local/bin/harp -> /usr/local/lib/node_modules/harp/bin/harp
...
+ harp@0.30.1
```

Install **Harp** on **Ubuntu Server LTS x86-64**:

```
$ sudo npm i harp -g
...
/usr/local/bin/harp -> /usr/local/lib/node_modules/harp/bin/harp
...
└─┬ harp@0.30.1
```

Install **Harp** on **Arch Linux** / **Arch Linux 32**:

```
$ sudo LIBSASS_EXT="no" npm i harp -g --unsafe-perm
...
/usr/bin/harp -> /usr/lib/node_modules/harp/bin/harp
...
+ harp@0.30.1
```
