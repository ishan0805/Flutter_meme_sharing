import 'package:crio_meme_sharing_app/models/meme.dart';
import 'package:crio_meme_sharing_app/utilies/api_helper.dart';
import 'package:crio_meme_sharing_app/utilies/api_paths.dart';
import 'package:http/http.dart' as http;

class MemeApiProvider {
  ApiHelper _apiHelper = ApiHelper();
  bool test = false;
  Future<List<Memes>> getMeme() async {
    List<Memes> memes = [];
    if (!test) {
      final response = await _apiHelper.httpGet(ApiPaths.getMemes);
      if (response != null) {
        for (var each in response) {
          memes.add(Memes.fromMap(each));
          print(each);
        }
      }
    } else {}
    return memes;
  }

  Future<bool> postMeme(Memes meme) async {
    Map<String, dynamic> data = meme.toMap();

    await _apiHelper
        .httpPost(ApiPaths.postMeme, data: data)
        .catchError((onError) {
      return false;
    });

    return true;
  }

  Future<bool> editMeme(Memes meme) async {
    Map<String, dynamic> data = meme.toMap();
    await _apiHelper
        .httpPut('${ApiPaths.editMeme}/${meme.id}', data)
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
