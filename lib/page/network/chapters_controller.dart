
import 'package:flutter/material.dart';
import 'package:flutter_plugin_app/page/network/chapters.dart';
import 'package:flutter_plugin_app/page/network/dio.dart';
import 'package:flutter_plugin_app/widget/progress_dialog.dart';
import 'package:get/get.dart';

class ChaptersController extends GetxController{

  var chapters = Chapters().obs;

  void getChapters(){
    ProgressDialog.showProgress(Get.context!);

    DioHelper.get('wxarticle/chapters/json', onSuccess:(data){
      Chapters chapter = Chapters.fromJson(data);
      if(chapter.errorCode == 0){
        chapters.value = chapter;
      }else{
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(
            content: Text('${chapters.value.errorMsg}'),
          ),
        );
      }
    }, onError:(msg,code){
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(
          content: Text('$msg'),
        ),
      );
    }, onFinish:(){
      ProgressDialog.dismiss(Get.context!);
    });
  }

  void clean() {
    chapters.value = Chapters();
  }



}