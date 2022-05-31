## React 状态 管理工具

### redux  

​	react-redux  redux redux-thunk

1.  全局 根节点 套 provider  

   ```jsx
   import React from "react";
   import ReactDOM from "react-dom";
   import { BrowserRouter } from "react-router-dom";
   import { Provider } from "react-redux";
   import { ConfigProvider } from "antd";
   import store from "./store"; // 
   import zhCN from "antd/es/locale/zh_CN";
   import { isDev } from "utils/config";
   import App from "./App";
   const Router = BrowserRouter;
   ReactDOM.render(<Provider store={store}>
     <Router>
       <ConfigProvider locale={zhCN}>
         <App />
       </ConfigProvider>
     </Router>
   </Provider>, document.getElementById("root"));
   ```

   

2. store 是所有的状态管理 

   ```jsx
   import { applyMiddleware, createStore } from 'redux' // 
   import thunk from 'redux-thunk' // 异步 
   import logger from 'redux-logger' // 日志。生产可以不用
   import { isDev } from 'utils/config'
   import reducer from './reducer' // 各个模块的 状态控制 
   const middleWare = [thunk]
   if (isDev) {
     middleWare.push(logger)
   }
   const store = createStore(reducer, applyMiddleware(...middleWare))
   
   export default store
   
   ```

3. reducer

   ```jsx
   import { combineReducers } from 'redux' 
   import modules from './modules' //  所有模块的状态
   const reducer = combineReducers(modules)  
   export default reducer
   
   ```

   ```jsx
   // modules/index.js // 利用  require.context. 将模块文件夹下所有文件映射
   const files = require.context('.', false, /\.js$/)
   const modules = {}
   files.keys().forEach(key => {
     if (key === './index.js') return
     modules[key.replace(/(\.\/|\.js)/g, '')] = files(key).default
   })
   export default modules
   
   ```

   ```jsx
   // 单个 文件 的 reducer
   import { listModel } from 'utils/tools'
   const courseIno = { // 默认数据状态
     manage: listModel(),
     manageScore: listModel(),
     target: listModel()
   }
   const status = { //action.type 
     COURSE_MANAGE: 'manage',
     COURSE_MANAGE_SCORE: 'manageScore',
     COURSE_TARGET: 'target'
   }
   // 处理不同的 action   
   const courseStore = (state = courseIno, action) => {
     const { type } = action
     if (status[type]) {
       return { ...state, [status[type]]: { ...action.payload }}
     }
     return state
   }
   export default courseStore
   
   // 异步 action // 在其他模块使用的 异步方法  可以把异步方法单独放文件使用
   export const getSupport = (params) => {
     return async(dispatch) => {
       const p = await getData(API.SUPPORT_HEAD, params)
       const { errcode, data: lists } = p
       if (errcode !== 0) {
         return console.log(p.errmsg)
       }
       dispatch(createAction(ACTION.SUPPORT_HEAD)(lists))
     }
   }
   
   ```

4. 其他模块使用

```jsx
import React from "react";
import { connect } from "react-redux";
import ContentTitle from "component/ContentTitle";
import BasePagination from "component/BasePagination";
import { Table, Button } from "antd";
import { courseManageScoreCols as tableCols } from "utils/cols";
import { HomeState } from "utils/extends";
import { getCourseManageScore as getList } from "store/async";
@connect(
  state => ({
    lists: state.course.manageScore.lists.map((list, index) => {
      const {
        student: { class: classes, id, name, student_no }
      } = list;
      return {
        key: id,
        class: classes,
        name,
        student_no
      };
    }),
    page: state.course.manageScore.page
  }),
  {
    getList
  }
)
class ManageScore extends HomeState {
  constructor(props) {
    super(props);
    console.log(this);
    console.log(this.props);
    this.state.loading = true;
    this.state.training_plan_id = this.props.location.state.id;
  }

  componentDidMount() {
    const dom = this.refs.need;
    const ycal = dom.clientHeight * 0.6;
    this.setState({
      scroll: {
        x: dom.clientWidth - 40,
        y: ycal
      }
    });
    this.getList();
  }
  componentWillReceiveProps(nextProps) {
    this.setState({
      loading: false
    });
  }
  getList = params => {
    const { page, page_size } = this.props.page;
    this.setState({
      loading: true
    });

    this.props.getList({
      page,
      page_size,
      ...params,
      training_plan_id: this.state.training_plan_id
    });
  };
  render() {
    const { state } = this.props.location;
    const { scroll, search_params, loading } = this.state;
    const { lists, page } = this.props;

    return (
      <div ref='need' className='secondDiv animated slideInRight'>
        <ContentTitle
          title={(state && state.title) || ""}
          txt={<div style={{ fontSize: 20 }}>{state.h3}</div>}
          btn={
            <div>
              <Button type='primary'>批量导入</Button>
              <Button type='primary' className='ml20'>
                新增
              </Button>
            </div>
          }
        />
        <Table
          style={{
            marginTop: 20,
            backgroundColor: "#fff",
            maxHeight: scroll.y + "px"
          }}
          loading={loading}
          scroll={scroll}
          dataSource={lists}
          size='middle'
          pagination={false}
          bordered
          columns={tableCols}
        ></Table>
        <BasePagination
          page={page}
          params={search_params}
          getList={this.getList}
        />
      </div>
    );
  }
}

export default ManageScore;

```

###  [mobx](https://cn.mobx.js.org/)

类似于 redux。但是 处理异步的时候  runInAction 或者 利用@action 将回调的的再处理包装成同步  或者使用flow [异步操作](https://www.cnblogs.com/0616--ataozhijia/p/11727935.html) [异步1](https://www.jianshu.com/p/66dd328726d7)



### useHooks useReducer

