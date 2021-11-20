# 各种方法

## 1、**数据类型**

``` javascript
function type(para) {
    return Object.prototype.toString.call(para)
}
```

## 2、数组去重

``` javascript
function unique1(arr) {
    return [...new Set(arr)]
}
function unique2(arr) {
    var obj = {};
    return arr.filter(ele => {
        if (!obj[ele]) {
            obj[ele] = true;
            return true;
        }
    })
}
function unique3(arr) {
    var result = [];
    arr.forEach(ele => {
        if (result.indexOf(ele) == -1) {
            result.push(ele)
        }
    })
    return result;
}


```

## 3、字符串去重

``` javascript
String.prototype.unique = function () {
    var obj = {},
        str = '',
        len = this.length;
    for (var i = 0; i < len; i++) {
        if (!obj[this[i]]) {
            str += this[i];
            obj[this[i]] = true;
        }
    }
    return str;
}
//去除连续的字符串 
function uniq(str) {
    return str.replace(/(\w)\1+/g, '$1')
}

```

## 4、深拷贝 浅拷贝

``` javascript
//深克隆（深克隆不考虑函数）
function deepClone(obj, result) {
    var result = result || {};
    for (var prop in obj) {
        if (obj.hasOwnProperty(prop)) {
            if (typeof obj[prop] == 'object' && obj[prop] !== null) {
                // 引用值(obj/array)且不为null
                if (Object.prototype.toString.call(obj[prop]) == '[object Object]') {
                    // 对象
                    result[prop] = {};
                } else {
                    // 数组
                    result[prop] = [];
                }
                deepClone(obj[prop], result[prop])
    } else {
        // 原始值或func
        result[prop] = obj[prop]
    }
  }
}
return result;
}

// 深浅克隆是针对引用值
function deepClone(target) {
    if (typeof (target) !== 'object') {
        return target;
    }
    var result;
    if (Object.prototype.toString.call(target) == '[object Array]') {
        // 数组
        result = []
    } else {
        // 对象
        result = {};
    }
    for (var prop in target) {
        if (target.hasOwnProperty(prop)) {
            result[prop] = deepClone(target[prop])
        }
    }
    return result;
}
// 无法复制函数
var o1 = jsON.parse(jsON.stringify(obj1));

function deepClone(obj, cache = new WeakMap()) {
  if (typeof obj !== 'object') return obj // 普通类型，直接返回
  if (obj === null) return obj
  if (cache.get(obj)) return cache.get(obj) // 防止循环引用，程序进入死循环
  if (obj instanceof Date) return new Date(obj)
  if (obj instanceof RegExp) return new RegExp(obj)
  
  // 找到所属原型上的constructor，所属原型上的constructor指向当前对象的构造函数
  let cloneObj = new obj.constructor()
  cache.set(obj, cloneObj) // 缓存拷贝的对象，用于处理循环引用的情况
  for (let key in obj) {
    if (obj.hasOwnProperty(key)) {
      cloneObj[key] = deepClone(obj[key], cache) // 递归拷贝
    }
  }
  return cloneObj
}

// 测试
const obj = { name: 'Jack', address: { x: 100, y: 200 } }
obj.a = obj // 循环引用
const newObj = deepClone(obj)
console.log(newObj.address === obj.address) // false
```

## 5、reverse 底层原理和扩展

``` javascript
// 改变原数组
Array.prototype.myReverse = function () {
    var len = this.length;
    for (var i = 0; i < len; i++) {
        var temp = this[i];
        this[i] = this[len - 1 - i];
        this[len - 1 - i] = temp;
    }
    return this;
}

```

## 6、圣杯模式的继承

``` javascript
function inherit(Target, Origin) {
    function F() {};
    F.prototype = Origin.prototype;
    Target.prototype = new F();
    Target.prototype.constructor = Target;
    // 最终的原型指向
    Target.prop.uber = Origin.prototype;
}

```

## 7、找出字符串中第一次只出现一次的字母

``` javascript
String.prototype.firstAppear = function () {
    var obj = {},
        len = this.length;
    for (var i = 0; i < len; i++) {
        if (obj[this[i]]) {
            obj[this[i]]++;
        } else {
            obj[this[i]] = 1;
        }
    }
    for (var prop in obj) {
       if (obj[prop] == 1) {
         return prop;
       }
    }
}

```

## 8、找元素的第 n 级父元素

``` javascript
function parents(ele, n) {
    while (ele && n) {
        ele = ele.parentElement ? ele.parentElement : ele.parentNode;
        n--;
    }
    return ele;
}

```

## 9、 返回元素的第 n 个兄弟节点

``` javascript
function retSibling(e, n) {
    while (e && n) {
        if (n > 0) {
            if (e.nextElementSibling) {
                e = e.nextElementSibling;
            } else {
                for (e = e.nextSibling; e && e.nodeType !== 1; e = e.nextSibling);
            }
            n--;
        } else {
            if (e.previousElementSibling) {
                e = e.previousElementSibling;
            } else {
                for (e = e.previousElementSibling; e && e.nodeType !== 1; e = e.previousElementSibling);
            }
            n++;
        }
    }
    return e;
}


```

## 10、封装 mychildren，解决浏览器的兼容问题

``` javascript
function myChildren(e) {
    var children = e.childNodes,
        arr = [],
        len = children.length;
    for (var i = 0; i < len; i++) {
        if (children[i].nodeType === 1) {
            arr.push(children[i])
        }
    }
    return arr;
}
```

## 11、判断元素有没有子元素

``` javascript
function hasChildren(e) {
    var children = e.childNodes,
        len = children.length;
    for (var i = 0; i < len; i++) {
        if (children[i].nodeType === 1) {
            return true;
        }
    }
    return false;
}

```

## 12、我一个元素插入到另一个元素的后面

``` javascript
Element.prototype.insertAfter = function (target, elen) {
    var nextElen = elen.nextElenmentSibling;
    if (nextElen == null) {
        this.appendChild(target);
    } else {
        this.insertBefore(target, nextElen);
    }
}


```

## 13、返回当前的时间（年月日时分秒）

``` javascript
function getDateTime() {
    var date = new Date(),
        year = date.getFullYear(),
        month = date.getMonth() + 1,
        day = date.getDate(),
        hour = date.getHours() + 1,
        minute = date.getMinutes(),
        second = date.getSeconds();
        month = checkTime(month);
        day = checkTime(day);
        hour = checkTime(hour);
        minute = checkTime(minute);
        second = checkTime(second);
     function checkTime(i) {
        if (i < 10) {
          i = "0" + i;
       }
      return i;
    }
    return "" + year + "年" + month + "月" + day + "日" + hour + "时" + minute + "分" + second + "秒"
}

```

## 14、获得滚动条的滚动距离

``` javascript
function getScrollOffset() {
    if (window.pageXOffset) {
        return {
            x: window.pageXOffset,
            y: window.pageYOffset
        }
    } else {
        return {
            x: document.body.scrollLeft + document.documentElement.scrollLeft,
            y: document.body.scrollTop + document.documentElement.scrollTop
        }
    }
}


```

## 15、获得视口的尺寸

``` javascript
function getViewportOffset() {
    if (window.innerWidth) {
        return {
            w: window.innerWidth,
            h: window.innerHeight
        }
    } else {
        // ie8及其以下
        if (document.compatMode === "BackCompat") {
            // 怪异模式
            return {
                w: document.body.clientWidth,
                h: document.body.clientHeight
            }
        } else {
            // 标准模式
            return {
                w: document.documentElement.clientWidth,
                h: document.documentElement.clientHeight
            }
        }
    }
}


```

## 16、获取任一元素的任意属性

``` javascript
function getStyle(elem, prop) {
    return window.getComputedStyle ? window.getComputedStyle(elem, null)[prop] : elem.currentStyle[prop]
}


```

## 17、绑定事件的兼容代码

``` javascript
function addEvent(elem, type, handle) {
    if (elem.addEventListener) { //非ie和非ie9
        elem.addEventListener(type, handle, false);
    } else if (elem.attachEvent) { //ie6到ie8
        elem.attachEvent('on' + type, function () {
            handle.call(elem);
        })
    } else {
        elem['on' + type] = handle;
    }
}


```

## 18、解绑事件

``` javascript
function removeEvent(elem, type, handle) {
    if (elem.removeEventListener) { //非ie和非ie9
        elem.removeEventListener(type, handle, false);
    } else if (elem.detachEvent) { //ie6到ie8
        elem.detachEvent('on' + type, handle);
    } else {
        elem['on' + type] = null;
    }
}


```

## 19、取消冒泡的兼容代码

``` javascript
function stopBubble(e) {
    if (e && e.stopPropagation) {
        e.stopPropagation();
    } else {
        window.event.cancelBubble = true;
    }
}


```

## 20、检验字符串是否是回文

``` javascript
function isPalina(str) {
    if (Object.prototype.toString.call(str) !== '[object String]') {
        return false;
    }
    var len = str.length;
    for (var i = 0; i < len / 2; i++) {
        if (str[i] != str[len - 1 - i]) {
            return false;
        }
    }
    return true;
}

```

## 21、检验字符串是否是回文

``` javascript
function isPalindrome(str) {
    str = str.replace(/\W/g, '').toLowerCase();
    console.log(str)
    return (str == str.split('').reverse().join(''))
}


```

## 22、兼容 getElementsByClassName 方法

``` javascript
Element.prototype.getElementsByClassName = Document.prototype.getElementsByClassName = function (_className) {
    var allDomArray = document.getElementsByTagName('*');
    var lastDomArray = [];
    function trimSpace(strClass) {
        var reg = /\s+/g;
        return strClass.replace(reg, ' ').trim()
    }
    for (var i = 0; i < allDomArray.length; i++) {
        var classArray = trimSpace(allDomArray[i].className).split(' ');
        for (var j = 0; j < classArray.length; j++) {
            if (classArray[j] == _className) {
                lastDomArray.push(allDomArray[i]);
                break;
            }
        }
    }
    return lastDomArray;
}


```

## 23、运动函数

``` javascript
function animate(obj, json, callback) {
    clearInterval(obj.timer);
    var speed,
        current;
    obj.timer = setInterval(function () {
        var lock = true;
        for (var prop in json) {
            if (prop == 'opacity') {
                current = parseFloat(window.getComputedStyle(obj, null)[prop]) * 100;
            } else {
                current = parseInt(window.getComputedStyle(obj, null)[prop]);
            }
            speed = (json[prop] - current) / 7;
            speed = speed > 0 ? Math.ceil(speed) : Math.floor(speed);

            if (prop == 'opacity') {
                obj.style[prop] = (current + speed) / 100;
            } else {
                obj.style[prop] = current + speed + 'px';
            }
            if (current != json[prop]) {
                lock = false;
            }
        }
        if (lock) {
            clearInterval(obj.timer);
            typeof callback == 'function' ? callback() : '';
        }
    }, 30)
}


```

## 24、弹性运动

``` javascript
function ElasticMovement(obj, target) {
    clearInterval(obj.timer);
    var iSpeed = 40,
        a, u = 0.8;
    obj.timer = setInterval(function () {
        a = (target - obj.offsetLeft) / 8;
        iSpeed = iSpeed + a;
        iSpeed = iSpeed * u;
        if (Math.abs(iSpeed) <= 1 && Math.abs(a) <= 1) {
            console.log('over')
            clearInterval(obj.timer);
            obj.style.left = target + 'px';
        } else {
            obj.style.left = obj.offsetLeft + iSpeed + 'px';
        }
    }, 30);
}


```

## 25、封装自己的 forEach 方法

``` javascript
Array.prototype.myForEach = function (func, obj) {
    var len = this.length;
    var _this = arguments[1] ? arguments[1] : window;
    // var _this=arguments[1]||window;
    for (var i = 0; i < len; i++) {
        func.call(_this, this[i], i, this)
    }
}


```

## 26、封装自己的 filter 方法

``` javascript
Array.prototype.myFilter = function (func, obj) {
    var len = this.length;
    var arr = [];
    var _this = arguments[1] || window;
    for (var i = 0; i < len; i++) {
        func.call(_this, this[i], i, this) && arr.push(this[i]);
    }
    return arr;
}


```

## 27、数组 map 方法

``` javascript
Array.prototype.myMap = function (func) {
    var arr = [];
    var len = this.length;
    var _this = arguments[1] || window;
    for (var i = 0; i < len; i++) {
        arr.push(func.call(_this, this[i], i, this));
    }
    return arr;
}


```

## 28、数组 every 方法

``` javascript
Array.prototype.myEvery = function (func) {
    var flag = true;
    var len = this.length;
    var _this = arguments[1] || window;
    for (var i = 0; i < len; i++) {
        if (func.apply(_this, [this[i], i, this]) == false) {
            flag = false;
            break;
        }
    }
    return flag;
}


```

## 29、数组 reduce 方法

``` javascript
Array.prototype.myReduce = function (func, initialValue) {
    var len = this.length,
        nextValue,
        i;
    if (!initialValue) {
        // 没有传第二个参数
        nextValue = this[0];
        i = 1;
    } else {
        // 传了第二个参数
        nextValue = initialValue;
        i = 0;
    }
    for (; i < len; i++) {
        nextValue = func(nextValue, this[i], i, this);
    }
    return nextValue;
}


```

## 30、获取 url 中的参数

``` javascript
function getWindonHref() {
    var sHref = window.location.href;
    var args = sHref.split('?');
    if (args[0] === sHref) {
        return '';
    }
    var hrefarr = args[1].split('#')[0].split('&');
    var obj = {};
    for (var i = 0; i < hrefarr.length; i++) {
        hrefarr[i] = hrefarr[i].split('=');
        obj[hrefarr[i][0]] = hrefarr[i][1];
    }
    return obj;
}

function getParams(url) {
  const res = {}
  if (url.includes('?')) {
    const str = url.split('?')[1]
    const arr = str.split('&')
    arr.forEach(item => {
      const key = item.split('=')[0]
      const val = item.split('=')[1]
      res[key] = decodeURIComponent(val) // 解码
    })
  }
  return res
}

// 测试
const user = getParams('http://www.baidu.com?user=%E9%98%BF%E9%A3%9E&age=16')
console.log(user) // { user: '阿飞', age: '16' }

```

## 31、数组排序

``` javascript
// 快排 [left] + min + [right]
function quickArr(arr) {
    if (arr.length <= 1) {
        return arr;
    }
    var left = [],
        right = [];
    var pIndex = Math.floor(arr.length / 2);
    var p = arr.splice(pIndex, 1)[0];
    for (var i = 0; i < arr.length; i++) {
        if (arr[i] <= p) {
            left.push(arr[i]);
        } else {
            right.push(arr[i]);
        }
    }
    // 递归
    return quickArr(left).concat([p], quickArr(right));
}

// 冒泡
function bubbleSort(arr) {
    for (var i = 0; i < arr.length - 1; i++) {
        for (var j = i + 1; j < arr.length; j++) {
            if (arr[i] > arr[j]) {
                var temp = arr[i];
                arr[i] = arr[j];
                arr[j] = temp;
            }
        }
    }
    return arr;
}

function bubbleSort(arr) {
    var len = arr.length;
    for (var i = 0; i < len - 1; i++) {
        for (var j = 0; j < len - 1 - i; j++) {
            if (arr[j] > arr[j + 1]) {
                var temp = arr[j];
                arr[j] = arr[j + 1];
                arr[j + 1] = temp;
            }
        }
    }
    return arr;
}


```

## 32、遍历 Dom 树

``` javascript
// 给定页面上的DOM元素,将访问元素本身及其所有后代(不仅仅是它的直接子元素)
// 对于每个访问的元素，函数讲元素传递给提供的回调函数
function traverse(element, callback) {
    callback(element);
    var list = element.children;
    for (var i = 0; i < list.length; i++) {
        traverse(list[i], callback);
    }
}


```

## 33、原生 js 封装 ajax

``` javascript
function ajax(method, url, callback, data, flag) {
    var xhr;
    flag = flag || true;
    method = method.toUpperCase();
    if (window.XMLHttpRequest) {
        xhr = new XMLHttpRequest();
    } else {
        xhr = new ActiveXObject('Microsoft.XMLHttp');
    }
    xhr.onreadystatechange = function () {
        if (xhr.readyState == 4 && xhr.status == 200) {
            console.log(2)
            callback(xhr.responseText);
        }
    }

    if (method == 'GET') {
        var date = new Date(),
        timer = date.getTime();
        xhr.open('GET', url + '?' + data + '&timer' + timer, flag);
        xhr.send()
        } else if (method == 'POST') {
        xhr.open('POST', url, flag);
        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        xhr.send(data);
    }
}


```

## 34、异步加载 script

``` javascript
function loadScript(url, callback) {
    var oscript = document.createElement('script');
    if (oscript.readyState) { // ie8及以下版本
        oscript.onreadystatechange = function () {
            if (oscript.readyState === 'complete' || oscript.readyState === 'loaded') {
                callback();
            }
        }
    } else {
        oscript.onload = function () {
            callback()
        };
    }
    oscript.src = url;
    document.body.appendChild(oscript);
}


```

## 35、cookie 管理

``` javascript
var cookie = {
    set: function (name, value, time) {
        document.cookie = name + '=' + value + '; max-age=' + time;
        return this;
    },
    remove: function (name) {
        return this.setCookie(name, '', -1);
    },
    get: function (name, callback) {
        var allCookieArr = document.cookie.split('; ');
        for (var i = 0; i < allCookieArr.length; i++) {
            var itemCookieArr = allCookieArr[i].split('=');
            if (itemCookieArr[0] === name) {
                return itemCookieArr[1]
            }
        }
        return undefined;
    }
}


```

## 36、实现 bind() 方法

``` javascript
Function.prototype.myBind = function (target) {
    var target = target || window;
    var _args1 = [].slice.call(arguments, 1);
    var self = this;
    var temp = function () {};
    var F = function () {
        var _args2 = [].slice.call(arguments, 0);
        var parasArr = _args1.concat(_args2);
        return self.apply(this instanceof temp ? this : target, parasArr)
    }
    temp.prototype = self.prototype;
    F.prototype = new temp();
    return F;
}


```

## 37、实现 call() 方法

``` javascript
Function.prototype.myCall = function () {
    var ctx = arguments[0] || window;
    ctx.fn = this;
    var args = [];
    for (var i = 1; i < arguments.length; i++) {
        args.push(arguments[i])
    }
    var result = ctx.fn(...args);
    delete ctx.fn;
    return result;
}


```

## 38、实现 apply() 方法

``` javascript
Function.prototype.myApply = function () {
    var ctx = arguments[0] || window;
    ctx.fn = this;
    if (!arguments[1]) {
        var result = ctx.fn();
        delete ctx.fn;
        return result;
    }
    var result = ctx.fn(...arguments[1]);
    delete ctx.fn;
    return result;
}


```

## 39、防抖

``` javascript
function debounce(handle, delay) {
    var timer = null;
    return function () {
        var _self = this,
            _args = arguments;
        clearTimeout(timer);
        timer = setTimeout(function () {
            handle.apply(_self, _args)
        }, delay)
    }
}


```

## 40、节流

``` javascript
function throttle(handler, wait) {
    var lastTime = 0;
    return function (e) {
        var nowTime = new Date().getTime();
        if (nowTime - lastTime > wait) {
            handler.apply(this, arguments);
            lastTime = nowTime;
        }
    }
}


```

## 41、requestAnimFrame 兼容性方法

``` javascript
window.requestAnimFrame = (function () {
    return window.requestAnimationFrame ||
        window.webkitRequestAnimationFrame ||
        window.mozRequestAnimationFrame ||
        function (callback) {
            window.setTimeout(callback, 1000 / 60);
        };
})();


```

## 42、cancelAnimFrame 兼容性方法

``` javascript
window.cancelAnimFrame = (function () {
    return window.cancelAnimationFrame ||
        window.webkitCancelAnimationFrame ||
        window.mozCancelAnimationFrame ||
        function (id) {
            window.clearTimeout(id);
        };
})();


```

## 43、jsonp 底层方法

``` javascript
function jsonp(url, callback) {
    var oscript = document.createElement('script');
    if (oscript.readyState) { // ie8及以下版本
        oscript.onreadystatechange = function () {
            if (oscript.readyState === 'complete' || oscript.readyState === 'loaded') {
                callback();
            }
        }
    } else {
        oscript.onload = function () {
            callback()
        };
    }
    oscript.src = url;
    document.body.appendChild(oscript);
}


```

## 44、获取 url 上的参数

``` javascript
function getUrlParam(sUrl, sKey) {
    var result = {};
    sUrl.replace(/(\w+)=(\w+)(?=[&|#])/g, function (ele, key, val) {
        if (!result[key]) {
            result[key] = val;
        } else {
            var temp = result[key];
            result[key] = [].concat(temp, val);
        }
    })
    if (!sKey) {
        return result;
    } else {
        return result[sKey] || '';
    }
}

const getParameters = (URL) => {
	URL = JSON.parse('{"' + decodeURI(URL.split("?")[1]).replace(/"/g, '\"').replace(/&/g, '","').replace(
	/=/g, '":"') + '"}');
	return JSON.stringify(URL);
};


```

## 45、格式化时间

``` javascript
function formatDate(t, str) {
    var obj = {
        yyyy: t.getFullYear(),
        yy: ("" + t.getFullYear()).slice(-2),
        M: t.getMonth() + 1,
        MM: ("0" + (t.getMonth() + 1)).slice(-2),
        d: t.getDate(),
        dd: ("0" + t.getDate()).slice(-2),
        H: t.getHours(),
        HH: ("0" + t.getHours()).slice(-2),
        h: t.getHours() % 12,
        hh: ("0" + t.getHours() % 12).slice(-2),
        m: t.getMinutes(),
        mm: ("0" + t.getMinutes()).slice(-2),
        s: t.getSeconds(),
        ss: ("0" + t.getSeconds()).slice(-2),
        w: ['日', '一', '二', '三', '四', '五', '六'][t.getDay()]
    };
    return str.replace(/([a-z]+)/ig, function ($1) {
        return obj[$1]
    });
}


```

## 46、验证邮箱的正则表达式

``` javascript
function isAvailableEmail(sEmail) {
    var reg = /^([\w+\.])+@\w+([.]\w+)+$/
    return reg.test(sEmail)
}


```

## 47、函数柯里化

``` javascript
//是把接受多个参数的函数变换成接受一个单一参数(最初函数的第一个参数)的函数，并且返回接受余下的参数且返回结果的新函数的技术

function curryIt(fn) {
    var length = fn.length,
        args = [];
    var result = function (arg) {
        args.push(arg);
        length--;
        if (length <= 0) {
            return fn.apply(this, args);
        } else {
            return result;
        }
    }
    return result;
}


```

## 48、大数相加

``` javascript
function sumBigNumber(a, b) {
    var res = '', //结果
        temp = 0; //按位加的结果及进位
    a = a.split('');
    b = b.split('');
    while (a.length || b.length || temp) {
        //~~按位非 1.类型转换，转换成数字 2.~~undefined==0 
        temp += ~~a.pop() + ~~b.pop();
        res = (temp % 10) + res;
        temp = temp > 9;
    }
    return res.replace(/^0+/, '');
}


```

## 49、单例模式

``` javascript
function getSingle(func) {
    var result;
    return function () {
        if (!result) {
            result = new func(arguments);
        }
        return result;
    }
}

```

## 50、实现promise

``` javascript
class MyPromise {
  constructor(executor) { // executor执行器
    this.status = 'pending' // 等待状态
    this.value = null // 成功或失败的参数
    this.fulfilledCallbacks = [] // 成功的函数队列
    this.rejectedCallbacks = [] // 失败的函数队列
    const that = this
    function resolve(value) { // 成功的方法
      if (that.status === 'pending') {
        that.status = 'resolved'
        that.value = value
        that.fulfilledCallbacks.forEach(myFn => myFn(that.value)) //执行回调方法
      }
    }
    function reject(value) { //失败的方法
      if (that.status === 'pending') {
        that.status = 'rejected'
        that.value = value
        that.rejectedCallbacks.forEach(myFn => myFn(that.value)) //执行回调方法
      }
    }
    try {
      executor(resolve, reject)
    } catch (err) {
      reject(err)
    }
  }
  then(onFulfilled, onRejected) {
    if (this.status === 'pending') {
      // 等待状态，添加回调函数到成功的函数队列
      this.fulfilledCallbacks.push(() => {
        onFulfilled(this.value)
      })
      // 等待状态，添加回调函数到失败的函数队列
      this.rejectedCallbacks.push(() => {
        onRejected(this.value)
      })
    }
    if (this.status === 'resolved') { // 支持同步调用
      console.log('this', this)
      onFulfilled(this.value)
    }
    if (this.status === 'rejected') { // 支持同步调用
      onRejected(this.value)
    }
  }
}
```

## 51、组合继承

```javascript
function Parent(name) {
  this.name = name
}
Parent.prototype.eat = function () {
  console.log(this.name + ' is eating')
}

function Child(name, age) {
  Parent.call(this, name) // 构造函数继承
  this.age = age
}
Child.prototype = new Parent() // 原型链继承
Child.prototype.contructor = Child
Child.prototype.study = function () {
  console.log(this.name + ' is studying')
}

// 测试
let child = new Child('xiaoming', 16)
console.log(child.name) // xiaoming
child.eat() // xiaoming is eating
child.study() // xiaoming is studying	
```

## 52、事件总线｜发布订阅模式

```javascript
class EventEmitter {
  constructor() {
    this.cache = {}
  }

  on(name, fn) {
    if (this.cache[name]) {
      this.cache[name].push(fn)
    } else {
      this.cache[name] = [fn]
    }
  }

  off(name, fn) {
    const tasks = this.cache[name]
    if (tasks) {
      const index = tasks.findIndex((f) => f === fn || f.callback === fn)
      if (index >= 0) {
        tasks.splice(index, 1)
      }
    }
  }

  emit(name, once = false) {
    if (this.cache[name]) {
      // 创建副本，如果回调函数内继续注册相同事件，会造成死循环
      const tasks = this.cache[name].slice()
      for (let fn of tasks) {
        fn();
      }
      if (once) {
        delete this.cache[name]
      }
    }
  }
}

// 测试
const eventBus = new EventEmitter()
const task1 = () => { console.log('task1'); }
const task2 = () => { console.log('task2'); }

eventBus.on('task', task1)
eventBus.on('task', task2)
eventBus.off('task', task1)
setTimeout(() => {
  eventBus.emit('task') // task2
}, 1000)	
```

## 53、复制剪切板

```javascript
const copyToClipboard = (text) => navigator.clipboard.writeText(text);
```

## 54、检查日期是否有效

```javascript
const isDateValid = (...val) => !Number.isNaN(new Date(...val).valueOf());	
```

## 55、找出一年中的哪一天

```javascript
const dayOfYear = (date) =>  Math.floor((date - new Date(date.getFullYear(), 0, 0)) / 1000 / 60 / 60 / 24);
```

## 56、首字符串大写

```javascript
const capitalize = str => str.charAt(0).toUpperCase() + str.slice(1)capitalize("follow for more")
```

## 57、两日期之间的天数

```javascript
const dayDif = (date1, date2) => Math.ceil(Math.abs(date1.getTime() - date2.getTime()) / 86400000)dayDif(new Date("2020-10-21"), new Date("2021-10-22"))
```

## 58、清除所有 Cookie

```javascript
const clearCookies = document.cookie.split(';').forEach(cookie => document.cookie = cookie.replace(/^ +/, '')
.replace(/=.*/, `=;expires=${new Date(0).toUTCString()};
path=/`));
```

## 59、随机16进制

```javascript
const randomHex = () => `#${Math.floor(Math.random() * 0xffffff).toString(16).padEnd(6, "0")}`
```

## 60、选定文本

```javascript
const getSelectedText = () => window.getSelection().toString();	
```

