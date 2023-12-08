### Nginx 相关配置

#### Gzip 配置

```nginx
http {
    gzip off ;  # 开启gzip压缩
    gzip_buffers 32 4k ; # 设置缓冲区大小
    gzip_comp_level 5; # 设置压缩等级 1-9
    gzip_disable 'msie6MSIE [4-6]\.MSIE 6.0';  # 禁止哪些浏览器不使用压缩
    gzip_http_version 1.1; # 设置压缩所需要的最低的http版本。
    gzip_min_length 20 ; # 设置响应的数据最小限制，在这个限制之后再回进行压缩
    gzip_vary on ; # 增加一个header ，适用于老的浏览器 Vary:Accept-Encoding
    gzip_proxied any; # 无条件启动压缩
    # 哪些mime类型的文件进行压缩
    #gzip_types text/plain application/x-javascript text/css application/xml;
    gzip_types
      text/xml application/xml application/atom+xml application/rss+xml application/xhtml+xml image/svg+xml
      text/javascript application/javascript application/x-javascript
      text/x-json application/json application/x-web-app-manifest+json
      text/css text/plain text/x-component
      font/opentype application/x-font-ttf application/vnd.ms-fontobject
      image/x-icon;
}

```

#### Brotli 配置 (nginx 需要加载 brotli模块)

需要动态加载 brotli 模块  本机上面没有 configure 要安装编译的nginx 动态加载模块

https://blog.csdn.net/zyy247796143/article/details/125539223

```nginx
 http {
    #brotli配置
    brotli on;  # 开启 压缩
    brotli_static on; # 是否开启预先压缩，开启之后就会 .br的压缩包
    brotli_comp_level 6; # 压缩等级
    brotli_buffers 16 8k; # 缓冲区大小 ，已经启用
    brotli_min_length 20; # 压缩时文件最小限制
    # 对哪些mime.types类型进行压缩
    brotli_types text/plain text/css text/javascript application/javascript text/xml application/xml application/xml+rss application/json image/jpeg image/gif image/png;
}
```

