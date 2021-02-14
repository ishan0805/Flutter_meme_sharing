import 'package:crio_meme_sharing_app/models/meme.dart';
import 'package:crio_meme_sharing_app/resources/meme_api_provider.dart';

class MemeRepository {
  MemeApiProvider _apiProvider = MemeApiProvider();
  Future<List<Memes>> getMeme() {
    return _apiProvider.getMeme();
  }

  Future<bool> postMeme(Memes meme) {
    return _apiProvider.postMeme(meme);
  }

  Future<bool> editMeme(Memes meme) {
    return _apiProvider.editMeme(meme);
  }
}
