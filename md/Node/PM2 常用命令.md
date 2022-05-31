> 本文由 [简悦 SimpRead](http://ksria.com/simpread/) 转码， 原文地址 [blog.csdn.net](https://blog.csdn.net/taoerchun/article/details/81537654)

一、PM2 常用命令

假设你现在已经写好了一个 app.js 的文件，需要启动，你可以使用 pm2 进行管理

1. 启动

1.  # pm2 start app.js
2.  # pm2 start app.js --name my-api   #my-api 为 PM2 进程名称
3.  # pm2 start app.js -i 0           # 根据 CPU 核数启动进程个数
4.  # pm2 start app.js --watch   # 实时监控 app.js 的方式启动，当 app.js 文件有变动时，pm2 会自动 reload

2. 查看进程

1.  # pm2 list
2.  # pm2 show 0 或者 # pm2 info 0  # 查看进程详细信息，0 为 PM2 进程 id

3. 监控

1.  # pm2 monit

4. 停止

1.  # pm2 stop all  # 停止 PM2 列表中所有的进程
2.  # pm2 stop 0    # 停止 PM2 列表中进程为 0 的进程

5. 重载

1.  # pm2 reload all    # 重载 PM2 列表中所有的进程
2.  # pm2 reload 0     # 重载 PM2 列表中进程为 0 的进程

6. 重启

1.  # pm2 restart all     # 重启 PM2 列表中所有的进程
2.  # pm2 restart 0      # 重启 PM2 列表中进程为 0 的进程

7. 删除 PM2 进程

1.  # pm2 delete 0     # 删除 PM2 列表中进程为 0 的进程
2.  # pm2 delete all   # 删除 PM2 列表中所有的进程

8. 日志操作

1.  # pm2 logs [--raw]   #Display all processes logs in streaming
2.  # pm2 flush              #Empty all log file
3.  # pm2 reloadLogs    #Reload all logs

9. 升级 PM2

1.  # npm install pm2@lastest -g   # 安装最新的 PM2 版本
2.  # pm2 updatePM2                    # 升级 pm2

10. 更多命令参数请查看帮助

1.  # pm2 --help

二、PM2 目录结构

默认的目录是：当前用于的家目录下的. pm2 目录（此目录可以自定义，请参考：五、自定义启动文件），详细信息如下：

1.  $HOME/.pm2                   #will contain all PM2 related files
2.  $HOME/.pm2/logs           #will contain all applications logs
3.  $HOME/.pm2/pids           #will contain all applications pids
4.  $HOME/.pm2/pm2.log    #PM2 logs
5.  $HOME/.pm2/pm2.pid    #PM2 pid
6.  $HOME/.pm2/rpc.sock    #Socket file for remote commands
7.  $HOME/.pm2/pub.sock   #Socket file for publishable events
8.  $HOME/.pm2/conf.js       #PM2 Configuration

三、自定义启动文件

创建一个 test.json 的示例文件，格式如下：

1.  {
2.        "name": "test",
3.        "cwd": "/data/wwwroot/nodejs",
4.        "script": "./test.sh",
5.        "exec_interpreter": "bash",
6.        "min_uptime": "60s",
7.        "max_restarts": 30,
8.        "exec_mode" : "cluster_mode",
9.        "error_file" : "./test-err.log",
10.        "out_file": "./test-out.log",
11.        "pid_file": "./test.pid"
12.        "watch": false
13.      }
14.  }

说明：

apps：json 结构，apps 是一个数组，每一个数组成员就是对应一个 pm2 中运行的应用

name：应用程序的名称

cwd：应用程序所在的目录

script：应用程序的脚本路径

exec_interpreter：应用程序的脚本类型，这里使用的 shell，默认是 nodejs

min_uptime：最小运行时间，这里设置的是 60s 即如果应用程序在 60s 内退出，pm2 会认为程序异常退出，此时触发重启 max_restarts 设置数量

max_restarts：设置应用程序异常退出重启的次数，默认 15 次（从 0 开始计数）

exec_mode：应用程序启动模式，这里设置的是 cluster_mode（集群），默认是 fork

error_file：自定义应用程序的错误日志文件

out_file：自定义应用程序日志文件

pid_file：自定义应用程序的 pid 文件

watch：是否启用监控模式，默认是 false。如果设置成 true，当应用程序变动时，pm2 会自动重载。这里也可以设置你要监控的文件。

详细参数列表：见附件八

四、实例

已上面的 test.json 为例

1.  # cat > /data/wwwroot/nodejs/test.sh << EOF
2.  #!/bin/bash
3.  while :
4.  do
5.      echo "Test" >> 1.log
6.      sleep 5
7.  done
8.  EOF

1.  # chmod +x test.sh      # 添加执行权限
2.  # pm2 start test.json    # 启动，如下图：

![](https://blog.linuxeye.com/wp-content/uploads/2016/01/pm2_example_start.png)

1.  # pm2 list    # 查看 pm2 进程，如下图：

![](https://blog.linuxeye.com/wp-content/uploads/2016/01/pm2_example_list.png)

五、备注

其他可参数见官网：[http://pm2.keymetrics.io](https://blog.linuxeye.com/wp-content/themes/begin/inc/go.php?url=http://pm2.keymetrics.io)

六、附件

<table data-evernote-id="1887"><tbody data-evernote-id="1889"><tr data-evernote-id="1890"><td data-evernote-id="1891">Field</td><td data-evernote-id="1892">Type</td><td data-evernote-id="1893">Example</td><td data-evernote-id="1894">Description</td></tr><tr data-evernote-id="1895"><td data-evernote-id="1896">name</td><td data-evernote-id="1897">string</td><td data-evernote-id="1898">"myAPI"</td><td data-evernote-id="1899">name your app will have in PM2</td></tr><tr data-evernote-id="1900"><td data-evernote-id="1901">script</td><td data-evernote-id="1902">string</td><td data-evernote-id="1903">"bin/app.js"</td><td data-evernote-id="1904">path of your app</td></tr><tr data-evernote-id="1905"><td data-evernote-id="1906">args</td><td data-evernote-id="1907">list</td><td data-evernote-id="1908">["--enable-logs", "-n", "15"]</td><td data-evernote-id="1909">arguments given to your app when it is launched</td></tr><tr data-evernote-id="1910"><td data-evernote-id="1911">node_args</td><td data-evernote-id="1912">list</td><td data-evernote-id="1913">["--harmony", "--max-stack-size=1024"]</td><td data-evernote-id="1914">arguments given to node when it is launched</td></tr><tr data-evernote-id="1915"><td data-evernote-id="1916">cwd</td><td data-evernote-id="1917">string</td><td data-evernote-id="1918">"/var/www/app/prod"</td><td data-evernote-id="1919">the directory from which your app will be launched</td></tr><tr data-evernote-id="1920"><td data-evernote-id="1921">exec_mode</td><td data-evernote-id="1922">string</td><td data-evernote-id="1923">"cluster"</td><td data-evernote-id="1924">"fork" mode is used by default, "cluster" mode can be configured with instances field</td></tr><tr data-evernote-id="1925"><td data-evernote-id="1926">instances</td><td data-evernote-id="1927">number</td><td data-evernote-id="1928">4</td><td data-evernote-id="1929">number of instances for your clustered app, 0 means as much instances as you have CPU cores. a negative value means CPU cores - value (e.g -1 on a 4 cores machine will spawn 3 instances)</td></tr><tr data-evernote-id="1930"><td data-evernote-id="1931">exec_interpreter</td><td data-evernote-id="1932">string</td><td data-evernote-id="1933">"node"</td><td data-evernote-id="1934">defaults to "node". can be "python", "ruby", "bash" or whatever interpreter you wish to use. "none" will execute your app as a binary executable</td></tr><tr data-evernote-id="1935"><td data-evernote-id="1936">log_date_format</td><td data-evernote-id="1937">string</td><td data-evernote-id="1938">"YYYY-MM-DD HH:mm Z"</td><td data-evernote-id="1939">format in which timestamps will be displayed in the logs</td></tr><tr data-evernote-id="1940"><td data-evernote-id="1941">error_file</td><td data-evernote-id="1942">string</td><td data-evernote-id="1943">"/var/log/node-app/node-app.stderr.log"</td><td data-evernote-id="1944">path to the specified error log file. PM2 generates one by default if not specified and you can find it by typing pm2 desc &lt;app id&gt;</td></tr><tr data-evernote-id="1945"><td data-evernote-id="1946">out_file</td><td data-evernote-id="1947">string</td><td data-evernote-id="1948">"/var/log/node-app/node-app.stdout.log"</td><td data-evernote-id="1949">path to the specified output log file. PM2 generates one by default if not specified and you can find it by typing pm2 desc &lt;app id&gt;</td></tr><tr data-evernote-id="1950"><td data-evernote-id="1951">pid_file</td><td data-evernote-id="1952">string</td><td data-evernote-id="1953">"pids/node-geo-api.pid"</td><td data-evernote-id="1954">path to the specified pid file. PM2 generates one by default if not specified and you can find it by typing pm2 desc &lt;app id&gt;</td></tr><tr data-evernote-id="1955"><td data-evernote-id="1956">merge_logs</td><td data-evernote-id="1957">boolean</td><td data-evernote-id="1958">false</td><td data-evernote-id="1959">defaults to false. if true, it will merge logs from all instances of the same app into the same file</td></tr><tr data-evernote-id="1960"><td data-evernote-id="1961">cron_restart</td><td data-evernote-id="1962">string</td><td data-evernote-id="1963">"1 0 * * *"</td><td data-evernote-id="1964">a cron pattern to restart your app. only works in "cluster" mode for now. soon to be avaible in "fork" mode as well</td></tr><tr data-evernote-id="1965"><td data-evernote-id="1966">watch</td><td data-evernote-id="1967">boolean</td><td data-evernote-id="1968">true</td><td data-evernote-id="1969">enables the watch feature, defaults to "false". if true, it will restart your app everytime a file change is detected on the folder or subfolder of your app.</td></tr><tr data-evernote-id="1970"><td data-evernote-id="1971">ignore_watch</td><td data-evernote-id="1972">list</td><td data-evernote-id="1973">["[\/\\]\./", "node_modules"]</td><td data-evernote-id="1974">list of regex to ignore some file or folder names by the watch feature</td></tr><tr data-evernote-id="1975"><td data-evernote-id="1976">min_uptime</td><td data-evernote-id="1977">number</td><td data-evernote-id="1978">1000</td><td data-evernote-id="1979">min uptime of the app to be considered started (i.e. if the app crashes in this time frame, the app will only be restarted the number set in max_restarts (default 15), after that it's errored)</td></tr><tr data-evernote-id="1980"><td data-evernote-id="1981">max_restarts</td><td data-evernote-id="1982">number</td><td data-evernote-id="1983">10</td><td data-evernote-id="1984">number of consecutive unstable restarts (less than 1sec interval or custom time via min_uptime) before your app is considered errored and stop being</td></tr><tr data-evernote-id="1985"><td data-evernote-id="1986">max_memory_restart</td><td data-evernote-id="1987">string</td><td data-evernote-id="1988">"150M"</td><td data-evernote-id="1989">your app will be restarted by PM2 if it exceeds the amount of memory specified. human-friendly format : it can be "10M", "100K", "2G" and so on...</td></tr><tr data-evernote-id="1990"><td data-evernote-id="1991">env</td><td data-evernote-id="1992">object</td><td data-evernote-id="1993">{"NODE_ENV": "production", "ID": "42"}</td><td data-evernote-id="1994">env variables which will appear in your app</td></tr><tr data-evernote-id="1995"><td data-evernote-id="1996">autorestart</td><td data-evernote-id="1997">boolean</td><td data-evernote-id="1998">false</td><td data-evernote-id="1999">true by default. if false, PM2 will not restart your app if it crashes or ends peacefully</td></tr><tr data-evernote-id="2000"><td data-evernote-id="2001">vizion</td><td data-evernote-id="2002">boolean</td><td data-evernote-id="2003">false</td><td data-evernote-id="2004">true by default. if false, PM2 will start without vizion features (versioning control metadatas)</td></tr><tr data-evernote-id="2005"><td data-evernote-id="2006">post_update</td><td data-evernote-id="2007">list</td><td data-evernote-id="2008">["npm install", "echo launching the app"]</td><td data-evernote-id="2009">a list of commands which will be executed after you perform a Pull/Upgrade operation from Keymetrics dashboard</td></tr><tr data-evernote-id="2010"><td data-evernote-id="2011">force</td><td data-evernote-id="2012">boolean</td><td data-evernote-id="2013">true</td><td data-evernote-id="2014">defaults to false. if true, you can start the same script several times which is usually not allowed by PM2</td></tr><tr data-evernote-id="2015"><td data-evernote-id="2016">next_gen_js</td><td data-evernote-id="2017">boolean</td><td data-evernote-id="2018">true</td><td data-evernote-id="2019">defaults to false. if true, PM2 will launch your app using embedded BabelJS features which means you can run ES6/ES7 javascript code</td></tr><tr data-evernote-id="2020"><td data-evernote-id="2021">restart_delay</td><td data-evernote-id="2022">number</td><td data-evernote-id="2023">4000</td><td data-evernote-id="2024">time to wait before restarting a crashed app (in milliseconds). defaults to 0.</td></tr></tbody></table>

