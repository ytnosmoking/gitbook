> 本文由 [简悦 SimpRead](http://ksria.com/simpread/) 转码， 原文地址 [mp.weixin.qq.com](https://mp.weixin.qq.com/s/wpsF946AaC0nQMJfNGiRbQ)

> **来自公众号：大迁世界**

修改 placeholder 样式，多行文本溢出，隐藏滚动条，修改光标颜色，水平和垂直居中。这些熟悉的场景啊! 前端开发者几乎每天都会和它们打交道，这里有20个CSS技巧，让我们一起来看看吧。

### 1. 解决 img 5px 间距的问题

你是否经常遇到图片底部多出`5p`x间距的问题？不用急，这里有4种方法可以解决。

**方案1：设置父元素字体大小为 0**

关键代码：

```
.img-container{  
  font-size: 0;  
}  

```

事例地址：https://codepen.io/qianlong/pen/VwrzoyE

**方案2：将 img 元素设置为** **`display: block`**

关键代码：

```
img{  
  display: block;  
}  

```

事例地址：https://codepen.io/qianlong/pen/eYeGONM

**方案3：将 img 元素设置为** **`vertical-align: bottom`**

关键代码：

```
img{  
  vertical-align: bottom;  
}  

```

事例地址：https://codepen.io/qianlong/pen/jOaGNWw

**解决方案4：给父元素设置** **`line-height: 5px`**

关键代码：

```
.img-container{  
  line-height: 5px;  
}  

```

事例地址：https://codepen.io/qianlong/pen/PoOJYzN

### 2. 元素的高度与 window 的高度相同

如何使元素与窗口一样高？答案使用 `height: 100vh;`

事例地址：https://codepen.io/qianlong/pen/xxPXKXe

### 3. 修改 input  placeholder  样式

关键代码：

```
.placehoder-custom::-webkit-input-placeholder {  
  color: #babbc1;  
  font-size: 12px;  
}  
  

```

![图片](https://mmbiz.qpic.cn/mmbiz_png/LDPLltmNy57P7pF03TKJSWk8XjugqKrUvUO2yyIrn2PH7YB9HAd0xvF2ZoicIfUBRs7JOPBibdzfCoNboZvnnwfQ/640?wx_fmt=png&wxfrom=5&wx_lazy=1&wx_co=1)

事例地址：https://codepen.io/qianlong/pen/JjOrPOq

### 4. 使用 `:not` 选择器

除了最后一个元素外，所有元素都需要一些样式，使用 `not` 选择器非常容易做到。

如下图所示：最后一个元素没有底边。

![图片](https://mmbiz.qpic.cn/mmbiz_png/LDPLltmNy57P7pF03TKJSWk8XjugqKrUXCZgLasm5W1CONsflEK6SYv0uRX1euiccLOE5CiawDL6GEUwDqiazP44w/640?wx_fmt=png&wxfrom=5&wx_lazy=1&wx_co=1)

关键代码

```
li:not(:last-child) {  
  border-bottom: 1px solid #ebedf0;  
}  
  

```

事例地址：https://codepen.io/qianlong/pen/QWOqLQO

### 5. 使用 flex 布局将一个元素智能地固定在底部

当内容不够时，按钮应该在页面的底部。当有足够的内容时，按钮应该跟随内容。当你遇到类似的问题时，使用 `flex` 来实现智能的布局。

![图片](https://mmbiz.qpic.cn/mmbiz_gif/LDPLltmNy57P7pF03TKJSWk8XjugqKrUDFfaGICclYSlRpcuiaQ6CJrjLjlibm4jntl7krr5WZQ1HhnldH5nUP5A/640?wx_fmt=gif&wxfrom=5&wx_lazy=1)

事例地址：https://codepen.io/qianlong/pen/ZEaXzxM

### 6. 使用 `caret-color` 来修改光标的颜色

可以使用 `caret-color` 来修改光标的颜色，如下所示：

```
caret-color: #ffd476;  

```

![图片](https://mmbiz.qpic.cn/mmbiz_png/LDPLltmNy57P7pF03TKJSWk8XjugqKrUwQRatxsQyrNNwG8ovOLbZOFSWibCubdz2glSY0bmceYQud6kIsOKxicg/640?wx_fmt=png&wxfrom=5&wx_lazy=1&wx_co=1)

事例地址：https://codepen.io/qianlong/pen/YzErKvy

### 7. 删除 `type="number"` 末尾的箭头

默认情况下，在`type="number"`的末尾会出现一个小箭头，但有时我们需要将其删除。我们应该怎么做呢？

![图片](https://mmbiz.qpic.cn/mmbiz_gif/LDPLltmNy57P7pF03TKJSWk8XjugqKrUBzqx3rCVVlQA50RV1jypFWs4K8AMApEicvYgiaexPriaturFVqwbSTjng/640?wx_fmt=gif&wxfrom=5&wx_lazy=1)

关键代码：

```
.no-arrow::-webkit-outer-spin-button,  
.no-arrow::-webkit-inner-spin-button {  
  -webkit-appearance: none;  
}  
  

```

事例地址：https://codepen.io/qianlong/pen/OJOxLrg

### 8. `outline:none` 删除输入状态线

当输入框被选中时，它默认会有一条蓝色的状态线，可以通过使用 `outline: none` 来移除它。

如下图所示：第二个输入框被移除，第一个输入框没有被移除。

![图片](https://mmbiz.qpic.cn/mmbiz_gif/LDPLltmNy57P7pF03TKJSWk8XjugqKrULjs1m9cUePY70jz0lohHLRDXNtSctgxLplT0m8ZAy8ZR57cn8fzUibA/640?wx_fmt=gif&wxfrom=5&wx_lazy=1)

事件地址：https://codepen.io/qianlong/pen/YzErzKG

### 9. 解决iOS滚动条被卡住的问题

在苹果手机上，经常发生元素在滚动时被卡住的情况。这时，可以使用如下的 CSS 来支持弹性滚动。

```
body,html{  
  -webkit-overflow-scrolling: touch;  
}  

```

### 10. 绘制三角形

![图片](https://mmbiz.qpic.cn/mmbiz_png/LDPLltmNy57P7pF03TKJSWk8XjugqKrUUFyb8HMODmnzNFkFRraSSRgqeDl9nht7E0BWAtUdwiaJEnia0UL7z1Fg/640?wx_fmt=png&wxfrom=5&wx_lazy=1&wx_co=1)

```
.box {  
  padding: 15px;  
  background-color: #f5f6f9;  
  border-radius: 6px;  
  display: flex;  
  align-items: center;  
  justify-content: center;  
}  
  
.triangle {  
  display: inline-block;  
  margin-right: 10px;  
  /* Base Style */  
  border: solid 10px transparent;  
}  
/*下*/  
.triangle.bottom {  
  border-top-color: #0097a7;  
}  
/*上*/  
.triangle.top {  
  border-bottom-color: #b2ebf2;  
}  
/*左*/  
.triangle.left {  
  border-right-color: #00bcd4;  
}  
/*右*/  
.triangle.right {  
  border-left-color: #009688;  
}  
  

```

事例地址：https://codepen.io/qianlong/pen/rNYGNRe

### 11. 绘制小箭头、

![图片](https://mmbiz.qpic.cn/mmbiz_png/LDPLltmNy57P7pF03TKJSWk8XjugqKrUwNBy7zQ2aiaURx2QVfLdP3FTyAH3pBuPHJd1kUWabv9LpW8rE0rM8ng/640?wx_fmt=png&wxfrom=5&wx_lazy=1&wx_co=1)

关键代码：

```
.box {  
  padding: 15px;  
  background-color: #ffffff;  
  border-radius: 6px;  
  display: flex;  
  align-items: center;  
  justify-content: center;  
}  
  
.arrow {  
  display: inline-block;  
  margin-right: 10px;  
  width: 0;  
  height: 0;  
  /* Base Style */  
  border: 16px solid;  
  border-color: transparent #cddc39 transparent transparent;  
  position: relative;  
}  
  
.arrow::after {  
  content: "";  
  position: absolute;  
  right: -20px;  
  top: -16px;  
  border: 16px solid;  
  border-color: transparent #fff transparent transparent;  
}  
/*下*/  
.arrow.bottom {  
  transform: rotate(270deg);  
}  
/*上*/  
.arrow.top {  
  transform: rotate(90deg);  
}  
/*左*/  
.arrow.left {  
  transform: rotate(180deg);  
}  
/*右*/  
.arrow.right {  
  transform: rotate(0deg);  
}  
  

```

事例地址：https://codepen.io/qianlong/pen/ZEaXEEP

### 12. 图像适配窗口大小

![图片](https://mmbiz.qpic.cn/mmbiz_gif/LDPLltmNy57P7pF03TKJSWk8XjugqKrU379qtaoXupcPotPUseHExMysgic2TalyBfibzuzgiaSEbMxjbgfnwPaaQ/640?wx_fmt=gif&wxfrom=5&wx_lazy=1)

事例地址：https://codepen.io/qianlong/pen/PoOJoPO

### 13. 隐藏滚动条

第一个滚动条是可见的，第二个滚动条是隐藏的。这意味着容器可以被滚动，但滚动条被隐藏起来，就像它是透明的一样。

![图片](data:image/gif;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVQImWNgYGBgAAAABQABh6FO1AAAAABJRU5ErkJggg==)

关键代码：

```
.box-hide-scrollbar::-webkit-scrollbar {  
  display: none; /* Chrome Safari */  
}  

```

事例地址：https://codepen.io/qianlong/pen/yLPzLeZ

### 14. 自定义选定的文本样式

![图片](data:image/gif;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVQImWNgYGBgAAAABQABh6FO1AAAAABJRU5ErkJggg==)

关键代码：

```
.box-custom::selection {  
  color: #ffffff;  
  background-color: #ff4c9f;  
}  

```

事例地址：https://codepen.io/qianlong/pen/jOaGOVQ

### 15. 不允许选择文本

![图片](data:image/gif;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVQImWNgYGBgAAAABQABh6FO1AAAAABJRU5ErkJggg==)

关键代码：

```
.box p:last-child {  
  user-select: none;  
}  

```

事例地址：https://codepen.io/qianlong/pen/rNYGNyB

### 16. 将一个元素在水平和垂直方向上居中

![图片](https://mmbiz.qpic.cn/mmbiz_png/LDPLltmNy57P7pF03TKJSWk8XjugqKrUBGiciaibeRNKQ33gjvgibdIab4L1lEDJ7E1xX8FtH6KnT5YNlUtpWVJQXA/640?wx_fmt=png&wxfrom=5&wx_lazy=1&wx_co=1)

关键代码：

```
display: flex;  
align-items: center;  
justify-content: center;  

```

事例地址：https://codepen.io/qianlong/pen/VwrMwWb

### 17. 单行文本溢出时显示省略号

![图片](https://mmbiz.qpic.cn/mmbiz_png/LDPLltmNy57P7pF03TKJSWk8XjugqKrU83g31QBn0hc6uobPIbzg6MqVQqo1ShibtjXZCS9MHDm7Pes4HSrDIzw/640?wx_fmt=png&wxfrom=5&wx_lazy=1&wx_co=1)

关键代码：

```
 overflow: hidden;  
  white-space: nowrap;  
  text-overflow: ellipsis;  
  max-width: 375px;
```

事例地址：https://codepen.io/qianlong/pen/vYWeYJJ

### 18. 多行文本溢出时显示省略号

![图片](https://mmbiz.qpic.cn/mmbiz_png/LDPLltmNy57P7pF03TKJSWk8XjugqKrUqic32TjiboIu5V9PqzsysPm13qkf0DOUfenqCgDlquyR75Rib4TLsQ6uA/640?wx_fmt=png&wxfrom=5&wx_lazy=1&wx_co=1)

关键代码：

```
 overflow: hidden;  
  text-overflow: ellipsis;  
  
  display: -webkit-box;  
  /* set n lines, including 1 */  
  -webkit-line-clamp: 2;  
  -webkit-box-orient: vertical;
```

事例地址：https://codepen.io/qianlong/pen/ZEaXEJg

### 19.使用 "filter:grayscale(1)"，使页面处于灰色模式。

![图片](https://mmbiz.qpic.cn/mmbiz_png/LDPLltmNy57P7pF03TKJSWk8XjugqKrUtw53yPVyTon13ZNyYNfHD0cOHQiaxdUzlJCmR8Ab1OgN5iarRI8VOcHw/640?wx_fmt=png&wxfrom=5&wx_lazy=1&wx_co=1)

关键代码：

```
body{  
  filter: grayscale(1);  
}
```

  

--- EOF ---  

  

**推荐↓↓↓**

 ![](http://mmbiz.qpic.cn/mmbiz_png/oGp3ImQqDoarjsIfwTvcrG25u7Uu0NBoISHFWqFc4kOOXLaTMXfPmGpSTnee8P8fqRzYw6KNxn74CzvplX2tDQ/0?wx_fmt=png) ** Web开发 ** 分享Web后端开发技术，分享PHP、Ruby、Python等用于后端网站、后台系统等后端开发技术；还包含ThinkPHP,WordPress等PHP网站开发框架、Django,Flask等Python网站开发框架。 0篇原创内容   公众号