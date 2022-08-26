# Install Zabbix 6.0.7 + Nginx/PHP-FPM + MariaDB on Ubuntu Server 22.04 LTS

### Zabbix 6.0.7 + Nginx/PHP-FPM + MariaDB on Ubuntu Server 22.04 LTS (x86-64) Brief Installation Instructions

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

**(4) Install Zabbix server, Zabbix frontend (web interface / control panel), Zabbix configuration for Nginx, SQL scripts for Zabbix database backend, and Zabbix agent**

```
$ sudo apt-get update && \
  sudo apt-get install zabbix-server-mysql zabbix-frontend-php zabbix-nginx-conf zabbix-sql-scripts zabbix-agent -y
```

**== TBD later on ==**
