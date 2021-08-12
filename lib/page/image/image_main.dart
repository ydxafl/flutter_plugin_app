
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_plugin_app/page/image/image_controller.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ImageMainPage extends StatelessWidget {

  final controller = Get.put(ImageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('图片:image_picker'),
      ),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.all(20),
            child: Text('插件名称：image_picker \n版本：0.8.3+1',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
          ),

          Container(
            margin: EdgeInsets.only(left: 10,right: 10),
            color: Colors.grey[350],
            padding: EdgeInsets.all(10),
            child: ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                Text('1.从相册选取'
                  ,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                Text('使用ImagePicker().pickImage(source: ImageSource.gallery) 从相册选取图片，比如：'
                    '\n'
                    '   ImagePicker().pickImage(source: ImageSource.gallery).then((value){'
                    '\n'
                    '       if(value != null){'
                    '\n'
                    '           // 处理图片'
                    '\n'
                    '       }'
                    '\n'
                    '   });'
                  ,style: TextStyle(fontSize: 15),),
                Container(
                  child: Obx((){
                    return  controller.image1.value == "" ? Text("请选择图片"): Image.file(File(controller.image1.value),width: 100,height: 100,);
                  }),
                  margin: EdgeInsets.all(20),
                ),
                ElevatedButton(
                  onPressed: () async {
                   if(await Permission.storage.request().isGranted){
                     ImagePicker().pickImage(source: ImageSource.gallery).then((value){
                       if(value != null){
                         controller.updateUrl(value.path,index: 0);
                       }
                     });
                   }
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
                Text('2.从相机拍摄'
                  ,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                Text('使用ImagePicker().pickImage(source: ImageSource.camera) 从相册选取图片，比如：'
                    '\n'
                    '   ImagePicker().pickImage(source: ImageSource.camera).then((value){'
                    '\n'
                    '       if(value != null){'
                    '\n'
                    '           // 处理图片'
                    '\n'
                    '       }'
                    '\n'
                    '   });'
                  ,style: TextStyle(fontSize: 15),),
                Container(
                  child: Obx((){
                    return  controller.image2.value == "" ? Text("请选择图片"): Image.file(File(controller.image2.value),width: 100,height: 100,);
                  }),
                  margin: EdgeInsets.all(20),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if(await Permission.camera.request().isGranted){
                      ImagePicker().pickImage(source: ImageSource.camera).then((value){
                        if(value != null){
                          controller.updateUrl(value.path,index: 1);
                        }
                      });
                    }
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
