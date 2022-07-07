> 本文由 [简悦 SimpRead](http://ksria.com/simpread/) 转码， 原文地址 [www.cnblogs.com](https://www.cnblogs.com/chunshan-blog/p/12632141.html)

安装log4js
--------

`npm install --save log4js`

新增配置文件
------

根目录下新建config目录 conifg目录下全为配置文件

config目录下 新建文件 logs.js

```
var path = require('path');

//日志根目录
var baseLogPath = path.resolve(__dirname, '../logs')

/*报错输出日志*/
//错误日志目录、文件名、输出完整路径
var errorPath = "/error";
var errorFileName = "error";
var errorLogPath = baseLogPath + errorPath + "/" + errorFileName;

/*请求数据得到响应时输出响应日志*/
//响应日志目录、文件名、输出完整路径
var responsePath = "/response";
var responseFileName = "response";
var responseLogPath = baseLogPath + responsePath + "/" + responseFileName;

/*操作数据库进行增删改等敏感操作记录日志*/
//操作日志目录、文件名、输出完整路径
var handlePath = "/handle";
var handleFileName = "handle";
var handleLogPath = baseLogPath + handlePath + "/" + handleFileName;


module.exports = {
    //日志格式等设置
    appenders:
        {
            "rule-console": {"type": "console"},
            "errorLogger": {
                "type": "dateFile",
                "filename": errorLogPath,
                "pattern": "-yyyy-MM-dd-hh.log",
                "alwaysIncludePattern": true,
                "encoding": "utf-8",
                "maxLogSize": 1000,
                "numBackups": 3,
                "path": errorPath
            },
            "resLogger": {
                "type": "dateFile",
                "filename": responseLogPath,
                "pattern": "-yyyy-MM-dd-hh.log",
                "alwaysIncludePattern": true,
                "encoding": "utf-8",
                "maxLogSize": 1000,
                "numBackups": 3,
                "path": responsePath
            },
            "handleLogger": {
                "type": "dateFile",
                "filename": handleLogPath,
                "pattern": "-yyyy-MM-dd-hh.log",
                "alwaysIncludePattern": true,
                "encoding": "utf-8",
                "maxLogSize": 1000,
                "numBackups": 3,
                "path": responsePath
            },
        },
    //供外部调用的名称和对应设置定义
    categories: {
        "default": {"appenders": ["rule-console"], "level": "all"},
        "resLogger": {"appenders": ["resLogger"], "level": "info"},
        "errorLogger": {"appenders": ["errorLogger"], "level": "error"},
        "handleLogger": {"appenders": ["handleLogger"], "level": "all"},
        "http": {"appenders": ["resLogger"], "level": "info"}
    },
    "baseLogPath": baseLogPath
} 
```

增加工具方法
------

新建 utils 目录， utils 目录下放置工具类方法

utils 下新建 logs.js 放置输出日志的工具方法

```
var log4js = require('log4js');
var logsConfig = require('../config/logs.js');
//加载配置文件
log4js.configure(logsConfig);
//调用预先定义的日志名称
var resLogger = log4js.getLogger("resLogger");
var errorLogger = log4js.getLogger("errorLogger");
var handleLogger = log4js.getLogger("handleLogger");
var consoleLogger = log4js.getLogger();

// 格式化日志文本 加上日志头尾和换行方便查看 ==>  普通日志、请求日志、响应日志、操作日志、错误日志
var formatText = {
    info: function(info) {
        var logText = new String();
        //响应日志头信息
        logText += "\n" + "***************info log start ***************" + "\n";
        //响应内容
        logText += "info detail: " + "\n" + JSON.stringify(info) + "\n";
        //响应日志结束信息
        logText += "*************** info log end ***************" + "\n";
        return logText;
    },
    request: function(req, resTime) {
        var logText = new String();
        var method = req.method;
        //访问方法
        logText += "request method: " + method + "\n";
        //请求原始地址
        logText += "request originalUrl:  " + req.originalUrl + "\n";
        //客户端ip
        logText += "request client ip:  " + req.ip + "\n";
        //开始时间
        var startTime;
        //请求参数
        if (method === 'GET') {
            logText += "request query:  " + JSON.stringify(req.query) + "\n";
            // startTime = req.query.requestStartTime;
        } else {
            logText += "request body: " + "\n" + JSON.stringify(req.body) + "\n";
            // startTime = req.body.requestStartTime;
        }
        //服务器响应时间
        logText += "response time: " + resTime + "\n";
        return logText;
    },
    response: function(ctx, resTime) {
        var logText = new String();
        //响应日志开始
        logText += "\n" + "*************** response log start ***************" + "\n";
        //添加请求日志
        logText += formatText.request(ctx.request, resTime);
        //响应状态码
        logText += "response status: " + ctx.status + "\n";
        //响应内容
        logText += "response body: " + "\n" + JSON.stringify(ctx.body) + "\n";
        //响应日志结束
        logText += "*************** response log end ***************" + "\n";
        return logText;
    },
    handle: function(info) {
        var logText = new String();
        //响应日志开始
        logText += "\n" + "***************info log start ***************" + "\n";
        //响应内容
        logText += "handle info detail: " + "\n" + JSON.stringify(info).replace(/\\n/g, "\n") + "\n";
        //响应日志结束
        logText += "*************** info log end ***************" + "\n";
        return logText;
    },
    error: function(ctx, err, resTime) {
        var logText = new String();
        //错误信息开始
        logText += "\n" + "*************** error log start ***************" + "\n";
        //添加请求日志
        logText += formatText.request(ctx.request, resTime);
        //错误名称
        logText += "err name: " + err.name + "\n";
        //错误信息
        logText += "err message: " + err.message + "\n";
        //错误详情
        logText += "err stack: " + err.stack + "\n";
        //错误信息结束
        logText += "*************** error log end ***************" + "\n";
        return logText;
    }
}

module.exports = {
    //封装普通日志
    logInfo: function(info) {
        if (info) {
            consoleLogger.info(formatText.info(info));
        }
    },
    //封装响应日志
    logResponse: function(ctx, resTime) {
        if (ctx) {
            resLogger.info(formatText.response(ctx, resTime));
        }
    },
    //封装操作日志
    logHandle: function(res) {
        if (res) {
            handleLogger.info(formatText.handle(res));
        }
    },
    //封装错误日志
    logError: function(ctx, error, resTime) {
        if (ctx && error) {
            errorLogger.error(formatText.error(ctx, error, resTime));
        }
    }
}; 
```

改造app.js
--------

```
// logger
const logsUtil = require('./utils/logs.js');
app.use(async (ctx, next) => {
    const start = new Date();					          // 响应开始时间
    let intervals;								              // 响应间隔时间
    try {
        await next();
        intervals = new Date() - start;
        logsUtil.logResponse(ctx, intervals);	  //记录响应日志
    } catch (error) {
        intervals = new Date() - start;
        logsUtil.logError(ctx, error, intervals);//记录异常日志
    }
}) 
```

参考资源：  
[koa添加日志管理模块](https://www.cnblogs.com/HoChine/p/10717831.html)