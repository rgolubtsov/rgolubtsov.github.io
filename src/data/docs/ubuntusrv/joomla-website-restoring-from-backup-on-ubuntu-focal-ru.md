# Восстановление веб-сайта Joomla! из бэкапа под Ubuntu Server 20.04 LTS

### Инструкция по восстановлению из бэкапа веб-сайта Joomla! и базы данных к нему (MariaDB)

*1st of September, 2021*

Для восстановления из бэкапа веб-сайта (полной установки **Joomla!**) и базы данных к нему (**MariaDB**), необходимо проделать ряд операций. Все они несложные, но их нужно выполнять обязательно на самом веб-сервере в командной строке (в оболочке **Bash**, установленной там по умолчанию).

1. Начальные условия и подготовительные действия.

Будем полагать, что мы уже залогинились по SSH на веб-сервер (виртуальная машина **Ubuntu 20.04.2 LTS**, 192.168.0.*&lt;WEB&gt;*):

```
$ ssh -C <vmusername>@192.168.0.<WEB>
Welcome to Ubuntu 20.04.2 LTS (GNU/Linux 5.4.0-74-generic x86_64)
...
$
```

Все бэкапы хранятся на FTP-сервере (192.168.0.*&lt;FTP&gt;*), поэтому необходимо зайти на этот сервер через FTP-клиент:

```
$ pftp 192.168.0.<FTP>
Connected to 192.168.0.<FTP>.
220 Microsoft FTP Service
Name (192.168.0.<FTP>:<ftpusername>): <ftpusername>
331 Password required for <ftpusername>.
Password:
230 User logged in.
Remote system type is Windows_NT.
ftp>
```

Далее нужно скачать требующуюся версию бэкапа. Бэкапы делаются *каждую ночь в 02:30*. Идентифицируем необходимый нам бэкап &ndash; просто смотрим листинг каталога, где они размещены:

```
ftp> cd tmp/abcd
250 CWD command successful.
ftp>
ftp> ls
227 Entering Passive Mode (192,168,0,<FTP>,215,19).
125 Data connection already open; Transfer starting.
06-29-21  02:00PM             10217764 x-abcd-joomla3-192.168.0.<WEB>-20210624-2000.txz
06-29-21  02:00PM             10217764 x-abcd-joomla3-192.168.0.<WEB>-20210624-2010.txz
06-29-21  02:00PM             10218408 x-abcd-joomla3-192.168.0.<WEB>-20210625-0230.txz
06-29-21  02:00PM             10218160 x-abcd-joomla3-192.168.0.<WEB>-20210626-0230.txz
06-29-21  02:00PM             10218876 x-abcd-joomla3-192.168.0.<WEB>-20210627-0230.txz
06-29-21  02:00PM             10218296 x-abcd-joomla3-192.168.0.<WEB>-20210628-0230.txz
06-29-21  02:00PM             10218440 x-abcd-joomla3-192.168.0.<WEB>-20210629-0230.txz
06-29-21  02:00PM                61816 xabcdjoomla3db-192.168.0.<WEB>-20210624-2000.sql.xz
06-29-21  02:00PM                61816 xabcdjoomla3db-192.168.0.<WEB>-20210624-2010.sql.xz
06-29-21  02:00PM                62360 xabcdjoomla3db-192.168.0.<WEB>-20210625-0230.sql.xz
06-29-21  02:00PM                64940 xabcdjoomla3db-192.168.0.<WEB>-20210626-0230.sql.xz
06-29-21  02:00PM                60568 xabcdjoomla3db-192.168.0.<WEB>-20210627-0230.sql.xz
06-29-21  02:00PM                60996 xabcdjoomla3db-192.168.0.<WEB>-20210628-0230.sql.xz
06-29-21  02:00PM                61300 xabcdjoomla3db-192.168.0.<WEB>-20210629-0230.sql.xz
226 Transfer complete.
```

Здесь `*.txz` &ndash; тарболы каталога веб-сайта (полной установки **Joomla!**), `*.sql.xz` &ndash; сжатые дампы базы данных веб-сайта. Выбираем, например, бэкапы *от 29 июня 2021 года* &ndash; ими будут следующие файлы:

```
x-abcd-joomla3-192.168.0.<WEB>-20210629-0230.txz
xabcdjoomla3db-192.168.0.<WEB>-20210629-0230.sql.xz
```

Отключаем запросы на подтверждение операций с несколькими файлами, а также включаем двоичный режим передачи данных:

```
ftp> prom
Interactive mode off.
ftp>
ftp> bi
200 Type set to I.
```

Скачиваем эти бэкапы в свой домашний каталог на веб-сервере (то есть туда, где мы сейчас находимся):

```
ftp> mg x-abcd-joomla3-192.168.0.<WEB>-20210629-0230.txz xabcdjoomla3db-192.168.0.<WEB>-20210629-0230.sql.xz
local: x-abcd-joomla3-192.168.0.<WEB>-20210629-0230.txz remote: x-abcd-joomla3-192.168.0.<WEB>-20210629-0230.txz
227 Entering Passive Mode (192,168,0,<FTP>,215,28).
125 Data connection already open; Transfer starting.
226 Transfer complete.
10218440 bytes received in 0.09 secs (110.7645 MB/s)
local: xabcdjoomla3db-192.168.0.<WEB>-20210629-0230.sql.xz remote: xabcdjoomla3db-192.168.0.<WEB>-20210629-0230.sql.xz
227 Entering Passive Mode (192,168,0,<FTP>,215,29).
125 Data connection already open; Transfer starting.
226 Transfer complete.
61300 bytes received in 0.00 secs (48.0759 MB/s)
```

Оба бэкапа скачаны, можно выйти из FTP-клиента &ndash; комбинация клавиш `<Ctrl-D>` или команда `by`:

```
ftp> by
ftp> 221 Goodbye.
```

Теперь можно посмотреть на эти файлы локально в файловой системе веб-сервера:

```
$ ls -l
total 10040
-rw-rw-r-- 1 <vmusername> <vmusergroup> 10218440 Jun 29 16:25 x-abcd-joomla3-192.168.0.<WEB>-20210629-0230.txz
-rw-rw-r-- 1 <vmusername> <vmusergroup>    61300 Jun 29 16:25 xabcdjoomla3db-192.168.0.<WEB>-20210629-0230.sql.xz
```

2. Восстановление базы данных.

Сначала выполним декомпрессию дампа базы данных:

```
$ unxz xabcdjoomla3db-192.168.0.<WEB>-20210629-0230.sql.xz
$
$ ls -l
total 11500
-rw-rw-r-- 1 <vmusername> <vmusergroup> 10218440 Jun 29 16:25 x-abcd-joomla3-192.168.0.<WEB>-20210629-0230.txz
-rw-rw-r-- 1 <vmusername> <vmusergroup>  1555738 Jun 29 16:25 xabcdjoomla3db-192.168.0.<WEB>-20210629-0230.sql
```

А теперь выполним собственно восстановление базы данных из этого дампа ([источник](https://mariadb.com/kb/en/mysqldump/#restoring "MariaDB | Restoring database from backup")):

```
$ mysql -uroot -p xabcdjoomla3db < xabcdjoomla3db-192.168.0.<WEB>-20210629-0230.sql
Enter password:
...
```

**База данных веб-сайта восстановлена и сразу же доступна для работы.**

3. Восстановление файлового каталога веб-сайта.

Для восстановления каталога веб-сайта (полной установки **Joomla!**) в файловой системе, предварительно необходимо полностью удалить все файлы и подкаталоги из этого каталога, но сам его оставить, то есть оставить пустым:

```
$ sudo rm -Rf /var/www/x-abcd-joomla3/*
$
$ ls -al /var/www/x-abcd-joomla3/
total 8
drwxr-xr-x 2 www-data www-data 4096 Jul  1 16:07 .
drwxrwxr-x 6 www-data www-data 4096 Jul  1 16:05 ..
```

Видим выше, что из этого каталога все удалено. Распаковываем тарбол, предварительно перейдя в корневой каталог (делаем это составной однострочной командой):

```
$ cd / && sudo tar -xf ~/x-abcd-joomla3-192.168.0.<WEB>-20210629-0230.txz
$
$ ls -al /var/www/x-abcd-joomla3/
total 120
drwxr-xr-x 17 www-data www-data  4096 Jul  1 16:35 .
drwxrwxr-x  6 www-data www-data  4096 Jul  1 16:05 ..
drwxr-xr-x 11 www-data www-data  4096 Jul  1 16:35 administrator
drwxr-xr-x  2 www-data www-data  4096 Jul  1 16:35 bin
drwxr-xr-x  3 www-data www-data  4096 Jul  1 16:35 cache
drwxr-xr-x  2 www-data www-data  4096 Jul  1 16:35 cli
drwxr-xr-x 20 www-data www-data  4096 Jul  1 16:35 components
-r--r--r--  1 www-data www-data  3759 Jul  1 16:35 configuration.php
...
```

**Веб-сайт полностью восстановлен и доступен для работы. Можно логиниться и заходить в панель управления Joomla!**

Restore website, refresh your mind ! &ndash; To publish bright, to be alright ! :+1:
