import 'dart:convert';
import 'dart:io';
import 'dart:developer' as developer;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'api_paths.dart';
import 'app_exception.dart';
import 'package:http/http.dart' as http;

class ApiHelper implements ApiService {
  /// Storage key for the token
  final String _token = "token";

  /// HTTP GET Request
  Future<dynamic> httpGet(String path) async {
    var responseJson;

    try {
      // final token = await getToken();

      //  print(token);

      developer.log('GET ${ApiPaths.baseUrl}$path', name: 'network request');
      final response = await http.get('${ApiPaths.baseUrl}$path', headers: {
        // "X-Custom-Token": token,
      });
      developer.log(response.body, name: 'network response');

      print(response.body);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  /// Http Delete request
  Future<dynamic> httpDelete(String path) async {
    var responseJson;

    try {
      // final token = await getToken();

      //  print(token);

      developer.log('DELETE ${ApiPaths.baseUrl}$path', name: 'network request');
      final response = await http.delete('${ApiPaths.baseUrl}$path', headers: {
        // "X-Custom-Token": token,
      });
      developer.log(response.statusCode.toString(), name: 'network response');

      print(response.statusCode);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw Exception('No Internet connection');
    }
    return responseJson;
  }

  /// HTTP Post Request
  Future<dynamic> httpPost(String path, Map<String, dynamic> body) async {
    var responseJson;
    print(jsonEncode(body));
    try {
      // final token = await getToken();

      // print(token);

      developer.log('POST ${ApiPaths.baseUrl}$path', name: 'network request');
      final response = await http.post(
        '${ApiPaths.baseUrl}$path',
        headers: {
          "Content-Type": "application/json",
          //  "X-Custom-Token": token,
        },
        body: jsonEncode(body),
      );
      developer.log(response.body, name: 'network response');

      responseJson = await _returnResponse(response);
      //print(responseJson.toString());
    } on SocketException {
      print('some error occured');
      throw Exception('No Internet connection');
    }
    print(responseJson.toString());
    return responseJson;
  }

  ///http PUT

  Future<dynamic> httpPut(String path, Map<String, dynamic> body) async {
    var responseJson;

    try {
      //  final token = await getToken();

      //  print(token);

      developer.log('PUT ${ApiPaths.baseUrl}$path', name: 'network request');
      final response = await http.patch(
        '${ApiPaths.baseUrl}$path',
        headers: {
          "Content-Type": "application/json",
          // "X-Custom-Token": token,
        },
        body: jsonEncode(body),
      );
      developer.log(response.body, name: 'network response');

      responseJson = await _returnResponse(response);
    } on SocketException {
      throw Exception('No Internet connection');
    }
    return responseJson;
  }

  // TODO: Check if user is logged in and valid
  Future<bool> handShake() async {
    final token = await getToken();
    if (token != null) return true;
    return false;
  }

  dynamic _returnResponse(http.Response response) async {
    switch (response.statusCode) {
      case 200:
        var responseJson = jsonDecode(response.body);
        return responseJson;

      case 201:
        var responseJson = jsonDecode(response.body);
        return responseJson;

      case 400:
        throw BadRequestException(jsonDecode(response.body)['message']);

      case 401:
        throw UnauthorisedException(jsonDecode(response.body)['message']);

      case 404:
        throw InvalidInputException(jsonDecode(response.body)['message']);

      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
        break;
    }
  }

  final storage = FlutterSecureStorage();

  /// Method that returns the token from Shared Preferences
  Future<String> getToken() async {
    return await storage.read(key: _token) ?? null;
  }

  /// Method that saves the token in Shared Preferences
  Future<void> setToken(String token) async {
    await storage.write(key: _token, value: token);
  }

  Future<void> removeToken() async {
    await storage.delete(key: _token);
  }
}

abstract class ApiService {
  Future<dynamic> httpGet(String path);
  Future<dynamic> httpPost(String path, Map<String, dynamic> body);
  Future<String> getToken();
  Future<void> setToken(String token);
  Future<void> removeToken();
  Future<bool> handShake();
}
