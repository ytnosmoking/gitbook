\> 本文由 \[简悦 SimpRead\](http://ksria.com/simpread/) 转码， 原文地址 \[blog.csdn.net\](https://blog.csdn.net/u013565133/article/details/102819929)

这句话待严谨：javaScript 存储对象都是存地址的，所以浅拷贝会导致 obj1 和 obj2 指向同一块内存地址。改变了其中一方的内容，都是在原来的内存上做修改会导致拷贝对象和源对象都发生改变，而深拷贝是开辟一块新的内存地址，将原对象的各个属性逐个复制进去。对拷贝对象和源对象各自的操作互不影响。

`JSON.parse(JSON.stringify(obj))`我们一般用来深拷贝，其过程说白了 就是利用`JSON.stringify` 将 js 对象序列化（`JSON字符串`），再使用`JSON.parse`来反序列化 (还原)js 对象；序列化的作用是存储(对象本身存储的只是一个地址映射，如果断电，对象将不复存在，因此需将对象的内容转换成字符串的形式再保存在磁盘上 ) 和传输（例如 如果请求的`Content-Type`是 `application/x-www-form-urlencoded`，则前端这边需要使用`qs.stringify(data)`来序列化参数再传给后端，否则后端接受不到； ps: `Content-Type` 为 `application/json;charset=UTF-8`或者 `multipart/form-data` 则可以不需要 ）。

**我们在使用 JSON.parse(JSON.stringify(xxx)) 时应该注意一下几点：**

### 1、如果 obj 里面有时间对象，则`JSON.stringify`后再`JSON.parse`的结果，时间将只是字符串的形式。而不是时间对象；

```
var test = {
     name: 'a',
     date: \[new Date(1536627600000), new Date(1540047600000)\],
   };

   let b;
   b = JSON.parse(JSON.stringify(test))

```

![](https://img-blog.csdnimg.cn/20191030152020407.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTM1NjUxMzM=,size_16,color_FFFFFF,t_70)

### 2、如果 obj 里有`RegExp`、`Error`对象，则序列化的结果将只得到空对象；

```
const test = {
     name: 'a',
     date: new RegExp('\\\\w+'),
   };
   // debugger
   const copyed = JSON.parse(JSON.stringify(test));
   test.name = 'test'
   console.error('ddd', test, copyed)

```

![](https://img-blog.csdnimg.cn/2019103015205694.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTM1NjUxMzM=,size_16,color_FFFFFF,t_70)  

### 3、如果 obj 里有函数，`undefined`，则序列化的结果会把函数或 undefined 丢失；

```
const test = {
        name: 'a',
        date: function hehe() {
          console.log('fff')
        },
      };
      // debugger
      const copyed = JSON.parse(JSON.stringify(test));
      test.name = 'test'
      console.error('ddd', test, copyed)

```

![](https://img-blog.csdnimg.cn/20191030152139924.png)![](https://img-blog.csdnimg.cn/20191030153003784.png)  

### 4、如果 obj 里有 NaN、Infinity 和 - Infinity，则序列化的结果会变成 null  

![](https://img-blog.csdnimg.cn/20191030152158882.png)  

### 5、`JSON.stringify()`只能序列化对象的可枚举的自有属性，例如 如果 obj 中的对象是有构造函数生成的， 则使用`JSON.parse(JSON.stringify(obj))`深拷贝后，会丢弃对象的`constructor`；

```
	function Person(name) {
	  this.name = name;
	  console.log(name)
	}
	
	const liai = new Person('liai');
	
	const test = {
	  name: 'a',
	  date: liai,
	};
	// debugger
	const copyed = JSON.parse(JSON.stringify(test));
	test.name = 'test'
	console.error('ddd', test, copyed)


```

![](https://img-blog.csdnimg.cn/20191030152226695.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTM1NjUxMzM=,size_16,color_FFFFFF,t_70)  

### 6、如果对象中存在循环引用的情况也无法正确实现深拷贝；

以上，如果拷贝的对象不涉及上面讲的情况，可以使用`JSON.parse(JSON.stringify(obj))`实现深拷贝，但是涉及到上面的情况，可以考虑使用如下方法实现深拷贝：

```
//实现深拷贝函数
function deepClone(data) {
    const type = this.judgeType(data);
    let obj = null;
    if (type == 'array') {
        obj = \[\];
        for (let i = 0; i < data.length; i++) {
            obj.push(this.deepClone(data\[i\]));
        }
    } else if (type == 'object') {
        obj = {}
        for (let key in data) {
            if (data.hasOwnProperty(key)) {
                obj\[key\] = this.deepClone(data\[key\]);
            }
        }
    } else {
        return data;
    }
    return obj;
}

function judgeType(obj) {
    // tostring会返回对应不同的标签的构造函数
    const toString = Object.prototype.toString;
    const map = {
        '\[object Boolean\]': 'boolean',
        '\[object Number\]': 'number',
        '\[object String\]': 'string',
        '\[object Function\]': 'function',
        '\[object Array\]': 'array',
        '\[object Date\]': 'date',
        '\[object RegExp\]': 'regExp',
        '\[object Undefined\]': 'undefined',
        '\[object Null\]': 'null',
        '\[object Object\]': 'object',
    };
    if (obj instanceof Element) {
        return 'element';
    }
    return map\[toString.call(obj)\];
}
const test = {
    name: 'a',
    date: \[1,2,3\]
};


console.log(deepClone(test))
test.date\[0\] = 6;
console.log(test);

```