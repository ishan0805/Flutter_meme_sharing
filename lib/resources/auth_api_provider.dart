import 'package:crio_meme_sharing_app/utilies/api_helper.dart';
import 'package:crio_meme_sharing_app/utilies/api_paths.dart';

import 'auth_repository.dart';

class AuthApiProvider implements Source {
  ApiHelper _apiHelper = ApiHelper();
  bool production = true;

  /// Sign Up
  Future<void> signUp(String email, String password) async {
    final jsonMap = {
      'email': email,
      'password': password,
    };
    if (production) {
      final jsonResponse = await _apiHelper.httpPost(
        ApiPaths.signUp,
        jsonMap,
      );

      await _apiHelper.setToken(jsonResponse['token']);
    }
  }

  /// Google sign up
  /*Future<void> googleSignUp(String idToken) async {
    // NOTE: Authentication with backend takes a lot of time

    final jsonMap = {
      'idToken': idToken,
    };

    final jsonResponse = await _apiHelper.httpPost(
      ApiPaths.googleSignUp,
      jsonMap,
    );

    await _apiHelper.setToken(jsonResponse['token']);
  }*/

  /// Login with email and password
  Future<void> login(String email, String password) async {
    final jsonMap = {
      "email": email,
      "password": password,
    };

    final jsonResponse = await _apiHelper.httpPost(
      ApiPaths.login,
      jsonMap,
    );

    await _apiHelper.setToken(jsonResponse['token']);
  }

  /// Login with google
  /*Future<void> googleLogin(String idToken) async {
    // NOTE: Authentication with backend takes a lot of time

    final jsonMap = {
      'idToken': idToken,
    };

    final jsonResponse = await _apiHelper.httpPost(
      ApiPaths.googleLogin,
      jsonMap,
    );

    await _apiHelper.setToken(jsonResponse['token']);
  }

  /// Send verification code to email to reset password
  Future<void> sendCode(String email) async {
    // final jsonMap = {
    //   'email': email,
    // };

    await _apiHelper.httpPost('${ApiPaths.sendCode}?email=$email', {});
  }

  /// Verify verification code sent to email to reset password
  Future<void> verifyCode(String email, String code) async {
    final jsonMap = {
      'email': email,
      'otp': code,
    };

    final jsonResponse =
        await _apiHelper.httpPost(ApiPaths.verifyCode, jsonMap);

    await _apiHelper.setToken(jsonResponse['token']);
  }

  /// Reset password if the user has forgotten it
  Future<void> resetPassword(String password) async {
    final jsonMap = {
      'password': password,
    };

    final jsonResponse =
        await _apiHelper.httpPost(ApiPaths.resetPassword, jsonMap);
  }

  /// Change password from user's profile
  Future<void> changePassword(String oldPassword, String newPassword) {}*/
}
