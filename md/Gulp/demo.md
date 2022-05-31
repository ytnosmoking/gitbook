# 使用

## node npm 使用

  1. 查看当前目录下安装的模块 npm ls
  2. 查看所有全局安装的模块 npm ls -g
  3. npm install package 安装到当前目录下的node_modules
  4. npm install -g package 全局安装
  5. 会安装到C:\Users\LEO(电脑名)\AppData\Roaming\npm\node_modules
  6. 注意:
  7. windows 平台 安装时会自动生成node_modules文件夹
  8. Mac及Linux平台 需要手动创建node_modules文件夹 否则模块会安装到磁盘根节点
  9. 因为相关包都在国外服务器，安装速度一般比较慢 所以可以考虑使用淘宝镜像,使用方法:在正常安装命令后面加上--registry=<https://registry.npm.taobao.org>
  10. 例如:npm install jquery --registry=<https://registry.npm.taobao.org>

## gulp 使用 **gulp: 一种构建工具**

  1. 安装:
  2. 先全局安装 gulp
  3. npm install -g gulp
  4. 局部安装 相关依赖   npm install gulp --save-dev

  5. 使用:
    1. 在当前目录下创建一个gulpfile.js文件
    2. gulp 只是一个载体，只实现需要处理什么文件，保存到哪个地方等功能，具体的处理方法需要其他包或插件去完成
    3. 使用gulp需要在gulpfile文件中引入gulp,类似如在html文件中使用js文件一样需要引入js文件

      ``` javascript
        var gulp = require('gulp');
        // 创建任务，在gulpfile文件中书写代码
        gulp.task('任务名',function(){
            // 需要处理的任务
        })
        //在当前目录下打开命令行窗口 使用 gulp 任务名执行任务，例如任务名是test
        gulp test
      ```

  6. gulp 本身是一个平台，完成任务需要安装其他插件，插件搜索平台:gulpjs.com/plugins 或者 npmjs.com/package/plugins

## 使用gulp合并代码

1. 安装代码合并插件 gulp-concat
2. npm install gulp-concat --registry=<https://registry.npm.taobao.org>
3. 在gulpfile中引入gulp-concat
  
  ``` javascript  
    var concat = require('gulp-concat');
    创建合并任务

    合并src目录下所有js文件
    gulp.task('cat',function(){
    确定合并哪些文件 需要合并文件的目录
    gulp.src('./src/*.js')
    使用gulp-concat合并 指定合并后文件的名字
    .pipe(concat('bundle.js'))
    // 将处理好的文件保存在dist文件夹中
    .pipe(gulp.dest('./dist'));
    })

     // 合并src下指定js文件而且可以指定合并顺序 
     gulp.task('cat',function(){
         // 确定合并哪些文件 需要合并文件的目录
         gulp.src([
             './src/3.js',
             './src/2.js',
             './src/1.js'
         ])
         // 使用gulp-concat合并 指定合并后文件的名字
        .pipe(concat('bundle.js'))
        // 将处理好的文件保存在dist文件夹中
        .pipe(gulp.dest('./dist'));
    })
  ```

## 使用gulp压缩代码

1. 安装代码压缩插件 gulp-uglify
2. npm install gulp-uglify --registry=<https://registry.npm.taobao.org>
3. 在gulpfile中引入gulp-concat

  ``` javascript

      var press = require('gulp-uglify');
      //创建压缩任务

      gulp.task('press',function(){
          // 需要压缩的文件目录 *代表当前目录下所有js文件 也可以指定文件名
          gulp.src('./dist/*.js')
          // 压缩函数press
          .pipe(press())
          // 输出至output目录
          .pipe(gulp.dest('./output'));
      })

  ```
