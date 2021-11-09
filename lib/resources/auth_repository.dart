import 'package:crio_meme_sharing_app/core/failures.dart';
import 'package:dartz/dartz.dart';

import 'auth_api_provider.dart';

class AuthRepository {
  Source _source = AuthApiProvider();

  Future<Either<Failures, Unit>> login(String email, String password) async {
    return await _source.login(email, password);
  }

  Future<void> logout() async {
    await _source.logout();
  }

  Future<Either<Failures, Unit>> signUp(
      String name, String email, String password) async {
    return await _source.signUp(name, email, password);
  }
  /* Future<void> googleLogin(String idToken) async {
    await _source.googleLogin(idToken);
  }

 

  Future<void> googleSignUp(String idToken) async {
    await _source.googleSignUp(idToken);
  }

  /// Send verification code to email to reset password
  Future<void> sendCode(String email) async {
    await _source.sendCode(email);
  }

  /// Verify verification code sent to email to reset password
  Future<void> verifyCode(String email, String code) async {
    await _source.verifyCode(email, code);
  }

  /// Reset password if the user has forgotten it
  Future<void> resetPassword(String password) async {
    await _source.resetPassword(password);
  }

  /// Change password from user's profile
  Future<void> changePassword(String oldPassword, String newPassword) {}*/
}

abstract class Source {
  Future<Either<Failures, Unit>> login(String email, String password);
  // Future<void> googleLogin(String idToken);

  Future<Either<Failures, Unit>> signUp(
      String name, String email, String password);
  Future<void> logout();
  //Future<void> googleSignUp(String idToken);

  //Future<void> sendCode(String email);
  //Future<void> verifyCode(String email, String code);

  //Future<void> resetPassword(String password);
  //Future<void> changePassword(String currentPassword, String newPassword);
}
