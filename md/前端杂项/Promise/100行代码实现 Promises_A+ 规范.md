> 本文由 [简悦 SimpRead](http://ksria.com/simpread/) 转码， 原文地址 [mp.weixin.qq.com](https://mp.weixin.qq.com/s?__biz=MzA4Njc2MTE3Ng==&mid=2456151398&idx=1&sn=c3351d6c9eb166035f2fa97a1b0b3a0a&scene=21#wechat_redirect)

作为 Modern JavaScript 基础设施的一部分，Promises 对前端开发者而言异常重要。

它是 async/await 语法的基础，是 JavaScript 中处理异步的标准形式。并且，未来的 Web API，只要是异步的，都会以 Promises 的形式出现。

如果不理解 Promises 相关的知识和运行机制，将来可能无法完成 Web 开发的日常工作。

因此，Promises 成为了前端面试中的必问问题之一。在网络上，也可以搜索到很多 Promises 的技术文章。甚至一些前端付费教程，以教你从零实现 Promises/A+ 规范作为卖点。

Promises/A+ 规范，有现成的单元测试套件，很容易搭建开发环境，以及验证代码是否符合规范要求。

对于已经理解 Promises 的开发者来说，实现 Promises/A+ 是一个有益的训练。

不过，如果一个初学者，想通过实现 Promises/A+ 去学习 Promises。或者认为实现了 Promises/A + 规范后，对 Promises 的理解水平能得到质的提升。

最后可能会失望。

实际上，Promises/A+ 规范，内容简短，实现难度低。其中充斥着细节行为的描述，缺乏设计目的和背景的部分，完全没有介绍使用场景。并不是一个入门 Promises 的好材料。

即便成功实现 Promises/A+ 规范，也不一定比没实现过的开发者，更善于使用 Promises 特性。

本文将分成三部分。第一部分，演示用 100 行以内的代码，实现 Promises/A + 规范。第二部分，澄清开发者对 Promises 的几个迷思。第三部分进行总结。

**1、实现 Promises/A+ 规范**

**1.1、前期工作**

> An open standard for sound, interoperable JavaScript promises
> 
> https://promisesaplus.com

通过上面的地址，可以查看规范内容。

通过 npm install promises-aplus-tests ，可以下载测试套件。

![](https://mmbiz.qpic.cn/mmbiz_png/PeB3s8AJwnaVickrkAHBKKnqOe8XNtAjNC9HHUAsWAVBwF9RnqAUZoSZzY5taMbgkkdnTYUzvSGAfMZXqhjBbBg/640?wx_fmt=png)

通过 npm run test 运行测试套件。  

**1.2、了解术语**  

![](https://mmbiz.qpic.cn/mmbiz_png/PeB3s8AJwnaVickrkAHBKKnqOe8XNtAjN5HLKzccib8l0yhdibbEib1JJ91LIWludMvUeP0WHnP3S9MqVglmOuxOIQ/640?wx_fmt=png)

规范的第一部分，描述了几个术语的意思。  

promise 是一个包含 then 方法的对象或函数，该方法符合规范指定的行为。  

thenable 是一个包含 then 方法和对象或者函数。

value 就是任意合法 JS 值。  

exception 就是 throw 语句抛出的值。

reason 是一个指示 promise 为什么被 rejected 的值。  

这部分没有需要落实到代码的地方，继续看下去。  

**1.3 Promise 状态**  

![](https://mmbiz.qpic.cn/mmbiz_png/PeB3s8AJwnaVickrkAHBKKnqOe8XNtAjNOIf7zC3PZz6cS4UFY8gictmHmm2nIrwKQcuTKsNT3tLF1kjDTSiahYmQ/640?wx_fmt=png)

promise 有 3 个状态，分别是 pending, fulfilled 和 rejected。  

在 pending 状态，promise 可以切换到 fulfilled 或 rejected。

在 fulfilled 状态，不能迁移到其它状态，必须有个不可变的 value。

在 rejected 状态，不能迁移到其它状态，必须有个不可变的 reason。

![](https://mmbiz.qpic.cn/mmbiz_png/PeB3s8AJwnaVickrkAHBKKnqOe8XNtAjNcUOAR5FHTym2CBzwW3iaRhIDE4wXjr3wkFyDPa6w2POjzyxNUiaOlJZA/640?wx_fmt=png)

落实到代码上，大概像上面那样：

有 3 个常量 pending, fulfilled, rejected，

一个 Promise 构造函数，有 state 和 result 两个属性。

当 state 为 fulfilled 时，result 作为 value 看待。

当 state 为 rejected 时，result 作为 reason 看待。  

一个 transition 状态迁移函数，它只会在 state 为 pending 时，进行状态迁移。  

如上，其实并没有多少自由发挥的空间。不管由谁来编写，仅仅是变量名，代码行数上的微小差异。  

**1.4、Then 方法**

![](https://mmbiz.qpic.cn/mmbiz_png/PeB3s8AJwnaVickrkAHBKKnqOe8XNtAjN3lchdymO1GbQx87SsQ4lM0s1xj5lNSyShN3jX4yBS8ibQOqtTga1lAw/640?wx_fmt=png)

promise 必须有 then 方法，接受 onFulfilled 和 onRejected 参数。  

那就像下面那样，新增一个 then 的原型方法。

![](https://mmbiz.qpic.cn/mmbiz_png/PeB3s8AJwnaVickrkAHBKKnqOe8XNtAjNXvnCJYo3St3tvCnWcCQCCzQy5TftB0LdVZOmsQXOdckp2c1eSW4yYA/640?wx_fmt=png)

onFulfilled 和 onRejected 如果是函数，必须最多执行一次。

onFulfilled 的参数是 value，onRejected 函数的参数是 reason。

then 方法可以被调用很多次，每次注册一组 onFulfilled 和 onRejected 的 callback。它们如果被调用，必须按照注册顺序调用。

![](https://mmbiz.qpic.cn/mmbiz_png/PeB3s8AJwnaVickrkAHBKKnqOe8XNtAjNeBUsjmb528WKiaRQjuicbSn3bFRiasiaI9srTzlBib0Ynib55Ncwjay9A6JQ/640?wx_fmt=png)

那就像上面那样，为 Promise 新增一个 callbacks 数组记录。

![](https://mmbiz.qpic.cn/mmbiz_png/PeB3s8AJwnaEWErNQ8KfAkoknJeljoNObukMZUVtEzmiaGdtDxibgbexjBbU3NibxlV8ChuR4uTVkSJqts5YbkbicA/640?wx_fmt=png)

then 方法必须返回 promise。

那 then 实现丰富化成下面这样：

![](https://mmbiz.qpic.cn/mmbiz_png/PeB3s8AJwnaVickrkAHBKKnqOe8XNtAjNJDBiaEwSqMicGQUOYR0534qR9xMxiakgHsf9OjFkY1f0whMbLsHTExibcg/640?wx_fmt=png)

在 then 方法里，return new Promise(f)，满足 then 必须 return promise 的要求。

当 state 处于 pending 状态，就储存进 callbacks 列表里。

当 state 不是 pending 状态，就扔给 handleCallback 去处理。

至于 handleCallback 是什么。其实不重要，我们只需要知道，它一定存在。我们总得做一些处理，不是写死在 then 函数里，就是在外部的辅助函数里。

至于为啥要套个 setTimeout 呢？

因为 then 方法里，还有一个重要约束是：  

onFulfilled or onRejected must not be called until the execution context stack contains only platform code.

我们不是在 JS 引擎层面实现 Promises，而是使用 JS 去实现 JS Promises。在 JS 里无法主动控制自身 execution context stack。可以通过 setTimeout/nextTick 等 API 间接实现，此处选用了 setTimeout。

then 方法返回的 promise，也有自己的 state 和 result。它们将由 onFulfilled 和 onRejected 的行为指定。

![](https://mmbiz.qpic.cn/mmbiz_png/PeB3s8AJwnaEWErNQ8KfAkoknJeljoNOibVsLrcWdgdpiapGEdPlQxcN6mp1hamzHAlA2uKLNJbPgqic48NOQPQqQ/640?wx_fmt=png)

这正是 handleCallback 要做的部分。  

![](https://mmbiz.qpic.cn/mmbiz_png/PeB3s8AJwnaVickrkAHBKKnqOe8XNtAjNFutqsvBQeoSvtzE3LQKNUjgNj6FkBq4LLyib2ew1bqPdWkuL4s4OeHA/640?wx_fmt=png)

handleCallback 函数，根据 state 状态，判断是走 fulfilled 路径，还是 rejected 路径。  

先判断 onFulfilled/onRejected 是否是函数，如果是，以它们的返回值，作为下一个 promise 的 result。

如果不是，直接以当前 promise 的 result 作为下一个 promise 的 result。

如果 onFulfilled/onRejected 执行过程中抛错，那这个错误，作为下一个 promise 的 rejected reason 来用。

then 方法核心用途是，构造下一个 promise 的 result。

我们的代码，几乎没有多余的处理逻辑，忠实的完成规范指定的行为。

**1.4、The Promise Resolution Procedure**

从上面的截图里，我们还看到了 The Promise Resolution Procedure 的说法。

它描述的是，一些特殊的 value 被 resolve 时，要做特殊处理。这个特殊处理，规范也明确描述了。

![](https://mmbiz.qpic.cn/mmbiz_png/PeB3s8AJwnaVickrkAHBKKnqOe8XNtAjNkibK8h4Qxawz0DPf84SlHD4cEX6rJjmXhpt6x2hddvn7wbRPjt2ibSEQ/640?wx_fmt=png)

第一步，如果 result 是当前 promise 本身，就抛出 TypeError 错误。

![](https://mmbiz.qpic.cn/mmbiz_png/PeB3s8AJwnaVickrkAHBKKnqOe8XNtAjN3xcs3jo2kpYCaMbUfdkBuV2Ko4R6NcnhAARwIRGzqwIgUXv8I9xh7A/640?wx_fmt=png)

第二步，如果 result 是另一个 promise，那么沿用它的 state 和 result 状态。

![](https://mmbiz.qpic.cn/mmbiz_png/PeB3s8AJwnaVickrkAHBKKnqOe8XNtAjNMqt0glpepCzMqDCdib78TrJ16gbiaUZVmcbzFR5pDe3ccBMt0vXnWgfQ/640?wx_fmt=png)

第三步，如果 result 是一个 thenable 对象。先取 then 函数，再 call then 函数，重新进入 The Promise Resolution Procedure 过程。

最后，如果不是上述情况，这个 result 成为当前 promise 的 result。  

![](https://mmbiz.qpic.cn/mmbiz_png/PeB3s8AJwnaVickrkAHBKKnqOe8XNtAjNr1QAzREMvH3NdOcibjUCmlAiawEQwEY4qdgYUiaDngEl4G0ef0yxMtATQ/640?wx_fmt=png)

用代码描绘起来，如上所示，按照规范描述的顺序，编写 3 个 if。

第一个判断 result 是不是 promise 本身，是就抛 TypeError 错误。

第二个判断 result 是不是 promise 类型，是就调用 then(resolve, reject) 取它的 value 或 reason。

第三个判断 result 是不是 thenable 对象，是就先取出 then，再用 new Promise 去进入 The Promise Resolution Procedure 过程。

若都不是，则直接 resolve result。

**1.5、整合剩余部分**  

至此，所有重要部分，都已经被处理。

1）我们有了 transition 对单个 promise 进行状态迁移。

2）我们有了 handleCallback ，在当前 promise 和下一个 promise 之间进行状态传递。

3）我们有了 resolvePromise，对特殊的 result 进行特殊处理。

接下来，我们只需要整合一下，把各部分衔接起来即可。  

其中，Promise 构造函数，扩充如下：

![](https://mmbiz.qpic.cn/mmbiz_png/PeB3s8AJwnaVickrkAHBKKnqOe8XNtAjNJia2r7vVkq1aqsdWCUrWticUicXyH3f5wbUoVZsW1Eic0kcZzUmqG7ibJwQ/640?wx_fmt=png)

构造 onFulfilled 去切换到 fulfilled 状态，构造 onRejected 去切换到 rejected 状态。  

构造 resolve 和 reject 函数，在 resolve 函数里，通过 resolvePromise 对 value 进行验证。

配合 ignore 这个 flag，保证 resolve/reject 只有一次调用作用。

最后将 resolve/reject 作为参数，传入 f 函数。

若 f 函数执行报错，该错误就作为 reject 的 reason 来用。

![](https://mmbiz.qpic.cn/mmbiz_png/PeB3s8AJwnaVickrkAHBKKnqOe8XNtAjNv9QbyvDopfBN7VYECHeoiaKWNfCAxfTicR0cUEFLKqqDpGRCg0pyOYKQ/640?wx_fmt=png)

transition 函数扩充如上，当状态变更时，异步清空所有 callbacks。

之前我们已经实现了 handleCallback，实现 handleCallbacks 只需要一个循环。

![](https://mmbiz.qpic.cn/mmbiz_png/PeB3s8AJwnaVickrkAHBKKnqOe8XNtAjNqGicOBFhlxErT7KLFk0T0vXo8HxM6ynqic9ohpSicu8TJJT1gDSkmmxvA/640?wx_fmt=png)

运行测试套件后，全部 passing。

Promises/A+ 规范实现完毕。（可以点击【阅读原文】，查看全部源码）

**1.6、ES2015 Promises**  

Promises/A+ 规范跟 ES2015 Promises 不完全等价。在 A+ 规范里，并没有描述 catch 方法，以及 Promsie.resolve,  Promise.reject, Promise.all, Promise.race 等静态方法。  

甚至，new Promise 这种用法都不是 A+ 规范的内容，只是恰好我们现在用 ES2015 Promises 风格去实现。

ES2015 Promises 兼容 Promises/A+ 规范，并做了自己的扩充。

有了 then 方法，我们可以很容易实现 ES2015 Promises 的几个扩充方法。  

![](https://mmbiz.qpic.cn/mmbiz_png/PeB3s8AJwnaVickrkAHBKKnqOe8XNtAjNxibdrmOuib4Ib5c2ZT8mg1vtBltzsRFa18WuGMrVJHiamLjZX2kN8sWIw/640?wx_fmt=png)

catch 方法和 resolve/reject 静态方法的实现如上所示。Promise.all 和 Promise.race 的实现，留给感兴趣的读者，作为练习。

**2、澄清迷思**

**2.1、能手写 promises 实现，一定精通 promises？**  

在计算机行业，盛行着一种朴素还原论的迷思。即认为越接近底层，技术含量越高。每个程序员都有读懂底层源代码的追求。

这在一定程度上是正确的。不过，我们也应该看到，一旦底层和表层之间，形成了领域鸿沟。精通底层，并不能代表在表层的水平。

比如游戏的开发者，不一定是游戏中的佼佼者。这在 FPS 射击游戏或者格斗游戏里尤为明显，这些游戏里的绝大部分顶尖玩家，完全不会写代码。

如果将精通 promises 定义为，善于在各种异步场景中使用 promises 解决问题。  

那么，能手写 promises 实现，对精通 promises 帮助不大。

Promise/A+ 规范，重点围绕的是 How to implement。

而不是 How to use。

通过实现规范，或者所谓的吃透底层源码，以期打通任督二脉的武学幻想，是不切实际的。  

想要精通 promises，还得在日常开发的各个异步场景中，多加思考和训练。  

有同学一定好奇，如何解释许多精通某技术的开发者，确实能读懂和实现规范？

其实，这是一个典型的【把相关当因果】的案例。

他们不是因为读懂和实现了规范而精通。而是精通该技术使他们产生读规范和实现规范的兴趣。

很少看到有电工试图通过学习电磁学，去精通电工实操，却常常看到开发者框架都还没玩熟，就想啃框架源码，代码还写得一塌糊涂，就想看语言规范。

想跳过扎实的学习和训练过程，直接走最后一步。有点像企图通过只吃最后一那口饭，来吃饱。  

**2.2、promises 是比 callback 更先进的异步方案？**  

网络上，许多文章介绍 JavaScript 里的异步方案的演进时，是用下面这种顺序：  

callback -> promise -> generator -> async/await

其中，callback 被认为是最差的方案，而 async/await 则是所谓的异步终极解决方案。

从流行趋势来看，这种说法不无道理。我们确实从 callback style 一步步走到了今天大量 async/await 的阶段。

不过，有些一些有趣的内容，我们可以了解一下。

**2.2.1、promises 也属于 callback style 的一种**

在 Promises/A+ 规范的第一段，我们能看到一个明确的表述：  

![](https://mmbiz.qpic.cn/mmbiz_png/PeB3s8AJwnaEWErNQ8KfAkoknJeljoNOEPG22k41UTIBUUUPNHb9C4N1AlDh9ySEy7SGAwJXYsMkCdjVg9fGxA/640?wx_fmt=png)

promise 是通过 then 方法去注册 callbacks，其中 onFulfilled callback 处理 value，而 onRejected callback 处理 reason。  

我们一直诟病的 callback style，通常是指 nodejs 那种 Error-First Callbacks，或者其它 raw callback。

![](https://mmbiz.qpic.cn/mmbiz_png/PeB3s8AJwnaEWErNQ8KfAkoknJeljoNOEpI4Kib7ErKtK3HNVa8ZbBiavfdlwLAnMYclRuljQh0lEIyJ8xrl8eDw/640?wx_fmt=png)

callback 自身是一个很宽泛的概念。

仿照 state management 的说法，我们可以将 promises 理解为是一种 callback management。

而 rxjs 则是另一种 callback management，相比 promises 只关心单个异步操作的 value 和 reason，rxjs 可以胜任多个异步操作的 value, error 和 complete 信号。

如果说 promises 可以处理 0~1 个异步结果，rxjs 则可以处理 0~Infinite 无限多个异步结果。  

一个很合理的设想是，我们能否用 rxjs 实现 Promises/A+ 规范？

看起来，无非是缩小 rxjs 的处理范围罢了。

答案是，可以的。

![](https://mmbiz.qpic.cn/mmbiz_png/PeB3s8AJwnaEWErNQ8KfAkoknJeljoNOtCAtoPHEVhqKJCQ2AaEooHzWrHlv9lvyqh7iag4NWHU3E4vnS8oFIhg/640?wx_fmt=png)

如上，我们可以将 rxjs 的 observable 封装成 promise style 的 api，在内部用 merge 组合 value$ 和 reason$ 为 result$，利用 rxjs 的 subscribe 机制，处理 promises 的 onFulfilled 和 onRejeted 两个 callbacks。  

（点击【阅读原文】，可以查看代码仓库，了解 rxjs-based 的 Promises/A+ 实现）。

如果将 promises 视为一种 callback management，那么之前我们认为的

callback -> promise 的演进，就变成了用一种 callback style 取代另一种 callback style 的过程。 

**2.2.2、generator function 也是一种 callback style**  

基于 generator + promise 的异步解决方案，可以实现用同步的写法，编写异步代码的效果。比如用 tj 的 co 库：  

```
co(function* () {
  var result = yield Promise.resolve(true);
  return result;
}).then(function (value) {
  console.log(value);
}, function (err) {
  console.error(err.stack);
});

```

这种妙用，正是源于 generator function 的 callback 特征。

![](https://mmbiz.qpic.cn/mmbiz_png/PeB3s8AJwnaEWErNQ8KfAkoknJeljoNO5XSVQOqIIaibZia89qsBDvliaRxfau5aBoa1jrCTic5J5ULVSjFCyBCUfA/640?wx_fmt=png)

generator function 可视为多个 callback 函数的整合，它返回一个 generator 对象，该对象包含 next, throw 和 return 三个方法，其中 generator.next(value) 把 value 发送给 generator function。

这个过程是不断的消费由 yield 关键字切割出来的多个 callback 函数的过程。

乍看可能难以理解，我们可以看一个简单案例。

![](https://mmbiz.qpic.cn/mmbiz_png/PeB3s8AJwnaEWErNQ8KfAkoknJeljoNO4F9e9yzmUricibiakBqpEyHYqHavwwwlhpqM5iaOoQ3b7rnI3WP3opxyyg/640?wx_fmt=png)

如上图所示，我们通过 yield 输出了 3 个值给外部，并从外部获取了 3 个值，然后 return 我们收集到的所有外部输入。  

如果我们去掉 * 号和 yield 语法糖，用朴素的函数来表示，一种简化形式如下：  

![](https://mmbiz.qpic.cn/mmbiz_png/PeB3s8AJwnaEWErNQ8KfAkoknJeljoNOBU3l4xlCXkiczmQiblAbvrBOIpom9j5vqR3dMaLgib0vgZl5KALBlJWXg/640?wx_fmt=png)

如上，我们构造了一个嵌套了 4 层的 callback，然后在 next 函数的 4 次调用中，分别解开每一层，最后清空了 callback 的层次。实现了与前面的 generator function 相似的行为。

我们的处理是过度简化的。只做了 next 方法，没有提供 throw 和 return 方法，也没有演示如何处理循环语句里的 yield，但基本思路是一致的。

我们可以把 generator function 视为将嵌套的 callback 用 yield 关键字扁平化的语法糖。  

这种处理不是 JavaScript 里特有的，早在 20 多年前的上世纪 90 年代，Haskell 里就用 do-notation 这种语法糖，将嵌套的 bind operator 扁平化。

![](https://mmbiz.qpic.cn/mmbiz_png/PeB3s8AJwnaEWErNQ8KfAkoknJeljoNOBreuGYbyb7TtrYcwCSia7OZqbTXsRWqCJE1TW7iax124WicuNsvbunf4g/640?wx_fmt=png)

通过 babel 编译，generator function 被 desugared 成下面这种样子：  

![](https://mmbiz.qpic.cn/mmbiz_png/PeB3s8AJwnaEWErNQ8KfAkoknJeljoNOGxsbUPBNY7rkUGjSD0NcTJKE7oJDhGPWXPmYSIMnib106iam18pbIiaEg/640?wx_fmt=png)

它没有生成多个嵌套 callback，而是合成一个函数，通过 switch case 将它分割成多块，每次执行其中一个 case。相当于将多个 callback inline 到一起。  

如果说 generator function 是一个带着语法糖的 callback management，那么之前我们认为的 promise -> generator 的异步方案演进，可以理解成是一个带语法糖的 callback style 取代手动调用的 then 方法的 callback style。  

**2.2.3 async function 也是一种 callback style**  

至于 generator -> async/await 的演进，可以视为是对 promise + generator 这个方案的语义化和标准化。毕竟 * 号和 yield 关键字，并不能准确反映这是一个异步操作。

在 babel 的编译处理中，async/await 的编译结果，正是在 generator 的基础上，包装一层 asyncToGenerator 函数。

![](https://mmbiz.qpic.cn/mmbiz_png/PeB3s8AJwnaEWErNQ8KfAkoknJeljoNOusk0BFiaAWHJzWRXffBKp8Of88iaKOtKG10aVcsjYGjGtXXIEGlsBibpw/640?wx_fmt=png)

至此，我们可以将 JavaScript 里的异步方案演进的表述，重新梳理成如下形式：  

Raw Callback Style -> Promise Callback Style -> Generator Callback Style -> Async/Await Callback

它们分别是：

1）Raw Callback Style: 朴素函数作为 callback，接受 error, data 等参数。

2）Promise Callback Style：通过 {then} 对象，去处理 onFulfilled 和 onRejected 两个 callback 函数。

3) Generator Callback Style：通过 * 号和 yield 关键字，将多个嵌套 callback 扁平化的语法糖。  

4）Async/Await Callback Style：通过 async 和 await 关键字，将 Promise  + Generator Callback Style 语义化和标准化的产物。

新的表述跟旧的表述，总体上是一致的。只是描述口径从 4 个不同事物的演进，变成了同种事物的不同形态的演进。

在这个主流演进路径之外，还存在 Rxjs Callback Style 等其它形态。

对 callback 的本质和背后的概念感兴趣的同学，可以搜索 Continuation 这个术语。  

**2.3、async/await 是异步终极解决方案？**

我不太确定当人们说 async/await 是异步终极解决方案时，所描述的终极在什么维度上衡量。

如果是指表达能力的维度，有几个有趣的事实，我们可以了解一下。

**2.3.1 generator function 比 async function 更普适**  

语义化和标准化，不意味着能力的增强，它也有可能导致能力的减弱。  

async/await 是能力减弱的案例。

generator function 即能支持同步行为，也能支持异步行为。

async function 只支持异步行为。

对于 tj 的 co 库来说，promise 只是它最主要的异步数据源，co 还能从其它异步数据源中获取结果。比如 thunk 函数。

![](https://mmbiz.qpic.cn/mmbiz_png/PeB3s8AJwnaEWErNQ8KfAkoknJeljoNO2GlIzv2ke6pLflWdMdG9ibGL3bQ5mnlHzLL9bfcuibQaCCBXnqyc5u4Q/640?wx_fmt=png)

如上所示，当 yield 一个 thunk 函数时，co 会传递 done 这个 nodejs 风格的 callback 函数。

如果愿意，我们还可以支持 yield rxjs 的 observable 等对象。

这是因为 co 是一个 library 里，它可以尽可能利用 generator function 的一切特性，实现想要的拓展功能。

而 async/await 是一个新的语法，它必须建立在标准化的基础上，它必须拥有一致的语义。它需要做很多取舍，通过放弃对非标准化对象的支持，换取清晰的语义。

因此，async/await 只能从 promise 对象中获取异步数据结果，相比 co 是一种能力上的降低。

**2.3.2 裸写 promise 比 async/await 更灵活**  

尽管 90% 以上的异步场景下，async/await 都能胜任；然而，还是有一些场景，裸写 promise 更加灵活。  

最典型的案例就是并行的 promise 处理。

![](https://mmbiz.qpic.cn/mmbiz_png/PeB3s8AJwnaEWErNQ8KfAkoknJeljoNOjd3dTcGeicV8BgKJGE6l624jRxX1JJtnOflnfNIfHLegzcAhvibG1fUQ/640?wx_fmt=png)

如上，await 关键字总是串行，当我们想要依次获取 a, b 时，写起来是很简单。如果我们想同时获取 a 和 b 并等待其结果，await 关键字却难以处理。

我们得自行通过 Promise.all 将多个 promise 包装成单个。

![](https://mmbiz.qpic.cn/mmbiz_png/PeB3s8AJwnaEWErNQ8KfAkoknJeljoNOs1TlC7OzvQttAicGDQSQxmT4RqJcelicx5BAW4lI2YHvMswzgoibeTkQA/640?wx_fmt=png)

曾经有个 await* 的提案，作为 Promise.all 的语法糖。不过，并没有得到落地。

![](https://mmbiz.qpic.cn/mmbiz_png/PeB3s8AJwnaEWErNQ8KfAkoknJeljoNOamjolDHGujIrj2qKNQw9CARk5k6XOUgSUolexzFkn6IiazdoII3n3yw/640?wx_fmt=png)

仔细一想，很容易理解为什么上图的做法，难以落地。Promise.all 只是 promise 的其中一种组合方式，还有 Promise.race，Promise.allSettled 等组合。

如果为每个组合方式都分配一个符号作为语法糖，代码将更难以阅读。

因此，当需要组合多个 promise 时，裸写 promise 是一个必要措施。  

此外，async/await 是语法，不是值，因此它不能被存储和传递。而 promise 对象，可以存储在内存里，可以作为参数在函数中传递。

这种灵活性，在一些特殊场景下，可以带来便利。比如，我们可以通过缓存 promise 来缓存异步结果。  

![](https://mmbiz.qpic.cn/mmbiz_png/PeB3s8AJwnaEWErNQ8KfAkoknJeljoNOWv1TTic50S8efjbIpp8mCH4DPbIibBcZaDiaHCXpoBzBXFcib85ZkwAFKA/640?wx_fmt=png)

如上所示，我们建立了一个 map，存储 url -> promise 的映射。每次 get url 时，都查一下缓存。  

通过 async/await 语法的话，promise 对象被隐藏起来了。我们无法获取。最多等结果返回后，缓存 url -> result 的映射。

然而，这种做法的缓存覆盖面有空隙。当 get 请求触发，但结果还没抵达的过程中，又触发了多个相同的请求，这些请求无法命中缓存。

如果我们缓存的是 promise 对象，那么利用 promise 对象可以多次调用 then 方法的特性，我们能做到让所有 get url 获取到同一份异步请求结果。  

**2.3.3 裸写 callback 比 promise 更灵活**  

promise 的 then 只支持 onFulfilled 和 onRejected 两种 callback 路径，属于对所有可能的 callback 路径的简化。  

比如前面提到的 rxjs，observer 和 subscriber 有 {next, error, complete} 三个 callback 路径，能比 promise 处理更多 cases。

如果愿意手动管理 callback，在理论上我们能做到比 promise 更强大和灵活。

比如 cyclejs 作者提出的 callbag 模式，仅用多个 callback 函数的组合，就实现了 rxjs-like 的 observables and iterables。

![](https://mmbiz.qpic.cn/mmbiz_png/PeB3s8AJwnaEWErNQ8KfAkoknJeljoNOvMbhULFXGuUdW1yicEyXz12F55z6JTuAicxlp03xlSTIichUAkBtMaN2g/640?wx_fmt=png)

> A standard for JS callbacks that enables lightweight observables and iterables
> 
> https://github.com/callbag/callbag

感兴趣的同学，可以访问上面的链接，了解 callbag。

受到 callbag 的启发，rxjs v7.0 版本正在用相似的模式，进行内部重构。他们称这个模式为 Functional Observables。

> RxJS FObs (Functional Observables)
> 
> https://docs.google.com/document/d/1DBOhMQ89e2xtWNN0EqCHXOFn4QJjKZcXEvUivp4W2r0/edit#

感兴趣的同学，可以访问上面的链接，了解 rxjs v7.0 的设计思路（需翻墙）。

如上，我们可以看到，async/await 反而是表达能力最弱的一个，callback 则是最强的一个。

JavaScript 的异步方案演进史：  

Raw Callback Style -> Promise Callback Style -> Generator Callback Style -> Async/Await Callback

并非表达能力不断增强的过程，而是对开发者的友好程度不断增加的过程。  

Rxjs Callback Style 因为没有语法糖的支撑，且 operators 极多，出名的对新手不友好，因此一直难以成为主流方案。

而 Callbag Style 更为反人类，连源代码都不利于阅读。只适合由资深的开发者编写，隐藏在 library/framework 内部。

**2.3.4 语法糖是有代价的**

到目前为止，我们知道 async/await 语法可以视为多个 callback 函数组合的语法糖，可以简化我们编写的异步代码的复杂性。  

不过，这不是没有代价的。

JS 的编译器需要处理大量的场景，要识别关键字，要准确的处理异步的 throw error 和同步的 throw error 的差异。要让 async/await 能跟普通函数协调的工作，能跟 generator function 协调的工作。

async/await + generator function 又将组合出一个新的 async generator function，异步生成器。  

![](https://mmbiz.qpic.cn/mmbiz_png/PeB3s8AJwnaEWErNQ8KfAkoknJeljoNOz8F0O7Kmn5t5OLoct8fjJaWyODibgZ1hCFwy76snlUrf459gHVSkuoA/640?wx_fmt=png)

如上图所示，通过 async generators + for-await 语法，我们可以同时获得 async/await 的异步处理能力，和 generator 输出多个值的能力。

![](https://mmbiz.qpic.cn/mmbiz_png/PeB3s8AJwnaEWErNQ8KfAkoknJeljoNOiby5k4A9kAnnKxHGHLJWgJhibrK5GPkEOkU4JTNkg1siaiaZjxO9VteNeQ/640?wx_fmt=png)

有个库 axax 受到启发，基于 async generators 实现了 rxjs-like 的异步数据流方案。相比 rxjs 用 subscribe 方法去消费数据，axax 通过 for-await of 语法来消费。

> Async Iterator Extensions for JavaScript e.g. map, reduce, filter, flatMap, etc.
> 
> https://github.com/jamiemccrindle/axax

感兴趣的同学，可以点击上述链接，了解 axax。

如今，在 JavaScript 里，有多种函数类型：

1) plain function 普通函数

2) arrow function 箭头函数

3) generator function 生成器函数  

4) async function 异步函数  

5) async arrow function 异步箭头函数

6) async generator function 异步生成器函数  

不断新增的函数类型和语法，对编译器的迭代和优化提出了巨大挑战，也对 ECMAScript 语言新增特性带来了问题。所以我们能看到 async arrow function，却没有看到 generator arrow function，以及 async generator arrow function。  

将来增加更多函数类型，跟之前的函数类型进行排列组合，数量将会越来越多，协调多种函数类型将变得越来越难。

这是不是编程语言发展绕不开的问题呢？

不是的。还有其它路线，async/await 和 iterator 等特性可以作为 library 而不是 syntax 语法出现。

> Structured Asynchrony with Algebraic Effects
> 
> https://www.microsoft.com/en-us/research/wp-content/uploads/2017/05/asynceffects-msr-tr-2017-21.pdf

上述 Paper 描述了具备 Algebraic Effects 特性的 Koka 语言，可以通过 algebraic effect handlers 模拟包括 async/await 在内的诸多特性，以 library 而非 language syntax 的形式提供。不会显著增加编译器的负担。

React 即将发布的 Suspense 特性，即采用了上述能力，它内部通过 JS 里一些比较 hack 的方式去模拟 Algebraic Effects。可以实现在 render 函数里不需要 await 一个异步操作，也能通过某种途径，获取到异步结果，同时又不会影响 render 函数的幂等要求。  

虽然 Algebraic Effects 或 Koka 还未得到广泛的实践验证，不过它让我们看到了，当前的方案存在的问题以及可能的解决方案。

**3、总结**  

在这篇文章中，我们给出了 100 行以内的代码实现 Promise/A+ 规范的案例，我们澄清了几个关于 Promises 和 JS 里的异步方案的迷思。

我们重新梳理了在 JavaScript 里的异步方案演进史的表述。  

我们也了解到，async/await 并非异步终极解决方案，也不是异步数据处理能力最强的模式。只能说，它是当前对新手开发者友好的主流方案。

关于 Promises 还有好多话题可以讨论，比如它与函数式的 Monad 的关系，比如 Promise/A+ 规范中值得商榷和可以改进的部分等。篇幅所限，今天就到这里。

![](https://mmbiz.qpic.cn/mmbiz_png/PeB3s8AJwnb5nycAXkVr0pAsOjff7qib6o67QiblkggUJkPEOnfAgYc7vcEEtVp0bqRcUtWD4cEFGNwJ5AuWLyPQ/640?wx_fmt=png)