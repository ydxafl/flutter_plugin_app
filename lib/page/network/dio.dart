
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';

class DioHelper{

  static Map<String, dynamic>? headers;
  static String? severCer;
  static String? privateCer;
  static String? clientCer;
  static String? cerPassWord;
  static String? baseUrl;

  static int? connectTimeouts;
  static int? receiveTimeouts;

  static init(String url,{
    Map<String, dynamic>? header,
    String? severCerUrl,
    String? privateCerUrl,
    String? clientCerUrl,
    String? cerPwd,
    int connectTimeout = 10000,
    int receiveTimeout = 10000,
  }){
    connectTimeouts = connectTimeout;
    receiveTimeouts = receiveTimeout;
    headers = header;
    severCer = severCerUrl;
    privateCer = privateCerUrl;
    clientCer = clientCerUrl;
    cerPassWord = cerPwd;
    baseUrl = url;
  }


  static void get(String url,
      {Map<String, dynamic>? data,
        Map<String, dynamic>? header,
        Map<String, dynamic>? addHeader,
        String? path,
        Function? success,
        Function? error,
        Function? finish}) async {
    // 数据拼接
    if (!url.startsWith('http')) {
      url = url + baseUrl!;
    }
    if (data != null && data.isNotEmpty) {
      StringBuffer options = new StringBuffer('?');
      data.forEach((key, value) {options.write('$key=$value&');});
      String optionsStr = options.toString();
      optionsStr = optionsStr.substring(0, optionsStr.length - 1);
      url += optionsStr;
    }else{
      if(path != null){
        url += path;
      }
    }

    // 发送get请求
    await _sendRequest(url, 'get', success!, error!, newHeader: header,addHeader: addHeader)
        .whenComplete(() {
      if (finish != null) {
        finish();
      }
    });
  }


  // 请求处理
  static Future _sendRequest(
      String url,
      String method,
      Function success,
      Function error, {
        Map<String, dynamic>? data,
        Map<String, dynamic>? newHeader,
        Map<String, dynamic>? addHeader,
        FormData? formData,
        String? newSeverCerUrl,
        String? newPrivateCerUrl,
        String? newClientCerUrl,
        String? newCerPassWord,
        int? newConnectTimeouts,
        int? newReceiveTimeouts,
      }) async {

    Map<String, dynamic> thisHeader = headers??{ "content-type":"application/json;charset=UTF-8","Accept":"application/json,text/plain,*/*"};

    // 检测请求地址是否是完整地址
    if (!url.startsWith('http')) {
      _handError(error, '请求地址异常：' + url,-10086);
    }
    try {

      Map<String, dynamic> dataMap = data ?? new Map<String, dynamic>() ;
      Map<String, dynamic> headersMap = newHeader ?? thisHeader;

      if(addHeader != null){
        headersMap.addAll(addHeader);
      }
      // 配置dio请求信息
      Response response;
      Dio dio = new Dio();

      if(severCer != null && privateCer != null && clientCer != null && cerPassWord != null){
        String? thisClientCer = clientCer;
        String? thisPrivateCer = privateCer;
        String? thisSeverCer = severCer;
        String? cerPwd = cerPassWord;

        if(newClientCerUrl != null && newPrivateCerUrl != null && newSeverCerUrl != null  && newCerPassWord != null ){
          thisClientCer = newClientCerUrl;
          thisPrivateCer = newPrivateCerUrl;
          thisSeverCer = newSeverCerUrl;
          cerPwd = newCerPassWord;
        }
        // cerPassWord like 123456
        // clientCer file's path like pubkey/sever_cert.pem
        List<int> caData = (await rootBundle.load(thisSeverCer!)).buffer.asUint8List();
        List<int> clientCertData = (await rootBundle.load(thisClientCer!)).buffer.asUint8List();
        List<int> clientPrivateData = (await rootBundle.load(thisPrivateCer!)).buffer.asUint8List();
        (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate  = (client) {
          SecurityContext sc = new SecurityContext(withTrustedRoots: true);
          sc.setTrustedCertificatesBytes(caData); //设置服务器端的公钥，为了验证服务器端
          sc.useCertificateChainBytes(clientCertData);//设置客户端证书到证书链
          sc.usePrivateKeyBytes(clientPrivateData, password:cerPwd);//设置私钥 虽然源码里的注释说pem不用密码，但是这里必须
          HttpClient httpClient = new HttpClient(context: sc);
          httpClient.badCertificateCallback=(X509Certificate cert, String host, int port){
            return true;
          };
          return httpClient;
        };
      }else{
        /// 忽略掉证书
        (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (HttpClient client){
          client.badCertificateCallback = (X509Certificate cert ,String host ,int port){
            return true;
          };
        };
      }

      dio.options.connectTimeout = (newConnectTimeouts??connectTimeouts)!; // 服务器链接超时，毫秒
      dio.options.receiveTimeout = (newReceiveTimeouts??receiveTimeouts)!; // 响应流上前后两次接受到数据的间隔，毫秒
      dio.options.headers.addAll(headersMap); // 添加headers,如需设置统一的headers信息也可在此添加

      switch(method){
        case 'get':
          response = await dio.get(url);
          break;
        case "post":
          if (formData != null) {
            response = await dio.post(url, data: formData);
          } else {
            response = await dio.post(url, data: dataMap);
          }
          break;

        case 'put':
          if (formData != null) {
            response = await dio.put(url, data: formData);
          } else {
            response = await dio.put(url, data: dataMap);
          }
          break;

        case 'delete':
          if (formData != null) {
            response = await dio.delete(url, data: formData);
          } else {
            response = await dio.delete(url, data: dataMap);
          }
          break;

        default:
          _handError(error,"不支持的请求方法",-10086);
          return;
      }

      if (response.statusCode! >= 200  && response.statusCode! < 300) {
        // 响应码在200-300 默认为成功，其他为失败
        success(response);
        return;
      }else{
        _httpError(error,response.statusCode!);
        return;
      }

    } on DioError catch (err) {
      if(err.response==null){
        _handError(error, "未知错误",-1000);
      }else if (err.type == DioErrorType.connectTimeout) {
        _handError(error, "网络连接超时",-1000);
      } else if (err.response!.statusCode == 401) {
        _handError(error, "未授权",-1401);
      } else {
        _handError(error, "网络连接错误",-1999);
      }
    }
  }


  // 返回错误信息
  static Future? _handError(Function errorCallback, String errorMsg,int code) {
    errorCallback(errorMsg);
    return null;
  }

  // 处理http错误
  static void _httpError(Function error, int statusCode) {
    switch(statusCode){
      case 100:
        _handError(error,"Continue",100);
        break;

      default:
        _handError(error,"其他HTTP错误",-10085);
        break;
    }
  }

}
