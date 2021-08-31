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
    } else {
      memes.add(
        Memes(
            name: "Ishan",
            id: 2,
            url:
                'https://static0.srcdn.com/wordpress/wp-content/uploads/2020/11/I-Had-Fun-Once-It-Was-Awful-amp-9-Other-Classic-Memes.jpg'),
      );
      memes.add(Memes(
          name: "Ishan",
          id: 2,
          url:
              'https://static0.srcdn.com/wordpress/wp-content/uploads/2020/11/I-Had-Fun-Once-It-Was-Awful-amp-9-Other-Classic-Memes.jpg'));
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
