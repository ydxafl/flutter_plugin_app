
import 'package:flutter/material.dart';
import 'package:flutter_plugin_app/page/cache/cache_main.dart';
import 'image/image_main.dart';
import 'package:flutter_plugin_app/page/network/dio.dart';
import 'package:flutter_plugin_app/page/network/net_work_main.dart';
import 'package:flutter_plugin_app/page/permission/permission_main.dart';
import 'package:flutter_plugin_app/page/route/route_main.dart';
import 'package:flutter_plugin_app/page/screenutil/screen_util_main.dart';
import 'package:flutter_plugin_app/page/state/state_main.dart';
import 'package:flutter_plugin_app/widget/plugin_card.dart';
import 'package:get/get.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('插件测试'),
      ),
      body: GridView.count(
        //水平子Widget之间间距
        crossAxisSpacing: 10.0,
        //垂直子Widget之间间距
        mainAxisSpacing: 30.0,
        //GridView内边距
        padding: EdgeInsets.all(10.0),
        //一行的Widget数量
        crossAxisCount: 4,
        //子Widget宽高比例
        childAspectRatio: 2.0,
        children: [
          PluginCard(
            onTap: (){
              Get.to(()=>RouteMain());
            },
            name: '路由',
            color: Color(0xFFCC9999),
          ),

          PluginCard(
            onTap: (){
              Get.to(()=> StateMainPage());
            },
            name: '状态管理',
            color: Color(0xFFFFFF99),
          ),

          PluginCard(
            onTap: (){
              Get.to(()=>ScreenUtilMainPage());
            },
            name: '屏幕适配',
            color: Color(0xFFCCCC99),
          ),

          PluginCard(
            onTap: (){
              Get.to(() => NetWorkMainPage());
            },
            name: '网络请求',
            color: Color(0xFF666699),
          ),

          PluginCard(
            onTap: (){
              Get.to(()=>PermissionMainPage());
            },
            name: '权限',
            color: Color(0xFFFF9900),
          ),

          PluginCard(
            onTap: (){
              Get.to(()=>CacheMainPage());
            },
            name: '数据缓存',
            color: Color(0xFFFFFF00),
          ),

          PluginCard(
            onTap: (){
              Get.to(()=>ImageMainPage());            },
            name: '照片',
            color: Color(0xFF0099CC),
          ),
        ],
      ),
    );
  }
}
