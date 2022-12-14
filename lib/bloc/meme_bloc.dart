import 'package:crio_meme_sharing_app/core/failures.dart';
import 'package:crio_meme_sharing_app/repository/models/meme.dart';
import 'package:crio_meme_sharing_app/resources/meme_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:rxdart/rxdart.dart';

class MemeBloc {
  //observable
  final _memestream = BehaviorSubject<List<Memes>>();

  //getter
  Stream<List<Memes>> get memes => _memestream.stream;

  MemeRepository _repository = MemeRepository();

  void getMemes() async {
    final event = await _repository.getMeme();
    _memestream.sink.add(event);
  }

  Future<Either<Failures, Unit>> postMeme(Memes meme) async {
    final event = await _repository.postMeme(meme);
    return event.fold((l) => left(l), (r) {
      getMemes();
      return right(unit);
    });
  }

  Future<Either<Failures, Unit>> editMeme(Memes meme) async {
    final event = await _repository.editMeme(meme);
    print(event);
    return event.fold((l) => left(l), (r) {
      getMemes();
      return right(unit);
    });
  }

  Future<Either<Failures, Unit>> deleteMeme(int id) async {
    final event = await _repository.deleteMeme(id);
    return event.fold((l) => left(l), (r) {
      getMemes();
      return right(unit);
    });
  }

  void dispose() {
    // _memestream.close();
  }
}
