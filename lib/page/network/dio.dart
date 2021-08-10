
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class DioHelper{

  static String baseUrl = 'https://www.wanandroid.com/'; //https://wanandroid.com/wxarticle/chapters/json
  static int connectTimeouts = 10000;
  static int receiveTimeouts = 10000;
  static Map<String, dynamic> headers = { "content-type":"application/json;charset=UTF-8","Accept":"application/json,text/plain,*/*"};

  static init(String url,int? connectTimeout,int? receiveTimeout, Map<String, dynamic>? header){
    baseUrl= url;
    connectTimeouts = connectTimeout!;
    receiveTimeouts = receiveTimeout!;
    headers = header!;
  }

  static get(String url,{
    required Function onSuccess,
    required Function onError,
    required Function onFinish,
    Map<String, dynamic>? data,
    Map<String, dynamic>? header,
    Map<String, dynamic>? addHeader,
    FormData? formData,
    bool reCer = false,
    String? severCert,
    String? clientCert,
    String? clientPrivate,
    String? certPassword,
    int? connectTimeout,
    int? receiveTimeout}){
    // 数据拼接
    if (data != null && data.isNotEmpty) {
      StringBuffer options = new StringBuffer('?');
      data.forEach((key, value) {
        options.write('$key=$value&');
      });
      String optionsStr = options.toString();
      optionsStr = optionsStr.substring(0, optionsStr.length - 1);
      url += optionsStr;
    }
    _sendRequest(url,MethodName.get,onSuccess,onError,
        data:data,
        header:header,
        addHeader:addHeader,
        formData:formData,
        reCer :reCer==true,
        severCert:severCert,
        clientCert:clientCert,
        clientPrivate:clientPrivate,
        certPassword:certPassword,
        connectTimeout:connectTimeout,
        receiveTimeout:receiveTimeout
    ).whenComplete(() {
      onFinish();
    });
  }

  static post(String url, {
    required Function onSuccess,
    required Function onError,
    required Function onFinish,
    Map<String, dynamic>? data,
    Map<String, dynamic>? header,
    Map<String, dynamic>? addHeader,
    FormData? formData,
    bool reCer = false,
    String? severCert,
    String? clientCert,
    String? clientPrivate,
    String? certPassword,
    int? connectTimeout,
    int? receiveTimeout}){

    _sendRequest(url,MethodName.post,onSuccess,onError,
        data:data,
        header:header,
        addHeader:addHeader,
        formData:formData,
        reCer :reCer==true,
        severCert:severCert,
        clientCert:clientCert,
        clientPrivate:clientPrivate,
        certPassword:certPassword,
        connectTimeout:connectTimeout,
        receiveTimeout:receiveTimeout
    ).whenComplete(() {
      onFinish();
    });

  }

  static put(){}

  static delete(){}

  static Future _sendRequest(String url,String method, Function success, Function error, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? header,
    Map<String, dynamic>? addHeader,
    FormData? formData,
    bool reCer = false,
    String? severCert,
    String? clientCert,
    String? clientPrivate,
    String? certPassword,
    int? connectTimeout,
    int? receiveTimeout,
  }) async {

    if (!url.startsWith('http')) {
      if(baseUrl == ''){
        _handError(error,ErrorMsg.UNDEFINED_BASE_URL,ErrorCode.CODE_UNDEFINED_BASE_URL);
        return;
      }
      url = baseUrl + url;
    }

    try {
      Map<String, dynamic> dataMap = data ?? new Map<String, dynamic>();
      Map<String, dynamic>? headersMap = header?? headers;
      if(addHeader != null){
        headersMap.addAll(addHeader);
      }

      // 配置dio请求信息
      Response response;
      Dio dio = new Dio();

      if(url.startsWith('https')){
        if(reCer){
          if(severCert == null || severCert == ''){
            _handError(error, 'errorMsg', 1000);
            return;
          }
          if(clientCert == null || clientCert == ''){
            _handError(error, 'errorMsg', 1000);
            return;
          }
          if(clientPrivate == null || clientPrivate == ''){
            _handError(error, 'errorMsg', 1000);
            return;
          }
          if(certPassword == null || certPassword == ''){
            _handError(error, 'errorMsg', 1000);
            return;
          }

          List<int> caData = (await rootBundle.load(severCert)).buffer.asUint8List();
          List<int> clientCertData = (await rootBundle.load(clientCert)).buffer.asUint8List();
          List<int> clientPrivateData = (await rootBundle.load(clientPrivate)).buffer.asUint8List();
          (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate  = (client) {
            SecurityContext sc = new SecurityContext(withTrustedRoots: true);
            sc.setTrustedCertificatesBytes(caData); //设置服务器端的公钥，为了验证服务器端
            sc.useCertificateChainBytes(clientCertData);//设置客户端证书到证书链
            sc.usePrivateKeyBytes(clientPrivateData, password:certPassword);//设置私钥 虽然源码里的注释说pem不用密码，但是这里必须
            HttpClient httpClient = new HttpClient(context: sc);
            httpClient.badCertificateCallback=(X509Certificate cert, String host, int port){
              return true;
            };
            return httpClient;
          };
        }else{
          (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (HttpClient client){
            client.badCertificateCallback = (X509Certificate cert ,String host ,int port){
              return true;
            };
          };
        }
      }

      dio.options.connectTimeout = connectTimeout??connectTimeouts; // 服务器链接超时，毫秒
      dio.options.receiveTimeout = receiveTimeout??receiveTimeouts; // 响应流上前后两次接受到数据的间隔，毫秒
      dio.options.headers.addAll(headersMap); // 添加headers,如需设置统一的headers信息也可在此添加

      ///访问地址打印
      debugPrint('请求地址：$url');
      switch(method){
        case MethodName.get:
          response = await dio.get(url);
          break;
        case MethodName.post:
          if (formData != null) {
            response = await dio.post(url, data: formData);
          } else {
            response = await dio.post(url, data: dataMap);
          }
          break;

        case MethodName.put:
          if (formData != null) {
            response = await dio.put(url, data: formData);
          } else {
            response = await dio.put(url, data: dataMap);
          }
          break;

        case MethodName.delete:
          if (formData != null) {
            response = await dio.delete(url, data: formData);
          } else {
            response = await dio.delete(url, data: dataMap);
          }
          break;

        default:
          _handError(error, '_msg',10000);
          return;
      }

      if(response.statusCode != null){
        if (response.statusCode! >= 300 || response.statusCode! < 200) {
          var _msg = '网络请求错误,状态码:' + response.statusCode.toString();
          _handError(error, _msg,response.statusCode!);
          return;
        }

        if(response.data==null){
          _handError(error, 'errorMsg', 100000);
        }else{
          debugPrint('返回内容：${response.data.toString()}');
          success(response.data);
        }
      }else{
        _handError(error, 'errorMsg', 100000);
      }

    }on DioError catch (err){
      if(err.response==null){
        _handError(error, "未知错误",123);
      }else if (err.type == DioErrorType.connectTimeout) {
        _handError(error, "网络连接超时",123);
      } else {
        _handError(error, "网络连接错误",123);
      }
    }
  }

  // 返回错误信息
  static  _handError(Function errorCallback, String errorMsg,int code) {
    errorCallback(errorMsg,code);
  }

}



class ErrorCode{
  /// -201  到  -299   配置异常
  static const int CODE_UNDEFINED_BASE_URL = -201; // 未定义基础地址
  static const int CODE_UNDEFINED_SEVER_CERT = -202;
  static const int CODE_UNDEFINED_CLIENT_CERT = -203;
  static const int CODE_UNDEFINED_CLIENT_PRIVATE = -204;
  static const int CODE_UNDEFINED_CERT_PASSWORD = -205;

}


class ErrorMsg{
  static const String UNDEFINED_BASE_URL = '未定义请求地址';
}

class MethodName{
  static const String get = 'get';
  static const String post = 'post';
  static const String put = 'put';
  static const String delete = 'delete';
}
