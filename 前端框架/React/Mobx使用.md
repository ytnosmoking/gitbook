> 本文由 [简悦 SimpRead](http://ksria.com/simpread/) 转码， 原文地址 [blog.csdn.net](https://blog.csdn.net/sinat_17775997/article/details/82772760)

前言
==

由于最近开启一个新的个人小项目，准备还是使用 [React](https://so.csdn.net/so/search?from=pc_blog_highlight&q=React) 及其生态来实现整个技术架构，之前一直使用的是 React + React-Router + [Redux](https://so.csdn.net/so/search?from=pc_blog_highlight&q=Redux) 组合，虽然说使用 Redux 来管理整个应用的数据流有着优点，但是 Redux 的写法繁琐也确实让人诟病，当然这里并不是说 Redux 不好。  
基于项目本身并不大，决定寻找一个新的解决方案，而 MobX 在之前就有所耳闻（只是一直没有时间和需求去深入了解），借着这次机会正好可以好好学习下 MobX 的理念。

本文中强烈建议使用 ES6&ES7 的语法并且本文也只用 ES6&ES7 语法来举例实现。

开始使用
====

START！！！?

首先第一步当然是引入 MobX，这里很简单，两种方式：

1.  使用 npm 安装然后引入：

<table><tbody><tr><td><pre>npm install mobx;

</pre></td></tr></tbody></table>

<table><tbody><tr><td><pre>import { ... } from 'mobx';

</pre></td></tr></tbody></table>

1.  使用 script 标签引入：

<table><tbody><tr><td><pre>&lt;script src="https://unpkg.com/mobx/lib/mobx.umd.js"&gt;&lt;/script&gt;

</pre></td></tr></tbody></table>

在 MobX 的使用中，使用 ES7 语法的 **修饰器（Decorator）** 将可以极大的简化组织代码，当然，如果使用 ES5 的语法也未尝不可，但是我这里还是强烈建议大家使用 修饰器，并且本文中的所有例子也都基于修饰器来说明。

对于修饰器这里简要说明一下，修饰器其实是对于一种函数形式的语法糖，通过以下例子可以一目了然其行为作用：

<table><tbody><tr><td><pre>@decorator
class A {}

// 等同于
class A {}
A = decorator(A) || A;

</pre></td></tr></tbody></table>

配置 ES6 以及 **修饰器** ，最方便的当然是使用 babel 来编译 ES6 代码了，在 .babelrc 中配置：

<table><tbody><tr><td><pre>{
  "presets": [
    "es2015",
    "stage-1"
  ],
  "plugins": ["transform-decorators-legacy"]
}

</pre></td></tr></tbody></table>

这里使用了 ES6 中 stage-1 提案标准，然后加入 transform-decorators-legacy 来支持修饰器。

核心概念
====

数据流
---

在一个数据管理框架 & 库中，其最重要的就是它的数据管理模式了，也就是其数据流。  
对于 MobX 来说，它的数据流简明清晰，并且也是单向数据流，如下图所示。

![](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADIAAAAyCAYAAAAeP4ixAAACbklEQVRoQ+2aMU4dMRCGZw6RC1CSSyQdLZJtKQ2REgoiRIpQkCYClCYpkgIESQFIpIlkW+IIcIC0gUNwiEFGz+hlmbG9b1nesvGW++zxfP7H4/H6IYzkwZFwQAUZmpJVkSeniFJKA8ASIi7MyfkrRPxjrT1JjZ8MLaXUDiJuzwngn2GJaNd7vyP5IoIYY94Q0fEQIKIPRGS8947zSQTRWh8CwLuBgZx479+2BTkHgBdDAgGAC+fcywoyIFWqInWN9BSONbTmFVp/AeA5o+rjKRJ2XwBYRsRXM4ZXgAg2LAPzOCDTJYQx5pSIVlrC3EI45y611osMTHuQUPUiYpiVooerg7TWRwDAlhSM0TuI+BsD0x4kGCuFSRVzSqkfiLiWmY17EALMbCAlMCmI6IwxZo+INgQYEYKBuW5da00PKikjhNNiiPGm01rrbwDwofGehQjjNcv1SZgddALhlJEgwgJFxDNr7acmjFLqCyJuTd6LEGFttpmkYC91Hrk3s1GZFERMmUT01Xv/sQljjPlMRMsxO6WULwnb2D8FEs4j680wScjO5f3vzrlNJszESWq2LYXJgTzjZm56MCHf3zVBxH1r7ftU1splxxKYHEgoUUpTo+grEf303rPH5hxENJqDKQEJtko2q9zGeeycWy3JhpKhWT8+NM/sufIhBwKI+Mta+7pkfxKMtd8Qtdbcx4dUQZcFCQ2I6DcAnLUpf6YMPxhIDDOuxC4C6djoQUE6+tKpewWZ1wlRkq0qUhXptKTlzv93aI3jWmE0Fz2TeujpX73F9TaKy9CeMk8vZusfBnqZ1g5GqyIdJq+XrqNR5AahKr9CCcxGSwAAAABJRU5ErkJggg==)图片来源：[http://cn.mobx.js.org/](http://cn.mobx.js.org/)

它由几个部分组成：Actions、State、Computed Values、[React](https://so.csdn.net/so/search?from=pc_blog_highlight&q=React)ions

在整个数据流中，通过事件驱动（UI 事件、网络请求…）触发 Actions，在 Actions 中修改了 State 中的值，这里的 State 既应用中的 store 树（存储数据），然后根据新的 State 中的数据计算出所需要的计算属性（computed values）值，最后响应（react）到 UI 视图层。

当然，如此说明仍然是过于抽象，接下来就进入实际例子分析。

例子
--

<table><tbody><tr><td><pre>const { observable, action, computed, autorun } = mobx;

class Store {
  @observable list = []
  @computed get total() {
    return this.list.length;
  }
  @action change () {
    this.list.push(this.list.length);
  }
};

const mstore = new Store();

setInterval(() =&gt; {
  mstore.change();
}, 2000);

autorun(() =&gt; {
  console.log(mstore.total);
});

</pre></td></tr></tbody></table>

运行这个例子，将可以看到控制台打印出来的数据，我们通过下面几个部分来分析代码。

可观察状态（State）
------------

在上面的例子中，定义了一个 Store 类作为数据存储，通过 `@observable` 修饰器可以将其中的属性转变为可观察的状态值，其语法为：

<table><tbody><tr><td><pre>@observable  classProperty = value

</pre></td></tr></tbody></table>

`@observable` 接受任何类型的 js 值（原始类型、引用、纯对象、类实例、数组和、maps），observable 的属性值在其变化的时候 mobx 会自动追踪并作出响应。

当 value 是一个对象类型值的时候，它会默认克隆该对象并且把其中每个属性变为可观察的值，这里默认是深拷贝，也就是说其对象的后代属性都会变成可观察的，比如 `@observable classProperty = { obj: { name: 'q' } }` ，当 `classProperty.obj.name` 改变的时候，在 MobX 中也是可以观察到并响应的；

当然在这里可以加一些调节器来做一些配置：

*   @observable.deep （默认）对对象进行深拷贝；
*   @observable.shallow 它只对对象进行浅拷贝；
*   @observable.ref 禁用对象的自动转化，只转化其引用；

这里需要注意的是，当定义好其 observable 的对象值后，对象中后来添加的值是不会变为可观察的，这时需要使用 extendObservable 来扩展对象：

<table><tbody><tr><td><pre>const { observable, action, computed, autorun, extendObservable } = mobx;

class Store {
  @observable oo = {
    name: 1
  }
};

const mstore = new Store();

extendObservable(mstore, {
  oo: {
    age: 0
  }
});

var i = 1;
setInterval(() =&gt; {
  mstore.oo.age = i++;
}, 2000);

autorun(() =&gt; {
  console.log(mstore.oo.age);
});

</pre></td></tr></tbody></table>

计算属性值（Computed Values）
----------------------

计算属性值实际上是一类衍生值，它是根据现有的状态或者其他值计算而来，原则上在计算属性中尽可能地不对当前状态做任何修改；  
同时对于任何可以通过现有状态数据得到的值都应该通过计算属性获取。  
语法为：`@computed get computesValue [function]`；

如上面的例子中，只需要获取其 list 属性的总数 total 的时候，我们可以根据其 list 来计算出 total，

<table><tbody><tr><td><pre>class Store {
  @observable list = []
  @computed get total() {
    return this.list.length;
  }
  @action change () {
    this.list.push(this.list.length);
  }
};

autorun(() =&gt; {
  console.log(mstore.total);
});

</pre></td></tr></tbody></table>

同时，当状态改变使得计算属性的值发生改变的时候，其也是可观察到的。

在 store 对象中，还可以定义 state 属性的 setter：

<table><tbody><tr><td><pre>class Store {
  @observable length = 2;
  @computed get squared() {
    return this.length * this.length;
  }
  set squared(value) {
    this.length = Math.sqrt(value);
  }
}

</pre></td></tr></tbody></table>

在每次改变 Store.squared 的时候，会先运行 `set squared` 函数，从而改变 Store 中的 state。

动作（Action）
----------

在 MobX 中，对于 store 对象中可观察的属性值，在他们改变的时候则会触发观察监听的函数，这里注意两点：

*   该属性必须是定义的可观察属性（@observable）
*   它的值必须发生改变（和原值是不等的）：

<table><tbody><tr><td><pre>class Store {
  @observable list = []
  @observable name = '2'
  @observable oo = {
    age: 1
  }
};

const mstore = new Store();

// 触发观察监听的函数
mstore.list.push('1');

// 或者
mstore.name = 'h';

// 或者
mstore.oo.age = 12;

// 这个情况下是不会触发观察，因为 age 属性并不可观察
mstore.age = 10;

// 这个情况下也不会触发观察，因为其值没有发生变化
mstore.oo.age = 1;

</pre></td></tr></tbody></table>

在 MobX 中，其本身并不会对开发者作出任何限制去如何改变可观察对象；  
但是，它还是提供了一个可选的方案来组织代码与数据流，`@action`，其规定对于 store 对象中所有可观察状态属性的改变都应该在 `@action` 中完成，它使代码可以组织的更好，并且对于数据改变的时机也更加清晰。

语法形式：`@action actionFuncName[function]`

<table><tbody><tr><td><pre>const { observable, action, computed, autorun } = mobx;

class Store {
  @observable list = []
  @computed get total() {
    return this.list.length;
  }
  @action change (i) {
    this.list.push(i);
  }
};
const mstore = new Store();

var i = 0;
autorun(() =&gt; {
  console.log(mstore.total);
});

mstore.change(i++);

</pre></td></tr></tbody></table>

可以看到，这里将 store 中 list 属性的改变都放在 `@action change` 函数之中，外加只需要调用该函数即可。

运行观察（autorun）
-------------

在上面的例子中，当触发了可观察状态属性的改变后，其变化的监听则是在传入 autorun 函数中作出响应。

autorun 接受一个函数作为参数，在使用 autorun 的时候，该函数会被立即调用一次，之后当该函数中依赖的可观察状态属性（或者计算属性）发生变化的时候，该函数会被调用，注意，该函数的调用取决的函数中使用了哪些可观察状态属性（或者计算属性）。

例子 1：

<table><tbody><tr><td><pre>const { observable, action, computed, autorun } = mobx;

class Store {
  @observable count = 0;
  @action add () {
    this.count = this.count + 1;
  }
};

const mstore = new Store();

setInterval(() =&gt; {
 mstore.add();
}, 2000);

autorun(() =&gt; {
  console.log(mstore.count);
});

</pre></td></tr></tbody></table>

在该例子中，autorun 的函数依赖了 mstore.count 属性，该属性是可观察的，其每次变化都会加 1 ，因此其中的函数在第一次立即触发，之后每次改变 mstore.count 的值都会被触发；

例子 2：

<table><tbody><tr><td><pre>const { observable, action, computed, autorun } = mobx;

class Store {
  @observable count = 0;
  @computed get result() {
    return this.count + 100;
  }
  @action add () {
    this.count = this.count + 1;
  }
};

const mstore = new Store();

setInterval(() =&gt; {
 mstore.add();
}, 2000);

autorun(() =&gt; {
  console.log(mstore.result);
});

</pre></td></tr></tbody></table>

该例子中和 例子 1 是类似的，auto 中的函数依赖了计算属性 mstore.result ，其每次变化的时候也都会触发该函数；

例子 3:

<table><tbody><tr><td><pre>const { observable, action, computed, autorun } = mobx;

class Store {
  @observable count = 0;
  @computed get result() {
    return this.count + 100;
  }
  @action add () {
    this.count = this.count;
  }
};

const mstore = new Store();

setInterval(() =&gt; {
 mstore.add();
}, 2000);

autorun(() =&gt; {
  console.log(mstore.result);
});

</pre></td></tr></tbody></table>

在该例子中，只在使用 autorun 的时候触发了一次其传入的函数，之后即使调用 mstore.add() 也并未观察到，这是因为之后的调用中 mstore.result 并没有改变，所以不会触发观察；

例子 4:

<table><tbody><tr><td><pre>const { observable, action, computed, autorun } = mobx;

class Store {
  count = 0;
  @action add () {
    this.count = this.count;
  }
};

const mstore = new Store();

setInterval(() =&gt; {
 mstore.add();
}, 2000);

autorun(() =&gt; {
  console.log(mstore.count);
});

</pre></td></tr></tbody></table>

在该例子中也只是在使用 autorun 的时候调用了一次其传入的函数，之后 mstore.count 的值即使改变也并没有触发观察，这是因为 mstore.count 并不是可观察的。

在实际使用中，autorun 中的函数就是用来操作 Reactions 的，当可观察状态属性的值发生改变的时候，可以在该函数中利用状态值来更新改变 UI 视图（记录日志、持久化），在 MobX 结合 React 的使用中，mobx-react 库则是封装了 autorun 用来在 store 中的可观察状态属性值发生改变的时候 rerender React 组件。

异步行为
====

在很多时候，比如网络请求 ，其 Actions 行为是异步的，这里通过以下一个例子说明如何编写异步的 Action：

<table><tbody><tr><td><pre>import { observable, action } from "mobx";
import axios from "axios";

export default class Store {
  @observable authenticated;
  @observable authenticating;
  @observable items;
  @observable item;

  @observable testval;

  // 初始化 state
  constructor() {
    this.authenticated = false;
    this.authenticating = false;
    this.items = [];
    this.item = {};

    this.testval = "Hello";
  }

  async fetchData(pathname, id) {
    let { data } = await axios.get(
      `localhost:3000/${pathname}`
    );
    data.length &gt; 0 ? this.setData(data) : this.setSingle(data);
  }

  @action setData(data) {
    this.items = data;
  }

  @action setSingle(data) {
    this.item = data;
  }

  @action clearItems() {
    this.items = [];
    this.item = {};
  }

  @action authenticate() {
    return new Promise((resolve, reject) =&gt; {
      this.authenticating = true;
      setTimeout(action(() =&gt; {
        this.authenticated = !this.authenticated;
        this.authenticating = false;
        resolve(this.authenticated);
      }), 100);
    });
  }
}

</pre></td></tr></tbody></table>

在 React 中使用 MobX
================

在 React 中使用 MobX 需要用到 mobx-react。  
其提供了 Provider 组件用来包裹最外层组件节点，并且传入 store（通过）context 传递给后代组件：

<table><tbody><tr><td><pre>import { Provider } from 'mobx-react';
const stores = {
  ...
};

ReactDOM.render((
  &lt;Provider {...stores}&gt;
    &lt;App /&gt;
  &lt;/Provider&gt;
), document.getElementById('root'));

</pre></td></tr></tbody></table>

使用 `@inject` 给组件注入其需要的 store（利用 React context 机制）；  
通过 `@observer` 将 React 组件转化成响应式组件，它用 mobx.autorun 包装了组件的 render 函数以确保任何组件渲染中使用的数据变化时都可以强制刷新组件：

<table><tbody><tr><td><pre>import React from 'react';
import { inject, observer } from 'mobx-react';

@inject('userStore', 'commonStore')
@observer
export default class App extends React.Component {

  componentWillMount() {
    if (this.props.commonStore.token) {
      this.props.userStore.pullUser()
        .finally(() =&gt; this.props.commonStore.setAppLoaded());
    } else {
      this.props.commonStore.setAppLoaded();
    }
  }

  render() {
    if (this.props.commonStore.appLoaded) {
      return (
        &lt;div&gt;
          ...
          {this.props.children}
        &lt;/div&gt;
      );
    }
    return (
      ...
    );
  }
}

</pre></td></tr></tbody></table>

TIP
===

useStrict
---------

在 mobx 中，可以有很多种方式去修改 state，mobx 并不对其做限制；  
但是如果使用了严格模式：

<table><tbody><tr><td><pre>import { useStrict } from 'mobx';

useStrict(true);

</pre></td></tr></tbody></table>

那么将会限制开发者只能通过 @action 来修改 state，这将会更有利于组织代码以及使数据流更清晰。

总结
==

MobX 的理念是通过观察者模式对数据做出追踪处理，在对可观察属性的作出变更或者引用的时候，触发其依赖的监听函数，在 React 中既是在 @observer 中对组件进行数据更新并渲染到视图层面，其核心与开发模式和 Vue 非常相似。

相比于 [Redux](https://so.csdn.net/so/search?from=pc_blog_highlight&q=Redux) 纯函数的形式，它在代码层面却是给开发者减少了不少工作量，但在多人维护的大项目中，个人认为还是 Redux 更加有利，一旦项目中的数据交互增多，其在 MobX 中对于数据流的变化就变得难以理清，而只能依靠约定来限制触发场景。

在 Redux 于 MobX 的选择中，其两者还是各具优势同时也各有缺点，而如何进行抉择还应该结合项目需求与业务场景。

参考
==

*   [http://mobx.js.org/](http://mobx.js.org/)
*   [http://cn.mobx.js.org/](http://cn.mobx.js.org/)
*   [https://github.com/mhaagens/react-mobx-react-router4-boilerplate](https://github.com/mhaagens/react-mobx-react-router4-boilerplate)

转载请注明来源：[https://qiutc.me/post/efficient-mobx.html](https://qiutc.me/post/efficient-mobx.html)