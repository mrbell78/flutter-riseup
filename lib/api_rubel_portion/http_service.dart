import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'api_response.dart';

class HttpService {
  Dio _dio;

  Dio _getDio() {
    if (_dio == null) {
      _dio = new Dio();

      _dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (RequestOptions options )async{



            SharedPreferences prefs = await SharedPreferences.getInstance();
            var header = prefs.get("apiToken");

            options.headers.addAll({"token": "$header"});

            return options;
            return options;


          },
          onResponse: (Response response, )async{
            return response;

          },
          onError: (DioError error)async{
            return error;
          }
        )
      );


 /*     _dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (RequestOptions options, RequestInterceptorHandler handler) async {
            *//*var token = spUtil.getValue(SPUtil.KEY_AUTH_TOKEN);*//*
            if (token != null) {
              print(("token : " + token));
              options.headers = {
                "Content-Type": "application/json",
                "Authorization": "Bearer  $token",
              };
            }
            return handler.next(options); //continue
          },
          onResponse: (Response response, ResponseInterceptorHandler handler) async {
            return handler.next(response); // continue
          },
          onError: (DioError e, ErrorInterceptorHandler handler) async {
            return handler.next(e); //continue
          },
        ),
      );*/
    }

    return _dio;
  }

  Future<ApiResponse<Response>> getRequest(String route, {Map<String, String> qp}) async {
    try {
      Response response = await _getDio().get(
        route,
        queryParameters: qp,
      );
      print("$route | $qp : $response");
      if (response.statusCode == 200) {
        return ApiResponse(httpCode: response.statusCode, data: response);
      } else {
        return ApiResponse(
            httpCode: response.statusCode, message: "Connection error. ${response.statusCode}");
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.RESPONSE) {
        print(e.response.data);
        print(e.response.statusCode);
        return ApiResponse(httpCode: e.response.statusCode, message: "${e.response.statusMessage}");
      } else {
        print(e.message);
        return ApiResponse(httpCode: -1, message: "Connection error. ${e.message}");
      }
    }
  }

  Future<ApiResponse<Response>> postRequest(String route, {Map<String, dynamic> data, String jsonData, bool isFormData = false, Function(int sent, int total) onProgress,}) async {
    try {
      Response response = await _getDio().post(
        route,
        data: isFormData ? FormData.fromMap(data) : (jsonData ?? jsonEncode(data)),
        onSendProgress: (int sent, int total) {
          print("onSendProgress $total $sent");
          if (onProgress != null) onProgress(sent, total);
        },
      );
      print("$route : $response");

      if (response.statusCode == 200) {
        return ApiResponse(httpCode: response.statusCode, data: response);
      } else {
        return ApiResponse(
            httpCode: response.statusCode, message: "Connection error. ${response.statusCode}");
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.RESPONSE) {
        print(e.response.data);
        print(e.response.statusCode);
        return ApiResponse(httpCode: e.response.statusCode, message: "${e.response.statusMessage}");
      } else {
        print(e.message);
        return ApiResponse(httpCode: -1, message: "Connection error. ${e.message}");
      }
    }
  }

  Future<ApiResponse<Response>> puttRequest(String route, {Map<String, dynamic> data}) async {
    try {
      Response response = await _getDio().put(
        route,
        data: jsonEncode(data),
      );
      print("$route : $response");

      if (response.statusCode == 200) {
        return ApiResponse(httpCode: response.statusCode, data: response);
      } else {
        return ApiResponse(
            httpCode: response.statusCode, message: "Connection error. ${response.statusCode}");
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.RESPONSE) {
        print(e.response.data);
        print(e.response.statusCode);
        return ApiResponse(httpCode: e.response.statusCode, message: "${e.response.statusMessage}");
      } else {
        print(e.message);
        return ApiResponse(httpCode: -1, message: "Connection error. ${e.message}");
      }
    }
  }

  Future<ApiResponse<Response>> deleteRequest(String route, {Map<String, dynamic> data}) async {
    try {
      Response response = await _getDio().delete(
        route,
        data: jsonEncode(data),
      );
      print("$route : $response");

      if (response.statusCode == 200) {
        return ApiResponse(httpCode: response.statusCode, data: response);
      } else {
        return ApiResponse(
            httpCode: response.statusCode, message: "Connection error. ${response.statusCode}");
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.RESPONSE) {
        print(e.response.data);
        print(e.response.statusCode);
        return ApiResponse(httpCode: e.response.statusCode, message: "${e.response.statusMessage}");
      } else {
        print(e.message);
        return ApiResponse(httpCode: -1, message: "Connection error. ${e.message}");
      }
    }
  }
}
