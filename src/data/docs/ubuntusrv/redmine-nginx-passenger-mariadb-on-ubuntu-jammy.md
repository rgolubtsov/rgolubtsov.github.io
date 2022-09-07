# Install Redmine 5.0.2 + Nginx/Passenger + MariaDB on Ubuntu Server 22.04 LTS

### Redmine 5.0.2 + Nginx/Passenger + MariaDB on Ubuntu Server 22.04 LTS (x86-64) Brief Installation Instructions

*15th of August, 2022*

Let's consider installing the widely used project management system Redmine on the latest version of Ubuntu Server distribution &ndash; 22.04 LTS. Redmine was also selected as its latest stable release to be able to use new features and be aware there are fresh bugfixes incorporated. For the web and app server option the ideal candidate is Nginx with its integration of the Phusion Passenger app server. And for the database server option the stock Ubuntu MariaDB was chosen.

Note that in these instructions some moments like manipulations with file/directory permissions were omitted because of uniqueness of the installation process in each particular case. Instead, there are inactive (commented out) hyperlinks to various sources regarding installation and configuration of the target components provided, which might be considered helpful.

**(1) Install the necessary dependencies**

```
$ sudo apt-get update && \
  sudo apt-get install build-essential libmariadb-dev ruby-dev imagemagick -y
```

**(2) Install MariaDB Server, Nginx, and Phusion Passenger (Nginx integration mode)**

```
$ sudo apt-get update && \
  sudo apt-get install mariadb-server nginx -y
```

```
$ # https://phusionpassenger.com/library/install/nginx/install/oss/bionic/
$
$ sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 561F9B9CAC40B2F7
$
$ sudo apt-get update && \
  sudo apt-get install libnginx-mod-http-passenger -y
```

**(3) Set up MariaDB for secured configuration**

```
$ # https://dev.mysql.com/doc/refman/8.0/en/mysql-secure-installation.html
$
$ sudo mysql_secure_installation
```

**(4) Configure MariaDB for Redmine readiness**

```
$ mysql -uroot -p
Welcome to the MariaDB monitor.  Commands end with ; or \g.
Your MariaDB connection id is 20
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
| sys                |
+--------------------+
4 rows in set (0.000 sec)

MariaDB [(none)]>
MariaDB [(none)]> select user, host from mysql.user;
+-------------+-----------+
| User        | Host      |
+-------------+-----------+
| mariadb.sys | localhost |
| mysql       | localhost |
| root        | localhost |
+-------------+-----------+
3 rows in set (0.000 sec)

MariaDB [(none)]>
MariaDB [(none)]> create database redmine;
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
+--------------------+
5 rows in set (0.000 sec)

MariaDB [(none)]>
MariaDB [(none)]> create user 'redmine'@'localhost' identified by '<password>';
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
+-------------+-----------+
4 rows in set (0.000 sec)

MariaDB [(none)]>
MariaDB [(none)]> grant all privileges on redmine.* to 'redmine'@'localhost';
Query OK, 0 rows affected (0.000 sec)

MariaDB [(none)]>
MariaDB [(none)]> flush privileges;
Query OK, 0 rows affected (0.000 sec)

MariaDB [(none)]>
MariaDB [(none)]> ^DBye
```

**(5) Download and unpack Redmine**

```
$ wget -c https://redmine.org/releases/redmine-5.0.2.tar.gz
$
$ cd /opt/
$ sudo tar -xvf ~/redmine-5.0.2.tar.gz
$ sudo ln -sfnv redmine-5.0.2 redmine
```

**(6) Install gems dependencies using Gem Bundler and perform initial database migrations**

```
$ # https://redmine.org/projects/redmine/wiki/RedmineInstall
$
$ cd /opt/redmine/
$ sudo -u<username> bundle3.0 config set --local without 'development test'
$ sudo -u<username> bundle3.0 install
$ sudo -u<username> bundle3.0 update
$ sudo -u<username> bundle3.0 exec rake generate_secret_token
$
$ sudo -u<username> RAILS_ENV=production bundle3.0 exec rake db:migrate
$ sudo -u<username> RAILS_ENV=production REDMINE_LANG=ru bundle3.0 exec rake redmine:load_default_data
```

Happy Redmining in Ubuntu ! :+1:
