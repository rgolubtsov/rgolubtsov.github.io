# Oracle Database 11*g* XE (11.2.0) on Ubuntu Server 16.04.4 LTS (x86-64) Deinstallation Instructions

## (1) Stop the running Oracle Database 11.2.0 XE instance

```
$ sudo /etc/init.d/oracle-xe stop
[ ok ] Stopping oracle-xe (via systemctl): oracle-xe.service.
```

## (2) Uninstall (and purge configuration files) the Oracle Database 11.2.0 XE instance and its components

Use the `dpkg` utility to:

### (a) Ensure the `oracle-xe` package is installed and registered in the system package database (optional)

```
$ dpkg --get-selections | grep oracle-xe
oracle-xe                                       install
```

### (b) Purge (uninstall) the `oracle-xe` package from the system and unregister it from the system package database

```
$ sudo dpkg -P oracle-xe
(Reading database ... 145312 files and directories currently installed.)
Removing oracle-xe (11.2.0-2) ...
Purging configuration files for oracle-xe (11.2.0-2) ...
dpkg: warning: while removing oracle-xe, directory '/u01/app/oracle/product/11.2.0/xe/lib' not empty so not removed
dpkg: warning: while removing oracle-xe, directory '/u01/app/oracle/product/11.2.0/xe/config' not empty so not removed
dpkg: warning: while removing oracle-xe, directory '/u01/app/oracle/product/11.2.0/xe/dbs' not empty so not removed
dpkg: warning: while removing oracle-xe, directory '/u01/app/oracle/product/11.2.0/xe/network' not empty so not removed
Processing triggers for libc-bin (2.23-0ubuntu10) ...
Processing triggers for mime-support (3.59ubuntu1) ...
```

### Manually remove remaining directories and files from the system

Notice from the previous command execution output there are a series of directories not removed, which are not actually needed. These directories should also be removed. For that simply delete the `/u01` directory recursively:

```
$ sudo rm -Rf /u01
```

Remove remaining Oracle Database-related directories and files which are still exist in the system for any reason:

```
$ sudo rm -Rf /etc/default/oracle-xe \
              /etc/oratab            \
              /tmp/.oracle           \
              /var/tmp/.oracle       \
              ~/oradiag_<username>   \
              ~/.rpmdb
```

## (3) (Optional) Remove the user who acts as a DBA from the `dba` group

```
$ sudo gpasswd -d <username> dba
Removing user <username> from group dba
```

Do relogin and check the DBA user is not a DBA anymore:

```
$ groups
<usergroup>
```

&ndash; It previously was looked like the following:

```
$ groups
<usergroup> dba
```

---

Happy deliverance from Oracle in Ubuntu ! :+1: &ndash; Because **PostgreSQL** will rule the Universe ! :blue_heart:
