

### 移动端前端适配 postcss-px-to-viewport（px 转 vw）

- [概述](#概述)
- [配置及实例](#配置及实例)

概述
==

前端适配困扰了很多开发人员，在 PC 端和移动端的适配，我个人认为最好的方法是开发两个界面，一个用于 PC 端，一个用于移动端，想要只开发一个界面又适用于 PC 端又适用与移动端有点太难了（个人想法，前端小白）。

然而，就算是移动端也分很多不同尺寸的移动设备啊，这时候有个很厉害的玩意东西出现了，就是 postcss-px-to-viewport，可以将单位 px 转换为 vw，vw 不是太了解，大概是根据尺寸大小会进行自动适配。话不多说直接干。

配置及实例
=====

第一步：`npm i https://github.com/evrone/postcss-px-to-viewport --save-dev`，**注意这里有个陷阱，下面会提到；**  
第二步：在. postcssrc.js 中加入配置语句，.postcssrc.js 全部内容如下：

```
module.exports = {
  "plugins": {
    "postcss-import": {},
    "postcss-url": {},
    // to edit target browsers: use "browserslist" field in package.json
    "autoprefixer":{},
    "postcss-px-to-viewport": {
        unitToConvert: 'px',    //需要转换的单位，默认为"px"
        viewportWidth: 375,     //设计稿的视口宽度，一般是375左右，iphone和很多安卓机等机型都差不多，ipad除外。如果是viewportWidth是375，font-size：14，那么font-size会转换为3.73333vm，计算过程：14÷375×100=3.73333
        unitPrecision: 5,       //单位转换后保留的精度
        propList: ['*'],        //能转化为vw的属性列表
        viewportUnit: 'vw',     //希望使用的视口单位
        fontViewportUnit: 'vw', //字体使用的视口单位
        selectorBlackList: [],  //需要忽略的CSS选择器，不会转为视口单位，使用原有的px等单位。
        minPixelValue: 1,       //设置最小的转换数值，如果为1的话，只有大于1的值会被转换
        mediaQuery: false,      //媒体查询里的单位是否需要转换单位
        replace: true,          //是否直接更换属性值，而不添加备用属性
        exclude: undefined,     //忽略某些文件夹下的文件或特定文件
        include: /Test.vue/,    //如果设置了include，那将只有匹配到的文件才会被转换
        landscape: false,       //是否添加根据 landscapeWidth 生成的媒体查询条件 @media (orientation: landscape)
        landscapeUnit: 'vw',    //横屏时使用的单位
        landscapeWidth: 568     //横屏时使用的视口宽度
    }
  }
}

```

这里可以参考官方文档：  
英文：[https://github.com/evrone/postcss-px-to-viewport](https://github.com/evrone/postcss-px-to-viewport)  
中文：[https://github.com/evrone/postcss-px-to-viewport/blob/master/README_CN.md](https://github.com/evrone/postcss-px-to-viewport/blob/master/README_CN.md)  
我直接把官方的配置贴出来：

*   unitToConvert (String) 需要转换的单位，默认为 "px"
*   viewportWidth (Number) 设计稿的视口宽度
*   unitPrecision (Number) 单位转换后保留的精度
*   propList (Array) 能转化为 vw 的属性列表  
    ①传入特定的 CSS 属性；  
    ②可以传入通配符 "“去匹配所有属性，例如：[’’]；  
    ③在属性的前或后添加”_", 可以匹配特定的属性. (例如 [‘position’] 会匹配 background-position-y)  
    ④在特定属性前加 “!”，将不转换该属性的单位 . 例如: [’_’,’!letter-spacing’]，将不转换 letter-spacing  
    ⑤"!" 和 "" 可以组合使用， 例如:[’’, ‘!font*’]，将不转换 font-size 以及 font-weight 等属性
*   viewportUnit (String) 希望使用的视口单位
*   fontViewportUnit (String) 字体使用的视口单位
*   selectorBlackList (Array) 需要忽略的 CSS 选择器，不会转为视口单位，使用原有的 px 等单位。  
    ①如果传入的值为字符串的话，只要选择器中含有传入值就会被匹配：  
    例如 selectorBlackList 为 [‘body’] 的话， 那么. body-class 就会被忽略  
    ②如果传入的值为正则表达式的话，那么就会依据 CSS 选择器是否匹配该正则：  
    例如 selectorBlackList 为 [/^body$/] , 那么 body 会被忽略，而 .body 不会
*   minPixelValue (Number) 设置最小的转换数值，如果为 1 的话，只有大于 1 的值会被转换
*   mediaQuery (Boolean) 媒体查询里的单位是否需要转换单位
*   replace (Boolean) 是否直接更换属性值，而不添加备用属性
*   exclude (Array or Regexp) 忽略某些文件夹下的文件或特定文件，例如’node_modules’下的文件  
    ①如果值是一个正则表达式，那么匹配这个正则的文件会被忽略；  
    ②如果传入的值是一个数组，那么数组里的值必须为正则
*   include (Array or Regexp) 如果设置了 include，那将只有匹配到的文件才会被转换，例如只转换’src/mobile’下的文件 (include://src/mobile//)  
    ①如果值是一个正则表达式，将包含匹配的文件，否则将排除该文件；  
    ②如果传入的值是一个数组，那么数组里的值必须为正则
*   landscape (Boolean) 是否添加根据 landscapeWidth 生成的媒体查询条件 @media(orientation: landscape)
*   landscapeUnit (String) 横屏时使用的单位
*   landscapeWidth (Number) 横屏时使用的视口宽度

**注意：**  
①exclude 和 include 是可以一起设置的，将取两者规则的交集；  
②陷阱：如果你需要用到 include，那一定要用第一步中的`npm i https://github.com/evrone/postcss-px-to-viewport --save-dev`，而不是`npm install postcss-px-to-viewport --save-dev`，为什么呢？  
答案：include 是上个月才做的，还没有 release，但是文档已经提前更新了，所以可以先使用 github 仓库的代码，说白了用 github 仓库的可以用 include，否则 include 无效。我发布这篇文章的时间是 2020-6-28。（太坑了，我花了一天时间在找这个 bug 上）  
解答地址：[https://github.com/evrone/postcss-px-to-viewport/issues/53](https://github.com/evrone/postcss-px-to-viewport/issues/53)  
③如果是 viewportWidth 是 375，且 font-size=14，那么 font-size 会转换为 3.73333vm，计算过程：14÷375×100=3.73333vm；  
④style 标签内嵌 CSS 样式是不会发生转换的，如：style：“font-size: 14px”，它不会转换为 style：“font-size: 3.73333vm” 的。

第三步：写前端代码。

```
<template>
    <div class="test">
        我是Test
    </div>
</template>

<script>

export default {
  name: 'Test',
}
</script>

<style scoped>
.test{
    height: 40px;
    background: #87CEFA;
    font-size: 14px;
}
</style>

```

css 变化:  
![](https://img-blog.csdnimg.cn/20200628230501824.png#pic_left)  
宽度是 375 时：  
![](https://img-blog.csdnimg.cn/20200628230100196.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dzZ3pqZGJi,size_16,color_FFFFFF,t_70#pic_left)  
宽度是 578 时：  
![](https://img-blog.csdnimg.cn/20200628230046318.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dzZ3pqZGJi,size_16,color_FFFFFF,t_70#pic_left)  
可以看到 font-size 由 14px 转变为 3.73333vm 了（怎么算的呢？14÷375×100=3.73333）。变化缩放宽度，会发现字体大小会随着宽度自适应变化（图片效果不明显，看不太出来，自己动手丰衣足食）。

参考网址：  
[https://github.com/evrone/postcss-px-to-viewport](https://github.com/evrone/postcss-px-to-viewport)  
[https://github.com/evrone/postcss-px-to-viewport/blob/master/README_CN.md](https://github.com/evrone/postcss-px-to-viewport/blob/master/README_CN.md)  
[https://github.com/evrone/postcss-px-to-viewport/issues/53](https://github.com/evrone/postcss-px-to-viewport/issues/53)