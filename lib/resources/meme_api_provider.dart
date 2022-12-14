import 'package:crio_meme_sharing_app/core/failures.dart';
import 'package:crio_meme_sharing_app/repository/models/meme.dart';
import 'package:crio_meme_sharing_app/utilies/api_helper.dart';
import 'package:crio_meme_sharing_app/utilies/api_paths.dart';
import 'package:dartz/dartz.dart';

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

  Future<Either<Failures, Unit>> postMeme(Memes meme) async {
    Map<String, dynamic> data = meme.toMap();

    final response = await _apiHelper.httpPost(ApiPaths.postMeme, data: data);
    if (response is Failures) return left(response);

    return right(unit);
  }

  Future<Either<Failures, Unit>> editMeme(Memes meme) async {
    Map<String, dynamic> data = meme.toMap();

    final response =
        await _apiHelper.httpPut('${ApiPaths.editMeme}/${meme.id}', data);

    if (response is Failures) return left(response);

    return right(unit);
  }

  Future<Either<Failures, Unit>> deleteMeme(int id) async {
    final response = await _apiHelper.httpDelete('${ApiPaths.deleteMeme}/$id');
    if (response is Failures) return left(response);

    return right(unit);
  }
}
