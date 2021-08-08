
import 'package:flutter/material.dart';
import 'package:flutter_plugin_app/page/state/state_controller.dart';
import 'package:flutter_plugin_app/widget/eg_widget.dart';
import 'package:get/get.dart';

class StateMainPage extends StatelessWidget {

  StateMainPage({Key? key}) : super(key: key);

  final controller = Get.put(Controller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('状态管理：get (getx)'),
      ),
      body: ListView(
        children: [

          Container(
            margin: EdgeInsets.only(left: 10,right: 10,top: 10),
            color: Colors.grey[350],
            padding: EdgeInsets.all(10),
            child: ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                Text('1.定义 Controller'
                  ,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                Text('定义 Controller 类继承 GetxController ，在 Controller 中定义需要被引用的参数及方法，比如：'
                    '\n'
                    '   var size = 0.obs;'
                    '\n'
                    '   void add()=>size++;'
                    '\n'
                    '其中size是被观察的值，添加.obs后，当size有变化时，将自动通知相对应的订阅事件；add()是触发的方法，这里表示size加1'
                  ,style: TextStyle(fontSize: 15),),
              ],
            ),
          ),

          Container(
            margin: EdgeInsets.only(left: 10,right: 10),
            color: Colors.grey[350],
            padding: EdgeInsets.all(10),
            child: ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                Text('2.获取 Controller'
                  ,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                Text('使用Get.put(T)获取对应的GetController，比如：'
                    '\n'
                    '   final controller = Get.put(Controller());'
                  ,style: TextStyle(fontSize: 15),),
              ],
            ),
          ),

          Container(
            margin: EdgeInsets.only(left: 10,right: 10),
            color: Colors.grey[350],
            padding: EdgeInsets.all(10),
            child: ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                Text('3.订阅通知'
                  ,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                Text('在Widget外层使用Obx()包裹订阅通知，内部使用controller.value引用对应值，比如：'
                    '\n'
                    '   Obx(()=>Text(\'\${controller.size}\')),'
                    '\n'
                    '当size有变化时，Text()显示的内容会自动更新'
                  ,style: TextStyle(fontSize: 15),),
              ],
            ),
          ),

          Container(
            margin: EdgeInsets.only(left: 10,right: 10),
            color: Colors.grey[350],
            padding: EdgeInsets.all(10),
            child: ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                Text('4.触发事件'
                  ,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                Text('在点击响应中使用 controller.function 直接触发事件，比如：'
                    '\n'
                    '   onPressed: (){'
                    '\n'
                    '       controller.add();'
                    '\n'
                    '   },'
                    '\n'
                    '表示点击后会触发 Controller 中的 add 方法'
                  ,style: TextStyle(fontSize: 15),),
              ],
            ),
          ),

          Container(
            margin: EdgeInsets.only(left: 10,right: 10,top: 30),
            padding: EdgeInsets.all(10),
            child: ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                Text('试一试'
                  ,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                Container(
                  alignment: Alignment.center,
                  height: 100,
                  child: Obx(()=>Text('一键三连了： ${controller.size} 次'
                    ,style: TextStyle(fontSize: 15),),),
                ),
                Container(
                  margin: EdgeInsets.only(left: 100,right: 100),
                  height: 50,
                  child: ElevatedButton(
                    onPressed: (){
                      controller.add();
                    },
                    child: Text('一键三连'),
                  ),
                ),
              ],
            ),
          ),

          Container(
            margin: EdgeInsets.only(left: 10,right: 10,top: 50, bottom: 50),
            color: Colors.grey[350],
            padding: EdgeInsets.all(10),
            child: ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                Text('进个阶'
                  ,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                Text('当需要跨页面共享数据时，使用 Get.find<T>() 获取最近一个实例化的 T ，比如：'
                    '\n'
                    '   final controller = Get.find<Controller>();'
                    '\n'
                    '获取到实例后就可按照正常操作使用这个实例，同时两个页面的数据是共享的，关闭这个页面后前一页面的数据不会重置(注意观察上方的一键三连次数)'
                  ,style: TextStyle(fontSize: 15),),
                Container(
                  margin: EdgeInsets.only(left: 100,right: 100,top: 50,bottom: 20),
                  height: 50,
                  child: ElevatedButton(
                    onPressed: (){
                      Get.to(()=>StatePageTwo());
                    },
                    child: Text('试一试'),
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}

class StatePageTwo extends StatelessWidget {

  StatePageTwo({Key? key}) : super(key: key);

  final controller = Get.find<Controller>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('第二个页面'),
      ),
      body: Center(
        child: Obx(()=>Text('一键三连了： ${controller.size} 次')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          controller.add();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

