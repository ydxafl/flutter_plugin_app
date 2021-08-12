
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheMainPage extends StatelessWidget {

  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('数据缓存:shared_preferences'),
      ),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.all(20),
            child: Text('插件名称：shared_preferences \n版本：2.0.6',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
          ),

          Container(
            margin: EdgeInsets.only(left: 10,right: 10),
            color: Colors.grey[350],
            padding: EdgeInsets.all(10),
            child: ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                Text('1.写'
                  ,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                Text('使用 SharedPreferences.getInstance() 获取实例后，使用set写数据，比如：'
                    '\n'
                    '   SharedPreferences sp = await SharedPreferences.getInstance();'
                    '\n'
                    '   sp.setString(key,value);'
                  ,style: TextStyle(fontSize: 15),),

                ElevatedButton(
                  onPressed: (){
                    SharedPreferences.getInstance().then((sp) {
                      sp.setString("key", "保存的第$index条信息");
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('保存的信息为：保存的第$index条信息'),
                        ),
                      );
                      index ++;
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
                Text('2.读'
                  ,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                Text('使用 SharedPreferences.getInstance() 获取实例后，使用get读数据，比如：'
                    '\n'
                    '   SharedPreferences sp = await SharedPreferences.getInstance();'
                    '\n'
                    '   sp.get(keyN);'
                  ,style: TextStyle(fontSize: 15),),
                ElevatedButton(
                  onPressed: (){
                    SharedPreferences.getInstance().then((sp) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('读取到的信息为：${sp.get("key")}'),
                        ),
                      );
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
