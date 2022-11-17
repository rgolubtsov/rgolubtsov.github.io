# Zabbix 6.0.7 to 6.0.8 Upgrade Gotchas

### Zabbix 6.0.7 to 6.0.8 upgrade gotchas regarding slow MariaDB SQL requests

*17th of November, 2022*

Once having the Zabbix 6.0.8 LTS release running after upgrading from the 6.0.7 LTS release, a one unexpected thing might occur during the monitoring process in a series of screens in Zabbix frontend (web interface). And this weird thing will appear repeatedly, again and again on some monitoring screens for a long time. What is this actually? &ndash; Well, this is very slow scanning and updating, for example, the list of hosts, host groups, and triggers... that's saying unacceptably slow scanning.

The root cause seems to be in a communication between Zabbix frontend (running on Nginx/PHP-FPM) and Zabbix database backend (actually MariaDB database server). All the underlying carriers and stack regarding the analyzed setup are clearly described in [this article](/data/docs/ubuntusrv/zabbix-nginx-php-fpm-mariadb-on-ubuntu-jammy "Install Zabbix 6.0.7 + Nginx/PHP-FPM + MariaDB on Ubuntu Server 22.04 LTS"). So this is not necessary to recount them here.

Go ahead and see what's going on there. &ndash; First of all, MariaDB server is almost continuously consuming 90% to 100% CPU usage when scanning the list of hosts is underway. At the same time Zabbix server log complains about slow queries are in progress. On the MariaDB side this is actually seen:

```
MariaDB [zabbix]> show full processlist;
+------+--------+-----------+--------+---------+------+--------------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+----------+
| Id   | User   | Host      | db     | Command | Time | State        | Info                                                                                                                                                                                                                                                                                                                                                                                                     | Progress |
+------+--------+-----------+--------+---------+------+--------------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+----------+
|    3 | zabbix | localhost | zabbix | Sleep   |    4 |              | NULL                                                                                                                                                                                                                                                                                                                                                                                                     |    0.000 |
|   32 | zabbix | localhost | zabbix | Sleep   |    4 |              | NULL                                                                                                                                                                                                                                                                                                                                                                                                     |    0.000 |
|   33 | zabbix | localhost | zabbix | Sleep   |    3 |              | NULL                                                                                                                                                                                                                                                                                                                                                                                                     |    0.000 |
|   34 | zabbix | localhost | zabbix | Sleep   |    1 |              | NULL                                                                                                                                                                                                                                                                                                                                                                                                     |    0.000 |
|   35 | zabbix | localhost | zabbix | Sleep   |    5 |              | NULL                                                                                                                                                                                                                                                                                                                                                                                                     |    0.000 |
|   36 | zabbix | localhost | zabbix | Sleep   |    2 |              | NULL                                                                                                                                                                                                                                                                                                                                                                                                     |    0.000 |
|   39 | zabbix | localhost | zabbix | Sleep   |   48 |              | NULL                                                                                                                                                                                                                                                                                                                                                                                                     |    0.000 |
|   40 | zabbix | localhost | zabbix | Sleep   |    0 |              | NULL                                                                                                                                                                                                                                                                                                                                                                                                     |    0.000 |
|   41 | zabbix | localhost | zabbix | Sleep   |    0 |              | NULL                                                                                                                                                                                                                                                                                                                                                                                                     |    0.000 |
|   43 | zabbix | localhost | zabbix | Sleep   |    2 |              | NULL                                                                                                                                                                                                                                                                                                                                                                                                     |    0.000 |
|   45 | zabbix | localhost | zabbix | Sleep   |   29 |              | NULL                                                                                                                                                                                                                                                                                                                                                                                                     |    0.000 |
|   46 | zabbix | localhost | zabbix | Sleep   |   39 |              | NULL                                                                                                                                                                                                                                                                                                                                                                                                     |    0.000 |
|   47 | zabbix | localhost | zabbix | Sleep   |   43 |              | NULL                                                                                                                                                                                                                                                                                                                                                                                                     |    0.000 |
|   52 | zabbix | localhost | zabbix | Sleep   |  277 |              | NULL                                                                                                                                                                                                                                                                                                                                                                                                     |    0.000 |
|   54 | zabbix | localhost | zabbix | Sleep   |   38 |              | NULL                                                                                                                                                                                                                                                                                                                                                                                                     |    0.000 |
|   55 | zabbix | localhost | zabbix | Sleep   |   12 |              | NULL                                                                                                                                                                                                                                                                                                                                                                                                     |    0.000 |
|   60 | zabbix | localhost | zabbix | Sleep   |   58 |              | NULL                                                                                                                                                                                                                                                                                                                                                                                                     |    0.000 |
|   85 | zabbix | localhost | zabbix | Query   |    1 | Sending data | select distinct g.graphid,g.name,g.width,g.height,g.yaxismin,g.yaxismax,g.show_work_period,g.show_triggers,g.graphtype,g.show_legend,g.show_3d,g.percent_left,g.percent_right,g.ymin_type,g.ymin_itemid,g.ymax_type,g.ymax_itemid,g.discover from graphs g,graphs_items gi,items i,item_discovery id where g.graphid=gi.graphid and gi.itemid=i.itemid and i.itemid=id.itemid and id.parent_itemid=43706 |    0.000 |
|  631 | zabbix | localhost | zabbix | Sleep   | 4136 |              | NULL                                                                                                                                                                                                                                                                                                                                                                                                     |    0.000 |
|  918 | zabbix | localhost | zabbix | Sleep   | 4016 |              | NULL                                                                                                                                                                                                                                                                                                                                                                                                     |    0.000 |
|  927 | zabbix | localhost | zabbix | Sleep   |   37 |              | NULL                                                                                                                                                                                                                                                                                                                                                                                                     |    0.000 |
|  934 | zabbix | localhost | zabbix | Sleep   | 3896 |              | NULL                                                                                                                                                                                                                                                                                                                                                                                                     |    0.000 |
| 6402 | root   | localhost | zabbix | Query   |    0 | starting     | show full processlist                                                                                                                                                                                                                                                                                                                                                                                    |    0.000 |
| 6927 | zabbix | localhost | zabbix | Query   |   26 | Sending data | SELECT DISTINCT t.triggerid FROM triggers t,functions f,items i WHERE i.hostid IN (10084,10528,10530) AND f.triggerid=t.triggerid AND f.itemid=i.itemid AND NOT EXISTS (SELECT NULL FROM functions f,items i,hosts h WHERE t.triggerid=f.triggerid AND f.itemid=i.itemid AND i.hostid=h.hostid AND (i.status<>0 OR h.status<>0)) AND t.status=0 AND t.flags IN (0,4)                                     |    0.000 |
+------+--------+-----------+--------+---------+------+--------------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+----------+
24 rows in set (0.000 sec)
```

Obviously, the query with Id `6927` is the source of this slowdown. Executing it manually gives the following output:

```
MariaDB [zabbix]> SELECT DISTINCT t.triggerid FROM triggers t,functions f,items i WHERE i.hostid IN (10084,10528,10530) AND f.triggerid=t.triggerid AND f.itemid=i.itemid AND NOT EXISTS (SELECT NULL FROM functions f,items i,hosts h WHERE t.triggerid=f.triggerid AND f.itemid=i.itemid AND i.hostid=h.hostid AND (i.status<>0 OR h.status<>0)) AND t.status=0 AND t.flags IN (0,4);
+-----------+
| triggerid |
+-----------+
|     13075 |
|     13436 |
|     13467 |
|     13468 |
|     13470 |
...
|     23022 |
|     23023 |
|     23024 |
|     23025 |
|     23026 |
+-----------+
114 rows in set (2.406 sec)
```

`2.406 sec`... :smiley: Not so bad here, but why?

Another similar query gives too inappropriate timings:

```
MariaDB [zabbix]> SELECT t.triggerid,t.priority,t.manual_close FROM triggers t WHERE t.triggerid IN (22387,23089,23126) AND NOT EXISTS (SELECT NULL FROM functions f,items i,hosts h WHERE t.triggerid=f.triggerid AND f.itemid=i.itemid AND i.hostid=h.hostid AND (i.status<>0 OR h.status<>0)) AND t.status=0 AND t.flags IN (0,4);
+-----------+----------+--------------+
| triggerid | priority | manual_close |
+-----------+----------+--------------+
|     22387 |        1 |            1 |
|     23089 |        3 |            0 |
|     23126 |        3 |            0 |
+-----------+----------+--------------+
3 rows in set (16.501 sec)
```

And what about the following one:

```
MariaDB [zabbix]> select distinct g.graphid,g.name,g.width,g.height,g.yaxismin,g.yaxismax,g.show_work_period,g.show_triggers,g.graphtype,g.show_legend,g.show_3d,g.percent_left,g.percent_right,g.ymin_type,g.ymin_itemid,g.ymax_type,g.ymax_itemid,g.discover from graphs g,graphs_items gi,items i,item_discovery id where g.graphid=gi.graphid and gi.itemid=i.itemid and i.itemid=id.itemid and id.parent_itemid=44069;
Empty set (6.268 sec)
```

**The solution**

**TBD**
