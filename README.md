# A Cup of Radicchio :coffee: :small_blue_diamond: :small_orange_diamond: :small_blue_diamond: :small_orange_diamond:

**[A Cup of Radicchio](https://rgolubtsov.github.io "A Cup of Radicchio: A personal website of a power looper, a skateboarder, and a coder"):** A personal website of a power looper, a skateboarder, and a coder.

---

The website might be rebuilt using **GNU Make** and **[Harp](https://harpjs.com "Harp, the static web server with built-in preprocessing")**: `$ make clean && make all`.

Install **Harp** on **OpenBSD/amd64**:

```
$ sudo CXX=c++ LIBSASS_EXT="no" npm i harp -g --unsafe-perm
/usr/local/bin/harp -> /usr/local/lib/node_modules/harp/bin/harp
...

+ harp@0.46.1
updated 1 package in 20.627s
$
$ ls -al /usr/local/bin/harp /usr/local/lib/node_modules/harp/bin/harp
lrwxr-xr-x  1 root  wheel    33 Jul  1 17:10 /usr/local/bin/harp -> ../lib/node_modules/harp/bin/harp
-rwxr-xr-x  1 root  wheel  4070 Oct 26  1985 /usr/local/lib/node_modules/harp/bin/harp
$
$ harp -v
v0.46.1
```

Install **Harp** on **Ubuntu Server LTS x86-64**:

```
$ sudo npm i harp -g --unsafe-perm

changed 84 packages, and audited 85 packages in 8s

4 packages are looking for funding
  run `npm fund` for details

found 0 vulnerabilities
$
$ ls -al /usr/local/bin/harp /usr/local/lib/node_modules/harp/bin/harp
lrwxrwxrwx 1 root root   33 Apr 12 19:30 /usr/local/bin/harp -> ../lib/node_modules/harp/bin/harp
-rwxr-xr-x 1 root root 4070 Apr 12 19:30 /usr/local/lib/node_modules/harp/bin/harp
$
$ harp -v
v0.46.1
```

Install **Harp** on **Arch Linux** / **Arch Linux 32**:

```
$ sudo LIBSASS_EXT="no" npm i harp -g --unsafe-perm

changed 84 packages, and audited 85 packages in 3s

4 packages are looking for funding
  run `npm fund` for details

found 0 vulnerabilities
$
$ ls -al /usr/bin/harp /usr/lib/node_modules/harp/bin/harp
lrwxrwxrwx 1 root root   33 Apr 12 19:40 /usr/bin/harp -> ../lib/node_modules/harp/bin/harp
-rwxr-xr-x 1 root root 4070 Apr 12 19:40 /usr/lib/node_modules/harp/bin/harp
$
$ harp -v
v0.46.1
```
