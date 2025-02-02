import 'package:crio_meme_sharing_app/core/failures.dart';
import 'package:crio_meme_sharing_app/repository/models/meme.dart';
import 'package:crio_meme_sharing_app/resources/meme_api_provider.dart';
import 'package:dartz/dartz.dart';

class MemeRepository {
  MemeApiProvider _apiProvider = MemeApiProvider();
  Future<List<Memes>> getMeme() {
    return _apiProvider.getMeme();
  }

  Future<Either<Failures, Unit>> postMeme(Memes meme) {
    return _apiProvider.postMeme(meme);
  }

  Future<Either<Failures, Unit>> editMeme(Memes meme) {
    return _apiProvider.editMeme(meme);
  }

  Future<Either<Failures, Unit>> deleteMeme(int id) {
    return _apiProvider.deleteMeme(id);
  }
}
