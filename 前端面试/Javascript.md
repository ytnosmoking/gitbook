### Javascript

#### get请求传参长度的误区

- **误解：HTTP 协议下的 Get 请求参数长度是有大小限制的，最大不能超过XX，而 Post 是无限制的。**

  1、首先即使有长度限制，也是限制的是**整个 URI 长度**，**而不仅仅是你的参数值数据长度**。

  2、HTTP 协议从未规定 GET/POST 的请求长度限制是多少。

  3、所谓的请求长度限制是由**浏览器**和 **web 服务器**决定和设置的，各种浏览器和 web 服务器的设定
  均不一样，这依赖于各个浏览器厂家的规定或者可以根据 web 服务器的处理能力来设定。

#### get和post请求在缓存方面的区别

- get请求类似于查找的过程，用户获取数据，可以不用每次都与数据库连接，所以可以使用缓存。
- post不同，post做的一般是修改和删除的工作，所以必须与数据库交互，所以不能使用缓存。因此get请求适合于请求缓存。

####  闭包

- 一句话可以概括：闭包就是能够读取其他函数内部变量的函数，或者子函数在外调用，子函数所在的父函数的作用域不会被释放。闭包是定义在一个函数内部可访问该函数内部局部变量的函数，作用就是让函数外部可以访问函数内部局部变量。

#### [类的创建和继承](https://www.cnblogs.com/ranyonsue/p/11201730.html)

```javascript
//创建
function FuncA() {}
function Func() {}
继承
//原型链继承
//特点：基于原型链，既是父类的实例，也是子类的实例。
//缺点：不能实现多继承。
FuncA.prototype = new Func()
FuncA.prototype.constructor = FuncA

//构造继承
//特点：可以实现多继承。
//缺点：只能实现继承父类的属性和方法，不能继承原型链上的属性和方法。
function FuncA() {
  Func.call(this)
}

//组合继承
//相当于构造继承和原型链继承的组合体。通过调用父类构造，继承父类的属性并保留传参的优点，然后通过将父类实例作为子类原型，实现函数复用。
//缺点：调用了两次父类构造函数，生成了两份实例。
function FuncA() {
  Func.call(this)
}
FuncA.prototype = new Func()
FuncA.prototype.constructor = FuncA

//寄生组合继承


var f = new FuncA()
```

#### 如何解决异步回调地狱

- async/await
- promise
- generator

#### 前端中的事件流 

- 事件流的3个阶段，即顺序：
  事件捕获阶段
  处于目标阶段
  事件冒泡阶段

  ```
  dom.addEventlistener(event, cb,bool)
  event = 'click'|... 事件
  cb = function(){}
  bool = true(捕获阶段触发)｜false('冒泡阶段')
  ```

  

#### 图片的懒加载和预加载

- 预加载：提前加载图片，当用户需要查看时可直接从本地缓存中渲染。
  - 原理：事先把网页的图片记载到本地，之后就直接到缓存中拿图片
- 懒加载：懒加载的主要目的是作为服务器前端的优化，减少请求数或延迟请求数。
  - 场景：对于图片过多的页面，为了加快页面加载速度，需要将页面内未出现的可视区域内的图片先不做加载，等到滚动可视区域后再去加载。
    原理：img标签的src属性用来表示图片的URL，当这个属性值不为空时，浏览器就会根据这个值发送请求，如果没有src属性就不会发送请求。所以，在页面加入时将img标签的src指向为空或者指向一个小图片（loading或者缺省图），将真实地址存在一个自定义属性data-src中，当页面滚动时，将可视区域的图片的src值赋为真实的值。
- 两种技术的本质：两者的行为是相反的，一个是提前加载，一个是迟缓甚至不加载。懒加载对服务器前端有一定的缓解压力作用，预加载 则会增加服务器前端压力。

#### mouseover和mouseenter的区别

- 二者的本质区别在于,mouseenter不会冒泡,简单的说,它不会被它本身的子元素的状态影响到.但是mouseover就会被它的子元素影响到,在触发子元素的时候,mouseover会冒泡触发它的父元素.(想要阻止mouseover的冒泡事件就用mouseenter)
- 共同点:当二者都没有子元素时,二者的行为是一致的,但是二者内部都包含子元素时,行为就不同了.

#### Javascript中new()到底做了些什么？new操作原理

1. (1) 创建一个新对象；
2. (2) 将构造函数的作用域赋给新对象（因此 this 就指向了这个新对象） ；
3. (3) 执行构造函数中的代码（为这个新对象添加属性） ；
4. (4) 返回新对象。

#### call bind apply 的 区别

- 三者都可以改变函数的this对象指向。

- 三者第一个参数都是this要指向的对象，如果如果没有这个参数或参数为undefined或null，则默认指向全局window。

- 三者都可以传参，但是apply是数组，而call是参数列表，且apply和call是一次性传入参数，而bind可以分为多次传入。

- bind 是返回绑定this之后的函数，便于稍后调用；apply 、call 则是立即执行。

  ```javascript
  简易版
  
  Function.prototype.bind=function () {
     var _this=this;
     var context=arguments[0];
     var arg=[].slice.call(arguments,1);
     return function(){
       arg=[].concat.apply(arg,arguments);
       _this.apply(context,arg);
     }
   };
  完美版
  
  //实现bind方法
   Function.prototype.bind = function(oThis) {
     if (typeof this !== 'function') {
       // closest thing possible to the ECMAScript 5
       // internal IsCallable function
       throw new TypeError('Function.prototype.bind - what is trying to be bound is not callable');
     }
     var aArgs = Array.prototype.slice.call(arguments, 1),
     fToBind = this,
     fNOP = function() {},
     fBound = function() {
       // this instanceof fBound === true时,说明返回的fBound被当做new的构造函数调用
       return fToBind.apply(this instanceof fBound
       ? this
       : oThis,
       // 获取调用时(fBound)的传参.bind 返回的函数入参往往是这么传递的
       aArgs.concat(Array.prototype.slice.call(arguments)));
     };
     // 维护原型关系
     if (this.prototype) {
       // 当执行Function.prototype.bind()时, this为Function.prototype 
       // this.prototype(即Function.prototype.prototype)为undefined
       fNOP.prototype = this.prototype; 
     }
   // 下行的代码使fBound.prototype是fNOP的实例,因此
   // 返回的fBound若作为new的构造函数,new生成的新对象作为this传入fBound,新对象的__proto__就是fNOP的实例
   fBound.prototype = new fNOP();
  	 return fBound;
   };
   var arr=[1,11,5,8,12];
   var max=Math.max.bind(null,arr[0],arr[1],arr[2],arr[3]);
   console.log(max(arr[4])); //12
  ```

  

#### clientHeight, scrollHeight,offsetHeight,scrollTop,offsetTop,clientTop

- clientHeight：包括padding但不包括border、水平滚动条、margin的元素的高度。对于inline的元素这个属性一直是0，单位px，只读元素
- offsetHeight：包括padding、border、水平滚动条，但不包括margin的元素的高度。对于inline的元素这个属性一直是0，单位px，只读元素

1. **clientHeight**: 可理解为内部可视区高度，样式的height+上下padding
2. **scrollHeight**: 内容的实际高度+上下padding（如果没有限制div的height，即height是自适应的，一般是scrollHeight==clientHeight）
3. **offsetHeight**:可理解为div的可视高度，样式的height+上下padding+上下border-width。
4. **clientTop**: 容器内部相对于容器本身的top偏移，实际就是 上border-width （div1是10px，div2是20px）
5. **scrollTop**: Y轴的滚动条没有，或滚到最上时，是0；y轴的滚动条滚到最下时是 scrollHeight-clientHeight（很好理解）
6. **offsetTop**: 容器到其包含块顶部的距离，粗略的说法可以理解为其父元素。 offsetTop = top + margin-top + border-top


#### [JS拖拽功能的实现](https://www.cnblogs.com/psxiao/p/11547834.html)

#### [异步加载js的方法](https://blog.csdn.net/shan1991fei/article/details/79395216)

1. HTML5中新增的属性，Chrome、FF、IE9&IE9+均支持（IE6~8不支持）。此外，这种方法不能保证脚本按顺序执行

   ```javascript
   (function(){
       var scriptEle = document.createElement("script");
       scriptEle.type = "text/javasctipt";
       scriptEle.async = true;
       scriptEle.src = "http://cdn.bootcss.com/jquery/3.0.0-beta1/jquery.min.js";
       var x = document.getElementsByTagName("head")[0];
       x.insertBefore(scriptEle, x.firstChild);        
    })();
   ```

2. window.onload

   ```javascript
   (function(){
       if(window.attachEvent){
           window.attachEvent("load", asyncLoad);
       }else{
           window.addEventListener("load", asyncLoad);
       }
       var asyncLoad = function(){
           var ga = document.createElement('script'); 
           ga.type = 'text/javascript'; 
           ga.async = true; 
           ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js'; 
           var s = document.getElementsByTagName('script')[0]; 
           s.parentNode.insertBefore(ga, s);
       }
   )();
   ```

3. ```
    <script>标签的defer="defer"属性 点评：兼容所有浏览器。此外，这种方法可以确保所有设置defer属性的脚本按顺序执行。
   ```

4. Ajax 加载后 eval 内容

#### Ajax解决浏览器缓存问题

1. 禁止浏览器缓存功能有如下几种方法：

2. 在ajax发送请求前加上 anyAjaxObj.setRequestHeader("If-Modified-Since","0")。
3. 在ajax发送请求前加上 anyAjaxObj.setRequestHeader("Cache-Control","no-cache")。
4. 在URL后面加上一个随机数："fresh=" + Math.random();。
5. 在URL后面加上时间搓："nowtime=" + new Date().getTime();。
6. 如果是使用jQuery，直接这样就可以了$.ajaxSetup({cache:false})。这样页面的所有ajax都会执行这条语句就是不需要保存缓存记录。

#### JS节流和防抖

1. 函数防抖：将几次操作合并为一此操作进行。原理是维护一个计时器，规定在delay时间后触发函数，但是在delay时间内再次触发的话，就会取消之前的计时器而重新设置。这样一来，只有最后一次操作能被触发。

   ```javascript
   function debounce(fn,delay){
       let timer = null //借助闭包
       return function() {
           if(timer){
               clearTimeout(timer) 
           }
           timer = setTimeout(fn,delay) // 简化写法
       }
   }
   ```

   

2. 函数节流：使得一定时间内只触发一次函数。原理是通过判断是否到达一定时间来触发函数。

   ```javascript
   function throttle(fn,delay){
       let valid = true
       return function() {
          if(!valid){
              //休息时间 暂不接客
              return false 
          }
          // 工作时间，执行函数并且在间隔期内把状态位设为无效
           valid = false
           setTimeout(() => {
               fn()
               valid = true;
           }, delay)
       }
   }
   /* 请注意，节流函数并不止上面这种实现方案,
      例如可以完全不借助setTimeout，可以把状态位换成时间戳，然后利用时间戳差值是否大于指定间隔时间来做判定。
      也可以直接将setTimeout的返回的标记当做判断条件-判断当前定时器是否存在，如果存在表示还在冷却，并且在执行fn之后消除定时器表示激活，原理都一样
       */
   
   ```

   

3. 区别： 函数节流不管事件触发有多频繁，都会保证在规定时间内一定会执行一次真正的事件处理函数，而函数防抖只是在最后一次事件后才触发一次函数。 比如在页面的无限加载场景下，我们需要用户在滚动页面时，每隔一段时间发一次 Ajax 请求，而不是在用户停下滚动页面操作时才去请求数据。这样的场景，就适合用节流技术来实现。

#### [JS垃圾回收机制](https://www.cnblogs.com/sunhuahuaa/p/7655587.html)

#### [前端模块化](https://www.cnblogs.com/jiaxiaozia/p/13803800.html)

1. 好处：避免变量污染，命名冲突

   提高代码复用率

   提高维护性

   依赖关系的管理

2. 规范：CommonJs AMD CMD ES6

   - CommonJS规范主要用于服务端编程，加载模块是同步的，这并不适合在浏览器环境，因为同步意味着阻塞加载，浏览器资源是异步加载的，因此有了AMD CMD解决方案。

   - AMD规范在浏览器环境中异步加载模块，而且可以并行加载多个模块。不过，AMD规范开发成本高，代码的阅读和书写比较困难，模块定义方式的语义不顺畅。

   - CMD规范与AMD规范很相似，都用于浏览器编程，依赖就近，延迟执行，可以很容易在Node.js中运行。不过，依赖SPM 打包，模块的加载逻辑偏重

   - ES6 在语言标准的层面上，实现了模块功能，而且实现得相当简单，完全可以取代 CommonJS 和 AMD 规范，成为浏览器和服务器通用的模块解决方案。

   - ```tex
     AMD与CMD区别
     总结如下：
     最明显的区别就是在模块定义时对依赖的处理不同。
     AMD推崇依赖前置 在定义模块的时候就有声明其依赖的模块
     CMD推崇就近依赖 只有在用到某模块的时候再去require
     AMD和CMD最大的区别是对依赖模块的执行时机处理不同，注意不是加载的时机或者方式不同。
     
     很多人说requireJS是异步加载模块，SeaJS是同步加载模块，这么理解实际上是不准确的，其实加载模块都是异步的，只不过AMD依赖前置，js可以方便知道依赖模块是谁，立即加载，而CMD就近依赖，需要使用把模块变为字符串解析一遍才知道依赖了那些模块，这也是很多人诟病CMD的一点，牺牲性能来带来开发的便利性，实际上解析模块用的时间短到可以忽略。
     为什么我们说两个的区别是依赖模块执行时机不同，为什么很多人认为ADM是异步的，CMD是同步的（除了名字的原因。。。）
     同样都是异步加载模块，AMD在加载模块完成后就会执行改模块，所有模块都加载执行完后会进入require的回调函数，执行主逻辑，这样的效果就是依赖模块的执行顺序和书写顺序不一定一致，看网络速度，哪个先下载下来，哪个先执行，但是主逻辑一定在所有依赖加载完成后才执行。
     CMD加载完某个依赖模块后并不执行，只是下载而已，在所有依赖模块加载完成后进入主逻辑，遇到require语句的时候才执行对应的模块，这样模块的执行顺序和书写顺序是完全一致的。
     这也是很多人说AMD用户体验好，因为没有延迟，依赖模块提前执行了，CMD性能好，因为只有用户需要的时候才执行的原因。
     ```

     　

#### 深度克隆详解以及实现 用odash.cloneDeep

1. ```javascript
   1.
   function deepClone(obj) {
       let newObj = Array.isArray(obj) ? [] : {}
       if (obj && typeof obj === "object") {
           for (let key in obj) {
               if (obj.hasOwnProperty(key)) {
                   newObj[key] = (obj && typeof obj[key] === 'object') ? deepClone(obj[key]) : obj[key];
               }
           }
       } 
       return newObj
   }
   const newObj = deepClone(oldObj));
   
   2.自己内部资料
   function DeepClone(source) {
     // 判断目标是数组还是对象
     const targetObj = source.constructor === Array ? [] : {};
     for (let key in source) {
       if (source.hasOwnProperty(key)) {
         //   如果是对象就递归
         if (source[key] && typeof source[key] === 'object') {
           targetObj[key] = source[key].constructor === Array ? [] : {}
           targetObj[key] = DeepClone(source[key])
         } else {
           targetObj[key] = source[key]
         }
       }
     }
     return targetObj
   }
   ```

2. ```tex
   const newObj = JSON.parse(JSON.stringify(oldObj));
   如果obj里面有时间对象，则JSON.stringify后再JSON.parse的结果，时间将只是字符串的形式。而不是时间对象；
   如果obj里有RegExp、Error对象，则序列化的结果将只得到空对象；
   如果obj里有function，Symbol 类型，undefined，则序列化的结果会把函数或 undefined丢失；
   如果obj里有NaN、Infinity和-Infinity，则序列化的结果会变成null 
   JSON.stringify()只能序列化对象的可枚举的自有属性，例如 如果obj中的对象是有构造函数生成的， 则使用JSON.parse(JSON.stringify(obj))深拷贝后，会丢弃对象的constructor；
   ```

3. ```javascript
   function deepClone (obj) {
   	if (typeof obj !== 'object') {
   		return obj;
   	}
   	if (!obj) { // obj 是 null的情况
   		return obj;
   	}
   	if (obj instanceof  Date) {
   		return new Date(obj);
   	} 
   	if (obj instanceof  RegExp) {
   		return new RegExp(obj);
   	} 
   	if (obj instanceof  Function) {
   		return obj;
   	} 
   	let newObj；
   	if (obj instanceof Array) {
   		newObj = [];
   		for(let i = 0, len = obj.length; i < len; i++){
                  newObj.push(deepClone(obj[i]));
            }
            return newObj;
   	}
   	newObj = {};
   	for（let key in obj) {
   		if (obj.hasOwnProperty(key)) {
   			if (typeof obj[key] !== 'object') {
   				newObj[key] = obj[key];
   			} else {
   				newObj[key] = deepClone(obj[key]);
   			}
   		}
   	}
   	return newObj;
   }
   
   ```

   

#### 实现一个once函数 传入参数只执行一次

```javascript
function test(){
    alert('coinxu')
}
var once = (function(){
    var memo = {}, i = 0;
    return function(fn){
        for(var key in memo){
            //匿名函数支持
            if(memo[key].func === fn||memo[key].func.toString() ===fn.toString()){
                return memo[key].result
            }
        }
        i += 1
        var result = fn()
        memo[i] = {func:fn, result:result}
        return result
    }
})()
once(test)
once(test)
```

#### 将原生ajax封装成Promise

```javascript
   //原生ajax封装成promise
    function myAjax(method,url,params){
        this.state = 'FULFILLED'
        this.fulfillList = []
        this.rejectList = []
        ;(function(that){
            var data = null
            method = method.toUpperCase()
            if(typeof params == 'object'){
                var _arr = []
                for(var item in params){
                    _arr.push(item+"="+params[item])
                }
                params = _arr.join('&')
            }
            if(method === 'GET'){
                url +='?'+params
            }
            if(method === 'POST'){
                data = params
            }
            //start
            var xhr = new XMLHttpRequest()
            xhr.open(method,url)
            xhr.setRequestHeader('Content-type','appliction/x-www-form-urlencoded')
            xhr.addEventListener('readystatechange',function(){
                if(this.readyState !== 4)return;
                if(this.status !== 200)
                    reject({status:this.status,statusText:this.statusText})
                else
                    resolve(this.responseText)
            })
            xhr.send(data)
            //成功
            var resolve = function(data){
                that.state = 'FULFILLED'
                setTimeout(function () {
                    that.fulfillList.forEach(function (itemFn,key,arr) {
                        itemFn(data)
                        arr.shift()
                    })
                },0)
            }
            //失败，执行失败队列的函数
            var reject = function(data){
                that.state = 'REJECTED'
                setTimeout(function () {
                    that.rejectList.forEach(function (itemFn,key,arr) {
                        itemFn(data)
                        arr.shift()
                    })
                },0)
            }
        })(this)
    }
    //成功回调函数
    myAjax.prototype.done = function(handle){
        if(typeof handle === 'function')
            this.fulfillList.push(handle)
        else
            throw new Error('回调函数出错')
        return this
    }
    //失败回调函数
    myAjax.prototype.fail = function(handle){
        if(typeof handle === 'function')
            this.rejectList.push(handle)
        else
            throw new Error('回调函数出错')
        return this
    }
    //失败成功写在一个方法内
    myAjax.prototype.then = function(fulfill,reject){
        this.done(fulfill||function () {})
        .fail(reject||function(){})
        return this
    }

    //测试ajax
    var ajax = new myAjax('get','./time.php',{a:'123'})

    ajax.then(function(data){
        console.log(data)
    },function(data){
        console.log(data)
    }) 
```

#### js监听对象属性的改变

- Es5 

  ```javascript
  
  Object.defineProperty(user, 'name', {
      set : funtion(value){
                 name = value;
                  console.log('set: name:' + value)
          }
  })
  
  Object.defineProperties(obj,{
    a : {
          configurable: true, // 设置属性可以更改，默认为false
          set : function(value){}
    },      
     b : {
         configurable: true, // 设置属性可以更改，默认为false
          set : function(value){}
    }
  } 
  })
  ```

- Es6

  ```javascript
  funtion handle(){
     // 改写set方法，监听设置
      set: funtion(){},
      get: funtion(){}
  }
  
  let p = new Proxy({},handle) // 第一个参数为监听的对象，第二个参数为改写的方法
  ```

  

#### 如何实现一个私有变量，用getName方法可以访问，不能直接访问？

通过defineProperty来实现

```javascript
obj={
name:yuxiaoliang,
getName:function(){
return this.name
}
}
object.defineProperty(obj,"name",{
//不可枚举不可配置
});
```

```
function product(){
var name='yuxiaoliang';
this.getName=function(){
return name;
}
}
var obj=new product()
```



# [JS中==、===和Object.is()的区别](https://www.cnblogs.com/lindasu/p/7471519.html)

1. `==`：等同，比较运算符，两边值类型不同的时候，先进行类型转换，再比较；
2. `===`：恒等，严格比较运算符，不做类型转换，类型不同就是不等；
3. `Object.is()`是*ES6*新增的用来比较两个值是否严格相等的方法，与`===`的行为基本一致。
4. 先说`===`，这个比较简单，只需要利用下面的规则来判断两个值是否恒等就行了：
   1. 如果类型不同，就*不相等*
   2. 如果两个都是数值，并且是同一个值，那么相等； 
      1. 值得注意的是，如果两个值中至少一个是**NaN**，那么*不相等*（判断一个值是否是*NaN*，可以用`isNaN()`或`Object.is()`来判断）。
   3. 如果两个都是**字符串**，每个位置的字符都一样，那么*相等*；否则*不相等*。
   4. 如果两个值都是同样的**Boolean**值，那么*相等*。
   5. 如果两个值都引用同一个**对象或函数**，那么*相等*，即两个对象的**物理地址**也必须保持一致；否则*不相等*。
   6. 如果两个值都是**null**，或者都是**undefined**，那么*相等*。
5. 再说`Object.is()`，其行为与`===`基本一致，不过有两处不同：
   1. **+0**不等于**-0**。
   2. **NaN**等于自身。

#### setTimeout, setInterval 与 requestAnimationFrame

1. setTimeout(code, millseconds) 用于延时执行参数指定的代码，如果在指定的延迟时间之前，你想取消这个执行，那么直接用clearTimeout(timeoutId)来清除任务，timeoutID 是 setTimeout 时返回的；

2. setInterval(code, millseconds)用于每隔一段时间执行指定的代码，永无停歇，除非你反悔了，想清除它，可以使用 clearInterval(intervalId)，这样从调用 clearInterval 开始，就不会在有重复执行的任务，intervalId 是 setInterval 时返回的；

3. requestAnimationFrame(code)，一般用于动画，与 setTimeout 方法类似，区别是 setTimeout 是用户指定的，而 requestAnimationFrame 是浏览器刷新频率决定的，一般遵循 W3C 标准，它在浏览器每次刷新页面之前执行。

   ```
   requestAnimationFrame 使用一个回调函数作为参数，这个回调函数会在浏览器重绘之前调用。他返回一个整数，标识定时器的编号，这个值可以传递给 cancelAnimationFrame用于取消这个函数的执行。
   ```

   

#### 如何实现sleep的效果

1. Es5 

   ```javascript
   function sleep(numberMillis) { 
     var now = new Date(); 
     var exitTime = now.getTime() + numberMillis; 
     while (true) { 
     now = new Date(); 
     if (now.getTime() > exitTime) 
       return; 
     } 
   }
   //或
   var t = Date.now();
    
   function sleep(d){
   	while(Date.now - t <= d);
   } 
   sleep(1000);
   ```

   

2. es6

   ```javascript
   function sleep(ms) {
     return new Promise(resolve => setTimeout(resolve, ms));
   }
   
   async function demo() {
     console.log('Taking a break...');
     await sleep(2000);
     console.log('Two seconds later');
   }
   
   ```

   

#### [简单实现一个promise](https://github.com/xieranmaya/blog/issues/3)

[demo](https://blog.csdn.net/qq_34178990/article/details/81078906)

#### Function.proto(getPrototypeOf)是什么？

获取一个对象的原型，在chrome中可以通过*proto*的形式，或者在ES6中可以通过Object.getPrototypeOf的形式。

那么Function.proto是什么么？也就是说Function由什么对象继承而来，我们来做如下判别。

Function.**proto**==Object.prototype //false

Function.**proto**==Function.prototype//true

![这里写图片描述](https://img-blog.csdn.net/20180227132000898?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvbGl3dXNlbg==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

####  简单实现一个EventEmitter模块

```javascript
class EventEmitter{
   constructor(){
      this.handler={};
   }
   on(eventName,callback){
      if(!this.handles){
        this.handles={};
      }
      if(!this.handles[eventName]){
        this.handles[eventName]=[];
      }
      this.handles[eventName].push(callback);
   }
   emit(eventName,...arg){
       if(this.handles[eventName]){
     for(var i=0;i<this.handles[eventName].length;i++){
       this.handles[eventName][i](...arg);
     }
   }

   }
}
let event=new EventEmitter();
event.on('say',function(str){
   console.log(str);
});
event.emit('say','hello Jony yu');
```

#### typeOf

1. 可判断：undefined、数值、字符串、布尔值、function
   不可判断：null与object、array与object

2. instanceof 判断范围

   instanceof用于判断`对象`的具体类型。

   `对象`只有三种：函数、数组、对象。

3. ```javascript
   console.log(Object.prototype.toString.call(123));    //[object Number]
   console.log(Object.prototype.toString.call('123'));    //[object String]
   console.log(Object.prototype.toString.call(undefined));    //[object Undefined]
   console.log(Object.prototype.toString.call(true));    //[object Boolean]
   console.log(Object.prototype.toString.call({}));    //[object Object]
   console.log(Object.prototype.toString.call([]));    //[object Array]
   console.log(Object.prototype.toString.call(function(){}));    //[object Function]
   console.log(Object.prototype.toString.call(null));    //[[object Null]]
   ```

#### JS实现跨域

1. jsonp请求

2. CORS 

3. window.postMessage

4. domain.name

   

#### ES6数组去重  test=[1,1,1,2,2,3]

1. [...newSet(test)];

2. Array.from(new Set(test))

3. ```javascript
   function unique(arr) {
       const res = new Map();
       return arr.filter((a) => !res.has(a) && res.set(a, 1))
   }
   ```

4. ```javascript
   test = test.reduce((cur,next) => {
            if(cur.includes(next)){
              return cur
            }
    			 return [...cur,next]
      },[]);
   ```

   

#### [跨域是什么](https://blog.csdn.net/weixin_48509270/article/details/106985567)

跨域，是指浏览器不能执行其它网站的脚本。它是由浏览器的同源策略造成的，是浏览器对javascript实施的安全限制。

简单来讲，就是从地址A加载的页面，不能访问地址B的服务（如上图）。此时地址A与地址B不同源。

所谓同源，就是域名、协议、端口均相同。举个例子：

```
http://www.123.com/index.html 调用 http://www.123.com/abc.do （非跨域）
http://www.123.com/index.html 调用 http://www.456.com/abc.do （主域名不同:123/456，跨域）
http://abc.123.com/index.html 调用 http://def.123.com/server.do （子域名不同:abc/def，跨域）
http://www.123.com:8080/index.html 调用 http://www.123.com:8081/server.do（端口不同:8080/8081，跨域）
http://www.123.com/index.html 调用 https://www.123.com/server.do （协议不同:http/https，跨域）

```

#### js中不同数据类型之间的比较规则

```
{} == {} ：两个对象进行比较，比较的是堆内存的地址
null == undefined => true;
null===undefined => false
NaN == NaN => false ： NaN和谁都不相等
对象和字符串进行比较，是把对象toString()转换为字符串后再比较
剩余的所有数据类型不一样的情况：都是先转换为数字
（1）对象转数字：先转换为字符串，再转换为数字
（2）字符串转换为数字：只要出现非数字字符，结果就是NaN
（3）布尔转数字：true=>1 false=>0
（4）null转数字：0
（5）undefined转数字：NaN
```

#### this的指向问题

1. 作为函数调用，非严格模式下，this指向window，严格模式下，this指向undefined；
2. 作为某对象的方法调用，this通常指向调用的对象。
3. 使用apply、call、bind 可以绑定this的指向。
4. 在构造函数中，this指向新创建的对象
5. 箭头函数没有单独的this值，this在箭头函数创建时确定，它与声明所在的上下文相同。
   

#### js 暂时性死区

- 在代码块内，使用`let、const`命令声明变量之前，该变量都是不可用的。这在语法上，称为“暂时性死区”（temporal dead zone，简称 TDZ）。

#### vdom是什么？为什么存在？

1. 用js模拟dom结构。
2. dom发生变化的对比，放在js层做。
3. 提高重绘的性能

#### 怎么获得对象上的属性：比如说通过Object.key（）

```javascript
Object.defineProperty(obj, 'c', {
	value: 3,
	enumerable: false
})
```

1. enumerable设置为false，表示不可枚举，for…in循环、Object.keys()方法和JSON.stringify方法均访问不到该属性。
2. for key in  obj 如果过滤原型上的属性时，需要使用hasOwnProperty
3. Object.getOwnPropertyNames(obj) 
4. Object.keys(obj) 返回一个数组，包含对象所有的可枚举属性

#### Es6新特性

![img](https://pic4.zhimg.com/80/v2-b7be6584d9abff093cb5b177d675832f_720w.jpg)

#### js计算一年有多少周（星期天为第一天

```javascript
getDate(year) {
            // 一年第一天是周几
            var first = new Date(year,0,1).getDay()
            // 计算一年有多少天
            if((year % 4 == 0 && year % 100 != 0) || (year % 100 == 0 && year % 400 == 0)) {
                var allyears = 366
            }else {
                var allyears = 365
            }
            // 计算一年有多少周
            var week = parseInt((allyears + first) / 7)
            if(((allyears + first) % 7) != 0) {
                week += 1
            }
            return week
        }
```

#### 箭头函数与function区别

1. 箭头函数是匿名函数，不能作为构造函数，不能使用new
2. 箭头函数没有原型属性
3. 箭头函数不能当做Generator函数,不能使用yield关键字
4. 箭头函数不绑定arguments，取而代之用rest参数...解决
5. 箭头函数不绑定this，会捕获其所在的上下文的this值，作为自己的this值

#### [EventLoop](https://zhuanlan.zhihu.com/p/55511602)

- ##### **MacroTask（宏任务）**

  - `script`全部代码、`setTimeout`、`setInterval`、`setImmediate`（浏览器暂时不支持，只有IE10支持，具体可见`MDN`）、`I/O`、`UI Rendering`。

- ##### **MicroTask（微任务）**

  - `Process.nextTick（Node独有）`、`Promise`、`Object.observe(废弃)`、`MutationObserver`（具体使用方式查看[这里](https://link.zhihu.com/?target=https%3A//link.juejin.im/%3Ftarget%3Dhttp%3A%2F%2Fjavascript.ruanyifeng.com%2Fdom%2Fmutationobserver.html)）

- ##### **浏览器中的Event Loop**

  -  `Javascript` 有一个 `main thread` 主线程和 `call-stack` 调用栈(执行栈)，所有的任务都会被放到调用栈等待主线程执行。

- **JS调用栈** 		

  - JS调用栈采用的是后进先出的规则，当函数执行的时候，会被添加到栈的顶部，当执行栈执行完成后，就会从栈顶移出，直到栈内被清空。

- ##### **同步任务和异步任务**
  - `Javascript`单线程任务被分为**同步任务**和**异步任务**，同步任务会在调用栈中按照顺序等待主线程依次执行，异步任务会在异步任务有了结果后，将注册的回调函数放入任务队列中等待主线程空闲的时候（调用栈被清空），被读取到栈内等待主线程的执行。

- ##### **事件循环的进程模型**

  - 选择当前要执行的任务队列，选择任务队列中最先进入的任务，如果任务队列为空即`null`，则执行跳转到微任务（`MicroTask`）的执行步骤。

  - 将事件循环中的任务设置为已选择任务。

  - 执行任务。

  - 将事件循环中当前运行任务设置为null。

  - 将已经运行完成的任务从任务队列中删除。

  - microtasks步骤：进入microtask检查点。

    - 执行进入microtask检查点时，用户代理会执行以下步骤：

    - 设置microtask检查点标志为true。
    - 当事件循环`microtask`执行不为空时：选择一个最先进入的`microtask`队列的`microtask`，将事件循环的`microtask`设置为已选择的`microtask`，运行`microtask`，将已经执行完成的`microtask`为`null`，移出`microtask`中的`microtask`。
    - 清理IndexDB事务
    - 设置进入microtask检查点的标志为false。

  - 更新界面渲染。

  - 返回第一步。

- 执行栈在执行完**同步任务**后，查看**执行栈**是否为空，如果执行栈为空，就会去执行`Task`（宏任务），每次**宏任务**执行完毕后，检查**微任务**(`microTask`)队列是否为空，如果不为空的话，会按照**先入先**出的规则全部执行完**微任务**(`microTask`)后，设置**微任务**(`microTask`)队列为`null`，然后再执行**宏任务**，如此循环。

- **`process.nextTick()`虽然它是异步API的一部分，但未在图中显示。这是因为`process.nextTick()`从技术上讲，它不是事件循环的一部分。**

  - 当每个阶段完成后，如果存在 `nextTick` 队列，就会清空队列中的所有回调函数，并且优先于其他 `microtask` 执行。
  - Prcocess.nextTick() >promise



