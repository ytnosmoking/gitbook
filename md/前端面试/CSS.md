### CSS

#### 说一下css盒模型 

- 盒模型的组成，由里向外content，padding，border，margin。
- 标准模型  总宽度为：width+border+padding 
- IE盒模型  总宽度为：width 

#### [画一条0.5px的线](https://zhuanlan.zhihu.com/p/40135815)

- transform 

  ```
  transform: scale会导致Chrome变虚了，而粗细几乎没有变化。但是如果加上transform-origin: 50% 100%
  
   transform: scaleY(0.5);
   transform-origin: 50% 100%
  ```

- **boxshadow** 

  ```
  这个方法在Chrome和Firefox都非常完美，但是Safari不支持小于1px的boxshadow，所以完全没显示出来了。
  height: 1px;
  background: none;
  box-shadow: 0 0.5px 0 #000;
  ```

- ```text
  <meta name="viewport" content="width=device-width,initial-sacle=1">
  其中width=device-width表示将viewport视窗的宽度调整为设备的宽度，这个宽度通常是指物理上宽度。默认的缩放比例为1，如iphone 6竖屏的宽度为750px，它的dpr=2，用2px表示1px，这样设置之后viewport的宽度就变成375px。这时候0.5px的边就使用我们上面讨论的方法。
  
  但是你可以把scale改成0.5：
  
  <meta name="viewport" content="width=device-width,initial-sacle=0.5">
  这样的话，viewport的宽度就是原本的750px，所以1个px还是1px，正常画就行，但这样也意味着UI需要按2倍图的出，整体面面的单位都会放大一倍。
  
  在iPone X和一些安卓手机等dpr = 3的设备上，需要设置scale为0.333333，这个时候就是3倍地画了。
  ```

#### link标签和import标签的区别

- 差别1：老祖宗的差别，link属于XHTML标签，而@import完全是css提供的一种方式。link标签除了可以加载css外，还可以做很多其他的事情，比如定义RSS，定义rel连接属性等，@import只能加载CSS。
- 差别2：加载顺序的差别：当一个页面被夹在的时候（就是被浏览者浏览的时候），link引用的CSS会同时被加载，而@import引用的CSS会等到页面全部被下载完再加载。所以有时候浏览@import加载CSS的页面时会没有样式（就是闪烁），网速慢的时候还挺明显。
- 差别3：兼容性的差别。由于@import是CSS2.1提出的所以老的浏览器不支持，@import只有在IE5以上的才能识别，而link标签无此问题，完全兼容。
- 差别4：使用dom控制样式时的差别。当时用JavaScript控制dom去改变样式的时候，只能使用link标签，因为@import不是dom可以控制的（不支持）。
- 差别5（不推荐）：@import可以在css中再次引入其他样式表，比如创建一个主样式表，在主样式表中再引入其他的样式表，但是：这样做有一个缺点，会对网站服务器产生过多的HTTP请求，以前是一个文件，而现在确实两个或更多的文件了，服务器压力增大，浏览量大的网站还是谨慎使用。

#### animation 和 transition 的区别

- animation 可以用 name 设置动画的名称，用 duration 设置动画完成的周期，用 timing-function 设置动画的速度曲线，delay 设置动画什么时候开始，iteration-count 设置动画播放的次数，direction 规定下一个周期是否逆向的播放，play-state 动画是否正在进行或者暂停，fill-mode 设置动画停了之后位置什么状态

- transition 用 property 去设置过渡效果的属性名称，duration 设置过渡效果的周期，timing-function 规定速度效果的速度曲线，delay 设定过渡效果什么时候开始；　

  ```
  -webkit-transition: background-color 1s ease 0.1s,width 1s linear 0.1s,height 1s ease-in-out 0.1s;
  -moz-transition: background-color 1s ease 0.1s ,width 1s linear 0.1s,height 1s ease-in-out 0.1s; 
  -ms-transition: background-color 1s ease 0.1s,width 1s linear 0.1s,height 1s ease-in-out 0.1s;
  -o-transition: background-color 1s ease 0.1s,width 1s linear 0.1s,height 1s ease-in-out 0.1s;
  transition: background-color 1s ease 0.1s,width 1s linear 0.1s,height 1s ease-in-out 0.1s;
  
  ```

  　

- 区别：

- 1、transition 是过渡，是样式值的变化的过程，只有开始和结束；animation 其实也叫关键帧，通过和 keyframe 结合可以设置中间帧的一个状态；

- 2、animation 配合 @keyframe 可以不触发时间就触发这个过程，而 transition 需要通过 hover 或者 js 事件来配合触发；

- 3、animation 可以设置很多的属性，比如循环次数，动画结束的状态等等，transition 只能触发一次；

  ```
  animation: name duration timing-function delay iteration-count direction;
  
  ```

  | 值                                                           | 描述                                     |
  | :----------------------------------------------------------- | :--------------------------------------- |
  | *[animation-name](https://www.w3school.com.cn/cssref/pr_animation-name.asp)* | 规定需要绑定到选择器的 keyframe 名称。。 |
  | *[animation-duration](https://www.w3school.com.cn/cssref/pr_animation-duration.asp)* | 规定完成动画所花费的时间，以秒或毫秒计。 |
  | *[animation-timing-function](https://www.w3school.com.cn/cssref/pr_animation-timing-function.asp)* | 规定动画的速度曲线。                     |
  | *[animation-delay](https://www.w3school.com.cn/cssref/pr_animation-delay.asp)* | 规定在动画开始之前的延迟。               |
  | *[animation-iteration-count](https://www.w3school.com.cn/cssref/pr_animation-iteration-count.asp)* | 规定动画应该播放的次数。                 |
  | *[animation-direction](https://www.w3school.com.cn/cssref/pr_animation-direction.asp)* | 规定是否应该轮流反向播放动画。           |

- 4、animation 可以结合 keyframe 设置每一帧，但是 transition 只有两帧；

- 5、在性能方面：浏览器有一个主线程和排版线程；主线程一般是对 js 运行的、页面布局、生成位图等等，然后把生成好的位图传递给排版线程，而排版线程会通过 GPU 将位图绘制到页面上，也会向主线程请求位图等等；我们在用使用 aniamtion 的时候这样就可以改变很多属性，像我们改变了 width、height、postion 等等这些改变文档流的属性的时候就会引起，页面的回流和重绘，对性能影响就比较大，但是我们用 transition 的时候一般会结合 tansfrom 来进行旋转和缩放等不会生成新的位图，当然也就不会引起页面的重排了；

#### Flex布局

- ```css
   display: -webkit-flex; /* Safari */
    display: flex;
  ```

- 注意，设为 Flex 布局以后，子元素的`float`、`clear`和`vertical-align`属性将失效。

- ```css
   flex-direction: row | row-reverse | column | column-reverse;
  ```

  1. `row`（默认值）：主轴为水平方向，起点在左端。
  2. `row-reverse`：主轴为水平方向，起点在右端。
  3. `column`：主轴为垂直方向，起点在上沿。
  4. `column-reverse`：主轴为垂直方向，起点在下沿。

- ```css
  flex-wrap: nowrap | wrap | wrap-reverse;
  ```

  1. `nowrap`（默认）：不换行。
  2. `wrap`：换行，第一行在上方。
  3. `wrap-reverse`：换行，第一行在下方。

- `flex-flow`属性是`flex-direction`属性和`flex-wrap`属性的简写形式，默认值为`row nowrap`。

  ```
  flex-flow: <flex-direction> || <flex-wrap>;
  ```

- 项目的属性  
  - `order` 属性定义项目的排列顺序。数值越小，排列越靠前，默认为0。
  - `flex-grow` 属性定义项目的放大比例，默认为`0`，即如果存在剩余空间，也不放大，如果所有项目的`flex-grow`属性都为1，则它们将等分剩余空间（如果有的话）。如果一个项目的`flex-grow`属性为2，其他项目都为1，则前者占据的剩余空间将比其他项多一倍
  - `flex-shrink` 属性定义了项目的缩小比例，默认为1，即如果空间不足，该项目将缩小。如果所有项目的`flex-shrink`属性都为1，当空间不足时，都将等比例缩小。如果一个项目的`flex-shrink`属性为0，其他项目都为1，则空间不足时，前者不缩小。负值对该属性无效。
  - `flex-basis`  属性定义了在分配多余空间之前，项目占据的主轴空间（main size）。浏览器根据这个属性，计算主轴是否有多余空间。它的默认值为`auto`，即项目的本来大小。它可以设为跟`width`或`height`属性一样的值（比如350px），则项目将占据固定空间。
  - `flex`属性是`flex-grow`, `flex-shrink` 和 `flex-basis`的简写，默认值为`0 1 auto`。后两个属性可选。该属性有两个快捷值：`auto` (`1 1 auto`) 和 none (`0 0 auto`)。建议优先使用这个属性，而不是单独写三个分离的属性，因为浏览器会推算相关值。
  - `align-self`属性允许单个项目有与其他项目不一样的对齐方式，可覆盖`align-items`属性。默认值为`auto`，表示继承父元素的`align-items`属性，如果没有父元素，则等同于`stretch`。

#### BFC 

- BFC(Block formatting context)直译为"块级格式化上下文"。它是一个独立的渲染区域，只有Block-level box参与， 它规定了内部的Block-level Box如何布局，并且与这个区域外部毫不相干。

- 内部的Box会在垂直方向，一个接一个地放置。

- Box垂直方向的距离由margin决定。属于同一个BFC的两个相邻Box的margin会发生重叠。

- 每个盒子（块盒与行盒）的margin box的左边，与包含块border box的左边相接触(对于从左往右的格式化，否则相反)。即使存在浮动也是如此。

- BFC的区域不会与float box重叠。

- BFC就是页面上的一个隔离的独立容器，容器里面的子元素不会影响到外面的元素。反之也如此。

- 计算BFC的高度时，浮动元素也参与计算。
  

#### 垂直居中的方法

- 通过vertical-align:middle实现CSS垂直居中是最常使用的方法，但是有一点需要格外注意，vertical生效的前提是元素的display：inline-block。
- 定位（position）
- 弹性盒子（flex）
- Margin:auto

#### Js动画与Css3动画的差异性

- 功能涵盖面，JS比CSS3大
  - 定义动画过程的`@keyframes`不支持递归定义，如果有多种类似的动画过程，需要调节多个参数来生成的话，将会有很大的冗余（比如jQuery Mobile的动画方案），而JS则天然可以以一套函数实现多个不同的动画过程
  - 时间尺度上，`@keyframes`的动画粒度粗，而JS的动画粒度控制可以很细
  - CSS3动画里被支持的时间函数非常少，不够灵活
  - 以现有的接口，CSS3动画无法做到支持两个以上的状态转化
- 实现/重构难度不一，CSS3比JS更简单，性能调优方向固定
- 对于帧速表现不好的低版本浏览器，CSS3可以做到自然降级，而JS则需要撰写额外代码
- CSS动画有天然事件支持（`TransitionEnd`、`AnimationEnd`，但是它们都需要针对浏览器加前缀），JS则需要自己写事件
- CSS3有兼容性问题，而JS大多时候没有兼容性问题

#### 说一下块元素和行元素

- 行内元素特征：
  - (1)设置宽高无效
  - (2)对margin仅设置左右方向有效，上下无效；padding设置上下左右都有效，即会撑大空间
  - (3)不会自动进行换行

- 块状元素特征：
  - (1)能够识别宽高
  - (2)margin和padding的上下左右均对其有效
  - (3)可以自动换行
  - (4)多个块状元素标签写在一起，默认排列方式为从上至

- 行内块状元素特征：
  - (1)不自动换行
  - (2)能够识别宽高
  - (3)默认排列方式为从左到右

#### 多行元素的 文本省略号

- ```
  使文字数量不同在相同的地方显示，给盒子加固定高度
  overflow：hidden;
  display：-webkit-box; 将盒子转换为弹性盒子
  -webkit-line-clamp：2; 设置显示多少行
  text-overflow：ellipsis; 文本以省略号显示    
  -webkit-box-orient：vertical; 文本显示方式，默认水平
  
  ```

- ```
  单行文本的溢出溢出省略号使用text-overflow：ellipsis
  overflow:hidden;
  text-overflow:ellipsis;
  white-space: nowrap;
  ```

  

#### [opacity:0、visibility:hidden、display:none](https://juejin.cn/post/6844904202867572749)

- **空间占据**

  display:none隐藏后不占据额外空间，它会产生回流和重绘，而visibility:hidden和opacity:0元素虽然隐藏了，但它们仍然占据着空间，它们俩只会引起页面重绘。

- **子元素继承**

  display:none不会被子元素继承，但是父元素都不在了，子元素自然也就不会显示了，皮之不存，毛之安附~~

  visibility:hidden 会被子元素继承，可以通过设置子元素visibility:visible 使子元素显示出来

  opacity: 0 也会被子元素继承，但是不能通过设置子元素opacity: 0使其重新显示

- **事件绑定**

  display:none 的元素都已经不再页面存在了，因此肯定也无法触发它上面绑定的事件；

  visibility:hidden 元素上绑定的事件也无法触发；

  opacity: 0元素上面绑定的事件是可以触发的。

- **过渡动画**

  transition对于display肯定是无效的，大家应该都知道；

  transition对于visibility也是无效的；

  transition对于opacity是有效，大家也是知道的:).

#### 双边距重叠问题

- 1. 什么是双边距重叠

  多个相邻的（兄弟或者父子关系）标准流中的块元素垂直方向的margin会重叠。

- 2. 折叠结果

  两个相邻的外边距都是正数的时候，折叠结果就是它们两者之间较大的值
  两个相邻的外边距都是负数的时候，折叠结果就是它们两者之间绝对值的较大值
  两个相邻的外边距一正一负的时候，折叠结果就是它们两者相加的和

- 3. 如何解决双边距重叠

  给其中的一个div添加一个父的div，并且为这个div设置边框或者实现overflow：hidden；
  将块级div设置成行内div（display：inline-block；）

#### Position

| 值       | 描述                                                         |
| :------- | :----------------------------------------------------------- |
| absolute | 生成绝对定位的元素，相对于 static 定位以外的第一个父元素进行定位。元素的位置通过 "left", "top", "right" 以及 "bottom" 属性进行规定。 |
| fixed    | 生成绝对定位的元素，相对于浏览器窗口进行定位。元素的位置通过 "left", "top", "right" 以及 "bottom" 属性进行规定。 |
| relative | 生成相对定位的元素，相对于其正常位置进行定位。因此，"left:20" 会向元素的 LEFT 位置添加 20 像素。 |
| static   | 默认值。没有定位，元素出现在正常的流中（忽略 top, bottom, left, right 或者 z-index 声明）。 |
| inherit  | 规定应该从父元素继承 position 属性的值。                     |

#### 浮动清除

- 额外标签法（在最后一个浮动标签后，新加一个标签，给其设置clear：both；）（不推荐）

- 父级添加overflow属性（父元素添加overflow:hidden）（不推荐）通过触发BFC方式，实现清除浮动

- 使用after伪元素清除浮动（推荐使用）

- 使用before和after双伪元素清除浮动

  ```
  .clearfix:after,.clearfix:before{
    content: ""; 
    display: block; 
    height: 0; 
    clear: both; 
    visibility: hidden;  
    }
  
  .clearfix {
    /* 触发 hasLayout */ 
    zoom: 1; 
    }
  
  ```

  

#### [css3新特性](https://www.html.cn/qa/css3/12577.html)

#### CSS选择器

-  总结排序：!important>内部样式>ID选择器>类选择器>标签选择器>通配符选择器>继承>浏览器默认属性

#### float元素 display 是block

#### Display:table 和 table

```
目前，在大多数开发环境中，已经基本不用table元素来做网页布局了，取而代之的是div+css，那么为什么不用table系表格元素呢？

1、用DIV+CSS编写出来的文件k数比用table写出来的要小，不信你在页面中放1000个table和1000个div比比看哪个文件大

2、table必须在页面完全加载后才显示，没有加载完毕前，table为一片空白，也就是说，需要页面完毕才显示，而div是逐行显示，不需要页面完全加载完毕，就可以一边加载一边显示

3、非表格内容用table来装，不符合标签语义化要求，不利于SEO

4、table的嵌套性太多，用DIV代码会比较简洁
```

- | table              | （类似 <table>）此元素会作为块级表格来显示，表格前后带有换行符。 |
  | ------------------ | ------------------------------------------------------------ |
  | inline-table       | （类似 <table>）此元素会作为内联表格来显示，表格前后没有换行符。 |
  | table-row-group    | （类似 <tbody>）此元素会作为一个或多个行的分组来显示。       |
  | table-header-group | （类似 <thead>）此元素会作为一个或多个行的分组来显示。       |
  | table-footer-group | （类似 <tfoot>）此元素会作为一个或多个行的分组来显示。       |
  | table-row          | （类似 <tr>）此元素会作为一个表格行显示。                    |
  | table-column-group | （类似 <colgroup>）此元素会作为一个或多个列的分组来显示。    |
  | table-column       | （类似 <col>）此元素会作为一个单元格列显示。                 |
  | table-cell         | （类似 <td> 和 <th>）此元素会作为一个表格单元格显示。        |
  | table-caption      | （类似 <caption>）此元素会作为一个表格标题显示。             |

- display:table能解决哪些问题？

  （1）大小不固定的元素垂直居中

  　　父元素设置：display:table; 子元素：display:table-cell; vertical-align:middle;

  （2）两列自适应布局

  （3）等高布局

#### 如果想要改变一个DOM元素的字体颜色，不在它本身上进行操作？

- css继承 在父元素上操作 color

#### line-height height

- **height：表示 行高**
- **line-height：表示  每行文字所占的高度** 

#### 设置一个元素的背景颜色，背景颜色会填充哪些区域？

链接：https://www.nowcoder.com/questionTerminal/cdcd727a9d114faeaf79703ff720c774
来源：牛客网



- “标准盒模型”与“ IE 盒模型”造成背景颜色的填充范围不同的主要原因就是：设置 width 时，其对应的范围不同。IE 盒子的 width 不仅包含了 content，还包含了 padding 和 border，而标准盒模型的 width 其范围就只包含了 content。    
-    在默认值情况下，background-color 的渲染范围不论是标准盒模型还是 IE 盒模型，都是一样的，都是 border 及以内的范围会被 background-color 的颜色覆盖。   

>   至于 background-clip 三个值对应 background-color 渲染范围的区别，从值的名字就可以直接看出来。
>
> - ​    content-box：背景颜色只覆盖 content 的部分；      
> - ​    padding-box：背景颜色覆盖 padding、content 的部分；      
> - ​    border-box**（默认）**：背景颜色覆盖 border、padding 和 content 的部分（同时，这又是**默认的属性，**在不手动设置 background-clip 属性值时，背景颜色默认覆盖了这三个范围，只不过平时我们设置的border都是实线且比较窄，所以一般情况下看起来似乎并没有覆盖border，其实是有的。）

![在这里插入图片描述](https://img-blog.csdnimg.cn/20210208174239160.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzM5MjQ4OQ==,size_16,color_FFFFFF,t_70)

#### [为什么img 是inline 还可以设置宽高](https://blog.csdn.net/weixin_42051913/article/details/89478552)

- **可替换元素**

  ```
  在 CSS 中，可替换元素（replaced element）的展现效果不是由 CSS 来控制的。这些元素是一种外部对象，它们外观的渲染，是独立于 CSS 的。
  
  简单来说，它们的内容不受当前文档的样式的影响。CSS 可以影响可替换元素的位置，但不会影响到可替换元素自身的内容。例如 <iframe> 元素，可能具有自己的样式表，但它们不会继承父文档的样式。 典型的可替换元素有：
  
  <iframe>
  
  <video>
  
  <embed>
  
  <img>
  
  有些元素仅在特定情况下被作为可替换元素处理，例如：
  
  <input> "image" 类型的 <input> 元素就像<img>一样可替换
  
  <option>
  
  <audio>
  
  <canvas>
  
  <object>
  
  <applet>（已废弃）
  
  CSS的 content 属性用于在元素的 ::before 和 ::after 伪元素中插入内容。使用content 属性插入的内容都是匿名的可替换元素。
  
  ```

  

#### Overflow原理

- overflow 属性规定当内容溢出元素框时发生的事情。

  | 值      | 描述                                                     |
  | :------ | :------------------------------------------------------- |
  | visible | 默认值。内容不会被修剪，会呈现在元素框之外。             |
  | hidden  | 内容会被修剪，并且其余内容是不可见的。                   |
  | scroll  | 内容会被修剪，但是浏览器会显示滚动条以便查看其余的内容。 |
  | auto    | 如果内容被修剪，则浏览器会显示滚动条以便查看其余的内容。 |
  | inherit | 规定应该从父元素继承 overflow 属性的值。                 |