# Install Zabbix 6.0.7 + Nginx/PHP-FPM + MariaDB on Ubuntu Server 22.04 LTS

### Zabbix 6.0.7 + Nginx/PHP-FPM + MariaDB on Ubuntu Server 22.04 LTS (x86-64) Brief Installation Instructions

*2nd of September, 2022*

The main prerequisite here is to have MariaDB and Nginx servers already installed, configured, and run on the same host where Zabbix supposed being installed. Thus, the following instructions are based on what was installed and configured earlier, for the Redmine-carrying Ubuntu server &ndash; clearly described in [this article](/data/docs/ubuntusrv/redmine-nginx-passenger-mariadb-on-ubuntu-jammy "Install Redmine 5.0.2 + Nginx/Passenger + MariaDB on Ubuntu Server 22.04 LTS").

**(1) Install the necessary dependencies**<br />
**(2) Install MariaDB Server and Nginx**

For installation instructions of dependencies, MariaDB, and Nginx servers please refer to the article "**Install Redmine 5.0.2 + Nginx/Passenger + MariaDB on Ubuntu Server 22.04 LTS**" (the hyperlink is given above).

**(3) Download and install Zabbix Ubuntu repo from the official Zabbix website**

```
$ # https://www.zabbix.com/download?zabbix=6.0&os_distribution=ubuntu&os_version=22.04_jammy&db=mysql&ws=nginx
$
$ curl -LO https://repo.zabbix.com/zabbix/6.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_6.0-3+ubuntu22.04_all.deb
...
$ sudo dpkg -i zabbix-release_6.0-3+ubuntu22.04_all.deb
...
```

**(4) Install Zabbix server, Zabbix frontend (web control panel), Zabbix configuration for Nginx, SQL scripts for Zabbix database backend, and Zabbix agent**

```
$ sudo apt-get update && \
  sudo apt-get install zabbix-server-mysql zabbix-frontend-php zabbix-nginx-conf zabbix-sql-scripts zabbix-agent -y
```

In this step PHP-FPM will be installed as a dependency along with numerous dependent `php-*` packages.

If it is expected to use Zabbix frontend in languages other than English, the `php-gettext-languages` package must also be installed. In addition, for those languages appropriate system locales should be generated on the server where Zabbix frontend is installed.

Also there is a couple of preconfigured scripts in Zabbix frontend which can be run against hosts monitored. So if it is supposed to "Traceroute" a host, it needs to install the `traceroute` package. And for OS detection using Nmap, it needs to install the `nmap` package.

**(5) Configure MariaDB for Zabbix readiness**

```
$ mysql -uroot -p
Welcome to the MariaDB monitor.  Commands end with ; or \g.
Your MariaDB connection id is 920
Server version: 10.6.7-MariaDB-2ubuntu1.1 Ubuntu 22.04

Copyright (c) 2000, 2018, Oracle, MariaDB Corporation Ab and others.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

MariaDB [(none)]>
MariaDB [(none)]> show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
| redmine            |
| sys                |
+--------------------+
5 rows in set (0.000 sec)

MariaDB [(none)]>
MariaDB [(none)]> select user, host from mysql.user;
+-------------+-----------+
| User        | Host      |
+-------------+-----------+
| mariadb.sys | localhost |
| mysql       | localhost |
| redmine     | localhost |
| root        | localhost |
+-------------+-----------+
4 rows in set (0.000 sec)

MariaDB [(none)]>
MariaDB [(none)]> create database zabbix collate utf8mb4_bin;
Query OK, 1 row affected (0.000 sec)

MariaDB [(none)]>
MariaDB [(none)]> show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
| redmine            |
| sys                |
| zabbix             |
+--------------------+
6 rows in set (0.000 sec)

MariaDB [(none)]>
MariaDB [(none)]> create user 'zabbix'@'localhost' identified by '<password>';
Query OK, 0 rows affected (0.000 sec)

MariaDB [(none)]>
MariaDB [(none)]> select user, host from mysql.user;
+-------------+-----------+
| User        | Host      |
+-------------+-----------+
| mariadb.sys | localhost |
| mysql       | localhost |
| redmine     | localhost |
| root        | localhost |
| zabbix      | localhost |
+-------------+-----------+
5 rows in set (0.000 sec)

MariaDB [(none)]>
MariaDB [(none)]> grant all privileges on zabbix.* to 'zabbix'@'localhost';
Query OK, 0 rows affected (0.000 sec)

MariaDB [(none)]>
MariaDB [(none)]> flush privileges;
Query OK, 0 rows affected (0.000 sec)

MariaDB [(none)]>
MariaDB [(none)]> ^DBye
```

**(6) Perform initial database migrations**

```
$ zcat /usr/share/doc/zabbix-sql-scripts/mysql/server.sql.gz | mysql -uzabbix -p zabbix
```

Happy Zabbixing in Ubuntu ! :+1:
