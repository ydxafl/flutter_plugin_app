
import 'package:flutter/material.dart';
import 'package:flutter_plugin_app/page/route/route_page.dart';
import 'package:flutter_plugin_app/widget/eg_widget.dart';
import 'package:get/get.dart';

class RouteMain extends StatelessWidget {
  const RouteMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('路由：get (getx)'),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: ListView(
          children: [

            Text('插件名称：get \n版本：4.3.4',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),

            Container(height: 20,),
            EgWidget(
              title: '直接跳转',
              mark: '使用 Get.to(()=>Page()) （或Get.to(Page()) ，没有其他参数的情况下推荐使用前者） 实现跳转,表示从当前页面跳转到Page页面，也可以使用Get.toNamed(\'path\')'
                  '\n'
                  '使用Get.toNamed(\'path\') 时需要申明path对应的页面',
              onTap: (){
                Get.to(()=>RoutePageRoot());
              },
            ),
            Container(height: 20,),
            EgWidget(
              title: '带参跳转',
              mark: '带参跳转有两种方式：'
                  '\n'
                  '1.使用构造参数传值；在Page中定义参数，通过Get.to(()=>Page(msg:msg))的方式传递'
                  '\n'
                  '2.使用get传值；方法为：Get.to(Page(),arguments: data)，将需要传递的对象data赋值给arguments,然后在Page中使用Control获取',
              onTap: (){
                Get.to(RoutePageNon(msg: '参数传值',),arguments: 'get传值');
              },
            ),
            Container(height: 20,),
            EgWidget(
              title: '监听返回值',
              mark: '使用 Get.to(()=>Page())?.then((value){//todo}) 实现监听返回值'
                  '\n'
                  'then((value){//todo}) 里的value就是返回值',
              onTap: (){
                Get.to(()=>RoutePageNon())?.then((value) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('返回值为：$value'),
                      ),
                  );
                });
              },
            ),
            Container(height: 20,),
            EgWidget(
              title: '清除当前路由',
              mark: '使用  Get.off(()=>Page());（或Get.off(Page()) ，没有其他参数的情况下推荐使用前者） 实现清除当前路由, 表示关闭当前页面跳转到Page页面',
              onTap: (){
                Get.off(()=>RoutePageRoot());
              },
            ),
            Container(height: 20,),
            EgWidget(
              title: '清除所有路由',
              mark: '使用  Get.offAll(()=>Page());（或Get.offAll(Page()) ，没有其他参数的情况下推荐使用前者） 实现清除所有路由, 表示关闭当前页面跳转到Page页面，并将Page设定为根页面',
              onTap: (){
                Get.offAll(()=>RoutePageRoot());
              },
            ),
          ],
        ),
      ),
    );
  }
}
