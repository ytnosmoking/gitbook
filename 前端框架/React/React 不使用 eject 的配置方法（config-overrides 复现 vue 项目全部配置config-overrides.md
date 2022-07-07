> 本文由 [简悦 SimpRead](http://ksria.com/simpread/) 转码， 原文地址 [blog.csdn.net](https://blog.csdn.net/qq_21567385/article/details/108383083)

基础依赖
----

暴露全部配置 eject 十分不友好，我们基于 customize-cra 和 react-app-rewired 进行自定义配置：

```
	yarn add -D customize-cra react-app-rewired

```

之后修改 `package.json` 的 `scripts` 部分：

```
"scripts": {
    "start": "react-app-rewired start",
    "build": "react-app-rewired build",
    "test": "react-app-rewired test",
    "_eject": "react-scripts eject"
  },

```

注意前三个命令只是把原来的 `react-scripts` 替换为了 `react-app-rewired` ，最后 eject 为了安全我加了下划线（你也可以不修改最后一行 eject ）。

下面就可以开始自定义配置了。

config-overrides.js
-------------------

根目录下建立一个配置重写文件 `config-overrides.js` ，刚刚安装的依赖就会注入 react 内帮我们 override 相应的配置。

### 总体把握

我们开一个新项目，使用 eject 暴露所有配置，会发现根目录下生成了 `config` 目录，下面有 react 的所有配置文件：

![](https://img-blog.csdnimg.cn/20200903150406205.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzIxNTY3Mzg1,size_16,color_FFFFFF,t_20)

很多教程都只讲如何配置 `webpack.config.js` ，那其他文件怎么配置呢？

#### 自定义配置 react 打包生成目录

在 `config-overrides.js` 写入如下内容：

```
const path = require('path')

function resolve(dir) {
  return path.join(__dirname, dir)
}

module.exports = {
  paths: function (paths) {
    paths.appBuild = resolve('./dist')
    return paths
  }
}

```

1.  先导入了 `path` 依赖并写了 `resolve()` 函数用来补全路径，`path.resolve()` 这个函数也可以补全，不过在 `('/a', '/b')` 情况下，只有 `path.join()` 是可以补全为 `/a/b` 的。
    
2.  之后导出我们要重写的配置对象，键就是你要重写的配置文件名，要重写 `paths.js` ，那就是 `paths` 这个键下进行重写。
    

之后 build 打包生成的内容就会在 `./dist` 下而不是默认的 `./build` 下。

#### 查看所有 paths.js 配置

如果你要查看所有 `paths.js` 的配置，第一种方法你重开一个 react 项目使用 eject 去查看有什么选项，第二种方法你在里面打印即可：

```
module.exports = {
  paths: function (paths) {
    paths.appBuild = resolve('./dist')
	console.log(paths)
    return paths
  }
}

```

我们执行 `yarn start` 就可以看到所有配置了：

![](https://img-blog.csdnimg.cn/20200903151626315.png)

这些配置和 eject 暴露全部配置后生成的 `paths.js` 是一样的：

![](https://img-blog.csdnimg.cn/20200903151730205.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzIxNTY3Mzg1,size_16,color_FFFFFF,t_30)

### 配置 webpack

根据上面的经验，我们配置 webpack 只需要如下写法即可：

```
module.exports = {
  webpack: override()
}

```

下面几个例子简单说明。

#### 配置路径 @ 快捷前缀

在 customize-cra 里给我们提供了一些封装好的 api ，我们直接使用就可以：

```
const {
  override,
  addWebpackAlias
} = require('customize-cra')

const path = require('path')

function resolve(dir) {
  return path.join(__dirname, dir)
}

module.exports = {
  webpack: override(
    addWebpackAlias({
      '@': resolve('src')
    })
}

```

这里使用了 `addWebpackAlias()` 这个 api ，十分方便。

完整 api 请查看：[官方 api 文档](https://github.com/arackaf/customize-cra/blob/master/api.md)

#### 配置 less 编译器

先安装基本依赖：

```
	yarn add -D less less-loader react-app-rewire-less react-app-rewire-less-modules

```

之后配置 `config-overrides.js` ：

```
const {
  override,
  addWebpackAlias
} = require('customize-cra')

const path = require('path')

function resolve(dir) {
  return path.join(__dirname, dir)
}

module.exports = {
  webpack: override(
    addLessLoader()
}

```

这样就可以打开 less-loader 了。

##### 在 less 中添加全局变量

如果我们直接在项目入口 `index.jsx` 或 `app.jsx` 导入 `.less` 是不能识别到定义的变量的（样式可以），我们要在 less-loader 选项中导入全局资源：

```
module.exports = {
  webpack: override(
    addLessLoader({
      additionalData: `@import "${ resolve('./src/assets/css/variable.less') }";`
    })
}

```

官方对 `addLessLoader()` 这个 api 的参数定义是 loaderOptions ，也就是说里面可以传 less-loader 的配置对象。

less-loader 可配置项：[webpack-contrib / less-loader](https://github.com/webpack-contrib/less-loader)

注：正如 vue-cli 在 [css 相关](https://cli.vuejs.org/zh/guide/css.html#%E5%90%91%E9%A2%84%E5%A4%84%E7%90%86%E5%99%A8-loader-%E4%BC%A0%E9%80%92%E9%80%89%E9%A1%B9) 所说，该 `@import "...";` 导入语句结尾必须要有分号！

#### 查看所有 webpack 配置

customize-cra 给我们提供的 api 不多，但是如同之前配置 `paths.js` 所说，我们可以用一个函数配置全部 webpack 的配置：

```
const fs = require('fs')

module.exports = {
  webpack: override(
    (config) => {
      if (process.env.NODE_ENV === "production") {
      	// 进行生产环境的配置
      }
      // 打印配置
      console.log(config)
      // 输出到文件（有些对象内部配置没法在控制台显示）
	  fs.writeFileSync(`./config-${process.env.NODE_ENV}.json`, JSON.stringify(config))
    }
  )
}

```

注：该函数只能传入一次。

下面说几个实用配置。

#### 随心所欲配置法

如果你在上面一步中将 `config` 打印到了控制台，你会发现插件都无法显示内部配置：

![](https://img-blog.csdnimg.cn/20200903154704655.png)

但是输出到文件会发现，丢失了插件名字，成了一个个对象：

![](https://img-blog.csdnimg.cn/20200903154951694.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzIxNTY3Mzg1,size_16,color_FFFFFF,t_70)

好心的 OptimizeCssAssetsWebpackPlugin 还给我们准备了插件说明，但是 TerserPlugin 却只是一个配置对象，没有任何说明，我们也不知道哪个对象是哪个插件的。

我们可以使用构造函数名字解决这个问题：

```
/**
 * @param target: 要遍历的对象
 * @param name: 插件名
 * @param callback: 回调函数，第一个参数为该插件对象
 * @return null
 */
function invade(target, name, callback) {
  target.forEach(
    item => {
      if (item.constructor.name === name) {
        callback(item)
      }
    }
  )
}

```

##### 生产环境去除 console.log

有了上面的 `invade()` 函数，我们可以这样写：

```
module.exports = {
  webpack: override(
    (config) => {
      if (process.env.NODE_ENV === "production") {
      	invade(config.optimization.minimizer, 'TerserPlugin', (e) => {
      	  // 去除 LICENSE.txt
          e.options.extractComments = false
          // 去除生产环境 console.log
          e.options.terserOptions.compress.drop_console = true
        })
      }
    }
  )
}

```

##### 关闭 sourceMap

react 官方很好心的给我们准备了这个环境变量，在 eject 后的 `webpack.config.js` 可以看到：

![](https://img-blog.csdnimg.cn/20200903160109170.png)

在根目录建立 `.env.production` ：

```
GENERATE_SOURCEMAP = false

```

##### 关闭生产环境 devtool

```
module.exports = {
  webpack: override(
    (config) => {
      if (process.env.NODE_ENV === "production") {
      	config.devtool = false;
    }
  )
}

```

##### 漂亮的打包 js/css 文件名

默认打包后文件名带 `.chunk` 结尾，去掉即可：

```
module.exports = {
  webpack: override(
    (config) => {
      if (process.env.NODE_ENV === "production") {
      	// 美化打包后 js 文件名
      	config.output.chunkFilename = config.output.chunkFilename.replace('.chunk', '')
      	// 美化打包后 css 文件名
      	invade(config.plugins, 'MiniCssExtractPlugin', (e) => {
          e.options.chunkFilename = e.options.chunkFilename.replace('.chunk', '')
        })
    }
  )
}

```

##### runtime 内联策略

有关 runtime 为何要内联，简单的说就是避免几 K 的文件还要单独加载一次，提高加载速度，你可以查找一些其他资料深入学习。

需要说的一点是，react 官方给我们提供了 `process.env.INLINE_RUNTIME_CHUNK` 选项，但是他不会配合 babel ，生成的 runtime 内联到 `index.html` 后仍然在 `js` 文件夹下生成，这是不友好的。

我们使用 script-ext-html-webpack-plugin ：

```
	yarn add -D script-ext-html-webpack-plugin

```

配置：

```
const ScriptExtHtmlWebpackPlugin = require('script-ext-html-webpack-plugin')

module.exports = {
  webpack: override(
    (config) => {
      if (process.env.NODE_ENV === "production") {
      	config.plugins.push(
          new ScriptExtHtmlWebpackPlugin(
          {
            // `runtime` must same as runtimeChunk name. default is `runtime`
            inline: /runtime\..*\.js$/
          })
        )
		// 单一整合 runtime
		config.optimization.runtimeChunk = 'single'
    }
  )
}

```

注：不知道有没有细心的人会疑惑，customize-cra 给我们提供了 `addWebpackPlugin()` 的快捷 api 啊，为啥还要 push ，这里不详细说明了，有兴趣可以去查一下该 api 的代码，也是做了 `config.push()` ，在我们自定义的 `(config) => { }` 函数里用了是不生效的，因为没有 `config` 对象给他了，只能在外面用。

外面怎么用？

```
module.exports = {
  webpack: override(
  	process.env.NODE_ENV === "production" ? addWebpackPlugin(new ScriptExtHtmlWebpackPlugin(...)) : null
  )
}

```

应该没有人会这么用。

之后再打包就会发现，runtime 内联到了 `index.html` ，并且在 `js` 文件夹下不再生成了。

##### 打包 splitChunks 分块策略		

```javascript
 splitChunks: {
      chunks: 'async', //指定代码分割样式 async异步 initial同步 all所有
      minSize: 30000, //指定执行分割代码的最小大小，默认为30000字节(30kb)，所以如果需要打包的文件小于30kb的不进行打包
      maxSize: 0, //限制打包的空间大小,比如某个打包文件为1Mb，maxSize设为100kb，那他的打包文件就会想方设法将打包文件分成每份为100kb或以下进行拆分打包，一般用默认配置即可，以后业务需要用到的话再单独设置
      minChunks: 1, //该参数就是命令行中每次导包都可以看到的打包参数Chunks
      maxAsyncRequests: 5,// 指定入口文件中最大打包的异步代码数，默认5
      maxInitialRequests: 3,//指定入口文件中最大打包的同步代码数，默认3
      automaticNameDelimiter: '~', // 指定生成默认的命名时之间的连接符，如符合vendors规则打包的，生成的打包文件名就是vendors~main.js
      name: true,
      cacheGroups: { //缓存组，当符合上面配置时会记录在缓存组中，然后进入里面的规则对号入座进行打包输出,如果相同的出口的则会一起打包在一起，比如当前有两个第三方插件都符合vendors，则他们都会一同打包输出 
        vendors: { //符合在node_modules中的第三方插件库引入的，命名为vendors~xxx.
          test: /[\\/]node_modules[\\/]/,
          priority: -10
        },
        default: { //不符合在node_modules中的第三方插件库引入的，命名为default~xxx.
          minChunks: 2,
          priority: -20, //区分当同时符合vendors和default的，进行优先级处理，值越大优先级越高
          reuseExistingChunk: true //检测模块是否被打包过，如果是则直接使用导包过的模块即可，缓存复用性
        }
      }
    }
  }
```



这里直接把 vue 的搬过来：

```

module.exports = {
  webpack: override(
    (config) => {
      if (process.env.NODE_ENV === "production") {
      	config.optimization.splitChunks = {
          chunks: 'all',
          cacheGroups: {
            libs: {
              name: 'chunk-libs',
              test: /[\\/]node_modules[\\/]/,
              priority: 10,
              chunks: 'initial' // only package third parties that are initially dependent
            },
            commons: {
              name: 'chunk-commons',
              test: resolve('src/components'), // can customize your rules
              minChunks: 3, //  minimum common number
              priority: 5,
              reuseExistingChunk: true
            }
          }
        }
    }
  )
}

```

非常易懂，不详细说明了。

##### prefetch 策略

在预加载和懒加载上也有一定的学问，可以先学习这篇文章：

[《[译] React 16.6 懒加载 (与预加载) 组件》](https://juejin.im/post/6844903753200451592)

在 webpack 4 中这么用即可：

```
() => import(/* webpackPrefetch: true */ 
                  "./pages/home")

```

有关 preload 请参考 [这里](https://github.com/webpack/webpack/issues/7920) ，不需要 preload 。

#### 其他

能参照 vue 进行的优化配置还有很多，比如 svg 的配置，自行参照搬过来即可。

还有两个没有说到：

1.  我如何知道 react 内置了什么插件：请打印 `config.plugins`
2.  react 打包后路由块的文件名不好看：请配置 `webpackChunkName` ：
    
    ```
    () => import(/* webpackChunkName: "home" */
                                  "./pages/home")
    
    ```
    
    之后就会打包出来 `home.contenthash.js` 。

总结
--

本文全部配置如下：

```
const {
  override,
  addLessLoader,
  addWebpackAlias
} = require('customize-cra')

// const fs = require('fs')

const path = require('path')

const ScriptExtHtmlWebpackPlugin = require('script-ext-html-webpack-plugin')


/**
 * @param target: 要遍历的对象
 * @param name: 插件名
 * @param callback: 回调函数，第一个参数为该插件对象
 * @return null
 */
function invade(target, name, callback) {
  target.forEach(
    item => {
      if (item.constructor.name === name) {
        callback(item)
      }
    }
  )
}

function resolve(dir) {
  return path.join(__dirname, dir)
}

module.exports = {
  paths: function (paths) {
    paths.appBuild = resolve('./dist')
    return paths
  },
  webpack: override(
    addWebpackAlias({
      '@': resolve('src'),
    }),
    addLessLoader({
      additionalData: `@import "${ resolve('./src/assets/css/variable.less') }";`
    }),

    (config) => {
      if (process.env.NODE_ENV === "production") {
        config.devtool = false;

        config.output.chunkFilename = config.output.chunkFilename.replace('.chunk', '')

        invade(config.optimization.minimizer, 'TerserPlugin', (e) => {
          e.options.extractComments = false
          e.options.terserOptions.compress.drop_console = true
        })
        invade(config.plugins, 'MiniCssExtractPlugin', (e) => {
          e.options.chunkFilename = e.options.chunkFilename.replace('.chunk', '')
        })

        config.optimization.splitChunks = {
          chunks: 'all',
          cacheGroups: {
            libs: {
              name: 'chunk-libs',
              test: /[\\/]node_modules[\\/]/,
              priority: 10,
              chunks: 'initial' // only package third parties that are initially dependent
            },
            commons: {
              name: 'chunk-commons',
              test: resolve('src/components'), // can customize your rules
              minChunks: 3, //  minimum common number
              priority: 5,
              reuseExistingChunk: true
            }
          }
        }

        config.plugins.push(
          new ScriptExtHtmlWebpackPlugin(
          {
            // `runtime` must same as runtimeChunk name. default is `runtime`
            inline: /runtime\..*\.js$/
          })
        )

        config.optimization.runtimeChunk = 'single'

      }

      // fs.writeFileSync(`./config-${process.env.NODE_ENV}.json`, JSON.stringify(config))

      return config
    }
  )
}

```

这不是一个完美的配置，还有一些细节和 svg 内联没有追究，有时间可以自行参照配一下，但基本上复现了在 vue 中我们的配置。

[《vue-cli 创建项目后优化更多配置（一）》](https://blog.csdn.net/qq_21567385/article/details/107603286)

[《vue-cli 创建项目后优化更多配置（二）》](https://blog.csdn.net/qq_21567385/article/details/107634781)

[《vue-cli 创建项目后优化更多配置（三）》](https://blog.csdn.net/qq_21567385/article/details/107673723)