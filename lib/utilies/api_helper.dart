import 'dart:convert';
import 'dart:io';
import 'dart:developer' as developer;
import 'package:crio_meme_sharing_app/core/failures.dart';
import 'package:dio/dio.dart';

import 'package:hive/hive.dart';

import 'api_paths.dart';

class ApiHelper implements ApiService {
  /// Storage key for the token
  String _token = '';
  late Dio _dio;

  ApiHelper() {
    _dio = Dio();
    _dio.options.baseUrl = ApiPaths.baseUrl;
    _dio.options.connectTimeout = 10000; //5s
    _dio.options.receiveTimeout = 3000;
  }

  /// HTTP GET Request
  Future<dynamic> httpGet(String path) async {
    var responseJson;
    _token = await getToken();
    try {
      // final token = await getToken();

      //  print(token);

      developer.log('GET ${ApiPaths.baseUrl}$path', name: 'network request');
      final response = await _dio.get('$path',
          options: Options(headers: {
            "Authorization": "Bearer $_token",
          }));
      developer.log(response.data.toString(), name: 'network response');

      print(response.data);

      responseJson = _returnResponse(response);
      return responseJson;
    } on DioError catch (e) {
      if (e.error.runtimeType == SocketException)
        return Failures("No internet connection");
      responseJson = await _returnResponse(e.response);
    }
    return responseJson;
  }

  /// Http Delete request
  Future<dynamic> httpDelete(String path) async {
    var responseJson;
    _token = await getToken();
    try {
      // final token = await getToken();

      //  print(token);

      developer.log('DELETE ${ApiPaths.baseUrl}$path', name: 'network request');
      final response = await _dio.delete('$path',
          options: Options(headers: {
            "Authorization": "Bearer $_token",
          }));
      developer.log(response.statusCode.toString(), name: 'network response');

      print(response.statusCode);
      responseJson = _returnResponse(response);
    } on DioError catch (e) {
      if (e.error.runtimeType == SocketException)
        return Failures("No internet connection");
      responseJson = await _returnResponse(e.response);
    }
    return responseJson;
  }

  /// HTTP Post Request
  Future<dynamic> httpPost(
    String path, {
    Map<String, dynamic>? data,
    FormData? formData,
  }) async {
    var responseJson;
    _token = await getToken();
    //print(jsonEncode(data));
    try {
      // final token = await getToken();

      // print(token);

      developer.log('POST ${ApiPaths.baseUrl}$path', name: 'network request');

      final response = await _dio.post(
        '$path',
        options: Options(headers: {
          //"Content-Type": "application/json",
          if (_token != "") "Authorization": "Bearer $_token",
        }),
        data: data != null ? data : formData,
      );
      developer.log(response.data.toString(), name: 'network response');
      responseJson = response.data;
      //print(responseJson.toString());
    } on DioError catch (e) {
      if (e.error.runtimeType == SocketException)
        return Failures("No internet connection");
      responseJson = await _returnResponse(e.response);
    }
    return responseJson;
  }

  ///http PUT

  Future<dynamic> httpPut(String path, Map<String, dynamic> data) async {
    var responseJson;
    _token = await getToken();
    try {
      developer.log('PUT ${ApiPaths.baseUrl}$path', name: 'network request');
      final response = await _dio.patch(
        '$path',
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $_token",
        }),
        data: jsonEncode(data),
      );

      developer.log(response.data.toString(), name: 'network response');

      responseJson = await _returnResponse(response);
    } on DioError catch (e) {
      if (e.error.runtimeType == SocketException)
        return Failures("No internet connection");
      responseJson = await _returnResponse(e.response);
      return responseJson;
    }
    return responseJson;
  }

  // TODO: Check if user is logged in and valid
  Future<bool> handShake() async {
    final token = await getToken();
    if (token != "") return true;
    return false;
  }

  dynamic _returnResponse(Response<dynamic>? response) async {
    switch (response!.statusCode) {
      case 200:
        var responseJson = response.data;
        return responseJson;

      case 201:
        var responseJson = response.data;
        return responseJson;

      case 400:
        return Failures(response.data['message']);

      case 401:
        return Failures("UnAuthenticated");

      case 404:
        return Failures(response.data['message']);
      case 409:
        return Failures(response.data['message']);

      case 500:
        return Failures('Server Error');

      default:
        return Failures(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }

  final storage = Hive.box('user');

  /// Method that returns the token from Shared Preferences
  Future<String> getToken() async {
    return await storage.get('token') ?? '';
  }

  /// Method that saves the token in Shared Preferences
  Future<void> setToken(String token) async {
    await storage.put('token', token);
  }

  Future<void> removeToken() async {
    await storage.delete('token');
  }
}

abstract class ApiService {
  Future<dynamic> httpGet(String path);
  Future<dynamic> httpPost(String path,
      {Map<String, dynamic> data, FormData formData});
  Future<String>? getToken();
  Future<void> setToken(String token);
  Future<void> removeToken();
  Future<bool> handShake();
}
