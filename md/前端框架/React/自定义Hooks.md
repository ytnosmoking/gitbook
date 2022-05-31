# 自定义Hooks

## useMount // dom初始化渲染之后执行

``` javascript
  import { useEffect } from 'react';
  const useMount = (fn)=>{
    useEffect(()=>{
      fn();
    },[fn])
  }
  // count 变化 也不会再执行 fun
  const MyPage = ()=>{
    const [count, setCount] = useState(0);
    const fun = useCallback(()=>{
      console.log('mount')
    },[]);
    useMount(fun)
    return (
      <div>
        <button type="button" onClick={()=>{setCout(count+1)}}> 增加</button>
      </div>
    )
  }

```

## useUnmount // dom卸载之前执行

``` javascript
  import { useEffect } from 'react';
  const useMount = (fn)=>{
    useUnmount(()=>{
      return ()=>{
        fn();
      }
    },[fn])
  }
  
  const MyPage = ()=>{
    const [count, setCount] = useState(0);
    const fun = useCallback(()=>{
      console.log('mount')
    },[]);
    useMount(fun)
    return (
      <div>
        <button type="button" onClick={()=>{setCout(count+1)}}> 增加</button>
      </div>
    )
  }
```

## useUpdate 强制更新 点击按钮 会强制页面更新

``` javascript
  const useUpdate = ()=>{
    const [, setState]=useState({});
    return useCallback(()=>setState({}),[])
  }
  const MyPage = ()=>{
    const update = useUpdate()
    return (
      <div>
        <button type="button" onClick={update}> 增加</button>
      </div>
    )
  }

```

## usePrevious 上一次渲染的state值

``` javascript
  const usePrevious = (state)=>{
    const preRef = useRef();
    const curRef = useRef();
    preRef.current = curRef.current
    curRef.current = state
    return preRef.current
  }
  const MyPage = ()=>{
    const [count, setCount] = useState(0)

    const previous = usePrevious(count);
    return (
      <div>
        <div>新值： {count}</div>
        <div>旧值： {previous}</div>
        <button type="button" onClick={()=>{setCout(count+1)}}> 增加</button>
      </div>
    )
  }
```

## useTimeout useInterval 自定义定时器 自动清除 防止遗忘

```javascript
  const useTimeout=(fn, delay)=>{
    useEffect(()=>{
      const timer = setTimeout(()=>{
        fn();
      },delay)
    return ()=>{
      clearTimeout(timer) 
    }
    },[fn, delay])
  }
  const useInterval = (fn ,delay)=>{
     useEffect(()=>{
      const timer = setInterval(()=>{
        fn();
      },delay)
    return ()=>{
      clearInterval(timer) 
    }
    },[fn, delay])
  }
```

## useDebounce  防抖(任务频繁操作) //间隔超过 delay  fn 才会执行

``` javascript
  const useDebounce = (fn , delay)=>{
    const timer = useRef()
    return useCallback((...args)=>{
      if(timer.current) {
        clearTimeout(timer.current)
      }
      timer.current = setTimeout(()=>{
        fn(...args);

      },delay)
    },[fn, fn])
  }
```

## useThrottle 节流 一定时间内 函数只运行一次

``` javascript
  const useThrottle = (fn,delay)=>{
    const timer = useRef();
    return useCallback((...args)=>{
      if(timer.current) {
        return 
      }
      timer.current = setTimeOut(()=>{
        fn(...args);
        timer.current = null
      },delay)

    },[delay, fn])
  }
```
