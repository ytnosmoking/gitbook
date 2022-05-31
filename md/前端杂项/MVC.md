# MVC, MVP, MVVM

### 1. MVC 

1. 视图	 (**View**)     用户界面
2. 控制器 (**Controller**)   业务逻辑
3. 模型    (**Model**)   数据保存

#### 通信  View > Controller > Model >View

- ![bg2015020105](http://www.ruanyifeng.com/blogimg/asset/2015/bg2015020105.png)
- View 传送指令到 Controller
- Controller 完成业务逻辑后，要求 Model 改变状态
- Model 将新的数据发送到 View，用户得到反馈



### 2 MVP

- ![bg2015020109](http://www.ruanyifeng.com/blogimg/asset/2015/bg2015020109.png)
-  各部分之间的通信，都是双向的。
-  View 与 Model 不发生联系，都通过 Presenter 传递。
-  View 非常薄，不部署任何业务逻辑，称为"被动视图"（Passive View），即没有任何主动性，而 Presenter非常厚，所有逻辑都部署在那里。

### 3 MVVM

- ![bg2015020110](http://www.ruanyifeng.com/blogimg/asset/2015/bg2015020110.png)
- 唯一的区别是，它采用双向绑定（data-binding）：View的变动，自动反映在 ViewModel，反之亦然。[Angular](https://angularjs.org/) 和 [Ember](http://emberjs.com/) 都采用这种模式。





来源:

1. http://www.ruanyifeng.com/blog/2015/02/mvcmvp_mvvm.html
