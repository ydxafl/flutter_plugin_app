
import 'package:flutter/material.dart';
import 'package:flutter_plugin_app/page/home_page.dart';
import 'package:get/get.dart';

class RoutePageNon extends StatelessWidget {
  final msg;
  const RoutePageNon({Key? key,this.msg}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('路由'),
      ),
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

            Container(
              margin: EdgeInsets.only(left: 10,right: 10,top: 10),
              color: Colors.grey[350],
              padding: EdgeInsets.all(10),
              child: ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  Text('带参返回'
                    ,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                  Text('使用 Get.back(result: msg); 返回，比如：'
                      '\n'
                      '   Get.back(result: \'页面返回消息了\');'
                    ,style: TextStyle(fontSize: 15),),
                  Container(height: 40,),
                  ElevatedButton(
                    onPressed: (){
                      Get.back(result: '页面返回消息了');
                    },
                    child: Text('试试看'),
                  ),
                ],
              ),
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
      appBar: AppBar(
        title: Text('路由'),
      ),
      body: Center(
        child: Column(
          children: [
            Container(height: 20,),

            ElevatedButton(
              onPressed: (){
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('是否可以返回上一页面：${Navigator.canPop(context)}'),
                  ),
                );
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
