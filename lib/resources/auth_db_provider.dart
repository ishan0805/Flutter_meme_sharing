import 'package:crio_meme_sharing_app/utilies/api_helper.dart';

import 'auth_repository.dart';

class AuthDbProvider implements Cache {
  ApiHelper _apiHelper = ApiHelper();

  @override
  Future<void> logout() async {
    // await _apiHelper.removeToken();
  }
}
