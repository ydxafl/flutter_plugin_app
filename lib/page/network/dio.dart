
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
      if(!baseUrl.startsWith('http')){
        _handError(error,'undefined base url',ErrorCode.CODE_UNDEFINED_BASE_URL);
        return;
      }
      url = baseUrl + url;
    }

    try {
      Map<String, dynamic> dataMap = data ?? Map<String, dynamic>();
      Map<String, dynamic>? headersMap = header?? headers;
      if(addHeader != null){
        headersMap.addAll(addHeader);
      }

      // 配置dio请求信息
      Response response;
      Dio dio = Dio();

      if(url.startsWith('https')){
        if(reCer){
          if(severCert == null || severCert == ''){
            _handError(error, 'severCert undefined', ErrorCode.CODE_UNDEFINED_SEVER_CERT);
            return;
          }
          if(clientCert == null || clientCert == ''){
            _handError(error, 'clientCert undefined', ErrorCode.CODE_UNDEFINED_CLIENT_CERT);
            return;
          }
          if(clientPrivate == null || clientPrivate == ''){
            _handError(error, 'clientPrivate undefined', ErrorCode.CODE_UNDEFINED_CLIENT_PRIVATE);
            return;
          }
          if(certPassword == null || certPassword == ''){
            _handError(error, 'certPassword undefined', ErrorCode.CODE_UNDEFINED_CERT_PASSWORD);
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
          _handError(error, 'http method not found',ErrorCode.CODE_HTTP_METHOD_NOT_FOUND);
          return;
      }

      if(response.statusCode != null){
        /// 200（含） - 300(不含)  表示正常响应
        if (response.statusCode! >= 300 || response.statusCode! < 200) {
          _httpError(error, response.statusCode!);
          return;
        }

        if(response.data==null){
          _handError(error, 'response data is null', ErrorCode.CODE_RESPONSE_DATA_IS_NULL);
        }else{
          debugPrint('返回内容：${response.data.toString()}');

          success(response.data);
        }
      }else{
        _handError(error, 'response statusCode is null', ErrorCode.CODE_RESPONSE_STATUS_CODE_IS_NULL);
      }
    }on DioError catch (err){
      if(err.response==null){
        _handError(error, "未知错误",ErrorCode.CODE_UNKNOWN_ERROR);
      }else if (err.type == DioErrorType.connectTimeout) {
        _handError(error, "网络连接超时",ErrorCode.CODE_CONNECT_TIMEOUT);
      } else {
        _handError(error, "其他错误",ErrorCode.CODE_OTHER_ERROR);
      }
    }
  }

  // 返回错误信息
  static  _handError(Function errorCallback, String errorMsg,int code) {
    errorCallback(errorMsg,code);
  }

  // http 错误在这里补充
  static _httpError(Function errorCallback, int code) {
    switch(code){
      case 401:
        errorCallback("未授权",code);
        break;

      case 404:
        errorCallback("404 NOT FOUND",code);
        break;

      case 500:
        errorCallback("系统异常",code);
        break;

      default:
        errorCallback("其他HTTP错误，错误码：$code",code);
        break;
    }
  }

}


/// 一些错误码
class ErrorCode{
  /// -201  到  -299
  static const int CODE_UNDEFINED_BASE_URL = -201;
  static const int CODE_UNDEFINED_SEVER_CERT = -202;
  static const int CODE_UNDEFINED_CLIENT_CERT = -203;
  static const int CODE_UNDEFINED_CLIENT_PRIVATE = -204;
  static const int CODE_UNDEFINED_CERT_PASSWORD = -205;
  static const int CODE_HTTP_METHOD_NOT_FOUND = -206;
  static const int CODE_RESPONSE_DATA_IS_NULL = -207;
  static const int CODE_RESPONSE_STATUS_CODE_IS_NULL = -208;
  static const int CODE_UNKNOWN_ERROR = -209;
  static const int CODE_CONNECT_TIMEOUT = -210;
  static const int CODE_OTHER_ERROR = -211;
}


/// 请求方法名称
class MethodName{
  static const String get = 'get';
  static const String post = 'post';
  static const String put = 'put';
  static const String delete = 'delete';
}
