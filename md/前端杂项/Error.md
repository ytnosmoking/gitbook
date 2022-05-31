## Error

### 一般处理

#### Window.onerror= ()=>{}

处理 一般类型错误 

#### windonw.addEventlister('error',()=>{})

 由于一些资源类型请求出错 如 image 回给自己的onerror事件。并且不回冒泡 这个时候 可以用这个

#### 原生Fetch 请求错误

​     监听不为200 的错误 可以去做拦截处理

#### axios请求错误

#### promise 为处理catch的方法

 window.addEventlistener（"unhandledrejection",()=>{}）



### React 项目错误处理

#### ErrorBundary处理 要包裹子组件

componentDidCatch (err) {} 



### 不同域名下js错误

 客户端 设置额 <script cross-origin="anonymous"></script>

服务端 静态资源设置响应头 Access-Control-Allow-Origin: *



### Fed-monitor-sdk

