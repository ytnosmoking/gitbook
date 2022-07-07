
安装 commitizen
=============

`sudo npm install -g commitizen`  
或  
`sudo cnpm install -g commitizen`

package.json
============

如果没有 package.json 文件, 先生成 package.json 文件 ：  
`npm init --yes`

初始化
===

`commitizen init cz-conventional-changelog --save --save-exact`

提交
==

`git add .`  
`git commit` 改为 `git cz`  
执行后出现这个界面表示已经安装成功了  
![](https://img-blog.csdnimg.cn/b03376e353a24d2eac2a4dc53a0ed7ee.png?x-oss-process=image/watermark,type_ZHJvaWRzYW5zZmFsbGJhY2s,shadow_50,text_Q1NETiBA6aOY6YC46ICF5omT556M552h,size_20,color_FFFFFF,t_70,g_se,x_16)

安装中文包
=====

执行命令  
`npm i cz-conventional-changelog-zh`  
或  
`cnpm i cz-conventional-changelog-zh`

修改 package.json 配置

```
"config": {
    "commitizen": {
      "path": "./node_modules/cz-conventional-changelog"
    }
  }

```

```
"config": {
    "commitizen": {
       "path": "./node_modules/cz-conventional-changelog-zh"
    }
  }

```

将 path 的`./node_modules/cz-conventional-changelog`修改为`./node_modules/cz-conventional-changelog-zh`

再次执行提交 git cz 界面将会变成这个样子  
![](https://img-blog.csdnimg.cn/5fe2205230a347a3a6db927ddd97d7bb.png?x-oss-process=image/watermark,type_ZHJvaWRzYW5zZmFsbGJhY2s,shadow_50,text_Q1NETiBA6aOY6YC46ICF5omT556M552h,size_13,color_FFFFFF,t_70,g_se,x_16)

添加中文标签
======

修改 package.json 文件  
添加配置

```
"defaultType":"[新增功能]",
	   "types": {
	    "[新增功能]": {
          "description": "新增功能点、新增需求",
          "title": "Features"
        },
        "[Bug修复]": {
          "description": "修复Bug,线上，测试，验收阶段的bug",
          "title": "Bug Fixes"
        },
        "[文档修改]": {
          "description": "文档增删改",
          "title": "Documentation"
        },
        "[样式修改]": {
          "description": "样式修改(空白、格式、缺少分号等)",
          "title": "Styles"
        },
        "[代码重构]": {
          "description": "既不修复bug也不添加新功能的更改",
          "title": "Code Refactoring"
        },
        "[性能优化]": {
          "description": "性能优化",
          "title": "Performance Improvements"
        },
        "[测试代码]": {
          "description": "增加测试",
          "title": "Tests"
        },
        "[编译代码]": {
          "description": "影响构建系统或外部依赖项的更改(示例范围:gulp、broccoli、npm)",
          "title": "Builds"
        },
        "[持续集成]": {
          "description": "对CI配置文件和脚本的更改(示例范围:Travis, Circle, BrowserStack, SauceLabs)",
          "title": "Continuous Integrations"
        },
        "[其他提交]": {
          "description": "除src目录或测试文件以外的修改",
          "title": "Chores"
        },
        "[回退更改]": {
          "description": "回退历史版本",
          "title": "Reverts"
        },
        "[修改冲突]": {
          "description": "修改冲突",
          "title": "Conflict"
        },
        "[字体修改]": {
          "description": "字体文件更新",
          "title": "Fonts"
        },
        "[删除文件]": {
          "description": "删除文件",
          "title": "Delete Files"
        },
        "[暂存文件]": {
          "description": "暂存文件",
          "title": "Stash Files"
        }
      }

```

添加后的 package.json 为

```
{
  "name": "gitcommittest",
  "version": "1.0.0",
  "description": "",
  "main": "index.js",
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1"
  },
  "author": "",
  "license": "ISC",
  "devDependencies": {
    "cz-conventional-changelog": "^3.3.0"
  },
  "config": {
    "commitizen": {
      "path": "./node_modules/cz-conventional-changelog-zh",
	  "defaultType":"[新增功能]",
	   "types": {
	    "[新增功能]": {
          "description": "新增功能点、新增需求",
          "title": "Features"
        },
        "[Bug修复]": {
          "description": "修复Bug,线上，测试，验收阶段的bug",
          "title": "Bug Fixes"
        },
        "[文档修改]": {
          "description": "文档增删改",
          "title": "Documentation"
        },
        "[样式修改]": {
          "description": "样式修改(空白、格式、缺少分号等)",
          "title": "Styles"
        },
        "[代码重构]": {
          "description": "既不修复bug也不添加新功能的更改",
          "title": "Code Refactoring"
        },
        "[性能优化]": {
          "description": "性能优化",
          "title": "Performance Improvements"
        },
        "[测试代码]": {
          "description": "增加测试",
          "title": "Tests"
        },
        "[编译代码]": {
          "description": "影响构建系统或外部依赖项的更改(示例范围:gulp、broccoli、npm)",
          "title": "Builds"
        },
        "[持续集成]": {
          "description": "对CI配置文件和脚本的更改(示例范围:Travis, Circle, BrowserStack, SauceLabs)",
          "title": "Continuous Integrations"
        },
        "[其他提交]": {
          "description": "除src目录或测试文件以外的修改",
          "title": "Chores"
        },
        "[回退更改]": {
          "description": "回退历史版本",
          "title": "Reverts"
        },
        "[修改冲突]": {
          "description": "修改冲突",
          "title": "Conflict"
        },
        "[字体修改]": {
          "description": "字体文件更新",
          "title": "Fonts"
        },
        "[删除文件]": {
          "description": "删除文件",
          "title": "Delete Files"
        },
        "[暂存文件]": {
          "description": "暂存文件",
          "title": "Stash Files"
        }
      }
    }
  }
}


```

再次运行 git cz 显示的界面  
![](https://img-blog.csdnimg.cn/00bad885e9a8490995bdd1fa6dca5b3e.png)