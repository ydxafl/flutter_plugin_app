/// data : [{"courseId":13,"id":408,"name":"鸿洋","order":190000,"parentChapterId":407,"userControlSetTop":false,"visible":1},{"courseId":13,"id":409,"name":"郭霖","order":190001,"parentChapterId":407,"userControlSetTop":false,"visible":1},{"courseId":13,"id":410,"name":"玉刚说","order":190002,"parentChapterId":407,"userControlSetTop":false,"visible":1},{"courseId":13,"id":411,"name":"承香墨影","order":190003,"parentChapterId":407,"userControlSetTop":false,"visible":1},{"courseId":13,"id":413,"name":"Android群英传","order":190004,"parentChapterId":407,"userControlSetTop":false,"visible":1},{"courseId":13,"id":414,"name":"code小生","order":190005,"parentChapterId":407,"userControlSetTop":false,"visible":1},{"courseId":13,"id":415,"name":"谷歌开发者","order":190006,"parentChapterId":407,"userControlSetTop":false,"visible":1},{"courseId":13,"id":416,"name":"奇卓社","order":190007,"parentChapterId":407,"userControlSetTop":false,"visible":1},{"courseId":13,"id":417,"name":"美团技术团队","order":190008,"parentChapterId":407,"userControlSetTop":false,"visible":1},{"courseId":13,"id":420,"name":"GcsSloop","order":190009,"parentChapterId":407,"userControlSetTop":false,"visible":1},{"courseId":13,"id":421,"name":"互联网侦察","order":190010,"parentChapterId":407,"userControlSetTop":false,"visible":1},{"courseId":13,"id":427,"name":"susion随心","order":190011,"parentChapterId":407,"userControlSetTop":false,"visible":1},{"courseId":13,"id":428,"name":"程序亦非猿","order":190012,"parentChapterId":407,"userControlSetTop":false,"visible":1},{"courseId":13,"id":434,"name":"Gityuan","order":190013,"parentChapterId":407,"userControlSetTop":false,"visible":1}]
/// errorCode : 0
/// errorMsg : ""

class Chapters {
  List<Data>? data;
  int? errorCode;
  String? errorMsg;

  Chapters({
      this.data, 
      this.errorCode, 
      this.errorMsg});

  Chapters.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
    errorCode = json['errorCode'];
    errorMsg = json['errorMsg'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    map['errorCode'] = errorCode;
    map['errorMsg'] = errorMsg;
    return map;
  }

}

/// courseId : 13
/// id : 408
/// name : "鸿洋"
/// order : 190000
/// parentChapterId : 407
/// userControlSetTop : false
/// visible : 1

class Data {
  int? courseId;
  int? id;
  String? name;
  int? order;
  int? parentChapterId;
  bool? userControlSetTop;
  int? visible;

  Data({
      this.courseId, 
      this.id, 
      this.name, 
      this.order, 
      this.parentChapterId, 
      this.userControlSetTop, 
      this.visible});

  Data.fromJson(dynamic json) {
    courseId = json['courseId'];
    id = json['id'];
    name = json['name'];
    order = json['order'];
    parentChapterId = json['parentChapterId'];
    userControlSetTop = json['userControlSetTop'];
    visible = json['visible'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['courseId'] = courseId;
    map['id'] = id;
    map['name'] = name;
    map['order'] = order;
    map['parentChapterId'] = parentChapterId;
    map['userControlSetTop'] = userControlSetTop;
    map['visible'] = visible;
    return map;
  }

}