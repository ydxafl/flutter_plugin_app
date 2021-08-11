
import 'package:flutter/material.dart';
import 'package:flutter_plugin_app/page/network/chapters.dart';
import 'package:flutter_plugin_app/page/network/dio.dart';
import 'package:get/get.dart';

class ChaptersController extends GetxController{

  var chapters = Chapters().obs;

  void getChapters(){
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
    }, onFinish:(){});
  }

  void clean() {
    Chapters chapter = Chapters();
    chapters.value = chapter;
  }



}