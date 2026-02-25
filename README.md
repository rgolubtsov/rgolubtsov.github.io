# A Cup of Radicchio :coffee: :small_blue_diamond: :small_orange_diamond: :small_blue_diamond: :small_orange_diamond:

**[A Cup of Radicchio](https://rgolubtsov.github.io "A Cup of Radicchio: A personal website of a power looper, a skateboarder, and a coder"):** A personal website of a power looper, a skateboarder, and a coder.

---

The website might be built using **GNU Make** and **[Harp](https://github.com/sintaxi/harp "Harp, the static web server with built-in preprocessing")**: `$ make clean && make all`. (On **OpenBSD** it needs to use `gmake` instead of `make`, i.e. `$ gmake clean && gmake all`.)

Install **Harp** on **OpenBSD/amd64**:

```
$ sudo npm i harp -g --unsafe-perm --ignore-scripts

changed 84 packages in 18s

5 packages are looking for funding
  run `npm fund` for details
$
$ ls -al /usr/local/bin/harp /usr/local/lib/node_modules/harp/bin/harp
lrwxr-xr-x  1 root  wheel    33 Mar 20 22:30 /usr/local/bin/harp -> ../lib/node_modules/harp/bin/harp
-rwxr-xr-x  1 root  wheel  4070 Mar 20 22:30 /usr/local/lib/node_modules/harp/bin/harp
$
$ harp -v
v0.46.1
```

Install **Harp** on **Ubuntu Server LTS x86-64**:

```
$ sudo npm i harp -g --unsafe-perm

changed 82 packages in 4s

6 packages are looking for funding
  run `npm fund` for details
$
$ ls -al /usr/local/bin/harp /usr/local/lib/node_modules/harp/bin/harp
lrwxrwxrwx 1 root root   33 Feb 25 18:00 /usr/local/bin/harp -> ../lib/node_modules/harp/bin/harp
-rwxr-xr-x 1 root root 4070 Feb 25 18:00 /usr/local/lib/node_modules/harp/bin/harp
$
$ harp -v
v0.47.2
```

Install **Harp** on **Arch Linux**:

```
$ sudo npm i harp -g --unsafe-perm

changed 84 packages in 13s

5 packages are looking for funding
  run `npm fund` for details
$
$ ls -al /usr/bin/harp /usr/lib/node_modules/harp/bin/harp
lrwxrwxrwx 1 root root   33 Mar 23 11:50 /usr/bin/harp -> ../lib/node_modules/harp/bin/harp
-rwxr-xr-x 1 root root 4070 Mar 23 11:50 /usr/lib/node_modules/harp/bin/harp
$
$ harp -v
v0.46.1
```
