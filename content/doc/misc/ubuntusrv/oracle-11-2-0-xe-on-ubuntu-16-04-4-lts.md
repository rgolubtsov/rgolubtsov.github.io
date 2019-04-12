# Oracle Database 11*g* XE (11.2.0) on Ubuntu Server 16.04.4 LTS (x86-64) Installation Instructions

(For instructions on deinstalling Oracle Database 11*g* XE see [this document](https://github.com/rgolubtsov/dotfiles/blob/master/ubuntusrv/ubuntu-16-04-4-lts-wo-oracle-11-2-0-xe.md "Oracle Database 11g XE (11.2.0) on Ubuntu Server 16.04.4 LTS (x86-64) Deinstallation Instructions.").)

## (1) Download the Oracle Database 11.2.0 XE zipped RPM package

It is freely downloadable from their OTN website. (**Note:** It needs to have an Oracle Account: sign in or sign up for a new one.) The link is named as "**Oracle Database Express Edition 11g Release 2 for Linux x64**".

Transfer this package to the Ubuntu Server box:

```
$ scp -C oracle-xe-11.2.0-1.0.x86_64.rpm.zip <username>@<hostname>:/home/<username>
oracle-xe-11.2.0-1.0.x86_64.rpm.zip                   100%  301MB   5.4MB/s   00:55
```

## (2) Make the Oracle Database 11.2.0 XE DEB (Debian) package

Do `unzip` the RPM package:

```
$ unzip oracle-xe-11.2.0-1.0.x86_64.rpm.zip
Archive:  oracle-xe-11.2.0-1.0.x86_64.rpm.zip
   creating: Disk1/
   creating: Disk1/upgrade/
  inflating: Disk1/upgrade/gen_inst.sql
   creating: Disk1/response/
  inflating: Disk1/response/xe.rsp
  inflating: Disk1/oracle-xe-11.2.0-1.0.x86_64.rpm
```

Install the **Alien** package:

```
$ sudo apt-get update && sudo apt-get install alien -y
```

Convert the RPM package to the DEB one (Superuser rights are required):

```
$ cd Disk1 && sudo alien -cd oracle-xe-11.2.0-1.0.x86_64.rpm
oracle-xe_11.2.0-2_amd64.deb generated
```

## (3) Install the DEB package into the system

Adjust the **AWK** interpreter's invocation path (create a symlink) in order to allow the Oracle Database configuration utility find it:

```
$ sudo ln -sfnv /usr/bin/awk /bin/awk
'/bin/awk' -> '/usr/bin/awk'
```

Install the **AIO** library. It is required by the Oracle Database instance binary which is dynamically linked against this library:

```
$ sudo apt-get update && sudo apt-get install libaio1 -y
```

Install the created Oracle Database DEB package:

```
$ sudo dpkg -i oracle-xe_11.2.0-2_amd64.deb
Selecting previously unselected package oracle-xe.
(Reading database ... 142241 files and directories currently installed.)
Preparing to unpack oracle-xe_11.2.0-2_amd64.deb ...
Unpacking oracle-xe (11.2.0-2) ...
Setting up oracle-xe (11.2.0-2) ...
Executing post-install steps...

/var/lib/dpkg/info/oracle-xe.postinst: line 114: /sbin/chkconfig: No such file or directory

You must run '/etc/init.d/oracle-xe configure' as the root user to configure the database.

Processing triggers for libc-bin (2.23-0ubuntu10) ...
Processing triggers for systemd (229-4ubuntu21.2) ...
Processing triggers for ureadahead (0.100.0-19) ...
Processing triggers for mime-support (3.59ubuntu1) ...
```

## (4) Configure the installed Oracle Database 11.2.0 XE

Adjust Kernel parameters' defaults using [this Bash script](https://raw.githubusercontent.com/rgolubtsov/dotfiles/master/ubuntusrv/oracle-11-2-0-xe-set-kernel-params "Adjust Kernel parameters required by the Oracle Database instance binary.") because it is required by the Oracle Database instance binary to run properly:

```
$ curl  -O https://raw.githubusercontent.com/rgolubtsov/dotfiles/master/ubuntusrv/oracle-11-2-0-xe-set-kernel-params && \
  chmod -v 700 oracle-11-2-0-xe-set-kernel-params                                                                    && \
  sudo       ./oracle-11-2-0-xe-set-kernel-params
...
mode of 'oracle-11-2-0-xe-set-kernel-params' changed from 0644 (rw-r--r--) to 0700 (rwx------)

=== Current values of Kernel parameters:
fs.file-max = 810275
net.ipv4.ip_local_port_range = 32768 60999
kernel.sem = 32000 1024000000 500 32000
kernel.shmmax = 18446744073692774399

=== Set the new values for Kernel parameters:
fs.file-max = 6815744
net.ipv4.ip_local_port_range = 9000 65000
kernel.sem = 250 32000 100 128
kernel.shmmax = 536870912
```

It needs to use their configuration utility exactly as stated on the previous step. The aforementioned AWK interpreter and AIO library will be involved here:

```
$ sudo /etc/init.d/oracle-xe configure

Oracle Database 11g Express Edition Configuration
-------------------------------------------------
This will configure on-boot properties of Oracle Database 11g Express
Edition.  The following questions will determine whether the database should
be starting upon system boot, the ports it will use, and the passwords that
will be used for database accounts.  Press <Enter> to accept the defaults.
Ctrl-C will abort.

Specify the HTTP port that will be used for Oracle Application Express [8080]:8888

Specify a port that will be used for the database listener [1521]:

Specify a password to be used for database accounts.  Note that the same
password will be used for SYS and SYSTEM.  Oracle recommends the use of
different passwords for each database account.  This can be done after
initial configuration:
Confirm the password:

Do you want Oracle Database 11g Express Edition to be started on boot (y/n) [y]:n

Starting Oracle Net Listener...Done
Configuring database...Done
Starting Oracle Database 11g Express Edition instance...Done
Installation completed successfully.
```

---

## (5) Stop, start, check status, connect to the running Oracle Database 11.2.0 XE instance

### Stop the Oracle Database instance

```
$ sudo /etc/init.d/oracle-xe stop
[ ok ] Stopping oracle-xe (via systemctl): oracle-xe.service.
```

### Start the Oracle Database instance

```
$ sudo /etc/init.d/oracle-xe start
[ ok ] Starting oracle-xe (via systemctl): oracle-xe.service.
```

### Check the status of the Oracle Database instance

```
$ sudo /etc/init.d/oracle-xe status
● oracle-xe.service - SYSV: This is a program that is responsible for taking care of
   Loaded: loaded (/etc/init.d/oracle-xe; bad; vendor preset: enabled)
   Active: active (exited) since Fri 2018-04-06 17:38:26 +03; 9min ago
     Docs: man:systemd-sysv-generator(8)
  Process: 10094 ExecStart=/etc/init.d/oracle-xe start (code=exited, status=0/SUCCESS)

Apr 06 17:38:19 <hostname> systemd[1]: Starting SYSV: This is a program that is responsible for taking care of...
Apr 06 17:38:19 <hostname> oracle-xe[10094]: Starting Oracle Net Listener.
Apr 06 17:38:19 <hostname> su[10106]: Successful su for oracle by root
Apr 06 17:38:19 <hostname> su[10106]: + ??? root:oracle
Apr 06 17:38:19 <hostname> su[10106]: pam_unix(su:session): session opened for user oracle by (uid=0)
Apr 06 17:38:19 <hostname> oracle-xe[10094]: Starting Oracle Database 11g Express Edition instance.
Apr 06 17:38:19 <hostname> su[10129]: Successful su for oracle by root
Apr 06 17:38:19 <hostname> su[10129]: + ??? root:oracle
Apr 06 17:38:19 <hostname> su[10129]: pam_unix(su:session): session opened for user oracle by (uid=0)
Apr 06 17:38:26 <hostname> systemd[1]: Started SYSV: This is a program that is responsible for taking care of.
```

### Connect to the running Oracle Database instance (and get data)

**(Optional)** Before executing any of Oracle Database utilities it needs to add the current user to the `dba` group and set appropriate environment variables:

```
$ sudo usermod -a -G dba <username>
```

**(Optional)** Do relogin and check the current user is now a DBA:

```
$ groups
<usergroup> dba
```

Set Oracle Database-related environment variables:

```
$ . /u01/app/oracle/product/11.2.0/xe/bin/oracle_env.sh
```

Use the __SQL*Plus__ utility to connect to the database and perform any DBA operations on it:

```
$ sqlplus sys as sysdba

SQL*Plus: Release 11.2.0.2.0 Production on Fri Apr 6 18:05:30 2018

Copyright (c) 1982, 2011, Oracle.  All rights reserved.

Enter password:

Connected to:
Oracle Database 11g Express Edition Release 11.2.0.2.0 - 64bit Production

SQL> select * from all_users;

USERNAME                          USER_ID CREATED
------------------------------ ---------- ------------------
XS$NULL                        2147483638 28-AUG-11
APEX_040000                            47 28-AUG-11
APEX_PUBLIC_USER                       45 28-AUG-11
FLOWS_FILES                            44 28-AUG-11
HR                                     43 28-AUG-11
MDSYS                                  42 28-AUG-11
ANONYMOUS                              35 28-AUG-11
XDB                                    34 28-AUG-11
CTXSYS                                 32 28-AUG-11
OUTLN                                   9 28-AUG-11
SYSTEM                                  5 28-AUG-11
SYS                                     0 28-AUG-11

12 rows selected.

SQL> <Ctrl+D>
SQL> Disconnected from Oracle Database 11g Express Edition Release 11.2.0.2.0 - 64bit Production
```

---

Happy Oracling in Ubuntu ! :+1:
