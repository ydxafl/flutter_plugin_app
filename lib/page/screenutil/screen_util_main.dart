
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScreenUtilMainPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 690),
      builder: ()=>Scaffold(
        appBar: AppBar(
          title: Text('屏幕适配:flutter_screenutil'),
        ),
        body: ListView(
          children: [
            Container(
              margin: EdgeInsets.all(20),
              child: Text('插件名称：flutter_screenutil \n版本：5.0.0+2',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
            ),

            Container(
              margin: EdgeInsets.only(left: 10,right: 10),
              color: Colors.grey[350],
              padding: EdgeInsets.all(10),
              child: ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  Text('1.初始化'
                    ,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                  Text('使用ScreenUtilInit包裹Widget，在builder中返回Widget，在designSize 配置页面尺寸，比如：'
                      '\n'
                      '   Widget build(BuildContext context) {'
                      '\n'
                      '       return ScreenUtilInit('
                      '\n'
                      '           designSize: Size(360, 690),'
                      '\n'
                      '           builder: ()=>Scaffold()'
                      '\n'
                      '       )'
                      '\n'
                      '   }'
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
                  Text('2.设置尺寸'
                    ,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                  Text('在宽度值后添加 .w后缀，在高度值后添加 .h后缀，在字体值后添加 .sp后缀，如果需要根据宽度或高度中的较小者进行调整则在后方添加 .r后缀，比如：'
                      '\n'
                      '   Text(\'字体变化\',style: TextStyle(fontSize: 12.sp),),'
                      '\n'
                      '   width: 100.w,'
                      '\n'
                      '   height: 100.h,'
                      '\n'
                      '   height: 80.r,'
                      '\n'
                      '   height: 80.r,'
                    ,style: TextStyle(fontSize: 15),),
                ],
              ),
            ),

            Container(
              margin: EdgeInsets.all(20),
              alignment: Alignment.center,
              color: Colors.deepOrangeAccent,
              width: 100.w,
              height: 100.h,
              child: Container(
                alignment: Alignment.center,
                color: Colors.greenAccent,
                width: 80.r,
                height: 80.r,
                child: Text('字体不变',style: TextStyle(fontSize: 12),),
              ),
            ),
            Container(
              margin: EdgeInsets.all(20),
              alignment: Alignment.center,
              color: Colors.red,
              width: 100,
              height: 100,
              child: Text('字体变化',style: TextStyle(fontSize: 12.sp),),
            ),
          ],
        ),
    ),
    );
  }

}
