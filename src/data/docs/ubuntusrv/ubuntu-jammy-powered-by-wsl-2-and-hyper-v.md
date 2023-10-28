# Install Ubuntu Server 22.04 LTS in WSL 2/Hyper-V

### A short essay on how to install and configure Ubuntu Server 22.04 LTS by means of WSL 2, backed by Microsoft Hyper-V

*28th of October, 2023*

**Beware:** These are specifically tailored instructions &ndash; your mileage may vary.

*Currently one may find here only raw, simply dumped, bare CLI commands, one-by-one. But their execution sequences will definitely be accompanied with instructions, comments, and explanations a little bit later. &ndash; Think of this article as in progress for a while.*

Create a specific user account for daily operations and provide it power user privileges:

```
$ sudo adduser <username>
Adding user `<username>' ...
Adding new group `<username>' (1001) ...
Adding new user `<username>' (1001) with group `<username>' ...
Creating home directory `/home/<username>' ...
Copying files from `/etc/skel' ...
New password:
Retype new password:
passwd: password updated successfully
Changing the user information for <username>
Enter the new value, or press ENTER for the default
        Full Name []: [first_name] [last_name]
        Room Number []:
        Work Phone []:
        Home Phone []:
        Other []:
Is the information correct? [Y/n]
$
$ sudo usermod -a -G adm,dialout,cdrom,floppy,sudo,audio,dip,video,plugdev,netdev <username>
```

Do relogin and check out that the newly created user has the ownership in those additionally assigned it user groups:

```
$ id
uid=1001(<username>) gid=1001(<usergroup>) groups=1001(<usergroup>),4(adm),20(dialout),24(cdrom),25(floppy),27(sudo),29(audio),30(dip),44(video),46(plugdev),116(netdev)
$
$ groups
<usergroup> adm dialout cdrom floppy sudo audio dip video plugdev netdev
```

**[ Packages ]**

```
$ sudo apt-get install build-essential tcc bc
...
$
$ sudo apt-get install zip unzip unrar p7zip tree colordiff dos2unix lynx elinks net-tools
...
$
$ sudo apt-get install erlang-nox erlang-dev
...
$
$ sudo apt-get install x11-apps ffmpeg mpg321 mplayer xine-console
...
$
$ sudo apt-get install mlocate
...
```

**[ Perl ]**

```
$ sudo apt-get install cpanminus
...
$
$ sudo cpanm App::cpanminus
...
$
$ sudo cpanm App::cpanoutdated
...
$
$ cpan-outdated -p | sudo cpanm
...
$
$ sudo cpanm Mojolicious Net::DNS::Native
...
$
$ sudo cpanm Twiggy
...
$
$ mojo version
CORE
  Perl        (v5.34.0, linux)
  Mojolicious (9.34, Waffle)

OPTIONAL
  Cpanel::JSON::XS 4.09+   (4.37)
  EV 4.32+                 (n/a)
  IO::Socket::Socks 0.64+  (n/a)
  IO::Socket::SSL 2.009+   (n/a)
  Net::DNS::Native 0.15+   (0.22)
  Role::Tiny 2.000001+     (2.002004)
  Future::AsyncAwait 0.52+ (n/a)

This version is up to date, have fun!
$
$ twiggy -v
Twiggy 0.1026
```

**[ Rebar3 + LFE ]**

```
$ rebar3 -v
rebar 3.22.1 on Erlang/OTP 24 Erts 12.2.1
$
$ rebar3 lfe repl
===> Verifying dependencies...
Erlang/OTP 24 [erts-12.2.1] [source] [64-bit] [smp:16:16] [ds:16:16:10] [async-threads:1] [jit]

   ..-~.~_~---..
  (      \\     )    |   A Lisp-2+ on the Erlang VM
  |`-.._/_\\_.-':    |   Type (help) for usage info.
  |         g |_ \   |
  |        n    | |  |   Docs: http://docs.lfe.io/
  |       a    / /   |   Source: http://github.com/lfe/lfe
   \     l    |_/    |
    \   r     /      |   LFE v2.1.2 (abort with ^C; enter JCL with ^G)
     `-E___.-'

lfe>
lfe> (halt)
```

**TBD**
