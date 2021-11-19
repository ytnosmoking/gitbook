## Vue 项目 优化 开发 生产

### package.json 添加指令

```javascript
scripts:{
	...,
	"dll": "webpack -p --progress --config ./webpack.dll.conf.js"
}
```

### 开发阶段 dev

#### 处理静态资源  类似 element-ui axios vue全家桶

```javascript
webpack.dll.conf.js

const path = require('path')
const webpack = require('webpack')
const CleanWebpackPlugin = require('clean-webpack-plugin')

// dll文件存放的目录
const dllPath = 'public/vendor'

module.exports = {
  entry: {
    // 需要提取的库文件
    // vendor: [
    //   'vue/dist/vue.common.js',
    //   'vue-router/dist/vue-router.common.js',
    //   'vuex/dist/vuex.common.js',
    //   'element-ui',
    //   'axios', 'qs', 'nprogress']
    vendor: ['vue', 'vue-router', 'vuex', 'axios', 'element-ui', 'qs', 'nprogress']
   
    // vendor: ['axios', 'qs', 'nprogress'],
 // 也可以把部分模块集中化处理   
    // entry: {
    //      vue: ['vue', 'vuex', 'vue-router'], // vue全家桶dll: vue.dll.js
    //    ec: ['echarts', 'echarts-wordcloud'], // echarts相关dll: ec.dll.js
    //  commons: [
    // 其他第三方库: commons.dll.js
    // ]
    // }
  },
  output: {
    path: path.join(__dirname, dllPath),
    filename: '[name].dll.js',
    // vendor.dll.js中暴露出的全局变量名
    // 保持与 webpack.DllPlugin 中名称一致
    library: '[name]_[hash]'
  },
  plugins: [
    // 清除之前的dll文件
    new CleanWebpackPlugin(['*.*'], {
      root: path.join(__dirname, dllPath)
    }),
    // 设置环境变量
    new webpack.DefinePlugin({
      'process.env': {
        NODE_ENV: 'production'
      }
    }),
    // manifest.json 描述动态链接库包含了哪些内容
    new webpack.DllPlugin({
      path: path.join(__dirname, dllPath, '[name]-manifest.json'),
      // 保持与 output.library 中名称一致
      name: '[name]_[hash]',
      context: process.cwd()
    })
  ]
}

```

#### 在vue.config.js 处理这些静态资源 不再项目里面进行打包 这里 没有做动动态打包引入打包的那种操作

```javascript
const webpack = require('webpack')
const plugins =[]
plugins.push(
  new webpack.DllReferencePlugin({
      context: process.cwd(),
      manifest: require('./public/vendor/${name}-manifest.json')
    })
)
const cdn = {
  dev: {
    css: [
      'https://cdn.bootcdn.net/ajax/libs/normalize/8.0.1/normalize.min.css',
      'https://cdn.bootcdn.net/ajax/libs/element-ui/2.13.2/theme-chalk/index.css'
    ],
    js: [
      '/vendor/vendor.dll.js'
      // 'https://cdn.bootcdn.net/ajax/libs/element-ui/2.13.2/index.js'
    ]
  },
  build: {
    css: [
      'https://cdn.bootcdn.net/ajax/libs/animate.css/4.1.1/animate.min.css',
      'https://cdn.bootcdn.net/ajax/libs/nprogress/0.2.0/nprogress.min.css',
      'https://cdn.bootcdn.net/ajax/libs/element-ui/2.13.2/theme-chalk/index.css',
      'https://cdn.bootcdn.net/ajax/libs/normalize/8.0.1/normalize.min.css'
    ],
    js: [
      'https://cdn.bootcdn.net/ajax/libs/vue/2.6.10/vue.min.js',
      'https://cdn.bootcss.com/vue-router/3.0.6/vue-router.min.js',
      'https://cdn.bootcss.com/vuex/3.1.1/vuex.min.js',
      'https://cdn.bootcdn.net/ajax/libs/axios/0.20.0/axios.min.js',
      'https://cdn.bootcdn.net/ajax/libs/nprogress/0.2.0/nprogress.min.js',
      'https://cdn.bootcdn.net/ajax/libs/element-ui/2.13.2/index.js',
      'https://cdn.bootcdn.net/ajax/libs/qs/6.9.4/qs.min.js'

    ]
  }
}
module.exports={
  ...,
  chainWebpack(config) {
      config.plugin('html').tap(args => {
     // 这里是为了 将那些静态资源引入到html中去   
      if (isDev) {
        args[0].cdn = cdn.dev
      } else {
        args[0].cdn = cdn.build
      }
      return args
    })
  },
  configureWebpack:{
  plugins
}
}
```

```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width,initial-scale=1.0" />
    <link rel="icon" href="<%= BASE_URL %>favicon.ico" />
    <title>demo1</title>
    <% for (var i in
    htmlWebpackPlugin.options.cdn&&htmlWebpackPlugin.options.cdn.css) { %>
    <link
      href="<%= htmlWebpackPlugin.options.cdn.css[i] %>"
      rel="preload"
      as="style"
    />
    <link href="<%= htmlWebpackPlugin.options.cdn.css[i] %>" rel="stylesheet" />
    <% } %>
  </head>
  <body>
    <noscript>
      <strong
        >We're sorry but demo1 doesn't work properly without JavaScript enabled.
        Please enable it to continue.</strong
      >
    </noscript>
    <div id="app">
      <!-- shell -->
    </div>
    <% for (var i in
    htmlWebpackPlugin.options.cdn&&htmlWebpackPlugin.options.cdn.js) { %>
    <script src="<%= htmlWebpackPlugin.options.cdn.js[i] %>"></script>
    <% } %>
    <!-- built files will be auto injected -->
  </body>
</html>

```

### 生产阶段 pro

#### vue.config.js  externals处理

```javascript
// 控制cdn 外链
const externals = {
  'vue': 'Vue',
  'vue-router': 'VueRouter',
  'vuex': 'Vuex',
  'axios': 'axios',
  'nprogress': 'NProgress',
  // 'element-ui': 'ElementUI'
  'element-ui': 'ELEMENT',
  'qs': 'Qs'
}
module.exports ={
   chainWebpack(config) {
      config.plugin('html').tap(args => {
     // 这里是为了 将那些静态资源引入到html中去   
      if (isDev) {
        args[0].cdn = cdn.dev
      } else {
        args[0].cdn = cdn.build
      }
      return args
    })
  },
  configureWebpack:{
    externals: isDev?{}:externals
  }
}
```



### **后续**

1. 静态资源有添加更改只需要配置好一次 提前打包静态话处理 后续 都不会需要打包进项目文件 缩短开发时项目启动 跟新慢的问题

2. 有些UI插件 类似 normalize.css animate.css 可以直接丢在cdn上 或者丢在公司的服务器 给个链接

3. 有些UI框架库 类似 antd-design-vue 配不好外链的externals 也可以打包成静态文件丢在服务器上 

4. 附加学习 

   https://segmentfault.com/a/1190000020485804

5.  Hard-source-webpack-plugin 类似最优解。但是如果为了减少静态三分文件 也可以先 dll处理后 打包开发 一面每次跟行app.bundle 过大 

   目的： 所以第三方不更新的插件静态话 开发页面 引入2次以上合包（利用webpack.splitChunks） 如果第三方包（类似 normalize.css vue其他） 在一定大小情况下可以打包进自己的app.js 减少页面请求也行

## 完整用列

```javascript

const path = require('path')
const webpack = require('webpack')
const BundleAnalyzerPlugin = require('webpack-bundle-analyzer').BundleAnalyzerPlugin
const CompressionPlugin = require('compression-webpack-plugin') // Gzip  只用在 开发阶段

// eslint-disable-next-line
const { SkeletonPlugin } = require('page-skeleton-webpack-plugin')

// eslint-disable-next-line
const pageSkeleton = new SkeletonPlugin({
  pathname: path.resolve(__dirname, './shell'), // 用来存储 shell 文件的地址
  staticDir: path.resolve(__dirname, './dist'), // 最好和 `output.path` 相同
  routes: ['/', '/login', '/act'], // 将需要生成骨架屏的路由添加到数组中
  port: '8988'
})

const isDev = process.env.NODE_ENV === 'development'
const plugins = []
// plugins.push(pageSkeleton)
const gzip = new CompressionPlugin({ // 文件开启Gzip，也可以通过服务端(如：nginx)(https://github.com/webpack-contrib/compression-webpack-plugin)
  filename: '[path].gz[query]',
  algorithm: 'gzip',
  test: new RegExp('\\.(' + ['js', 'css'].join('|') + ')$'),
  threshold: 8192,
  minRatio: 0.8
})
if (!isDev) {
  plugins.push(new BundleAnalyzerPlugin())
  plugins.push(gzip)
}
if (isDev) {
  plugins.push(new BundleAnalyzerPlugin())
  plugins.push(
    new webpack.DllReferencePlugin({
      context: process.cwd(),
      manifest: require('./public/vendor/vendor-manifest.json')
    })
  )
}

const cdn = {
  dev: {
    css: [
      'https://cdn.bootcdn.net/ajax/libs/normalize/8.0.1/normalize.min.css',
      'https://cdn.bootcdn.net/ajax/libs/element-ui/2.13.2/theme-chalk/index.css'
    ],
    js: [
      '/vendor/vendor.dll.js'
      // 'https://cdn.bootcdn.net/ajax/libs/element-ui/2.13.2/index.js'
    ]
  },
  build: {
    css: [
      'https://cdn.bootcdn.net/ajax/libs/animate.css/4.1.1/animate.min.css',
      'https://cdn.bootcdn.net/ajax/libs/nprogress/0.2.0/nprogress.min.css',
      'https://cdn.bootcdn.net/ajax/libs/element-ui/2.13.2/theme-chalk/index.css',
      'https://cdn.bootcdn.net/ajax/libs/normalize/8.0.1/normalize.min.css'
    ],
    js: [
      'https://cdn.bootcdn.net/ajax/libs/vue/2.6.10/vue.min.js',
      'https://cdn.bootcss.com/vue-router/3.0.6/vue-router.min.js',
      'https://cdn.bootcss.com/vuex/3.1.1/vuex.min.js',
      'https://cdn.bootcdn.net/ajax/libs/axios/0.20.0/axios.min.js',
      'https://cdn.bootcdn.net/ajax/libs/nprogress/0.2.0/nprogress.min.js',
      'https://cdn.bootcdn.net/ajax/libs/element-ui/2.13.2/index.js',
      'https://cdn.bootcdn.net/ajax/libs/qs/6.9.4/qs.min.js'

    ]
  }
}

// 控制cdn 外链
const externals = {
  'vue': 'Vue',
  'vue-router': 'VueRouter',
  'vuex': 'Vuex',
  'axios': 'axios',
  'nprogress': 'NProgress',
  // 'element-ui': 'ElementUI'
  'element-ui': 'ELEMENT',
  'qs': 'Qs'
}
console.log(require('os').cpus().length)
module.exports = {
  productionSourceMap: false,
  // 构建时开启多进程处理 babel 编译
  // parallel: require('os').cpus().length > 1,
  devServer: {
    open: false,

    proxy: {
      '/isDev': {
        target: 'http://whrdd.f3322.net:28889',
        changeOrigin: true,
        ws: true, // proxy websockets
        pathRewrite: {
          '^/isDev': ''
        }
      },
      '/isTest': {
        target: 'http://whrdd.f3322.net:60091',
        changeOrigin: true,
        ws: true, // proxy websockets
        pathRewrite: {
          '^/isTest': ''
        }
      }
    }
  },
  chainWebpack(config) {
    // 移除 prefetch 插件
    config.plugins.delete('prefetch')
    // 移除 preload 插件
    config.plugins.delete('preload')

    config
      .when(process.env.NODE_ENV !== 'development',
        config => {
          config
            .optimization.splitChunks({
              chunks: 'all',
              cacheGroups: {
                libs: {
                  name: 'chunk-libs',
                  test: /[\\/]node_modules[\\/]/,
                  priority: 10,
                  chunks: 'initial' // only package third parties that are initially dependent
                },
                // elementUI: {
                //   name: 'chunk-elementUI', // split elementUI into a single package
                //   priority: 20, // the weight needs to be larger than libs and app or it will be packaged into libs or app
                //   test: /[\\/]node_modules[\\/]_?element-ui(.*)/ // in order to adapt to cnpm
                // },
                commons: {
                  name: 'chunk-commons',
                  test: path.resolve(__dirname, 'src/components'),
                  minChunks: 3, //  minimum common number
                  priority: 5,
                  reuseExistingChunk: true
                }
              }
            })
          // https://webpack.js.org/configuration/optimization/#optimizationruntimechunk
          config.optimization.runtimeChunk('single')
        }
      )

    config.plugin('html').tap(args => {
      if (isDev) {
        args[0].cdn = cdn.dev
      } else {
        args[0].cdn = cdn.build
      }
      return args
    })
    if (!isDev) {
      config.plugin('html').tap(opts => {
        opts[0].minify.removeComments = false
        return opts
      })
    }
  },

  configureWebpack: {
    plugins,
    externals: isDev ? {} : externals
  }
}

```

