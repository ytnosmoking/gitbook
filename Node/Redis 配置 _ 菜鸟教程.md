> 本文由 [简悦 SimpRead](http://ksria.com/simpread/) 转码， 原文地址 [www.runoob.com](https://www.runoob.com/redis/redis-conf.html)

Redis 配置
========

Redis 的配置文件位于 Redis 安装目录下，文件名为 redis.conf(Windows 名为 redis.windows.conf)。

你可以通过 **CONFIG** 命令查看或设置配置项。

* * *

### 语法

Redis CONFIG 命令格式如下：

```
redis 127.0.0.1:6379> CONFIG GET CONFIG_SETTING_NAME
```

### 实例

```
redis 127.0.0.1:6379> CONFIG GET loglevel

1) "loglevel"
2) "notice"
```

使用 ***** 号获取所有配置项：

### 实例

```
redis 127.0.0.1:6379> CONFIG GET *

  1) "dbfilename"
  2) "dump.rdb"
  3) "requirepass"
  4) ""
  5) "masterauth"
  6) ""
  7) "unixsocket"
  8) ""
  9) "logfile"
 10) ""
 11) "pidfile"
 12) "/var/run/redis.pid"
 13) "maxmemory"
 14) "0"
 15) "maxmemory-samples"
 16) "3"
 17) "timeout"
 18) "0"
 19) "tcp-keepalive"
 20) "0"
 21) "auto-aof-rewrite-percentage"
 22) "100"
 23) "auto-aof-rewrite-min-size"
 24) "67108864"
 25) "hash-max-ziplist-entries"
 26) "512"
 27) "hash-max-ziplist-value"
 28) "64"
 29) "list-max-ziplist-entries"
 30) "512"
 31) "list-max-ziplist-value"
 32) "64"
 33) "set-max-intset-entries"
 34) "512"
 35) "zset-max-ziplist-entries"
 36) "128"
 37) "zset-max-ziplist-value"
 38) "64"
 39) "hll-sparse-max-bytes"
 40) "3000"
 41) "lua-time-limit"
 42) "5000"
 43) "slowlog-log-slower-than"
 44) "10000"
 45) "latency-monitor-threshold"
 46) "0"
 47) "slowlog-max-len"
 48) "128"
 49) "port"
 50) "6379"
 51) "tcp-backlog"
 52) "511"
 53) "databases"
 54) "16"
 55) "repl-ping-slave-period"
 56) "10"
 57) "repl-timeout"
 58) "60"
 59) "repl-backlog-size"
 60) "1048576"
 61) "repl-backlog-ttl"
 62) "3600"
 63) "maxclients"
 64) "4064"
 65) "watchdog-period"
 66) "0"
 67) "slave-priority"
 68) "100"
 69) "min-slaves-to-write"
 70) "0"
 71) "min-slaves-max-lag"
 72) "10"
 73) "hz"
 74) "10"
 75) "no-appendfsync-on-rewrite"
 76) "no"
 77) "slave-serve-stale-data"
 78) "yes"
 79) "slave-read-only"
 80) "yes"
 81) "stop-writes-on-bgsave-error"
 82) "yes"
 83) "daemonize"
 84) "no"
 85) "rdbcompression"
 86) "yes"
 87) "rdbchecksum"
 88) "yes"
 89) "activerehashing"
 90) "yes"
 91) "repl-disable-tcp-nodelay"
 92) "no"
 93) "aof-rewrite-incremental-fsync"
 94) "yes"
 95) "appendonly"
 96) "no"
 97) "dir"
 98) "/home/deepak/Downloads/redis-2.8.13/src"
 99) "maxmemory-policy"
100) "volatile-lru"
101) "appendfsync"
102) "everysec"
103) "save"
104) "3600 1 300 100 60 10000"
105) "loglevel"
106) "notice"
107) "client-output-buffer-limit"
108) "normal 0 0 0 slave 268435456 67108864 60 pubsub 33554432 8388608 60"
109) "unixsocketperm"
110) "0"
111) "slaveof"
112) ""
113) "notify-keyspace-events"
114) ""
115) "bind"
116) ""
```

* * *

编辑配置
----

你可以通过修改 redis.conf 文件或使用 **CONFIG set** 命令来修改配置。

### 语法

**CONFIG SET** 命令基本语法：

```
redis 127.0.0.1:6379> CONFIG SET CONFIG_SETTING_NAME NEW_CONFIG_VALUE
```

### 实例

```
redis 127.0.0.1:6379> CONFIG SET loglevel "notice"
OK
redis 127.0.0.1:6379> CONFIG GET loglevel

1) "loglevel"
2) "notice"
```

* * *

参数说明
----

redis.conf 配置项说明如下：

<table class="reference"><tbody><tr><th>序号</th><th>配置项</th><th>说明</th></tr><tr><td>1</td><td><pre class="prettyprint prettyprinted" style="">daemonize no</pre></td><td>Redis 默认不是以守护进程的方式运行，可以通过该配置项修改，使用 yes 启用守护进程（Windows 不支持守护线程的配置为 no ）</td></tr><tr><td>2</td><td><pre class="prettyprint prettyprinted" style="">pidfile /var/run/redis.pid</pre></td><td>当 Redis 以守护进程方式运行时，Redis 默认会把 pid 写入 /var/run/redis.pid 文件，可以通过 pidfile 指定</td></tr><tr><td>3</td><td><pre class="prettyprint prettyprinted" style="">port 6379</pre></td><td>指定 Redis 监听端口，默认端口为 6379，作者在自己的一篇博文中解释了为什么选用 6379 作为默认端口，因为 6379 在手机按键上 MERZ 对应的号码，而 MERZ 取自意大利歌女 Alessia Merz 的名字</td></tr><tr><td>4</td><td><pre class="prettyprint prettyprinted" style="">bind 127.0.0.1</pre></td><td>绑定的主机地址</td></tr><tr><td>5</td><td><pre class="prettyprint prettyprinted" style="">timeout 300</pre></td><td>当客户端闲置多长秒后关闭连接，如果指定为 0 ，表示关闭该功能</td></tr><tr><td>6</td><td><pre class="prettyprint prettyprinted" style="">loglevel notice</pre></td><td>指定日志记录级别，Redis 总共支持四个级别：debug、verbose、notice、warning，默认为 notice</td></tr><tr><td>7</td><td><pre class="prettyprint prettyprinted" style="">logfile stdout</pre></td><td>日志记录方式，默认为标准输出，如果配置 Redis 为守护进程方式运行，而这里又配置为日志记录方式为标准输出，则日志将会发送给 /dev/null</td></tr><tr><td>8</td><td><pre class="prettyprint prettyprinted" style="">databases 16</pre></td><td>设置数据库的数量，默认数据库为0，可以使用SELECT <dbid>命令在连接上指定数据库id</dbid></td></tr><tr><td>9</td><td><pre class="prettyprint prettyprinted" style="">save &lt;seconds&gt; &lt;changes&gt;</pre><p>Redis 默认配置文件中提供了三个条件：</p><p><strong>save 900 1</strong></p><p><strong>save 300 10</strong></p><p><strong>save 60 10000</strong></p><p>分别表示 900 秒（15 分钟）内有 1 个更改，300 秒（5 分钟）内有 10 个更改以及 60 秒内有 10000 个更改。</p></td><td>指定在多长时间内，有多少次更新操作，就将数据同步到数据文件，可以多个条件配合</td></tr><tr><td>10</td><td><pre class="prettyprint prettyprinted" style="">rdbcompression yes</pre></td><td>指定存储至本地数据库时是否压缩数据，默认为 yes，Redis 采用 LZF 压缩，如果为了节省 CPU 时间，可以关闭该选项，但会导致数据库文件变的巨大</td></tr><tr><td>11</td><td><pre class="prettyprint prettyprinted" style="">dbfilename dump.rdb</pre></td><td>指定本地数据库文件名，默认值为 dump.rdb</td></tr><tr><td>12</td><td><pre class="prettyprint prettyprinted" style="">dir ./</pre></td><td>指定本地数据库存放目录</td></tr><tr><td>13</td><td><pre class="prettyprint prettyprinted" style="">slaveof &lt;masterip&gt; &lt;masterport&gt;</pre></td><td>设置当本机为 slave 服务时，设置 master 服务的 IP 地址及端口，在 Redis 启动时，它会自动从 master 进行数据同步</td></tr><tr><td>14</td><td><pre class="prettyprint prettyprinted" style="">masterauth &lt;master-password&gt;</pre></td><td>当 master 服务设置了密码保护时，slav 服务连接 master 的密码</td></tr><tr><td>15</td><td><pre class="prettyprint prettyprinted" style="">requirepass foobared</pre></td><td>设置 Redis 连接密码，如果配置了连接密码，客户端在连接 Redis 时需要通过 AUTH &lt;password&gt; 命令提供密码，默认关闭</td></tr><tr><td>16</td><td><pre class="prettyprint prettyprinted" style=""> maxclients 128</pre></td><td>设置同一时间最大客户端连接数，默认无限制，Redis 可以同时打开的客户端连接数为 Redis 进程可以打开的最大文件描述符数，如果设置 maxclients 0，表示不作限制。当客户端连接数到达限制时，Redis 会关闭新的连接并向客户端返回 max number of clients reached 错误信息</td></tr><tr><td>17</td><td><pre class="prettyprint prettyprinted" style="">maxmemory &lt;bytes&gt;</pre></td><td>指定 Redis 最大内存限制，Redis 在启动时会把数据加载到内存中，达到最大内存后，Redis 会先尝试清除已到期或即将到期的 Key，当此方法处理 后，仍然到达最大内存设置，将无法再进行写入操作，但仍然可以进行读取操作。Redis 新的 vm 机制，会把 Key 存放内存，Value 会存放在 swap 区</td></tr><tr><td>18</td><td><pre class="prettyprint prettyprinted" style="">appendonly no</pre></td><td>指定是否在每次更新操作后进行日志记录，Redis 在默认情况下是异步的把数据写入磁盘，如果不开启，可能会在断电时导致一段时间内的数据丢失。因为 redis 本身同步数据文件是按上面 save 条件来同步的，所以有的数据会在一段时间内只存在于内存中。默认为 no</td></tr><tr><td>19</td><td><pre class="prettyprint prettyprinted" style="">appendfilename appendonly.aof</pre></td><td>指定更新日志文件名，默认为 appendonly.aof</td></tr><tr><td>20</td><td><pre class="prettyprint prettyprinted" style="">appendfsync everysec</pre></td><td><p>指定更新日志条件，共有 3 个可选值：</p><ul><li><strong>no</strong>：表示等操作系统进行数据缓存同步到磁盘（快）</li><li><strong>always</strong>：表示每次更新操作后手动调用 fsync() 将数据写到磁盘（慢，安全）</li><li><strong>everysec</strong>：表示每秒同步一次（折中，默认值）</li></ul></td></tr><tr><td>21</td><td><pre class="prettyprint prettyprinted" style="">vm-enabled no</pre></td><td>指定是否启用虚拟内存机制，默认值为 no，简单的介绍一下，VM 机制将数据分页存放，由 Redis 将访问量较少的页即冷数据 swap 到磁盘上，访问多的页面由磁盘自动换出到内存中（在后面的文章我会仔细分析 Redis 的 VM 机制）</td></tr><tr><td>22</td><td><pre class="prettyprint prettyprinted" style="">vm-swap-file /tmp/redis.swap</pre></td><td>虚拟内存文件路径，默认值为 /tmp/redis.swap，不可多个 Redis 实例共享</td></tr><tr><td>23</td><td><pre class="prettyprint prettyprinted" style="">vm-max-memory 0</pre></td><td>将所有大于 vm-max-memory 的数据存入虚拟内存，无论 vm-max-memory 设置多小，所有索引数据都是内存存储的(Redis 的索引数据 就是 keys)，也就是说，当 vm-max-memory 设置为 0 的时候，其实是所有 value 都存在于磁盘。默认值为 0</td></tr><tr><td>24</td><td><pre class="prettyprint prettyprinted" style="">vm-page-size 32</pre></td><td>Redis swap 文件分成了很多的 page，一个对象可以保存在多个 page 上面，但一个 page 上不能被多个对象共享，vm-page-size 是要根据存储的 数据大小来设定的，作者建议如果存储很多小对象，page 大小最好设置为 32 或者 64bytes；如果存储很大大对象，则可以使用更大的 page，如果不确定，就使用默认值</td></tr><tr><td>25</td><td><pre class="prettyprint prettyprinted" style="">vm-pages 134217728</pre></td><td>设置 swap 文件中的 page 数量，由于页表（一种表示页面空闲或使用的 bitmap）是在放在内存中的，，在磁盘上每 8 个 pages 将消耗 1byte 的内存。</td></tr><tr><td>26</td><td><pre class="prettyprint prettyprinted" style="">vm-max-threads 4</pre></td><td>设置访问swap文件的线程数,最好不要超过机器的核数,如果设置为0,那么所有对swap文件的操作都是串行的，可能会造成比较长时间的延迟。默认值为4</td></tr><tr><td>27</td><td><pre class="prettyprint prettyprinted" style="">glueoutputbuf yes</pre></td><td>设置在向客户端应答时，是否把较小的包合并为一个包发送，默认为开启</td></tr><tr><td>28</td><td><pre class="prettyprint prettyprinted" style="">hash-max-zipmap-entries 64
hash-max-zipmap-value 512</pre></td><td>指定在超过一定的数量或者最大的元素超过某一临界值时，采用一种特殊的哈希算法</td></tr><tr><td>29</td><td><pre class="prettyprint prettyprinted" style="">activerehashing yes</pre></td><td>指定是否激活重置哈希，默认为开启（后面在介绍 Redis 的哈希算法时具体介绍）</td></tr><tr><td>30</td><td><pre class="prettyprint prettyprinted" style="">include /path/to/local.conf</pre></td><td>指定包含其它的配置文件，可以在同一主机上多个Redis实例之间使用同一份配置文件，而同时各个实例又拥有自己的特定配置文件</td></tr></tbody></table>