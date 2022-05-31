### 高级类型

- keyof **将一个类型的属性名全部提取出来当做联合类型**

  1. `keyof` 与 `Object.keys` 略有相似，只不过 `keyof` 取 `interface` 的键。

  ```typescript
   // 联合类型 
  	const a :string|number = 1234
    a = '1234'
  interface Person {
    name: string,
    age: number
  }
  type PersonKeys = keyof Person // 等同于 type PersonKeys = 'name' | 'age'
  
  ```

- Record **用于属性映射**

  ```typescript
  // 1. 定义普通的对象类型
  type MyObject = Record<string, any>
  // 2. 搭配联合类型
  type RequestMethods = 'GET'|'POST'|'DELETE'
  type MethodsAny = Record<RequestMethods, any> 
  // 3. 让对象的每个属性都是一个拥有特定键值对的类型
  interface PersonModel {
    name: string
    age: number
  }
  type Person = Record<string, PersonModel> ;
  
  // 实现原理 Record的内部定义，接收两个泛型参数
  //type Record<K extends string | number | symbol, T> = {
  //    [P in K]: T;
  //}
  //1. 泛型K即为第一次参数
  //2. p in xx 又是什么意思呢？in的意思就是遍历，如上就是将 类型string进行遍历，也就是string
  //3. 每个属性都是传入的T类型，如 string: PersonModel
  
  ```

- Partial **让一个定义中的所有属性都变成可选参数**

  ```typescript
  interface Person {
    name: string,
    age: number
  }
  const person1: Partial<Person> ={}
  
  // 实现原理
  type Partial<T> = {
    [P in keyof T]?: T[P]
  }
  //将一个类型的属性名全部提取出来当做联合类型
  //将 age和name进行遍历
  //[P in keyof T]? 的冒号就代表 可选 的参数
  //T[P] 就代表 如 Person[name]代表的是 string 类型
  ```

- Required **和Partial刚好相反，将一个定义中的属性全部变成必选参数**

  ```typescript
  interface Person {
  	name?: string
    age?: number
  }
  
  type RequiredPerson = Required<Person>
  
  // 实现原理
  type Required<T> = {
      [P in keyof T]-?: T[P];
  }
  //将一个类型的属性名全部提取出来当做联合类型
  //将 age和name进行遍历
  //在?之前加个-，代表着这个属性是必须的。
  //T[P] 就代表 如 Person[name]代表的是 string 类型
  ```

- Pick **可以选择一个原来的接口中一部分的属性定义**

  ```typescript
  interface Person {
  	name: string
  	age: number
  }
  type somePerson = Pick<Person, 'name'|'age'>
  
  // 实现原理
  //type Pick<T, K extends keyof T> = {
  //  [P in K]: T[P]
  //}
  //第一个泛型 T 便是 interface 或者 type 定义
  //第二个就是第一个定义中的属性， extends就代表继承 K extends keyof T 等同于 k extends ‘name’ | ‘age’,意思就是k只能是age或者name
  ```

- Readonly **让一个定义中的所有属性都变成只读参数**

  ```typescript
  interface Person {
    name: string
    age: number
    girlFriend: {
      name: string
      age: number 
    }
  }
  type ReadOnlyPerson = Readonly<Person>
  //实现原理 
  type Readonly<T> = {
    readonly [P in keyof T]: T[P];
  }
  //将一个类型的属性名全部提取出来当做联合类型
  //将 age和name进行遍历
  //readonly 修饰符代表属性是只读的
  //T[P] 就代表 如 Person[name]代表的是 string 类型
  ```

- Exclude  排除 **联合类型** 中一部分的内容 注意Exclude是操作联合类型的

  ```typescript
  type MyTypes = 'name'|'age'|'height'
  type someMyTypes = Exclude<MyTypes, 'name'>
  // 原理
  type Exclude<T, U> = T extends U ? never : T
  //我们这里用 MyTypes 也就是 ‘name’ | ‘age’ | ‘height’ 去代表 T
  //用 name 属性去代表第二个泛型 U
  //T extends U 就判断是否’name’ | ‘age’ | ‘height’ 有 name， 有name就返回never,就代表将其排除
  ```

- Omit **将接口或者类型的键值对删除一部分**

  ```typescript
  type Person = {
    name: string,
    age: number
  }
  type somePerson = Omit<Person, 'name'>
  //原理
  //type Omit<T, K extends string | number | symbol> = {
  // 	[P in Exclude<keyof T, K>]: T[P]
  //}
  ```

- ReadonlyArray 创建一个数组，**数组中的索引不允许被修改**

  ```typescript
  //我们知道当我们使用const创建对象或者数组时，其实是可以修改其内部属性的，但是有的时候我们可能不需要其内部能够被修改	
  //方法1：通过类型断言的方式
  const arr = [1,2,3,4] as const
  //方法2：使用ReadonlyArray，需要传入一个泛型来约束数组中的索引类型
  const arr: ReadonlyArray<number> = [1,2,3,4,5]
  
  //区别在于as const是深层次的，尽管数组内放的对象，对象内部数据也是不能被修改的。ReadonlyArray则是‘浅层’的。
  ```

  

  1. [ts高阶]: https://blog.csdn.net/dajuna/article/details/1179586

  2. [技巧]: https://blog.csdn.net/ch834301/article/details/102617697

  3. [其他]: https://www.cnblogs.com/cczlovexw/p/14389259.html

     

  

  

  

  