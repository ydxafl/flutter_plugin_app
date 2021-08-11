
import 'package:flutter/material.dart';
import 'package:flutter_plugin_app/page/network/chapters_controller.dart';
import 'package:get/get.dart';

class NetWorkMainPage extends StatelessWidget {
  
  NetWorkMainPage({Key? key}) : super(key: key);

  final controller = Get.put(ChaptersController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('玩Android公众号列表'),
        actions: [
          InkWell(
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all(2),
              child: Text('清空数据',),
            ),
            onTap: (){
              controller.clean();
            },
          ),
        ],
      ),
      body: Obx(() => ListView.builder(
        itemBuilder:(context,index){
          return Container(
            margin: EdgeInsets.all(10),
            child: Text('公众号名称：${controller.chapters.value.data![index].name}'),
          );
        },
        itemCount: (controller.chapters.value.data == null) ? 0 :controller.chapters.value.data!.length,
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.getChapters();
        },
        child: Icon(Icons.add),
      ),
    );
  }

}
