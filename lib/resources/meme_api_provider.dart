import 'package:crio_meme_sharing_app/models/meme.dart';
import 'package:crio_meme_sharing_app/utilies/api_helper.dart';
import 'package:crio_meme_sharing_app/utilies/api_paths.dart';
import 'package:http/http.dart' as http;

class MemeApiProvider {
  ApiHelper _apiHelper = ApiHelper();

  Future<List<Memes>> getMeme() async {
    final response = await _apiHelper.httpGet(ApiPaths.getMemes);
    List<Memes> memes = [];
    if (response != null) {
      for (var each in response) {
        memes.add(Memes.fromMap(each));
        print(each);
      }
    }
    return memes;
  }

  Future<bool> postMeme(Memes meme) async {
    Map<String, dynamic> m = meme.toMap();

    await _apiHelper.httpPost(ApiPaths.postMeme, m).catchError((onError) {
      return false;
    });

    return true;
  }

  Future<bool> editMeme(Memes meme) async {
    Map<String, String> m = {'url': meme.url, 'caption': meme.description};
    await _apiHelper
        .httpPut('${ApiPaths.editMeme}/${meme.id}', m)
        .catchError((onError) {
      return false;
    });
    return true;
  }

  Future<bool> deleteMeme(int id) async {
    await _apiHelper
        .httpDelete('${ApiPaths.deleteMeme}/$id')
        .catchError((onError) {
      return false;
    });
    return true;
  }
}
