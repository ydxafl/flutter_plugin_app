
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionMainPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('权限管理:permission_handler'),
      ),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.all(20),
            child: Text('插件名称：permission_handler \n版本：8.1.4+2',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
          ),

          Container(
            margin: EdgeInsets.only(left: 10,right: 10),
            color: Colors.grey[350],
            padding: EdgeInsets.all(10),
            child: ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                Text('1.注册权限'
                  ,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                Text('Android ：在AndroidManifest.xml 中添加权限'
                    '\n'
                    'iOS：在Info.plist 中添加权限说明，在Podfile 中添注册'
                    '\n'
                    '详情查看：https://pub.dev/packages/permission_handler'
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
                Text('2.申请权限'
                  ,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                Text('使用 [Permission.xxx,Permission.yyy,].request(); 申请权限，比如：'
                    '\n'
                    '[Permission.camera].request();'
                    '\n'
                    '表示申请相机和读文件的权限'
                  ,style: TextStyle(fontSize: 15),),
                ElevatedButton(
                  onPressed: (){
                    [Permission.camera].request();
                  },
                  child: Text('试试看'),),
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
                Text('3.查询是否有权限'
                  ,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                Text('使用 Permission.xxx.status 查询是否有权限，比如'
                    '\n'
                    '   var status = await Permission.camera.status;'
                    '\n'
                    '   if (status.isDenied) {'
                    '\n'
                    '       // 还没有发起请求或者被拒绝'
                    '\n'
                    '   }'
                  ,style: TextStyle(fontSize: 15),),
                ElevatedButton(
                  onPressed: (){
                    Permission.camera.status.isGranted.then((value) =>{
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('是否已获得相机权限：$value'),
                        ),
                      ),
                    });
                  },
                  child: Text('试试看'),),
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
                Text('4.查询并发起申请'
                  ,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                Text('使用 Permission.xxx.request().isGranted 查询是否有权限，如果没有则发起申请，有则返回true，比如：'
                    '\n'
                    '   if (await Permission.storage.request().isGranted) {'
                    '\n'
                    '       // 如果有权限则继续执行，没权限则发起申请'
                    '\n'
                    '   }'
                  ,style: TextStyle(fontSize: 15),),
                ElevatedButton(
                  onPressed: (){
                    Permission.storage.request().isGranted.then((value) =>{
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('是否已获得访问文件权限：$value'),
                        ),
                      ),
                    });
                  },
                  child: Text('试试看'),),
              ],
            ),
          ),

        ],
      ),
    );
  }
}

