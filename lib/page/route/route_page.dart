
import 'package:flutter/material.dart';
import 'package:flutter_plugin_app/page/home_page.dart';
import 'package:get/get.dart';

class RoutePageNon extends StatelessWidget {
  final msg;
  const RoutePageNon({Key? key,this.msg}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [

            Container(height: 20,),

            Container(
              child: Text('通过构造参数接收到的信息为：$msg'),
            ),

            Container(height: 20,),

            Container(
              child: Text('通过get接收到的信息为：${Get.arguments}'),
            ),

            Container(height: 20,),

            ElevatedButton(
              onPressed: (){
                Get.back(result: '页面返回消息了');
              },
              child: Text('返回'),
            ),
          ],
        ),
      ),
    );
  }
}


class RoutePageRoot extends StatelessWidget {
  const RoutePageRoot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Container(height: 20,),

            ElevatedButton(
              onPressed: (){
                debugPrint('${Navigator.canPop(context)}');
                if(Navigator.canPop(context)){
                  Get.back();
                }
              },
              child: Text('是否可返回上一页面'),
            ),

            Container(height: 20,),

            ElevatedButton(
              onPressed: (){
                Get.offAll(HomePage());
              },
              child: Text('回到首页'),
            ),
          ],
        ),
      ),
    );
  }
}
