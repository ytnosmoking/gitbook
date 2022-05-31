# MAC 破解wifi

## 确保有安装macports 没有先去装macports

### airport

1. #### airport -s  查看附近wifi 源 截取要获取的wifi CHANNEL

2. 嗅探 airport en0 sniff channel 监听你要获取wifi 频道 需要sudo


### Aircrack-ng

#### 安装

1. sudo port selfupdate (twice)
2. sudo port install aircrack-ng
3. 1,2不行的情况下 可以。brew install aircrack-ng 如果有问题 看brew link aircrack-ng。此时 如果报sbin 不存在。手动创建一个存在的 sbin 目录 。

#### 查看

1. 查看文件 aircrack-ng   *.cp 文件 找到 有handshake的 序列

2. 破解 aircrack-ng -w *.txt(字典文件)*.cp     enter后输入序列

3. 如果找不到 多找几个字典 继续爆破
   + <https://blog.csdn.net/qq_39498701/article/details/104262468?utm_medium=distribute.pc_relevant_t0.none-task-blog-BlogCommendFromBaidu-1.control&amp;depth_1-utm_source=distribute.pc_relevant_t0.none-task-blog-BlogCommendFromBaidu-1.control>
   + <https://blog.csdn.net/Neo_Lost/article/details/91890103>
   + <https://www.jianshu.com/p/67c0277fd5bc>
   + <https://www.cnblogs.com/djjv/p/10837542.html>
