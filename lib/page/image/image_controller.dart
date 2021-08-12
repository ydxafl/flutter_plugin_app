


import 'package:get/get.dart';

class ImageController extends GetxController{

  var image1 = "".obs;

  var image2 = "".obs;

  updateUrl(String path,{int? index}){
    if(index == 0){
      image1.value = path;
    }else{
      image2.value = path;
    }
  }

}