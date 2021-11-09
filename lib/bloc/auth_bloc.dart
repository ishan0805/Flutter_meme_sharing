import 'package:crio_meme_sharing_app/core/failures.dart';
import 'package:crio_meme_sharing_app/resources/auth_repository.dart';
import 'package:dartz/dartz.dart';

class AuthBloc {
  AuthRepository _authRepository = AuthRepository();

  Future<Either<Failures, Unit>> login(String email, String password) async {
    return await _authRepository.login(email, password);
  }

  Future<Either<Failures, Unit>> signUp(
      String name, String email, String password) async {
    return await _authRepository.signUp(name, email, password);
  }

  /*Future<void> googleLogin(String idToken) async {
    await _authRepository.googleLogin(idToken);
  }

 

  Future<void> googleSignUp(String idToken) async {
    await _authRepository.googleSignUp(idToken);
  }

  /// Send verification code to email to reset password
  Future<void> sendCode(String email) async {
    await _authRepository.sendCode(email);
  }

  /// Verify verification code sent to email to reset password
  Future<void> verifyCode(String email, String code) async {
    await _authRepository.verifyCode(email, code);
  }

  /// Reset password if the user has forgotten it
  Future<void> resetPassword(String password) async {
    await _authRepository.resetPassword(password);
  }*/

  Future<void> logout() async {
    await _authRepository.logout();
  }
}
