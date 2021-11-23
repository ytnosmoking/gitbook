> 本文由 [简悦 SimpRead](http://ksria.com/simpread/) 转码， 原文地址 [blog.csdn.net](https://blog.csdn.net/landl_ww/article/details/102158814)

一遍就能学会的 [react](https://so.csdn.net/so/search?from=pc_blog_highlight&q=react) hooks
===================================================================================

介绍
--

`react hooks` 是 `React 16.8` 的新增特性。 它可以让我们在函数组件中使用 `state` 、生命周期以及其他 `react` 特性，而不仅限于 `class` 组件

`react hooks` 的出现，标示着 `react` 中不会在存在无状态组件了，只有类组件和函数组件

对比
--

存在即合理，`hooks` 也不例外，它的出现，就代表了它要解决一些 `class` 组件的缺陷或者不足，那么我们先来看看 `class` 组件有什么不足或者问题存在

根据网上的说法我总结出三点，当然每种问题都有其解决方案

<table><thead><tr><th>问题</th><th>解决方案</th><th>缺点</th></tr></thead><tbody><tr><td>生命周期臃肿、逻辑耦合</td><td>无</td><td></td></tr><tr><td>逻辑难以复用</td><td>通过继承解决</td><td>不支持多继承</td></tr><tr><td></td><td>通过 hoc 解决</td><td>会增加额外的组件嵌套，也会有一些性能影响</td></tr><tr><td></td><td>渲染属性</td><td>同上、层级臃肿、性能影响</td></tr><tr><td><code>class</code> <code>this</code> 指向问题</td><td>匿名函数</td><td>每次都创建新的函数，子组件重复不必要渲染</td></tr><tr><td></td><td><code>bind</code></td><td>需要写很多跟逻辑、状态无关的代码</td></tr></tbody></table>

而 `hooks` 对这些问题都有较好的解决方案

1.  没有了 `class，` 自然就没有了 `this` 指向问题
2.  通过自定义 `useEffect` 来解决复用问题
3.  通过使用 `useEffect` 来细分逻辑，减小出现逻辑臃肿的场景

当然，`hooks` 是一把双刃剑，用的好自己能够达到效果，用的不好反而会 降低开发效率和质量，那么我们接下来看看如用更好的使用 `hooks` 吧

具体使用
----

### useState 的使用

#### 简单例子

`hooks` 的能力，就是让我们在函数组件中使用 `state`, 就是通过 `useState` 来实现的，我们来看一个简单的例子

```
  function App () {
    const [ count, setCount ] = useState(0)
    return (
      <div>
        点击次数: { count } 
        <button onClick={() => { setCount(count + 1)}}>点我</button>
      </div>
      )
  }

```

`useState` 的使用非常简单，我们从 `React` 中拿到 `useState` 后，只需要在使用的地方直接调用 `useState` 函数就可以， `useState` 会返回一个数组，第一个值是我们的 `state，` 第二个值是一个函数，用来修改该 `state` 的，那么这里为什么叫 `count` 和 `setCount`？一定要叫这个吗，这里使用了 `es6` 的解构赋值，所以你可以给它起任何名字，`updateCount`, `doCount`、`any thing`，当然，为了编码规范，所以建议统一使用一种命名规范，尤其是第二个值

#### 相同值

当我们在使用 `useState` 时，修改值时传入同样的值，我们的组件会重新渲染吗，例如这样

```
  function App () {
    const [ count, setCount ] = useState(0)
    console.log('component render count')
    return (
      <div>
        点击次数: { count } 
        <button onClick={() => { setCount(count)}}>点我</button>
      </div>
      )
  }

```

结果是不会，放心使用

#### useState 的默认值

`useState` 支持我们在调用的时候直接传入一个值，来指定 `state` 的默认值，比如这样 `useState(0)`, `useState({ a: 1 })`, `useState([ 1, 2 ])`，还支持我们传入一个函数，来通过逻辑计算出默认值，比如这样

```
function App (props) {
    const [ count, setCount ] = useState(() => {
      return props.count || 0
    })
    return (
      <div>
        点击次数: { count } 
        <button onClick={() => { setCount(count + 1)}}>点我</button>
      </div>
      )
  }

```

这个时候，就有小伙伴问了，那我组件每渲染一次，`useState` 中的函数就会执行一边吗，浪费性能，其实不会，`useState` 中的函数只会执行一次，我们可以做个测试

```
function App (props) {
    const [ count, setCount ] = useState(() => {
      console.log('useState default value function is call')
      return props.count || 0
    })
    return (
      <div>
        点击次数: { count } 
        <button onClick={() => { setCount(count + 1)}}>点我</button>
      </div>
      )
  }

```

结果是  
![](https://fx.inyoumall.com/admin/goods/picture/2019-10-02/4a97823f3c7ab9cc.png)

#### setUseState 时获取上一轮的值

我们在使用 `useState` 的第二个参数时，我们想要获取上一轮该 `state` 的值的话，只需要在 `useState` 返回的第二个参数，也就是我们上面的例子中的 `setCount` 使用时，传入一个参数，该函数的参数就是上一轮的 `state` 的值

```
  setCount((count => count + 1)


```

#### 多个 useState 的情况

`useState` 我们不可能只使用一个，当我们使用多个 `useState` 的时候，那 `react` 是如何识别那个是哪个呢，其实很简单，它是靠第一次执行的顺序来记录的，就相当于每个组件存放`useState` 的地方是一个数组，每使用一个新的 `useState`，就向数组中 `push` 一个 `useState`，那么当然，当我们在运行时改变、添加、减少 `useState` 时，`react` 还能正常执行吗

```
function App (props) {
  let count, setCount
  let sum, setSum
  if (count > 2) {
    [ count, setCount ] = useState(0)
    [ sum, setSum ] = useState(10)
  } else {
    [ sum, setSum ] = useState(10)
    [ count, setCount ] = useState(0)
  }
  return (
    <div>
      点击次数: { count } 
      总计：{ sum }
      <button onClick={() => { setCount(count + 1); setSum(sum - 1)}}>点我</button>
    </div>
    )
}

```

当我们在运行时改变 `useState` 的顺序，数据会混乱，增加 `useState`, 程序会报错

> 不要在循环，条件或嵌套函数中调用 `Hook`， 确保总是在你的 `React` 函数的最顶层调用他们。遵守这条规则，你就能确保 `Hook` 在每一次渲染中都按照同样的顺序被调用。这让 `React` 能够在多次的 `useState` 和 `useEffect` 调用之间保持 `hook` 状态的正确

同时推荐使用 `eslint-plugin-react-hooks` 插件来规范代码编写，针对这种情况进行校验

`useState` 的使用就是这么简单，我已经学会了, 接下来，我们看一下 `useEffect` 的使用

### useEffect 的使用

`Effect Hook` 可以让你在函数组件中执行副作用操作，这里提到副作用，什么是副作用呢，就是除了状态相关的逻辑，比如网络请求，监听事件，查找 `dom`

#### 简单例子

有这样一个需求，需要我们在组件在状态更新的时候改变 `document.title`，在以前我们会这样写代码

```
  class App extends PureComponent {
    state = {
      count: 0
    }

    componentDidMount() {
      document.title = count
    }

    componentDidUpdate() {
      document.title = count
    }
    render () {
      const { count } = this.state
      return (
        <div>
          页面名称: { count } 
          <button onClick={() => { this.setState({ count: count++ })}}>点我</button>
        </div>
      )
    }
  }

```

使用 `hooks` 怎么写呢

```
function App () {
  const [ count, setCount ] = useState(0)

  useEffect(() => {
    document.title = count
  })

  return (
    <div>
      页面名称: { count } 
      <button onClick={() => { setCount(count + 1 )}}>点我</button>
    </div>
    )
}

```

`useEffect` 是什么呢，我们先忽略，回到我们总结的 `class` 组件存在的问题，`useState` 只是让我们的函数组件具有使用 `state` 的能力，那我们要解决 `class` 组件存在的问题，先来解决第一个，生命周期臃肿的问题

#### useEffect 生命周期

> 如果你熟悉 `React class` 的生命周期函数，你可以把 `useEffect Hook` 看做 `componentDidMount`，`componentDidUpdate` 和 `componentWillUnmount` 这三个函数的组合。

以往我们在绑定事件、解绑事件、设定定时器、查找 `dom` 的时候，都是通过 `componentDidMount`、`componentDidUpdate`、`componentWillUnmount` 生命周期来实现的，而 `useEffect` 会在组件每次 `render` 之后调用，就相当于这三个生命周期函数，只不过可以通过传参来决定是否调用

其中注意的是，`useEffect` 会返回一个回调函数，作用于清除上一次副作用遗留下来的状态，如果该 `useEffect` 只调用一次，该回调函数相当于 `componentWillUnmount` 生命周期

具体看下面例子

```
  function App () {
    const [ count, setCount ] = useState(0)
    const [ width, setWidth ] = useState(document.body.clientWidth)

    const onChange = () => {
      
      setWidth(document.body.clientWidth)
    }

    useEffect(() => {
      window.addEventListener('resize', onChange, false)

      return () => {
        window.removeEventListener('resize', onChange, false)
      }
    })

    useEffect(() => {
      document.title = count
    })

    return (
      <div>
        页面名称: { count } 
        页面宽度: { width }
        <button onClick={() => { setCount(count + 1)}}>点我</button>
      </div>
      )
  }

```

接着我们前面的简单例子，我们上面例子要处理两种副作用逻辑，这里我们既要处理 `title`，还要监听屏幕宽度改变，按照 `class` 的写法，我们要在生命周期中处理这两种逻辑，但在 `hooks` 中，我们只需要两个 `useEffect` 就能解决这些问题，我们之前提到，`useEffect` 能够返回一个函数，用来清除上一次副作用留下的状态，这个地方我们可以用来解绑事件监听，这个地方存在一个问题，就是 `useEffect` 是每次 `render` 之后就会调用，比如 `title` 的改变，相当于 `componentDidUpdate`，但我们的事件监听不应该每次 `render` 之后，进行一次绑定和解绑，就是我们需要 `useEffect` 变成 `componentDidMount`, 它的返回函数变成 `componentWillUnmount`，这里就需要用到 `useEffect` 函数的第二个参数了

#### useEffect 的第二个参数

`useEffect` 的第二个参数，有三种情况

1.  什么都不传，组件每次 `render` 之后 `useEffect` 都会调用，相当于 `componentDidMount` 和 `componentDidUpdate`
2.  传入一个空数组 [], 只会调用一次，相当于 `componentDidMount` 和 `componentWillUnmount`
3.  传入一个数组，其中包括变量，只有这些变量变动时，`useEffect` 才会执行

具体看下面例子

```
  function App () {
    const [ count, setCount ] = useState(0)
    const [ width, setWidth ] = useState(document.body.clientWidth)

    const onChange = () => {
      setWidth(document.body.clientWidth)
    }

    useEffect(() => {
      // 相当于 componentDidMount
      console.log('add resize event')
      window.addEventListener('resize', onChange, false)

      return () => {
        // 相当于 componentWillUnmount
        window.removeEventListener('resize', onChange, false)
      }
    }, [])

    useEffect(() => {
      // 相当于 componentDidUpdate
      document.title = count
    })

    useEffect(() => {
      console.log(`count change: count is ${count}`)
    }, [ count ])

    return (
      <div>
        页面名称: { count } 
        页面宽度: { width }
        <button onClick={() => { setCount(count + 1)}}>点我</button>
      </div>
      )
  }

```

根据上面的例子的运行结果，第一个 `useEffect` 中的 `'add resize event'` 只会在第一次运行时输出一次，无论组件怎么 `render`，都不会在输出，第二个 `useEffect` 会在每次组件 `render` 之后都执行，`title` 每次点击都会改变， 第三个 `useEffect`, 只要有在第一次运行和 `count` 改变时，才会执行，屏幕发生改变引起的 `render` 并不会影响第三个 `useEffect`

### useContext

关于 `react` 中如何使用 `context`，这里就不细说，可以看我之前写的 [React 中 Context 的使用](https://github.com/landluck/react-go/blob/master/src/context/README.md)

`context` 中的 `Provider` 和 `Consumer`，在类组件和函数组件中都能使用，`contextType` 只能在类组件中使用，因为它是类的静态属性，具体如何使用 `useContext` 呢，看下面的例子

```
// 创建一个 context
const Context = createContext(0)

// 组件一, Consumer 写法
class Item1 extends PureComponent {
  render () {
    return (
      <Context.Consumer>
        {
          (count) => (<div>{count}</div>)
        }
      </Context.Consumer>
    )
  }
}
// 组件二, contextType 写法
class Item2 extends PureComponent {
  static contextType = Context
  render () {
    const count = this.context
    return (
      <div>{count}</div>
    )
  }
}
// 组件一, useContext 写法
function Item3 () {
  const count = useContext(Context);
  return (
    <div>{ count }</div>
  )
}

function App () {
  const [ count, setCount ] = useState(0)
  return (
    <div>
      点击次数: { count } 
      <button onClick={() => { setCount(count + 1)}}>点我</button>
      <Context.Provider value={count}>
        <Item1></Item1>
        <Item2></Item2>
        <Item3></Item3>
      </Context.Provider>
    </div>
    )
}

```

通过运行上面的例子，我们得到的结果是，三种写法都能够实现我们的需求，但是，三种写有各自的优缺点，下面为对比出的结果

<table><thead><tr><th>写法</th><th>优缺点</th></tr></thead><tbody><tr><td><code>consumer</code></td><td>嵌套复杂，<code>Consumer</code> 第一个子节点必须为一个函数，无形增加了工作量</td></tr><tr><td><code>contextType</code></td><td>只支持 类组件，无法在多 <code>context</code> 的情况下使用</td></tr><tr><td><code>useContext</code></td><td>不需要嵌套，多 <code>context</code> 写法简单</td></tr></tbody></table>

通过上面的比较，没理由继续使用 `consumer` 和 `contextType`

### useMemo

`useMemo` 是什么呢，它跟 `memo` 有关系吗， `memo` 的具体内容可以查看 [React 中性能优化、 memo、PureComponent、shouldComponentUpdate 的使用](https://github.com/landluck/react-go/tree/master/src/memo)，说白了 `memo` 就是函数组件的 `PureComponent`，用来做性能优化的手段，`useMemo` 也是，`useMemo` 在我的印象中和 `Vue` 的  
`computed` 计算属性类似，都是根据依赖的值计算出结果，当依赖的值未发生改变的时候，不触发状态改变，`useMemo` 具体如何使用呢，看下面例子

```
function App () {
  const [ count, setCount ] = useState(0)
  const add = useMemo(() => {
    return count + 1
  }, [count])
  return (
    <div>
      点击次数: { count }
      <br/>
      次数加一: { add }
      <button onClick={() => { setCount(count + 1)}}>点我</button>
    </div>
    )
}

```

上面的例子中，`useMemo` 也支持传入第二个参数，用法和 `useEffect` 类似

1.  不传数组，每次更新都会重新计算
2.  空数组，只会计算一次
3.  依赖对应的值，当对应的值发生变化时，才会重新计算 (可以依赖另外一个 `useMemo` 返回的值)

需要注意的是，`useMemo` 会在渲染的时候执行，而不是渲染之后执行，这一点和 `useEffect` 有区别，所以 `useMemo` 不建议有 副作用相关的逻辑

同时，`useMemo` 可以作为性能优化的手段，但不要把它当成语义上的保证，将来，`React` 可能会选择 “遗忘” 以前的一些 `memoized` 值，并在下次渲染时重新计算它们

### useCallback

`useCallback` 是什么呢，可以说是 `useMemo` 的语法糖，能用 `useCallback` 实现的，都可以使用 `useMemo`, 在 react 中我们经常面临一个子组件渲染优化的问题，细节可以查看 [React 中性能优化、 memo、PureComponent、shouldComponentUpdate 的使用](https://github.com/landluck/react-go/tree/master/src/memo)，尤其是在向子组件传递函数 props 时，每次 `render` 都会创建新函数，导致子组件不必要的渲染，浪费性能，这个时候，就是 `useCallback` 的用武之地了，`useCallback` 可以保证，无论 `render` 多少次，我们的函数都是同一个函数，减小不断创建的开销，具体如何使用看下面例子

```
const onClick = `useMemo`(() => {
  return () => {
    console.log('button click')
  }
}, [])

const onClick = useCallback(() => {
 console.log('button click')
}, [])

```

同样，`useCallback` 的第二个参数和`useMemo`一样，没有区别

### useRef

`useRef` 有什么作用呢，其实很简单，总共有两种用法

1.  获取子组件的实例 (只有类组件可用)
2.  在函数组件中的一个全局变量，不会因为重复 `render` 重复申明， 类似于类组件的 `this.xxx`

#### 获取子组件实例

上面提到了一点，`useRef` 只能获取子组件的实例，这在类组件中也是同样的道理，具体看下面的例子

```
// 使用 ref 子组件必须是类组件
class Children extends PureComponent {
  render () {
    const { count } = this.props
    return (
      <div>{ count }</div>
    )
  }
}

function App () {
  const [ count, setCount ] = useState(0)
  const childrenRef = useRef(null)
  // const 
  const onClick = useMemo(() => {
    return () => {
      console.log('button click')
      console.log(childrenRef.current)
      setCount((count) => count + 1)
    }
  }, [])
  return (
    <div>
      点击次数: { count }
      <Children ref={childrenRef}  count={count}></Children>
      <button onClick={onClick}>点我</button>
    </div>
    )
}

```

`useRef` 在使用的时候，可以传入默认值来指定默认值，需要使用的时候，访问 `ref.current` 即可访问到组件实例

#### 类组件属性

有些情况下，我们需要保证函数组件每次 `render` 之后，某些变量不会被重复申明，比如说 `Dom` 节点，定时器的 `id` 等等，在类组件中，我们完全可以通过给类添加一个自定义属性来保留，比如说 `this.xxx`， 但是函数组件没有 `this`，自然无法通过这种方法使用，有的朋友说，我可以使用  
`useState` 来保留变量的值，但是 `useState` 会触发组件 `render`，在这里完全是不需要的，我们就需要使用 `useRef` 来实现了，具体看下面例子

```
function App () {
  const [ count, setCount ] = useState(0)
  const timer = useRef(null)
  let timer2 
  
  useEffect(() => {
    let id = setInterval(() => {
      setCount(count => count + 1)
    }, 500)

    timer.current = id
    timer2 = id
    return () => {
      clearInterval(timer.current)
    }
  }, [])

  const onClickRef = useCallback(() => {
    clearInterval(timer.current)
  }, [])

  const onClick = useCallback(() => {
    clearInterval(timer2)
  }, [])

  return (
    <div>
      点击次数: { count }
      <button onClick={onClick}>普通</button>
      <button onClick={onClickRef}>useRef</button>
    </div>
    )
}

```

当我们们使用普通的按钮去暂停定时器时发现定时器无法清除，因为 `App` 组件每次 `render`，都会重新申明一次 `timer2`, 定时器的 `id` 在第二次 `render` 时，就丢失了，所以无法清除定时器，针对这种情况，就需要使用到 `useRef`，来为我们保留定时器 `id`，类似于 `this.xxx`，这就是 `useRef` 的另外一种用法

### useReducer

`useReducer` 是什么呢，它其实就是类似 `redux` 中的功能，相较于 `useState`，它更适合一些逻辑较复杂且包含多个子值，或者下一个 `state` 依赖于之前的 `state` 等等的特定场景， `useReducer` 总共有三个参数

1.  第一个参数是 一个 `reducer`，就是一个函数类似 `(state, action) => newState` 的函数，传入 上一个 `state` 和本次的 `action`
2.  第二个参数是初始 `state`，也就是默认值，是比较简单的方法
3.  第三个参数是惰性初始化，这么做可以将用于计算 `state` 的逻辑提取到 `reducer` 外部，这也为将来对重置 `state` 的 `action` 做处理提供了便利

具体使用方法看下面的例子

```
function reducer(state, action) {
  switch (action.type) {
    case 'increment':
      return {count: state.count + 1};
    case 'decrement':
      return {count: state.count - 1};
    default:
      throw new Error();
  }
}

function App() {
  const [state, dispatch] = useReducer(reducer, {
    count: 0
  });
  return (
    <>
      点击次数: {state.count}
      <button onClick={() => dispatch({type: 'increment'})}>+</button>
      <button onClick={() => dispatch({type: 'decrement'})}>-</button>
    </>
  );
}

```

### useImperativeHandle

`useImperativeHandle` 可以让你在使用 `ref` 时自定义暴露给父组件的实例值，说简单点就是，子组件可以选择性的暴露给副组件一些方法，这样可以隐藏一些私有方法和属性，官方建议，`useImperativeHandle`应当与 `forwardRef` 一起使用，具体如何使用看下面例子

```
function Kun (props, ref) {
  const kun = useRef()

  const introduce = useCallback (() => {
    console.log('i can sing, jump, rap, play basketball')
  }, [])
  useImperativeHandle(ref, () => ({
    introduce: () => {
      introduce()
    }
  }));

  return (
    <div ref={kun}> { props.count }</div>
  )
}

const KunKun = forwardRef(Kun)

function App () {
  const [ count, setCount ] = useState(0)
  const kunRef = useRef(null)

  const onClick = useCallback (() => {
    setCount(count => count + 1)
    kunRef.current.introduce()
  }, [])
  return (
    <div>
      点击次数: { count }
      <KunKun ref={kunRef}  count={count}></KunKun>
      <button onClick={onClick}>点我</button>
    </div>
    )
}

```

### 其它 hook

还有两个 `hook`，没什么好讲的，用的也不多，可以看看官方文档

1.  [useLayoutEffect](https://react-1251415695.cos-website.ap-chengdu.myqcloud.com/docs/hooks-reference.html#uselayouteffect)
2.  [useDebugValue](https://react-1251415695.cos-website.ap-chengdu.myqcloud.com/docs/hooks-reference.html#usedebugvalue)

### 自定义 hook

我们之前总结出三个问题，`class this` 指向问题，生命周期逻辑冗余问题，都已得到解决，而逻辑难以复用，在前面的例子中并没有解决，要解决这个问题，就要通过 自定义 `hook` 来解决

> 自定义 `Hook`，可以将组件逻辑提取到可重用的函数中，来解决逻辑难以复用问题

前面有个例子是获取屏幕宽度变化的例子，假设我们有诸多组件都需要这个逻辑，那么我们只需要将其抽取成一个自定义 `hook` 即可，具体实现看下面例子

```
function useWidth (defaultWidth) {
  const [width, setWidth] = useState(document.body.clientWidth)

  const onChange = useCallback (() => {
    setWidth(document.body.clientWidth)
  }, [])

  useEffect(() => {
    window.addEventListener('resize', onChange, false)

    return () => {
      window.removeEventListener('resize', onChange, false)
    }
  }, [onChange])

  return width
}

function App () {

  const width = useWidth(document.body.clientWidth)

  return (
    <div> 
      页面宽度: { width }
    </div>
    )
}

```

通过上面的例子，我们可以看出

自定义 `hook` 是一个函数，其名称以 `use` 开头，函数内部可以调用其他的 `hook`，至于为什么要以 `use` 开头，是因为如果不以 `use` 开头，`React` 就无法判断某个函数是否包含对其内部 `hook` 的调用，`React` 也将无法自动检查你的 `hook` 是否违反了 `hook` 的规则，所以要以 `use` 开头

自定义 `hook`，真的很简单，不过具体什么样的逻辑，需要抽离成自定义 `hook`，这就需要工作中不段积累的经验去判断，避免为了 `hook` 而 `hook`

总结
--

在我学习和使用自定义 `hook` 时，我发现其实它的道理很简单，很多前端框架、库里面都有类似的概念，框架和库的设计最后都疏通同归，所以我们在学习一个新的框架、库或者理念时，不应该将其是为一个全新的东西，而更多的应该从自身掌握的内容去推导，去触类旁通，这样我们在学习的时候会事半功倍，在日益更新的前端领域，能够抽出更多的时间去理解更为核心的内容

最后，如果本文对你有任何帮助的话，感谢点个赞 ?

参考
--

1.  [https://react-1251415695.cos-website.ap-chengdu.myqcloud.com/docs/hooks-intro.html](https://react-1251415695.cos-website.ap-chengdu.myqcloud.com/docs/hooks-intro.html)
2.  [https://reactjs.org/docs/hooks-intro.html](https://reactjs.org/docs/hooks-intro.html)

react 其他文章
----------

1.  [React 中 lazy, Suspense 以及错误边界 (Error Boundaries) 的使用](https://blog.csdn.net/landl_ww/article/details/95238244)
2.  [React 中 Context 和 ContextType 的使用](https://blog.csdn.net/landl_ww/article/details/93514944)
3.  [React 中性能优化、 memo、 PureComponent、shouldComponentUpdate 的使用](https://blog.csdn.net/landl_ww/article/details/95600969)

代码
--

1.  [Github](https://github.com/landluck/react-go)