import 'auth_api_provider.dart';
import 'auth_db_provider.dart';

class AuthRepository {
  Source _source = AuthApiProvider();
  Cache _cache = AuthDbProvider();

  Future<void> login(String email, String password) async {
    await _source.login(email, password);
  }

  Future<void> logout() async {
    await _cache.logout();
  }

  Future<void> signUp(String email, String password) async {
    await _source.signUp(email, password);
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
  Future<void> login(String email, String password);
  // Future<void> googleLogin(String idToken);

  Future<void> signUp(String email, String password);
  //Future<void> googleSignUp(String idToken);

  //Future<void> sendCode(String email);
  //Future<void> verifyCode(String email, String code);

  //Future<void> resetPassword(String password);
  //Future<void> changePassword(String currentPassword, String newPassword);
}

abstract class Cache {
  Future<void> logout();
}
